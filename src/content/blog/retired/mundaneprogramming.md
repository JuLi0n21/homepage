---
title: "mundane programming"
description: "build software, that is easy to read, write and maintain"
pubDate: "Apr 01 2026"
---

<style is:global>
 h1,
 h2,
 h3,
 h4,
 ul li,
 figcaption:before { color: #00d5ec }
 body, .wrapper, nav::after  {background: #202023 }
 a, p, ul { color: #ffc107 }
 img {
     border: 5px solid;
     border-color: #101010;
 }
</style>

# Mundane Programming

In the Age of ever Approaching Agi, one needs to be prepared, because until then you are still better off having an understanding of your application and system. This is an opinionated guide on how to build mundane crud applications, fast, which are easy to understand and debug.

## Wants and Lacks

what would a simpleton want from a programming language to aid in building a mundane crud application?

- easy to use toolchain: a handful of commands to let the toolchain, compile (fast), check and test the application, bonus points if dependency management is included but be careful with them more on that later.
- a list of simple features, if/else, switches, structs, functions, enums and loops, arrays and maps. Lastly a decently sized standard library providing a ready to use webserver implementation. I.E. simple request routing, and basic request handling.
- an idiomatic way to be written, forcing the same (code|formatting) style onto everyone.
- type safety, exhaustive switches, errors as values, and multiple return values
- garbage collected, memory management is a waste of time

for the crud aspect a simpleton would need a simple database to store the data
- sql compatible
- widely used
- type safety

as to stuff a simpleton wouldn't want:
- multiple ways of doing things
- magical syntactical sugar
- complicated features

## Dependencies

More than ever before have dependencies been filled with exploits and vulnerabilities, so the simpletons way is to just not use them, if every dependency is a liability wouldnt it make sense to just reduce it to the bare minimum? Even then, quite often a very small subset of features is actually required. So make sure to think twice before using any dependencys

In the same ways versions should be locked by default, and or directly vendored into your own source code to prevent any infections from outside to get in.

## Programm layout

Books are read from Left to right, top to bottom. so why shouldn't software be written the same way?
Abstraction should only be used to reduce complexity not to introduce it.
Interfaces are only of worth if multiple implementations exist and its less effort to use then just a simple enum switch
Layers should be kept to a minimum
encapsulation as a goal is very bad, the design should be as transparent as possible to easily see how and when components interact with each other
code sharing should be done with caution.

## Programming Patterns

### functions
functions that change state should be obviously named and only should act on the state management like, databases, object stores or caches.
early exit should be the default, be it validation failure, missing data or incomplete requirements

### enums and switches
need to make a decision based on a specific state of an object? enums are your best friend
enums allows a simpleton to deal easily with everchanging business requirements and all the other unique annoying ways software tends to change over time.

### imperative
top-down, left to right why make it complicated just do it like one would write a book

## Implementation ways

How does a mundane system look like? let's build a small one together:

although go doens't fit into all of our requirements missing many things in the safety aspect it still comes the closest. if only gleam had loops ...

the entire program should follow this pattern to handle a request:

state management, routing delegation, authorization and authentication, input validation, data handling, view / presentation generation, return
now this doesn't seem very simpleton friendly, but seeing it in an example a simpleton might be able to understand.

### State management

While dependency injection is still all the rage in the enterprise environment. a simpleton knows a struct containing the state is all you need. it will contain anything one might need.

```go
type Server struct {
    db      Database
    storage Storage
}
```

### Route delegation

```go 
func NewHandler(s *Server) http.Handler {
    router := http.NewServeMux()

    //list all endpoints groupd by functions and pahts
    router.HandleFunc("/", s.Index)
    router.HandleFunc("/login", s.Login)
    router.HandleFunc("/logout", s.Logout)
    router.HandleFunc("GET /user/{userid}", s.User)

    return router
}
```
### Authorization and Authentication

to follow the simple written like a book approach we want the authentication and authorization to be handled even before the route specific handler is reached (return early), to achieve this in golang one follows the middleware approach, which boils down to a function which the request goes through before reaching the actual handler.

here the required features are added one by one.

```go 

var Users sync.Map
const AuthCookie string = "my_session_cookie"

func (s *Server) AuthUser(next func(w http.ResponseWriter, r *http.Request)) http.HandlerFunc {
    return func(w http.ResponseWriter, r *http.Request) {

        cookie, err := r.Cookie(AuthCookie);
        if err != nil {
            http.Error(w, "Cookie not found", http.StatusUnauthorized)
            return
        }

        _, ok := Users.Load(cookie)
        if !ok {
            if !s.db.isUserLoggedIn(r.Context(), cookie) {
                http.Redirect(w, r, "/login", http.StatusFound)
                return 
            }
        }

	return next(w, r)
	})
}
```
### Putting it together

now that we have our state managed and the difficult parts secured we can go back to the actual meat of the crud application.
to fulfill our request of it being written like a book, the simpleton just writes one function that describes the entire flow until the return.
```go 
func (s *Server) GuideLine(w http.ResponseWriter, r *http.Request) {
    type Request struct {
        //a Request object that contains the required / optional variables needed for this specific request
        Value string
        Math int
    }
    var req Request

    // parsing the raw request and validate the input
    req.Value = r.PathValue("value")
    
    if req.Value == "" {
        http.Error(w, "bad value provided", http.StatusBadRequest)
        return
    }

    // followed by the buisness logic

    // fetch some data
    data, err := s.db.GetTheValues(r.Context(), req.Value)
    if err !=...

    // do some things
    data = applyBusinessLogic(data)

    // save the data
    err = s.db.SaveTheValues(r.Context(), data)
    if er...

    // render / return the result or error incase something unexpected happens

    fmt.Fprintf(w, "Successfully handled the request")
}
```

for example the Login function could look like the following

```go
func (s *Server) Login(w http.ResponseWriter, r *http.Request) {
    if r.Method != "POST" {
        LoginPage(w, r)
        return
    }

    type Request struct {
        Username string
        Password string
    }
    
    var req Request

    err := r.ParseForm()
    if err != nil {
        http.Error(w, "bad request", http.StatusBadRequest)
        return
    }

    req.Password = r.PostForm.Get("password")
    req.Username = r.PostForm.Get("username")

    if (req.Password == "" || req.Username == "") {
        http.Error(w, "Missing required fields", http.StatusBadRequest)
        return
    }

    user, err := s.db.LoginUser(r.Context(), req.Username, req.Password)
    if err != nil {
        http.Error(w, "invalid credentials", http.StatusUnauthorized)
        return
    }

    cookieVal := rand.Text()
    Users.Store(cookieVal, user)
    
    cookie := http.Cookie{
        Name: AuthCookie,
        Value: cookieVal,
        MaxAge: 3600 * 24,
        HttpOnly: true,
        SameSite: http.SameSiteLax,
        Secure: true,
    }
    http.SetCookie(w, &cookie)

    http.Redirect(w, r, "/", http.StatusFound)
}
```

and to handle the `User` request we just follow the exact same pattern of 
input variables, business logic, redirect / render / or return
```go
func (s *Server) User(w http.ResponseWriter, r *http.Request) {
    type Request struct {
        UserId string
    }

    var req Request

    req.UserId = r.PathValue("userid")

    if req.UserId == "" {
        NotFoundPage(w, r, "UserId not provided")
        return
    }

    user, err := s.db.GetUserById(r.Context(), req.UserId)
    if err != nil {
        NotFoundPage(w, r, "User not found")
        return
    }

    UserPage(w, r, user)
}
```
and that's about it.
## Nuances

Now Software development is about much then coding your unique situation, business context, and user count changes the even the basic ideas about programming, for example the simple `sync.Map` approach for session storage works well for a few users but can quickly bend its knees, so one could replace it with a custom read-lock optimized map a or even external cache like redis, to allow multiple instances sharing the same cache.
But this text advocates for building a house for the people you have, not that you potentially could hypothetically have in the future. There's no advantage in splitting up into microservices, adding queues or complex routing if a single sever with a single instance running can handle the requests without any issues.