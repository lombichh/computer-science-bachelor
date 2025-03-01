/*
 * Please do not edit this file.
 * It was generated using rpcgen.
 */

#include "RPC.h"

bool_t
xdr_Matricola(xdrs, objp)
	XDR *xdrs;
	Matricola *objp;
{

	if (!xdr_vector(xdrs, (char *)objp->matricola, MAX_MATRICOLA_SIZE, sizeof(char), (xdrproc_t)xdr_char))
		return (FALSE);
	return (TRUE);
}

bool_t
xdr_Studente(xdrs, objp)
	XDR *xdrs;
	Studente *objp;
{

	if (!xdr_vector(xdrs, (char *)objp->matricola, MAX_MATRICOLA_SIZE, sizeof(char), (xdrproc_t)xdr_char))
		return (FALSE);
	if (!xdr_vector(xdrs, (char *)objp->nome, MAX_NAME_SIZE, sizeof(char), (xdrproc_t)xdr_char))
		return (FALSE);
	if (!xdr_vector(xdrs, (char *)objp->cognome, MAX_NAME_SIZE, sizeof(char), (xdrproc_t)xdr_char))
		return (FALSE);
	if (!xdr_int(xdrs, &objp->voto))
		return (FALSE);
	return (TRUE);
}

bool_t
xdr_Output(xdrs, objp)
	XDR *xdrs;
	Output *objp;
{

	if (!xdr_vector(xdrs, (char *)objp->lista_studenti, MAX_LISTA_SIZE, sizeof(Studente), (xdrproc_t)xdr_Studente))
		return (FALSE);
	return (TRUE);
}
