package Thrall;

=head1 NAME

Thrall - a simple PSGI/Plack HTTP server which uses threads

=head1 SYNOPSIS

  $ plackup -s Thrall --port=80 [options] your-app.psgi

  $ plackup -s Thrall --port=443 --ssl=1 --ssl-key-file=file.key --ssl-cert-file=file.crt [options] your-app.psgi

  $ plackup -s Thrall --port=80 --ipv6 [options] your-app.psgi

  $ plackup -s Thrall --socket=/tmp/thrall.sock [options] your-app.psgi

=head1 DESCRIPTION

Thrall is a standalone HTTP/1.1 server with keep-alive support. It uses
threads instead pre-forking, so it works correctly on Windows. It is pure-Perl
implementation which doesn't require any XS package.

=for readme stop

=cut


use 5.008_001;

use strict;
use warnings;

our $VERSION = '0.0202';

1;


__END__

=head1 COMMAND LINE OPTIONS

In addition to the options supported by L<plackup>, Thrall accepts following
options(s).

=over

=item --max-workers=#

number of worker processes (default: 10)

=item --timeout=#

seconds until timeout (default: 300)

=item --keepalive-timeout=#

timeout for persistent connections (default: 2)

=item --max-keepalive-reqs=#

max. number of requests allowed per single persistent connection.  If set to
one, persistent connections are disabled (default: 1)

=item --max-reqs-per-child=#

max. number of requests to be handled before a worker process exits (default:
1000)

=item --min-reqs-per-child=#

if set, randomizes the number of requests handled by a single worker process
between the value and that supplied by C<--max-reqs-per-chlid> (default: none)

=item --spawn-interval=#

if set, worker processes will not be spawned more than once than every given
seconds.  Also, when SIGHUP is being received, no more than one worker
processes will be collected every given seconds.  This feature is useful for
doing a "slow-restart". (default: none)

=item --main-thread-delay=#

the Thrall does not use signals or semaphores and it requires a small delay in
main thread so it doesn't consume all CPU. (default: 0.1)

=item --thread-stack-size=#

sets a new default per-thread stack size. (default: none)

=item --ssl=#

enables SSL support. The L<IO::Socket::SSL> module is required. (default: 0)

=item --ssl-key-file=#

specifies the path to SSL key file. (default: none)

=item --ssl-cert-file=#

specifies the path to SSL certificate file. (default: none)

=item --ipv6=#

enables IPv6 support. The L<IO::Socket::IP> module is required. (default: 0)

=item --socket=#

enables UNIX socket support. The L<IO::Socket::UNIX> module is required. The
socket file have to be not yet created. The first character C<@> or C<\0> in
the socket file name means that abstract socket address will be created.
(default: none)

=back

=for readme continue

=head1 NOTES

Thrall was started as a fork of L<Starlet> server. It has almost the same code
as L<Starlet> and it was adapted to use threads instead fork().

=head1 SEE ALSO

L<Starlet>,
L<Starman>

=head1 LIMITATIONS

See L<threads/"BUGS AND LIMITATIONS"> and L<perlthrtut/"Thread-Safety of
System Libraries"> to read about limitations for PSGI applications started
with Thrall and check if you encountered a known problem.

Especially, PSGI applications should avoid: changing current working
directory, catching signals, starting new processes. Environment variables
might (Linux, Unix) or might not (Windows) be shared between threads.

=head1 BUGS

There is a problem with Perl threads implementation which occurs on Windows.
Some requests can fail with message:

  failed to set socket to nonblocking mode:An operation was attempted on
  something that is not a socket.

Cygwin version seems to be correct.

This problem was introduced in Perl 5.16 and fixed in Perl 5.18.2 and Perl
5.19.5.

See L<https://rt.perl.org/rt3/Public/Bug/Display.html?id=119003> for more
information about this issue.

=head2 Reporting

If you find the bug or want to implement new features, please report it at
L<https://github.com/dex4er/Thrall/issues>

The code repository is available at
L<http://github.com/dex4er/Thrall>

=head1 AUTHORS

Piotr Roszatycki <dexter@cpan.org>

Based on Starlet by:

Kazuho Oku

miyagawa

kazeburo

Some code based on Plack:

Tatsuhiko Miyagawa

=head1 LICENSE

Copyright (c) 2013 Piotr Roszatycki <dexter@cpan.org>.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.

See L<http://dev.perl.org/licenses/artistic.html>
