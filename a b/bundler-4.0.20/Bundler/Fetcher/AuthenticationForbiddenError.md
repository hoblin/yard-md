# class Bundler::Fetcher::AuthenticationForbiddenError < Bundler::HTTPError
Defined in: `lib/bundler/fetcher.rb`

This error is raised if HTTP authentication is correct, but lacks
necessary permissions.

## Instance methods

### #initialize(remote_uri)
