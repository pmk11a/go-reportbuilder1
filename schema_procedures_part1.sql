-- =============================================
-- DAPEN Backend - SQLite Schema
-- Stored Procedures (Generated from dbbcagroup SQL Server)
-- Total: 408 procedures
-- =============================================


-- CetakDebetNote
CREATE PROCEDURE IF NOT EXISTS CetakDebetNote AS Select  c.KodeSupp,d.NamaCustSupp,d.Alamat1,SUBSTR(a.noBukti, LENGTH(a.noBukti)-4+1)NoUrut,a.Urut,a.NoBukti,c.tanggal,Keterangan,b.NoBukti NoInv,NDPP,NPPN,NNET,Nilai,

        a.kodeVls, a.Kurs, a.NilaiRp, NNetRp

From  dbDebetNoteDet a

Left Outer Join dbDebetNote c On c.NoBukti=a.NoBukti

Left Outer Join (select a.NoBukti, SUM(NDPP) NDPP, SUM(NPPN) NPPN, SUM(NNET) NNet, SUM(NNETRp) NnetRp

                 from dbInvoiceDet a

                 Left Outer Join dbBeli b On a.NoBeli=b.noBukti

                 LEft Outer Join (Select NOBUKTI, SUM(NDPP) NDPP, SUM(NPPN) NPPN, SUM(NNET) NNet, SUM(NNETRp) NnetRp

                                  From DBBELIDET

                                  Group by NOBUKTI) C on C.NOBUKTI=B.NOBUKTI

                 Group by a.NoBukti )b On a.NoInv=b.NoBukti

Left Outer Join dbCustSupp d On d.KodeCustSupp=c.KodeSupp

where a.NoBukti=@NoBukti

order by a.NoBukti;

-- cetakhasilproduksi
CREATE PROCEDURE IF NOT EXISTS cetakhasilproduksi AS select	A.NOBUKTI, A.NOURUT, A.TANGGAL,A.KETERANGAN, B.URUT, B.KODEBRG, Br.NAMABRG, Br.NFix, B.QNT, B.NOSAT, B.SATUAN, B.ISI,

B.KodeGdg,NoSPK,c.Nama,COALESCE(A.cetakke,0) + 1 CetakN,

CS.NAMACUSTSUPP,Pr.NAMAPROJECT

from DBHasilPrd A

left outer join DBHasilPrdDET B on B.NOBUKTI=A.NOBUKTI

Left Outer Join DBSPK B1 On B1.NOBUKTI=B.NoSPK

Left Outer Join DBSO SO On SO.NOBUKTI=B1.NOSO

Left Outer Join DBCUSTSUPP CS On CS.KODECUSTSUPP=SO.KODECUST

Left Outer Join DBPROJECT PR ON PR.KODEPROJECT=SO.AlamatKirim

left outer join DBBARANG Br on Br.KODEBRG=B.KODEBRG

left outer join dbGudang  c on c.KodeGdg=b.KodeGdg

where A.NoBukti=@NoBukti

order by B.Urut;

-- CetakInspeksiGudang
CREATE PROCEDURE IF NOT EXISTS CetakInspeksiGudang AS select	A.NOBUKTI, A.NOURUT, A.TANGGAL, A.TglJatuhTempo, A.KODESUPP, Cs.NAMACUSTSUPP, 

A.HANDLING, A.KETERANGAN, A.FAKTURSUPP, A.KODEVLS, A.KURS, A.PPN, 

A.TIPEBAYAR, A.HARI, A.TipeDisc, A.DISC, A.DISCRP, A.ISCETAK, A.NilaiCetak, 

A.KodeExp, B.URUT, B.KODEBRG, Br.NAMABRG, Br.NFix, B.QNT, B.NOSAT, B.SATUAN, B.ISI, 

B.HARGA, B.DISCP, B.DISCTOT, B.BYANGKUT, B.HRGNETTO, B.NDISKON, B.SUBTOTAL, 

B.NDPP, B.NPPN, B.NNET, B.NoPO, B.UrutPO,PO.QNT QntPO, 

B.HPP, B.KodeGdg,

B.QntTerima,

case when COALESCE(B.UrutBeli,0)=0 then B.Qnt1Terima else null  Qnt1Terima,

case when COALESCE(B.UrutBeli,0)=0 then B.Qnt2Terima else null  Qnt2Terima,

B.QntReject,

case when COALESCE(B.UrutBeli,0)=0 then null else B.Qnt1Reject  Qnt1Reject,

case when COALESCE(B.UrutBeli,0)=0 then null else B.Qnt2Reject  Qnt2Reject,

Br.SAT1, Br.SAT2, COALESCE(B.UrutBeli,0) UrutBeli, B.KetReject,

case when COALESCE(B.UrutBeli,0)=0 then B.Satuan else ''  SatuanTerima,

case when COALESCE(B.UrutBeli,0)=0 then '' else B.Satuan  SatuanReject

from DBBELI A

left outer join DBBELIDET B on B.NOBUKTI=A.NOBUKTI

left outer join DBBARANG Br on Br.KODEBRG=B.KODEBRG

left outer join DBCUSTSUPP Cs on Cs.KODECUSTSUPP=A.KODESUPP

Left Outer join (Select NOBUKTI,URUT,QNT

                 from DBPODET) PO on PO.NOBUKTI=B.NoPO and PO.URUT=B.UrutPO

where A.NoBukti=@NoBukti and B.Qnt1Reject<>0

order by case when COALESCE(B.UrutBeli,0)=0 then B.Urut else B.UrutBeli , B.Urut;

-- CetakinvoicePembelian
CREATE PROCEDURE IF NOT EXISTS CetakinvoicePembelian AS Select  c.KodeSupp,d.NamaCustSupp,d.Alamat1,SUBSTR(a.noBukti, LENGTH(a.noBukti)-4+1)NoUrut,a.Urut,a.NoBukti,c.tanggal,Keterangan,b.NoBukti NoBeli,NDPP,NPPN,NNET

,NoPO,c.NoFaktur,c.TglFaktur,c.KodeVls,c.Kurs,c.PPN,c.TipeBayar,c.Hari

From  dbInvoiceDet a

Left Outer Join dbInvoice c On c.NoBukti=a.NoBukti

Left Outer Join (select a.NoBukti,Sum(NDPP)NDPP,Sum(NPPN)NPPN,Sum(NNET)NNET

                 from dbBeli a

                 Left Outer Join dbBeliDet b On a.NoBukti=b.noBukti

                 Group by a.NoBukti)b On a.NoBeli=b.NoBukti

Left Outer Join dbCustSupp d On d.KodeCustSupp=c.KodeSupp

where a.NoBukti=@NoBukti

order by a.NoBukti;

-- CetakInvoicePenjualan
CREATE PROCEDURE IF NOT EXISTS CetakInvoicePenjualan AS --select @nobukti='SJY/INVC/0913/00438'

Select A.NoBukti, A.NoUrut, A.Tanggal, A.PPN, A.Valas, A.Kurs, A.KodeCustSupp, A.Consignee, A.NotifyParty, A.StuffingDate, 

       A.StuffingPlace, H.Nobukti ContractNo, A.PONo, A.PaymentTerm, 

       A.DocCreditNo, A.PoL, A.PoD, A.NameOfVessel, A.Feeder_Vessel, A.Connect_Vessel, A.ShipOnBoardDate, A.Packing, 

       A.Others, A.IsCetak, A.IDUser, A.IsLokal, A.NoBL, A.NoteBeneficiary1, 

       A.NoteBeneficiary2, A.NoteBeneficiary3, A.ShipmentAdvice1, A.ShipmentAdvice2, A.ETADestination, A.ToShipmentAdvice2, A.NoPajak, A.TglFPJ, 

       A.Footnote, A.IssuingBank, A.MyID, 

       A.IsOtorisasi1, A.OtoUser1, A.TglOto1,

       A.IsOtorisasi2, A.OtoUser2, A.TglOto2, 

       A.IsOtorisasi3, A.OtoUser3, A.TglOto3, 

       A.IsOtorisasi4, A.OtoUser4, A.TglOto4, 

       

       A.IsOtorisasi5, A.OtoUser5, A.TglOto5,

       B.Kodebrg,B.Namabrg NamaBrgkom,

       Sum(Case when B.NOSAT=1 then B.QNT

            when B.NOSAT=2 then B.QNT2

            else 0

       ) Qty,

      (Case when B.NOSAT=1 then B.Sat_1

            when B.NOSAT=2 then B.Sat_2

            else ''

       ) Satuan,Sum(B.Qnt) Qnt, Sum(B.Qnt2) Qnt2, B.Sat_1,

       Case when B.SAT_2='' then B.SAT_1

            else B.SAT_2

         Sat_2,B.Nosat,B.Harga,

       Sum(B.NDPP) NDPP, Sum(B.NDPPRp) NDPPRp, Sum(B.NPPN) NPPN, Sum(B.NPPNRp) NPPnRp, Sum(B.NNET) Nnet, Sum(B.NNETRp) NnetRp,

       B.ShippingMark, B.KetDetail, B.NetW, B.GrossW, B.Meas,

       E.Namabrg,       

       Case when C.USAHA<>'' then C.USAHA+'. ' else '' +C.NAMACUSTSUPP NamaCustSupp,

       ltrim(C.ALAMAT1+case when ltrim(C.ALAMAT2)<>'' then char(13)+C.ALAMAT2 else '' ) Alamat,C.Kota,C.USAHA,'' NEGARA, C.TELPON, '' FAX, '' EMAIL,

       '' NoLC,

	   '' NoLCShip, '' Notify_PartyShip, '' PoLShip, 

	   '' PodShip, '' ConsigneeShip, 

	   '' Veeder_VesselShip, '' Voy_Veeder_VesselShip,

       '' Connect_VesselShip, '' Voy_Connect_VesselShip, 

	   '' ShipOnBoardShip, '' Stuffing_DateShip, 

	   '' Stuffing_PlaceShip,

	   '' Freight_TermShip, '' NotesShip,

	   Case when MONTH(A.tanggal)=1 then 'January'

	        when MONTH(A.tanggal)=2 then 'February'

	        when MONTH(A.tanggal)=3 then 'March'

	        when MONTH(A.tanggal)=4 then 'April'

	        when MONTH(A.tanggal)=5 then 'May'

	        when MONTH(A.tanggal)=6 then 'June'

	        when MONTH(A.tanggal)=7 then 'July'

	        when MONTH(A.tanggal)=8 then 'August'

	        when MONTH(A.tanggal)=9 then 'September'

	        when MONTH(A.tanggal)=10 then 'October'

	        when MONTH(A.tanggal)=11 then 'November'

	        when MONTH(A.tanggal)=12 then 'December'

	        else ''

	    Bulan, '' Ukr_Kertas, '' Trade_Term,

        Case when MONTH(A.ShipOnBoardDate)=1 then 'January'

	        when MONTH(A.ShipOnBoardDate)=2 then 'February'

	        when MONTH(A.ShipOnBoardDate)=3 then 'March'

	        when MONTH(A.ShipOnBoardDate)=4 then 'April'

	        when MONTH(A.ShipOnBoardDate)=5 then 'May'

	        when MONTH(A.ShipOnBoardDate)=6 then 'June'

	        when MONTH(A.ShipOnBoardDate)=7 then 'July'

	        when MONTH(A.ShipOnBoardDate)=8 then 'August'

	        when MONTH(A.ShipOnBoardDate)=9 then 'September'

	        when MONTH(A.ShipOnBoardDate)=10 then 'October'

	        when MONTH(A.ShipOnBoardDate)=11 then 'November'

	        when MONTH(A.ShipOnBoardDate)=12 then 'December'

	        else ''

	    BulanShipOnBoard,

        Case when MONTH(A.ETADestination)=1 then 'January'

	        when MONTH(A.ETADestination)=2 then 'February'

	        when MONTH(A.ETADestination)=3 then 'March'

	        when MONTH(A.ETADestination)=4 then 'April'

	        when MONTH(A.ETADestination)=5 then 'May'

	        when MONTH(A.ETADestination)=6 then 'June'

	        when MONTH(A.ETADestination)=7 then 'July'

	        when MONTH(A.ETADestination)=8 then 'August'

	        when MONTH(A.ETADestination)=9 then 'September'

	        when MONTH(A.ETADestination)=10 then 'October'

	        when MONTH(A.ETADestination)=11 then 'November'

	        when MONTH(A.ETADestination)=12 then 'December'

	        else ''

	    BulanETADestination, B.Urut,Case when B.Nosat=1 then E.ISI1

            when B.Nosat=2 then E.Isi2 

            else 0

        ISI,Dbo.Terbilang(m1.Tot) TerBIlang,C.KOdeBank,m2.NAMABANK

       ,H.TGLJATUHTEMPO

from dbInvoicePL A

     left outer join dbInvoicePLDet b on b.NoBukti=A.NoBukti     

     left outer join DBBARANG E on E.KODEBRG=B.KodeBrg

     left Outer join (Select x.NoBukti, x.Urut, x.NoSPP

                      from dbSPBDet x

                      Group by x.NoBukti, x.Urut, x.NoSPP) F on F.NoBukti=B.NoSPB and F.Urut=B.UrutSPB

     left outer join (Select NoBukti, NoSO

                      from dbSPPDet x

                      Group by NoBukti, NoSO) G on G.NoBukti=f.NoSPP

     left Outer join DBSO H on H.NoBukti=G.NoSo

     --left outer join vwBrowsCustomer c on c.KODECUST=A.KodeCustSupp and c.Sales=H.KODESLS

     left outer join DBCUSTSUPP c on c.KODECUSTSUPP=A.KodeCustSupp

     LEFT Outer join (select SUM(NNETRp) Tot,Nobukti from dbInvoicePLDet 

						where NoBukti=@nobukti group by NoBukti) m1 on B.NoBukti = m1.NoBukti

	 LEFT outer Join DBBANK m2 on C.KodeBank = m2.KODEBANK 

     where A.NoBukti=@nobukti

Group by A.NoBukti, A.NoUrut, A.Tanggal, A.PPN, A.Valas, A.Kurs, A.KodeCustSupp, A.Consignee, A.NotifyParty, A.StuffingDate, 

       A.StuffingPlace, A.ContractNo, A.PONo, A.PaymentTerm, 

       A.DocCreditNo, A.PoL, A.PoD, A.NameOfVessel, A.Feeder_Vessel, A.Connect_Vessel, A.ShipOnBoardDate, A.Packing, 

       A.Others, A.IsCetak, A.IDUser, A.IsLokal, A.NoBL, A.NoteBeneficiary1, 

       A.NoteBeneficiary2, A.NoteBeneficiary3, A.ShipmentAdvice1, A.ShipmentAdvice2, A.ETADestination, A.ToShipmentAdvice2, A.NoPajak, A.TglFPJ, 

       A.Footnote, A.IssuingBank, A.MyID, 

       A.IsOtorisasi1, A.OtoUser1, A.TglOto1,

       A.IsOtorisasi2, A.OtoUser2, A.TglOto2, 

       A.IsOtorisasi3, A.OtoUser3, A.TglOto3, 

       A.IsOtorisasi4, A.OtoUser4, A.TglOto4, 

       A.IsOtorisasi5, A.OtoUser5, A.TglOto5,

       B.Kodebrg,B.Namabrg,B.NOSAT, B.SAT_1,  

       B.SAT_2, B.Harga,m1.Tot,

       Case when B.Nosat=1 then E.ISI1

            when B.Nosat=2 then E.ISI2 

            else 0

       ,

       

       B.ShippingMark, B.KetDetail, B.NetW, B.GrossW, B.Meas,

       E.Namabrg,       

       Case when C.USAHA<>'' then C.USAHA+'. ' else '' +C.NAMACUSTSUPP,

       C.Alamat1, C.ALAMAT2, C.Kota, C.USAHA, C.TELPON, C.KODEPOS, B.Urut,

      

	   Case when MONTH(A.tanggal)=1 then 'January'

	        when MONTH(A.tanggal)=2 then 'February'

	        when MONTH(A.tanggal)=3 then 'March'

	        when MONTH(A.tanggal)=4 then 'April'

	        when MONTH(A.tanggal)=5 then 'May'

	        when MONTH(A.tanggal)=6 then 'June'

	        when MONTH(A.tanggal)=7 then 'July'

	        when MONTH(A.tanggal)=8 then 'August'

	        when MONTH(A.tanggal)=9 then 'September'

	        when MONTH(A.tanggal)=10 then 'October'

	        when MONTH(A.tanggal)=11 then 'November'

	        when MONTH(A.tanggal)=12 then 'December'

	        else ''

	   ,

	   Case when MONTH(A.ShipOnBoardDate)=1 then 'January'

	        when MONTH(A.ShipOnBoardDate)=2 then 'February'

	        when MONTH(A.ShipOnBoardDate)=3 then 'March'

	        when MONTH(A.ShipOnBoardDate)=4 then 'April'

	        when MONTH(A.ShipOnBoardDate)=5 then 'May'

	        when MONTH(A.ShipOnBoardDate)=6 then 'June'

	        when MONTH(A.ShipOnBoardDate)=7 then 'July'

	        when MONTH(A.ShipOnBoardDate)=8 then 'August'

	        when MONTH(A.ShipOnBoardDate)=9 then 'September'

	        when MONTH(A.ShipOnBoardDate)=10 then 'October'

	        when MONTH(A.ShipOnBoardDate)=11 then 'November'

	        when MONTH(A.ShipOnBoardDate)=12 then 'December'

	        else ''

	   ,

         Case when MONTH(A.ETADestination)=1 then 'January'

	        when MONTH(A.ETADestination)=2 then 'February'

	        when MONTH(A.ETADestination)=3 then 'March'

	        when MONTH(A.ETADestination)=4 then 'April'

	        when MONTH(A.ETADestination)=5 then 'May'

	        when MONTH(A.ETADestination)=6 then 'June'

	        when MONTH(A.ETADestination)=7 then 'July'

	        when MONTH(A.ETADestination)=8 then 'August'

	        when MONTH(A.ETADestination)=9 then 'September'

	        when MONTH(A.ETADestination)=10 then 'October'

	        when MONTH(A.ETADestination)=11 then 'November'

	        when MONTH(A.ETADestination)=12 then 'December'

	        else ''

	   , H.nobukti,C.KOdeBank,m2.NAMABANK,H.TGLJATUHTEMPO;

-- cetakKreditNote
CREATE PROCEDURE IF NOT EXISTS cetakKreditNote AS Select  c.KodeSupp,d.NamaCustSupp,d.Alamat1,SUBSTR(a.noBukti, LENGTH(a.noBukti)-4+1)NoUrut,a.Urut,a.NoBukti,c.tanggal,Keterangan,b.NoBukti NoInv,NDPP,NPPN,NNET, NNETRp,Nilai,

        a.kodeVls, a.Kurs, a.NilaiRp

From  dbKreditNoteDet a

Left Outer Join dbKreditNote c On c.NoBukti=a.NoBukti

Left Outer Join (select a.NoBukti,Sum(NDPP)NDPP, Sum(NPPN) NPPN, Sum(NNET)NNET,Sum(NNETRp)NNETRp

                 from dbInvoicePLDet a

                 Group by a.NoBukti)b On a.NoInv=b.NoBukti

Left Outer Join dbCustSupp d On d.KodeCustSupp=c.KodeSupp

where a.NoBukti=@NoBukti

order by a.NoBukti;

-- CetakLBMGudang
CREATE PROCEDURE IF NOT EXISTS CetakLBMGudang AS select A.NOBUKTI, A.NOURUT, A.TANGGAL, A.TglJatuhTempo, A.KODESUPP, Cs.NAMACUSTSUPP, 

A.HANDLING, A.KETERANGAN, A.FAKTURSUPP, A.KODEVLS, A.KURS, A.PPN, 

A.TIPEBAYAR, A.HARI, A.TipeDisc, A.DISC, A.DISCRP, A.ISCETAK, A.NilaiCetak, 

A.KodeExp,  B.KODEBRG, Br.NAMABRG, Br.NFix, Sum(B.QNT) QNT, B.NOSAT, B.SATUAN, B.ISI, 

Sum(B.NDPP) NDPP, Sum(B.NPPN) NPPN, Sum(B.NNET) NNET, B.NoPO, B.UrutPO,PO.QNT QntPO, 

Max(B.HPP) HPP, B.KodeGdg,

SuM(B.QntTerima) QntTerima,

Sum(case when COALESCE(B.UrutBeli,0)=0 then B.Qnt1Terima else null ) Qnt1Terima,

Sum(case when COALESCE(B.UrutBeli,0)=0 then B.Qnt2Terima else null ) Qnt2Terima,

Sum(B.QntReject) QntReject,

Sum(case when COALESCE(B.UrutBeli,0)=0 then null else B.Qnt1Reject ) Qnt1Reject,

Sum(case when COALESCE(B.UrutBeli,0)=0 then null else B.Qnt2Reject ) Qnt2Reject,

Br.SAT1, Br.SAT2,-- COALESCE(B.UrutBeli,0) UrutBeli, B.KetReject,

Max(case when COALESCE(B.UrutBeli,0)=0 then B.Satuan else '' ) SatuanTerima,

Max(case when COALESCE(B.UrutBeli,0)=0 then '' else B.Satuan ) SatuanReject

from DBBELI A

left outer join DBBELIDET B on B.NOBUKTI=A.NOBUKTI

left outer join DBBARANG Br on Br.KODEBRG=B.KODEBRG

left outer join DBCUSTSUPP Cs on Cs.KODECUSTSUPP=A.KODESUPP

Left Outer join (Select NOBUKTI,URUT,QNT

                 from DBPODET) PO on PO.NOBUKTI=B.NoPO and PO.URUT=B.UrutPO

where A.NoBukti=@NoBukti 

Group by A.NOBUKTI, A.NOURUT, A.TANGGAL, A.TglJatuhTempo, A.KODESUPP, Cs.NAMACUSTSUPP, 

A.HANDLING, A.KETERANGAN, A.FAKTURSUPP, A.KODEVLS, A.KURS, A.PPN, 

A.TIPEBAYAR, A.HARI, A.TipeDisc, A.DISC, A.DISCRP, A.ISCETAK, A.NilaiCetak, 

A.KodeExp, B.KODEBRG, Br.NAMABRG, Br.NFix,B.NoPO, B.UrutPO,PO.QNT, B.KodeGdg,Br.SAT1, Br.SAT2,B.NOSAT, B.SATUAN, B.ISI--,B.KetReject,B.UrutBeli

--order by case when COALESCE(B.UrutBeli,0)=0 then B.Urut else B.UrutBeli;

-- CetakOpnameBahan
CREATE PROCEDURE IF NOT EXISTS CetakOpnameBahan AS Select A.Nobukti, A.Tanggal, A.note, A.ISCetak, Urut, b.kodebrg, C.namaBrg NamaBrg, A.KodeGdg, D.Nama NamaGDG,

       case when C.sat1='PCS' then b.SaldoComp

            when C.sat2='PCS' then b.Saldo2Comp else b.SaldoComp  SaldoComp ,

       case when C.sat1='PCS' then b.QntOpname

            when C.sat2='PCS' then b.Qnt2Opname else b.QntOpname  QntOpname, b.Selisih,

       case when C.sat1='PCS' then b.Qntdb 

            when C.sat2='PCS' then b.Qnt2db else b.Qntdb  Qntdb, 

       case when C.sat1='PCS' then B.QntCr

            when C.sat2='PCS' then B.Qnt2Cr else B.QntCr  QntCr

                       , b.Harga, (b.qntdb-b.qntcr)*b.harga as Total,

       (b.qntdb)*b.harga  HrgAdi, (b.qntcr)*b.harga HrgAdo,

       case when C.sat1='PCS' then 'PCS'

            when C.sat2='PCS' then 'PCS' else C.Sat1  Satuan,C.Sat2 Satuan2,b.Saldo2Comp, b.Qnt2Opname, b.Selisih2,

       b.Qnt2db, B.Qnt2Cr,Iscek,Iscek2,NilaiCetak Ncetak,

       Case When (A.Devisi='01' or LEFT(a.NOBUKTI,1)='B') Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Nama

From dbKoreksi A 

     left outer join dbKoreksiDet B on b.nobukti=a.nobukti 

     left outer join dbBarang C on c.kodebrg=b.kodebrg 

     left outer join dbGudang D on d.kodegdg=A.kodegdg

where A.NoBukti=@NoBukti

order by B.Urut;

-- CetakPemakaianbahan
CREATE PROCEDURE IF NOT EXISTS CetakPemakaianbahan AS Select 	A.NoBukti,A.Nourut,A.Tanggal,A.Kodegdg,E.NAMA Namagdg,A.NoBPPB,

 B.urut, B.Kodebrg,a.KdDep,B1.nmDep,

 case when B.NoSat=1 then B.Qnt else B.Qnt2  Qnt,

 B.Qnt Qnt1, B.Qnt2, B.Isi, B.Nosat, B.Sat, D.NamaBrg,

 D.Isi2, D.NFix, B.UrutSPK, B.NoSatSPK,

 CAST(2 AS Numeric(18),0) Stok, CAST(2 AS Numeric(18),0) QntBppB, CAST(2 AS Numeric(18),0) QntBP, CAST(2 AS Numeric(18),0) sisa,

 COALESCE(A.CetakKe,0)+1 CetakN

From dbPenyerahanBhn A

Left Outer join dbPenyerahanBhnDet B on B.NoBukti=a.NoBukti

Left Outer Join(Select * from DBDEPART where COALESCE(isSetPass,0)=0)B1 On B1.KdDep=A.KdDep

Left Outer join dbBarang D on D.KodeBrg=B.Kodebrg

left outer join DBGUDANG E on E.KODEGDG=a.Kodegdg

where	A.NoBukti=@NoBukti

order by B.Urut;

-- CetakPenerimaan
CREATE PROCEDURE IF NOT EXISTS CetakPenerimaan AS select	A.Nobukti, A.NOURUT, A.TANGGAL, A.TglJatuhTempo, A.KODESUPP, Cs.NAMACUSTSUPP, 

A.HANDLING, A.KETERANGAN, A.FAKTURSUPP, A.KODEVLS, A.KURS, A.PPN, 

A.TIPEBAYAR, A.HARI, A.TipeDisc, A.DISC, A.DISCRP, A.ISCETAK, A.NilaiCetak, 

A.KodeExp, B.URUT, B.KODEBRG, case when COALESCE(br.IsJasa,0)=1 Then B.NamaBrg else Br.NAMABRG  NamaBrg, Br.NFix, B.QNT, B.NOSAT, B.SATUAN, B.ISI, 

B.HARGA, B.DISCP, B.DISCTOT, B.BYANGKUT, B.HRGNETTO, B.NDISKON, B.SUBTOTAL, 

B.NDPP, B.NPPN, B.NNET, B.NoPO, B.UrutPO, PO.QNT QntPO,

B.HPP, B.KodeGdg,

B.QntTerima, B.Qnt1Terima, B.Qnt2Terima,COALESCE(A.nilaiCetak,0) + 1 Ncetak

from DBBELI A

left outer join DBBELIDET B on B.NOBUKTI=A.NOBUKTI

left outer join DBBARANG Br on Br.KODEBRG=B.KODEBRG

left outer join DBCUSTSUPP Cs on Cs.KODECUSTSUPP=A.KODESUPP

Left Outer join (Select NOBUKTI,URUT,QNT

                 from DBPODET) PO on PO.NOBUKTI=B.NoPO and PO.URUT=B.UrutPO

where A.NoBukti=@NoBukti and COALESCE(B.UrutBeli,0)=0

order by B.Urut;

-- CetakPenerimaanACC
CREATE PROCEDURE IF NOT EXISTS CetakPenerimaanACC AS --select * from DBPBIAYA

select * from (

select distinct A.*,B.TotalNetto,B.TerbilangTotal from (

Select 	A.NoBukti, A.NoUrut, A.Tanggal, A.TglJatuhTempo, A.KodeSupp, C.NamaCustSupp, C.Alamat1, C.Alamat2, C.Kota,

        C.Alamat1+Char(13)+C.Alamat2+Char(13)+C.kota Alamat,

	B.KodeGdg, F.Nama, A.Handling/*, A.KodeExp, G.NamaExp*/, A.Keterangan, A.FakturSupp,

	A.KodeVls, D.NamaVls, A.Kurs, A.PPN, A.TipeBayar, A.Hari, A.TipeDisc, A.Disc, A.DiscRp,

	B.Urut, B.KodeBrg,case when E.NamaBrg='' then B.NamaBrg else E.NamaBrg  NamaBrg , B.Satuan, B.Qnt, B.NoSat, B.Isi, B.Harga, b.HrgNetto, B.DiscP, B.DiscTot,

	B.BYAngkut Beban,C.TELPON+C.Fax Telpon,

	b.NoPO,b.UrutPO,

        H.TotDiskon, H.TotDPP, H.TotPPN, H.TotNet,

        Case when A.Kodevls='IDR' then B.SubTotalRp  else B.SubTotal  Total,

        Case when A.Kodevls='IDR' then I.TotDiskonRp  else I.TotDiskon  Diskon,

        Case when A.Kodevls='IDR' then I.TotDPPRp  else I.TotDPP   TotalDPP,

        Case when A.Kodevls='IDR' then I.TotPPnRp  else I.TotPPn  TotalPPn,

        Case when A.Kodevls='IDR' then I.TotNetRp  else I.TotNet +COALESCE(A1.Nilai,0) TotalNettoA,

    COALESCE(a.NilaiCetak,0)+1 NCetak,PO.TANGGAL TglPO,

    dbo.Terbilang(COALESCE(Case when A.Kodevls='IDR' then I.TotNetRp  else I.TotNet ,0)+COALESCE(A1.Nilai,0)) TerbilangTotalA,0 NNET,0 NDPPRp,0 NPPNRp,0 NNETRp,

     PPL.KETERANGAN KetDet,Case when FX.Jumlah>=1 Then 'INVOICE PEMBELIAN BARANG'  else 'INVOICE PEMBELIAN JASA'  Judul

From dbBeli A

Left Outer join dbBeliDet B on B.NoBukti=a.NoBukti

LEFT Outer Join(select SUM(Nilai)Nilai,NoBuktiInv from DBPBIAYA Group By NoBuktiInv) A1 On A1.NoBuktiInv=A.Nobukti

Left Outer join DBPO PO on PO.NOBUKTI=b.NoPO

Left Outer Join dbCustSupp C on c.KodeCustSupp=a.KodeSupp

Left Outer join dbValas D on D.KodeVls=A.KodeVls

Left Outer join dbBarang E on E.KodeBrg=B.KodeBrg

Left Outer Join(Select COALESCE(Jumlah,0)Jumlah from(

                select COUNT(*)Jumlah from dbBeliDet a

                Left Outer Join dbBarang b on a.KODEBRG=b.KODEBRG where NOBUKTI=@NoBukti and COALESCE(IsJasa,0)=0)a)FX on 1=1

Left Outer Join dbGudang F on F.KodeGdg=B.KodeGdg

--Left Outer Join dbExpedisi G on G.KodeExp=A.KodeExp

Left Outer Join vwMasterBeli H on H.NoBukti=A.NoBukti

Left Outer Join vwRpDetBeli I on I.NoBukti=A.NoBukti

Left Outer join (Select a.NOBUKTI,a.URUT,a.QNT,b.Keterangan

                 from DBPODET a

                 Left Outer Join DBPPLDET b on a.NoPPL=b.Nobukti and a.UrutPPL=b.urut) PPL on PPL.NOBUKTI=B.NoPO and PPL.URUT=B.UrutPO

where	A.NoBukti=@NoBukti

Union ALL

select A.NoBukti, A.NoUrut, A.Tanggal, A.TglJatuhTempo, A.KodeSupp, C.NamaCustSupp, C.Alamat1, C.Alamat2, C.Kota,

        C.Alamat1+Char(13)+C.Alamat2+Char(13)+C.kota Alamat,

	'G01', 'GUDANG BCA', A.Handling/*, A.KodeExp, G.NamaExp*/, A.Keterangan, A.FakturSupp,

	A.KodeVls, D.NamaVls, A.Kurs, A.PPN, A.TipeBayar, A.Hari, A.TipeDisc, A.Disc, A.DiscRp,

	100, A1.Kodebiaya, A1.Keterangan, '', 1, Null, Null, Nilai, Nilai, Null, Null,

	Null Beban,C.TELPON+C.Fax Telpon,

	Null,Null,

        Null, Null, Null, Null,

        A1.Nilai Total,

        Null Diskon,

        i.TotDPPRp TotalDPP,

       i.TotPPNRp TotalPPn,

        i.TotNetRp+COALESCE(A1.Nilai,0) TotalNetto,

    COALESCE(a.NilaiCetak,0)+1 NCetak,Null TglPO,

    dbo.Terbilang(COALESCE(Case when A.Kodevls='IDR' then A1.Nilai  else A1.Nilai ,0)) TerbilangTotalA,Nilai,null NDPPRp,null NPPNRp,null NNETRp,''KetDet,

    Case when FX.Jumlah>=1 Then 'INVOICE PEMBELIAN BARANG' else 'INVOICE PEMBELIAN JASA'  Judul

From DBPBIAYA A1

Left Outer Join dbBeli A On A.NOBUKTI=A1.NoBuktiInv

Left Outer Join dbCustSupp C on c.KodeCustSupp=a.KodeSupp

Left Outer join dbValas D on D.KodeVls=A.KodeVls

Left Outer Join(Select COALESCE(Jumlah,0)Jumlah from(

                select COUNT(*)Jumlah from dbBeliDet a

                Left Outer Join dbBarang b on a.KODEBRG=b.KODEBRG where NOBUKTI=@NoBukti and COALESCE(IsJasa,0)=0)a)FX on 1=1

Left Outer Join vwRpDetBeli I on I.NoBukti=A.NoBukti

where A1.NoBuktiInv=@NoBukti



) A

left outer join 

(Select 	A.NoBukti, A.NoUrut, A.Tanggal, A.TglJatuhTempo, A.KodeSupp, C.NamaCustSupp, C.Alamat1, C.Alamat2, C.Kota,

        C.Alamat1+Char(13)+C.Alamat2+Char(13)+C.kota Alamat,

	B.KodeGdg, F.Nama, A.Handling/*, A.KodeExp, G.NamaExp*/, A.Keterangan, A.FakturSupp,

	A.KodeVls, D.NamaVls, A.Kurs, A.PPN, A.TipeBayar, A.Hari, A.TipeDisc, A.Disc, A.DiscRp,

	B.Urut, B.KodeBrg, case when E.NamaBrg='' then B.NamaBrg else E.NamaBrg  NamaBrg, B.Satuan, B.Qnt, B.NoSat, B.Isi, B.Harga, b.HrgNetto, B.DiscP, B.DiscTot,

	B.BYAngkut Beban,C.TELPON+C.Fax Telpon,

	b.NoPO,b.UrutPO,

        H.TotDiskon, H.TotDPP, H.TotPPN, H.TotNet,

        Case when A.Kodevls='IDR' then B.SubTotalRp  else B.SubTotal  Total,

        Case when A.Kodevls='IDR' then I.TotDiskonRp  else I.TotDiskon  Diskon,

        Case when A.Kodevls='IDR' then I.TotDPPRp  else I.TotDPP   TotalDPP,

        Case when A.Kodevls='IDR' then I.TotPPnRp  else I.TotPPn  TotalPPn,

        Case when A.Kodevls='IDR' then I.TotNetRp  else I.TotNet +COALESCE(A1.Nilai,0) TotalNetto,

    COALESCE(a.NilaiCetak,0)+1 NCetak,PO.TANGGAL TglPO,

    dbo.Terbilang(COALESCE(Case when A.Kodevls='IDR' then I.TotNetRp  else I.TotNet ,0)+COALESCE(A1.Nilai,0)) TerbilangTotal,0 NNET,0 NDPPRp,0 NPPNRp,0 NNETRp,

    PPL.KETERANGAN KetDet

From dbBeli A

Left Outer join dbBeliDet B on B.NoBukti=a.NoBukti

LEFT Outer Join(select SUM(Nilai)Nilai,NoBuktiInv from DBPBIAYA Group By NoBuktiInv) A1 On A1.NoBuktiInv=A.Nobukti

Left Outer join DBPO PO on PO.NOBUKTI=b.NoPO

Left Outer Join dbCustSupp C on c.KodeCustSupp=a.KodeSupp

Left Outer join dbValas D on D.KodeVls=A.KodeVls

Left Outer join dbBarang E on E.KodeBrg=B.KodeBrg

Left Outer Join dbGudang F on F.KodeGdg=B.KodeGdg

--Left Outer Join dbExpedisi G on G.KodeExp=A.KodeExp

Left Outer Join vwMasterBeli H on H.NoBukti=A.NoBukti

Left Outer Join vwRpDetBeli I on I.NoBukti=A.NoBukti

Left Outer join (Select a.NOBUKTI,a.URUT,a.QNT,b.Keterangan

                 from DBPODET a

                 Left Outer Join DBPPLDET b on a.NoPPL=b.Nobukti and a.UrutPPL=b.urut) PPL on PPL.NOBUKTI=B.NoPO and PPL.URUT=B.UrutPO

where	A.NoBukti=@NoBukti

) B on B.NOBUKTI=A.NOBUKTI

) C order by URUT;

-- CetakPenerimaangudang
CREATE PROCEDURE IF NOT EXISTS CetakPenerimaangudang AS --select @NoBukti='bca/lpb/0719/0109'

select * from (

select distinct A.*,B.TotalNetto,B.TerbilangTotal from (

Select 	A.NoBukti, A.NoUrut, A.Tanggal, A.TglJatuhTempo, A.KodeSupp, C.NamaCustSupp, C.Alamat1, C.Alamat2, C.Kota,

        C.Alamat1+Char(13)+C.Alamat2+Char(13)+C.kota Alamat,

	B.KodeGdg, F.Nama, A.Handling/*, A.KodeExp, G.NamaExp*/, A.Keterangan, A.FakturSupp,

	A.KodeVls, D.NamaVls, A.Kurs, A.PPN, A.TipeBayar, A.Hari, A.TipeDisc, A.Disc, A.DiscRp,

	B.Urut, B.KodeBrg, case when E.NamaBrg='' then B.NamaBrg else E.NamaBrg  NamaBrg, B.Satuan, B.Qnt, B.NoSat, B.Isi, B.Harga, b.HrgNetto, B.DiscP, B.DiscTot,

	B.BYAngkut Beban,C.TELPON+C.Fax Telpon,

	b.NoPO,b.UrutPO,

        H.TotDiskon, H.TotDPP, H.TotPPN, H.TotNet,

        Case when A.Kodevls='IDR' then B.SubTotalRp  else B.SubTotal  Total,

        Case when A.Kodevls='IDR' then I.TotDiskonRp  else I.TotDiskon  Diskon,

        Case when A.Kodevls='IDR' then I.TotDPPRp  else I.TotDPP  TotalDPP,

        Case when A.Kodevls='IDR' then I.TotPPnRp  else I.TotPPn  ToPPN,

        Case when A.Kodevls='IDR' then I.TotNetRp  else I.TotNet +COALESCE(A1.Nilai,0) TotalNettoA,

    COALESCE(a.NilaiCetak,0)+1 NCetak,PO.TANGGAL TglPO,

    dbo.Terbilang(COALESCE(Case when A.Kodevls='IDR' then I.TotNetRp  else I.TotNet ,0)+COALESCE(A1.Nilai,0)) TerbilangTotalA,

    0 NNET,0 NDPPRp,

    0 NPPNRp,0 NNETRp,

    PPL.KETERANGAN KetDet,Case when FX.Jumlah>=1 Then 'SURAT PENERIMAAN BARANG' else 'SURAT PENERIMAAN JASA'  Judul

From dbBeli A

Left Outer join dbBeliDet B on B.NoBukti=a.NoBukti

LEFT Outer Join(select SUM(Nilai)Nilai,NoBuktiInv from DBPBIAYA Group By NoBuktiInv) A1 On A1.NoBuktiInv=A.Nobukti

Left Outer join DBPO PO on PO.NOBUKTI=b.NoPO

Left Outer Join dbCustSupp C on c.KodeCustSupp=a.KodeSupp

Left Outer join dbValas D on D.KodeVls=A.KodeVls

Left Outer join dbBarang E on E.KodeBrg=B.KodeBrg

Left Outer Join dbGudang F on F.KodeGdg=B.KodeGdg

Left Outer Join(Select COALESCE(Jumlah,0)Jumlah from(

                select COUNT(*)Jumlah from dbBeliDet a

                Left Outer Join dbBarang b on a.KODEBRG=b.KODEBRG where NOBUKTI=@NoBukti and COALESCE(IsJasa,0)=0)a)FX on 1=1

--Left Outer Join dbExpedisi G on G.KodeExp=A.KodeExp

Left Outer Join vwMasterBeli H on H.NoBukti=A.NoBukti

Left Outer Join vwRpDetBeli I on I.NoBukti=A.NoBukti

Left Outer join (Select a.NOBUKTI,a.URUT,a.QNT,b.Keterangan

                 from DBPODET a

                 Left Outer Join DBPPLDET b on a.NoPPL=b.Nobukti and a.UrutPPL=b.urut) PPL on PPL.NOBUKTI=B.NoPO and PPL.URUT=B.UrutPO

where	A.NoBukti=@NoBukti

Union ALL

select A.NoBukti, A.NoUrut, A.Tanggal, A.TglJatuhTempo, A.KodeSupp, C.NamaCustSupp, C.Alamat1, C.Alamat2, C.Kota,

        C.Alamat1+Char(13)+C.Alamat2+Char(13)+C.kota Alamat,

	'', '', A.Handling/*, A.KodeExp, G.NamaExp*/, A.Keterangan, A.FakturSupp,

	A.KodeVls, D.NamaVls, A.Kurs, A.PPN, A.TipeBayar, A.Hari, A.TipeDisc, A.Disc, A.DiscRp,

	100, A1.Kodebiaya, A1.Keterangan, '', 1, Null, Null, Nilai, Nilai, Null, Null,

	Null Beban,C.TELPON+C.Fax Telpon,

	Null,Null,

        Null, Null, Null, Null,

        A1.Nilai Total,

        Null Diskon,

        i.TotDPPRp TotalDPP,

        i.TotPPNRp TotalPPn,

        i.TotNetRp+COALESCE(A1.Nilai,0) TotalNetto,

    COALESCE(a.NilaiCetak,0)+1 NCetak,Null TglPO,

    dbo.Terbilang(COALESCE(Case when A.Kodevls='IDR' then A1.Nilai  else A1.Nilai ,0)) TerbilangTotalA,Nilai,null NDPPRp,null NPPNRp,null NNETRp,null,

    Case when FX.Jumlah>=1 Then 'SURAT PENERIMAAN BARANG' else 'SURAT PENERIMAAN JASA'  Judul

From DBPBIAYA A1

Left Outer Join dbBeli A On A.NOBUKTI=A1.NoBuktiInv

Left Outer Join dbCustSupp C on c.KodeCustSupp=a.KodeSupp

Left Outer Join(Select COALESCE(Jumlah,0)Jumlah from(

                select COUNT(*)Jumlah from dbBeliDet a

                Left Outer Join dbBarang b on a.KODEBRG=b.KODEBRG where NOBUKTI=@NoBukti and COALESCE(IsJasa,0)=0)a)FX on 1=1

Left Outer join dbValas D on D.KodeVls=A.KodeVls

Left Outer Join vwRpDetBeli I on I.NoBukti=A.NoBukti

where A1.NoBuktiInv=@NoBukti



) A 

left outer join



(Select 	A.NoBukti, A.NoUrut, A.Tanggal, A.TglJatuhTempo, A.KodeSupp, C.NamaCustSupp, C.Alamat1, C.Alamat2, C.Kota,

        C.Alamat1+Char(13)+C.Alamat2+Char(13)+C.kota Alamat,

	B.KodeGdg, F.Nama, A.Handling/*, A.KodeExp, G.NamaExp*/, A.Keterangan, A.FakturSupp,

	A.KodeVls, D.NamaVls, A.Kurs, A.PPN, A.TipeBayar, A.Hari, A.TipeDisc, A.Disc, A.DiscRp,

	B.Urut, B.KodeBrg, case when E.NamaBrg='' then B.NamaBrg else E.NamaBrg  NamaBrg, B.Satuan, B.Qnt, B.NoSat, B.Isi, B.Harga, b.HrgNetto, B.DiscP, B.DiscTot,

	B.BYAngkut Beban,C.TELPON+C.Fax Telpon,

	b.NoPO,b.UrutPO,

        H.TotDiskon, H.TotDPP, H.TotPPN, H.TotNet,

        Case when A.Kodevls='IDR' then B.SubTotalRp  else B.SubTotal  Total,

        Case when A.Kodevls='IDR' then I.TotDiskonRp  else I.TotDiskon  Diskon,

        Case when A.Kodevls='IDR' then I.TotDPPRp  else I.TotDPP  TotalDPP,

        Case when A.Kodevls='IDR' then I.TotPPnRp  else I.TotPPn  ToPPn ,

        Case when A.Kodevls='IDR' then I.TotNetRp  else I.TotNet +COALESCE(A1.Nilai,0) TotalNetto,

    COALESCE(a.NilaiCetak,0)+1 NCetak,PO.TANGGAL TglPO,

    dbo.Terbilang(COALESCE(Case when A.Kodevls='IDR' then I.TotNetRp  else I.TotNet ,0)+COALESCE(A1.Nilai,0)) TerbilangTotal,

    0 NNET,0 NDPPRp,

    0 NPPNRp,0 NNETRp,

    PPL.KETERANGAN KetDet

From dbBeli A

Left Outer join dbBeliDet B on B.NoBukti=a.NoBukti

LEFT Outer Join(select SUM(Nilai)Nilai,NoBuktiInv from DBPBIAYA Group By NoBuktiInv) A1 On A1.NoBuktiInv=A.Nobukti

Left Outer join DBPO PO on PO.NOBUKTI=b.NoPO

Left Outer Join dbCustSupp C on c.KodeCustSupp=a.KodeSupp

Left Outer join dbValas D on D.KodeVls=A.KodeVls

Left Outer join dbBarang E on E.KodeBrg=B.KodeBrg

Left Outer Join dbGudang F on F.KodeGdg=B.KodeGdg

--Left Outer Join dbExpedisi G on G.KodeExp=A.KodeExp

Left Outer Join vwMasterBeli H on H.NoBukti=A.NoBukti

Left Outer Join vwRpDetBeli I on I.NoBukti=A.NoBukti

Left Outer join (Select a.NOBUKTI,a.URUT,a.QNT,b.Keterangan

                 from DBPODET a

                 Left Outer Join DBPPLDET b on a.NoPPL=b.Nobukti and a.UrutPPL=b.urut) PPL on PPL.NOBUKTI=B.NoPO and PPL.URUT=B.UrutPO

where	A.NoBukti=@NoBukti

) B on B.NOBUKTI=a.NOBUKTI

) C order by URUT;

-- CetakPenyerahanbarang
CREATE PROCEDURE IF NOT EXISTS CetakPenyerahanbarang AS select	A.NOBUKTI, A.NOURUT, A.TANGGAL, A.KDDEP, Dp.NMDEP, A.KodeGdg, A.KodeGdgT, A.NoBPPB,

B.UrutBPPB, B.NoSatBPPB, B.URUT, B.KODEBRG, Br.NAMABRG, Br.NFix,

case when B.NoSat=1 then B.Qnt else B.Qnt2  QNT,

B.Qnt Qnt1, B.NOSAT, B.SATUAN, B.ISI, B.Qnt2, B.Qnt2M, B.Qnt2P,

COALESCE(A.cetakke,0) + 1 cetakN

from DBBPPBT A

left outer join DBBPPBTDET B on B.NOBUKTI=A.NOBUKTI

left outer join DBBARANG Br on Br.KODEBRG=B.KODEBRG

left outer join DBDEPART Dp on Dp.KDDEP=A.KDDEP and COALESCE(DP.isSetPass,0)=0

where A.NOBUKTI=@NoBukti

order by B.Urut;

-- CetakPerintahKirim
CREATE PROCEDURE IF NOT EXISTS CetakPerintahKirim AS select a.NoBukti,a.NoSO NoSC,b.NoPesan,b.Tanggal,a.KodeBrg,d.NAMABRG namabrgdbbrg ,a.NamaBrg namabrgdbdet ,''Jns_Kertas,''Ukr_Kertas,

       c.NamaCust NAMACUSTSUPP,c.Alamat,'' ALAMAT1,''ALAMAT2,''ALAMATPKP1,'' ALAMATPKP2,c.kodekota Kota,

       case when a.NOSAT = 1 then a.SAT_1 else a.SAT_2  satuan,

       case when a.NOSAT = 1 then a.QNT else a.QNT2  QNT,

       b.TglKirim,'' ShippingMark,b.NoLC,b.Packing,b.Catatan, a.Urut

from 

dbSPPDet a 

left outer join dbSPP b on a.NoBukti = b.NoBukti

Left Outer Join vwOutSO_SPP E on E.Nobukti=a.NoSO and E.urut=a.UrutSO

Left Outer join DBSO G on G.Nobukti=A.NoSO

left outer join vwBrowsCustomer c on b.KodeCustSupp = c.KODECUST and c.Sales=G.KODESLS

left outer join DBBARANG d on a.KodeBrg = d.KODEBRG

where A.NoBukti=@nobukti;

-- CetakpermintaanBahan
CREATE PROCEDURE IF NOT EXISTS CetakpermintaanBahan AS select	A.NOBUKTI, A.NOURUT, A.TANGGAL, A.KDDEP, Dp.NMDEP , A.KodeGdg, A.KodeGdgT, 

B.URUT, B.KODEBRG, Br.NAMABRG, Br.NFix,

case when B.NoSat=1 then B.Qnt else B.Qnt2  QNT,

B.Qnt Qnt1, B.NOSAT, B.SATUAN, B.ISI, B.Qnt2, B.Qnt2M, B.Qnt2P,

COALESCE(A.cetakke,0) + 1 CetakN

from DBBPPB A

left outer join DBBPPBDET B on B.NOBUKTI=A.NOBUKTI

left outer join DBBARANG Br on Br.KODEBRG=B.KODEBRG

left outer join DBDEPART Dp on Dp.KDDEP=A.KDDEP

where A.NOBUKTI=@NoBukti

order by B.Urut;

-- CetakPR
CREATE PROCEDURE IF NOT EXISTS CetakPR AS --select 	@NoBukti=''

Select 	A.*,B.*, Case When COALESCE(B.NamaBrg,'')='' Then D.Namabrg else B.NamaBrg  NamaBrgX, C.NMDep,D.KOdeBrg,A.cetakke + 1 CetakN,

PO.NOBUKTI NoPO

From dbPPL A

Left Outer join dbPPLDet B on B.NoBukti=a.NoBukti

Left Outer Join (select NOBUKTI,NOPPL,KODEBRG from DBPODET Group by NOBUKTI,NOPPL,KODEBRG)PO On PO.NoPPL=B.Nobukti and PO.KODEBRG=B.kodebrg

Left Outer join dbBarang D on D.KodeBrg=B.Kodebrg

Left Outer join dbDepart C on C.KdDep=A.KDDep

where	A.NoBukti=@NoBukti

order by B.Urut;

-- CetakProsesBuatSPB
CREATE PROCEDURE IF NOT EXISTS CetakProsesBuatSPB AS Select 	A.NoBukti, A.NOURUT, A.Tanggal, A.KodecustSupp KodeCUST, C.NamaCUST, C.Alamat, J.Alamat AlamatKirim, 

	B.KodeGdg, A.Catatan, 

	B.Urut, B.UrutSO, B.KodeBrg, H.NamaBrg, B.Qnt Qnt1, 

	Case when B.Nosat=1 then B.Qnt when B.Nosat=2 then B.Qnt2 else 0  Qnt,

	Case when B.Nosat=1 then H.Sat1 when B.Nosat=2 then H.Sat2 else ''   Satuan, 

 B.Qnt2, H.Sat2 SatuanRoll,  

	case when B.Qnt2=0 then B.Qnt else B.Qnt2  QntTampil, 

	case when B.Qnt2=0 then H.Sat1 else H.Sat2  SatuanTampil

From dbSPP A 

Left Outer join dbSPPDet B on B.NoBukti=a.NoBukti 

Left Outer join dbSO SO on SO.Nobukti=B.Noso

Left Outer Join vwBrowsCustomer C on c.KodeCust=a.KodeCustsupp and c.Sales=SO.Kodesls 

left outer join dbKaryawan F on F.KeyNik=SO.KodeSls 

Left Outer Join vwSatuanBrg H on H.KodeBrg=B.KodeBrg 

left outer join vwAlamatCust J on J.KodeCustSupp=A.KodeCustSupp and J.Nomor=A.NoAlamatKirim 

where A.NoBukti in (@Nobukti)

order by A.NoBukti, B.Urut;

-- CetakRevisiPO
CREATE PROCEDURE IF NOT EXISTS CetakRevisiPO AS --select 	@NoBukti='VSM/052009/00001/PO '

Select 	A.NoBukti, A.NoUrut, A.Tanggal, A.TglJatuhTempo, A.KodeSupp, C.NamaCustSupp, C.Alamat1, C.Alamat2, C.Kota,

        C.Alamat1+Char(13)+C.Alamat2+Char(13)+C.kota Alamat,

	A.Handling, A.Keterangan, A.FakturSupp,IsExp,J.Tanggal TglKirim,

	A.KodeVls, D.NamaVls, A.Kurs, A.PPN, A.TipeBayar, A.Hari, A.Disc,

	B.Urut, B.KodeBrg, E.NamaBrg, B.Satuan, B.Qnt, B.Nosat, B.Isi,

        B.Harga, B.DISCP, B.DISCTOT,NoPPL,A.IsClose,B.IsClose IsCloseD,

        case when A.Kurs=1 then 0.0 else B.SubTotal  TotalUSD,a.KodeExp,F.NamaExp,

	round(B.SubTotal*A.Kurs,2) TotalIDR, round(B.NDPP*A.Kurs,2) NDPP,

        round(B.NPPN*A.Kurs,2) NPPN,COALESCE(B.Tolerate,0) Tolerate,

	B.BYAngkut Beban,

	round(B.SubTotal*A.Kurs,2) + B.BYAngkut Total,

        H.TotDiskon, H.TotDPP, H.TotPPN, H.TotNet

From dbPO A

Left Outer join dbPODet B on B.NoBukti=a.NoBukti

Left Outer Join dbCustSupp C on c.KodeCustSupp=a.KodeSupp

Left Outer join dbValas D on D.KodeVls=A.KodeVls

Left Outer join dbBarang E on E.KodeBrg=B.KodeBrg

Left Outer join dbExpedisi F On F.KodeExp=A.KodeExp

Left Outer Join vwMasterPO H on H.NoBukti=A.NoBukti

Left Outer Join (select NoBukti,KodeBrg,Max(Tanggal)Tanggal from DBKirimDET group By NoBukti,KodeBrg) J On J.KodeBrg=B.KodeBrg and J.NoBukti=B.NoBukti

where	A.NoBukti=@NoBukti

order by B.Urut;

-- CetakRPemakaianbahan
CREATE PROCEDURE IF NOT EXISTS CetakRPemakaianbahan AS Select 	d.Isi2,d.Nfix,A.NoBukti,A.Nourut,A.Tanggal,A.Kodegdg,A.NoPenyerahanBhn,B.urut,B.Kodebrg,B.Qnt,Qnt2,B.Isi,B.Nosat,B.Sat,D.NamaBrg,CAST(2 AS Numeric(18),0) Stok,CAST(2 AS Numeric(18),0) Stok2,CAST(2 AS Numeric(18),0) QntBP,CAST(2 AS Numeric(18),0) Qnt2BP

,CAST(2 AS Numeric(18),0) QntRBP,CAST(2 AS Numeric(18),0) Qnt2RBP,CAST(2 AS Numeric(18),0) sisa

From dbRPenyerahanBhn A

Left Outer join dbRPenyerahanBhnDet B on B.NoBukti=a.NoBukti

Left Outer join dbBarang D on D.KodeBrg=B.Kodebrg

where	A.NoBukti=@NoBukti

order by B.Urut;

-- CetakRpenjualaninvoice
CREATE PROCEDURE IF NOT EXISTS CetakRpenjualaninvoice AS --select @nobukti='bcb/rinvc/0518/00001'

/*Select Left(A.NOBUKTI,4)+'-INV'+SUBSTR(A.NOBUKTI, LENGTH(A.NOBUKTI)-11+1)NoBukti, A.TANGGAL, B.NamaBrg,'' Ukr_Kertas,0.00 GSM, d.NoSO, d.TglSO, A.NoLKP, A.TGLLKP,

       d.NoSPB,d.Tanggal TglSPB, A.KODECUSTSUPP, C.NamaCust NAMACUSTSUPP, null TglRencanaPenarikan, null TglPengesahan,

       F.NoBukti NoSPR, F.Tanggal TglSPR, B.URUT, 

       Case when B.Nosat=1 then B.QNT

            when B.Nosat=2 then B.QNT2

            else 0

        QntRPJ,

       Case when B.Nosat=1 then B.SAT_1

            when B.Nosat=2 then B.SAT_2

            else ''

        SatRPJ,

       Case when F.Nosat=1 then F.QNT

            when F.Nosat=2 then F.QNT2

            else 0

        QntSPR,

       Case when F.Nosat=1 then F.SAT_1

            when F.Nosat=2 then F.SAT_2

            else ''

        SatSPR

From DBRInvoicePL A

     left outer join DBRInvoicePLDET B on B.NOBUKTI=A.NOBUKTI        

     left outer join (Select x0.NoBukti, x0.Urut, z.Tanggal, z.NoBukti NoSPB, x1.KODESLS, x1.KODECUST,x1.NOBUKTI NoSO,x1.TANGGAL tglSO

                      from dbInvoicePLDet x0

                           left outer join dbSPBDet y on y.NoBukti=x0.Nospb and y.Urut=x0.UrutSPB

                           left outer join dbSPB z on z.NoBukti=y.NoBukti

                           left outer join dbSPPDet x on x.NoBukti=y.NoSPP and x.Urut=y.UrutSPP

                           left Outer join DBSO x1 on x1.NOBUKTI=x.NoSO

                           ) d on d.NoBukti=B.NoInvoice and d.Urut=B.UrutInvoice --and d.NoSPB=B.NoSPB

     left outer join DBBARANG E on E.KODEBRG=B.KODEBRG

     left outer join (Select x.NoBukti,x.Tanggal, y.NoRPJ, y.UrutRPJ, y.QNT, y.QNT2, y.SAT_1, y.SAT_2, y.NOSAT

                      from dbSPBRJual x

                           left outer join dbSPBRJualDet y on y.NoBukti=x.NoBukti) F on F.NoRPJ=b.NOBUKTI and F.UrutRPJ=B.URUT

     left outer join vwBrowsCustomer C on C.KODECUST=A.KODECUSTSUPP and C.Sales=d.KODESLS

where A.NOBUKTI=@nobukti

*/

select Left(A.NOBUKTI,4)+'RINV'+SUBSTR(A.NOBUKTI, LENGTH(A.NOBUKTI)-11+1) NoBukti,COALESCE(A1.Noinv,'')NoInv, A.Tanggal, A.KodeCustSupp,c.telpon,

	     Case when C.USAHA<>'' then C.USAHA+'. ' else '' + C.NAMACUSTSUPP NamaCustSupp, C.ALAMAT,A.PPN, 

		0 Urut, 0 UrutTrans, '' NoSPB, 0 UrutSPB, B.KodeBrg, D.NamaBrg, case when b.Nosat=1 then Sum(B.QNT) else Sum(B.QNT2)  Qnt, --S.QNT1, S.QNT2, 

		case when b.Nosat=1 then B.SAT_1 else b.SAT_2  SATUAN, D.SAT1, D.SAT2,

		B.NOSAT, B.ISI, B.NetW, B.GrossW, B.HARGA, 

		B.DISCTOT, B.HrgNetto, 

		B.NDISKON, Sum(B.SUBTOTAL+COALESCE(SO.BYANGKUT,0)) SUBTOTAL, Round(Sum(Case When COALESCE(A.FRetensi,0)<>0 Then B.NDPPRRp else B.NDPP +COALESCE(SO.BYANGKUT,0)),1) NDPP, Sum(B.NDPP+COALESCE(SO.BYANGKUT,0))DPP, Sum(B.NPPN)NPPN, Sum(B.NNET+COALESCE(SO.BYANGKUT,0))NNET, 

		Sum(B.SUBTOTALRp+COALESCE(SO.BYANGKUT,0))SUBTOTALRp, Sum(B.NDPPRp+COALESCE(SO.BYANGKUT,0))NDPPRp, Sum(B.NPPNRp)NPPNRp, Sum(B.NNETRp+COALESCE(SO.BYANGKUT,0))NNETRp,

		P.NAMA NamaPersh, P.KOTA KotaPersh,Bk.NAMABANK,Bk.KODEBANK,Bk.Nama,COALESCE(A.RDP,0)DP,case when COALESCE(a.islokal,0)=0 Then 'ALAM MONANDAR' else 'HENDRIK RAO'  NamaTTD,

		case when COALESCE(IsLokal,0)=0 Then 'Direktur' else 'Direktur'  Jabatan,SO.Hari ,

		SUM(B.NDPPRp)-(COALESCE(A.RDP,0))+Case when A.PPN=0 Then 0 else (SUM(B.NDPPRp)-(COALESCE(A.RDP,0)))*b.NilaiPPN  TotalRp,

		dbo.Terbilang(SUM(B.NDPPRp)-(COALESCE(A.RDP,0))+Case when A.PPN=0 Then 0 else (SUM(B.NDPPRp)-(COALESCE(A.RDP,0)))*b.NilaiPPN )MyTerbilang,

		A.Tanggal+SO.HARI JatuhTempo,h.ALAMATPROJECT,'' UntukPembayaran, Bk.NAMABANK NamaBank,Bk.NAMA Pemilik, A1.KodeBank NoBank

		

		,Sum(B.SUBTOTAL) SUBTOTAL,

       Case When A.Devisi='01' Then 'PT. BETON CITRA ABADI' else 'PT. CALVARY ABADI'  NamaDevisi,b.NilaiPPN,CAST(CAST(b.NilaiPPN*100 AS TINYINT AS TEXT))+'%' pajak

	,

	 CAST(CAST(COALESCE(a.FRetensi,0 AS TINYINT AS TEXT)))+'%' Retensi,COALESCE(a.FRetensi,0)/100*Sum(B.NDPP)TRetensi 

	from DBRInvoicePL A 

	Left Outer Join DBRInvoicePLDET B on A.NoBukti=B.NoBukti

	Left Outer Join (Select A.NoBukti,B.NoSO,IsTTD,DP,NoInv,KodeBank from dbInvoicePL A

	                 Left Outer Join dbInvoicePLDet B On A.NoBukti=B.NoBukti

	                 Group by A.NoBukti,IsTTD,DP,NoInv,KodeBank,NoSO)A1 on A1.NoBukti=B.NoInvoice

	left outer join vwCUSTSUPP C on C.KODECUSTSUPP = A.KodeCustSupp

	left outer join DBBARANG D on D.KODEBRG = B.KodeBrg

	left outer join DBPERUSAHAAN P on 1=1

	left outer join DBBANK Bk on Bk.KodeBank=A1.KodeBank

	left outer join dbSPBDet S on S.NoBukti=B.NoSPB and S.KodeBrg=B.KODEBRG

	LEFT Outer Join (select a.NOBUKTI,HARI,SUM(COALESCE(0,0))BYANGKUT,AlamatKirim from DBSODET a Left Outer Join dbSO b On a.NOBUKTI=b.NOBUKTI Group by a.NOBUKTI,HARI,AlamatKirim)SO on SO.NOBUKTI=A1.NoSO

    left outer join DBPROJECT H on h.KODEPROJECT=so.AlamatKirim

	where A.NoBukti = @nobukti

	Group by A.Devisi,A.NoBukti, A.Tanggal, A.KodeCustSupp, C.NAMACUSTSUPP, C.ALAMAT,A.PPN,  B.KodeBrg, D.NamaBrg,c.telpon,h.ALAMATPROJECT,

	B.SAT_1 , D.SAT1, D.SAT2,

		B.NOSAT, B.ISI, B.NetW, B.GrossW,  B.HARGA,  

		B.DISCTOT, B.HrgNetto, COALESCE(a.FRetensi,0), 

		B.NDISKON, 

		P.NAMA , P.KOTA,Bk.NAMABANK,Bk.KODEBANK,A.RDP,COALESCE(IsLokal,0),Bk.Nama,A1.Noinv,SO.HARI,c.USAHA,b.SAT_2,A1.KodeBank,b.NilaiPPN

	order by Kodebrg,Max(B.Urut);

-- CetakRSPB
CREATE PROCEDURE IF NOT EXISTS CetakRSPB AS select A.NOBUKTI, A.NOURUT, A.TANGGAL, A.KODECUSTSUPP, 

       Case when D.USAHA<>'' then D.USAHA+'. ' else '' +D.NamaCust NamaCustSupp, 

       D.Alamat, D.NamaKota Kota, '' NEGARA,

        A0.NoSPP,A0.NoBukti NoSPB, A.NoPolKend,A.KodeGdg,

        A.Container, A.NoContainer, A.NoSeal,

        A.ISCETAK, A.IDUser,

        B.URUT, B.KODEBRG, C.Namabrg, '' Jns_Kertas,'' Ukr_Kertas, case when B.ISI>=1 Then B.QNT Else B.QNT2  QNT, case when B.ISI>=1 Then B.QNT2 Else B.QNT  QNT2, case when B.ISI>=1 Then B.SAT_1 Else B.SAT_2  SAT_1, case when B.ISI>=1 Then B.SAT_2 Else B.SAT_1  SAT_2, B.NoSat, B.ISI,

        E.NoSO,E.TglSO,E.NOPO NoPesanan, A1.NamaKirim, A1.AlamatKirim,a.catatan,

        (Select NOSPB from DBNOMOR) NODOK, B.Namabrg NamaBrgkom,

         case when B.NOSAT = 1 then b.SAT_1 else b.SAT_2  as satuanas,

         case when B.NOSAT = 1 then B.QNT else b.QNT2  as QNTAS,

        A.Catatan, b.NetW, b.GrossW, A0.sopir,A.NoPolKend,A3.NAMAPROJECT,

        Case When c.ISI2>c.ISI1 Then c.SAT1 when c.ISI2=c.ISI1 Then c.SAT1 else c.SAT2  SA_1,Case When c.ISI2<c.ISI1 Then c.SAT1 WHEN c.ISI2=c.ISI1 Then c.SAT2 else c.SAT2  SA_2

From DBRSPB A

left outer join dbSPB A0 on a.NoSPB = a0.NoBukti

left outer join dbSPP A1 on A1.NoBukti=A0.NoSPP

Left Outer Join DBPROJECT A3 on A3.KODEPROJECT=A0.NoResi

Left Outer Join (Select Nobukti, NoSO from dbSPPDet Group by NoBukti,NoSO) A2 on A2.NoBukti=A1.nobukti

Left Outer Join DBRSPBDET B on B.NoBukti=A.NoBukti

Left Outer Join dbBarang c On C.KodeBrg=B.KodeBrg

Left Outer Join vwBrowsCustomer D On D.KodeCust=A.KodeCustSupp

Left Outer join (Select y.Nobukti NoSO,y.Tanggal TglSO, y.NoPesanan Nopo

                 from DBSO y

                 group by y.Nobukti,y.Tanggal, y.NoPesanan) E on E.NoSO=A2.NoSo

where A.NoBukti =@Nobukti;

-- CetakRSPBLampiran
CREATE PROCEDURE IF NOT EXISTS CetakRSPBLampiran AS Select Case when A.NOROLL<>'' then A.NOROLL+' ' else '' +

       Case when A.NOPALLET<>'' then A.NOPALLET+' ' else '' + 

       Case when A.NOLOT<>'' then A.NOLOT+' ' else ''        

        NoLot, 

       B.Namabrg NamaBrgKom, C.Jns_Kertas, C.Ukr_Kertas, C.GSM,

       A.Qnt,A.Qnt2, A.Sat_1, A.Sat_2, A.NetW, A.GrossW, A.Keterangan,

       B.NoBukti,B.Tanggal, B.NoPolKend, B.NoContainer, B.NoSeal, A.Urut, A.UrutSPB,

       Case when A.Nosat=1 then a.Qnt

            when a.Nosat=2 then a.Qnt2

            else 0

        Qty,

       Case when A.Nosat=1 then a.Sat_1

            when a.Nosat=2 then a.Sat_2

            else ''

        Satuan,

       (Select NoSPB from dbnomor) NODok

From dbSPBLampiran A

     left Outer join (Select y.NoBukti, Y.Tanggal, y.NoContainer, y.NoPolKend, y.NoSeal,

                             x.Urut, x.KodeBrg, x.Namabrg

                      from dbRSPBDet x

                           left Outer join dbSPB y on y.NoBukti=x.NoBukti

                      ) B on B.NoBukti=A.NoSPB and B.Urut=A.UrutSPB

     left Outer join (Select kodebrg, namabrg, SAT1, Sat2, '' Jns_Kertas, '' Ukr_Kertas, 0.00 GSM from DBBARANG) C on C.KODEBRG=B.KodeBrg;

-- CetakSPK
CREATE PROCEDURE IF NOT EXISTS CetakSPK AS Select 	B.urut,A.NoBukti, A.NoBatch, A.TglExpired, A.tanggal,SUBSTR(A.NoBukti, LENGTH(A.NoBukti)-4+1) NoUrut,

A.KodeBrg BrgJ,A.Qnt QntJ,A.Nosat NosatJ, A.Isi IsiJ,

case when a.Nosat=1 then E.SAT1

     when a.nosat=2 then E.SAT2  SATJ,

B.KodeBrg ,B.Qnt-COALESCE(B.QntBatal,0)Qnt,B.Satuan,B.isi,B.Nosat,E.NamaBrg NamaBrgJ,D.NamaBrg NamaBrgDet,C.QNT Qntdet,

COALESCE(A.Cetakke,0)+1 CetakN,

CS.NAMACUSTSUPP,Pr.NAMAPROJECT,A.NOSO

From dbSPK A

Left Outer join DBSPKMDET B on B.NoBukti=a.NoBukti

Left Outer Join DBSPKDET C On C.NOBUKTI=B.NOBUKTI and C.UrutM=B.URUT

LEFT Outer Join DBSO SO on SO.NOBUKTI=A.NOSO

LEFT Outer JOIn DBCUSTSUPP CS ON CS.KODECUSTSUPP=SO.KODECUST

Left Outer Join DBPROJECT Pr On Pr.KODEPROJECT=SO.AlamatKirim

Left Outer join dbBarang E on E.KodeBrg=B.Kodebrg

Left Outer Join DBBARANG D On D.KODEBRG=C.KODEBRG

where	A.NoBukti=@NoBukti

order by B.Urut;

-- Cetakspp
CREATE PROCEDURE IF NOT EXISTS Cetakspp AS select A.NOBUKTI, A.NOURUT, A.TANGGAL, Case When A.TglKirim='12-30-1899' Then Null else A.TglKirim  TglKirim, A.KODECUSTSUPP, D.namaCust NamaCustSupp, D.Alamat, D.kodekota Kota,

        A.NOSHIP, A.NOPESAN, B.ShippingMark,

        A.NoLC, A.Catatan,

        A.ISCETAK, A.IDUser,

        B.URUT, B.KODEBRG, C.NamaBrg,  B.QNT QNT1, B.QNT2, B.SAT_1, B.SAT_2, B.NoSat, B.ISI,

        B.KetDetail, B.UrutSO, B.NetW, b.GrossW, G.NOBUKTI NoSO, '' NOPO, B.Namabrg NamabrgKom, B.Mesurement,

        A.NamaKirim, A.Alamatkirim, Case when B.nosat=1 then B.Sat_1 when B.nosat=2 then B.Sat_2 else ''  Satuan,

        A.NoAlamatkirim, B.kodegdg,

        Case when B.nosat=1 then B.Qnt when B.nosat=2 then B.Qnt2 else 0  Qnt,

        COALESCE(A.Cetakke ,0) + 1 Ncetak,Pr.NAMAPROJECT

From DBSPP A

Left Outer Join DBSPPDET B on B.NoBukti=A.NoBukti

Left Outer join dbSO G on G.Nobukti=B.NoSO

Left Outer Join dbBarang c On C.KodeBrg=B.KodeBrg

Left Outer Join DBPROJECT Pr On Pr.KODEPROJECT=G.AlamatKirim

Left Outer Join vwBrowsCustomer D On D.KodeCust=A.KodeCustSupp --and D.Sales=G.KODESLS

Left Outer Join vwOutSO_SPP E on E.Nobukti=B.NoSO and E.urut=B.UrutSO

where a.NoBukti=@NoBukti

order By B.Urut;

-- CetakTransfer
CREATE PROCEDURE IF NOT EXISTS CetakTransfer AS Select A.Nobukti, A.Tanggal, A.NOTE, B.Urut, B.KODEBRG, C.NAMABRG, 

	B.GDGASAL, D1.Nama NamaGdgAsal, B.GDGTUJUAN, D2.NAMA NamaGdgTujuan,

	Case When B.NOSAT=1 Then B.QNT else B.QNT2  QNT1, B.QNT2, Case When B.NOSAT=1 Then B.SAT_1 else B.SAT_2  SAT_1, B.SAT_2, C.SAT1 SATUAN1, C.SAT2 SATUAN2,NoPenyerahan KodeSupp,Cs.NAMACUSTSUPP, 

	a.NOPOL,a.SOPIR, 

	case when a.Devisi<>'02' then

	Case When A.NOBUKTI Like '%-GM%' and (B.GDGTUJUAN='G01' or B.GDGTUJUAN='G21' or B.GDGTUJUAN='G116' or B.GDGTUJUAN='G112') Then 'Surat Jalan Transfer ( Masuk ) Barang' when  A.NOBUKTI Like '%-GK%' and(B.GDGASAL='G01' or B.GDGASAL='G21' or B.GDGASAL='G116' or B.GDGASAL='G112') Then 'Surat Jalan Transfer ( Keluar ) Barang' else ''  

	else 

	Case When A.NOBUKTI Like '%-GM%' and (B.GDGTUJUAN='G01@CA' ) Then 'Surat Jalan Transfer ( Masuk ) Barang' when  A.NOBUKTI Like '%-GK%' and (B.GDGASAL='G01@CA' ) Then 'Surat Jalan Transfer ( Keluar ) Barang' else '' 

	 Judul

From DBTRANSFER A 

     left outer join DBTRANSFERDET B on B.NOBUKTI=A.NOBUKTI 

     left outer join dbBarang C on C.KODEBRG=B.KODEBRG 

     left outer join dbGudang D1 on D1.KODEGDG=B.GDGASAL

     left outer join DBGUDANG D2 on D2.KODEGDG=B.GDGTUJUAN

     left Outer join DBCUSTSUPP Cs on Cs.KODECUSTSUPP=A.NoPenyerahan

where A.NoBukti=@NoBukti

order by B.Urut;

-- CetakTTInvoicePenjualan
CREATE PROCEDURE IF NOT EXISTS CetakTTInvoicePenjualan AS --select @nobukti='SJY/INVC/0713/00005'

Select 1 as Urut, 'Surat Jalan' KetDokumen, 

		B.NoSPB NoBukti, A.NoUrut, A.Tanggal Tanggal, A.PPN, A.Valas, A.Kurs, A.KodeCustSupp,       

       Case when C.USAHA<>'' then C.USAHA+'. ' else '' +C.NAMACUSTSUPP NamaCustSupp,

       ltrim(C.ALAMAT1+case when ltrim(C.ALAMAT2)<>'' then char(13)+C.ALAMAT2 else '' ) Alamat,C.Kota,

		C.USAHA,'' NEGARA, C.TELPON, '' FAX, '' EMAIL,

       0 Jumlah, Dbo.Terbilang(m1.Tot) TerBIlang, 0.00 NNet

from dbInvoicePL A

     left outer join dbInvoicePLDet b on b.NoBukti=A.NoBukti

     left outer join dbSPB SPB on SPB.NoBukti=B.NoSPB     

     left outer join DBCUSTSUPP c on c.KODECUSTSUPP=A.KodeCustSupp

     LEFT Outer join (select SUM(NNETRp) Tot,Nobukti from dbInvoicePLDet 

						where NoBukti=@nobukti group by NoBukti) m1 on B.NoBukti = m1.NoBukti

     where A.NoBukti=@nobukti

Group by A.NoBukti, B.NoSPB, A.NoUrut, A.Tanggal, A.PPN, A.Valas, A.Kurs, A.KodeCustSupp,       

       C.USAHA, C.NAMACUSTSUPP,

       C.ALAMAT1, C.ALAMAT2, C.KOTA, c.TELPON, C.KodePos,

       Dbo.Terbilang(m1.Tot)

union all

Select 2 as Urut, 'Faktur' KetDokumen, 

		A.NoBukti, A.NoUrut, A.Tanggal, A.PPN, A.Valas, A.Kurs, A.KodeCustSupp,       

       Case when C.USAHA<>'' then C.USAHA+'. ' else '' +C.NAMACUSTSUPP NamaCustSupp,

       ltrim(C.ALAMAT1+case when ltrim(C.ALAMAT2)<>'' then char(13)+C.ALAMAT2 else '' ) Alamat,C.Kota,

		C.USAHA,'' NEGARA, C.TELPON, '' FAX, '' EMAIL,

       m1.Tot Jumlah, Dbo.Terbilang(m1.Tot) TerBIlang, 0.00 NNet

from dbInvoicePL A

     left outer join dbInvoicePLDet b on b.NoBukti=A.NoBukti     

     left outer join DBCUSTSUPP c on c.KODECUSTSUPP=A.KodeCustSupp

     LEFT Outer join (select SUM(NNETRp) Tot,Nobukti from dbInvoicePLDet 

						where NoBukti=@nobukti group by NoBukti) m1 on B.NoBukti = m1.NoBukti

     where A.NoBukti=@nobukti

Group by A.NoBukti, A.NoUrut, A.Tanggal, A.PPN, A.Valas, A.Kurs, A.KodeCustSupp,       

       C.USAHA, C.NAMACUSTSUPP,

       C.ALAMAT1, C.ALAMAT2, C.KOTA, c.TELPON, C.KodePos,

       m1.Tot, Dbo.Terbilang(m1.Tot)

union all

Select 3 Urut, 'Kwitansi' KetDokumen, 

		A.NoBukti, A.NoUrut, A.Tanggal, A.PPN, A.Valas, A.Kurs, A.KodeCustSupp,       

       Case when C.USAHA<>'' then C.USAHA+'. ' else '' +C.NAMACUSTSUPP NamaCustSupp,

       ltrim(C.ALAMAT1+case when ltrim(C.ALAMAT2)<>'' then char(13)+C.ALAMAT2 else '' ) Alamat,C.Kota,

		C.USAHA,'' NEGARA, C.TELPON, '' FAX, '' EMAIL,

       0 Jumlah, Dbo.Terbilang(m1.Tot) TerBIlang, 0.00 NNet

from dbInvoicePL A

     left outer join dbInvoicePLDet b on b.NoBukti=A.NoBukti     

     left outer join DBCUSTSUPP c on c.KODECUSTSUPP=A.KodeCustSupp

     LEFT Outer join (select SUM(NNETRp) Tot,Nobukti from dbInvoicePLDet 

						where NoBukti=@nobukti group by NoBukti) m1 on B.NoBukti = m1.NoBukti

     where A.NoBukti=@nobukti

Group by A.NoBukti, A.NoUrut, A.Tanggal, A.PPN, A.Valas, A.Kurs, A.KodeCustSupp,       

       C.USAHA, C.NAMACUSTSUPP,

       C.ALAMAT1, C.ALAMAT2, C.KOTA, c.TELPON, C.KodePos,

       m1.Tot, Dbo.Terbilang(m1.Tot)

union all

Select 4 Urut, 'Faktur Pajak' KetDokumen,

		N.NOSERI+'.'+A.NoPajak NoBukti, A.NoUrut, A.Tanggal, A.PPN, A.Valas, A.Kurs, A.KodeCustSupp,       

       Case when C.USAHA<>'' then C.USAHA+'. ' else '' +C.NAMACUSTSUPP NamaCustSupp,

       ltrim(C.ALAMAT1+case when ltrim(C.ALAMAT2)<>'' then char(13)+C.ALAMAT2 else '' ) Alamat,C.Kota,

		C.USAHA,'' NEGARA, C.TELPON, '' FAX, '' EMAIL,

       0 Jumlah, Dbo.Terbilang(m1.Tot) TerBIlang, 0.00 NNet

from dbInvoicePL A

     left outer join dbInvoicePLDet b on b.NoBukti=A.NoBukti     

     left outer join DBCUSTSUPP c on c.KODECUSTSUPP=A.KodeCustSupp

     left outer join dbNomor n on 1=1

     LEFT Outer join (select SUM(NNETRp) Tot,Nobukti from dbInvoicePLDet 

						where NoBukti=@nobukti group by NoBukti) m1 on B.NoBukti = m1.NoBukti

     where A.NoBukti=@nobukti

Group by A.NoBukti, a.NoPajak, A.NoUrut, A.Tanggal, A.PPN, A.Valas, A.Kurs, A.KodeCustSupp,       

       C.USAHA, C.NAMACUSTSUPP, N.NOSERI,

       C.ALAMAT1, C.ALAMAT2, C.KOTA, c.TELPON, C.KodePos,

       m1.Tot, Dbo.Terbilang(m1.Tot)

       

order by Urut, NoBukti;

-- KoreksiReturSPB
CREATE PROCEDURE IF NOT EXISTS KoreksiReturSPB AS -- DECLARE REMOVED,@Urut int,@KodebrgK Varchar(25),@Kodegdg Varchar(15),@KodebrgA Varchar(25)

if @mode in('I','U')

select @NOSJ=NOSPB,@KodebrgA=b.KodeBrgA from dbRSPBDet a

Left Outer Join dbSPBDet b on a.NoSPB=b.NoBukti and a.UrutSPB=b.Urut

where a.NoBukti=@NoBukti and COALESCE(b.isCetakKitir,0)=1 Group By NoSPB,KodeBrgA

------------

-- IF EXISTS REMOVED
delete DBKOREKSI where NOBUKTI=@NoBukti



Declare CurTrans Cursor for

select a.NOBUKTI,a.URUT,KODEBRG,b.KodeGdg from DBKOREKSIDET a

Left Outer Join DBKOREKSI b on a.NOBUKTI=b.NOBUKTI

where b.NOTE Like '%'+@NOSJ+'%' and (a.KodeBrg=@KodeBrg or a.Kodebrg=@KodeBrgA)

order by urut



Open CurTrans

    Fetch Next from CurTrans into @NoKoreksi ,@Urut ,@KodebrgK ,@Kodegdg

 While @@fetch_Status=0

 if not exists(select NoBukti from DBKOREKSI where NOBUKTI=@NoBukti)

 insert Into DBKOREKSI (NOBUKTI, NOURUT, TANGGAL,KodeGdg,NOTE)

 select @NoBukti,@NoUrut,@Tanggal,@Kodegdg,@NoBukti from

 DBKOREKSI where NOBUKTI=@NoKoreksi

 

 insert into DBKOREKSIDET (NOBUKTI,URUT,KODEBRG,QNTDB,QNTCR,QNT2DB,QNT2CR,HARGA, NoSat, Isi, Satuan)

 select @NoBukti,Urut,KodeBrg,Case When Urut in(2,4,6,8,10) Then @Qnt else 0 ,Case When Urut in(1,3,5,7,9) Then @Qnt else 0 ,Case When Urut in(2,4,6,8,10) Then @Qnt2 else 0 ,Case When Urut in(1,3,5,7,9) Then @Qnt2 else 0 ,Harga,Nosat,Isi,Satuan from DBKOREKSIDET

 where NOBUKTI=@NoKoreksi and KODEBRG=@KodebrgK and Urut=@Urut

 ----

 /*insert into DBKOREKSIDET (NOBUKTI,URUT,KODEBRG,QNTDB,QNTCR,QNT2DB,QNT2CR,HARGA, NoSat, Isi, Satuan)

 select @NoBukti,Urut,KodeBrg,@Qnt,0,@Qnt2,0,Harga,Nosat,Isi,Satuan from DBKOREKSIDET

 where NOBUKTI=@NoKoreksi and KODEBRG=@KodebrgK and Urut=@Urut*/

 

 Fetch Next from CurTrans into @NoKoreksi ,@Urut ,@KodebrgK ,@Kodegdg

 

   Close CurTrans

     Deallocate CurTrans



else

-- IF EXISTS REMOVED
delete DBKOREKSI where NOBUKTI=@NoBukti;

-- ProsesAktiva
CREATE PROCEDURE IF NOT EXISTS ProsesAktiva AS select @NoBukti='SJY/BJK/'+SUBSTR('00'+CAST(@bulan as varchar(2)), LENGTH('00'+CAST(@bulan as varchar(2)))-2+1)+SUBSTR('0000'+CAST(@Tahun as varchar(4)), LENGTH('0000'+CAST(@Tahun as varchar(4)))-2+1)+'/AKM01'

select @Nourut='AKM01'

 

-- DECLARE REMOVED,@SaldoPenyusutan numeric(18,2),

        @SaldoPerolehanD Numeric(18,2),@SaldoPenyusutanD numeric(18,2),

        @Penyusutan Numeric(18,2), @PenyusutanD Numeric(18,2),

        @nPenyusutan Numeric(18,2), @nPenyusutanD Numeric(18,2), @urut int,

        @Ket varchar(8000),@Ket2 varchar(8000)

--update DBAKTIVADET set dmk=0,MK=0,DMD=0,MD=0,DSD=0,SD=0,DSK=0,SK=0 where Perkiraan=@KodeAktiva and Devisi=@Devisi and Bulan=@Bulan and Tahun=@Tahun

update DBAKTIVADET set SD=0 where Perkiraan=@KodeAktiva and Devisi=@Devisi and Bulan=@Bulan and Tahun=@Tahun

        

Select @SaldoPerolehan=Awal+(MD-MK), @SaldoPerolehanD=AwalD+(DMD-DMK),

       @SaldoPenyusutan=AwalSusut, @SaldoPenyusutanD=AwalSusutD

from DBAKTIVADET A

where A.Perkiraan=@KodeAktiva and Devisi=@Devisi and Bulan=@Bulan and Tahun=@Tahun



if @TglPerolehan<=CAST(CAST(@bulan AS TEXT)+'-15-'+CAST(@tahun AS TEXT))

if @SaldoPerolehan-@SaldoPenyusutan<=0

  -- SET REMOVED0

  

  else

  If @Metode='L'

	-- SET REMOVED(@SaldoPerolehan*(@Susut/100))/12

	  ---- SET REMOVED(@SaldoPerolehanD*(@Susut/100))/12

	

	else if @Metode='M'

	-- SET REMOVED((@SaldoPerolehan-@SaldoPenyusutan)*(@Susut/100))/12

	  ---- SET REMOVED((@SaldoPerolehanD-@SaldoPenyusutanD)*(@Susut/100))/12

	

	else if @Metode='P'

	Select @SaldoPenyusutan=Case when @Bulan=1 then ((@SaldoPerolehan-@SaldoPenyusutan)*(@Susut/100))/12

											 when A.SK=0 then (@SaldoPerolehan*(@Susut/100))/12

											 when A.SK<>0 then A.SK

											 else 0

									  /*,

				@SaldoPenyusutanD=Case when @Bulan=1 then ((@SaldoPerolehanD-@SaldoPenyusutanD)*(@Susut/100))/12

											  when A.DSK=0 then (@SaldoPerolehanD*(@Susut/100))/12

											  when A.DSK<>0 then A.DSK

											  else 0

										 */                           

	                          

	  From DBAKTIVADET A         

	  where A.Perkiraan=@KodeAktiva and Devisi=@Devisi and Bulan=@Bulan and Tahun=@Tahun                      


	-- SET REMOVEDCase when @SaldoPerolehan-@SaldoPenyusutan<=1 then 0

								when @SaldoPerolehan-(@SaldoPenyusutan+@Penyusutan)<=1 then @SaldoPerolehan-@SaldoPenyusutan-1.0

								when @TipeAktiva=1 then @SaldoPerolehan

								else @Penyusutan

						 

	/*-- SET REMOVEDCase when @SaldoPerolehanD-@SaldoPenyusutanD<=1 then 0

								 when @SaldoPerolehanD-(@SaldoPenyusutanD+@PenyusutanD)<=1 then @SaldoPerolehanD-@SaldoPenyusutanD-1.0

								 when @TipeAktiva=1 then @SaldoPerolehanD

								 else @PenyusutanD

						                   */

	If @Penyusutan>1

	-- SET REMOVED'Akumulasi Penyusutan Aktiva Periode '+Case when @bulan<10 then '0' else '' +Cast(@bulan as varchar(2))+'-'+Cast(@tahun as varchar(4))

	  if @Biaya2 in ('','-') and @Biaya3 in ('','-') and @Biaya4 in ('','-')

		  select @nPenyusutan=@Penyusutan--, @nPenyusutanD=@PenyusutanD

	  else

		  select @nPenyusutan=@Penyusutan*(@Persenbiaya1/100)

	  -- SET REMOVED'Akm. Pny. '+@Keterangan+' ('+@KodeAktiva+') pada : '+@Biaya1+' dgn Persentase : '+CAST(@Persenbiaya1 as varchar(50))+' %'

	  if @Biaya1 not in ('-','')

	  exec SP_Transaksi 'I', @NoBukti,@Nourut, @Tanggal,@Ket2,0,

								@Devisi, @Biaya1, @Akumulasi, @Ket, '', @nPenyusutan,0,'IDR',1,@nPenyusutan,0,

								'BJK','C','','',@urut,'',@kodeAktiva,'','AKM-','',@kodebag,'','AKM','',''

	                     

	  if @Biaya2 not in ('','-')

	  -- SET REMOVED'Akm. Pny. '+@Keterangan+' ('+@KodeAktiva+') pada : '+@Biaya2+' dgn Persentase : '+CAST(@Persenbiaya2 as varchar(50))+' %'

		  -- SET REMOVED@Penyusutan*(@Persenbiaya2/100)

		  exec SP_Transaksi  'I', @NoBukti,@Nourut, @Tanggal,@Ket2,0,

								@Devisi, @Biaya2, @Akumulasi, @Ket, '', @nPenyusutan,0,'IDR',1,@nPenyusutan,0,

								'BJK','C','','',@urut,'',@kodeAktiva,'','AKM-','',@kodebag,'','AKM','',''


	  if @Biaya3 not in ('','-')

	  -- SET REMOVED'Akm. Pny. '+@Keterangan+' ('+@KodeAktiva+') pada : '+@Biaya3+' dgn Persentase : '+CAST(@Persenbiaya3 as varchar(50))+' %'

		  -- SET REMOVED@Penyusutan*(@Persenbiaya3/100)

		  exec SP_Transaksi  'I', @NoBukti,@Nourut, @Tanggal,@Ket2,0,

								@Devisi, @Biaya3, @Akumulasi, @Ket, '', @nPenyusutan,0,'IDR',1,@nPenyusutan,0,

								'BJK','C','','',@urut,'',@kodeAktiva,'','AKM-','',@kodebag,'','AKM','',''


	  if @Biaya4 not in ('','-')

	  -- SET REMOVED'Akm. Pny. '+@Keterangan+' ('+@KodeAktiva+') pada : '+@Biaya4+' dgn Persentase : '+CAST(@Persenbiaya4 as varchar(50))+' %'

		  -- SET REMOVED@Penyusutan*(@Persenbiaya4/100)

		  exec SP_Transaksi  'I', @NoBukti,@Nourut, @Tanggal,@Ket2,0,

								@Devisi, @Biaya4, @Akumulasi, @Ket, '', @nPenyusutan,0,'IDR',1,@nPenyusutan,0,

								'BJK','C','','',@urut,'',@kodeAktiva,'','AKM-','',@kodebag,'','AKM','',''

	  

	  update DBAKTIVADET set SK=@Penyusutan where Perkiraan=@KodeAktiva and Devisi=@Devisi and Bulan=@Bulan and Tahun=@Tahun  


Select @SaldoPerolehan=A.Akhir,@SaldoPerolehanD=A.AkhirD,@SaldoPenyusutan=A.AkhirSusut,@SaldoPenyusutanD=A.AkhirSusutD

from DBAKTIVADET A

where A.Perkiraan=@KodeAktiva and A.Devisi=@Devisi and A.Bulan=@Bulan and A.Tahun=@Tahun



update DBAKTIVADET set Awal=@SaldoPerolehan,AwalD=@SaldoPerolehanD,AwalSusut=@SaldoPenyusutan,AwalSusutD=@SaldoPenyusutanD

where Perkiraan=@KodeAktiva and Devisi=@Devisi and 

                      Bulan=Case when @Bulan=12 then 1 else @Bulan+1  and 

                      Tahun=Case when @Bulan=12 then @Tahun+1 else @Tahun 

     

Insert into DBAKTIVADET(Perkiraan,Devisi,Bulan,Tahun,Awal,AwalD,AwalSusut,AwalSusutD,Valas,Kurs)

Select Perkiraan,Devisi,Case when @Bulan=12 then 1 else @Bulan+1 , Case when @Bulan=12 then @Tahun+1 else @Tahun ,

      Akhir,AkhirD,AkhirSusut,AkhirSusutD,Valas,Kurs

from DBAKTIVADET    

where Perkiraan=@KodeAktiva and Devisi=@Devisi and Bulan=@Bulan and Tahun=@Tahun and 

     not exists(Select Perkiraan 

                from DBAKTIVADET 

                where Perkiraan=@KodeAktiva and Devisi=@Devisi and 

                      Bulan=Case when @Bulan=12 then 1 else @Bulan+1  and 

                      Tahun=Case when @Bulan=12 then @Tahun+1 else @Tahun );

-- SP_AktivaDet
CREATE PROCEDURE IF NOT EXISTS SP_AktivaDet AS tran

if (@choice='I')

insert into dbAktivadet (Devisi, Perkiraan, Bulan, Tahun, Valas,kurs,Awal, AwalSusut,Awald,AwalsusutD)

  	values (@Divisi, @Perkiraan, @Bulan, @Tahun, @valas,@kurs,@Awal*@kurs, @AwalSusut*@kurs,@Awal,@AwalSusut)


if (@choice='U')

IF NOT EXISTS(SELECT 'TRUE' FROM DBAKTIVADET WHERE DEVISI=@DIVISI AND PERKIRAAN=@PERKIRAAN AND BULAN=@Bulan AND TAHUN=@TAHUN)

  insert into dbAktivadet (Devisi, Perkiraan, Bulan, Tahun, Valas,kurs,Awal, AwalSusut,Awald,AwalsusutD)

  	values (@Divisi, @Perkiraan, @Bulan, @Tahun, @valas,@kurs,@Awal*@kurs, @AwalSusut*@kurs,@Awal,@AwalSusut)

   

  ELSE

  UPDATE DBAKTIVADET SET AWAL=@AWAL*@kurs, AWALSUSUT=@AWALSUSUT*@kurs,

                           AWALD=@AWAL, AWALSUSUTD=@AWALSUSUT,Valas=@Valas,Kurs=@kurs

    WHERE DEVISI=@DIVISI AND PERKIRAAN=@PERKIRAAN AND BULAN=@Bulan AND TAHUN=@TAHUN


IF @@ERROR <> 0 GOTO JIKASALAH

commit tran

return

jikasalah:

 rollback tran

 raiserror('Proses Input Data Gagal',16,1)

 return;

-- SP_AktivaTetap
CREATE PROCEDURE IF NOT EXISTS SP_AktivaTetap AS tran

if @choice='I'

insert into dbAktiva (Devisi, Perkiraan, Keterangan, Quantity, Persen, Tanggal, Tipe, 

                        Akumulasi, Biaya, NoMuka, NoBelakang,biaya2,persenbiaya1,persenbiaya2,

                        biaya3,persenbiaya3,biaya4,persenbiaya4, TipeAktiva,Kodebag,NoBelakang2,kelompok,NoAktivaHd)

  values (@Devisi, @Perkiraan, @Keterangan, @Quantity, @Persen, @Tanggal, @Tipe, @Akumulasi, @Biaya, @NoMuka,

          @NoBelakang,@biaya2,@persenbiaya1,@persenbiaya2,@biaya3,@persenbiaya3,@biaya4,@persenbiaya4,@TipeAktiva,@Bagian,

          @NoBelakang2,@IsHeader,@NoAktivaHd)

  if @@error <> 0 goto jikasalah



if @choice='U'

update dbAktiva set Keterangan=@Keterangan, Quantity=@Quantity, Persen=@Persen, Tanggal=@Tanggal, Tipe=@Tipe, Akumulasi=@Akumulasi, 

             Biaya=@Biaya,biaya2=@biaya2, persenbiaya1=@persenbiaya1,persenbiaya2=@persenbiaya2, biaya3=@biaya3, persenbiaya3=@persenbiaya3,

	biaya4=@biaya4, persenbiaya4=@persenbiaya4, TipeAktiva=@TipeAktiva,Kodebag=@Bagian,Devisi=@Devisi,

	NoBelakang2=@NoBelakang2, Kelompok=@IsHeader,NoAktivaHd=@NoAktivaHd

 where  Perkiraan=@Perkiraan

if @@error <> 0 goto jikasalah



if @choice='D'

delete  dbAktiva where Devisi=@Devisi and Perkiraan=@Perkiraan

 if not exists(Select 'True' from DBAKTIVA where Devisi=@Devisi and Perkiraan=@Perkiraan)

    Delete DBAKTIVADET where Devisi=@Devisi and Perkiraan=@Perkiraan

 if @@error <> 0 goto jikasalah



commit tran

return

jikasalah:

 rollback tran

 raiserror('Proses Input Data Gagal',16,1)

 return;

-- sp_alasan
CREATE PROCEDURE IF NOT EXISTS sp_alasan AS select * from vw_alasan

where Tanggal between @tglawal and @TglAkhir

order by Tanggal desc;

-- Sp_AlatBerat
CREATE PROCEDURE IF NOT EXISTS Sp_AlatBerat AS tran

if @choice='I'

insert into dbAlatBerat (KodeAlat,NamaAlat ,Tipe ,Keterangan ,NamaOpe,Tf,Do)

  values (@KodeAlat,@NamaAlat ,@Tipe ,@Keterangan ,@NamaOpe,0,@choice)

  if @@error <> 0 goto jikasalah



else

if @choice='U'

update dbAlatBerat 

    set KodeAlat=@KodeAlat, NamaAlat=@NamaAlat,Tipe=@Tipe,Keterangan=@Keterangan,NamaOpe=@NamaOpe,Tf=0,Do=@Choice

    where KodeAlat=@OldKode

    if @@error <> 0

     goto jikasalah



if @choice='D'

delete dbAlatBerat 

   where KodeAlat=@OldKode

   insert TempDelData

   select @OldKode,'dbAlatBerat'   

   if @@error <> 0 goto jikasalah



commit tran

return

jikasalah:

	rollback tran

	raiserror('Proses Input Data Gagal',16,1)

	return;

-- sp_alterdiagram
CREATE PROCEDURE IF NOT EXISTS sp_alterdiagram AS 'dbo'

	AS

	set nocount on

	

		-- DECLARE REMOVED

		-- DECLARE REMOVED

		-- DECLARE REMOVED

		

		-- DECLARE REMOVED

		-- DECLARE REMOVED

		-- DECLARE REMOVED

	

		if(@diagramname is null)

		RAISERROR ('Invalid ARG', 16, 1)

			return -1


		execute as caller;

		select @theId = DATABASE_PRINCIPAL_ID();	 

		select @IsDbo = IS_MEMBER(N'db_owner'); 

		if(@owner_id is null)

			select @owner_id = @theId;

		revert;

	

		select @ShouldChangeUID = 0

		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 

		

		if(@DiagId IS NULL or (@IsDbo = 0 and @theId <> @UIDFound))

		RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);

			return -3


		if(@IsDbo <> 0)

		if(@UIDFound is null or USER_NAME(@UIDFound) is null) -- invalid principal_id

			select @ShouldChangeUID = 1 ;


		-- update dds data			

		update dbo.sysdiagrams set definition = @definition where diagram_id = @DiagId ;



		-- change owner

		if(@ShouldChangeUID = 1)

			update dbo.sysdiagrams set principal_id = @theId where diagram_id = @DiagId ;



		-- update dds version

		if(@version is not null)

			update dbo.sysdiagrams set version = @version where diagram_id = @DiagId ;



		return 0;

-- Sp_Area
CREATE PROCEDURE IF NOT EXISTS Sp_Area AS tran

if @choice='I'

insert into dbArea (KodeArea, NamaArea)

	values (@KodeArea, @NamaArea)

	if @@error <> 0 goto jikasalah



if @choice='U'

update dbArea set NamaArea=@NamaArea

             where KodeArea=@KodeArea

	if @@error <> 0 goto jikasalah



if @choice='D'

delete  dbArea where KodeArea=@KodeArea

	if @@error <> 0 goto jikasalah



commit tran

return

jikasalah:

	rollback tran

	raiserror('Proses Input Data Gagal',16,1)

	return;

-- Sp_Bagian
CREATE PROCEDURE IF NOT EXISTS Sp_Bagian AS tran

if @choice='I'

insert into dbBagian (KodeBag, NamaBag, Perkiraan, Biaya, BiayaJasaKom, BiayaJasaAlat)

	values (@KodeBag, @NamaBag, @Perkiraan, @Biaya, @BiayaJasaKom, @BiayaJasaALat)

	if @@error <> 0 goto jikasalah



if @choice='U'

update dbBagian set NamaBag=@NamaBag, KodeBag=@KodeBag, Perkiraan=@Perkiraan, Biaya=@Biaya,

	                    BiayaJasaKom=@BiayaJasaKom, BiayaJasaAlat=@BiayaJasaALat

   where KodeBag=@OldKode

	if @@error <> 0 goto jikasalah



if @choice='D'

delete  dbBagian where KodeBag=@OldKode

	if @@error <> 0 goto jikasalah



commit tran

return

jikasalah:

	rollback tran

	raiserror('Proses Input Data Gagal',16,1)

	return;

-- Sp_Bank
CREATE PROCEDURE IF NOT EXISTS Sp_Bank AS tran

if @choice='I'

insert into DBbank (KodeBank, NamaBank,Nama,Tf,Do)

	values (@Kodebank, @NamaBank,@Nama,0,@choice)

	if @@error <> 0 goto jikasalah



if @choice='U'

update dbbank set Namabank=@NamaBank,NAMA=@Nama,Tf=0,Do=@Choice

             where kodebank=@Kodebank

	if @@error <> 0 goto jikasalah



if @choice='D'

delete  dbbank where Kodebank=@Kodebank

   insert TempDelData

   select @Kodebank,'dbbank'

	if @@error <> 0 goto jikasalah



commit tran

return

jikasalah:

	rollback tran

	raiserror('Proses Input Data Gagal',16,1)

	return;

-- Sp_Barang
CREATE PROCEDURE IF NOT EXISTS Sp_Barang AS tran

-- DECLARE REMOVED

-- SET REMOVEDgetdate()

Select @Tglinput

if @Choice='I'

insert into dbBarang(kodebrg, namabrg, kodegrp,kodeSubgrp, kodesupp, sat1, ISi1, sat2, isi2, sat3, isi3, IsAKtif,

		Hrg1_1, Hrg2_1, Hrg3_1, Hrg1_2, Hrg2_2, Hrg3_2, Hrg1_3, Hrg2_3, Hrg3_3, QntMin, QntMax, Keterangan,NFix,NamaBrg2,tolerate,IsBarang,Tf,Do)

    values(@kodebrg, @namabrg, @kodegrp,@kodeSubgrp, @KodeSupp, @sat1, @ISi1, @Sat2, @Isi2, @Sat3, @Isi3, @IsAKtif,

		@Hrg1_1, @Hrg2_1, @Hrg3_1, @Hrg1_2, @Hrg2_2, @Hrg3_2, @Hrg1_3, @Hrg2_3, @Hrg3_3, @QntMin, @QntMax, @Keterangan,@NFix,@NamaBrg2,@tolerate,@IsBarang,0,@choice)

    if @@error <> 0 goto jikasalah


if @Choice='U'

update dbBarang

    set namabrg=@Namabrg,KodeSubGrp=@KodeSubGrp,kodegrp=@Kodegrp, KodeSupp=@KodeSupp, 

	sat1=@Sat1, ISi1=@Isi1, Sat2=@Sat2, Isi2=@Isi2, Sat3=@Sat3, Isi3=@Isi3, IsAKtif=@isaktif,

	Hrg1_1=@Hrg1_1, Hrg2_1=@Hrg2_1, Hrg3_1=@Hrg3_1, Hrg1_2=@Hrg1_2, Hrg2_2=@Hrg2_2, Hrg3_2=@Hrg3_2, 

	Hrg1_3=@Hrg1_3, Hrg2_3=@Hrg2_3, Hrg3_3=@Hrg3_3, QntMin=@QntMin, QntMax=@QntMax, Keterangan=@Keterangan,NFix=@NFix,NamaBrg2=@NamaBrg2,tolerate=@tolerate,IsBarang=@IsBarang,Tf=0,Do=@Choice

    where KodeBrg=@KodeBrg

    if @@error <> 0 goto jikasalah


if @Choice='D'

Delete DBDATABARANG where KODEBRG=@KodeBrg 

    Delete DBSTOCKBRG where KODEBRG=@KodeBrg

    Delete dbBarang where KodeBrg=@KodeBrg

    insert TempDelData

   select @KodeBrg,'dbBarang'

    if @@error <> 0 goto jikasalah



commit tran

return

jikasalah:

	rollback tran

	raiserror('Proses Input Data Gagal',16,1)

        return;

-- sp_BarangJadi
CREATE PROCEDURE IF NOT EXISTS sp_BarangJadi AS tran

---- DECLARE REMOVED

---- SET REMOVEDgetdate()

--Select @Tglinput

if @Choice='I'

insert into dbBarang(kodebrg, namabrg, kodegrp,kodeSubgrp, GrpBarang, kodesupp, sat1, ISi1, sat2, isi2, sat3, isi3, IsAKtif,

		Hrg1_1, Hrg2_1, Hrg3_1, Hrg1_2, Hrg2_2, Hrg3_2, Hrg1_3, Hrg2_3, Hrg3_3, QntMin, QntMax, Keterangan,NFix,NamaBrg2,tolerate,

		DimH, DimW, DimT1A, DimT1B, DimT2, DimL, IsBarang,Ukuran,tonase,Tf,Do)

    values(@kodebrg, @namabrg, @kodegrp,@kodeSubgrp, @GrpBarang, @KodeSupp, @sat1, @ISi1, @Sat2, @Isi2, @Sat3, @Isi3, @IsAKtif,

		@Hrg1_1, @Hrg2_1, @Hrg3_1, @Hrg1_2, @Hrg2_2, @Hrg3_2, @Hrg1_3, @Hrg2_3, @Hrg3_3, @QntMin, @QntMax, @Keterangan,@NFix,@NamaBrg2,@tolerate,

		@DimH, @DimW, @DimT1A, @DimT1B, @DimT2, @DimL, case when @KodeGrp='FG' and @IsBarang=3 Then 0 else @IsBarang ,@Ukuran,@Tonase,0,@choice)

    if @@error <> 0 goto jikasalah


if @Choice='U'

update dbBarang

    set namabrg=@Namabrg,KodeSubGrp=@KodeSubGrp,kodegrp=@Kodegrp, GrpBarang=@GrpBarang, KodeSupp=@KodeSupp, 

	sat1=@Sat1, ISi1=@Isi1, Sat2=@Sat2, Isi2=@Isi2, Sat3=@Sat3, Isi3=@Isi3, IsAKtif=@isaktif,

	Hrg1_1=@Hrg1_1, Hrg2_1=@Hrg2_1, Hrg3_1=@Hrg3_1, Hrg1_2=@Hrg1_2, Hrg2_2=@Hrg2_2, Hrg3_2=@Hrg3_2, 

	Hrg1_3=@Hrg1_3, Hrg2_3=@Hrg2_3, Hrg3_3=@Hrg3_3, QntMin=@QntMin, QntMax=@QntMax, Keterangan=@Keterangan,NFix=@NFix,NamaBrg2=@NamaBrg2,tolerate=@tolerate,

	DimH=@DimH, DimW=@DimW, DimT1A=@DimT1A, DimT1B=@DimT1B, DimT2=@DimT2, DimL=@DimL,

	IsBarang=case when @KodeGrp='FG' and @IsBarang=3 Then 0 else @IsBarang ,Ukuran=@Ukuran,tonase=@Tonase,Tf=0,Do=@Choice

    where KodeBrg=@KodeBrg

    if @@error <> 0 goto jikasalah


if @Choice='D'

Delete dbBarang where KodeBrg=@KodeBrg

   insert TempDelData

   select @KodeBrg,'dbBarang'

    if @@error <> 0 goto jikasalah



commit tran

return

jikasalah:

	rollback tran

	raiserror('Proses Input Data Gagal',16,1)

        return;

-- sp_BarangJS
CREATE PROCEDURE IF NOT EXISTS sp_BarangJS AS tran

---- DECLARE REMOVED

Select Top 1 @KodeGrp=KODEGRP from DBGROUP 

--Select @Tglinput

if @Choice='I'

insert into dbBarang(kodebrg, namabrg, kodegrp,kodeSubgrp, GrpBarang, kodesupp, sat1, ISi1, sat2, isi2, sat3, isi3, IsAKtif,

		Hrg1_1, Hrg2_1, Hrg3_1, Hrg1_2, Hrg2_2, Hrg3_2, Hrg1_3, Hrg2_3, Hrg3_3, QntMin, QntMax, Keterangan,NFix,NamaBrg2,tolerate,

		DimH, DimW, DimT1A, DimT1B, DimT2, DimL, IsBarang,Ukuran,tonase,IsJasa,Tf,Do)

    values(@kodebrg, @namabrg, @kodegrp,@kodeSubgrp, @GrpBarang, @KodeSupp, @sat1, @ISi1, @Sat2, @Isi2, @Sat3, @Isi3, @IsAKtif,

		@Hrg1_1, @Hrg2_1, @Hrg3_1, @Hrg1_2, @Hrg2_2, @Hrg3_2, @Hrg1_3, @Hrg2_3, @Hrg3_3, @QntMin, @QntMax, @Keterangan,@NFix,@NamaBrg2,@tolerate,

		@DimH, @DimW, @DimT1A, @DimT1B, @DimT2, @DimL, @IsBarang,@Ukuran,@Tonase,1,0,@choice)

    if @@error <> 0 goto jikasalah


if @Choice='U'

update dbBarang

    set namabrg=@Namabrg,KodeSubGrp=@KodeSubGrp,kodegrp=@Kodegrp, GrpBarang=@GrpBarang, KodeSupp=@KodeSupp, 

	sat1=@Sat1, ISi1=@Isi1, Sat2=@Sat2, Isi2=@Isi2, Sat3=@Sat3, Isi3=@Isi3, IsAKtif=@isaktif,

	Hrg1_1=@Hrg1_1, Hrg2_1=@Hrg2_1, Hrg3_1=@Hrg3_1, Hrg1_2=@Hrg1_2, Hrg2_2=@Hrg2_2, Hrg3_2=@Hrg3_2, 

	Hrg1_3=@Hrg1_3, Hrg2_3=@Hrg2_3, Hrg3_3=@Hrg3_3, QntMin=@QntMin, QntMax=@QntMax, Keterangan=@Keterangan,NFix=@NFix,NamaBrg2=@NamaBrg2,tolerate=@tolerate,

	DimH=@DimH, DimW=@DimW, DimT1A=@DimT1A, DimT1B=@DimT1B, DimT2=@DimT2, DimL=@DimL,

	IsBarang=@IsBarang,Ukuran=@Ukuran,tonase=@Tonase,IsJasa=1,Tf=0,Do=@Choice

    where KodeBrg=@KodeBrg

    if @@error <> 0 goto jikasalah


if @Choice='D'

Delete dbBarang where KodeBrg=@KodeBrg

    insert TempDelData

    select @KodeBrg,'dbBarang'

    if @@error <> 0 goto jikasalah



commit tran

return

jikasalah:

	rollback tran

	raiserror('Proses Input Data Gagal',16,1)

        return;

-- Sp_Beli
CREATE PROCEDURE IF NOT EXISTS Sp_Beli AS tran

if @Choice='I'

select @Urut=COALESCE(max(urut),0)+1 from dbBelidet Where NoBukti=@NoBukti

  if not exists(select * from dbBeli Where NoBukti=@NoBukti) 

  insert into dbBeli (Devisi,NOBUKTI, NOURUT, TANGGAL, TglJatuhTempo, KODESUPP, Handling,  KETERANGAN, 

	FakturSUPP, KODEVLS, KURS, PPN, TIPEBAYAR, HARI, TipeDisc, DISC, DiscRp)

    values (@Devisi,@NOBUKTI, @NOURUT, @TANGGAL, @TglJatuhTempo, @KODESUPP, @Handling, @KETERANGAN,

	@FakturSupp, @KODEVLS, @KURS, @PPN, @TIPEBAYAR, @HARI, @TipeDisc, @DISC, @DiscRp)

  

  insert into dbBeliDET (NOBUKTI, URUT,  PPN, Disc, KODEBRG, QntTerima, NOSAT, ISI, SATUAN, HARGA, DISCP, DISCTot, NoPO,UrutPO, KodeGdg,Qnt2Terima,Qnt,QntReject,KURS,Perkiraan)

  values(@NOBUKTI, @URUT, @PPN, @Disc, @KODEBRG, @Qnt, @NoSat, @Isi, @Satuan, @Harga, @DiscP, @DiscTOT, @NoPO,@UrutPO, @KodeGdg,@Qnt2,@Qnt,0,@Kurs,@Perkiraan)



if @Choice='U'

update dbBeliDET set KodeBrg=@KODEBRG,  QntTerima=Case when @XUbah='T' Then Case When @Pilih='I' Then COALESCE(Qnt,0)+@QNT when @Pilih='U'Then @Qnt  else QntTerima , NOSAT=@NoSat, ISI=@ISI, SATUAN=@Satuan, Harga=@HARGA, DiscP=@DiscP, DiscTot=@DiscTot, KodeGdg=@KodeGdg

  ,Qnt2Terima=Case when @XUbah='T' Then Case When @Pilih='I' Then COALESCE(Qnt,0)+@QNT2 when @Pilih='U'Then @Qnt2  else Qnt2Terima ,QntReject=Case when @XUbah='R' Then Case When @Pilih='I' Then COALESCE(QntReject,0)+@QntReject when @Pilih='U'Then @QntReject  else QntReject ,Qnt2Reject=Case when @XUbah='R' Then Case When @Pilih='I' Then COALESCE(Qnt2Reject,0)+@Qnt2Reject when @Pilih='U'Then @Qnt2Reject  else Qnt2Reject 

  ,QNT=(QntTerima-QntReject),KURS=@Kurs

  where NoBukti=@NoBukti and Urut=@Urut



if @Choice='U'

update dbBeliDET set  QNT=(QntTerima-QntReject),Perkiraan=@Perkiraan

 where NoBukti=@NoBukti and Urut=@Urut



if @Choice='D'

delete dbBeliDET where NoBukti=@NoBukti and Urut=@Urut 

  if not exists( select NoBukti from dbBeliDET where NoBukti=@NoBukti)

  delete dbBeli where NoBukti=@NoBukti


/*-- IF EXISTS REMOVED
Update DBBELI Set NILAIDPP=(select SUM(NDPP)NDPP from DBBELIDET where NOBUKTI=DBBELI.NOBUKTI),

                     NILAINET=(select SUM(NNET)NNET from DBBELIDET where NOBUKTI=DBBELI.NOBUKTI),

                     NILAIPPN=(select SUM(NPPN)NPPN from DBBELIDET where NOBUKTI=DBBELI.NOBUKTI)

   where NOBUKTI=@NoBukti                  

  */

if @@error<>0  goto jikasalah

Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- sp_BeliGudang
CREATE PROCEDURE IF NOT EXISTS sp_BeliGudang AS -- DECLARE REMOVED, @DiscP numeric(18,2), @DiscTot numeric(18,2)

-- DECLARE REMOVED, @Disc float



tran



if @Choice='I'

select @Urut=COALESCE(max(urut),0)+1 from dbBeliDet Where NoBukti=@NoBukti

  if @@error<>0  goto jikasalah

  if not exists(select * from dbBeli Where NoBukti=@NoBukti) 

  insert into dbBeli (NOBUKTI, NOURUT, TANGGAL, TglJatuhTempo, KODESUPP, Handling,  KETERANGAN, 

	FakturSUPP, KODEVLS, KURS, PPN, TIPEBAYAR, HARI, TipeDisc, DISC, DiscRp, NoPOHd, KodeGdgHd)

	select @NoBukti, @NoUrut, @Tanggal, @Tanggal+HARI, @KodeSupp, HANDLING, @Keterangan,

	@FakturSupp, KODEVLS, KURS, PPN, TIPEBAYAR, HARI, TipeDisc, DISC, DISCRP, @NoPO, @KodeGdg

	from DBPO 

	where NOBUKTI=@NoPO

	if @@error<>0  goto jikasalah


  select @PPN=PPN, @Disc=DISC from DBBELI where NOBUKTI=@NoBukti

  if @@error<>0  goto jikasalah

  

  select top 1 @Harga=HARGA, @DiscP=DISCP, @DiscTot=DISCTOT 

  from DBPODET

  where NOBUKTI=@NoPO and KODEBRG=@KodeBrg and NOSAT=@NoSat

  if @@error<>0  goto jikasalah

  

  select @Harga=COALESCE(@Harga,0), @DiscP=COALESCE(@DiscP,0), @DiscTot=COALESCE(@DiscTot,0)

  if @@error<>0  goto jikasalah

  

  insert into dbBeliDET (NOBUKTI, URUT, KODEBRG, KodeGdg, PPN, DISC, 

  QNT, NOSAT, SATUAN, ISI, HARGA, DISCP, DISCTOT, BYANGKUT, 

  NoPO, UrutPO, HPP, QntTerima, Qnt1Terima, Qnt2Terima)

  values(@NOBUKTI, @URUT, @KODEBRG, @KodeGdg, @PPN, @Disc, 

  @QntTerima, @NoSat, @Satuan, @Isi, @Harga, @DiscP, @DiscTOT, 

  0.00, @NoPO, @UrutPO, 0, @QntTerima, @Qnt1Terima, @Qnt2Terima)

  if @@error<>0  goto jikasalah


if @Choice='U'

update dbBeliDET set KodeBrg=@KODEBRG,  QntTerima=@QntTerima, NOSAT=@NoSat, SATUAN=@Satuan, ISI=@Isi,

  Qnt1Terima=@Qnt1Terima, Qnt2Terima=@Qnt2Terima,

  QNT=@QntTerima-QntReject

  where NoBukti=@NoBukti and Urut=@Urut

  if @@error<>0  goto jikasalah


if @Choice='D'

delete dbBeliDET where NoBukti=@NoBukti and Urut=@Urut

  if @@error<>0  goto jikasalah 

  if not exists( select NoBukti from dbBeliDET where NoBukti=@NoBukti)

  delete dbBeli where NoBukti=@NoBukti

    if @@error<>0  goto jikasalah


if @Choice in('I','U')

exec [sp_UpdateTransaksiPPN] 'dbBeliDet','dbBeli',@NoBukti


---- IF EXISTS REMOVED
-- --   Update DBBELI Set NILAIDPP=(select SUM(NDPP)NDPP from DBBELIDET where NOBUKTI=DBBELI.NOBUKTI),

--                     NILAINET=(select SUM(NNET)NNET from DBBELIDET where NOBUKTI=DBBELI.NOBUKTI),

--                     NILAIPPN=(select SUM(NPPN)NPPN from DBBELIDET where NOBUKTI=DBBELI.NOBUKTI)

--   where NOBUKTI=@NoBukti                  

--  

--if @@error<>0  goto jikasalah

Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- sp_BeliReject
CREATE PROCEDURE IF NOT EXISTS sp_BeliReject AS tran



if @Choice='I'

select @Urut=COALESCE(max(urut),0)+1 from dbBeliDet Where NoBukti=@NoBukti

  if @@error<>0  goto jikasalah

  insert into dbBeliDET (NOBUKTI, URUT, KODEBRG, KodeGdg, PPN, DISC, KURS,

  QNT, NOSAT, SATUAN, ISI, HARGA, DISCP, DISCTOT, BYANGKUT, 

  NoPO, UrutPO, HPP, QntTerima, Qnt1Terima, Qnt2Terima,

  QntReject, Qnt1Reject, Qnt2Reject, UrutBeli, KetReject)

  select NoBukti, @Urut, KodeBrg, KodeGdg, PPN, Disc,Kurs,

  -1*@QntReject, @NoSatReject, @SatuanReject, @IsiReject, Harga, DiscP, DiscTot, 0 BYANGKUT,

  NoPO, UrutPO, HPP, 0 QntTerima, 0 Qnt1Terima, 0 Qnt2Terima,

  @QntReject, @Qnt1Reject, @Qnt2Reject, @UrutBeli, @KetReject

  from DBBELIDET

  where NOBUKTI=@NoBukti and Urut=@UrutBeli 

  if @@error<>0  goto jikasalah


if @Choice='U'

update dbBeliDET set NoSat=@NoSatReject, SATUAN=@SatuanReject, QntReject=@QntReject, Qnt1Reject=@Qnt1Reject, Qnt2Reject=@Qnt2Reject,

	QNT=-1*@QntReject, KetReject=@KetReject

  where NoBukti=@NoBukti and Urut=@Urut

  if @@error<>0  goto jikasalah


if @Choice='D'

delete dbBeliDET where NoBukti=@NoBukti and Urut=@Urut

  if @@error<>0  goto jikasalah 

  if not exists( select NoBukti from dbBeliDET where NoBukti=@NoBukti)

  delete dbBeli where NoBukti=@NoBukti

    if @@error<>0  goto jikasalah


---- IF EXISTS REMOVED
-- --   Update DBBELI Set NILAIDPP=(select SUM(NDPP)NDPP from DBBELIDET where NOBUKTI=DBBELI.NOBUKTI),

--                     NILAINET=(select SUM(NNET)NNET from DBBELIDET where NOBUKTI=DBBELI.NOBUKTI),

--                     NILAIPPN=(select SUM(NPPN)NPPN from DBBELIDET where NOBUKTI=DBBELI.NOBUKTI)

--   where NOBUKTI=@NoBukti                  

--  

--if @@error<>0  goto jikasalah

Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- sp_BeliTerima
CREATE PROCEDURE IF NOT EXISTS sp_BeliTerima AS -- DECLARE REMOVED, @DiscP numeric(18,2), @DiscTot numeric(18,2)

-- DECLARE REMOVED, @Disc float



tran



if @Choice='I'

select @Urut=COALESCE(max(urut),0)+1 from dbBeliDet Where NoBukti=@NoBukti

  if @@error<>0  goto jikasalah

  if not exists(select * from dbBeli Where NoBukti=@NoBukti) 

  insert into dbBeli (NOBUKTI, NOURUT, TANGGAL, TglJatuhTempo, KODESUPP, Handling,  KETERANGAN, 

	FakturSUPP, KODEVLS, KURS, PPN, TIPEBAYAR, HARI, TipeDisc, DISC, DiscRp, NoPOHd, KodeGdgHd,Tf,Do)

	select @NoBukti, @NoUrut, @Tanggal, @Tanggal+HARI, @KodeSupp, HANDLING, @Keterangan,

	@FakturSupp, KODEVLS, KURS, PPN, TIPEBAYAR, HARI, TipeDisc, DISC, DISCRP, @NoPO, @KodeGdg,0,@choice

	from DBPO 

	where NOBUKTI=@NoPO

	if @@error<>0  goto jikasalah


  select @PPN=PPN, @Disc=DISC from DBBELI where NOBUKTI=@NoBukti

  if @@error<>0  goto jikasalah

  

  select top 1 @Harga=HARGA, @DiscP=DISCP, @DiscTot=DISCTOT 

  from DBPODET

  where NOBUKTI=@NoPO and KODEBRG=@KodeBrg and NOSAT=@NoSat

  if @@error<>0  goto jikasalah

  

  select @Harga=COALESCE(@Harga,0), @DiscP=COALESCE(@DiscP,0), @DiscTot=COALESCE(@DiscTot,0)

  if @@error<>0  goto jikasalah

  

  insert into dbBeliDET (NOBUKTI, URUT, KODEBRG, KodeGdg, PPN, DISC, 

  QNT, NOSAT, SATUAN, ISI, HARGA, DISCP, DISCTOT, BYANGKUT, 

  NoPO, UrutPO, HPP, QntTerima_, Qnt1Terima_, Qnt2Terima_,

  QntTerima, Qnt1Terima, Qnt2Terima,KetReject,Tf,Do)

  values(@NOBUKTI, @URUT, @KODEBRG, @KodeGdg, @PPN, @Disc, 

  @QntTerima, @NoSat, @Satuan, @Isi, @Harga, @DiscP, @DiscTOT, 

  0.00, @NoPO, @UrutPO, 0, @QntTerima, @Qnt1Terima, @Qnt2Terima,

  @QntTerima, @Qnt1Terima, @Qnt2Terima,@KetDetail,0,@choice)

  if @@error<>0  goto jikasalah


if @Choice='U'

update dbBeliDET set KodeBrg=@KODEBRG,  QntTerima=@QntTerima,  QntTerima_=@QntTerima, NOSAT=@NoSat, SATUAN=@Satuan, ISI=@Isi,

  Qnt1Terima_=@Qnt1Terima, Qnt2Terima_=@Qnt2Terima,KetReject=@KetDetail,Tf=0,Do=@Choice 

  where NoBukti=@NoBukti and Urut=@Urut

  if @@error<>0  goto jikasalah


if @Choice='D'

delete dbBeliDET where NoBukti=@NoBukti and Urut=@Urut

  insert TempDelDataDet

  select @Nobukti,@Urut,'dbBeliDET'	

  if @@error<>0  goto jikasalah 

  if not exists( select NoBukti from dbBeliDET where NoBukti=@NoBukti)

  delete dbBeli where NoBukti=@NoBukti

  	insert TempDelData

    select @Nobukti,'dbBeli'

    if @@error<>0  goto jikasalah


if @Choice in('I','U')

exec [sp_UpdateTransaksiPPN] 'dbBeliDet','dbBeli',@NoBukti


---- IF EXISTS REMOVED
-- --   Update DBBELI Set NILAIDPP=(select SUM(NDPP)NDPP from DBBELIDET where NOBUKTI=DBBELI.NOBUKTI),

--                     NILAINET=(select SUM(NNET)NNET from DBBELIDET where NOBUKTI=DBBELI.NOBUKTI),

--                     NILAIPPN=(select SUM(NPPN)NPPN from DBBELIDET where NOBUKTI=DBBELI.NOBUKTI)

--   where NOBUKTI=@NoBukti                  

--  

--if @@error<>0  goto jikasalah

Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- Sp_BeratBrg
CREATE PROCEDURE IF NOT EXISTS Sp_BeratBrg AS tran

if @choice='I'

insert into dbHPPProduksi (Bulan, Tahun,KodeBrg,Berat)

	values (@Bulan, @Tahun,@KodeBrg,@Berat)

	if @@error <> 0 goto jikasalah



if @choice='U'

update dbHPPProduksi set Bulan=@Bulan,Tahun=@Tahun,KodeBrg=@KodeBrg,Berat=@Berat

             where Bulan=@OldBulan and Tahun = @OldTahun and Kodebrg = @OldKodeBrg 

	if @@error <> 0 goto jikasalah



if @choice='D'

delete  dbHPPProduksi where Bulan=@OldBulan and Tahun = @OldTahun and Kodebrg = @OldKodeBrg 

	if @@error <> 0 goto jikasalah



commit tran

return

jikasalah:

	rollback tran

	raiserror('Proses Input Data Gagal',16,1)

	return;

-- Sp_Biaya
CREATE PROCEDURE IF NOT EXISTS Sp_Biaya AS tran

if @choice='I'

insert into dbBiaya (KodeBiaya, Keterangan,Perkiraan)

	values (@KodeBiaya, @Keterangan,@Perkiraan)

	if @@error <> 0 goto jikasalah



if @choice='U'

update dbBiaya set Keterangan=@Keterangan ,KodeBiaya=@KodeBiaya, Perkiraan=@Perkiraan

             where KodeBiaya=@OldKode

	if @@error <> 0 goto jikasalah



if @choice='D'

delete  dbBiaya where KodeBiaya=@OldKode

	if @@error <> 0 goto jikasalah



commit tran

return

jikasalah:

	rollback tran

	raiserror('Proses Input Data Gagal',16,1)

	return;

-- Sp_BiayaBeli
CREATE PROCEDURE IF NOT EXISTS Sp_BiayaBeli AS tran

if @Choice='I'

select @Urut=COALESCE(max(urut),0)+1 from dbBiayaBeli Where NoBukti=@NoBukti

	insert into dbBiayaBeli (NoBukti, Urut, Kodebiaya, KODECUSTSUPP, Qnt, Harga, Valas, kurs, PPn)

	values (@NoBukti, @Urut, @Kodebiaya, @KODECUSTSUPP, @Qnt, @Harga, @Valas, @kurs, @PPn)

	if @@error<>0  goto jikasalah


if @Choice='U'

update	dbBiayaBeli

	set	 Kodebiaya=@Kodebiaya, KODECUSTSUPP=@KODECUSTSUPP, Qnt=@Qnt, Harga=@Harga, Valas=@Valas, kurs=@kurs, PPn=@PPn

  	where 	NoBukti=@NoBukti and Urut=@Urut

	if @@error<>0  goto jikasalah



if @Choice='D'

delete dbBiayaBeli where NoBukti=@NoBukti and Urut=@Urut 

	if @@error<>0  goto jikasalah

	if (not exists( select NoBukti from dbBeliDET where NoBukti=@NoBukti)) and  (not exists( select NoBukti from dbBiayaBeli where NoBukti=@NoBukti))

  	delete dbBELI where NoBukti=@NoBukti

		if @@error<>0  goto jikasalah


Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- sp_BiayaPO
CREATE PROCEDURE IF NOT EXISTS sp_BiayaPO AS tran

if @Choice='I'

select @Urut=COALESCE(max(urut),0)+1 from dbBiayaPO Where NoBukti=@NoBukti

	insert into DBBIAYAPO (NoBukti, Urut, Kodebiaya, KODECUSTSUPP, Qnt, Harga, Valas, kurs, PPn)

	values (@NoBukti, @Urut, @Kodebiaya, @KODECUSTSUPP, @Qnt, @Harga, @Valas, @kurs, @PPn)

	if @@error<>0  goto jikasalah


if @Choice='U'

update	dbBiayaPO

	set	 Kodebiaya=@Kodebiaya, KODECUSTSUPP=@KODECUSTSUPP, Qnt=@Qnt, Harga=@Harga, Valas=@Valas, kurs=@kurs, PPn=@PPn

  	where 	NoBukti=@NoBukti and Urut=@Urut

	if @@error<>0  goto jikasalah



if @Choice='D'

delete dbBiayaPO where NoBukti=@NoBukti and Urut=@Urut 

	if @@error<>0  goto jikasalah

	if (not exists( select NoBukti from dbPODet where NoBukti=@NoBukti)) and (not exists( select NoBukti from dbBiayaPO where NoBukti=@NoBukti))

  	delete dbPO where NoBukti=@NoBukti

		if @@error<>0  goto jikasalah

		delete dbNotePO where NoBukti=@NoBukti

		if @@error<>0  goto jikasalah


Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- Sp_BiayaRBeli
CREATE PROCEDURE IF NOT EXISTS Sp_BiayaRBeli AS tran

if @Choice='I'

select @Urut=COALESCE(max(urut),0)+1 from dbBiayaBeli Where NoBukti=@NoBukti

	insert into dbBiayaRBeli (NoBukti, Urut, Kodebiaya, KODECUSTSUPP, Qnt, Harga, Valas, kurs, PPn)

	values (@NoBukti, @Urut, @Kodebiaya, @KODECUSTSUPP, @Qnt, @Harga, @Valas, @kurs, @PPn)

	if @@error<>0  goto jikasalah


if @Choice='U'

update	dbBiayaRBeli

	set	 Kodebiaya=@Kodebiaya, KODECUSTSUPP=@KODECUSTSUPP, Qnt=@Qnt, Harga=@Harga, Valas=@Valas, kurs=@kurs, PPn=@PPn

  	where 	NoBukti=@NoBukti and Urut=@Urut

	if @@error<>0  goto jikasalah



if @Choice='D'

delete dbBiayaRBeli where NoBukti=@NoBukti and Urut=@Urut 

	if @@error<>0  goto jikasalah

	if (not exists( select NoBukti from dbRBeliDET where NoBukti=@NoBukti)) and  (not exists( select NoBukti from dbBiayaRBeli where NoBukti=@NoBukti))

  	delete dbRBELI where NoBukti=@NoBukti

		if @@error<>0  goto jikasalah


Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- sp_Bon
CREATE PROCEDURE IF NOT EXISTS sp_Bon AS if @choice='I'

insert into dbbon(Devisi,NoBukti,Tanggal,Penerima,Debet,Kredit,Keterangan,TglInput,UserID,Perkiraan,Urut,

		KodeVls, Kurs, DebetD, KreditD)

	values (@Devisi,@NoBukti,@Tanggal,@Penerima,@Debet,@Kredit,@Keterangan,@TglInput,@UserID,@Perkiraan,@Urut,

		@KodeVls, @Kurs, @DebetD, @KreditD)



if @choice='U'

Update dbbon set Tanggal=@tanggal,Penerima=@penerima,Keterangan=@keterangan,Debet=@debet,Kredit=@kredit,TglInput=@tglInput,UserID=@userID,

		KodeVls=@KodeVls, Kurs=@Kurs, DebetD=@DebetD, KreditD=@KreditD

	where devisi=@devisi and nobukti=@nobukti and perkiraan=@perkiraan and urut=@urut



if @choice='D'

delete dbbon

	where devisi=@devisi and nobukti=@nobukti and perkiraan=@perkiraan and Urut=@Urut;

-- Sp_BPPB
CREATE PROCEDURE IF NOT EXISTS Sp_BPPB AS tran

if @Choice='I'

select @Urut=COALESCE(max(urut),0)+1 from dbBPPBdet Where NoBukti=@NoBukti

  if not exists(select * from dbBPPB Where NoBukti=@NoBukti) 

  insert into dbBPPB (NOBUKTI, NOURUT, TANGGAL, KDDEP, KodeGdg, KodeGdgT)

    values (@NOBUKTI, @NOURUT, @TANGGAL, @KdDep,'',@KodeGdg)

  

  insert into dbBPPBDET (NOBUKTI, URUT, KODEBRG, QNT, NOSAT, ISI, SATUAN, Qnt2, Qnt2M,Qnt2P)

  values(@NOBUKTI, @URUT, @KODEBRG, @Qnt, @NoSat, @Isi, @Satuan, @Qnt2, @Qnt2M,0.00)



if @Choice='U'

--Update dbBPPB set KodeGdgT=@KodeGdgT where NOBUKTI=@NoBukti 

  --update dbBPPBDET set KodeBrg=@KODEBRG, Qnt=case when @pilihan='M' Then @QNT else Qnt , NOSAT=@NoSat, ISI=@ISI, SATUAN=@Satuan,Qnt2=Case when @pilihan='T' Then @Qnt2 else Qnt2 

  --, Qnt2M=case when @pilihan='M' Then @QNT2M else Qnt2M , Qnt2P=case when @pilihan='T' Then @Qnt2P else Qnt2P 

  --where NoBukti=@NoBukti and Urut=@Urut

  update dbBPPBDET set KodeBrg=@KODEBRG, Qnt=@Qnt, Qnt2=@Qnt2, NOSAT=@NoSat, ISI=@ISI, SATUAN=@Satuan

  where NoBukti=@NoBukti and Urut=@Urut



if @Choice='D'

delete dbBPPBDET where NoBukti=@NoBukti and Urut=@Urut 

  if not exists( select NoBukti from dbBPPBDET where NoBukti=@NoBukti)

  delete dbBPPB where NoBukti=@NoBukti


if @@error<>0  goto jikasalah

Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- sp_BPPBT
CREATE PROCEDURE IF NOT EXISTS sp_BPPBT AS tran

if @Choice='I'

select @Urut=COALESCE(max(urut),0)+1 from dbBPPBTdet Where NoBukti=@NoBukti

  if not exists(select * from dbBPPBT Where NoBukti=@NoBukti) 

  insert into dbBPPBT (NOBUKTI, NOURUT, TANGGAL, KDDEP, KodeGdg, NoBPPB,KodeGdgT)

    values (@NOBUKTI, @NOURUT, @TANGGAL, @KdDep,@KodeGdg,@NoBPPB,@KodegdgT)

  

  insert into dbBPPBTDET (NOBUKTI, URUT, NoBPPB, UrutBPPB, NoSatBPPB, KODEBRG, QNT, NOSAT, ISI, SATUAN, Qnt2, Qnt2M,Qnt2P)

  values(@NOBUKTI, @URUT, @NoBPPB, @UrutBPPB, @NoSatBPPB, @KODEBRG, @Qnt, @NoSat, @Isi, @Satuan, @Qnt2, 0.00, 0.00)



if @Choice='U'

--Update dbBPPB set KodeGdgT=@KodeGdgT where NOBUKTI=@NoBukti 

  --update dbBPPBDET set KodeBrg=@KODEBRG, Qnt=case when @pilihan='M' Then @QNT else Qnt , NOSAT=@NoSat, ISI=@ISI, SATUAN=@Satuan,Qnt2=Case when @pilihan='T' Then @Qnt2 else Qnt2 

  --, Qnt2M=case when @pilihan='M' Then @QNT2M else Qnt2M , Qnt2P=case when @pilihan='T' Then @Qnt2P else Qnt2P 

  --where NoBukti=@NoBukti and Urut=@Urut

  update dbBPPBTDET set Qnt=@Qnt, Qnt2=@Qnt2, NOSAT=@NoSat, ISI=@ISI, SATUAN=@Satuan

  where NoBukti=@NoBukti and Urut=@Urut



if @Choice='D'

delete dbBPPBTDET where NoBukti=@NoBukti and Urut=@Urut 

  if not exists( select NoBukti from dbBPPBTDET where NoBukti=@NoBukti)

  delete dbBPPBT where NoBukti=@NoBukti


if @@error<>0  goto jikasalah

Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- sp_CekHPPPro
CREATE PROCEDURE IF NOT EXISTS sp_CekHPPPro AS -- IF EXISTS REMOVED
=8)

Select 1000 Hpp



else

select COALESCE(HPPBrg,0)Hpp from dbHPPProduksi a

Left Outer Join DBBARANG b on a.KodeBrg=b.KODEBRG

where a.KodeBrg=@Kodebrg and Bulan=@Bulan and Tahun=@Tahun;

-- Sp_CekPiutAwl
CREATE PROCEDURE IF NOT EXISTS Sp_CekPiutAwl AS -- IF EXISTS REMOVED
)+cast(Urut as varchar(3))+Tipe+Perkiraan+Devisi not in

              (select nofaktur+TipeTrans+KodeCustSupp+cast(NoMsk as varchar(3))+cast(Urut as varchar(3))+Tipe+Perkiraan+Devisi

              from DBHUTPIUT where tipe='PT' and tipetrans='AWL'))

  Delete DBHUTPIUT where TipeTrans='AWL' and Tipe='PT'

    INSERT INTO [DBHUTPIUT]

           ([NoFaktur],[NoRetur],[TipeTrans],[KodeCustSupp],[NoBukti],[NoMsk],[Urut],[Tanggal],[JatuhTempo],[Debet],[Kredit],[Valas],

           [Kurs],[DebetD],[KreditD],[KodeSales],[Tipe],[Perkiraan],[Catatan],[NOINVOICE],[TGLINVOICE],[NOPAJAK],[TGLFPJ],[KodeVls_],

           [Kurs_],[KursBayar],[FlagSimbol],[TipeBayar],[NoPelunasan],[PerkiraanKas],[TglButuh],[PerkiraanTBayar],[KBLB],[Devisi])

     select [NoFaktur],[NoRetur],[TipeTrans],[KodeCustSupp],[NoBukti],[NoMsk],[Urut],[Tanggal],[JatuhTempo],[Debet],[Kredit],[Valas],

           [Kurs],[DebetD],[KreditD],[KodeSales],[Tipe],[Perkiraan],[Catatan],[NOINVOICE],[TGLINVOICE],[NOPAJAK],[TGLFPJ],[KodeVls_],

           [Kurs_],[KursBayar],[FlagSimbol],[TipeBayar],[NoPelunasan],[PerkiraanKas],[TglButuh],[PerkiraanTBayar],[KBLB],[Devisi]

        from DBPIUTAWL where TipeTrans='AWL' and Tipe='PT';

-- SP_CetakBonSementara
CREATE PROCEDURE IF NOT EXISTS SP_CetakBonSementara AS Select 	A.NoBukti+SUBSTR('0000000000'+A.Perkiraan, LENGTH('0000000000'+A.Perkiraan)-10+1)+SUBSTR('00000'+cast(A.Urut as varchar(5)), LENGTH('00000'+cast(A.Urut as varchar(5)))-5+1) KeyNoBukti,

        A.Devisi, A.NoBukti, A.NOURUT, A.Tanggal, A.Penerima, A.Keterangan,

	A.Debet, A.Kredit, A.Perkiraan, COALESCE(A.KodeVls,'IDR') KodeVls, COALESCE(A.Kurs,1) Kurs, COALESCE(A.DebetD,0) DebetD, COALESCE(A.KreditD,0) KreditD,

	A.TglInput, A.UserID, A.Urut, A.BuktiKas, A.UrutKas,

        A.Debet-A.Kredit Saldo, COALESCE(A.DebetD,0)-COALESCE(A.KreditD,0) SaldoD,

        COALESCE(Case when KodeVls='IDR' Then Case When Debet=0 Then Kredit else Debet  else Case when DebetD=0 Then KreditD else DebetD  ,0)Total,

        dbo.Terbilang(COALESCE(Case when KodeVls='IDR' Then Case When Debet=0 Then Kredit else Debet  else Case when DebetD=0 Then KreditD else DebetD  ,0))Terbilang

From dbBon A

where A.NoBukti=@NoBukti and Urut=@Urut and Perkiraan=@Perkiraan

Order by A.NoBukti


--exec SP_CetakBonSementara '';

-- sp_CetakInvoicePL
CREATE PROCEDURE IF NOT EXISTS sp_CetakInvoicePL AS -- DECLARE REMOVED,@kodeCustSupp Varchar(20),@NoSO Varchar(30),@NoSOX Varchar(30)

select @Tanggal=Tanggal from dbInvoicePL where NoBukti=@NoBukti

select @kodeCustSupp=KodeCustSupp from dbInvoicePL where NoBukti=@NoBukti

select @NoSO=NoSo from dbInvoicePLDet where NoBukti=@NoBukti and COALESCE(IsAngkutJasa,0)=1 Group By NoSO

select @NoSOX=NoSo from dbInvoicePLDet where NoBukti=@NoBukti Group By NoSO



if @Tipe=1

if @IsDP=1 

select /*CAST(CAST(CAST(ROUND(A.NoKwitansi/100000) AS INTEGER)))+'/'+Left(A.NoKwitansi,6)+Case When CAST(SUBSTRING(A.NoKwitansi,7,2 AS Int))=1 Then'I/' 

                                                                                         When CAST(SUBSTRING(A.NoKwitansi,7,2 AS Int))=2 Then'II/' 

                                                                                         When CAST(SUBSTRING(A.NoKwitansi,7,2 AS Int))=3 Then'III/' 

                                                                                         When CAST(SUBSTRING(A.NoKwitansi,7,2 AS Int))=4 Then'IV/' 

                                                                                         When CAST(SUBSTRING(A.NoKwitansi,7,2 AS Int))=5 Then'V/' 

                                                                                         When CAST(SUBSTRING(A.NoKwitansi,7,2 AS Int))=6 Then'VI/' 

                                                                                         When CAST(SUBSTRING(A.NoKwitansi,7,2 AS Int))=7 Then'VII/' 

                                                                                         When CAST(SUBSTRING(A.NoKwitansi,7,2 AS Int))=8 Then'VIII/' 

                                                                                         When CAST(SUBSTRING(A.NoKwitansi,7,2 AS Int))=9 Then'IX/' 

                                                                                         When CAST(SUBSTRING(A.NoKwitansi,7,2 AS Int))=10 Then'X/' 

                                                                                         When CAST(SUBSTRING(A.NoKwitansi,7,2 AS Int))=11 Then'XI/' 

                                                                                         When CAST(SUBSTRING(A.NoKwitansi,7,2 AS Int))=12 Then'XII/'   +SUBSTRING(A.NoKwitansi,9,2)*/ A.NoKwitansi  NoBukti,COALESCE(A.Keterangan,'')NoInv, A.Tanggal,c.telpon,p.alamatproject,

        Case when C.USAHA<>'' then C.USAHA+'. ' else '' + C.NAMACUSTSUPP NamaCustSupp,0 PPN,

		P.NAMAPROJECT UntukPembayaran, COALESCE(a.NilaiDP,0)DP , cast(null as datetime) TglBank,

		COALESCE(a.Total,0) TotalRp,COALESCE(a.Total,0) DPP,

		dbo.Terbilang(COALESCE(a.Total,0))+'Rupiah' MyTerbilang,case when COALESCE(IsTTD,0)=0 Then 'ALAM MONANDAR' else 'HENDRIK RAO'  NamaTTD,

		case when COALESCE(IsTTD,0)=0 Then 'Direktur' else 'Direktur'  Jabatan,

		dbo.Terbilang(COALESCE(a.Total,0)) TerbilangDP,a.KodeBank NoBank,G.NAMABANK,G.Nama Pemilik

	from dbDP A

	left outer join vwCUSTSUPP C on C.KODECUSTSUPP = A.KodeCustSupp

	left outer join DBPROJECT P on P.KODEPROJECT=A.KodeProject

	Left outer join DBBANK G on G.KODEBANK=a.KodeBank

	where A.NoKwitansi = @NoBukti


else

Update dbInvoicePLdet set Qnt=Qnt+Qntkoreksi,Qntkoreksi=0,Meas=0,Qnt2=Qnt/Case when Isi=0 Then 1 else Isi  where NoBukti=@NoBukti and Qntkoreksi<>0

/*

	select Left(A.NoBukti,8)+SUBSTR(A.Nobukti, LENGTH(A.Nobukti)-11+1)as NoBukti,COALESCE(A.Noinv,'')NoInv, A.Tanggal, A.KodeCustSupp,c.telpon,a.pono,

	     Case when C.USAHA<>'' then C.USAHA+'. ' else '' + C.NAMACUSTSUPP NamaCustSupp, C.ALAMAT,A.PPN, 

		0 Urut, 0 UrutTrans, '' NoSPB, 0 UrutSPB, B.KodeBrg, Case When SO.IsUbahNama=1 Then Max(B.Namabrg) else Case When COALESCE(D.IsJasa,0)=1 Then Max(B.Namabrg) else D.NamaBrg   NamaBrg, Sum(Case When B.NOSAT=2 Then B.QNT2 else B.QNT +COALESCE(B.QntKoreksi,0))Qnt, --S.QNT1, S.QNT2, 

		Case When B.NOSAT=2 Then B.SAT_2 else  B.SAT_1  SATUAN, D.SAT1, D.SAT2,

		B.NOSAT, Max(B.ISI)Isi, B.HARGA, B.DiscP, B.DiscRp, 

		B.DISCTOT, Max(B.KetDetail)KetDetail, B.HrgNetto, 

		sum(B.NDISKON) NDISKON, Sum(B.SUBTOTAL) SUBTOTAL, Sum(B.NDPP)NDPP, Sum(B.NPPN)NPPN, Sum(B.NNET)NNET, sum(B.NDISKONRp) NDISKONRp, 

		Sum(B.SUBTOTALRp)SUBTOTALRp, Sum(B.NDPPRp)NDPPRp, Sum(B.NPPNRp)NPPNRp, Sum(B.NNETRp)NNETRp,

		P.NAMA NamaPersh, P.KOTA KotaPersh,Bk.NAMABANK,Bk.KODEBANK,Bk.Nama,COALESCE(A.DP,0)DP,case when COALESCE(isTTD,0)=0 Then 'ALAM MONANDAR' else 'HENDRIK RAO'  NamaTTD,

		case when COALESCE(IsTTD,0)=0 Then 'Direktur' else 'Direktur'  Jabatan,SO.Hari ,Case When COALESCE(C.ispph21,0)=1 Then COALESCE(A.FRetensi,0) else SO.Retensi  Retensi,SO.PPH22,COALESCE(A.PPH21,0)PPH21,SO.PPHDPP,

		A.Tanggal+SO.HARI JatuhTempo,COALESCE(h.ALAMATPROJECT,'')ALAMATPROJECT, SUM((B.QNT+B.Meas)*B.HARGA*(B.DISC/100))DISKONTOTAL,j.DiskonNota,

		Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))RpRetensi,Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))RpDppRetensi,

		(Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then NilaiPPN else (1+NilaiPPN)  RpPPNRetensi,

		(Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then NilaiPPN else (1+NilaiPPN) ) RpNetRetensi,

		(Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100)RpPPH22,

		(Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then NilaiPPN else (1+NilaiPPN)  RpPPNPPH22,

		(Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then NilaiPPN else (1+NilaiPPN) )-

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then NilaiPPN else (1+NilaiPPN) )

		else

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then NilaiPPN else (1+NilaiPPN) )*-1

		

		RpKwt,

		SUM(Round(B.NNet,0))NetPPh21,COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0)/100)PtgRetensi21,

		SUM(Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100)Progres21, 

		(SUM(Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/(1+NilaiPPN) Progres21DPP,

		((SUM(Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/(1+NilaiPPN))*NilaiPPN Progres21PPN,

	    ((SUM(Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/(1+NilaiPPN))*(COALESCE(A.PPh21,0)/100)PPh21Final,	

	    (SUM(Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-(((SUM(Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/(1+NilaiPPN))*(COALESCE(A.PPh21,0)/100))Netditerima21,b.NilaiPPN,CAST(CAST(b.NilaiPPN*100 AS TINYINT AS TEXT))+'%' pajak 

	from dbInvoicePL A

	left outer join dbInvoicePLDet B on B.NoBukti = A.NoBukti

	left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti

	left outer join vwCUSTSUPP C on C.KODECUSTSUPP = A.KodeCustSupp

	left outer join DBBARANG D on D.KODEBRG = B.KodeBrg

	left outer join DBPERUSAHAAN P on 1=1

	left outer join DBBANK Bk on Bk.KodeBank=A.KodeBank

	left outer join dbSPBDet S on S.NoBukti=B.NoSPB and S.Urut=B.UrutSPB

	LEFT Outer Join (select a.NOBUKTI,HARI,SUM(COALESCE(BYANGKUT,0))BYANGKUT,AlamatKirim,KODEBRG,CAST(max(CAST(COALESCE(a.IsUbahNama,0 AS INTEGER AS TINYINT))))IsUbahNama,COALESCE(b.TERM1P,0)Retensi,COALESCE(b.TERM2P,0)PPH22,COALESCE(b.TERM3P,0)PPHDPP from DBSODET a Left Outer Join dbSO b On a.NOBUKTI=b.NOBUKTI Group by a.NOBUKTI,a.KODEBRG,HARI,AlamatKirim,COALESCE(a.IsUbahNama,0),COALESCE(b.TERM1P,0),COALESCE(b.TERM2P,0),COALESCE(b.TERM3P,0))SO on SO.NOBUKTI=B.NoSO and SO.KODEBRG=b.KodeBrg

    left outer join DBPROJECT H on h.KODEPROJECT=COALESCE(SO.AlamatKirim,A.NoBL)

    LEFT outer join (select NoBukti,SUM(COALESCE(NDISKON,0)) DiskonNota from dbInvoicePLDet group by NoBukti) J on J.NoBukti=A.NoBukti

	where A.NoBukti = @NoBukti

	Group by A.NoBukti,COALESCE(A.PPh21,0),COALESCE(A.NTotal,0),COALESCE(A.FRetensi,0),c.Ispph21, A.Tanggal, A.KodeCustSupp, C.NAMACUSTSUPP, C.ALAMAT,A.PPN,  B.KodeBrg, D.NamaBrg,c.telpon,h.ALAMATPROJECT,a.pono,

	B.SAT_1 , D.SAT1, D.SAT2,

		B.NOSAT, /*B.ISI,*/ B.HARGA, B.DiscP, B.DiscRp, 

		B.DISCTOT,  B.HrgNetto,SO.Retensi,SO.PPH22,SO.PPHDPP,rpInv.TotNet,  

		--B.NDISKON, B.NDISKONRp,

		SO.IsUbahNama,d.NamaBrg2, 

		P.NAMA , P.KOTA,Bk.NAMABANK,Bk.KODEBANK,A.DP,IsTTD,Bk.Nama,A.Noinv,SO.HARI,c.USAHA,d.IsJasa,b.NOSAT,b.SAT_2,j.DiskonNota,b.NilaiPPN

	order by Kodebrg,Max(B.Urut)

*/

select Left(A.NoBukti,8)+SUBSTR(A.Nobukti, LENGTH(A.Nobukti)-11+1)as NoBukti,COALESCE(A.Noinv,'')NoInv, A.Tanggal, A.KodeCustSupp,c.telpon,a.pono,

	     Case when C.USAHA<>'' then C.USAHA+'. ' else '' + C.NAMACUSTSUPP NamaCustSupp, C.ALAMAT,A.PPN, 

		0 Urut, 0 UrutTrans, '' NoSPB, 0 UrutSPB, B.KodeBrg, Case When SO.IsUbahNama=1 Then Max(B.Namabrg) else Case When COALESCE(D.IsJasa,0)=1 Then Max(B.Namabrg) else D.NamaBrg   NamaBrg, Sum(Case When B.NOSAT=2 Then B.QNT2 else B.QNT +COALESCE(B.QntKoreksi,0))Qnt, --S.QNT1, S.QNT2, 

		Case When B.NOSAT=2 Then B.SAT_2 else  B.SAT_1  SATUAN, D.SAT1, D.SAT2,

		B.NOSAT, Max(B.ISI)Isi, B.HARGA, B.DiscP, B.DiscRp, 

		B.DISCTOT, Max(B.KetDetail)KetDetail, B.HrgNetto, 

		sum(B.NDISKON) NDISKON, Sum(B.SUBTOTAL) SUBTOTAL, Sum(Case When COALESCE(A.FRetensi,0)<>0 Then B.NDPPRRp else B.NDPP )NDPP, Sum(Case When COALESCE(A.FRetensi,0)<>0  Then B.NPPNRRp else B.NPPN )NPPN, Sum(Case When COALESCE(A.FRetensi,0)<>0 Then B.NNETRRp else B.NNET )NNET, sum(B.NDISKONRp) NDISKONRp, 

		Sum(B.SUBTOTALRp)SUBTOTALRp, Sum(Case When COALESCE(A.FRetensi,0)<>0 Then B.NDPPRRp else B.NDPPRp )NDPPRp, Sum(Case When COALESCE(A.FRetensi,0)<>0 Then B.NPPNRRp else B.NPPNRp )NPPNRp, Sum(Case When COALESCE(A.FRetensi,0)<>0 Then B.NNETRRp else B.NNETRp )NNETRp,

		P.NAMA NamaPersh, P.KOTA KotaPersh,Bk.NAMABANK,Bk.KODEBANK,Bk.Nama,COALESCE(A.DP,0)DP,case when COALESCE(isTTD,0)=0 Then 'ALAM MONANDAR' else 'HENDRIK RAO'  NamaTTD,

		case when COALESCE(IsTTD,0)=0 Then 'Direktur' else 'Direktur'  Jabatan,SO.Hari ,Case When COALESCE(C.ispph21,0)=1 Then COALESCE(A.FRetensi,0) else SO.Retensi  Retensi,SO.PPH22,COALESCE(A.PPH21,0)PPH21,SO.PPHDPP,

		A.Tanggal+SO.HARI JatuhTempo,COALESCE(h.ALAMATPROJECT,h.NamaProject)ALAMATPROJECT, SUM((B.QNT+B.Meas)*B.HARGA*(B.DISC/100))DISKONTOTAL,j.DiskonNota,

		Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))RpRetensi,Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))RpDppRetensi,

		(Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1  RpPPNRetensi,

		(Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 ) RpNetRetensi,

		(Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100)RpPPH22,

		(Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1  RpPPNPPH22,

		(Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		

		RpKwt,

		SUM(Round(B.NNet,0))NetPPh21,COALESCE(A.NTotal,0)*(COALESCE(a.FRetensi,0)/100)PtgRetensi21,

		SUM(Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(a.FRetensi,0))/100)Progres21, 

		(SUM(Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(a.FRetensi,0))/100))/1.1 Progres21DPP,

		((SUM(Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(a.FRetensi,0))/100))/1.1)*0.1 Progres21PPN,

	    ((SUM(Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(a.FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100)PPh21Final,	

	    (SUM(Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(a.FRetensi,0))/100))-(((SUM(Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(a.FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))Netditerima21 

	,b.NilaiPPN,CAST(CAST(b.NilaiPPN*100 AS TINYINT AS TEXT))+'%' pajak,

	CAST(CAST(COALESCE(a.FRetensi,0 AS TINYINT AS TEXT)))+'%' Retensi,COALESCE(a.FRetensi,0)/100*Sum(B.NDPP)TRetensi

	from dbInvoicePL A

	left outer join dbInvoicePLDet B on B.NoBukti = A.NoBukti

	left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti

	left outer join vwCUSTSUPP C on C.KODECUSTSUPP = A.KodeCustSupp

	left outer join DBBARANG D on D.KODEBRG = B.KodeBrg

	left outer join DBPERUSAHAAN P on 1=1

	left outer join DBBANK Bk on Bk.KodeBank=A.KodeBank

	left outer join dbSPBDet S on S.NoBukti=B.NoSPB and S.Urut=B.UrutSPB

	LEFT Outer Join (select a.NOBUKTI,HARI,SUM(COALESCE(BYANGKUT,0))BYANGKUT,AlamatKirim,KODEBRG,CAST(max(CAST(COALESCE(a.IsUbahNama,0 AS INTEGER AS TINYINT))))IsUbahNama,COALESCE(b.TERM1P,0)Retensi,COALESCE(b.TERM2P,0)PPH22,COALESCE(b.TERM3P,0)PPHDPP from DBSODET a Left Outer Join dbSO b On a.NOBUKTI=b.NOBUKTI Group by a.NOBUKTI,a.KODEBRG,HARI,AlamatKirim,COALESCE(a.IsUbahNama,0),COALESCE(b.TERM1P,0),COALESCE(b.TERM2P,0),COALESCE(b.TERM3P,0))SO on SO.NOBUKTI=B.NoSO and SO.KODEBRG=b.KodeBrg

    left outer join DBPROJECT H on h.KODEPROJECT=COALESCE(SO.AlamatKirim,A.NoBL)

    LEFT outer join (select NoBukti,SUM(COALESCE(NDISKON,0)) DiskonNota from dbInvoicePLDet group by NoBukti) J on J.NoBukti=A.NoBukti

	where A.NoBukti = @NoBukti

	Group by A.NoBukti,COALESCE(A.PPh21,0),COALESCE(A.NTotal,0),COALESCE(A.FRetensi,0),c.Ispph21, A.Tanggal, A.KodeCustSupp, C.NAMACUSTSUPP, C.ALAMAT,A.PPN,  B.KodeBrg, D.NamaBrg,c.telpon,h.ALAMATPROJECT,a.pono,

	B.SAT_1 , D.SAT1, D.SAT2,

		B.NOSAT, /*B.ISI,*/ B.HARGA, B.DiscP, B.DiscRp, 

		B.DISCTOT,  B.HrgNetto,SO.Retensi,SO.PPH22,SO.PPHDPP,rpInv.TotNet,  

		--B.NDISKON, B.NDISKONRp,

		SO.IsUbahNama,d.NamaBrg2, 

		P.NAMA , P.KOTA,Bk.NAMABANK,Bk.KODEBANK,A.DP,IsTTD,Bk.Nama,A.Noinv,SO.HARI,c.USAHA,d.IsJasa,b.NOSAT,b.SAT_2,j.DiskonNota,b.NilaiPPN

	,H.NamaProject

	order by Kodebrg,Max(B.Urut)


if @Tipe=2 

select Left(A.NoBukti,8)+SUBSTR(A.Nobukti, LENGTH(A.Nobukti)-11+1) as NoBukti,COALESCE(A.Noinv,'')NoInv, A.Tanggal,

	    Case when C.USAHA<>'' then C.USAHA+'. ' else '' + C.NAMACUSTSUPP NamaCustSupp,A.PPN,

		'' UntukPembayaran, b1.NAMABANK NamaBank,b1.NAMA Pemilik,COALESCE(a.DP,0)DP, A.KodeBank NoBank, cast(null as datetime) TglBank,

		/*SUM(B.NDPPRp)-(A.DP)+Case when A.PPN=0 Then 0 else (SUM(B.NDPPRp)-(A.DP))*NilaiPPN  TotalRp,SUM(B.NDPPRp)DPP,

		dbo.Terbilang(SUM(B.NDPPRp)-(A.DP)+Case when A.PPN=0 Then 0 else (SUM(B.NDPPRp)-(A.DP))*NilaiPPN ) MyTerbilang,case when COALESCE(isTTD,0)=0 Then 'ALAM MONANDAR' else 'ALAM MONANDAR'  NamaTTD,

		case when COALESCE(IsTTD,0)=0 Then 'Direktur' else 'Direktur'  Jabatan,

		dbo.Terbilang(A.DP) TerbilangDP,A.NoBL Kodeproject,p.NAMAPROJECT+CHAR(13)+p.ALAMATPROJECT Alamat--c.ALAMAT*/

		( SUM(Case When COALESCE(A.FRetensi,0)<>0 Then B.NDPPRRp else B.NDPPRp ) -(A.DP))+round(Case when A.PPN=0 Then 0 else ( SUM(Case When COALESCE(A.FRetensi,0)<>0 Then B.NDPPRRp else B.NDPPRp  ) -(A.DP))*NilaiPPN ,2) TotalRp,SUM(Case When COALESCE(A.FRetensi,0)<>0 Then B.NDPPRRp else B.NDPPRp )DPP,

		/*dbo.Terbilang((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then NilaiPPN else (1+NilaiPPN) )-

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then NilaiPPN else (1+NilaiPPN) )

		else

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then NilaiPPN else (1+NilaiPPN) )*-1

		) MyTerbilang*/dbo.Terbilang( SUM(Case When COALESCE(A.FRetensi,0)<>0 Then B.NDPPRRp else B.NDPPRp ) -(A.DP)+Case when A.PPN=0 Then 0 else ( SUM(Case When COALESCE(A.FRetensi,0)<>0 Then B.NDPPRRp else B.NDPPRp ) -(A.DP))*NilaiPPN ) MyTerbilang,case when COALESCE(a.IsTTD,0)=0 Then 'ALAM MONANDAR' else 'HENDRIK RAO'  NamaTTD,

		case when COALESCE(IsTTD,0)=0 Then 'Direktur' else 'Direktur'  Jabatan,

		dbo.Terbilang(A.DP) TerbilangDP,A.NoBL Kodeproject,Case when A.kodeCustSupp in('G0000040') Then c.Alamat else COALESCE(p.ALAMATPROJECT,p.namaProject)  Alamat--c.ALAMAT

		,Sum(B.NDPP)NDPP,Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))RpRetensi,Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))RpDppRetensi,

		(Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then NilaiPPN else (1+NilaiPPN)  RpPPNRetensi,

		(Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then NilaiPPN else (1+NilaiPPN) ) RpNetRetensi,

		(Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100)RpPPH22,

		(Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then NilaiPPN else (1+NilaiPPN)  RpPPNPPH22,

		(Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then NilaiPPN else (1+NilaiPPN) )-

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then NilaiPPN else (1+NilaiPPN) )

		else

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then NilaiPPN else (1+NilaiPPN) )*-1

		

		RpKwt,A.PoL NoBAP,A.PoD NoBASTB,A.NameOfVessel noSPBarang,SO.Retensi,SO.PPH22,

		Case When Year(A.ShipOnBoardDate)=1899 Then Null else A.ShipOnBoardDate   TglBAP,Case When  Year(A.ETADestination)=1899 Then Null else A.ETADestination  TglBASTB,A.TglKMK  TglSPBarang,

		b.NilaiPPN,CAST(CAST(b.NilaiPPN*100 AS TINYINT AS TEXT))+'%' pajak

	from dbInvoicePL A

	left outer join dbInvoicePLDet B on B.NoBukti = A.NoBukti

	left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti

	left outer join DBBANK B1 On B1.KODEBANK=A.KodeBank

	left outer join vwCUSTSUPP C on C.KODECUSTSUPP = A.KodeCustSupp

	left outer join DBPROJECT P on P.KODEPROJECT=A.NoBL

	LEFT Outer Join (select a.NOBUKTI,SUM(COALESCE(BYANGKUT,0))BYANGKUT,COALESCE(TERM1P,0)Retensi,COALESCE(TERM2P,0)PPH22,COALESCE(TERM3P,0)PPHDPP, COALESCE(b.TIPESC,0) TIPESC from DBSODET a Left Outer Join dbSO b on a.NOBUKTI=b.NOBUKTI Group by a.NOBUKTI,COALESCE(TERM1P,0),COALESCE(TERM2P,0),COALESCE(TERM3P,0), COALESCE(b.TIPESC,0))SO on SO.NOBUKTI=B.NoSO

	where A.NoBukti = @NoBukti

	group by A.NoBukti, A.Tanggal, C.NAMACUSTSUPP,b1.NAMABANK,a.KodeBank,a.DP,b1.Nama,IsTTD,A.PPN,A.Noinv,

		P.NAMAPROJECT,c.USAHA,A.NoBL,p.ALAMATPROJECT ,c.ALAMAT,a.KodecustSupp

	,SO.Retensi,SO.PPH22,SO.PPHDPP,rpInv.TotNet,

	A.PoL ,A.PoD ,A.NameOfVessel ,a.FRetensi,

		A.ShipOnBoardDate ,A.ETADestination ,A.TglKMK,SO.TIPESC,b.NilaiPPN



if  @Tipe=3

--select * from DBInvoicePL where NoBukti='ca/invc/0414/00008'

--select * from db

	select  Case when C.USAHA<>'' then C.USAHA+'. ' else '' +C.NAMACUSTSUPP NamaCustSupp, C.ALAMAT ALAMATCUSTSUPP,C.TELPON,C.FAX, 

	case when a.PPN<>0 then a.NoInv else 	Left(A.NoBukti,6)+SUBSTR(A.Nobukti, LENGTH(A.Nobukti)-11+1)  NoTandaTerima,

		P.NAMAPROJECT,

		Left(A.NoBukti,6)+SUBSTR(A.Nobukti, LENGTH(A.Nobukti)-11+1) NoInvoice,COALESCE(Noinv,'')NoInv, A.Tanggal TglInvoice,

		SUM(B.NDPPRp)-(A.DP)+Case when A.PPN=0 Then 0 else (SUM(B.NDPPRp)-(A.DP))*NilaiPPN  NilaiKwitansi, A.Tanggal TglKwitansi,

		a.noseri+'.'+A.NoPajak nopajak, A.TglFPJ,A.PPN,

		'' Inputan4, 

		'' Inputan5,

		'' Inputan6,

		'' Inputan7,

		'' Inputan8,

		Case When SO.HARI=0 Then '' else 'Term  '+CAST(SO.Hari AS TEXT)+' Hari'  Catatan,b.NilaiPPN,CAST(CAST(b.NilaiPPN*100 AS TINYINT AS TEXT))+'%' pajak 

	from dbInvoicePL A

	left outer join dbInvoicePLDet B on B.NoBukti = A.NoBukti

	left outer join vwCUSTSUPP C on C.KODECUSTSUPP = A.KodeCustSupp

	left outer join DBPROJECT P on P.KODEPROJECT=A.NoBL

	LEFT Outer Join (select a.NOBUKTI,b.HARI,SUM(COALESCE(BYANGKUT,0))BYANGKUT from DBSODET a Left Outer Join dbSO b on a.NoBukti=b.NoBukti Group by a.NOBUKTI,b.HARI)SO on SO.NOBUKTI=B.NoSO

	where A.NoBukti = @NoBukti

	group by A.NoBukti, A.Tanggal, C.NAMACUSTSUPP,a.PONo,a.NoSeri,a.DP,

		A.NoPajak, A.TglFPJ, C.ALAMAT, P.NAMAPROJECT,A.PPN,A.Noinv,c.USAHA,SO.HARI,C.TELPON,C.FAX,NilaiPPN


if  @Tipe=4

-- IF EXISTS REMOVED
)

Select @Tanggal TglINV,case when COALESCE(a1.IsTTD,0)=0 Then 'Direktur' else 'Direktur'  Jabatan,'IMAM' dibuat

 ,'ADMIN.INVOICE' JabBuat,case when COALESCE(a1.isTTD,0)=0 Then 'ALAM MONANDAR' else 'HENDRIK RAO'  NamaTTD

 ,b.USAHA,b.Kota,Urut,a.Tanggal,a.NoBukti,NoPOLkend,a.KodeBrg,a.NAMABRG,QntSisa, Case When UPPER(SAT_1)='PCS' Then ROUND(QntSisa,2) else QntSisa  QntSisaPcs,Case When UPPER(SAT_2)='PCS' Then Round(Qnt2Sisa,2)else Qnt2Sisa  Qnt2SisaPcs ,Qnt2Sisa ,SAT_1,SAT_2,a.KodeCustSupp,a.NAMACUSTSUPP

 ,NAMAPROJECT,a.LM,

 COALESCE((Select Sum(QntSisa) QntLalu from vwReportRekapKirim where NoBukti in(Select NoSPB from dbInvoicePLDet a Left Outer Join dbInvoicePL b on a.NoBukti=b.NoBukti where  b.Tanggal<@Tanggal and NOSO in(a2.NoSO)  and b.KodeCustSupp=@kodeCustSupp)),0) QntLalu,

 Case When D.ISI2>D.ISI1 Then D.SAT1 when D.ISI2=D.ISI1 Then D.SAT1 else D.SAT2  SA_1,Case When D.ISI2<D.ISI1 Then D.SAT1 WHEN D.ISI2=D.ISI1 Then D.SAT2 else D.SAT2  SA_2,

 '' NoSAT

 from vwReportRekapKirim a

 Left Outer Join dbInvoicePL a1 On a1.NoBukti=@NoBukti

 Left Outer Join DBBARANG D on d.KODEBRG=a.KodeBrg

 Left Outer Join(Select NoBukti,NOSO from dbInvoicePLDet group by NoBukti,NoSO)a2 On a2.NoBukti=a1.NoBukti 

 Left Outer Join dbCustSupp b on a.KodeCustSupp=b.KODECUSTSUPP

 where a.NoSO in(Select NoSO from dbInvoicePLDet where NoBukti=@NoBukti)

 order by a.NAMABRG 


else

Select @Tanggal TglINV,case when COALESCE(a1.IsTTD,0)=0 Then 'Direktur' else 'Direktur'  Jabatan,'IMAM' dibuat

 ,'ADMIN.INVOICE' JabBuat,case when COALESCE(a1.isTTD,0)=0 Then 'ALAM MONANDAR' else 'HENDRIK RAO'  NamaTTD

 ,b.USAHA,b.Kota,Urut,a.Tanggal,a.NoBukti,NoPOLkend,a.KodeBrg,a.NAMABRG,QntSisa, Case When UPPER(SAT_1)='PCS' Then ROUND(QntSisa,2) else QntSisa  QntSisaPcs,Case When UPPER(SAT_2)='PCS' Then Round(Qnt2Sisa,2)else Qnt2Sisa  Qnt2SisaPcs ,Qnt2Sisa ,SAT_1,SAT_2,a.KodeCustSupp,a.NAMACUSTSUPP

 ,NAMAPROJECT,a.LM,

 COALESCE((Select Sum(QntSisa) QntLalu from vwReportRekapKirim where NoBukti in(Select NoSPB from dbInvoicePLDet a Left Outer Join dbInvoicePL b on a.NoBukti=b.NoBukti where  b.Tanggal<@Tanggal and NOSO in(a2.NoSO)  and b.KodeCustSupp=@kodeCustSupp)),0) QntLalu,

 Case When D.ISI2>D.ISI1 Then D.SAT1 when D.ISI2=D.ISI1 Then D.SAT1 else D.SAT2  SA_1,Case When D.ISI2<D.ISI1 Then D.SAT1 WHEN D.ISI2=D.ISI1 Then D.SAT2 else D.SAT2  SA_2,

 '' NoSAT

 from vwReportRekapKirim a

 Left Outer Join dbInvoicePL a1 On a1.NoBukti=@NoBukti

 Left Outer Join DBBARANG D on d.KODEBRG=a.KodeBrg

 Left Outer Join(Select NoBukti,NOSO from dbInvoicePLDet group by NoBukti,NoSO)a2 On a2.NoBukti=a1.NoBukti 

 Left Outer Join dbCustSupp b on a.KodeCustSupp=b.KODECUSTSUPP

 where a.NoBukti in(Select NoSPB from dbInvoicePLDet where NoBukti=@NoBukti)

 order by a.NAMABRG,a.Tanggal;

-- sp_CetakInvoicePLNP
CREATE PROCEDURE IF NOT EXISTS sp_CetakInvoicePLNP AS if @Pilih=0

WITH CetakINVNP (NoBukti,	NoInv,	Tanggal,	KodeCustSupp,	telpon,	pono,	NamaCustSupp,	ALAMAT,	PPN,	Urut,	UrutTrans,	NoSPB,	UrutSPB,	KodeBrg,

		NamaBrg,	Qnt,	SATUAN,	SAT1,	SAT2,

		UntukPembayaran,NamaBank,Kodebank,Nama,Pemilik,DP,NoBank,	TglBank,NOSAT	,ISI,	HARGA,	DiscP,	DiscRp,	DISCTOT,	KetDetail	,HrgNetto,

		TotalRp,DPP,MyTerbilang,	NDISKON	,SUBTOTAL,	NDPP,	NPPN,	NNET,	NDISKONRp,	SUBTOTALRp,	NDPPRp	,NPPNRp,	NNETRp,	NamaPersh,	KotaPersh,	

				NamaTTD,	Jabatan,	Hari,	Retensi,	PPH22,	PPHDPP,	JatuhTempo,	ALAMATPROJECT,	DISKONTOTAL,	DiskonNota,	RpRetensi,	RpDppRetensi,	RpPPNRetensi,	RpNetRetensi,	RpPPH22,	RpPPNPPH22,	RpKwt,

				NoTandaTerima,

		NAMAPROJECT,

		 NoInvoice,  TglInvoice,

		 NilaiKwitansi,  TglKwitansi,

		nopajak, TglFPJ,

		 Inputan4, 

		 Inputan5,

		 Inputan6,

		 Inputan7,

		 Inputan8,

		 Catatan,

		  ALAMATCUSTSUPP,FAX    )



AS

(

	select Left(A.NoBukti,8)+SUBSTR(A.Nobukti, LENGTH(A.Nobukti)-11+1)as NoBukti,COALESCE(A.Noinv,'')NoInv, A.Tanggal, A.KodeCustSupp,c.telpon,a.pono,

	     Case when C.USAHA<>'' then C.USAHA+'. ' else '' + C.NAMACUSTSUPP NamaCustSupp, C.ALAMAT,0 PPN, 

		0 Urut, 0 UrutTrans, '' NoSPB, 0 UrutSPB, B.KodeBrg, Case When SO.IsUbahNama=1 Then D.NamaBrg2 else Case When COALESCE(D.IsJasa,0)=1 Then B.Namabrg else D.NamaBrg   NamaBrg, Sum(Case When B.NOSAT=2 Then B.QNT2 else B.QNT +COALESCE(B.QntKoreksi,0))Qnt, --S.QNT1, S.QNT2, 

		Case When B.NOSAT=2 Then B.SAT_2 else  B.SAT_1  SATUAN, D.SAT1, D.SAT2,

		'' UntukPembayaran, Bk.NAMABANK NamaBank,bk.KODEBANK,Bk.NAMA,Bk.NAMA Pemilik,COALESCE(a.DP,0)DP, A.KodeBank NoBank, cast(null as datetime) TglBank,

		B.NOSAT, max(B.ISI) ISI, B.HARGA, B.DiscP, B.DiscRp, 

		B.DISCTOT, Max(B.KetDetail)KetDetail, B.HrgNetto, 

		SUM(B.NDPPRp)-(A.DP)TotalRp,SUM(B.NDPPRp)DPP,

		dbo.Terbilang(SUM(B.NDPPRp)-(A.DP)) MyTerbilang,

		sum(B.NDISKON) NDISKON, Sum(B.SUBTOTAL) SUBTOTAL, Sum(B.SUBTOTAL)-sum(B.NDISKON)NDPP, 0 NPPN, Sum(B.SUBTOTAL)NNET, sum(B.NDISKONRp) NDISKONRp, 

		Sum(B.SUBTOTALRp)SUBTOTALRp, Sum(B.SUBTOTALRp)NDPPRp, 0 NPPNRp, Sum(B.SUBTOTAL)NNETRp,

		P.NAMA NamaPersh, P.KOTA KotaPersh,case when COALESCE(isTTD,0)=0 Then 'ALAM MONANDAR' else 'ALAM MONANDAR'  NamaTTD,

		case when COALESCE(IsTTD,0)=0 Then 'Direktur' else 'Direktur'  Jabatan,SO.Hari ,SO.Retensi,SO.PPH22,SO.PPHDPP,

		A.Tanggal+SO.HARI JatuhTempo,h.ALAMATPROJECT, SUM((B.QNT+B.Meas)*B.HARGA*(B.DISC/100))DISKONTOTAL,j.DiskonNota,

		Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))RpRetensi,Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))RpDppRetensi,

		(Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1  RpPPNRetensi,

		(Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 ) RpNetRetensi,

		(Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100)RpPPH22,

		(Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1  RpPPNPPH22,

		(Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		

		RpKwt,

		Left(A.NoBukti,6)+SUBSTR(A.Nobukti, LENGTH(A.Nobukti)-11+1) NoTandaTerima,

		NAMAPROJECT,

		Left(A.NoBukti,6)+SUBSTR(A.Nobukti, LENGTH(A.Nobukti)-11+1) NoInvoice, A.Tanggal TglInvoice,

		SUM(B.NDPPRp)-(A.DP) NilaiKwitansi, A.Tanggal TglKwitansi,

		a.noseri+'.'+A.NoPajak nopajak, A.TglFPJ,

		'' Inputan4, 

		'' Inputan5,

		'' Inputan6,

		'' Inputan7,

		'' Inputan8,

		Case When SO.HARI=0 Then '' else 'Term  '+CAST(SO.Hari AS TEXT)+' Hari'  Catatan ,

		C.ALAMAT ALAMATCUSTSUPP,C.FAX  

	from dbInvoicePL A

	left outer join dbInvoicePLDet B on B.NoBukti = A.NoBukti

	left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti

	left outer join vwCUSTSUPP C on C.KODECUSTSUPP = A.KodeCustSupp

	left outer join DBBARANG D on D.KODEBRG = B.KodeBrg

	left outer join DBPERUSAHAAN P on 1=1

	left outer join DBBANK Bk on Bk.KodeBank=A.KodeBank

	left outer join dbSPBDet S on S.NoBukti=B.NoSPB and S.Urut=B.UrutSPB

	LEFT Outer Join (select a.NOBUKTI,HARI,SUM(COALESCE(BYANGKUT,0))BYANGKUT,AlamatKirim,COALESCE(a.IsUbahNama,0)IsUbahNama,COALESCE(b.TERM1P,0)Retensi,COALESCE(b.TERM2P,0)PPH22,COALESCE(b.TERM3P,0)PPHDPP from DBSODET a Left Outer Join dbSO b On a.NOBUKTI=b.NOBUKTI Group by a.NOBUKTI,HARI,AlamatKirim,COALESCE(a.IsUbahNama,0),COALESCE(b.TERM1P,0),COALESCE(b.TERM2P,0),COALESCE(b.TERM3P,0))SO on SO.NOBUKTI=B.NoSO

    left outer join DBPROJECT H on h.KODEPROJECT=COALESCE(so.AlamatKirim,A.NoBL)

    LEFT outer join (select NoBukti,SUM(COALESCE(NDISKON,0)) DiskonNota from dbInvoicePLDet group by NoBukti) J on J.NoBukti=A.NoBukti

	where A.NoBukti = @NoBukti

	Group by A.NoBukti, A.Tanggal, A.KodeCustSupp, C.NAMACUSTSUPP, C.ALAMAT,A.PPN,  B.KodeBrg, D.NamaBrg,c.telpon,h.ALAMATPROJECT,a.pono,

	B.SAT_1 , D.SAT1, D.SAT2,

		B.NOSAT, B.HARGA, B.DiscP, B.DiscRp, 

		B.DISCTOT,  B.HrgNetto,SO.Retensi,SO.PPH22,SO.PPHDPP,rpInv.TotNet, 

		--B.NDISKON, B.NDISKONRp,

		SO.IsUbahNama,d.NamaBrg2, 

		P.NAMA , P.KOTA,Bk.NAMABANK,Bk.KODEBANK,A.DP,IsTTD,Bk.Nama,A.Noinv,SO.HARI,c.USAHA,d.IsJasa,b.Namabrg,b.NOSAT,b.SAT_2,j.DiskonNota

	    ,Bk.NAMABANK ,Bk.NAMA ,COALESCE(a.DP,0), A.KodeBank,NAMAPROJECT,NoSeri,NoPajak,TglFPJ,c.FAX

	)

	

	select * from CetakINVNP

	order by Kodebrg,Urut



else if @Pilih=1

with 

 CetakKw(

 NoBukti,NoInv,Tanggal,	NamaCustSupp, 	PPN	,UntukPembayaran,	NamaBank,	Pemilik	,DP,	NoBank,	TglBank,	TotalRp	,DPP	,MyTerbilang,	NamaTTD	,Jabatan,	TerbilangDP,	Kodeproject,	Alamat,	NDPP,	RpRetensi	,RpDppRetensi,	RpPPNRetensi,	RpNetRetensi,	RpPPH22	,RpPPNPPH22,	RpKwt,	NoBAP,	NoBASTB	,noSPBarang,	Retensi	,PPH22	,TglBAP	,TglBASTB,	TglSPBarang

 )

 AS

 (select COALESCE(A.Noinv,'') as NoBukti,COALESCE(A.Noinv,'')NoInv, A.Tanggal,

	    Case when C.USAHA<>'' then C.USAHA+'. ' else '' + C.NAMACUSTSUPP NamaCustSupp,0 PPN,

		'' UntukPembayaran, b1.NAMABANK NamaBank,b1.NAMA Pemilik,COALESCE(a.DP,0)DP, A.KodeBank NoBank, cast(null as datetime) TglBank,

		/*SUM(B.NDPPRp)-(A.DP)+Case when A.PPN=0 Then 0 else (SUM(B.NDPPRp)-(A.DP))*0.1  TotalRp,SUM(B.NDPPRp)DPP,

		dbo.Terbilang(SUM(B.NDPPRp)-(A.DP)+Case when A.PPN=0 Then 0 else (SUM(B.NDPPRp)-(A.DP))*0.1 ) MyTerbilang,case when COALESCE(isTTD,0)=0 Then 'ALAM MONANDAR' else 'ALAM MONANDAR'  NamaTTD,

		case when COALESCE(IsTTD,0)=0 Then 'Direktur' else 'Direktur'  Jabatan,

		dbo.Terbilang(A.DP) TerbilangDP,A.NoBL Kodeproject,p.ALAMATPROJECT Alamat--c.ALAMAT

	from dbInvoicePL A

	left outer join dbInvoicePLDet B on B.NoBukti = A.NoBukti

	left outer join DBBANK B1 On B1.KODEBANK=A.KodeBank

	left outer join vwCUSTSUPP C on C.KODECUSTSUPP = A.KodeCustSupp

	left outer join DBPROJECT P on P.KODEPROJECT=A.NoBL

	LEFT Outer Join (select NoBukti,SUM(COALESCE(BYANGKUT,0))BYANGKUT from DBSODET Group by NOBUKTI)SO on SO.NOBUKTI=B.NoSO

	where A.NoBukti = @NoBukti

	group by A.NoBukti, A.Tanggal, C.NAMACUSTSUPP,b1.NAMABANK,a.KodeBank,a.DP,b1.Nama,IsTTD,A.PPN,A.Noinv,

		P.NAMAPROJECT,c.USAHA,A.NoBL,p.ALAMATPROJECT --c.ALAMAT

	*/

	SUM(B.SUBTOTALRp)-sum(B.NDISKON)-(A.DP) TotalRp,SUM(B.SUBTOTALRp)-sum(B.NDISKON)DPP,

		/*dbo.Terbilang((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		) MyTerbilang*/dbo.Terbilang(SUM(B.SUBTOTALRp)-sum(B.NDISKON)-(A.DP)) MyTerbilang,case when COALESCE(a.isTTD,0)=0 Then 'ALAM MONANDAR' else 'HENDRIK RAO'  NamaTTD,

		case when COALESCE(IsTTD,0)=0 Then 'Direktur' else 'Direktur'  Jabatan,

		dbo.Terbilang(A.DP) TerbilangDP,A.NoBL Kodeproject,p.ALAMATPROJECT Alamat--c.ALAMAT

		,Sum(B.SUBTOTAL)NDPP,Sum(B.SUBTOTALRp*(CAST(SO.Retensi AS Float)/100.00))RpRetensi,Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))RpDppRetensi,

		(Sum(B.SUBTOTALRp)-Sum(B.SUBTOTALRp*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1  RpPPNRetensi,

		(Sum(B.SUBTOTALRp)-Sum(B.SUBTOTALRp*(CAST(SO.Retensi AS Float)/100.00)))+((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 ) RpNetRetensi,

		(Sum(B.SUBTOTALRp)-Sum(B.SUBTOTALRp*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100)RpPPH22,

		(Sum(B.SUBTOTALRp)-Sum(B.SUBTOTALRp*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1  RpPPNPPH22,

		(Sum(B.SUBTOTALRp)-Sum(B.SUBTOTALRp*(CAST(SO.Retensi AS Float)/100.00)))+((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		((Sum(B.SUBTOTALRp)-Sum(B.SUBTOTALRp*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		

		RpKwt,A.PoL NoBAP,A.PoD NoBASTB,A.NameOfVessel noSPBarang,SO.Retensi,SO.PPH22,

		Case When Year(A.ShipOnBoardDate)=1899 Then Null else A.ShipOnBoardDate   TglBAP,Case When  Year(A.ETADestination)=1899 Then Null else A.ETADestination  TglBASTB,A.TglKMK  TglSPBarang

	from dbInvoicePL A

	left outer join dbInvoicePLDet B on B.NoBukti = A.NoBukti

	left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti

	left outer join DBBANK B1 On B1.KODEBANK=A.KodeBank

	left outer join vwCUSTSUPP C on C.KODECUSTSUPP = A.KodeCustSupp

	left outer join DBPROJECT P on P.KODEPROJECT=A.NoBL

	LEFT Outer Join (select a.NOBUKTI,SUM(COALESCE(BYANGKUT,0))BYANGKUT,COALESCE(TERM1P,0)Retensi,COALESCE(TERM2P,0)PPH22,COALESCE(TERM3P,0)PPHDPP, COALESCE(b.TIPESC,0) TIPESC from DBSODET a Left Outer Join dbSO b on a.NOBUKTI=b.NOBUKTI Group by a.NOBUKTI,COALESCE(TERM1P,0),COALESCE(TERM2P,0),COALESCE(TERM3P,0), COALESCE(b.TIPESC,0))SO on SO.NOBUKTI=B.NoSO

	where A.NoBukti = @NoBukti

	group by A.NoBukti, A.Tanggal, C.NAMACUSTSUPP,b1.NAMABANK,a.KodeBank,a.DP,b1.Nama,IsTTD,A.PPN,A.Noinv,

		P.NAMAPROJECT,c.USAHA,A.NoBL,p.ALAMATPROJECT --c.ALAMAT

	,SO.Retensi,SO.PPH22,SO.PPHDPP,rpInv.TotNet,

	A.PoL ,A.PoD ,A.NameOfVessel ,

		A.ShipOnBoardDate ,A.ETADestination ,A.TglKMK,COALESCE(SO.TIPESC,0)

)

select * from CetakKw


else if @Pilih=2 

With CetakTerima(NamaCustSupp,	ALAMATCUSTSUPP,	TELPON,	FAX	,NoTandaTerima,	NAMAPROJECT,	NoInvoice,	NoInv,	TglInvoice,	NilaiKwitansi	,TglKwitansi,	nopajak	,TglFPJ	,PPN,	Inputan4,	Inputan5,	Inputan6,	Inputan7,	Inputan8	,Catatan)

AS

(select  Case when C.USAHA<>'' then C.USAHA+'. ' else '' +C.NAMACUSTSUPP NamaCustSupp, C.ALAMAT ALAMATCUSTSUPP,C.TELPON,C.FAX,  

	case when a.PPN<>0 then a.NoInv else 	Left(A.NoBukti,6)+SUBSTR(A.Nobukti, LENGTH(A.Nobukti)-11+1)  NoTandaTerima,

		P.NAMAPROJECT,

		Left(A.NoBukti,6)+SUBSTR(A.Nobukti, LENGTH(A.Nobukti)-11+1) NoInvoice,COALESCE(Noinv,'')NoInv, A.Tanggal TglInvoice,

		SUM(B.SUBTOTALRp)-(A.DP) NilaiKwitansi, A.Tanggal TglKwitansi,

		a.noseri+'.'+A.NoPajak nopajak, A.TglFPJ,A.PPN,

		'' Inputan4, 

		'' Inputan5,

		'' Inputan6,

		'' Inputan7,

		'' Inputan8,

		Case When SO.HARI=0 Then '' else 'Term  '+CAST(SO.Hari AS TEXT)+' Hari'  Catatan 

	from dbInvoicePL A

	left outer join dbInvoicePLDet B on B.NoBukti = A.NoBukti

	left outer join vwCUSTSUPP C on C.KODECUSTSUPP = A.KodeCustSupp

	left outer join DBPROJECT P on P.KODEPROJECT=A.NoBL

	LEFT Outer Join (select a.NOBUKTI,b.HARI,SUM(COALESCE(BYANGKUT,0))BYANGKUT from DBSODET a Left Outer Join dbSO b on a.NoBukti=b.NoBukti Group by a.NOBUKTI,b.HARI)SO on SO.NOBUKTI=B.NoSO

	where A.NoBukti = @NoBukti

	group by A.NoBukti, A.Tanggal, C.NAMACUSTSUPP,a.PONo,a.NoSeri,a.DP,

		A.NoPajak, A.TglFPJ, C.ALAMAT, P.NAMAPROJECT,A.PPN,A.Noinv,c.USAHA,SO.HARI,C.TELPON,C.FAX)

select * from 	CetakTerima;

-- sp_CetakInvoicePLR
CREATE PROCEDURE IF NOT EXISTS sp_CetakInvoicePLR AS -- DECLARE REMOVED,@kodeCustSupp Varchar(20),@NoSO Varchar(30),@NoSOX Varchar(30)

select @Tanggal=Tanggal from dbInvoicePL where NoBukti=@NoBukti

select @kodeCustSupp=KodeCustSupp from dbInvoicePL where NoBukti=@NoBukti

select @NoSO=NoSo from dbInvoicePLDet where NoBukti=@NoBukti and COALESCE(IsAngkutJasa,0)=1 Group By NoSO

select @NoSOX=NoSo from dbInvoicePLDet where NoBukti=@NoBukti Group By NoSO



if @Tipe=1

select Left(A1.NoBukti,8)+SUBSTR(A1.Nobukti, LENGTH(A1.Nobukti)-11+1)as NoBukti,COALESCE(A1.Noinvoice,'')NoInv, A1.Tanggal, A.KodeCustSupp,c.telpon,a.pono,

	     Case when C.USAHA<>'' then C.USAHA+'. ' else '' + C.NAMACUSTSUPP NamaCustSupp, C.ALAMAT,A.PPN, 

		0 Urut, 0 UrutTrans, '' NoSPB, 0 UrutSPB, '' KodeBrg, A1.Keterangan NamaBrg, 1 Qnt, 

		'' SATUAN, 1 SAT1, 0 SAT2,

		'' NOSAT, Max(B.ISI)Isi, A1.SubTotal HARGA,0 DiscP, 0 DiscRp, 

		0 DISCTOT, Max(B.KetDetail)KetDetail, A1.SUBTOTAL  HrgNetto, 

		sum(B.NDISKON) NDISKON, A1.SUBTOTAL SUBTOTAL, A1.TDPP NDPP, A1.TNPPN NPPN, A1.TNNET NNET, sum(B.NDISKONRp) NDISKONRp, 

		A1.SUBTOTAL SUBTOTALRp, A1.TDPP NDPPRp, A1.TNPPN NPPNRp, A1.TNNET NNETRp,

		P.NAMA NamaPersh, P.KOTA KotaPersh,Bk.NAMABANK,Bk.KODEBANK,Bk.Nama,0 DP,case when COALESCE(a.IsTTD,0)=0 Then 'ALAM MONANDAR' else 'HENDRIK RAO'  NamaTTD,

		case when COALESCE(IsTTD,0)=0 Then 'Direktur' else 'Direktur'  Jabatan,SO.Hari ,Case When COALESCE(C.ispph21,0)=1 Then COALESCE(A.FRetensi,0) else SO.Retensi  Retensi,SO.PPH22,COALESCE(A.PPH21,0)PPH21,SO.PPHDPP,

		0 JatuhTempo,COALESCE(h.ALAMATPROJECT,'')ALAMATPROJECT, SUM((B.QNT+B.Meas)*B.HARGA*(B.DISC/100))DISKONTOTAL,j.DiskonNota,

		Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))RpRetensi,Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))RpDppRetensi,

		(Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1  RpPPNRetensi,

		(Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 ) RpNetRetensi,

		(Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100)RpPPH22,

		(Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1  RpPPNPPH22,

		(Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		

		RpKwt,

		SUM(Round(B.NNet,0))NetPPh21,COALESCE(A.NTotal,0)*(COALESCE(a.FRetensi,0)/100)PtgRetensi21,

		SUM(Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(a.FRetensi,0))/100)Progres21, 

		(SUM(Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(a.FRetensi,0))/100))/1.1 Progres21DPP,

		((SUM(Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(a.FRetensi,0))/100))/1.1)*0.1 Progres21PPN,

	    ((SUM(Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(a.FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100)PPh21Final,	

	    (SUM(Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(a.FRetensi,0))/100))-(((SUM(Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(a.FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))Netditerima21 

	,b.NilaiPPN,CAST(CAST(b.NilaiPPN*100 AS TINYINT AS TEXT))+'%' pajak    

	from dbInvoicePLRetensi A1

	Left Outer Join dbInvoicePL A on A.NoBukti=A1.NoInvoice

	left outer join dbInvoicePLDet B on B.NoBukti = A.NoBukti

	left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti

	left outer join vwCUSTSUPP C on C.KODECUSTSUPP = A.KodeCustSupp

	left outer join DBPERUSAHAAN P on 1=1

	left outer join DBBANK Bk on Bk.KodeBank=A.KodeBank

	left outer join dbSPBDet S on S.NoBukti=B.NoSPB and S.Urut=B.UrutSPB

	LEFT Outer Join (select a.NOBUKTI,HARI,SUM(COALESCE(BYANGKUT,0))BYANGKUT,AlamatKirim,KODEBRG,CAST(max(CAST(COALESCE(a.IsUbahNama,0 AS INTEGER AS TINYINT))))IsUbahNama,COALESCE(b.TERM1P,0)Retensi,COALESCE(b.TERM2P,0)PPH22,COALESCE(b.TERM3P,0)PPHDPP from DBSODET a Left Outer Join dbSO b On a.NOBUKTI=b.NOBUKTI Group by a.NOBUKTI,a.KODEBRG,HARI,AlamatKirim,COALESCE(a.IsUbahNama,0),COALESCE(b.TERM1P,0),COALESCE(b.TERM2P,0),COALESCE(b.TERM3P,0))SO on SO.NOBUKTI=B.NoSO and SO.KODEBRG=b.KodeBrg

    left outer join DBPROJECT H on h.KODEPROJECT=COALESCE(SO.AlamatKirim,A.NoBL)

    LEFT outer join (select NoBukti,SUM(COALESCE(NDISKON,0)) DiskonNota from dbInvoicePLDet group by NoBukti) J on J.NoBukti=A.NoBukti

	where A1.NoBukti = @NoBukti

	Group by A1.NoBukti,COALESCE(A.PPh21,0),COALESCE(A.NTotal,0),COALESCE(A.FRetensi,0),c.Ispph21, A1.Tanggal, A.KodeCustSupp, C.NAMACUSTSUPP, C.ALAMAT,A.PPN, c.telpon,h.ALAMATPROJECT,a.pono,

		SO.Retensi,SO.PPH22,SO.PPHDPP,rpInv.TotNet,  

		A1.NoInvoice,A1.Keterangan,A1.SubTOTAL,

		SO.IsUbahNama,A1.TDPP , A1.TNPPN , A1.TNNET,

		P.NAMA , P.KOTA,Bk.NAMABANK,Bk.KODEBANK,A.DP,IsTTD,Bk.Nama,A.Noinv,SO.HARI,c.USAHA,j.DiskonNota,b.NilaiPPN

	order by Max(B.Urut)


if @Tipe=2 

select Left(A1.NoBukti,8)+SUBSTR(A1.Nobukti, LENGTH(A1.Nobukti)-11+1) as NoBukti,COALESCE(A1.NoBukti,'')NoInv, A1.Tanggal,

	    Case when C.USAHA<>'' then C.USAHA+'. ' else '' + C.NAMACUSTSUPP NamaCustSupp,A.PPN,

		'' UntukPembayaran, b1.NAMABANK NamaBank,b1.NAMA Pemilik,0 DP, A.KodeBank NoBank, cast(null as datetime) TglBank,

		

		A1.TNNet TotalRp,A1.TDPP DPP,

		dbo.Terbilang(A1.TNNet) MyTerbilang,case when COALESCE(a.IsTTD,0)=0 Then 'ALAM MONANDAR' else 'HENDRIK RAO'  NamaTTD,

		case when COALESCE(IsTTD,0)=0 Then 'Direktur' else 'Direktur'  Jabatan,

		dbo.Terbilang(A.DP) TerbilangDP,A.NoBL Kodeproject,'RETENSI '+ p.ALAMATPROJECT Alamat--c.ALAMAT

		,A1.TDPP NDPP,Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))RpRetensi,Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))RpDppRetensi,

		(Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1  RpPPNRetensi,

		(Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 ) RpNetRetensi,

		(Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100)RpPPH22,

		(Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1  RpPPNPPH22,

		(Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		

		RpKwt,A.PoL NoBAP,A.PoD NoBASTB,A.NameOfVessel noSPBarang,SO.Retensi,SO.PPH22,

		Case When Year(A.ShipOnBoardDate)=1899 Then Null else A.ShipOnBoardDate   TglBAP,Case When  Year(A.ETADestination)=1899 Then Null else A.ETADestination  TglBASTB,A.TglKMK  TglSPBarang

	,b.NilaiPPN,CAST(CAST(b.NilaiPPN*100 AS TINYINT AS TEXT))+'%' pajak    

	from dbInvoicePLRetensi A1

	Left Outer Join dbInvoicePL A on A.NoBukti=A1.NoInvoice

	left outer join dbInvoicePLDet B on B.NoBukti = A.NoBukti

	left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti

	left outer join DBBANK B1 On B1.KODEBANK=A.KodeBank

	left outer join vwCUSTSUPP C on C.KODECUSTSUPP = A.KodeCustSupp

	left outer join DBPROJECT P on P.KODEPROJECT=A.NoBL

	LEFT Outer Join (select a.NOBUKTI,SUM(COALESCE(BYANGKUT,0))BYANGKUT,COALESCE(TERM1P,0)Retensi,COALESCE(TERM2P,0)PPH22,COALESCE(TERM3P,0)PPHDPP, COALESCE(b.TIPESC,0) TIPESC from DBSODET a Left Outer Join dbSO b on a.NOBUKTI=b.NOBUKTI Group by a.NOBUKTI,COALESCE(TERM1P,0),COALESCE(TERM2P,0),COALESCE(TERM3P,0), COALESCE(b.TIPESC,0))SO on SO.NOBUKTI=B.NoSO

	where A1.NoBukti =@NoBukti

	group by A1.NoBukti, A1.Tanggal, C.NAMACUSTSUPP,b1.NAMABANK,a.KodeBank,a.DP,b1.Nama,IsTTD,A.PPN,A.Noinv,

		P.NAMAPROJECT,c.USAHA,A.NoBL,p.ALAMATPROJECT ,A1.TNNet,A1.TDPP

	,SO.Retensi,SO.PPH22,SO.PPHDPP,rpInv.TotNet,

	A.PoL ,A.PoD ,A.NameOfVessel ,

		A.ShipOnBoardDate ,A.ETADestination ,A.TglKMK,SO.TIPESC,b.NilaiPPN;

-- sp_CetakPermintaanProduk
CREATE PROCEDURE IF NOT EXISTS sp_CetakPermintaanProduk AS Select a.NOBUKTI,a.TANGGAL,c.NAMA,c.ALAMAT1 Alamat,c.Telpon,a.KODESLS,a.AlamatKirim kdProject,d.NAMAPROJECT,cs.NAMACUSTSUPP,cs.ALAMAT1 AlamatCust,cs.TELPON Telpocust,cs.HPContP HP,

CAST(CAST(a.Jam AS DateTime AS int))Jam,Case When Year(a.TglKirim)=1899 Then Null else a.TglKirim  TglKirim,Case When Year(a.MasaBerlaku)=1899 Then Null else a.MasaBerlaku  MasaBerlaku,b.KODEBRG,br.NAMABRG,QNT,SATUAN,a.NoPesanan,

Case When a.NoAlamatKirim=0 Then 'Loko On Truck' when a.NoAlamatKirim=1 Then 'Franko on truck'

when a.NoAlamatKirim=2 Then 'Franko on site'

when a.NoAlamatKirim=3 Then 'Terpasang'  TipeKirim,F.Nama NmSls 

from DBSO a

Left Outer Join DBSODET b on a.NOBUKTI=b.NOBUKTI

Left Outer Join DBCUSTSUPP cs on cs.KODECUSTSUPP=a.KODECUST

Left Outer Join DBBARANG br On br.KODEBRG=b.KODEBRG

Left Outer Join DBPROJECT d on d.KODEPROJECT=a.AlamatKirim

Left Outer Join DBPERUSAHAAN c on 1=1

Left Outer Join (select * from dbKaryawan) F on F.KeyNIK=a.KODESLS

where a.NOBUKTI=@NoBukti;

-- sp_CetakPNW
CREATE PROCEDURE IF NOT EXISTS sp_CetakPNW AS -- DECLARE REMOVED



if @Tipe=0



Select 	A.NoBukti NoKP, A.Tanggal TglKP, A.MasaBerlaku TglBatas,

		COALESCE(C.USAHA,'')+' '+COALESCE(C.NAMACUSTSUPP,A.INSBrg) NamaCust, COALESCE(C.Alamat,SUBSTR(INSBrg, LENGTH(INSBrg)-10+1)) AlamatCust,

		C.ContactP ContactCust, C.TELPON TelpHPCust,

		C.FAX+'  '+C.EMAIL FaxEmailCust,

		COALESCE(P.NAMAPROJECT ,INSGdg) NamaProyek, COALESCE(P.ALAMATPROJECT,'') AlamatProyek,

		P.ContactP ContactProyek, P.TelpHP TelpHPProyek,

		P.FAX+'  '+P.EMAIL FaxEmailProyek,

		B.Urut, B.KodeBrg, Case When COALESCE(H.ISJasa,0)=0 Then H.NamaBrg else  B.NamaBrg  

		                   +Case When dbo.fnc_NamaBrgPNW(a.NOBUKTI,B.KODEBRG)='' Then '' else CHAR(13)+'- '+dbo.fnc_NamaBrgPNW(a.NOBUKTI,B.KODEBRG) 

		                   --+case when COALESCE(Ketbatal,'')='' Then '' else CHAR(13)+COALESCE(Ketbatal,'') 

		                   NamaBrg ,Case when NOSAT=1 Then B.Qnt else B.QNT2  Qnt, B.SATUAN,

        B.HrgNetto HargaSat, B.SUBTOTALRp, B.NDPPRp, B.NPPNRp, B.NNETRp,

		case when YEAR(A.Jam)<=1900 then null else A.Jam  TglMinta, 

		case when year(A.TGLKIRIM)<=1900 then null else A.TglKirim  TglKirim, 

		case when YEAR(A.MasaBerlaku)<=1900 then null else A.MasaBerlaku  TglBatasKirim,

		Sp.Beton_K350, Sp.Beton_K400, Sp.Beton_K500, Sp.Besi_WRU50, Sp.Besi_BJTD40, Sp.Besi_BJTP24,

		Sp.Semen_Type, cast(case when COALESCE(Sp.Semen_Type,0)=0 then 'Type 1' else ''  as varchar(50)) MySemen_Type,

		Sp.Samb_ButJoint, Sp.Samb_QuicklyJoint, Sp.Samb_SocketSpigot, Sp.Samb_MaleFemale,

		sp.Besi_PCWire,sp.Samb_Tanpa,sp.Samb_Plat,

		dbo.fnc_MutuBetonSO(A.NOBUKTI) MyMutuBeton,

		dbo.fnc_MutuBesiSO(A.NOBUKTI) MyMutuBesi,

		dbo.fnc_SambunganSO(A.NOBUKTI) MySambungan,

		dbo.fnc_SifatPengiriman(A.NOBUKTI) MyKirim,

		'Type 1' MySemenType,

		cast(case when A.NoAlamatKirim=0 then 1 else 0  as INTEGER) IsLoko,

		cast(case when A.NoAlamatKirim=1 then 1 else 0  as INTEGER) IsFrankoOnTruck,

		cast(case when A.NoAlamatKirim=2 then 1 else 0  as INTEGER) IsFrankoOnSite,

		cast(case when A.NoAlamatKirim=3 then 1 else 0  as INTEGER) IsTerpasang,

		CAST(F.Nama+' '+F.TeleponHP as varchar(100)) ContactPersonCA,

		CAST(C.ContactP as varchar(100)) NamaTtdCust,

		CAST(COALESCE(A.NamaTtd,'') as varchar(100)) NamaTtdCalvary,

		CAST(COALESCE(A.NamaTtd,'')+'  '+COALESCE(F.TeleponHP,'') as varchar(100)) NamaTtdCalvaryPlus,

		CAST(COALESCE(A.JabatanTtd,'') as varchar(100)) JabatanTtdcalvary,

		case when A.NoAlamatKirim=0 Then 'Loko'

		     when A.NoAlamatKirim=1 Then 'Franko On Truck'

		     when A.NoAlamatKirim=2 Then 'Franko On Site'

		     when A.NoAlamatKirim=3 Then 'Terpasang'  SifatKirim,'SURAT PENAWARAN '+Case When H.KODESUBGRP='PV' Then 'PAVING'WHEN H.KODESUBGRP='PG' Then 'PAGAR' else ''   Caption,c.KODEPOS,

		F1.TeleponHP,B.NDISKON     

	From dbPNW A

	Left Outer join dbPNWDet B on B.NoBukti=A.NoBukti and (COALESCE(B.KodeBrgM,'')='' /*OR B.HARGA<>0*/)

	Left Outer Join vwCUSTSUPP C on C.KODECUSTSUPP=A.KodeCust

	Left Outer join dbValas D on D.KodeVls=A.KodeVls

	left outer join dbKaryawan F on F.KeyNIK=A.KodeSls

	Left Outer Join dbKaryawan F1 on F1.Nama=A.NamaTtd 

	Left Outer Join DBBARANG H on H.KodeBrg=B.KodeBrg

	--Left Outer Join vwRpDetSO I on I.NoBukti=A.NoBukti

	--Left Outer Join vwAlamatCust O on O.KODECUSTSUPP=A.KODECUST and O.NOMOR=A.NOAlamatKirim

	--left outer join dbExpedisi M on M.KodeExp=A.KodeExp

	left outer join DBPROJECT P on P.KODEPROJECT=A.AlamatKirim

	left outer join dbSpesifikasiSO Sp on Sp.NoBukti=A.NOBUKTI

	where	A.NoBukti=@NoBukti

	order by B.Urut



 else



if @Tipe=1



truncate table TempCetakSO

	

	insert into TempCetakSO (NoBukti, Urut, KodeBrg, Qnt, Satuan) 

	select A.NOBUKTI, A.URUT, A.KODEBRG, A.QNT, A.SATUAN

	from DBPNWDET A

	where A.NOBUKTI=@NOBUKTI

	order by A.URUT

	

	select @CountSO=COUNT(*) from DBPNWDET where NOBUKTI=@NOBUKTI

	

	insert into TempCetakSO (NoBukti, Urut, KodeBrg, Qnt, Satuan) 

	select @NOBUKTI, null URUT, null KODEBRG, null QNT, null SATUAN

	from dbNoUrut A

	where A.NoUrut<=14-@CountSO

	

	Select 	Left(A.NoBukti,3)+'FPP/'+SUBSTR(A.NOBUKTI, LENGTH(A.NOBUKTI)-10+1) NoPermintaan, A.Tanggal, A.NoPesanan NoKontrak, 

		'' NamaPershCust, C.NAMACUSTSUPP NamaCust, C.Alamat AlamatCust,

		C.TELPON TelpHPCust,

		P.NAMAPROJECT NamaProyek, P.ALAMATPROJECT AlamatProyek,

		F.Nama NamaSls,

		case when YEAR(A.Jam)<=1900 then null else A.Jam  TglMinta, 

		case when year(A.TGLKIRIM)<=1900 then null else A.TglKirim  TglKirim, 

		case when YEAR(A.MasaBerlaku)<=1900 then null else A.MasaBerlaku  TglBatasKirim,

		case when COALESCE(B.Urut,0)=0 then null else B0.KeyUrut  Urut, 

		B.KodeBrg, H.NamaBrg, B.Qnt, H.Sat1 Satuan,

        COALESCE(A.CetakKe,0)+1 CetakN,sp.Besi_PCWire,sp.Samb_Tanpa,sp.Samb_Plat,

		Sp.Beton_K350, Sp.Beton_K400, Sp.Beton_K500, Sp.Besi_WRU50, Sp.Besi_BJTD40, Sp.Besi_BJTP24,

		Sp.Semen_Type, cast(case when COALESCE(Sp.Semen_Type,0)=0 then 'Type 1' else ''  as varchar(50)) MySemen_Type,

		Sp.Samb_ButJoint, Sp.Samb_QuicklyJoint, Sp.Samb_SocketSpigot, Sp.Samb_MaleFemale,

		A.CATATAN,H.Hrg3_2 Berat,C.ContactP,case when Left(a.NOBUKTI,2)='CB' Then 'JASA'else 'BELI'  Caption

	,F.TeleponHP

	From dbPNW A

	Left outer join TempCetakSO B0 on B0.NoBukti=A.NOBUKTI

	Left Outer join dbPNWDet B on B.NoBukti=B0.NoBukti and B.URUT=B0.Urut

	Left Outer Join vwCUSTSUPP C on C.KODECUSTSUPP=A.KodeCust

	--Left Outer join dbValas D on D.KodeVls=A.KodeVls

	left outer join dbKaryawan F on F.KeyNIK=A.KodeSls

	Left Outer Join DBBARANG H on H.KodeBrg=B.KodeBrg

	--Left Outer Join vwRpDetSO I on I.NoBukti=A.NoBukti

	--Left Outer Join vwAlamatCust O on O.KODECUSTSUPP=A.KODECUST and O.NOMOR=A.NOAlamatKirim

	--left outer join dbExpedisi M on M.KodeExp=A.KodeExp

	left outer join DBPROJECT P on P.KODEPROJECT=A.AlamatKirim

	left outer join dbSpesifikasiSO Sp on Sp.NoBukti=A.NOBUKTI

	where	A.NoBukti=@NoBukti

	order by B0.KeyUrut;

-- Sp_CetakPO
CREATE PROCEDURE IF NOT EXISTS Sp_CetakPO AS --select @nobukti='SJY/PO/0913/0323',@tipe=0

-- SET REMOVED(

					select distinct(F.TotNet)Totnet

					from DBKirimDET A

					Left Outer join DBBARANG B on A.KodeBrg = B.KODEBRG

					Left outer join DBPO C on A.NoBukti = C.NOBUKTI

					Left Outer join (select Nobukti,KOdebrg, SATUAN,NoPPL, 

                        Sum(COALESCE(harga,0)) Harga, Sum(COALESCE(DISCP,0))Disc, 

                        Sum(COALESCE(Disctot,0)) Disctot, Sum(COALESCE(Subtotal,0)) SubTotal,SUM(COALESCE(Qnt,0)) TotQnt 

					from DBPODET 

					Group By NOBUKTI,KodeBrg,SATUAN, NoPPL) D on A.NoBukti = D.NOBUKTI and A.KodeBrg = D.KODEBRG

				Left Outer join DBCUSTSUPP E on C.KODESUPP = E.KODECUSTSUPP

				Left Outer join VwMasterPO F on A.nobukti = F.Nobukti

				Left outer join DBGUDANG G on g.KODEGDG =c.KodeGDG

				where	A.NOBUKTI=@NoBukti and A.KodeBrg=D.KODEBRG)



select F.*,

       D.NoPPL,E.TELPON,E.FAX,E.ContactP, A.KodeBrg,g.alamat as alamatkirim,

       Case when COALESCE(C1.NAMABRG,'')='' Then B.NamaBrg when COALESCE(C1.NAMABRG,'')=B.NamaBrg Then B.NamaBrg else C1.NamaBrg  NAMABRG,

       A.Tanggal TglKrm,C1.Qnt QntKrm,COALESCE(D.HARGA,0) - COALESCE(D.DISCTOT,0) HrgKrm,

       COALESCE(D.harga,0)harga,COALESCE(D.DiscTOt,0)DiscTot,--COALESCE(D.Subtotal,0)Subtotal,F.TotDpp,

       (D.harga - D.DISCTOT) * C1.Qnt TotalDetKirim,

       A.Qnt*(D.harga - D.DISCTOT) Total,

       --Dbo.terbilang((A.Qnt*(D.harga - D.DISCTOT)) + F.TotPPnRP-F.TotDiskon) terbilang, --F.TotDpp + F.TotPPnRP-F.TotDiskon GrandTot,

      

E.Alamat1+Char(13)+E.Alamat2+Char(13)+E.kota Alamat,E.NamaCustSupp ,--F.TotPPNRp,F.TotDiskon,

COALESCE(D.SATUAN,(Select Max(SATUAN)Satuan from DBPODET where NOBUKTI=@NoBukti and KODEBRG=A.KodeBrg))Satuan, 

Case when C.TIPEBAYAR=0 Then 'TUNAI' else 'KREDIT'  Pembayaran,C.HARI,D.Disc Disc ,E.HARIHUTPIUT,E.HARI HariCust,

COALESCE(C.NilaiCetak,0)+1 Cetakke,C.KODEVLS,E.Att,C.KETERANGAN,

dbo.Terbilang(COALESCE(Case when C.Kodevls='IDR' then F.TotNetRp  else F.TotNet ,0)) TerbilangTotal,

C.NOBUKTI NOPO,C.TANGGAL TglPO,Case when C.Kodevls='IDR' then C1.NNETRp else C1.NNET  NNet,

Case when C.Kodevls='IDR' then C1.NPPNRp else C1.NPPN  NPPN,

Case when C.Kodevls='IDR' then C1.NDPPRp else C1.NDPP  NDPP,

Case when C.Kodevls='IDR' then C1.NDISKON else C1.NDISKON  NDISKON,

Syarat,Case When Year(C.TglBatas)=1899 Then Null else C.TglBatas  tglBatas,Vs.NAMAVLS,Case When FX.Jumlah>=1 Then 'PURCHASE ORDER' else 'PURCHASE ORDER JASA'  Judul,po.Jmh,

TJ.TNDPP,TJ.TNNet,TJ.TNPPN

from DBKirimDET A

Left Outer join DBBARANG B on A.KodeBrg = B.KODEBRG

Left outer join DBPO C on A.NoBukti = C.NOBUKTI

Left Outer Join (select NoBukti,COUNT(*)Jmh from DBPODET group by NOBUKTI)Po on Po.NOBUKTI=c.NOBUKTI

Left Outer Join (select C.NOBUKTI,SUM(Case when C.Kodevls='IDR' then C1.NNETRp else C1.NNET ) TNNet,

SUM(Case when C.Kodevls='IDR' then C1.NPPNRp else C1.NPPN ) TNPPN,

SUM(Case when C.Kodevls='IDR' then C1.NDPPRp else C1.NDPP ) TNDPP from DBPO C Left Outer Join DBPODET C1 on C.NOBUKTI=c1.NOBUKTI

Group by C.NOBUKTI)TJ on TJ.NOBUKTI=c.NOBUKTI                                 

Left Outer Join DBPODET C1 On C1.NOBUKTI=C.NOBUKTI and B.KODEBRG=C1.KODEBRG --and A.KodeBrg=C1.KODEBRG and A.Urut=C1.URUT

Left Outer join (select Nobukti,KOdebrg, SATUAN,NoPPL, 

                        harga Harga, Sum(COALESCE(DISCP,0))Disc, 

                        Sum(COALESCE(Disctot,0)) Disctot, Sum(COALESCE(Subtotal,0)) SubTotal,SUM(COALESCE(Qnt,0)) TotQnt 

                 from DBPODET 

                 Group By NOBUKTI,KodeBrg,SATUAN, NoPPL,HARGA) D on A.NoBukti = D.NOBUKTI and A.KodeBrg = D.KODEBRG and C1.HARGA=D.Harga and d.NoPPL=C1.NoPPL

Left Outer join DBCUSTSUPP E on C.KODESUPP = E.KODECUSTSUPP 

Left Outer Join(Select COALESCE(Jumlah,0)Jumlah from(

                select COUNT(*)Jumlah from DBPODET a

                Left Outer Join dbBarang b on a.KODEBRG=b.KODEBRG where NOBUKTI=@NoBukti and COALESCE(IsJasa,0)=0)a)FX on 1=1

Left Outer join VwMasterPO F on A.nobukti = F.Nobukti

Left Outer Join dbVALAS Vs On Vs.KODEVLS=c.KODEVLS

Left outer join DBGUDANG G on g.KODEGDG =c.KodeGDG

where	A.NOBUKTI=@NoBukti and A.KodeBrg=D.KODEBRG

order by A.KodeBrg, A.Tanggal;

-- sp_cetakRBeliGdg
CREATE PROCEDURE IF NOT EXISTS sp_cetakRBeliGdg AS Select 	A.devisi,A.NOBUKTI, A.NOURUT, A.TANGGAL, A.TGLJATUHTEMPO, A.KODESUPP,

        C.NamaCustSupp, C.Alamat1, C.Alamat2, C.Kota,

        C.Alamat1+Char(13)+C.Alamat2+Char(13)+C.kota Alamat,

        A.NOBELI, A.KodeGdg, A.KODEEXP, A.HANDLING, A.KETERANGAN, A.FAKTURSUPP,

        A.KODEVLS, A.KURS, A.PPN, A.TIPEBAYAR, A.HARI, A.TipeDisc, A.DISC, A.DISCRP,

        A.NILAIPOT, A.NILAIDPP, A.NILAIPPN, A.NILAINET, A.ISCETAK, A.NilaiCetak,

        B.URUT, B.KODEBRG, COALESCE(B.NamaBrg,E.NamaBrg)NamaBrg, B.QNT, B.NOSAT, B.SATUAN, B.ISI, B.HARGA, B.DISCP, B.DISCTOT,

        B.BYANGKUT, B.NOPBL, B.URUTPBL, B.Qnt2, B.Qnt1, B.HPP,

        B.HRGNETTO, B.NDISKON, B.SUBTOTAL, B.NDPP, B.NPPN, B.NNET,

        E.NFix

From dbRBeli A

Left Outer join dbRBeliDet B on B.NoBukti=A.NoBukti

Left Outer Join dbCustSupp C on C.KodeCustSupp=A.KodeSupp

Left Outer join dbValas D on D.KodeVls=A.KodeVls

Left Outer join dbBarang E on E.KodeBrg=B.KodeBrg

Left Outer Join dbGudang F on F.KodeGdg=A.KodeGdg

Left Outer Join dbExpedisi G on G.KodeExp=A.KodeExp

where	A.NoBukti=@NoBukti

order by B.Urut;

-- sp_CetakRInvoicePLR
CREATE PROCEDURE IF NOT EXISTS sp_CetakRInvoicePLR AS -- DECLARE REMOVED,@kodeCustSupp Varchar(20),@NoSO Varchar(30),@NoSOX Varchar(30)

select @Tanggal=Tanggal from dbInvoicePL where NoBukti=@NoBukti

select @kodeCustSupp=KodeCustSupp from dbInvoicePL where NoBukti=@NoBukti

select @NoSO=NoSo from dbInvoicePLDet where NoBukti=@NoBukti and COALESCE(IsAngkutJasa,0)=1 Group By NoSO

select @NoSOX=NoSo from dbInvoicePLDet where NoBukti=@NoBukti Group By NoSO



if @Tipe=1

select Left(A1.NoBukti,8)+SUBSTR(A1.Nobukti, LENGTH(A1.Nobukti)-11+1)as NoBukti,COALESCE(A1.Noinvoice,'')NoInv, A1.Tanggal, A.KodeCustSupp,c.telpon,

	     Case when C.USAHA<>'' then C.USAHA+'. ' else '' + C.NAMACUSTSUPP NamaCustSupp, C.ALAMAT,A.PPN, 

		0 Urut, 0 UrutTrans, '' NoSPB, 0 UrutSPB, '' KodeBrg, A1.Keterangan NamaBrg, 1 Qnt, 

		'' SATUAN, 1 SAT1, 0 SAT2,

		'' NOSAT, Max(B.ISI)Isi, A1.SubTotal HARGA,0 DiscP, 0 DiscRp, 

		0 DISCTOT, '' KetDetail, A1.SUBTOTAL  HrgNetto,'' Pono, 

		sum(B.NDISKON) NDISKON, A1.SUBTOTAL SUBTOTAL, A1.TDPP NDPP, A1.TNPPN NPPN, A1.TNNET NNET, sum(B.NDISKON) NDISKONRp, 

		A1.SUBTOTAL SUBTOTALRp, A1.TDPP NDPPRp, A1.TNPPN NPPNRp, A1.TNNET NNETRp,

		P.NAMA NamaPersh, P.KOTA KotaPersh,Bk.NAMABANK,Bk.KODEBANK,Bk.Nama,0 DP,case when COALESCE(IsLokal,0)=0 Then 'ALAM MONANDAR' else 'HENDRIK RAO'  NamaTTD,

		case when COALESCE(IsLokal,0)=0 Then 'Direktur' else 'Direktur'  Jabatan,SO.Hari ,Case When COALESCE(C.ispph21,0)=1 Then COALESCE(A.FRetensi,0) else SO.Retensi  Retensi,SO.PPH22,SO.PPHDPP,

		0 JatuhTempo,COALESCE(h.ALAMATPROJECT,'')ALAMATPROJECT, SUM((B.QNT)*B.HARGA*(B.DISC/100))DISKONTOTAL,j.DiskonNota,

		Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))RpRetensi,Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))RpDppRetensi,

		(Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1  RpPPNRetensi,

		(Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 ) RpNetRetensi,

		(Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100)RpPPH22,

		(Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1  RpPPNPPH22,

		(Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		

		RpKwt

	,b.NilaiPPN,CAST(CAST(b.NilaiPPN*100 AS TINYINT AS TEXT))+'%' pajak    

	from dbRInvoicePLRetensi A1

	Left Outer Join dbRInvoicePL A on A.NoBukti=A1.NoInvoice

	left outer join dbRInvoicePLDet B on B.NoBukti = A.NoBukti

	Left Outer Join (select a.NoBukti,KodeBank,NoBL,NoSO from dbInvoicePL a Left Outer Join dbInvoicePLDet b on a.NoBukti=b.NoBukti Group by a.NoBukti,KodeBank,NoBL,NoSO)A2 on A2.NoBukti=b.NoInvoice

	left Outer join [vwRpDetRInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti

	left outer join vwCUSTSUPP C on C.KODECUSTSUPP = A.KodeCustSupp

	left outer join DBPERUSAHAAN P on 1=1

	left outer join DBBANK Bk on Bk.KodeBank=A2.KodeBank

	LEFT Outer Join (select a.NOBUKTI,HARI,SUM(COALESCE(BYANGKUT,0))BYANGKUT,AlamatKirim,KODEBRG,CAST(max(CAST(COALESCE(a.IsUbahNama,0 AS INTEGER AS TINYINT))))IsUbahNama,COALESCE(b.TERM1P,0)Retensi,COALESCE(b.TERM2P,0)PPH22,COALESCE(b.TERM3P,0)PPHDPP from DBSODET a Left Outer Join dbSO b On a.NOBUKTI=b.NOBUKTI Group by a.NOBUKTI,a.KODEBRG,HARI,AlamatKirim,COALESCE(a.IsUbahNama,0),COALESCE(b.TERM1P,0),COALESCE(b.TERM2P,0),COALESCE(b.TERM3P,0))SO on SO.NOBUKTI=A2.NoSO and SO.KODEBRG=b.KodeBrg

    left outer join DBPROJECT H on h.KODEPROJECT=COALESCE(SO.AlamatKirim,A2.NoBL)

    LEFT outer join (select NoBukti,SUM(COALESCE(NDISKON,0)) DiskonNota from dbInvoicePLDet group by NoBukti) J on J.NoBukti=A.NoBukti

	where A1.NoBukti = @NoBukti

	Group by A1.NoBukti,COALESCE(A.FRetensi,0),c.Ispph21, A1.Tanggal, A.KodeCustSupp, C.NAMACUSTSUPP, C.ALAMAT,A.PPN, c.telpon,h.ALAMATPROJECT,

		SO.Retensi,SO.PPH22,SO.PPHDPP,rpInv.TotNet,  

		A1.NoInvoice,A1.Keterangan,A1.SubTOTAL,

		SO.IsUbahNama,A1.TDPP , A1.TNPPN , A1.TNNET,

		P.NAMA , P.KOTA,Bk.NAMABANK,Bk.KODEBANK,A.RDP,IsLokal,Bk.Nama,SO.HARI,c.USAHA,j.DiskonNota,b.NilaiPPN

	order by Max(B.Urut)


if @Tipe=2 

select Left(A1.NoBukti,8)+SUBSTR(A1.Nobukti, LENGTH(A1.Nobukti)-11+1) as NoBukti,COALESCE(A1.NoBukti,'')NoInv, A.Tanggal,

	    'RETENSI '+Case when C.USAHA<>'' then C.USAHA+'. ' else '' + C.NAMACUSTSUPP NamaCustSupp,A.PPN,

		'' UntukPembayaran, b1.NAMABANK NamaBank,b1.NAMA Pemilik,0 DP, A2.KodeBank NoBank, cast(null as datetime) TglBank,

		

		A1.TNNet TotalRp,A1.TDPP DPP,

		dbo.Terbilang(A1.TNNet) MyTerbilang,case when COALESCE(SO.TIPESC,0)=0 Then 'ALAM MONANDAR' else 'HENDRIK RAO'  NamaTTD,

		case when COALESCE(IsLokal,0)=0 Then 'Direktur' else 'Direktur'  Jabatan,

		dbo.Terbilang(A.RDP) TerbilangDP,A2.NoBL Kodeproject,'RETENSI '+ p.ALAMATPROJECT Alamat--c.ALAMAT

		,A1.TDPP NDPP,Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))RpRetensi,Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))RpDppRetensi,

		(Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1  RpPPNRetensi,

		(Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 ) RpNetRetensi,

		(Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100)RpPPH22,

		(Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1  RpPPNPPH22,

		(Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		

		RpKwt,SO.Retensi,SO.PPH22

	,b.NilaiPPN,CAST(CAST(b.NilaiPPN*100 AS TINYINT AS TEXT))+'%' pajak    

	from dbRInvoicePLRetensi A1

	Left Outer Join dbRInvoicePL A on A.NoBukti=A1.NoInvoice

	left outer join dbRInvoicePLDet B on B.NoBukti = A.NoBukti

	Left Outer Join (select a.NoBukti,KodeBank,NoBL,NoSO from dbInvoicePL a Left Outer Join dbInvoicePLDet b on a.NoBukti=b.NoBukti Group by a.NoBukti,KodeBank,NoBL,NoSO)A2 on A2.NoBukti=b.NoInvoice

	left Outer join [vwRpDetRInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti

	left outer join DBBANK B1 On B1.KODEBANK=A2.KodeBank

	left outer join vwCUSTSUPP C on C.KODECUSTSUPP = A.KodeCustSupp

	left outer join DBPROJECT P on P.KODEPROJECT=A2.NoBL

	LEFT Outer Join (select a.NOBUKTI,SUM(COALESCE(BYANGKUT,0))BYANGKUT,COALESCE(TERM1P,0)Retensi,COALESCE(TERM2P,0)PPH22,COALESCE(TERM3P,0)PPHDPP, COALESCE(b.TIPESC,0) TIPESC from DBSODET a Left Outer Join dbSO b on a.NOBUKTI=b.NOBUKTI Group by a.NOBUKTI,COALESCE(TERM1P,0),COALESCE(TERM2P,0),COALESCE(TERM3P,0), COALESCE(b.TIPESC,0))SO on SO.NOBUKTI=A2.NoSO

	where A1.NoBukti =@NoBukti

	group by A1.NoBukti, A.Tanggal, C.NAMACUSTSUPP,b1.NAMABANK,a2.KodeBank,a.RDP,b1.Nama,IsLokal,A.PPN,

		P.NAMAPROJECT,c.USAHA,A2.NoBL,p.ALAMATPROJECT ,A1.TNNet,A1.TDPP

	,SO.Retensi,SO.PPH22,SO.PPHDPP,rpInv.TotNet,

	SO.TIPESC,b.NilaiPPN;

-- sp_CetakRTransRute
CREATE PROCEDURE IF NOT EXISTS sp_CetakRTransRute AS select A.NOBUKTI,A.NOURUT,A.TANGGAL,A.KODEKEND,A.SUPIR,A.RUTE,

B.URUT,B.BIAYA,B.TARIF,B.QNT,B.TOTAL,C.NAMAKEND,C.KODEJENISKEND,

D.NAMAJENISKEND,E.NAMARUTE,B.ISP,Ket1,Ket2,Pro.NAMAPROJECT,Cust.NAMACUSTSUPP,A.NoRute

from DBRRUTETRANS A

LEFT OUTER JOIN DBRRUTETRANSDET B ON A.NOBUKTI=B.NOBUKTI

Left Outer Join DBCUSTSUPP Cust On Cust.KODECUSTSUPP=A.Ket2

Left Outer Join DBPROJECT Pro On Pro.KODEPROJECT=A.Ket1

LEFT OUTER JOIN DBKENDARAAN C ON A.KODEKEND=C.KODEKEND

LEFT OUTER JOIN DBJENISKEND D ON C.KODEJENISKEND=D.KODEJENISKEND

LEFT OUTER JOIN DBRUTE E ON A.RUTE=E.KODERUTE

WHERE A.NOBUKTI=@NOBUKTI;

-- sp_CetakSO
CREATE PROCEDURE IF NOT EXISTS sp_CetakSO AS -- DECLARE REMOVED



if @Tipe=0



Select 	A.NoBukti NoKP, A.Tanggal TglKP, A.MasaBerlaku TglBatas,

		C.USAHA+' '+C.NAMACUSTSUPP NamaCust, C.Alamat AlamatCust,

		C.ContactP ContactCust, C.TELPON TelpHPCust,

		C.FAX+'  '+C.EMAIL FaxEmailCust,

		P.NAMAPROJECT NamaProyek, P.ALAMATPROJECT AlamatProyek,

		P.ContactP ContactProyek, P.TelpHP TelpHPProyek,

		P.FAX+'  '+P.EMAIL FaxEmailProyek,

		B.Urut, B.KodeBrg, Case When COALESCE(B.IsUbahNama,0)=0 Then Case When COALESCE(H.ISJasa,0)=0 Then H.NamaBrg else  B.NamaBrg  else B.NamaBrg 

		                   +Case When dbo.fnc_NamaBrgSO(a.NOBUKTI,B.KODEBRG)='' Then '' else CHAR(13)+'- '+dbo.fnc_NamaBrgSO(a.NOBUKTI,B.KODEBRG) 

		                   +case when COALESCE(B.Ketbatal1,COALESCE(B.Ketbatal,''))='' Then '' else CHAR(13)+COALESCE(B.Ketbatal1,COALESCE(B.KetBatal,'')) 

		                   +Case When COALESCE(a.KETERANGAN,'')<>'' Then CHAR(13)+'SLUM  '+COALESCE(a.KETERANGAN,'') else ''   NamaBrg ,Case when B.NOSAT=1 Then B.Qnt else B.QNT2  Qnt, case when B.NOSAT=2 Then B.SATUAN+CHAR(13)+ CAST(B.ISI AS TEXT)+' '+H.SAT1+CHAR(13)+'[ 1 ]' else B.SATUAN  SATUAN,

        B.HrgNetto HargaSat, B.SUBTOTALRp, B.NDPPRp, B.NPPNRp, B.NNETRp,

		case when YEAR(A.Jam)<=1900 then null else A.Jam  TglMinta, 

		case when year(A.TGLKIRIM)<=1900 then null else A.TglKirim  TglKirim, 

		case when YEAR(A.MasaBerlaku)<=1900 then null else A.MasaBerlaku  TglBatasKirim,

		Sp.Beton_K350, Sp.Beton_K400, Sp.Beton_K500, Sp.Besi_WRU50, Sp.Besi_BJTD40, Sp.Besi_BJTP24,

		Sp.Semen_Type, cast(case when COALESCE(Sp.Semen_Type,0)=0 then 'Type 1' else ''  as varchar(50)) MySemen_Type,

		Sp.Samb_ButJoint, Sp.Samb_QuicklyJoint, Sp.Samb_SocketSpigot, Sp.Samb_MaleFemale,

		sp.Besi_PCWire,sp.Samb_Tanpa,sp.Samb_Plat,

		dbo.fnc_MutuBetonSO(A.NOBUKTI) MyMutuBeton,

		dbo.fnc_MutuBesiSO(A.NOBUKTI) MyMutuBesi,

		dbo.fnc_SambunganSO(A.NOBUKTI) MySambungan,

		dbo.fnc_SifatPengiriman(A.NOBUKTI) MyKirim,

		'Type 1' MySemenType,

		cast(case when A.NoAlamatKirim=0 then 1 else 0  as INTEGER) IsLoko,

		cast(case when A.NoAlamatKirim=1 then 1 else 0  as INTEGER) IsFrankoOnTruck,

		cast(case when A.NoAlamatKirim=2 then 1 else 0  as INTEGER) IsFrankoOnSite,

		cast(case when A.NoAlamatKirim=3 then 1 else 0  as INTEGER) IsTerpasang,

		CAST(F.Nama+' '+F.TeleponHP as varchar(100)) ContactPersonCA,

		CAST(C.ContactP as varchar(100)) NamaTtdCust,

		CAST(COALESCE(A.NamaTtd,'')as varchar(100)) NamaTtdCalvary,

		CAST(COALESCE(A.NamaTtd,'')+'  '+COALESCE(F.TeleponHP,'') as varchar(100)) NamaTtdCalvaryPlus,

		CAST(COALESCE(A.JabatanTtd,'') as varchar(100)) JabatanTtdcalvary,

		case when A.NoAlamatKirim=0 Then 'Loko'

		     when A.NoAlamatKirim=1 Then 'Franko On Truck'

		     when A.NoAlamatKirim=2 Then 'Franko On Site'

		     when A.NoAlamatKirim=3 Then 'Terpasang'  SifatKirim,'SALES ORDER (SO)' Caption,c.KODEPOS,

		F1.TeleponHP,/*Case When B1.Urut=B.Urut Then B1.NDISKON else 0  */B.NDISKON

		,Case When COALESCE(B.Ketbatal,'')='' then '' else '* '+B.Ketbatal  ketgab,Case when a.TIPESC=0 Then 'ALAM MONANDAR'else 'HENDRIK RAO'  TTDCEO,

		case When B.NOSAT=2 then Case when a.KODEVLS='IDR' Then 'Rp' else '$' +'.'+CAST(Cast(b.HARGA as money AS TEXT),1)+CHAR(13)+CHAR(13)+

		'[ '+Case when a.KODEVLS='IDR' Then 'Rp' else '$' +'.'+CAST(Cast(b.HARGA/b.ISI as money AS TEXT),1)+'/'+H.SAT1 +' ]'

		else  Case when a.KODEVLS='IDR' Then 'Rp' else '$' +'.'+CAST(Cast(b.HARGA as money AS TEXT),1)  HargaRP,

		case When B.NOSAT=2 then CAST(Cast(b.QNT2 as money AS TEXT),1)+CHAR(13)+CHAR(13)+

		'[ '+CAST(Cast(b.QNT2*b.ISI as money AS TEXT),1)+'/'+H.SAT1+' ]' 

		else  CAST(Cast(b.QNT as money AS TEXT),1)  VolumeRp,CAST(CAST(b.NilaiPPN*100 AS TINYINT AS TEXT))+'%' pajak    

	From dbSO A

	Left Outer join dbSODet B on B.NoBukti=A.NoBukti and (COALESCE(B.KodeBrgM,'')='' /*OR B.HARGA<>0*/)

	--Left Outer join (Select NoBukti,Min(Urut)Urut,SUM(NDISKON)NDISKON from dbSODet Group By NoBukti) B1 on B1.NoBukti=A.NoBukti 

	Left Outer Join vwCUSTSUPP C on C.KODECUSTSUPP=A.KodeCust

	Left Outer join dbValas D on D.KodeVls=A.KodeVls

	left outer join dbKaryawan F on F.KeyNIK=A.KodeSls

	Left Outer Join dbKaryawan F1 on F1.Nama=A.NamaTtd 

	Left Outer Join DBBARANG H on H.KodeBrg=B.KodeBrg

	--Left Outer Join vwRpDetSO I on I.NoBukti=A.NoBukti

	--Left Outer Join vwAlamatCust O on O.KODECUSTSUPP=A.KODECUST and O.NOMOR=A.NOAlamatKirim

	--left outer join dbExpedisi M on M.KodeExp=A.KodeExp

	left outer join DBPROJECT P on P.KODEPROJECT=A.AlamatKirim

	left outer join dbSpesifikasiSO Sp on Sp.NoBukti=A.NOBUKTI

	where	A.NoBukti=@NoBukti

	order by B.Urut



 else



if @Tipe=1



truncate table TempCetakSO

	

	insert into TempCetakSO (NoBukti, Urut, KodeBrg, Qnt, Satuan) 

	select A.NOBUKTI, A.URUT, A.KODEBRG, Case When B.KODESUBGRP='UD' Then Case When A.NOSAT=2 Then A.QNt2 Else A.QNT  Else A.QNT  , Case When B.KODESUBGRP='UD' Then Case When A.NOSAT=2 Then B.SAT2 else A.SATUAN  else A.SATUAN  Satuan

	from DBSODET A

	Left Outer Join DBBARANG B on B.KODEBRG=A.KODEBRG

	where A.NOBUKTI=@NOBUKTI

	order by A.URUT

	

	select @CountSO=COUNT(*) from DBSODET where NOBUKTI=@NOBUKTI

	

	insert into TempCetakSO (NoBukti, Urut, KodeBrg, Qnt, Satuan) 

	select @NOBUKTI, null URUT, null KODEBRG, null QNT, null SATUAN

	from dbNoUrut A

	where A.NoUrut<=14-@CountSO

	

	Select 	Left(A.NoBukti,3)+'FPP/'+SUBSTR(A.NOBUKTI, LENGTH(A.NOBUKTI)-10+1) NoPermintaan, A.Tanggal, A.NOBUKTI NoKontrak, 

		'' NamaPershCust, C.NAMACUSTSUPP NamaCust, C.Alamat AlamatCust,

		C.TELPON TelpHPCust,

		P.NAMAPROJECT NamaProyek, P.ALAMATPROJECT AlamatProyek,

		F.Nama NamaSls,

		case when YEAR(A.Jam)<=1900 then null else A.Jam  TglMinta, 

		case when year(A.TGLKIRIM)<=1900 then null else A.TglKirim  TglKirim, 

		case when YEAR(A.MasaBerlaku)<=1900 then null else A.MasaBerlaku  TglBatasKirim,

		case when COALESCE(B.Urut,0)=0 then null else B0.KeyUrut  Urut, 

		B.KodeBrg, H.NamaBrg+Case When COALESCE(a.KETERANGAN,'')<>'' Then CHAR(13)+'SLUM  '+COALESCE(a.KETERANGAN,'') else ''  NamaBrg, Case When H.KODESUBGRP='UD' Then Case When (B.NOSAT=2 and Upper(H.SAT2)='PCS') Then B.QNT2 When (B.NOSAT=1 and Upper(H.SAT1)='PCS') Then B.QNT Else B.QNT  Else Case When B.NOSAT=2 Then B.QNT2 else B.QNT   Qnt, 

		Case When H.KODESUBGRP='UD' Then Case When (B.NOSAT=2 and Upper(H.SAT2)='PCS') Then H.SAT2 When (B.NOSAT=1 and Upper(H.SAT1)='PCS') Then H.SAT1 else B.SATUAN  else B.SATUAN   Satuan,

        COALESCE(A.CetakKe,0)+1 CetakN,sp.Besi_PCWire,sp.Samb_Tanpa,sp.Samb_Plat,

		Sp.Beton_K350, Sp.Beton_K400, Sp.Beton_K500, Sp.Besi_WRU50, Sp.Besi_BJTD40, Sp.Besi_BJTP24,

		Sp.Semen_Type, cast(case when COALESCE(Sp.Semen_Type,0)=0 then 'Type 1' else ''  as varchar(50)) MySemen_Type,

		Sp.Samb_ButJoint, Sp.Samb_QuicklyJoint, Sp.Samb_SocketSpigot, Sp.Samb_MaleFemale,

		A.CATATAN,H.Hrg3_2 Berat,C.ContactP,case when Substring(a.NOBUKTI,2,2)='CB' Then 'JASA'else 'BELI'  Caption

	,F.TeleponHP,CAST(CAST(b.NilaiPPN*100 AS TINYINT AS TEXT))+'%' pajak 

	From dbSO A

	Left outer join TempCetakSO B0 on B0.NoBukti=A.NOBUKTI

	Left Outer join dbSODet B on B.NoBukti=B0.NoBukti and B.URUT=B0.Urut

	Left Outer Join vwCUSTSUPP C on C.KODECUSTSUPP=A.KodeCust

	--Left Outer join dbValas D on D.KodeVls=A.KodeVls

	left outer join dbKaryawan F on F.KeyNIK=A.KodeSls

	Left Outer Join DBBARANG H on H.KodeBrg=B.KodeBrg

	--Left Outer Join vwRpDetSO I on I.NoBukti=A.NoBukti

	--Left Outer Join vwAlamatCust O on O.KODECUSTSUPP=A.KODECUST and O.NOMOR=A.NOAlamatKirim

	--left outer join dbExpedisi M on M.KodeExp=A.KodeExp

	left outer join DBPROJECT P on P.KODEPROJECT=A.AlamatKirim

	left outer join dbSpesifikasiSO Sp on Sp.NoBukti=A.NOBUKTI

	where	A.NoBukti=@NoBukti

	order by B0.KeyUrut;

-- sp_CetakSOJ
CREATE PROCEDURE IF NOT EXISTS sp_CetakSOJ AS -- DECLARE REMOVED



if @Tipe=0



Select 	A.NoBukti NoKP, A.Tanggal TglKP, A.MasaBerlaku TglBatas,

		C.USAHA+' '+C.NAMACUSTSUPP NamaCust, C.Alamat AlamatCust,

		C.ContactP ContactCust, C.TELPON TelpHPCust,

		C.FAX+'  '+C.EMAIL FaxEmailCust,

		P.NAMAPROJECT NamaProyek, P.ALAMATPROJECT AlamatProyek,

		P.ContactP ContactProyek, P.TelpHP TelpHPProyek,

		P.Fax+'  '+P.EMAIL FaxEmailProyek,

		B.Urut, B.KodeBrg, H.NamaBrg, B.Qnt, H.Sat1 Satuan,

        B.HrgNetto HargaSat, B.SUBTOTALRp, B.NDPPRp, B.NPPNRp, B.NNETRp,

		case when YEAR(A.Jam)<=1900 then null else A.Jam  TglMinta, 

		case when year(A.TGLKIRIM)<=1900 then null else A.TglKirim  TglKirim, 

		case when YEAR(A.MasaBerlaku)<=1900 then null else A.MasaBerlaku  TglBatasKirim,

		Sp.Beton_K350, Sp.Beton_K400, Sp.Beton_K500, Sp.Besi_WRU50, Sp.Besi_BJTD40, Sp.Besi_BJTP24,

		Sp.Semen_Type, cast(case when COALESCE(Sp.Semen_Type,0)=0 then 'Type 1' else ''  as varchar(50)) MySemen_Type,

		Sp.Samb_ButJoint, Sp.Samb_QuicklyJoint, Sp.Samb_SocketSpigot, Sp.Samb_MaleFemale,

		sp.Besi_PCWire,sp.Samb_Tanpa,sp.Samb_Plat,

		dbo.fnc_MutuBetonSO(A.NOBUKTI) MyMutuBeton,

		dbo.fnc_MutuBesiSO(A.NOBUKTI) MyMutuBesi,

		dbo.fnc_SambunganSO(A.NOBUKTI) MySambungan,

		'Type 1' MySemenType,

		cast(case when A.NoAlamatKirim=0 then 1 else 0  as INTEGER) IsLoko,

		cast(case when A.NoAlamatKirim=1 then 1 else 0  as INTEGER) IsFrankoOnTruck,

		cast(case when A.NoAlamatKirim=2 then 1 else 0  as INTEGER) IsFrankoOnSite,

		cast(case when A.NoAlamatKirim=3 then 1 else 0  as INTEGER) IsTerpasang,

		CAST(F.Nama+' '+F.TeleponHP as varchar(100)) ContactPersonCA,

		CAST(C.ContactP as varchar(100)) NamaTtdCust,

		CAST(COALESCE(A.NamaTtd,'') as varchar(100)) NamaTtdCalvary,

		CAST(COALESCE(A.JabatanTtd,'') as varchar(100)) JabatanTtdcalvary,

		case when A.NoAlamatKirim=0 Then 'Loko'

		     when A.NoAlamatKirim=1 Then 'Franko On Truck'

		     when A.NoAlamatKirim=2 Then 'Franko On Site'

		     when A.NoAlamatKirim=3 Then 'Terpasang'  SifatKirim,'KONFIRMASI JASA' Caption,c.KODEPOS

	,F.TeleponHP

	From dbSO A

	Left Outer join dbSODet B on B.NoBukti=A.NoBukti 

	Left Outer Join vwCUSTSUPP C on C.KODECUSTSUPP=A.KodeCust

	Left Outer join dbValas D on D.KodeVls=A.KodeVls

	left outer join dbKaryawan F on F.KeyNIK=A.KodeSls

	Left Outer Join DBBARANG H on H.KodeBrg=B.KodeBrg

	--Left Outer Join vwRpDetSO I on I.NoBukti=A.NoBukti

	--Left Outer Join vwAlamatCust O on O.KODECUSTSUPP=A.KODECUST and O.NOMOR=A.NOAlamatKirim

	--left outer join dbExpedisi M on M.KodeExp=A.KodeExp

	left outer join DBPROJECT P on P.KODEPROJECT=A.AlamatKirim

	left outer join dbSpesifikasiSO Sp on Sp.NoBukti=A.NOBUKTI

	where	A.NoBukti=@NoBukti

	order by B.Urut



 else



if @Tipe=1



truncate table TempCetakSO

	

	insert into TempCetakSO (NoBukti, Urut, KodeBrg, Qnt, Satuan) 

	select A.NOBUKTI, A.URUT, A.KODEBRG, A.QNT, A.SATUAN

	from DBSODET A

	where A.NOBUKTI=@NOBUKTI

	order by A.URUT

	

	select @CountSO=COUNT(*) from DBSODET where NOBUKTI=@NOBUKTI

	

	insert into TempCetakSO (NoBukti, Urut, KodeBrg, Qnt, Satuan) 

	select @NOBUKTI, null URUT, null KODEBRG, null QNT, null SATUAN

	from dbNoUrut A

	where A.NoUrut<=14-@CountSO

	

	Select 	Left(A.NoBukti,3)+'FPP/'+SUBSTR(A.NOBUKTI, LENGTH(A.NOBUKTI)-10+1) NoPermintaan, A.Tanggal, A.NoPesanan NoKontrak, 

		'' NamaPershCust, C.NAMACUSTSUPP NamaCust, C.Alamat AlamatCust,

		C.TELPON TelpHPCust,

		P.NAMAPROJECT NamaProyek, P.ALAMATPROJECT AlamatProyek,

		F.Nama NamaSls,

		case when YEAR(A.Jam)<=1900 then null else A.Jam  TglMinta, 

		case when year(A.TGLKIRIM)<=1900 then null else A.TglKirim  TglKirim, 

		case when YEAR(A.MasaBerlaku)<=1900 then null else A.MasaBerlaku  TglBatasKirim,

		case when COALESCE(B.Urut,0)=0 then null else B0.KeyUrut  Urut, 

		B.KodeBrg, H.NamaBrg, B.Qnt, H.Sat1 Satuan,

        COALESCE(A.CetakKe,0)+1 CetakN,sp.Besi_PCWire,sp.Samb_Tanpa,sp.Samb_Plat,

		Sp.Beton_K350, Sp.Beton_K400, Sp.Beton_K500, Sp.Besi_WRU50, Sp.Besi_BJTD40, Sp.Besi_BJTP24,

		Sp.Semen_Type, cast(case when COALESCE(Sp.Semen_Type,0)=0 then 'Type 1' else ''  as varchar(50)) MySemen_Type,

		Sp.Samb_ButJoint, Sp.Samb_QuicklyJoint, Sp.Samb_SocketSpigot, Sp.Samb_MaleFemale,

		A.CATATAN,H.Hrg3_2 Berat,C.ContactP,case when Left(a.NOBUKTI,2)='CB' Then 'JASA'else 'BELI'  Caption

	From dbSO A

	Left outer join TempCetakSO B0 on B0.NoBukti=A.NOBUKTI

	Left Outer join dbSODet B on B.NoBukti=B0.NoBukti and B.URUT=B0.Urut

	Left Outer Join vwCUSTSUPP C on C.KODECUSTSUPP=A.KodeCust

	--Left Outer join dbValas D on D.KodeVls=A.KodeVls

	left outer join dbKaryawan F on F.KeyNIK=A.KodeSls

	Left Outer Join DBBARANG H on H.KodeBrg=B.KodeBrg

	--Left Outer Join vwRpDetSO I on I.NoBukti=A.NoBukti

	--Left Outer Join vwAlamatCust O on O.KODECUSTSUPP=A.KODECUST and O.NOMOR=A.NOAlamatKirim

	--left outer join dbExpedisi M on M.KodeExp=A.KodeExp

	left outer join DBPROJECT P on P.KODEPROJECT=A.AlamatKirim

	left outer join dbSpesifikasiSO Sp on Sp.NoBukti=A.NOBUKTI

	where	A.NoBukti=@NoBukti

	order by B0.KeyUrut;

-- sp_CetakSOJold
CREATE PROCEDURE IF NOT EXISTS sp_CetakSOJold AS -- DECLARE REMOVED


	Select 	A.NoBukti NoKP, A.Tanggal TglKP, A.MasaBerlaku TglBatas,

		C.NAMACUSTSUPP NamaCust, C.Alamat AlamatCust,

		C.ContactP ContactCust, C.TELPON TelpHPCust,

		C.EMAIL FaxEmailCust,

		P.NAMAPROJECT NamaProyek, P.ALAMATPROJECT AlamatProyek,

		'' ContactProyek, '' TelpHPProyek,

		C.EMAIL FaxEmailProyek,

		B.Urut, B.KodeBrg, H.NamaBrg, B.Qnt, H.Sat1 Satuan,

        B.HrgNetto HargaSat, B.SUBTOTALRp, B.NDPPRp, B.NPPNRp, B.NNETRp,

		case when YEAR(A.Jam)<=1900 then null else A.Jam  TglMinta, 

		case when year(A.TGLKIRIM)<=1900 then null else A.TglKirim  TglKirim, 

		case when YEAR(A.MasaBerlaku)<=1900 then null else A.MasaBerlaku  TglBatasKirim,

		Sp.Beton_K350, Sp.Beton_K400, Sp.Beton_K500, Sp.Besi_WRU50, Sp.Besi_BJTD40, Sp.Besi_BJTP24,

		Sp.Semen_Type, cast(case when COALESCE(Sp.Semen_Type,0)=0 then 'Type 1' else ''  as varchar(50)) MySemen_Type,

		Sp.Samb_ButJoint, Sp.Samb_QuicklyJoint, Sp.Samb_SocketSpigot, Sp.Samb_MaleFemale,

		dbo.fnc_MutuBetonSO(A.NOBUKTI) MyMutuBeton,

		dbo.fnc_MutuBesiSO(A.NOBUKTI) MyMutuBesi,

		dbo.fnc_SambunganSO(A.NOBUKTI) MySambungan,

		'Type 1' MySemenType,

		cast(case when A.NoAlamatKirim=0 then 1 else 0  as INTEGER) IsLoko,

		cast(case when A.NoAlamatKirim=1 then 1 else 0  as INTEGER) IsFrankoOnTruck,

		cast(case when A.NoAlamatKirim=2 then 1 else 0  as INTEGER) IsFrankoOnSite,

		cast(case when A.NoAlamatKirim=3 then 1 else 0  as INTEGER) IsTerpasang,

		CAST(F.Nama+' '+F.TeleponHP as varchar(100)) ContactPersonCA,

		CAST(C.ContactP as varchar(100)) NamaTtdCust,

		CAST(COALESCE(A.NamaTtd,'') as varchar(100)) NamaTtdCalvary,

		CAST(COALESCE(A.JabatanTtd,'') as varchar(100)) JabatanTtdcalvary

	From dbSO A

	Left Outer join dbSODet B on B.NoBukti=A.NoBukti 

	Left Outer Join vwCUSTSUPP C on C.KODECUSTSUPP=A.KodeCust

	Left Outer join dbValas D on D.KodeVls=A.KodeVls

	left outer join dbKaryawan F on F.KeyNIK=A.KodeSls

	Left Outer Join DBBARANG H on H.KodeBrg=B.KodeBrg

	--Left Outer Join vwRpDetSO I on I.NoBukti=A.NoBukti

	--Left Outer Join vwAlamatCust O on O.KODECUSTSUPP=A.KODECUST and O.NOMOR=A.NOAlamatKirim

	--left outer join dbExpedisi M on M.KodeExp=A.KodeExp

	left outer join DBPROJECT P on P.KODEPROJECT=A.AlamatKirim

	left outer join dbSpesifikasiSO Sp on Sp.NoBukti=A.NOBUKTI

	where	A.NoBukti=@NoBukti

	order by B.Urut;

-- sp_CetakSONP
CREATE PROCEDURE IF NOT EXISTS sp_CetakSONP AS WITH CetakSNP ( NoKP,	TglKP,	TglBatas	,NamaCust	,AlamatCust	,ContactCust,	TelpHPCust,	FaxEmailCust,	NamaProyek,	AlamatProyek,	ContactProyek,	TelpHPProyek,	FaxEmailProyek,	Urut,	KodeBrg,	NamaBrg,	Qnt,	SATUAN,	HargaSat,	SUBTOTALRp,	NDPPRp,	NPPNRp,	NNETRp,	TglMinta,	TglKirim,	TglBatasKirim,	Beton_K350,	Beton_K400,	Beton_K500,	Besi_WRU50	,Besi_BJTD40,	Besi_BJTP24,	Semen_Type,	MySemen_Type,	Samb_ButJoint	,Samb_QuicklyJoint,	Samb_SocketSpigot	,Samb_MaleFemale,	Besi_PCWire	,Samb_Tanpa,	Samb_Plat,	MyMutuBeton,	MyMutuBesi,	MySambungan	,MyKirim,	MySemenType,	IsLoko,	IsFrankoOnTruck,	IsFrankoOnSite,

	IsTerpasang,	ContactPersonCA	,NamaTtdCust,	NamaTtdCalvary	,NamaTtdCalvaryPlus,	JabatanTtdcalvary	,SifatKirim	,Caption,	KODEPOS	,TeleponHP,	NDISKON	,ketgab,TTDCEO,HargaRp,VolumeRp)  

AS  

(  



	Select 	A.NoBukti NoKP, A.Tanggal TglKP, A.MasaBerlaku TglBatas,

		C.USAHA+' '+C.NAMACUSTSUPP NamaCust, C.Alamat AlamatCust,

		C.ContactP ContactCust, C.TELPON TelpHPCust,

		C.FAX+'  '+C.EMAIL FaxEmailCust,

		P.NAMAPROJECT NamaProyek, P.ALAMATPROJECT AlamatProyek,

		P.ContactP ContactProyek, P.TelpHP TelpHPProyek,

		P.FAX+'  '+P.EMAIL FaxEmailProyek,

		B.Urut, B.KodeBrg, Case When COALESCE(B.IsUbahNama,0)=0 Then Case When COALESCE(H.ISJasa,0)=0 Then H.NamaBrg else  B.NamaBrg  else H.NamaBrg2 

		                   +Case When dbo.fnc_NamaBrgSO(a.NOBUKTI,B.KODEBRG)='' Then '' else CHAR(13)+'- '+dbo.fnc_NamaBrgSO(a.NOBUKTI,B.KODEBRG) 

		                   +case when COALESCE(Ketbatal,'')='' Then '' else CHAR(13)+COALESCE(Ketbatal,'') 

		                   NamaBrg ,Case when NOSAT=1 Then B.Qnt else B.QNT2  Qnt, case when NOSAT=2 Then B.SATUAN+CHAR(13)+ CAST(B.ISI AS TEXT)+' '+H.SAT1+CHAR(13)+'[ 1 ]' else B.SATUAN  SATUAN,

        B.HrgNetto HargaSat, B.SUBTOTALRp,B.SUBTOTALRp NDPPRp,0 NPPNRp, B.SUBTOTALRp NNETRp,

		case when YEAR(A.Jam)<=1900 then null else A.Jam  TglMinta, 

		case when year(A.TGLKIRIM)<=1900 then null else A.TglKirim  TglKirim, 

		case when YEAR(A.MasaBerlaku)<=1900 then null else A.MasaBerlaku  TglBatasKirim,

		Sp.Beton_K350, Sp.Beton_K400, Sp.Beton_K500, Sp.Besi_WRU50, Sp.Besi_BJTD40, Sp.Besi_BJTP24,

		Sp.Semen_Type, cast(case when COALESCE(Sp.Semen_Type,0)=0 then 'Type 1' else ''  as varchar(50)) MySemen_Type,

		Sp.Samb_ButJoint, Sp.Samb_QuicklyJoint, Sp.Samb_SocketSpigot, Sp.Samb_MaleFemale,

		sp.Besi_PCWire,sp.Samb_Tanpa,sp.Samb_Plat,

		dbo.fnc_MutuBetonSO(A.NOBUKTI) MyMutuBeton,

		dbo.fnc_MutuBesiSO(A.NOBUKTI) MyMutuBesi,

		dbo.fnc_SambunganSO(A.NOBUKTI) MySambungan,

		dbo.fnc_SifatPengiriman(A.NOBUKTI) MyKirim,

		'Type 1' MySemenType,

		cast(case when A.NoAlamatKirim=0 then 1 else 0  as INTEGER) IsLoko,

		cast(case when A.NoAlamatKirim=1 then 1 else 0  as INTEGER) IsFrankoOnTruck,

		cast(case when A.NoAlamatKirim=2 then 1 else 0  as INTEGER) IsFrankoOnSite,

		cast(case when A.NoAlamatKirim=3 then 1 else 0  as INTEGER) IsTerpasang,

		CAST(F.Nama+' '+F.TeleponHP as varchar(100)) ContactPersonCA,

		CAST(C.ContactP as varchar(100)) NamaTtdCust,

		CAST(COALESCE(A.NamaTtd,'') as varchar(100)) NamaTtdCalvary,

		CAST(COALESCE(A.NamaTtd,'')+'  '+COALESCE(F.TeleponHP,'') as varchar(100)) NamaTtdCalvaryPlus,

		CAST(COALESCE(A.JabatanTtd,'') as varchar(100)) JabatanTtdcalvary,

		case when A.NoAlamatKirim=0 Then 'Loko'

		     when A.NoAlamatKirim=1 Then 'Franko On Truck'

		     when A.NoAlamatKirim=2 Then 'Franko On Site'

		     when A.NoAlamatKirim=3 Then 'Terpasang'  SifatKirim,'Sales Order (SO)' Caption,c.KODEPOS,

		F1.TeleponHP,B.NDISKON,Case When Ketbatal='' then '' else '* '+Ketbatal  ketgab,Case when a.TIPESC=0 Then 'ALAM MONANDAR'else 'HENDRIK RAO'  TTDCEO      

	,case When NOSAT=2 then Case when a.KODEVLS='IDR' Then 'Rp' else '$' +'.'+CAST(Cast(b.HARGA as money AS TEXT),1)+CHAR(13)+CHAR(13)+

		'[ '+Case when a.KODEVLS='IDR' Then 'Rp' else '$' +'.'+CAST(Cast(b.HARGA/b.ISI as money AS TEXT),1)+'/'+H.SAT1 +' ]'

		else  Case when a.KODEVLS='IDR' Then 'Rp' else '$' +'.'+CAST(Cast(b.HARGA as money AS TEXT),1)  HargaRP,

		case When NOSAT=2 then CAST(Cast(b.QNT2 as money AS TEXT),1)+CHAR(13)+CHAR(13)+

		'[ '+CAST(Cast(b.QNT2*b.ISI as money AS TEXT),1)+'/'+H.SAT1+' ]' 

		else  CAST(Cast(b.QNT as money AS TEXT),1)  VolumeRp   

	From dbSO A

	Left Outer join dbSODet B on B.NoBukti=A.NoBukti and (COALESCE(B.KodeBrgM,'')='' /*OR B.HARGA<>0*/)

	Left Outer Join vwCUSTSUPP C on C.KODECUSTSUPP=A.KodeCust

	Left Outer join dbValas D on D.KodeVls=A.KodeVls

	left outer join dbKaryawan F on F.KeyNIK=A.KodeSls

	Left Outer Join dbKaryawan F1 on F1.Nama=A.NamaTtd 

	Left Outer Join DBBARANG H on H.KodeBrg=B.KodeBrg

	--Left Outer Join vwRpDetSO I on I.NoBukti=A.NoBukti

	--Left Outer Join vwAlamatCust O on O.KODECUSTSUPP=A.KODECUST and O.NOMOR=A.NOAlamatKirim

	--left outer join dbExpedisi M on M.KodeExp=A.KodeExp

	left outer join DBPROJECT P on P.KODEPROJECT=A.AlamatKirim

	left outer join dbSpesifikasiSO Sp on Sp.NoBukti=A.NOBUKTI

	where	A.NoBukti=@NoBukti

	)

	

	select * from CetakSNP  order by Urut;

-- sp_CetakSORev
CREATE PROCEDURE IF NOT EXISTS sp_CetakSORev AS -- DECLARE REMOVED



if @Tipe=0



Select 	A.NoBukti NoKP, A.Tanggal TglKP, A.MasaBerlaku TglBatas,

		C.USAHA+' '+C.NAMACUSTSUPP NamaCust, C.Alamat AlamatCust,

		C.ContactP ContactCust, C.TELPON TelpHPCust,

		C.FAX+'  '+C.EMAIL FaxEmailCust,

		P.NAMAPROJECT NamaProyek, P.ALAMATPROJECT AlamatProyek,

		P.ContactP ContactProyek, P.TelpHP TelpHPProyek,

		P.FAX+'  '+P.EMAIL FaxEmailProyek,

		B.Urut, B.KodeBrg, H.NamaBrg, B.Qnt, H.Sat1 Satuan,

        B.HrgNetto HargaSat, B.SUBTOTALRp, B.NDPPRp, B.NPPNRp, B.NNETRp,

		case when YEAR(A.Jam)<=1900 then null else A.Jam  TglMinta, 

		case when year(A.TGLKIRIM)<=1900 then null else A.TglKirim  TglKirim, 

		case when YEAR(A.MasaBerlaku)<=1900 then null else A.MasaBerlaku  TglBatasKirim,

		Sp.Beton_K350, Sp.Beton_K400, Sp.Beton_K500, Sp.Besi_WRU50, Sp.Besi_BJTD40, Sp.Besi_BJTP24,

		Sp.Semen_Type, cast(case when COALESCE(Sp.Semen_Type,0)=0 then 'Type 1' else ''  as varchar(50)) MySemen_Type,

		Sp.Samb_ButJoint, Sp.Samb_QuicklyJoint, Sp.Samb_SocketSpigot, Sp.Samb_MaleFemale,

		sp.Besi_PCWire,sp.Samb_Tanpa,sp.Samb_Plat,

		dbo.fnc_MutuBetonSO(A.NOBUKTI) MyMutuBeton,

		dbo.fnc_MutuBesiSO(A.NOBUKTI) MyMutuBesi,

		dbo.fnc_SambunganSO(A.NOBUKTI) MySambungan,

		'Type 1' MySemenType,

		cast(case when A.NoAlamatKirim=0 then 1 else 0  as INTEGER) IsLoko,

		cast(case when A.NoAlamatKirim=1 then 1 else 0  as INTEGER) IsFrankoOnTruck,

		cast(case when A.NoAlamatKirim=2 then 1 else 0  as INTEGER) IsFrankoOnSite,

		cast(case when A.NoAlamatKirim=3 then 1 else 0  as INTEGER) IsTerpasang,

		CAST(F.Nama+' '+F.TeleponHP as varchar(100)) ContactPersonCA,

		CAST(C.ContactP as varchar(100)) NamaTtdCust,

		CAST(COALESCE(A.NamaTtd,'') as varchar(100)) NamaTtdCalvary,

		CAST(COALESCE(A.NamaTtd,'')+'  '+COALESCE(F.TeleponHP,'') as varchar(100)) NamaTtdCalvaryPlus,

		CAST(COALESCE(A.JabatanTtd,'') as varchar(100)) JabatanTtdcalvary,

		case when A.NoAlamatKirim=0 Then 'Loko'

		     when A.NoAlamatKirim=1 Then 'Franko On Truck'

		     when A.NoAlamatKirim=2 Then 'Franko On Site'

		     when A.NoAlamatKirim=3 Then 'Terpasang'  SifatKirim,'KONFIRMASI PEMBELIAN' Caption,c.KODEPOS,B1.RevisiKe,F1.TeleponHP,B.NDISKON 

	From dbSO A

	Left Outer join dbSODet B on B.NoBukti=A.NoBukti 

	Left Outer join (Select MAX(RevisiKe)RevisiKe,NOBUKTI from DBSORev Group By NOBUKTI) B1 on B1.NoBukti=A.NoBukti 

	Left Outer Join vwCUSTSUPP C on C.KODECUSTSUPP=A.KodeCust

	Left Outer join dbValas D on D.KodeVls=A.KodeVls

	left outer join dbKaryawan F on F.KeyNIK=A.KodeSls

	Left Outer Join dbKaryawan F1 on F1.Nama=A.NamaTtd 

	Left Outer Join DBBARANG H on H.KodeBrg=B.KodeBrg

	--Left Outer Join vwRpDetSO I on I.NoBukti=A.NoBukti

	--Left Outer Join vwAlamatCust O on O.KODECUSTSUPP=A.KODECUST and O.NOMOR=A.NOAlamatKirim

	--left outer join dbExpedisi M on M.KodeExp=A.KodeExp

	left outer join DBPROJECT P on P.KODEPROJECT=A.AlamatKirim

	left outer join dbSpesifikasiSO Sp on Sp.NoBukti=A.NOBUKTI

	where	A.NoBukti=@NoBukti

	order by B.Urut



 else



if @Tipe=1



truncate table TempCetakSO

	

	insert into TempCetakSO (NoBukti, Urut, KodeBrg, Qnt, Satuan) 

	select A.NOBUKTI, A.URUT, A.KODEBRG, A.QNT, A.SATUAN

	from DBSODET A

	where A.NOBUKTI=@NOBUKTI

	order by A.URUT

	

	select @CountSO=COUNT(*) from DBSODET where NOBUKTI=@NOBUKTI

	

	insert into TempCetakSO (NoBukti, Urut, KodeBrg, Qnt, Satuan) 

	select @NOBUKTI, null URUT, null KODEBRG, null QNT, null SATUAN

	from dbNoUrut A

	where A.NoUrut<=14-@CountSO

	

	Select 	Left(A.NoBukti,3)+'FPP/'+SUBSTR(A.NOBUKTI, LENGTH(A.NOBUKTI)-10+1) NoPermintaan, A.Tanggal, A.NoPesanan NoKontrak, 

		'' NamaPershCust, C.NAMACUSTSUPP NamaCust, C.Alamat AlamatCust,

		C.TELPON TelpHPCust,

		P.NAMAPROJECT NamaProyek, P.ALAMATPROJECT AlamatProyek,

		F.Nama NamaSls,

		case when YEAR(A.Jam)<=1900 then null else A.Jam  TglMinta, 

		case when year(A.TGLKIRIM)<=1900 then null else A.TglKirim  TglKirim, 

		case when YEAR(A.MasaBerlaku)<=1900 then null else A.MasaBerlaku  TglBatasKirim,

		case when COALESCE(B.Urut,0)=0 then null else B0.KeyUrut  Urut, 

		B.KodeBrg, H.NamaBrg, B.Qnt, H.Sat1 Satuan,

        COALESCE(A.CetakKe,0)+1 CetakN,sp.Besi_PCWire,sp.Samb_Tanpa,sp.Samb_Plat,

		Sp.Beton_K350, Sp.Beton_K400, Sp.Beton_K500, Sp.Besi_WRU50, Sp.Besi_BJTD40, Sp.Besi_BJTP24,

		Sp.Semen_Type, cast(case when COALESCE(Sp.Semen_Type,0)=0 then 'Type 1' else ''  as varchar(50)) MySemen_Type,

		Sp.Samb_ButJoint, Sp.Samb_QuicklyJoint, Sp.Samb_SocketSpigot, Sp.Samb_MaleFemale,

		A.CATATAN,H.Hrg3_2 Berat,C.ContactP,case when Left(a.NOBUKTI,2)='CB' Then 'JASA'else 'BELI'  Caption

	From dbSO A

	Left outer join TempCetakSO B0 on B0.NoBukti=A.NOBUKTI

	Left Outer join dbSODet B on B.NoBukti=B0.NoBukti and B.URUT=B0.Urut

	Left Outer Join vwCUSTSUPP C on C.KODECUSTSUPP=A.KodeCust

	--Left Outer join dbValas D on D.KodeVls=A.KodeVls

	left outer join dbKaryawan F on F.KeyNIK=A.KodeSls

	Left Outer Join DBBARANG H on H.KodeBrg=B.KodeBrg

	--Left Outer Join vwRpDetSO I on I.NoBukti=A.NoBukti

	--Left Outer Join vwAlamatCust O on O.KODECUSTSUPP=A.KODECUST and O.NOMOR=A.NOAlamatKirim

	--left outer join dbExpedisi M on M.KodeExp=A.KodeExp

	left outer join DBPROJECT P on P.KODEPROJECT=A.AlamatKirim

	left outer join dbSpesifikasiSO Sp on Sp.NoBukti=A.NOBUKTI

	where	A.NoBukti=@NoBukti

	order by B0.KeyUrut;

-- sp_CetakSPB
CREATE PROCEDURE IF NOT EXISTS sp_CetakSPB AS if @Tipe=1

-- DECLARE REMOVED,@CountSO Int,@No Int,@NoSO Varchar(30)

Select @TglSPB=Tanggal,@No=SUBSTR(NoBukti, LENGTH(NoBukti)-5+1) from dbSPB  where NoBukti=@NoBukti

Select @NoSO=NOSO from dbSPPDet where NoBukti in(select NoSPP from dbSPBDet where NoBukti=@NoBukti Group by NoSPP)

/*Select @CountSO=COALESCE(Count(*),0) from dbSPPDet a

                         Left Outer Join (select a.NoSPP,b.Tanggal,b.NoBukti from dbSPBDet a

                                                        Left Outer Join dbSPB b on a.NoBukti=b.NoBukti  

                                          Group by a.NoSPP,b.Tanggal,b.NoBukti)b on b.NoSPP=a.NoBukti

                         where a.NoSO=@NoSO and  b.Tanggal<=@TglSPB and ( SUBSTR(b.NoBukti, LENGTH(b.NoBukti)-5+1)<=Case When MONTH(b.Tanggal)=MONTH(@TglSPB) and YEAR(b.Tanggal)=YEAR(@TglSPB)Then @No else 500  )

                         Group by NoSO*/

Select @CountSO=SUM(Urut) from(

Select (CAST(ROW_NUMBER() Over(PARTITION BY b.NoBukti Order by b.NoBukti) As int))Urut from dbSPPDet a

                         Left Outer Join (select a.NoSPP,b.Tanggal,b.NoBukti from dbSPBDet a

                                                        Left Outer Join dbSPB b on a.NoBukti=b.NoBukti  

                                          Group by a.NoSPP,b.Tanggal,b.NoBukti )b on b.NoSPP=a.NoBukti

                         where a.NoSO=@NoSO and  b.Tanggal<=@TglSPB and ( SUBSTR(b.NoBukti, LENGTH(b.NoBukti)-5+1)<=Case When MONTH(b.Tanggal)=MONTH(@TglSPB) and YEAR(b.Tanggal)=YEAR(@TglSPB)Then @No else 5000  )

                         Group by b.NoBukti

                         )a

                      

---------------------------------------

	select A.NoBukti, A.Tanggal,A.KodeCustSupp, C.NAMACUSTSUPP+' ('+COALESCE(P.ContactP,'')+' '+COALESCE(P.TelpHP,'')+')' NAMACUSTSUPP,@CountSO JmlAngkut, 

		Sdet.NoSO NOSO, case when COALESCE(isDO,'')=''then '' else 'DO'  DO,

		 COALESCE(P.NAMAPROJECT,'-') NAMAPROJECT, '' ContactP, '' TelpContactP,a.Catatan, 

		A.NoPolKend, A.Sopir, B.QNT,QNT2, B.SAT_1, B.SAT_2, Case when COALESCE(B.NamaBrg,'')='' Then D.NamaBrg when COALESCE(B.NamaBrg,'') Like '%Terpasang%' Then D.NamaBrg else B.NamaBrg   NamaBrg,NoPesan,COALESCE(A.NoTarif,'')NoTarif,c.ALAMAT

	,Case When D.ISI2>D.ISI1 Then D.SAT1 when D.ISI2=D.ISI1 Then D.SAT1 else D.SAT2  SA_1,Case When D.ISI2<D.ISI1 Then D.SAT1 WHEN D.ISI2=D.ISI1 Then D.SAT2 else D.SAT2  SA_2,COALESCE(a.CetakKe,0)+1 Cetakke,

	d.KODESUBGRP,P.ContactP+' '+P.TelpHP Penerima,a.NoRetur,Sdet.SLUMP

	from dbSPB A

	left outer join dbSPBDet B on B.NoBukti = A.NoBukti

	left outer join DBPROJECT P on P.KODEPROJECT=A.NoResi

	left outer join vwCUSTSUPP C on C.KODECUSTSUPP = A.KodeCustSupp

	left outer join DBBARANG D on D.KODEBRG = B.KodeBrg

	left outer join dbSPP S on S.NoBukti=B.NoSPP

	left outer join (select a.NoBukti,b.NoBukti NoSO,so.KETERANGAN SLUMP from dbSPPDet a 

	                 left Outer Join DBSO so on so.NOBUKTI=a.NoSO  

	                 Left Outer Join (select NoBukti,Urut from DBSODET where KodeBrg Not In(select COALESCE(KodeBrgM,'') from DBSODET where NOBUKTI=@NoSO Group By COALESCE(KodeBrgM,''),Urut))b on a.NoSO=b.NOBUKTI and a.UrutSO=b.URUT

	                 where b.NOBUKTI is Not Null

	                 group by a.NoBukti,b.NoBukti,so.KETERANGAN ) Sdet On Sdet.NoBukti=S.NoBukti

	--left outer join (select a.NoBukti,a.NoSO,UrutSO from dbSPPDet a group by a.NoBukti,a.NoSO,UrutSO) Sdet On Sdet.NoBukti=S.NoBukti --and Sdet.Urut=b.UrutSPP

	--Left Outer Join (select KodeBrg,NoBukti,Urut from DBSODET where KodeBrg Not In(select COALESCE(KodeBrgM,'') from DBSODET where NOBUKTI=@NoSO Group By COALESCE(KodeBrgM,'')))so on so.NOBUKTI=Sdet.NoSO and so.Urut=Sdet.UrutSO and SO.KODEBRG=b.KodeBrg and SO.KODEBRG Is Not Null

	where A.NoBukti = @NoBukti 

	order by B.Urut


if @Tipe=2

select A.NoBukti, A.Tanggal, C.NAMACUSTSUPP, C.ALAMAT1 ALAMAT, 

		JK.NAMAJENISKEND, A.NoPolKend, A.Sopir, B.NamaTarif, 

		case when B.Satuan='' then null else B.Qty  Qty, 

		B.Satuan, 

		case when B.Satuan='' then null else B.RpTarif  RpTarif, 

		B.RpTotalTarif 

	from dbSPB A

	left outer join DBTarifSPB B on B.NoBukti = A.NoBukti

	left outer join vwCUSTSUPP C on C.KODECUSTSUPP = A.KodeCustSupp

	left outer join DBKENDARAAN K on K.KODEKEND=A.NoContainer

	left outer join DBJENISKEND JK on JK.KODEJENISKEND=K.KODEJENISKEND

	where A.NoBukti = @NoBukti

	order by B.Urut



if @Tipe=3

Select @TglSPB=Tanggal,@No=SUBSTR(NoBukti, LENGTH(NoBukti)-5+1) from dbSPB  where NoBukti=@NoBukti

Select @NoSO=NOSO from dbSPPDet where NoBukti in(select NoSPP from dbSPBDet where NoBukti=@NoBukti Group by NoSPP)

Select @CountSO=COALESCE(Count(*),0) from dbSPP a

                         Left Outer Join (select a.NoSPP,b.Tanggal,b.NoBukti from dbSPBDet a

                                                        Left Outer Join dbSPB b on a.NoBukti=b.NoBukti  

                                          Group by a.NoSPP,b.Tanggal,b.NoBukti)b on b.NoSPP=a.NoBukti

                         where a.NoSHIP=@NoSO and  b.Tanggal<=@TglSPB and ( SUBSTR(b.NoBukti, LENGTH(b.NoBukti)-5+1)<=Case When MONTH(b.Tanggal)=MONTH(@TglSPB) and YEAR(b.Tanggal)=YEAR(@TglSPB)Then @No else 500  )

                         Group by NoSHIP 

---------------------------------------

	select A.NoBukti, A.Tanggal, C.NAMACUSTSUPP+' ('+COALESCE(P.ContactP,'')+' '+COALESCE(P.TelpHP,'')+')' NAMACUSTSUPP,@CountSO JmlAngkut, 

		Sdet.NoSO NOSO, COALESCE(P.NAMAPROJECT,'-') NAMAPROJECT, '' ContactP, '' TelpContactP,a.Catatan, 

		A.NoPolKend, A.Sopir, B.QNT,QNT2, B.SAT_1, B.SAT_2, Case when COALESCE(B.NamaBrg,'')='' Then D.NamaBrg else B.NamaBrg  NamaBrg,NoPesan,COALESCE(A.NoTarif,'')NoTarif,c.ALAMAT

	,Case When D.ISI2>D.ISI1 Then D.SAT1 when D.ISI2=D.ISI1 Then D.SAT1 else D.SAT2  SA_1,Case When D.ISI2<D.ISI1 Then D.SAT1 WHEN D.ISI2=D.ISI1 Then D.SAT2 else D.SAT2  SA_2,COALESCE(a.CetakKe,0)+1 Cetakke

	from dbSPB A

	left outer join dbSPBDet B on B.NoBukti = A.NoBukti

	left outer join DBPROJECT P on P.KODEPROJECT=A.NoResi

	left outer join vwCUSTSUPP C on C.KODECUSTSUPP = A.KodeCustSupp

	left outer join DBBARANG D on D.KODEBRG = B.KodeBrg

	left outer join dbSPP S on S.NoBukti=B.NoSPP

	left outer join (select a.NoBukti,b.NoBukti NoSO from dbSPPDet a 

	                 Left Outer Join (select NoBukti,Urut from DBSODET where KodeBrg Not In(select COALESCE(KodeBrgM,'') from DBSODET where NOBUKTI=@NoSO Group By COALESCE(KodeBrgM,''),Urut))b on a.NoSO=b.NOBUKTI and a.UrutSO=b.URUT

	                 where b.NOBUKTI is Not Null

	                 group by a.NoBukti,b.NoBukti ) Sdet On Sdet.NoBukti=S.NoBukti

	--left outer join (select a.NoBukti,a.NoSO,UrutSO from dbSPPDet a group by a.NoBukti,a.NoSO,UrutSO) Sdet On Sdet.NoBukti=S.NoBukti --and Sdet.Urut=b.UrutSPP

	--Left Outer Join (select KodeBrg,NoBukti,Urut from DBSODET where KodeBrg Not In(select COALESCE(KodeBrgM,'') from DBSODET where NOBUKTI=@NoSO Group By COALESCE(KodeBrgM,'')))so on so.NOBUKTI=Sdet.NoSO and so.Urut=Sdet.UrutSO and SO.KODEBRG=b.KodeBrg and SO.KODEBRG Is Not Null

	where A.NoBukti = @NoBukti 

	order by B.Urut;

-- sp_CetakTotalKirim
CREATE PROCEDURE IF NOT EXISTS sp_CetakTotalKirim AS -- DECLARE REMOVED,@kodeCustSupp Varchar(20),@Noso Varchar(30)

 select @Tanggal=Tanggal,@kodeCustSupp=KodeCustSupp from dbInvoicePL where NoBukti=@NoBukti

 select @NoSO=NoSo from dbInvoicePLDet where NoBukti=@NoBukti Group By NoSO

-- IF EXISTS REMOVED
Select  Sum(a.QntSisa) QntSisa,SUM(Case when UPPER(SAT_1)='PCS' Then ROund(a.QntSisa,0) when UPPER(SAT_2)='PCS' Then ROund(a.Qnt2Sisa,0) else 0 ) QtySisapcss,SUM(Case when UPPER(SAT_1)='PCS' Then ROund(a.QntSisa,0) else a.QntSisa )  QntSISAPcs,SUM(Case when UPPER(SAT_2)='PCS' Then ROUND(a.Qnt2Sisa,0) else a.Qnt2Sisa )Qnt2SisaPcs  ,Sum(a.Qnt2Sisa)Qnt2Sisa,a.KodeBrg,a.NAMABRG,

 COALESCE(b1.QntLalu,0)QntLalu,SAT_1,SAT_2,

 Case When D.ISI2>D.ISI1 Then D.SAT1 when D.ISI2=D.ISI1 Then D.SAT1 else D.SAT2  SA_1,Case When D.ISI2<D.ISI1 Then D.SAT1 WHEN D.ISI2=D.ISI1 Then D.SAT2 else D.SAT2  SA_2,

 Case When D.SAT1=a.SAT_1 Then 1 when D.SAT1=a.SAT_2 Then 2  Nosat

 from vwReportRekapKirim a

 Left Outer Join dbInvoicePL a1 On a1.NoBukti=@NoBukti

 Left Outer Join DBBARANG d  on d.KODEBRG=a.KodeBrg

 Left Outer Join (Select Sum(QntSisa) QntLalu,KodeBrg from vwReportRekapKirim where NoBukti in(Select NoSPB from dbInvoicePLDet x Left Outer Join dbInvoicePL b on x.NoBukti=b.NoBukti where b.Tanggal<@Tanggal and NoSO=@Noso and b.KodeCustSupp=@kodeCustSupp)group by KodeBrg)b1 On  b1.KodeBrg=a.KodeBrg

 Left Outer Join(Select NoBukti,NOSO from dbInvoicePLDet group by NoBukti,NoSO)a2 On a2.NoBukti=a1.NoBukti 

 Left Outer Join dbCustSupp b on a.KodeCustSupp=b.KODECUSTSUPP

 where a.NoSO in(Select NoSO from dbInvoicePLDet where NoBukti=@NoBukti)

 Group By a.KodeBrg,a.NAMABRG,COALESCE(b1.QntLalu,0),D.ISI2,D.ISI1,D.SAT1 , D.SAT2,SAT_1,SAT_2

 order by NAMABRG



else

Select   Sum(a.QntSisa)  QntSisa,SUM(Case when UPPER(SAT_1)='PCS' Then ROund(a.QntSisa,0) when UPPER(SAT_2)='PCS' Then ROund(a.Qnt2Sisa,0) else 0 ) QtySisapcss, SUM(Case when UPPER(SAT_1)='PCS' Then ROund(a.QntSisa,0) else a.QntSisa )  QntSISAPcs,SUM(Case when UPPER(SAT_2)='PCS' Then ROUND(a.Qnt2Sisa,0) else a.Qnt2Sisa )Qnt2SisaPcs,Sum(a.Qnt2Sisa)Qnt2Sisa,a.KodeBrg,a.NAMABRG,

 COALESCE(b1.QntLalu,0)QntLalu,SAT_1,SAT_2,

 Case When D.ISI2>D.ISI1 Then D.SAT1 when D.ISI2=D.ISI1 Then D.SAT1 else D.SAT2  SA_1,Case When D.ISI2<D.ISI1 Then D.SAT1 WHEN D.ISI2=D.ISI1 Then D.SAT2 else D.SAT2  SA_2,

 '' Nosat

 from vwReportRekapKirim a

 Left Outer Join dbInvoicePL a1 On a1.NoBukti=@NoBukti

 Left Outer Join DBBARANG d  on d.KODEBRG=a.KodeBrg

 Left Outer Join (Select Sum(QntSisa) QntLalu,KodeBrg from vwReportRekapKirim where NoBukti in(Select NoSPB from dbInvoicePLDet x Left Outer Join dbInvoicePL b on x.NoBukti=b.NoBukti where b.Tanggal<@Tanggal and NoSO=@Noso and b.KodeCustSupp=@kodeCustSupp)group by KodeBrg)b1 On  b1.KodeBrg=a.KodeBrg

 Left Outer Join(Select NoBukti,NOSO from dbInvoicePLDet group by NoBukti,NoSO)a2 On a2.NoBukti=a1.NoBukti 

 Left Outer Join dbCustSupp b on a.KodeCustSupp=b.KODECUSTSUPP

 where a.NoBukti in(Select NoSPB from dbInvoicePLDet where NoBukti=@NoBukti)

 Group By a.KodeBrg,a.NAMABRG,COALESCE(b1.QntLalu,0),D.ISI2,D.ISI1,D.SAT1 , D.SAT2,SAT_1,SAT_2

 order by NAMABRG;

-- sp_CetakTotalKirimSJ
CREATE PROCEDURE IF NOT EXISTS sp_CetakTotalKirimSJ AS -- DECLARE REMOVED,@kodeCustSupp Varchar(20),@Noso Varchar(30)

 select @Tanggal=Tanggal,@kodeCustSupp=KodeCustSupp from dbSPB where NoBukti=@NoBukti

 select @NoSO=b.NoSo from dbSPBDET a Left Outer Join dbSPPDet b on a.NoSPP=b.NoBukti and a.UrutSPP=b.Urut

 where a.NoBukti=@NoBukti Group By b.NoSO

 

/*if @Noso is null 

Select 'a', Sum(a.QNT2-COALESCE(rsp.QNT2R,0)) Qnt2Sisa,0 QntLalu,a.SAT_2,'' SA_1,a.SAT_1

 from  dbSPB b left Outer Join

 dbSPBdet a on a.NoBukti=b.NoBukti 

 Left Outer Join dbSPPdet c on c.NoBukti=a.NoSPP and c.Urut=a.urutSPP

 Left Outer Join(select NOSPB,UrutSPB,SUM(Qnt2)QNT2R from DBRSPBDet  Group by NOSPB,UrutSPB)rsp on rsp.NoSPB=a.NoBukti and rsp.UrutSPB=a.Urut

 where  a.NoBukti=@NoBukti and b.KodeCustSupp=@kodeCustSupp 

 Group By a.SAT_2,a.SAT_1



else*/ -- IF EXISTS REMOVED
Select  Sum(a.QNT2-COALESCE(rsp.QNT2R,0)) Qnt2Sisa,0 QntLalu,a.SAT_2,'' SA_1,a.SAT_1

 from  dbSPB b left Outer Join

 dbSPBdet a on a.NoBukti=b.NoBukti 

 Left Outer Join dbSPPdet c on c.NoBukti=a.NoSPP and c.Urut=a.urutSPP

 Left Outer Join(select NOSPB,UrutSPB,SUM(Qnt2)QNT2R from DBRSPBDet  Group by NOSPB,UrutSPB)rsp on rsp.NoSPB=a.NoBukti and rsp.UrutSPB=a.Urut

 where b.Tanggal=@Tanggal and c.NoSO=@Noso and b.KodeCustSupp=@kodeCustSupp 

 Group By a.SAT_2,a.SAT_1


else

Select  Sum(a.QNT2-COALESCE(rsp.QNT2R,0)) Qnt2Sisa,0 QntLalu,a.SAT_2,'' SA_1,a.SAT_1

 from  dbSPB b left Outer Join

 dbSPBdet a on a.NoBukti=b.NoBukti 

 Left Outer Join dbSPPdet c on c.NoBukti=a.NoSPP and c.Urut=a.urutSPP 

 Left Outer Join(select NOSPB,UrutSPB,SUM(Qnt2)QNT2R from DBRSPBDet  Group by NOSPB,UrutSPB)rsp on rsp.NoSPB=a.NoBukti and rsp.UrutSPB=a.Urut

 where b.Tanggal=@Tanggal and c.NoSO=@Noso and b.KodeCustSupp=@kodeCustSupp 

 Group By a.SAT_2,a.SAT_1;

-- Sp_Contact
CREATE PROCEDURE IF NOT EXISTS Sp_Contact AS -- DECLARE REMOVED

tran

  If @Choice='I' 

  Select @ContactId=Max(COALESCE(Contactid,0)) From dbContact

    -- SET REMOVEDisnull(@ContactId,0)+1

    Insert into dbContact(ContactId,Title,FirstName,MiddleName,LastName,JobTitle,Phone1,Phone2,

                          Phone3,Email,Alamat,--Photo,

                          KODECUSTSUPP)

    Values(@ContactId,@Title,@FirstName,@MiddleName,@LastName,@JobTitle,@Phone1,@Phone2,

           @Phone3,@Email,@Alamat,--@Photo,

           @KodeSupp) 

  

  else if @Choice='U' 

  Update dbContact Set FirstName=@Firstname,MiddleName=@Middlename,LastName=@LastName,JobTitle=@Jobtitle,

                         Phone1=@Phone1,Phone2=@Phone2,Phone3=@Phone3,Email=@Email,Alamat=@Alamat,

                         --Photo=@Photo,

                         Title=@Title

    where Contactid=@Oldkode and KODECUSTSUPP=@kodeSupp

  

  else if @Choice='D'

  Delete From dbContact where Contactid=@OldKode and KODECUSTSUPP=@kodeSupp

  

  if @@Error<>0 Goto JikaSalah

Commit Tran

Return

JikaSalah: Rollback Tran

           raiserror('Proses Input Data Gagal',16,1)

           Return;

-- sp_creatediagram
CREATE PROCEDURE IF NOT EXISTS sp_creatediagram AS 'dbo'

	AS

	set nocount on

	

		-- DECLARE REMOVED

		-- DECLARE REMOVED

		-- DECLARE REMOVED

		-- DECLARE REMOVED

		if(@version is null or @diagramname is null)

		RAISERROR (N'E_INVALIDARG', 16, 1);

			return -1


		execute as caller;

		select @theId = DATABASE_PRINCIPAL_ID(); 

		select @IsDbo = IS_MEMBER(N'db_owner');

		revert; 

		

		if @owner_id is null

		select @owner_id = @theId;

		

		else

		if @theId <> @owner_id

			if @IsDbo = 0

				RAISERROR (N'E_INVALIDARG', 16, 1);

					return -1

				

				select @theId = @owner_id


		-- next 2 line only for test, will be removed after define name unique

		-- IF EXISTS REMOVED
RAISERROR ('The name is already used.', 16, 1);

			return -2


		insert into dbo.sysdiagrams(name, principal_id , version, definition)

				VALUES(@diagramname, @theId, @version, @definition) ;

		

		select @retval = @@IDENTITY 

		return @retval;

-- SP_CUSTSUPP
CREATE PROCEDURE IF NOT EXISTS SP_CUSTSUPP AS tran

if @mode='I'

insert into dbCustSupp(KodeCustSupp, NamaCustSupp, Usaha, Alamat1, Alamat2, Kota, KodePos, Negara,

            		Telpon, Fax, Email, NPWP, Tanggal, Plafon, Hari, Berikat, Jenis,

                         	NamaPKP, AlamatPkp1, Alamatpkp2, KotaPkp, Sales,Kodevls,Perkiraan, KodeTipe,isPpn,Kind,HariHutPiut,

                         	IsAktif, HargaKe)

  	values(@KodeCustSupp, @NamaCustSupp, @Usaha, @Alamat1, @Alamat2, @KodeKota, @KodePos, @Negara, 

		@Telpon, @Fax, @Email, @NPWP, @Tanggal, @Plafon, @Hari, @Berikat, @Jenis,

         		@NamaPKP, @AlamatPkp1, @Alamatpkp2, @KotaPkp, @Sales,@kodevls,@Perkiraan, @KodeTipe, 0,@Kind,@HariHutPiut,

         		@IsAktif, @HargaKe)


if @Mode='U'

Update dbCustSupp set KodeCustSupp=@KodeCustSupp, NamaCustSupp=@NamaCustSupp, Usaha=@Usaha,

                        Alamat1=@Alamat1, Alamat2=@Alamat2, Kota=@KodeKota, KodePos=@KodePos, Telpon=@Telpon, Fax=@Fax,

                        Email=@Email, NPWP=@NPWP, Tanggal=@Tanggal, Plafon=@Plafon, Hari=@Hari,Kind=@Kind,HariHutPiut=@HariHutPiut,

                        Berikat=@Berikat, Jenis=@Jenis, Sales=@Sales,Negara=@Negara,

                        NamaPkp=@NamaPKP, AlamatPkp1=@AlamatPkp1, AlamatPkp2=@Alamatpkp2, KotaPkp=@KotaPkp,kodevls=@kodevls,

                        Perkiraan=@Perkiraan, KodeTipe=@KodeTipe,isPpn=0, IsAktif=@IsAktif, HargaKe=@HargaKe

  	where KodeCustSupp=@OldKode and Kind=@Kind



if @Mode='D'

Delete dbCustSupp 

    	where KodeCustSupp=@OldKode and Kind=@Kind



if @@error <> 0 goto JikaSalah

commit tran

return

JikaSalah:  rollback tran

            return;

-- Sp_Dealer
CREATE PROCEDURE IF NOT EXISTS Sp_Dealer AS tran

if @choice='I'

insert into DBDealer (Kodedealer, NamaDealer)

	values (@Kodedealer, @NamaDealer)

	if @@error <> 0 goto jikasalah



if @choice='U'

update DbDealer set NamaDealer=@NamaDealer

             where Kodedealer=@Kodedealer

	if @@error <> 0 goto jikasalah



if @choice='D'

delete  Dbdealer where Kodedealer=@Kodedealer

	if @@error <> 0 goto jikasalah



commit tran

return

jikasalah:

	rollback tran

	raiserror('Proses Input Data Gagal',16,1)

	return;

-- Sp_DebetNote
CREATE PROCEDURE IF NOT EXISTS Sp_DebetNote AS tran

if @Choice='I'

select @Urut=COALESCE(max(urut),0)+1 from dbDebetNoteDet Where NoBukti=@NoBukti

  if not exists(select 'True' from dbDebetNote Where NoBukti=@NoBukti) 

  insert into dbDebetNote (NOBUKTI, TANGGAL, KodeSupp, Nourut)

    values (@NOBUKTI, @TANGGAL, @KodeSupp, @NoURut)

  

  insert into dbDebetNoteDET (NOBUKTI, URUT,Keterangan,NoInv,Nilai,KodeVLS, Kurs, NilaiRp)

  values(@NOBUKTI, @URUT,@Keterangan,@NoInv,@Nilai, @KodeVls, @Kurs, @NilaiRp)



if @Choice='U'

update dbDebetNoteDET set NoInv=@NoInv,Keterangan=@Keterangan,Nilai=@Nilai, KodeVLS=@KodeVls, Kurs=@Kurs, NilaiRp=@NilaiRp

  where NoBukti=@NoBukti and Urut=@Urut


if @Choice='D'

delete dbDebetNoteDET where NoBukti=@NoBukti and Urut=@Urut 

  if not exists( select NoBukti from dbDebetNoteDET where NoBukti=@NoBukti)

  delete dbDebetNote where NoBukti=@NoBukti


--if @@error<>0  goto jikasalah

Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- Sp_DEPART
CREATE PROCEDURE IF NOT EXISTS Sp_DEPART AS tran

if @choice='I'

insert into dbDepart (KdDep, NmDep,PerkBiaya,isSetPass,Tf,Do)

	values (@KDDEP, @NMDEP,@PerkBiaya,@IsSetPass,0,@choice)

	if @@error <> 0 goto jikasalah



if @choice='U'

update dbDepart set NmDep=@NmDep ,KdDep=@KDDEP,PerkBiaya=@PerkBiaya,isSetPass=@IsSetPass ,Tf=0,Do=@Choice

             where KdDep=@OldKode

	if @@error <> 0 goto jikasalah



if @choice='D'

delete  dbDepart where KdDep=@OldKode

	if @@error <> 0 goto jikasalah



commit tran

return

jikasalah:

	rollback tran

	raiserror('Proses Input Data Gagal',16,1)

	return;

-- SP_DEPOSITO
CREATE PROCEDURE IF NOT EXISTS SP_DEPOSITO AS tran

-- DECLARE REMOVED, @kredit Numeric(18,2),

        @DebetRp numeric(18,2), @kreditRp Numeric(18,2)

-- SET REMOVED@Jumlah

-- SET REMOVED0

-- SET REMOVED@Jumlah*@Kurs

-- SET REMOVED0

if @choice='I'

insert into DBDEPOSITO (Bank, NoDEPOSITO, Tanggal, TglJatuhTempo, Debet, Kredit, DebetRp, KreditRp, Keterangan, TglBuka, BuktiBuka, KodeVls, Kurs, KeteranganCair, TglCair, BuktiCair,Tipe)

  values (@Bank, @NoDEPOSITO, @Tanggal, @TgljatuhTempo, @Debet, @Kredit, @DebetRp, @kreditRp, @Keteranganbuka, @TglBuka, @BuktiBuka, @KodeVls, @Kurs, @KeteranganCair, @TglCair, @BuktiCair,@Tipe)

  if @@error <> 0 goto jikasalah



if @choice='U'

update DBDEPOSITO set Tanggal=@TglJatuhTempo, Debet=@Debet, Kredit=@Kredit, Keterangan=@Keteranganbuka, 

                        TglBuka=@TglBuka, BuktiBuka=@BuktiBuka, KodeVls=@KodeVls, Kurs=@Kurs, 

                        KeteranganCair=@KeteranganCair, TglCair=@TglCair, BuktiCair=@BuktiCair

             where NoDEPOSITO=@NoDEPOSITO and bank=@bank

  if @@error <> 0 goto jikasalah



if @choice='D'

-- IF EXISTS REMOVED
delete DBDEPOSITO 

  where NoDEPOSITO=@NoDEPOSITO and bank=@bank and Tipe=@Tipe

  -- if @@error <> 0 goto jikasalah


commit tran

return

jikasalah:

 rollback tran

 raiserror('Proses Input Data Gagal',16,1)

 return;

-- SP_DEVISI
CREATE PROCEDURE IF NOT EXISTS SP_DEVISI AS tran

if @choice='I'

insert into dbDevisi (Devisi, NamaDevisi)

 values (@Devisi, @NamaDevisi)

 if @@error <> 0 goto jikasalah



if @choice='U'

update dbDevisi set NamaDevisi=@NamaDevisi

             where Devisi=@OldDevisi

 if @@error <> 0 goto jikasalah



if @choice='D'

delete  dbDevisi where Devisi=@OldDevisi

 if @@error <> 0 goto jikasalah



commit tran

return

jikasalah:

 rollback tran

 raiserror('Proses Input Data Gagal',16,1)

 return;

-- Sp_DP
CREATE PROCEDURE IF NOT EXISTS Sp_DP AS tran

if @choice='I'

insert into DBDP (Devisi,Tanggal,KodeCustSupp, KodeProject,NilaiDP,Keterangan,NoKwitansi,ISPPN,KodeBank,IsTTD,NPPN)

	values (@Devisi,@Tanggal,@KodeCustSupp, @KodeProject,@NilaiDP,@Keterangan,@NoKwitansi,@IsPPN,@KodeBank,@IsTTD,@NPPN)

	--------------

    /*Insert into DBO.dbJurnalOTO(NoBukti, Tanggal, Devisi, Note, Lampiran, IsOtorisasi1, OtoUser1, TglOto1, IsOtorisasi2, OtoUser2, TglOto2, IsOtorisasi3, OtoUser3, TglOto3, IsOtorisasi4, OtoUser4, 

                                TglOto4, IsOtorisasi5, OtoUser5, TglOto5, Urut, Perkiraan, Lawan, Keterangan, Keterangan2, Debet, Kredit, Valas, Kurs, DebetRp, KreditRp, TipeTrans, TPHC, 

                                CustSuppP, CustSuppL, KodeP, KodeL, NoAktivaP, NoAktivaL, StatusAktivaP, StatusAktivaL, Nobon, KodeBag, StatusGiro,  Jenis, NOURUT)

    Select  @NoKwitansi, @Tanggal, '01', '', '', 1, '', datetime('now'), 0, '', NULL, 0, '', Null, 

            '', '', Null, 0, '', Null,1 URUT, PERKIRAAN, '21020001'LAWAN, 'Bayar DP  No.'+@NoKwitansi KETERANGAN, '' KETERANGAN2, 0 DEBET, 0 KREDIT, 'IDR', 

            1 KURS, @NilaiDP DEBETRP, 0 KREDITRP, 'DP'TIPETRANS, 'C'TPHC, ''CUSTSUPPP, ''CUSTSUPPL, ''KODEP, ''KODEL, ''NOAKTIVAP, ''NOAKTIVAL, '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, 

            ''KODEBAG, ''STATUSGIRO, 'DP' JENIS, '0001'NOURUT

    From Dbo.DBPERKIRAAN where Keterangan Like '%'+@KodeBank+'%'*/

    

	--------------

	if @@error <> 0 goto jikasalah



if @choice='U'

update DBDP set IsPPN=@IsPPN,Tanggal=@Tanggal,KodeCustSupp=@KodeCustSupp,NilaiDP=@NilaiDP,Keterangan=@Keterangan,KodeProject=@KodeProject,IsTTD=@IsTTD,KodeBank=@KodeBank,NPPN=@NPPN

             where NoKwitansi=@OldKode

	if @@error <> 0 goto jikasalah



if @choice='D'

delete  DBDP where NoKwitansi=@OldKode

	if @@error <> 0 goto jikasalah



commit tran

return

jikasalah:

	rollback tran

	raiserror('Proses Input Data Gagal',16,1)

	return;

-- sp_dropdiagram
CREATE PROCEDURE IF NOT EXISTS sp_dropdiagram AS 'dbo'

	AS

	set nocount on

		-- DECLARE REMOVED

		-- DECLARE REMOVED

		

		-- DECLARE REMOVED

		-- DECLARE REMOVED

	

		if(@diagramname is null)

		RAISERROR ('Invalid value', 16, 1);

			return -1


		EXECUTE AS CALLER;

		select @theId = DATABASE_PRINCIPAL_ID();

		select @IsDbo = IS_MEMBER(N'db_owner'); 

		if(@owner_id is null)

			select @owner_id = @theId;

		REVERT; 

		

		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 

		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))

		RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)

			return -3


		delete from dbo.sysdiagrams where diagram_id = @DiagId;

	

		return 0;

-- Sp_Expedisi
CREATE PROCEDURE IF NOT EXISTS Sp_Expedisi AS tran



if @Mode='I'

insert into dbExpedisi(KodeExp, NamaExp, Alamat1, Alamat2, Kota, KodePos, Telpon, HP, Fax, Email, 

		Contact, Perkiraan, Aktif)

    values(@KodeExp, @NamaExp, @Alamat1, @Alamat2, @Kota, @KodePos, @Telpon, @HP, @Fax, @Email, 

		@Contact, @Perkiraan, @Aktif)

   if @@error <> 0

     goto Salah



if @Mode='U'

update dbExpedisi

     set   NamaExp=@NamaExp, Alamat1=@Alamat1, Alamat2=@Alamat2, Kota=@Kota, KodePos=@KodePos, Telpon=@Telpon,

	HP=@HP, Fax=@Fax, Email=@Email, Contact=@Contact, Aktif=@Aktif

     where KodeExp=@KodeExp



     if @@error <> 0 

      goto Salah 



if @Mode='D'

Delete dbExpedisi 

     where KodeExp=@KodeExp

     

    if @@error <> 0 

     goto Salah


commit tran

--insert into dblog(tipe,userid,tglupdate,keterangan)

--values('dbekspedisi ','-',datetime('now'),@kodeeksped)

return



Salah:

        rollback tran

        return;

-- sp_fakturpajak
CREATE PROCEDURE IF NOT EXISTS sp_fakturpajak AS Select NoKwitansi NoBukti,NoKwitansi NoPNJ,A.Keterangan KodeBrg,COALESCE(a.NoSeri,'')+'.'+COALESCE(A.NoPajak,'')NOFPJ,

       A.Tanggal TglFPJ,

       N.NoSeri MySeri, 1 Kurs, E.Usaha, '' KodeGrp,

	

       P.NAMAPKP NamaPKP, P.ALAMATPKP1+Char(13)+P.ALAMATPKP2+' '+Char(13)+P.KOTAPKP AlamatPKP,p.alamat2,

       P.NPWP NPWPPKP, P.TglPengukuhan TglPKP,

	   A.KodeCustSupp, E.NAMACUSTSUPP , E.ALAMATPKP1+Char(13)+E.ALAMATPKP2+' '+E.KOTAPKP AlamatCust,

	   E.NPWP NPWPCust,e.ALAMAT1 as alamatcustom,e.kota as kotacustom,

	   ''KodeBrg,A.Keterangan NamaBrg, 0 Jumlah, CAST(2 AS Numeric(18),0) as UangMuka,

       ''SAT_1,''SAT_2, NilaiDP NDpp, Case when COALESCE(NPPN,0)=0 Then NilaiDP*0.1  else NPPN  Nppn, NilaiDP+Case when COALESCE(NPPN,0)=0 Then NilaiDP*0.1  else NPPN  Nnet, 'IDR' Valas,

       0 Harga,

       P.Kota, P.Direksi, P.Jabatan, '' KetNota,

	A.NoKwitansi+' Tanggal: '+CAST(A.tanggal,105 AS TEXT) +' Customer: '+E.NAMACUSTSUPP+'  <No. Faktur Pajak : '+

	N.NoSeri+'.'+substring(A.NoKwitansi,1,5)+'>' as GroupNobukti2,e.namapkp as namacustpkp,e.alamatpkp1 as alamatcustpkp,e.alamatpkp2 as alamatcustpkp2,e.kotapkp as kotacustpkp

	,case  when e.NPWP='' then e.NAMACUSTSUPP else e.NAMAPKP  as namax,

        case when e.NPWP='' then e.ALAMAT1 else e.ALAMATPKP1  as alamat1x,

        case when e.NPWP='' then e.ALAMAT1 else e.ALAMATPKP2  as alamat2x,

        case when e.NPWP='' then ko.NamaKota else e.KOTAPKP  as kotapkpx,

        COALESCE(A.Total,0)  Jum,COALESCE(A.Total,0) HrgNetto,

     '' stn,

     0 qnt

       From dbDP A

       left outer join DBCUSTSUPP e on A.KodeCustSupp=e.KODECUSTSUPP 

       left outer join dbNomor n on 1=1

       left outer join dbPerusahaan p on 1=1

       left outer join dbkota ko on e.kota = ko.kodekota

where A.NoKwitansi=@NoBukti      

Union ALL

select 	D.NoBukti, D.NoBukti NoPNJ, C.KodeBrg, COALESCE(d.NoSeri,'')+'.'+COALESCE(d.NoPajak,'') NOFPJ,

	case when year(D.TglFPJ)=1899 then null else D.TglFPJ  TglFPJ

	, N.NoSeri MySeri, D.Kurs, E.Usaha, F.KodeGrp,

	

	P.NAMAPKP NamaPKP, P.ALAMATPKP1+Char(13)+P.ALAMATPKP2+' '+Char(13)+P.KOTAPKP AlamatPKP,p.alamat2,

	P.NPWP NPWPPKP, P.TglPengukuhan TglPKP,

	D.KodeCustSupp, E.NAMACUSTSUPP , E.ALAMATPKP1+Char(13)+E.ALAMATPKP2+' '+E.KOTAPKP AlamatCust,

	E.NPWP NPWPCust,e.ALAMAT1 as alamatcustom,e.kota as kotacustom,

	C.KodeBrg, F.NamaBrg, Sum(C.Qnt*C.Harga) Jumlah, DP as UangMuka,

       	C.SAT_1,C.SAT_2, Sum(C.NDpp)NDPP, Sum(C.Nppn)NPPN, Sum(C.Nnet)NNET, D.Valas,

       	case when C.Ppn in (0,1) then c.HrgNetto else c.HrgNetto/1.1  Harga,

       	P.Kota, P.Direksi, P.Jabatan, '' KetNota,

	D.Nobukti+' Tanggal: '+CAST(D.tanggal,105 AS TEXT) +' Customer: '+E.NAMACUSTSUPP+'  <No. Faktur Pajak : '+

	N.NoSeri+'.'+substring(D.NoBukti,1,5)+'>' as GroupNobukti2,e.namapkp as namacustpkp,e.alamatpkp1 as alamatcustpkp,e.alamatpkp2 as alamatcustpkp2,e.kotapkp as kotacustpkp

	,case  when e.NPWP='' then e.NAMACUSTSUPP else e.NAMAPKP  as namax,

        case when e.NPWP='' then e.ALAMAT1 else e.ALAMATPKP1  as alamat1x,

        case when e.NPWP='' then e.ALAMAT1 else e.ALAMATPKP2  as alamat2x,

        case when e.NPWP='' then ko.NamaKota else e.KOTAPKP  as kotapkpx,

        Sum(c.NDPP + c.NPPN) as Jum,c.HrgNetto,

     case when C.NOSAT=1 then f.SAT1 when C.NOSAT=2 then F.SAT2  stn,

     Sum(case when c.NOSAT=1 then c.QNT when c.NOSAT=2 then c.QNT2 ) qnt



from dbInvoicePLDet c 

left outer join DBINvoicePL d on c.NoBukti=d.NoBukti

left outer join DBCUSTSUPP e on D.KodeCustSupp=e.KODECUSTSUPP

left outer join dbBarang f on c.KodeBrg=f.KodeBrg

left outer join dbNomor n on 1=1

left outer join dbPerusahaan p on 1=1

left outer join dbkota ko on e.kota = ko.kodekota

where c.NoBukti=@NoBukti --and COALESCE(c.IsBonus,0)=0

Group By D.NoBukti,  C.KodeBrg, d.NoSeri,d.NoPajak,

	d.TglFPJ

	, N.NoSeri , D.Kurs, E.Usaha, F.KodeGrp,

	P.NAMAPKP , P.ALAMATPKP1,P.ALAMATPKP2,P.KOTAPKP,p.alamat2,

	P.NPWP , P.TglPengukuhan ,

	D.KodeCustSupp, E.NAMACUSTSUPP , E.ALAMATPKP1,E.ALAMATPKP2,E.KOTAPKP ,

	E.NPWP ,e.ALAMAT1 ,e.kota,C.KodeBrg, F.NamaBrg,C.SAT_1,C.SAT_2,C.PPN,c.HrgNetto,

	P.Kota, P.Direksi, P.Jabatan, 

	D.tanggal,E.NAMACUSTSUPP,

	N.NoSeri,e.namapkp ,e.alamatpkp1,e.alamatpkp2 ,e.kotapkp 

	, c.HrgNetto,d.Valas,NamaKota,

    C.NOSAT ,f.SAT1 ,F.SAT2,d.DP;

-- Sp_FLpass
CREATE PROCEDURE IF NOT EXISTS Sp_FLpass AS tran

if @choice='I'

Insert into dbFlpass(UserID,UID,Tingkat,status,Fullname,kodeBag,kodejab,Tf,Do)

      	values (@UserID,@UID,@Tingkat,@status,@Fullname,@kodebag,@kodejab,0,@choice)

 	if @@error <> 0 goto jikasalah



if @choice='U'

update dbFlpass set UID=@uid,Tingkat=@tingkat,status=@status,fullname=@Fullname,

      	                    kodeBag=@kodebag,kodejab=@kodejab,Tf=0,Do=@Choice

      	where userid=@userid

 	if @@error <> 0 goto jikasalah



if @choice='D'

delete dbFlpass 

      	where userid=@userid and UserID<>'SA'

      	insert TempDelData

      	select @UserID,'dbFlpass'



commit tran

return

jikasalah:

 rollback tran

 raiserror('Proses Input Data Gagal',16,1)

 return;

-- Sp_GenerateReportBukuTambahan
CREATE PROCEDURE IF NOT EXISTS Sp_GenerateReportBukuTambahan AS delete dbtempbkbesar

-- where devisi=@devisi

 -- DECLARE REMOVED,@tipe varchar(2)

 Declare CurNeraca Cursor for

  select Perkiraan from dbperkiraan where perkiraan>=@awal and perkiraan<=@akhir and tipe=1

  order by perkiraan    

 Open CurNeraca

    Fetch Next from CurNeraca into @perkiraan

 While @@fetch_Status=0

 exec sp_GenerateSaldobukutambahan @bulan,@tahun,@perkiraan,@Jurnal,@devisi

  exec Sp_GenerateTransBukuTambahan @tglawal,@perkiraan,@jurnal,@devisi,@tglakhir

  Fetch Next from CurNeraca into @perkiraan

 

     Close CurNeraca

     Deallocate CurNeraca;

-- Sp_GenerateSaldoBukuTambahan
CREATE PROCEDURE IF NOT EXISTS Sp_GenerateSaldoBukuTambahan AS -- DECLARE REMOVED,@tahun int, @mtgl varchar(20), @mtgl1 datetime

select @mtgl=cast(@bln as varchar(2))+'/01/'+cast(@thn as varchar(4))

select @mtgl1=cast(@mtgl as datetime)-1

select @mtgl=cast(month(@mtgl1) as varchar(2))+'/'+cast(datepart(dd,@mtgl1) as varchar(2))+'/'+cast(year(@mtgl1) as varchar(4))

select @bulan=@bln

select @tahun=@thn

-- SET REMOVEDCase when @devisi in ('-','') then '%' else @devisi 

  if @jurnal='T'

  insert into dbtempBkBesar(devisi,NoAcc,Tanggal,NoBukti,Keterangan,Perkiraan,Lawan,Debet,Kredit,saldoawal,saldo,bulan,tahun,DebetD,KreditD,SaldoAwalD) 

    select @devisi,A.Perkiraan, @mtgl as Tanggal,' Saldo Awal 'as no_bukti, '' as Ket,A.perkiraan as No, '' as lawan,

           0 as debet,0 as kredit,

           case when a.DK=0 then b.AwalDRp

                when A.DK=1 then b.AwalKRp

                else 0       

            as Saldo,0,@bln,@thn,0,0,

           case when a.DK=0 then b.AwalD

                when A.DK=1 then b.AwalK

                else 0       

            as SaldoD

    from dbPerkiraan A

         left outer join DBNERACA b on b.Perkiraan=A.Perkiraan

    where a.Perkiraan=@perkiraan and b.Bulan=@bulan and b.Tahun=@tahun and (b.Devisi like @devisi)

   

  else if @jurnal='Y'

  insert into dbtempBkBesar(devisi,NoAcc,Tanggal,NoBukti,Keterangan,Perkiraan,Lawan,Debet,Kredit,saldoawal,saldo,bulan,tahun,DebetD,KreditD,SaldoAwalD) 

    select @devisi,A.Perkiraan, @mtgl as Tanggal,' Saldo Awal 'as no_bukti, '' as Ket,A.perkiraan as No, '' as lawan,

           0 as debet,0 as kredit,

           case when a.DK=0 then b.AwalDRp

                when A.DK=1 then b.AwalKRp

                else 0       

            as Saldo,0,@bln,@thn,0,0,

           case when a.DK=0 then b.AwalD

                when A.DK=1 then b.AwalK

                else 0       

            as SaldoD

    from dbPerkiraan A

         left outer join DBNERACA b on b.Perkiraan=A.Perkiraan

    where a.Perkiraan=@perkiraan and b.Bulan=@bulan and b.Tahun=@tahun and (b.Devisi like @devisi);

-- Sp_GenerateTransBukuTambahan
CREATE PROCEDURE IF NOT EXISTS Sp_GenerateTransBukuTambahan AS -- DECLARE REMOVED, @Perkiraan varchar(20), @Lawan varchar(20), @Keterangan varchar(500), @tanggal datetime,

 @debet numeric(18,2), @kredit numeric(18,2), @transaksi varchar(2), @Bulan int, @tahun int, @tipe varchar(2), @urut int,@tgl datetime,

 @debetd numeric(18,2), @kreditd numeric(18,2),@valas varchar(3),@Kurs numeric(18,2)

select @bulan=month(@tglawal)

select @tahun=year(@tglawal)

select @tgl=(select cast((cast(@bulan as varchar(2))+'/'+'01'+'/'+cast(@tahun as varchar(4))) as datetime))

-- SET REMOVEDcase when @devisi in ('-','') then '%' else @Devisi 



  select @urut=1



  Declare CurTrans Cursor for

  select a.perkiraan,case when b.dk=0 then 'D' else 'K'  As Transaksi ,a.tanggal,a.nobukti,a.keterangan,a.lawan,

		Case when a.Perkiraan=@NoAccount then a.DebetRp else 0  DebetRp, 

		Case when a.Lawan=@NoAccount then a.DebetRp else 0  KreditRp, 

		case when a.Valas='IDR' then 0 else Case when a.Perkiraan=@NoAccount then a.Debet else 0   Debet, 

		case when a.Valas='IDR' then 0 else Case when a.Lawan=@NoAccount then a.Debet else 0   Kredit,

		a.valas,a.kurs

  from dbtransaksi a,dbperkiraan b

  where a.perkiraan=b.perkiraan and (a.perkiraan=@NoAccount or a.lawan=@noAccount) and 

        a.Tanggal>=@tgl and a.Tanggal<=@tglakhir and (a.devisi like @devisi)

        and ((a.NoBukti not like '%BJP%' and @Jurnal='T') or (a.NoBukti like '%' and @Jurnal='Y'))

  order by a.tanggal,a.nobukti



    Open CurTrans

    Fetch Next from CurTrans into @perkiraan,@transaksi,@tanggal,@nobukti,@keterangan,@lawan,@debet,@kredit,@debetd,@kreditd,@valas,@kurs

 While @@fetch_Status=0

 select @Tipe=case when dk=0 then 'D' else 'K'  from dbPerkiraan where perkiraan=@NoAccount

  --if @perkiraan=@NoAccount

  --insert into dbtempBkBesar(devisi,NoAcc,Transaksi,Tanggal,NoBukti,Keterangan,Perkiraan,Lawan,

    Debet,Kredit,saldo,saldoawal,bulan,tahun,urut,debetd,kreditd,valas,kurs)

    values(@devisi,@NoAccount,@tipe,@tanggal,@nobukti,@keterangan,@perkiraan,@lawan,

    @debet,@kredit,0,0,@bulan,@tahun,@urut,@debetd,@kreditd, @valas,@kurs)

  --

  /*if @Lawan=@NoAccount

  insert into dbtempBkBesar(devisi,NoAcc,Transaksi,Tanggal,NoBukti,Keterangan,Perkiraan,Lawan,

     Debet,Kredit,saldo,saldoawal,bulan,tahun,urut,debetd,kreditd,valas,kurs)

     values(@devisi,@NoAccount,@tipe,@tanggal,@nobukti,@keterangan,@Lawan,@perkiraan,

     @kredit,@debet,0,0,@bulan,@tahun,@urut,@kreditd,@debetd,@valas,@kurs)

  */

  

  select @urut=@urut+1

  Fetch Next from CurTrans into @perkiraan,@transaksi,@tanggal,@nobukti,@keterangan,@lawan,@debet,@kredit,@debetd,@kreditd,@valas,@kurs

 

     Close CurTrans

     Deallocate CurTrans;

-- Sp_GetLabaBlnin
CREATE PROCEDURE IF NOT EXISTS Sp_GetLabaBlnin AS -- SET REMOVEDCase when @devisi='-' then '' else @devisi 

-- DECLARE REMOVED,@nomor varchar(10),@perkiraan varchar(20),@keterangan varchar(50),@grup varchar(10),

@tipe varchar(1),@tanda varchar(1),@jumlah varchar(1),@totalA numeric(18,2),@totalb numeric(18,2),@totalc numeric(18,2),

@tampil varchar(1),@persen varchar(1),@mtahun int

-- DECLARE REMOVED,@S2 numeric(18,2),@S3 numeric(18,2)

-- DECLARE REMOVED,@G2 numeric(18,2),@G3 numeric(18,2)

-- DECLARE REMOVED,@T2 numeric(18,2),@T3 numeric(18,2)

-- DECLARE REMOVED,@n2 numeric(18,2),@n3 numeric(18,2)

select @S1=0

select @S2=0

select @S3=0

select @G1=0

select @G2=0

select @G3=0

select @T1=0

select @T2=0

select @T3=0

select @n1=0

select @n2=0

select @n3=0

declare CurrLR cursor for

 select Devisi,Nomor,Perkiraan,Keterangan, Tipe, Tanda, Jumlah, Persen, TotalA,TotalB,TotalC,Tahun,Tampil 

 from DBLRHPP where Bulan=@Bulan and tahun=@tahun and devisi=@devisi and Perkiraan<>'' and isLRHpp=@prosesRlHPP

 order by devisi,nomor

open CurrLR

Fetch Next from CurrLR into @mDevisi,@Nomor,@Perkiraan,@Keterangan, @Tipe, @Tanda, @Jumlah, @Persen, @TotalA,@TotalB,@TotalC,@mTahun,@Tampil

While @@fetch_Status=0

if @tanda='+' select @n1=COALESCE(@totalA,0) else select @n1=-1*COALESCE(@totalA,0) 

  if @tanda='+' select @n2=COALESCE(@totalb,0) else select @n2=-1*COALESCE(@totalb,0) 

  if @tanda='+' select @n3=COALESCE(@totalc,0) else select @n3=-1*COALESCE(@totalc,0) 

  

  if @jumlah=''   

  select @s1=@s1+@n1

   select @s2=@s2+@n2

   select @s3=@s3+@n3

   select @g1=@g1+@n1

   select @g2=@g2+@n2

   select @g3=@g3+@n3

   select @t1=@t1+@n1

   select @t2=@t2+@n2

   select @t3=@t3+@n3

  

  else if @Jumlah='S'

  select @s1=0

   select @s2=0

   select @s3=0

   else if @jumlah='G'

  select @s1=0

   select @s2=0

   select @s3=0  

   select @g1=0

   select @g2=0

   select @g3=0  

   else if @jumlah='T'

  select @s1=0

   select @s2=0

   select @s3=0  

   select @g1=0

   select @g2=0

   select @g3=0  

  

  Fetch Next from CurrLR into @mDevisi,@Nomor,@Perkiraan,@Keterangan, @Tipe, @Tanda, @Jumlah, @Persen, @TotalA,@TotalB,@TotalC,@mTahun,@Tampil



Close CurrLR

Deallocate CurrLR



select @s2 as nilai;

-- SP_Giro
CREATE PROCEDURE IF NOT EXISTS SP_Giro AS tran

-- DECLARE REMOVED, @kredit Numeric(18,2),

        @DebetRp numeric(18,2), @kreditRp Numeric(18,2)

-- SET REMOVEDCase when @tipe='PT' then Case when @KodeVls='IDR' then 0 else @Jumlah  else 0 

-- SET REMOVEDCase when @tipe='HT' then Case when @KodeVls='IDR' then 0 else @Jumlah  else 0 

-- SET REMOVEDCase when @tipe='PT' then @Jumlah*@Kurs else 0 

-- SET REMOVEDCase when @tipe='HT' then @Jumlah*@Kurs else 0 

if @choice='I'

insert into DBGIRO (Bank, NoGiro, TglGiro, Debet, Kredit, DebetRp, KreditRp, Keterangan, TglBuka, BuktiBuka, KodeVls, Kurs, KeteranganCair, TglCair, BuktiCair,Tipe,kas)

  values (@Bank, @NoGiro, @TglGiro, @Debet, @Kredit, @DebetRp, @kreditRp, @Keteranganbuka, @TglBuka, @BuktiBuka, @KodeVls, @Kurs, @KeteranganCair, @TglCair, @BuktiCair,@Tipe,@Kas)

  if @@error <> 0 goto jikasalah



if @choice='U'

update DBGIRO set TglGiro=@TglGiro, Debet=@Debet, Kredit=@Kredit, Keterangan=@Keteranganbuka, TglBuka=@TglBuka, 

                                      BuktiBuka=@BuktiBuka, KodeVls=@KodeVls, Kurs=@Kurs, 

                    KeteranganCair=@KeteranganCair, TglCair=@TglCair,BuktiCair=@BuktiCair,Kas=@kas

             where NoGiro=@NoGiro and bank=@bank

  if @@error <> 0 goto jikasalah



if @choice='D'

-- IF EXISTS REMOVED
delete DBGIRO 

  where NoGiro=@NoGiro and bank=@bank and Tipe=@Tipe

  -- if @@error <> 0 goto jikasalah


commit tran

return

jikasalah:

 rollback tran

 raiserror('Proses Input Data Gagal',16,1)

 return;

-- Sp_Group
CREATE PROCEDURE IF NOT EXISTS Sp_Group AS tran

if @choice='I'

insert into dbGroup (KodeGrp, Nama)

  values (@KodeGrp, @NamaGrp)

  if @@error <> 0 goto jikasalah



else

if @choice='U'

update dbGroup set Nama=@NamaGrp 

             where KodeGrp=@KodeGrp

	if @@error <> 0 goto jikasalah



else

if @choice='D'

delete  dbGroup where KodeGrp=@KodeGrp

	if @@error <> 0 goto jikasalah



commit tran

return

jikasalah:

	rollback tran

	raiserror('Proses Input Data Gagal',16,1)

	return;

-- Sp_Gudang
CREATE PROCEDURE IF NOT EXISTS Sp_Gudang AS tran

if @choice='I'

insert into dbGudang (KodeGdg, Nama, IsProduksi,Alamat,IsTransfer,CONNSTR,IsRusak,Tf,Do)

  values (@KodeGdg, @NamaGdg, @IsProduksi,@Alamat,@IsTransfer,@ConnStr,@IsRusak,0,@choice)

  if @@error <> 0 goto jikasalah



else

if @choice='U'

update dbGudang 

    set kodeGdg=@kodeGdg, Nama=@NamaGdg, IsProduksi=@IsProduksi,Alamat=@Alamat,IsTransfer=@IsTransfer,CONNSTR=@ConnStr,IsRusak=@IsRusak

    ,Tf=0,Do=@Choice

    where KodeGdg=@OldKode

    if @@error <> 0

     goto jikasalah



if @choice='D'

delete dbGudang 

   where KodeGdg=@OldKode

   insert TempDelData

   select @OldKode,'dbGudang'

   

   if @@error <> 0 goto jikasalah



commit tran

return

jikasalah:

	rollback tran

	raiserror('Proses Input Data Gagal',16,1)

	return;

-- Sp_HasilPrd
CREATE PROCEDURE IF NOT EXISTS Sp_HasilPrd AS tran

if @Choice='I'

select @Urut=COALESCE(max(urut),0)+1 from dbHasilPrddet Where NoBukti=@NoBukti

  if not exists(select * from dbHasilPrd Where NoBukti=@NoBukti) 

  insert into dbHasilPrd (Devisi,NOBUKTI, NOURUT, TANGGAL, KETERANGAN,KdDep)

    values (@Devisi,@NOBUKTI, @NOURUT, @TANGGAL, @KETERANGAN,@KdDep)

  

  insert into dbHasilPrdDET (NOBUKTI, URUT,  KODEBRG, Qnt, NOSAT, ISI, SATUAN,KodeGdg,NoSPK)

  values(@NOBUKTI, @URUT, @KODEBRG, @Qnt, @NoSat, @Isi, @Satuan, @KodeGdg,@NoSPK)



if @Choice='U'

update dbHasilPrdDET set KodeBrg=@KODEBRG, Qnt=@QNT, NOSAT=@NoSat, ISI=@ISI, SATUAN=@Satuan,KodeGdg=@KodeGdg

  where NoBukti=@NoBukti and Urut=@Urut



if @Choice='D'

delete dbHasilPrdDET where NoBukti=@NoBukti and Urut=@Urut 

  if not exists( select NoBukti from dbHasilPrdDET where NoBukti=@NoBukti)

  delete dbHasilPrd where NoBukti=@NoBukti


if @@error<>0  goto jikasalah

Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- sp_helpdiagramdefinition
CREATE PROCEDURE IF NOT EXISTS sp_helpdiagramdefinition AS N'dbo'

	AS

	set nocount on



		-- DECLARE REMOVED

		-- DECLARE REMOVED

		-- DECLARE REMOVED

		-- DECLARE REMOVED

	

		if(@diagramname is null)

		RAISERROR (N'E_INVALIDARG', 16, 1);

			return -1


		execute as caller;

		select @theId = DATABASE_PRINCIPAL_ID();

		select @IsDbo = IS_MEMBER(N'db_owner');

		if(@owner_id is null)

			select @owner_id = @theId;

		revert; 

	

		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname;

		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId ))

		RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);

			return -3


		select version, definition FROM dbo.sysdiagrams where diagram_id = @DiagId ; 

		return 0;

-- sp_helpdiagrams
CREATE PROCEDURE IF NOT EXISTS sp_helpdiagrams AS N'dbo'

	AS

	-- DECLARE REMOVED

		-- DECLARE REMOVED

		EXECUTE AS CALLER;

			-- SET REMOVED USER_NAME();

			-- SET REMOVED CAST(IS_MEMBER('db_owner' AS INTEGER));

		REVERT;

		SELECT

			[Database] = DB_NAME(),

			[Name] = name,

			[ID] = diagram_id,

			[Owner] = USER_NAME(principal_id),

			[OwnerID] = principal_id

		FROM

			sysdiagrams

		WHERE

			(@dboLogin = 1 OR USER_NAME(principal_id) = @user) AND

			(@diagramname IS NULL OR name = @diagramname) AND

			(@owner_id IS NULL OR principal_id = @owner_id)

		ORDER BY

			4, 5, 1;

-- sp_HitungNilaiRl
CREATE PROCEDURE IF NOT EXISTS sp_HitungNilaiRl AS if (@tipe='A')           -- //Saldo Awal

select @hasil1Rp=Sum(Case when P.DK=0 then ((COALESCE(N.AwalDRp,0)-COALESCE(N.AwalKRp,0))) 

                           when P.DK=1 then ((COALESCE(N.AwalKRp,0)-COALESCE(N.AwalDRp,0)))

                           else 0

                      ),

        @hasil1=Sum(Case when P.DK=0 then ((COALESCE(N.AwalD,0)-COALESCE(N.AwalK,0))) 

                         when P.DK=1 then ((COALESCE(N.AwalK,0)-COALESCE(N.AwalD,0)))

                         else 0

                    ) 

 from dbPerkiraan P

      left outer join dbNeraca N on N.Perkiraan=p.Perkiraan

 where p.Perkiraan=@perkiraan and N.bulan=(@bulan-1) and N.tahun=@tahun and N.devisi like @devisi+'%'

 

 select @hasil2Rp=Sum(Case when P.DK=0 then ((COALESCE(N.AwalDRp,0)-COALESCE(N.AwalKRp,0))) 

                           when P.DK=1 then ((COALESCE(N.AwalKRp,0)-COALESCE(N.AwalDRp,0)))

                           else 0

                      ),

        @hasil2=Sum(Case when P.DK=0 then ((COALESCE(N.AwalD,0)-COALESCE(N.AwalK,0))) 

                         when P.DK=1 then ((COALESCE(N.AwalK,0)-COALESCE(N.AwalD,0)))

                         else 0

                    ) 

 from dbPerkiraan P

      left outer join dbNeraca N on N.Perkiraan=p.Perkiraan

 where p.Perkiraan=@perkiraan and N.bulan=(@bulan) and N.tahun=@tahun and N.devisi like @devisi+'%'

 

 select @hasil3Rp=Sum(Case when P.DK=0 then ((COALESCE(N.AwalDRp,0)-COALESCE(N.AwalKRp,0))) 

                           when P.DK=1 then ((COALESCE(N.AwalKRp,0)-COALESCE(N.AwalDRp,0)))

                           else 0

                      ),

        @hasil3=Sum(Case when P.DK=0 then ((COALESCE(N.AwalD,0)-COALESCE(N.AwalK,0))) 

                         when P.DK=1 then ((COALESCE(N.AwalK,0)-COALESCE(N.AwalD,0)))

                         else 0

                    ) 

 from dbPerkiraan P

      left outer join dbNeraca N on N.Perkiraan=p.Perkiraan

 where p.Perkiraan=@perkiraan and N.bulan=@bulan and N.tahun=@tahun and N.devisi like @devisi+'%'

 select @jurnal=0,@jurnalRp=0



if (@tipe='Z')           -- //Persediaan Akhir

select @hasil1Rp=Sum(Case when P.DK=0 then ((COALESCE(N.AwalDRp,0)-COALESCE(N.AwalKRp,0))+(COALESCE(N.MDRp,0)-COALESCE(N.MKRp,0))+(COALESCE(N.JPDRp,0)-COALESCE(N.JPKRp,0))+(COALESCE(N.RLDRp,0)-COALESCE(N.RLKRp,0))) 

                           when P.DK=1 then ((COALESCE(N.AwalKRp,0)-COALESCE(N.AwalDRp,0))+(COALESCE(N.MKRp,0)-COALESCE(N.MDRp,0))+(COALESCE(N.JPKRp,0)-COALESCE(N.JPDRp,0))+(COALESCE(N.RLKRp,0)-COALESCE(N.RLDRp,0)))

                           else 0

                      ),

        @hasil1=Sum(Case when P.DK=0 then ((COALESCE(N.AwalD,0)-COALESCE(N.AwalK,0))+(COALESCE(N.MD,0)-COALESCE(N.MK,0))+(COALESCE(N.JPD,0)-COALESCE(N.JPK,0))+(COALESCE(N.RLD,0)-COALESCE(N.RLK,0))) 

                         when P.DK=1 then ((COALESCE(N.AwalK,0)-COALESCE(N.AwalD,0))+(COALESCE(N.MK,0)-COALESCE(N.MD,0))+(COALESCE(N.JPK,0)-COALESCE(N.JPD,0))+(COALESCE(N.RLK,0)-COALESCE(N.RLD,0)))

                         else 0

                    ) 

 from dbPerkiraan P

      left outer join dbNeraca N on N.Perkiraan=p.Perkiraan

 where p.Perkiraan=@perkiraan and N.bulan=(@bulan-1) and N.tahun=@tahun and N.devisi like @devisi+'%'

 

 select @hasil2Rp=Sum(Case when P.DK=0 then ((COALESCE(N.AwalDRp,0)-COALESCE(N.AwalKRp,0))+(COALESCE(N.MDRp,0)-COALESCE(N.MKRp,0))+(COALESCE(N.JPDRp,0)-COALESCE(N.JPKRp,0))+(COALESCE(N.RLDRp,0)-COALESCE(N.RLKRp,0))) 

                           when P.DK=1 then ((COALESCE(N.AwalKRp,0)-COALESCE(N.AwalDRp,0))+(COALESCE(N.MKRp,0)-COALESCE(N.MDRp,0))+(COALESCE(N.JPKRp,0)-COALESCE(N.JPDRp,0))+(COALESCE(N.RLKRp,0)-COALESCE(N.RLDRp,0)))

                           else 0

                      ),

        @hasil2=Sum(Case when P.DK=0 then ((COALESCE(N.AwalD,0)-COALESCE(N.AwalK,0))+(COALESCE(N.MD,0)-COALESCE(N.MK,0))+(COALESCE(N.JPD,0)-COALESCE(N.JPK,0))+(COALESCE(N.RLD,0)-COALESCE(N.RLK,0))) 

                         when P.DK=1 then ((COALESCE(N.AwalK,0)-COALESCE(N.AwalD,0))+(COALESCE(N.MK,0)-COALESCE(N.MD,0))+(COALESCE(N.JPK,0)-COALESCE(N.JPD,0))+(COALESCE(N.RLK,0)-COALESCE(N.RLD,0)))

                         else 0

                    ) 

 from dbPerkiraan P

      left outer join dbNeraca N on N.Perkiraan=p.Perkiraan

 where p.Perkiraan=@perkiraan and N.bulan=(@bulan) and N.tahun=@tahun and N.devisi like @devisi+'%'

 

 select @hasil3Rp=Sum(Case when P.DK=0 then ((COALESCE(N.AwalDRp,0)-COALESCE(N.AwalKRp,0))+(COALESCE(N.MDRp,0)-COALESCE(N.MKRp,0))+(COALESCE(N.JPDRp,0)-COALESCE(N.JPKRp,0))+(COALESCE(N.RLDRp,0)-COALESCE(N.RLKRp,0))) 

                           when P.DK=1 then ((COALESCE(N.AwalKRp,0)-COALESCE(N.AwalDRp,0))+(COALESCE(N.MKRp,0)-COALESCE(N.MDRp,0))+(COALESCE(N.JPKRp,0)-COALESCE(N.JPDRp,0))+(COALESCE(N.RLKRp,0)-COALESCE(N.RLDRp,0)))

                           else 0

                      ),

        @hasil3=Sum(Case when P.DK=0 then ((COALESCE(N.AwalD,0)-COALESCE(N.AwalK,0))+(COALESCE(N.MD,0)-COALESCE(N.MK,0))+(COALESCE(N.JPD,0)-COALESCE(N.JPK,0))+(COALESCE(N.RLD,0)-COALESCE(N.RLK,0))) 

                         when P.DK=1 then ((COALESCE(N.AwalK,0)-COALESCE(N.AwalD,0))+(COALESCE(N.MK,0)-COALESCE(N.MD,0))+(COALESCE(N.JPK,0)-COALESCE(N.JPD,0))+(COALESCE(N.RLK,0)-COALESCE(N.RLD,0)))

                         else 0

                    ) 

 from dbPerkiraan P

      left outer join dbNeraca N on N.Perkiraan=p.Perkiraan

 where p.Perkiraan=@perkiraan and N.bulan=(@bulan) and N.tahun=@tahun and N.devisi like @devisi+'%'

 select @jurnal=0,@jurnalRp=0 



if (@tipe='T')           -- //RLD

select @hasil1Rp=SUM(COALESCE(N.RLDRp,0)),

        @hasil1=SUM(COALESCE(N.RLD,0))

 from dbPerkiraan P

      left outer join dbNeraca N on N.Perkiraan=p.Perkiraan

 where p.Perkiraan=@perkiraan and N.bulan=(@bulan-1) and N.tahun=@tahun and N.devisi like @devisi+'%'

 

 select @hasil2Rp=SUM(COALESCE(N.RLDRp,0)),

        @hasil2=SUM(COALESCE(N.RLD,0))

 from dbPerkiraan P

      left outer join dbNeraca N on N.Perkiraan=p.Perkiraan

 where p.Perkiraan=@perkiraan and N.bulan=(@bulan) and N.tahun=@tahun and N.devisi like @devisi+'%'

 

 select @hasil3Rp=SUM(COALESCE(N.RLDRp,0)),

        @hasil3=SUM(COALESCE(N.RLD,0))

 from dbPerkiraan P

      left outer join dbNeraca N on N.Perkiraan=p.Perkiraan

 where p.Perkiraan=@perkiraan and N.bulan<=(@bulan) and N.tahun=@tahun and N.devisi like @devisi+'%'

 

 select @jurnalRp=Sum(Case when P.DK=0 then ((COALESCE(N.AwalDRp,0)-COALESCE(N.AwalKRp,0))+(COALESCE(N.MDRp,0)-COALESCE(N.MKRp,0))+(COALESCE(N.JPDRp,0)-COALESCE(N.JPKRp,0))+(COALESCE(N.RLDRp,0)-COALESCE(N.RLKRp,0))) 

                           when P.DK=1 then ((COALESCE(N.AwalKRp,0)-COALESCE(N.AwalDRp,0))+(COALESCE(N.MKRp,0)-COALESCE(N.MDRp,0))+(COALESCE(N.JPKRp,0)-COALESCE(N.JPDRp,0))+(COALESCE(N.RLKRp,0)-COALESCE(N.RLDRp,0)))

                           else 0

                      ),

        @jurnal=Sum(Case when P.DK=0 then ((COALESCE(N.AwalD,0)-COALESCE(N.AwalK,0))+(COALESCE(N.MD,0)-COALESCE(N.MK,0))+(COALESCE(N.JPD,0)-COALESCE(N.JPK,0))+(COALESCE(N.RLD,0)-COALESCE(N.RLK,0))) 

                         when P.DK=1 then ((COALESCE(N.AwalK,0)-COALESCE(N.AwalD,0))+(COALESCE(N.MK,0)-COALESCE(N.MD,0))+(COALESCE(N.JPK,0)-COALESCE(N.JPD,0))+(COALESCE(N.RLK,0)-COALESCE(N.RLD,0)))

                         else 0

                    ) 

 from dbPerkiraan P

      left outer join dbNeraca N on N.Perkiraan=p.Perkiraan

 where p.Perkiraan=@perkiraan and N.bulan=(@bulan) and N.tahun=@tahun and N.devisi like @devisi+'%' 



 -- DECLARE REMOVED

 select @xBulan=@bulan-1

 

 if @xBulan=0

 select @hasil1=0,@hasil1Rp=0

 

 else

 --print('Isi xBulan ')

  --Print(@xBulan)

  select @hasil1Rp=Sum(Case when P.DK=0 then ((COALESCE(N.AwalDRp,0)-COALESCE(N.AwalKRp,0))+(COALESCE(N.MDRp,0)-COALESCE(N.MKRp,0))+(COALESCE(N.JPDRp,0)-COALESCE(N.JPKRp,0))+(COALESCE(N.RLDRp,0)-COALESCE(N.RLKRp,0))) 

                            when P.DK=1 then ((COALESCE(N.AwalKRp,0)-COALESCE(N.AwalDRp,0))+(COALESCE(N.MKRp,0)-COALESCE(N.MDRp,0))+(COALESCE(N.JPKRp,0)-COALESCE(N.JPDRp,0))+(COALESCE(N.RLKRp,0)-COALESCE(N.RLDRp,0)))

                            else 0

                      ),

         @hasil1=Sum(Case when P.DK=0 then ((COALESCE(N.AwalD,0)-COALESCE(N.AwalK,0))+(COALESCE(N.MD,0)-COALESCE(N.MK,0))+(COALESCE(N.JPD,0)-COALESCE(N.JPK,0))+(COALESCE(N.RLD,0)-COALESCE(N.RLK,0))) 

                          when P.DK=1 then ((COALESCE(N.AwalK,0)-COALESCE(N.AwalD,0))+(COALESCE(N.MK,0)-COALESCE(N.MD,0))+(COALESCE(N.JPK,0)-COALESCE(N.JPD,0))+(COALESCE(N.RLK,0)-COALESCE(N.RLD,0)))

                          else 0

                     ) 

  from dbPerkiraan P

       left outer join dbNeraca N on N.Perkiraan=p.Perkiraan

  where p.Perkiraan=@perkiraan and N.bulan=(@xBulan) and N.tahun=@tahun and N.devisi like @devisi+'%' 

 

 --print(@hasil1)

 select @hasil2=@jurnal

 select @hasil3=@jurnal



if (@tipe='K')           -- //Saldo Akhir

select @hasil1Rp=Sum(Case when P.DK=0 then ((COALESCE(N.AwalDRp,0)-COALESCE(N.AwalKRp,0))+(COALESCE(N.MDRp,0)-COALESCE(N.MKRp,0))+(COALESCE(N.JPDRp,0)-COALESCE(N.JPKRp,0))+(COALESCE(N.RLDRp,0)-COALESCE(N.RLKRp,0))) 

                            when P.DK=1 then ((COALESCE(N.AwalKRp,0)-COALESCE(N.AwalDRp,0))+(COALESCE(N.MKRp,0)-COALESCE(N.MDRp,0))+(COALESCE(N.JPKRp,0)-COALESCE(N.JPDRp,0))+(COALESCE(N.RLKRp,0)-COALESCE(N.RLDRp,0)))

                            else 0

                       ),

         @hasil1=Sum(Case when P.DK=0 then ((COALESCE(N.AwalD,0)-COALESCE(N.AwalK,0))+(COALESCE(N.MD,0)-COALESCE(N.MK,0))+(COALESCE(N.JPD,0)-COALESCE(N.JPK,0))+(COALESCE(N.RLD,0)-COALESCE(N.RLK,0))) 

                          when P.DK=1 then ((COALESCE(N.AwalK,0)-COALESCE(N.AwalD,0))+(COALESCE(N.MK,0)-COALESCE(N.MD,0))+(COALESCE(N.JPK,0)-COALESCE(N.JPD,0))+(COALESCE(N.RLK,0)-COALESCE(N.RLD,0)))

                          else 0

                     ) 

  from dbPerkiraan P

       left outer join dbNeraca N on N.Perkiraan=p.Perkiraan

  where p.Perkiraan=@perkiraan and N.bulan=(@Bulan-1) and N.tahun=@tahun and N.devisi like @devisi+'%'

  select @hasil2Rp=Sum(Case when P.DK=0 then ((COALESCE(N.AwalDRp,0)-COALESCE(N.AwalKRp,0))+(COALESCE(N.MDRp,0)-COALESCE(N.MKRp,0))+(COALESCE(N.JPDRp,0)-COALESCE(N.JPKRp,0))+(COALESCE(N.RLDRp,0)-COALESCE(N.RLKRp,0))) 

                            when P.DK=1 then ((COALESCE(N.AwalKRp,0)-COALESCE(N.AwalDRp,0))+(COALESCE(N.MKRp,0)-COALESCE(N.MDRp,0))+(COALESCE(N.JPKRp,0)-COALESCE(N.JPDRp,0))+(COALESCE(N.RLKRp,0)-COALESCE(N.RLDRp,0)))

                            else 0

                       ),

         @hasil2=Sum(Case when P.DK=0 then ((COALESCE(N.AwalD,0)-COALESCE(N.AwalK,0))+(COALESCE(N.MD,0)-COALESCE(N.MK,0))+(COALESCE(N.JPD,0)-COALESCE(N.JPK,0))+(COALESCE(N.RLD,0)-COALESCE(N.RLK,0))) 

                          when P.DK=1 then ((COALESCE(N.AwalK,0)-COALESCE(N.AwalD,0))+(COALESCE(N.MK,0)-COALESCE(N.MD,0))+(COALESCE(N.JPK,0)-COALESCE(N.JPD,0))+(COALESCE(N.RLK,0)-COALESCE(N.RLD,0)))

                          else 0

                     ) 

  from dbPerkiraan P

       left outer join dbNeraca N on N.Perkiraan=p.Perkiraan

  where p.Perkiraan=@perkiraan and N.bulan=(@Bulan) and N.tahun=@tahun and N.devisi like @devisi+'%'

  select @hasil3Rp=Sum(Case when P.DK=0 then ((COALESCE(N.AwalDRp,0)-COALESCE(N.AwalKRp,0))+(COALESCE(N.MDRp,0)-COALESCE(N.MKRp,0))+(COALESCE(N.JPDRp,0)-COALESCE(N.JPKRp,0))+(COALESCE(N.RLDRp,0)-COALESCE(N.RLKRp,0))) 

                            when P.DK=1 then ((COALESCE(N.AwalKRp,0)-COALESCE(N.AwalDRp,0))+(COALESCE(N.MKRp,0)-COALESCE(N.MDRp,0))+(COALESCE(N.JPKRp,0)-COALESCE(N.JPDRp,0))+(COALESCE(N.RLKRp,0)-COALESCE(N.RLDRp,0)))

                            else 0

                   ),

         @hasil3=Sum(Case when P.DK=0 then ((COALESCE(N.AwalD,0)-COALESCE(N.AwalK,0))+(COALESCE(N.MD,0)-COALESCE(N.MK,0))+(COALESCE(N.JPD,0)-COALESCE(N.JPK,0))+(COALESCE(N.RLD,0)-COALESCE(N.RLK,0))) 

                          when P.DK=1 then ((COALESCE(N.AwalK,0)-COALESCE(N.AwalD,0))+(COALESCE(N.MK,0)-COALESCE(N.MD,0))+(COALESCE(N.JPK,0)-COALESCE(N.JPD,0))+(COALESCE(N.RLK,0)-COALESCE(N.RLD,0)))

                          else 0

                     ) 

  from dbPerkiraan P

       left outer join dbNeraca N on N.Perkiraan=p.Perkiraan

  where p.Perkiraan=@perkiraan and N.bulan=(@Bulan) and N.tahun=@tahun and N.devisi like @devisi+'%'

 select @jurnal=0,@jurnalRp=0



if (@tipe='H')           -- //HPP

select @hasil1Rp=Sum(Case when P.DK=0 then ((COALESCE(N.MDRp,0)-COALESCE(N.MKRp,0))+(COALESCE(N.JPDRp,0)-COALESCE(N.JPKRp,0))+(COALESCE(N.RLDRp,0)-COALESCE(N.RLKRp,0))) 

                            when P.DK=1 then ((COALESCE(N.MKRp,0)-COALESCE(N.MDRp,0))+(COALESCE(N.JPKRp,0)-COALESCE(N.JPDRp,0))+(COALESCE(N.RLKRp,0)-COALESCE(N.RLDRp,0)))

                            else 0

                       ),

         @hasil1=Sum(Case when P.DK=0 then ((COALESCE(N.MD,0)-COALESCE(N.MK,0))+(COALESCE(N.JPD,0)-COALESCE(N.JPK,0))+(COALESCE(N.RLD,0)-COALESCE(N.RLK,0))) 

                          when P.DK=1 then ((COALESCE(N.MK,0)-COALESCE(N.MD,0))+(COALESCE(N.JPK,0)-COALESCE(N.JPD,0))+(COALESCE(N.RLK,0)-COALESCE(N.RLD,0)))

                          else 0

                     ) 

  from dbPerkiraan P

       left outer join dbNeraca N on N.Perkiraan=p.Perkiraan

  where p.Perkiraan=@perkiraan and N.bulan=(@Bulan-1) and N.tahun=@tahun and N.devisi like @devisi+'%'

  select @hasil2Rp=Sum(Case when P.DK=0 then ((COALESCE(N.MDRp,0)-COALESCE(N.MKRp,0))+(COALESCE(N.JPDRp,0)-COALESCE(N.JPKRp,0))+(COALESCE(N.RLDRp,0)-COALESCE(N.RLKRp,0))) 

                            when P.DK=1 then ((COALESCE(N.MKRp,0)-COALESCE(N.MDRp,0))+(COALESCE(N.JPKRp,0)-COALESCE(N.JPDRp,0))+(COALESCE(N.RLKRp,0)-COALESCE(N.RLDRp,0)))

                            else 0

                       ),

         @hasil2=Sum(Case when P.DK=0 then ((COALESCE(N.MD,0)-COALESCE(N.MK,0))+(COALESCE(N.JPD,0)-COALESCE(N.JPK,0))+(COALESCE(N.RLD,0)-COALESCE(N.RLK,0))) 

                          when P.DK=1 then ((COALESCE(N.MK,0)-COALESCE(N.MD,0))+(COALESCE(N.JPK,0)-COALESCE(N.JPD,0))+(COALESCE(N.RLK,0)-COALESCE(N.RLD,0)))

                          else 0

                     ) 

  from dbPerkiraan P

       left outer join dbNeraca N on N.Perkiraan=p.Perkiraan

  where p.Perkiraan=@perkiraan and N.bulan=(@Bulan) and N.tahun=@tahun and N.devisi like @devisi+'%'

  

  select @hasil3Rp=Sum(Case when P.DK=0 then ((COALESCE(N.MDRp,0)-COALESCE(N.MKRp,0))+(COALESCE(N.JPDRp,0)-COALESCE(N.JPKRp,0))+(COALESCE(N.RLDRp,0)-COALESCE(N.RLKRp,0))) 

                            when P.DK=1 then ((COALESCE(N.MKRp,0)-COALESCE(N.MDRp,0))+(COALESCE(N.JPKRp,0)-COALESCE(N.JPDRp,0))+(COALESCE(N.RLKRp,0)-COALESCE(N.RLDRp,0)))

                            else 0

                       ),

         @hasil3=Sum(Case when P.DK=0 then ((COALESCE(N.MD,0)-COALESCE(N.MK,0))+(COALESCE(N.JPD,0)-COALESCE(N.JPK,0))+(COALESCE(N.RLD,0)-COALESCE(N.RLK,0))) 

                          when P.DK=1 then ((COALESCE(N.MK,0)-COALESCE(N.MD,0))+(COALESCE(N.JPK,0)-COALESCE(N.JPD,0))+(COALESCE(N.RLK,0)-COALESCE(N.RLD,0)))

                          else 0

                     ) 

  from dbPerkiraan P

       left outer join dbNeraca N on N.Perkiraan=p.Perkiraan

  where p.Perkiraan=@perkiraan and N.bulan<=(@Bulan) and N.tahun=@tahun and N.devisi like @devisi+'%'

  select @jurnalRp=Sum(Case when P.DK=0 then ((COALESCE(N.MDRp,0)-COALESCE(N.MKRp,0))+(COALESCE(N.JPDRp,0)-COALESCE(N.JPKRp,0))+(COALESCE(N.RLDRp,0)-COALESCE(N.RLKRp,0))) 

                            when P.DK=1 then ((COALESCE(N.MKRp,0)-COALESCE(N.MDRp,0))+(COALESCE(N.JPKRp,0)-COALESCE(N.JPDRp,0))+(COALESCE(N.RLKRp,0)-COALESCE(N.RLDRp,0)))

                            else 0

                       ),

         @jurnal=Sum(Case when P.DK=0 then ((COALESCE(N.MD,0)-COALESCE(N.MK,0))+(COALESCE(N.JPD,0)-COALESCE(N.JPK,0))+(COALESCE(N.RLD,0)-COALESCE(N.RLK,0))) 

                          when P.DK=1 then ((COALESCE(N.MK,0)-COALESCE(N.MD,0))+(COALESCE(N.JPK,0)-COALESCE(N.JPD,0))+(COALESCE(N.RLK,0)-COALESCE(N.RLD,0)))

                          else 0

                     ) 

  from dbPerkiraan P

       left outer join dbNeraca N on N.Perkiraan=p.Perkiraan

  where p.Perkiraan=@perkiraan and N.bulan=(@Bulan) and N.tahun=@tahun and N.devisi like @devisi+'%'



if (@tipe='M')           -- //Mutasi

select @hasil1Rp=Sum(Case when P.DK=0 then ((COALESCE(N.MDRp,0)-COALESCE(N.MKRp,0))+(COALESCE(N.JPDRp,0)-COALESCE(N.JPKRp,0))) 

                            when P.DK=1 then ((COALESCE(N.MKRp,0)-COALESCE(N.MDRp,0))+(COALESCE(N.JPKRp,0)-COALESCE(N.JPDRp,0)))

                            else 0

                       ),

         @hasil1=Sum(Case when P.DK=0 then ((COALESCE(N.MD,0)-COALESCE(N.MK,0))+(COALESCE(N.JPD,0)-COALESCE(N.JPK,0))) 

                          when P.DK=1 then ((COALESCE(N.MK,0)-COALESCE(N.MD,0))+(COALESCE(N.JPK,0)-COALESCE(N.JPD,0)))

                          else 0

                     ) 

  from dbPerkiraan P

       left outer join dbNeraca N on N.Perkiraan=p.Perkiraan

  where p.Perkiraan=@perkiraan and N.bulan=(@Bulan-1) and N.tahun=@tahun and N.devisi like @devisi+'%'



  select @hasil2Rp=Sum(Case when P.DK=0 then ((COALESCE(N.MDRp,0)-COALESCE(N.MKRp,0))+(COALESCE(N.JPDRp,0)-COALESCE(N.JPKRp,0))) 

                            when P.DK=1 then ((COALESCE(N.MKRp,0)-COALESCE(N.MDRp,0))+(COALESCE(N.JPKRp,0)-COALESCE(N.JPDRp,0)))

                            else 0

                       ),

         @hasil2=Sum(Case when P.DK=0 then ((COALESCE(N.MD,0)-COALESCE(N.MK,0))+(COALESCE(N.JPD,0)-COALESCE(N.JPK,0))) 

                          when P.DK=1 then ((COALESCE(N.MK,0)-COALESCE(N.MD,0))+(COALESCE(N.JPK,0)-COALESCE(N.JPD,0)))

                          else 0

                     ) 

  from dbPerkiraan P

       left outer join dbNeraca N on N.Perkiraan=p.Perkiraan

  where p.Perkiraan=@perkiraan and N.bulan=(@Bulan) and N.tahun=@tahun and N.devisi like @devisi+'%'



  select @hasil3Rp=Sum(Case when P.DK=0 then ((COALESCE(N.MDRp,0)-COALESCE(N.MKRp,0))+(COALESCE(N.JPDRp,0)-COALESCE(N.JPKRp,0))) 

                            when P.DK=1 then ((COALESCE(N.MKRp,0)-COALESCE(N.MDRp,0))+(COALESCE(N.JPKRp,0)-COALESCE(N.JPDRp,0)))

                            else 0

                       ),

         @hasil3=Sum(Case when P.DK=0 then ((COALESCE(N.MD,0)-COALESCE(N.MK,0))+(COALESCE(N.JPD,0)-COALESCE(N.JPK,0))) 

                          when P.DK=1 then ((COALESCE(N.MK,0)-COALESCE(N.MD,0))+(COALESCE(N.JPK,0)-COALESCE(N.JPD,0)))

                          else 0

                     ) 

  from dbPerkiraan P

       left outer join dbNeraca N on N.Perkiraan=p.Perkiraan

  where p.Perkiraan=@perkiraan and N.bulan<=(@Bulan) and N.tahun=@tahun and N.devisi like @devisi+'%'

  select @jurnalRp=Sum(Case when P.DK=0 then ((COALESCE(N.MDRp,0)-COALESCE(N.MKRp,0))+(COALESCE(N.JPDRp,0)-COALESCE(N.JPKRp,0))) 

                            when P.DK=1 then ((COALESCE(N.MKRp,0)-COALESCE(N.MDRp,0))+(COALESCE(N.JPKRp,0)-COALESCE(N.JPDRp,0)))

                            else 0

                       ),

         @jurnal=Sum(Case when P.DK=0 then ((COALESCE(N.MD,0)-COALESCE(N.MK,0))+(COALESCE(N.JPD,0)-COALESCE(N.JPK,0))) 

                          when P.DK=1 then ((COALESCE(N.MK,0)-COALESCE(N.MD,0))+(COALESCE(N.JPK,0)-COALESCE(N.JPD,0)))

                          else 0

                     ) 

  from dbPerkiraan P

       left outer join dbNeraca N on N.Perkiraan=p.Perkiraan

  where p.Perkiraan=@perkiraan and N.bulan=(@Bulan) and N.tahun=@tahun and N.devisi like @devisi+'%'

 -- DECLARE REMOVED

 select @trans=(select P.DK from dbperkiraan P where P.perkiraan=@perkiraan)



if (@tipe='1')           -- //MD

select @hasil1Rp=sum(COALESCE(N.MDRp,0)),

         @hasil1=sum(COALESCE(N.MD,0))

  from dbPerkiraan P

       left outer join dbNeraca N on N.Perkiraan=p.Perkiraan

  where p.Perkiraan=@perkiraan and N.bulan=(@Bulan-1) and N.tahun=@tahun and N.devisi like @devisi+'%'

  

  select @hasil2Rp=sum(COALESCE(N.MDRp,0)),

         @hasil2=sum(COALESCE(N.MD,0))

  from dbPerkiraan P

       left outer join dbNeraca N on N.Perkiraan=p.Perkiraan

  where p.Perkiraan=@perkiraan and N.bulan=(@Bulan) and N.tahun=@tahun and N.devisi like @devisi+'%'

  

  select @hasil3Rp=sum(COALESCE(N.MDRp,0)),

         @hasil3=sum(COALESCE(N.MD,0))

  from dbPerkiraan P

       left outer join dbNeraca N on N.Perkiraan=p.Perkiraan

  where p.Perkiraan=@perkiraan and N.bulan<=(@Bulan) and N.tahun=@tahun and N.devisi like @devisi+'%'

 select @jurnal=0, @jurnalRp=0



if (@tipe='2')           -- //MK

select @hasil1Rp=sum(COALESCE(N.MKRp,0)),

         @hasil1=sum(COALESCE(N.MK,0))

  from dbPerkiraan P

       left outer join dbNeraca N on N.Perkiraan=p.Perkiraan

  where p.Perkiraan=@perkiraan and N.bulan=(@Bulan-1) and N.tahun=@tahun and N.devisi like @devisi+'%'

  

  select @hasil2Rp=sum(COALESCE(N.MKRp,0)),

         @hasil2=sum(COALESCE(N.MK,0))

  from dbPerkiraan P

       left outer join dbNeraca N on N.Perkiraan=p.Perkiraan

  where p.Perkiraan=@perkiraan and N.bulan=(@Bulan) and N.tahun=@tahun and N.devisi like @devisi+'%'

  

  select @hasil3Rp=sum(COALESCE(N.MKRp,0)),

         @hasil3=sum(COALESCE(N.MK,0))

  from dbPerkiraan P

       left outer join dbNeraca N on N.Perkiraan=p.Perkiraan

  where p.Perkiraan=@perkiraan and N.bulan<=(@Bulan) and N.tahun=@tahun and N.devisi like @devisi+'%'

  select @jurnal=0, @jurnalRp=0



if (@tipe='3')           -- //JPD

select @hasil1Rp=sum(COALESCE(N.JPDRp,0)),

         @hasil1=sum(COALESCE(N.JPD,0))

  from dbPerkiraan P

       left outer join dbNeraca N on N.Perkiraan=p.Perkiraan

  where p.Perkiraan=@perkiraan and N.bulan=(@Bulan-1) and N.tahun=@tahun and N.devisi like @devisi+'%'

  

  select @hasil2Rp=sum(COALESCE(N.JPDRp,0)),

         @hasil2=sum(COALESCE(N.JPD,0))

  from dbPerkiraan P

       left outer join dbNeraca N on N.Perkiraan=p.Perkiraan

  where p.Perkiraan=@perkiraan and N.bulan=(@Bulan) and N.tahun=@tahun and N.devisi like @devisi+'%'

  

  select @hasil3Rp=sum(COALESCE(N.JPDRp,0)),

         @hasil3=sum(COALESCE(N.JPD,0))

  from dbPerkiraan P

       left outer join dbNeraca N on N.Perkiraan=p.Perkiraan

  where p.Perkiraan=@perkiraan and N.bulan<=(@Bulan) and N.tahun=@tahun and N.devisi like @devisi+'%'

  select @jurnal=0, @jurnalRp=0



if (@tipe='4')           -- //JPK

select @hasil1Rp=sum(COALESCE(N.JPKRp,0)),

         @hasil1=sum(COALESCE(N.JPK,0))

  from dbPerkiraan P

       left outer join dbNeraca N on N.Perkiraan=p.Perkiraan

  where p.Perkiraan=@perkiraan and N.bulan=(@Bulan-1) and N.tahun=@tahun and N.devisi like @devisi+'%'

  

  select @hasil2Rp=sum(COALESCE(N.JPKRp,0)),

         @hasil2=sum(COALESCE(N.JPK,0))

  from dbPerkiraan P

       left outer join dbNeraca N on N.Perkiraan=p.Perkiraan

  where p.Perkiraan=@perkiraan and N.bulan=(@Bulan) and N.tahun=@tahun and N.devisi like @devisi+'%'

  

  select @hasil3Rp=sum(COALESCE(N.JPKRp,0)),

         @hasil3=sum(COALESCE(N.JPK,0))

  from dbPerkiraan P

       left outer join dbNeraca N on N.Perkiraan=p.Perkiraan

  where p.Perkiraan=@perkiraan and N.bulan<=(@Bulan) and N.tahun=@tahun and N.devisi like @devisi+'%'

  select @jurnal=0, @jurnalRp=0



-- DECLARE REMOVED,@perkHpp varchar(25),@perk1 varchar(25),@lawan1 varchar(25),@BhnBaku varchar(25),

        @brgJadi Varchar(25)        

Select @perkRl=Perkiraan from DBPOSTHUTPIUT where Kode='RLB'

select @perkHpp=Perkiraan from DBPOSTHUTPIUT where Kode='HPP'

-- DECLARE REMOVED

select @temptgl=datetime('now')

-- PRINT REMOVED
if COALESCE(@jurnal,0)<>0 or COALESCE(@jurnalRp,0)<>0

if (@tipe<>'T') and (@tipe<>'H') 

 if @trans=0

  if @Rl_Hpp=0 select @perk1=@perkRl    

   else select @perk1=@perkHpp

   select @lawan1=@perkiraan

  

  else

  select @perk1=@perkiraan

   if @Rl_Hpp=0 select @lawan1=@perkRl    

   else select @lawan1=@perkHpp


 else

 if (@tipe='T')

 if @Rl_Hpp=0 select @perk1=@perkRl    

  else select @perk1=@perkHpp

  select @lawan1=@perkiraan

 

 else

 if (@tipe='H') and (@Rl_Hpp=0)

 select @perk1=@perkRL

             select @lawan1=@perkHPP

 

 -- DECLARE REMOVED

 ---- PRINT REMOVED
  if @Rl_Hpp=0 

  select @keterangan='Jurnal Penutup'

 else

  select @keterangan='HPP Penutup' 

 -- DECLARE REMOVED,@nobukti varchar(20),@prd varchar(8),@tipetrans varchar(3),

 @nourut int

 if @Rl_Hpp=0 

 select @s='00000' 

  select @tipetrans='R/L'  

 

 else 

 select @s='00000' 

  select @tipetrans='HPP'

 

 Select @nourut=MAX(Cast(nourut as int)) from dbTrans where LEFT(nobukti,3)=@tipetrans and 

 month(tanggal)=@bulan and year(tanggal)=@tahun

 -- SET REMOVEDSUBSTRING(@s,1,LEN(@s)-LEN(Cast(COALESCE(@nourut,0)+1 as varchar(5))))+Cast(COALESCE(@nourut,0)+1 as varchar(5))

 if @bulan<10 

    select @prd='/0'+cast(@bulan as varchar(1))+SUBSTR(cast(@tahun as varchar(4)), LENGTH(cast(@tahun as varchar(4)))-2+1)

 else

    select @prd='/'+cast(@bulan as varchar(2))+SUBSTR(cast(@tahun as varchar(4)), LENGTH(cast(@tahun as varchar(4)))-2+1)

  if @Rl_Hpp=0 

     select @noBukti=@tipetrans+@prd+'/'+@s+'/BCB'

  else

     select @noBukti=@tipetrans+@prd+'/'+@s+'/BCB'

 --print(@jurnal)

 --print(@lawan1)

 --print(@devisi)

 exec dbo.SP_Transaksi 'I',@Nobukti,@S,@tanggal,@Keterangan,0,@devisi,@Perk1,@Lawan1,@Keterangan,'',

 @jurnalRp,0,'IDR',1,@jurnalRp,0,@tipetrans,'C','','',1,'','','','','','','','','','';

-- Sp_HitungUlang
CREATE PROCEDURE IF NOT EXISTS Sp_HitungUlang AS tran

  if not exists (Select Kodebrg 

                 from dbstockbrg 

                 where Kodebrg=@kodebrg and Kodegdg=@kodegdg

                 and Bulan=@bulan and tahun=@tahun)

  insert into dbstockbrg(Kodebrg,Bulan,Tahun,Kodegdg)

    Values(@Kodebrg,@bulan,@Tahun,@kodegdg)


  ----------------------------

  Update DBKOREKSIDET Set QNTDB=Case When a.KODEBRG=c.KodeBrg Then c.QNT else 0 ,

                        QNTCR=Case When a.KODEBRG=c.KodeBrgA Then c.QNT else 0 ,

                        QNT2DB=Case When a.KODEBRG=c.KodeBrg Then c.QNT2 else 0 ,

                        QNT2CR=Case When a.KODEBRG=c.KodeBrgA Then c.QNT2 else 0   

  from DBKOREKSIDET a

  Left Outer Join DBKOREKSI b on a.NOBUKTI=b.NOBUKTI

  Left Outer Join dbSPBDet c on b.NOTE Like '%'+c.NoBukti+'%' and LEFT(a.NOBUKTI,1)=LEFT(c.NoBukti,1)

  where c.isCetakKitir=1 and (Case When a.KODEBRG=c.KodeBrg Then a.QNTDB when a.KODEBRG=c.KodeBrgA Then a.QNTCR <>c.QNT

  or Case When a.KODEBRG=c.KodeBrg Then a.QNT2DB when a.KODEBRG=c.KodeBrgA Then a.QNT2CR <>c.QNT2)

  and MONTH(TANGGAL)=@Bulan and YEAR(TANGGAL)=@Tahun

  and c.KodeBrg=@Kodebrg

  ----------------------------

   if @Tipe='ADI' or @Tipe='ADO'

   delete dbKoreksi where NoBukti='' and Month(tanggal)=@bulan and Year(Tanggal)=@Tahun  

   

  -----------------

  

  if @Tipe='ADI' or @Tipe='ADO'

  -- DECLARE REMOVED,@Tanggal datetime,@xQnt numeric(18,2),@xQnt2 numeric(18,2)

    Declare MyOpname Cursor for

    

    select A.NoBukti, A.Tanggal

    from dbKoreksi A, dbKoreksiDet B 

    where A.NoBukti=B.NoBukti 

    and year(A.Tanggal)=@Tahun and month(A.Tanggal)=@Bulan

    and A.nobukti like '%OP%' and B.KodeBrg=@Kodebrg and A.kodeGdg=@Kodegdg

    group by A.NoBukti, A.Tanggal, B.KodeBrg 

    order by A.Tanggal, A.NoBukti, B.KodeBrg 

 

   Open MyOpname

   Fetch Next from MyOpname into @NoBukti,@Tanggal

   While @@fetch_Status=0

   update dbKoreksiDet set SaldoComp=COALESCE(C.QntSaldo,0),Saldo2Comp=COALESCE(C.Qnt2Saldo,0)       

     from dbKoreksiDet A

     left outer join dbKoreksi B on B.NoBukti=A.NoBukti

     left outer join

	   (select	KodeBrg, KodeGdg, sum(QntSaldo) QntSaldo, sum(Qnt2Saldo) Qnt2Saldo

	    from

		   (  

		     select 	a.KodeBrg, a.KodeGdg, a.QntSaldo, a.Qnt2Saldo Qnt2Saldo 

		     from 	vwKartuStock a

		     where 	year(a.Tanggal)=year(@Tanggal) and month(a.Tanggal)=month(@Tanggal) and a.Tanggal<=@Tanggal

		     and a.KodeBrg=@KodeBrg

		     and a.NoBukti<>@NoBukti --and Tipe<>@Tipe

		   ) X

	       group by KodeBrg, KodeGdg

	   ) C on C.KodeBrg=A.KodeBrg and C.KodeGdg=B.KodeGdg

        where A.NoBukti=@NoBukti and A.KodeBrg=@KodeBrg

          

        update 	dbKoreksiDet

        set 	Selisih=QntOpname-SaldoComp, Selisih2=Qnt2Opname-Saldo2Comp

        where 	NoBukti=@NoBukti and KodeBrg=@KodeBrg 



        update 	dbKoreksiDet

        set	QntDb=case when Selisih>0 then Selisih else 0 , QntCr=case when Selisih<0 then -1*Selisih else 0 ,

	    Qnt2DB=case when Selisih2>0 then Selisih2 else 0 , Qnt2CR=case when Selisih2<0 then -1*Selisih2 else 0 

        where 	NoBukti=@NoBukti and KodeBrg=@KodeBrg


   Fetch Next from MyOpname into @NoBukti,@Tanggal

   

   Close MyOpname

   Deallocate MyOpname

   

   if @Tipe='ADI'

   Update DBSTOCKBRG set QNTADI=0,QNT2ADI=0 where  Bulan=@bulan and Tahun=@tahun and KODEGDG=@Kodegdg and KODEBRG=@Kodebrg

    else

   if @Tipe='ADO'

   Update DBSTOCKBRG set QNTADO=0,QNT2ADO=0 where  Bulan=@bulan and Tahun=@tahun and KODEGDG=@Kodegdg and KODEBRG=@Kodebrg


   Select @xQnt=COALESCE(Sum(Case when COALESCE(a.QntDB,0)<>0 then COALESCE(a.QntDB,0) else COALESCE(a.QntCR,0) ),0), 

          @xQnt2=COALESCE(sum(Case when COALESCE(a.Qnt2DB,0)<>0 then COALESCE(a.Qnt2DB,0) else COALESCE(a.Qnt2CR,0) ),0)

   from vwkartuStock a

   left outer join dbbarang b on b.kodebrg=a.kodebrg

   where  Bulan=@Bulan and tahun=@Tahun and Tipe=@Tipe

   and a.kodebrg=@Kodebrg and a.Kodegdg=@Kodegdg

   Group by a.Tipe,a.Kodebrg,b.Namabrg,a.Kodegdg

   Order by a.Tipe,a.Kodebrg,a.Kodegdg

     

    if @Tipe='ADI'

    Update dbstockbrg set QntADI=QntADI+COALESCE(@xQnt,0), Qnt2ADI=Qnt2ADI+COALESCE(@xQnt2,0)          

      where Kodebrg=@kodebrg and Kodegdg=@kodegdg and Bulan=@bulan and tahun=@tahun

    

    else 

    if @Tipe='ADO'

    Update dbstockbrg set QntADO=QntADO+COALESCE(@xQnt,0), Qnt2ADO=Qnt2ADO+COALESCE(@xQnt2,0)

      where Kodebrg=@kodebrg and Kodegdg=@kodegdg and Bulan=@bulan and tahun=@tahun


  else 

  if @Tipe='PBL'

  Update dbstockbrg set QNTPBL =QNTPBL+@Qnt, QNT2PBL=QNT2PBL+@Qnt2     

    where Kodebrg=@kodebrg and Kodegdg=@kodegdg and Bulan=@bulan and tahun=@tahun

  

  else

  if @Tipe='RPB'

  Update dbstockbrg set QNTRPB =QNTRPB+@Qnt, QNT2RPB=QNT2RPB+@Qnt2     

    where Kodebrg=@kodebrg and Kodegdg=@kodegdg and Bulan=@bulan and tahun=@tahun

  

  else

  if @Tipe='PNJ'

  Update dbstockbrg set QNTPNJ =QNTPNJ+@Qnt, QNT2PNJ=QNT2PNJ+@Qnt2     

    where Kodebrg=@kodebrg and Kodegdg=@kodegdg and Bulan=@bulan and tahun=@tahun

  

  else

  if @Tipe='RPJ'

  Update dbstockbrg set QNTRPJ=QNTRPJ+@Qnt, QNT2RPJ=QNT2RPJ+@Qnt2     

    where Kodebrg=@kodebrg and Kodegdg=@kodegdg and Bulan=@bulan and tahun=@tahun

  

  else

  if @Tipe='UKI'

  Update dbstockbrg set QNTUKI =QNTUKI+@Qnt, QNT2UKI=QNT2UKI+@Qnt2     

    where Kodebrg=@kodebrg and Kodegdg=@kodegdg and Bulan=@bulan and tahun=@tahun

  

  else

  if @Tipe='UKO'

  Update dbstockbrg set QNTUKO =QNTUKO+@Qnt, QNT2UKO=QNT2UKO+@Qnt2     

    where Kodebrg=@kodebrg and Kodegdg=@kodegdg and Bulan=@bulan and tahun=@tahun

  

  else

  if @Tipe='TRI' or @Tipe='PBI'

  Update dbstockbrg set QNTTRI =QNTTRI+@Qnt, QNT2TRI=QNT2TRI+@Qnt2     

    where Kodebrg=@kodebrg and Kodegdg=@kodegdg and Bulan=@bulan and tahun=@tahun

  

  else

  if @Tipe='TRO' or @Tipe='PBO'

  Update dbstockbrg set QNTTRO =QNTTRO+@Qnt, QNT2TRO=QNT2TRO+@Qnt2     

    where Kodebrg=@kodebrg and Kodegdg=@kodegdg and Bulan=@bulan and tahun=@tahun

  

  else 

  if @Tipe='PMK'

  Update dbstockbrg set QntPMK=QntPMK+@Qnt, Qnt2PMK=Qnt2PMK+@Qnt2          

    where Kodebrg=@kodebrg and Kodegdg=@kodegdg and Bulan=@bulan and tahun=@tahun

  

  else 

  if @Tipe='RPK'

  Update dbstockbrg set QntRPK=QntRPK+@Qnt, Qnt2RPK=Qnt2RPK+@Qnt2

    where Kodebrg=@kodebrg and Kodegdg=@kodegdg and Bulan=@bulan and tahun=@tahun

  

  else 

  if @Tipe='HP'

  Update dbstockbrg set QntHPrd=COALESCE(QntHPrd,0)+@Qnt, Qnt2HPrd=COALESCE(Qnt2HPrd,0)+@Qnt2

    where Kodebrg=@kodebrg and Kodegdg=@kodegdg and Bulan=@bulan and tahun=@tahun


  if @@error<>0 goto JikaSalah

commit tran

return

jikaSalah: Rollback tran

           return;

-- sp_HitungUlangAktiva
CREATE PROCEDURE IF NOT EXISTS sp_HitungUlangAktiva AS --insert into dbAktivadet(Bulan,tahun,Perkiraan,devisi)

--select @Bulan,@Tahun,@Perkiraan,a.Devisi 

--from DBDEVISI a

--where Devisi not in (select devisi from dbAktivadet x where perkiraan=@Perkiraan and bulan =@bulan and tahun=@tahun) 

update DBAKTIVADET set dmk=0,MK=0,DMD=0,MD=0,DSD=0,SD=0,DSK=0,SK=0 where Perkiraan=@Perkiraan and Bulan=@Bulan and Tahun=@Tahun



update dbAktivadet set MK=COALESCE((select sum(DebetRp) from dbTransaksi

   where month(Tanggal)=@Bulan and year(Tanggal)=@Tahun and Devisi=DBAKTIVADET.Devisi 

   and ((StatusAktivaP='AKV-' and NoAktivaP=@Perkiraan) or (StatusAktivaL='AKV-' and NoAktivaL=@Perkiraan)) and DebetRp<>0),0),

   MD=COALESCE((select sum(DebetRp) from dbTransaksi

   where month(Tanggal)=@Bulan and year(Tanggal)=@Tahun and Devisi=DBAKTIVADET.Devisi 

   and ((StatusAktivaP='AKV+' and NoAktivaP=@Perkiraan) or (StatusAktivaL='AKV+' and NoAktivaL=@Perkiraan)) and DebetRp<>0),0)

where Perkiraan=@Perkiraan and Bulan=@Bulan and Tahun=@Tahun



Update dbAktivadet set SK=COALESCE((select sum(DebetRp) from dbTransaksi

   where month(Tanggal)=@Bulan and year(Tanggal)=@Tahun and Devisi=DBAKTIVADET.Devisi 

   and ((StatusAktivaP='AKM+' and NoAktivaP=@Perkiraan) or (StatusAktivaL='AKM-' and NoAktivaL=@Perkiraan)) and DebetRp<>0),0),

   SD=COALESCE((select sum(DebetRp) from dbTransaksi

   where month(Tanggal)=@Bulan and year(Tanggal)=@Tahun and Devisi=DBAKTIVADET.Devisi 

   and ((StatusAktivaP='AKM-' and NoAktivaP=@Perkiraan) or (StatusAktivaL='AKM+' and NoAktivaL=@Perkiraan)) and DebetRp<>0),0)

where Perkiraan=@Perkiraan and Bulan=@Bulan and Tahun=@Tahun;

-- Sp_HitungUlangInvoice
CREATE PROCEDURE IF NOT EXISTS Sp_HitungUlangInvoice AS -- DECLARE REMOVED,@str2 varchar(8000),@str3 varchar(1000)



tran

  if not exists (Select 'true' from DBCustAreaKota where KodeArea =@KodeArea and KodeCustSupp=@KodeCustSupp and KodeKota=@KodeKota and @Tahun =@Tahun)

  insert into DBCustAreaKota(KodeCustSupp,KodeArea,KodeKota,Tahun)

    Values(@KodeCustSupp,@KodeArea,@KodeKota,@Tahun)

  

  if not exists (Select 'true' from DBSalesCustPrd where KodeBrg =@Kodebrg and KodeCustSupp=@KodeCustSupp and KodeSLS=@KodeSLS and @Tahun =@Tahun)

  insert into DBSalesCustPrd(KodeBrg,KodeCustSupp,KodeSLS,Tahun)

    Values(@Kodebrg,@KodeCustSupp,@KodeSLS,@Tahun)

  

  if not exists (Select 'true' from DBAreaKotaPrd where KodeBrg =@Kodebrg and KodeKota=@KodeKota and KodeArea=@KodeArea and @Tahun =@Tahun)

  insert into DBAreaKotaPrd(KodeBrg,KodeArea,KodeKota,Tahun)

    Values(@Kodebrg,@KodeArea,@KodeKota,@Tahun)

  

 if @Tipe='IPL'

  select @str='Update DBCustAreaKota set QntBln'+CAST(@Bulan AS TEXT)+'=QntBln'+CAST(@Bulan AS TEXT)+' + '+CAST(@qnt AS TEXT)+

    ', qnt2bln'+ CAST(@bulan AS TEXT)+' = '+ 'qnt2bln'+CAST(@bulan AS TEXT) +' + ' +CAST(@qnt2 AS TEXT)+

    ', RpBln'+ CAST(@bulan AS TEXT)+' = '+'RpBln'+CAST(@bulan AS TEXT)+' + '+CAST(@RpBln AS TEXT)+       

    ' where KodeCustSupp='''+CAST(@kodecustsupp AS TEXT)+''' and Kodearea='''+CAST(@kodearea AS TEXT)+''' 

    and kodekota='''+CAST(@kodekota AS TEXT)+''' and tahun='+CAST(@tahun AS TEXT)

   -- select @str ='select qntbln'+CAST(@Bulan AS TEXT)+'=qntbln'+CAST(@Bulan AS TEXT)+'+'+CAST(@qnt AS TEXT)+' from DBCustAreaKota'

    ---- PRINT REMOVED
    exec (@str)

    select @str2='Update DBSalesCustPrd set QntBln'+CAST(@Bulan AS TEXT)+'=QntBln'+CAST(@Bulan AS TEXT)+' + '+CAST(@qnt AS TEXT)+

    ', qnt2bln'+ CAST(@bulan AS TEXT)+' = '+ 'qnt2bln'+CAST(@bulan AS TEXT) +' + ' +CAST(@qnt2 AS TEXT)+

    ', RpBln'+ CAST(@bulan AS TEXT)+' = '+'RpBln'+CAST(@bulan AS TEXT)+' + '+CAST(@RpBln AS TEXT)+       

    ' where KodeCustSupp='''+CAST(@kodecustsupp AS TEXT)+''' and Kodesls='''+CAST(@kodesls AS TEXT)+''' 

    and kodebrg='''+CAST(@Kodebrg AS TEXT)+''' and tahun='+CAST(@tahun AS TEXT)    

    ---- PRINT REMOVED
    exec (@str2)

    select @str3='Update DBAreaKotaPrd set QntBln'+CAST(@Bulan AS TEXT)+'=QntBln'+CAST(@Bulan AS TEXT)+' + '+CAST(@qnt AS TEXT)+

    ', qnt2bln'+ CAST(@bulan AS TEXT)+' = '+ 'qnt2bln'+CAST(@bulan AS TEXT) +' + ' +CAST(@qnt2 AS TEXT)+

    ', RpBln'+ CAST(@bulan AS TEXT)+' = '+'RpBln'+CAST(@bulan AS TEXT)+' + '+CAST(@RpBln AS TEXT)+       

    ' where Kodearea='''+CAST(@kodearea AS TEXT)+'''  and kodekota='''+CAST(@kodekota AS TEXT)+'''

    and kodebrg='''+CAST(@Kodebrg AS TEXT)+''' and tahun='+CAST(@tahun AS TEXT)    

    exec (@str3)


  else if @Tipe='RIPL'

  select @str='Update DBCustAreaKota set QntBln'+CAST(@Bulan AS TEXT)+'=QntBln'+CAST(@Bulan AS TEXT)+' - '+CAST(@qnt AS TEXT)+

    ', qnt2bln'+ CAST(@bulan AS TEXT)+' = '+ 'qnt2bln'+CAST(@bulan AS TEXT) +' - ' +CAST(@qnt2 AS TEXT)+

    ', RpBln'+ CAST(@bulan AS TEXT)+' = '+'RpBln'+CAST(@bulan AS TEXT)+' - '+CAST(@RpBln AS TEXT)+       

    ' where KodeCustSupp='''+CAST(@kodecustsupp AS TEXT)+''' and Kodearea='''+CAST(@kodearea AS TEXT)+''' 

    and kodekota='''+CAST(@kodekota AS TEXT)+''' and tahun='+CAST(@tahun AS TEXT)

   -- select @str ='select qntbln'+CAST(@Bulan AS TEXT)+'=qntbln'+CAST(@Bulan AS TEXT)+'+'+CAST(@qnt AS TEXT)+' from DBCustAreaKota'

    ---- PRINT REMOVED
    exec (@str)

    select @str2='Update DBSalesCustPrd set QntBln'+CAST(@Bulan AS TEXT)+'=QntBln'+CAST(@Bulan AS TEXT)+' - '+CAST(@qnt AS TEXT)+

    ', qnt2bln'+ CAST(@bulan AS TEXT)+' = '+ 'qnt2bln'+CAST(@bulan AS TEXT) +' - ' +CAST(@qnt2 AS TEXT)+

    ', RpBln'+ CAST(@bulan AS TEXT)+' = '+'RpBln'+CAST(@bulan AS TEXT)+' - '+CAST(@RpBln AS TEXT)+       

    ' where KodeCustSupp='''+CAST(@kodecustsupp AS TEXT)+''' and Kodesls='''+CAST(@kodesls AS TEXT)+''' 

    and kodebrg='''+CAST(@Kodebrg AS TEXT)+''' and tahun='+CAST(@tahun AS TEXT)    

    exec (@str2)

    select @str3='Update DBAreaKotaPrd set QntBln'+CAST(@Bulan AS TEXT)+'=QntBln'+CAST(@Bulan AS TEXT)+' - '+CAST(@qnt AS TEXT)+

    ', qnt2bln'+ CAST(@bulan AS TEXT)+' = '+ 'qnt2bln'+CAST(@bulan AS TEXT) +' - ' +CAST(@qnt2 AS TEXT)+

    ', RpBln'+ CAST(@bulan AS TEXT)+' = '+'RpBln'+CAST(@bulan AS TEXT)+' - '+CAST(@RpBln AS TEXT)+       

    ' where Kodearea='''+CAST(@kodearea AS TEXT)+'''  and kodekota='''+CAST(@kodekota AS TEXT)+'''

    and kodebrg='''+CAST(@kodebrg AS TEXT)+''' and tahun='+CAST(@tahun AS TEXT)    

    exec (@str3)

   

  if @@error<>0 goto JikaSalah

commit tran

return

jikaSalah: Rollback tran

           return;

-- sp_HitungUlangTransaksi
CREATE PROCEDURE IF NOT EXISTS sp_HitungUlangTransaksi AS --Select @devisi='01',@bulan=1,@tahun=2011

Set nocount on



Insert Into DBNERACA (Perkiraan, Bulan, Tahun, Devisi,Valas)

Select Perkiraan, @bulan, @tahun, @devisi,Valas

from DBPERKIRAAN 

where Perkiraan=@Perkiraan and Tipe=1 and Perkiraan not in (Select Perkiraan 

                                                            from DBNERACA 

                                                            where Perkiraan=@Perkiraan and Bulan=@bulan and Tahun=@tahun

                                                                  and Devisi=@devisi)

union 

Select Perkiraan, @bulan, @tahun, @devisi,Valas

from DBPERKIRAAN 

where Perkiraan=@Lawan and Tipe=1 and Perkiraan not in (Select Perkiraan 

                                                            from DBNERACA 

                                                            where Perkiraan=@Lawan and Bulan=@bulan and Tahun=@tahun

                                                                  and Devisi=@devisi)



if @Tipetrans in ('BKK','BKM','BBM','BBK','BMM','PBL','PJL')

update DBNERACA set MD=MD+Case when @Valas<>'IDR' then @Jumlah else 0 , MDRp=MDRp+@jumalhRp

  where Devisi=@devisi and Perkiraan=@Perkiraan and Bulan=@bulan and Tahun=@tahun

  

  update DBNERACA set MK=MK+Case when @Valas<>'IDR' then @Jumlah else 0 , MKRp=MKRp+@jumalhRp

  where Devisi=@devisi and Perkiraan=@Lawan and Bulan=@bulan and Tahun=@tahun 



else if @Tipetrans in ('BJK')

update DBNERACA set JPD=JPD+Case when @Valas<>'IDR' then @Jumlah else 0 , JPDRp=JPDRp+@jumalhRp

  where Devisi=@devisi and Perkiraan=@Perkiraan and Bulan=@bulan and Tahun=@tahun

  

  update DBNERACA set JPK=JPK+Case when @Valas<>'IDR' then @Jumlah else 0 , JPKRp=JPKRp+@jumalhRp

  where Devisi=@devisi and Perkiraan=@Lawan and Bulan=@bulan and Tahun=@tahun 



else if @Tipetrans in ('R/L','HPP')

update DBNERACA set RLD=RLD+Case when @Valas<>'IDR' then @Jumlah else 0 , RLDRp=RLDRp+@jumalhRp

  where Devisi=@devisi and Perkiraan=@Perkiraan and Bulan=@bulan and Tahun=@tahun

  

  update DBNERACA set RLK=RLK+Case when @Valas<>'IDR' then @Jumlah else 0 , RLKRp=RLKRp+@jumalhRp

  where Devisi=@devisi and Perkiraan=@Lawan and Bulan=@bulan and Tahun=@tahun


set nocount off;

-- Sp_HPPJadi
CREATE PROCEDURE IF NOT EXISTS Sp_HPPJadi AS tran

if @choice='I'

insert into dbHPPProduksi (Bulan, Tahun,KOdeBrg,HPPBrg)

	values (@Bulan, @Tahun,@KOdeBrg,@HPP)

	if @@error <> 0 goto jikasalah



if @choice='U'

--update dbHPPProduksi set Bulan=@Bulan,Tahun=@Tahun,KodeBrg=@KOdeBrg,HPPBrg=@HPP

      --       where Bulan=@OldBulan and Tahun = @OldTahun and Kodebrg = @OldKOdeBrg

    update dbHPPProduksi set HPPBrg=@HPP

             where Bulan=1 and Tahun = @OldTahun and Kodebrg = @OldKOdeBrg and Bulan>=@OldBulan

    update dbHPPProduksi set HPPBrg=@HPP

             where Bulan=2 and Tahun = @OldTahun and Kodebrg = @OldKOdeBrg and Bulan>=@OldBulan

    update dbHPPProduksi set HPPBrg=@HPP

             where Bulan=3 and Tahun = @OldTahun and Kodebrg = @OldKOdeBrg and Bulan>=@OldBulan

    update dbHPPProduksi set HPPBrg=@HPP

             where Bulan=4 and Tahun = @OldTahun and Kodebrg = @OldKOdeBrg and Bulan>=@OldBulan

    update dbHPPProduksi set HPPBrg=@HPP

             where Bulan=5 and Tahun = @OldTahun and Kodebrg = @OldKOdeBrg and Bulan>=@OldBulan

    update dbHPPProduksi set HPPBrg=@HPP

             where Bulan=6 and Tahun = @OldTahun and Kodebrg = @OldKOdeBrg and Bulan>=@OldBulan

    update dbHPPProduksi set HPPBrg=@HPP

             where Bulan=7 and Tahun = @OldTahun and Kodebrg = @OldKOdeBrg and Bulan>=@OldBulan

    update dbHPPProduksi set HPPBrg=@HPP

             where Bulan=8 and Tahun = @OldTahun and Kodebrg = @OldKOdeBrg and Bulan>=@OldBulan

    update dbHPPProduksi set HPPBrg=@HPP

             where Bulan=9 and Tahun = @OldTahun and Kodebrg = @OldKOdeBrg and Bulan>=@OldBulan

    update dbHPPProduksi set HPPBrg=@HPP

             where Bulan=10 and Tahun = @OldTahun and Kodebrg = @OldKOdeBrg and Bulan>=@OldBulan

    update dbHPPProduksi set HPPBrg=@HPP

             where Bulan=11 and Tahun = @OldTahun and Kodebrg = @OldKOdeBrg and Bulan>=@OldBulan

    update dbHPPProduksi set HPPBrg=@HPP

             where Bulan=12 and Tahun = @OldTahun and Kodebrg = @OldKOdeBrg and Bulan>=@OldBulan

	if @@error <> 0 goto jikasalah



if @choice='D'

--delete  dbHPPProduksi where Bulan=@OldBulan and Tahun = @OldTahun and Kodebrg = @OldKodeBrg 

	if @@error <> 0 goto jikasalah



commit tran

return

jikasalah:

	rollback tran

	raiserror('Proses Input Data Gagal',16,1)

	return;

-- Sp_HutangAwal
CREATE PROCEDURE IF NOT EXISTS Sp_HutangAwal AS if @choice='I'

select @urut=Max(urut) 

	from dbHUTPIUT 

	where KodeCustSupp=@kodesupp and NoFaktur=@nobukti 

	-- SET REMOVEDCase when @urut is null then 1 else @urut + 1 

	insert into dbHUTPIUT(NoFaktur,Tanggal,JatuhTempo,KodeCustSupp,Debet,Kredit,

		                  DebetD,KreditD,TipeTrans,Tipe,Urut,NoMsk,Valas,Kurs,Perkiraan)

	values(@Nobukti,@tglBukti,@TglJatuhTempo,@KodeSupp,@JumlahRp,@KreditRp,

	       Case when @Valas='IDR' then 0 else @Jumlah ,

	       Case when @Valas='IDR' then 0 else @Kredit ,@tipetrans,'HT',

		   @urut,0,@valas,@kurs,@Perkiraan)



if @choice='U'

update dbHUTPIUT set  Debet=@JumlahRp,Kredit=@KreditRp,JatuhTempo=@tglJatuhTempo ,tanggal=@tglbukti,

                       DebetD=Case when @Valas='IDR' then 0 else @Jumlah ,

                       KreditD=Case when @Valas='IDR' then 0 else @Kredit ,Valas=@Valas,Kurs=@kurs

 where NoFaktur=@Nobukti and KodeCustSupp=@kodesupp and 

       tipetrans=@tipetrans and urut=@urut and Perkiraan=@Perkiraan and Tipe='HT'



if @choice='D'

delete dbHUTPIUT 

 where NoFaktur=@Nobukti and KodeCustSupp=@kodesupp and 

       tipetrans=@tipetrans and urut=@urut and Perkiraan=@Perkiraan and Tipe='HT';

-- sp_HutPiut
CREATE PROCEDURE IF NOT EXISTS sp_HutPiut AS if @Choice='I'

select @Urut=Max(Urut) 

	from DBHUTPIUT 

	where KodeCustSupp=@KodeCustSupp and NoFaktur=@NoFaktur 

	-- SET REMOVEDisnull(@Urut,0)+1

	insert into DBHUTPIUT (NoFaktur, NoRetur, TipeTrans, KodeCustSupp, 

	NoBukti, NoMsk, Urut, 

	Tanggal, JatuhTempo, Debet, Kredit, Valas, Kurs, DebetD, KreditD, 

	KodeSales, Tipe, Perkiraan, Catatan, NoInvoice, KodeVls_, Kurs_, KursBayar,TipeBayar,NoPelunasan,

	PerkiraanKas,TglButuh,PerkiraanTBayar)

	values (@NoFaktur, @NoRetur, @TipeTrans, @KodeCustSupp, 

	@NoBukti, @NoMsk, @Urut, 

	@Tanggal, @JatuhTempo, @Debet*@Kurs, @Kredit*@Kurs, @Valas, @Kurs, 

	case when @Valas='IDR' then @DebetD else @Debet , 

	case when @Valas='IDR' then @KreditD else @Kredit , 

	@KodeSales, @Tipe, @Perkiraan, @Catatan,

	@NoInvoice, @KodeVls_, @Kurs_, @KursBayar,@TipeBayar,@NoPelunasan,@PerkiraanKas,@Tglbutuh,@PerkiraanTBayar)

	if @TipeBayar=1  

	insert into DBGIRO (Bank, NoGiro, TglGiro, Debet, Kredit, DebetRp, KreditRp,KodeVls, Kurs, KeteranganCair, TglCair, BuktiCair,Tipe)

    values (@Bank, @NoGiro, @TglGiro, @Debet, @Kredit, @NilaiGiroD, @NilaiGiroK, @Valas, @Kurs, '', @Tanggal, @BuktiCair,@Tipe)



if @choice='U'

update DBHUTPIUT 

	set Tanggal=@Tanggal, JatuhTempo=@JatuhTempo, Debet=@Debet*@Kurs, Kredit=@Kredit*@Kurs, Valas=@Valas, Kurs=@Kurs, 

	DebetD=case when @Valas='IDR' then 0 else @Debet , KreditD=case when @Valas='IDR' then 0 else @Kredit , 

	KodeSales=@KodeSales, Tipe=@Tipe, Catatan=@Catatan,TipeBayar=@TipeBayar,

	NoPelunasan=@NoPelunasan,

	PerkiraanKas=@PerkiraanKas,Tglbutuh=@Tglbutuh,PerkiraanTBayar=@PerkiraanTBayar

	where NoFaktur=@NoFaktur and NoRetur=@NoRetur and TipeTrans='L' and KodeCustSupp=@KodeCustSupp and NoBukti=@NoBukti

	and Perkiraan=@Perkiraan and NoMsk=@NoMsk and Urut=@Urut 



if @choice='D'

delete DBHUTPIUT 

	where NoFaktur=@NoFaktur and NoRetur=@NoRetur and TipeTrans='L' and KodeCustSupp=@KodeCustSupp and NoBukti=@NoBukti

	and Perkiraan=@Perkiraan and NoMsk=@NoMsk and Urut=@Urut

	if @TipeBayar=1 delete DBGIRO where NoGiro=@noGiro and BuktiCair=@BuktiCair;

-- Sp_InsertInvPL
CREATE PROCEDURE IF NOT EXISTS Sp_InsertInvPL AS --Select @NoSPB='SJY/SJ/0712/00002'

tran

insert into dbInvoicePL (NoBukti, NoUrut, Tanggal,PPN, Valas, Kurs, NoSPP, KodeCustSupp, Consignee, NotifyParty, 

StuffingDate, StuffingPlace, ContractNo, PONo, PaymentTerm, DocCreditNo, PoL, PoD, NameOfVessel, ShipOnBoardDate, 

Packing, Others, IsCetak, IDUser, IsLokal) 

select @NoBukti, @NoUrut, @Tanggal,C.PPn,C.KODEVLS,C.Kurs,D.NoBukti NoSPP,C.Kodecust,'' Consignee,'' Notify_Party,

       null Stuffing_Date, '' Stuffing_Place, C.Nobukti NoSO, '' NOPO, '' Term_of_Payment,

       '' NoLC, '' Port_of_Loading, '' Port_of_Discharge, 

       '' NameOfVessel,

       null ShipOnBoard, '' Packing, '', 0, @IDUser, 0 IsLokal

From DBSPB A

     left Outer join (Select y.NoBukti, y.NoSPP

                      from dbSPBDet y

                      group by y.NoBukti, y.NoSPP) SPBDet on SPBDet.NoBukti=A.NoBukti

     left Outer join (Select x.NoBukti, x.Tanggal, y.NoSPB

                      from dbInvoicePL x

                           left Outer join dbInvoicePLDet y on y.NoBukti=x.NoBukti

                      group by x.NoBukti, x.Tanggal, y.NoSPB) B on B.NoSPB=A.NoBukti     

     left outer join (Select x.NoBukti, x.Tanggal, y.NoSO

                      from dbSPP x

                           left Outer join dbSPPDet y on y.NoBukti=x.NoBukti

                      Group by x.NoBukti, x.Tanggal, y.NoSO)D on D.NoBukti=A.NoSPP

left Outer join dbSO C On C.Nobukti=D.NoSO

where A.NoBukti=@NoSPB and B.NoSPB is null     



if @@error<>0  goto jikasalah



insert into dbInvoicePLDet (NoBukti, Urut, NoSPB, UrutSPB, KodeBrg, Namabrg, PPN, DISC, KURS, 

Qnt, Qnt2, Sat_1, Sat_2, NoSat, Isi, NetW, GrossW, Meas, Harga, DiscP, DiscRp, DiscTot, ShippingMark)

Select @NoBukti,A.Urut, A.Nobukti, A.Urut, A.Kodebrg, A.Namabrg, D.PPn, 0, D.Kurs,

       C.Qnt, C.Qnt2, A.Sat_1, A.Sat_2, A.Nosat, A.Isi, A.NetW, A.GrossW, 0 Mesurement, D.Harga, 0 DiscP, 0 DiscRp,

       0 DiscRp , '' ShippingMark

from dbSPBDet A

     Left Outer join dbInvoicePLDet B on B.NoSPB=A.Nobukti and B.UrutSPB=A.Urut

     Left Outer Join (Select x.NoSO,x.UrutSO, SUM(y.QNT) Qnt, SUM(y.qnt2) Qnt2,

                             sum(y.NetW) NetW, SUM(y.GrossW) GrossW, SUM(x.Mesurement) Mesurement,x.NoBukti, z.IsClose,x.Urut

                      from dbSPPDet x

                           left Outer Join dbSPBDet y on y.NoSPP=x.NoBukti and y.UrutSPP=x.Urut

                           left Outer join dbSPP z on z.NoBukti=x.NoBukti

                           /*Left Outer join (Select x.NoSPB, x.UrutSPB, sum(Qnt) QntRSPB, sum(Qnt2) Qnt2RSPB, 

                                                   SUM(x.NetW) NetWRSPB, SUM(x.GrossW) GrossWRSPB

                                            from DBRSPBDet x

                                            Group by  x.NoSPB, x.UrutSPB) z1 on z1.NoSPB=y.NoBukti and z1.UrutSPB=y.Urut*/

                      group by x.NoSo, x.UrutSo, x.NoBukti, z.IsClose, x.Urut) C on C.NoBukti=A.NoSPP and C.Urut=A.UrutSPP

     left Outer join (Select x.Nobukti,y.Urut, x.PPn, x.Kurs,y.Harga

                      from DBSO x

                           left Outer join DBSODET y on y.Nobukti=x.Nobukti) D on D.Nobukti=C.NoSO and D.Urut=c.UrutSO                                                 

where A.Nobukti=@NoSPB and B.NoBukti is null 

Order by A.Nobukti, A.Urut         

if @@error<>0  goto jikasalah



Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- sp_InsertOutstandingPO
CREATE PROCEDURE IF NOT EXISTS sp_InsertOutstandingPO AS tran



-- DECLARE REMOVED



--exec sp_RefreshOutPO @NoPO



--if @@error<>0  goto jikasalah



--select * from DBBELI



insert into dbBeli (NOBUKTI, NOURUT, TANGGAL, TglJatuhTempo, KODESUPP, HANDLING, KodeExp, KETERANGAN, 

	FAKTURSUPP, KODEVLS, KURS, PPN, TIPEBAYAR, HARI, TipeDisc, DISC, DISCRP, ISCETAK, NilaiCetak,Tf,Do)	

select 	distinct @NoBukti, @NoUrut, @Tanggal, @Tanggal+A.Hari, A.KodeSupp, 0.00 Handling, '' KodeExp, @Keterangan, 

	@FakturSupp, A.KodeVls, A.Kurs, A.PPN, A.TipeBayar, A.Hari, A.TipeDisc, A.Disc, A.DiscRp, 0 IsCetak, 0 NilaiCetak,0,'I'

from 	dbPO A

where	A.NoBukti=@NoPO



if @@error<>0  goto jikasalah



insert into dbBeliDet (NOBUKTI, URUT, KODEBRG, KodeGdg, PPN, DISC, QNT, 

	NOSAT, SATUAN, ISI, HARGA, DISCP, DISCTOT, BYANGKUT, NoPO, UrutPO, 

	QntTerima, Qnt1Terima, Qnt2Terima,KURS,NamaBrg,Tf,Do)

select 	@NoBukti NoBukti, T.Urut, T.KodeBrg, @KodeGdg, B.PPN, B.Disc, T.QntTerima Qnt,

	T.NoSat, T.Satuan, T.Isi, T.Harga, T.DiscP, T.DiscTot, 0.00 ByAngkut, T.NoBukti, T.Urut, 

	T.QntTerima, case when NOSAT=1 then T.QntTerima else T.QntTerima*Br.ISI2 , 

	case when NOSAT=1 then T.QntTerima/Br.ISI2 else T.QntTerima , b.KURS,T.NAMABRG ,0,'I'

from dbPO B

left outer join TempOutstandingPO T on T.NoBukti=B.NoBukti

left outer join DBBARANG Br on Br.KODEBRG=T.KODEBRG

where 	B.NoBukti=@NoPO and T.IsTerima=1 and T.QntTerima<>0

order by T.Urut



exec [sp_UpdateTransaksiPPN] 'dbBeliDet','dbBeli',@NoBukti



if @@error<>0  goto jikasalah



Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- sp_InsertOutstandingPO_
CREATE PROCEDURE IF NOT EXISTS sp_InsertOutstandingPO_ AS tran



-- DECLARE REMOVED



--exec sp_RefreshOutPO @NoPO



--if @@error<>0  goto jikasalah



--select * from DBBELI



insert into dbBeli (Devisi,NOBUKTI, NOURUT, TANGGAL, TglJatuhTempo, KODESUPP, HANDLING, KodeExp, KETERANGAN, 

	FAKTURSUPP, KODEVLS, KURS, PPN, TIPEBAYAR, HARI, TipeDisc, DISC, DISCRP, ISCETAK, NilaiCetak)	

select 	distinct Devisi,@NoBukti, @NoUrut, @Tanggal, @Tanggal+A.Hari, A.KodeSupp, 0.00 Handling, '' KodeExp, @Keterangan, 

	@FakturSupp, A.KodeVls, A.Kurs, A.PPN, A.TipeBayar, A.Hari, A.TipeDisc, A.Disc, A.DiscRp, 0 IsCetak, 0 NilaiCetak 

from 	dbPO A

where	A.NoBukti=@NoPO



if @@error<>0  goto jikasalah



insert into dbBeliDet (NOBUKTI, URUT, KODEBRG, KodeGdg, PPN, DISC, QNT, 

	NOSAT, SATUAN, ISI, HARGA, DISCP, DISCTOT, BYANGKUT, NoPO, UrutPO, 

	QntTerima_, Qnt1Terima_, Qnt2Terima_, QntTerima, Qnt1Terima, Qnt2Terima,KURS,NamaBrg)

select 	@NoBukti NoBukti, T.Urut, T.KodeBrg, @KodeGdg, B.PPN, B.Disc, T.QntTerima Qnt,

	T.NoSat, T.Satuan, T.Isi, T.Harga, T.DiscP, T.DiscTot, 0.00 ByAngkut, T.NoBukti, T.Urut, 

	T.QntTerima, case when NOSAT=1 then T.QntTerima else T.QntTerima*Br.ISI2 , 

	case when NOSAT=1 then T.QntTerima/Case When Br.ISI2=0 Then 1 else Br.ISI2  else T.QntTerima , 

	T.QntTerima, case when NOSAT=1 then T.QntTerima else T.QntTerima*Br.ISI2 , 

	case when NOSAT=1 then T.QntTerima/Case When Br.ISI2=0 Then 1 else Br.ISI2  else T.QntTerima , b.KURS,T.NAMABRG 

from dbPO B

left outer join TempOutstandingPO T on T.NoBukti=B.NoBukti

left outer join DBBARANG Br on Br.KODEBRG=T.KODEBRG

where 	B.NoBukti=@NoPO and T.IsTerima=1 and T.QntTerima<>0

order by T.Urut



exec [sp_UpdateTransaksiPPN] 'dbBeliDet','dbBeli',@NoBukti


if @@error<>0  goto jikasalah



Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- sp_InvBeli
CREATE PROCEDURE IF NOT EXISTS sp_InvBeli AS -- DECLARE REMOVED,@NoUrutPB varchar(10)='',@Tanggal datetime=0,@Kodegdg varchar(15),@KodeBrg varchar(25)='',

  @Qnt numeric(18,2)=0,@NoSat TINYINT=0,@Sat varchar(5)='',@Isi numeric(18,2)=0,@NoBppB Varchar(50),@Qnt2 numeric(18,2)=0,

  @UrutSPK int=0,@NoSatSPK TINYINT=0,@IsSampel INTEGER,@KdDep Varchar(20)='',@NoPOL Varchar(50)='',@Supir Varchar(100)='',

  @KetBrg varchar(200)='',@Devisi Varchar(15)='',@BlTh varchar(8),@s varchar(7)

tran



if @Choice='I'

select 1


if @Choice='U'

Update DBBELIDET set KURS=b.KURS from DBBELIDET a

  Left Outer Join DBBELI b on a.NOBUKTI=b.NOBUKTI

  where b.NOBUKTI=@NoBukti

  

  update dbBeliDET set HARGA=@Harga, DISCP=@DiscP, DISCTOT=@DiscTot,Perkiraan=@Perkiraan

  where NoBukti=@NoBukti and Urut=@Urut

  /*

  if (COALESCE(@Perkiraan,'')<>'' and COALESCE(@Perkiraan,'')<>'-')

  select @Tanggal=b.TANGGAL,@Kodegdg=a.KodeGdg,@KodeBrg=a.KODEBRG,@Qnt=Qnt1Terima,@Qnt2=Qnt2Terima,@NoSat=a.NOSAT,

    @Sat=a.SATUAN,@Isi=a.ISI,@Devisi=b.Devisi from DBBELIDET a

    left outer join DBBELI b on b.NOBUKTI=a.NOBUKTI

    where a.NOBUKTI=@NoBukti and a.URUT=@Urut and a.kodebrg not like '%TPS%' 

  

    if not Exists(select 1 from DBPenyerahanBhn  where NoBPPB=@NoBukti and NoJurnal=@Perkiraan) 

    Select @NoUrutPB=MAX(Cast(nourut as int))+1 from DBPenyerahanBhn where month(tanggal)=month(@Tanggal) and year(tanggal)=year(@Tanggal) and ((Nobukti like 'BCA/%' and @Devisi='01') or (Nobukti like 'CA/%' and @Devisi='02'))

     if MONTH(@Tanggal)<10 

     select @BlTh='/0'+cast(MONTH(@Tanggal) as varchar(2))+SUBSTR(cast(year(@Tanggal) as varchar(4)), LENGTH(cast(year(@Tanggal) as varchar(4)))-2+1)+'/'

     

     else

     select @BlTh='/'+cast(MONTH(@Tanggal) as varchar(2))+SUBSTR(cast(year(@Tanggal) as varchar(4)), LENGTH(cast(year(@Tanggal) as varchar(4)))-2+1)+'/'

     

     select @s='0000'

     -- SET REMOVEDSUBSTRING(@s,1,LEN(@s)-LEN(Cast(COALESCE(@NoUrutPB,0) as varchar(4))))+Cast(COALESCE(@NoUrutPB,0) as varchar(4))

     select @NoBuktiPB=case when @Devisi='01' then 'BCA' else 'CA' +'/BP'+@BlTh+@s

  

     exec sp_PenyerahanBhn 'I',@NoBuktiPB,@NoUrutPB,@Tanggal,@Kodegdg,@Urut,@KodeBrg,@Qnt,@NoSat,

     @Sat,@Isi,@NoBukti,@Qnt2,0,0,0,'-',@Perkiraan,'',

     '','Dibiayakan',@Devisi,@Harga

      

    -- IF EXISTS REMOVED
<>'' or COALESCE(NoJurnal,'')<>'-'))

    if not Exists(select 1 from DBPenyerahanBhnDET  where Nobukti in (select Nobukti from DBPenyerahanBhn where NoBPPB=@NoBukti and NoJurnal=@Perkiraan) and urut=@Urut)

      select @NoBuktiPB=Nobukti,@NoUrutPB=Nourut from DBPenyerahanBhn  where NoBPPB=@NoBukti and NoJurnal=@Perkiraan

        exec sp_PenyerahanBhn 'I',@NoBuktiPB,@NoUrutPB,@Tanggal,@Kodegdg,@Urut,@KodeBrg,@Qnt,@NoSat,

        @Sat,@Isi,@NoBukti,@Qnt2,0,0,0,'-',@Perkiraan,'',

        '','Dibiayakan',@Devisi,@Harga

      

      -- IF EXISTS REMOVED
and urut=@Urut)

      select @NoBuktiPB=Nobukti,@NoUrutPB=Nourut from DBPenyerahanBhn  where NoBPPB=@NoBukti and NoJurnal=@Perkiraan

        exec sp_PenyerahanBhn 'U',@NoBuktiPB,@NoUrutPB,@Tanggal,@Kodegdg,@Urut,@KodeBrg,@Qnt,@NoSat,

        @Sat,@Isi,@NoBukti,@Qnt2,0,0,0,'-',@Perkiraan,'',

        '','Dibiayakan',@Devisi,@Harga


    if not Exists(select 1 from DBPenyerahanBhn  where NoBPPB=@NoBukti and NoJurnal=@Perkiraan and (COALESCE(NoJurnal,'')<>'' or COALESCE(NoJurnal,'')<>'-'))

    select @NoBuktiPB=Nobukti,@NoUrutPB=Nourut from DBPenyerahanBhn  where NoBPPB=@NoBukti

      exec sp_PenyerahanBhn 'D',@NoBuktiPB,@NoUrutPB,@Tanggal,@Kodegdg,@Urut,@KodeBrg,@Qnt,@NoSat,

      @Sat,@Isi,@NoBukti,@Qnt2,0,0,0,'-',@Perkiraan,'',

      '','Dibiayakan',@Devisi,@Harga

      

     Select @NoUrutPB=MAX(Cast(nourut as int))+1 from DBPenyerahanBhn where month(tanggal)=month(@Tanggal) and year(tanggal)=year(@Tanggal) and ((Nobukti like 'BCA/%' and @Devisi='01') or (Nobukti like 'CA/%' and @Devisi='02'))

     if MONTH(@Tanggal)<10 

     select @BlTh='/0'+cast(MONTH(@Tanggal) as varchar(2))+SUBSTR(cast(year(@Tanggal) as varchar(4)), LENGTH(cast(year(@Tanggal) as varchar(4)))-2+1)+'/'

     

     else

     select @BlTh='/'+cast(MONTH(@Tanggal) as varchar(2))+SUBSTR(cast(year(@Tanggal) as varchar(4)), LENGTH(cast(year(@Tanggal) as varchar(4)))-2+1)+'/'

     

     select @s='0000'

     -- SET REMOVEDSUBSTRING(@s,1,LEN(@s)-LEN(Cast(COALESCE(@NoUrutPB,0) as varchar(4))))+Cast(COALESCE(@NoUrutPB,0) as varchar(4))

     select @NoBuktiPB=case when @Devisi='01' then 'BCA' else 'CA' +'/BP'+@BlTh+@s        

      exec sp_PenyerahanBhn 'I',@NoBuktiPB,@NoUrutPB,@Tanggal,@Kodegdg,@Urut,@KodeBrg,@Qnt,@NoSat,

      @Sat,@Isi,@NoBukti,@Qnt2,0,0,0,'-',@Perkiraan,'',

      '','Dibiayakan',@Devisi,@Harga


  if COALESCE(@Perkiraan,'')='-'

  select @KodeBrg=a.KODEBRG,@Qnt=Qnt1Terima from DBBELIDET a

    left outer join DBBELI b on b.NOBUKTI=a.NOBUKTI

    where a.NOBUKTI=@NoBukti and a.URUT=@Urut

    

    select @NoBuktiPB=a.Nobukti,@NoUrutPB=a.Nourut 

    from DBPenyerahanBhn a

    left outer join DBPenyerahanBhnDET b on b.Nobukti=a.Nobukti  

    where a.NoBPPB=@NoBukti and b.urut=@Urut and b.kodebrg=@KodeBrg and b.Qnt=@Qnt and b.Harga=@Harga

     

    exec sp_PenyerahanBhn 'D',@NoBuktiPB,@NoUrutPB,@Tanggal,@Kodegdg,@Urut,@KodeBrg,@Qnt,@NoSat,

    @Sat,@Isi,@NoBukti,@Qnt2,0,0,0,'-',@Perkiraan,'',

    '','Dibiayakan',@Devisi,@Harga

    

  */

  if @@error<>0  goto jikasalah


if @Choice='D'

select 1



---- IF EXISTS REMOVED
-- --   Update DBBELI Set NILAIDPP=(select SUM(NDPP)NDPP from DBBELIDET where NOBUKTI=DBBELI.NOBUKTI),

--                     NILAINET=(select SUM(NNET)NNET from DBBELIDET where NOBUKTI=DBBELI.NOBUKTI),

--                     NILAIPPN=(select SUM(NPPN)NPPN from DBBELIDET where NOBUKTI=DBBELI.NOBUKTI)

--   where NOBUKTI=@NoBukti                  

--  

--if @@error<>0  goto jikasalah

Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- Sp_Invoice
CREATE PROCEDURE IF NOT EXISTS Sp_Invoice AS tran

if @Choice='I'

select @Urut=COALESCE(max(urut),0)+1 from dbInvoiceDet Where NoBukti=@NoBukti

  if not exists(select * from dbInvoice Where NoBukti=@NoBukti) 

  insert into dbInvoice (NOBUKTI, TANGGAL, KETERANGAN,KodeSupp,NoPO,NoFaktur,TglFaktur,KodeVls,Kurs,PPN,TipeBayar,Hari)

    values (@NOBUKTI, @TANGGAL, @KETERANGAN,@KodeSupp,@NoPO,@NoFaktur,@TglFaktur,@KodeVls,@Kurs,@PPN,@TipeBayar,@Hari)

  

  insert into dbInvoiceDET (NOBUKTI, URUT,NoBeli)

  values(@NOBUKTI, @URUT,@NoBeli)



if @Choice='U'

update dbInvoiceDET set NoBeli=@NoBeli 

  where NoBukti=@NoBukti and Urut=@Urut


if @Choice='D'

delete dbInvoiceDET where NoBukti=@NoBukti and Urut=@Urut 

  if not exists( select NoBukti from dbInvoiceDET where NoBukti=@NoBukti)

  delete dbInvoice where NoBukti=@NoBukti


if @@error<>0  goto jikasalah

Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- SP_InvoicePLLampiran
CREATE PROCEDURE IF NOT EXISTS SP_InvoicePLLampiran AS tran

if @Choice='I'

Select @urut=urut from DBInvoicePLLampiran where Nobukti=@Nobukti

  -- SET REMOVEDISNULL(@urut,0)+1

  insert into DBInvoicePLLampiran(Nobukti,Urut,Keterangan,KodeVls,Kurs,Qnt,Qnt2,Nosat,Sat_1,Sat_2, Harga)

  Values (@Nobukti,@urut,@Keterangan,@KodeVls, @Kurs,@Qnt,@Qnt2,@Nosat,@Sat_1,@Sat_2, @Harga)



else if @Choice='U'

update DBInvoicePLLampiran set Keterangan=@Keterangan, KodeVls=@KodeVls, Kurs=@Kurs,Qnt=@Qnt,Qnt2=@Qnt2,

                                 Nosat=@Nosat,Sat_1=@Sat_1,Sat_2=@Sat_2, Harga=@Harga

  where Nobukti=@Nobukti and Urut=@urut



else if @Choice='D'

delete from DBInvoicePLLampiran 

  where Nobukti=@Nobukti and Urut=@urut



if @@ERROR<>0 Goto JikaSalah

Commit Tran

Return

JikaSalah: Rollback Tran

           Return;

-- Sp_InvoiceRetensi
CREATE PROCEDURE IF NOT EXISTS Sp_InvoiceRetensi AS tran

if @Choice='I'

if not exists(select * from [dbInvoicePLRetensi] Where NoBukti=@NoBukti) 

  insert into [dbInvoicePLRetensi] (NOBUKTI,NoUrut, TANGGAL, KETERANGAN,NoInvoice)

    values (@NOBUKTI,@NoUrut, @TANGGAL, @KETERANGAN,@NoBeli)

  

 Update [dbInvoicePLRetensi] set SubTotal=SUBTOTALRp*FRetensi/100,TDPP=NDPPRp*FRetensi/100,TNPPN=NPPNRp*FRetensi/100,TNNET=NNETRRp*FRetensi/100 from [dbInvoicePLRetensi] a

 Left Outer Join (select NoBukti,SUM(SUBTOTALRp)SUBTOTALRp,SUM(NDPPRp)NDPPRp,SUM(NPPNRp)NPPNRp,SUM(NNETRRp)NNETRRp,FRetensi

 from dbInvoicePLDet where NoBukti=@NoBeli

 Group By NoBukti,FRetensi) b on a.NoInvoice=b.NoBukti

 where a.NoBukti=@NoBukti

 --------------------

 if Not exists(Select NOBUKTI from DBJurnalOto where NOBUKTI=@NoBukti)

   Insert into DBO.dbJurnalOTO(NoBukti, Tanggal, Devisi, Note, Lampiran, IsOtorisasi1, OtoUser1, TglOto1, Urut, Perkiraan, Lawan, Keterangan, Keterangan2, Debet, Kredit, Valas, Kurs, DebetRp, KreditRp, TipeTrans, TPHC, 

                                CustSuppP, CustSuppL, KodeP, KodeL, NoAktivaP, NoAktivaL, StatusAktivaP, StatusAktivaL, Nobon, KodeBag, StatusGiro,  Jenis, NOURUT)

    Select  NOBUKTI, TANGGAL, DEVISI, NOTE, LAMPIRAN, 1, 'SA', datetime('now'), 

            CAST(ROW_NUMBER() Over(PARTITION BY NoBukti Order by NoBukti) As int) URUT, 

            PERKIRAAN, LAWAN, KETERANGAN, KETERANGAN2, DEBET, KREDIT, VALAS, 

            KURS, DEBETRP, KREDITRP, TIPETRANS, TPHC, CUSTSUPPP, CUSTSUPPL, KODEP, KODEL, NOAKTIVAP, NOAKTIVAL, STATUSAKTIVAP, STATUSAKTIVAL, NOBON, 

            KODEBAG, STATUSGIRO,  JENIS, NOURUT

    From [fnc_JurnalPenjualanRetensi](@nobukti)  


    ---------------

   if Not exists(Select NOBUKTI from DBHUTPIUT where NoFaktur=@NoBukti)

   Insert into dbo.DBHUTPIUT(NoFaktur, NoRetur, TipeTrans, KodeCustSupp, NoBukti, NoMsk, Urut, Tanggal, JatuhTempo, 

                              Debet, Kredit,  Valas, Kurs, DebetD, KreditD, 

                              KodeSales, Tipe, Perkiraan, Catatan, NOINVOICE,  KodeVls_, Kurs_,Devisi)

    Select  NoFaktur, NoRetur, Tipetrans, KODECUSTSUPP, Nobukti, NoMsk, urut, TANGGAL, JatuhTempo, 

            Debet, Kredit,  Valas, KURS, 

            Case when Valas='IDR' then 0.00 else DebetD  DebetD,  

            Case when Valas='IDR' then 0.00 else KreditD  KreditD, 

                      KodeSales, Tipe, PERKIRAAN, Catatan, NoInvoice, KodeVls_, Kurs_,DEVISI

    from Dbo.fnc_PostPenjualanRetensi(@nobukti)    

  

 ----------------



if @Choice='U'

update [dbInvoicePLRetensi] set KETERANGAN=@Keterangan,Tanggal=@Tanggal

  where NoBukti=@NoBukti 

   ---------------------------

   delete DBJurnalOto where NoBukti=@NoBukti

  -- if Not exists(Select NOBUKTI from DBJurnalOto where NOBUKTI=@NoBukti)

   Insert into DBO.dbJurnalOTO(NoBukti, Tanggal, Devisi, Note, Lampiran, IsOtorisasi1, OtoUser1, TglOto1, Urut, Perkiraan, Lawan, Keterangan, Keterangan2, Debet, Kredit, Valas, Kurs, DebetRp, KreditRp, TipeTrans, TPHC, 

                                CustSuppP, CustSuppL, KodeP, KodeL, NoAktivaP, NoAktivaL, StatusAktivaP, StatusAktivaL, Nobon, KodeBag, StatusGiro,  Jenis, NOURUT)

    Select  NOBUKTI, TANGGAL, DEVISI, NOTE, LAMPIRAN, 1, 'SA', datetime('now'), 

            CAST(ROW_NUMBER() Over(PARTITION BY NoBukti Order by NoBukti) As int) URUT, 

            PERKIRAAN, LAWAN, KETERANGAN, KETERANGAN2, DEBET, KREDIT, VALAS, 

            KURS, DEBETRP, KREDITRP, TIPETRANS, TPHC, CUSTSUPPP, CUSTSUPPL, KODEP, KODEL, NOAKTIVAP, NOAKTIVAL, STATUSAKTIVAP, STATUSAKTIVAL, NOBON, 

            KODEBAG, STATUSGIRO,  JENIS, NOURUT

    From [fnc_JurnalPenjualanRetensi](@nobukti)  


    ---------------

   delete DBHUTPIUT where NoFaktur=@NoBukti and TipeTrans='T' 

  -- if Not exists(Select NOBUKTI from DBHUTPIUT where NoFaktur=@NoBukti)

   Insert into dbo.DBHUTPIUT(NoFaktur, NoRetur, TipeTrans, KodeCustSupp, NoBukti, NoMsk, Urut, Tanggal, JatuhTempo, 

                              Debet, Kredit,  Valas, Kurs, DebetD, KreditD, 

                              KodeSales, Tipe, Perkiraan, Catatan, NOINVOICE,  KodeVls_, Kurs_,Devisi)

    Select  NoFaktur, NoRetur, Tipetrans, KODECUSTSUPP, Nobukti, NoMsk, urut, TANGGAL, JatuhTempo, 

            Debet, Kredit,  Valas, KURS, 

            Case when Valas='IDR' then 0.00 else DebetD  DebetD,  

            Case when Valas='IDR' then 0.00 else KreditD  KreditD, 

                      KodeSales, Tipe, PERKIRAAN, Catatan, NoInvoice, KodeVls_, Kurs_,DEVISI

    from Dbo.fnc_PostPenjualanRetensi(@nobukti)    

  

 ----------------


if @Choice='D'

delete [dbInvoicePLRetensi] where NoBukti=@NoBukti

     delete DBJurnalOto where NoBukti=@NoBukti

     delete DBHUTPIUT where NoFaktur=@NoBukti and TipeTrans='T' 



if @@error<>0  goto jikasalah

Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- SP_InvoiceRPJ
CREATE PROCEDURE IF NOT EXISTS SP_InvoiceRPJ AS Tran

if @Choice='I'

Select @urut=MAX(Urut) from DBINVOICERPJDet where NoBukti=@Nobukti

  -- SET REMOVEDISNULL(@urut,0)+1

  if not Exists(Select 'True' From DBINVOICERPJ where NoBukti=@Nobukti) 

  insert into DBINVOICERPJ (Devisi,NoBukti, NoUrut, Tanggal, TglJatuhTempo, KODECUSTSUPP, NoInvoice, TglInvoice, NORPJ, KODEVLS, KURS, PPN, TIPEBAYAR, HARI, IDUser, IsFLag) 

    Values(@Devisi,@Nobukti, @NoUrut, @Tanggal, @Tanggal+@Hari, @Kodecustsupp, @NoInvoice, @TglInvoice, @NoRPJ,@KODEVLS, @Kurs, @PPn, @TipeBayar, @Hari, @Iduser, @Flagmenu)  

  

  Insert into DBINVOICERPJDet(NoBukti, Urut, Kodebrg, NOSPR, UrutSPR, Disc, PPn, Kurs, SAT_1, SAT_2, Qnt, Qnt2, Nosat, Isi, Harga, DiscP, DiscRp, DISCTOT, Keterangan,NamaBrg)

  Values(@Nobukti, @Urut, @kodebrg, @NoRPJ, @urutRPJ, 0, @PPn, @Kurs, @Sat_1, @Sat_2, @Qnt, @qnt2, @Nosat, @Isi, @Harga, @DiscP, @DiscRp, @DiscTot, @Keterangan,@NamaBrg)



else if @Choice='U'

update DBINVOICERPJDet set Kodebrg=@kodebrg, NOSPR=@NoRPJ, UrutSPR=@urutRPJ, Disc=0, PPn=@PPn, 

                             Kurs=@Kurs, SAT_1=@Sat_1, SAT_2=@Sat_2, Qnt=@qnt, Qnt2=@qnt2, Nosat=@Nosat, 

                             Isi=@Isi, Harga=@Harga, DiscP=@DiscP, DiscRp=@DiscRp, DISCTOT=@DiscTot, Keterangan=@Keterangan,NamaBrg=@NamaBrg

  where NoBukti=@Nobukti and Urut=@urut


else if @Choice='D'

Delete DBINVOICERPJDet where NoBukti=@Nobukti and Urut=@urut

  if not Exists(Select 'True' From DBINVOICERPJDet where NoBukti=@Nobukti) 

  Delete DBINVOICERPJ where NoBukti=@Nobukti 


if @@ERROR<>0 Goto JikaSalah

Commit Tran

Return

JikaSalah: Rollback Tran

           Return;

-- sp_InvRBeli
CREATE PROCEDURE IF NOT EXISTS sp_InvRBeli AS tran



if @Choice='I'

select 1


if @Choice='U'

update dbRBeliDET set HARGA=@Harga, DISCP=@DiscP, DISCTOT=@DiscTot

  where NoBukti=@NoBukti and Urut=@Urut

  if @@error<>0  goto jikasalah


if @Choice='D'

select 1



---- IF EXISTS REMOVED
-- --   Update DBBELI Set NILAIDPP=(select SUM(NDPP)NDPP from DBBELIDET where NOBUKTI=DBBELI.NOBUKTI),

--                     NILAINET=(select SUM(NNET)NNET from DBBELIDET where NOBUKTI=DBBELI.NOBUKTI),

--                     NILAIPPN=(select SUM(NPPN)NPPN from DBBELIDET where NOBUKTI=DBBELI.NOBUKTI)

--   where NOBUKTI=@NoBukti                  

--  

--if @@error<>0  goto jikasalah

Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- sp_IsPerkiraanIntoNeraca
CREATE PROCEDURE IF NOT EXISTS sp_IsPerkiraanIntoNeraca AS insert into dbneraca(Perkiraan,bulan,tahun,devisi)

select @perkiraan,@bulan,@tahun,devisi

from dbdevisi 

where devisi not in (select devisi from dbneraca where perkiraan=@perkiraan and bulan=@bulan and tahun=@tahun);

-- Sp_Jabatan
CREATE PROCEDURE IF NOT EXISTS Sp_Jabatan AS tran

if @choice='I'

insert into dbJabatan (KodeJab, NamaJab)

	values (@KodeJab, @NamaJab)

	if @@error <> 0 goto jikasalah



if @choice='U'

update dbJabatan set NamaJab=@NamaJab,KodeJab=@KodeJab

             where KodeJab=@OldKode

	if @@error <> 0 goto jikasalah



if @choice='D'

delete  dbJabatan where KodeJab=@OldKode

	if @@error <> 0 goto jikasalah



commit tran

return

jikasalah:

	rollback tran

	raiserror('Proses Input Data Gagal',16,1)

	return;

-- Sp_JenisCust
CREATE PROCEDURE IF NOT EXISTS Sp_JenisCust AS tran

if @choice='I'

insert into dbJenisCustSupp (Kodejenis, NamaJenis)

  values (@KodeJenis, @NamaJenis)

  if @@error <> 0 goto jikasalah



else

if @choice='U'

update DbJenisCustSupp 

    set Namajenis=@NamaJenis

    where Kodejenis=@KodeJenis

    if @@error <> 0

     goto jikasalah



if @choice='D'

delete DbjenisCustSupp 

   where KodeJenis=@KodeJenis

   

   if @@error <> 0 goto jikasalah



commit tran

return

jikasalah:

	rollback tran

	raiserror('Proses Input Data Gagal',16,1)

	return;

-- sp_JenisKend
CREATE PROCEDURE IF NOT EXISTS sp_JenisKend AS tran

if @choice='I'

insert into DBJENISKEND (KODEJENISKEND, NAMAJENISKEND,Tf,Do)

	values (@KODEJENISKEND, @NAMAJENISKEND,0,@choice)

	if @@error <> 0 goto jikasalah



if @choice='U'

update DBJENISKEND set NAMAJENISKEND=@NAMAJENISKEND,Tf=0,Do=@Choice

    where KODEJENISKEND=@KODEJENISKEND

	if @@error <> 0 goto jikasalah



if @choice='D'

delete  DBJENISKEND where KODEJENISKEND=@KODEJENISKEND

	insert TempDelData

    select @KODEJENISKEND,'DBJENISKEND'

	if @@error <> 0 goto jikasalah



commit tran

return

jikasalah:

	rollback tran

	raiserror('Proses Input Data Gagal',16,1)

	return;

-- Sp_JnsBarang
CREATE PROCEDURE IF NOT EXISTS Sp_JnsBarang AS tran

if @choice='I'

insert into dbJenis (KodeJnsBrg, Keterangan)

	values (@KodeJnsBrg, @Keterangan)

	if @@error <> 0 goto jikasalah



if @choice='U'

update dbJenis set Keterangan=@Keterangan ,KodeJnsBrg=@KodeJnsbrg

             where KodeJnsBrg=@OldKode

	if @@error <> 0 goto jikasalah



if @choice='D'

delete  dbJenis where KodeJnsBrg=@OldKode

	if @@error <> 0 goto jikasalah



commit tran

return

jikasalah:

	rollback tran

	raiserror('Proses Input Data Gagal',16,1)

	return;

-- Sp_JnsBarangBrgJadi
CREATE PROCEDURE IF NOT EXISTS Sp_JnsBarangBrgJadi AS tran

if @choice='I'

insert into DBJENISBRGJADI (KodeJnsBrg, Keterangan)

	values (@KodeJnsBrg, @Keterangan)

	if @@error <> 0 goto jikasalah



if @choice='U'

update DBJENISBRGJADI set Keterangan=@Keterangan ,KodeJnsBrg=@KodeJnsbrg

             where KodeJnsBrg=@OldKode

	if @@error <> 0 goto jikasalah



if @choice='D'

delete  DBJENISBRGJADI where KodeJnsBrg=@OldKode

	if @@error <> 0 goto jikasalah



commit tran

return

jikasalah:

	rollback tran

	raiserror('Proses Input Data Gagal',16,1)

	return;

-- Sp_JnsPakai
CREATE PROCEDURE IF NOT EXISTS Sp_JnsPakai AS tran

if @choice='I'

insert into dbJnsPakai (KodeJnsPakai, Keterangan)

	values (@KodeJnsPakai, @Keterangan)

	if @@error <> 0 goto jikasalah



if @choice='U'

update dbJnsPakai set Keterangan=@Keterangan ,KodeJnsPakai=@KodeJnsPakai

             where KodeJnsPakai=@OldKode

	if @@error <> 0 goto jikasalah



if @choice='D'

delete  dbJnsPakai where KodeJnsPakai=@OldKode

	if @@error <> 0 goto jikasalah



commit tran

return

jikasalah:

	rollback tran

	raiserror('Proses Input Data Gagal',16,1)

	return;

-- Sp_Kelompok
CREATE PROCEDURE IF NOT EXISTS Sp_Kelompok AS tran

if @choice='I'

insert into dbKelompok (KodeKelompok, Keterangan, Perkiraan)

	values (@KodeKelompok, @Keterangan, @Perkiraan)

	if @@error <> 0 goto jikasalah



if @choice='U'

update dbKelompok set Keterangan=@Keterangan ,KodeKelompok=@KodeKelompok, Perkiraan=@Perkiraan

             where KodeKelompok=@OldKode

	if @@error <> 0 goto jikasalah



if @choice='D'

delete  dbKelompok where KodeKelompok=@OldKode

	if @@error <> 0 goto jikasalah



commit tran

return

jikasalah:

	rollback tran

	raiserror('Proses Input Data Gagal',16,1)

	return;

-- sp_Kendaraan
CREATE PROCEDURE IF NOT EXISTS sp_Kendaraan AS tran

if @choice='I'

insert into DBKENDARAAN (KODEKEND, KODEJENISKEND, NAMAKEND,Tf,Do)

	values (@KODEKEND, @KODEJENISKEND, @NAMAKEND,0,@choice)

	if @@error <> 0 goto jikasalah



if @choice='U'

update DBKENDARAAN set KODEKEND=@KODEKEND,KODEJENISKEND=@KODEJENISKEND, NAMAKEND=@NAMAKEND,Tf=0,Do=@Choice

    where KODEKEND=@OldKode and NAMAKEND=@OldKodeNama

	if @@error <> 0 goto jikasalah



if @choice='D'

delete  DBKENDARAAN where KODEKEND=@OldKode and NAMAKEND=@OldKodeNama

	select @OldKode,'DBKENDARAAN'

	if @@error <> 0 goto jikasalah



commit tran

return

jikasalah:

	rollback tran

	raiserror('Proses Input Data Gagal',16,1)

	return;

-- sp_Kiriman
CREATE PROCEDURE IF NOT EXISTS sp_Kiriman AS tran

if @Choice='I'

insert into [DBKirimDET] (NOBUKTI,KODEBRG, TANGGAL,Qnt)

   values (@NOBUKTI, @KODEBRG, @TANGGAL, @Qnt)



if @Choice='U'

update [DBKirimDET] set Tanggal=@Tanggal, Qnt=@QNT

  where NoBukti=@NoBukti and KodeBrg=@KodeBrg and Tanggal=@OldTanggal



if @Choice='D'

delete [DBKirimDET] where NoBukti=@NoBukti and Kodebrg=@KodeBrg and Tanggal=@OldTanggal



if @@error<>0  goto jikasalah

Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- Sp_Konsesi
CREATE PROCEDURE IF NOT EXISTS Sp_Konsesi AS tran

if @Choice='I'

select @Urut=COALESCE(max(urut),0)+1 from dbKonsesiDet Where NoBukti=@NoBukti

  	if not exists(select * from dbKonsesi Where NoBukti=@NoBukti) 

  	insert into dbKonsesi (NOBUKTI, NOURUT, TANGGAL, TglJatuhTempo, NOPBL, NOPO, KODECUSTSUPP, 

		KODEGDG, KODEVLS, KURS, PPN, TIPEBAYAR, HARI, TipeDisc, DISC, DiscRp, IDUser)

 		values (@NOBUKTI, @NoUrut, @TANGGAL, @Tanggal, @NOPBL, @NOPO, @KODECUSTSUPP, 

		@KODEGDG, @Valas, @Kurs, @PPN, @tipeBayar, 0, 0, 0, 0,  @IDUser)

		if @@error<>0  goto jikasalah

  	

	insert into dbKonsesiDET (NOBUKTI, URUT, NoPBL, UrutPBL, PPN, Disc, Kurs, KODEBRG, QNT, QNT2, Sat_1,Sat_2, Isi, Keterangan, NoIns,urutins, Harga,nosat)

	Values(@NOBUKTI, @URUT,  @NoPBL, @UrutPBL, @PPN, @Disc, @Kurs, @KODEBRG, @Qnt, @QNT2, @Sat_1,@Sat_2, @Isi, @Keterangan,  @NOINS,@UrutINS, @harga, @NoSat)

	if @@error<>0  goto jikasalah



if @Choice='U'

update dbKonsesiDET set NOPBL=@NOPBL, UrutPBL=@UrutPBL, 

		KodeBrg=@KODEBRG, Qnt=@QNT, QNT2=@QNT2, NoSat=@NoSat, Sat_1=@Sat_1, Sat_2=@Sat_2, Isi=@Isi,

		Keterangan=@Keterangan, NOiNS=@NOINS,URUTINS=@UrutINS, harga=@harga

  	where NoBukti=@NoBukti and Urut=@Urut

	if @@error<>0  goto jikasalah



if @Choice='D'

delete dbKonsesiDET where NoBukti=@NoBukti and Urut=@Urut 

	if @@error<>0  goto jikasalah

	if (not exists( select NoBukti from dbKonsesiDET where NoBukti=@NoBukti)) 

	delete dbKonsesi where NoBukti=@NoBukti

		if @@error<>0  goto jikasalah


Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- SP_KOREKSI
CREATE PROCEDURE IF NOT EXISTS SP_KOREKSI AS tran

if @choice='I'

select @urut=COALESCE(max(urut),0)+1 from DBKOREKSIdet Where NoBukti=@NoBukti

  If @urut is null -- SET REMOVED1

  if not exists(select * from DBKOREKSI Where NoBukti=@NoBukti) 

  insert into DBKOREKSI (Devisi,NOBUKTI, NOURUT, TANGGAL,KodeGdg,NOTE,IdUser)

    values (@Devisi,@NOBUKTI, @NoUrut, @TANGGAL,@KodeGdg,@NOTE,@UserID)


  insert into DBKOREKSIDET (NOBUKTI,URUT,KODEBRG,

                            SaldoComp,QntOpname,Selisih,QNTDB,QNTCR,Saldo2Comp,Qnt2Opname,Selisih2,QNT2DB,QNT2CR,HARGA, NoSat, Isi, Satuan,Keterangan,IsCek,IsCek2)

  values(@NOBUKTI,@URUT,@KODEBRG, 

         @SaldoComp,@QntOpname,@Selisih,@QNTDB,@QNTCR,@Saldo2Comp,@Qnt2Opname,@Selisih2,@QNT2DB,@QNT2CR,@HARGA, @NoSat, @Isi, @Satuan,@Keterangan,@isCek,@IsCek2)



if @choice='U'

update DBKOREKSIDET set Kodebrg=@KODEBRG, 

         SaldoComp=@SaldoComp,QntOpname=@QntOpname,Selisih=@Selisih,QntDb=@QNTDB,QntCR=@QNTCR,Harga=@HARGA,

         Saldo2Comp=@Saldo2Comp,Qnt2Opname=@Qnt2Opname,Selisih2=@Selisih2,Qnt2Db=@QNT2DB,Qnt2CR=@QNT2CR,

	NoSat=@NoSat, Isi=@Isi, Satuan=@Satuan,Keterangan=@Keterangan,IsCek=@isCek,IsCek2=@IsCek2

  where nobukti=@nobukti and urut=@urut



if @choice='D'

delete DBKOREKSIDET where nobukti=@nobukti and  urut=@urut 

  if not exists( select nobukti from DBKOREKSIDET where nobukti=@nobukti)

  delete DBKOREKSI where nobukti=@nobukti


if @@error<>0  goto jikasalah

Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- sp_koreksipersj
CREATE PROCEDURE IF NOT EXISTS sp_koreksipersj AS alter table DBKOREKSIDET disable trigger all

Update DBKOREKSIDET Set KODEBRG=c.KodeBrgA from DBKOREKSIDET a

Left Outer JOIN DBKOREKSI b on a.NOBUKTI=b.NOBUKTI

Left Outer JOIn dbSPBDet c on b.NOTE Like '%'+c.NoBukti+'%'

where c.NoBukti=@NoBukti and a.URUT=@Urut*2 and LEFT(a.NOBUKTI,3)=LEFT(c.NoBukti,3)

and COALESCE(c.isCetakKitir,0)=1

and a.KODEBRG<>c.KodeBrgA

alter table DBKOREKSIDET enable trigger all;

-- sp_koreksisj
CREATE PROCEDURE IF NOT EXISTS sp_koreksisj AS alter table DBKOREKSIDET disable trigger all

Update DBKOREKSIDET Set KODEBRG=c.KodeBrgA from DBKOREKSIDET a

Left Outer JOIN DBKOREKSI b on a.NOBUKTI=b.NOBUKTI

Left Outer JOIn dbSPBDet c on b.NOTE Like '%'+c.NoBukti+'%'

where MONTH(TANGGAL)=@Bulan and YEAR(TANGGAL)=@Tahun and a.URUT=c.Urut*2 and LEFT(a.NOBUKTI,3)=LEFT(c.NoBukti,3)

and COALESCE(c.isCetakKitir,0)=1

and a.KODEBRG<>c.KodeBrgA

alter table DBKOREKSIDET enable trigger all;

-- Sp_Kota
CREATE PROCEDURE IF NOT EXISTS Sp_Kota AS tran



if @mode='I'

insert into dbKota (kodeKota, namaKota,kodearea,Tf,Do)

    	values(@kodeKota, @namaKota,@kodearea,0,@mode)

   	if @@error <> 0

     	goto Salah



if @Mode='U'

update dbKota

     	set   namaKota= @namaKota,Kodearea=@kodearea ,Tf=0,Do=@mode

     	where KodeKota=@KodeKota



     	if @@error <> 0 

      	goto Salah 



if @Mode='D'

Delete dbKota

     	where KodeKota=@KodeKota

     

    	if @@error <> 0 

     	goto Salah


commit tran

return



Salah:

        rollback tran

        return;

-- Sp_KreditNote
CREATE PROCEDURE IF NOT EXISTS Sp_KreditNote AS tran

if @Choice='I'

select @Urut=COALESCE(max(urut),0)+1 from dbKreditNoteDet Where NoBukti=@NoBukti

  if not exists(select * from dbKreditNote Where NoBukti=@NoBukti) 

  insert into dbKreditNote (NOBUKTI, TANGGAL, KodeSupp, NoUrut)

    values (@NOBUKTI, @TANGGAL, @KodeSupp, @nourut)

  

  insert into dbKreditNoteDET (NOBUKTI, URUT,Keterangan,NoInv,Nilai, KodeVLS, Kurs, NilaiRp)

  values(@NOBUKTI, @URUT,@Keterangan,@NoInv,@Nilai,@KodeVls, @Kurs, @NilaiRp)



if @Choice='U'

update dbKreditNoteDET set NoInv=@NoInv,Keterangan=@Keterangan,Nilai=@Nilai, KodeVLS=@KodeVls,Kurs=@Kurs, NilaiRp=@NilaiRp

  where NoBukti=@NoBukti and Urut=@Urut


if @Choice='D'

delete dbKreditNoteDET where NoBukti=@NoBukti and Urut=@Urut 

  if not exists( select NoBukti from dbKreditNoteDET where NoBukti=@NoBukti)

  delete dbKreditNote where NoBukti=@NoBukti


if @@error<>0  goto jikasalah

Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- sp_LapAktiva
CREATE PROCEDURE IF NOT EXISTS sp_LapAktiva AS -- SET REMOVEDCase when @Divisi in ('-','') then '%' else @Divisi  

Select LEFT(A.PERKIRAAN,8) GrpPerkiraan, A.GroupAktiva,A.perkiraan, A.Keterangan,C.Perkiraan,

		   A.Devisi, A.Tanggal, A.Quantity, A.Persen,

		   (B.Awal) Awal, (B.MD) MD, (B.MK) MK, (B.Akhir) Akhir, (B.AwalSusut) AwalSusut, 

		   (B.SD) SD, (B.SK) SK, (B.AkhirSusut) Akhirsusut, D.Keterangan NamaPerkiraan,

		   B.Akhir-B.Akhirsusut NilaiAK,A.Biaya, 

		   E.Keterangan NamaBiaya, A.Biaya2, F.Keterangan NamaBiaya2, A.PersenBiaya1, A.PersenBiaya2,

		   Case when A.Biaya not in ('','-') then (B.SK*A.PersenBiaya1)/100 else 0  nBiayaSK,

		   Case when A.Biaya2 not in ('','-') then (B.SK*A.PersenBiaya2)/100 else 0  nBiayaSK2,

		   Case when A.Biaya not in ('','-') then (B.SD*A.PersenBiaya1)/100 else 0  nBiayaSD,

		   Case when A.Biaya2 not in ('','-') then (B.SK*A.PersenBiaya2)/100 else 0  nBiayaSD2

	From DBAKTIVA A

		  left Outer join  DBAKTIVADET B on B.Perkiraan=A.Perkiraan and B.Devisi=A.Devisi

		  left Outer Join DBPOSTHUTPIUT C on C.Perkiraan=A.NoMuka and C.Kode='AKV'

		  left Outer Join DBPERKIRAAN D on D.Perkiraan=C.Perkiraan and D.Tipe=1

		  left Outer Join DBPERKIRAAN E on E.Perkiraan=A.Biaya and E.Tipe=1

		  left Outer Join DBPERKIRAAN F on F.Perkiraan=A.Biaya2 and F.Tipe=1

	where B.Bulan=@bulan and B.Tahun=@tahun and A.Devisi like @Divisi       

	order by LEFT(A.PERKIRAAN,8),A.Devisi,A.NoMuka, A.Perkiraan;

-- sp_LapBankHarian
CREATE PROCEDURE IF NOT EXISTS sp_LapBankHarian AS -- SET REMOVEDCase when @Divisi in ('-','') then '%' else @Divisi 

  select a.tanggal,a.nobukti,a.TPHC,

         (case when a.perkiraan=@perkiraan then a.Lawan

	          when a.lawan=@perkiraan then Case When a.NoBukti Like '%BBK%' Then a.Lawan When a.NoBukti Like '%BKK%' Then a.Lawan else a.Perkiraan 

		)lawan,

	    (case when  a.TPHC in('C','T') and a.perkiraan=@perkiraan then  debet*a.kurs else 0 ) as Debet,

	    (case when  a.TPHC not in('C','T') and a.perkiraan=@perkiraan then  debet*a.kurs else 0 ) as Debet2,

	    (case when a.perkiraan=@perkiraan then debet*a.kurs else 0 ) as DebetRp,

	    (case when a.perkiraan=@perkiraan and a.valas<>'IDR' then debet else 0 ) as DebetD,

		 a.TipeTrans, case when COALESCE(t.Note,'')<>'' then t.Note+CHAR(13)+a.Keterangan else a.Keterangan  Keterangan,

		(case when  a.TPHC in('C','T') and a.lawan=@perkiraan then debet*a.kurs else 0 ) as kredit,                       

		(case when  a.TPHC not in('C','T') and a.Lawan=@perkiraan then  debet*a.kurs else 0 ) as kredit2, 

 	    (case when a.Lawan=@perkiraan then debet*a.Kurs else 0 ) as kreditRp,   

		(case when a.lawan=@perkiraan and a.valas<>'IDR' then debet else 0 ) as kreditD,

        a.Kurs, a.Valas, 0 Dolar, a.Devisi,a.Perkiraan,b.Keterangan NamaPerkiraan

		from dbTrans t 

               left outer join dbtransaksi a on t.NoBukti=a.NoBukti

		     left outer join DBPERKIRAAN b on b.Perkiraan=a.Perkiraan

		     left outer join DBPERKIRAAN c on c.Perkiraan=a.Lawan	

		where (t.tanggal between @tglaw and @tglAk) and (a.Devisi like @divisi)

		and (a.perkiraan=@perkiraan or a.lawan=@perkiraan )

		order by a.tanggal asc, t.NOURUT, t.Simbol, a.tipetrans desc, a.nobukti, a.Urut;

-- Sp_LapBiaya
CREATE PROCEDURE IF NOT EXISTS Sp_LapBiaya AS if @devisi = '-'

select substring(a.Perkiraan,1,2)as Kira, a.perkiraan, a.keterangan, a.tipe,

 COALESCE((select sum(COALESCE(b.MDRp,0)-COALESCE(b.MKRp,0)+COALESCE(b.JPDRp,0)-COALESCE(b.JPKRp,0))

  from dbNeraca b where a.perkiraan=b.perkiraan and b.bulan=(case  @Bulan when 1 then 12 else (@bulan-1) ) 

      and b.tahun=(case @bulan when 1 then @tahun-1 else @tahun  )),0) as BulanLalu,

 case when 

  COALESCE((select sum(COALESCE(b.MDRp,0)-COALESCE(b.MKRp,0)+COALESCE(b.JPDRp,0)-COALESCE(b.JPKRp,0))

   from dbNeraca b where a.perkiraan=b.perkiraan and b.bulan<@Bulan and b.tahun=@tahun  ),0)<> 0 then

   ((COALESCE((select sum(COALESCE(b.MDRp,0)-COALESCE(b.MKRp,0)+COALESCE(b.JPDRp,0)-COALESCE(b.JPKRp,0))

    from dbNeraca b where a.perkiraan=b.perkiraan and b.bulan=@Bulan and b.tahun=@tahun ),0)-

   COALESCE((select sum(COALESCE(b.MDRp,0)-COALESCE(b.MKRp,0)+COALESCE(b.JPDRp,0)-COALESCE(b.JPKRp,0))

    from dbNeraca b where a.perkiraan=b.perkiraan and b.bulan<@Bulan and b.tahun=@tahun),0))

   /

   COALESCE((select sum(COALESCE(b.MDRp,0)-COALESCE(b.MKRp,0)+COALESCE(b.JPDRp,0)-COALESCE(b.JPKRp,0))

    from dbNeraca b where a.perkiraan=b.perkiraan and b.bulan<@Bulan and b.tahun=@tahun),0))*100

 else 0  as Persen,

 COALESCE((select sum(COALESCE(b.MDRp,0)-COALESCE(b.MKRp,0)+COALESCE(b.JPDRp,0)-COALESCE(b.JPKRp,0))

 from dbNeraca b where a.perkiraan=b.perkiraan and b.bulan=@Bulan and b.tahun=@tahun ),0) as BulanKini,

 COALESCE((select sum(COALESCE(b.MDRp,0)-COALESCE(b.MKRp,0)+COALESCE(b.JPDRp,0)-COALESCE(b.JPKRp,0))

  from dbNeraca b where a.perkiraan=b.perkiraan and b.bulan<@Bulan and b.tahun=@tahun  ),0)+

 COALESCE((select sum(COALESCE(b.MDRp,0)-COALESCE(b.MKRp,0)+COALESCE(b.JPDRp,0)-COALESCE(b.JPKRp,0))

 from dbNeraca b where a.perkiraan=b.perkiraan and b.bulan=@Bulan and b.tahun=@tahun  ),0) as sdBulanini

  from dbperkiraan A

  where a.perkiraan>=@pkraw and a.perkiraan<=@pkrak

  order by a.perkiraan

 else

select substring(a.Perkiraan,1,2)as Kira, a.perkiraan, a.keterangan, a.tipe,

 COALESCE((select sum(COALESCE(b.MDRp,0)-COALESCE(b.MKRp,0)+COALESCE(b.JPDRp,0)-COALESCE(b.JPKRp,0))

  from dbNeraca b where a.perkiraan=b.perkiraan and b.bulan=(case  @Bulan when 1 then 12 else (@bulan-1) ) 

      and b.tahun=(case @bulan when 1 then @tahun-1 else @tahun  )  and b.devisi=@devisi),0) as BulanLalu,

 case when 

  COALESCE((select sum(COALESCE(b.MDRp,0)-COALESCE(b.MKRp,0)+COALESCE(b.JPDRp,0)-COALESCE(b.JPKRp,0))

   from dbNeraca b where a.perkiraan=b.perkiraan and b.bulan<@Bulan and b.tahun=@tahun  and b.devisi=@devisi),0)<> 0 then

   ((COALESCE((select sum(COALESCE(b.MDRp,0)-COALESCE(b.MKRp,0)+COALESCE(b.JPDRp,0)-COALESCE(b.JPKRp,0))

    from dbNeraca b where a.perkiraan=b.perkiraan and b.bulan=@Bulan and b.tahun=@tahun  and b.devisi=@devisi),0)-

   COALESCE((select sum(COALESCE(b.MDRp,0)-COALESCE(b.MKRp,0)+COALESCE(b.JPDRp,0)-COALESCE(b.JPKRp,0))

    from dbNeraca b where a.perkiraan=b.perkiraan and b.bulan<@Bulan and b.tahun=@tahun  and b.devisi=@devisi),0))

   /

   COALESCE((select sum(COALESCE(b.MDRp,0)-COALESCE(b.MKRp,0)+COALESCE(b.JPDRp,0)-COALESCE(b.JPKRp,0))

    from dbNeraca b where a.perkiraan=b.perkiraan and b.bulan<@Bulan and b.tahun=@tahun  and b.devisi=@devisi),0))*100

 else 0  as Persen,

 COALESCE((select sum(COALESCE(b.MDRp,0)-COALESCE(b.MKRp,0)+COALESCE(b.JPDRp,0)-COALESCE(b.JPKRp,0))

 from dbNeraca b where a.perkiraan=b.perkiraan and b.bulan=@Bulan and b.tahun=@tahun  and b.devisi=@devisi),0) as BulanKini,

 COALESCE((select sum(COALESCE(b.MDRp,0)-COALESCE(b.MKRp,0)+COALESCE(b.JPDRp,0)-COALESCE(b.JPKRp,0))

  from dbNeraca b where a.perkiraan=b.perkiraan and b.bulan<@Bulan and b.tahun=@tahun  and b.devisi=@devisi),0)+

 COALESCE((select sum(COALESCE(b.MDRp,0)-COALESCE(b.MKRp,0)+COALESCE(b.JPDRp,0)-COALESCE(b.JPKRp,0))

 from dbNeraca b where a.perkiraan=b.perkiraan and b.bulan=@Bulan and b.tahun=@tahun  and b.devisi=@devisi),0) as sdBulanini

  from dbperkiraan A

  where a.perkiraan>=@pkraw and a.perkiraan<=@pkrak

  order by a.perkiraan;

-- Sp_LapBiayabulan
CREATE PROCEDURE IF NOT EXISTS Sp_LapBiayabulan AS Select substring(a.Perkiraan,1,2)as Kira, a.perkiraan, a.keterangan, a.tipe,

       Sum(Case when B.Bulan=1 then Case when a.DK=0 then COALESCE(b.MD,0)-COALESCE(b.MK,0)+COALESCE(b.JPD,0)-COALESCE(b.JPK,0)

                                         when a.DK=1 then COALESCE(b.MK,0)-COALESCE(b.MD,0)+COALESCE(b.JPK,0)-COALESCE(b.JPD,0)

                                         else 0

                                    

                else 0 

           ) Jan,

       Sum(Case when B.Bulan=2 then Case when a.DK=0 then COALESCE(b.MD,0)-COALESCE(b.MK,0)+COALESCE(b.JPD,0)-COALESCE(b.JPK,0)

                                         when a.DK=1 then COALESCE(b.MK,0)-COALESCE(b.MD,0)+COALESCE(b.JPK,0)-COALESCE(b.JPD,0)

                                         else 0

                                    

                else 0 

           ) Feb,

       Sum(Case when B.Bulan=3 then Case when a.DK=0 then COALESCE(b.MD,0)-COALESCE(b.MK,0)+COALESCE(b.JPD,0)-COALESCE(b.JPK,0)

                                         when a.DK=1 then COALESCE(b.MK,0)-COALESCE(b.MD,0)+COALESCE(b.JPK,0)-COALESCE(b.JPD,0)

                                         else 0

                                    

                else 0 

           ) Mar,

       Sum(Case when B.Bulan=4 then Case when a.DK=0 then COALESCE(b.MD,0)-COALESCE(b.MK,0)+COALESCE(b.JPD,0)-COALESCE(b.JPK,0)

                                         when a.DK=1 then COALESCE(b.MK,0)-COALESCE(b.MD,0)+COALESCE(b.JPK,0)-COALESCE(b.JPD,0)

                                         else 0

                                    

                else 0 

           ) April,

       Sum(Case when B.Bulan=5 then Case when a.DK=0 then COALESCE(b.MD,0)-COALESCE(b.MK,0)+COALESCE(b.JPD,0)-COALESCE(b.JPK,0)

                                         when a.DK=1 then COALESCE(b.MK,0)-COALESCE(b.MD,0)+COALESCE(b.JPK,0)-COALESCE(b.JPD,0)

                                         else 0

                                    

                else 0 

           ) Mei,

       Sum(Case when B.Bulan=6 then Case when a.DK=0 then COALESCE(b.MD,0)-COALESCE(b.MK,0)+COALESCE(b.JPD,0)-COALESCE(b.JPK,0)

                                         when a.DK=1 then COALESCE(b.MK,0)-COALESCE(b.MD,0)+COALESCE(b.JPK,0)-COALESCE(b.JPD,0)

                                         else 0

                                    

                else 0 

           ) Jun,

       Sum(Case when B.Bulan=7 then Case when a.DK=0 then COALESCE(b.MD,0)-COALESCE(b.MK,0)+COALESCE(b.JPD,0)-COALESCE(b.JPK,0)

                                         when a.DK=1 then COALESCE(b.MK,0)-COALESCE(b.MD,0)+COALESCE(b.JPK,0)-COALESCE(b.JPD,0)

                                         else 0

                                    

                else 0 

           ) Jul,

       Sum(Case when B.Bulan=8 then Case when a.DK=0 then COALESCE(b.MD,0)-COALESCE(b.MK,0)+COALESCE(b.JPD,0)-COALESCE(b.JPK,0)

                                         when a.DK=1 then COALESCE(b.MK,0)-COALESCE(b.MD,0)+COALESCE(b.JPK,0)-COALESCE(b.JPD,0)

                                         else 0

                                    

                else 0 

           ) Aug,

       Sum(Case when B.Bulan=9 then Case when a.DK=0 then COALESCE(b.MD,0)-COALESCE(b.MK,0)+COALESCE(b.JPD,0)-COALESCE(b.JPK,0)

                                         when a.DK=1 then COALESCE(b.MK,0)-COALESCE(b.MD,0)+COALESCE(b.JPK,0)-COALESCE(b.JPD,0)

                                         else 0

                                    

                else 0 

           ) Sept,

       Sum(Case when B.Bulan=10 then Case when a.DK=0 then COALESCE(b.MD,0)-COALESCE(b.MK,0)+COALESCE(b.JPD,0)-COALESCE(b.JPK,0)

                                          when a.DK=1 then COALESCE(b.MK,0)-COALESCE(b.MD,0)+COALESCE(b.JPK,0)-COALESCE(b.JPD,0)

                                          else 0

                                     

                else 0 

           ) Okt, 

       Sum(Case when B.Bulan=11 then Case when a.DK=0 then COALESCE(b.MD,0)-COALESCE(b.MK,0)+COALESCE(b.JPD,0)-COALESCE(b.JPK,0)

                                          when a.DK=1 then COALESCE(b.MK,0)-COALESCE(b.MD,0)+COALESCE(b.JPK,0)-COALESCE(b.JPD,0)

                                          else 0

                                     

                else 0 

           ) Nov,

       Sum(Case when B.Bulan=12 then Case when a.DK=0 then COALESCE(b.MD,0)-COALESCE(b.MK,0)+COALESCE(b.JPD,0)-COALESCE(b.JPK,0)

                                          when a.DK=1 then COALESCE(b.MK,0)-COALESCE(b.MD,0)+COALESCE(b.JPK,0)-COALESCE(b.JPD,0)

                                          else 0

                                     

                else 0 

           ) 'Des',

       Sum(Case when a.DK=0 then COALESCE(b.MD,0)-COALESCE(b.MK,0)+COALESCE(b.JPD,0)-COALESCE(b.JPK,0)

                when a.DK=1 then COALESCE(b.MK,0)-COALESCE(b.MD,0)+COALESCE(b.JPK,0)-COALESCE(b.JPD,0)

                else 0

           ) 'Total'

From DBPERKIRAAN A

     left Outer join DBNERACA B on B.Perkiraan=A.Perkiraan

where (Devisi=@devisi Or Case when @devisi IN('','-') then 1 else 0 =1)and b.Tahun=@tahun

Group by substring(a.Perkiraan,1,2), a.perkiraan, a.keterangan, a.tipe

Order by Perkiraan;

-- Sp_LapBiayatahun
CREATE PROCEDURE IF NOT EXISTS Sp_LapBiayatahun AS -- DECLARE REMOVED (Perkiraan varchar(50) Primary Key, Saldo numeric(18,2))

Insert @BiayaTahunLalu(Perkiraan,Saldo)

Select a.Perkiraan, 

       Sum(Case when a.DK=0 then COALESCE(b.MD,0)-COALESCE(b.MK,0)+COALESCE(b.JPD,0)-COALESCE(b.JPK,0)

                when a.DK=1 then COALESCE(b.MK,0)-COALESCE(b.MD,0)+COALESCE(b.JPK,0)-COALESCE(b.JPD,0)

                else 0

           ) Saldo   

From DBPERKIRAAN a

     left Outer join DBNERACA b on b.Perkiraan=a.Perkiraan

where (Devisi=@devisi Or Case when @devisi IN('','-') then 1 else 2 =1)and b.Tahun=@tahun-1

Group by a.Perkiraan



-- DECLARE REMOVED (Perkiraan varchar(50) Primary Key, Saldo numeric(18,2))

Insert @BiayaTahunIni(Perkiraan,Saldo)

Select a.Perkiraan, 

       Sum(Case when a.DK=0 then COALESCE(b.MD,0)-COALESCE(b.MK,0)+COALESCE(b.JPD,0)-COALESCE(b.JPK,0)

                when a.DK=1 then COALESCE(b.MK,0)-COALESCE(b.MD,0)+COALESCE(b.JPK,0)-COALESCE(b.JPD,0)

                else 0

           ) Saldo   

From DBPERKIRAAN a

     left Outer join DBNERACA b on b.Perkiraan=a.Perkiraan

where (Devisi=@devisi Or Case when @devisi IN('','-') then 1 else 2 =1)and b.Tahun=@tahun

Group by a.Perkiraan



-- DECLARE REMOVED (Perkiraan varchar(50) Primary Key, Saldo numeric(18,2))

Insert @BiayaSdTahunIni(Perkiraan,Saldo)

Select a.Perkiraan, 

       Sum(Case when a.DK=0 then COALESCE(b.MD,0)-COALESCE(b.MK,0)+COALESCE(b.JPD,0)-COALESCE(b.JPK,0)

                when a.DK=1 then COALESCE(b.MK,0)-COALESCE(b.MD,0)+COALESCE(b.JPK,0)-COALESCE(b.JPD,0)

                else 0

           ) Saldo   

From DBPERKIRAAN a

     left Outer join DBNERACA b on b.Perkiraan=a.Perkiraan

where (Devisi=@devisi Or Case when @devisi IN('','-') then 1 else 0 =1)and b.Tahun<=@tahun

Group by a.Perkiraan



Select substring(a.Perkiraan,1,2)as Kira, a.perkiraan, a.keterangan, a.tipe,

       COALESCE(b.Saldo,0) TahunLalu,

       Case when COALESCE(c.Saldo,0)<>0 then COALESCE(b.Saldo,0)/COALESCE(c.Saldo,0) else 0 *100 Persen,

       COALESCE(c.Saldo,0) TahunKini, COALESCE(d.Saldo,0) sdTahunIni

From DBPERKIRAAN a

     left Outer join @BiayaTahunLalu b on b.Perkiraan=a.Perkiraan

     left Outer join @BiayaTahunIni c on c.Perkiraan=a.Perkiraan

     left Outer join @BiayaSdTahunIni d on d.Perkiraan=a.Perkiraan

Order by a.Perkiraan;

-- Sp_LapDeposito
CREATE PROCEDURE IF NOT EXISTS Sp_LapDeposito AS -- SET REMOVEDcase when @Perkiraan in ('-','') then '%' else @Perkiraan 

if @Masuk='1'

select  a.Bank, a.NoDeposito, a.TglJatuhTempo,

           A.Debet,A.DebetRp, 

           A.Kredit,a.KreditRp,

           a.Keterangan, a.TglBuka, a.BuktiBuka,a.TglCair, a.BuktiCair,

           a.Kurs, a.Jumlah, a.Kodevls, @Masuk JenisLap

   from DBDEPOSITO a

   where a.TglJatuhTempo>=@TglAw and a.TglJatuhTempo<=@TglAk and (a.Debet*a.Kurs)<>(a.Kredit*a.Kurs) and a.Tipe='PT' and a.Bank like @Perkiraan  

 else

if @Masuk='2'

select  a.Bank, a.NoDeposito, a.TglJatuhTempo,

            A.Debet,A.DebetRp, 

            A.Kredit,a.KreditRp,  a.Keterangan, a.TglBuka, a.BuktiBuka, a.TglCair, a.BuktiCair,

            a.Kurs, a.Jumlah, A.Kodevls, @Masuk JenisLap

    from DBDEPOSITO a

    where a.Bank=@Perkiraan and (a.Tglcair is not null and (a.tglcair between @TglAw and @TglAk))


if @Masuk='3'

select  a.Bank, a.NoDeposito, a.TglJatuhTempo,            

           A.Debet,A.DebetRp, 

           A.Kredit,a.KreditRp,

           a.Keterangan, a.TglBuka, a.BuktiBuka, 

           (case when a.Tglcair is null or tglcair>@TglAw then null else a.TglCair )as TglCair,

           (case when a.Tglcair is null or tglcair>@TglAw then null else a.BuktiCair )as BuktiCair,

             a.Kurs, a.Jumlah, a.Kodevls, @Masuk JenisLap

   from DBDEPOSITO a

   where  a.TglBuka between @TglAw and @tglAk and a.Tipe='PT' and a.Bank like @Perkiraan  

 else

if @Masuk='4'

select  a.Bank, a.NoDeposito, a.TglJatuhTempo,

            A.Debet,A.DebetRp, 

            A.Kredit,a.KreditRp,

               a.Keterangan, a.TglBuka, a.BuktiBuka, a.TglCair, a.BuktiCair,

               a.Kurs, a.Jumlah,a.Kodevls, @Masuk JenisLap

    from DBDEPOSITO a

    where a.TglCair>@TglAw and a.TglCair<=@TglAk and a.Tipe='PT' and a.Bank like @Perkiraan  


if @Masuk='5'

Select a.TglBuka Tanggal,a.BuktiBuka Nobukti,b.Keterangan,a.Bank,'' NoAcc,a.NoDeposito,a.TglJatuhTempo,

         a.Debet,0 kredit,a.Debet Saldo,1 Urut, @Masuk JenisLap

  from DBDEPOSITO a

  left Outer join dbtransaksi b on b.nobukti=a.buktibuka and b.Urut=a.UrutBuktiBuka

  Where a.BuktiBuka<>'' and month(a.tglbuka)=Month(@TglAw) and year(a.tglBuka)=year(@tglaw) and a.debet<>0 and a.Tipe='PT' and a.Bank like @Perkiraan  

  union

  Select a.TglCair,a.BuktiCair,b.Keterangan,a.Bank,''NoAcc,a.NoDeposito,a.TglJatuhTempo,

         0 debet,a.Kredit,a.Kredit*-1 Saldo,2 urut, @Masuk JenisLap

  from DBDEPOSITO a

  left Outer join dbtransaksi b on b.nobukti=a.bukticair and b.Urut=a.UrutBuktiCair



  Where a.BuktiCair<>'' and month(a.tglCair)=Month(@Tglaw) and year(a.tglcair)=year(@tglaw) and a.kredit<>0 and a.Tipe='PT' and a.Bank like @Perkiraan  

  union

  Select null,'','Saldo awal','','','',null,0,0,Sum(debet) Saldo,0 urut, @Masuk JenisLap

  From DBDEPOSITO a 

  where (Month(Tglbuka)<Month(@tglaw) and year(tglBuka)<=year(@tglaw))and 

        ((Kredit=0)or (Month(TglCair)>=Month(@tglaw) and year(tglcair)>=year(@tglaw))) and a.Tipe='PT' and a.Bank like @Perkiraan  

  Order by urut,Tanggal,Nobukti;

-- sp_LapDP
CREATE PROCEDURE IF NOT EXISTS sp_LapDP AS select @Id=SUBSTRING(@Id,1,1)


if @Id=''

if @IsiList=''     

exec('Select ''Gabungan'' Perusahaan,* from [fnc_ReportDP] ('+@Tgl1+''+','+''+@Tgl2+')

      order by KodeCustSupp,KodeProject,NoKwitansi,TglInv')



else

exec('Select ''Gabungan'' Perusahaan,* from [fnc_ReportDP] ('+@Tgl1+''+','+''+@Tgl2+') 

      where  KodeCustSupp IN'+@isiList+ '

      order by KodeCustSupp,KodeProject,NoKwitansi,tglInv

     ')    


else

if @IsiList=''     

exec('Select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from [fnc_ReportDP] ('+@Tgl1+''+','+''+@Tgl2+')

      where '''+@ID+'''= Left(NoBukti,1)

      order by KodeCustSupp,KodeProject,NoKwitansi,TglInv')



else

exec('Select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from [fnc_ReportDP] ('+@Tgl1+''+','+''+@Tgl2+') 

      where  KodeCustSupp IN'+@isiList+ '

      and '''+@ID+'''= Left(NoBukti,1)

      order by KodeCustSupp,KodeProject,NoKwitansi,tglInv

     ');

-- sp_LapDPold
CREATE PROCEDURE IF NOT EXISTS sp_LapDPold AS if @IsiList='' 

exec('select * from vw_DP where (TglInv Between '+@Tgl1+''+' and '+''+@Tgl2+') 

     order by KodeCustSupp,KodeProject,NoKwitansi,TglInv')



else

exec('select * from vw_DP where  KodeCustSupp IN'+@isiList+ ' and (TglInv Between '+@Tgl1+''+' and '+''+@Tgl2+') 

     order by KodeCustSupp,KodeProject,NoKwitansi,tglInv');

-- Sp_LapGiroHutang
CREATE PROCEDURE IF NOT EXISTS Sp_LapGiroHutang AS -- SET REMOVEDcase when @Perkiraan in ('-','') then '%' else @Perkiraan 

if @masuk='1'

select  a.Bank, a.NoGiro, a.TglGiro, 

          A.Debet,A.DebetRp, 

          A.Kredit,a.KreditRp,

          a.Keterangan, a.TglBuka, a.BuktiBuka, a.TglCair, a.BuktiCair, a.Kurs, a.Jumlah,

          a.Kodevls, @Masuk JenisLap

  from dbgiro a

  where (a.TglGiro between @TglAw and @TglAk) and  A.Tipe='HT' and a.Bank like @Perkiraan  

 else

if @masuk='2'

select a.Bank, a.NoGiro, a.TglGiro,A.Debet,A.DebetRp, 

          A.Kredit,a.KreditRp,

          a.Keterangan, a.TglBuka, a.BuktiBuka, a.TglCair, a.BuktiCair, a.Kurs, a.Jumlah,

          a.Kodevls, @Masuk JenisLap

  from dbgiro a

  where a.Bank like @Perkiraan and a.TglBuka>=@TglAw and a.TglBuka<=@TglAk and A.Tipe='HT' 



if @masuk='3'

select  a.Bank, a.NoGiro, a.TglGiro,

          A.Debet,A.DebetRp, 

          A.Kredit,a.KreditRp,

          a.Keterangan, a.TglBuka, a.BuktiBuka,

         a.TglCair,

         a.BuktiCair,

         a.Kurs, a.Jumlah,a.Kodevls, @Masuk JenisLap

   from dbgiro a

   where (a.Tglcair is null or TglCair>@TglAk) and a.TglBuka<=@TglAk

  and a.bank like @Perkiraan  and A.Tipe='HT'

 else

if @masuk='4'

select  a.Bank, a.NoGiro, a.TglGiro, 

          A.Debet,A.DebetRp, 

          A.Kredit,a.KreditRp,

          a.Keterangan, a.TglBuka, a.BuktiBuka, a.TglCair, a.BuktiCair,

          a.Kurs, a.Jumlah, A.Kodevls, @Masuk JenisLap

  from dbgiro a

 

  where a.Bank like @Perkiraan and (a.TglCair between @TglAw and @TglAk) and A.Tipe='HT';

-- sp_LapGiroPiutang
CREATE PROCEDURE IF NOT EXISTS sp_LapGiroPiutang AS --select @masuk=5, @Divisi ='01',@Perkiraan ='101005',@TglAw ='1-1-2013',@TglAk ='1-31-2013'



-- SET REMOVEDcase when @Perkiraan in ('-','') then '%' else @Perkiraan 



if @Masuk='1'

if @tolak=1

	   select  a.Bank, a.NoGiro, a.TglGiro,

		a.Debet, a.DebetRp, 

		a.Kredit, a.KreditRp,

		a.Keterangan, a.TglBuka, a.BuktiBuka, a.TglCair, a.BuktiCair,

		a.Kurs, a.Jumlah, a.Kodevls, @Masuk JenisLap

		from	DBGIRO a

		where	a.Tipe='PT' and (a.TglGiro between @TglAw and @TglAk) and a.Kas like @Perkiraan  

	    and A.NoGiro like '%T'

	   

	else if @tolak=2

	   select  a.Bank, a.NoGiro, a.TglGiro,

		a.Debet, a.DebetRp, 

		a.Kredit, a.KreditRp,

		a.Keterangan, a.TglBuka, a.BuktiBuka, a.TglCair, a.BuktiCair,

		a.Kurs, a.Jumlah, a.Kodevls, @Masuk JenisLap

		from	DBGIRO a

		where	a.Tipe='PT' and (a.TglGiro between @TglAw and @TglAk) and a.Kas like @Perkiraan  

	    and A.NoGiro not like '%T'

	   

	else if @tolak=3

	   select  a.Bank, a.NoGiro, a.TglGiro,

		a.Debet, a.DebetRp, 

		a.Kredit, a.KreditRp,

		a.Keterangan, a.TglBuka, a.BuktiBuka, a.TglCair, a.BuktiCair,

		a.Kurs, a.Jumlah, a.Kodevls, @Masuk JenisLap

		from	DBGIRO a

		where	a.Tipe='PT' and (a.TglGiro between @TglAw and @TglAk) and a.Kas like @Perkiraan  


 else

if @Masuk='2'

if @tolak=1

	select  a.Bank, a.NoGiro, a.TglGiro,

		a.Debet, a.DebetRp, 

		a.Kredit, a.KreditRp,

		a.Keterangan, a.TglBuka, a.BuktiBuka, a.TglCair, a.BuktiCair,

		a.Kurs, a.Jumlah, a.Kodevls, @Masuk JenisLap

		from	DBGIRO a

		where	a.Tipe='PT' and a.TglCair is not null 

		and a.TglCair>=@TglAw and a.TglCair<=@TglAk and a.Kas like @Perkiraan 

		and A.NoGiro like '%T' 

		

	else if @tolak=2

	select  a.Bank, a.NoGiro, a.TglGiro,

		a.Debet, a.DebetRp, 

		a.Kredit, a.KreditRp,

		a.Keterangan, a.TglBuka, a.BuktiBuka, a.TglCair, a.BuktiCair,

		a.Kurs, a.Jumlah, a.Kodevls, @Masuk JenisLap

		from	DBGIRO a

		where	a.Tipe='PT' and a.TglCair is not null 

		and a.TglCair>=@TglAw and a.TglCair<=@TglAk and a.Kas like @Perkiraan 

		and A.NoGiro not like '%T' 

		

	else if @tolak=3

	select  a.Bank, a.NoGiro, a.TglGiro,

		a.Debet, a.DebetRp, 

		a.Kredit, a.KreditRp,

		a.Keterangan, a.TglBuka, a.BuktiBuka, a.TglCair, a.BuktiCair,

		a.Kurs, a.Jumlah, a.Kodevls, @Masuk JenisLap

		from	DBGIRO a

		where	a.Tipe='PT' and a.TglCair is not null 

		and a.TglCair>=@TglAw and a.TglCair<=@TglAk and a.Kas like @Perkiraan 


if @Masuk='3'

if @tolak=1

	   select  a.Bank, a.NoGiro, a.TglGiro,

            A.Debet,A.DebetRp, 

            A.Kredit,a.KreditRp,

             a.Keterangan, a.TglBuka, a.BuktiBuka, 

            a.TglCair,

            a.BuktiCair,

             a.Kurs, a.Jumlah, a.Kodevls, @Masuk JenisLap

			from dbgiro a

			where  (a.TglBuka between @TglAw and @tglAk) and a.Tipe='PT' and a.Kas like @Perkiraan  

			and A.NoGiro like '%T' 

	   

	else if @tolak=2

	   select  a.Bank, a.NoGiro, a.TglGiro,

            A.Debet,A.DebetRp, 

            A.Kredit,a.KreditRp,

             a.Keterangan, a.TglBuka, a.BuktiBuka, 

            a.TglCair,

            a.BuktiCair,

             a.Kurs, a.Jumlah, a.Kodevls, @Masuk JenisLap

			from dbgiro a

			where  (a.TglBuka between @TglAw and @tglAk) and a.Tipe='PT' and a.Kas like @Perkiraan  

			and A.NoGiro not like '%T' 

	   

	 else if @tolak=3

	   select  a.Bank, a.NoGiro, a.TglGiro,

            A.Debet,A.DebetRp, 

            A.Kredit,a.KreditRp,

             a.Keterangan, a.TglBuka, a.BuktiBuka, 

            a.TglCair,

            a.BuktiCair,

             a.Kurs, a.Jumlah, a.Kodevls, @Masuk JenisLap

			from dbgiro a

			where  (a.TglBuka between @TglAw and @tglAk) and a.Tipe='PT' and a.kas like @Perkiraan  


 else

if @Masuk='4'

if @tolak=1

	   select  a.Bank, a.NoGiro, a.TglGiro,

            A.Debet,A.DebetRp, 

            A.Kredit,a.KreditRp,

               a.Keterangan, a.TglBuka, a.BuktiBuka, a.TglCair, a.BuktiCair,

               a.Kurs, a.Jumlah,a.Kodevls, @Masuk JenisLap

			from dbgiro a

			where A.TglBuka<=@TglAk and (A.TglCair>@TglAk or a.TglCair is null) and a.Tipe='PT' and a.kas like @Perkiraan  

			and A.NoGiro like '%T' 

		

	else if @tolak=2

	   select  a.Bank, a.NoGiro, a.TglGiro,

            A.Debet,A.DebetRp, 

            A.Kredit,a.KreditRp,

               a.Keterangan, a.TglBuka, a.BuktiBuka, a.TglCair, a.BuktiCair,

               a.Kurs, a.Jumlah,a.Kodevls, @Masuk JenisLap

			from dbgiro a

			where A.TglBuka<=@TglAk and (A.TglCair>@TglAk or a.TglCair is null) and a.Tipe='PT' and a.kas like @Perkiraan  

			and A.NoGiro not like '%T' 

		

	else if @tolak=3

	   select  a.Bank, a.NoGiro, a.TglGiro,

            A.Debet,A.DebetRp, 

            A.Kredit,a.KreditRp,

               a.Keterangan, a.TglBuka, a.BuktiBuka, a.TglCair, a.BuktiCair,

               a.Kurs, a.Jumlah,a.Kodevls, @Masuk JenisLap

			from dbgiro a

			where A.TglBuka<=@TglAk and (A.TglCair>@TglAk or a.TglCair is null) and a.Tipe='PT' and a.kas like @Perkiraan  


if @Masuk='5'

---- DECLARE REMOVED

 -- SET REMOVED case when (@TglAw>(select min (tglbuka) from dbgiro) ) then @TglAw else (select min (tglbuka) from dbgiro)  


  Select a.TglBuka Tanggal,a.BuktiBuka Nobukti,b.Keterangan,a.Bank,'' NoAcc,a.NoGiro,a.TglGiro,

         a.DebetRp Debet,0 kredit,a.DebetRp Saldo,1 Urut, @Masuk JenisLap

  from dbgiro a

  left Outer join dbtransaksi b on b.nobukti=a.buktibuka and b.Urut=a.UrutBuktiBuka

  Where a.BuktiBuka<>'' and month(a.tglbuka)=Month(@TglAw) and year(a.tglBuka)=year(@tglaw) and a.DebetRp<>0 and a.Tipe='PT' and a.kas like @Perkiraan  

  union all

  Select a.TglCair,a.BuktiCair,b.Keterangan,a.Bank,''NoAcc,a.NoGiro,a.TglGiro,

         0 debet, a.KreditRp Kredit, a.KreditRp*-1 Saldo,2 urut, @Masuk JenisLap

  from dbgiro a

  left Outer join dbtransaksi b on b.nobukti=a.bukticair and b.Urut=a.UrutBuktiCair

  Where a.BuktiCair<>'' and month(a.tglCair)=Month(@Tglaw) and year(a.tglcair)=year(@tglaw) and a.kreditRp<>0 and a.Tipe='PT' and a.kas like @Perkiraan  

  union all

  Select null,'','Saldo awal','','','',null,0,0, Sum(debetRp) Saldo,0 urut, @Masuk JenisLap

  From dbgiro a 

  where 

    (TglBuka<=@TglAw)

  --and(Month(Tglbuka)<Month(@tglaw) and year(tglBuka)<=year(@tglaw)) 

  --and 

   --((KreditRp=0) or (Month(TglCair)>=Month(@tglaw) and year(tglcair)>=year(@tglaw))) 

   and a.Tipe='PT' and a.kas like @Perkiraan  

  Order by Tanggal,urut,Nobukti;

-- Sp_LapJurnal
CREATE PROCEDURE IF NOT EXISTS Sp_LapJurnal AS --select @Tipe='BBM',@Divisi='01',@TglAw='2020-06-01',@TglAk='2020-06-30'

-- SET REMOVEDCase when @Divisi in ('-','') then '%' else @Divisi 


	if @tipe='JP'

	--Jurnal Penutup

	 select a.Devisi, a.Tanggal, a.NoBukti, a.Perkiraan, a.Lawan, Debet=(a.Debet*a.Kurs),

			  Kredit=(a.Kredit*a.Kurs), a.TipeTrans, a.Keterangan,

	 (case when exists(Select b.NoBukti from dbTransaksi b where b.NoBukti=a.NoBukti and

	  b.TipeTrans=@Tipe and b.Tanggal>=@TglAw and b.Tanggal<=@TglAk group by b.NoBukti)then

	 (select sum(b.Debet*b.Kurs)from dbTransaksi b where b.NoBukti=a.NoBukti and

	  b.TipeTrans=@Tipe and b.Tanggal>=@TglAw and b.Tanggal<=@TglAk group by b.NoBukti)else 0 )as NDebet,

	 (case when exists(Select b.NoBukti from dbTransaksi b where b.NoBukti=a.NoBukti and

	  b.TipeTrans=@Tipe and b.Tanggal>=@TglAw and b.Tanggal<=@TglAk group by b.NoBukti)then

	 (select sum(b.Kredit*b.Kurs)from dbTransaksi b where b.NoBukti=a.NoBukti and

	  b.TipeTrans=@Tipe and b.Tanggal>=@TglAw and b.Tanggal<=@TglAk group by b.NoBukti)else 0 )as NKredit

	 From dbTransaksi a

	 Where (a.TipeTrans='HPP' or a.tipetrans='LR')  and a.devisi=@divisi and a.Tanggal>=@TglAw and a.Tanggal<=@TglAk

	 

	else

	select a.Devisi, a.Tanggal, a.NoBukti, a.Perkiraan, a.Lawan, 

	 Debet=(case when (a.Lawan='131') and ((b.FlagSimbol='LB') or (b.FlagSimbol='TG')) then ((a.Debet*-1)*a.Kurs) else (a.Debet*a.Kurs) ),

			  Kredit=(a.Kredit*a.Kurs), a.TipeTrans, a.Keterangan,

	 (case when exists(Select b.NoBukti from dbTransaksi b where b.NoBukti=a.NoBukti and

	  b.TipeTrans=@Tipe and b.Tanggal>=@TglAw and b.Tanggal<=@TglAk group by b.NoBukti)then

	 (select sum(b.Debet*b.Kurs)from dbTransaksi b where b.NoBukti=a.NoBukti and

	  b.TipeTrans=@Tipe and b.Tanggal>=@TglAw and b.Tanggal<=@TglAk group by b.NoBukti)else 0 )as NDebet,

	 (case when exists(Select b.NoBukti from dbTransaksi b where b.NoBukti=a.NoBukti and

	  b.TipeTrans=@Tipe and b.Tanggal>=@TglAw and b.Tanggal<=@TglAk group by b.NoBukti)then

	 (select sum(b.Kredit*b.Kurs)from dbTransaksi b where b.NoBukti=a.NoBukti and

	  b.TipeTrans=@Tipe and b.Tanggal>=@TglAw and b.Tanggal<=@TglAk group by b.NoBukti)else 0 )as NKredit

	 From VWTransaksiBB a

	 left outer join dbTransaksi b on b.NoBukti=a.NOBUKTI and b.Urut=a.URUT

	 Where a.TipeTrans=@Tipe and a.devisi like @divisi and a.Tanggal>=@TglAw and a.Tanggal<=@TglAk

	 and a.PERKIRAAN<>'102' and a.LAWAN<>'102';

-- sp_LapKasHarian
CREATE PROCEDURE IF NOT EXISTS sp_LapKasHarian AS -- SET REMOVEDCase when @Divisi in ('-','') then '%' else @Divisi 

  select * from(

  select NOURUT, t.Simbol,Urut,a.tanggal,a.nobukti,

         (case when a.perkiraan=@perkiraan then a.Lawan

	          when a.lawan=@perkiraan then a.Perkiraan

		)lawan,

	    (case when  a.TPHC='C' then

		    (case when a.perkiraan=@perkiraan and debet<>0 then debet*a.kurs

		          when a.perkiraan=@perkiraan  and kredit<>0 then 0

		          when a.lawan=@perkiraan  and debet<>0 then 0

		          when a.lawan=@perkiraan  and kredit<>0 then kredit*a.kurs 

	        	) 

               else 0 ) as Debet,

		(case when a.perkiraan=@perkiraan then Case when a.valas<>'IDR' then debet else 0 

		      when a.lawan=@perkiraan then 0

		 ) as DebetD,

		 (case when a.TPHC in ('T','P','H') then

		      (case when a.perkiraan=@perkiraan and debet<>0 then debet*a.kurs

		            when a.perkiraan=@perkiraan  and kredit<>0 then 0

	 	            when a.lawan=@perkiraan  and debet<>0 then 0

		            when a.lawan=@perkiraan  and kredit<>0 then kredit*a.kurs ) 

                 else 0 ) as Debet2,

		 a.TipeTrans, COALESCE(a.Keterangan,'')+COALESCE(supp.NAMACUSTSUPP,'') Keterangan,

		(case when  a.TPHC='C' then                        

		      (case when a.perkiraan=@perkiraan and debet<>0 then 0

		            when a.perkiraan=@perkiraan and kredit<>0 then Kredit*a.kurs

		            when a.lawan=@perkiraan and debet<>0 then Debet*a.kurs

		            when a.lawan=@perkiraan and kredit<>0 then 0 ) else 0 )  kredit,

		 (case when a.perkiraan=@perkiraan then 0

		      when a.lawan=@perkiraan then Case when a.valas<>'IDR' then debet else 0 

		 ) as KreditD,

		(case when a.TPHC in ('T','P','H') then                        

			 (case when a.perkiraan=@perkiraan and debet<>0 then 0

				  when a.perkiraan=@perkiraan and kredit<>0 then Kredit*a.kurs

				  when a.lawan=@perkiraan and debet<>0 then Debet*a.kurs

				  when a.lawan=@perkiraan and kredit<>0 then 0 )

                 else 0 

           ) kredit2,



             		a.Kurs, a.Valas, 0 Dolar, a.Devisi,a.Perkiraan,b.Keterangan NamaPerkiraan

		from dbTrans t 

               left outer join dbtransaksi a on t.NoBukti=a.NoBukti

               Left Outer Join DBCUSTSUPP supp on supp.KODECUSTSUPP=a.CustSuppP

		     left outer join DBPERKIRAAN b on b.Perkiraan=a.Perkiraan

		     left outer join DBPERKIRAAN c on c.Perkiraan=a.Lawan	

		where (t.tanggal between @tglaw and @tglAk) and (a.Devisi like @divisi)

		and (a.perkiraan=@perkiraan or a.lawan=@perkiraan )

		union all

select NOURUT, '',Urut,a.tanggal,a.nobukti,

         (case when a.perkiraan=@perkiraan then a.Lawan

	          when a.lawan=@perkiraan then a.Perkiraan

		)lawan,

	    (case when  a.TPHC='C' then

		    (case when a.perkiraan=@perkiraan and debet<>0 then debet*a.kurs

		          when a.perkiraan=@perkiraan  and kredit<>0 then 0

		          when a.lawan=@perkiraan  and debet<>0 then 0

		          when a.lawan=@perkiraan  and kredit<>0 then kredit*a.kurs 

	        	) 

               else 0 ) as Debet,

		(case when a.perkiraan=@perkiraan then Case when a.valas<>'IDR' then debet else 0 

		      when a.lawan=@perkiraan then 0

		 ) as DebetD,

		 (case when a.TPHC in ('T','P','H') then

		      (case when a.perkiraan=@perkiraan and debet<>0 then debet*a.kurs

		            when a.perkiraan=@perkiraan  and kredit<>0 then 0

	 	            when a.lawan=@perkiraan  and debet<>0 then 0

		            when a.lawan=@perkiraan  and kredit<>0 then kredit*a.kurs ) 

                 else 0 ) as Debet2,

		 a.TipeTrans, a.Keterangan,

		(case when  a.TPHC='C' then                        

		      (case when a.perkiraan=@perkiraan and debet<>0 then 0

		            when a.perkiraan=@perkiraan and kredit<>0 then Kredit*a.kurs

		            when a.lawan=@perkiraan and debet<>0 then Debet*a.kurs

		            when a.lawan=@perkiraan and kredit<>0 then 0 ) else 0 )  kredit,

		 (case when a.perkiraan=@perkiraan then 0

		      when a.lawan=@perkiraan then Case when a.valas<>'IDR' then debet else 0 

		 ) as KreditD,

		(case when a.TPHC in ('T','P','H') then                        

			 (case when a.perkiraan=@perkiraan and debet<>0 then 0

				  when a.perkiraan=@perkiraan and kredit<>0 then Kredit*a.kurs

				  when a.lawan=@perkiraan and debet<>0 then Debet*a.kurs

				  when a.lawan=@perkiraan and kredit<>0 then 0 )

                 else 0 

           ) kredit2,



             		a.Kurs, a.Valas, 0 Dolar, a.Devisi,a.Perkiraan,b.Keterangan NamaPerkiraan

		from vwtransaksi a

		left outer join DBPERKIRAAN b on b.Perkiraan=a.Perkiraan

		     left outer join DBPERKIRAAN c on c.Perkiraan=a.Lawan	

		where (A.tanggal between @tglaw and @tglAk) and JENIS Like '%SK%' and (a.lawan =@Perkiraan or a.PERKIRAAN=@Perkiraan)

		)a		

		order by tanggal asc, a.tipetrans desc, a.nobukti, a.Urut;

-- sp_LapKasHarianOld
CREATE PROCEDURE IF NOT EXISTS sp_LapKasHarianOld AS -- SET REMOVEDCase when @Divisi in ('-','') then '%' else @Divisi 

  select * from(

  select NOURUT, t.Simbol,Urut,a.tanggal,a.nobukti,

         (case when a.perkiraan=@perkiraan then a.Lawan

	          when a.lawan=@perkiraan then a.Perkiraan

		)lawan,

	    (case when  a.TPHC='C' then

		    (case when a.perkiraan=@perkiraan and debet<>0 then debet*a.kurs

		          when a.perkiraan=@perkiraan  and kredit<>0 then 0

		          when a.lawan=@perkiraan  and debet<>0 then 0

		          when a.lawan=@perkiraan  and kredit<>0 then kredit*a.kurs 

	        	) 

               else 0 ) as Debet,

		(case when a.perkiraan=@perkiraan then Case when a.valas<>'IDR' then debet else 0 

		      when a.lawan=@perkiraan then 0

		 ) as DebetD,

		 (case when a.TPHC in ('T','P','H') then

		      (case when a.perkiraan=@perkiraan and debet<>0 then debet*a.kurs

		            when a.perkiraan=@perkiraan  and kredit<>0 then 0

	 	            when a.lawan=@perkiraan  and debet<>0 then 0

		            when a.lawan=@perkiraan  and kredit<>0 then kredit*a.kurs ) 

                 else 0 ) as Debet2,

		 a.TipeTrans, COALESCE(a.Keterangan,'')+COALESCE(supp.NAMACUSTSUPP,'') Keterangan,

		(case when  a.TPHC='C' then                        

		      (case when a.perkiraan=@perkiraan and debet<>0 then 0

		            when a.perkiraan=@perkiraan and kredit<>0 then Kredit*a.kurs

		            when a.lawan=@perkiraan and debet<>0 then Debet*a.kurs

		            when a.lawan=@perkiraan and kredit<>0 then 0 ) else 0 )  kredit,

		 (case when a.perkiraan=@perkiraan then 0

		      when a.lawan=@perkiraan then Case when a.valas<>'IDR' then debet else 0 

		 ) as KreditD,

		(case when a.TPHC in ('T','P','H') then                        

			 (case when a.perkiraan=@perkiraan and debet<>0 then 0

				  when a.perkiraan=@perkiraan and kredit<>0 then Kredit*a.kurs

				  when a.lawan=@perkiraan and debet<>0 then Debet*a.kurs

				  when a.lawan=@perkiraan and kredit<>0 then 0 )

                 else 0 

           ) kredit2,



             		a.Kurs, a.Valas, 0 Dolar, a.Devisi,a.Perkiraan,b.Keterangan NamaPerkiraan

		from dbTrans t 

               left outer join dbtransaksi a on t.NoBukti=a.NoBukti

               Left Outer Join DBCUSTSUPP supp on supp.KODECUSTSUPP=a.CustSuppP

		     left outer join DBPERKIRAAN b on b.Perkiraan=a.Perkiraan

		     left outer join DBPERKIRAAN c on c.Perkiraan=a.Lawan	

		where (t.tanggal between @tglaw and @tglAk) and (a.Devisi like @divisi)

		and (a.perkiraan=@perkiraan or a.lawan=@perkiraan )

		union all

select NOURUT, '',Urut,a.tanggal,a.nobukti,

         (case when a.perkiraan=@perkiraan then a.Lawan

	          when a.lawan=@perkiraan then a.Perkiraan

		)lawan,

	    (case when  a.TPHC='C' then

		    (case when a.perkiraan=@perkiraan and debet<>0 then debet*a.kurs

		          when a.perkiraan=@perkiraan  and kredit<>0 then 0

		          when a.lawan=@perkiraan  and debet<>0 then 0

		          when a.lawan=@perkiraan  and kredit<>0 then kredit*a.kurs 

	        	) 

               else 0 ) as Debet,

		(case when a.perkiraan=@perkiraan then Case when a.valas<>'IDR' then debet else 0 

		      when a.lawan=@perkiraan then 0

		 ) as DebetD,

		 (case when a.TPHC in ('T','P','H') then

		      (case when a.perkiraan=@perkiraan and debet<>0 then debet*a.kurs

		            when a.perkiraan=@perkiraan  and kredit<>0 then 0

	 	            when a.lawan=@perkiraan  and debet<>0 then 0

		            when a.lawan=@perkiraan  and kredit<>0 then kredit*a.kurs ) 

                 else 0 ) as Debet2,

		 a.TipeTrans, a.Keterangan,

		(case when  a.TPHC='C' then                        

		      (case when a.perkiraan=@perkiraan and debet<>0 then 0

		            when a.perkiraan=@perkiraan and kredit<>0 then Kredit*a.kurs

		            when a.lawan=@perkiraan and debet<>0 then Debet*a.kurs

		            when a.lawan=@perkiraan and kredit<>0 then 0 ) else 0 )  kredit,

		 (case when a.perkiraan=@perkiraan then 0

		      when a.lawan=@perkiraan then Case when a.valas<>'IDR' then debet else 0 

		 ) as KreditD,

		(case when a.TPHC in ('T','P','H') then                        

			 (case when a.perkiraan=@perkiraan and debet<>0 then 0

				  when a.perkiraan=@perkiraan and kredit<>0 then Kredit*a.kurs

				  when a.lawan=@perkiraan and debet<>0 then Debet*a.kurs

				  when a.lawan=@perkiraan and kredit<>0 then 0 )

                 else 0 

           ) kredit2,



             		a.Kurs, a.Valas, 0 Dolar, a.Devisi,a.Perkiraan,b.Keterangan NamaPerkiraan

		from vwtransaksi a

		left outer join DBPERKIRAAN b on b.Perkiraan=a.Perkiraan

		     left outer join DBPERKIRAAN c on c.Perkiraan=a.Lawan	

		where (A.tanggal between @tglaw and @tglAk) and JENIS Like '%SK%' and (a.lawan =@Perkiraan or a.PERKIRAAN=@Perkiraan)

		)a		

		order by tanggal asc, a.tipetrans desc, a.nobukti, a.Urut;

-- SP_LapNeracaPenunjang
CREATE PROCEDURE IF NOT EXISTS SP_LapNeracaPenunjang AS -- SET REMOVEDCase when @divisi in ('-','') then '%' else @divisi 

Select Case when Left(A.Neraca,2)='A1' then 'AKTIVA LANCAR'

            when Left(A.Neraca,2)='A2' then 'AKTIVA TETAP'

            when Left(A.Neraca,2)='A3' then 'AKTIVA LAIN-LAIN' 

            when Left(A.Neraca,2)='P1' then 'KEWAJIBAN LANCAR'

            when Left(A.Neraca,2)='P2' then 'KEWAJIBAN TIDAK LANCAR'

            when Left(A.Neraca,2)='P3' then 'MODAL SENDIRI' 

            else ''

        Grup, A.Keterangan, A.Perkiraan,

       a.Keterangan, A.Tipe, a.DK,

       Case when A.DK=0 then b.AkhirDRp-b.AkhirKRp 

            when A.DK=1 then b.AkhirKRp-b.AkhirDRp

            else 0

        BulanIni, B.Devisi 

from dbPerkiraan a

     left outer join dbNeraca b on b.Perkiraan=a.Perkiraan

where b.Bulan=@bulan and b.Tahun=@tahun and Left(A.Neraca,2)<>'' and 

      B.Devisi like @divisi and 

      Case when A.DK=0 then b.AkhirDRp-b.AkhirKRp 

            when A.DK=1 then b.AkhirKRp-b.AkhirDRp

            else 0

       <>0 

Order by Left(A.Neraca,2),A.Perkiraan;

-- Sp_LapPosisiBankKasHarian
CREATE PROCEDURE IF NOT EXISTS Sp_LapPosisiBankKasHarian AS exec Sp_GenerateReportBukuTambahan 1, 2011, @Tanggal, @Tanggal, '','z','T',@Divisi 



select GroupPrk, KetGroupPrk, NoAcc, Keterangan, Valas, JumlahD, 

	case when JumlahD=0 then null else JumlahRp/JumlahD  Kurs, JumlahRp

from



(

select 'A' GroupPrk, 'BANK - GIRO/TAB' KetGroupPrk,

	A.NoAcc, B.Keterangan, B.Valas, SUM(A.SaldoAwalD+A.DebetD-A.KreditD) JumlahD,

	SUM(A.SaldoAwal+A.Debet-A.Kredit) JumlahRp 

from dbTempBkBesar A

left outer join DBPERKIRAAN B on B.Perkiraan=A.NoACC

where A.NoACC like '1112%'

group by A.NoAcc, B.Keterangan, B.Valas



union all

select 'B' GroupPrk, 'BANK - DEPOSITO' KetGroupPrk,

	A.NoAcc, B.Keterangan, B.Valas, SUM(A.SaldoAwalD+A.DebetD-A.KreditD) JumlahD,

	SUM(A.SaldoAwal+A.Debet-A.Kredit) JumlahRp 

from dbTempBkBesar A

left outer join DBPERKIRAAN B on B.Perkiraan=A.NoACC

where A.NoACC like '1113%'

group by A.NoAcc, B.Keterangan, B.Valas



union all

select 'C' GroupPrk, 'KAS' KetGroupPrk,

	A.NoAcc, B.Keterangan, B.Valas, SUM(A.SaldoAwalD+A.DebetD-A.KreditD) JumlahD,

	SUM(A.SaldoAwal+A.Debet-A.Kredit) JumlahRp 

from dbTempBkBesar A

left outer join DBPERKIRAAN B on B.Perkiraan=A.NoACC

where A.NoACC like '1111%'

group by A.NoAcc, B.Keterangan, B.Valas



union all

select 'D' GroupPrk, 'PIUTANG DAGANG' KetGroupPrk,

	A.NoAcc, B.Keterangan, B.Valas, SUM(A.SaldoAwalD+A.DebetD-A.KreditD) JumlahD,

	SUM(A.SaldoAwal+A.Debet-A.Kredit) JumlahRp 

from dbTempBkBesar A

left outer join DBPERKIRAAN B on B.Perkiraan=A.NoACC

where A.NoACC like '113%'

group by A.NoAcc, B.Keterangan, B.Valas

) X



where JumlahRp<>0 or JumlahD<>0



order by GroupPrk, NoAcc, Keterangan, Valas;

-- Sp_LapPosisiBankKasHarianDet
CREATE PROCEDURE IF NOT EXISTS Sp_LapPosisiBankKasHarianDet AS select A.*, B.*

from dbDeposito A

left outer join DBPERKIRAAN B on B.Perkiraan=A.Bank

where A.Bank=@NoAcc;

-- sp_LapSaldoAwal
CREATE PROCEDURE IF NOT EXISTS sp_LapSaldoAwal AS -- DECLARE REMOVED,@SaldoAwalBulan numeric(18,2),@SaldoAwalBulanBerjalan numeric(18,2),@dk TINYINT

-- DECLARE REMOVED,@SaldoAwalBulanD numeric(18,2),@SaldoAwalBulanBerjalanD numeric(18,2), @SaldoGiro numeric(18,2)

-- DECLARE REMOVED, @SaldoGiroTolakan Numeric(18,2)



select @SaldoAwal=0,@SaldoAwalBulan=0,@SaldoAwalBulanBerjalan=0

select @SaldoAwalD=0,@SaldoAwalBulanD=0,@SaldoAwalBulanBerjalanD=0



-- SET REMOVEDCase when @Divisi in ('-','') then '%' else @Divisi 



    select @SaldoAwalBulan=sum(case when b.DK=0 then COALESCE(AwalDRp,0)

                                    else COALESCE(AwalKRp,0) 

                               ),

           @SaldoAwalBulanD=sum(case when b.DK=0 then COALESCE(Awald,0)

                                    else COALESCE(AwalK,0) 

                               )

    from dbNeraca a

    left outer join DBPERKIRAAN b on b.Perkiraan=a.Perkiraan

    where a.Bulan=month(@tglAw) and a.Tahun=year(@tglAw) and a.Perkiraan=@Perkiraan and (devisi like @Divisi)

    group by a.Perkiraan  

  

    -- SET REMOVED@SaldoAwalBulan

    -- SET REMOVED@SaldoAwalBulanD

    if day(@tglAw)<>1

    select @SaldoAwalBulanBerjalan=sum(case when a.Perkiraan=@Perkiraan then a.DebetRp       

                                              when a.Lawan=@Perkiraan then -a.DebetRp

                                              else 0              

                                         ),

             @SaldoAwalBulanBerjalanD=sum(case when a.Perkiraan=@Perkiraan then a.Debet       

                                              when a.Lawan=@Perkiraan then -a.Debet

                                              else 0              

                                         ) 

      from(                                   

      Select a.Perkiraan,a.Lawan,a.DebetRp,a.Debet

      from dbTransaksi a

      where a.Tanggal<@tglAw and  (a.Perkiraan=@Perkiraan or a.Lawan=@Perkiraan)

		and YEAR(a.Tanggal)=YEAR(@tglAw) and MONTH(a.Tanggal)=MONTH(@TglAw)

		and a.Tanggal>='06/01/2012'

      Union all

      Select a.Perkiraan,a.Lawan,a.DebetRp,a.Debet

      from vwtransaksi a

      where a.Tanggal<@tglAw and  (a.Perkiraan=@Perkiraan or a.Lawan=@Perkiraan)

		and YEAR(a.Tanggal)=YEAR(@tglAw) and MONTH(a.Tanggal)=MONTH(@TglAw)

		and a.Tanggal>='06/01/2012'

		and JENIS Like '%SK%' and (a.lawan =@Perkiraan or a.PERKIRAAN=@Perkiraan))

	  a	

      -- SET REMOVED@SaldoAwal+COALESCE(@SaldoAwalBulanBerjalan,0)

      -- SET REMOVED@SaldoAwalD+COALESCE(@SaldoAwalBulanBerjalanD,0)

    

    Select @SaldoGiro=SUM(Case when NoGiro like '%T' then 0.00 else A.DebetRp ), 

           @SaldoGiroTolakan=SUM(Case when NoGiro like '%T' then A.DebetRp else 0.00 )

    from DBGIRO A

    where A.Tipe='PT' and A.TglBuka<=@TglAk and (A.TglCair>@TglAk or a.TglCair is null) and kas = @Perkiraan

    and BuktiBuka not like '+%' --(giro gempol)

    select @SaldoAwal SaldoAwal, @SaldoAwalD SaldoAwalD, 

		(select sum(Debet-Kredit) from dbBon where Tanggal<=@TglAk and Devisi=@Divisi and Perkiraan=@Perkiraan and KodeVls='IDR') SaldoBon,

		(select sum(Debet-Kredit) from dbBon where Tanggal<=@TglAk and Devisi=@Divisi and Perkiraan=@Perkiraan and KodeVls='U$') SaldoBonD,

		(select sum(Debet-Kredit) from dbBon where Tanggal<=@TglAk and Devisi=@Divisi and Perkiraan=@Perkiraan and KodeVls='EUR') SaldoBonE, 

		(select sum(Debet-Kredit) from dbBon where Tanggal<=@TglAk and Devisi=@Divisi and Perkiraan=@Perkiraan and KodeVls='AUD') SaldoBonA,

		(select sum(Debet-Kredit) from dbBon where Tanggal<=@TglAk and Devisi=@Divisi and Perkiraan=@Perkiraan and KodeVls='DH') SaldoBonDH,

		@SaldoGiro SaldoGiro, @SaldoGiroTolakan SaldoGiroTolakan



Select * from DBBON;

-- sp_LapSusutAktiva
CREATE PROCEDURE IF NOT EXISTS sp_LapSusutAktiva AS if @Divisi<>'-'

select distinct left(a.Perkiraan,11) as GrpPerkiraan, a.Devisi, a.Perkiraan, a.Keterangan, a.Quantity, a.Persen, a.Tanggal, Kode=substring(a.Perkiraan,1,3), 

	NilaiAk_=((select sum(COALESCE(d.awal,0)+case when d.Bulan=1 then 0 else COALESCE(d.md,0)-COALESCE(d.mk,0) ) from dbaktivadet d 

   where d.devisi=a.devisi and d.perkiraan=a.perkiraan and d.bulan<=@bulan and d.tahun=@tahun)-

   (select sum(COALESCE(d.awalsusut,0)+case when d.Bulan=1 then 0 else COALESCE(d.sk,0)-COALESCE(d.sd,0) ) from dbaktivadet d 

   where d.devisi=a.devisi and d.perkiraan=a.perkiraan and d.bulan<=@bulan and d.tahun=@tahun)),

  awal=(select sum(COALESCE(d.awal,0)+case when d.Bulan=@Bulan then 0 else COALESCE(d.md,0)-COALESCE(d.mk,0) ) from dbaktivadet d 

                 where d.devisi=a.devisi and d.perkiraan=a.perkiraan and d.bulan<=@bulan and d.tahun=@tahun),



  MD=COALESCE((select COALESCE(d.md,0) from dbaktivadet d where d.devisi=a.devisi and d.perkiraan=a.perkiraan and 

   d.bulan=@bulan and d.tahun=@tahun),0),

  MK=COALESCE((select COALESCE(d.mk,0) from dbaktivadet d where d.devisi=a.devisi and d.perkiraan=a.perkiraan and 

   d.bulan=@bulan and d.tahun=@tahun),0),

  akhir=(select sum(COALESCE(d.awal,0)+COALESCE(d.md,0)-COALESCE(d.mk,0)) from dbaktivadet d 

                 where d.devisi=a.devisi and d.perkiraan=a.perkiraan and d.bulan<=@bulan and d.tahun=@tahun),

  AwalSusut=(select sum(COALESCE(d.awalsusut,0)+case when d.Bulan=@Bulan then 0 else COALESCE(d.sk,0)-COALESCE(d.sd,0) ) from dbaktivadet d 

    where d.devisi=a.devisi and d.perkiraan=a.perkiraan and d.bulan<=@bulan and d.tahun=@tahun),


  awalSusutJan=(select COALESCE(d.awalsusut,0) from dbaktivadet d where d.devisi=a.devisi and d.perkiraan=a.perkiraan and d.bulan=1 and d.tahun=@tahun),

 

  SK=COALESCE((select COALESCE(d.sk,0) from dbaktivadet d where d.devisi=a.devisi and d.perkiraan=a.perkiraan and 

   d.bulan=@bulan and d.tahun=@tahun),0),

  SD=COALESCE((select COALESCE(d.sd,0) from dbaktivadet d where d.devisi=a.devisi and d.perkiraan=a.perkiraan and 

   d.bulan=@bulan and d.tahun=@tahun),0),

  AkhirSusut=(select sum(COALESCE(d.awalsusut,0)+COALESCE(d.sk,0)-COALESCE(d.sd,0)) from dbaktivadet d 

    where d.devisi=a.devisi and d.perkiraan=a.perkiraan and d.bulan<=@bulan and d.tahun=@tahun),

  SusutTahun=(select sum(COALESCE(d.sk,0)-COALESCE(d.sd,0)) from dbaktivadet d 

    where d.devisi=a.devisi and d.perkiraan=a.perkiraan and d.bulan<=@bulan and d.tahun=@tahun),



  NilaiAk=((select sum(COALESCE(d.awal,0)+COALESCE(d.md,0)-COALESCE(d.mk,0)) from dbaktivadet d 

   where d.devisi=a.devisi and d.perkiraan=a.perkiraan and d.bulan<=@bulan and d.tahun=@tahun)-

   (select sum(COALESCE(d.awalsusut,0)+COALESCE(d.sk,0)-COALESCE(d.sd,0)) from dbaktivadet d 

   where d.devisi=a.devisi and d.perkiraan=a.perkiraan and d.bulan<=@bulan and d.tahun=@tahun)),

   b.Keterangan NamaPerkiraan 

 from dbaktiva A 

      left outer join dbperkiraan b on b.perkiraan=left(a.Perkiraan,11)

 where a.Devisi=@Divisi and

  ((case when @bulan=1 then 

     (select COALESCE(d.awal,0) from dbaktivadet d 

    where d.devisi=a.devisi and d.perkiraan=a.perkiraan and d.bulan=@bulan and d.tahun=@tahun)

         else

    (select sum(COALESCE(d.awal,0)+COALESCE(d.md,0)-COALESCE(d.mk,0)) from dbaktivadet d 

    where d.devisi=a.devisi and d.perkiraan=a.perkiraan and d.bulan<@bulan and d.tahun=@tahun)

            )<> 0 or

  COALESCE((select COALESCE(d.md,0) from dbaktivadet d where d.devisi=a.devisi and d.perkiraan=a.perkiraan and 

   d.bulan=@bulan and d.tahun=@tahun),0)<> 0 or

  COALESCE((select COALESCE(d.mk,0) from dbaktivadet d where d.devisi=a.devisi and d.perkiraan=a.perkiraan and 

   d.bulan=@bulan and d.tahun=@tahun),0)<> 0)

 order by a.devisi,a.Perkiraan



if @Divisi='-'

select distinct left(a.Perkiraan,11) as GrpPerkiraan, a.Devisi, a.Perkiraan, a.Keterangan, a.Quantity, a.Persen, a.Tanggal, Kode=substring(a.Perkiraan,1,3), 

NilaiAk_=((select sum(COALESCE(d.awal,0)+case when d.Bulan=1 then 0 else COALESCE(d.md,0)-COALESCE(d.mk,0) ) from dbaktivadet d 

   where d.perkiraan=a.perkiraan and d.bulan<=@bulan and d.tahun=@tahun)-

   (select sum(COALESCE(d.awalsusut,0)+case when d.Bulan=1 then 0 else COALESCE(d.sk,0)-COALESCE(d.sd,0) ) from dbaktivadet d 

   where d.perkiraan=a.perkiraan and d.bulan<=@bulan and d.tahun=@tahun)),

  awal=(select sum(COALESCE(d.awal,0)+case when d.Bulan=@Bulan then 0 else COALESCE(d.md,0)-COALESCE(d.mk,0) ) from dbaktivadet d 

                 where d.perkiraan=a.perkiraan and d.bulan<=@bulan and d.tahun=@tahun),

  MD=COALESCE((select sum(COALESCE(d.md,0)) from dbaktivadet d where d.perkiraan=a.perkiraan and 

   d.bulan=@bulan and d.tahun=@tahun),0),

  MK=COALESCE((select sum(COALESCE(d.mk,0)) from dbaktivadet d where d.perkiraan=a.perkiraan and 

   d.bulan=@bulan and d.tahun=@tahun),0),

  akhir=(select sum(COALESCE(d.awal,0)+COALESCE(d.md,0)-COALESCE(d.mk,0)) from dbaktivadet d 

                 where d.perkiraan=a.perkiraan and d.bulan<=@bulan and d.tahun=@tahun),

  AwalSusut=(select sum(COALESCE(d.awalsusut,0)+case when d.Bulan=@Bulan then 0 else COALESCE(d.sk,0)-COALESCE(d.sd,0) ) from dbaktivadet d 

    where d.perkiraan=a.perkiraan and d.bulan<=@bulan and d.tahun=@tahun),



  awalSusutJan=(select sum(COALESCE(d.awalsusut,0)) from dbaktivadet d where d.perkiraan=a.perkiraan and d.bulan=1 and d.tahun=@tahun),



  SK=COALESCE((select sum(COALESCE(d.sk,0)) from dbaktivadet d where d.perkiraan=a.perkiraan and 

   d.bulan=@bulan and d.tahun=@tahun),0),

  SD=COALESCE((select sum(COALESCE(d.sd,0)) from dbaktivadet d where d.perkiraan=a.perkiraan and 

   d.bulan=@bulan and d.tahun=@tahun),0),

  AkhirSusut=(select sum(COALESCE(d.awalsusut,0)+COALESCE(d.sk,0)-COALESCE(d.sd,0)) from dbaktivadet d 

    where d.perkiraan=a.perkiraan and d.bulan<=@bulan and d.tahun=@tahun),

  SusutTahun=(select sum(COALESCE(d.sk,0)-COALESCE(d.sd,0)) from dbaktivadet d 

    where d.perkiraan=a.perkiraan and d.bulan<=@bulan and d.tahun=@tahun),



  NilaiAk=((select sum(COALESCE(d.awal,0)+COALESCE(d.md,0)-COALESCE(d.mk,0)) from dbaktivadet d 

   where d.perkiraan=a.perkiraan and d.bulan<=@bulan and d.tahun=@tahun)-

   (select sum(COALESCE(d.awalsusut,0)+COALESCE(d.sk,0)-COALESCE(d.sd,0)) from dbaktivadet d 

   where d.perkiraan=a.perkiraan and d.bulan<=@bulan and d.tahun=@tahun)),

   b.Keterangan NamaPerkiraan  

 from dbaktiva A

      left outer join dbperkiraan b on b.perkiraan=left(a.Perkiraan,11)

where ((case when @bulan=1 then 

     (select COALESCE(d.awal,0) from dbaktivadet d 

    where d.devisi=a.devisi and d.perkiraan=a.perkiraan and d.bulan=@bulan and d.tahun=@tahun)

         else

    (select sum(COALESCE(d.awal,0)+COALESCE(d.md,0)-COALESCE(d.mk,0)) from dbaktivadet d 

    where d.devisi=a.devisi and d.perkiraan=a.perkiraan and d.bulan<@bulan and d.tahun=@tahun)

            )<> 0 or

  COALESCE((select COALESCE(d.md,0) from dbaktivadet d where d.devisi=a.devisi and d.perkiraan=a.perkiraan and 

   d.bulan=@bulan and d.tahun=@tahun),0)<> 0 or

  COALESCE((select COALESCE(d.mk,0) from dbaktivadet d where d.devisi=a.devisi and d.perkiraan=a.perkiraan and 

   d.bulan=@bulan and d.tahun=@tahun),0)<> 0)

 order by a.devisi,a.Perkiraan;

-- SP_LR
CREATE PROCEDURE IF NOT EXISTS SP_LR AS tran

if @choice='I'

insert into dbLRHPP (Devisi, Nomor, Perkiraan, Keterangan, Grup, Tipe, Tanda, Jumlah, Persen, Tampil,bulan, Tahun,IsLRHPP)

 values (@Devisi, @Nomor, @Perkiraan, @Keterangan, @Grup, @Tipe, @Tanda, @Jumlah, @Persen, @Tampil, @bulan, @Tahun,@isLRHpp)

 if @@error <> 0 goto jikasalah



if @choice='U'

update dbLRHPP set Perkiraan=@Perkiraan, Keterangan=@Keterangan, Grup=@Grup, Tipe=@Tipe, Tanda=@Tanda, Jumlah=@Jumlah, 

      Persen=@Persen, Tampil=@Tampil

 where Devisi=@Devisi and Nomor=@Nomor and bulan=@bulan and tahun=@Tahun and IsLRHPP=@isLRHpp

if @@error <> 0 goto jikasalah



if @choice='D'

delete  dbLRHPP where Devisi=@Devisi and Nomor=@Nomor and bulan=@bulan and tahun=@Tahun

 if @@error <> 0 goto jikasalah



commit tran

return

jikasalah:

 rollback tran

 raiserror('Proses Input Data Gagal',16,1)

 return;

-- Sp_Menu
CREATE PROCEDURE IF NOT EXISTS Sp_Menu AS tran

if @Choice='I'

Insert into dbmenu (kodeMenu,Keterangan,OL, L0, ACCESS)

  Values(@Kodemenu,@Keterangan,@OL, @L0, @ACCESS)

 if @Choice='U'

update dbmenu set kodemenu=@Kodemenu, Keterangan=@Keterangan, OL=@OL,

                    L0=@L0, ACCESS=@ACCESS 

  where kodemenu=@Kodemenu

 else if @Choice='D'

delete dbmenu 

  where kodemenu=@Kodemenu



if @@ERROR<>0 Goto JikaSalah

commit tran

Return

JikaSalah: Rollback Tran

           Return;

-- Sp_Mesin
CREATE PROCEDURE IF NOT EXISTS Sp_Mesin AS tran

if @choice='I'

insert into dbMesin (KodeMesin, NamaMesin)

	values (@KodeMesin, @NamaMesin)

	if @@error <> 0 goto jikasalah



if @choice='U'

update dbMesin set NamaMesin=@NamaMesin,KodeMesin=@KodeMesin

             where KodeMesin=@OldKode

	if @@error <> 0 goto jikasalah



if @choice='D'

delete  dbMesin where KodeMesin=@OldKode

	if @@error <> 0 goto jikasalah



commit tran

return

jikasalah:

	rollback tran

	raiserror('Proses Input Data Gagal',16,1)

	return;

-- sp_NerajaLajur
CREATE PROCEDURE IF NOT EXISTS sp_NerajaLajur AS -- SET REMOVEDCase when @Devisi in ('-','') then '%' else @Devisi  

 select @Devisi Divisi, A.Perkiraan,a.keterangan,

 case when a.DK=0 then sum(b.AwalDRp) 

      else 0

  as SaldoAwD,

 case when a.DK=1 then sum(b.AwalKRp) 

      else 0

  as SaldoAwk,

 MD=sum(b.MDRp),

 MK=sum(b.MKRp),

 JPD=sum(b.JPDRp),

 JPK=sum(b.JPKRp),

 RLD=sum(b.RLDRp),

 RLK=sum(b.RLKRp),

 case when a.DK=0 then sum(b.AkhirDRp)

      else 0

  as SaldoAkD,

 case when a.DK=1 then sum(b.AkhirKRp)

      else 0

  as SaldoAkK

 from dbPerkiraan A

      left outer join DBNERACA b on b.Perkiraan=A.Perkiraan

 where

 a.Perkiraan in (select perkiraan from dbAksesPerkiraan where userid=@IdUser) and 

 b.Devisi like @Devisi and b.Bulan=@Bulan and b.Tahun=@Tahun

 group by A.Perkiraan,a.keterangan,a.DK

 having (sum(b.AwalDRp)<>0 or sum(b.AwalKRp)<>0 or sum(b.MDRp)<>0 or sum(b.MKRp)<>0 

 or sum(b.JPDRp)<>0 or sum(b.JPKRp)<>0 or sum(b.RLDRp)<>0 or sum(b.RLKRp)<>0 or

 sum(b.AkhirDRp)<>0 or sum(b.AkhirKRp)<>0) 

 order by a.perkiraan;

-- Sp_PajakMasuk
CREATE PROCEDURE IF NOT EXISTS Sp_PajakMasuk AS Tran

if @Choice='I'

Select @Urut=Max(urut) from DBPajakMasuk where NoBukti=@NoBukti

  -- SET REMOVEDISNULL(@Urut,0)+1

  Insert into DBPajakMasuk ( NoBukti, Urut, NOFPJ, TGLFPJ, NPPn, TglLaporFPJ, TipePPh, NoPPh, TglPPh, 

                             nPPh, TglLaporPPh, NPWP, NamaPKP, AlamatPKP1, AlamatPKP2, KotaPKP)

  Values ( @NoBukti, @Urut, @NoFPJ, @TglFpj, @nPPn, @TglLaporFpj, @TipePph, @NoPph, @TglPPh, 

           @nPPh, @TglLaporPPh, @npwp, @NamaPKP, @AlamatPkp1, @AlamatPkp2, @kotaPKP)                             

 else if @Choice='U'

update DBPajakMasuk Set NOFPJ=@NoFPJ , TGLFPJ=@TglFpj, NPPn=@nPPn, TglLaporFPJ=@TglLaporFpj, 

                          TipePPh=@TipePph, NoPPh=@NoPph, TglPPh=@TglPPh, nPPh=@nPPh, 

                          TglLaporPPh=@TglLaporPPh, NPWP=@npwp, NamaPKP=@NamaPKP, 

                          AlamatPKP1=@AlamatPkp1, AlamatPKP2=@AlamatPkp2, KotaPKP=@kotaPKP

  where NoBukti=@NoBukti and Urut=@Urut

 else if @Choice='D'

Delete DBPajakMasuk

  where NoBukti=@NoBukti and Urut=@Urut



if @@ERROR<>0 Goto JikaSalah

Commit Tran

Return

JikaSalah: Rollback Tran

           Return;

-- sp_PBiaya
CREATE PROCEDURE IF NOT EXISTS sp_PBiaya AS if @choice='I'

select @urut=COALESCE(max(urut),0)+1 from dbPBiaya Where NoBuktiInv=@NoBuktiInv

    If @urut is null -- SET REMOVED1

	insert into dbPBiaya(KodeBiaya,Keterangan,Nilai,KodeVls, Kurs,NoBuktiInv,Urut)

	values (@KodeBiaya,@Keterangan,@Nilai,@KodeVls, @Kurs,@NoBuktiInv,@urut)



if @choice='U'

Update dbPBiaya set KodeBiaya=@KodeBiaya,Keterangan=@Keterangan,Nilai=@Nilai,NoBuktiInv=@NoBuktiInv,

		                KodeVls=@KodeVls, Kurs=@Kurs

	where KodeBiaya=@OldKode and Urut=@urut



if @choice='D'

delete dbPBiaya

	where KodeBiaya=@OldKode and Urut=@urut;

-- SP_PemakaianBhn
CREATE PROCEDURE IF NOT EXISTS SP_PemakaianBhn AS tran

if @choice='I'

select @urut=COALESCE(max(urut),0)+1 from DBPemakaianBhndet Where NoBukti=@NoBukti

  	If @urut is null -- SET REMOVED1

  	if not exists(select * from DBPemakaianBhn Where NoBukti=@NoBukti) 

  	insert into DBPemakaianBhn (NOBUKTI, NOURUT, TANGGAL,KodeGdg,NOTE,IDUser)

    		values (@NOBUKTI, @NOURUT, @TANGGAL,@KodeGdg,@NOTE, @IDUser)

		if @@error<>0  goto jikasalah

  	

  	insert into DBPemakaianBhnDET (NOBUKTI,URUT,KODEBRG, Nosat, Isi, Sat_1, Sat_2,

                            SaldoComp,QntOpname,Selisih,QNTDB,QNTCR, HARGA,SaldoComp2,QntOpname2,Selisih2,QNTDB2,QNTCR2)

  	values(@NOBUKTI,@URUT,@KODEBRG, @Nosat, @Isi, @Sat_1, @Sat_2, 

         		@SaldoComp,@QntOpname,@Selisih,@QNTDB,@QNTCR, @HARGA,@SaldoComp2,@QntOpname2,@Selisih2,@QNTDB2,@QNTCR2)

	if @@error<>0  goto jikasalah



if @choice='U'

update DBPemakaianBhnDET set Kodebrg=@KODEBRG, Nosat=@NoSat, Isi=@Isi, Sat_1=@Sat_1, Sat_2=@Sat_2, 

         		SaldoComp=@SaldoComp,QntOpname=@QntOpname,Selisih=@Selisih,QntDb=@QNTDB,QntCR=@QNTCR, Harga=@HARGA,

		SaldoComp2=@SaldoComp2,QntOpname2=@QntOpname2,Selisih2=@Selisih2,QntDb2=@QNTDB2,QntCR2=@QNTCR2

  	where nobukti=@nobukti and urut=@urut

	if @@error<>0  goto jikasalah



if @choice='D'

delete DBPemakaianBhnDET where nobukti=@nobukti and  urut=@urut 

	if @@error<>0  goto jikasalah

  	if not exists( select nobukti from DBPemakaianBhnDET where nobukti=@nobukti)

  	delete DBPemakaianBhn where nobukti=@nobukti

		if @@error<>0  goto jikasalah


Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- sp_PembayaranPO
CREATE PROCEDURE IF NOT EXISTS sp_PembayaranPO AS tran

if @Choice='I'

insert into [DBPembayaranPO] (NOBUKTI,Keterangan, DP,Persentase,KodeVls,Nilai)

   values (@NOBUKTI, @Keterangan, @DP, @Persentase,@KodeVls,@Nilai)



if @Choice='U'

update [DBPembayaranPO] set Keterangan=@Keterangan, DP=@DP,Persentase=@Persentase,KodeVls=@KodeVls,Nilai=@Nilai 

  where NoBukti=@NoBukti and Keterangan=@OldKet



if @Choice='D'

delete [DBPembayaranPO] where NoBukti=@NoBukti and Keterangan=@OldKet



if @@error<>0  goto jikasalah

Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- Sp_PenerimaanBrgJadi
CREATE PROCEDURE IF NOT EXISTS Sp_PenerimaanBrgJadi AS Tran

If @Choice='I'

Select @Urut=MAX(Urut) from dbPenerimaanBrgJadidet where nobukti=@NoBukti

  -- SET REMOVEDISNULL(@urut,0)+1

  If not Exists(Select 'True' From dbPenerimaanbrgjadi where nobukti=@NoBukti)

  Insert into dbPenerimaanbrgjadi(Nobukti,Nourut,Tanggal,Keterangan, Shift, NoPenyerahan)

    Values(@NoBukti, @Nourut, @Tanggal, @Keterangan, @Shift, @NoPenyerahan)

  

  Insert into dbPenerimaanbrgjadidet (Nobukti, Urut, kodebrg, Qnt, Qnt2, Sat_1, Sat_2, Nosat, Isi, Kodegdg)

  Values(@NoBukti, @Urut, @Kodebrg, @Qnt, @Qnt2, @Sat_1, @Sat_2, @Nosat, @Isi, @Kodegdg)



else if @Choice='U'

update dbpenerimaanbrgjadidet set Kodebrg=@Kodebrg, Qnt=@Qnt, Qnt2=@Qnt2, Sat_1=@Sat_1, Sat_2=@Sat_2, 

                                    Nosat=@Nosat, Isi=@Isi, Kodegdg=@Kodegdg

  where nobukti=@NoBukti and Urut=@Urut

 else if @Choice='D'

delete dbpenerimaanbrgjadidet 

  where nobukti=@NoBukti and Urut=@Urut

  If not Exists(Select 'True' From dbPenerimaanbrgjadidet where nobukti=@NoBukti)

  delete dbpenerimaanbrgjadi

  where nobukti=@NoBukti 



if @@error<>0 Goto JikaSalah

Commit Tran

Return

JikaSalah: Rollback Tran

           Return;

-- sp_PenerimaKomisi
CREATE PROCEDURE IF NOT EXISTS sp_PenerimaKomisi AS tran



-- DECLARE REMOVED

-- SET REMOVED@Alamat1+CHAR(13)+

                Case when @Alamat2<>'' then @Alamat2+CHAR(13)

                     else ''

                +Case when @KodeKota<>'' then (Select NamaKota from DBKOTA where KodeKota=@KodeKota) else '' 

if @mode='I'

insert into dbCustSupp(KodeCustSupp, NamaCustSupp, Usaha, Alamat1, Alamat2, Kota, KodePos, Negara,

  	                       Telpon, Fax, Email, NPWP, Tanggal, Plafon, Hari, Berikat, Jenis,

                           NamaPKP, AlamatPkp1, Alamatpkp2, KotaPkp, Sales,Kodevls,Perkiraan, 

                           KodeTipe,isPpn,Kind,HariHutPiut,ContactP,Alamat1ContP,Alamat2ContP,

                           KotaContP,NegaraContP,TelpContP,FaxContP,EmailContP,KODEPOSContP,HPContP,

                           SyaratPenerimaan,SyaratPembayaran,Agent,Alamat1A,Alamat2A,KotaA,NegaraA,

                           ContactA,TelpA,FaxA,EmailA,KODEPOSA,HPA,EmailContA,IsAktif,

                           PortOfLoading, CountryOfOrigin,IsKontrak,tglinput,PPN, HargaKe,Att,bank,NoAcc,KodeJenis,KodeBank,

                           KodeDealer,IsPelanggan)

  	values(@KodeCustSupp, @NamaCustSupp, @Usaha, @Alamat1, @Alamat2, @KodeKota, @KodePos, @Negara, 

		   @Telpon, @Fax, @Email, @NPWP, @Tanggal, @Plafon, @Hari, @Berikat, @Jenis,

           @NamaPKP, @AlamatPkp1, @Alamatpkp2, @KotaPkp, @Sales,@kodevls,@Perkiraan, @KodeTipe, 0,@Kind,@HariHutPiut,

           @ContactP,@Alamat1ContP,@Alamat2ContP,@KotaContP,@NegaraContP,@TelpContP,@FaxContP,@EmailContP,

           @KODEPOSContP,@HPContP,@SyaratPenerimaan,@SyaratPembayaran,@Agent,@Alamat1A,@Alamat2A,@KotaA,@NegaraA,

           @ContactA,@TelpA,@FaxA,@EmailA,@KODEPOSA,@HPA,@EmailContA,@IsAktif,

           @PortOfLoading, @CountryOfOrigin,@IsKontrak,datetime('now'),@PPN, @HargaKe,@Att,@Bank,@NoACC,

           @KodeJenis,@KodeBank,@Kodedealer,@IsPelanggan)

    if @@error <> 0 goto JikaSalah



if @Mode='U'

Update dbCustSupp set NamaCustSupp=@NamaCustSupp, Usaha=@Usaha, 

  	                      Alamat1=@Alamat1, Alamat2=@Alamat2, Kota=@KodeKota, KodePos=@KodePos, Negara=@Negara,

  	                      Telpon=@Telpon, Fax=@Fax, Email=@Email, NPWP=@NPWP, Tanggal=@Tanggal, Plafon=@Plafon, 

  	                      Hari=@Hari, Berikat=@Berikat, Jenis=@Jenis,

                          NamaPKP=@NamaPKP, AlamatPkp1=@AlamatPkp1, Alamatpkp2=@AlamatPkp2, 

                          KotaPkp=@KotaPKP, Sales=@Sales,Kodevls=@KodeVls,Perkiraan=@Perkiraan, 

                          KodeTipe=@KodeTipe,isPpn=@IsPpn,Kind=@Kind,HariHutPiut=@HariHutPiut,

                          ContactP=@ContactP,Alamat1ContP=Alamat1ContP,Alamat2ContP=@Alamat2ContP,

                          KotaContP=@KotaContP,NegaraContP=@NegaraContP,TelpContP=@TelpContP,

                          FaxContP=@FaxContP,EmailContP=@EmailContP,KODEPOSContP=@KODEPOSContP,HPContP=@HPContP,

                          SyaratPenerimaan=@SyaratPenerimaan,SyaratPembayaran=@SyaratPembayaran,Agent=@Agent,

                          Alamat1A=@Alamat1A,Alamat2A=@Alamat2A,KotaA=@KotaA,NegaraA=@NegaraA,

                          ContactA=@ContactA,TelpA=@TelpA,FaxA=@FaxA,EmailA=@EmailA,KODEPOSA=@KODEPOSA,

                          HPA=@HPA,EmailContA=@EmailContA,IsAktif=@IsAktif,

                          PortOfLoading=@PortOfLoading, CountryOfOrigin=@CountryOfOrigin,IsKontrak=@IsKontrak,PPN=@PPN, HargaKe=@HargaKe

  						  ,Att=@Att,bank=@Bank ,NoAcc =@NoACC,KodeJenis=@KodeJenis,KodeBank=@KodeBank,KodeDealer=@Kodedealer,

  						  ISpelanggan=@IsPelanggan

  	where KodeCustSupp=@KodeCustSupp

  	if @@error <> 0 goto JikaSalah



if @Mode='D'

Delete dbCustSupp 

    where KodeCustSupp=@KodeCustSupp

    if @@error <> 0 goto JikaSalah


commit tran

return

JikaSalah:  rollback tran

            return;

-- sp_Penjualan
CREATE PROCEDURE IF NOT EXISTS sp_Penjualan AS tran



if @Choice='I'

insert into DBPenjualan(NoBukti,Urut,Tanggal,JatuhTempo,KodeCustSupp,PPn,

		KodeTipe,KodeSubTipe,Qnt,Harga,NDPP,NPPN,NNet,

		KodeVls, Kurs, NDPPD, NPPND, NNetD,

		AccPersediaan,AccPPN,AccHutPiut,IsExcel)

	Values(@NoBukti,@Urut,@Tanggal,@JatuhTempo,@KodeCustSupp,@PPn,

		@KodeTipe,@KodeSubTipe,@Qnt,@Harga,@NDPP,@NPPN,@NNET,

		@KodeVls, @Kurs, @NDPPD, @NPPND, @NNetD,

		@AccPersediaan,@AccPPN,@AccHutPiut,@IsExcel)

	if @@error<>0  goto jikasalah



if @Choice='U'

update DBPenjualan set Tanggal=@Tanggal, JatuhTempo=@JatuhTempo, KodeCustSupp=@KodeCustSupp,

	PPn=@PPn, KodeTipe=@KodeTipe, KodeSubTipe=@KodeSubTipe, Qnt=@Qnt, Harga=@Harga,

	NDPP=@NDPP, NPPN=@NPPN, NNET=@NNET, KodeVls=@KodeVls, Kurs=@Kurs, 

	NDPPD=@NDPPD, NPPND=@NPPND, NNetD=@NNetD,

	AccPersediaan=@AccPersediaan, AccPPN=@AccPPN, AccHutPiut=@AccHutPiut

	where NoBukti=@NoBukti and Urut=@Urut

	if @@error<>0  goto jikasalah



else if @Choice='D'

Delete DBPenjualan where NoBukti=@Nobukti and Urut=@Urut

	if @@error<>0  goto jikasalah



Commit Tran

Return

JikaSalah: RollBack Tran

           Return;

-- sp_PenyerahanBhn
CREATE PROCEDURE IF NOT EXISTS sp_PenyerahanBhn AS tran

if @Choice='I'

if @NoBppB not like '%LPB%'

  select @Urut=COALESCE(max(urut),0)+1 from dbPenyerahanBhndet Where NoBukti=@NoBukti

  

  if not exists(select * from dbPenyerahanBhn Where NoBukti=@NoBukti) 

  insert into dbPenyerahanBhn (Devisi,NOBUKTI, NOURUT, TANGGAL,KODEGDG,NoBPPB, IsSampel,KdDep,NoJurnal,NoPOL,Supir)

    values (@Devisi,@NOBUKTI, @NOURUT, @TANGGAL,@KODEGDG,@NoBppB,@IsSampel,@KdDep,@Perkiraan,@NoPOL,@Supir)

  

  insert into dbPenyerahanBhnDET (NOBUKTI, URUT, KODEBRG, QNT, NOSAT, ISI, SAT,Qnt2,

	NoSPK, UrutSPK, NoSatSPK,KetBrg,Harga)

  values(@NOBUKTI, @URUT, @KODEBRG, @Qnt, @NoSat, @Isi, @Sat,@Qnt2,

	@NoBppB, @UrutSPK, @NoSatSPK,@KetBrg,@Harga)



if @Choice='U'

update dbPenyerahanBhnDET 

  set Qnt=@QNT, NOSAT=@NoSat, ISI=@ISI, SAT=@Sat,Qnt2=@Qnt2,Harga=@Harga

  where NoBukti=@NoBukti and Urut=@Urut



if @Choice='D'

delete dbPenyerahanBhnDET where NoBukti=@NoBukti and Urut=@Urut 

  if not exists( select NoBukti from dbPenyerahanBhnDET where NoBukti=@NoBukti)

  delete dbPenyerahanBhn where NoBukti=@NoBukti


if @@error<>0  goto jikasalah

Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- Sp_PerkCustSupp
CREATE PROCEDURE IF NOT EXISTS Sp_PerkCustSupp AS tran

if @choice='I'

Select @Urut=urut from DBPERKCUSTSUPP where KodeCustSupp=@KodeCustSupp

   -- SET REMOVEDISNULL(@urut,0)+1

	insert into dbPerkCustSupp (KodeCustSupp, Urut, Perkiraan,Tf,Do)

	values (@KodeCustSupp, @Urut, @Perkiraan,0,@choice)

	if @@error <> 0 goto jikasalah



if @choice='U'

update dbPerkCustSupp set KodeCustSupp=@KodeCustSupp,Perkiraan=@Perkiraan,Tf=0,Do=@Choice   

   where KodeCustSupp=@OldKodeCustSupp and Urut=@OldMUrut

	if @@error <> 0 goto jikasalah



if @choice='D'

delete  dbPerkCustSupp where KodeCustSupp=@OldKodeCustSupp and Urut=@OldMUrut

	   insert TempDelData

   select @OldKodeCustSupp,'dbPerkCustSupp'

	if @@error <> 0 goto jikasalah



commit tran

return

jikasalah:

	rollback tran

	raiserror('Proses Input Data Gagal',16,1)

	return;

-- SP_PERKIRAAN
CREATE PROCEDURE IF NOT EXISTS SP_PERKIRAAN AS tran

if @choice='I'

insert into dbPerkiraan (Perkiraan, Keterangan, Kelompok, Tipe, Valas, DK, Neraca,simbol, IsPPN, Lokasi,Tf,Do)

 values (@Perkiraan, @Keterangan, @Kelompok, @Tipe, @Valas, @DK, @Neraca,@simbol, @IsPPN, @Lokasi,0,@Choice)

 if @@error <> 0 goto jikasalah



if @choice='U'

update dbPerkiraan set Keterangan=@Keterangan, Kelompok=@Kelompok, Tipe=@Tipe, Valas=@Valas, DK=@DK, Neraca=@Neraca, simbol=@simbol, IsPPN=@IsPPN,

                        Lokasi=@Lokasi,Tf=0,Do=@Choice

 where Perkiraan=@Perkiraan

 if @@error <> 0 goto jikasalah



if @choice='D'

delete  dbPerkiraan where Perkiraan=@Perkiraan

       	insert TempDelData

      	select @Perkiraan,'dbPerkiraan'

 if @@error <> 0 goto jikasalah



commit tran

return

jikasalah:

 rollback tran

 raiserror('Proses Input Data Gagal',16,1)

 return;

-- SP_Persediaan
CREATE PROCEDURE IF NOT EXISTS SP_Persediaan AS Tran

if @Choice='I'

Insert into dbpersediaan(Bulan, Tahun, Devisi, Perkiraan, Saldo)

  Values(@Bulan, @Tahun, @Devisi, @Perkiraan, @Saldo)



else if @Choice='U'

update dbpersediaan set Saldo=@Saldo

  where Bulan=@Bulan and Tahun=@Tahun and Devisi=@Devisi and Perkiraan=@Perkiraan



else if @Choice='D'

Delete dbpersediaan 

  where Bulan=@Bulan and Tahun=@Tahun and Devisi=@Devisi and Perkiraan=@Perkiraan



if @@ERROR>0 Goto JikaSalah

Commit Tran

Return

JikaSalah: RollBack Tran

           Return;

-- Sp_PindahSaldoNeraca
CREATE PROCEDURE IF NOT EXISTS Sp_PindahSaldoNeraca AS -- DECLARE REMOVED,@xPerkiraan varchar(30),@xBulan int, @xtahun int,

@awalD numeric(18,2),@AwalDRp numeric(18,2),@AwalK numeric(18,2),@AwalKrp numeric(18,2),

@Valas varchar(15),@DK TINYINT

Declare Mydata Cursor For

Select B.Devisi, B.Perkiraan, Case when @bulan=12 then 1 else @bulan+1 ,

         Case when @bulan=12 then @tahun+1 else @tahun ,

         case when a.DK=0 then b.AkhirD

              else 0

          as SaldoAkD,

         case when a.DK=0 then b.AkhirDRp

              else 0

          as SaldoAkDRp,

         case when a.DK=1 then b.AkhirK

              else 0

          as SaldoAkK,

         case when a.DK=1 then b.AkhirKRp

              else 0

          as SaldoAkKRp,B.Valas,A.DK

  from DBNERACA B

       left Outer join dbperkiraan A on a.perkiraan=b.perkiraan

  where b.Devisi like Case when @devisi IN('-','') then '%' else @devisi  and a.Perkiraan=@Perkiraan and

        b.Bulan=@bulan and b.Tahun=@tahun 

open mydata 

Fetch next from Mydata Into @xDevisi,@xPerkiraan,@xBulan,@xtahun,@awalD,@AwalDRp,@AwalK,@AwalKrp, @Valas, @DK

While @@FETCH_STATUS=0

if not Exists(Select 'True' From DBNERACA where Devisi=@xdevisi and Perkiraan=@xPerkiraan and

              Bulan=Case when @bulan=12 then 1 else @bulan+1  and Tahun=Case when @bulan=12 then @tahun+1 else @tahun )

	Insert into DBNERACA(Devisi,Valas,Perkiraan,Bulan,Tahun,AwalD,AwalDRp,AwalK,AwalKRp,DK)

	  Values (@xDevisi,@Valas,@xPerkiraan,@xBulan,@xtahun,@awalD,@AwalDRp,@AwalK,@AwalKrp,@DK)

	

	else

	update DBNERACA set AwalD=@awalD,AwalDRp=@AwalDRp,AwalK=@AwalK,AwalKRp=@AwalKrp,Valas=@Valas,DK=@DK

	  where Devisi=@xdevisi and Perkiraan=@xPerkiraan and

           Bulan=@xBulan and Tahun=@xtahun

	

	Fetch next from Mydata Into @xDevisi,@xPerkiraan,@xBulan,@xtahun,@awalD,@AwalDRp,@AwalK,@AwalKrp, @DK



close mydata

Deallocate Mydata;

-- Sp_PiutangAwal
CREATE PROCEDURE IF NOT EXISTS Sp_PiutangAwal AS if @choice='I'

select @urut=Max(urut) 

	from dbHUTPIUT 

	where KodeCustSupp=@kodesupp and NoFaktur=@nobukti 

	-- SET REMOVEDCase when @urut is null then 1 else @urut + 1 

	insert into dbHUTPIUT(NoFaktur,Tanggal,JatuhTempo,KodeCustSupp,Debet,Kredit,

		                  DebetD,KreditD,TipeTrans,Tipe,Urut,NoMsk,Valas,Kurs,Perkiraan)

	values(@Nobukti,@tglBukti,@TglJatuhTempo,@KodeSupp,@JumlahRp,@KreditRp,

	       Case when @Valas='IDR' then 0 else @Jumlah ,

	       Case when @Valas='IDR' then 0 else @Kredit ,@tipetrans,'PT',

		   @urut,0,@valas,@kurs,@Perkiraan)



if @choice='U'

update dbHUTPIUT set  debet=@JumlahRp,JatuhTempo=@tglJatuhTempo ,tanggal=@tglbukti,

                       DebetD=Case when @Valas='IDR' then 0 else @Jumlah ,Valas=@Valas,Kurs=@kurs,

                       Kredit=@KreditRp,

                       KreditD=Case when @Valas='IDR' then 0 else @Kredit  

 where NoFaktur=@Nobukti and KodeCustSupp=@kodesupp and 

       tipetrans=@tipetrans and urut=@urut and Perkiraan=@Perkiraan and Tipe='PT'



if @choice='D'

delete dbHUTPIUT 

 where NoFaktur=@Nobukti and KodeCustSupp=@kodesupp and 

       tipetrans=@tipetrans and urut=@urut and Perkiraan=@Perkiraan and Tipe='PT';

-- sp_PO
CREATE PROCEDURE IF NOT EXISTS sp_PO AS tran

if @Choice='I'

select @Urut=COALESCE(max(urut),0)+1 from dbPOdet Where NoBukti=@NoBukti

  if not exists(select * from dbPO Where NoBukti=@NoBukti) 

  insert into dbPO (Devisi,NOBUKTI, NOURUT, TANGGAL, TglJatuhTempo, KODESUPP, Handling, KodeExp, KETERANGAN, 

	FakturSUPP, KODEVLS, KURS, PPN, TIPEBAYAR, HARI, TipeDisc, DISC, DiscRp,IsClose,IsExp, kodegdg,Syarat,TglBatas,Tf,Do)

    values (@Devisi,@NOBUKTI, @NOURUT, @TANGGAL, @TglJatuhTempo, @KODESUPP, @Handling, @KodeExp, @KETERANGAN,

	@FakturSupp, @KODEVLS, @KURS, @PPN, @TIPEBAYAR, @HARI, @TipeDisc, @DISC, @DISCRP,@IsClose,@IsExp, @Kodegdg,@Syarat,@TglBatas,0,@choice)

  

  insert into dbPODET (NOBUKTI, URUT,  PPN, Disc, KODEBRG, QNT, NOSAT, ISI, SATUAN, HARGA, DISCP, DISCTOT,NoPPL,IsClose,Tolerate, UrutPPL,KURS,NamaBrg,Tf,Do)

  values(@NOBUKTI, @URUT, @PPN, @Disc, @KODEBRG, @Qnt, @NOSAT, @ISI, @SATUAN, @Harga, @DISCP, @DISCTOT,@NoPPL,@IsCloseD,@Tolerate, @UrutPPL,@Kurs,@NamaBrg,0,@choice)



if @Choice='U'

-- IF EXISTS REMOVED
=1) 

 select 1

  --exec [sp_PORev] @NoBukti,0,@Urut,@Catatan,1

 

  update dbPODET set IsClose=@IsCloseD, KodeBrg=@KODEBRG, Qnt=@QNT, NoSat=@NoSat, Isi=@Isi, Satuan=@Satuan, Harga=@HARGA, DiscP=@DiscP, DiscTot=@DiscTot,NoPPL=@NoPPL,Tolerate=@Tolerate,KURS=@Kurs,NamaBrg=@NamaBrg,Tf=0,Do=@Choice 

  where NoBukti=@NoBukti and Urut=@Urut



if @Choice='D'

-- IF EXISTS REMOVED
=1) 

 select 1

 -- exec [sp_PORev] @NoBukti,0,@Urut,@Catatan,1

   

  delete dbPODET where NoBukti=@NoBukti and Urut=@Urut 

  insert TempDelDataDet

  select @Nobukti,@Urut,'dbPODET'	

  if not exists( select NoBukti from dbPODET where NoBukti=@NoBukti)

  delete dbPO where NoBukti=@NoBukti

  	insert TempDelData

    select @Nobukti,'dbPO'

    delete DBKirimDET where NoBukti=@NoBukti 


---- IF EXISTS REMOVED
----Update DBPO Set NILAIDPP=(select COALESCE(SUM(NDPP),0)NDPP from DBPODET where NOBUKTI=DBPO.NOBUKTI),

     --                NILAINET=(select COALESCE(SUM(NNET),0)NNET from DBPODET where NOBUKTI=DBPO.NOBUKTI),

   --                  NILAIPPN=(select COALESCE(SUM(NPPN),0)NPPN from DBPODET where NOBUKTI=DBPO.NOBUKTI)

   --where NOBUKTI=@NoBukti                  

 -- 

if @Choice in('I','U')

exec [sp_UpdateTransaksiPPN] 'dbPODET','dbPO',@NoBukti



exec sp_RefreshOutPPL @NoPPL

if @@error<>0  goto jikasalah



Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- Sp_POKirim
CREATE PROCEDURE IF NOT EXISTS Sp_POKirim AS tran

if @Choice='I'

Select @urut=MAX(urut) from DBPOKIRIM where NoPO=@NoPO and UrutPO=@UrutPO

  -- SET REMOVEDISNULL(@urut,0)+1

  Insert into DBPOKIRIM (urut, NoPO, UrutPO, TglKirim, Sat_1, Sat_2, Qnt, Qnt2, Nosat, Isi)

  values (@urut,@NoPO,@UrutPO,@Tglkirim,@Sat_1,@Sat_2, @qnt, @qnt2, @Nosat, @Isi)



else if @Choice='U'

update DBPOKIRIM set TglKirim=@Tglkirim, Qnt=@qnt, @qnt2=@qnt2, Sat_1=@Sat_1, Sat_2=@Sat_2, 

  Nosat=@Nosat, isi=@isi

  where urut=@urut and nopo=@NoPO and urutpo=@UrutPO



else if @Choice='D'

delete DBPOKIRIM where urut=@urut and nopo=@NoPO and urutpo=@UrutPO



if @@ERROR<>0 goto JikaSalah

Commit Tran

Return

JikaSalah: Rollback Tran

           Return;

-- sp_PORev
CREATE PROCEDURE IF NOT EXISTS sp_PORev AS tran

 if @Urutan =1 

 select @RevisiKe=COALESCE(max(RevisiKe),0)+1 from dbPORev Where NoBukti=@NoBukti

    insert into dbPORev (NOBUKTI, NOURUT, TANGGAL, TglJatuhTempo, KODESUPP, Handling, KodeExp, KETERANGAN, 

	FakturSUPP, KODEVLS, KURS, PPN, TIPEBAYAR, HARI, TipeDisc, DISC, DiscRp,IsClose,RevisiKe,TanggalRev)

    Select NOBUKTI, NOURUT, TANGGAL, TglJatuhTempo, KODESUPP, Handling, KodeExp, KETERANGAN,

	FakturSupp, KODEVLS, KURS, PPN, TIPEBAYAR, HARI, TipeDisc, DISC, DISCRP,IsClose,@RevisiKe,datetime('now')

	from dbPO where NOBUKTI=@NoBukti

  

    insert into dbPORevDET (NOBUKTI, URUT,  PPN, Disc, KODEBRG, QNT, NOSAT, ISI, SATUAN, HARGA, DISCP, DISCTOT,NoPPL,IsClose,Catatan,RevisiKe)

    select NOBUKTI, URUT, PPN, Disc, KODEBRG, Qnt, NOSAT, ISI, SATUAN, Harga, DISCP, DISCTOT,NoPPL,IsClose,@Catatan,@RevisiKe 

    from DBPODET where NOBUKTI=@NoBukti and URUT=@urut

 

else

 select @RevisiKe=COALESCE(max(RevisiKe),0)+1 from dbPORev Where NoBukti=@NoBukti

    insert into dbPORev (NOBUKTI, NOURUT, TANGGAL, TglJatuhTempo, KODESUPP, Handling, KodeExp, KETERANGAN, 

	FakturSUPP, KODEVLS, KURS, PPN, TIPEBAYAR, HARI, TipeDisc, DISC, DiscRp,IsClose,RevisiKe,TanggalRev)

    Select NOBUKTI, NOURUT, TANGGAL, TglJatuhTempo, KODESUPP, Handling, KodeExp, KETERANGAN,

	FakturSupp, KODEVLS, KURS, PPN, TIPEBAYAR, HARI, TipeDisc, DISC, DISCRP,IsClose,@RevisiKe,datetime('now')

	from dbPO where NOBUKTI=@NoBukti

	-------

	insert into dbPORevDET (NOBUKTI, URUT,  PPN, Disc, KODEBRG, QNT, NOSAT, ISI, SATUAN, HARGA, DISCP, DISCTOT,NoPPL,IsClose,Catatan,RevisiKe)

    select NOBUKTI, URUT, PPN, Disc, KODEBRG, Qnt, NOSAT, ISI, SATUAN, Harga, DISCP, DISCTOT,NoPPL,IsClose,@Catatan,@RevisiKe 

    from DBPODET where NOBUKTI=@NoBukti


exec [sp_UpdateTransaksiPPN] 'dbPORevDET','dbPORev',@NoBukti

 

if @@error<>0  goto jikasalah

Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- Sp_PostBiaya
CREATE PROCEDURE IF NOT EXISTS Sp_PostBiaya AS tran

if @choice='I'

insert into dbPostBiaya (KodeBag, KodeMesin, Perkiraan, BiayaJasa)

	values (@KodeBag, @KodeMesin, @Perkiraan, @BiayaJasa)

	if @@error <> 0 goto jikasalah



if @choice='U'

update dbPostBiaya set KodeMesin=@KodeMesin ,KodeBag=@KodeBag, Perkiraan=@Perkiraan, BiayaJasa=@BiayaJasa

   where KodeBag=@OldKode and KodeMesin=@OldKode2 

	if @@error <> 0 goto jikasalah



if @choice='D'

delete  dbPostBiaya where KodeBag=@OldKode and KodeMesin=@OldKode2 

	if @@error <> 0 goto jikasalah



commit tran

return

jikasalah:

	rollback tran

	raiserror('Proses Input Data Gagal',16,1)

	return;

-- sp_PPL
CREATE PROCEDURE IF NOT EXISTS sp_PPL AS tran

if @Choice='I'

select @Urut=COALESCE(max(urut),0)+1 from dbPPLdet Where NoBukti=@NoBukti

  if @@error<>0  goto jikasalah

  if not exists(select * from dbPPL Where NoBukti=@NoBukti) 

  insert into dbPPL (NOBUKTI, NOURUT, TANGGAL,IsClose, KDDep,Devisi,Tf,Do)

    values (@NOBUKTI, @NOURUT, @TANGGAL,@IsClose, @KDDep,@Devisi,0,@choice)

    if @@error<>0  goto jikasalah

  

  insert into dbPPLDET (NOBUKTI, URUT, KODEBRG, QNT, NOSAT, ISI, SAT,Keterangan,IsClose, nosPk,UrutSPK, NosatSPK,Tglkirim,NamaBrg,Tf,Do)

  values(@NOBUKTI, @URUT, @KODEBRG, @Qnt, @NoSat, @Isi, @Satuan,@Keterangan,@IsClosed, @noSPK, @UrutSPK, @NosatSPK,@TglKirim,@NamaBrg,0,@choice)

  if @@error<>0  goto jikasalah



if @Choice='U'

update dbPPLDET set KodeBrg=@KODEBRG, Qnt=@QNT, NOSAT=@NoSat, ISI=@ISI, SAT=@Satuan,Keterangan=@Keterangan,IsClose=@IsClosed,

                      nosPk=@noSPK,UrutSPK=@UrutSPK, NosatSPK=@NoSatSPK,TglKirim=@TglKirim,NamaBrg=@NamaBrg    ,Tf=0,Do=@Choice

  where NoBukti=@NoBukti and Urut=@Urut

  if @@error<>0  goto jikasalah



if @Choice='D'

delete dbPPLDET where NoBukti=@NoBukti and Urut=@Urut

  insert TempDelDataDet

   select @Nobukti,@Urut,'dbPPLDET'	

  if @@error<>0  goto jikasalah 

  if not exists( select NoBukti from dbPPLDET where NoBukti=@NoBukti)

  delete dbPPL where NoBukti=@NoBukti

  	insert TempDelData

    select @Nobukti,'dbPPL'

    delete DBKirimPRDET where NoBukti=@NoBukti 

    if @@error<>0  goto jikasalah


exec sp_RefreshOutPPL @NoBukti

if @@error<>0  goto jikasalah



Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- sp_Project
CREATE PROCEDURE IF NOT EXISTS sp_Project AS tran



if @Choice='I'

insert into dbProject (Devisi,KodeProject, NamaProject, KodeCust, ALAMATPROJECT, Pelaksana, KodeSubKota,

  ContactP, TelpHP, Fax, Email,KodeRute,Tf,Do)

  values (@Devisi,@KodeProject, @NamaProject, @KodeCust,@ALAMATPROJECT, @Pelaksana, @KodeSubKota,

  @ContactP, @TelpHP, @Fax, @Email,@Rute,0,@Choice)

  if @@error <> 0 goto jikasalah



else

if @choice='U'

update dbProject 

    set NAMAPROJECT=@NamaProject, KODECUST=@KodeCust,ALAMATPROJECT=@ALAMATPROJECT,

    Pelaksana=@Pelaksana, KodeSubKota=@KodeSubKota, ContactP=@ContactP, TelpHP=@TelpHP,

    Fax=@Fax, Email=@Email,KodeRute=@Rute,Tf=0,Do=@Choice

    where KODEPROJECT=@KodeProject

    if @@error <> 0

     goto jikasalah



if @choice='D'

delete dbProject 

   where KODEPROJECT=@KodeProject

       insert TempDelData

    select @KodeProject,'dbProject'

   

   if @@error <> 0 goto jikasalah



commit tran

return

jikasalah:

	rollback tran

	raiserror('Proses Input Data Gagal',16,1)

	return;

-- Sp_ProsesCashFlow
CREATE PROCEDURE IF NOT EXISTS Sp_ProsesCashFlow AS -- DECLARE REMOVED, @Periode2 varchar(10), @xBulan int



select @Periode1=cast(@Tahun as varchar(4))+SUBSTR('0'+cast(@Bulan as varchar(2)), LENGTH('0'+cast(@Bulan as varchar(2)))-2+1)

select @Periode2=cast(@TahunB as varchar(4))+SUBSTR('0'+cast(@BulanB as varchar(2)), LENGTH('0'+cast(@BulanB as varchar(2)))-2+1)



select a.Perkiraan, a.Perkiraan as Lawan, a.Keterangan,

     sum(COALESCE(bb.AwalDRp,0))as Kas,

     0 as Koreksi, 0 as Jumlah, 'SALDO AWAL'as Gol, '1' as Urut, @UserID as UserID, '01' devisi, '' KodeCS

from dbPerkiraan a

left outer join dbneraca b on (b.perkiraan=a.perkiraan and b.Devisi=@Divisi and

     b.Bulan=@Bulan and b.Tahun=@Tahun)

left outer join dbneraca bb on (bb.perkiraan=a.perkiraan and bb.Devisi=@Divisi and

     bb.Bulan=@Bulan and bb.Tahun=@Tahun)

--where a.FlagCashFlow='1'

where (a.Perkiraan in(select x.Perkiraan from dbposthutpiut x where  x.kode='KAS')) or

      (a.Perkiraan in(select x.Perkiraan from dbposthutpiut x where  x.kode='BANK'))

Group by a.Perkiraan, a.Keterangan

union



select a.Perkiraan, a.Lawan, b.Keterangan,

sum(COALESCE(a.Debet*a.Kurs,0)-COALESCE(a.Kredit*a.Kurs,0)) as Kas,

0 as Koreksi, 0 as Jumlah, 'PENERIMAAN'as Gol, '2' as Urut, @UserID as UserID,'01' as Devisi, '' KodeCS

from dbTransaksi a

left outer join dbPerkiraan b on a.Lawan=b.perkiraan



where (cast(year(A.Tanggal) as varchar(4))+SUBSTR('0'+cast(month(A.Tanggal) as varchar(2)), LENGTH('0'+cast(month(A.Tanggal) as varchar(2)))-2+1) between @Periode1 and @Periode2) and

     (a.tipetrans='BKM' or a.tipetrans='BBM') and

      (a.Lawan not in(select x.Perkiraan from dbposthutpiut x where  x.kode='KAS')) and

      (a.Lawan not in(select x.Perkiraan from dbposthutpiut x where  x.kode='BANK'))

Group by a.Perkiraan, a.Lawan, b.Keterangan

/*

union

select a.Perkiraan, a.Lawan, COALESCE(COALESCE('    - '+sp.NAMACUSTSUPP,'    - '+cs.NAMACUSTSUPP),b.Keterangan) Keterangan,

sum(case when p.NoBukti is null then COALESCE(a.Debet*a.Kurs,0) - COALESCE(a.Kredit*a.Kurs,0) else COALESCE(p.Kredit,COALESCE(h.Debet,0)) ) as Kas,

0 as Koreksi, 0 as Jumlah, 'PENERIMAAN'as Gol, '2' as Urut, @UserID as UserID,'01' as Devisi,

	COALESCE(COALESCE(h.KodeCustSupp,p.KodeCustSupp),'') KodeCS

from dbTransaksi a

left outer join dbPerkiraan b on a.Lawan=b.perkiraan

left outer join dbhutpiut h on h.NoBukti=a.NoBukti 

left outer join dbCustSupp sp on sp.KodeCustSupp=h.KodecustSupp

left outer join dbhutpiut p on p.NoBukti=a.NoBukti 

left outer join dbCustSupp cs on cs.KODECUSTSUPP=p.KodeCustSupp



where (cast(year(A.Tanggal) as varchar(4))+SUBSTR('0'+cast(month(A.Tanggal) as varchar(2)), LENGTH('0'+cast(month(A.Tanggal) as varchar(2)))-2+1) between @Periode1 and @Periode2) and

     (a.tipetrans='BKM' or a.tipetrans='BBM') and

      (a.Lawan not in(select x.Perkiraan from dbposthutpiut x where  x.kode='KAS')) and

      (a.Lawan not in(select x.Perkiraan from dbposthutpiut x where  x.kode='BANK'))

	and (p.NoBukti is not null or h.NoBukti is not null)

Group by a.Perkiraan, a.Lawan, COALESCE(COALESCE('    - '+sp.NAMACUSTSUPP,'    - '+cs.NAMACUSTSUPP),b.Keterangan), COALESCE(COALESCE(h.KodeCustSupp,p.KodeCustSupp),'')

union

*/

select a.Perkiraan, a.Lawan, b.Keterangan,

sum(COALESCE(a.Kredit*a.Kurs,0)-COALESCE(a.Debet*a.Kurs,0)) as Kas, 0 as Koreksi, 0 as Jumlah, 'PENGELUARAN'as Gol, 

'3' as Urut, @UserID as UserID, '01' as devisi, '' KodeCS

from dbTransaksi a

left outer join dbPerkiraan b on a.Lawan=b.perkiraan



where (cast(year(A.Tanggal) as varchar(4))+SUBSTR('0'+cast(month(A.Tanggal) as varchar(2)), LENGTH('0'+cast(month(A.Tanggal) as varchar(2)))-2+1) between @Periode1 and @Periode2) and

      (a.tipetrans='BKK' or a.tipetrans='BBK') and

      (a.Lawan not in(select x.Perkiraan from dbposthutpiut x where  x.kode='KAS')) and

      (a.Lawan not in(select x.Perkiraan from dbposthutpiut x where  x.kode='BANK')) 

Group by a.Perkiraan, a.Lawan, b.Keterangan



union 

select a.Perkiraan, a.Lawan, COALESCE(COALESCE('    - '+sp.NAMACUSTSUPP,'    - '+cs.NAMACUSTSUPP),b.Keterangan) Keterangan ,

sum(case when h.NoBukti is null then COALESCE(a.Kredit*a.Kurs,0)-COALESCE(a.Debet*a.Kurs,0) else COALESCE(h.Debet,p.Kredit) ) as Kas, 0 as Koreksi, 0 as Jumlah, 'PENGELUARAN'as Gol, 

'3' as Urut, @UserID as UserID, '01' as devisi, COALESCE(h.KodeCustSupp,COALESCE(p.KodeCustSupp,'')) KodeCS

from dbTransaksi a

left outer join dbPerkiraan b on a.Lawan=b.perkiraan

left outer join dbHutpiut h on h.NoBukti=a.NoBukti 

left outer join DBCUSTSUPP sp on sp.KODECUSTSUPP=h.KodeCustSupp

left outer join DBHUTPIUT p on p.NoBukti=a.NoBukti 

left outer join DBCUSTSUPP cs on cs.KODECUSTSUPP=p.KodeCustSupp



where (cast(year(A.Tanggal) as varchar(4))+SUBSTR('0'+cast(month(A.Tanggal) as varchar(2)), LENGTH('0'+cast(month(A.Tanggal) as varchar(2)))-2+1) between @Periode1 and @Periode2) and

      (a.tipetrans='BKK' or a.tipetrans='BBK') and

      (a.Lawan not in(select x.Perkiraan from dbposthutpiut x where  x.kode='KAS')) and

      (a.Lawan not in(select x.Perkiraan from dbposthutpiut x where  x.kode='BANK')) 

	and (p.NoBukti is not null or h.NoBukti is not null)

Group by a.Perkiraan, a.Lawan, COALESCE(COALESCE('    - '+sp.NAMACUSTSUPP,'    - '+cs.NAMACUSTSUPP),b.Keterangan), COALESCE(h.KodeCustSupp,COALESCE(p.KodeCustSupp,''))

union

select a.Perkiraan, a.Perkiraan as Lawan, a.Keterangan,

     sum(COALESCE(b.AwalDRp,0)+(COALESCE(b.MDRp,0)-COALESCE(b.MKRp,0))+

     (COALESCE(b.JPDRp,0)-COALESCE(b.JPKRp,0))+(COALESCE(b.RLDRp,0)-COALESCE(b.RLKRp,0))) as Kas,

     0 as Koreksi, 0 as Jumlah, 'SALDO AKHIR'as Gol, '4' as Urut, @UserID as UserID, '01' devisi, '' KodeCS

from dbPerkiraan a

left outer join dbneraca b on (b.perkiraan=a.perkiraan and b.Devisi=@Divisi and

     b.Bulan=@BulanB and b.Tahun=@TahunB)

--where a.FlagCashFlow='1'

where (a.Perkiraan in(select x.Perkiraan from dbposthutpiut x where  x.kode='KAS')) or

      (a.Perkiraan in(select x.Perkiraan from dbposthutpiut x where  x.kode='BANK'))

Group by a.Perkiraan, a.Keterangan;

-- sp_ProsesKomisiInvoicePL
CREATE PROCEDURE IF NOT EXISTS sp_ProsesKomisiInvoicePL AS -- DECLARE REMOVED



select @xMaxUrut=MAX(xUrut) from dbKomisiInvoicePL where Tahun=@Tahun and Bulan=@Bulan



select @xMaxUrut=COALESCE(@xMaxUrut,0)



select * from dbKomisiInvoicePL



insert into dbKomisiInvoicePL (TAHUN, BULAN, xUrut, NoBukti, NoBuktiLunas, Tanggal,

	KodeCustSupp, Urut, KodeBrg, Qnt, NoSat, Satuan,

	KodeTerima, JenisKomisi, Harga, TotHarga)  

select @Tahun Tahun, @Bulan Bulan, @xMaxUrut+B.Urut xUrut, 

	A.NoBukti, '' NoBuktiLunas, A.Tanggal,

	A.KodeCustSupp, B.Urut, B.KodeBrg, 

	case when B.NOSAT=1 then B.QNT else B.QNT2  QNT, B.NOSAT,

	case when B.NOSAT=1 then Brg.SAT1 else Brg.SAT2  Satuan,

	KC.Nama KodeTerima, 0 JenisKomisi, 0 Harga, 0 TotHarga

from DBInvoicePL A

left outer join dbInvoicePLDet B on B.NOBUKTI=A.NOBUKTI

left outer join DBBARANGCUSTOMER BC on BC.KodecustSupp=A.KodeCustSupp and BC.KodeBrg=B.KodeBrg

left outer join DBKomisiCustomer KC on BC.KodecustSupp=A.KodeCustSupp and BC.KodeBrg=B.KodeBrg

	and KC.KodeCustSupp=BC.KodecustSupp and KC.KodeBrg=BC.KodeBrg

left outer join DBBARANG Brg on Brg.KODEBRG=B.KodeBrg

where YEAR(A.Tanggal)=@Tahun and MONTH(A.Tanggal)=@Bulan

	and A.NoBukti=@NoBukti;

-- SP_ProsesLabaRugi
CREATE PROCEDURE IF NOT EXISTS SP_ProsesLabaRugi AS --Select @Bulan=1,@Tahun=2011,@LR_HPP=0,@Tanggal='01-31-2011',@Userid='SA'

Tran

    -- DECLARE REMOVED,@PerkTujuan varchar(25),@SelisihWIP numeric(18,2),@NobuktiWIP varchar(30),

          @prd varchar(8),@PerkiraanWIP varchar(25),@LawanWIP varchar(25),@PerkTujuanGanti varchar(25),

          @SoAkhirPerkTujuan numeric(18,2)

   

    select @PerkAsal=Perkiraan,@PerkTujuan='151',@PerkTujuanGanti='359' from DBPOSTHUTPIUT where Kode='HPP' 

	-- DECLARE REMOVED,@urutx int,@Devisix varchar(15)

	declare CurHapus cursor for

	select nobukti,urut,devisi from dbtransaksi 

	where nobukti like Case when @LR_HPP=0 then 'R/L%' 

						         when @LR_HPP=1 then 'HPP%'

						         else ''

					        and 

	      month(tanggal)=@bulan and year(tanggal)=@tahun and Devisi=@devisi and (Tipetrans in ('R/L','HPP') or (tipetrans='BJK' and perkiraan=@PerkAsal))  

	Order by Nobukti

	open CurHapus

	Fetch Next from CurHapus into @Nobuktix,@Urutx,@Devisix

	while @@FETCH_STATUS=0

	Delete dbTransaksi where NoBukti=@Nobuktix and Urut=@urutx and Devisi=@Devisix

		if not exists(Select 'True' from dbTransaksi where NoBukti=@Nobuktix and Devisi=@Devisix)

		   Delete dbTrans where NoBukti=@Nobuktix 

		Fetch Next from CurHapus into @Nobuktix,@Urutx,@Devisix

	

	close CurHapus

	Deallocate CurHapus

	if @@ERROR<>0 Goto JikaSalah

	-- DECLARE REMOVED,@Nomor varchar(25),

		 @Grup Varchar(50),@Tipe Varchar(3),

		 @Tanda varchar(3),@Persen varchar(3),

		 @JumLah varchar(3),@Tampil varchar(3)

	-- DECLARE REMOVED,@hasil1 numeric(18,2),@hasil2 numeric(18,2),@hasil3 numeric(18,2),@jurnal numeric(18,2)

	-- DECLARE REMOVED,@hasil2Rp numeric(18,2),@hasil3Rp numeric(18,2),@jurnalRp numeric(18,2)

	-- DECLARE REMOVED

	-- DECLARE REMOVED,@hsl2 numeric(18,2),@hsl3 numeric(18,2)

	-- DECLARE REMOVED,@jumtotal2 numeric(18,2),@jumtotal3 numeric(18,2)

	-- DECLARE REMOVED,@jumgroup2 numeric(18,2),@jumgroup3 numeric(18,2)

	-- DECLARE REMOVED,@jumsubgroup2 numeric(18,2),@jumsubgroup3 numeric(18,2)

	select @jumtotal1=0

	select @jumtotal2=0

	select @jumtotal3=0

	select @jumgroup1=0

	select @jumgroup2=0

	select @jumgroup3=0

	select @jumsubgroup1=0

	select @jumsubgroup2=0

	select @jumsubgroup3=0	 

	Declare mydata Cursor For

		Select Bulan,Tahun,Devisi,Perkiraan,Nomor,Grup,Tipe,Tanda,Persen,JumLah,Tampil 

		from DBLRHPP 

		Where Bulan=@bulan and tahun=@tahun and IsLrHpp=@LR_HPP and Devisi=@devisi

		order by Nomor

	open mydata

	fetch next from mydata into @Bulan,@Tahun,@Devisix,@Perkiraan,@Nomor,@Grup,@Tipe,@Tanda,@Persen,@JumLah,@Tampil

	while @@FETCH_STATUS=0

	Select @hsl1=0, @hsl2=0, @hsl3=0

	  -- DECLARE REMOVED

     if @Perkiraan<>''

     select @detail=(select distinct p.Tipe from dbperkiraan p where P.perkiraan=@perkiraan)

       Declare MyPerkiraan cursor for

       --select distinct P.perkiraan 

       --from dbperkiraan P, dbneraca N 

       --where P.perkiraan like (@perkiraan+'%') and (P.perkiraan <> @perkiraan) and 

       --      P.perkiraan=N.perkiraan and N.bulan=@bulan and N.tahun=@tahun and N.devisi like @devisix+'%'

       --      and P.Tipe=1

       ---Order by P.Perkiraan

       select distinct P.perkiraan 

       from dbperkiraan P, dbneraca N 

       where ((P.Perkiraan like (left(@Perkiraan,2)+'%') and @Detail=0 and P.Perkiraan<>@Perkiraan) or (P.perkiraan=@Perkiraan and @Detail=1)) 

             and P.perkiraan=N.perkiraan and N.bulan=@bulan and N.tahun=@tahun and N.devisi like @devisix+'%'

             and P.Tipe=1

       Order by P.Perkiraan

       open MyPerkiraan

       Fetch next From MyPerkiraan into @Perkiraanx

       while @@FETCH_STATUS=0

       exec dbo.sp_HitungNilaiRl @perkiraanx,@tipe,@bulan,@tahun,@Devisix,@LR_HPP,@tanggal,@userid,

			 @hasil1 output,@hasil2 output,@hasil3 output,@jurnal output,

			 @hasil1Rp output,@hasil2Rp output,@hasil3Rp output,@jurnalRp output

			 select @hsl1=@hsl1+COALESCE(@hasil1Rp,0)

			 select @hsl2=@hsl2+COALESCE(@hasil2Rp,0)

			 select @hsl3=@hsl3+COALESCE(@hasil3Rp,0)

         Fetch next From MyPerkiraan into @Perkiraanx

       

       close MyPerkiraan

       Deallocate MyPerkiraan 


     Update DBLRHPP set TotalA=@hsl1,TotalB=@hsl2,TotalC=@hsl3

     where Nomor=@Nomor and Bulan=@Bulan and Tahun=@Tahun and Devisi=@Devisix and Perkiraan=@Perkiraan and IsLRHPP=@LR_HPP

     

	  fetch next from mydata into @Bulan,@Tahun,@Devisix,@Perkiraan,@Nomor,@Grup,@Tipe,@Tanda,@Persen,@JumLah,@Tampil

	

	close Mydata

	Deallocate Mydata

	

	Insert into DBLRHPP(Devisi,Bulan,Tahun,Nomor,Perkiraan,Keterangan,Grup,Tipe,Tanda,Persen,Tampil,TotalA,TotalB,TotalC,IsLRHPP,Jumlah)

   Select Devisi,Case when @bulan=12 then 1 else Bulan+1 ,

          Case when @Bulan=12 then Tahun+1 else @Tahun ,

          Nomor,Perkiraan,Keterangan,Grup,Tipe,Tanda,Persen,Tampil,TotalA,TotalB,TotalC,IsLRHPP,Jumlah

   from DBLRHPP  

   where Bulan=@Bulan and Tahun=@Tahun and Devisi=@Devisix and IsLRHPP=@LR_HPP



   update DBTRANS set TipeTransHd='BJK' from DBTRANS where MONTH(Tanggal)=@Bulan and YEAR(Tanggal)=@Tahun and 

   nobukti in (select NoBukti from dbTransaksi where TipeTrans='HPP' and Perkiraan=@PerkAsal)

   update dbTransaksi set TipeTrans='BJK' from dbTransaksi where MONTH(Tanggal)=@Bulan and YEAR(Tanggal)=@Tahun 

   and TipeTrans='HPP' and Perkiraan=@PerkAsal

  /*

   delete DBTRANS from DBTRANS a

   left outer join dbTransaksi b on b.NoBukti=a.NoBukti

   where MONTH(a.Tanggal)=@Bulan and YEAR(a.Tanggal)=@Tahun and a.TipeTransHd='BJK' and a.NoBukti like '%WIP01%' and b.Devisi=@Devisix  

  

   Select @SelisihWIP=cast(sum(COALESCE(Case when A.DK=0 and B.PERKIRAAN=A.Perkiraan then B.DEBETRP

            when A.DK=1 and B.PERKIRAAN=A.Perkiraan then -B.DEBETRP

            when A.DK=0 and B.LAWAN=A.Perkiraan then -B.DEBETRP

            when A.DK=1 and B.LAWAN=A.Perkiraan then B.DEBETRP

            else 0

       ,0)) as numeric(18,2)) 

   From DBPERKIRAAN A

     left Outer join VWTransaksiBB B on B.PERKIRAAN=A.Perkiraan or B.LAWAN=A.Perkiraan

     left outer join dbtransaksi c on c.NoBukti=b.NOBUKTI and c.Urut=b.URUT

   where month(B.TANGGAL)=@Bulan and YEAR(B.TANGGAL)=@Tahun and B.Devisi=@Devisix and A.Perkiraan=@PerkAsal

   having cast(sum(COALESCE(Case when A.DK=0 and B.PERKIRAAN=A.Perkiraan then B.DEBETRP

            when A.DK=1 and B.PERKIRAAN=A.Perkiraan then -B.DEBETRP

            when A.DK=0 and B.LAWAN=A.Perkiraan then -B.DEBETRP

            when A.DK=1 and B.LAWAN=A.Perkiraan then B.DEBETRP

            else 0

       ,0)) as numeric(18,2))<>0

  

   if @bulan<10 

      select @prd='/0'+cast(@bulan as varchar(1))+SUBSTR(cast(@tahun as varchar(4)), LENGTH(cast(@tahun as varchar(4)))-2+1)

   else

      select @prd='/'+cast(@bulan as varchar(2))+SUBSTR(cast(@tahun as varchar(4)), LENGTH(cast(@tahun as varchar(4)))-2+1)



   if @devisi='01'

      select @NobuktiWIP='BCB/BMM'+@prd+'/WIP01'

   else

      select @NobuktiWIP='CB/BMM'+@prd+'/WIP01'

      

   select @SoAkhirPerkTujuan=AkhirDRp+@SelisihWIP from DBNERACA where Bulan=@Bulan and Tahun=Tahun and Perkiraan=@PerkTujuan and Devisi=@Devisix

   select @PerkiraanWIP=case when @SelisihWIP>0 then case when @SoAkhirPerkTujuan>0 then @PerkTujuan else @PerkTujuanGanti  else @PerkAsal 

   select @LawanWIP=case when @SelisihWIP>0 then @PerkAsal else case when @SoAkhirPerkTujuan>0 then @PerkTujuan else @PerkTujuanGanti   

   select @SelisihWIP=case when @SelisihWIP<0 then @SelisihWIP*-1 else @SelisihWIP  

 

   exec dbo.SP_Transaksi 'I',@NobuktiWIP,'WIP01',@tanggal,'Jurnal Koreksi Penyesuaian WIP',0,@Devisix,@PerkiraanWIP ,@LawanWIP,

   'Jurnal Koreksi Penyesuaian WIP','',@SelisihWIP,0,'IDR',1,@SelisihWIP,0,'BJK','C','','',1,'','','','','','','','','',''

*/

Commit Tran

Return

JikaSalah: RollBack Tran

           Return;

-- sp_ProsesMdb
CREATE PROCEDURE IF NOT EXISTS sp_ProsesMdb AS -- DECLARE REMOVED,

@NoUrut varchar(10)='',

@Tanggal datetime=0,

@Kodegdg varchar(15),

@Urut int,

@KodeBrg varchar(25)='',

@Qnt numeric(18,2)=0,

@NoSat TINYINT=0,

@Sat varchar(5)='',

@Isi numeric(18,2)=0,

@NoBppB Varchar(50),

@Qnt2 numeric(18,2)=0,

@UrutSPK int=0,

@NoSatSPK TINYINT=0,

@IsSampel INTEGER,

@KdDep Varchar(20)='',

@Perkiraan Varchar(20)='',

@NoPOL Varchar(50)='',

@Supir Varchar(100)='',

@KetBrg varchar(200)='',

@Devisi Varchar(15)='',

@ID int =0,

@TGLJAM datetime =null,

@NAMA_RECIPE Varchar(50) ='',

@BINM1 Int=0,

@BINM2 Int=0,

@BINM3 Int=0,

@BINM4 Int=0,

@BINM5 Int=0,

@BINC1 real=0,

@BINC2 Real=0,

@BINC3 Real=0,

@ADDITIVE real=0



Declare CurFifoIN Cursor for

select a.ID,

a.TGLJAM,

NAMA_RECIPE,

BINM1,

BINM2,

BINM3,

BINM4,

COALESCE(BINM5,0) BINM5,

BINC1,

BINC2,

BINC3,

ADDITIVE,SOPIR

 from work a

 Left Outer Join  (select * from dbPenyerahanBhn where NoBukti Like '%'+@Proses+'%') b on a.ID=b.ID and a.TGLJAM=b.TGLJAM

 where CAST(a.TGLJAM AS Date) >=@TglAwal and CAST(a.TGLJAM AS Date) <=@tglAkhir

 and b.NoBukti is Null

 order by a.ID

Open CurFifoIN

Fetch Next from CurfifoIN into @ID ,@TGLJAM ,@NAMA_RECIPE ,@BINM1 ,@BINM2 ,@BINM3 ,@BINM4 ,@BINM5 ,@BINC1 ,@BINC2 ,@BINC3 ,@ADDITIVE,@Supir

While @@fetch_Status=0

select @NoBukti='BCA/'+@Proses+'/'+Case when len(MONTH(@TGLJAM))=1 Then '0' else '' +CAST(MONTH(@TGLJAM AS TEXT))+SUBSTR(CAST(YEar(@TGLJAM AS TEXT)), LENGTH(CAST(YEar(@TGLJAM AS TEXT)))-2+1)+'/'+

 Case when LEN(@ID)=1 Then '0000'+CAST(@ID AS TEXT)

      when LEN(@ID)=2 Then '000'+CAST(@ID AS TEXT)

      when LEN(@ID)=3 Then '00'+CAST(@ID AS TEXT)

      when LEN(@ID)=4 Then '0'+CAST(@ID AS TEXT)

      when LEN(@ID)=5 Then CAST(@ID AS TEXT)

       ,

      @NoUrut= Case when LEN(@ID)=1 Then '0000'+CAST(@ID AS TEXT)

      when LEN(@ID)=2 Then '000'+CAST(@ID AS TEXT)

      when LEN(@ID)=3 Then '00'+CAST(@ID AS TEXT)

      when LEN(@ID)=4 Then '0'+CAST(@ID AS TEXT)

      when LEN(@ID)=5 Then CAST(@ID AS TEXT)

      ,

      @Devisi='01',

      @Tanggal=CAST(@TGLJAM AS Date),

      @Kodegdg='G01',

      @NoBppB='-',

      @IsSampel=0,

      @KdDep=case when @NAMA_RECIPE like '%RM%' then 'RM'

             else case when @Proses='BP1' then 'PVG'

                       when @Proses='BP2' then 'UD'

                       when @Proses='BP3' then 'TLB'  

             ,

      @Perkiraan='-',@NoPOL=''

  

  if not exists(select * from dbPenyerahanBhn Where NoBukti=@NoBukti) 

  insert into dbPenyerahanBhn (Devisi,NOBUKTI, NOURUT, TANGGAL,KODEGDG,NoBPPB, IsSampel,KdDep,NoJurnal,NoPOL,Supir,ID,TGLJAM)

    values (@Devisi,@NOBUKTI, @NOURUT, @TANGGAL,@KODEGDG,@NoBppB,@IsSampel,@KdDep,@Perkiraan,@NoPOL,@Supir,@ID,@TGLJAM)

  

  if @Proses='BP1'

  if @BINM1>0 

  select @Qnt2=@BINM1/ISI2 from DBBARANG where KODEBRG='1-1'

  insert into dbPenyerahanBhnDET (NOBUKTI, URUT, KODEBRG, QNT, NOSAT, ISI, SAT,Qnt2,

	NoSPK, UrutSPK, NoSatSPK,KetBrg)

  values(@NOBUKTI, 1, '1-1', @BINM1, 1, 1, 'KG',@Qnt2,

	@NoBppB, 0, '-',@NAMA_RECIPE)

	

----

 if @BINM2>0 

  select @Qnt2=@BINM2/ISI2 from DBBARANG where KODEBRG='5-10 C'

  insert into dbPenyerahanBhnDET (NOBUKTI, URUT, KODEBRG, QNT, NOSAT, ISI, SAT,Qnt2,

	NoSPK, UrutSPK, NoSatSPK,KetBrg)

  values(@NOBUKTI, 2, '5-10 C', @BINM2, 1, 1, 'KG',@Qnt2,

	@NoBppB, 0, '-',@NAMA_RECIPE)

	

	----

	if 	@BINM3>0

	select @Qnt2=@BINM3/ISI2 from DBBARANG where KODEBRG='AB'

  insert into dbPenyerahanBhnDET (NOBUKTI, URUT, KODEBRG, QNT, NOSAT, ISI, SAT,Qnt2,

	NoSPK, UrutSPK, NoSatSPK,KetBrg)

  values(@NOBUKTI, 3, 'AB', @BINM3, 1, 1, 'KG',@Qnt2,

	@NoBppB, 0, '-',@NAMA_RECIPE)

	

	-----

 if @BINM4>0

 select @Qnt2=@BINM4/ISI2 from DBBARANG where KODEBRG='PSLMJ'

  insert into dbPenyerahanBhnDET (NOBUKTI, URUT, KODEBRG, QNT, NOSAT, ISI, SAT,Qnt2,

	NoSPK, UrutSPK, NoSatSPK,KetBrg)

  values(@NOBUKTI, 4, 'PSLMJ', @BINM4, 1, 1, 'KG',@Qnt2,

	@NoBppB, 0, '-',@NAMA_RECIPE)	

 	

 if @BINC1>0 

 select @Qnt2=@BINC1/ISI2 from DBBARANG where KODEBRG='SM'

  insert into dbPenyerahanBhnDET (NOBUKTI, URUT, KODEBRG, QNT, NOSAT, ISI, SAT,Qnt2,

	NoSPK, UrutSPK, NoSatSPK,KetBrg)

  values(@NOBUKTI, 5, 'SM', @BINC1, 1, 1, 'KG',@Qnt2,

	@NoBppB, 0, '-',@NAMA_RECIPE)	



----

  if @BINC2>0 

  select @Qnt2=@BINC2/ISI2 from DBBARANG where KODEBRG='SM'

    insert into dbPenyerahanBhnDET (NOBUKTI, URUT, KODEBRG, QNT, NOSAT, ISI, SAT,Qnt2,

	NoSPK, UrutSPK, NoSatSPK,KetBrg)

	

    values(@NOBUKTI, 6, 'SM', @BINC2, 1, 1, 'KG',@Qnt2,

	@NoBppB, 0, '-',@NAMA_RECIPE)


  if @Proses='BP2'

  if @BINM1>0 

  select @Qnt2=@BINM1/ISI2 from DBBARANG where KODEBRG='1-2'

  insert into dbPenyerahanBhnDET (NOBUKTI, URUT, KODEBRG, QNT, NOSAT, ISI, SAT,Qnt2,

	NoSPK, UrutSPK, NoSatSPK,KetBrg)

  values(@NOBUKTI, 1, '1-2', @BINM1, 1, 1, 'KG',@Qnt2,

	@NoBppB, 0, '-',@NAMA_RECIPE)

	

----

 if @BINM2>0 

  select @Qnt2=@BINM2/ISI2 from DBBARANG where KODEBRG='5-10 C'

  insert into dbPenyerahanBhnDET (NOBUKTI, URUT, KODEBRG, QNT, NOSAT, ISI, SAT,Qnt2,

	NoSPK, UrutSPK, NoSatSPK,KetBrg)

  values(@NOBUKTI, 2, '5-10 C', @BINM2, 1, 1, 'KG',@Qnt2,

	@NoBppB, 0, '-',@NAMA_RECIPE)

	

	----

	if 	@BINM3>0

	select @Qnt2=@BINM3/ISI2 from DBBARANG where KODEBRG='AB'

  insert into dbPenyerahanBhnDET (NOBUKTI, URUT, KODEBRG, QNT, NOSAT, ISI, SAT,Qnt2,

	NoSPK, UrutSPK, NoSatSPK,KetBrg)

  values(@NOBUKTI, 3, 'AB', @BINM3, 1, 1, 'KG',@Qnt2,

	@NoBppB, 0, '-',@NAMA_RECIPE)

	

	-----

 if @BINM4>0

 select @Qnt2=@BINM4/ISI2 from DBBARANG where KODEBRG='1-1'

  insert into dbPenyerahanBhnDET (NOBUKTI, URUT, KODEBRG, QNT, NOSAT, ISI, SAT,Qnt2,

	NoSPK, UrutSPK, NoSatSPK,KetBrg)

  values(@NOBUKTI, 4, '1-1', @BINM4, 1, 1, 'KG',@Qnt2,

	@NoBppB, 0, '-',@NAMA_RECIPE)	

 	

 if @BINM5>0 

 select @Qnt2=@BINM5/ISI2 from DBBARANG where KODEBRG='PSLMJ'

  insert into dbPenyerahanBhnDET (NOBUKTI, URUT, KODEBRG, QNT, NOSAT, ISI, SAT,Qnt2,

	NoSPK, UrutSPK, NoSatSPK,KetBrg)

  values(@NOBUKTI, 5, 'PSLMJ', @BINM5, 1, 1, 'KG',@Qnt2,

	@NoBppB, 0, '-',@NAMA_RECIPE)	


 if @Proses='BP3'

  if @BINM1>0 

  select @Qnt2=@BINM1/ISI2 from DBBARANG where KODEBRG='PSLMJ'

  insert into dbPenyerahanBhnDET (NOBUKTI, URUT, KODEBRG, QNT, NOSAT, ISI, SAT,Qnt2,

	NoSPK, UrutSPK, NoSatSPK,KetBrg)

  values(@NOBUKTI, 1, 'PSLMJ', @BINM1, 1, 1, 'KG',@Qnt2,

	@NoBppB, 0, '-',@NAMA_RECIPE)

	

----

 if @BINM2>0 

  select @Qnt2=@BINM2/ISI2 from DBBARANG where KODEBRG='AB'

  insert into dbPenyerahanBhnDET (NOBUKTI, URUT, KODEBRG, QNT, NOSAT, ISI, SAT,Qnt2,

	NoSPK, UrutSPK, NoSatSPK,KetBrg)

  values(@NOBUKTI, 2, 'AB', @BINM2, 1, 1, 'KG',@Qnt2,

	@NoBppB, 0, '-',@NAMA_RECIPE)

	

	----

	if 	@BINM3>0

	select @Qnt2=@BINM3/ISI2 from DBBARANG where KODEBRG='5-10 C'

  insert into dbPenyerahanBhnDET (NOBUKTI, URUT, KODEBRG, QNT, NOSAT, ISI, SAT,Qnt2,

	NoSPK, UrutSPK, NoSatSPK,KetBrg)

  values(@NOBUKTI, 3, '5-10 C', @BINM3, 1, 1, 'KG',@Qnt2,

	@NoBppB, 0, '-',@NAMA_RECIPE)

	

	-----

 if @BINM4>0

 select @Qnt2=@BINM4/ISI2 from DBBARANG where KODEBRG='1-1'

  insert into dbPenyerahanBhnDET (NOBUKTI, URUT, KODEBRG, QNT, NOSAT, ISI, SAT,Qnt2,

	NoSPK, UrutSPK, NoSatSPK,KetBrg)

  values(@NOBUKTI, 4, '1-1', @BINM4, 1, 1, 'KG',@Qnt2,

	@NoBppB, 0, '-',@NAMA_RECIPE)	


Fetch Next from CurfifoIN into @ID ,@TGLJAM ,@NAMA_RECIPE ,@BINM1 ,@BINM2 ,@BINM3 ,@BINM4 ,@BINM5 ,@BINC1 ,@BINC2 ,@BINC3 ,@ADDITIVE,@Supir


Close CurFifoIn

Deallocate CurFifoIn;

-- sp_ProsesPostingHutPiut
CREATE PROCEDURE IF NOT EXISTS sp_ProsesPostingHutPiut AS Delete from dbo.DBHUTPIUT where YEAR(Tanggal)=@Tahun and MONTH(Tanggal)=@Bulan and TipeTrans='T' and --NOINVOICE=@JenisTrans and 

NoFaktur=@NoBuktiTrans



if @TipeProses=1 

if @JenisTrans='BL'

  Insert into dbo.DBHUTPIUT(NoFaktur, NoRetur, TipeTrans, KodeCustSupp, NoBukti, NoMsk, Urut, Tanggal, JatuhTempo, 

                              Debet, Kredit,  Valas, Kurs,DebetD, KreditD, 

                              KodeSales, Tipe, Perkiraan, Catatan, NOINVOICE,  KodeVls_, Kurs_,Devisi)

    Select  NoFaktur, NoRetur, Tipetrans, KODECUSTSUPP, Nobukti, NoMsk, urut, TANGGAL, JatuhTempo, 

            Debet, Kredit,  Valas, KURS, 

            Case when Valas='IDR' then 0.00 else DebetD  DebetD,  

            Case when Valas='IDR' then 0.00 else KreditD  KreditD, 

                      KodeSales, Tipe, PERKIRAAN, Catatan, NoInvoice, KodeVls_, Kurs_,DEVISI

    from Dbo.fnc_PostPembelian(@NoBuktiTrans)    

   else  

  if @JenisTrans='RBL'

  Insert into dbo.DBHUTPIUT(NoFaktur, NoRetur, TipeTrans, KodeCustSupp, NoBukti, NoMsk, Urut, Tanggal, JatuhTempo, 

                              Debet, Kredit,  Valas, Kurs, DebetD, KreditD, 

                              KodeSales, Tipe, Perkiraan, Catatan, NOINVOICE,  KodeVls_, Kurs_,Devisi)

    Select  NoFaktur, NoRetur, Tipetrans, KODECUSTSUPP, Nobukti, NoMsk, urut, TANGGAL, JatuhTempo, 

            Debet, Kredit,  Valas, KURS, 

            Case when Valas='IDR' then 0.00 else DebetD  DebetD,  

            Case when Valas='IDR' then 0.00 else KreditD  KreditD, 

                      KodeSales, Tipe, PERKIRAAN, Catatan, NoInvoice, KodeVls_, Kurs_,DEVISI

    from Dbo.fnc_PostReturPembelian(@NoBuktiTrans)    

   else

  if @JenisTrans='BP'

  Insert into dbo.DBHUTPIUT(NoFaktur, NoRetur, TipeTrans, KodeCustSupp, NoBukti, NoMsk, Urut, Tanggal, JatuhTempo, 

                              Debet, Kredit,  Valas, Kurs, DebetD, KreditD, 

                              KodeSales, Tipe, Perkiraan, Catatan, NOINVOICE,  KodeVls_, Kurs_,Devisi)

    Select  NoFaktur, NoRetur, Tipetrans, KODECUSTSUPP, Nobukti, NoMsk, urut, TANGGAL, JatuhTempo, 

            Debet, Kredit,  Valas, KURS, 

            Case when Valas='IDR' then 0.00 else DebetD  DebetD,  

            Case when Valas='IDR' then 0.00 else KreditD  KreditD, 

                      KodeSales, Tipe, PERKIRAAN, Catatan, NoInvoice, KodeVls_, Kurs_,DEVISI

    from Dbo.fnc_PostPenjualan(@NoBuktiTrans)  

   else

  if @JenisTrans='INVRPJ'

  Insert into dbo.DBHUTPIUT(NoFaktur, NoRetur, TipeTrans, KodeCustSupp, NoBukti, NoMsk, Urut, Tanggal, JatuhTempo, 

                              Debet, Kredit,  Valas, Kurs, DebetD, KreditD, 

                              KodeSales, Tipe, Perkiraan, Catatan, NOINVOICE,  KodeVls_, Kurs_,Devisi)

    Select  NoFaktur, NoRetur, Tipetrans, KODECUSTSUPP, Nobukti, NoMsk, urut, TANGGAL, JatuhTempo, 

            Debet, Kredit,  KODEVLS, KURS, 

            Case when KODEVLS='IDR' then 0.00 else DebetD  DebetD,  

            Case when KODEVLS='IDR' then 0.00 else KreditD  KreditD, 

                      KodeSales, Tipe, PERKIRAAN, Catatan, NoInvoice, KodeVls_, Kurs_,DEVISI

    from Dbo.fnc_PostReturPenjualan(@NoBuktiTrans);

-- sp_ProsesPostingJurnalOto
CREATE PROCEDURE IF NOT EXISTS sp_ProsesPostingJurnalOto AS -- DECLARE REMOVED

if @JenisTrans='BL' 

Select @NoJurnal=NoJurnal from DBBELI where NOBUKTI=@NoBukti

delete DBJurnalOto where Jenis=@JenisTrans and NoBukti=@NoJurnal and YEAR(Tanggal)=@Tahun and MONTH(Tanggal)=@Bulan



else if @JenisTrans='RBL' 

Select @NoJurnal=NoJurnal from DBRBELI where NOBUKTI=@NoBukti

delete DBJurnalOto where Jenis=@JenisTrans and NoBukti=@NoJurnal and YEAR(Tanggal)=@Tahun and MONTH(Tanggal)=@Bulan



else if @JenisTrans='BP' 

Select @NoJurnal=NoJurnal from DBInvoicePL where NOBUKTI=@NoBukti

delete DBJurnalOto where Jenis=@JenisTrans and NoBukti=@NoJurnal and YEAR(Tanggal)=@Tahun and MONTH(Tanggal)=@Bulan



else if @JenisTrans='INVRPJ' 

Select @NoJurnal=NoJurnal from dbRInvoicePL where NOBUKTI=@NoBukti

delete DBJurnalOto where Jenis=@JenisTrans and NoBukti=@NoJurnal and YEAR(Tanggal)=@Tahun and MONTH(Tanggal)=@Bulan



else if @JenisTrans='INVRPJ' 

Select @NoJurnal=NoJurnal from dbSPBRJual where NOBUKTI=@NoBukti

delete DBJurnalOto where Jenis=@JenisTrans and NoBukti=@NoBukti and YEAR(Tanggal)=@Tahun and MONTH(Tanggal)=@Bulan



else if @JenisTrans='HPR' 

Select @NoJurnal=NoJurnal from DBHASILPRD where NOBUKTI=@NoBukti

delete DBJurnalOto where Jenis=@JenisTrans and NoBukti=@NoJurnal and YEAR(Tanggal)=@Tahun and MONTH(Tanggal)=@Bulan



else

delete DBJurnalOto where Jenis=@JenisTrans and NoBukti=@NoBukti and YEAR(Tanggal)=@Tahun and MONTH(Tanggal)=@Bulan



if @TipeProses=1

if @JenisTrans='BL'

  Insert into DBO.dbJurnalOTO(NoBukti, Tanggal, Devisi, Note, Lampiran, IsOtorisasi1, OtoUser1, TglOto1, IsOtorisasi2, OtoUser2, TglOto2, IsOtorisasi3, OtoUser3, TglOto3, IsOtorisasi4, OtoUser4, 

                                TglOto4, IsOtorisasi5, OtoUser5, TglOto5, Urut, Perkiraan, Lawan, Keterangan, Keterangan2, Debet, Kredit, Valas, Kurs, DebetRp, KreditRp, TipeTrans, TPHC, 

                                CustSuppP, CustSuppL, KodeP, KodeL, NoAktivaP, NoAktivaL, StatusAktivaP, StatusAktivaL, Nobon, KodeBag, StatusGiro,  Jenis, NOURUT)

    Select  NOBUKTI, TANGGAL, DEVISI, NOTE, LAMPIRAN, IsOtorisasi1, OTOUSER1, TGLOTO1, ISOTORISASI2, OTOUSER2, TGLOTO2, ISOTORISASI3, OTOUSER3, TGLOTO3, 

            ISOTORISASI4, OTOUSER4, TGLOTO4, ISOTORISASI5, OTOUSER5, TGLOTO5,CAST(ROW_NUMBER() Over(PARTITION BY Nobukti Order by Nobukti) As int) URUT, PERKIRAAN, LAWAN, KETERANGAN, KETERANGAN2, DEBET, KREDIT, VALAS, 

            KURS, DEBETRP, KREDITRP, TIPETRANS, TPHC, CUSTSUPPP, CUSTSUPPL, KODEP, KODEL, NOAKTIVAP, NOAKTIVAL, STATUSAKTIVAP, STATUSAKTIVAL, NOBON, 

            KODEBAG, STATUSGIRO,  JENIS, NOURUT

    From Dbo.fnc_JurnalBP(@nobukti)

   else

  if @JenisTrans='RBL'

  Insert into DBO.dbJurnalOTO(NoBukti, Tanggal, Devisi, Note, Lampiran, IsOtorisasi1, OtoUser1, TglOto1, IsOtorisasi2, OtoUser2, TglOto2, IsOtorisasi3, OtoUser3, TglOto3, IsOtorisasi4, OtoUser4, 

                                TglOto4, IsOtorisasi5, OtoUser5, TglOto5, Urut, Perkiraan, Lawan, Keterangan, Keterangan2, Debet, Kredit, Valas, Kurs, DebetRp, KreditRp, TipeTrans, TPHC, 

                                CustSuppP, CustSuppL, KodeP, KodeL, NoAktivaP, NoAktivaL, StatusAktivaP, StatusAktivaL, Nobon, KodeBag, StatusGiro,  Jenis, NOURUT)

    Select  NOBUKTI, TANGGAL, DEVISI, NOTE, LAMPIRAN, IsOtorisasi1, OTOUSER1, TGLOTO1, ISOTORISASI2, OTOUSER2, TGLOTO2, ISOTORISASI3, OTOUSER3, TGLOTO3, 

            ISOTORISASI4, OTOUSER4, TGLOTO4, ISOTORISASI5, OTOUSER5, TGLOTO5, CAST(ROW_NUMBER() Over(PARTITION BY Nobukti Order by Nobukti) As int) URUT, PERKIRAAN, LAWAN, KETERANGAN, KETERANGAN2, DEBET, KREDIT, VALAS, 

            KURS, DEBETRP, KREDITRP, TIPETRANS, TPHC, CUSTSUPPP, CUSTSUPPL, KODEP, KODEL, NOAKTIVAP, NOAKTIVAL, STATUSAKTIVAP, STATUSAKTIVAL, NOBON, 

            KODEBAG, STATUSGIRO,  JENIS, NOURUT

    From fnc_JurnalRBP(@nobukti) 

   else

  if @JenisTrans='SPB'

  Insert into DBO.dbJurnalOTO(NoBukti, Tanggal, Devisi, Note, Lampiran, IsOtorisasi1, OtoUser1, TglOto1, IsOtorisasi2, OtoUser2, TglOto2, IsOtorisasi3, OtoUser3, TglOto3, IsOtorisasi4, OtoUser4, 

                                TglOto4, IsOtorisasi5, OtoUser5, TglOto5, Urut, Perkiraan, Lawan, Keterangan, Keterangan2, Debet, Kredit, Valas, Kurs, DebetRp, KreditRp, TipeTrans, TPHC, 

                                CustSuppP, CustSuppL, KodeP, KodeL, NoAktivaP, NoAktivaL, StatusAktivaP, StatusAktivaL, Nobon, KodeBag, StatusGiro,  Jenis, NOURUT)

    Select  NOBUKTI, TANGGAL, DEVISI, NOTE, LAMPIRAN, IsOtorisasi1, OTOUSER1, TGLOTO1, ISOTORISASI2, OTOUSER2, TGLOTO2, ISOTORISASI3, OTOUSER3, TGLOTO3, 

            ISOTORISASI4, OTOUSER4, TGLOTO4, ISOTORISASI5, OTOUSER5, TGLOTO5, 

            CAST(ROW_NUMBER() Over(PARTITION BY NoBukti Order by NoBukti) As int) URUT, 

            PERKIRAAN, LAWAN, KETERANGAN, KETERANGAN2, DEBET, KREDIT, VALAS, 

            KURS, DEBETRP, KREDITRP, TIPETRANS, TPHC, CUSTSUPPP, CUSTSUPPL, KODEP, KODEL, NOAKTIVAP, NOAKTIVAL, STATUSAKTIVAP, STATUSAKTIVAL, NOBON, 

            KODEBAG, STATUSGIRO,  JENIS, NOURUT

    From [fnc_JurnalSPB](@nobukti)

   else

  if @JenisTrans='RSPB'

  Insert into DBO.dbJurnalOTO(NoBukti, Tanggal, Devisi, Note, Lampiran, IsOtorisasi1, OtoUser1, TglOto1, IsOtorisasi2, OtoUser2, TglOto2, IsOtorisasi3, OtoUser3, TglOto3, IsOtorisasi4, OtoUser4, 

                                TglOto4, IsOtorisasi5, OtoUser5, TglOto5, Urut, Perkiraan, Lawan, Keterangan, Keterangan2, Debet, Kredit, Valas, Kurs, DebetRp, KreditRp, TipeTrans, TPHC, 

                                CustSuppP, CustSuppL, KodeP, KodeL, NoAktivaP, NoAktivaL, StatusAktivaP, StatusAktivaL, Nobon, KodeBag, StatusGiro,  Jenis, NOURUT)

    Select  NOBUKTI, TANGGAL, DEVISI, NOTE, LAMPIRAN, IsOtorisasi1, OTOUSER1, TGLOTO1, ISOTORISASI2, OTOUSER2, TGLOTO2, ISOTORISASI3, OTOUSER3, TGLOTO3, 

            ISOTORISASI4, OTOUSER4, TGLOTO4, ISOTORISASI5, OTOUSER5, TGLOTO5, 

            CAST(ROW_NUMBER() Over(PARTITION BY NoBukti Order by NoBukti) As int) URUT, 

            PERKIRAAN, LAWAN, KETERANGAN, KETERANGAN2, DEBET, KREDIT, VALAS, 

            KURS, DEBETRP, KREDITRP, TIPETRANS, TPHC, CUSTSUPPP, CUSTSUPPL, KODEP, KODEL, NOAKTIVAP, NOAKTIVAL, STATUSAKTIVAP, STATUSAKTIVAL, NOBON, 

            KODEBAG, STATUSGIRO,  JENIS, NOURUT

    From [fnc_JurnalRSPB](@nobukti)  

   else

  if @JenisTrans='BP'

  Insert into DBO.dbJurnalOTO(NoBukti, Tanggal, Devisi, Note, Lampiran, IsOtorisasi1, OtoUser1, TglOto1, IsOtorisasi2, OtoUser2, TglOto2, IsOtorisasi3, OtoUser3, TglOto3, IsOtorisasi4, OtoUser4, 

                                TglOto4, IsOtorisasi5, OtoUser5, TglOto5, Urut, Perkiraan, Lawan, Keterangan, Keterangan2, Debet, Kredit, Valas, Kurs, DebetRp, KreditRp, TipeTrans, TPHC, 

                                CustSuppP, CustSuppL, KodeP, KodeL, NoAktivaP, NoAktivaL, StatusAktivaP, StatusAktivaL, Nobon, KodeBag, StatusGiro,  Jenis, NOURUT)

    Select  NOBUKTI, TANGGAL, DEVISI, NOTE, LAMPIRAN, IsOtorisasi1, OTOUSER1, TGLOTO1, ISOTORISASI2, OTOUSER2, TGLOTO2, ISOTORISASI3, OTOUSER3, TGLOTO3, 

            ISOTORISASI4, OTOUSER4, TGLOTO4, ISOTORISASI5, OTOUSER5, TGLOTO5, 

            CAST(ROW_NUMBER() Over(PARTITION BY NoBukti Order by NoBukti) As int) URUT, 

            PERKIRAAN, LAWAN, KETERANGAN, KETERANGAN2, DEBET, KREDIT, VALAS, 

            KURS, DEBETRP, KREDITRP, TIPETRANS, TPHC, CUSTSUPPP, CUSTSUPPL, KODEP, KODEL, NOAKTIVAP, NOAKTIVAL, STATUSAKTIVAP, STATUSAKTIVAL, NOBON, 

            KODEBAG, STATUSGIRO,  JENIS, NOURUT

    From [fnc_JurnalPenjualan](@nobukti)  

   else

  if @JenisTrans='INVRPJ'

  Insert into DBO.dbJurnalOTO(NoBukti, Tanggal, Devisi, Note, Lampiran, IsOtorisasi1, OtoUser1, TglOto1, IsOtorisasi2, OtoUser2, TglOto2, IsOtorisasi3, OtoUser3, TglOto3, IsOtorisasi4, OtoUser4, 

                                TglOto4, IsOtorisasi5, OtoUser5, TglOto5, Urut, Perkiraan, Lawan, Keterangan, Keterangan2, Debet, Kredit, Valas, Kurs, DebetRp, KreditRp, TipeTrans, TPHC, 

                                CustSuppP, CustSuppL, KodeP, KodeL, NoAktivaP, NoAktivaL, StatusAktivaP, StatusAktivaL, Nobon, KodeBag, StatusGiro,  Jenis, NOURUT)

    Select  NOBUKTI, TANGGAL, DEVISI, NOTE, LAMPIRAN, IsOtorisasi1, OTOUSER1, TGLOTO1, ISOTORISASI2, OTOUSER2, TGLOTO2, ISOTORISASI3, OTOUSER3, TGLOTO3, 

            ISOTORISASI4, OTOUSER4, TGLOTO4, ISOTORISASI5, OTOUSER5, TGLOTO5, 

            CAST(ROW_NUMBER() Over(PARTITION BY NoBukti Order by NoBukti) As int) URUT, 

            PERKIRAAN, LAWAN, KETERANGAN, KETERANGAN2, DEBET, KREDIT, VALAS, 

            KURS, DEBETRP, KREDITRP, TIPETRANS, TPHC, CUSTSUPPP, CUSTSUPPL, KODEP, KODEL, NOAKTIVAP, NOAKTIVAL, STATUSAKTIVAP, STATUSAKTIVAL, NOBON, 

            KODEBAG, STATUSGIRO,  JENIS, NOURUT

    From fnc_JurnalInvoiceRPJ(@nobukti)  

   else

  if @JenisTrans='INVRPJ'

  Insert into DBO.dbJurnalOTO(NoBukti, Tanggal, Devisi, Note, Lampiran, IsOtorisasi1, OtoUser1, TglOto1, IsOtorisasi2, OtoUser2, TglOto2, IsOtorisasi3, OtoUser3, TglOto3, IsOtorisasi4, OtoUser4, 

                                TglOto4, IsOtorisasi5, OtoUser5, TglOto5, Urut, Perkiraan, Lawan, Keterangan, Keterangan2, Debet, Kredit, Valas, Kurs, DebetRp, KreditRp, TipeTrans, TPHC, 

                                CustSuppP, CustSuppL, KodeP, KodeL, NoAktivaP, NoAktivaL, StatusAktivaP, StatusAktivaL, Nobon, KodeBag, StatusGiro,  Jenis, NOURUT)

    Select  NOBUKTI, TANGGAL, DEVISI, NOTE, LAMPIRAN, IsOtorisasi1, OTOUSER1, TGLOTO1, ISOTORISASI2, OTOUSER2, TGLOTO2, ISOTORISASI3, OTOUSER3, TGLOTO3, 

            ISOTORISASI4, OTOUSER4, TGLOTO4, ISOTORISASI5, OTOUSER5, TGLOTO5, 

            CAST(ROW_NUMBER() Over(PARTITION BY NoBukti Order by NoBukti) As int) URUT, 

            PERKIRAAN, LAWAN, KETERANGAN, KETERANGAN2, DEBET, KREDIT, VALAS, 

            KURS, DEBETRP, KREDITRP, TIPETRANS, TPHC, CUSTSUPPP, CUSTSUPPL, KODEP, KODEL, NOAKTIVAP, NOAKTIVAL, STATUSAKTIVAP, STATUSAKTIVAL, NOBON, 

            KODEBAG, STATUSGIRO,  JENIS, NOURUT

    From fnc_JurnalSPBRJual(@nobukti)  

   else

  if @JenisTrans='HPR'

  Insert into DBO.dbJurnalOTO(NoBukti, Tanggal, Devisi, Note, Lampiran, IsOtorisasi1, OtoUser1, TglOto1, IsOtorisasi2, OtoUser2, TglOto2, IsOtorisasi3, OtoUser3, TglOto3, IsOtorisasi4, OtoUser4, 

                                TglOto4, IsOtorisasi5, OtoUser5, TglOto5, Urut, Perkiraan, Lawan, Keterangan, Keterangan2, Debet, Kredit, Valas, Kurs, DebetRp, KreditRp, TipeTrans, TPHC, 

                                CustSuppP, CustSuppL, KodeP, KodeL, NoAktivaP, NoAktivaL, StatusAktivaP, StatusAktivaL, Nobon, KodeBag, StatusGiro,  Jenis, NOURUT)

    Select  NOBUKTI, TANGGAL, DEVISI, NOTE, LAMPIRAN, IsOtorisasi1, OTOUSER1, TGLOTO1, ISOTORISASI2, OTOUSER2, TGLOTO2, ISOTORISASI3, OTOUSER3, TGLOTO3, 

            ISOTORISASI4, OTOUSER4, TGLOTO4, ISOTORISASI5, OTOUSER5, TGLOTO5, 

            CAST(ROW_NUMBER() Over(PARTITION BY NoBukti Order by NoBukti) As int) URUT, 

            PERKIRAAN, LAWAN, KETERANGAN, KETERANGAN2, DEBET, KREDIT, VALAS, 

            KURS, DEBETRP, KREDITRP, TIPETRANS, TPHC, CUSTSUPPP, CUSTSUPPL, KODEP, KODEL, NOAKTIVAP, NOAKTIVAL, STATUSAKTIVAP, STATUSAKTIVAL, NOBON, 

            KODEBAG, STATUSGIRO,  JENIS, NOURUT

    From [fnc_JurnalHasilPrd](@nobukti);

-- Sp_RBeli
CREATE PROCEDURE IF NOT EXISTS Sp_RBeli AS tran

if @Choice='I'

select @Urut=COALESCE(max(urut),0)+1 from dbRBelidet Where NoBukti=@NoBukti

  if not exists(select * from dbRBeli Where NoBukti=@NoBukti) 

  insert into dbRBeli (NOBUKTI, NOURUT, TANGGAL,Kodegdg, TglJatuhTempo, KODESUPP, NoBeli, Handling, KodeExp, KETERANGAN, 

	FakturSUPP, KODEVLS, KURS, PPN, TIPEBAYAR, HARI, TIPEDISC, DISC, DISCRP)

    values (@NOBUKTI, @NOURUT, @TANGGAL,@KodeGdg, @TglJatuhTempo, @KODESUPP, @NoBeli, @Handling, @KodeExp, @KETERANGAN,

	@FakturSupp, 'IDR', @KURS, @PPN, @TIPEBAYAR, @HARI, @TIPEDISC, @DISC, @DISCRP)

  

  insert into dbRBeliDET (NOBUKTI, URUT, PPN, Disc, KODEBRG, QNT, NoSat, Isi, Satuan, HARGA, DISCP, DISCTOT, UrutPBL,Qnt2, KURS,NamaBrg)

  values(@NOBUKTI, @URUT, @PPN, @Disc, @KODEBRG, @Qnt, @NoSat, @Isi, @Satuan, @Harga, @DiscP, @DiscRp, @UrutPBL,@Qnt2, @Kurs ,@NamaBrg)



if @Choice='U'

update dbRBeliDET set KodeBrg=@KODEBRG, Qnt=@QNT, NoSat=@NoSat, Isi=@Isi, Satuan=@Satuan, Harga=@HARGA, DiscP=@DiscP, DiscTot=@DiscTot, UrutPBL=@UrutPBL,Qnt2=@Qnt2,

  NamaBrg=@NamaBrg

  where NoBukti=@NoBukti and Urut=@Urut



if @Choice='D'

delete dbRBeliDET where NoBukti=@NoBukti and Urut=@Urut 

  if not exists( select NoBukti from dbRBeliDET where NoBukti=@NoBukti)

  delete dbRBeli where NoBukti=@NoBukti


-- IF EXISTS REMOVED
Update DBRBELI Set NILAIDPP=(select SUM(NDPP)NDPP from DBRBELIDET where NOBUKTI=DBRBELI.NOBUKTI),

                     NILAINET=(select SUM(NNET)NNET from DBRBELIDET where NOBUKTI=DBRBELI.NOBUKTI),

                     NILAIPPN=(select SUM(NPPN)NPPN from DBRBELIDET where NOBUKTI=DBRBELI.NOBUKTI)

   where NOBUKTI=@NoBukti                  


if @@error<>0  goto jikasalah

Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- sp_RBeliGudang
CREATE PROCEDURE IF NOT EXISTS sp_RBeliGudang AS -- DECLARE REMOVED, @DiscP numeric(18,2), @DiscTot numeric(18,2)

-- DECLARE REMOVED, @Disc float, @Kurs numeric(18,4)



tran



if @Choice='I'

select @Urut=COALESCE(max(urut),0)+1 from dbRBeliDet Where NoBukti=@NoBukti

  if @@error<>0  goto jikasalah

  if not exists(select * from dbRBeli Where NoBukti=@NoBukti) 

  -- IF EXISTS REMOVED
insert into dbRBeli (Devisi,NOBUKTI, NOURUT, TANGGAL, TglJatuhTempo, KODESUPP, Handling,  KETERANGAN, 

	FakturSUPP, KODEVLS, KURS, PPN, TIPEBAYAR, HARI, TipeDisc, DISC, DiscRp, NoBeli, KodeGdg,Tf,Do)

	select Devisi,@NoBukti, @NoUrut, @Tanggal, @Tanggal+HARI, @KodeSupp, HANDLING, @Keterangan,

	@FakturSupp, KODEVLS, KURS, PPN, TIPEBAYAR, HARI, TipeDisc, DISC, DISCRP, @NoBeli, @KodeGdg,0,@Choice

	from DBBELI 

	where NOBUKTI=@NoBeli

	

	else

	insert into dbRBeli (Devisi,NOBUKTI, NOURUT, TANGGAL, TglJatuhTempo, KODESUPP, Handling,  KETERANGAN, 

	FakturSUPP, KODEVLS, KURS, PPN, TIPEBAYAR, HARI, TipeDisc, DISC, DiscRp, NoBeli, KodeGdg,Tf,Do)

	Values(@Devisi,@NOBUKTI, @NOURUT, @Tanggal, @Tanggal, @KodeSupp, 0,  @Keterangan, 

	@FakturSupp, 'IDR', COALESCE(@Kurs,1), @PPN, 0, 0, 0, 0, 0, '-', @KodeGdg,0,@Choice)

	

	if @@error<>0  goto jikasalah


  select @PPN=PPN, @Disc=DISC, @Kurs=KURS from DBRBELI where NOBUKTI=@NoBukti

  if @@error<>0  goto jikasalah

  

  select top 1 @Harga=COALESCE(HARGA,0), @DiscP=COALESCE(DISCP,0), @DiscTot=COALESCE(DISCTOT,0) 

  from DBBELIDET

  where NOBUKTI=@NoBeli and Urut=@UrutPBL

  if @@error<>0  goto jikasalah

  

  select @Harga=COALESCE(@Harga,0), @DiscP=COALESCE(@DiscP,0), @DiscTot=COALESCE(@DiscTot,0)

  if @@error<>0  goto jikasalah

  

  insert into dbRBeliDET (NOBUKTI, URUT, KODEBRG, PPN, DISC, KURS, 

  QNT, NOSAT, SATUAN, ISI, HARGA, DISCP, DISCTOT, BYANGKUT, 

  NOPBL, URUTPBL, HPP, Qnt1, Qnt2,NamaBrg,Tf,Do)

  values(@NOBUKTI, @URUT, @KODEBRG, @PPN, @Disc, COALESCE(@Kurs,1),

  @Qnt, @NoSat, @Satuan, @Isi, @Harga, @DiscP, @DiscTOT, 0.00,

  COALESCE(@NoBeli,'-'), COALESCE(@UrutPBL,0), 0, @Qnt1, @Qnt2,@NamaBrg,0,@Choice)

  if @@error<>0  goto jikasalah


if @Choice='U'

update dbRBeliDET set KodeBrg=@KODEBRG,  Qnt=@Qnt, NOSAT=@NoSat, SATUAN=@Satuan, ISI=@Isi,

  Qnt1=@Qnt1, Qnt2=@Qnt2,NamaBrg=@NamaBrg,Tf=0,Do=@Choice 

  where NoBukti=@NoBukti and Urut=@Urut

  if @@error<>0  goto jikasalah


if @Choice='D'

delete dbRBeliDET where NoBukti=@NoBukti and Urut=@Urut

  insert TempDelDataDet

  select @Nobukti,@Urut,'dbRBeliDET'	

  if @@error<>0  goto jikasalah 

  if not exists( select NoBukti from dbRBeliDET where NoBukti=@NoBukti)

  delete dbRBeli where NoBukti=@NoBukti

  	insert TempDelData

    select @Nobukti,'dbRBeli'

    if @@error<>0  goto jikasalah


---- IF EXISTS REMOVED
-- --   Update DBBELI Set NILAIDPP=(select SUM(NDPP)NDPP from DBBELIDET where NOBUKTI=DBBELI.NOBUKTI),

--                     NILAINET=(select SUM(NNET)NNET from DBBELIDET where NOBUKTI=DBBELI.NOBUKTI),

--                     NILAIPPN=(select SUM(NPPN)NPPN from DBBELIDET where NOBUKTI=DBBELI.NOBUKTI)

--   where NOBUKTI=@NoBukti                  

--  

--if @@error<>0  goto jikasalah

if @Choice in('I','U')

exec [sp_UpdateTransaksiPPN] 'dbRBeliDET','dbRBeli',@NoBukti


Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- sp_RefreshOutPPL
CREATE PROCEDURE IF NOT EXISTS sp_RefreshOutPPL AS update 	dbPPLDet set QntPO=COALESCE(B.QntPO,0)

from	dbPPLDet A

left outer join

	(select NoPPL, UrutPPL, sum(Qnt) QntPO from dbPODet

	where NoPPL=@NoBukti

	group by NoPPL, UrutPPL

	) B on B.NoPPL=A.NoBukti and B.UrutPPL=A.Urut

where	A.NoBukti=@NoBukti;

-- SP_RefreshQntBatalPO
CREATE PROCEDURE IF NOT EXISTS SP_RefreshQntBatalPO AS update DBPODET set QntBtl=COALESCE(B.Qnt,0), Qnt2Btl=COALESCE(B.Qnt2,0) 

from dbPODet A

left outer join

	(select A.NOBUKTI, A.URUT 

	from DBPODET A

	left outer join DBBatalPODET B on B.NoPO=A.NOBUKTI and B.UrutPO=A.URUT

	group by A.NOBUKTI, A.URUT, A.QntBtl ,A.Qnt2Btl

	having COALESCE(A.QntBtl,0)<>SUM(COALESCE(B.Qnt,0)) or COALESCE(A.Qnt2Btl,0)<>SUM(COALESCE(B.Qnt2,0))

	) A0 on A0.NOBUKTI=A.NOBUKTI and A0.URUT=A.URUT

left outer join 

	(select NOPO, UrutPO, sum(Qnt) Qnt, sum(Qnt2) Qnt2 from dbBatalPODet 

	group by NoPO, UrutPO

	) B on B.NOPO=A.NOBUKTI and B.UrutPO=A.Urut

where A0.NOBUKTI is not null;

-- SP_RefreshQntBatalPPL
CREATE PROCEDURE IF NOT EXISTS SP_RefreshQntBatalPPL AS update DBPPLDET set QntBtl=COALESCE(B.Qnt,0), Qnt2Btl=COALESCE(B.Qnt2,0) 

from dbPPLDet A

left outer join

	(select A.NOBUKTI, A.URUT 

	from DBPPLDET A

	left outer join DBBatalPPLDET B on B.NoPPL=A.NOBUKTI and B.UrutPPL=A.URUT

	group by A.NOBUKTI, A.URUT, A.QntBtl ,A.Qnt2Btl

	having COALESCE(A.QntBtl,0)<>SUM(COALESCE(B.Qnt,0)) or COALESCE(A.Qnt2Btl,0)<>SUM(COALESCE(B.Qnt2,0))

	) A0 on A0.NOBUKTI=A.NOBUKTI and A0.URUT=A.URUT

left outer join 

	(select NOPPL, UrutPPL, sum(Qnt) Qnt, sum(Qnt2) Qnt2 from dbBatalPPLDet 

	group by NoPPL, UrutPPL

	) B on B.NOPPL=A.NOBUKTI and B.UrutPPL=A.Urut

where A0.NOBUKTI is not null;

-- sp_RefreshTempOutstandingPO
CREATE PROCEDURE IF NOT EXISTS sp_RefreshTempOutstandingPO AS --Select @NoBukti='SJY/0113/PO/0006'

--exec sp_RefreshOutPO @NoBukti



delete	TempOutstandingPO where IDUser=@IDUser or @NoBukti=@NoBukti



insert into TempOutstandingPO (IDUser, IsTerima, NOBUKTI, Tanggal, KeyNoBukti, 

	URUT, KODEBRG, KodeWarna, NAMABRG, QNT, NOSAT, SATUAN, ISI, 

	HARGA, DISCP, DISCTOT, QntSisa, CollyTerima, QntTerima)

select	@IDUser, cast(0 as INTEGER) IsTerima, A.NoBukti, A.Tanggal, A.NoBukti+'-'+SUBSTR('00000000'+cast(min(A.Urut) as varchar(8)), LENGTH('00000000'+cast(min(A.Urut) as varchar(8)))-8+1) KeyNoBukti, 

	min(A.Urut) Urut, A.KodeBrg, '' KodeWarna, COALESCE(A.NamaBrg,Br.NamaBrg)NamaBrg, sum(A.Qnt) Qnt, A.NoSat, 

	case when A.NOSAT=1 then Br.SAT1 else Br.SAT2  Satuan, 

	case when A.NOSAT=1 then 1 else Br.ISI2  Isi, 

	max(A.Harga) Harga, DiscP, DiscTot, sum(A.QntOut) QntSisa, 0 CollyTerima, sum(A.QntOut) QntTerima

--from	vwOutstandingPO A

--where	A.NoBukti=@NoBukti

from (

select A.NoBukti, A.Tanggal, B.Urut, B.KODEBRG,B.NamaBrg, B.NOSAT, B.Qnt, B.Qnt+(B.Qnt*(B.Tolerate/100)) QntOut, B.HARGA , B.DISCP, B.DISCTOT

from DBPO A, DBPODET B

where A.NOBUKTI=B.NOBUKTI and A.NOBUKTI=@NoBukti

union all

select A.NoBukti, A.Tanggal, 99999 Urut, B.KODEBRG,B.NamaBrg, B.NOSAT, 0.00 Qnt, -(B.Qnt) QntOut, 0.00 Harga, B.DISCP, B.DISCTOT

from DBPO A, DBBELIDET B

where A.NOBUKTI=B.NoPO and A.NOBUKTI=@NoBukti

) A

left outer join DBBARANG Br on Br.KODEBRG=A.KODEBRG 

group by A.NOBUKTI, A.TANGGAL, A.KODEBRG,A.NamaBrg, Br.NAMABRG, A.NOSAT, Br.SAT1, Br.SAT2, Br.ISI1, Br.ISI2, DISCP, DISCTOT

Having SUM(A.QntOut)>0;

-- sp_RegisterGiroHutang
CREATE PROCEDURE IF NOT EXISTS sp_RegisterGiroHutang AS --Select @Perkiraan='111',@Tanggal='03-20-2008',@Devisi='01',@Tanggal1='03-20-2008'

-- DECLARE REMOVED,@tahun Int,@TglCair datetime,@TglBuka datetime

Select @Bulan=Month(@tanggal),@tahun=Year(@Tanggal)

Select @tahun=@tahun+Case when @bulan=12 then 1 else 0 

Select @Tglcair=Cast(cast(@bulan as varchar(2))+'-01-'+cast(@tahun as varchar(4)) as datetime)

Select @tglBuka=dateadd(dd,0,cast(cast(@Bulan+1 as varchar(2))+'-01-'+cast(@tahun as varchar(4)) as datetime))



 delete dbtempbkbesar where devisi=@devisi

 -- DECLARE REMOVED,@tipe varchar(2)

 Declare CurNeraca Cursor for

  select Perkiraan from dbperkiraan where perkiraan=@Perkiraan and tipe=1

  order by perkiraan    

 Open CurNeraca

    Fetch Next from CurNeraca into @xperkiraan

 While @@fetch_Status=0

 exec sp_GenerateSaldobukutambahan @bulan,@tahun,@xperkiraan,'T',@devisi

  exec Sp_GenerateTransBukuTambahan @Tanggal,@xperkiraan,'T',@devisi,@Tanggal1

  Fetch Next from CurNeraca into @perkiraan

 

     Close CurNeraca

     Deallocate CurNeraca


Select 1 urut,a.TglBuka,a.buktibuka,a.Keterangan,a.Nogiro,a.TglGiro,

       0 debet, a.KreditRp Kredit, a.KreditRp Jumlah, 0 Debet_1, 0 kredit_1, 0 Saldo

from DBGiro a

     left outer join dbtransaksi b on b.nobukti=a.buktibuka and b.Urut=a.UrutBuktiBuka

Where a.bank=@Perkiraan and (a.TglBuka between @Tanggal and @Tanggal1) and a.Tipe='HT'

union

Select 2,case when (a.bukticair like '%BBM%' and a.Tipe='HT') then a.TglCair else a.TglGiro  'TglCair', a.bukticair,a.Keterangancair,a.Nogiro,Case when a.nogiro<>'' then a.TglGiro else null  'TglGiro',

       a.KreditRp Debet, 0 , -a.KreditRp Jumlah,case when b.NoBukti <>'' then  b.KreditRp else 0  Debet_1,a.KreditRp Kredit_1,(case when b.NoBukti <>'' then  b.KreditRp else 0 ) - a.KreditRp Saldo

from DBGiro a

     left outer join dbtransaksi b on b.nobukti=COALESCE(a.buktiBuka,'') and b.Urut=a.UrutBuktiBuka

where  a.bank=@Perkiraan and (a.TglGiro between @Tanggal and @Tanggal1) and a.Tipe='HT'

union

Select 3,a.Tanggal,a.Nobukti,a.Keterangan,null Nogiro,Case when b.nogiro<>'' then b.TglGiro else null  'TglGiro',0,0,0,

       Case when a.Perkiraan=@Perkiraan then A.DebetRp else 0  Debet_1, 

       case when a.Perkiraan=@Perkiraan then 0 else A.DebetRp  Kredit_1 ,

       Case when a.Perkiraan=@Perkiraan then a.DebetRp else -a.DebetRp  saldo

From dbTransaksi a

     left Outer join dbgiro B on B.Buktibuka=A.nobukti and B.urutBuktiBuka=A.urut and B.Tipe='HT'

where  (a.Tanggal between @Tanggal and @Tanggal1) and (a.Perkiraan=@Perkiraan or a.lawan=@Perkiraan)

     and A.NoBukti+Cast(a.Urut as varchar(5)) not in (Select x.BuktiBuka+Cast(x.UrutBuktiBuka as varchar(5)) from DBGIRO x where x.Tipe='HT' and (x.TglBuka between @Tanggal and @Tanggal1) and x.Bank=a.Lawan)

Union 

Select 0 urut,null,'Saldo Awal','Saldo Awal','',null,0,0,

       COALESCE((Select sum(a.KreditRp)

               From DBGiro a 

               where (a.tglGiro>=@Tanggal) and a.TglBuka<@Tanggal and a.Bank=@perkiraan

       ),0),0,0,

       COALESCE(sum(case when b.transaksi='D' then b.Debet-b.kredit

                when b.transaksi='K' then b.Kredit-b.debet

                else b.Saldoawal 

           ),0)+COALESCE((Select sum(a.KreditRp)

               From DBGiro a 

               where (a.tglGiro>=@Tanggal) and a.TglBuka<@Tanggal and a.Bank=@perkiraan

       ),0)

From dbTempbkBesar b

where b.tanggal<@Tanggal and b.noacc=@Perkiraan

order by TglBuka;

-- sp_renamediagram
CREATE PROCEDURE IF NOT EXISTS sp_renamediagram AS 'dbo'

	AS

	set nocount on

		-- DECLARE REMOVED

		-- DECLARE REMOVED

		

		-- DECLARE REMOVED

		-- DECLARE REMOVED

		-- DECLARE REMOVED

		-- DECLARE REMOVED

		if((@diagramname is null) or (@new_diagramname is null))

		RAISERROR ('Invalid value', 16, 1);

			return -1


		EXECUTE AS CALLER;

		select @theId = DATABASE_PRINCIPAL_ID();

		select @IsDbo = IS_MEMBER(N'db_owner'); 

		if(@owner_id is null)

			select @owner_id = @theId;

		REVERT;

	

		select @u_name = USER_NAME(@owner_id)

	

		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 

		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))

		RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)

			return -3


		-- if((@u_name is not null) and (@new_diagramname = @diagramname))	-- nothing will change

		--	return 0;

	

		if(@u_name is null)

			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @new_diagramname

		else

			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @owner_id and name = @new_diagramname

	

		if((@DiagIdTarg is not null) and  @DiagId <> @DiagIdTarg)

		RAISERROR ('The name is already used.', 16, 1);

			return -2


		if(@u_name is null)

			update dbo.sysdiagrams set [name] = @new_diagramname, principal_id = @theId where diagram_id = @DiagId

		else

			update dbo.sysdiagrams set [name] = @new_diagramname where diagram_id = @DiagId

		return 0;

-- Sp_RepHrgAkhir
CREATE PROCEDURE IF NOT EXISTS Sp_RepHrgAkhir AS select A.KODEBRG,A.NAMABRG,A.Tanggal,D.Harga,D.NOBUKTI,D.NOURUT,D.URUT from (

select A.KODEBRG,MAX(B.TANGGAL) Tanggal,C.NAMABRG,MAX(B.NOURUT) Nourut,MAX(A.URUT) Urut

from DBBELIDET A

Left Outer join DBBELI B on A.NOBUKTI = B.NOBUKTI

Left Outer join DBBARANG C on A.KODEBRG = C.KODEBRG 

Group by A.KODEBRG,C.NAMABRG)A 

inner join (Select A.Kodebrg,B.Tanggal,A.Harga,B.NOURUT,A.URUT,B.NOBUKTI from DBBELIDET A

					left outer join DBBELI B on A.NOBUKTI = B.NOBUKTI 

			)D on A.KODEBRG = D.KODEBRG and A.tanggal = D.TANGGAL and A.Nourut=D.NOURUT and A.Urut=D.URUT

--where a.KODEBRG='STK 54B.9'

group by A.KODEBRG,A.NAMABRG,A.Tanggal,D.Nourut,D.Harga,D.URUT,D.NOBUKTI

order by A.KODEBRG;

-- Sp_RepKomisiNota
CREATE PROCEDURE IF NOT EXISTS Sp_RepKomisiNota AS Select  A.nama KodePenerima,B.NAMACUSTSUPP NamaPenerima,A.KodeCustSupp,C.namaCustSupp,

B.ALAMAT1+case when ltrim(B.Alamat2)='' then '' else CHAR(13)+B.ALAMAT2  ALAMAT,

D.NoBukti,D.KodeBrg,Z.Namabrg,

D.QNT,A.Kurir,A.Kurir_2,

D.Omset,

Case when D.NOSAT=1 then A.Kurir 

	 when D.NOSAT=2 then A.Kurir_2 

 Komisi,

Case when D.NOSAT=1 then (A.Kurir * D.QNT) 

	 when D.NOSAT=2 then (A.Kurir_2 * D.QNT) 

 KomisiRP,

Case when D.NOSAT=1 then D.Omset-(A.Kurir * D.QNT) 

	 when D.NOSAT=2 then D.Omset-(A.Kurir_2 * D.QNT) 

 OmsetMinKomisi,

Case when D.NOSAT=1 then Z.SAT1 when D.NOSAT=2 then Z.SAT2  Satuan

,M.namabank

from DBKomisiCustomer A

Left Outer join DBCustSupp B on A.Nama=B.kodeCustSupp

Left Outer Join DBCUSTSUPP C on A.KodeCustSupp=C.KODECUSTSUPP

Left Outer Join (select B.KodeCustSupp,B.NoBukti,A.KodeBrg,A.Nosat,

				 Case when A.NOSAT=1 then A.QNT when A.NOSAT=2 then A.QNT2  Qnt, 

				 SUM(COALESCE(NDPPRP,0)) Omset 

				  From DBInvoicePLdet A

				  Left Outer Join DBInvoicePL B on A.nobukti = B.nobukti

				  where MONTH(B.Tanggal)=@Bulan and YEAR(B.Tanggal)=@Tahun

				  group BY B.KodeCustSupp,B.NoBukti,A.KodeBrg,A.NOSAT,A.QNT,A.QNT2) D on A.KodeCustSupp=D.KodeCustSupp

				  And A.KodeBrg = D.KodeBrg

--Left Outer join DBKomisiCustomer x on X.KodeCustSupp = A.KodeCust and X.Nama = A.KodePenerima and D.KodeBrg = x.KodeBrg

Left Outer Join DBBARANG Z on D.KodeBrg = Z.KODEBRG	  

Left Outer Join Dbbank M on B.KodeBank = M.KodeBank

Where islunas=0 and D.NoBukti is not null

Order By A.Nama;

-- Sp_RepKomisiPelunasan
CREATE PROCEDURE IF NOT EXISTS Sp_RepKomisiPelunasan AS select @Id=SUBSTRING(@Id,1,1)

if @Id=''

select 'Gabungan' Perusahaan,n.KODEEXP Penerima,N.NAMAEXP NamaPenerima,A.KodeCustSupp,N1.NAMACUSTSUPP,A.NoBukti,B.NoFaktur,A.KodeBrg,

M.NamaBrg,X1.Qnt2SisaSO,X1.Qnt2SisaSO ,A.QNT,

Case when A.NOSAT=1 then X1.Qnt2SisaSO

	 when A.NOSAT=2 then X1.Qnt2SisaSO

 Komisi,

Case when A.NOSAT=1 then (X1.Qnt2SisaSO * A.QNT) 

	 when A.NOSAT=2 then (X1.Qnt2SisaSO * A.QNT) 

 KomisiRP,

Case when A.NOSAT=1 then A.Omset-(X1.Qnt2SisaSO * A.QNT) 

	 when A.NOSAT=2 then A.Omset-(X1.Qnt2SisaSO * A.QNT) 

	  OmsetMinKomisi,

case when A.NOSAT=1 then M.SAT1 when A.NOSAT=2 then M.SAT2 when A.NOSAT=3 then M.SAT3  Satuan,

A.Omset,A.NOSAT,a.NoSPP

from 

(

 	select B.KodeCustSupp,B.NoBukti,A.KodeBrg,A.NOSAT,b.NoSPP

 	,case when A.NOSAT=1 then A.QNT when A.NOSAT=2 then A.QNT2  QNT, SUM(COALESCE(NDPPRP,0)) Omset 

				  From DBInvoicePLdet A

				  Left Outer Join DBInvoicePL B on A.nobukti = B.nobukti

				 -- where MONTH(B.Tanggal)=@Bulan and YEAR(B.Tanggal)=@Tahun

				  group BY B.KodeCustSupp,B.NoBukti,A.KodeBrg,b.nospp,A.NOSAT,A.QNT,A.QNT2

 	

)A 

Left Outer join (

select B.* from 

(

select 	Distinct(a.Nofaktur) Nofaktur

 	from vwHutpiut a

 	left outer join DBCUSTSUPP b on(a.KodeCustSupp=b.KodeCustSupp)

 	where  month(a.tanggal)=@bulan and YEAR(A.tanggal)=@tahun                                            

 	group by a.KodeCustSupp, a.Nofaktur,b.NAMACUSTSUPP

)A Left OUter join (

					select 	a.KodeCustSupp KodeCust,b.NAMACUSTSUPP NamaCust,a.Nofaktur, 

 					sum(a.Debet) as Jumlah, 

 					sum(a.Kredit) as Terbayar,

 					sum(a.Debet)-sum(a.Kredit) as sisa

 					from vwHutpiut a

 					left outer join DBCUSTSUPP b on(a.KodeCustSupp=b.KodeCustSupp)

 					where  a.Tanggal<=datetime('now')                                         

 					group by a.KodeCustSupp, a.Nofaktur,b.NAMACUSTSUPP

 					having (sum(a.Debet)-sum(a.Kredit)) =0)B on A.Nofaktur=B.NoFaktur

 	Where A.Nofaktur is not null and b.NoFaktur is not null


)B on  A.NoBukti=B.NoFaktur and A.KodeCustSupp=B.KodeCust 

left outer join dbSPP a1 on a1.nobukti=a.NoSPP

left outer join dbSPPDet a2 on a2.NoBukti=a1.NoBukti

Left Outer join DBSO x on X.NOBUKTI =a2.NoSO

left outer join DBSODET x1 on x1.NOBUKTI=x.NOBUKTI and x1.KODEBRG=a.KodeBrg	

left outer join DBEXPEDISI N on X.KodeExp= N.KODEEXP

Left Outer join DBCUSTSUPP N1 on A.KodeCustSupp = N1.KODECUSTSUPP

Left Outer join DBBARANG M on A.KodeBrg = M.KODEBRG

where b.NoFaktur is not null --and x.KodeExp is not null  --and A.NoBukti like '%282%'



ORDER BY N.NAMAEXP,A.NoBukti

--select * from dbSPPdet



else

select Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,n.KODEEXP Penerima,N.NAMAEXP NamaPenerima,A.KodeCustSupp,N1.NAMACUSTSUPP,A.NoBukti,B.NoFaktur,A.KodeBrg,

M.NamaBrg,X1.Qnt2SisaSO,X1.Qnt2SisaSO ,A.QNT,

Case when A.NOSAT=1 then X1.Qnt2SisaSO

	 when A.NOSAT=2 then X1.Qnt2SisaSO

 Komisi,

Case when A.NOSAT=1 then (X1.Qnt2SisaSO * A.QNT) 

	 when A.NOSAT=2 then (X1.Qnt2SisaSO * A.QNT) 

 KomisiRP,

Case when A.NOSAT=1 then A.Omset-(X1.Qnt2SisaSO * A.QNT) 

	 when A.NOSAT=2 then A.Omset-(X1.Qnt2SisaSO * A.QNT) 

	  OmsetMinKomisi,

case when A.NOSAT=1 then M.SAT1 when A.NOSAT=2 then M.SAT2 when A.NOSAT=3 then M.SAT3  Satuan,

A.Omset,A.NOSAT,a.NoSPP

from 

(

 	select B.KodeCustSupp,B.NoBukti,A.KodeBrg,A.NOSAT,b.NoSPP

 	,case when A.NOSAT=1 then A.QNT when A.NOSAT=2 then A.QNT2  QNT, SUM(COALESCE(NDPPRP,0)) Omset 

				  From DBInvoicePLdet A

				  Left Outer Join DBInvoicePL B on A.nobukti = B.nobukti

				 -- where MONTH(B.Tanggal)=@Bulan and YEAR(B.Tanggal)=@Tahun

				  group BY B.KodeCustSupp,B.NoBukti,A.KodeBrg,b.nospp,A.NOSAT,A.QNT,A.QNT2

 	

)A 

Left Outer join (

select B.* from 

(

select 	Distinct(a.Nofaktur) Nofaktur

 	from vwHutpiut a

 	left outer join DBCUSTSUPP b on(a.KodeCustSupp=b.KodeCustSupp)

 	where  month(a.tanggal)=@bulan and YEAR(A.tanggal)=@tahun                                            

 	group by a.KodeCustSupp, a.Nofaktur,b.NAMACUSTSUPP

)A Left OUter join (

					select 	a.KodeCustSupp KodeCust,b.NAMACUSTSUPP NamaCust,a.Nofaktur, 

 					sum(a.Debet) as Jumlah, 

 					sum(a.Kredit) as Terbayar,

 					sum(a.Debet)-sum(a.Kredit) as sisa

 					from vwHutpiut a

 					left outer join DBCUSTSUPP b on(a.KodeCustSupp=b.KodeCustSupp)

 					where  a.Tanggal<=datetime('now')                                         

 					group by a.KodeCustSupp, a.Nofaktur,b.NAMACUSTSUPP

 					having (sum(a.Debet)-sum(a.Kredit)) =0)B on A.Nofaktur=B.NoFaktur

 	Where A.Nofaktur is not null and b.NoFaktur is not null


)B on  A.NoBukti=B.NoFaktur and A.KodeCustSupp=B.KodeCust 

left outer join dbSPP a1 on a1.nobukti=a.NoSPP

left outer join dbSPPDet a2 on a2.NoBukti=a1.NoBukti

Left Outer join DBSO x on X.NOBUKTI =a2.NoSO

left outer join DBSODET x1 on x1.NOBUKTI=x.NOBUKTI and x1.KODEBRG=a.KodeBrg	

left outer join DBEXPEDISI N on X.KodeExp= N.KODEEXP

Left Outer join DBCUSTSUPP N1 on A.KodeCustSupp = N1.KODECUSTSUPP

Left Outer join DBBARANG M on A.KodeBrg = M.KODEBRG

where b.NoFaktur is not null --and x.KodeExp is not null  --and A.NoBukti like '%282%'

and @Id=LEFT(x.NOBUKTI,1)

ORDER BY N.NAMAEXP,A.NoBukti;

-- Sp_RepOmsetKomisi
CREATE PROCEDURE IF NOT EXISTS Sp_RepOmsetKomisi AS --select  @Bulan=9,@Tahun=2013



Select  A.KodePenerima,C.NAMACUSTSUPP NamaPenerima,A.KodeCust,B.namaCustSupp,C.Komisi,

B.ALAMAT1+case when ltrim(B.Alamat2)='' then '' else CHAR(13)+B.ALAMAT2  ALAMAT,

D.Omset,C.komisi,(D.Omset * C.komisi)/100 RPKomisi

from DBOmsetkomisi A 

Left Outer join DBCustSupp B on A.KodeCust=B.kodeCustSupp

Left Outer Join DBCUSTSUPP C on A.KodePenerima=C.KODECUSTSUPP

Left Outer Join (select B.KodeCustSupp, SUM(COALESCE(NDPPRP,0)) Omset 

				  From DBInvoicePLdet A

				  Left Outer Join DBInvoicePL B on A.nobukti = B.nobukti

				  where MONTH(B.Tanggal)=@Bulan and YEAR(B.Tanggal)=@Tahun

				  group BY B.KodeCustSupp) D on A.KodeCust=D.KodeCustSupp

				  

Order By A.KodeCust;

-- Sp_report_CashBack
CREATE PROCEDURE IF NOT EXISTS Sp_report_CashBack AS if @isiList='' 

	  Exec('select * from [Vw_ReportCashBack] where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')    

			order by Filter,KodeCust,NamaCustSupp')

	  else

	  Exec('select * from [Vw_ReportCashBack] where Filter IN'+@isiList+ '  and  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')    

			order by Filter,KodeCust,NamaCustSupp');

-- Sp_reportAnalisaSales
CREATE PROCEDURE IF NOT EXISTS Sp_reportAnalisaSales AS select A.KeyNIK,A.NIK,A.Nama,B.KodeCustSupp,C.KODECUST,C.Nobukti,C.tanggal,

Case when ceiling (cast(datepart(dd,C.Tanggal)as numeric(38,8))/7)=1 then 1 else 0  Minggu1,

Case when ceiling (cast(datepart(dd,C.Tanggal)as numeric(38,8))/7)=2 then 1 else 0  Minggu2,

Case when ceiling (cast(datepart(dd,C.Tanggal)as numeric(38,8))/7)=3 then 1 else 0  Minggu3,

Case when ceiling (cast(datepart(dd,C.Tanggal)as numeric(38,8))/7)=4 then 1 else 0  Minggu4,

Case when ceiling (cast(datepart(dd,C.Tanggal)as numeric(38,8))/7)=5 then 1 else 0  Minggu5



from dbKaryawan A 

left outer join DBSALESCUSTOMER B on A.KeyNIK = B.KeyNik

left outer join (select Nobukti,Tanggal,Kodesls,KODECUST from DBSO where

				 month(TANGGAL)=@Bulan and YEAR(tanggal)=@tahun)C on B.KeyNik = C.kodesls

left outer join DBCUSTSUPP D on C.KODECUST =d.KODECUSTSUPP 

where c.Nobukti is not null

order by a.KeyNIK,B.KodeCustSupp,C.NOBUKTI;

-- Sp_reportBeliAccDet
CREATE PROCEDURE IF NOT EXISTS Sp_reportBeliAccDet AS -- DECLARE REMOVED (10)

select @Devisi=Devisi from dbDevisi where NamaDevisi=@ID



if @Id='' 

if @Perkiraan=0

If @Ordr='N'

		if @NeedOto=0 or @NeedOto=1

		  if @isiList='' 

		  if @TipeBayar=0 or @TipeBayar=1

 		  Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			and TIPEBAYAR='+@TipeBayar+'

			order by NoBukti,Tanggal')

		  else

		   Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			order by NoBukti,Tanggal')	

		  

		  else

		  if @TipeBayar=0 or @TipeBayar=1 

		  Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

		        and TIPEBAYAR='+@TipeBayar+'

		        and  NoBukti IN'+@isiList+ '

			    order by NoBukti,Tanggal')

	      else

	      Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

		        and  NoBukti IN'+@isiList+ '

			    order by NoBukti,Tanggal')		    

		  	    	

		if @NeedOto=2	

		if  @TipeBayar=0 or @TipeBayar=1 

		  Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

			and TIPEBAYAR='+@TipeBayar+'

			order by NoBukti,Tanggal')

		 else

		  Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

			order by NoBukti,Tanggal')

        

		  else

		 if  @TipeBayar=0 or @TipeBayar=1 

		  Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		        and TIPEBAYAR='+@TipeBayar+'

		        and  NoBukti IN'+@isiList+ '

			    order by NoBukti,Tanggal')

		  else

		  Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		        and  NoBukti IN'+@isiList+ '

			    order by NoBukti,Tanggal')	    	    


	else If @Ordr='B'

		if @NeedOto=0 or @NeedOto=1

         if @isiList=''	

		  if @TipeBayar=0 or @TipeBayar=1 

		    Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and TIPEBAYAR='+@TipeBayar+'

			order by KodeBrg')

		   else

		   	Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			order by KodeBrg')

		  	

		 else

		  if @TipeBayar=0 or @TipeBayar=1 

			Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and TIPEBAYAR='+@TipeBayar+'

			and  KodeBrg IN'+@isiList+ '

			order by KodeBrg')

		  else

		  Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and  KodeBrg IN'+@isiList+ '

			order by KodeBrg')	 


        if @NeedOto=2

		 if @isiList=''	

		 if @TipeBayar=0 or @TipeBayar=1 

		 Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and TIPEBAYAR='+@TipeBayar+'

			order by KodeBrg')

		 else 

			Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			order by KodeBrg')

		 

		 else

		  if @TipeBayar=0 or @TipeBayar=1 

		  Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and TIPEBAYAR='+@TipeBayar+'

			and  KodeBrg IN'+@isiList+ '

			order by KodeBrg')

		  else

			Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and  KodeBrg IN'+@isiList+ '

			order by KodeBrg')


	else If @Ordr='S'

		if @NeedOto=0 or @NeedOto=1

		     if @isiList=''	

		     if @TipeBayar=0 or @TipeBayar=1 

              Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			  and TIPEBAYAR='+@TipeBayar+'

			  order by KodeCustSupp')

              else 

			  Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			  order by KodeCustSupp')

		      

		     else

		     if @TipeBayar=0 or @TipeBayar=1

		     Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			 and TIPEBAYAR='+@TipeBayar+'

			 and  KodeCustSupp IN'+@isiList+ ' 

			 order by KodeCustSupp')

		     else

		     Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			 and  KodeCustSupp IN'+@isiList+ ' 

			 order by KodeCustSupp')

			 

          if @NeedOto=2

		     if @isiList=''	

		     if @TipeBayar=0 or @TipeBayar=1

		      Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			  and TIPEBAYAR='+@TipeBayar+'

			  order by KodeCustSupp')

		     else 

			 Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			 order by KodeCustSupp')

			 

		     else

		     if @TipeBayar=0 or @TipeBayar=1

		     Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			 and TIPEBAYAR='+@TipeBayar+'

			 and  KodeCustSupp IN'+@isiList+ ' 

			 order by KodeCustSupp')

		     else

		     Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			 and  KodeCustSupp IN'+@isiList+ ' 

			 order by KodeCustSupp')


else

If @Ordr='N'

		if @NeedOto=0 or @NeedOto=1

		  if @isiList='' 

		  if @TipeBayar=0 or @TipeBayar=1

 		  Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			and TIPEBAYAR='+@TipeBayar+' and Perkiraan<>''''

			order by NoBukti,Tanggal')

		  else

		   Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where Perkiraan<>'''' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			order by NoBukti,Tanggal')	

		  

		  else

		  if @TipeBayar=0 or @TipeBayar=1 

		  Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

		        and TIPEBAYAR='+@TipeBayar+'

		        and  NoBukti IN'+@isiList+ ' and Perkiraan<>''''

			    order by NoBukti,Tanggal')

	      else

	      Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

		        and  NoBukti IN'+@isiList+ ' and Perkiraan<>''''

			    order by NoBukti,Tanggal')		    

		  	    	

		if @NeedOto=2	

		if  @TipeBayar=0 or @TipeBayar=1 

		  Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

			and TIPEBAYAR='+@TipeBayar+' and Perkiraan<>''''

			order by NoBukti,Tanggal')

		 else

		  Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where  Perkiraan<>'''' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

			order by NoBukti,Tanggal')

        

		  else

		 if  @TipeBayar=0 or @TipeBayar=1 

		  Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		        and TIPEBAYAR='+@TipeBayar+' and Perkiraan<>''''

		        and  NoBukti IN'+@isiList+ ' 

			    order by NoBukti,Tanggal')

		  else

		  Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		        and  NoBukti IN'+@isiList+ ' and Perkiraan<>''''

			    order by NoBukti,Tanggal')	    	    


	else If @Ordr='B'

		if @NeedOto=0 or @NeedOto=1

         if @isiList=''	

		  if @TipeBayar=0 or @TipeBayar=1 

		    Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and TIPEBAYAR='+@TipeBayar+' and Perkiraan<>''''

			order by KodeBrg')

		   else

		   	Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where  Perkiraan<>'''' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			order by KodeBrg')

		  	

		 else

		  if @TipeBayar=0 or @TipeBayar=1 

			Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and TIPEBAYAR='+@TipeBayar+'

			and  KodeBrg IN'+@isiList+ ' and Perkiraan<>''''

			order by KodeBrg')

		  else

		  Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and  KodeBrg IN'+@isiList+ ' and Perkiraan<>''''

			order by KodeBrg')	 


        if @NeedOto=2

		 if @isiList=''	

		 if @TipeBayar=0 or @TipeBayar=1 

		 Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and TIPEBAYAR='+@TipeBayar+' and Perkiraan<>''''

			order by KodeBrg')

		 else 

			Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where Perkiraan<>'''' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			order by KodeBrg')

		 

		 else

		  if @TipeBayar=0 or @TipeBayar=1 

		  Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where  Perkiraan<>'''' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and TIPEBAYAR='+@TipeBayar+'

			and  KodeBrg IN'+@isiList+ '

			order by KodeBrg')

		  else

			Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where Perkiraan<>'''' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and  KodeBrg IN'+@isiList+ '

			order by KodeBrg')


	else If @Ordr='S'

		if @NeedOto=0 or @NeedOto=1

		     if @isiList=''	

		     if @TipeBayar=0 or @TipeBayar=1 

              Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			  and TIPEBAYAR='+@TipeBayar+' and Perkiraan<>''''

			  order by KodeCustSupp')

              else 

			  Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where  Perkiraan<>'''' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			  order by KodeCustSupp')

		      

		     else

		     if @TipeBayar=0 or @TipeBayar=1

		     Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			 and TIPEBAYAR='+@TipeBayar+'

			 and  KodeCustSupp IN'+@isiList+ '  and Perkiraan<>''''

			 order by KodeCustSupp')

		     else

		     Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where Perkiraan<>'''' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			 and  KodeCustSupp IN'+@isiList+ ' 

			 order by KodeCustSupp')

			 

          if @NeedOto=2

		     if @isiList=''	

		     if @TipeBayar=0 or @TipeBayar=1

		      Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where Perkiraan<>'''' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			  and TIPEBAYAR='+@TipeBayar+'

			  order by KodeCustSupp')

		     else 

			 Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where Perkiraan<>'''' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			 order by KodeCustSupp')

			 

		     else

		     if @TipeBayar=0 or @TipeBayar=1

		     Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			 and TIPEBAYAR='+@TipeBayar+'

			 and  KodeCustSupp IN'+@isiList+ '  and Perkiraan<>''''

			 order by KodeCustSupp')

		     else

		     Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			 and  KodeCustSupp IN'+@isiList+ '  and Perkiraan<>''''

			 order by KodeCustSupp')


else------------------@id

---------------------

if @Perkiraan=0

If @Ordr='N'

		if @NeedOto=0 or @NeedOto=1

		  if @isiList='' 

		  if @TipeBayar=0 or @TipeBayar=1

 		  Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			and TIPEBAYAR='+@TipeBayar+'

			and Devisi='''+@Devisi+'''

			order by NoBukti,Tanggal')

		  else

		   Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			and Devisi='''+@Devisi+'''

			order by NoBukti,Tanggal')	

		  

		  else

		  if @TipeBayar=0 or @TipeBayar=1 

		  Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

		        and TIPEBAYAR='+@TipeBayar+'

		        and  NoBukti IN'+@isiList+ '

			    and Devisi='''+@Devisi+'''

			    order by NoBukti,Tanggal')

	      else

	      Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

		        and  NoBukti IN'+@isiList+ '

			    and Devisi='''+@Devisi+'''

			    order by NoBukti,Tanggal')		    

		  	    	

		if @NeedOto=2	

		if  @TipeBayar=0 or @TipeBayar=1 

		  Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

			and TIPEBAYAR='+@TipeBayar+'

			and Devisi='''+@Devisi+'''

			order by NoBukti,Tanggal')

		 else

		  Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

			and Devisi='''+@Devisi+'''

			order by NoBukti,Tanggal')

        

		  else

		 if  @TipeBayar=0 or @TipeBayar=1 

		  Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		        and TIPEBAYAR='+@TipeBayar+'

		        and  NoBukti IN'+@isiList+ '

			    and Devisi='''+@Devisi+'''

			    order by NoBukti,Tanggal')

		  else

		  Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		        and  NoBukti IN'+@isiList+ '

			    and Devisi='''+@Devisi+'''

			    order by NoBukti,Tanggal')	    	    


	else If @Ordr='B'

		if @NeedOto=0 or @NeedOto=1

         if @isiList=''	

		  if @TipeBayar=0 or @TipeBayar=1 

		    Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and TIPEBAYAR='+@TipeBayar+'

			and Devisi='''+@Devisi+'''

			order by KodeBrg')

		   else

		   	Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and Devisi='''+@Devisi+'''

			order by KodeBrg')

		  	

		 else

		  if @TipeBayar=0 or @TipeBayar=1 

			Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and TIPEBAYAR='+@TipeBayar+'

			and  KodeBrg IN'+@isiList+ '

			and Devisi='''+@Devisi+'''

			order by KodeBrg')

		  else

		  Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and  KodeBrg IN'+@isiList+ '

			and Devisi='''+@Devisi+'''

			order by KodeBrg')	 


        if @NeedOto=2

		 if @isiList=''	

		 if @TipeBayar=0 or @TipeBayar=1 

		 Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and TIPEBAYAR='+@TipeBayar+'

			and Devisi='''+@Devisi+'''

			order by KodeBrg')

		 else 

			Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and Devisi='''+@Devisi+'''

			order by KodeBrg')

		 

		 else

		  if @TipeBayar=0 or @TipeBayar=1 

		  Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and TIPEBAYAR='+@TipeBayar+'

			and  KodeBrg IN'+@isiList+ '

			and Devisi='''+@Devisi+'''

			order by KodeBrg')

		  else

			Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and  KodeBrg IN'+@isiList+ '

			and Devisi='''+@Devisi+'''

			order by KodeBrg')


	else If @Ordr='S'

		if @NeedOto=0 or @NeedOto=1

		     if @isiList=''	

		     if @TipeBayar=0 or @TipeBayar=1 

              Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			  and TIPEBAYAR='+@TipeBayar+'

			  and Devisi='''+@Devisi+'''

			  order by KodeCustSupp')

              else 

			  Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			  and Devisi='''+@Devisi+'''

			  order by KodeCustSupp')

		      

		     else

		     if @TipeBayar=0 or @TipeBayar=1

		     Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			 and TIPEBAYAR='+@TipeBayar+'

			 and  KodeCustSupp IN'+@isiList+ ' 

			 and Devisi='''+@Devisi+'''

			 order by KodeCustSupp')

		     else

		     Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			 and  KodeCustSupp IN'+@isiList+ ' 

			 and Devisi='''+@Devisi+'''

			 order by KodeCustSupp')

			 

          if @NeedOto=2

		     if @isiList=''	

		     if @TipeBayar=0 or @TipeBayar=1

		      Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			  and TIPEBAYAR='+@TipeBayar+'

			  and Devisi='''+@Devisi+'''

			  order by KodeCustSupp')

		     else 

			 Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			 and Devisi='''+@Devisi+'''

			 order by KodeCustSupp')

			 

		     else

		     if @TipeBayar=0 or @TipeBayar=1

		     Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			 and TIPEBAYAR='+@TipeBayar+'

			 and  KodeCustSupp IN'+@isiList+ ' 

			 and Devisi='''+@Devisi+'''

			 order by KodeCustSupp')

		     else

		     Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			 and  KodeCustSupp IN'+@isiList+ ' 

			 and Devisi='''+@Devisi+'''

			 order by KodeCustSupp')


else

If @Ordr='N'

		if @NeedOto=0 or @NeedOto=1

		  if @isiList='' 

		  if @TipeBayar=0 or @TipeBayar=1

 		  Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			and TIPEBAYAR='+@TipeBayar+' and Perkiraan<>''''

			and @id=Case When Len(@Id)=3 Then Left(NoBukti,3) else Left(NoBukti,2)

			order by NoBukti,Tanggal')

		  else

		   Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where Perkiraan<>'''' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			and @id=Case When Len(@Id)=3 Then Left(NoBukti,3) else Left(NoBukti,2)

			order by NoBukti,Tanggal')	

		  

		  else

		  if @TipeBayar=0 or @TipeBayar=1 

		  Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

		        and TIPEBAYAR='+@TipeBayar+'

		        and  NoBukti IN'+@isiList+ ' and Perkiraan<>''''

			    and @id=Case When Len(@Id)=3 Then Left(NoBukti,3) else Left(NoBukti,2)

			    order by NoBukti,Tanggal')

	      else

	      Exec('select * from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

		        and  NoBukti IN'+@isiList+ ' and Perkiraan<>''''

			    and @id=Case When Len(@Id)=3 Then Left(NoBukti,3) else Left(NoBukti,2)

			    order by NoBukti,Tanggal')		    

		  	    	

		if @NeedOto=2	

		if  @TipeBayar=0 or @TipeBayar=1 

		  Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

			and TIPEBAYAR='+@TipeBayar+' and Perkiraan<>''''

			order by NoBukti,Tanggal')

		 else

		  Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where  Perkiraan<>'''' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

			and @id=Case When Len(@Id)=3 Then Left(NoBukti,3) else Left(NoBukti,2)

			order by NoBukti,Tanggal')

        

		  else

		 if  @TipeBayar=0 or @TipeBayar=1 

		  Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		        and TIPEBAYAR='+@TipeBayar+' and Perkiraan<>''''

		        and  NoBukti IN'+@isiList+ ' 

			    and @id=Case When Len(@Id)=3 Then Left(NoBukti,3) else Left(NoBukti,2)

			    order by NoBukti,Tanggal')

		  else

		  Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		        and  NoBukti IN'+@isiList+ ' and Perkiraan<>''''

			    and @id=Case When Len(@Id)=3 Then Left(NoBukti,3) else Left(NoBukti,2)

			    order by NoBukti,Tanggal')	    	    


	else If @Ordr='B'

		if @NeedOto=0 or @NeedOto=1

         if @isiList=''	

		  if @TipeBayar=0 or @TipeBayar=1 

		    Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and TIPEBAYAR='+@TipeBayar+' and Perkiraan<>''''

			and @id=Case When Len(@Id)=3 Then Left(NoBukti,3) else Left(NoBukti,2)

			order by KodeBrg')

		   else

		   	Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where  Perkiraan<>'''' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and @id=Case When Len(@Id)=3 Then Left(NoBukti,3) else Left(NoBukti,2)

			order by KodeBrg')

		  	

		 else

		  if @TipeBayar=0 or @TipeBayar=1 

			Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and TIPEBAYAR='+@TipeBayar+'

			and  KodeBrg IN'+@isiList+ ' and Perkiraan<>''''

			and @id=Case When Len(@Id)=3 Then Left(NoBukti,3) else Left(NoBukti,2)

			order by KodeBrg')

		  else

		  Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and  KodeBrg IN'+@isiList+ ' and Perkiraan<>''''

			and @id=Case When Len(@Id)=3 Then Left(NoBukti,3) else Left(NoBukti,2)

			order by KodeBrg')	 


        if @NeedOto=2

		 if @isiList=''	

		 if @TipeBayar=0 or @TipeBayar=1 

		 Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and TIPEBAYAR='+@TipeBayar+' and Perkiraan<>''''

			and @id=Case When Len(@Id)=3 Then Left(NoBukti,3) else Left(NoBukti,2)

			order by KodeBrg')

		 else 

			Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where Perkiraan<>'''' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and @id=Case When Len(@Id)=3 Then Left(NoBukti,3) else Left(NoBukti,2)

			order by KodeBrg')

		 

		 else

		  if @TipeBayar=0 or @TipeBayar=1 

		  Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where  Perkiraan<>'''' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and TIPEBAYAR='+@TipeBayar+'

			and  KodeBrg IN'+@isiList+ '

			and @id=Case When Len(@Id)=3 Then Left(NoBukti,3) else Left(NoBukti,2)

			order by KodeBrg')

		  else

			Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where Perkiraan<>'''' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and  KodeBrg IN'+@isiList+ '

			and @id=Case When Len(@Id)=3 Then Left(NoBukti,3) else Left(NoBukti,2)

			order by KodeBrg')


	else If @Ordr='S'

		if @NeedOto=0 or @NeedOto=1

		     if @isiList=''	

		     if @TipeBayar=0 or @TipeBayar=1 

              Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			  and TIPEBAYAR='+@TipeBayar+' and Perkiraan<>''''

			  and @id=Case When Len(@Id)=3 Then Left(NoBukti,3) else Left(NoBukti,2)

			  order by KodeCustSupp')

              else 

			  Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where  Perkiraan<>'''' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			  and @id=Case When Len(@Id)=3 Then Left(NoBukti,3) else Left(NoBukti,2)

			  order by KodeCustSupp')

		      

		     else

		     if @TipeBayar=0 or @TipeBayar=1

		     Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			 and TIPEBAYAR='+@TipeBayar+'

			 and  KodeCustSupp IN'+@isiList+ '  and Perkiraan<>''''

			 and @id=Case When Len(@Id)=3 Then Left(NoBukti,3) else Left(NoBukti,2)

			 order by KodeCustSupp')

		     else

		     Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where Perkiraan<>'''' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			 and  KodeCustSupp IN'+@isiList+ ' 

			 and @id=Case When Len(@Id)=3 Then Left(NoBukti,3) else Left(NoBukti,2)

			 order by KodeCustSupp')

			 

          if @NeedOto=2

		     if @isiList=''	

		     if @TipeBayar=0 or @TipeBayar=1

		      Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where Perkiraan<>'''' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			  and TIPEBAYAR='+@TipeBayar+'

			  and @id=Case When Len(@Id)=3 Then Left(NoBukti,3) else Left(NoBukti,2)

			  order by KodeCustSupp')

		     else 

			 Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where Perkiraan<>'''' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			 and @id=Case When Len(@Id)=3 Then Left(NoBukti,3) else Left(NoBukti,2)

			 order by KodeCustSupp')

			 

		     else

		     if @TipeBayar=0 or @TipeBayar=1

		     Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			 and TIPEBAYAR='+@TipeBayar+'

			 and  KodeCustSupp IN'+@isiList+ '  and Perkiraan<>''''

			 and @id=Case When Len(@Id)=3 Then Left(NoBukti,3) else Left(NoBukti,2)

			 order by KodeCustSupp')

		     else

		     Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			 and  KodeCustSupp IN'+@isiList+ '  and Perkiraan<>''''

			 and @id=Case When Len(@Id)=3 Then Left(NoBukti,3) else Left(NoBukti,2)

			 order by KodeCustSupp');

-- Sp_reportBeliAccDetPerPerkiraan
CREATE PROCEDURE IF NOT EXISTS Sp_reportBeliAccDetPerPerkiraan AS -- DECLARE REMOVED (10)

select @Devisi=Devisi from dbDevisi where NamaDevisi=@ID



if @Id=''

If @Ordr='N'

		if @NeedOto=0 or @NeedOto=1

		  if @isiList='' 

		  if @TipeBayar=0 or @TipeBayar=1

 		  Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			and TIPEBAYAR='+@TipeBayar+' and Perkiraan in('''+@Keterangan+''')

			order by NoBukti,Tanggal')

		  else

		   Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where Perkiraan in('''+@Keterangan+''') and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			order by NoBukti,Tanggal')	

		  

		  else

		  if @TipeBayar=0 or @TipeBayar=1 

		  Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

		        and TIPEBAYAR='+@TipeBayar+'

		        and  NoBukti IN'+@isiList+ ' and Perkiraan in('''+@Keterangan+''')

			    order by NoBukti,Tanggal')

	      else

	      Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

		        and  NoBukti IN'+@isiList+ ' and Perkiraan in('''+@Keterangan+''')

			    order by NoBukti,Tanggal')		    

		  	    	

		if @NeedOto=2	

		if  @TipeBayar=0 or @TipeBayar=1 

		  Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

			and TIPEBAYAR='+@TipeBayar+' and Perkiraan in('''+@Keterangan+''')

			order by NoBukti,Tanggal')

		 else

		  Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where  Perkiraan in('''+@Keterangan+''') and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

			order by NoBukti,Tanggal')

        

		  else

		 if  @TipeBayar=0 or @TipeBayar=1 

		  Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		        and TIPEBAYAR='+@TipeBayar+' and Perkiraan in('''+@Keterangan+''')

		        and  NoBukti IN'+@isiList+ ' 

			    order by NoBukti,Tanggal')

		  else

		  Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		        and  NoBukti IN'+@isiList+ ' and Perkiraan in('''+@Keterangan+''')

			    order by NoBukti,Tanggal')	    	    


	else If @Ordr='B'

		if @NeedOto=0 or @NeedOto=1

         if @isiList=''	

		  if @TipeBayar=0 or @TipeBayar=1 

		    Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and TIPEBAYAR='+@TipeBayar+' and Perkiraan in('''+@Keterangan+''')

			order by KodeBrg')

		   else

		   	Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where  Perkiraan in('''+@Keterangan+''') and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			order by KodeBrg')

		  	

		 else

		  if @TipeBayar=0 or @TipeBayar=1 

			Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and TIPEBAYAR='+@TipeBayar+'

			and  KodeBrg IN'+@isiList+ ' and Perkiraan in('''+@Keterangan+''')

			order by KodeBrg')

		  else

		  Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and  KodeBrg IN'+@isiList+ ' and Perkiraan in('''+@Keterangan+''')

			order by KodeBrg')	 


        if @NeedOto=2

		 if @isiList=''	

		 if @TipeBayar=0 or @TipeBayar=1 

		 Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and TIPEBAYAR='+@TipeBayar+' and Perkiraan in('''+@Keterangan+''')

			order by KodeBrg')

		 else 

			Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where Perkiraan in('''+@Keterangan+''') and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			order by KodeBrg')

		 

		 else

		  if @TipeBayar=0 or @TipeBayar=1 

		  Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where  Perkiraan in('''+@Keterangan+''') and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and TIPEBAYAR='+@TipeBayar+'

			and  KodeBrg IN'+@isiList+ '

			order by KodeBrg')

		  else

			Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where Perkiraan in('''+@Keterangan+''') and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and  KodeBrg IN'+@isiList+ '

			order by KodeBrg')


	else If @Ordr='S'

		if @NeedOto=0 or @NeedOto=1

		     if @isiList=''	

		     if @TipeBayar=0 or @TipeBayar=1 

              Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			  and TIPEBAYAR='+@TipeBayar+' and Perkiraan in('''+@Keterangan+''')

			  order by KodeCustSupp')

              else 

			  Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where Perkiraan in('''+@Keterangan+''') and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			  order by KodeCustSupp')

		      

		     else

		     if @TipeBayar=0 or @TipeBayar=1

		     Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			 and TIPEBAYAR='+@TipeBayar+'

			 and  KodeCustSupp IN'+@isiList+ '  and Perkiraan in('''+@Keterangan+''')

			 order by KodeCustSupp')

		     else

		     Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where Perkiraan in('''+@Keterangan+''') and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			 and  KodeCustSupp IN'+@isiList+ ' 

			 order by KodeCustSupp')

			 

          if @NeedOto=2

		     if @isiList=''	

		     if @TipeBayar=0 or @TipeBayar=1

		      Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where Perkiraan in('''+@Keterangan+''') and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			  and TIPEBAYAR='+@TipeBayar+'

			  order by KodeCustSupp')

		     else 

			 Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where Perkiraan in('''+@Keterangan+''') and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			 order by KodeCustSupp')

			 

		     else

		     if @TipeBayar=0 or @TipeBayar=1

		     Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			 and TIPEBAYAR='+@TipeBayar+'

			 and  KodeCustSupp IN'+@isiList+ '  and Perkiraan in('''+@Keterangan+''')

			 order by KodeCustSupp')

		     else

		     Exec('select ''Gabungan'' Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			 and  KodeCustSupp IN'+@isiList+ '  and Perkiraan in('''+@Keterangan+''')

			 order by KodeCustSupp')


else

---

If @Ordr='N'

		if @NeedOto=0 or @NeedOto=1

		  if @isiList='' 

		  if @TipeBayar=0 or @TipeBayar=1

 		  Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			and TIPEBAYAR='+@TipeBayar+' and Perkiraan in('''+@Keterangan+''')

			and Devisi='''+@Devisi+'''

			order by NoBukti,Tanggal')

		  else

		   Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where Perkiraan in('''+@Keterangan+''') and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			order by NoBukti,Tanggal')	

		  

		  else

		  if @TipeBayar=0 or @TipeBayar=1 

		  Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

		        and TIPEBAYAR='+@TipeBayar+'

		        and  NoBukti IN'+@isiList+ ' and Perkiraan in('''+@Keterangan+''')

		        and Devisi='''+@Devisi+'''

			    order by NoBukti,Tanggal')

	      else

	      Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

		        and  NoBukti IN'+@isiList+ ' and Perkiraan in('''+@Keterangan+''')

		        and Devisi='''+@Devisi+'''

			    order by NoBukti,Tanggal')		    

		  	    	

		if @NeedOto=2	

		if  @TipeBayar=0 or @TipeBayar=1 

		  Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

			and TIPEBAYAR='+@TipeBayar+' and Perkiraan in('''+@Keterangan+''')

			and Devisi='''+@Devisi+'''

			order by NoBukti,Tanggal')

		 else

		  Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where  Perkiraan in('''+@Keterangan+''') and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

			and Devisi='''+@Devisi+'''

			order by NoBukti,Tanggal')

        

		  else

		 if  @TipeBayar=0 or @TipeBayar=1 

		  Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		        and TIPEBAYAR='+@TipeBayar+' and Perkiraan in('''+@Keterangan+''')

		        and  NoBukti IN'+@isiList+ ' 

		        and Devisi='''+@Devisi+'''

			    order by NoBukti,Tanggal')

		  else

		  Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		        and  NoBukti IN'+@isiList+ ' and Perkiraan in('''+@Keterangan+''')

		        and Devisi='''+@Devisi+'''

			    order by NoBukti,Tanggal')	    	    


	else If @Ordr='B'

		if @NeedOto=0 or @NeedOto=1

         if @isiList=''	

		  if @TipeBayar=0 or @TipeBayar=1 

		    Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and TIPEBAYAR='+@TipeBayar+' and Perkiraan in('''+@Keterangan+''')

			and Devisi='''+@Devisi+'''

			order by KodeBrg')

		   else

		   	Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where  Perkiraan in('''+@Keterangan+''') and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and Devisi='''+@Devisi+'''

			order by KodeBrg')

		  	

		 else

		  if @TipeBayar=0 or @TipeBayar=1 

			Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and TIPEBAYAR='+@TipeBayar+'

			and  KodeBrg IN'+@isiList+ ' and Perkiraan in('''+@Keterangan+''')

			and Devisi='''+@Devisi+'''

			order by KodeBrg')

		  else

		  Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and  KodeBrg IN'+@isiList+ ' and Perkiraan in('''+@Keterangan+''')

			and Devisi='''+@Devisi+'''

			order by KodeBrg')	 


        if @NeedOto=2

		 if @isiList=''	

		 if @TipeBayar=0 or @TipeBayar=1 

		 Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and TIPEBAYAR='+@TipeBayar+' and Perkiraan in('''+@Keterangan+''')

			and Devisi='''+@Devisi+'''

			order by KodeBrg')

		 else 

			Exec('select * from VwReportBeliGudang where Perkiraan in('''+@Keterangan+''') and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and Devisi='''+@Devisi+'''

			order by KodeBrg')

		 

		 else

		  if @TipeBayar=0 or @TipeBayar=1 

		  Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where  Perkiraan in('''+@Keterangan+''') and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and TIPEBAYAR='+@TipeBayar+'

			and  KodeBrg IN'+@isiList+ '

			and Devisi='''+@Devisi+'''

			order by KodeBrg')

		  else

			Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where Perkiraan in('''+@Keterangan+''') and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and  KodeBrg IN'+@isiList+ '

			and Devisi='''+@Devisi+'''

			order by KodeBrg')


	else If @Ordr='S'

		if @NeedOto=0 or @NeedOto=1

		     if @isiList=''	

		     if @TipeBayar=0 or @TipeBayar=1 

              Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			  and TIPEBAYAR='+@TipeBayar+' and Perkiraan in('''+@Keterangan+''')

			  and Devisi='''+@Devisi+'''

			  order by KodeCustSupp')

              else 

			  Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where Perkiraan in('''+@Keterangan+''') and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			  and Devisi='''+@Devisi+'''

			  order by KodeCustSupp')

		      

		     else

		     if @TipeBayar=0 or @TipeBayar=1

		     Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			 and TIPEBAYAR='+@TipeBayar+'

			 and  KodeCustSupp IN'+@isiList+ '  and Perkiraan in('''+@Keterangan+''')

			 and Devisi='''+@Devisi+'''

			 order by KodeCustSupp')

		     else

		     Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where Perkiraan in('''+@Keterangan+''') and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			 and  KodeCustSupp IN'+@isiList+ ' 

			 and Devisi='''+@Devisi+'''

			 order by KodeCustSupp')

			 

          if @NeedOto=2

		     if @isiList=''	

		     if @TipeBayar=0 or @TipeBayar=1

		      Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where Perkiraan in('''+@Keterangan+''') and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			  and TIPEBAYAR='+@TipeBayar+'

			  and Devisi='''+@Devisi+'''

			  order by KodeCustSupp')

		     else 

			 Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where Perkiraan in('''+@Keterangan+''') and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			 order by KodeCustSupp')

			 

		     else

		     if @TipeBayar=0 or @TipeBayar=1

		     Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			 and TIPEBAYAR='+@TipeBayar+'

			 and  KodeCustSupp IN'+@isiList+ '  and Perkiraan in('''+@Keterangan+''')

			 and Devisi='''+@Devisi+'''

			 order by KodeCustSupp')

		     else

		     Exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			 and  KodeCustSupp IN'+@isiList+ '  and Perkiraan in('''+@Keterangan+''')

			 and Devisi='''+@Devisi+'''

			 order by KodeCustSupp');