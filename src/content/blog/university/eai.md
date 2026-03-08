---
title: "eai"
description: "Lorem ipsum dolor sit amet"
pubDate: "Jul 08 2022"
gitLink: "https://github.com/Juli0n21/eai"
---

<style is:global>
h1,
h2,
h3,
h4, ul li { color: #1e3a8a }
body, table { background: #9ca3af }
.wrapper, nav::after  {background: #f1f5f9 }
p, a, ul { color: #000000 }
img, iframe, td {
    border: 5px solid;
    border-color: #aaaeaf;
}
</style>

# Enterprise Application Integration - Grand Finale

We build a website to show of the diffrent layers and Techniques used in eai, we set ourself the goal to build a webshop, we ended up with 3 backend components and 4 frontend ones, first we started with Microservices as backend having each their own database. A CRM, IMS and PMS those where build using diffrent languages and frameworks, each service got their own microfrontends aswell, lastly a portal that was managed using module federation and the routing of the independent services happend over a wos2 integrator a Enterprise service bus

Try it out, and play around 

<IFrame src="https://eai.illegalesachen.download" height="800px" />

#

The other Services are reachable here

| Service | Backend (OpenAPI/Swagger) | Frontend |
| :--- | :--- | :--- |
| **Customers** | [Swagger UI](https://eai-customers.illegalesachen.download/swagger/index.html) | [Customer Dashboard](https://eai.illegalesachen.download/customers) |
| **Products** | [Swagger UI](https://eai-products.illegalesachen.download/swagger-ui/index.html) | [Product Catalog](https://eai.illegalesachen.download/products) |
| **Orders** | [Swagger UI](https://eai-orders.illegalesachen.download/orders/q/swagger-ui) | [Order Management](https://eai.illegalesachen.download/orders) |
