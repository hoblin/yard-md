# class Gem::Net::HTTP::Persistent
Defined in: `lib/bundler/vendor/net-http-persistent/lib/net/http/persistent.rb`

Persistent connections for Gem::Net::HTTP

Gem::Net::HTTP::Persistent maintains persistent connections across all the
servers you wish to talk to.  For each host:port you communicate with a
single persistent connection is created.

Connections will be shared across threads through a connection pool to
increase reuse of connections.

You can shut down any remaining HTTP connections when done by calling
#shutdown.

Example:

```
require 'bundler/vendor/net-http-persistent/lib/net/http/persistent'

uri = Gem::URI 'http://example.com/awesome/web/service'

http = Gem::Net::HTTP::Persistent.new

# perform a GET
response = http.request uri

# or

get = Gem::Net::HTTP::Get.new uri.request_uri
response = http.request get

# create a POST
post_uri = uri + 'create'
post = Gem::Net::HTTP::Post.new post_uri.path
post.set_form_data 'some' => 'cool data'

# perform the POST, the Gem::URI is always required
response http.request post_uri, post
```

⚠ Note that for GET, HEAD and other requests that do not have a body,
it uses Gem::URI#request_uri as default to send query params

### TLS/SSL

TLS connections are automatically created depending upon the scheme of the
Gem::URI.  TLS connections are automatically verified against the default
certificate store for your computer.  You can override this by changing
verify_mode or by specifying an alternate cert_store.

Here are the TLS settings, see the individual methods for documentation:

**#certificate        ** — This client's certificate
**#ca_file            ** — The certificate-authorities
**#ca_path            ** — Directory with certificate-authorities
**#cert_store         ** — An SSL certificate store
**#ciphers            ** — List of SSl ciphers allowed
**#extra_chain_cert   ** — Extra certificates to be added to the certificate chain
**#private_key        ** — The client's SSL private key
**#reuse_ssl_sessions ** — Reuse a previously opened SSL session for a new
                       connection
**#ssl_timeout        ** — Session lifetime
**#ssl_version        ** — Which specific SSL version to use
**#verify_callback    ** — For server certificate verification
**#verify_depth       ** — Depth of certificate verification
**#verify_mode        ** — How connections should be verified
**#verify_hostname    ** — Use hostname verification for server certificate
                       during the handshake

### Proxies

A proxy can be set through #proxy= or at initialization time by providing a
second argument to ::new.  The proxy may be the Gem::URI of the proxy server or
`:ENV` which will consult environment variables.

See #proxy= and #proxy_from_env for details.

### Headers

Headers may be specified for use in every request.  #headers are appended to
any headers on the request.  #override_headers replace existing headers on
the request.

The difference between the two can be seen in setting the User-Agent.  Using
`http.headers['User-Agent'] = 'MyUserAgent'` will send "Ruby,
MyUserAgent" while `http.override_headers['User-Agent'] = 'MyUserAgent'` will send "MyUserAgent".

### Tuning

#### Segregation

Each Gem::Net::HTTP::Persistent instance has its own pool of connections.  There
is no sharing with other instances (as was true in earlier versions).

#### Idle Timeout

If a connection hasn't been used for this number of seconds it will
automatically be reset upon the next use to avoid attempting to send to a
closed connection.  The default value is 5 seconds. nil means no timeout.
Set through #idle_timeout.

Reducing this value may help avoid the "too many connection resets" error
when sending non-idempotent requests while increasing this value will cause
fewer round-trips.

#### Read Timeout

The amount of time allowed between reading two chunks from the socket.  Set
through #read_timeout

#### Max Requests

The number of requests that should be made before opening a new connection.
Typically many keep-alive capable servers tune this to 100 or less, so the
101st request will fail with ECONNRESET. If unset (default), this value has
no effect, if set, connections will be reset on the request after
max_requests.

#### Open Timeout

The amount of time to wait for a connection to be opened.  Set through
#open_timeout.

#### Socket Options

Socket options may be set on newly-created connections.  See #socket_options
for details.

#### Connection Termination

If you are done using the Gem::Net::HTTP::Persistent instance you may shut down
all the connections in the current thread with #shutdown.  This is not
recommended for normal use, it should only be used when it will be several
minutes before you make another HTTP request.

If you are using multiple threads, call #shutdown in each thread when the
thread is done making requests.  If you don't call shutdown, that's OK.
Ruby will automatically garbage collect and shutdown your HTTP connections
when the thread terminates.

## Constants

### DEFAULT_POOL_SIZE = 256

### EPOCH = Time.at 0

The beginning of Time

### HAVE_OPENSSL = defined? OpenSSL::SSL # :nodoc:

Is OpenSSL available?  This test works with autoload

### VERSION = '4.0.6'

The version of Gem::Net::HTTP::Persistent you are using

## Instance attributes

### #ca_file

An SSL certificate authority.  Setting this will set verify_mode to
VERIFY_PEER.

### #ca_path

A directory of SSL certificates to be used as certificate authorities.
Setting this will set verify_mode to VERIFY_PEER.

### #cert_store

An SSL certificate store.  Setting this will override the default
certificate store.  See verify_mode for more information.

### #certificate

This client's OpenSSL::X509::Certificate

Also known as: `cert`, `cert=`

### #ciphers

The ciphers allowed for SSL connections

### #debug_output

Sends debug_output to this IO via Gem::Net::HTTP#set_debug_output.

Never use this method in production code, it causes a serious security
hole.

### #extra_chain_cert

Extra certificates to be added to the certificate chain

### #generation (read-only)

Current connection generation

### #headers (read-only)

Headers that are added to every request using Gem::Net::HTTP#add_field

### #http_versions (read-only)

Maps host:port to an HTTP version.  This allows us to enable version
specific features.

### #idle_timeout

Maximum time an unused connection can remain idle before being
automatically closed.

### #keep_alive

The value sent in the Keep-Alive header.  Defaults to 30.  Not needed for
HTTP/1.1 servers.

This may not work correctly for HTTP/1.0 servers

This method may be removed in a future version as RFC 2616 does not
require this header.

### #max_requests

Maximum number of requests on a connection before it is considered expired
and automatically closed.

### #max_retries

Number of retries to perform if a request fails.

See also #max_retries=, Gem::Net::HTTP#max_retries=.

### #max_version

Maximum SSL version to use, e.g. :TLS1_2

By default, the version will be negotiated automatically between client
and server.  Ruby 2.5 and newer only.

### #min_version

Minimum SSL version to use, e.g. :TLS1_1

By default, the version will be negotiated automatically between client
and server.  Ruby 2.5 and newer only.

### #name (read-only)

The name for this collection of persistent connections.

### #no_proxy (read-only)

List of host suffixes which will not be proxied

### #open_timeout

Seconds to wait until a connection is opened.  See Gem::Net::HTTP#open_timeout

### #override_headers (read-only)

Headers that are added to every request using Gem::Net::HTTP#[]=

### #pool (read-only)

Test-only accessor for the connection pool

### #private_key

This client's SSL private key

Also known as: `key`, `key=`

### #proxy_uri (read-only)

The URL through which requests will be proxied

### #read_timeout

Seconds to wait until reading one block.  See Gem::Net::HTTP#read_timeout

### #reuse_ssl_sessions

By default SSL sessions are reused to avoid extra SSL handshakes.  Set
this to false if you have problems communicating with an HTTPS server
like:

```
SSL_connect [...] read finished A: unexpected message (OpenSSL::SSL::SSLError)
```

### #socket_options (read-only)

An array of options for Socket#setsockopt.

By default the TCP_NODELAY option is set on sockets.

To set additional options append them to this array:

```
http.socket_options << [Socket::SOL_SOCKET, Socket::SO_KEEPALIVE, 1]
```

### #ssl_generation (read-only)

Current SSL connection generation

### #ssl_timeout

SSL session lifetime

### #ssl_version

SSL version to use.

By default, the version will be negotiated automatically between client
and server.  Ruby 1.9 and newer only. Deprecated since Ruby 2.5.

### #timeout_key (read-only)

Where this instance's last-use times live in the thread local variables

### #verify_callback

SSL verification callback.  Used when ca_file or ca_path is set.

### #verify_depth

Sets the depth of SSL certificate verification

### #verify_hostname

HTTPS verify_hostname.

If a client sets this to true and enables SNI with SSLSocket#hostname=,
the hostname verification on the server certificate is performed
automatically during the handshake using
OpenSSL::SSL.verify_certificate_identity().

You can set `verify_hostname` as true to use hostname verification
during the handshake.

NOTE: This works with Ruby > 3.0.

### #verify_mode

HTTPS verify mode.  Defaults to OpenSSL::SSL::VERIFY_PEER which verifies
the server certificate.

If no ca_file, ca_path or cert_store is set the default system certificate
store is used.

You can use `verify_mode` to override any default values.

### #write_timeout

Seconds to wait until writing one block.  See Gem::Net::HTTP#write_timeout

## Class methods

### .detect_idle_timeout(uri, max = 10)

Use this method to detect the idle timeout of the host at `uri`.  The
value returned can be used to configure #idle_timeout.  `max` controls the
maximum idle timeout to detect.

After

Idle timeout detection is performed by creating a connection then
performing a HEAD request in a loop until the connection terminates
waiting one additional second per loop.

NOTE:  This may not work on ruby > 1.9.

## Instance methods

### #connection_for(uri)

Creates a new connection for `uri`

### #escape(str)

CGI::escape wrapper

### #expired?(connection)

Returns true if the connection should be reset due to an idle timeout, or
maximum request count, false otherwise.

Returns: `Boolean`

### #finish(connection)

Finishes the Gem::Net::HTTP `connection`

### #http_version(uri)

Returns the HTTP protocol version for `uri`

### #initialize(name: nil, proxy: nil, pool_size: DEFAULT_POOL_SIZE)

Creates a new Gem::Net::HTTP::Persistent.

Set a `name` for fun.  Your library name should be good enough, but this
otherwise has no purpose.

`proxy` may be set to a Gem::URI::HTTP or :ENV to pick up proxy options from
the environment.  See proxy_from_env for details.

In order to use a Gem::URI for the proxy you may need to do some extra work
beyond Gem::URI parsing if the proxy requires a password:

```
proxy = Gem::URI 'http://proxy.example'
proxy.user     = 'AzureDiamond'
proxy.password = 'hunter2'
```

Set `pool_size` to limit the maximum number of connections allowed.
Defaults to 1/4 the number of allowed file handles or 256 if your OS does
not support a limit on allowed file handles.  You can have no more than
this many threads with active HTTP transactions.

### #normalize_uri(uri)

Adds "http://" to the String `uri` if it is missing.

### #proxy=(proxy)

Sets the proxy server.  The `proxy` may be the Gem::URI of the proxy server,
the symbol `:ENV` which will read the proxy from the environment or nil to
disable use of a proxy.  See #proxy_from_env for details on setting the
proxy from the environment.

If the proxy Gem::URI is set after requests have been made, the next request
will shut-down and re-open all connections.

The `no_proxy` query parameter can be used to specify hosts which shouldn't
be reached via proxy; if set it should be a comma separated list of
hostname suffixes, optionally with `:port` appended, for example
`example.com,some.host:8080`.

### #proxy_bypass?(host, port)

Returns true when proxy should by bypassed for host.

Returns: `Boolean`

### #proxy_from_env

Creates a Gem::URI for an HTTP proxy server from ENV variables.

If `HTTP_PROXY` is set a proxy will be returned.

If `HTTP_PROXY_USER` or `HTTP_PROXY_PASS` are set the Gem::URI is given the
indicated user and password unless HTTP_PROXY contains either of these in
the Gem::URI.

The `NO_PROXY` ENV variable can be used to specify hosts which shouldn't
be reached via proxy; if set it should be a comma separated list of
hostname suffixes, optionally with `:port` appended, for example
`example.com,some.host:8080`. When set to `*` no proxy will
be returned.

For Windows users, lowercase ENV variables are preferred over uppercase ENV
variables.

### #reconnect

Forces reconnection of all HTTP connections, including TLS/SSL
connections.

### #reconnect_ssl

Forces reconnection of only TLS/SSL connections.

### #reload

Discard all existing connections. Subsequent checkouts will create
new connections as needed.

If any thread is still using a connection it may cause an error!  Call
#reload when you are completely done making requests!

### #request(uri, req = nil, &block)

Makes a request on `uri`.  If `req` is nil a Gem::Net::HTTP::Get is performed
against `uri`.

If a block is passed #request behaves like Gem::Net::HTTP#request (the body of
the response will not have been read).

`req` must be a Gem::Net::HTTPGenericRequest subclass (see Gem::Net::HTTP for a list).

### #request_setup(req_or_uri)

Creates a GET request if `req_or_uri` is a Gem::URI and adds headers to the
request.

Returns the request.

### #reset(connection)

Finishes then restarts the Gem::Net::HTTP `connection`

### #shutdown

Shuts down all connections. Attempting to checkout a connection after
shutdown will raise an error.

**NOTE**: Calling shutdown for can be dangerous!

If any thread is still using a connection it may cause an error!  Call
#shutdown when you are completely done making requests!

### #ssl(connection)

Enables SSL on `connection`

### #start(http)

Starts the Gem::Net::HTTP `connection`

### #unescape(str)

CGI::unescape wrapper
