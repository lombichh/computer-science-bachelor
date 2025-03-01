/*
 * Please do not edit this file.
 * It was generated using rpcgen.
 */

#ifndef _RPC_XFILE_H_RPCGEN
#define _RPC_XFILE_H_RPCGEN

#define RPCGEN_VERSION	199506

#include <rpc/rpc.h>

#define MAX_NUM_PREN 30
#define ID_SERIALE_LENGTH 7
#define CARTA_ID_LENGTH 5
#define BRAND_LENGTH 5
#define MAX_FOLDER_LENGTH 20

struct Prenotazione {
	char id_seriale[ID_SERIALE_LENGTH];
	char carta_id[CARTA_ID_LENGTH];
	char brand[BRAND_LENGTH];
	char img_folder[MAX_FOLDER_LENGTH];
};
typedef struct Prenotazione Prenotazione;
#ifdef __cplusplus
extern "C" bool_t xdr_Prenotazione(XDR *, Prenotazione*);
#elif __STDC__
extern  bool_t xdr_Prenotazione(XDR *, Prenotazione*);
#else /* Old Style C */
bool_t xdr_Prenotazione();
#endif /* Old Style C */


struct Prenotazioni {
	Prenotazione prenotazioni[MAX_NUM_PREN];
};
typedef struct Prenotazioni Prenotazioni;
#ifdef __cplusplus
extern "C" bool_t xdr_Prenotazioni(XDR *, Prenotazioni*);
#elif __STDC__
extern  bool_t xdr_Prenotazioni(XDR *, Prenotazioni*);
#else /* Old Style C */
bool_t xdr_Prenotazioni();
#endif /* Old Style C */


struct Brand {
	char brand[BRAND_LENGTH];
};
typedef struct Brand Brand;
#ifdef __cplusplus
extern "C" bool_t xdr_Brand(XDR *, Brand*);
#elif __STDC__
extern  bool_t xdr_Brand(XDR *, Brand*);
#else /* Old Style C */
bool_t xdr_Brand();
#endif /* Old Style C */


struct Id_seriale {
	char id_seriale[ID_SERIALE_LENGTH];
};
typedef struct Id_seriale Id_seriale;
#ifdef __cplusplus
extern "C" bool_t xdr_Id_seriale(XDR *, Id_seriale*);
#elif __STDC__
extern  bool_t xdr_Id_seriale(XDR *, Id_seriale*);
#else /* Old Style C */
bool_t xdr_Id_seriale();
#endif /* Old Style C */


#define PREN ((rpc_uint)0x20000013)
#define PRENVERS ((rpc_uint)1)

#ifdef __cplusplus
#define VISUALIZZA_PRENOTAZIONI ((rpc_uint)1)
extern "C" Prenotazioni * visualizza_prenotazioni_1(Brand *, CLIENT *);
extern "C" Prenotazioni * visualizza_prenotazioni_1_svc(Brand *, struct svc_req *);
#define ELIMINA_MONOPATTINO ((rpc_uint)2)
extern "C" int * elimina_monopattino_1(Id_seriale *, CLIENT *);
extern "C" int * elimina_monopattino_1_svc(Id_seriale *, struct svc_req *);

#elif __STDC__
#define VISUALIZZA_PRENOTAZIONI ((rpc_uint)1)
extern  Prenotazioni * visualizza_prenotazioni_1(Brand *, CLIENT *);
extern  Prenotazioni * visualizza_prenotazioni_1_svc(Brand *, struct svc_req *);
#define ELIMINA_MONOPATTINO ((rpc_uint)2)
extern  int * elimina_monopattino_1(Id_seriale *, CLIENT *);
extern  int * elimina_monopattino_1_svc(Id_seriale *, struct svc_req *);

#else /* Old Style C */
#define VISUALIZZA_PRENOTAZIONI ((rpc_uint)1)
extern  Prenotazioni * visualizza_prenotazioni_1();
extern  Prenotazioni * visualizza_prenotazioni_1_svc();
#define ELIMINA_MONOPATTINO ((rpc_uint)2)
extern  int * elimina_monopattino_1();
extern  int * elimina_monopattino_1_svc();
#endif /* Old Style C */

#endif /* !_RPC_XFILE_H_RPCGEN */
