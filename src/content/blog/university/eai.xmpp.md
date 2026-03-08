---
title: "eai-xmpp"
description: "Lorem ipsum dolor sit amet"
pubDate: "Jul 08 2022"
---

<style is:global>
h1,
h2,
h3,
h4, 
ul li,
figcaption::before { color: #ff5faf }
body {background: #1e1e1e }
.wrapper, nav::after  {background: #18181b }
p, a, ul { color: #fff }
img, iframe {
    border: 5px solid;
    border-color: #ff5faf; 
}
</style>

# Terminal XMPP client setup

In this lecture we talked about Message based integration and looked at some Technologies
To deepen the Lecture we created a custom Xmpp client that implements common features to a terminal based xmpp client should have.

- Creating a public channel, where multiple users can join
- See Online Users
![publicChat](@assets/eai-xmpp/publicChat.png)

- Write Private Chat Messages
- write them with `/msg Username [message]
![privateChat](@assets/eai-xmpp/privateChat.png)

switch with Tab
