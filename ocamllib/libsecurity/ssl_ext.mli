(*
    Copyright © 2011 MLstate

    This file is part of Opa.

    Opa is free software: you can redistribute it and/or modify it under the
    terms of the GNU Affero General Public License, version 3, as published by
    the Free Software Foundation.

    Opa is distributed in the hope that it will be useful, but WITHOUT ANY
    WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
    FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
    more details.

    You should have received a copy of the GNU Affero General Public License
    along with Opa. If not, see <http://www.gnu.org/licenses/>.
*)

(**
   Additionnal bindings to SSL

   @see <http://www.openssl.org/docs/ssl/ssl.html> for OpenSSL functions
   @see <http://savonet.rastageeks.org/browser/trunk/ocaml-ssl> for base Ocaml-ssl source code
   @see "ssl_ext.c" for the c-implementation of external values
   @author Frederic Ye
*)

(** {6 SSL} *)

(** Another SSL initialisation function, that adds support for all digests, ciphers and algorithms *)
val init : unit -> unit

val set_session_id_context : Ssl.context -> unit

(** Set CTX options for bugs workarounds and renegotiation (SSL_OP_NO_SESSION_RESUMPTION_ON_RENEGOTIATION)
    -> fails with Opera if the second is not set...
    Should be able to select whatever options we want :
    @see <http://www.openssl.org/docs/ssl/SSL_CTX_set_options.html> Damnit \@see needs a description
*)
val set_ctx_options : Ssl.context -> int

val set_verify : Ssl.socket -> Ssl.verify_mode list -> Ssl.verify_callback option -> unit

(** Compute the digest of a certificate *)
val compute_digest : Ssl.certificate -> string -> int -> string

val certificate_to_string : Ssl.certificate -> string -> int -> string

(** Exception raised when there is an error during a renegotiation  *)
exception Renegotiation_error

(** Exception raised when there is an error during a hanshake *)
exception Handshake_error of Ssl.ssl_error

(** Renegotiate ssl function has to be used with do_handshake function to
    complete a full renegotiation. *)
val renegotiate : Ssl.socket -> unit

(** Return the verify_callback that does no verifications.
    Usefull if we don't want OpenSSL to check the client certificate validity *)
val no_client_verify_callback : Ssl.verify_callback

val check_chain : Ssl.certificate -> string -> bool

val do_handshake : Ssl.socket -> unit
(** {6 RSA} *)

exception RSA_error

type rsa_key

(** Read an SSL RSA private key from a given file *)
val rsa_read_privkey : string -> rsa_key

(** Read an SSL RSA public key from a given file *)
val rsa_read_pubkey : string -> rsa_key

(** Convert an SSL RSA key to a Cryptokit RSA key format *)
val rsa_key_to_cryptokit_hex_rsa : rsa_key -> Cryptokit.RSA.key

(** Convert a [Ssl.ssl_error] to a string *)
val error_to_string : Ssl.ssl_error -> string
