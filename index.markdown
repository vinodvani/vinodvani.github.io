---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: home
author: admin
comments: true
toc: true
---


<h1> New Website </h1>


# Table of contents
1. [Hypertext transfer protocol (HTTP)](#Hypertext-transfer-protocol-(HTTP))
    1. [HTTP Requests](#HTTP-REQUESTS)
    2. [HTTP Responses](#HTTP-RESPONSE)
    3. [HTTP Methods](#HTTP-METHODS)
    4. [REST](#rest)
    5. [HTTP Headers](#HTTP_HEADERS)
        1. [General Headers](#GENERAL_HEADERS)
        2. [Request Headers](#REQUEST_HEADERS)
        3. [Response Headers](#RESPONSE_HEADERS)
    6. [Cookies](#COOKIES)
    7. [Status Codes](#STATUS_CODES)
    8. [HTTP Proxies](#HTTP_PROXIES)
    9. [HTTP AUTHENTICATION](#AUTHENTICATION)
2. Web Functionality
    1. [Server-Side Functionality](#SERVER_SIDE_FUNCTIONALITY)
    2. [Client-Side Functionality](#CLIENT_SIDE_FUNCTIONALITY)
    3. [State and Sessions](#STATE_AND_SESSIONS)


# Hypertext transfer protocol (HTTP) <a name="Hypertext-transfer-protocol-(HTTP)"></a>

Hypertext transfer protocol (HTTP) is the core communications protocols used to access the World Wide Web and is used by all of today's web applications. It is a simple protocol that was originally developed for retrieving static text-based resources. It has since been extended and leveraged in various ways to enable its to support the complex distributed applications that are now commonplace.

HTTP uses a message-based model in which a client sends a request mes- sage and the server returns a response message. The protocol is essentially connectionless: although HTTP uses the stateful TCP protocol as its transport mechanism, each exchange of request and response is an autonomous transac- tion and may use a different TCP connection.

## HTTP Requests <a name="HTTP-REQUESTS"></a>

All HTTP messages (requests and responses) consist of one or more headers, each on a separate line, followed by a mandatory blank line, followed by an optional message body. A typical HTTP request is as follows:

```
  GET /auth/488/YourDetails.ashx?uid=129 HTTP/1.1
  Accept: application/x-ms-application, image/jpeg, application/xaml+xml,
  image/gif, image/pjpeg, application/x-ms-xbap, application/x-shockwave-
  flash, */*
  Referer: https://mdsec.net/auth/488/Home.ashx
  Accept-Language: en-GB
  User-Agent: Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; WOW64;
  Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR
  3.0.30729; .NET4.0C; InfoPath.3; .NET4.0E; FDM; .NET CLR 1.1.4322)
  Accept-Encoding: gzip, deflate
  Host: mdsec.net
  Connection: Keep-Alive
  Cookie: SessionId=5B70C71F3FD4968935CDB6682E545476

```
**The first line of every HTTP request consists of three items, separated by spaces:**

* A verb indicating the HTTP method. The most commonly used method is GET, whose function is to retrieve a resource from the web server. GET requests do not have a message body, so no further data follows the blank line after the message headers.

* The requested URL. The URL typically functions as a name for the resource being requested, together with an optional query string containing param- eters that the client is passing to that resource. The query string is indicated by the ? character in the URL. The example contains a single parameter with the name uid and the value 129.

* The HTTP version being used. The only HTTP versions in common use on the Internet are 1.0 and 1.1, and most browsers use version 1.1 by default. There are a few differences between the specifications of these two versions; however, the only difference you are likely to encounter when attacking web applications is that in version 1.1 the Host request header is mandatory.

**Here are some other points of interest in the sample request:**

* The Referer header is used to indicate the URL from which the request originated (for example, because the user clicked a link on that page). Note that this header was misspelled in the original HTTP specification, and the misspelled version has been retained ever since.

* The User-Agent header is used to provide information about the browser or other client software that generated the request. Note that most brows- ers include the Mozilla prefix for historical reasons. This was the User- Agent string used by the originally dominant Netscape browser, and other browsers wanted to assert to websites that they were compatible with this standard. As with many quirks from computing history, it has become so established that it is still retained, even on the current version of Internet Explorer, which made the request shown in the example.

* The Host header specifies the hostname that appeared in the full URL being accessed. This is necessary when multiple websites are hosted on the same server, because the URL sent in the first line of the request usually does not contain a hostname. (See Chapter 17 for more information about virtually hosted websites.)

* The Cookie header is used to submit additional parameters that the server has issued to the client (described in more detail later in this chapter).

## HTTP Responses <a name="HTTP-RESPONSE"></a>

A typical HTTP response is as follows:
```
  HTTP/1.1 200 OK
  Date: Tue, 19 Apr 2011 09:23:32 GMT
  Server: Microsoft-IIS/6.0
  X-Powered-By: ASP.NET
  Set-Cookie: tracking=tI8rk7joMx44S2Uu85nSWc
  X-AspNet-Version: 2.0.50727
  Cache-Control: no-cache
  Pragma: no-cache
  Expires: Thu, 01 Jan 1970 00:00:00 GMT
  Content-Type: text/html; charset=utf-8
  Content-Length: 1067
  <!DOCTYPE html PUBLIC “-//W3C//DTD XHTML 1.0 Transitional//EN” “http://
  www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd”><html xmlns=”http://
  www.w3.org/1999/xhtml” ><head><title>Your details</title>
  ...
```
**The first line of every HTTP response consists of three items, separated by
spaces:**

* The HTTP version being used.
* A numeric status code indicating the result of the request. 200 is the most common status code; it means that the request was successful and that the requested resource is being returned.
* A textual “reason phrase” further describing the status of the response. This can have any value and is not used for any purpose by current browsers.

**Here are some other points of interest in the response:**

* The Server header contains a banner indicating the web server software being used, and sometimes other details such as installed modules and the server operating system. The information contained may or may not be accurate.

* The Set-Cookie header issues the browser a further cookie; this is sub- mitted back in the Cookie header of subsequent requests to this server.

* The Pragma header instructs the browser not to store the response in its cache. The Expires header indicates that the response content expired in the past and therefore should not be cached. These instructions are frequently issued when dynamic content is being returned to ensure that browsers obtain a fresh version of this content on subsequent occasions.

* Almost all HTTP responses contain a message body following the blank line after the headers. The Content-Type header indicates that the body of this message contains an HTML document.

* The Content-Length header indicates the length of the message body in bytes.

## HTTP Methods <a name="HTTP-METHODS"></a>

When you are attacking web applications, you will be dealing almost exclusively with the most commonly used methods: GET and POST. You need to be aware of some important differences between these methods, as they can affect an application’s security if overlooked.

The GET method is designed to retrieve resources. It can be used to send parameters to the requested resource in the URL query string. This enables users to bookmark a URL for a dynamic resource that they can reuse. Or other users can retrieve the equivalent resource on a subsequent occasion (as in a bookmarked search query). URLs are displayed on-screen and are logged in various places, such as the browser history and the web server’s access logs. They are also transmitted in the Referer header to other sites when external links are followed. For these reasons, the query string should not be used to transmit any sensitive information.

The *POST* method is designed to perform actions. With this method, request parameters can be sent both in the URL query string and in the body of the message. Although the URL can still be bookmarked, any parameters sent in the message body will be excluded from the bookmark. These parameters will also be excluded from the various locations in which logs of URLs are main- tained and from the Referer header. Because the POST method is designed for performing actions, if a user clicks the browser’s Back button to return to a page that was accessed using this method, the browser does not automatically reissue the request. Instead, it warns the user of what it is about to do, as shown in Figure 3-1. This prevents users from unwittingly performing an action more than once. For this reason, POST requests should always be used when an action is being performed.

In additions to the *GET* and *POST* methods, the HTTP protocol supports numerous other methods that have been created for specific purposes. Here are the other ones you are most likely to require knowledge of:

* **HEAD** functions in the same way as a *GET* request, except that the server should not return a message body in its response. The server should return the same headers that it would have returned to the corresponding *GET* request. Hence, this method can be used to check whether a resource is present before making a *GET* request for it.

* **TRACE** is designed for diagnostic purposes. The server should return in the response bidy the exact contents of the request mesage it received. zthis can be used to detect the effect of nay proxy sservers between the client and server that may manipulate the request.

* **OPTIONS** asks the server to report the HTTP methods that are available for a particular resource. The server typically returns a response containing an **Allow** header that lists the available methods.

* **PUT** attempts to upload the specified resource to the server, using the content contained in the body of the request. If this method is enabled, you may be able to leverage it to attack the application, such as by uploading an arbitrary script and executing it on the server.

## REST <a name="rest"></a>

**Representational state transfer (REST)** is a style of architecture for distributed systems in which requests and responses contain representations of the current state of the system’s resources. The core technologies employed in the World Wide Web, including the HTTP protocol and the format of URLs, conform to the REST architectural style.

Although URLs containing parameters within the query string do themselves conform to REST constraints, the term “REST-style URL” is often used to signify a URL that contains its parameters within the URL file path, rather than the query string. For example, the following URL containing a query string:

  *http://wahh-app.com/search?make=ford&model=pinto*

corresponds to the following URL containing “REST-style” parameters:

 *http://wahh-app.com/search/ford/pinto*


## HTTP Headers <a name="HTTP_HEADERS"></a>

### General Headers <a name="GENERAL_HEADERS"></a>

* **Connection** tells the other end of the communication whether it should close the TCP connection after the HTTP transmission has completed or keep it open for further messages.

* **Content-Encoding** specifies what kind of encoding is being used for the content contained in the message body, such as gzip, which is used by some applications to compress responses for faster transmission.

* **Content-Length** specifies the length of the message body, in bytes (except in the case of responses to HEAD requests, when it indicates the length of the body in the response to the corresponding GET request).

* **Content-Type** specifies the type of content contained in the message body, such as text/html for HTML documents.

* **Transfer-Encoding** specifies any encoding that was performed on the message body to facilitate its transfer over HTTP. It is normally used to specify chunked encoding when this is employed.

### Request Headers <a name="REQUEST_HEADERS"></a>

* **Accept** tells the server what kinds of content the client is willing to accept, such as image types, office document formats, and so on.

* **Accept-Encoding** tells the server what kinds of content encoding the client is willing to accept.

* **Authorization** submits credentials to the server for one of the built-in HTTP authentication types.

* **Cookie** submits cookies to the server that the server previously issued. 

* **Host** specifies the hostname that appeared in the full URL being requested.

* **If-Modified-Since** specifies when the browser last received the requested resource. If the resource has not changed since that time, the server may instruct the client to use its cached copy, using a response with status code 304.

* **If-None-Match** specifies an entity tag, which is an identifier denoting the contents of the message body. The browser submits the entity tag that the server issued with the requested resource when it was last received. The server can use the entity tag to determine whether the browser may use its cached copy of the resource.

* **Origin** is used in cross-domain Ajax requests to indicate the domain from which the request originated (see Chapter 13).

* **Referer** specifies the URL from which the current request originated.

* **User-Agent** provides information about the browser or other client software that generated the request.

### Response Headers <a name="RESPONSE_HEADERS"></a>

* **Access-Control-Allow-Origin** indicates whether the resource can be retrieved via cross-domain Ajax requests (see Chapter 13).

* **Cache-Control** passes caching directives to the browser (for example, no-cache).

* **ETag specifies** an entity tag. Clients can submit this identifier in future requests for the same resource in the If-None-Match header to notify the server which version of the resource the browser currently holds in its cache.

* **Expires** tells the browser for how long the contents of the message body are valid. The browser may use the cached copy of this resource until this time.

* **Location** is used in redirection responses (those that have a status code starting with 3) to specify the target of the redirect.

* **Pragma** passes caching directives to the browser (for example, no-cache).

* **Server** provides information about the web server software being used.

* **Set-Cookie** issues cookies to the browser that it will submit back to the server in subsequent requests.

* **WWW-Authenticate** is used in responses that have a 401 status code to provide details on the type(s) of authentication that the server supports.

* **X-Frame-Options** indicates whether and how the current response may be loaded within a browser frame (see Chapter 13).

## Cookies <a name="COOKIES"></a>

Cookies are a key part of HTTP protocol that most web applications rely on. Frequently they can be used as a vehicle for exploiting vulnerabilities. The cookies mechanism eanbles the server to send items of data to the client, which the client stores and resubmits to the server. Unlike, the other types of requests parameters (those within the URL query string or the message body), cookies continue to be resubmitted in each subsequent request without any particular action required by the application or the user.

A Server issues a cookie using the **Set-Cookie** respponse header, as you have seen;

  **Set-Cookie: tracking=tI8rk7joMx44S2Uu85nSWc**

The user’s browser then automatically adds the following header to subsequent requests back to the same server:
  
  **Cookie: tracking=tI8rk7joMx44S2Uu85nSWc**

Cookies normally consist of a name/value pair, as shown, but they may consist of any string that does not contain a space. Multiple cookies can be issued by using multiple Set-Cookie headers in the server’s response. These are submitted back to the server in the same Cookie header, with a semicolon separating different individual cookies.

In addition to the cookie’s actual value, the Set-Cookie header can include any of the following optional attributes, which can be used to control how the browser handles the cookie:

* **expires** sets a data until which the cookie is valid. This causes the browser to save the cookie to presistent storage, and it is reused in subsequent browser sessions until the expiration date is reached. If this attribute not set, the cookie is used only in the current browser session.

* **domain** specifies the domain for which the cookie is valid. This must be the same or parent of the domain from which the cookie is received.

* **path** specifies the URL path foe which the cookie is valid.

* **secure** If this attribute is set, the cookie will be submitted only in the HTTPS requests.

* **HttpOnly** If this attribute is set, the cookie cannot be directly accesses via client-side JavaScript.

Each of these cookies attributes can impact the application's security. The peimary impact is on the attacker's ability to target other users of the application.

## Status Codes <a name="STATUS_CODES"></a>

Each HTTP response message must contain a status code in its first line, indicating the result of the request. The status codes fall into five groups, according to the code’s first digit:

* 1xx — Informational.
* 2xx — The request was successful.
* 3xx — The client is redirected to a different resource.
* 4xx — The request contains a* error of some kind.
* 5xx — The server encountered an error fulfilling the request.

There are numerous specific status codes, many of which are used only in specialized circumstances. Here are the status codes you are most likely to encounter when attacking a web application, along with the usual reason phrase associated with them:

* 100 Continue is sent in some circumstances when a client submits a request containing a body. The response indicates that the request headers were received and that the client should continue sending the body. The server returns a second response when the request has been completed.
* 200 OK indicates that the request was successful and that the response body contains the result of the request.
* 201 CreatedisreturnedinresponsetoaPUTrequesttoindicatethatthe request was successful.
* 301 Moved Permanently redirects the browser permanently to a different URL, which is specified in the Location header. The client should use the new URL in the future rather than the original.
* 302 Found redirects the browser temporarily to a different URL, which is specified in the Location header. The client should revert to the original URL in subsequent requests.
* 304 Not Modified instructs the browser to use its cached copy of the requested resource. The server uses the If-Modified-Since and If-None- Match request headers to determine whether the client has the latest version of the resource.
* 400 Bad Request indicates that the client submitted an invalid HTTP request. You will probably encounter this when you have modified a request in certain invalid ways, such as by placing a space character into the URL.
* 401 Unauthorized indicates that the server requires HTTP authentication before the request will be granted. The WWW-Authenticate header contains details on the type(s) of authentication supported.
* 403 Forbidden indicates that no one is allowed to access the requested resource, regardless of authentication.
* 404 Not Found indicates that the requested resource does not exist.
* 405 Method Not Allowed indicates that the method used in the request is not supported for the specified URL. For example, you may receive this status code if you attempt to use the PUT method where it is not supported.
* 413 Request Entity Too Large — If you are probing for buffer overflow vulnerabilities in native code, and therefore are submitting long strings of data, this indicates that the body of your request is too large for the server to handle.
* 414 Request URI Too Long is similar to the 413 response. It indicates that the URL used in the request is too large for the server to handle.
* 500 Internal Server Error indicates that the server encountered an error fulfilling the request. This normally occurs when you have submit- ted unexpected input that caused an unhandled error somewhere within the application’s processing. You should closely review the full contents of the server’s response for any details indicating the nature of the error.
* 503 Service Unavailable normally indicates that, although the web server itself is functioning and can respond to requests, the application accessed via the server is not responding. You should verify whether this is the result of any action you have performed.

## HTTP Proxies <a name="HTTP_PROXIES"></a>

A HTTP proxy is a server that mediates access between the client browser and the destination web server. When a browser has been configured to use a proxy server, it makes all its requests to that server. The Proxy relays the requests to the relevant web servers and forwards their responses back to the browser.
Most proxies provide additional services, including caching, authentication, and access control.

**You should be aware of two differences in how HTTP works when a procy server is being used:**

* When a browser issues an unencrypted HTTP request to a proxy server, it places the full URL into the request, including the protocol prefix http://, the server's hostname, and the port number if this is unstandard. The proxy server extracts the hostname and port and uses these to direct the request to the correct destination server.

* WHen HTTPS is being used, the browser cannot perform the SSL hand-shake with proxy-server, because this would break the secure channel and leave the communications vulnerable to interception attacks. Hence, the browser must use the proxy as a pure TCP-level relay, which passes all network data in both directions between the browser and the destination web server, with which the browser performs the SSL handshake as normal. To establish this relay, the browser makes an HTTP request to the proxy server using **CONNECT** method and specifying the destination hostname and port number as the URL. If the proxy allows the request, it returns an HTTP response with a 200 status, keeps the TCP connection open, and from that point onward acts as a pure TCP-level relay to the destination web server.

## HTTP Authentication <a name="AUTHENTICATION"></a>

The HTTP protocol includes its own mechanisms for authenticating users using various authentication schemes, including the following:

* **Basic** is a simple authentication mechanism that sends user credentials as a Base64-encoded string in a request header with each message.

* **NTLM** is a challenge-response mechanism and uses a version of the Windows NTLM protocol.

* **Digest** is a challenge-response mechanism and uses MD5 checksums of a nonce with the user’s credentials.

It is relatively rare to encounter these authentication protocols being used by web applications deployed on the Internet. They are more commonly used within organizations to access intranet-based services.

# Web Functionality

In addition to the core communications protocol used to send messages between client and server, web applications employ numerous technologies to deliver their functionality. Any reasonably functional application may employ dozens of distinct technologies within its server and client components. Before you can mount a serious attack against a web application, you need a basic understand- ing of how its functionality is implemented, how the technologies used are designed to behave, and where their weak points are likely to lie.

## Server-Side Functionality <a name="SERVER_SIDE_FUNCTIONALITY"></a>

The early World Wide Web contained entirely static content. Websites con- sisted of various resources such as HTML pages and images, which were simply loaded onto a web server and delivered to any user who requested them. Each time a particular resource was requested, the server responded with the same content.

Today’s web applications still typically employ a fair number of static resources. However, a large amount of the content that they present to users is generated **dynamically**. When a user requests a dynamic resource, the server’s response is created on the fly, and each user may receive content that is uniquely customized for him or her.

**Dynamic content is generated by scripts or other code executing on the server.** These scripts are akin to computer programs in their own right. They have various inputs, perform processing on these, and return their outputs to the user.



## Client-Side Fucntionality <a name="CLIENT_SIDE_FUNCTIONALITY"></a>

## State and Sessions <a name"STATE_AND_SESSIONS"></a>
