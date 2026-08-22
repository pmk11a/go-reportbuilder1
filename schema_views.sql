-- =============================================
-- DAPEN Backend - SQLite Schema
-- Views (Generated from dbbcagroup SQL Server)
-- Total: 223 views
-- =============================================

/* VIEWS */
/* ============================================= */


-- HPPSO
CREATE VIEW IF NOT EXISTS HPPSO AS select Isnull(HPPBrg,0)HPP,Bulan,Tahun,KodeBrg from dbHPPProduksi a;

-- VIEWREPORTRSPB
CREATE VIEW IF NOT EXISTS VIEWREPORTRSPB AS select 	B.NOBUKTI, B.URUT, B.NoSPB NoSC, B.UrutSPB UrutSC, B.KODEBRG, case when isnull(c.IsJasa,0)=1 then b.Namabrg else C.NAMABRG  NAMABRG, '' Jns_Kertas, ''Ukr_Kertas,

0 Qnt, 0 QNT2, case when B.NOSAT=1 Then B.SAT_1 else B.SAT_2   SAT_1,

 B.SAT_2, B.ISI, B.NetW, B.GrossW,'' KetDetail,F2.HARGA,

         (((case when B.NOSAT=1 Then B.QNT Else B.QNT2 )*F2.HARGA)-(((case when B.NOSAT=1 Then B.QNT Else B.QNT2 )*F2.HARGA)*f2.DISC/100)) dpp,

         (case when F2.PPN IN(1,2)Then (((case when B.NOSAT=1 Then B.QNT Else B.QNT2 )*F2.HARGA)-(((case when B.NOSAT=1 Then B.QNT Else B.QNT2 )*F2.HARGA)*f2.DISC/100))*0.1 else 0 ) ppn,

        ((((case when B.NOSAT=1 Then B.QNT Else B.QNT2 )*F2.HARGA)-(((case when B.NOSAT=1 Then B.QNT Else B.QNT2 )*F2.HARGA)*f2.DISC/100))+

          (case when F2.PPN IN(1,2)Then (((case when B.NOSAT=1 Then B.QNT Else B.QNT2 )*F2.HARGA)-(((case when B.NOSAT=1 Then B.QNT Else B.QNT2 )*F2.HARGA)*f2.DISC/100))*0.1 else 0 )) Total,

        0 dpphpp,

        0 Laba,

        A.Tanggal,a.KodeCustSupp,--D.NAMACUSTSUPP+CHAR(13)+Isnull(Prj.NAMAPROJECT,'') NAMACUSTSUPP, 

        D.NAMACUSTSUPP NAMACUSTSUPP,a2.NoResi,Isnull(Prj.NAMAPROJECT,'') NAMAPROJECT,  

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER)NeedOtorisasi, (CONVERT(Numeric(18,2), Isnull(F.HPPBrg,0) ))HPP, '' NoInv,

		'' Noso,case when B.NOSAT=1 Then Isnull(B.QNT,0) Else Isnull(B.Qnt2,0)  QntRetur,D.KODECUSTSUPP+A2.NoResi CustProject,a2.Tanggal TglSPB,a2.NoBukti NoSPB,e.NoBukti NoSPP,

		case when upper(b.SAT_1)='PCS' then 0 when upper(b.SAT_2)='PCS' then 0 else 0  QntSJPcs,

		case when upper(b.SAT_1)='PCS' then '' when upper(b.SAT_2)='PCS' then '' else ''  SatSJPcs,

		case when upper(b.SAT_1)<>'PCS' then 0 when upper(b.SAT_2)<>'PCS' then 0 else 0  QntSJNonPcs,

		case when upper(b.SAT_1)<>'PCS' then '' when upper(b.SAT_2)<>'PCS' then '' else ''  SatSJNonPcs,

		case when upper(b.SAT_1)='PCS' then b.QNT when upper(b.SAT_2)='PCS' then b.QNT2 else 0  QntRSJPcs,

		case when upper(b.SAT_1)='PCS' then b.SAT_1 when upper(b.SAT_2)='PCS' then b.SAT_2 else ''  SatRSJPcs,

		case when upper(b.SAT_1)<>'PCS' then b.QNT when (upper(b.SAT_2)<>'PCS' and upper(b.SAT_2)<>'') then b.QNT2 else 0  QntRSJNonPcs,

		case when upper(b.SAT_1)<>'PCS' then b.SAT_1 when upper(b.SAT_2)<>'PCS' then b.SAT_2 else ''  SatRSJNonPcs, a.catatan

from DBRSPBDet b

left outer join DBBARANG c on c.KODEBRG=b.KodeBrg

left outer join DBRSPB a on a.NoBukti=b.NoBukti

LEFT outer join dbSPBDet a1 on a1.NoBukti=b.NoSPB and a1.Urut=b.UrutSPB

LEFT outer join dbSPB a2 on a2.NoBukti=a1.NoBukti

Left Outer Join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

left outer join dbSPPDet E on e.NoBukti=a1.NoSPP and e.KodeBrg=a1.KodeBrg and E.Urut=a1.UrutSPP

left outer join DBSODET F2 on F2.NoBukti=E.NoSO and F2.KodeBrg=e.KodeBrg and F2.URUT=E.UrutSO

Left Outer Join DBPROJECT Prj on Prj.KODEPROJECT=A2.NoResi

left outer join dbHPPProduksi F on  F.KodeBrg=b.KodeBrg  and F.Bulan=MONTH(A.Tanggal) and F.Tahun=YEAR(A.Tanggal)

where /*((Left(B.NoBukti,3) Like 'BCA%' or Left(B.NoBukti,3) Like 'BCB%')) and*/ a1.NoBukti Not Like '%SJB%' and ISNULL(A2.IsClose,0)=0;

-- vw_alasan
CREATE VIEW IF NOT EXISTS vw_alasan AS select Case when Jns ='DBInvoicePL' Then 'Invoice'

            when Jns ='dbBeli' Then 'Pembelian' 

            when Jns ='DBHasilPrd' Then 'Hasil Produksi'

             Jenis,* from dbAlasanBatal;

-- vw_DP
CREATE VIEW IF NOT EXISTS vw_DP AS select a.KodeCustSupp+a.KodeProject KodeGab,a.NoSeri,a.NoPajak,a.KodeCustSupp,a.KodeProject,d.NAMAPROJECT,c.NAMACUSTSUPP

,b1.Total,ISNULL(DP,0)DP,a.NoKwitansi,b.NoBukti NoInv,Isnull(b.Tanggal,a.Tanggal) TglInv,b.NoBukti,b.RDP

from dbDP a

Left Outer Join (select KodecustSupp,Tanggal,NoBukti,NoBL,Sum(Isnull(RDP,0))RDP,SUM(DP-Isnull(RDP,0)+Case when Left(NoBukti,2)='CB' Then 0 else (DP*0.1 )) DP from dbInvoicePL 

group by KodecustSupp,Tanggal,NoBukti,NoBL)b  on  a.KodeCustSupp=b.KodeCustSupp and a.KodeProject=b.NoBL

Left Outer Join (select KodeCustSupp,KodeProject,Sum(Total)Total from dbDP Group by KodeCustSupp,KodeProject) b1 On B1.KodeProject=a.KodeProject and b1.KodeCustSupp=a.KodeCustSupp 

Left Outer Join (select KodeCustSupp,KodeProject,Min(NoKwitansi)NoKwitansi from dbDP Group by KodeCustSupp,KodeProject)b2 on b2.KodeProject=a.KodeProject and b2.KodeCustSupp=a.KodeCustSupp and a.NoKwitansi=b2.nokwitansi 

Left Outer Join DBCUSTSUPP c on c.KODECUSTSUPP=a.KodeCustSupp

Left Outer Join DBPROJECT d On d.KODEPROJECT=a.KodeProject

where a.NoKwitansi=b2.nokwitansi 

and ISNULL(DP,0)-Isnull(RDP,0)<>0;

-- Vw_HasilPrd
CREATE VIEW IF NOT EXISTS Vw_HasilPrd AS select a.NOBUKTI,a.TANGGAL,c.KodeSubGrp,c2.NamaSubGrp,b.KODEBRG,c.NAMABRG,b1.KODECUST,d.NAMACUSTSUPP,b1.KodeProject, e.NAMAPROJECT,

SUM(b.QNT)QntPro,b1.Qnt QntSO,b.SATUAN,Case when b1.Qnt Is Null Then SUM(b.QNT)else b1.Qnt-SUM(b.Qnt)  QntSisa,

case when Isnull(B1.HPP,0)=0 Then c.Hrg1_2 else b1.HPP  HPP,b1.NoSPK,b1.NOBUKTI NoSO

from DBHASILPRD a

Left Outer Join DBHASILPRDDET b on a.NOBUKTI=b.NOBUKTI

Left Outer Join (Select a.NoBukti NoSPK,b.* from dbSPK a 

                 Left Outer Join(

                 select a.NOBUKTI,KODECUST,AlamatKirim KodeProject,b.KODEBRG,SUM(b.Qnt)Qnt,HPP 

                 from  DBSO a

                 Left Outer Join DBSODET b On a.NOBUKTI=b.NOBUKTI 

                 Group by a.NOBUKTI,KODECUST,AlamatKirim,b.KODEBRG,HPP)b On B.NOBUKTI=a.NOSO) b1 on b1.NoSPK=b.NoSPK and b1.KODEBRG=b.KODEBRG

Left Outer Join DBBARANG c On c.KODEBRG=b.KODEBRG

LEFT Outer Join dbSubGroup c2 On c2.KodeGrp=c.KODEGRP and c2.KodeSubGrp=c.KODESUBGRP

Left Outer Join DBCUSTSUPP d On d.KODECUSTSUPP=B1.KODECUST

Left Outer Join DBPROJECT e On e.KODEPROJECT=b1.KodeProject

--Left Outer Join HPPSO c1 On c1.Kodebrg=b.Kodebrg

where Isnull(c.ISAKTIF,0)=1

Group by a.NOBUKTI,a.TANGGAL,c.KodeSubGrp,c2.NamaSubGrp,b.KODEBRG,c.NAMABRG,b1.KODECUST,d.NAMACUSTSUPP,b1.KodeProject, e.NAMAPROJECT,b1.Qnt,b.SATUAN,b1.HPP,

c.Hrg1_2,b1.NoSPK,b1.NOBUKTI;

-- Vw_HistoryKP
CREATE VIEW IF NOT EXISTS Vw_HistoryKP AS select Case when XUrut=1 Then QntSJ else 0  QntSJ_1,* from(

select a.Nobukti,a.TANGGAL,a.KODECUST,a.AlamatKirim Kodeprj,brSO.NAMABRG kdbrgSO,b.QNT,Case When b.ISI>=1 Then b.HARGA/b.ISI else b.HARGA  Harga ,

d.NoSPB NoSJ,d.KodeBrg KdbrgSJ,d.NAMABRG NamaBrgSJ,d.Qnt QntSJ,

e.NoBukti NoInv,Case when a.KODEVLS='IDR' Then f.TotNetRp else f.TotNet  NilaiInv,

e1.Tanggal TT,g.Tanggal Tglbayar,g.Kredit,h.NAMACUSTSUPP,I.NAMAPROJECT,b1.Qnt TotQntSO,a.KODECUST+a.AlamatKirim Filter,

g.NoBukti NoRef,

CAST(ROW_NUMBER() Over(PARTITION BY a.KODECUST,d.NoSPB,d.UrutSPB Order by a.KODECUST,d.NoSPB,d.urutSpb) As int) XURUT,

d.Tanggal TglSJ,d1.OSKP,d1.NAMABRG NmOSKP,d1.HARGA hrgoskp,e.NAMABRG nmBrgInv,e.Qnt QntInv,e.HARGA HrgInv

from DBSO a

Left Outer Join DBSODET b On a.NOBUKTI=b.NOBUKTI

Left Outer Join DBBARANG brSO on brSO.KODEBRG=b.KODEBRG

Left Outer Join (select NOBUKTI,KODEBRG,SUM(Qnt)Qnt from DBSODET group by NOBUKTI,KODEBRG)b1 On b1.NOBUKTI=b.NOBUKTI and b1.KODEBRG=b.KODEBRG 

Left Outer Join (select b.Tanggal,d.NAMABRG,NoSO,b.NoBukti NoSPB,b.KodeBrg,Isnull(b.QNT,0)-ISNULL(c.Qnt,0)Qnt,UrutSpb from dbSPPdet a 

                 Left Outer Join (select b.NoSPP,b1.Tanggal,b.NoBukti,Kodebrg,MIN(Urut)UrutSpb,Sum(Qnt)Qnt from dbSPBDet b

                                  Left Outer Join dbSPB b1 on b1.NoBukti=b.NoBukti

                                  Group by  b.NoSPP,b1.Tanggal,Kodebrg,b.NoBukti) b On a.NoBukti=b.NoSPP and a.KodeBrg=b.KodeBrg

                 Left Outer Join (select NOSPB,Kodebrg,Sum(Qnt)Qnt from DBRSPBDet 

                                  Group by NOSPB,Kodebrg )c On c.NoSPB=b.NoBukti and c.KodeBrg=b.KodeBrg

                 

                 Left Outer Join DBBARANG d On d.KODEBRG=b.KODEBRG

                 Group by b.Tanggal,d.NAMABRG,NoSO,b.NoBukti,b.KodeBrg,Isnull(b.QNT,0)-ISNULL(c.Qnt,0),UrutSpb)d On d.NoSO=b.NOBUKTI and d.KodeBrg=b.KODEBRG

--------

Left Outer Join (select b.Tanggal,d.NAMABRG,a.NoBukti,a.HARGA,b.KodeBrg,a.QNT-Isnull(b.QNT,0)-ISNULL(c.Qnt,0)OSKP from DBSODET a 

                 Left Outer Join (select spp.NoSO,b1.Tanggal,b.NoBukti,b.KodeBrg,MIN(b.Urut)UrutSpb,Sum(b.QNT)Qnt from dbSPBDet b

                                  Left Outer Join dbSPB b1 on b1.NoBukti=b.NoBukti

                                  Left Outer Join dbSPPDet spp on spp.NOBUKTI=b.NoSPP and  spp.KodeBrg=b.KodeBrg 

                                  Group by  spp.NoSO,b1.Tanggal,b.KodeBrg,b.NoBukti) b On a.NoBukti=b.NoSO and a.KodeBrg=b.KodeBrg

                 Left Outer Join (select NOSPB,Kodebrg,Sum(Qnt)Qnt from DBRSPBDet 

                                  Group by NOSPB,Kodebrg )c On c.NoSPB=b.NoBukti and c.KodeBrg=b.KodeBrg

                 Left Outer Join DBBARANG d On d.KODEBRG=a.KODEBRG

                 Group by b.Tanggal,d.NAMABRG,a.NoBukti,a.HARGA,b.KodeBrg,a.QNT-Isnull(b.QNT,0)-ISNULL(c.Qnt,0))d1 On d1.NOBUKTI=b.NOBUKTI and d1.KodeBrg=b.KODEBRG                 

Left Outer Join (Select a.NOSO,a.NOSPB,a.Kodebrg,b.Namabrg,a.NoBukti,SUM(a.Qnt)Qnt,a.HARGA from dbInvoicePLDet a

                 Left Outer Join dbBarang b on a.KodeBrg=b.KodeBrg

                 Group By a.NOSO,a.NOSPB,a.Kodebrg,b.Namabrg,a.NoBukti,a.HARGA) e On e.NoSO=b.NOBUKTI and e.NoSPB=d.NoSPB and e.KodeBrg=b.KODEBRG  

Left Outer Join dbInvoicePL e1 On e1.NoBukti=e.NoBukti

Left Outer Join [vwRpDetInvoicePL]f On f.NoBukti=e.NoBukti

Left Outer Join DBCUSTSUPP h on h.KODECUSTSUPP=a.KODECUST

Left Outer Join DBPROJECT i on i.KODEPROJECT=a.AlamatKirim

Left Outer Join (select Max(Tanggal)Tanggal,Nofaktur,Max(NoBukti)NoBukti,KodeCustSupp,SUM(Kredit)Kredit from DBHUTPIUT where TipeTrans='L' and ISNULL(debet,0)=0

                 Group by Nofaktur,KodeCustSupp)g On g.NoFaktur=e.NoBukti and a.KODECUST=g.KodeCustSupp        

)a 

where QNT<>0;

-- Vw_KartuProyek
CREATE VIEW IF NOT EXISTS Vw_KartuProyek AS select Case when XUrut=1 Then QntSJ else 0  QntSJ_1,* from(

select a.Nobukti,a.TANGGAL,a.KODECUST,a.AlamatKirim Kodeprj,b.KODEBRG kdbrgSO,/*case when b.ISI>=1 Then Case When b.Nosat=2 Then b.Qnt2 else b.QNT   Else Case when b.Nosat=2 Then b.QNT else b.QNT2  */ Case When B.NOSAT=2 Then B.QNT2 When B.NOSAT=1 Then B.QNT  Qnt,case when B.ISI>=1 Then Case When B.Nosat=2 Then B.HARGA else B.HARGA/B.Isi   Else B.HARGA   Harga ,c.KODEBRG kdBrgPrd,c.NAMABRG NmPrd,c.Qnt QntPrd,

d.NoSPB NoSJ,d.KodeBrg KdbrgSJ,d.NAMABRG NamaBrgSJ,d.Qnt QntSJ,b.SATUAN,b.NDISKON DiscRp,

e.NoBukti NoInv,Case when a.KODEVLS='IDR' Then e.TotNetRp else e.TotNet  NilaiInv,

e.Tanggal TT,g.Tanggal Tglbayar,g.Kredit,h.NAMACUSTSUPP,I.NAMAPROJECT,b1.Qnt TotQntSO,a.KODECUST+a.AlamatKirim Filter,

g.NoBukti NoRef,

CAST(ROW_NUMBER() Over(PARTITION BY a.KODECUST,d.NoSPB,d.UrutSPB Order by a.KODECUST,d.NoSPB,d.urutSpb) As int) XURUT,

d.Tanggal TglSJ,b.QNT-ISNULL(c.Qnt,0)QntsisaProd,Case When bx.PPN=0 then '' when bx.PPN=1 then 'Harga plus PPn 10%' when bx.PPN=2 then 'Harga include ppn'  statusppn,d.NAMABRG

from DBSO a

Left Outer Join DBSODET b On a.NOBUKTI=b.NOBUKTI

Left Outer Join (select NoBukti,PPN from DBSODET Group by NoBukti,PPN) bx On a.NOBUKTI=bx.NOBUKTI

Left Outer Join (select NOBUKTI,KODEBRG,SUM(/*case when b.ISI>=1 Then Case When b.Nosat=2 Then b.Qnt2 else b.QNT   Else Case when b.Nosat=2 Then b.QNT else b.QNT2  */ Case WHen b.NOSAT=2 Then b.QNT2 when b.NOSAT=1 Then b.QNT )Qnt from DBSODET b group by NOBUKTI,KODEBRG)b1 On b1.NOBUKTI=b.NOBUKTI and b1.KODEBRG=b.KODEBRG 

Left Outer Join (select b.Tanggal,d.NAMABRG,NoSO,b.NoBukti NoSPB,b.KodeBrg,(b.QNT)-ISNULL(c.Qnt,0)Qnt,UrutSpb from dbSPPdet a 

                 Left Outer Join (--select b.NoSPP,b1.Tanggal,b.NoBukti,Kodebrg,MIN(Urut)UrutSpb,Sum(case when b.ISI>=1 Then Case When b.Nosat=2 Then b.Qnt2 else b.QNT   Else Case when b.Nosat=2 Then b.QNT else b.QNT2  )Qnt from dbSPBDet b

                                  select b.NoSPP,b1.Tanggal,b.NoBukti,Kodebrg,MIN(Urut)UrutSpb,Sum( Case When b.Nosat=2 Then b.Qnt2 else b.QNT   )Qnt from dbSPBDet b

                                  Left Outer Join dbSPB b1 on b1.NoBukti=b.NoBukti

                                  Group by  b.NoSPP,b1.Tanggal,Kodebrg,b.NoBukti) b On a.NoBukti=b.NoSPP and a.KodeBrg=b.KodeBrg

                 --Left Outer Join (select NOSPB,Kodebrg,Sum(case when ISI>=1 Then Case When Nosat=2 Then Qnt2 else QNT   Else Case when Nosat=2 Then QNT else QNT2  )Qnt 

                 Left Outer Join (select NOSPB,Kodebrg,Sum(Case When Nosat=2 Then Qnt2 else QNT  )Qnt 

                 from DBRSPBDet 

                                  Group by NOSPB,Kodebrg )c On c.NoSPB=b.NoBukti and c.KodeBrg=b.KodeBrg

                 Left Outer Join DBBARANG d On d.KODEBRG=b.KODEBRG

                 Group by b.Tanggal,d.NAMABRG,NoSO,b.NoBukti,b.KodeBrg,b.QNT-ISNULL(c.Qnt,0),UrutSpb)d On d.NoSO=b.NOBUKTI and d.KodeBrg=b.KODEBRG

Left Outer Join (select a.NoBukti,b.Tanggal,a.NoSO,a.NoSPB,a.KodeBrg,TotNetRp,TotNet from dbInvoicePLDet a  

                 Left Outer Join dbInvoicePL b On b.NoBukti=a.NoBukti

                 Left Outer Join [vwRpDetInvoicePL]f On f.NoBukti=a.NoBukti

                 group by a.NoBukti,b.Tanggal,a.NoSO,a.NoSPB,a.KodeBrg,TotNetRp,TotNet)e On e.NoSO=b.NOBUKTI and e.NoSPB=d.NoSPB and e.KodeBrg=b.KODEBRG  

Left Outer Join (select a.NOSO ,b.KodeBrg,b.NAMABRG,SUM(b.Qnt)Qnt from dbSPK a 

                 Left Outer Join(select a.NoSPK,a.KodeBrg,b.NAMABRG,Sum(a.QNT)Qnt from DBHASILPRDDET a 

                                 Left Outer Join dbbarang b On a.KodeBrg=b.KODEBRG

                                 Group by a.NoSPK,a.KodeBrg,b.NAMABRG)b on b.NoSPK=a.NOBUKTI

                Group by a.NOSO ,b.KodeBrg,b.NAMABRG  ) c On c.NOSO=a.NOBUKTI and c.KODEBRG=b.KODEBRG 

Left Outer Join DBCUSTSUPP h on h.KODECUSTSUPP=a.KODECUST

Left Outer Join DBPROJECT i on i.KODEPROJECT=a.AlamatKirim

Left Outer Join (select Max(Tanggal)Tanggal,Nofaktur,Max(NoBukti)NoBukti,KodeCustSupp,SUM(Kredit)Kredit from DBHUTPIUT where TipeTrans='L' and ISNULL(debet,0)=0

                 Group by Nofaktur,KodeCustSupp)g On g.NoFaktur=e.NoBukti and a.KODECUST=g.KodeCustSupp        

)a 

where QNT<>0;

-- Vw_KartuProyekBarang
CREATE VIEW IF NOT EXISTS Vw_KartuProyekBarang AS select Case when XUrut=1 Then QntSJ else 0  QntSJ_1,* from(

select a.Nobukti,a.TANGGAL,a.KODECUST,a.AlamatKirim Kodeprj,b.KODEBRG kdbrgSO,/*case when b.ISI>=1 Then Case When b.Nosat=2 Then b.Qnt2 else b.QNT   Else Case when b.Nosat=2 Then b.QNT else b.QNT2  */ Case When B.NOSAT=2 Then B.QNT2 When B.NOSAT=1 Then B.QNT  Qnt,case when B.ISI>=1 Then Case When B.Nosat=2 Then B.HARGA else B.HARGA/B.Isi   Else B.HARGA   Harga ,c.KODEBRG kdBrgPrd,c.NAMABRG NmPrd,c.Qnt QntPrd,

d.NoSPB NoSJ,d.KodeBrg KdbrgSJ,d.NAMABRG NamaBrgSJ,d.Qnt QntSJ,b.SATUAN,b.NDISKON DiscRp,

h.NAMACUSTSUPP,I.NAMAPROJECT,b1.Qnt TotQntSOF,b.KODEBRG+Br.NamaBrg  Filter,

CAST(ROW_NUMBER() Over(PARTITION BY a.KODECUST,d.NoSPB,d.UrutSPB Order by a.KODECUST,d.NoSPB,d.urutSpb) As int) XURUT,

d.Tanggal TglSJ,b.QNT-ISNULL(c.Qnt,0)QntsisaProd,Case When bx.PPN=0 then '' when bx.PPN=1 then 'Harga plus PPn 11%' when bx.PPN=2 then 'Harga include ppn'  statusppn,B.NOSAT,Br.NamaBrg 

from DBSO a

Left Outer Join DBSODET b On a.NOBUKTI=b.NOBUKTI

Left Outer Join DBBARANG br on br.KODEBRG=b.KODEBRG

Left Outer Join (select NoBukti,PPN from DBSODET Group by NoBukti,PPN) bx On a.NOBUKTI=bx.NOBUKTI

Left Outer Join (select NOBUKTI,KODEBRG,SUM(Case WHen b.NOSAT=2 Then b.QNT2 when b.NOSAT=1 Then b.QNT )Qnt from DBSODET b group by NOBUKTI,KODEBRG)b1 On b1.NOBUKTI=b.NOBUKTI and b1.KODEBRG=b.KODEBRG 

Left Outer Join (select b.Tanggal,d.NAMABRG,NoSO,b.NoBukti NoSPB,b.KodeBrg,(b.QNT)-ISNULL(c.Qnt,0)Qnt,UrutSpb from dbSPPdet a 

                 Left Outer Join (--select b.NoSPP,b1.Tanggal,b.NoBukti,Kodebrg,MIN(Urut)UrutSpb,Sum(case when b.ISI>=1 Then Case When b.Nosat=2 Then b.Qnt2 else b.QNT   Else Case when b.Nosat=2 Then b.QNT else b.QNT2  )Qnt from dbSPBDet b

                                  select b.NoSPP,b1.Tanggal,b.NoBukti,Kodebrg,MIN(Urut)UrutSpb,Sum( Case When b.Nosat=2 Then b.Qnt2 else b.QNT   )Qnt from dbSPBDet b

                                  Left Outer Join dbSPB b1 on b1.NoBukti=b.NoBukti

                                  Group by  b.NoSPP,b1.Tanggal,Kodebrg,b.NoBukti) b On a.NoBukti=b.NoSPP and a.KodeBrg=b.KodeBrg

                 --Left Outer Join (select NOSPB,Kodebrg,Sum(case when ISI>=1 Then Case When Nosat=2 Then Qnt2 else QNT   Else Case when Nosat=2 Then QNT else QNT2  )Qnt 

                 Left Outer Join (select NOSPB,Kodebrg,Sum(Case When Nosat=2 Then Qnt2 else QNT  )Qnt 

                 from DBRSPBDet 

                                  Group by NOSPB,Kodebrg )c On c.NoSPB=b.NoBukti and c.KodeBrg=b.KodeBrg

                 Left Outer Join DBBARANG d On d.KODEBRG=b.KODEBRG

                 Group by b.Tanggal,d.NAMABRG,NoSO,b.NoBukti,b.KodeBrg,b.QNT-ISNULL(c.Qnt,0),UrutSpb)d On d.NoSO=b.NOBUKTI and d.KodeBrg=b.KODEBRG

Left Outer Join (select a.NOSO ,b.KodeBrg,b.NAMABRG,SUM(b.Qnt)Qnt from dbSPK a 

                 Left Outer Join(select a.NoSPK,a.KodeBrg,b.NAMABRG,Sum(a.QNT)Qnt from DBHASILPRDDET a 

                                 Left Outer Join dbbarang b On a.KodeBrg=b.KODEBRG

                                 Group by a.NoSPK,a.KodeBrg,b.NAMABRG)b on b.NoSPK=a.NOBUKTI

                Group by a.NOSO ,b.KodeBrg,b.NAMABRG  ) c On c.NOSO=a.NOBUKTI and c.KODEBRG=b.KODEBRG 

Left Outer Join DBCUSTSUPP h on h.KODECUSTSUPP=a.KODECUST

Left Outer Join DBPROJECT i on i.KODEPROJECT=a.AlamatKirim

)a 

where QNT<>0;

-- Vw_KartuProyekold
CREATE VIEW IF NOT EXISTS Vw_KartuProyekold AS select Case when XUrut=1 Then QntSJ else 0  QntSJ_1,* from(

select a.Nobukti,a.TANGGAL,a.KODECUST,a.AlamatKirim Kodeprj,b.KODEBRG kdbrgSO,/*case when b.ISI>=1 Then Case When b.Nosat=2 Then b.Qnt2 else b.QNT   Else Case when b.Nosat=2 Then b.QNT else b.QNT2  */ Case When B.NOSAT=2 Then B.QNT2 When B.NOSAT=1 Then B.QNT  Qnt,case when B.ISI>=1 Then Case When B.Nosat=2 Then B.HARGA else B.HARGA/B.Isi   Else B.HARGA   Harga ,c.KODEBRG kdBrgPrd,c.NAMABRG NmPrd,c.Qnt QntPrd,

d.NoSPB NoSJ,d.KodeBrg KdbrgSJ,d.NAMABRG NamaBrgSJ,d.Qnt QntSJ,b.SATUAN,b.NDISKON DiscRp,

e.NoBukti NoInv,Case when a.KODEVLS='IDR' Then f.TotNetRp else f.TotNet  NilaiInv,

e1.Tanggal TT,g.Tanggal Tglbayar,g.Kredit,h.NAMACUSTSUPP,I.NAMAPROJECT,b1.Qnt TotQntSO,a.KODECUST+a.AlamatKirim Filter,

g.NoBukti NoRef,

CAST(ROW_NUMBER() Over(PARTITION BY a.KODECUST,d.NoSPB,d.UrutSPB Order by a.KODECUST,d.NoSPB,d.urutSpb) As int) XURUT,

d.Tanggal TglSJ,b.QNT-ISNULL(c.Qnt,0)QntsisaProd,Case When bx.PPN=0 then '' when bx.PPN=1 then 'Harga plus PPn 10%' when bx.PPN=2 then 'Harga include ppn'  statusppn

from DBSO a

Left Outer Join DBSODET b On a.NOBUKTI=b.NOBUKTI

Left Outer Join (select NoBukti,PPN from DBSODET Group by NoBukti,PPN) bx On a.NOBUKTI=bx.NOBUKTI

Left Outer Join (select NOBUKTI,KODEBRG,SUM(/*case when b.ISI>=1 Then Case When b.Nosat=2 Then b.Qnt2 else b.QNT   Else Case when b.Nosat=2 Then b.QNT else b.QNT2  */ Case WHen b.NOSAT=2 Then b.QNT2 when b.NOSAT=1 Then b.QNT )Qnt from DBSODET b group by NOBUKTI,KODEBRG)b1 On b1.NOBUKTI=b.NOBUKTI and b1.KODEBRG=b.KODEBRG 

Left Outer Join (select b.Tanggal,d.NAMABRG,NoSO,b.NoBukti NoSPB,b.KodeBrg,(b.QNT)-ISNULL(c.Qnt,0)Qnt,UrutSpb from dbSPPdet a 

                 Left Outer Join (--select b.NoSPP,b1.Tanggal,b.NoBukti,Kodebrg,MIN(Urut)UrutSpb,Sum(case when b.ISI>=1 Then Case When b.Nosat=2 Then b.Qnt2 else b.QNT   Else Case when b.Nosat=2 Then b.QNT else b.QNT2  )Qnt from dbSPBDet b

                                  select b.NoSPP,b1.Tanggal,b.NoBukti,Kodebrg,MIN(Urut)UrutSpb,Sum( Case When b.Nosat=2 Then b.Qnt2 else b.QNT   )Qnt from dbSPBDet b

                                  Left Outer Join dbSPB b1 on b1.NoBukti=b.NoBukti

                                  Group by  b.NoSPP,b1.Tanggal,Kodebrg,b.NoBukti) b On a.NoBukti=b.NoSPP and a.KodeBrg=b.KodeBrg

                 --Left Outer Join (select NOSPB,Kodebrg,Sum(case when ISI>=1 Then Case When Nosat=2 Then Qnt2 else QNT   Else Case when Nosat=2 Then QNT else QNT2  )Qnt 

                 Left Outer Join (select NOSPB,Kodebrg,Sum(Case When Nosat=2 Then Qnt2 else QNT  )Qnt 

                 from DBRSPBDet 

                                  Group by NOSPB,Kodebrg )c On c.NoSPB=b.NoBukti and c.KodeBrg=b.KodeBrg

                 Left Outer Join DBBARANG d On d.KODEBRG=b.KODEBRG

                 Group by b.Tanggal,d.NAMABRG,NoSO,b.NoBukti,b.KodeBrg,b.QNT-ISNULL(c.Qnt,0),UrutSpb)d On d.NoSO=b.NOBUKTI and d.KodeBrg=b.KODEBRG

Left Outer Join dbInvoicePLDet e On e.NoSO=b.NOBUKTI and e.NoSPB=d.NoSPB and e.KodeBrg=b.KODEBRG  

Left Outer Join dbInvoicePL e1 On e1.NoBukti=e.NoBukti

Left Outer Join [vwRpDetInvoicePL]f On f.NoBukti=e.NoBukti

Left Outer Join (select a.NOSO ,b.KodeBrg,b.NAMABRG,SUM(b.Qnt)Qnt from dbSPK a 

                 Left Outer Join(select a.NoSPK,a.KodeBrg,b.NAMABRG,Sum(a.QNT)Qnt from DBHASILPRDDET a 

                                 Left Outer Join dbbarang b On a.KodeBrg=b.KODEBRG

                                 Group by a.NoSPK,a.KodeBrg,b.NAMABRG)b on b.NoSPK=a.NOBUKTI

                Group by a.NOSO ,b.KodeBrg,b.NAMABRG  ) c On c.NOSO=a.NOBUKTI and c.KODEBRG=b.KODEBRG 

Left Outer Join DBCUSTSUPP h on h.KODECUSTSUPP=a.KODECUST

Left Outer Join DBPROJECT i on i.KODEPROJECT=a.AlamatKirim

Left Outer Join (select Max(Tanggal)Tanggal,Nofaktur,Max(NoBukti)NoBukti,KodeCustSupp,SUM(Kredit)Kredit from DBHUTPIUT where TipeTrans='L' and ISNULL(debet,0)=0

                 Group by Nofaktur,KodeCustSupp)g On g.NoFaktur=e.NoBukti and a.KODECUST=g.KodeCustSupp        

)a 

where QNT<>0;

-- Vw_ReportCashBack
CREATE VIEW IF NOT EXISTS Vw_ReportCashBack AS select a.NoBukti,a.KODECUST,a.TANGGAL,AlamatKirim KodePrj,d.NAMACUSTSUPP,e.NAMAPROJECT,b.QNT,Isnull(c.Qnt,0)QntKirim,b.HARGA,b.HARGA*Isnull(c.Qnt,0)HargaK,b.HARGA-Qnt2SisaSO HrgDeal,Qnt2SisaSO CashBack,

Isnull(c.Qnt,0)*b.HARGA TotalKirim ,Isnull(c.Qnt,0) * (b.HARGA-Qnt2SisaSO)TotalDeal, (Isnull(c.Qnt,0)*b.HARGA)-(Isnull(c.Qnt,0) * (b.HARGA-Qnt2SisaSO)) Kelebihan,Isnull(c.Qnt,0)*Qnt2SisaSO KelebihanK,null TglRealisasi,

a.KODECUST+e.NAMAPROJECT Filter,f.NamaBrg,a.TglJurnal,a.KodeExp

from DBSO a  

Left Outer Join DBSODET b on a.NOBUKTI=b.NOBUKTI

Left Outer Join (select a.KodeBrg,NoSO,SUM(b.QNT)-Isnull(c.Qnt,0) Qnt from dbSPPDet a

                 Left Outer Join dbSPBDet b On a.NoBukti=b.NoSPP and a.KodeBrg=b.KodeBrg

                 Left Outer Join(select Kodebrg,SUM(Qnt)Qnt,NoSPB from DBRSPBDet Group By Kodebrg,NoSPB)c on c.NoSPB=b.NoBukti and c.KodeBrg=b.KodeBrg

                 Group by a.KodeBrg,NoSO,c.Qnt)c on c.KodeBrg=b.KODEBRG and c.NoSO=b.NOBUKTI

Left Outer Join DBCUSTSUPP d on d.KODECUSTSUPP=a.KODECUST

Left Outer Join DBPROJECT e On e.KODEPROJECT=a.AlamatKirim and e.KODECUST=a.KODECUST 

Left Outer Join DBBARANG f On f.KODEBRG=b.KODEBRG               

where Qnt2SisaSO<>0;

-- Vw_ReportSPBCashBack
CREATE VIEW IF NOT EXISTS Vw_ReportSPBCashBack AS select a.NoBukti,a.KodeCustSupp ,a.TANGGAL,d.NAMACUSTSUPP,b.QNT-ISNULL(Rspb.Qnt,0)Qnt ,c.HARGA,c.HARGA*b.QNT-ISNULL(Rspb.Qnt,0)HargaK,c.HARGA-c.Qnt2SisaSO HrgDeal,c.Qnt2SisaSO CashBack,

b.QNT-ISNULL(Rspb.Qnt,0)*c.HARGA TotalKirim ,b.QNT-ISNULL(Rspb.Qnt,0) * (c.HARGA-c.Qnt2SisaSO)TotalDeal, ((b.QNT-ISNULL(Rspb.Qnt,0))*c.HARGA)-((b.QNT-ISNULL(Rspb.Qnt,0)) * (c.HARGA-c.Qnt2SisaSO)) Kelebihan,(b.QNT-ISNULL(Rspb.Qnt,0))*c.Qnt2SisaSO KelebihanK,TglOto1 TglRealisasi,

f.NamaBrg,a.TglJurnal,a.KodeExp

from dbSPB a  

Left Outer Join dbSPBDet b on a.NOBUKTI=b.NOBUKTI

Left Outer Join(select NOSPB,KODEBRG,SUM(Qnt)Qnt from DBRSPBDet

                Group by NOSPB,KODEBRG)Rspb on Rspb.NoSPB=b.NoBukti and Rspb.KodeBrg=b.KodeBrg

Left Outer Join (select b.KodeBrg,a.NoBukti,b.HARGA,SUM(b.Qnt2SisaSO)Qnt2SisaSO,b1.KodeExp,SUM(b.Qnt)Qnt from dbSPPDet a

                 Left Outer Join DBSODET b On b.NoBukti=a.NoSO and a.KodeBrg=b.KodeBrg

                 Left Outer Join DBSO b1 on b1.NOBUKTI=b.NOBUKTI

                 Group by b.KodeBrg,a.NoBukti,NoSO,b.HARGA,b1.KodeExp)c on c.KodeBrg=b.KODEBRG and c.NoBukti=b.NoSPP

Left Outer Join DBCUSTSUPP d on d.KODECUSTSUPP=a.KodeCustSupp

Left Outer Join DBBARANG f On f.KODEBRG=b.KODEBRG               

where c.Qnt2SisaSO<>0;

-- vw_SOvsSPKvsHasilPrd
CREATE VIEW IF NOT EXISTS vw_SOvsSPKvsHasilPrd AS select a.NOBUKTI,a.noBukti NoSO,a.TANGGAL,a.KODECUST,f.NAMACUSTSUPP,G.NAMAPROJECT,b.KODEBRG,h.NAMABRG,

b.QNT QntSO,c.NOBUKTI NoSPK,d.QNT QntSPK,e.TANGGAL TglProd,e.NOBUKTI NoProd,e.QNT qntProd

from dbSO a

Left Outer Join DBSODET b on a.NOBUKTI=b.NOBUKTI

Left Outer Join DBSPK c On c.NOSO=b.NOBUKTI

Left Outer Join (select NoBukti,KodeBrg,Qnt from DBSPKMDET Group by NoBukti,KodeBrg,Qnt) d On d.NOBUKTI=c.NOBUKTI and d.KODEBRG=b.KODEBRG

Left Outer Join (select a.Tanggal,a.NoBukti,b.Qnt,b.KodeBrg,b.NoSPK  from

                 DBHASILPRD a

                 Left Outer Join  DBHasilPrdDet b On a.NOBUKTI=b.NOBUKTI)e On e.NoSPK=d.NOBUKTI and e.KODEBRG=d.KODEBRG

Left Outer Join DBCUSTSUPP f on f.KODECUSTSUPP=a.KODECUST

Left Outer Join DBPROJECT g on g.KodePROJECT=a.AlamatKirim  

Left Outer Join DBBARANG h on h.KODEBRG=b.KODEBRG 

where Isnull(h.ISAKTIF,0)=1


--select * from DBSODET where NOBUKTI='CA/KP/0414/00026';

-- vw_TransRute
CREATE VIEW IF NOT EXISTS vw_TransRute AS select A.NOBUKTI,A.NOURUT,A.TANGGAL,A.KODEKEND,A.SUPIR,A.RUTE,

B.URUT,B.BIAYA,B.TARIF,B.QNT,B.TOTAL,C.NAMAKEND,C.KODEJENISKEND,

D.NAMAJENISKEND,E.NAMARUTE,B.ISP,Ket1,Ket2

from DBRUTETRANS A

LEFT OUTER JOIN DBRUTETRANSDET B ON A.NOBUKTI=B.NOBUKTI

LEFT OUTER JOIN DBKENDARAAN C ON A.KODEKEND=C.KODEKEND

LEFT OUTER JOIN DBJENISKEND D ON C.KODEJENISKEND=D.KODEJENISKEND

LEFT OUTER JOIN DBRUTE E ON A.RUTE=E.KODERUTE;

-- vwAktiva
CREATE VIEW IF NOT EXISTS vwAktiva AS select A.*,C.Keterangan KelAktiva,D.Keterangan NamaAkumulasi,

       E.Keterangan NamaBiaya,F.Keterangan NamaBiaya2,

       G.Keterangan NamaBiaya3,H.Keterangan NamaBiaya4,

       Case when A.Tipe='L' then 'Garis Lurus'

            when A.Tipe='M' then 'Menurun'

            when A.Tipe='P' then 'Pajak'

            else ''

        Mytipe,

       I.NamaBag,

       C.Keterangan+Case when C.Keterangan is null then '' else ' ('+C.Perkiraan+')'  myAktiva,

       D.Keterangan+Case when D.Keterangan is null then '' else ' ('+D.Perkiraan+')'  myAkumulasi,

       E.Keterangan+Case when E.Keterangan is null then '' else ' ('+E.Perkiraan+')'  myBiaya,

       F.Keterangan+Case when F.Keterangan is null then '' else ' ('+F.Perkiraan+')'  myBiaya2,

       G.Keterangan+Case when G.Keterangan is null then '' else ' ('+G.Perkiraan+')'  myBiaya3,

       H.Keterangan+Case when H.Keterangan is null then '' else ' ('+H.Perkiraan+')'  myBiaya4,

       I.NamaBag+Case when I.NamaBag is null then '' else ' ('+I.KodeBag+')'  myBagian

from DBAKTIVA A

     left Outer join DBPOSTHUTPIUT B on B.Perkiraan=A.NoMuka

     Left Outer join DBPERKIRAAN C on C.Perkiraan=B.Perkiraan and C.Perkiraan=A.NoMuka

     left Outer join DBPERKIRAAN D on D.Perkiraan=A.Akumulasi

     left Outer join DBPERKIRAAN E on E.Perkiraan=A.Biaya

     left Outer join DBPERKIRAAN F on F.Perkiraan=A.Biaya2

     left Outer join DBPERKIRAAN G on G.Perkiraan=A.biaya3

     left Outer join DBPERKIRAAN H on H.Perkiraan=A.biaya4

     Left Outer join DBBAGIAN I on I.KodeBag=A.Kodebag;

-- vwAktivitasUser
CREATE VIEW IF NOT EXISTS vwAktivitasUser AS select  A.Tahun, A.Bulan, A.Tanggal, A.Pemakai, A.Aktivitas,

        cast(case when A.Aktivitas='I' then 'Tambah' when A.Aktivitas='U' then 'Koreksi'

        when A.Aktivitas='D' then 'Hapus' when A.Aktivitas='C' then 'Cetak' else ''  as varchar(50)) NamaAktivitas,

        isnull(B.NamaSumber,'') Sumber, A.NoBukti, 

	cast(case when A.Aktivitas='I' then 'Tambah --> ' 

                  when A.Aktivitas='U' then 'Koreksi --> '

                  when A.Aktivitas='D' then 'Hapus --> ' 

                  when A.Aktivitas='C' then 'Cetak' 

                  when A.Aktivitas='CI' then 'Cetak Surat Jalan' 

                  else '' 

             +A.Keterangan as text) Keterangan

from    dbLogFile A

left outer join vwSumberAktivitasUser B on B.KodeSumber=A.Sumber;

-- vwAlamatCust
CREATE VIEW IF NOT EXISTS vwAlamatCust AS --select * from 	dbAlamatCust A

select A.KODECUSTSUPP, 0 Nomor, A.NAMACUSTSUPP Nama, 

A.ALAMAT1+case when ltrim(A.Alamat2)='' then '' else CHAR(13)+A.ALAMAT2 +CHAR(13)+A.Kota Alamat,

A.TELPON Telp, A.FAX Fax

from DBCUSTSUPP A

union all

select A.KODECUSTSUPP, A.Nomor, A.Nama, A.Alamat,

A.Telp, A.Fax

from dbAlamatCust A;

-- vwBagian
CREATE VIEW IF NOT EXISTS vwBagian AS Select A.*, 

       B.Keterangan+' ('+A.Perkiraan+')' NamaPerkiraan,

       C.Keterangan+' ('+A.Biaya+')' NamaBiaya

from DBBAGIAN A

     Left Outer Join DBPERKIRAAN B on B.Perkiraan=A.Perkiraan

     left Outer join DBPERKIRAAN C on C.Perkiraan=A.Biaya;

-- vwBarang
CREATE VIEW IF NOT EXISTS vwBarang AS select	A.KODEBRG, A.NAMABRG, A.NamaBrg2,A.Ukuran,  

	A.KODEGRP, B.NAMA NamaGrp, A.GrpBarang, C.NamaSubGrp NamaGrpBarang, A.KODESUBGRP, C.NamaSubGrp,

	A.KODESUPP, A.IsBarang, 

    case when A.IsBarang=3 then 'Barang' else 'Jasa'  MyBarang, 

	A.SAT1, A.ISI1, A.SAT2, A.ISI2, A.SAT3, A.ISI3,

	A.NFix, cast(case when A.NFix=0 then 'Sama' else 'Tidak Sama'  as varchar(30)) MyNFix,

	A.Hrg1_1, A.Hrg2_1, A.Hrg3_1, A.Hrg1_2, A.Hrg2_2, A.Hrg3_2, A.Hrg1_3, A.Hrg2_3, A.Hrg3_3,

	A.QntMin, A.QntMax, Isnull(A.ISAKTIF,0)ISAKTIF, case when a.IsAktif=0 then 'Non Aktif' else 'Aktif'  MyAktif,

	A.Keterangan,  

	A.Tolerate, A.DimH, A.DimL, A.DimT1A, A.DimT1B, A.DimT2, A.DimW,isnull(A.tonase,0) Tonase,ISNULL(A.IsJasa,0)IsJasa,

	CONVERT(INTEGER,Case When Isnull(IsBarang,0)=8 Then 1 else 0 )NS  

from	DBBARANG A

left outer join DBGROUP B on B.KODEGRP=A.KODEGRP

left outer join dbSubGroup C on C.KodeGrp=A.KODEGRP and C.KodeSubGrp=A.KODESUBGRP

left outer join dbSubGroup2 C2 on C2.KodeGrp=A.KODEGRP and C2.KodeSubGrp=A.GrpBarang and C2.KodeSubGrp2=A.KODESUBGRP;

-- vwBon
CREATE VIEW IF NOT EXISTS vwBon AS select A.*,B.Keterangan NamaPerkiraan

from DBBON A

     left Outer join DBPERKIRAAN B on B.Perkiraan=A.Perkiraan;

-- vwBonBelumLunas
CREATE VIEW IF NOT EXISTS vwBonBelumLunas AS Select Nobukti,SUM(Debet-Kredit) Saldo

from DBBON

Group by NoBukti

Having SUM(Debet-Kredit)>0;

-- vwBrgInspeksi
CREATE VIEW IF NOT EXISTS vwBrgInspeksi AS select a.KodeBrg,d.NamaBrg,a.NoBukti,a.Qnt,a.Qnt2,d.Toleransi From dbPODet a

left Outer join dbPPLdet b on a.NoPPL=b.NoBukti and a.UrutPPL=b.Urut

Left Outer join dbPermintaanBrgdet c on c.NoBukti=b.NoPermintaan and c.Urut=b.UrutPermintaan 

Left Outer Join dbBarang d on d.KodeBrg=C.KodeBrg

where c.IsInspeksi=1;

-- vwBrowsCust
CREATE VIEW IF NOT EXISTS vwBrowsCust AS Select 	A.KODECUSTSUPP, A.NAMACUSTSUPP, A.ALAMAT1, A.ALAMAT2, 

    case when isnull(A.Alamat2,'')='' then A.Alamat1 else A.Alamat1+char(13)+A.Alamat2  Alamat,

	A.kota kodeKota,  A.Kota, 

	A.TELPON, A.FAX, A.EMAIL, A.KODEPOS, A.NEGARA, A.NPWP, A.Tanggal, A.PLAFON, A.HARI, A.HARIHUTPIUT, 

	A.BERIKAT, A.USAHA, D.PERKIRAAN, JENIS, A.NAMAPKP, A.ALAMATPKP1, A.ALAMATPKP2, A.KOTAPKP, A.Sales, A.KodeVls, A.KodeTipe, A.IsPpn,

	A.Agent,case when isnull(A.Alamat2A,'')='' then A.Alamat1A else A.Alamat1A+char(13)+A.Alamat2A  AlamatA,

	A.KotaA, A.NegaraA, A.ContactP, B.IsBeliJual, B.IsLokalorExim,

	case when isnull(A.ALAMATPKP2,'')='' then A.ALAMATPKP1 else A.ALAMATPKP1+char(13)+A.ALAMATPKP2  AlamatPKP,	   

	C.Keterangan NamaPerkiraan,A.IsAktif,Isnull(A.IsPPh21,0)isPPh21

From 	dbo.DBCUSTSUPP A

      left Outer join DBPERKCUSTSUPP D on D.KodeCustSupp=A.KODECUSTSUPP

      Left Outer Join DBPOSTHUTPIUT B on B.Perkiraan=D.PERKIRAAN

      Left Outer Join dbo.DBPERKIRAAN C on C.Perkiraan=B.PERKIRAAN

where B.Kode='PT';

-- vwBrowsCustHT
CREATE VIEW IF NOT EXISTS vwBrowsCustHT AS Select 	A.KODECUSTSUPP, A.NAMACUSTSUPP, A.ALAMAT1, A.ALAMAT2, 

    case when isnull(A.Alamat2,'')='' then A.Alamat1 else A.Alamat1+char(13)+A.Alamat2  Alamat,

	A.kota kodeKota,  A.Kota, 

	A.TELPON, A.FAX, A.EMAIL, A.KODEPOS, A.NEGARA, A.NPWP, A.Tanggal, A.PLAFON, A.HARI, A.HARIHUTPIUT, 

	A.BERIKAT, A.USAHA, D.PERKIRAAN, JENIS, A.NAMAPKP, A.ALAMATPKP1, A.ALAMATPKP2, A.KOTAPKP, A.Sales, A.KodeVls, A.KodeTipe, A.IsPpn,

	A.Agent,case when isnull(A.Alamat2A,'')='' then A.Alamat1A else A.Alamat1A+char(13)+A.Alamat2A  AlamatA,

	A.KotaA, A.NegaraA, A.ContactP, B.IsBeliJual, B.IsLokalorExim,

	case when isnull(A.ALAMATPKP2,'')='' then A.ALAMATPKP1 else A.ALAMATPKP1+char(13)+A.ALAMATPKP2  AlamatPKP,	   

	C.Keterangan NamaPerkiraan,A.IsAktif

From 	dbo.DBCUSTSUPP A

      left Outer join DBPERKCUSTSUPP D on D.KodeCustSupp=A.KODECUSTSUPP

      Left Outer Join DBPOSTHUTPIUT B on B.Perkiraan=D.PERKIRAAN

      Left Outer Join dbo.DBPERKIRAAN C on C.Perkiraan=B.PERKIRAAN

where B.Kode='HT' and  ISNULL(IsCust,0)=1;

-- vwBrowsCustomer
CREATE VIEW IF NOT EXISTS vwBrowsCustomer AS select	A.KODECUSTSupp kodecust, A.NAMACUSTSUPP namaCust, ltrim(A.ALAMAT1+case when ltrim(A.ALAMAT2)<>'' then char(13)+A.ALAMAT2 else '' +

	case when ltrim(isnull(A.KOTA,''))<>'' then char(13)+isnull(A.KOTA,'')+' '+A.KodePos else '' ) ALAMAT, 

	A.Kota kodekota, a.Kota NAMAKOTA, A.TELPON, A.PLAFON, A.HARI, A.Hari HARIPIUTANG, 

	A.USAHA, A.PERKIRAAN, A.JENIS, C.KeyNik Sales, D.Nama NAMASLS, A.KODEEXP, E.NAMAEXP, A.KODETIPE, a.IsPpn

from	dbCustSupp A

left outer join DBSALESCUSTOMER C on c.KodeCustSupp=a.KODECUSTSUPP

Left Outer join dbKaryawan D on d.KeyNIK=C.KeyNik

left outer join dbExpedisi E on E.KodeExp=A.KodeExp;

-- vwBrowsExpedisi
CREATE VIEW IF NOT EXISTS vwBrowsExpedisi AS Select 	A.KODECUSTSUPP, A.NAMACUSTSUPP, A.ALAMAT1, A.ALAMAT2, 

    case when isnull(A.Alamat2,'')='' then A.Alamat1 else A.Alamat1+char(13)+A.Alamat2  Alamat,

	A.kota kodeKota,  A.Kota, 

	A.TELPON, A.FAX, A.EMAIL, A.KODEPOS, A.NEGARA, A.NPWP, A.Tanggal, A.PLAFON, A.HARI, A.HARIHUTPIUT, 

	A.BERIKAT, A.USAHA, D.PERKIRAAN, JENIS, A.NAMAPKP, A.ALAMATPKP1, A.ALAMATPKP2, A.KOTAPKP, A.Sales, A.KodeVls, A.KodeTipe, A.IsPpn,

	A.Agent,case when isnull(A.Alamat2A,'')='' then A.Alamat1A else A.Alamat1A+char(13)+A.Alamat2A  AlamatA,

	A.KotaA, A.NegaraA, A.ContactP, B.IsBeliJual, B.IsLokalorExim,

	case when isnull(A.ALAMATPKP2,'')='' then A.ALAMATPKP1 else A.ALAMATPKP1+char(13)+A.ALAMATPKP2  AlamatPKP,	   

	C.Keterangan NamaPerkiraan,A.IsAktif

From 	dbo.DBCUSTSUPP A

      left Outer join DBPERKCUSTSUPP D on D.KodeCustSupp=A.KODECUSTSUPP

      Left Outer Join DBPOSTHUTPIUT B on B.Perkiraan=D.PERKIRAAN

      Left Outer Join dbo.DBPERKIRAAN C on C.Perkiraan=B.PERKIRAAN

where a.Jenis=3;

-- vwBrowsOutBP_Inspeksi
CREATE VIEW IF NOT EXISTS vwBrowsOutBP_Inspeksi AS select	Nobukti, urut, NoPO, UrutPO, kodebrg, Sat_1, Sat_2, Isi, Qnt, Qnt2, QntBatal, Qnt2Batal, QntIns, Qnt2Ins, QntSisaIns, Qnt2SisaIns, QntSisa, Qnt2Sisa, Nosat

From 	dbo.vwOutBP_Inspeksi 

where 	QntSisa>0 and Qnt2Sisa>0;

-- vwBrowsOutInspeksi
CREATE VIEW IF NOT EXISTS vwBrowsOutInspeksi AS Select 	NoBukti, Urut, KodeBrg, Qnt, Qnt2, QntSJ, Qnt2SJ, QntSisa, Qnt2Sisa 

From 	vwOutInspeksi 

where 	QntSisa>0 and Qnt2Sisa>0;

-- vwBrowsOutPermintaanBrg
CREATE VIEW IF NOT EXISTS vwBrowsOutPermintaanBrg AS SELECT     Nobukti, urut, kodebrg,Nosat, Sat_1, Sat_2, Isi, Qnt, Qnt2, TglTiba, isInspeksi, 

		QntBPB, Qnt2BPB, QntBBP, Qnt2BBP, QntPPL, Qnt2PPL,QntBPL, Qnt2BPL, 

		QntSisaBPB, Qnt2SisaBPB, QntSisa, Qnt2Sisa, Keterangan

FROM         dbo.vwOutPermintaanBrg

where (QntSisaBPB>0) or (Qnt2SisaBPB>0);

-- vwBrowsOutPO
CREATE VIEW IF NOT EXISTS vwBrowsOutPO AS Select 	Nobukti, urut, NoPPL, UrutPPL, kodebrg, Sat_1, Sat_2, Isi, Qnt, Qnt2, QntBatal, Qnt2Batal, 

	QntBeli, Qnt2Beli, QntSisaBeli, Qnt2SisaBeli, QntSisa, Qnt2Sisa, ISNULL(QntTukar,0) QntTukar, ISNULL(Qnt2Tukar,0) Qnt2Tukar 

From 	dbo.vwOutPO 

where 	QntSisa>0 and Qnt2Sisa>0;

-- vwBrowsOutPO_BP
CREATE VIEW IF NOT EXISTS vwBrowsOutPO_BP AS Select 	NoBukti, Urut, NoPPL, UrutPPL, NoInspeksi, UrutInspeksi, KodeBrg, Sat_1, Sat_2, Isi, Qnt, Qnt2, QntBatal, Qnt2Batal, 

	QntBeli, Qnt2Beli, QntSisaBeli, Qnt2SisaBeli, QntSisa, Qnt2Sisa, Nosat, Catatan

From 	vwOutPO_BP 

where 	QntSisa>0 Or Qnt2Sisa>0;

-- vwBrowsOutPO_Inspeksi
CREATE VIEW IF NOT EXISTS vwBrowsOutPO_Inspeksi AS select	Nobukti, urut, NoPPL, UrutPPL, kodebrg, Sat_1, Sat_2, Isi, Qnt, Qnt2, QntBatal, Qnt2Batal, QntIns, Qnt2Ins, QntSisaIns, Qnt2SisaIns, QntSisa, Qnt2Sisa, Nosat

From 	dbo.vwOutPO_Inspeksi 

where 	QntSisa>0 and Qnt2Sisa>0;

-- vwBrowsOutPPL
CREATE VIEW IF NOT EXISTS vwBrowsOutPPL AS SELECT     Nobukti, urut, kodebrg, Sat_1, Sat_2, Isi, Qnt, Qnt2, TglTiba, NoPermintaan, UrutPermintaan, QntBatal, Qnt2Batal, 

			QntPO, Qnt2PO, QntBtlPO, Qnt2BtlPO, QntSisaPO, 

            Qnt2SisaPO, QntSisa, Qnt2Sisa, NamaBag,  tglbutuh, keterangan, isInspeksi, nosat, Pelaksana

FROM         dbo.vwOutPPL

WHERE     (QntSisa > 0) AND (Qnt2Sisa > 0);

-- vwBrowsOutRJual
CREATE VIEW IF NOT EXISTS vwBrowsOutRJual AS Select 	NoBukti, Urut, KodeBrg, Sat_1, Sat_2, NoSat, Isi, Qnt, Qnt2, 

	QntSPB, Qnt2SPB, QntSisa, Qnt2Sisa,NetW,GrossW, noinvoice,UrutInvoice, namabrg, isFlag	

From 	vwOutRjual 

where 	QntSisa>0 and Qnt2Sisa>0;

-- vwBrowsOutSC_SPP
CREATE VIEW IF NOT EXISTS vwBrowsOutSC_SPP AS Select 	NoBukti, Urut, KodeBrg, Sat_1, Sat_2, NoSat, Isi, Qnt, Qnt2, 

	QntSPP, Qnt2SPP, QntSisa, Qnt2Sisa, NamabrgKom 

From 	vwOutSC_SPP 

where 	QntSisa>0 and Qnt2Sisa>0;

-- vwBrowsOutShip
CREATE VIEW IF NOT EXISTS vwBrowsOutShip AS Select 	NoBukti, Urut, KodeBrg,Namabrg, Sat_1, Sat_2, NoSat, Isi, Qnt, Qnt2, 

	QntSPB, Qnt2SPB, QntSisa, Qnt2Sisa,NetW,GrossW, NoSC

From 	vwOutShip 

where 	QntSisa>0 and Qnt2Sisa>0;

-- vwBrowsOutSHIP_SPP
CREATE VIEW IF NOT EXISTS vwBrowsOutSHIP_SPP AS Select 	NoBukti, NOSC, Urut, KodeBrg, Sat_1, Sat_2, NoSat, Isi, Qnt, Qnt2, QntSPP, Qnt2SPP, QntSisa, Qnt2Sisa, NamabrgKom,

         ShippingMark

From 	vwOutSHIP_SPP 

where 	QntSisa>0 and Qnt2Sisa>0;

-- vwBrowsOutSO_InvoicePL
CREATE VIEW IF NOT EXISTS vwBrowsOutSO_InvoicePL AS Select 	NoBukti,  Urut, KodeBrg, Satuan,  NoSat, Isi, Qnt, Qnt2, QntSPP, Qnt2SPP, QntSisa, Qnt2Sisa, NamabrgKom, isLengkap, MasaBerlaku

,QNTBATAL,Isclose

	    ,UserClose,tglClose,ketBatal

From 	vwOutSO_InvoicePL

where 	QntSisa>0 --and MasaBerlaku>=GETDATE();

-- vwBrowsOutSO_SPP
CREATE VIEW IF NOT EXISTS vwBrowsOutSO_SPP AS Select 	NoBukti,  Urut, KodeBrg, Satuan,  NoSat, Isi, Qnt, Qnt2, QntSPP, Qnt2SPP, QntSisa, Qnt2Sisa, NamabrgKom, isLengkap, MasaBerlaku

,QNTBATAL,Isclose,PPN,NamaProject

	    ,UserClose,tglClose,ketBatal

From 	vwOutSO_SPP --where NoBukti='BCB/KP/0117/00005'

where 	QntSisa>0 or Qnt2Sisa>0 --and MasaBerlaku>=GETDATE();

-- vwBrowsOutSPB_RSPB
CREATE VIEW IF NOT EXISTS vwBrowsOutSPB_RSPB AS Select 	NoBukti, Urut, KodeBrg,Namabrg, Qnt,Convert(Numeric(18,2),0)Qnt2, QntInv,Nosat,Sat_1,ISI,SAT_2, 

	QntRetur,Convert(Numeric(18,2),0)Qnt2Retur, QntSisa,Convert(Numeric(18,2),Qnt2Sisa)Qnt2Sisa,Kodegdg

	From 	vwOutSPB_RSPB a

where 	QntSisa>0 



--select * from vwOutSPB_RSPB;

-- vwBrowsOutSPP
CREATE VIEW IF NOT EXISTS vwBrowsOutSPP AS Select 	NoBukti, Urut, KodeBrg,Namabrg, Sat_1, Sat_2, NoSat, Isi, Qnt, Qnt2, 

	QntSPB, Qnt2SPB, QntSisa, Qnt2Sisa,NetW,GrossW, Catatan, TipeSPP,

	isClose, NoSO, UrutSO, isCetakKitir,QntSO,Qnt2SO,QntTSPB,QntT2SPB,QntRSPB,KodeGdg

From 	vwOutSPP 

where 	QntSisa>0 or Qnt2Sisa>0;

-- vwBrowsOutSPRK
CREATE VIEW IF NOT EXISTS vwBrowsOutSPRK AS SELECT     Nobukti, urut, kodebrg, Sat_1, Sat_2, Isi, Qnt, Qnt2, '' NoPermintaan,0 UrutPermintaan,

           QntBSPRK QntBatal, Qnt2BSPRK Qnt2Batal, QntPO, Qnt2PO, QntBPO, Qnt2BPO, QntSisaPO, 

           Qnt2SisaPO, QntSisa, Qnt2Sisa, NamaBag, nosat, Pelaksana, IsInspeksi, Keterangan, KodeGrp, Catatan,

           JnsPakai, Kodegdg, kodebag, kodemesin, SOP, Perk_Investasi

FROM   dbo.vwOutSPRK

WHERE (QntSisa > 0) AND (Qnt2Sisa > 0);

-- vwBrowsSupp
CREATE VIEW IF NOT EXISTS vwBrowsSupp AS Select A.KODECUSTSUPP, A.NAMACUSTSUPP, A.ALAMAT1, A.ALAMAT2, 

       case when isnull(A.Alamat2,'')='' then A.Alamat1 else A.Alamat1+char(13)+A.Alamat2  Alamat,

    	 A.kota kodeKota,  A.Kota, 

	    A.TELPON, A.FAX, A.EMAIL, A.KODEPOS, A.NEGARA, A.NPWP, A.Tanggal, A.PLAFON, A.HARI, A.HARIHUTPIUT, 

	    A.BERIKAT, A.USAHA, D.PERKIRAAN, A.JENIS, A.NAMAPKP, A.ALAMATPKP1, A.ALAMATPKP2, A.KOTAPKP, A.Sales, A.KodeVls, A.KodeTipe, A.IsPpn,

	    A.Agent,case when isnull(A.Alamat2,'')='' then A.Alamat1A else A.Alamat1A+char(13)+A.Alamat2A  AlamatA,

	    A.KotaA, A.NegaraA, A.ContactP, B.IsBeliJual, B.IsLokalorExim,

	    C.Keterangan NamaPerkiraan,A.IsAktif

From 	dbo.DBCUSTSUPP A

      Left Outer join (select * from DBPERKCUSTSUPP where KodecustSupp+CONVERT(Varchar(2),Urut) in( select KodecustSupp+Convert(Varchar(2),MIN(urut))Urut from DBPERKCUSTSUPP Group By KODECUSTSUPP)) D on D.KodeCustSupp=A.KODECUSTSUPP 

      Left Outer Join dbo.DBPOSTHUTPIUT B on B.Perkiraan=D.PERKIRAAN

      Left Outer Join dbo.DBPERKIRAAN C on C.Perkiraan=B.PERKIRAAN

where  B.Kode='HT';

-- vwCashBack
CREATE VIEW IF NOT EXISTS vwCashBack AS select d.AlamatKirim KodeProject,d.KODECUST,e.NAMAPROJECT,f.NAMACUSTSUPP,d.TANGGAL,a.KodeBrg,

Brg.NAMABRG,(c.Qnt) QntSO,c.HARGA HrgSO,Sum(a.QNT) qntKirim,c.HARGA*Sum(a.QNT) Tot,c.Komisi,c.HARGA-Case when c.Komisi=0 Then c.HARGA else c.Komisi    selisih,(c.HARGA-Case when c.Komisi=0 Then c.HARGA else c.Komisi )*(c.Qnt) TotCashBack

from dbSPBDet a

Left Outer Join(Select NOBUKTI,NoSO,KODEBRG from dbSPPDet Group By NOBUKTI,NoSO,KODEBRG)b on b.NoBukti=a.NoSPP and b.KodeBrg=a.KodeBrg

Left Outer Join (select NOBUKTI,KODEBRG,Qnt2SisaSO Komisi,HARGA,SUM(Qnt)Qnt from DBSODET Group By NOBUKTI,KODEBRG,HARGA,Qnt2SisaSO) c on c.NOBUKTI=b.NoSO and c.KODEBRG=a.KodeBrg

Left Outer Join DBSO d on d.NOBUKTI=c.NOBUKTI

Left Outer Join DBBARANG Brg on Brg.KODEBRG=a.KodeBrg

Left Outer Join DBPROJECT e on e.KODEPROJECT=d.AlamatKirim

Left Outer Join DBCUSTSUPP f on f.KODECUSTSUPP=d.KODECUST

where a.NoBukti in(Select NoBukti from dbSPBDet where KODEBRG Like '%PC%')

Group by d.AlamatKirim,d.KODECUST,e.NAMAPROJECT,f.NAMACUSTSUPP,d.TANGGAL,

Brg.NAMABRG,c.HARGA,c.HARGA,c.Komisi,c.Qnt,a.KodeBrg;

-- vwCetakContractReview
CREATE VIEW IF NOT EXISTS vwCetakContractReview AS select a.nobukti,b.tanggal,b.KodecustSupp,a.KodeBrg,a.NAMABRG,e.Jns_Kertas,e.Ukr_Kertas,e.gsm,

case when a.Nosat=1 then c.Qnt 

     else c.Qnt2 

 jumlahkirim,

case when c.Nosat=1 then c.Sat_1

     when c.Nosat=2 then c.Sat_2 

     else ''

 Satuan,a.Nosat,c.TGLKirim,a.Sistem_Kemasan_IsKarton,

a.Sistem_Kemasan_IsPalet,a.Sistem_Kemasan_IsKarton_Palet,a.Sistem_Kemasan_IsBungkus,

a.Sistem_Kemasan_IsBungkus_Palet,a.Sticker,a.Isi_Kemasan,a.Ketentuan_Berat_IsTeori,

a.Ketentuan_Berat_IsTimbang,a.Jenis_isPlastik,a.Jenis_isKarton,a.Diameter_Inside_120mm,

a.Diameter_Inside_152mm,a.Diameter_Inside_76mm,a.Tebal_14mm_152mm,a.Tebal_14mm_76mm,

a.Tebal_15mm,a.Tebal_Lain,a.Tebal_lain2,a.Warna_YellowA,a.Warna_YellowB,a.Warna_Lain,a.Warna_Lain2,

a.Arah_Putaran_WI,a.Arah_Putaran_WO,a.Jum_Ukuran_Cont,a.Jum_Kemasan,a.Ship_Mark,

a.NamaBrg Namabrgkom, c.Keterangan, A.Urut,

Case when d.USAHA<>'' then d.USAHA+'. ' else '' +d.NAMACUSTSUPP NamaCustsupp,

       d.Alamat+CAse when d.Kota<>'' then CHAR(13)+d.Kota else '' +

       Case when d.NEGARA<>'' then CHAR(13)+d.NEGARA else ''  Alamat     

from dbContractReviewDet a 

left outer join dbContractReview b on a.NoBukti = b.nobukti

left outer join DBContractReviewKIRIM c on a.NoBukti = c.NoCR and c.UrutCR=a.Urut

left outer join vwBrowsCust d on b.KodecustSupp = d.KODECUSTSUPP

left outer join DBBARANGJADI e on a.KodeBrg =  e.KODEBRG



--where a.nobukti ='ENQ/0111/00002/SZZ';

-- vwcetakenquiry
CREATE VIEW IF NOT EXISTS vwcetakenquiry AS select a.nobukti,b.nourut,b.tanggal,

case when b.islokal=0 then 'LOKAL' else 'EXPORT'  as penjualan,

b.kodecustsupp,c.namacustsupp,a.KodeBrg,a.Namabrg,d.Jns_Kertas,d.Ukr_Kertas,d.GSM,

a.Sat_1,a.Qnt,a.Sat_2,a.Qnt2

from dbenquirydet a 

left outer join DBENQUIRY b on a.NoBukti = b.NoBukti

left outer join vwBrowsCust c on b.KodeCustSupp=c.KODECUSTSUPP

left outer join DBBARANGJADI d on a.KodeBrg = d.KODEBRG



--where a.nobukti ='ENQ/0111/00002/SZZ';

-- vwCetakInvoicePL
CREATE VIEW IF NOT EXISTS vwCetakInvoicePL AS Select A.NoBukti, A.NoUrut, A.Tanggal, A.PPN, A.Valas, A.Kurs, A.KodeCustSupp, A.Consignee, A.NotifyParty, A.StuffingDate, 

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

       B.Kodebrg,B.Namabrg NamaBrgkom,

       Sum(Case when B.NOSAT=1 then B.QNT

            when B.NOSAT=2 then B.QNT2

            else 0

       ) Qty,

      (Case when B.NOSAT=1 then B.Sat_1

            when B.NOSAT=2 then B.Sat_2

            else ''

       ) Satuan,Sum(B.Qnt) Qnt, Sum(B.Qnt2) Qnt2, B.Sat_1,B.Sat_2,B.Nosat,B.Harga,

       Sum(B.NDPP) NDPP, Sum(B.NDPPRp) NDPPRp, Sum(B.NPPN) NPPN, Sum(B.NPPNRp) NPPnRp, Sum(B.NNET) Nnet, Sum(B.NNETRp) NnetRp,

       B.ShippingMark, B.KetDetail, B.NetW, B.GrossW, B.Meas,

       E.Namabrg,       

       Case when C.USAHA<>'' then C.USAHA+'. ' else '' +C.NAMACUST NamaCustSupp,

       C.Alamat,C.kodekota Kota,C.USAHA,'' NEGARA, C.TELPON, '' FAX, '' EMAIL,

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

	    BulanETADestination, B.Urut

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

     left outer join vwBrowsCustomer c on c.KODECUST=A.KodeCustSupp and c.Sales=H.KODESLS

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

       B.Kodebrg,B.Namabrg,B.NOSAT, B.SAT_1, B.SAT_2, B.Harga,

       

       B.ShippingMark, B.KetDetail, B.NetW, B.GrossW, B.Meas,

       E.Namabrg,       

       Case when C.USAHA<>'' then C.USAHA+'. ' else '' +C.NAMACUST,

       C.Alamat,C.kodeKota,C.USAHA, C.TELPON, B.Urut,

      

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

	        else '';

-- vwCetakInvoicePLLampiran
CREATE VIEW IF NOT EXISTS vwCetakInvoicePLLampiran AS Select a.Nobukti, a.Urut, a.Keterangan, a.KodeVls, a.Kurs, a.Harga, a.NNet

from DBInvoicePLLampiran a;

-- vwcetakquotation
CREATE VIEW IF NOT EXISTS vwcetakquotation AS select a.nobukti,b.kodecustsupp,b.Term_of_Payment, b.Packing,b.Delivery,b.Price_Validity,

       Case when z.USAHA<>'' then z.USAHA+'. ' else '' + z.NAMACUSTSUPP NamaCustSupp,      

       z.contactp,a.kodebrg,x.NAMABRG,x.Ukr_Kertas,x.Jns_Kertas,

       a.Sat_1 sat1det,a.Sat_2 sat2det,a.Nosat nosatdet,a.Qnt qntdet,a.Qnt2 qnt2det,

       c.Qnt qntkirim, c.TGLKirim tglkirim,A.harga,

       case when c.Nosat = 1 then Case when c.Nosat is not null then c.qnt else a.Qnt 

            when c.Nosat = 2 then Case when c.Nosat is not null then c.Qnt2 else a.Qnt2 

        Unit,

       case when c.Nosat = 1 then Case when c.Nosat is not null then c.Sat_1 else a.Sat_1 

            when c.Nosat = 2 then Case when c.Nosat is not null then c.Sat_2 else a.Sat_2 

        Satuan,

       case when c.Nosat = 1 then Case when c.Nosat is not null then c.qnt else a.Qnt 

            when c.Nosat = 2 then Case when c.Nosat is not null then c.Qnt2 else a.Qnt2 

       *a.Harga jumlah, A.Namabrg NamabrgKom,

       B.Tanggal, C.Keterangan,

       Case when z.USAHA<>'' then z.USAHA+'. ' else '' +z.NAMACUSTSUPP NamaCustomer,

       z.Alamat+CAse when z.Kota<>'' then CHAR(13)+z.Kota else '' +

       Case when z.NEGARA<>'' then CHAR(13)+z.NEGARA else ''  Alamat,

       B.Note_Quotation

from dbquotationdet a 

LEFT outer join dbQuotation b on a.Nobukti = b.Nobukti

left outer join vwBrowsCust z on b.KodecustSupp = z.KODECUSTSUPP

left outer join DBBARANGJADI x on a.KodeBrg = x.KODEBRG

left outer join DBQuotationKIRIM c on a.Nobukti = c.NoQuo and c.urutQuo=a.Urut



--where a.nobukti ='ENQ/0111/00002/SZZ';

-- vwCetakRPJ
CREATE VIEW IF NOT EXISTS vwCetakRPJ AS Select A.NOBUKTI, A.TANGGAL, B.NamaBrg,'' Ukr_Kertas,0.00 GSM, A.NoSO, A.TglSO, A.NoLKP, A.TGLLKP,

       B.NoSPB,d.Tanggal TglSPB, A.KODECUSTSUPP, C.NamaCust NAMACUSTSUPP, null TglRencanaPenarikan, null TglPengesahan,

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

     left outer join (Select x0.NoBukti, x0.Urut, z.Tanggal, z.NoBukti NoSPB, x1.KODESLS, x1.KODECUST

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

     left outer join vwBrowsCustomer C on C.KODECUST=A.KODECUSTSUPP and C.Sales=d.KODESLS;

-- vwCetakRSPB
CREATE VIEW IF NOT EXISTS vwCetakRSPB AS --select * from DBSPBreturdet

--select * from DBrSPBdet



select A.NOBUKTI, A.NOURUT, A.TANGGAL, A.KODECUSTSUPP, 

       Case when D.USAHA<>'' then D.USAHA+'. ' else '' +D.NamaCust NamaCustSupp, 

       D.Alamat, D.NamaKota Kota, '' NEGARA,

        A0.NoSPP, A.NoPolKend,

        A.Container, A.NoContainer, A.NoSeal,

        A.ISCETAK, A.IDUser,

        B.URUT, B.KODEBRG, C.Namabrg, '' Jns_Kertas,'' Ukr_Kertas, B.QNT, B.QNT2, B.SAT_1, B.SAT_2, B.NoSat, B.ISI,

        Ax.UrutSPP, E.NoSO,E.TglSO,E.NOPO NoPesanan, A1.NamaKirim, A1.AlamatKirim,

        (Select NOSPB from DBNOMOR) NODOK, B.Namabrg NamaBrgkom,

         case when B.NOSAT = 1 then b.SAT_1 else b.SAT_2  as satuanas,

         case when B.NOSAT = 1 then B.QNT else b.QNT2  as QNTAS,

        A.Catatan, b.NetW, b.GrossW, A0.sopir

From DBRSPB A

left outer join dbSPB A0 on a.NoSPB = a0.NoBukti

left outer join dbSPBDet ax on a0.NoBukti = ax.NoBukti

left outer join dbSPP A1 on A1.NoBukti=A0.NoSPP

Left Outer Join (Select Nobukti, NoSO from dbSPPDet Group by NoBukti,NoSO) A2 on A2.NoBukti=A1.nobukti

Left Outer Join DBRSPBDET B on B.NoBukti=A.NoBukti

Left Outer Join dbBarang c On C.KodeBrg=B.KodeBrg

Left Outer Join vwBrowsCustomer D On D.KodeCust=A.KodeCustSupp

Left Outer join (Select y.Nobukti NoSO,y.Tanggal TglSO, y.NoPesanan Nopo

                 from DBSO y

                 group by y.Nobukti,y.Tanggal, y.NoPesanan) E on E.NoSO=A2.NoSo;

-- vwCetakRSpbLampiran
CREATE VIEW IF NOT EXISTS vwCetakRSpbLampiran AS Select Case when A.NOROLL<>'' then A.NOROLL+' ' else '' +

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

-- vwCetakSalesContract
CREATE VIEW IF NOT EXISTS vwCetakSalesContract AS select a.nobukti,a.kodebrg,e.NAMABRG,b.Tanggal as tanggal,b.KodecustSupp,b.islokal,

       d.NAMAPKP NAMACUSTSUPP,

       a.Qnt qntdet,a.Qnt2 as qnt2det,

       b.Term_of_Payment,b.ACC_NO,b.Swift_Code,b.Shipment_Time,b.Last_Shipment_Time,b.Packing,       

       b.Consignee, b.Notify_Party, b.Port_of_Loading, b.Port_of_Discharge, b.TransShipment, b.Partial_Shipment,

       a.Ship_Mark, b.Remarks, c.Qnt qntkirim,

       c.Qnt2 qntkirim2,a.Harga HargaDet,a.Nosat,a.ppn,

       Case when c.NoSC is null then Case when a.Nosat=1 then a.Qnt

                                          when a.Nosat=2 then a.Qnt2

                                          else 0

                                     

            else Case when c.Nosat=1 then c.Qnt

                      when c.nosat=2 then c.qnt2

                      else 0

                 

        kuantitas,

       Case when c.NoSC is null then Case when a.Nosat=1 then a.Sat_1

                                          when a.Nosat=2 then a.Sat_2

                                          else ''

                                     

            else Case when c.Nosat=1 then c.Sat_1

                      when c.nosat=2 then c.Sat_2

                      else ''

                 

        Satuan,

       Case when c.NoSC is null then Case when a.Nosat=1 then a.Qnt

                                          when a.Nosat=2 then a.Qnt2

                                          else 0

                                     

            else Case when c.Nosat=1 then c.Qnt

                      when c.nosat=2 then c.qnt2

                      else 0

                 

       *a.harga SubTotal,

       Case when c.NoSC is null then Case when a.Nosat=1 then a.Qnt

                                          when a.Nosat=2 then a.Qnt2

                                          else 0

                                     

            else Case when c.Nosat=1 then c.Qnt

                      when c.nosat=2 then c.qnt2

                      else 0

                 

       *a.harga*a.Kurs SubTotalRp,

       (Case when a.PPn in (1) then Case when c.NoSC is null then Case when a.Nosat=1 then a.Qnt

                                                                        when a.Nosat=2 then a.Qnt2

                                                                        else 0

                                                                   

                                          else Case when c.Nosat=1 then c.Qnt

                                                    when c.nosat=2 then c.qnt2

                                                    else 0

                                               

                                     *a.Harga

            when a.PPn=2 then(Case when c.NoSC is null then Case when a.Nosat=1 then a.Qnt

                                                                 when a.Nosat=2 then a.Qnt2

                                                                 else 0

                                                            

                                   else Case when c.Nosat=1 then c.Qnt

                                             when c.nosat=2 then c.qnt2

                                             else 0

                                               

                              *a.Harga)/1.1

            else 0

       *0.1)*0.001 PPh,

       (Case when a.PPn in (1) then Case when c.NoSC is null then Case when a.Nosat=1 then a.Qnt

                                                                        when a.Nosat=2 then a.Qnt2

                                                                        else 0

                                                                   

                                          else Case when c.Nosat=1 then c.Qnt

                                                    when c.nosat=2 then c.qnt2

                                                    else 0

                                               

                                     *a.Harga

            when a.PPn=2 then(Case when c.NoSC is null then Case when a.Nosat=1 then a.Qnt

                                                                 when a.Nosat=2 then a.Qnt2

                                                                 else 0

                                                            

                                   else Case when c.Nosat=1 then c.Qnt

                                             when c.nosat=2 then c.qnt2

                                             else 0

                                               

                              *a.Harga)/1.1

            else 0

       *0.1*a.Kurs)*0.001 PPhRp,

       Case when a.PPn in (0,1) then Case when c.NoSC is null then Case when a.Nosat=1 then a.Qnt

                                                                        when a.Nosat=2 then a.Qnt2

                                                                        else 0

                                                                   

                                          else Case when c.Nosat=1 then c.Qnt

                                                    when c.nosat=2 then c.qnt2

                                                    else 0

                                               

                                     *a.Harga

            when a.PPn=2 then(Case when c.NoSC is null then Case when a.Nosat=1 then a.Qnt

                                                                 when a.Nosat=2 then a.Qnt2

                                                                 else 0

                                                            

                                   else Case when c.Nosat=1 then c.Qnt

                                             when c.nosat=2 then c.qnt2

                                             else 0

                                               

                              *a.Harga)/1.1

            else 0

        nDPP,

	    Case when a.PPn in (0,1) then Case when c.NoSC is null then Case when a.Nosat=1 then a.Qnt

                                                                        when a.Nosat=2 then a.Qnt2

                                                                        else 0

                                                                   

                                          else Case when c.Nosat=1 then c.Qnt

                                                    when c.nosat=2 then c.qnt2

                                                    else 0

                                               

                                     *a.Harga

            when a.PPn=2 then(Case when c.NoSC is null then Case when a.Nosat=1 then a.Qnt

                                                                 when a.Nosat=2 then a.Qnt2

                                                                 else 0

                                                            

                                   else Case when c.Nosat=1 then c.Qnt

                                             when c.nosat=2 then c.qnt2

                                             else 0

                                               

                              *a.Harga)/1.1

            else 0

       *a.Kurs nDPPRp,

	    Case when a.PPn in (1) then Case when c.NoSC is null then Case when a.Nosat=1 then a.Qnt

                                                                        when a.Nosat=2 then a.Qnt2

                                                                        else 0

                                                                   

                                          else Case when c.Nosat=1 then c.Qnt

                                                    when c.nosat=2 then c.qnt2

                                                    else 0

                                               

                                     *a.Harga

            when a.PPn=2 then(Case when c.NoSC is null then Case when a.Nosat=1 then a.Qnt

                                                                 when a.Nosat=2 then a.Qnt2

                                                                 else 0

                                                            

                                   else Case when c.Nosat=1 then c.Qnt

                                             when c.nosat=2 then c.qnt2

                                             else 0

                                               

                              *a.Harga)/1.1

            else 0

       *0.1 nPPn,

	    (Case when a.PPn in (1) then Case when c.NoSC is null then Case when a.Nosat=1 then a.Qnt

                                                                        when a.Nosat=2 then a.Qnt2

                                                                        else 0

                                                                   

                                          else Case when c.Nosat=1 then c.Qnt

                                                    when c.nosat=2 then c.qnt2

                                                    else 0

                                               

                                     *a.Harga

            when a.PPn=2 then(Case when c.NoSC is null then Case when a.Nosat=1 then a.Qnt

                                                                 when a.Nosat=2 then a.Qnt2

                                                                 else 0

                                                            

                                   else Case when c.Nosat=1 then c.Qnt

                                             when c.nosat=2 then c.qnt2

                                             else 0

                                               

                              *a.Harga)/1.1

            else 0

       *0.1)*a.Kurs nPPnRp,

       Case when a.PPn in (0,1) then Case when c.NoSC is null then Case when a.Nosat=1 then a.Qnt

                                                                        when a.Nosat=2 then a.Qnt2

                                                                        else 0

                                                                   

                                          else Case when c.Nosat=1 then c.Qnt

                                                    when c.nosat=2 then c.qnt2

                                                    else 0

                                               

                                     *a.Harga

            when a.PPn=2 then(Case when c.NoSC is null then Case when a.Nosat=1 then a.Qnt

                                                                 when a.Nosat=2 then a.Qnt2

                                                                 else 0

                                                            

                                   else Case when c.Nosat=1 then c.Qnt

                                             when c.nosat=2 then c.qnt2

                                             else 0

                                               

                              *a.Harga)/1.1

            else 0

       +(

       Case when a.PPn in (1) then Case when c.NoSC is null then Case when a.Nosat=1 then a.Qnt

                                                                        when a.Nosat=2 then a.Qnt2

                                                                        else 0

                                                                   

                                          else Case when c.Nosat=1 then c.Qnt

                                                    when c.nosat=2 then c.qnt2

                                                    else 0

                                               

                                     *a.Harga

            when a.PPn=2 then(Case when c.NoSC is null then Case when a.Nosat=1 then a.Qnt

                                                                 when a.Nosat=2 then a.Qnt2

                                                                 else 0

                                                            

                                   else Case when c.Nosat=1 then c.Qnt

                                             when c.nosat=2 then c.qnt2

                                             else 0

                                               

                              *a.Harga)/1.1

            else 0

       *0.1)+((

       Case when a.PPn in (1) then Case when c.NoSC is null then Case when a.Nosat=1 then a.Qnt

                                                                        when a.Nosat=2 then a.Qnt2

                                                                        else 0

                                                                   

                                          else Case when c.Nosat=1 then c.Qnt

                                                    when c.nosat=2 then c.qnt2

                                                    else 0

                                               

                                     *a.Harga

            when a.PPn=2 then(Case when c.NoSC is null then Case when a.Nosat=1 then a.Qnt

                                                                 when a.Nosat=2 then a.Qnt2

                                                                 else 0

                                                            

                                   else Case when c.Nosat=1 then c.Qnt

                                             when c.nosat=2 then c.qnt2

                                             else 0

                                               

                              *a.Harga)/1.1

            else 0

       *0.1)*0.001) jumlah,

	    (Case when a.PPn in (0,1) then Case when c.NoSC is null then Case when a.Nosat=1 then a.Qnt

                                                                        when a.Nosat=2 then a.Qnt2

                                                                        else 0

                                                                   

                                          else Case when c.Nosat=1 then c.Qnt

                                                    when c.nosat=2 then c.qnt2

                                                    else 0

                                               

                                     *a.Harga

            when a.PPn=2 then(Case when c.NoSC is null then Case when a.Nosat=1 then a.Qnt

                                                                 when a.Nosat=2 then a.Qnt2

                                                                 else 0

                                                            

                                   else Case when c.Nosat=1 then c.Qnt

                                             when c.nosat=2 then c.qnt2

                                             else 0

                                               

                              *a.Harga)/1.1

            else 0

       +(

       Case when a.PPn in (1) then Case when c.NoSC is null then Case when a.Nosat=1 then a.Qnt

                                                                        when a.Nosat=2 then a.Qnt2

                                                                        else 0

                                                                   

                                          else Case when c.Nosat=1 then c.Qnt

                                                    when c.nosat=2 then c.qnt2

                                                    else 0

                                               

                                     *a.Harga

            when a.PPn=2 then(Case when c.NoSC is null then Case when a.Nosat=1 then a.Qnt

                                                                 when a.Nosat=2 then a.Qnt2

                                                                 else 0

                                                            

                                   else Case when c.Nosat=1 then c.Qnt

                                             when c.nosat=2 then c.qnt2

                                             else 0

                                               

                              *a.Harga)/1.1

            else 0

       *0.1)+

       ((Case when a.PPn in (1) then Case when c.NoSC is null then Case when a.Nosat=1 then a.Qnt

                                                                        when a.Nosat=2 then a.Qnt2

                                                                        else 0

                                                                   

                                          else Case when c.Nosat=1 then c.Qnt

                                                    when c.nosat=2 then c.qnt2

                                                    else 0

                                               

                                     *a.Harga

            when a.PPn=2 then(Case when c.NoSC is null then Case when a.Nosat=1 then a.Qnt

                                                                 when a.Nosat=2 then a.Qnt2

                                                                 else 0

                                                            

                                   else Case when c.Nosat=1 then c.Qnt

                                             when c.nosat=2 then c.qnt2

                                             else 0

                                               

                              *a.Harga)/1.1

            else 0

       *0.1)*0.001))*a.kurs jumlahRp,

        d.AlamatPKP+Case when d.KOTAPKP<>'' then CHAR(13)+d.KOTAPKP else ''  Alamat,

       c.Keterangan, a.NamaBrg NamabrgKom,a.Urut,

       a.Harga

from dbSalesContractdet a 

left outer join dbSalesContract b on a.Nobukti = b.Nobukti

left outer join DBSalesContractKIRIM c on a.Nobukti = c.NoSC and c.urutSC=a.Urut

left outer join vwBrowsCust d on b.KodecustSupp = d.KODECUSTSUPP

left outer join DBBARANGJADI e on a.Kodebrg = e.KODEBRG;

-- vwCetakSPB
CREATE VIEW IF NOT EXISTS vwCetakSPB AS select A.NOBUKTI, A.NOURUT, A.TANGGAL, A.KODECUSTSUPP, 

       Case when D.USAHA<>'' then D.USAHA+'. ' else '' +D.NamaCustSupp NamaCustSupp, 

       D.Alamat, D.Kota, D.NEGARA,

        A.NOSPP, A.NoPolKend,

        A.Container, A.NoContainer, A.NoSeal,

        A.ISCETAK, A.IDUser,

        B.URUT, B.KODEBRG, C.NamaBrg Namabrg, '' Jns_Kertas, ''Ukr_Kertas, B.QNT, B.QNT2, B.SAT_1, B.SAT_2, B.NoSat, B.ISI,

        B.UrutSPP, E.Nobukti Noso,E.TglSO,E.NOPO NoPesanan, A1.NamaKirim, A1.AlamatKirim,

        (Select NOSPB from DBNOMOR) NODOK, B.Namabrg NamaBrgkom,

        case when B.NOSAT = 1 then b.SAT_1 else b.SAT_2  as satuanas,

        case when B.NOSAT = 1 then B.QNT else b.QNT2  as QNTAS,

        A.Catatan

From DBSPB A

Left Outer Join DBSPBDET B on B.NoBukti=A.NoBukti

left outer join (Select  y.nobukti, y.tanggal, x.Urut, x.NoSO, x.UrutSO, y.NamaKirim, y.AlamatKirim

                 From dbSPPDet x

                      Left Outer join dbSPP y on y.nobukti=x.nobukti

                 )A1 on A1.NoBukti=B.NoSPP and A1.Urut=B.UrutSPP

Left Outer Join dbBarang c On C.KodeBrg=B.KodeBrg

Left Outer Join vwBrowsCust D On D.KodeCustSupp=A.KodeCustSupp

Left Outer join (Select x.Nobukti,y.Tanggal TglSO,'' Nopo, x.URUT

                 from DBSODET x      

                      Left Outer join DBSO y on y.NOBUKTI=x.NOBUKTI               

                 group by x.Nobukti, y.TANGGAL, x.URUT) E on E.Nobukti=A1.NoSO and E.URUT=A1.UrutSO;

-- vwCetakSpbLampiran
CREATE VIEW IF NOT EXISTS vwCetakSpbLampiran AS Select Case when A.NOROLL<>'' then A.NOROLL+' ' else '' +

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

       (Select NoSPB from dbnomor) NODok, b.NoSPP

From dbSPBLampiran A

     left Outer join (Select y.NoBukti, Y.Tanggal, y.NoContainer, y.NoPolKend, y.NoSeal,

                             x.Urut, x.KodeBrg, x.Namabrg, x.NoSPP

                      from dbSPBDet x

                           left Outer join dbSPB y on y.NoBukti=x.NoBukti

                     ) B on B.NoBukti=A.NoSPB and B.Urut=A.UrutSPB

     left Outer join (Select kodebrg, namabrg, SAT1, Sat2, '' Jns_Kertas, '' Ukr_Kertas, 0.00 GSM from DBBARANG) C on C.KODEBRG=B.KodeBrg;

-- vwcetakSPBRjual
CREATE VIEW IF NOT EXISTS vwcetakSPBRjual AS select A.NOBUKTI, A.NOURUT, A.TANGGAL, A.KODECUSTSUPP, D.NamaCust NamaCustSupp, D.Alamat, D.NamaKota Kota,

        A1.NOSC, A.NORPJ, A.NoPolKend,

        A.Container, A.NoContainer, A.NoSeal,

        A.ISCETAK, A.IDUser,

        B.URUT, B.KODEBRG, C.NamaBrg, '' Jns_Kertas, '' Ukr_Kertas, case when B.ISI>=1 Then B.QNT Else B.QNT2  QNT, case when B.ISI>=1 Then B.QNT2 Else B.QNT  QNT2, case when B.ISI>=1 Then B.SAT_1 Else B.SAT_2  SAT_1, case when B.ISI>=1 Then B.SAT_2 Else B.SAT_1  SAT_2, B.NoSat, B.ISI,

        B.UrutRPJ, B.netW, b.GrossW, B.Namabrg Namabrgkom, 0.00 GSM,

        B.NoBukti+Cast(B.urut as varchar(5)) Mykey,a.Catatan, A.Sopir, C.nFix,

        /*Case when B.Nosat=1 then B.Qnt

             when B.Nosat=2 then B.Qnt2

             else 0.00

         Qnt,

        Case when B.Nosat=1 then B.sat_1

             when B.Nosat=2 then B.Sat_2

             else ''

         Satuan,*/  B.kodegdg,A1.NoInvoice,

         Case When c.ISI2>c.ISI1 Then c.SAT1 when c.ISI2=c.ISI1 Then c.SAT1 else c.SAT2  SA_1,Case When c.ISI2<c.ISI1 Then c.SAT1 WHEN c.ISI2=c.ISI1 Then c.SAT2 else c.SAT2  SA_2,

         A1.NAMAPROJECT

From DBSPBRJual A

left outer join (Select x.NOBUKTI NoBukti , Y.Nobukti NoInvoice, z2.NoBukti NoSC,z3.KODESLS,Pr.NAMAPROJECT

                 from dbRInvoicePLDet x

                      Left outer join dbinvoicePLDet y on Y.nobukti=x.NoInvoice and y.Urut=x.UrutInvoice

                      left Outer join dbSPBDet z on z.nobukti=y.NoSPB and z.urut=y.UrutSPB

                      left Outer join dbSPPDet z1 on z1.NoBukti=z.NoSPP and z1.Urut=z.UrutSPP

                      left Outer join DBSODET z2 on z2.nobukti=z1.noso and z2.urut=z1.UrutSO

                      left Outer join DBSO z3 on z3.NOBUKTI=z2.NOBUKTI

                      Left Outer Join DBPROJECT pr on Pr.KODEPROJECT=z3.AlamatKirim

                 Group by x.NOBUKTI,Y.NoBukti,z2.NOBUKTI, z3.KODESLS,Pr.NAMAPROJECT

                 ) A1 on A1.NoBukti=A.NoRPJ

Left Outer Join DBSPBRJualDET B on B.NoBukti=A.NoBukti

Left Outer Join dbBarang c On C.KodeBrg=B.KodeBrg

Left Outer Join vwBrowsCustomer D On D.KodeCust=A.KodeCustSupp --and D.Sales=A1.KODESLS

--where a.NoBukti=@NoBukti

--order By B.Urut;

-- vwCetakSPP
CREATE VIEW IF NOT EXISTS vwCetakSPP AS select a.NoBukti,a.NoSO NoSC,b.NoPesan,b.Tanggal,a.KodeBrg,d.NAMABRG namabrgdbbrg ,a.NamaBrg namabrgdbdet ,''Jns_Kertas,''Ukr_Kertas,

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

left outer join DBBARANG d on a.KodeBrg = d.KODEBRG;

-- vwCrossCheckBPPB
CREATE VIEW IF NOT EXISTS vwCrossCheckBPPB AS Select *

from (Select x.Nobukti BPPB_Nobukti, x.Tanggal BPPB_Tanggal, x.Kodebag BPPB_kodebag, x.kodeBiaya BPPB_Kodebiaya, 

             x.SOP BPPB_SOP, x.KodeMesin BPPB_Kodemesin, x.KodeJnsPakai BPPB_KodejnsPakai, 

             x.JnsKertas BPPB_jnsKertas, x.IDUSER BPPB_IDUser, 

             x.JnsPakai BPPB_jnsPakai, x.Perk_Investasi BPPB_PerkInvestasi, x.Kodegdg BPPB_kodegdg,

             y.urut BPPB_Urut, y.kodebrg BPPB_kodebrg, y.Sat_1 BPPB_Sat_1 , y.Sat_2 BPPB_Sat_2 , y.Nosat BPPB_Nosat, 

             Case when y.Nosat=1 then y.Qnt 

                  when y.Nosat=2 then y.Qnt2

                  else 0

              BPPB_Qty,

             Case when y.Nosat=1 then y.Sat_1

                  when y.Nosat=2 then y.Sat_2

                  else ''

              BPPB_Satuan,

             y.Isi BPPB_Isi, y.Qnt BPPB_Qnt, y.Qnt2 BPPB_Qnt2, y.TglTiba BPPB_TglTiba, 

             y.TglButuh BPPB_TglButuh, y.MyID BPPB_MyID, y.isInspeksi BPPB_isInspeksi, 

             y.Keterangan BPPB_Keterangan, y.QntBtl BPPB_QntBatal, y.Qnt2Btl BPPB_Qnt2Btl, 

             y.UrutTrans BPPB_UrutTrans, y.HPP BPPB_HPP, y.Nnet BPPB_Nnet,

             Case when x.JnsPakai=0 then 'Stock'

                  when x.JnsPakai=1 then 'Investasi'

                  when x.JnsPakai=2 then 'Rep & Pem Teknik'

                  when x.JnsPakai=3 then 'Rep & Pem Komputer'

                  when x.JnsPakai=4 then 'Rep & Pem Peralatan'

              BPPB_MyJnsPakai,

             z.*                      

      from DBPermintaanBrg x

           left Outer join DBPermintaanBrgDET y on y.Nobukti=x.Nobukti

           left Outer join (Select x.Nobukti BBPPB_Nobukti, x.Tanggal BBPPB_Tanggal,

                                   y.urut BBPPB_urut,y.kodebrg BBPPB_Kodebrg, 

											  Case when y.Nosat=1 then y.Qnt 

										    		 when y.Nosat=2 then y.Qnt2

													 else 0

											   BBPPB_Qty,

											  Case when y.Nosat=1 then y.Sat_1

											 		 when y.Nosat=2 then y.Sat_2

													 else ''

											   BBPPB_Satuan,

											  y.Sat_1 BBPPB_Sat_1, y.Sat_2 BBPPB_Sat_2, 

											  y.Isi BBPPB_Isi, y.Nosat BBPPB_Nosat, y.Qnt BBPPB_Qnt, Y.Qnt2 BBPPB_Qnt2, 

											  Y.NoBPPB BBPPB_NoBPPB, Y.UrutBPPB BBPPB_UrutBPPB, 

											  y.Keterangan BBPPB_Keterangan, y.MyID BBPPB_MyID, y.UrutTrans BBPPB_UrutTrans, 

											  y.HPP BBPPB_HPP,y.nnet BBPPB_nNet

                      from DBBatalMintaBrg x

                      left Outer join DBBatalMintaBrgDET y on y.Nobukti=x.Nobukti) z on z.BBPPB_NoBPPB=x.Nobukti and z.BBPPB_UrutBPPB=y.urut) a                                                          

     left Outer join (Select x. Nobukti BPB_Nobukti, x.Tanggal BPB_Tanggal, 

                             x.Kodebag BPB_kodebag, x.kodeBiaya BPB_KodeBiaya, 

                             x.SOP BPB_SOP, x.KodeMesin BPB_KodeMesin, 

                             x.KodeJnsPakai BPB_KodeJnsPakai, x.JnsKertas BPB_JnsKertas, IDUser BPB_IDUSER, 

                             x.NoBPPB BPB_NOBPPB,x.JnsPakai BPB_JnsPakai, 

                             x.Perk_Investasi BPB_Perk_Investasi, x.Kodegdg BPB_Kodegdg,

                             y.urut BPB_Urut, y.kodebrg BPB_Kodebrg, 

                             Case when y.Nosat=1 then y.Qnt 

											 when y.Nosat=2 then y.Qnt2

									 		 else 0

									   BPB_Qty,

									  Case when y.Nosat=1 then y.Sat_1

									 		 when y.Nosat=2 then y.Sat_2

											 else ''

									   BPB_Satuan,

                             y.Sat_1 BPB_Sat_1, y.Sat_2 BPB_Sat_2, y.Nosat BPB_Nosat, 

                             y.Isi BPB_ISI, y.Qnt BPB_Qnt, y.Qnt2 BPB_Qnt2, 

                             y.TglTiba BPB_TglTiba, y.MyID BPB_MyID, 

                             y.NoPermintaan BPB_NoPermintaan, 

                             y.UrutPermintaan BPB_UrutPermintaan, 

                             y.IsInspeksi BPB_IsInspeksi, 

                             y.UrutTrans BPB_UrutTrans, y.KetDet BPB_KetDet, y.HPP BPB_HPP, Y.NNet BPB_NNet,

                             Case when x.JnsPakai=0 then 'Stock'

											 when x.JnsPakai=1 then 'Investasi'

											 when x.JnsPakai=2 then 'Rep & Pem Teknik'

											 when x.JnsPakai=3 then 'Rep & Pem Komputer'

											 when x.JnsPakai=4 then 'Rep & Pem Peralatan'

									   BPB_MyJnsPakai,

                             z.*

                      from DBPenyerahanBrg x

                      left Outer join DBPenyerahanBrgDET y on y.Nobukti=x.Nobukti

                      left outer join (Select x.Nobukti RBPB_Nobukti, x.Tanggal RBPB_Tanggal, x.Kodebag RBPB_KodeBag, 

															 x.kodeBiaya RBPB_Kodebiaya, x.SOP RBPB_SOP, x.KodeMesin RBPB_kodeMesin, x.KodeJnsPakai RBPB_KodeJnsPakai, 

															 x.JnsKertas RBPB_JnsKertas, x.IDUser RBPB_IDUSER,                             

															 x.JnsPakai RBPB_JnsPakai, x.Perk_Investasi RBPB_Perk_Investasi,

															 y.urut RBPB_urut, y.kodebrg RBPB_kodebrg, 

															 Case when y.Nosat=1 then y.Qnt 

																	 when y.Nosat=2 then y.Qnt2

									 								 else 0

															   RBPB_Qty,

															  Case when y.Nosat=1 then y.Sat_1

									 								 when y.Nosat=2 then y.Sat_2

																	 else ''

															   RBPB_Satuan,

															 y.Sat_1 RBPB_Sat_1, 

															 y.Sat_2 RBPB_Sat_2, y.Nosat RBPB_Nosat, y.Isi RBPB_isi, 

															 y.Qnt RBPB_qnt, y.Qnt2 RBPB_Qnt2, y.TglTiba RBPB_TglTiba, y.MyID RBPB_MyID, 

															 y.NoPenyerahan RBPB_NoPenyerahan, y.UrutPenyerahan RBPB_urutPenyerahan, 

															 y.IsInspeksi RBPB_IsInspeksi, y.UrutTrans RBPB_UrutTrans, y.KetDet RBPB_KetDet, 

															 y.HPP RBPB_HPP, y.NNet RBPB_NNet,

															 Case when x.JnsPakai=0 then 'Stock'

																	 when x.JnsPakai=1 then 'Investasi'

																	 when x.JnsPakai=2 then 'Rep & Pem Teknik'

																	 when x.JnsPakai=3 then 'Rep & Pem Komputer'

																	 when x.JnsPakai=4 then 'Rep & Pem Peralatan'

															   RBPB_MyJnsPakai

													from DBRPenyerahanBrg x

														  left outer join DBRPenyerahanBrgDET y on y.Nobukti=y.Nobukti)z on z.RBPB_NoPenyerahan=x.Nobukti and z.RBPB_urutPenyerahan=y.Urut) b on b.BPB_NoPermintaan=a.BPPB_Nobukti and b.BPB_UrutPermintaan=a.BPPB_Urut    

   left outer join (select  x.Nobukti PPL_Nobukti,x.Tanggal PPL_Tanggal, x.TglKirim PPL_TglKirim, 

                            x.IDUser PPL_IDUser, x.RefNoPermintaan PPL_RefNoPermintaan, x.RefBagPermintaan PPL_RefBagPermintaan, 

                            x.RefNamaBagPermintaan PPL_RefNamaBagPermintaan, x.RefTglPermintaan PPL_RefTglPermintaan,

                            y.urut PPL_urut, y.kodebrg PPL_kodebrg, 

                            Case when y.Nosat=1 then y.Qnt 

											 when y.Nosat=2 then y.Qnt2

									 		 else 0

									   PPL_Qty,

									  Case when y.Nosat=1 then y.Sat_1

									 		 when y.Nosat=2 then y.Sat_2

											 else ''

									   PPL_Satuan,y.Sat_1 PPL_Sat_1, y.Sat_2 PPL_Sat_2, y.Nosat PPL_Nosat, 

                            y.Isi PPL_isi, y.Qnt PPL_Qnt, y.Qnt2 PPL_Qnt2, y.TglTiba PPL_TglTiba, y.MyID PPL_MyId, 

                            y.NoPermintaan PPL_NoPermintaan, y.UrutPermintaan PPL_UrutPermintaan, y.Keterangan PPL_Keterangan, 

                            y.QntBtl PPL_QntBtl, y.Qnt2Btl PPL_Qnt2Btl, y.UrutTrans PPL_UrutTrans, y.Pelaksana PPL_Pelaksan, 

                            y.HPP PPL_HPP, Y.NNet PPL_NNet,

                            z.*

                    from DBPPL x

                         left outer join DBPPLDET y on y.Nobukti=x.Nobukti

                         left outer join (Select x.Nobukti BPL_Nobukti, x.Tanggal BPL_Tanggal, x.IDUser BPL_IDuser, 

                                                 y.urut BPL_urut, y.kodebrg BPL_Kodebrg, 

                                                 Case when y.Nosat=1 then y.Qnt 

																		 when y.Nosat=2 then y.Qnt2

									 									 else 0

																   BPL_Qty,

																  Case when y.Nosat=1 then y.Sat_1

									 									 when y.Nosat=2 then y.Sat_2

																		 else ''

																   BPL_Satuan,

                                                 y.Sat_1 BPL_Sat_1, 

                                                 y.Sat_2 BPL_Sat_2, y.Isi BPL_isi, y.Nosat BPL_nosat, 

                                                 y.Qnt BPL_Qnt, y.Qnt2 BPL_Qnt2, y.TglTiba BPL_TglTiba, y.MyID BPL_MyID, 

                                                 y.NoPPL BPL_NoPPL, y.UrutPPL BPL_UrutPPL, y.Keterangan BPL_Keterangan, 

                                                 y.NoBatalMintaBrg BPL_NoBatalMintaBrg, y.UrutBatalMintaBrg BPL_UrutBatalMintaBrg, 

                                                 y.UrutTrans BPL_UrutTrans,y.HPP BPL_HPP, y.NNet BPL_NNet

                                          from DBBatalPPL x

                                               left outer join DBBatalPPLDET y on y.Nobukti=x.Nobukti) z on z.BPL_NoPPL=x.Nobukti and z.BPL_UrutPPL=y.urut) c on c.PPL_NoPermintaan=a.BPPB_Nobukti and c.PPL_UrutPermintaan=a.BPPB_Urut

   left outer join (select x.NOBUKTI PO_Nobukti, x.TANGGAL PO_Tanggal, x.TglJatuhTempo PO_TgljatuhTempo, x.KODECUSTSUPP PO_kodecustsupp, 

                           x.RefInt PO_RefInt, x.RefVen PO_RefVendor, x.KODEVLS PO_Kodevls, x.KURS PO_Kurs, 

                           x.PPN PO_PPN, x.TIPEBAYAR PO_TipeBayar, x.HARI PO_Hari, x.TIPEDISC PO_TipeDisc, x.DISC PO_DISC, x.DISCRP PO_DISCRP, 

                           x.NILAIPOT PO_NilaiPot,x.NILAIDPP PO_NilaiDPP, x.NILAIPPN PO_NilaiPPN, 

                           x.NILAINET PO_NilaiNet, x.NILAIPOTRp PO_NilaiPotRp, x.NILAIDPPRp PO_NilaiDPPRp, x.NILAIPPNRp PO_NilaiPPnRp, 

                           x.NILAINETRp PO_NilaiNetRp, x.ISCETAK PO_IsCetak, x.Tipe PO_Tipe, x.IsLengkap PO_Lengkap, 

                           x.PPH PO_PPh, x.Freight PO_Freight, x.Lain2 PO_Lain2, x.IDUser PO_IDUser, 

                           x.RevisiKe PO_RevisiKe,x.TanggalPO PO_TanggalPO,  

                           y.URUT PO_Urut, y.NoPPL PO_NOPPL, y.UrutPPL PO_UrutPPL, 

                           y.KODEBRG PO_Kodebrg,

                           Case when y.Nosat=1 then y.Qnt 

											 when y.Nosat=2 then y.Qnt2

									 		 else 0

									   PO_Qty,

									  Case when y.Nosat=1 then y.Sat_1

									 		 when y.Nosat=2 then y.Sat_2

											 else ''

									   PO_Satuan,

                           y.QNT PO_Qnt, y.QNT2 PO_Qnt2, y.SAT_1 PO_Sat_1, y.SAT_2 PO_Sat_2, 

                           y.Nosat PO_Nosat, y.ISI PO_Isi, y.Toleransi PO_Toleransi, y.HARGA PO_Harga, 

                           y.DiscP1 PO_DiscP1, y.DiscRp1 PO_DiscRp1, y.DiscP2 PO_DiscP2, y.DiscRp2 PO_DiscRp2, 

                           y.DiscP3 PO_Discp3, y.DiscRp3 PO_DiscRp3, y.DiscP4 PO_DiscP4, y.DiscRp4 PO_DiscRp4, 

                           y.DISCTOT PO_DiscTot, y.HRGNETTO PO_HrgNetto, y.NDISKON PO_NDiskon, y.NDISKONTOT PO_NDiskonTot, 

                           y.BRUTTO PO_Brutto, y.SUBTOTAL PO_SubTotal, y.NDPP PO_NDPP, y.NPPN PO_NPPn, y.NNET PO_NNet,

                           y.SUBTOTALRp PO_SubTotalRp, y.NDPPRp PO_NdppRp, y.NPPNRp PO_nPPnRp, y.NNETRp PO_NnetRp, 

                           y.NOPO PO_NOPO, y.MyID PO_MyID, y.Catatan PO_Catatan, y.QntBtl PO_QntBtl, 

                           y.Qnt2Btl PO_Qnt2Btl, y.UrutTrans PO_UrutTrans, y.TglKirimPO PO_TglKirimPO,

                           z.*

                    from DBPO x

                         left outer join DBPODET y on y.NOBUKTI=x.NOBUKTI

                         left outer join (select  x.Nobukti BPO_NoBukti, x.Tanggal BPO_Tanggal, x.JenisBatal BPO_JenisBatal,

                                                  y.urut BPO_Urut, y.kodebrg BPO_kodebrg, 

                                                  Case when y.Nosat=1 then y.Qnt 

																		 when y.Nosat=2 then y.Qnt2

									 									 else 0

																   BPO_Qty,

																  Case when y.Nosat=1 then y.Sat_1

									 									 when y.Nosat=2 then y.Sat_2

																		 else ''

																   BPO_Satuan,

                                                  y.Sat_1 BPO_Sat_1, y.Sat_2 BPO_Sat_2, 

                                                  y.Nosat BPO_Nosat, y.Isi BPO_Isi, y.Qnt BPO_Qnt, y.Qnt2 BPO_Qnt2, 

                                                  y.MyID BPO_MyID, y.NoPO BPO_NoPO, y.UrutPO BPO_UrutPO, 

                                                  y.Keterangan BPO_Keterangan, y.UrutTrans BPO_UrutTans, 

                                                  y.HPP BPO_Hpp, y.NNet BPO_Nnet

                                          from DBBatalPO x

                                               left outer join DBBatalPODET y on y.Nobukti=x.Nobukti) z on z.BPO_NoPO=x.NOBUKTI and z.BPO_UrutPO=y.URUT) d on d.PO_NOPPL=c.PPL_Nobukti and d.PO_UrutPPL=c.PPL_urut;

-- vwCUSTSUPP
CREATE VIEW IF NOT EXISTS vwCUSTSUPP AS select	A.KODECUSTSUPP, A.NAMACUSTSUPP, A.ALAMAT1, A.ALAMAT2, A.Kota, 

A.TELPON, A.FAX, A.EMAIL, A.KODEPOS, A.NEGARA, A.NPWP, 

A.Tanggal, A.PLAFON, A.HARI, A.HARIHUTPIUT, A.BERIKAT, A.USAHA, 

A.PERKIRAAN, A.JENIS, A.NAMAPKP, A.ALAMATPKP1, A.ALAMATPKP2, A.KOTAPKP, 

A.Sales, A.KodeVls, A.KodeExp, A.KodeTipe, A.IsPpn, A.IsAktif, A.Kind, 

A.ContactP, A.Alamat1ContP, A.Alamat2ContP, A.KotaContP, A.NegaraContP, 

A.TelpContP, A.FaxContP, A.EmailContP, A.KODEPOSContP, A.HPContP, 

A.SyaratPenerimaan, A.SyaratPembayaran, A.Agent, A.Alamat1A, A.Alamat2A, 

A.KotaA, A.NegaraA, A.ContactA, A.TelpA, A.FaxA, A.EmailA, A.KODEPOSA, 

A.HPA, A.EmailContA, A.PortOfLoading, A.CountryOfOrigin, 

A.TglInput, A.iskontrak, A.PPN, A.HargaKe,

A.ALAMAT1+case when ltrim(A.Alamat2)='' then '' else CHAR(13)+A.ALAMAT2  ALAMAT,

A.ALAMAT1+case when ltrim(A.Alamat2)='' then '' else CHAR(13)+A.ALAMAT2 +CHAR(13)+A.Kota ALAMATKOTA,

A.Usaha+case when isnull(A.Usaha,'')='' then '' else '. ' +A.NamaCustSupp Nama,

A.ALAMATPKP1+case when ltrim(A.ALAMATPKP2)='' then '' else CHAR(13)+A.ALAMATPKP2  ALAMATPKP,

A.ALAMATPKP1+case when ltrim(A.ALAMATPKP2)='' then '' else CHAR(13)+A.ALAMATPKP2 +CHAR(13)+A.KOTAPKP ALAMATKOTAPKP,

case when A.iskontrak is null then 0 when A.iskontrak=0 then 0 when A.iskontrak=1 then 1  xKontrak,

cast('' as varchar(50)) NamaKota, cast('' as varchar(20)) KodeArea, cast('' as varchar(50)) NamaArea, 

case when A.HargaKe=0 then 'Harga Jual 1'

     when A.HargaKe=1 then 'Harga Jual 2'

     when a.HargaKe=2 then 'Harga Jual 3'

     else ''

 KetHarga,

cast(case when A.PPN=0 then 'NONE' when A.PPN=1 then 'Exclude' when A.PPN=2 then 'Include'  as varchar(50)) MyPPN,

cast(case when A.IsAktif=0 then 'Tidak Aktif' when A.IsAktif=1 then 'Aktif'  as varchar(50)) MyAktif,

CAST(case when A.Jenis=0 then 1 else 0  as TINYINT) IsSupplier, 

CAST(case when A.Jenis=0 then 0 else 1  as TINYINT) IsCustomer,ISNULL(IsPPH21,0)IsPPH21

from	DBCUSTSUPP A;

-- vwDetailKoreksi
CREATE VIEW IF NOT EXISTS vwDetailKoreksi AS Select A.Nobukti,A.tanggal,A.note,A.ISCetak,b.kodebrg,C.namaBrg,c.KodeGrp,c.KodeSubGrp,

       b.SaldoComp,b.QntOpname,b.Selisih,

       A.Kodegdg, b.Qntdb,B.QntCr, c.Sat1 Satuan,b.nosat,B.isi,b.Harga,b.urut,d.nama NamaGDG,

       (b.qntdb-b.qntcr)*b.harga as Total,

       (b.qntdb)*b.harga  HrgAdi,

       (b.qntcr)*b.harga HrgAdo, Case When (c1.KodeBrg) Is null Then c.Hrg1_2 else c1.HPP  HPP,

       Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                      Case when A.IsOtorisasi2=1 then 1 else 0 +

                      Case when A.IsOtorisasi3=1 then 1 else 0 +

                      Case when A.IsOtorisasi4=1 then 1 else 0 +

                      Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                 else 1

             As INTEGER) NeedOtorisasi 

From dbKoreksi A 

     left outer join dbKoreksiDet B on b.nobukti=a.nobukti 

     left outer join dbBarang C on c.kodebrg=b.kodebrg 

     Left Outer Join (select Kodebrg,HPP,Bulan,Tahun from HPPSO Group by Kodebrg,HPP,Bulan,Tahun )c1 On c1.Kodebrg=c.Kodebrg and MONTH(a.TANGGAL)=c1.Bulan and YEAR(a.TANGGAL)=c1.Tahun

     left outer join dbGudang D on d.kodegdg=A.kodegdg;

-- vwDetailUbahKemasan
CREATE VIEW IF NOT EXISTS vwDetailUbahKemasan AS Select A.Nobukti,A.tanggal,A.note,A.ISCetak,b.kodebrg,C.namaBrg,

       b.Kodegdg,b.Qntdb,B.QntCr,b.Satuan,b.nosat,B.isi,b.Harga,b.urut,d.nama NamaGDG, 

       (b.qntdb-b.qntcr)*b.harga as Total, 

      (b.qntdb)*b.HPP2 HrgAdi,

      (b.qntcr)*b.hpp HrgADO,b.Hpp,b.HPP2

From dbubahKemasan A 

     left outer join dbUbahKemasanDet B on b.nobukti=a.nobukti 

     left outer join dbBarang C on c.kodebrg=b.kodebrg 

     left outer join dbGudang D on d.kodegdg=b.kodegdg;

-- vwGroupCustSupp
CREATE VIEW IF NOT EXISTS vwGroupCustSupp AS select case when isnull(Agent,'')='' then KODECUSTSUPP else ISNULL(Agent,'')  KodeCustSupp 

from DBCUSTSUPP

group by case when isnull(Agent,'')='' then KODECUSTSUPP else ISNULL(Agent,'');

-- vwGudang
CREATE VIEW IF NOT EXISTS vwGudang AS Select * from DBGUDANG;

-- VwHrgRata2
CREATE VIEW IF NOT EXISTS VwHrgRata2 AS select KODEBRG,Tanggal,AVG(Hrg)Hrg from(

                 select KodeBrg,Case when Nosat=1 Then (Harga) else (Harga)/Case When ISI=0 Then 1 else ISI   Hrg,b.TANGGAL 

                 from DBBELIDET a

                 Left Outer Join DBBELI b on a.NOBUKTI=b.NOBUKTI 

                 union all

                 select b.KodeBrg,(b.HPPBrg) Hrg,a1.TANGGAL from DBKOREKSIDET a

                 Left Outer Join DBKOREKSI a1 On a1.NOBUKTI=a.NOBUKTI

                 Left Outer Join dbHPPProduksi b on a.KODEBRG=b.KodeBrg and MONTH(a1.Tanggal)=b.Bulan and YEAR(a1.TANGGAL)=b.Tahun

                 where Isnull(b.HPPBrg,0)<>0

                 union all

                 select a.KODEBRG,Case when Nosat=1 Then (Harga) else (Harga)/ISI  Hrg,b.TANGGAL 

                 from DBUBAHKEMASANDET a

                 Left Outer Join DBUBAHKEMASAN b On a.NOBUKTI=b.NOBUKTI

                 where HARGA<>0)a

                 Group by a.KODEBRG,a.TANGGAL;

-- vwHutPiut
CREATE VIEW IF NOT EXISTS vwHutPiut AS SELECT    NoFaktur, NoRetur, TipeTrans, 

	upper(KodeCustSupp) KodeCustSupp, NoBukti, NoMsk, Urut, Tanggal, JatuhTempo, 

	Debet, Kredit, Saldo, Valas, Kurs, DebetD, KreditD, SaldoD, 

	KodeSales, Tipe, Perkiraan, Catatan, NOINVOICE, KodeVls_, Kurs_,FlagSimbol,'P' Simbol,NOPAJAK,Devisi

FROM dbo.DBHUTPIUT where NoRetur=''

Union all

SELECT    NoFaktur, NoRetur, TipeTrans, 

	upper(KodeCustSupp) KodeCustSupp, NoBukti, NoMsk, Urut, Tanggal, JatuhTempo, 

	Debet, Kredit, Saldo, Valas, Kurs, DebetD, KreditD, SaldoD, 

	KodeSales, Tipe, Perkiraan, Catatan, NOINVOICE, KodeVls_, Kurs_,FlagSimbol,'R',NOPAJAK,Devisi

FROM dbo.DBHUTPIUT where NoRetur<>'';

-- vwHutPiutBelumlunas
CREATE VIEW IF NOT EXISTS vwHutPiutBelumlunas AS SELECT DISTINCT NoFaktur, KodeCustSupp

FROM  dbo.vwHutpiut

GROUP BY NoFaktur, KodeCustSupp

HAVING (SUM(Case when Tipe='PT' then Debet-Kredit

                 when Tipe='HT' then Kredit-Debet

                 else 0

            ) <> 0);

-- VwInvoicePiutangSJ
CREATE VIEW IF NOT EXISTS VwInvoicePiutangSJ AS select 	B.NoBukti, B.Urut, B.NoSPB, B.UrutSPB, B.KodeBrg, b.NAMABRG,

        x.Tanggal tglSPB,B.NoSPP,z.NOBUKTI NoKP,a.KURS,a.Valas,z.kodesls,p.nama,

        case when b.NOSAT>=1 then B.QNT else B.QNT2  as qnt,

        case when b.NOSAT>=1 then B.SAT_1 else B.SAT_2  as satuan,

        B.HARGA, B.DiscP, B.DISCTOT, B.NDPP,case when b.Namabrg like '%terpasang%' then isnull(t.dpp,0) else B.NDPPRp  NDPPRp,

        case when b.Namabrg like '%terpasang%' then isnull(t.ppn,0) else B.NPPNRp  NPPNRp, 

        case when b.Namabrg like '%terpasang%' then isnull(t.dpp,0) else B.NDPPRp +

        case when b.Namabrg like '%terpasang%' then isnull(t.ppn,0) else B.NPPNRp  NNETRp

        --B.NNETRp

        , B.KetDetail,

        A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,   

        B.SAT_1,B.SAT_2,

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER) Needotorisasi

from	dbInvoicePLDet B

left outer join dbBarang C on C.KodeBrg=B.KodeBrg

left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

left outer join dbSPB X on B.NoSPB = X.NoBukti

left outer join dbSPP y on y.NoBukti=x.NoSPP

left outer join DBSO z on z.NOBUKTI=y.NoSHIP

left outer join dbKaryawan p on p.KeyNIK=z.KODESLS

left outer join (select NOBUKTI,SUM(dpp)DPP,SUM(ppn)PPN from VwreportSPBPlusReturACC group by NOBUKTI ) T on T.NOBUKTI=b.NoSPB

where Isnull(X.IsClose,0)=0  and ISNULL(a.IsBatal,0)=0 and

((Left(x.NoBukti,3) Like 'BCA%' or Left(x.NoBukti,3) Like 'BCB%')) and x.NoBukti<>'' --and x.NoBukti Not Like '%SJB%';

-- vwJabatan
CREATE VIEW IF NOT EXISTS vwJabatan AS Select * from DBJABATAN;

-- vwJenis
CREATE VIEW IF NOT EXISTS vwJenis AS Select A.*

from DBJenis A;

-- vwJenisJadi
CREATE VIEW IF NOT EXISTS vwJenisJadi AS Select A.*

from DBJENISBRGJADI A;

-- vwKartuInvocePL
CREATE VIEW IF NOT EXISTS vwKartuInvocePL AS SELECT 'AWL' AS tipe, '00' Prioritas, '' KodeArea,'' Kodekota,'' KodeSls,b.Kodebrg, '' KodeGdg,0.00 QNT,0.00 NilaiDPP,0.00 NilaiPPN,0.00 jumlahNetto, 

       (b.qntAwal) AS QntDB, (b.Qnt2Awal) Qnt2DB, (b.HrgAwal) HrgDebet, 

       0.00 QntCr,  0.00 Qnt2Cr, 0.00 HrgKredit,

       (b.qntAwal) AS QntSaldo, (b.Qnt2Awal) Qnt2Saldo, (b.HrgAwal) HrgSaldo, 

       Dateadd(MM, 0, Cast(CASE WHEN b.Bulan < 10 THEN '0' ELSE ''  + Cast(b.Bulan AS varchar(2))+'-01-'+ 

                           Cast(b.Tahun AS varchar(4)) AS Datetime)) Tanggal, b.Bulan, b.Tahun, 'Saldo Awal' Nobukti,

      '' KodeCustSupp, '' Keterangan, '' IDUSER, B.HRGRATA HPP

FROM  DBSTOCKBRG b

where b.QNTAWAL<>0 or b.QNT2AWAL<>0

Union All

Select 	'IPL' Tipe, 'A2' Prioritas, e.KodeArea Kodearea,e.KodeKota,f.KeyNik Kodesls,B.KodeBrg, '' KodeGdg,Sum(B.QNT)Qnt,Sum(B.NDPP) NilaiDpp ,Sum(B.NPPN) NilaiPPN,Sum(b.NNET) Jumlahnetto,

   Sum(Isnull(B.Qnt,0)) QntDb, Sum(Isnull(B.Qnt2,0))-Sum(Isnull(B.Qnt2,0)) Qnt2Db, Sum(B.NDPP) HrgDebet,

	0.00 QntCr, 0.00 Qnt2Cr, 0.00 HrgKredit,

	Sum(Isnull(B.Qnt,0)) QntSaldo, Sum(Isnull(B.Qnt2,0)) Qnt2Saldo, Sum(B.NDPP) HrgSaldo,

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti,

	A.KodeCustSupp, '' Keterangan, ''IDUser,

	Sum(B.NDPP/Case when B.Nosat=1 then (B.Qnt)

	                       when B.Nosat=2 then (B.Qnt2)

	                  )  HPP

from 	DBInvoicePL A

left outer join dbInvoicePLDet B on B.NoBukti=A.NoBukti

left outer join DBBARANG C on C.KODEBRG=B.KodeBrg

left outer join DBCUSTSUPP D on D.KODECUSTSUPP=a.KodeCustSupp 

left outer join DBKOTA E on E.KodeKota=D.Kota

left outer join DBSALESCUSTOMER f on f.KodeCustSupp=d.KODECUSTSUPP

Group By B.KodeBrg, A.TANGGAL,A.NOBUKTI,A.KodeCustSupp,e.KodeArea,f.KeyNik,e.KodeKota

union all

Select 	'RIPL' Tipe, 'B1' Prioritas,e.KodeArea kodearea,e.KodeKota ,f.KeyNik Kodesls,B.KodeBrg, '' KodeGdg,Sum(Isnull(B.QNT,0)),Sum(B.NDPP) NilaiDpp ,Sum(B.NPPN) NilaiPPN,Sum(b.NNET) Jumlahnetto,

   0.00 QntDb, 0.00 Qnt2Db, 0.00 HrgDebet,

	Sum(Isnull(B.Qnt,0)) QntCr, Sum(Isnull(B.Qnt2,0)) Qnt2Cr, Sum(B.NDPP) HrgKredit,

	Sum(-1*(Isnull(B.Qnt,0))) QntSaldo, SUM(-1*(Isnull(B.Qnt2,0))) Qnt2Saldo, SUM(-1*B.NDPP) HrgSaldo,

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti,

	A.KODECUSTSUPP, '' Keterangan, ''IDUser,

   SUM( B.NDPP/Case when B.Nosat=1 then B.QNT 

	                       when B.Nosat=2 then B.QNT2 

	                  ) HPP

from 	DBRInvoicePL A

left outer join DBRInvoicePLDET B on B.NoBukti=A.NoBukti

left outer join DBBARANG C on C.KODEBRG=B.KodeBrg

left outer join DBCUSTSUPP D on D.KODECUSTSUPP=a.KodeCustSupp 

left outer join DBKOTA E on E.KodeKota=D.Kota

left outer join DBSALESCUSTOMER f on f.KodeCustSupp=d.KODECUSTSUPP

Group By B.KodeBrg,A.TANGGAL,A.NOBUKTI,A.KODECUSTSUPP,e.KodeArea,f.KeyNik,e.KodeKota;

-- vwKartuPersediaan
CREATE VIEW IF NOT EXISTS vwKartuPersediaan AS Select 	'BPY' Tipe, 'B2' Prioritas, B.KodeBrg, 0.00 QntDb, 0.00 Qnt2Db,0 HrgDebet,

	B.Qnt QntCr, B.Qnt2 Qnt2Cr, 0.00 HrgKredit,

	-B.Qnt QntSaldo, -B.Qnt2 Qnt2Saldo, 0.00 HrgSaldo,

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti,

	''KodeCustSupp, '' Keterangan, A.IDUser,

    0.00 HPP, A.Kodebag, '' NamaCustSupp

from DBPenyerahanBrg A

left outer join DBPenyerahanBrgDET B on B.NoBukti=A.NoBukti

union all

Select 	'RPB' Tipe, 'A3' Prioritas, B.KodeBrg,B.Qnt QntDb, B.Qnt2 Qnt2Db,0.00 HrgDebet,

	0.00 QntCr, 0.00 Qnt2Cr, 0.00 HrgKredit,

	B.Qnt QntSaldo, B.Qnt2 Qnt2Saldo, 0.00 HrgSaldo,

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti,

	''KodeCustSupp, '' Keterangan, A.IDUser,

    0.00 HPP, A.Kodebag,  '' NamaCustSupp

from DBRPenyerahanBrg A

left outer join DBRPenyerahanBrgDET B on B.NoBukti=A.NoBukti

union all

Select 	'BPB' Tipe, 'A2' Prioritas, B.KodeBrg, B.Qnt QntDb, B.Qnt2 Qnt2Db, B.NDPPRp HrgDebet,

	0.00 QntCr, 0.00 Qnt2Cr, 0.00 HrgKredit,

	B.Qnt QntSaldo, B.Qnt2 Qnt2Saldo, B.NDPPRp HrgSaldo,

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti,

	A.KodeCustSupp, '' Keterangan, A.IDUser,

	case when Case when B.Nosat=1 then B.QNT 

	               when B.Nosat=2 then B.QNT2 

	          =0 then 0.00 

	    else B.NDPPRp/Case when B.Nosat=1 then B.QNT 

	                       when B.Nosat=2 then B.QNT2 

	                    HPP,

	'' Kodebag,  C.NamaCustSupp

from 	dbBeli A

left outer join dbBeliDet B on B.NoBukti=A.NoBukti

left outer join vwBrowsSupp C on C.Kodecustsupp=a.kodecustsupp

union all

Select 	'BRB' Tipe, 'B1' Prioritas, B.KodeBrg, 0.00 QntDb, 0.00 Qnt2Db, 0.00 HrgDebet,

	(B.Qnt-B.QNTTukar) QntCr, (B.Qnt2-B.QNT2Tukar) Qnt2Cr, B.NDPPRp HrgKredit,

	-(B.Qnt-B.QNTTukar) QntSaldo, -(B.QNT2-B.QNT2Tukar) Qnt2Saldo, -B.NDPPRp HrgSaldo,

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti,

	A.KodeCustSupp, '' Keterangan, A.IDUser,

	case when Case when B.Nosat=1 then B.QNT 

	               when B.Nosat=2 then B.QNT2 

	          =0 then 0.00 

	    else B.NDPPRp/Case when B.Nosat=1 then B.QNT 

	                       when B.Nosat=2 then B.QNT2 

	                    HPP,

	'' KodeBag,  C.NamaCustSupp

from 	dbRBeli A

left outer join dbRBeliDet B on B.NoBukti=A.NoBukti

left outer join vwBrowsSupp C on C.Kodecustsupp=a.kodecustsupp

union all

Select 	'ADI' Tipe, 'A2' Prioritas, B.KodeBrg, B.QntDb, B.QntDb2 Qnt2Db, B.QntDb*B.Harga HrgDebet,

	0.00 QntCr, 0.00 Qnt2Cr, 0.00 HrgKredit,

	B.QntDb QntSaldo, B.QntDb2 Qnt2Saldo, B.QntDb*B.Harga HrgSaldo, 

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti,

	'' KodeCustSupp, '' Keterangan, A.IDUser,

	B.Harga HPP, '' KodeBag,  '' NamaCustSupp

from 	dbKoreksi A

left outer join dbKoreksiDet B on B.NoBukti=A.NoBukti

where 	B.QntDb<>0 or B.QntDb2<>0

union all

Select 	'ADO' Tipe, 'B3' Prioritas, B.KodeBrg, 0.00 QntDb, 0.00 Qnt2Db, 0.00 HrgDebet,

	B.QntCr, B.QntCr2 Qnt2Cr, B.QntCr*B.HPP HrgKredit,

	-1*B.QntCr QntSaldo, -1*B.QntCr2 Qnt2Saldo, -1*B.QntCr*B.HPP HrgSaldo, 

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti,

	'' KodeCustSupp, '' Keterangan, A.IDUser,

	B.HPP, '' KodeBag, '' NamaCustSupp

from 	dbKoreksi A

left outer join dbKoreksiDet B on B.NoBukti=A.NoBukti

where 	B.QntCr<>0 or B.QntCr2<>0;

-- vwKartuStock
CREATE VIEW IF NOT EXISTS vwKartuStock AS SELECT 'AWL' AS Tipe, 'AWL' AS MyTipe, 'A00' Prioritas, b.Kodebrg, b.Kodegdg,0.00 QNT,0.00 NilaiDPP,0.00 NilaiPPN,0.00 jumlahNetto, 

       Sum(b.qntAwal) AS QntDB, Sum(b.Qnt2Awal) Qnt2DB, Sum(b.QNTAWAL)* Case when Left(d.KODEGRP,3)='110' Then case when Sum(b.qntAwal)=0 then 0 else Sum(B.HRGAwal)/Sum(b.qntAwal)   else  case when Sum(b.qntAwal)=0 then 0 else Sum(B.HRGAwal)/Sum(b.qntAwal)    HrgDebet, 

       Convert(Numeric(18,2),0.00) QntCr,  0.00 Qnt2Cr, 0.00 HrgKredit,

       Sum(b.qntAwal) AS QntSaldo, Sum(b.Qnt2Awal) Qnt2Saldo, Sum(b.QNTAWAL)* Case when Left(d.KODEGRP,3)='110' Then case when Sum(b.qntAwal)=0 then 0 else Sum(B.HRGAwal)/Sum(b.qntAwal)   else  case when Sum(b.qntAwal)=0 then 0 else Sum(B.HRGAwal)/Sum(b.qntAwal)   HrgSaldo, 

       Dateadd(MM, 0, Cast(CASE WHEN b.Bulan < 10 THEN '0' ELSE ''  + Cast(b.Bulan AS varchar(2))+'-01-'+ 

                           Cast(b.Tahun AS varchar(4)) AS Datetime)) Tanggal, b.Bulan, b.Tahun, 

      'Saldo Awal' Nobukti, 0 Urut,

      '' KodeCustSupp, '' Keterangan, '' IDUSER, 

      --case when Sum(b.qntAwal)=0 then 0 else Sum(B.HRGAwal)/Sum(b.qntAwal)  HPP

     Case when Left(d.KODEGRP,3)='110' Then  case when Sum(b.qntAwal)=0 then 0 else Sum(B.HRGAwal)/Sum(b.qntAwal)   else  case when Sum(b.qntAwal)=0 then 0 else Sum(B.HRGAwal)/Sum(b.qntAwal)   HPP,NamaBrg

FROM  DBSTOCKBRG b

Left Outer Join dbBarang d on d.KodeBrg=b.KODEBRG

--Left Outer Join (select Kodebrg,MONTH(Tanggal)Bulan,YEAR(Tanggal)Tahun,AVG(Hrg)Hrg from VwHrgRata2 Group By Kodebrg,MONTH(Tanggal),YEAR(Tanggal))c On c.Kodebrg=b.Kodebrg and c.Bulan=case when b.Bulan=1 Then 12 else b.Bulan-1  and  c.Tahun=case when b.Bulan=1 Then b.Tahun-1 else b.TAHUN 

--Left Outer Join (Select Kodebrg,MONTH(MAX(Tanggal))Bulan,YEAR(MAX(TANGGAL))Tahun,AVG(HPP)HPP from DBSODET a Left Outer Join DBSO b On a.NOBUKTI=b.NOBUKTI where HPP<>0 Group by Kodebrg)c1 on c1.Kodebrg=b.Kodebrg and c1.Bulan<=case when b.Bulan=1 Then 12 else b.Bulan-1  and  c1.Tahun<=case when b.Bulan=1 Then b.Tahun-1 else b.TAHUN 

--left outer join (select Bulan,Tahun,KodeBrg,HPPBrg HPP from dbHPPProduksi)HPP on HPP.KODEBRG=b.KODEBRG and hpp.Bulan=b.BULAN and hpp.Tahun=b.BULAN

where b.QNTAWAL<>0 or b.QNT2AWAL<>0 --and c.Bulan=case when b.Bulan=1 Then 12 else b.Bulan-1  and  c.Tahun=case when b.Bulan=1 Then b.Tahun-1 else b.TAHUN 

Group by b.Kodebrg, b.Kodegdg,b.BULAN,b.TAHUN,Left(d.KODEGRP,3),d.Hrg1_2,NamaBrg --,d.Hrg1_2

union ALL

Select 	'PBL' Tipe, 'PBL' MyTipe, 'A10' Prioritas, B.KodeBrg, B.KodeGdg, B.QNT Qnt, B.NDPP NilaiDpp ,B.NPPN NilaiPPN, b.NNET Jumlahnetto,

 case When a.NOBUKTI Like '%INT%' Then Case When Nosat=2 Then (Isnull(B.Qnt1Terima,Qnt2Terima*B.ISI)-Isnull(B.Qnt1Reject,0)) else B.QNT  else Case When Nosat=2 Then (Isnull(B.Qnt1Terima,Qnt2Terima*B.ISI)-Isnull(B.Qnt1Reject,0)) else B.QNT    QntDb, Isnull(B.Qnt2Terima,0)-Isnull(B.Qnt2Reject,0) Qnt2Db, B.NDPPRp HrgDebet,

	(case when c.IsJasa=1 Then Isnull(B.Qnt1Terima,0)-Isnull(B.Qnt1Reject,0) else 0.00 ) QntCr, 0.00 Qnt2Cr, case when c.IsJasa=1 Then B.NDPPRp else 0.00  HrgKredit,

	case When a.NOBUKTI Like '%INT%' Then (case when c.IsJasa=1 Then 0.00 else Isnull(B.Qnt1Terima,Qnt2Terima*B.ISI)-Isnull(B.Qnt1Reject,0) ) else (case when c.IsJasa=1 Then 0.00 else Isnull(B.Qnt1Terima,Qnt2Terima*B.ISI)-Isnull(B.Qnt1Reject,0) )   QntSaldo, Isnull(B.Qnt2Terima,0)-Isnull(B.Qnt2Reject,0) Qnt2Saldo, case when c.IsJasa=1 Then B.NDPPRp else B.NDPPRp  HrgSaldo,

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti, B.Urut,

	A.KodeSupp,case when c.IsJasa=1 Then b.NamaBrg else d.namacustsupp  as  Keterangan, ''IDUser,

	--B.NDPPRp/case when isnull(B.Qnt1Terima,0)-isnull(B.Qnt1Reject,0)=0 then 1 else isnull(B.Qnt1Terima,0)-isnull(B.Qnt1Reject,0)    HPP

    --Case When c1.KodeBrg Is null Then Isnull(c.Hrg1_2,B.Harga) else isnull(c1.HPP,B.Harga)  

    case when isi=0 then case when b.PPN=2 then (HARGA/1.1)/1 else HARGA /1  else case when b.PPN=2 then (HARGA/1.1)/ISI else   Harga/ISI   HPP,c.NamaBrg

from 	dbBeli A

left outer join dbBeliDet B on B.NoBukti=A.NoBukti

left outer join DBBARANG C on C.KODEBRG=B.KodeBrg

left outer join dbcustsupp D on d.kodecustsupp=a.kodesupp

--Left Outer Join HPPSO c1 On c1.Kodebrg=b.Kodebrg

where B.KODEBRG is not null

--Group By B.KodeBrg, B.KodeGdg,A.TANGGAL,A.NOBUKTI,A.KODESUPP, B.Urut

union all

Select 	'RPB' Tipe, 'RPB' MyTipe, 'B10' Prioritas, B.KodeBrg, A.KodeGdg,Isnull(B.QNT,0) QNT, B.NDPP NilaiDpp ,B.NPPN NilaiPPN, b.NNET Jumlahnetto,

   0.00 QntDb, 0.00 Qnt2Db, 0.00 HrgDebet,

	Isnull(B.Qnt1,0) QntCr, Isnull(B.Qnt2,0) Qnt2Cr, B.NDPP HrgKredit,

	-1*Isnull(B.Qnt1,0) QntSaldo, -1*Isnull(B.Qnt2,0) Qnt2Saldo, -1*B.NDPP HrgSaldo,

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti, B.URUT,

	A.KodeSupp,case when c.IsJasa=1 Then b.NamaBrg else d.namacustsupp  as Keterangan, ''IDUser,

    B.NDPP/Case when B.Nosat=1 then B.Qnt1 when B.Nosat=2 then B.QNT2  HPP,c.NamaBrg

   -- c1.Hrg HPP

from 	dbRBeli A

left outer join dbRBeliDet B on B.NoBukti=A.NoBukti

left outer join DBBARANG C on C.KODEBRG=B.KodeBrg

left outer join dbcustsupp D on d.kodecustsupp=a.kodesupp

Left Outer Join (select Kodebrg,MONTH(Tanggal)Bulan,YEAR(Tanggal)Tahun,AVG(Hrg)Hrg 

                 from VwHrgRata2 Group By Kodebrg,MONTH(Tanggal),YEAR(Tanggal))c1 On c1.Kodebrg=b.Kodebrg 

                 and c1.Bulan=MONTH(a.TANGGAL) and c1.Tahun=YEAR(a.Tanggal)

where 	(B.Qnt<>0 )--and c1.Bulan=MONTH(a.TANGGAL) and c1.Tahun=YEAR(a.Tanggal)

--Group By B.KodeBrg, A.kodegdg,A.Tanggal, A.NoBukti, B.URUT

--Left Outer Join HPPSO c1 On c1.Kodebrg=b.Kodebrg

--Group By B.KodeBrg, A.KodeGdg,A.TANGGAL,A.NOBUKTI,A.KODESUPP, B.Urut

union all

Select 	'PMK' Tipe, 'PMK' MyTipe, 'B20' Prioritas, B.KodeBrg, A.KodeGdg,B.QNT QNt,0.00 NilaiDpp ,0.00 NilaiPPN,0.00 Jumlahnetto,

   0.00 QntDb, 0.00 Qnt2Db, 0.00 HrgDebet,

	Isnull(B.Qnt,0) QntCr, Isnull(B.Qnt2,0) Qnt2Cr, B.Qnt*isnull(B.HPP,0)  HrgKredit,

	Isnull(B.Qnt,0) *-1 QntSaldo, Isnull(B.Qnt2,0)*-1 Qnt2Saldo, -1*B.Qnt*isnull(B.HPP,0)  HrgSaldo,

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti, B.Urut,

	''KodeSupp, Upper(/*B.NoSPK+' '+dp.NMDEP+' '+*/case when a.KdDep='A.BR' then E.NamaAlat else a.NoPOL ) Keterangan, ''IDUser,

	isnull(B.HPP,0) HPP,c.NamaBrg

	--c1.Hrg HPP

from 	DBPenyerahanBhn A

left outer join DBPenyerahanBhndet B on B.NoBukti=A.NoBukti

Left Outer join DBDEPART dp on dp.KDDEP=A.KdDep

left outer join DBBARANG C on C.KODEBRG=B.KodeBrg

Left Outer Join (select b.noBukti,a.KodeBrg,AVG(cast(Hrg as numeric(18,2)))Hrg 

                 from VwHrgRata2 a

                 Left Outer Join DBPenyerahanBhnDET b On a.KodeBrg=b.kodebrg

                 Left Outer Join DBPenyerahanBhn c On c.Nobukti=b.Nobukti

                 where a.Tanggal<=c.tanggal or ( MONTH(a.Tanggal)=MONTH(c.Tanggal) and YEAR(a.Tanggal)=YEAR(c.Tanggal))

                 Group by b.noBukti,a.KodeBrg)c1 On c1.KODEBRG=B.kodebrg and c1.Nobukti=A.Nobukti

left outer join dbAlatBerat E on E.KodeAlat=A.NoPOL

--Group By  B.KodeBrg, A.KodeGdg,A.Tanggal,A.Nobukti, B.Urut

union all

Select 	'RPK' Tipe, 'RPK' MyTipe, 'A20' Prioritas, B.KodeBrg, A.KodeGdg, B.QNT Qnt,0.00 NilaiDpp ,0.00 NilaiPPN,0.00 Jumlahnetto,

   B.Qnt QntDb, B.Qnt2 Qnt2Db, B.Qnt*isnull(B.HPP,0) HrgDebet,

	0.00 QntCr, 0.00 Qnt2Cr, 0.00 HrgKredit, 

	B.Qnt QntSaldo, B.Qnt2 Qnt2Saldo, B.Qnt*isnull(B.HPP,0) HrgSaldo,

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti, B.Urut,

	''KodeSupp, '' Keterangan, ''IDUser,

	isnull(B.HPP,0) HPP,c.NamaBrg

	--Case When c1.KodeBrg Is null Then c.Hrg1_2 else c1.HPP  HPP

from 	DBRPenyerahanBhn A

left outer join DBRPenyerahanBhndet B on B.NoBukti=A.NoBukti

left outer join DBBARANG C on C.KODEBRG=B.KodeBrg

--Left Outer Join HPPSO c1 On c1.Kodebrg=b.Kodebrg

--Group By B.KodeBrg, A.KodeGdg,A.Tanggal,A.Nobukti, B.Urut

Union All

Select 	'TRI' Tipe, 'TRI' MyTipe, 'A05' Prioritas, B.KodeBrg, B.GdgTujuan,B.QNT Qnt,0.00 NilaiDpp ,0.00 NilaiPPN,0.00 Jumlahnetto,

   B.Qnt, B.Qnt2 Qnt2Db, B.Qnt*case When ISNULL(c1.HPP,0)<>0  Then c1.HPP else B.HPP  HrgDebet,

	0.00 QntCr, 0.00 Qnt2Cr, 0.00 HrgKredit,

	B.Qnt QntSaldo, B.Qnt2 Qnt2Saldo, B.Qnt*case When ISNULL(c1.HPP,0)<>0  Then c1.HPP else B.HPP  HrgSaldo, 

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti, B.Urut,

	'' KodeCustSupp, '' Keterangan, '' IDUSER,

	--B.HPP HPP

	case When ISNULL(c1.HPP,0)<>0  Then c1.HPP else B.HPP  HPP,c.NamaBrg

from 	DBTRANSFER A

left outer join DBTRANSFERDET B on B.NoBukti=A.NoBukti

left outer join DBBARANG C on C.KODEBRG=B.KodeBrg

--Left Outer Join (select Kodebrg,AVG(HPP)HPP from HPPSO Group By KODEBRG) c1 On c1.Kodebrg=b.Kodebrg

Left Outer Join (select Bulan,Tahun,KodeBrg,HPPBrg HPP from dbHPPProduksi) c1 on c1.KODEBRG=b.KODEBRG and c1.Bulan=month(A.TANGGAL) and c1.Tahun=YEAR(a.TANGGAL)

where 	(B.Qnt<>0 or B.Qnt2<>0)

--and A.NOBUKTI Like '%-GM%' 

--Group By B.KodeBrg, B.GdgTujuan,A.Tanggal, A.NoBukti, B.Urut

union all

Select 	'TRO' Tipe, 'TRO' MyTipe, 'B05' Prioritas, B.KodeBrg,B.GDGAsal,B.QNT QNT,0.00 NilaiDpp ,0.00 NilaiPPN,0.00 Jumlahnetto,

   0.00 QntDb, 0.00 Qnt2Db, 0.00 HrgDebet,

	B.Qnt, B.Qnt2 Qnt2Cr, B.Qnt*case When ISNULL(c1.HPP,0)<>0  Then c1.HPP else B.HPP  HrgKredit,

	-1*B.Qnt QntSaldo, -1*B.Qnt2 Qnt2Saldo, -1*B.Qnt*case When ISNULL(c1.HPP,0)<>0  Then c1.HPP else B.HPP  HrgSaldo, 

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti, B.Urut,

	'' KodeCustSupp, '' Keterangan, ''IDUser,

	case When ISNULL(c1.HPP,0)<>0  Then c1.HPP else B.HPP  HPP,c.NamaBrg

	-- case when B.GDGTUJUAN='R1' Then 0 else c1.Hrg   HPP

from 	DBTRANSFER A

left outer join DBTRANSFERDET B on B.NoBukti=A.NoBukti

left outer join DBBARANG C on C.KODEBRG=B.KodeBrg

Left Outer Join (select Bulan,Tahun,KodeBrg,HPPBrg HPP from dbHPPProduksi) c1 on c1.KODEBRG=b.KODEBRG and c1.Bulan=month(A.TANGGAL) and c1.Tahun=YEAR(a.TANGGAL)

--Left Outer Join (select Kodebrg,MONTH(Tanggal)Bulan,YEAR(Tanggal)Tahun,AVG(Hrg)Hrg from VwHrgRata2 Group By Kodebrg,MONTH(Tanggal),YEAR(Tanggal))c1 On c1.Kodebrg=b.Kodebrg and c1.Bulan=MONTH(a.TANGGAL) and c1.Tahun=YEAR(a.Tanggal)

where 	(B.Qnt<>0 or B.Qnt2<>0) 

--and A.NOBUKTI Like '%-GK%' 

--Group By B.KodeBrg, B.GDGASAL,A.Tanggal, A.NoBukti, B.Urut

/*union all

Select 	'PBI' Tipe, 'PBI' MyTipe, 'B06' Prioritas, B.KodeBrg, A.KodeGdgT, Isnull(B.QNT,0) Qnt,0.00 NilaiDpp ,0.00 NilaiPPN,0.00 Jumlahnetto,

   Isnull(B.Qnt,0) QntDb, Isnull(B.Qnt2,0) Qnt2Db, Isnull(B.Qnt,0)*Case When c1.KodeBrg Is null Then c.Hrg1_2 else c1.HPP  HrgDebet,

	0.00 QntCr, 0.00 Qnt2Cr, 0.00 HrgKredit,

	Isnull(B.Qnt,0) QntSaldo, Isnull(B.Qnt2,0) Qnt2Saldo, Isnull(B.Qnt,0)*Case When c1.KodeBrg Is null Then c.Hrg1_2 else c1.HPP  HrgSaldo,

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti, B.Urut,

	''KodeSupp, '' Keterangan, ''IDUser,

	--isnull(B.HPP,0) HPP

	Case When c1.KodeBrg Is null Then c.Hrg1_2 else c1.HPP  HPP

from 	DBBPPBT A

left outer join DBBPPBTDET B on B.NoBukti=A.NoBukti

left outer join DBBARANG C on C.KODEBRG=B.KodeBrg

Left Outer Join HPPSO c1 On c1.Kodebrg=b.Kodebrg

--Group By B.KodeBrg, A.KodeGdgT,A.TANGGAL,A.NOBUKTI, B.Urut

Union All

Select 	'PBO' Tipe, 'PBO' MyTipe, 'B06' Prioritas, B.KodeBrg, 'G001' KodeGdg,Isnull(B.QNT,0) Qnt,0.00 NilaiDpp ,0.00 NilaiPPN,0.00 Jumlahnetto,

    0.00 QntDb, 0.00 Qnt2Db, 0.00 HrgDebet,

	Isnull(B.Qnt,0) QntCr, Isnull(B.Qnt2,0) Qnt2Cr, Isnull(B.Qnt,0)*Case When c1.KodeBrg Is null Then c.Hrg1_2 else c1.HPP  HrgKredit, 

	Isnull(B.Qnt,0)*-1 QntSaldo, Isnull(B.Qnt2,0)*-1 Qnt2Saldo, -1*Isnull(B.Qnt,0)*Case When c1.KodeBrg Is null Then c.Hrg1_2 else c1.HPP  HrgSaldo,

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti, B.Urut,

	''KodeSupp, '' Keterangan, ''IDUser,

	--isnull(B.HPP,0) HPP

	Case When c1.KodeBrg Is null Then c.Hrg1_2 else c1.HPP  HPP

from 	DBBPPBT A

left outer join DBBPPBTdet B on B.NoBukti=A.NoBukti

left outer join DBBARANG C on C.KODEBRG=B.KodeBrg

Left Outer Join HPPSO c1 On c1.Kodebrg=b.Kodebrg

--Group By B.KodeBrg, A.KodeGdg,A.TANGGAL,A.NOBUKTI, B.Urut*/

union all

Select 	'UKI' Tipe, 'UKI' MyTipe, 'A60' Prioritas, B.KodeBrg, B.KodeGdg,B.QNTDB QNT,0.00 NilaiDpp ,0.00 NilaiPPN,0.00 Jumlahnetto,

   B.QNTDB, Case when B.NOSAT=2 Then B.QNTDB else (B.QNTDB/(Case when B.ISI=0 Then 1 else C.ISI2 ))  Qnt2Db, B.HARGA HrgDebet,

	0.00 QntCr, 0.00 Qnt2Cr, 0.00 HrgKredit,

	B.QntDB QntSaldo,Case when B.NOSAT=2 Then B.QNTDB else (B.QNTDB/(Case when B.ISI=0 Then 1 else C.ISI2 ))  Qnt2Saldo, 0.00 HrgSaldo,

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti, B.Urut,

	''KodeSupp, '' Keterangan,B.UserID IDUser,

	--0.00 HPP

	B.Harga HPP,c.NamaBrg

from 	DBUBAHKEMASAN A

left outer join DBUBAHKEMASANDET B on B.NoBukti=A.NoBukti

left outer join DBBARANG C on C.KODEBRG=B.KodeBrg

--Left Outer Join HPPSO c1 On c1.Kodebrg=b.Kodebrg

where	b.qntdb<>0 

--Group By B.KodeBrg, B.KodeGdg,A.NOBUKTI,A.Tanggal,B.UserID, B.Urut

union all

Select 	'UK0' Tipe, 'UK0' MyTipe, 'B60' Prioritas, B.KodeBrg, B.KodeGdg,B.QNTCR QNT,0.00 NilaiDpp ,0.00 NilaiPPN,0.00 Jumlahnetto,

   0.00 QNTDB, 0.00 Qnt2Db, 0.00 HrgDebet,

	B.QNTCR, Case when B.NOSAT=2 Then B.QNTCR else (B.QNTCR/(Case when B.ISI=0 Then 1 else C.ISI2 ))  Qnt2Cr,B.HARGA HrgKredit,

	B.QNTCR*-1 QntSaldo,Case when B.NOSAT=2 Then B.QNTCR else (B.QNTCR/(Case when B.ISI=0 Then 1 else C.ISI2 )) *-1 Qnt2Saldo, 0.00 HrgSaldo,

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti,B.Urut,

	''KodeSupp, '' Keterangan,B.UserID IDUser,

	--0.00 HPP

	Case When ISNULL(c1.HPP,0)=0 Then b.HPP else c1.HPP  HPP,c.NamaBrg

from 	DBUBAHKEMASAN A

left outer join DBUBAHKEMASANDET B on B.NoBukti=A.NoBukti

left outer join DBBARANG C on C.KODEBRG=B.KodeBrg

--Left Outer Join HPPSO c1 On c1.Kodebrg=b.Kodebrg

Left Outer Join (select Bulan,Tahun,KodeBrg,HPPBrg HPP from dbHPPProduksi) c1 on c1.KODEBRG=b.KODEBRG and c1.Bulan=month(A.TANGGAL) and c1.Tahun=YEAR(a.TANGGAL)

where	b.qntcr<>0 

--Group By B.KodeBrg, B.KodeGdg,A.NOBUKTI,A.Tanggal,B.UserID, B.URUT



union all

Select 	'ADI' Tipe, 'ADI' MyTipe, 'A70' Prioritas, B.KodeBrg, A.kodegdg, B.QNTDB Qnt,0.00 NilaiDpp ,0.00 NilaiPPN,0.00 Jumlahnetto,

   B.QntDb , B.Qnt2DB Qnt2Db, B.QntDb*CASE When C.KODEGRP='BM' then case when isnull(B.HARGA,0)=0 then isnull(B.HPP,0) else isnull(B.HARGA,0)  else case when a.NOBUKTI in('BCA/OPBJ/0621/0001','BCA/OPBJ/0621/0003','BCA/OPBJ/0621/0005','CA/OPBJ/0621/0002') then isnull(B.HARGA,0) else c1.HPPBrg   HrgDebet,

	0.00 QntCr, 0.00 Qnt2Cr, 0.00 HrgKredit,

	B.QntDb QntSaldo, B.Qnt2DB Qnt2Saldo, B.QntDb*CASE When C.KODEGRP='BM' then case when isnull(B.HARGA,0)=0 then isnull(B.HPP,0) else isnull(B.HARGA,0)  else case when a.NOBUKTI in('BCA/OPBJ/0621/0001','BCA/OPBJ/0621/0003','BCA/OPBJ/0621/0005','CA/OPBJ/0621/0002') then isnull(B.HARGA,0) else c1.HPPBrg   HrgSaldo, 

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti, B.Urut,

	'' KodeCustSupp, A.Note Keterangan, '' IDUSER,

    --B.Harga HPP

	CASE When C.KODEGRP='BM' then case when isnull(B.HARGA,0)=0 then isnull(B.HPP,0) else isnull(B.HARGA,0)  else case when a.NOBUKTI in('BCA/OPBJ/0621/0001','BCA/OPBJ/0621/0003','BCA/OPBJ/0621/0005','CA/OPBJ/0621/0002') then isnull(B.HARGA,0) else c1.HPPBrg   HPP,c.NamaBrg

from 	dbKoreksi A

left outer join dbKoreksiDet B on B.NoBukti=A.NoBukti

left outer join DBBARANG C on C.KODEBRG=B.KodeBrg

Left outer Join (select b.noBukti,a.KodeBrg,AVG(cast(Hrg as numeric(18,2)))Hpp 

                 from VwHrgRata2 a

                 Left Outer Join DBKOREKSIDET b On a.KodeBrg=b.kodebrg

                 Left Outer Join DBKOREKSI c On c.Nobukti=b.Nobukti

                 where a.Tanggal<=c.tanggal or ( MONTH(a.Tanggal)=MONTH(c.Tanggal) and YEAR(a.Tanggal)=YEAR(c.Tanggal))

                 Group by b.noBukti,a.KodeBrg

                )c2 On c2.KODEBRG=B.kodebrg and c2.Nobukti=A.Nobukti 

Left Outer Join dbHPPProduksi c1 on B.KODEBRG=c1.KodeBrg and MONTH(a.Tanggal)=c1.Bulan and YEAR(a.TANGGAL)=c1.Tahun

Left outer Join (select b.noBukti,a.KodeBrg,AVG(cast(Hrg as numeric(18,2)))Hpp 

                 from VwHrgRata2 a

                 Left Outer Join DBKOREKSIDET b On a.KodeBrg=b.kodebrg

                 Left Outer Join DBKOREKSI c On c.Nobukti=b.Nobukti

                 Group by b.noBukti,a.KodeBrg

                )d On d.KODEBRG=B.kodebrg and d.Nobukti=A.Nobukti                   

where 	( B.QntDb<>0 or B.Qnt2DB <>0)

--Group By B.KodeBrg, A.kodegdg,A.Tanggal, A.NoBukti, B.URUT

union all

Select 	'ADO' Tipe, 'ADO' MyTipe, 'B70' Prioritas, B.KodeBrg,A.KodeGdg, B.QNTCR QNT,0.00 NilaiDpp ,0.00 NilaiPPN,0.00 Jumlahnetto,

   0.00 QntDb, 0.00 Qnt2Db, 0.00 HrgDebet,

	B.QntCr, B.Qnt2Cr Qnt2Cr, B.QntCr*case when a.NOBUKTI in('CA/KRS/0121/00035','BCA/KRS/0121/00039','BCA/OPBJ/0621/0001','BCA/OPBJ/0621/0002','BCA/OPBJ/0621/0004','BCA/OPBJ/0621/0006','CA/OPN/0621/0002','CA/OPBJ/0621/0003','BCA/KRS/0223/00045','BCA/KRS/0423/00018') then b.HARGA else case When ISNULL(c1.HPPBrg,0)<>0 Then c1.HPPBrg else B.HPP   HrgKredit,

	-1*B.QntCr QntSaldo, -1*B.Qnt2Cr Qnt2Saldo, -1*B.QntCr*case when a.NOBUKTI in('CA/KRS/0121/00035','BCA/KRS/0121/00039','BCA/OPBJ/0621/0001','BCA/OPBJ/0621/0002','BCA/OPBJ/0621/0004','BCA/OPBJ/0621/0006','CA/OPN/0621/0002','CA/OPBJ/0621/0003','BCA/KRS/0223/00045','BCA/KRS/0423/00018') then b.HARGA else case When ISNULL(c1.HPPBrg,0)<>0  Then c1.HPPBrg else B.HPP   HrgSaldo, 

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti, B.Urut,

	'' KodeCustSupp, A.NOTE Keterangan, ''IDUser,

  case when a.NOBUKTI in('CA/KRS/0121/00035','BCA/KRS/0121/00039','BCA/OPBJ/0621/0001','BCA/OPBJ/0621/0002','BCA/OPBJ/0621/0004','BCA/OPBJ/0621/0006','CA/OPN/0621/0002','CA/OPBJ/0621/0003','BCA/KRS/0223/00045','BCA/KRS/0423/00018') then b.HARGA else case When ISNULL(c1.HPPBrg,0)<>0 Then c1.HPPBrg else B.HPP   HPP,c.NamaBrg

	--Isnull(c1.Hrg,0) HPP

from 	dbKoreksi A

left outer join dbKoreksiDet B on B.NoBukti=A.NoBukti

left outer join DBBARANG C on C.KODEBRG=B.KodeBrg

Left Outer Join dbHPPProduksi c1 on B.KODEBRG=c1.KodeBrg and MONTH(a.Tanggal)=c1.Bulan and YEAR(a.TANGGAL)=c1.Tahun

--Left Outer Join (select Kodebrg,MONTH(Tanggal)Bulan,YEAR(Tanggal)Tahun,AVG(Hrg)Hrg from VwHrgRata2 Group By Kodebrg,MONTH(Tanggal),YEAR(Tanggal))c1 On c1.Kodebrg=b.Kodebrg and c1.Bulan=MONTH(a.TANGGAL) and c1.Tahun=YEAR(a.Tanggal)

where 	(B.QntCr<>0 or B.Qnt2CR<>0) --and c1.Bulan=MONTH(a.TANGGAL) and c1.Tahun=YEAR(a.Tanggal)

--Group By B.KodeBrg, A.kodegdg,A.Tanggal, A.NoBukti, B.URUT

Union ALL

Select 	'PNJ' Tipe, 'PNJ' MyTipe, 'B80' Prioritas, B.KodeBrg,B.KodeGdg,B.QNT QNT,0.00 NilaiDpp ,0.00 NilaiPPN,0.00 Jumlahnetto,

   0.00 QntDb, 0.00 Qnt2Db, 0.00 HrgDebet,

	B.QNT, B.QNT2 Qnt2Cr, B.QNT*case When ISNULL(c1.HPPBrg,0)<>0  Then c1.HPPBrg else B.HPP  HrgKredit,

	-1*B.Qnt QntSaldo, -1*B.Qnt2 Qnt2Saldo, -1*B.Qnt*case When ISNULL(c1.HPPBrg,0)<>0  Then c1.HPPBrg else B.HPP  HrgSaldo, 

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti, B.Urut,

	'' KodeCustSupp, case when c.IsJasa=1 Then b.NamaBrg else d.NAMACUSTSUPP  as Keterangan, ''IDUser,

	case When ISNULL(c1.HPPBrg,0)<>0  Then c1.HPPBrg else B.HPP  HPP,c.NamaBrg

	--B.HPP HPP

	--Case When Isnull(c1.HPP,0)=0 Then c.Hrg1_2 else c1.HPP  HPP

from 	dbSPB A

left outer join dbSPBDet B on B.NoBukti=A.NoBukti

left outer join dbcustsupp D on d.kodecustsupp=a.kodecustsupp

left outer join DBBARANG C on C.KODEBRG=B.KodeBrg

Left Outer Join dbHPPProduksi c1 On c1.Kodebrg=b.Kodebrg and C1.Bulan=MONTH(a.Tanggal) and C1.Tahun=YEAR(a.Tanggal)

where 	(B.Qnt<>0 or B.Qnt2<>0) and isnull(IsClose,0)=0 --and ISNULL(isDO,0)=0

--Group By B.KodeBrg, B.KodeGdg,A.Tanggal, A.NoBukti, B.Urut

Union ALL

Select 	'RPJ' Tipe, 'RPJ' MyTipe, 'A80' Prioritas, B.KODEBRG,A.KodeGdg,B.QNT QNT,0.00 NilaiDpp ,0.00 NilaiPPN,0.00 Jumlahnetto,

   B.QNT QntDb, B.QNT2 Qnt2Db, --B.QNT*case When C.KODEGRP='FG' Then c1.HPPBrg else B.HPP  HrgDebet,

   B.QNT*case When ISNULL(c1.HPPBrg,0)<>0  Then c1.HPPBrg else B.HPP  HrgDebet,

	0.00,  0.00 Qnt2Cr, 0.00 HrgKredit,

	B.Qnt QntSaldo, B.Qnt2 Qnt2Saldo, B.Qnt*case When ISNULL(c1.HPPBrg,0)<>0  Then c1.HPPBrg else B.HPP   HrgSaldo, 

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti, B.Urut,

	B.NoSPB KodeCustSupp, case when c.IsJasa=1 Then b.NamaBrg else d.NAMACUSTSUPP  as Keterangan, ''IDUser,

	--case When C.KODEGRP='FG' Then c1.HPPBrg else B.HPP  HPP

	--Case When Isnull(c1.KodeBrg,'')='' Then c.Hrg1_2 else c1.HPP  HPP

	case When ISNULL(c1.HPPBrg,0)<>0  Then c1.HPPBrg else B.HPP  HPP,c.NamaBrg

from 	DBRSPB A

left outer join DBRSPBDet B on B.NoBukti=A.NoBukti

--Left Outer Join (select NoBukti,Urut,NoSPP from dbSPBDet Group By NoBukti,Urut,NoSPP)SPB On SPB.NoBukti=B.NoSPB 

left Outer join dbcustsupp D on d.kodecustsupp=a.kodecustsupp

left outer join DBBARANG C on C.KODEBRG=B.KodeBrg

Left Outer Join dbHPPProduksi c1 On c1.Kodebrg=b.Kodebrg and C1.Bulan=MONTH(a.Tanggal) and C1.Tahun=YEAR(a.Tanggal)

where 	B.Qnt<>0 or B.Qnt2<>0

--Group By B.KodeBrg,B.KodeGdg, A.Tanggal, A.NoBukti, B.Urut

Union ALL

Select 	'RPJ' Tipe, 'RPJ' MyTipe, 'C80' Prioritas, B.KODEBRG,B.KodeGdg,B.QNT QNT,0.00 NilaiDpp ,0.00 NilaiPPN,0.00 Jumlahnetto,

   B.QNT QntDb, B.QNT2 Qnt2Db, --B.QNT*case When C.KODEGRP='FG' Then c1.HPPBrg else B.HPP  HrgDebet,

   B.QNT*case When ISNULL(c1.HPPBrg,0)<>0  Then c1.HPPBrg else B.HPP  HrgDebet,

	0.00,  0.00 Qnt2Cr, 0.00 HrgKredit,

	B.Qnt QntSaldo, B.Qnt2 Qnt2Saldo, B.Qnt*case When ISNULL(c1.HPPBrg,0)<>0  Then c1.HPPBrg else B.HPP   HrgSaldo, 

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti, B.Urut,

	'' KodeCustSupp, case when c.IsJasa=1 Then b.NamaBrg else d.NAMACUSTSUPP  as Keterangan, ''IDUser,

	--case When C.KODEGRP='FG' Then c1.HPPBrg else B.HPP  HPP

	--Case When Isnull(c1.KodeBrg,'')='' Then c.Hrg1_2 else c1.HPP  HPP

	case When ISNULL(c1.HPPBrg,0)<>0  Then c1.HPPBrg else B.HPP  HPP,c.NamaBrg

from 	dbSPBRJual A

left outer join dbSPBRJualDet B on B.NoBukti=A.NoBukti

--Left Outer Join (select NoBukti,Urut,NoSPP from dbSPBDet Group By NoBukti,Urut,NoSPP)SPB On SPB.NoBukti=B.NoSPB 

left Outer join dbcustsupp D on d.kodecustsupp=a.kodecustsupp

left outer join DBBARANG C on C.KODEBRG=B.KodeBrg

Left Outer Join dbHPPProduksi c1 On c1.Kodebrg=b.Kodebrg and C1.Bulan=MONTH(a.Tanggal) and C1.Tahun=YEAR(a.Tanggal)

where 	B.Qnt<>0 or B.Qnt2<>0

Union ALL

Select 	'HP' Tipe, 'HP' MyTipe, 'A90' Prioritas, B.KODEBRG,B.KodeGdg, Case when B.NOSAT=1 Then (B.Qnt) else (B.Qnt*B.ISI)   QNT,0.00 NilaiDpp ,0.00 NilaiPPN,0.00 Jumlahnetto,

   Case when B.NOSAT=1 Then (B.Qnt) else (B.Qnt*B.ISI)   QntDb, Case when B.NOSAT=2 Then B.QNT else (B.QNT/(Case when B.ISI=0 Then 1 else C.ISI2 ))  Qnt2Db, 

   case when B.NOSAT=1 then B.Qnt else B.Qnt*B.ISI *Case When Isnull(HPP.HPP,0)=0 Then b.HPP else HPP.HPP  HrgDebet,

	0.00,  0.00 Qnt2Cr, 0.00 HrgKredit,

	Case when B.NOSAT=1 Then (B.Qnt) else (B.Qnt*B.ISI)   QntSaldo, Case when B.NOSAT=2 Then B.QNT else (B.QNT/(Case when B.ISI=0 Then 1 else C.ISI2 ))  Qnt2Saldo, 

	case when B.NOSAT=1 then B.Qnt else B.Qnt*B.ISI *Case When Isnull(HPP.HPP,0)=0 Then b.HPP else HPP.HPP  HrgSaldo, 

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti, B.Urut,

	'' KodeCustSupp,A.KETERANGAN Keterangan, ''IDUser,

	--B.HPP HPP

	Case When Isnull(HPP.HPP,0)=0 Then b.HPP else HPP.HPP  HPP,c.NamaBrg

from 	DBHASILPRD A

left outer join DBHASILPRDDet B on B.NoBukti=A.NoBukti

--Left Outer Join(Select a.NOBUKTI NoSPK,c.NAMACUSTSUPP from DBSPK a

--                Left Outer Join DBSO b on b.NOBUKTI=a.NOSO 

--                Left Outer Join DBCUSTSUPP c On c.KODECUSTSUPP=b.KODECUST)B1 On B1.NoSPK=B.NoSPK

Left Outer Join DBBARANG C on C.KODEBRG=B.KODEBRG

Left Outer Join (select Bulan,Tahun,KodeBrg,HPPBrg HPP from dbHPPProduksi) HPP on HPP.KODEBRG=b.KODEBRG and hpp.Bulan=month(A.TANGGAL) and hpp.Tahun=YEAR(a.TANGGAL);

-- vwKartuStockold
CREATE VIEW IF NOT EXISTS vwKartuStockold AS SELECT 'AWL' AS Tipe, 'AWL' AS MyTipe, 'A00' Prioritas, b.Kodebrg, b.Kodegdg,0.00 QNT,0.00 NilaiDPP,0.00 NilaiPPN,0.00 jumlahNetto, 

       Sum(b.qntAwal) AS QntDB, Sum(b.Qnt2Awal) Qnt2DB, Sum(b.HrgAwal) HrgDebet, 

       0.00 QntCr,  0.00 Qnt2Cr, 0.00 HrgKredit,

       Sum(b.qntAwal) AS QntSaldo, Sum(b.Qnt2Awal) Qnt2Saldo, Sum(b.HrgAwal) HrgSaldo, 

       Dateadd(MM, 0, Cast(CASE WHEN b.Bulan < 10 THEN '0' ELSE ''  + Cast(b.Bulan AS varchar(2))+'-01-'+ 

                           Cast(b.Tahun AS varchar(4)) AS Datetime)) Tanggal, b.Bulan, b.Tahun, 

      'Saldo Awal' Nobukti, 0 Urut,

      '' KodeCustSupp, '' Keterangan, '' IDUSER, 

      --case when Sum(b.qntAwal)=0 then 0 else Sum(B.HRGAwal)/Sum(b.qntAwal)  HPP

      --Case When min(c.KodeBrg) Is null Then d.Hrg1_2 else 

      c.Hrg HPP

FROM  DBSTOCKBRG b

Left Outer Join dbBarang d on d.KodeBrg=b.KODEBRG

Left Outer Join (select Kodebrg,MONTH(Tanggal)Bulan,YEAR(Tanggal)Tahun,AVG(Hrg)Hrg from VwHrgRata2 Group By Kodebrg,MONTH(Tanggal),YEAR(Tanggal))c On c.Kodebrg=b.Kodebrg and c.Bulan=case when b.Bulan=1 Then 12 else b.Bulan-1  and  c.Tahun=case when b.Bulan=1 Then b.Tahun-1 else b.TAHUN 

where b.QNTAWAL<>0 or b.QNT2AWAL<>0 and c.Bulan=case when b.Bulan=1 Then 12 else b.Bulan-1  and  c.Tahun=case when b.Bulan=1 Then b.Tahun-1 else b.TAHUN 

Group by b.Kodebrg, b.Kodegdg,c.Hrg,b.BULAN,b.TAHUN --,d.Hrg1_2

union ALL

Select 	'PBL' Tipe, 'PBL' MyTipe, 'A10' Prioritas, B.KodeBrg, B.KodeGdg, B.QNT Qnt, B.NDPP NilaiDpp ,B.NPPN NilaiPPN, b.NNET Jumlahnetto,

   (Isnull(B.Qnt1Terima,0)-Isnull(B.Qnt1Reject,0)) QntDb, Isnull(B.Qnt2Terima,0)-Isnull(B.Qnt2Reject,0) Qnt2Db, B.NDPPRp HrgDebet,

	(case when c.IsJasa=1 Then Isnull(B.Qnt1Terima,0)-Isnull(B.Qnt1Reject,0) else 0.00 ) QntCr, 0.00 Qnt2Cr, case when c.IsJasa=1 Then B.NDPPRp else 0.00  HrgKredit,

	(case when c.IsJasa=1 Then 0.00 else Isnull(B.Qnt1Terima,0)-Isnull(B.Qnt1Reject,0) ) QntSaldo, Isnull(B.Qnt2Terima,0)-Isnull(B.Qnt2Reject,0) Qnt2Saldo, case when c.IsJasa=1 Then 0.00 else B.NDPPRp  HrgSaldo,

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti, B.Urut,

	A.KodeSupp,case when c.IsJasa=1 Then b.NamaBrg else d.namacustsupp  as  Keterangan, ''IDUser,

	--B.NDPPRp/case when isnull(B.Qnt1Terima,0)-isnull(B.Qnt1Reject,0)=0 then 1 else isnull(B.Qnt1Terima,0)-isnull(B.Qnt1Reject,0)    HPP

    --Case When c1.KodeBrg Is null Then Isnull(c.Hrg1_2,B.Harga) else isnull(c1.HPP,B.Harga)  

    Harga/ISI HPP

from 	dbBeli A

left outer join dbBeliDet B on B.NoBukti=A.NoBukti

left outer join DBBARANG C on C.KODEBRG=B.KodeBrg

left outer join dbcustsupp D on d.kodecustsupp=a.kodesupp

--Left Outer Join HPPSO c1 On c1.Kodebrg=b.Kodebrg

where B.KODEBRG is not null

--Group By B.KodeBrg, B.KodeGdg,A.TANGGAL,A.NOBUKTI,A.KODESUPP, B.Urut

union all

Select 	'RPB' Tipe, 'RPB' MyTipe, 'B10' Prioritas, B.KodeBrg, A.KodeGdg,Isnull(B.QNT,0) QNT, B.NDPP NilaiDpp ,B.NPPN NilaiPPN, b.NNET Jumlahnetto,

   0.00 QntDb, 0.00 Qnt2Db, 0.00 HrgDebet,

	Isnull(B.Qnt1,0) QntCr, Isnull(B.Qnt2,0) Qnt2Cr, B.NDPP HrgKredit,

	-1*Isnull(B.Qnt1,0) QntSaldo, -1*Isnull(B.Qnt2,0) Qnt2Saldo, -1*B.NDPP HrgSaldo,

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti, B.URUT,

	A.KodeSupp,case when c.IsJasa=1 Then b.NamaBrg else d.namacustsupp  as Keterangan, ''IDUser,

   --B.NDPP/Case when B.Nosat=1 then B.Qnt1 when B.Nosat=2 then B.QNT2  HPP

    Case When c1.KodeBrg Is null Then c.Hrg1_2 else c1.HPP  HPP

from 	dbRBeli A

left outer join dbRBeliDet B on B.NoBukti=A.NoBukti

left outer join DBBARANG C on C.KODEBRG=B.KodeBrg

left outer join dbcustsupp D on d.kodecustsupp=a.kodesupp

Left Outer Join HPPSO c1 On c1.Kodebrg=b.Kodebrg

--Group By B.KodeBrg, A.KodeGdg,A.TANGGAL,A.NOBUKTI,A.KODESUPP, B.Urut

union all

Select 	'PMK' Tipe, 'PMK' MyTipe, 'B20' Prioritas, B.KodeBrg, A.KodeGdg,B.QNT QNt,0.00 NilaiDpp ,0.00 NilaiPPN,0.00 Jumlahnetto,

   0.00 QntDb, 0.00 Qnt2Db, 0.00 HrgDebet,

	Isnull(B.Qnt,0)*B.Isi QntCr, Isnull(B.Qnt2,0) Qnt2Cr, B.Qnt*isnull(c1.Hrg,0) HrgKredit,

	(Isnull(B.Qnt,0)*-1)*B.Isi QntSaldo, Isnull(B.Qnt2,0)*-1 Qnt2Saldo, -1*B.Qnt*isnull(c1.Hrg,0) HrgSaldo,

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti, B.Urut,

	''KodeSupp, B.NoSPK+' '+dp.NMDEP Keterangan, ''IDUser,

	--isnull(B.HPP,0) HPP

	c1.Hrg HPP

from 	DBPenyerahanBhn A

left outer join DBPenyerahanBhndet B on B.NoBukti=A.NoBukti

Left Outer join DBDEPART dp on dp.KDDEP=A.KdDep

left outer join DBBARANG C on C.KODEBRG=B.KodeBrg

Left Outer Join (select b.noBukti,a.KodeBrg,AVG(Hrg)Hrg 

                 from VwHrgRata2 a

                 Left Outer Join DBPenyerahanBhnDET b On a.KodeBrg=b.kodebrg

                 Left Outer Join DBPenyerahanBhn c On c.Nobukti=b.Nobukti

                 where a.Tanggal<=c.tanggal or ( MONTH(a.Tanggal)=MONTH(c.Tanggal) and YEAR(a.Tanggal)=YEAR(c.Tanggal))

                 Group by b.noBukti,a.KodeBrg)c1 On c1.KODEBRG=B.kodebrg and c1.Nobukti=A.Nobukti

--Group By  B.KodeBrg, A.KodeGdg,A.Tanggal,A.Nobukti, B.Urut

union all

Select 	'RPK' Tipe, 'RPK' MyTipe, 'A20' Prioritas, B.KodeBrg, A.KodeGdg, B.QNT Qnt,0.00 NilaiDpp ,0.00 NilaiPPN,0.00 Jumlahnetto,

   B.Qnt QntDb, B.Qnt2 Qnt2Db, B.Qnt*isnull(B.HPP,0) HrgDebet,

	0.00 QntCr, 0.00 Qnt2Cr, 0.00 HrgKredit, 

	B.Qnt QntSaldo, B.Qnt2 Qnt2Saldo, B.Qnt*isnull(B.HPP,0) HrgSaldo,

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti, B.Urut,

	''KodeSupp, '' Keterangan, ''IDUser,

	--isnull(B.HPP,0) HPP

	Case When c1.KodeBrg Is null Then c.Hrg1_2 else c1.HPP  HPP

from 	DBRPenyerahanBhn A

left outer join DBRPenyerahanBhndet B on B.NoBukti=A.NoBukti

left outer join DBBARANG C on C.KODEBRG=B.KodeBrg

Left Outer Join HPPSO c1 On c1.Kodebrg=b.Kodebrg

--Group By B.KodeBrg, A.KodeGdg,A.Tanggal,A.Nobukti, B.Urut

Union All

Select 	'TRI' Tipe, 'TRI' MyTipe, 'B05' Prioritas, B.KodeBrg, B.GdgTujuan,B.QNT Qnt,0.00 NilaiDpp ,0.00 NilaiPPN,0.00 Jumlahnetto,

   B.Qnt, B.Qnt2 Qnt2Db, B.Qnt*isnull(B.HPP,0) HrgDebet,

	0.00 QntCr, 0.00 Qnt2Cr, 0.00 HrgKredit,

	B.Qnt QntSaldo, B.Qnt2 Qnt2Saldo, B.Qnt*isnull(B.HPP,0) HrgSaldo, 

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti, B.Urut,

	'' KodeCustSupp, '' Keterangan, '' IDUSER,

	--B.HPP HPP

	Case When c1.KodeBrg Is null Then c.Hrg1_2 else c1.HPP  HPP

from 	DBTRANSFER A

left outer join DBTRANSFERDET B on B.NoBukti=A.NoBukti

left outer join DBBARANG C on C.KODEBRG=B.KodeBrg

Left Outer Join HPPSO c1 On c1.Kodebrg=b.Kodebrg

where 	B.Qnt<>0 or B.Qnt2<>0

--Group By B.KodeBrg, B.GdgTujuan,A.Tanggal, A.NoBukti, B.Urut

union all

Select 	'TRO' Tipe, 'TRO' MyTipe, 'B05' Prioritas, B.KodeBrg,B.GDGAsal,B.QNT QNT,0.00 NilaiDpp ,0.00 NilaiPPN,0.00 Jumlahnetto,

   0.00 QntDb, 0.00 Qnt2Db, 0.00 HrgDebet,

	B.Qnt, B.Qnt2 Qnt2Cr, B.Qnt*B.HPP HrgKredit,

	-1*B.Qnt QntSaldo, -1*B.Qnt2 Qnt2Saldo, -1*B.Qnt*B.HPP HrgSaldo, 

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti, B.Urut,

	'' KodeCustSupp, '' Keterangan, ''IDUser,

	--B.HPP HPP

	 c1.Hrg  HPP

from 	DBTRANSFER A

left outer join DBTRANSFERDET B on B.NoBukti=A.NoBukti

left outer join DBBARANG C on C.KODEBRG=B.KodeBrg

Left Outer Join (select Kodebrg,MONTH(Tanggal)Bulan,YEAR(Tanggal)Tahun,AVG(Hrg)Hrg from VwHrgRata2 Group By Kodebrg,MONTH(Tanggal),YEAR(Tanggal))c1 On c1.Kodebrg=b.Kodebrg and c1.Bulan=MONTH(a.TANGGAL) and c1.Tahun=YEAR(a.Tanggal)

where 	B.Qnt<>0 or B.Qnt2<>0 and c1.Bulan=MONTH(a.TANGGAL) and c1.Tahun=YEAR(a.Tanggal)

--Group By B.KodeBrg, B.GDGASAL,A.Tanggal, A.NoBukti, B.Urut

union all

Select 	'TRI' Tipe, 'PBI' MyTipe, 'B06' Prioritas, B.KodeBrg, A.KodeGdgT, Isnull(B.QNT,0) Qnt,0.00 NilaiDpp ,0.00 NilaiPPN,0.00 Jumlahnetto,

   Isnull(B.Qnt,0) QntDb, Isnull(B.Qnt2,0) Qnt2Db, Isnull(B.Qnt,0)*ISNULL(B.HPP,0) HrgDebet,

	0.00 QntCr, 0.00 Qnt2Cr, 0.00 HrgKredit,

	Isnull(B.Qnt,0) QntSaldo, Isnull(B.Qnt2,0) Qnt2Saldo, Isnull(B.Qnt,0)*ISNULL(B.HPP,0) HrgSaldo,

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti, B.Urut,

	''KodeSupp, '' Keterangan, ''IDUser,

	--isnull(B.HPP,0) HPP

	Case When c1.KodeBrg Is null Then c.Hrg1_2 else c1.HPP  HPP

from 	DBBPPBT A

left outer join DBBPPBTDET B on B.NoBukti=A.NoBukti

left outer join DBBARANG C on C.KODEBRG=B.KodeBrg

Left Outer Join HPPSO c1 On c1.Kodebrg=b.Kodebrg

--Group By B.KodeBrg, A.KodeGdgT,A.TANGGAL,A.NOBUKTI, B.Urut

Union All

Select 	'TRO' Tipe, 'PBO' MyTipe, 'B06' Prioritas, B.KodeBrg, 'G001' KodeGdg,Isnull(B.QNT,0) Qnt,0.00 NilaiDpp ,0.00 NilaiPPN,0.00 Jumlahnetto,

    0.00 QntDb, 0.00 Qnt2Db, 0.00 HrgDebet,

	Isnull(B.Qnt,0) QntCr, Isnull(B.Qnt2,0) Qnt2Cr, Isnull(B.Qnt,0)*ISNULL(B.HPP,0) HrgKredit, 

	Isnull(B.Qnt,0)*-1 QntSaldo, Isnull(B.Qnt2,0)*-1 Qnt2Saldo, -1*Isnull(B.Qnt,0)*ISNULL(B.HPP,0) HrgSaldo,

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti, B.Urut,

	''KodeSupp, '' Keterangan, ''IDUser,

	--isnull(B.HPP,0) HPP

	Case When c1.KodeBrg Is null Then c.Hrg1_2 else c1.HPP  HPP

from 	DBBPPBT A

left outer join DBBPPBTdet B on B.NoBukti=A.NoBukti

left outer join DBBARANG C on C.KODEBRG=B.KodeBrg

Left Outer Join HPPSO c1 On c1.Kodebrg=b.Kodebrg

--Group By B.KodeBrg, A.KodeGdg,A.TANGGAL,A.NOBUKTI, B.Urut

union all

Select 	'UKI' Tipe, 'UKI' MyTipe, 'A60' Prioritas, B.KodeBrg, B.KodeGdg,B.QNTDB QNT,0.00 NilaiDpp ,0.00 NilaiPPN,0.00 Jumlahnetto,

   B.QNTDB, 0.00 Qnt2Db, B.HARGA HrgDebet,

	0.00 QntCr, 0.00 Qnt2Cr, 0.00 HrgKredit,

	B.QntDB QntSaldo,0.00 Qnt2Saldo, 0.00 HrgSaldo,

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti, B.Urut,

	''KodeSupp, '' Keterangan,B.UserID IDUser,

	--0.00 HPP

	B.Harga HPP

from 	DBUBAHKEMASAN A

left outer join DBUBAHKEMASANDET B on B.NoBukti=A.NoBukti

left outer join DBBARANG C on C.KODEBRG=B.KodeBrg

Left Outer Join HPPSO c1 On c1.Kodebrg=b.Kodebrg

where	b.qntdb<>0 

--Group By B.KodeBrg, B.KodeGdg,A.NOBUKTI,A.Tanggal,B.UserID, B.Urut

union all

Select 	'UK0' Tipe, 'UK0' MyTipe, 'B60' Prioritas, B.KodeBrg, B.KodeGdg,B.QNTCR QNT,0.00 NilaiDpp ,0.00 NilaiPPN,0.00 Jumlahnetto,

   0.00 QNTDB, 0.00 Qnt2Db, 0.00 HrgDebet,

	B.QNTCR, 0.00 Qnt2Cr,B.HARGA HrgKredit,

	B.QntDB QntSaldo,0.00 Qnt2Saldo, 0.00 HrgSaldo,

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti,B.Urut,

	''KodeSupp, '' Keterangan,B.UserID IDUser,

	--0.00 HPP

	Case When c1.KodeBrg Is null Then c.Hrg1_2 else c1.HPP  HPP

from 	DBUBAHKEMASAN A

left outer join DBUBAHKEMASANDET B on B.NoBukti=A.NoBukti

left outer join DBBARANG C on C.KODEBRG=B.KodeBrg

Left Outer Join HPPSO c1 On c1.Kodebrg=b.Kodebrg

where	b.qntcr<>0 

--Group By B.KodeBrg, B.KodeGdg,A.NOBUKTI,A.Tanggal,B.UserID, B.URUT

union all

Select 	'ADI' Tipe, 'ADI' MyTipe, 'A70' Prioritas, B.KodeBrg, A.kodegdg, B.QNTDB Qnt,0.00 NilaiDpp ,0.00 NilaiPPN,0.00 Jumlahnetto,

   B.QntDb, B.Qnt2DB Qnt2Db, B.QntDb*Isnull(c1.HPPBrg,0) HrgDebet,

	0.00 QntCr, 0.00 Qnt2Cr, 0.00 HrgKredit,

	B.QntDb QntSaldo, B.Qnt2DB Qnt2Saldo, B.QntDb*Isnull(c1.HPPBrg,0) HrgSaldo, 

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti, B.Urut,

	'' KodeCustSupp, A.NOBUKTI Keterangan, '' IDUSER,

	--B.Harga HPP

	c1.HPPBrg HPP

from 	dbKoreksi A

left outer join dbKoreksiDet B on B.NoBukti=A.NoBukti

left outer join DBBARANG C on C.KODEBRG=B.KodeBrg

Left Outer Join dbHPPProduksi c1 on B.KODEBRG=c1.KodeBrg and MONTH(a.Tanggal)=c1.Bulan and YEAR(a.TANGGAL)=c1.Tahun

where 	( B.QntDb<>0 )

--Group By B.KodeBrg, A.kodegdg,A.Tanggal, A.NoBukti, B.URUT

union all

Select 	'ADO' Tipe, 'ADO' MyTipe, 'B70' Prioritas, B.KodeBrg,A.KodeGdg, B.QNTCR QNT,0.00 NilaiDpp ,0.00 NilaiPPN,0.00 Jumlahnetto,

   0.00 QntDb, 0.00 Qnt2Db, 0.00 HrgDebet,

	B.QntCr, B.Qnt2Cr Qnt2Cr, B.QntCr*Isnull(c1.Hrg,0) HrgKredit,

	-1*B.QntCr QntSaldo, -1*B.Qnt2Cr Qnt2Saldo, -1*B.QntCr*Isnull(c1.Hrg,0) HrgSaldo, 

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti, B.Urut,

	'' KodeCustSupp, A.NOBUKTI Keterangan, ''IDUser,

	--B.HPP HPP

	Isnull(c1.Hrg,0) HPP

from 	dbKoreksi A

left outer join dbKoreksiDet B on B.NoBukti=A.NoBukti

left outer join DBBARANG C on C.KODEBRG=B.KodeBrg

--Left Outer Join dbHPPProduksi c1 on B.KODEBRG=c1.KodeBrg and MONTH(a.Tanggal)=c1.Bulan and YEAR(a.TANGGAL)=c1.Tahun

Left Outer Join (select Kodebrg,MONTH(Tanggal)Bulan,YEAR(Tanggal)Tahun,AVG(Hrg)Hrg from VwHrgRata2 Group By Kodebrg,MONTH(Tanggal),YEAR(Tanggal))c1 On c1.Kodebrg=b.Kodebrg and c1.Bulan=MONTH(a.TANGGAL) and c1.Tahun=YEAR(a.Tanggal)

where 	(B.QntCr<>0 )and c1.Bulan=MONTH(a.TANGGAL) and c1.Tahun=YEAR(a.Tanggal)

--Group By B.KodeBrg, A.kodegdg,A.Tanggal, A.NoBukti, B.URUT

Union ALL

Select 	'PNJ' Tipe, 'PNJ' MyTipe, 'B80' Prioritas, B.KodeBrg,B.KodeGdg,B.QNT QNT,0.00 NilaiDpp ,0.00 NilaiPPN,0.00 Jumlahnetto,

   0.00 QntDb, 0.00 Qnt2Db, 0.00 HrgDebet,

	B.QNT, B.QNT2 Qnt2Cr, B.QNT*B.HPP HrgKredit,

	-1*B.Qnt QntSaldo, -1*B.Qnt2 Qnt2Saldo, -1*B.Qnt*B.HPP HrgSaldo, 

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti, B.Urut,

	'' KodeCustSupp, case when c.IsJasa=1 Then b.NamaBrg else d.NAMACUSTSUPP  as Keterangan, ''IDUser,

	--B.HPP HPP

	Case When c1.KodeBrg Is null Then c.Hrg1_2 else c1.HPP  HPP

from 	dbSPB A

left outer join dbSPBDet B on B.NoBukti=A.NoBukti

left outer join dbcustsupp D on d.kodecustsupp=a.kodecustsupp

left outer join DBBARANG C on C.KODEBRG=B.KodeBrg

Left Outer Join HPPSO c1 On c1.Kodebrg=b.Kodebrg

where 	B.Qnt<>0 or B.Qnt2<>0

--Group By B.KodeBrg, B.KodeGdg,A.Tanggal, A.NoBukti, B.Urut

Union ALL

Select 	'RPJ' Tipe, 'RPJ' MyTipe, 'A80' Prioritas, B.KODEBRG,B.KodeGdg,B.QNT QNT,0.00 NilaiDpp ,0.00 NilaiPPN,0.00 Jumlahnetto,

   B.QNT QntDb, B.QNT2 Qnt2Db, B.QNT*B.HPP HrgDebet,

	0.00,  0.00 Qnt2Cr, 0.00 HrgKredit,

	B.Qnt QntSaldo, B.Qnt2 Qnt2Saldo, B.Qnt*B.HPP HrgSaldo, 

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti, B.Urut,

	'' KodeCustSupp, case when c.IsJasa=1 Then b.NamaBrg else d.NAMACUSTSUPP  as Keterangan, ''IDUser,

	--B.HPP HPP

	Case When c1.KodeBrg Is null Then c.Hrg1_2 else c1.HPP  HPP

from 	DBSPBRJual A

left outer join DBSPBRJualDet B on B.NoBukti=A.NoBukti

left outer join dbcustsupp D on d.kodecustsupp=a.kodecustsupp

left outer join DBBARANG C on C.KODEBRG=B.KodeBrg

Left Outer Join HPPSO c1 On c1.Kodebrg=b.Kodebrg

where 	B.Qnt<>0 or B.Qnt2<>0

--Group By B.KodeBrg,B.KodeGdg, A.Tanggal, A.NoBukti, B.Urut

Union ALL

Select 	'HP' Tipe, 'HP' MyTipe, 'A90' Prioritas, B.KODEBRG,B.KodeGdg, Case when B.NOSAT=1 Then (B.Qnt) else (B.Qnt*B.ISI)   QNT,0.00 NilaiDpp ,0.00 NilaiPPN,0.00 Jumlahnetto,

   Case when B.NOSAT=1 Then (B.Qnt) else (B.Qnt*B.ISI)   QntDb, Case when B.NOSAT=2 Then B.QNT else (B.QNT/(Case when B.ISI=0 Then 1 else B.ISI ))  Qnt2Db, 

   case when B.NOSAT=1 then B.Qnt else B.Qnt*B.ISI *ISNULL(B.HPP,0) HrgDebet,

	0.00,  0.00 Qnt2Cr, 0.00 HrgKredit,

	Case when B.NOSAT=1 Then (B.Qnt) else (B.Qnt*B.ISI)   QntSaldo, Case when B.NOSAT=2 Then B.QNT else (B.QNT/(Case when B.ISI=0 Then 1 else B.ISI ))  Qnt2Saldo, 

	case when B.NOSAT=1 then B.Qnt else B.Qnt*B.ISI *ISNULL(B.HPP,0) HrgSaldo, 

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti, B.Urut,

	'' KodeCustSupp, B.NoSPK+' '+ISNULL(B1.NAMACUSTSUPP,'') Keterangan, ''IDUser,

	--B.HPP HPP

	Case When Isnull(HPP.HPP,0)=0 Then C.Hrg1_2 else HPP.HPP  HPP

from 	DBHASILPRD A

left outer join DBHASILPRDDet B on B.NoBukti=A.NoBukti

Left Outer Join(Select a.NOBUKTI NoSPK,c.NAMACUSTSUPP from DBSPK a

                Left Outer Join DBSO b on b.NOBUKTI=a.NOSO 

                Left Outer Join DBCUSTSUPP c On c.KODECUSTSUPP=b.KODECUST)B1 On B1.NoSPK=B.NoSPK

Left Outer Join DBBARANG C on C.KODEBRG=B.KODEBRG

Left Outer Join (Select a.NoBukti NoSPK,b.* from dbSPK a 

                 Left Outer Join(

                 select a.NOBUKTI,KODECUST,AlamatKirim KodeProject,b.KODEBRG,SUM(b.Qnt)Qnt,HPP 

                 from  DBSO a

                 Left Outer Join DBSODET b On a.NOBUKTI=b.NOBUKTI 

                 Group by a.NOBUKTI,KODECUST,AlamatKirim,b.KODEBRG,HPP)b On B.NOBUKTI=a.NOSO) HPP on HPP.NoSPK=b.NoSPK and HPP.KODEBRG=b.KODEBRG;

-- vwKategori
CREATE VIEW IF NOT EXISTS vwKategori AS Select A.*,B.NAMA NamaGdg, C.Keterangan NamaPerkiraan,

       B.NAMA+Case when B.NAMA is null then '' else ' ('+B.KODEGDG+')'  myGudang,

       C.Keterangan+Case when C.Keterangan is null then '' else ' ('+C.Perkiraan+')'  myPerkiraan

from DBKATEGORI A

     Left Outer join DBGUDANG B on B.KODEGDG=A.Kodegdg

     left Outer join DBPERKIRAAN C on C.Perkiraan=A.Perkiraan;

-- vwKategoriJadi
CREATE VIEW IF NOT EXISTS vwKategoriJadi AS Select A.*,B.NAMA NamaGdg, C.Keterangan NamaPerkiraan,

       B.NAMA+Case when B.NAMA is null then '' else ' ('+B.KODEGDG+')'  myGudang,

       C.Keterangan+Case when C.Keterangan is null then '' else ' ('+C.Perkiraan+')'  myPerkiraan

from DBKATEGORIBRGJADI A

     Left Outer join DBGUDANG B on B.KODEGDG=A.Kodegdg

     left Outer join DBPERKIRAAN C on C.Perkiraan=A.Perkiraan;

-- vwKelompok
CREATE VIEW IF NOT EXISTS vwKelompok AS Select A.*,B.Keterangan NamaPerkiraan,

       B.Keterangan+Case when B.Keterangan is null then '' else ' ('+B.Perkiraan+')'  myPerkiraan

from DBKELOMPOK A

     left Outer join DBPERKIRAAN B on B.Perkiraan=A.Perkiraan;

-- vwKontrakVsSJ
CREATE VIEW IF NOT EXISTS vwKontrakVsSJ AS Select d.NOBUKTI NoSO,b.KodeCustSupp,e.NAMACUSTSUPP,b.NoResi KodeProject,f.NAMAPROJECT,

a.KodeBrg,g.NAMABRG,d.QNT QntSO,a.NoBukti NoSJ,a.QNT-ISNULL(b1.Qnt,0) QntSJ,b.Tanggal 

from dbSPBDet  a 

Left Outer Join dbSPB b On a.NoBukti=b.NoBukti

Left Outer Join(select NoSPB,KodeBrg,SUM(Qnt)Qnt from DBRSPBDet group by NoSPB,KodeBrg)b1 On B1.NoSPB=a.NoBukti and B1.KodeBrg=a.KodeBrg 

Left Outer Join (select NoBukti,NoSO,Kodebrg from dbSPPDet Group by NoBukti,NoSO,Kodebrg) c On c.NoBukti=a.NoSPP and a.KodeBrg=c.KodeBrg

Left Outer Join (select NoBukti,KodeBrg,Sum(Qnt) Qnt from DBSODET Group by NoBukti,KodeBrg)d On d.NOBUKTI=c.NoSO and d.KODEBRG=c.KodeBrg

Left Outer Join DBPROJECT f on f.KODEPROJECT=b.NoResi

Left Outer Join DBCUSTSUPP e On e.KODECUSTSUPP=b.KodeCustSupp

Left Outer Join DBBARANG g on g.KODEBRG=a.KodeBrg;

-- vwLabaRugiHPP
CREATE VIEW IF NOT EXISTS vwLabaRugiHPP AS Select * 

from DBLRHPP;

-- vwMasterBeli
CREATE VIEW IF NOT EXISTS vwMasterBeli AS Select 	a.Devisi,A.NoBukti, A.Tanggal, A.KodeSupp, C.NAMACUSTSUPP, C.Kota,NoPO,A.UserBatal,A.tglbatal,

	A.Handling, A.FakturSupp, isnull(A.IsBatal,0) IsBatal,

        sum(B.SubTotal) TotSubTotal, sum(B.NDiskon) TotDiskon, 

	sum(B.SubTotal)-sum(B.NDiskon) TotTotal, sum(B.NDPP) TotDPP, 

	sum(B.NPPN) TotPPN, sum(B.NNet) TotNet,

	sum(B.SubTotal*A.Kurs) TotSubTotalRp, sum(B.NDiskon*A.Kurs) TotDiskonRp, 

	sum(B.SubTotal*A.Kurs)-sum(B.NDiskon*A.Kurs) TotTotalRp, sum(B.NDPP*A.Kurs) TotDPPRp, 

	sum(B.NPPN*A.Kurs) TotPPNRp, sum(B.NNet*A.Kurs)+Isnull(A1.Nilai,0) TotNetRp, a.Keterangan,a.TipeBayar

	,

	A.IsOtorisasi1, A.OtoUser1, A.TglOto1, A.IsOtorisasi2, A.OtoUser2, A.TglOto2, 

	A.IsOtorisasi3, A.OtoUser3, A.TglOto3, A.IsOtorisasi4, A.OtoUser4, A.TglOto4,

	A.IsOtorisasi5, A.OtoUser5, A.TglOto5, A.MAXOL,A1.Nilai

From dbBeli A

Left Outer Join dbBeliDet B on B.NoBukti=A.NoBukti

Left Outer Join (select SUM(Nilai)Nilai,NoBuktiInv From DBPBIAYA Group By NoBuktiInv)A1 On A1.NoBuktiInv=A.NOBUKTI

Left Outer Join DBCUSTSUPP C on c.KODECUSTSUPP=a.KodeSupp

Group By a.Devisi,A.NoBukti, A.Tanggal, A.KodeSupp, C.NAMACUSTSUPP, C.Kota,

	A.Handling, A.FakturSupp, isnull(A.IsBatal,0), a.Keterangan,a.TipeBayar,NOPO,

	A.IsOtorisasi1, A.OtoUser1, A.TglOto1, A.IsOtorisasi2, A.OtoUser2, A.TglOto2, 

	A.IsOtorisasi3, A.OtoUser3, A.TglOto3, A.IsOtorisasi4, A.OtoUser4, A.TglOto4,

	A.IsOtorisasi5, A.OtoUser5, A.TglOto5, A.MAXOL,A.UserBatal,A.tglbatal,A1.Nilai;

-- vwMasterKoreksi
CREATE VIEW IF NOT EXISTS vwMasterKoreksi AS Select a.Devisi,a.nobukti+' Tanggal : '+convert(varchar(10),a.tanggal,105) + '   Gudang : '+a.KodeGdg as GroupNobukti, 

       A.Nobukti,a.Tanggal,

	A.IsOtorisasi1, A.OtoUser1, A.TglOto1, A.IsOtorisasi2, A.OtoUser2, A.TglOto2, 

	A.IsOtorisasi3, A.OtoUser3, A.TglOto3, A.IsOtorisasi4, A.OtoUser4, A.TglOto4,

	A.IsOtorisasi5, A.OtoUser5, A.TglOto5,

        Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                       Case when A.IsOtorisasi2=1 then 1 else 0 +

                       Case when A.IsOtorisasi3=1 then 1 else 0 +

                       Case when A.IsOtorisasi4=1 then 1 else 0 +

                       Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                  else 1

              As INTEGER) NeedOtorisasi,IdUser

From dbKoreksi A;

-- vwMasterOutstandingPO
CREATE VIEW IF NOT EXISTS vwMasterOutstandingPO AS Select 	A.NoBukti, A.Tanggal, A.KodeSupp, C.NAMACUSTSUPP, 

	A.IsBatal,

        	sum(B.SubTotal) TotSubTotal, sum(B.NDiskon) TotDiskon, 

	sum(B.SubTotal)-sum(B.NDiskon) TotTotal, sum(B.NDPP) TotDPP, 

	sum(B.NPPN) TotPPN, sum(B.NNet) TotNet,

	sum(B.SubTotal*A.Kurs) TotSubTotalRp, sum(B.NDiskon*A.Kurs) TotDiskonRp, 

	sum(B.SubTotal*A.Kurs)-sum(B.NDiskon*A.Kurs) TotTotalRp, sum(B.NDPP*A.Kurs) TotDPPRp, 

	sum(B.NPPN*A.Kurs) TotPPNRp, sum(B.NNet*A.Kurs) TotNetRp

From dbPO A

Left Outer Join dbPODet B on B.NoBukti=A.NoBukti

Left Outer Join (select Kodebrg,NoPO,Isnull(Sum(Qnt*Isi),0)QntB from dbBelidet group by Kodebrg,NoPO)B1 On B1.NOPO=A.NoBukti and B1.Kodebrg=B.Kodebrg

Left Outer Join DBCUSTSUPP C on c.KODECUSTSUPP=a.KodeSupp

where (B.Qnt*B.Isi)<>Isnull(QntB,0)

and

Case when Isnull(A.IsClose,0)=0 Then Isnull(B.IsClose,0)else Isnull(A.IsClose,0) =0

Group By A.NoBukti, A.Tanggal, A.KodeSupp, C.NAMACUSTSUPP, A.IsBatal;

-- vwMasterPO
CREATE VIEW IF NOT EXISTS vwMasterPO AS Select 	A.NoBukti, A.Tanggal, A.KodeSupp, C.NAMACUSTSUPP, C.Kota,

	A.Handling, A.FakturSupp, isnull(A.IsBatal,0) IsBatal,

        sum(B.SubTotal) TotSubTotal, sum(B.NDiskon) TotDiskon, 

	sum(B.SubTotal)-sum(B.NDiskon) TotTotal, sum(B.NDPP) TotDPP, 

	sum(B.NPPN) TotPPN, sum(B.NNet) TotNet,

	sum(B.SubTotal*A.Kurs) TotSubTotalRp, sum(B.NDiskon*A.Kurs) TotDiskonRp, 

	sum(B.SubTotal*A.Kurs)-sum(B.NDiskon*A.Kurs) TotTotalRp, sum(B.NDPP*A.Kurs) TotDPPRp, 

	sum(B.NPPN*A.Kurs) TotPPNRp, sum(B.NNet*A.Kurs) TotNetRp

From dbPO A

Left Outer Join dbPODet B on B.NoBukti=A.NoBukti

Left Outer Join  dbCustSupp C on c.KodeCustSupp=a.KodeSupp  

Group By A.NoBukti, A.Tanggal, A.KodeSupp, C.NAMACUSTSUPP, C.Kota,

	A.Handling, A.FakturSupp, isnull(A.IsBatal,0);

-- vwMasterPOOut
CREATE VIEW IF NOT EXISTS vwMasterPOOut AS Select 	A.NoBukti, A.Tanggal, A.KodeSupp, C.NAMACUSTSUPP, C.Kota,

b.Qnt-isnull(e.QntTerima,0) QntSisa,QntTerima,

	A.Handling, A.FakturSupp, --isnull(A.IsBatal,0) IsBatal,

       0.00 --sum(B.SubTotal) 

        TotSubTotal, --sum(B.NDiskon) 

     0.00   TotDiskon, 

	0.00--sum(B.SubTotal)-sum(B.NDiskon) 

	TotTotal, 0.00--sum(B.NDPP)

	 TotDPP, 

	0.00--sum(B.NPPN)

		 TotPPN, 0.00--sum(B.NNet) 

		 TotNet,

	0.00--sum(B.SubTotal*A.Kurs) 

	TotSubTotalRp, 0.00--sum(B.NDiskon*A.Kurs) 

	TotDiskonRp, 

	0.00--sum(B.SubTotal*A.Kurs)-sum(B.NDiskon*A.Kurs) 

	TotTotalRp, 0.00--sum(B.NDPP*A.Kurs) 

	TotDPPRp, 

	0.00--sum(B.NPPN*A.Kurs) 

	TotPPNRp, 0.00--sum(B.NNet*A.Kurs) 

	TotNetRp, b.KODEBRG ,Case When Isnull(B.NAMABRG,'')='' Then d.NAMABRG else B.NamaBrg  Namabrg , qnt, f.qntbatal, b.urut, b.IsBatal, b.UserBatal, b.TglBatal,b.SATUAN

From dbPO A

Left Outer Join dbPODet B on B.NoBukti=A.NoBukti

Left Outer Join  dbCustSupp C on c.KodeCustSupp=a.KodeSupp  

left outer join DBBARANG d on d.KODEBRG=b.KODEBRG

left outer join

	(Select NOBUKTI , Urut, KodeBrg, sum(QntBatal ) QntBatal

	 from dbPODet

	 group by NOBUKTI, Urut, KodeBrg) f on f.NOBUKTI=A.NoBukti and f.Urut=b.urut and B.KodeBrg=b.KodeBrg

left outer join

	(Select NoPO , UrutPO, KodeBrg, sum(Qnt ) QntTerima

	 from dbbelidet

	 group by NOpo, Urutpo, KodeBrg) e on e.NoPO =A.NoBukti and e.UrutPO=b.Urut and e.KodeBrg=b.KodeBrg	 

Group By A.NoBukti, A.Tanggal, A.KodeSupp, C.NAMACUSTSUPP, C.Kota,

	A.Handling, A.FakturSupp, isnull(A.IsBatal,0), b.KODEBRG , b.NAMABRG,d.NAMABRG ,QNT ,f.QntBatal,e.QntTerima, b.urut, b.IsBatal, b.UserBatal, b.TglBatal, SATUAN;

-- vwMasterRBeli
CREATE VIEW IF NOT EXISTS vwMasterRBeli AS Select 	A.Devisi,A.NoBukti, A.Tanggal, A.KodeSupp, C.NAMACUSTSUPP, A.NoBeli, C.Kota,

	A.Handling, A.FakturSupp,

        sum(B.SubTotal) TotSubTotal, sum(B.NDiskon) TotDiskon, 

	sum(B.SubTotal)-sum(B.NDiskon) TotTotal, sum(B.NDPP) TotDPP, 

	sum(B.NPPN) TotPPN, sum(B.NNet) TotNet,Kodegdg,

	sum(B.SubTotal*A.Kurs) TotSubTotalRp, sum(B.NDiskon*A.Kurs) TotDiskonRp, 

	sum(B.SubTotal*A.Kurs)-sum(B.NDiskon*A.Kurs) TotTotalRp, sum(B.NDPP*A.Kurs) TotDPPRp, 

	sum(B.NPPN*A.Kurs) TotPPNRp, sum(B.NNet*A.Kurs) TotNetRp,

        A.IsOtorisasi1, A.OtoUser1, A.TglOto1, A.IsOtorisasi2, A.OtoUser2, A.TglOto2, 

	A.IsOtorisasi3, A.OtoUser3, A.TglOto3, A.IsOtorisasi4, A.OtoUser4, A.TglOto4,

	A.IsOtorisasi5, A.OtoUser5, A.TglOto5, A.MAXOL,        

        Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                       Case when A.IsOtorisasi2=1 then 1 else 0 +

                       Case when A.IsOtorisasi3=1 then 1 else 0 +

                       Case when A.IsOtorisasi4=1 then 1 else 0 +

                       Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                  else 1

              As INTEGER) NeedOtorisasi,TglFpj,NOpajak 

From dbRBeli A

Left Outer Join dbRBeliDet B on B.NoBukti=A.NoBukti

Left Outer Join dbCustSupp C on c.KODECUSTSUPP=a.KodeSupp

Group By A.Devisi,A.NoBukti, A.Tanggal, A.KodeSupp, C.NAMACUSTSUPP, A.NoBeli, C.Kota,

	A.Handling, A.FakturSupp, A.KodeGdg, a.ISotorisasi1,OtoUser1,a.TglOto1,TglFpj,NOpajak, A.IsOtorisasi2, A.OtoUser2, A.TglOto2, 

	A.IsOtorisasi3, A.OtoUser3, A.TglOto3, A.IsOtorisasi4, A.OtoUser4, A.TglOto4,

	A.IsOtorisasi5, A.OtoUser5, A.TglOto5, A.MAXOL;

-- vwMasterSO
CREATE VIEW IF NOT EXISTS vwMasterSO AS Select 	A.NoBukti, A.Tanggal, A.KODECUST, C.NAMACUSTSUPP, C.Kota,

	A.Handling, isnull(A.IsBatal,0) IsBatal,

        sum(B.SubTotal) TotSubTotal, sum(B.NDiskon) TotDiskon, 

	sum(B.SubTotal)-sum(B.NDiskon) TotTotal, sum(B.NDPP) TotDPP, 

	sum(B.NPPN) TotPPN, sum(B.NNet) TotNet,

	sum(B.SubTotal*A.Kurs) TotSubTotalRp, sum(B.NDiskon*A.Kurs) TotDiskonRp, 

	sum(B.SubTotal*A.Kurs)-sum(B.NDiskon*A.Kurs) TotTotalRp, sum(B.NDPP*A.Kurs) TotDPPRp, 

	sum(B.NPPN*A.Kurs) TotPPNRp, sum(B.NNet*A.Kurs) TotNetRp

From dbSO A

Left Outer Join dbSODet B on B.NoBukti=A.NoBukti

Left Outer Join  dbCustSupp C on c.KodeCustSupp=a.KODECUST  

Group By A.NoBukti, A.Tanggal, A.KODECUST, C.NAMACUSTSUPP, C.Kota,

	A.Handling, isnull(A.IsBatal,0);

-- vwMasterUbahKemasan
CREATE VIEW IF NOT EXISTS vwMasterUbahKemasan AS Select Devisi,a.nobukti+' Tanggal : '+convert(varchar(10),a.tanggal,105) as GroupNobukti, 

       A.Nobukti, A.NOURUT, a.Tanggal, A.NOTE, A.IsCetak, A.NilaiCetak,

       A.IsOtorisasi1, A.OtoUser1, A.TglOto1,

       A.IsOtorisasi2, A.OtoUser2, A.TglOto2,

       A.IsOtorisasi3, A.OtoUser3, A.TglOto3,

       A.IsOtorisasi4, A.OtoUser4, A.TglOto4,

       A.IsOtorisasi5, A.OtoUser5, A.TglOto5

From  DBUBAHKEMASAN A;

-- vwMesin
CREATE VIEW IF NOT EXISTS vwMesin AS Select * from DBMESIN;

-- vwOSBarang
CREATE VIEW IF NOT EXISTS vwOSBarang AS select a.Kodebrg,Isnull(SUM(a.QNT*isi),0)QntBPPB,Isnull(b.Qnt,0)QntBP,Isnull(SUM(a.QNT*isi),0)-Isnull(b.Qnt,0)OSBP,isnull(e.Sisa,0)OSPPL,Isnull(f.sisa,0)OSPO from DBBPPBDET a 

left Outer Join (select Kodebrg,SUM(Qnt*isi)Qnt from DBPenyerahanBhnDET group by kodebrg)b On b.kodebrg=a.KodeBrg 

Left Outer join (select a.kodebrg,SUM(a.Qnt*isi)QntPPL,Isnull(b.Qnt,0) QntPO,SUM(a.Qnt*isi)-Isnull(b.Qnt,0)sisa from DBPPLDET a

                 Left Outer Join (select NoPPL,Kodebrg,SUM(Qnt*isi)Qnt from DBPODET group by NoPPL,Kodebrg)b On a.Nobukti=b.NoPPL and a.kodebrg=b.KODEBRG

                 group by a.kodebrg,b.Qnt

                 having SUM(a.Qnt*isi)-Isnull(b.Qnt,0)<>0)e on e.KODEBRG=a.KODEBRG

Left Outer Join (select a.kodebrg,SUM(a.Qnt*isi)QntPO,Isnull(b.Qnt,0)QntBeli,SUM(a.Qnt*isi)-isnull(b.Qnt,0)sisa from DBPODET a

                 left Outer Join (select NoPO,Kodebrg,SUM(Qnt*isi)Qnt from DBBELIDET Group by NoPO,KODEBRG)b On a.NOBUKTI=b.NoPO and a.KODEBRG=b.KODEBRG

                 group by a.KodeBrg,b.Qnt

                 having SUM(a.Qnt*isi)-isnull(b.Qnt,0)<>0)f On f.KODEBRG=a.KODEBRG                 

group by a.KodeBrg,b.Qnt,e.Sisa,f.sisa

having (Isnull(SUM(a.QNT*isi),0)-Isnull(b.Qnt,0))-Isnull(e.Sisa,0)-Isnull(f.sisa,0)>0;

-- vwOutBP_Inspeksi
CREATE VIEW IF NOT EXISTS vwOutBP_Inspeksi AS select	A.Nobukti, A.urut, A.NOPO, A.URUTPO, A.kodebrg, A.Sat_1, A.Sat_2, A.Isi, A.Qnt, A.Qnt2, 

	0.00 QntBatal, 0.00 Qnt2Batal, isnull(C.QntIns,0) QntIns, isnull(C.Qnt2Ins,0) Qnt2Ins,

	A.Qnt-isnull(C.QntIns,0) QntSisaIns, A.Qnt2-isnull(C.Qnt2Ins,0) Qnt2SisaIns,

	A.Qnt-isnull(C.QntIns,0) QntSisa, A.Qnt2-isnull(C.Qnt2Ins,0) Qnt2Sisa, A.Nosat

from 	DBBELIDET A

left outer join (select NOBUKTI,URUT, NoPPL, UrutPPL, KodeBrg, sum(Qnt) QntPO, sum(Qnt2) Qnt2Po

	              from DBPODET

	              group by NOBUKTI,URUT, NoPPL, UrutPPL, KodeBrg ) B on B.NOBUKTI=A.NOPO and B.URUT=A.URUTPO

left outer join (select NoBP, UrutBP, KodeBrg, sum(Qnt1) QntIns, sum(Qnt2) Qnt2Ins

	              from dbInspeksiDet

	              group by NoBP, UrutBP, KodeBrg

	) C on C.NoBP=A.NoBukti and C.UrutBP=A.Urut

left outer join dbPPLDet P on P.NoBukti=B.NOPPL and P.Urut=B.UrutPPL

left outer join dbPermintaanBrgDet P2 on P2.NoBukti=P.NoPermintaan and P2.Urut=P.UrutPermintaan

where	P2.IsInspeksi=1;

-- vwOutBPPB
CREATE VIEW IF NOT EXISTS vwOutBPPB AS Select A.NOBUKTI, A.TANGGAL, B.URUT, B.KODEBRG, A.KodeGdg, A.KodeGdgT, B.QNT, B.Qnt2, B.NOSAT, B.ISI, B.SATUAN,

       ISNULL(C.Qnt,0) QntBPPBT, ISNULL(C.Qnt2,0) Qnt2BPPBT,

       (B.QNT-ISNULL(C.Qnt,0)) QntSisa, 

       (B.QNT2-ISNULL(C.Qnt2,0)) Qnt2Sisa

From DBBPPB A

     Left Outer join DBBPPBDET B on B.NOBUKTI=A.NOBUKTI

     left Outer join (Select x.NoBPPB, x.UrutBPPB, x.NOSAT, x.ISI, SUM(x.QNT) Qnt, SUM(x.Qnt2) Qnt2

                      from DBBPPBTDET x

                      Group by x.NoBPPB, x.UrutBPPB, x.NOSAT, x.ISI) C on C.NoBPPB=A.NOBUKTI and C.UrutBPPB=B.URUT

     left Outer join dbbarang BR on BR.KODEBRG=B.KODEBRG

Where Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                       Case when A.IsOtorisasi2=1 then 1 else 0 +

                       Case when A.IsOtorisasi3=1 then 1 else 0 +

                       Case when A.IsOtorisasi4=1 then 1 else 0 +

                       Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                  else 1

              As INTEGER)=0 and (B.QNT-ISNULL(C.Qnt,0)>0 or B.Qnt2-ISNULL(c.Qnt2,0)>0);

-- vwOutInspeksi
CREATE VIEW IF NOT EXISTS vwOutInspeksi AS select	A.Nobukti, A.urut, A.kodebrg, A.reject1 Qnt, A.reject2 Qnt2, 

	isnull(C.QntSJ,0) QntSJ, isnull(C.Qnt2SJ,0) Qnt2SJ,

	A.reject1-isnull(C.QntSJ,0) QntSisa, A.reject2-isnull(C.Qnt2SJ,0) Qnt2Sisa

from 	dbInspeksiDet A

left outer join

	(select NoInspek, UrutInspek, KodeBrg, sum(Qnt1) QntSJ, sum(Qnt2) Qnt2SJ

	from dbSPengantarDet

	group by NoInspek, UrutInspek, KodeBrg

	) C on C.NoInspek=A.NoBukti and C.UrutInspek=A.Urut and C.KodeBrg=A.KodeBrg;

-- vwOutInspeksi_RBP
CREATE VIEW IF NOT EXISTS vwOutInspeksi_RBP AS Select A.NOBUKTI,A.urut,A.KODECUSTSUPP, A.TANGGAL,A.KODEBRG,

       A.Sat_1,a.Sat_2,a.Nosat,a.Isi,

       A.Qnt QntIns, A.Qnt2 Qnt2Ins,

       A.OK1, A.OK2, A.Reject1, A.Reject2,

       A.Pending1, A.Pending2,A.NOBP,A.urutBP,C.NOPO,c.URUTPO,

       isnull(B.NOPBL,'') NOPBL,isnull(B.URUTPBL,0) URUTPBL,

       isnull(B.noins,'') NOINS,isnull(B.Urutins,'')URUTINS ,

       isnull(B.qnt,0) QntRBP, isnull(B.qnt2,0) Qnt2RBP,

       isnull(D.qnt,0) QntKNS, 

       isnull(D.qnt2,0) Qnt2KNS,

       isnull(B.qntTukar,0) qntTukar, 

       isnull(B.Qnt2Tukar,0) Qnt2Tukar,

       A.Reject1-isnull(B.qnt,0) QntSisaIns,

       A.Reject2-isnull(B.qnt2,0) Qnt2SisaIns,

       A.Pending1-isnull(D.qnt,0) QntSisaKNS,

       A.Pending2-isnull(D.qnt2,0) Qnt2SisaKNS,

       C.HARGA,C.KODEGDG,C.KODEVLS,C.KURS,C.PPN,C.TIPEBAYAR,C.DISC,C.DISCRP

from (Select A.NOBUKTI,B.URUT, A.KODECUSTSUPP,A.TANGGAL, B.NOBP,B.URUTBP,(B.Qnt1) Qnt, (B.qnt2) Qnt2,

             (B.OK1) OK1, (B.OK2) OK2,

             (B.Reject1) Reject1, (B.Reject2) Reject2,

             (B.Pending1) Pending1, (B.Pending2) Pending2,

             B.KODEBRG,B.Sat_1,B.Sat_2,B.Nosat,B.Isi

      from DBINSPEKSI A

      left outer join DBINSPEKSIDET B on B.NOBUKTI=A.NOBUKTI) A

      Left Outer join (select NOPBL,URUTPBL,NOINS,Urutins, SUM(Qnt) Qnt ,SUM(Qnt2) qnt2, SUM(QntTukar) qntTukar, SUM(QNT2Tukar) Qnt2Tukar 

                       from DBRBELIDET

                       Group by NOPBL,URUTPBL,NOINS,UrutINS) B on B.NOPBL=A.NOBP and B.URUTPBL=A.URUTBP

      Left Outer join (Select a.NOBUKTI,a.URUT,a.NOPO,URUTPO,a.HARGA,B.KODEVLS,B.KURS,B.PPN,B.TIPEBAYAR,B.DISC,B.DISCRP,

                              B.KODEGDG

                       from DBBELIDET A

                       left outer join DBBELI B on B.NOBUKTI=A.NOBUKTI) C On C.NOBUKTI=A.NOBP and C.URUT=A.URUTBP 

      Left Outer join (select NOPBL,URUTPBL,NOINS,Urutins, SUM(Qnt) Qnt ,SUM(Qnt2) qnt2

                       from DBKonsesiDET

                       Group by NOPBL,URUTPBL,NOINS,UrutINS) D on D.NOINS=A.NOBUKTI and D.URUTINS=A.URUT;

-- vwOutInvoicePL_RInvoicePL
CREATE VIEW IF NOT EXISTS vwOutInvoicePL_RInvoicePL AS Select A.KodeBrg, A.NAMABRG, A.NamabrgKom, A.NamaProduk, A.QNT, A.QNT2, A.Qty, A.SAT_1, A.SAT_2, A.Satuan,

       A.ISI, A.NOSAT, A.NetW, A.GrossW, 

       ISNULL(b.qty,0) QtyRetur, ISNULL(b.NetW,0) NetWRetur,

       ISNULL(b.GrossW,0) GrossWRetur, ISNULL(b.Qnt1,0) QntRetur,

       ISNULL(b.Qnt2,0) Qnt2Retur,

       A.Qty-ISNULL(b.qty,0) QtySisa,

       A.QNT-ISNULL(b.Qnt1,0) QntSisa,

       A.QNT2-ISNULL(b.Qnt2,0) Qnt2Sisa,

       A.NetW-ISNULL(b.NetW,0) NetWSisa,

       A.GrossW-ISNULL(b.GrossW,0) GrossWSisa, A.NoBukti, A.Urut, A.HARGA, A.NoSPB

From (    

          Select a.KodeBrg, a.Namabrg NamabrgKom, b.namabrg,

				 'Nama Produk : '+b.Namabrg+CHAR(13)+'Nama Komersil : '+ a.namabrg NamaProduk ,

				 case when a.NOSAT=1 then a.QNT

						when a.NOSAT=2 then a.QNT2

						else 0

				  Qty,

				 case when a.NOSAT=1 then a.SAT_1

						when a.NOSAT=2 then a.SAT_2

						else ''

				  Satuan,

				 a.NetW, a.GrossW, a.QNT, A.QNT2, a.SAT_1, a.SAT_2, a.NOSAT, a.ISI,

				 a.NoBukti, a.Urut, A.HARGA, D.NoBukti NoSPB

		from dbInvoicePLDet a

			  left outer join DBBARANG b on b.KODEBRG=a.KodeBrg

                 left Outer join dbSPBDet D on D.NoBukti=a.NoSPB and D.UrutSPP=a.UrutSPB  

                 Left Outer join dbSPPDet C on c.NoBukti=D.NoSPP and c.Urut=D.UrutSPP

                 

		) A

Left Outer join (Select x.NoInvoice, x.UrutInvoice, SUM(x.QNT) Qnt1, SUM(x.QNT2) Qnt2,

                        SUM(x.netW) NetW, SUM(x.GrossW) GrossW,

                        Sum(case when x.NOSAT=1 then x.QNT

						               when x.NOSAT=2 then x.QNT2

						               else 0

				                ) Qty

                 from DBRInvoicePLDET x

                 Group by x.NoInvoice, x.UrutInvoice) b on b.NoInvoice=A.NoBukti and b.UrutInvoice=A.Urut;

-- vwOutPermintaanBrg
CREATE VIEW IF NOT EXISTS vwOutPermintaanBrg AS SELECT A.Nobukti, A.urut, A.kodebrg, A.Sat_1, A.Sat_2, A.Isi, A.Qnt, A.Qnt2, A.TglTiba, A.isInspeksi, 

       ISNULL(B.QntBPB, 0) AS QntBPB, 

       ISNULL(B.Qnt2BPB, 0) AS Qnt2BPB, 

       ISNULL(c.QntPPL, 0) AS QntPPl, 

       ISNULL(c.Qnt2PPL, 0) AS Qnt2PPL,

       ISNULL(d.QntBBP,0) QntBBP, 

       ISNULL(d.Qnt2BBP,0) Qnt2BBP,

       ISNULL(e.qntBPL,0) AS QntBPL,

       ISNULL(e.Qnt2BPL,0) AS Qnt2BPL, 

       A.Qnt - ISNULL(B.QntBPB, 0)-ISNULL(d.QntBBP, 0) AS QntSisaBPB, 

       A.Qnt2 - ISNULL(B.Qnt2BPB, 0)-ISNULL(d.Qnt2BBP, 0) AS Qnt2SisaBPB, 

       A.Qnt - ISNULL(d.QntBBP, 0) - ISNULL(C.QntPPL,0)+ISNULL(e.QntBPL,0) AS QntSisa, 

       A.Qnt2 - ISNULL(d.Qnt2BBP, 0) - ISNULL(C.Qnt2PPL, 0)+ISNULL(e.Qnt2BPL,0) AS Qnt2Sisa, 

       B.NoPermintaan, A.Nosat, A.Keterangan, F.JnsPakai,

       Case when F.JnsPakai=0 then 'Stock'

				when F.JnsPakai=1 then 'Investasi'

				when F.JnsPakai=2 then 'Rep & Pem Teknik'

				when F.JnsPakai=3 then 'Rep & Pem Komputer'

				when F.JnsPakai=4 then 'Rep & Pem Peralatan'

		  MyJnsPakai,

		 Case when A.Nosat=1 then A.Qnt

            when A.Nosat=2 then A.Qnt2

            else 0

        BPPB_QntBPPB,

       Case when A.Nosat=1 then isnull(d.QntBBP,0)

            when A.Nosat=2 then isnull(d.Qnt2BBP,0)

            else 0

        BPPB_QntBBP,

       Case when A.Nosat=1 then isnull(B.QntBPB,0)

            when A.Nosat=2 then isnull(B.Qnt2BPB,0)

            else 0

        BPPB_QntBPB,

       Case when A.Nosat=1 then isnull(C.QntPPL,0)

            when A.Nosat=2 then isnull(C.Qnt2PPL,0)

            else 0

        BPPB_QntPPL,

       Case when A.Nosat=1 then isnull(e.QntBPL,0)

            when A.Nosat=2 then isnull(e.Qnt2BPL,0)

            else 0

        BPPB_QntBPL,

       Case when A.Nosat=1 then A.Qnt - ISNULL(B.QntBPB, 0)-ISNULL(d.QntBBP, 0)

            when A.Nosat=2 then A.Qnt2 - ISNULL(B.Qnt2BPB, 0)-ISNULL(d.Qnt2BBP, 0)

            else 0

        BPPB_QntSisaBPB,

       Case when A.Nosat=1 then A.Qnt - ISNULL(d.QntBBP, 0) - ISNULL(C.QntPPL,0)+ISNULL(e.QntBPL,0)

            when A.Nosat=2 then A.Qnt2 - ISNULL(d.Qnt2BBP, 0) - ISNULL(C.Qnt2PPL, 0)+ISNULL(e.Qnt2BPL,0)

            else 0

        BPPB_QntSisa,

		 Case when A.Nosat=1 then A.Sat_1

            when A.Nosat=2 then A.Sat_2

            else ''

        BPPB_Satuan

FROM dbo.DBPermintaanBrgDET AS A 

LEFT OUTER JOIN (SELECT x.NoPermintaan, x.UrutPermintaan, x.kodebrg, SUM(x.Qnt) AS QntBPB, SUM(x.Qnt2) AS Qnt2BPB

                 FROM dbo.DBPenyerahanBrgDET x

                 GROUP BY x.NoPermintaan, x.UrutPermintaan, x.kodebrg) AS B ON B.NoPermintaan = A.Nobukti AND B.UrutPermintaan = A.urut AND 

                 B.kodebrg = A.kodebrg 

LEFT OUTER JOIN (SELECT x.NoPermintaan, x.UrutPermintaan, x.kodebrg, 

                 SUM(x.Qnt) AS QntPPL, 

                 SUM(x.Qnt2) AS Qnt2PPL

                 FROM dbo.DBPPLDET AS x 

                 GROUP BY x.NoPermintaan, x.UrutPermintaan, x.kodebrg) AS c ON c.NoPermintaan = A.Nobukti AND c.UrutPermintaan = A.urut AND 

                      c.kodebrg = A.kodebrg

LEFT Outer join (select x.NoBPPB, x.UrutBPPB, x.kodebrg,

                        SUM(x.Qnt) QntBBP, SUM(x.Qnt2) Qnt2BBP

                 from  DBBatalMintaBrgDet x

                 group by x.NoBPPB, x.UrutBPPB, x.kodebrg) d on d.NoBPPB=A.Nobukti and d.UrutBPPB=A.urut  

LEFT OUTER JOIN (SELECT y.NoPermintaan, y.UrutPermintaan, x.kodebrg, 

                 SUM(x.Qnt) AS QntBPL, 

                 SUM(x.Qnt2) AS Qnt2BPL

                 FROM dbo.DBBatalPPLDET AS x

                      left outer join (Select y.NoPermintaan,y.UrutPermintaan,y.kodebrg, y.Nobukti,y.urut

                                       From DBPPLDET y 

                                       Group by y.NoPermintaan,y.UrutPermintaan,y.kodebrg, y.Nobukti,y.urut) y on y.Nobukti=x.NoPPL and y.urut=x.UrutPPL

                 GROUP BY y.NoPermintaan, y.UrutPermintaan, x.kodebrg) AS e ON e.NoPermintaan = A.Nobukti AND e.UrutPermintaan = A.urut AND 

                      c.kodebrg = A.kodebrg

Left Outer join DBPermintaanBrg F on F.Nobukti=A.Nobukti;

-- vwOutPO
CREATE VIEW IF NOT EXISTS vwOutPO AS select	A.Nobukti, A.urut, A.NoPPL, A.UrutPPL, A.kodebrg, A.Sat_1, A.Sat_2, A.Isi, A.Qnt, A.Qnt2, 

	      isnull(B.QntBatal,0) QntBatal, isnull(B.Qnt2Batal,0) Qnt2Batal, 

	      isnull(C.QntBeli,0) QntBeli, isnull(C.Qnt2Beli,0) Qnt2Beli,

	      A.Qnt-isnull(C.QntBeli,0) QntSisaBeli, 

	      A.Qnt2-isnull(C.Qnt2Beli,0) Qnt2SisaBeli,

	      A.Qnt-isnull(B.QntBatal,0)-isnull(C.QntBeli,0)+ISNULL(C.QntTukar,0) QntSisa, 

	      A.Qnt2-isnull(B.Qnt2Batal,0)-isnull(C.Qnt2Beli,0)+ISNULL(C.Qnt2Tukar,0) Qnt2Sisa,

	      ISNULL(C.QntTukar,0) QntTukar, ISNULL(C.Qnt2Tukar,0) Qnt2Tukar

from 	dbPODet A

left outer join

	(Select NoPO, UrutPO, KodeBrg, sum(Qnt) QntBatal, sum(Qnt2) Qnt2Batal

	 from dbBatalPODet

	 group by NoPO, UrutPO, KodeBrg) B on B.NoPO=A.NoBukti and B.UrutPO=A.Urut and B.KodeBrg=A.KodeBrg

left outer join

	(select x.NoPO, x.URUTPO, x.KODEBRG, sum(Qnt) QntBeli, sum(Qnt2) Qnt2Beli, sum(y.QntTukar) QntTukar, sum(y.Qnt2Tukar) Qnt2Tukar

	 from dbBeliDet x

	      left outer join(select NOPBL, URUTPBL, KodeBrg, sum(QNTTukar) QntTukar, sum(QNT2Tukar) Qnt2Tukar

	                      from DBRBELIDET A 

	                      group by NOPBL, URUTPBL, KodeBrg) y on y.NOPBL=x.NoBukti and y.URUTPBL=x.Urut

	 group by x.NOPO, x.URUTPO, x.KODEBRG) C on C.NoPO=A.NoBukti and C.UrutPO=A.Urut and C.KodeBrg=A.KODEBRG;

-- vwOutPO_BP
CREATE VIEW IF NOT EXISTS vwOutPO_BP AS select	A.NoBukti, A.Urut, A.NoPPL, A.UrutPPL, '' NoInspeksi, 0 UrutInspeksi, A.KodeBrg, A.Sat_1, A.Sat_2, A.Isi, A.Qnt, A.Qnt2, 

	isnull(B.QntBatal,0) QntBatal, isnull(B.Qnt2Batal,0) Qnt2Batal, 

	isnull(C.QntBeli,0) QntBeli, isnull(C.Qnt2Beli,0) Qnt2Beli,

	A.Qnt-isnull(C.QntBeli,0)+ISNULL(D.QntTukar,0) QntSisaBeli, 

	A.Qnt2-isnull(C.Qnt2Beli,0)+ISNULL(D.Qnt2Tukar,0) Qnt2SisaBeli,

	A.Qnt-isnull(B.QntBatal,0)-isnull(C.QntBeli,0)+ISNULL(D.QntTukar,0) QntSisa, 

	A.Qnt2-isnull(B.Qnt2Batal,0)-isnull(C.Qnt2Beli,0)+ISNULL(D.Qnt2Tukar,0) Qnt2Sisa,

	A.Nosat,A.Catatan

from 	dbPODet A

left outer join

	(

	select NoPO, UrutPO, KodeBrg, sum(Qnt) QntBatal, sum(Qnt2) Qnt2Batal

	from dbBatalPODet

	group by NoPO, UrutPO, KodeBrg

	) B on B.NoPO=A.NoBukti and B.UrutPO=A.Urut and B.KodeBrg=A.KodeBrg

left outer join

	(select NoPO, UrutPO, KodeBrg, sum(Qnt) QntBeli, sum(Qnt2) Qnt2Beli

	from dbBeliDet

	group by NoPO, UrutPO, KodeBrg

	) C on C.NoPO=A.NoBukti and C.UrutPO=A.Urut and C.KodeBrg=A.KodeBrg

Left outer join (Select y.NOPO,y.URUTPO,SUM(QNTTUKAR) QntTukar, SUM(Qnt2Tukar) Qnt2Tukar

                 from DBRBELIDET x

                 left Outer Join DBBELIDET y on y.NOBUKTI=x.NOPBL and y.URUT=x.URUTPBL

                 Group by y.NOPO,y.URUTPO) D on D.NOPO=C.NOPO and D.URUTPO=C.URUTPO;

-- vwOutPO_Inspeksi
CREATE VIEW IF NOT EXISTS vwOutPO_Inspeksi AS select	A.Nobukti, A.urut, A.NoPPL, A.UrutPPL, A.kodebrg, A.Sat_1, A.Sat_2, A.Isi, A.Qnt, A.Qnt2, 

	isnull(B.QntBatal,0) QntBatal, isnull(B.Qnt2Batal,0) Qnt2Batal, isnull(C.QntIns,0) QntIns, isnull(C.Qnt2Ins,0) Qnt2Ins,

	A.Qnt-isnull(C.QntIns,0) QntSisaIns, A.Qnt2-isnull(C.Qnt2Ins,0) Qnt2SisaIns,

	A.Qnt-isnull(B.QntBatal,0)-isnull(C.QntIns,0) QntSisa, A.Qnt2-isnull(B.Qnt2Batal,0)-isnull(C.Qnt2Ins,0) Qnt2Sisa, A.Nosat

from 	dbPODet A

left outer join

	(

	select NoPO, UrutPO, KodeBrg, sum(Qnt) QntBatal, sum(Qnt2) Qnt2Batal

	from dbBatalPODet

	group by NoPO, UrutPO, KodeBrg

	) B on B.NoPO=A.NoBukti and B.UrutPO=A.Urut and B.KodeBrg=A.KodeBrg

left outer join

	(select NoPO, UrutPO, KodeBrg, sum(Qnt1) QntIns, sum(Qnt2) Qnt2Ins

	from dbInspeksiDet

	group by NoPO, UrutPO, KodeBrg

	) C on C.NoPO=A.NoBukti and C.UrutPO=A.Urut and C.KodeBrg=A.KodeBrg

left outer join dbPPLDet P on P.NoBukti=A.NOPPL and P.Urut=A.UrutPPL

left outer join dbPermintaanBrgDet P2 on P2.NoBukti=P.NoPermintaan and P2.Urut=P.UrutPermintaan

where	P2.IsInspeksi=1;

-- vwOutPOBatal
CREATE VIEW IF NOT EXISTS vwOutPOBatal AS select c.TANGGAL,A.Nobukti, NAMACUSTSUPP,a.urut, A.NoPPL, A.UrutPPL, A.kodebrg, A.Satuan,A.Isi, A.Qnt, 

	      isnull(B.QntBatal,0) QntBatal, case when Isnull(A.NamaBrg,'')=d.NamaBrg Then d.NamaBrg when Isnull(A.NamaBrg,'')='' Then d.NamaBrg else A.NamaBrg  NamaBrg,

	      A.Qnt-isnull(e.QntTerima,0) QntSisa, QntTerima

	 

from 	dbPODet A

left outer join DBPO c on c.NOBUKTI =a.NOBUKTI 

left outer join DBBARANG d on d.KODEBRG =a.KODEBRG 

left Outer join DBCUSTSUPP f on f.KODECUSTSUPP=c.KODESUPP



left outer join

	(Select NOBUKTI , Urut, KodeBrg, sum(QntBatal ) QntBatal

	 from dbPODet

	 group by NOBUKTI, Urut, KodeBrg) B on B.NOBUKTI=A.NoBukti and B.Urut=A.Urut and B.KodeBrg=A.KodeBrg

left outer join

	(Select NoPO , UrutPO, KodeBrg, sum(Qnt ) QntTerima

	 from dbbelidet

	 group by NOpo, Urutpo, KodeBrg) e on e.NoPO =A.NoBukti and e.UrutPO=A.Urut and e.KodeBrg=A.KodeBrg	 

where

Cast(Case when Case when c.IsOtorisasi1=1 then 1 else 0 +

                       Case when c.IsOtorisasi2=1 then 1 else 0 +

                       Case when c.IsOtorisasi3=1 then 1 else 0 +

                       Case when c.IsOtorisasi4=1 then 1 else 0 +

                       Case when c.IsOtorisasi5=1 then 1 else 0 =c.MaxOL then 0

                  else 1

              As INTEGER)=0;

-- vwOutPPL
CREATE VIEW IF NOT EXISTS vwOutPPL AS select	A.Devisi,A.Nobukti, A.NoUrut, A.Tanggal,c.NMDEP, 

B.urut, B.kodebrg, Case When Isnull(BR.IsJasa,0)=0 Then Br.NAMABRG else B.NamaBrg  NamaBrg, B.Sat, B.Nosat, B.Isi, B.Qnt, Isnull(B.QntPO,0)QntPO, B.Keterangan, isnull(B.Qnt,0)-Isnull(B.QntPO,0)-Isnull(B.Qntbatal,0) SisaPPL, B.IsClose,br.tolerate

,B.Qnt-isnull(e.QntTerima,0) QntSisa, QntTerima,B.QntBatal,B.Tglbatal,B.IsBatal,B.userbatal,

A.IsOtorisasi1, A.OtoUser1, A.TglOto1,

       A.IsOtorisasi2, A.OtoUser2, A.TglOto2,

       A.IsOtorisasi3, A.OtoUser3, A.TglOto3,

       A.IsOtorisasi4, A.OtoUser4, A.TglOto4,

       A.IsOtorisasi5, A.OtoUser5, A.TglOto5,

       Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                      Case when A.IsOtorisasi2=1 then 1 else 0 +

                      Case when A.IsOtorisasi3=1 then 1 else 0 +

                      Case when A.IsOtorisasi4=1 then 1 else 0 +

                      Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                 else 1

             As INTEGER) NeedOtorisasi

from	DBPPL A

left outer join DBPPLDET B on B.Nobukti=A.Nobukti

left outer join DBBARANG Br on Br.KODEBRG=B.kodebrg

left outer join DBDEPART c on c.KDDEP=a.KDDep

left outer join

	(Select NoPPL , UrutPPL, KodeBrg, sum(Qnt ) QntTerima

	 from DBPODET

	 group by NoPPL, UrutPPL, KodeBrg) e on e.NoPPL =B.NoBukti and e.UrutPPL=B.Urut and e.KodeBrg=B.KodeBrg	 

where B.Qnt-Isnull(B.QntPO,0)>0.01 and a.IsOtorisasi1 =1 and isnull(B.Isbatal,0)=0;

-- vwOutPPLBatal
CREATE VIEW IF NOT EXISTS vwOutPPLBatal AS select	A.Nobukti, A.NoUrut, A.Tanggal,c.NMDEP, 

B.urut, B.kodebrg, Case When Isnull(BR.IsJasa,0)=0 Then Br.NAMABRG else B.NamaBrg  NamaBrg, B.Sat, B.Nosat, B.Isi, B.Qnt, Isnull(e.QntTerima,B.QntPO)QntPO, B.Keterangan, isnull(B.Qnt,0)-Isnull(e.QntTerima,B.QntPO)-Isnull(B.Qntbatal,0) SisaPPL, B.IsClose,br.tolerate

,B.Qnt-isnull(e.QntTerima,B.QntPO)-Isnull(B.Qntbatal,0) QntSisa, QntTerima,B.QntBatal,B.Tglbatal,B.IsBatal,B.userbatal,

A.IsOtorisasi1, A.OtoUser1, A.TglOto1,

       A.IsOtorisasi2, A.OtoUser2, A.TglOto2,

       A.IsOtorisasi3, A.OtoUser3, A.TglOto3,

       A.IsOtorisasi4, A.OtoUser4, A.TglOto4,

       A.IsOtorisasi5, A.OtoUser5, A.TglOto5,

       Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                      Case when A.IsOtorisasi2=1 then 1 else 0 +

                      Case when A.IsOtorisasi3=1 then 1 else 0 +

                      Case when A.IsOtorisasi4=1 then 1 else 0 +

                      Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                 else 1

             As INTEGER) NeedOtorisasi,Convert(DateTime,TglOto1)+day(DATEADD(dd,-DAY(DATEADD(mm,1,Convert(DateTime,TglOto1))), DATEADD(mm,1,Convert(DateTime,TglOto1))) ) Tglexp,ISNULL(Alasan,'')Alasan

from	DBPPL A

left outer join DBPPLDET B on B.Nobukti=A.Nobukti

left outer join DBBARANG Br on Br.KODEBRG=B.kodebrg

left outer join DBDEPART c on c.KDDEP=a.KDDep

left outer join

	(Select NoPPL , UrutPPL, KodeBrg, sum(Qnt-ISNULL(QntBatal,0)) QntTerima

	 from DBPODET

	 group by NoPPL, UrutPPL, KodeBrg) e on e.NoPPL =B.NoBukti and e.UrutPPL=B.Urut and e.KodeBrg=B.KodeBrg	 

where isnull(B.Qnt,0)-Isnull(e.QntTerima,B.QntPO)>0

and isnull(B.Qnt,0)-Isnull(B.QntPO,0)>0

 and a.IsOtorisasi1 =1;

-- vwOutRJual
CREATE VIEW IF NOT EXISTS vwOutRJual AS select	A.NoBukti, A.Urut, A.KodeBrg,  A.Sat_1, A.Sat_2, A.NoSat, A.Isi, A.Qnt, A.Qnt2, 

	isnull(C.QntSPB,0) QntSPB, isnull(C.Qnt2SPB,0) Qnt2SPB,

	A.Qnt-isnull(C.QntSPB,0) QntSisa, A.Qnt2-isnull(C.Qnt2SPB,0) Qnt2Sisa,

     a.NetW, A.GrossW, A.NoInvoice, A.UrutInvoice, A.NamaBrg, B.IsFLag

from 	DBRInvoicePLDET A

left outer join

	(select NoRPJ, UrutRPJ, KodeBrg, sum(Qnt) QntSPB, sum(Qnt2) Qnt2SPB

	 from dbSPBRjualDet

	 group by NoRPJ, UrutRPJ, KodeBrg) C on C.NoRpj=A.NoBukti and C.UrutRPJ=A.Urut and C.KodeBrg=A.KodeBrg

	Left Outer Join DBRInvoicePL B on B.NoBukti=A.NoBukti;

-- vwOutRSPB
CREATE VIEW IF NOT EXISTS vwOutRSPB AS select	A.NoBukti, A.Urut, A.KodeBrg, A.NamaBrg, A.Sat_1, A.Sat_2, A.NoSat, A.Isi, A.Qnt Qnt, A.Qnt2 Qnt2, 

	isnull(C.QntSPB,0) QntSPB, isnull(C.Qnt2SPB,0) Qnt2SPB,

	A.Qnt-isnull(C.QntSPB,0) QntSisa, A.Qnt2-isnull(C.Qnt2SPB,0) Qnt2Sisa,

	A.NetW,A.GrossW, 'Ekspor' TipeSPP, B.Catatan, B.isClose, 

     Case when A.NOSAT=1 then A.SAT_1

          when A.NOSAT=2 then A.SAT_2

          else ''

      Satuan

from 	DBRSPBDet A

Left Outer Join DBRSPB B1 ON A.NoBukti=B1.NoBukti

left outer join

	(select NoSPP, UrutSPP, a.KodeBrg, sum(a.QNT) QntSPB, sum(a.QNT2) Qnt2SPB

	from dbSPBDet a

	group by NoSPP, UrutSPP, a.KodeBrg

	) C on C.NoSPP=A.NoBukti and C.UrutSPP=A.Urut and C.KodeBrg=A.KodeBrg

	Left Outer Join dbSPP B on B.NoBukti=A.NoBukti

where Isnull(B1.IsTukarBrg,0)=1;

-- vwOutSC
CREATE VIEW IF NOT EXISTS vwOutSC AS Select a.Nobukti, b.Urut, b.Sat_1, b.Sat_2, b.Isi, b.Nosat, b.Qnt, b.Qnt2,

       b.Kodebrg, isnull(C.Qnt,0) QntSC, isnull(C.Qnt2,0) Qnt2SC,

       b.Qnt-isnull(C.Qnt,0) QntSisa,

       b.Qnt2-isnull(C.Qnt2,0) Qnt2Sisa

from dbSalesContract a

     left outer join dbSalesContractDet b on b.Nobukti=a.Nobukti

     left outer join (Select NoSC,UrutSC, SUM(Qnt) Qnt, SUM(Qnt2) Qnt2

                      from DBSHIPPINGDET 

                      group by NoSC,UrutSC) C on C.NoSC=a.Nobukti and C.UrutSC=b.Urut;

-- vwOutSC_SPP
CREATE VIEW IF NOT EXISTS vwOutSC_SPP AS select	A.NoBukti, A.Urut, A.KodeBrg, A.Sat_1, A.Sat_2, A.NoSat, A.Isi, A.Qnt, A.Qnt2, 

	isnull(C.QntSPP,0) QntSPP, isnull(C.Qnt2SPP,0) Qnt2SPP,

	A.Qnt-isnull(C.QntSPP,0) QntSisa, A.Qnt2-isnull(C.Qnt2SPP,0) Qnt2Sisa,

	A.NamaBrg NamabrgKom

from 	dbSalesContractDet A

left Outer Join (select NoSC, UrutSC, KodeBrg, sum(Qnt) QntSPP, sum(Qnt2) Qnt2SPP

	              from dbSPPLokalDet

	              group by NoSC, UrutSC, KodeBrg) C on C.NoSC=A.NoBukti and C.UrutSC=A.Urut and C.KodeBrg=A.KodeBrg

Left Outer Join dbSalesContract B on B.Nobukti=A.Nobukti	              

where B.IsLokal=0;

-- vwOutSHIP
CREATE VIEW IF NOT EXISTS vwOutSHIP AS select	A.NoBukti, A.Urut, A.KodeBrg, A.NamaBrg, A.Sat_1, A.Sat_2, A.NoSat, A.Isi,isnull(B.Qnt,0) Qnt, 

   isnull(B.Qnt2,0) Qnt2, 

	isnull(B.Qnt,0) QntSPB, isnull(B.Qnt2,0) Qnt2SPB,

	isnull(B.Qnt,0)-isnull(C.QntSPB,0) QntSisa, isnull(B.Qnt2,0)-isnull(C.Qnt2SPB,0) Qnt2Sisa,

	B.NetW,B.GrossW, A.NoSC

from 	DBSHIPPINGDET A

left outer join (select NoShip, UrutSHIP, KodeBrg, sum(Qnt) QntSPB, sum(Qnt2) Qnt2SPB

	              from dbInvoicePLDet

	              group by NoSHIP, UrutSHIP, KodeBrg) C on C.NoSHIP=A.NoBukti and C.UrutSHIP=A.Urut

Left Outer Join (Select x.NoSHIP,x.UrutSHIP, SUM(y.QNT) Qnt, SUM(y.qnt2) Qnt2,

                             sum(y.NetW) NetW, SUM(y.GrossW) GrossW

                 from dbSPPDet x

                      left Outer Join dbSPBDet y on y.NoSPP=x.NoBukti and y.UrutSPP=x.Urut

                 group by x.NoSHIP, x.UrutSHIP) B on B.NoSHIP=A.Nobukti and B.UrutSHIP=A.Urut   

left Outer join DBSHIPPING D on D.NoBukti=A.Nobukti

where D.isclose=1;

-- vwOutSHIP_SPP
CREATE VIEW IF NOT EXISTS vwOutSHIP_SPP AS select A.NoBukti, A.Urut, A.KodeBrg, A.Sat_1, A.Sat_2, A.NoSat, A.Isi, A.Qnt, A.Qnt2, 

	    isnull(C.QntSPP,0) QntSPP, isnull(C.Qnt2SPP,0) Qnt2SPP,

	    A.Qnt-isnull(C.QntSPP,0) QntSisa, A.Qnt2-isnull(C.Qnt2SPP,0) Qnt2Sisa,

	    A.NoSC, A.Namabrg NamabrgKom, A.shippingMark

from 	DBSHIPPINGDET A

left outer join(select NoSHIP, UrutSHIP, KodeBrg, sum(Qnt) QntSPP, sum(Qnt2) Qnt2SPP

	             from dbSPPDet

	             group by NoSHIP, UrutSHIP, KodeBrg) C on C.NoSHIP=A.NoBukti and C.UrutSHIP=A.Urut 

left Outer join (Select Nobukti

                 from dbSalesContract) D on D.Nobukti=A.NoSC;

-- vwOutSO_InvoicePL
CREATE VIEW IF NOT EXISTS vwOutSO_InvoicePL AS select A.NoBukti, A.Urut, A.KodeBrg, A.SATUAN, A.NoSat, A.Isi, A.Qnt, A.Qnt2, 

	    isnull(C.QntSPP,0) QntSPP, isnull(C.Qnt2SPP,0) Qnt2SPP,

	    A.Qnt-isnull(C.QntSPP,0) QntSisa, A.Qnt2-isnull(C.Qnt2SPP,0) Qnt2Sisa,

	    B.CATATAN, D.Namabrg NamabrgKom, B.IsLengkap, B.MasaBerlaku,A.QNTBATAL,A.Isclose

	    ,A.UserClose,A.tglClose,A.ketBatal

from 	DBSODET A

Left Outer join DBSO B on b.NOBUKTI=A.NOBUKTI

left outer join(select NoSPB NoSO, UrutSPB UrutSO, KodeBrg, sum(Qnt) QntSPP, sum(Qnt2) Qnt2SPP

	             from dbInvoicePLDet

	             group by NoSPB, UrutSPB, KodeBrg) C on C.NoSO=A.NoBukti and C.UrutSo=A.Urut 

Left Outer join DBBARANG D on D.KODEBRG=A.KODEBRG



--select * from dbInvoicePLDet;

-- vwOutSO_SPP
CREATE VIEW IF NOT EXISTS vwOutSO_SPP AS select A.NoBukti, A.Urut, A.KodeBrg, A.SATUAN, A.NoSat, A.Isi, A.Qnt, A.Qnt2, 

	    isnull(C.QntSPP,0) QntSPP, isnull(C.Qnt2SPP,0) Qnt2SPP,

	    A.Qnt-ISNULL(A.QntBatal,0)-isnull(C.QntSPP,0) QntSisa, A.Qnt2-ISNULL(A.QntBatal,0)-isnull(C.Qnt2SPP,0) Qnt2Sisa,

	    B.CATATAN, D.Namabrg NamabrgKom, B.IsLengkap, B.MasaBerlaku,A.QNTBATAL,A.Isclose

	    ,A.UserClose,A.tglClose,A.ketBatal,B.PPN,Pr.NAMAPROJECT

from 	DBSODET A

Left Outer join DBSO B on b.NOBUKTI=A.NOBUKTI

left outer join(select NoSO, UrutSO, KodeBrg, sum(Qnt) QntSPP, sum(Qnt2) Qnt2SPP

	             from dbSPPDet

	             group by NoSO, UrutSO, KodeBrg) C on C.NoSO=A.NoBukti and C.UrutSo=A.Urut 

Left Outer join DBBARANG D on D.KODEBRG=A.KODEBRG

Left Outer Join DBPROJECT Pr On Pr.KODEPROJECT=B.AlamatKirim;

-- vwOutSPB
CREATE VIEW IF NOT EXISTS vwOutSPB AS With InvoicePL(NoInvoice, Kodecust, NoSPB, UrutSPB, Qnt, Qnt2)

AS

(Select A.NoBukti, a.KodeCustSupp, B.NoSPB, B.UrutSPB, Sum(B.QNT) Qnt, Sum(B.QNT2) Qnt2

 From dbInvoicePL A

      Left Outer join dbInvoicePLDet B on b.NoBukti=A.NoBukti

 Group by A.NoBukti, a.KodeCustSupp, B.NoSPB, B.UrutSPB)



Select A.NoBukti, B.KodeBrg, B.ISI, B.NOSAT,

       Case when B.NOSAT=1 then B.SAT_1 

            when B.NOSAT=2 then B.SAT_2

            else ''

        Satuan, B.qnt, B.QNT2, B.NetW, B.GrossW,

       ISNULL(c.qnt,0) QntInv,

       B.QNT-ISNULL(c.qnt,0) Sisa       

From dbSPB a

     Left Outer join dbSPBDet b on b.NoBukti=a.NoBukti 

     left Outer join InvoicePL c on c.NoSPB=b.NoBukti and c.UrutSPB=b.urut

where B.QNT-ISNULL(c.qnt,0)>0;

-- vwOutSPB_RSPB
CREATE VIEW IF NOT EXISTS vwOutSPB_RSPB AS select X.Devisi,X.NoBukti, X.Tanggal,(X.KodeGdg)Kodegdg, X.KodeCustSupp, Cs.NAMACUSTSUPP, X.NoSPP, X.Urut, X.KodeBrg, Br.NAMABRG, 

SUM(X.QNT) Qnt, SUM(X.QntInv) QntInv, SUM(X.QntRetur) QntRetur, SUM(X.QntSisa) QntSisa,SUM(X.Qnt2Sisa)Qnt2Sisa,NOSAT,SAT_1,ISI,SAT_2

from

	(

	select A.Devisi,A.NoBukti, A.Tanggal,B.KodeGdg, A.KodeCustSupp, A.NoSPP, B.Urut, B.KodeBrg,  B.QNT Qnt,B.QNT2, 0 QntInv,0 Qnt2Inv, 0 QntRetur,0 Qnt2Retur,  B.QNT  QntSisa,B.QNT2 Qnt2Sisa,NOSAT, B.SAT_1  SAT_1,SAT_2,ISI

	from dbSPB A, dbSPBDet B

	where B.NoBukti=A.NoBukti and ISNULL(A.IsClose,0)=0

	union all

	select A.Devisi,A.NoBukti, A.Tanggal,X.KodeGdg, A.KodeCustSupp, A.NoSPP, B.UrutSPB, B.KodeBrg, 0 QNT,0,  B.QNT+Isnull(B.QntKoreksi,0)  QntInv,B.QNT2, 0 QntRetur,0, -1*( B.QNT+Isnull(B.QntKoreksi,0) ),-1*(B.QNT2+Isnull(B.QntKoreksi,0)) Qnt2Sisa,B.NOSAT, B.SAT_1  SAT_1,B.SAT_2,B.ISI 

	from dbSPB A, dbInvoicePLDet B,dbSPBDet X,dbInvoicePL Y

	where B.NoSPB=A.NoBukti and A.NoBukti=X.NoBukti and X.Urut=B.UrutSPB and ISNULL(A.IsClose,0)=0 and B.NoBukti=Y.NoBukti and ISNULL(Y.IsBatal,0)=0

	/*

	select A.Devisi,A.NoBukti, A.Tanggal,X.KodeGdg, A.KodeCustSupp, A.NoSPP, B.UrutSPB, B.KodeBrg, 0 QNT,0,  B.QNT+Isnull(B.QntKoreksi,0)-ISNULL(Y2.QNT,0)  QntInv,B.QNT2-ISNULL(Y2.QNT2,0) , 0 QntRetur,0, -1*( B.QNT+Isnull(B.QntKoreksi,0)-ISNULL(Y2.QNT,0) ),-1*(B.QNT2+Isnull(B.QntKoreksi,0)-ISNULL(y2.QNT2,0)) Qnt2Sisa,B.NOSAT, B.SAT_1  SAT_1,B.SAT_2,B.ISI 

	from dbSPB A 

	Left Outer Join dbSPBDet X on  A.NoBukti=X.NoBukti

	Left Outer Join dbInvoicePLDet B on B.NoSPB=A.NoBukti  and X.Urut=B.UrutSPB

	Left Outer Join dbInvoicePL Y on  B.NoBukti=Y.NoBukti 

	Left Outer Join DBRInvoicePLDET Y2 on Y2.NoInvoice=Y.NoBukti and Y2.UrutInvoice=B.Urut

	where ISNULL(A.IsClose,0)=0  and ISNULL(Y.IsBatal,0)=0*/

	union all

	select A.Devisi,A.NoBukti, A.Tanggal,X.Kodegdg, A.KodeCustSupp, A.NoSPP, B.UrutSPB, B.KodeBrg, 0 QNT,0, 0 QntInv,0,  B.QNT  QntRetur,0, -1* B.QNT ,-B.QNT2,B.NOSAT, B.SAT_1  SAT_1,B.SAT_2,B.ISI 

	from dbSPB A, DBRSPBDet B,dbSPBDet X

	where B.NoSPB=A.NoBukti and A.NoBukti=X.NoBukti and B.KodeBrg=X.KodeBrg and X.Urut=B.UrutSPB and ISNULL(A.IsClose,0)=0

	) X

left outer join DBCUSTSUPP Cs on Cs.KODECUSTSUPP=X.KodeCustSupp

left outer join DBBARANG Br on Br.KODEBRG=X.KodeBrg 

group by X.Devisi,X.NoBukti, X.Tanggal,X.KodeGdg, X.KodeCustSupp, Cs.NAMACUSTSUPP, X.NoSPP, X.Urut, X.KodeBrg, Br.NAMABRG,NOSAT,SAT_1,ISI,SAT_2;

-- vwOutSPK_HasilP
CREATE VIEW IF NOT EXISTS vwOutSPK_HasilP AS Select A.NoBukti,A.TANGGAL,A1.KodeBrg KodeBrgJ,E.NamaBrg NamaBrgJ ,A1.Qnt*A1.isi QntJ,A1.Nosat NosatJ,A1.Isi IsiJ,A1.Satuan SatJ,

       ISNULL(Case when A.Nosat=1 then Case when B.NOSAT=1 then B.QNT

                                            when B.NOSAT=2 then B.QNT*A1.isi

                                            else 0

                                       

                   when A.Nosat=2 then Case when B.NOSAT=1 then B.QNT/A1.isi

                                            when B.NOSAT=2 then B.QNT

                                            else 0

                                       

                   else 0

              ,0)*Case when A1.nosat=1 then 1

                          When A1.nosat=2 then A.Isi 

                      QntH,

       (A.QNT*A.Isi)-(

       ISNULL(Case when A.Nosat=1 then Case when B.NOSAT=1 then B.QNT

                                            when B.NOSAT=2 then B.QNT*A1.isi

                                            else 0

                                       

                   when A.Nosat=2 then Case when B.NOSAT=1 then B.QNT/A1.isi

                                            when B.NOSAT=2 then B.QNT

                                            else 0

                                       

                   else 0

              ,0)*Case when A1.nosat=1 then 1

                          When A1.nosat=2 then A.Isi 

                     ) SisaSPK

From dbSPK A

     Left Outer Join DBSPKMDET A1 On A1.NOBUKTI=A.NOBUKTI

     Left Outer join dbBarang E on E.KodeBrg=A1.Kodebrg

     Left Outer join (Select y.NoSPK,y.KODEBRG, y.KodeGdg, y.QNT, y.NOSAT, y.ISI, y.SATUAN

                      from DBHASILPRD x

                           left Outer join DBHASILPRDDET y on y.NOBUKTI=x.NOBUKTI) B on B.NoSPK=A.NOBUKTI and B.KODEBRG=A1.KODEBRG

where (A1.QNT*A1.isi)-(

       ISNULL(Case when A1.Nosat=1 then Case when B.NOSAT=1 then B.QNT

                                            when B.NOSAT=2 then B.QNT*A1.isi

                                            else 0

                                       

                   when A.Nosat=2 then Case when B.NOSAT=1 then B.QNT/A1.isi

                                            when B.NOSAT=2 then B.QNT

                                            else 0

                                       

                   else 0

              ,0)*Case when A1.nosat=1 then 1

                          When A1.nosat=2 then A1.Isi 

                     )>0;

-- vwOutSPK_Pakai
CREATE VIEW IF NOT EXISTS vwOutSPK_Pakai AS select Devisi,NOBUKTI, URUT, KODEBRG, NOSAT, TglSPK,

sum(QNTSPK) QntSPK, sum(QntPakai) QntPakai, sum(QNTSisa) QntSisa

from

(

select Y.Devisi,x.NOBUKTI, x.URUT, x.KODEBRG, x.NOSAT, x.QNT QntSPK, 0.00 QntPakai, x.QNT QntSisa, y.TANGGAL TglSPK

from DBSPKDET x

     left Outer join DBSPK y on y.NOBUKTI=x.NOBUKTI

union all

select y1.Devisi,x.NoSPK NoBukti, x.UrutSPK Urut, x.kodebrg, NoSatSPK NoSat,

0.00 QntSPK, case when NoSatSPK=1 then x.Qnt else Qnt2  QntPakai,

-1*case when NoSatSPK=1 then x.Qnt else Qnt2  QntSisa, y1.TANGGAL TglSPK

from DBPenyerahanBhnDET x

     left Outer join DBSPKMDET y on y.NOBUKTI=x.NoSPK 

     Left Outer join DBSPK y1 on y1.NOBUKTI=y.NOBUKTI

) X group by Devisi,NOBUKTI, URUT, KODEBRG, NOSAT, TglSPK;

-- vwOutSPP
CREATE VIEW IF NOT EXISTS vwOutSPP AS select	A.NoBukti, A.Urut, A.KodeBrg, A.NamaBrg, A.Sat_1, A.Sat_2, A.NoSat, A.Isi, A.Qnt-ISNULL(A.QntBatal,0) Qnt, A.Qnt2-ISNULL(A.QntBatal,0) Qnt2, 

	isnull(C.QntSPB,0) QntSPB, isnull(C.Qnt2SPB,0) Qnt2SPB,

	A.Qnt-Isnull(A.QntBatal,0)-isnull(C.QntSPB,0) QntSisa, A.Qnt2-Isnull(A.QntBatal,0)-isnull(C.Qnt2SPB,0) Qnt2Sisa,

	A.NetW,A.GrossW, 'Ekspor' TipeSPP, B.Catatan, B.isClose, 

     Case when A.NOSAT=1 then A.SAT_1

          when A.NOSAT=2 then A.SAT_2

          else ''

      Satuan, A.NoSO, A.UrutSO, A.isCetakKitir,SO.Qnt QntSO,SO.Qnt2 Qnt2SO,c1.QntSPB QntTSPB,c1.Qnt2SPB QntT2SPB,c1.QntRSPB,

     a.KodeGdg,Bx.Tanggal

from 	dbSPPDet A

Left Outer Join dbSPP BX on a.NoBukti=bX.NoBukti

Left Outer Join (select NOBukti,KodeBrg,SUM(QNT)Qnt,SUM(Qnt2)Qnt2 from DBSODET Group By NOBukti,KodeBrg)SO on SO.NOBUKTI=A.NoSO and SO.KODEBRG=A.KodeBrg

left outer join

	(select NoSPP, UrutSPP, a.KodeBrg, sum(a.QNT-Isnull(b.QNT,0)) QntSPB, sum(a.QNT2-Isnull(b.QNT,0)) Qnt2SPB

	from dbSPBDet a

	Left Outer Join (select a.NoSPB,a.KodeBrg,Sum(a.QNT)Qnt from DBRSPBDet a left Outer join DBRSPB y on y.NoBukti=a.NoBukti

                                  where Isnull(y.TipeRetur,0)=0 and Cast(Case when Case when y.IsOtorisasi1=1 then 1 else 0 +

                                                       Case when y.IsOtorisasi2=1 then 1 else 0 +

                                                       Case when y.IsOtorisasi3=1 then 1 else 0 +

                                                       Case when y.IsOtorisasi4=1 then 1 else 0 +

                                                       Case when y.IsOtorisasi5=1 then 1 else 0 =y.MaxOL then 0

                                                  else 1

                                        As INTEGER)=0

                                       Group by a.NoSPB,a.KodeBrg

                 Union all                   

                 select c.NoSPB,a.KodeBrg,SUM(a.QNT)Qnt from dbSPBRJualDet a

                 Left Outer Join DBRInvoicePLDET b on a.NoRPJ=b.NOBUKTI and a.UrutRPJ=b.URUT

                 Left Outer Join dbInvoicePLDet c on c.NoBukti=b.NoInvoice and c.Urut=b.UrutInvoice

                 Left Outer Join dbSPBRJual y on y.NoBukti=a.NoBukti

                 where a.NoRPJ=b.NOBUKTI and a.UrutRPJ=b.URUT

                 and Cast(Case when Case when y.IsOtorisasi1=1 then 1 else 0 +

                                                       Case when y.IsOtorisasi2=1 then 1 else 0 +

                                                       Case when y.IsOtorisasi3=1 then 1 else 0 +

                                                       Case when y.IsOtorisasi4=1 then 1 else 0 +

                                                       Case when y.IsOtorisasi5=1 then 1 else 0 =y.MaxOL then 0

                                                  else 1

                                        As INTEGER)=0

                 Group by a.KodeBrg,c.NoSPB                   ) b On b.NoSPB=a.NoBukti and a.KodeBrg=b.KodeBrg 

	group by NoSPP, UrutSPP, a.KodeBrg

	) C on C.NoSPP=A.NoBukti and C.UrutSPP=A.Urut and C.KodeBrg=A.KodeBrg

left outer join

	(select SPP.NoSO, a.KodeBrg, sum(a.QNT-Isnull(b.QNT,0)) QntSPB, sum(a.QNT2-Isnull(b.QNT,0)) Qnt2SPB,SUM(Isnull(b.QNT,0))QntRSPB

	from dbSPBDet a

	Left Outer Join dbSPPDet SPP on SPP.NoBukti=a.NoSPP and SPP.KodeBrg=a.KodeBrg 

	Left Outer Join (select a.NoSPB,a.KodeBrg,a.QNT from DBRSPBDet a left Outer join DBRSPB y on y.NoBukti=a.NoBukti

                                  where Cast(Case when Case when y.IsOtorisasi1=1 then 1 else 0 +

                                                       Case when y.IsOtorisasi2=1 then 1 else 0 +

                                                       Case when y.IsOtorisasi3=1 then 1 else 0 +

                                                       Case when y.IsOtorisasi4=1 then 1 else 0 +

                                                       Case when y.IsOtorisasi5=1 then 1 else 0 =y.MaxOL then 0

                                                  else 1

                                        As INTEGER)=0) b On b.NoSPB=a.NoBukti and a.KodeBrg=b.KodeBrg 

	group by SPP.NoSO, a.KodeBrg

	) C1 on C1.NoSO=A.NoSO and C1.KodeBrg=A.KodeBrg	

	Left Outer Join dbSPP B on B.NoBukti=A.NoBukti

    where   

    A.Qnt-Isnull(A.QntBatal,0)-isnull(C.QntSPB,0)>Case When A.NOSAT=1 Then 0.01 else 10000000000000 

    or

    A.Qnt2-Isnull(A.QntBatal,0)-isnull(C.Qnt2SPB,0)>Case When A.NOSAT=2 Then 0.01 else 10000000000000;

-- vwOutSPRK
CREATE VIEW IF NOT EXISTS vwOutSPRK AS SELECT  A.Nobukti, A.urut, A.kodebrg, A.Sat_1, A.Sat_2, A.Isi, A.Qnt, A.Qnt2, 

        ISNULL(B.QntPO, 0) AS QntPO, 

        ISNULL(B.Qnt2PO, 0) AS Qnt2PO,

        ISNULL(B.QntBPO, 0) AS QntBPO, 

        ISNULL(B.Qnt2BPO, 0) AS Qnt2BPO, 

        ISNULL(D.QntBSPRK, 0) AS QntBSPRK, 

        ISNULL(D.Qnt2BSPRK, 0) AS Qnt2BSPRK, 

        A.Qnt - ISNULL(B.QntPO, 0)+ISNULL(B.QntBPO, 0)- ISNULL(D.QntBSPRK, 0) AS QntSisaPO, 

        A.Qnt2 - ISNULL(B.Qnt2PO, 0)+ISNULL(B.Qnt2BPO, 0)- ISNULL(D.Qnt2BSPRK, 0) AS Qnt2SisaPO, 

        A.Qnt - ISNULL(B.QntPO, 0)+ISNULL(B.QntBPO, 0) - ISNULL(D.QntBSPRK, 0) AS QntSisa, 

        A.Qnt2 - ISNULL(B.Qnt2PO, 0)+ISNULL(B.Qnt2BPO, 0) - ISNULL(D.Qnt2BSPRK, 0) AS Qnt2Sisa,

        E.NamaBag, A.nosat, A.Pelaksana,

        A.IsInspeksi,A.Keterangan,A.Catatan,A.KodeGrp,

        Case when A.Nosat=1 then A.Qnt

            when A.Nosat=2 then A.Qnt2

            else 0

        SPRK_Qty,

       Case when A.Nosat=1 then ISNULL(D.QntBSPRK,0)

            when A.Nosat=2 then ISNULL(D.Qnt2BSPRK,0)

            else 0

        SPRK_QtyBtl,

       Case when A.Nosat=1 then ISNULL(B.QntPO,0)

            when A.Nosat=2 then ISNULL(B.Qnt2PO,0)

            else 0

        SPRK_QtyPO,

       Case when A.Nosat=1 then ISNULL(B.QntBPO,0)

            when A.Nosat=2 then ISNULL(B.Qnt2BPO,0)

            else 0

        SPRK_QtyBPO,

       Case when A.Nosat=1 then A.Qnt - ISNULL(B.QntPO, 0)+ISNULL(B.QntBPO, 0) - ISNULL(D.QntBSPRK, 0)

            when A.Nosat=2 then A.Qnt2 - ISNULL(B.Qnt2PO, 0)+ISNULL(B.Qnt2BPO, 0) - ISNULL(D.Qnt2BSPRK, 0)

            else 0

        SPRK_QtySisa,

       Case when A.Nosat=1 then A.Sat_1

            when A.Nosat=2 then A.Sat_2

            else ''

        SPRK_Satuan,

       C.JnsPakai,

       Case when C.JnsPakai=0 then 'Stock'

				when c.JnsPakai=1 then 'Investasi'

				when c.JnsPakai=2 then 'Rep & Pem Teknik'

				when c.JnsPakai=3 then 'Rep & Pem Komputer'

				when c.JnsPakai=4 then 'Rep & Pem Peralatan'

		  MyJnsPakai, C.Perk_Investasi, c.Kodegdg, c.SOP, C.Tanggal, C.KodeBag, C.KodeMesin

FROM dbo.DBSPRKDET AS A 

LEFT OUTER JOIN (SELECT  x.NoPPL, x.UrutPPL, KODEBRG, SUM(x.QNT) AS QntPO, SUM(x.QNT2) AS Qnt2PO,

                         ISNULL(y.qnt,0) QntBPO,ISNULL(y.Qnt2,0) Qnt2BPO

                 FROM  dbo.DBPODET x

                       left Outer join (Select  NoPO, UrutPO, SUM(Qnt) Qnt, SUM(Qnt2) Qnt2

                                        from DBBatalPODET  

                                        group by NoPO, UrutPO) y on y.NoPO=x.NOBUKTI and y.UrutPO=x.URUT 

                 GROUP BY x.NoPPL, x.UrutPPL, x.KODEBRG, y.Qnt,y.Qnt2) AS B ON B.NoPPL = A.Nobukti AND B.UrutPPL = A.urut

left Outer join dbSPRK c on c.NoBukti=A.NoBukti

LEFT OUTER JOIN (SELECT  NoSPRK, UrutSPRK, KODEBRG, SUM(QNT) AS QntBSPRK, SUM(QNT2) AS Qnt2BSPRK

                 FROM  dbo.DBBatalSPRKDET

                 GROUP BY NoSPRK, UrutSPRK, KODEBRG) AS D ON D.NoSPRK = A.Nobukti AND D.UrutSPRK = A.urut                 

left outer join DBBAGIAN E on E.KodeBag=c.KodeBag;

-- vwOutstandingBeli
CREATE VIEW IF NOT EXISTS vwOutstandingBeli AS select 	A.NoBukti, A.Urut, A.KodeBrg, isnull(B.QntSat1,0) QntRBeliSat1, isnull(B.QntSat2,0) QntRBeliSat2   

from 	dbBeliDet A

left outer join vwQntRBeliDariBeli B on B.NoBeli=A.NoBukti and B.UrutPBL=A.Urut

where	A.Qnt*A.Isi>isnull(B.QntSat1,0);

-- vwOutstandingPO
CREATE VIEW IF NOT EXISTS vwOutstandingPO AS select 	A.NoBukti, case when Isnull(A.NamaBrg,'')=H.NamaBrg Then H.NamaBrg when Isnull(A.NamaBrg,'')='' Then H.NamaBrg else A.NamaBrg  NamaBrg, A.Urut, A.KodeBrg,A.Qnt*a.ISI-Isnull(B.QntSat1,0)QNTOS,A.Qnt*a.ISI QntPO,A.Satuan,isnull(B.QntSat1,0) QntBeliSat1  

from 	dbPODet A

Left Outer Join DBBARANG H On A.KODEBRG=H.KODEBRG

left outer join  vwQntBeliDariPO B on B.NOPO=A.NoBukti and B.UrutPO=A.Urut and A.KODEBRG=B.KodeBrg

where	A.Qnt*A.Isi>isnull(B.QntSat1,0);

-- vwOutTBJ_RBJ
CREATE VIEW IF NOT EXISTS vwOutTBJ_RBJ AS Select A.Nobukti,A.Urut,A.Kodebrg,A.Kodegdg, A.Qnt,A.Qnt2, A.Nosat,A.Isi,A.Sat_1,A.Sat_2,

       isnull(B.Qnt,0) QntR, isnull(B.Qnt2,0) Qnt2R,

       A.Qnt-ISNULL(B.Qnt,0) qntSisa,

       A.Qnt2-ISNULL(B.Qnt2,0) Qnt2Sisa

From DbPenerimaanBrgJadiDet A

     left Outer join (Select x.NoTerima,x.UrutTerima, SUM(x.Qnt) Qnt, SUM(x.qnt2) Qnt2

                      from DbRPenerimaanBrgJadiDet x

                      Group by x.Noterima,x.UrutTerima) B on B.NoTerima=A.Nobukti and B.urutTerima=A.Urut

Where (A.Qnt-ISNULL(B.Qnt,0)<>0) Or (A.Qnt2-ISNULL(B.Qnt2,0)<>0);

-- vwpemakaianbrg
CREATE VIEW IF NOT EXISTS vwpemakaianbrg AS SELECT a.Nobukti,b.Tanggal, a.kodebrg,c.NAMABRG,c.KodeJnsBrg,  b.Kodebag,d.NamaBag

,e.KodeJnsPakai,f.Keterangan,e.KodeMesin,g.NamaMesin,case when a.Nosat = 1 then a.Sat_1 else a.Sat_2  as satuan,

case when a.Nosat = 1 then a.Qnt else a.Qnt2  as QNT,a.hpp,

a.Qnt *ISNULL(a.HPP,0) as total,

Case when b.JnsPakai=0 then 'Stock'

	  when b.JnsPakai=1 then 'Investasi'

	  when b.JnsPakai=2 then 'Rep & Pem Teknik'

	  when b.JnsPakai=3 then 'Rep & Pem Komputer'

	  when b.JnsPakai=4 then 'Rep & Pem Peralatan'

 MyJnsPakai,b.JnsPakai

FROM DBPenyerahanBrgdet a 

left outer join DBPenyerahanBrg b on a.Nobukti = b.Nobukti

left outer join DBBARANG c on a.kodebrg = c.KODEBRG

left outer join DBBAGIAN d on b.Kodebag = d.KodeBag

left outer join DBPermintaanBrg e on b.NoBPPB=e.Nobukti

left outer join DBJNSPAKAI f on e.KodeJnsPakai = f.KodeJNSPakai

left outer join DBMESIN g on e.KodeMesin = g.KodeMesin;

-- vwPenerimaanBrg
CREATE VIEW IF NOT EXISTS vwPenerimaanBrg AS select  a.NOBUKTI,b.TANGGAL,b.KODECUSTSUPP, d.NAMACUSTSUPP,

        a.KODEBRG,c.NAMABRG,a.Nosat,a.QNT,a.QNT2,a.SAT_1,a.SAT_2,f.NOPPL,c.ISJASA,c.KodeJnsBrg,

        f.tipe,

        case when a.nosat =1 then a.sat_1 

             else a.sat_2 

         as satuan,

        case when a.Nosat = 1 then a.QNT 

             else a.QNT2 

         as quantity,

        a.HARGA,b.KODEVLS,b.KURS,

        a.SUBTOTAL,a.SUBTOTALRp,

        a.NDPP,a.NDPPRp, a.NPPN, a.NPPNRp, a.NNET, a.NNETRp,        

        c.KodeKategori,g.Keterangan NamaKategori,g.Perkiraan PerkPersediaan, h.Keterangan NamaPerkPersediaan, 

        d.PERKIRAAN PerkHutang, d.NamaPerkiraan NamaPerkHutang

from DBBELIDET a 

left outer join DBBELI b on a.NOBUKTI = b.NOBUKTI

left outer join DBBARANG c on a.KODEBRG = c.KODEBRG

left outer join vwBrowsSupp d on b.KODECUSTSUPP = d.KODECUSTSUPP

left outer join (Select x.NOBUKTI NOPO, x.URUT URutPO, y.Tipe, x.NoPPL

                 from DBPODET x

                      left outer join DBPO y on y.NOBUKTI=x.NOBUKTI 

                 Group by x.NOBUKTI, x.URUT, x.NoPPL, y.Tipe) f on f.NOPO=a.NOPO and f.URutPO=a.URUTPO

left outer join DBKATEGORI g on g.KodeKategori=c.KodeKategori

left outer join DBPERKIRAAN h on h.Perkiraan=g.Perkiraan;

-- vwPerkiraan
CREATE VIEW IF NOT EXISTS vwPerkiraan AS select a.*,

                 Case when a.Tipe=0 then 'General'

                      when a.Tipe=1 then 'Detail'

                      else '''' 

                  mytipe, 

                 Case when a.DK=0 then 'Debet'

                      when a.DK=1 then 'Kredit'

                      else '''' 

                  myDK ,

                 Case when a.Kelompok=0 then 'Aktiva'

                      when a.Kelompok=1 then 'Kewajiban'

                      when a.Kelompok=2 then 'Modal'

                      when a.Kelompok=3 then 'Kelompok'

                      when a.Kelompok=4 then 'Pendapatan'

                      when a.Kelompok=5 then 'Biaya'

                      else '' 

                  myKelompok from dbPerkiraan a;

-- vwPerusahaan
CREATE VIEW IF NOT EXISTS vwPerusahaan AS SELECT KODEUSAHA, NAMA, ALAMAT1 + CHAR(13) + ALAMAT2 + CHAR(13) + 'Telp ' + Telpon + ', ' + 'Fax ' + Fax + CHAR(13)+

       'E-mail : '+Email AS Alamat, ALAMAT1 AlamatReport, LOGO, 

       Direksi, Jabatan, KOTA, email,

       NPWP, NAMAPKP, ALAMATPKP1+CHAR(13)+ALAMATPKP2+CHAR(13)+KOTAPKP AlamatPKP1, TGLPENGUKUHAN,

       NPWP1, NAMAPKP1, ALAMATPKP21+CHAR(13)+ALAMATPKP22+CHAR(13)+KOTAPKP1 AlamatPKP2, TGLPENGUKUHAN1

FROM dbo.DBPERUSAHAAN;

-- vwPiutangDetail
CREATE VIEW IF NOT EXISTS vwPiutangDetail AS select a.KodeCustSupp Kode,a.NoBL KOdeproject,a.NoBukti,e.NAMACUSTSUPP Nama,f.NAMAPROJECT,H.Nama Marketing,d.NamaSubGrp,a.Tanggal TglInv,NoInv NoKwk,NoPajak,TglFPJ,NoSeri,a.Tanggal+e.HARI TglJthTempo,

Case When a.Valas='IDR' Then b.NNETRp else b.NNET  Tot,a.DP,Case When a.Valas='IDR' Then b.NNETRp else b.NNET -DP Sisa,

c.Tanggal TglBayar,c.Kredit,Case When a.valas='IDR' Then RInv.NNetRp else RInv.NNet  Retur,

Case When a.Valas='IDR' Then b.NNETRp else b.NNET -ISNULL(c.Kredit,0)-Isnull(Case When a.valas='IDR' Then RInv.NNetRp else RInv.NNet ,0)SaldoPiutang 

from dbInvoicePL a

Left Outer Join (select NoBukti,NoSO,Sum(Qnt)Qnt,b.KODEGRP,b.KODESUBGRP,SUM(NDPP)NDPP,SUM(NDPPRp)NDPPRp,SUM(NPPN)NPPN,SUM(NNET)NNET,SUM(NNETRp)NNETRp 

from dbInvoicePLDet a

Left Outer Join DBBARANG b On a.KodeBrg=b.KODEBRG

group by NoBukti,b.KODEGRP,b.KODESUBGRP,NoSO)b On a.NoBukti=b.NoBukti

Left Outer Join (select NoFaktur,MIN(Tanggal)Tanggal,KodeCustSupp,Sum(Debet)debet,Sum(Kredit)Kredit,Sum(Saldo)Saldo from DBHUTPIUT 

where TipeTrans='L' Group by NoFaktur,KodeCustSupp)c On a.NoBukti=c.NoFaktur and a.KodeCustSupp=c.KodeCustSupp

Left Outer Join dbSubGroup d on d.KodeSubGrp=b.KODESUBGRP and d.KodeGrp=b.KODEGRP

Left Outer Join DBCUSTSUPP e on e.KODECUSTSUPP=a.KodeCustSupp

Left Outer Join DBPROJECT f On f.KODEPROJECT=a.NoBL

Left Outer Join (select NoInvoice,SUM(NNet)NNet,SUM(NNetRp)NNetRp from DBRInvoicePLDET Group by NoInvoice)RInv On RInv.NoInvoice=b.NoBukti

Left Outer Join(Select NOBUKTI,KODESLS from DBSO Group By NOBUKTI,KODESLS)G On G.NOBUKTI=b.NoSO 

Left Outer Join dbKaryawan H On H.KeyNIK=G.KODESLS;

-- vwPIUTANGKP12DEC2013AJC
CREATE VIEW IF NOT EXISTS vwPIUTANGKP12DEC2013AJC AS /*

select cast([Col001] as int) Urut, 

cast(right([tgl kontrak],4)+SUBSTRING([tgl kontrak],4,2)+LEFT([tgl kontrak],2) as datetime) Tanggal, 

[no. KP] NoBukti, [proyek] NamaProyek, 

[Col005] TipePPN, KodeCust,

[nama customer] NamaCustSupp,

[nama barang] NamaBrg, [Harga], 

cast([sisa 12 des] as int) Sisa12, 

cast(case when isnumeric(isnull([SJ 13 DES],'0'))=0 then 0 else isnull([SJ 13 DES],'0')  as int) SJ13, 

cast(case when isnumeric(isnull([SJ 14 DES],'0'))=0 then 0 else isnull([SJ 14 DES],'0')  as int) SJ14,

cast(case when isnumeric(isnull([SJ 15 DES],'0'))=0 then 0 else isnull([SJ 15 DES],'0')  as int) SJ15, 

cast(case when isnumeric(isnull([SJ 16 DES],'0'))=0 then 0 else isnull([SJ 16 DES],'0')  as int) SJ16, 

cast(case when isnumeric(isnull([SJ 17 DES],'0'))=0 then 0 else isnull([SJ 17 DES],'0')  as int) SJ17, 

cast(case when isnumeric(isnull([SJ 18 DES],'0'))=0 then 0 else isnull([SJ 18 DES],'0')  as int) SJ18,

cast(case when isnumeric(isnull([SJ 19 DES],'0'))=0 then 0 else isnull([SJ 19 DES],'0')  as int) SJ19, 

cast(case when isnumeric(isnull([SJ 20 DES],'0'))=0 then 0 else isnull([SJ 20 DES],'0')  as int) SJ20, 

cast(case when isnumeric(isnull([SJ 21 DES],'0'))=0 then 0 else isnull([SJ 21 DES],'0')  as int) SJ21, 

cast(case when isnumeric(isnull([SJ 22 DES],'0'))=0 then 0 else isnull([SJ 22 DES],'0')  as int) SJ22, 

cast(case when isnumeric(isnull([SJ 23 DES],'0'))=0 then 0 else isnull([SJ 23 DES],'0')  as int) SJ23, 

cast(case when isnumeric(isnull([SJ 24 DES],'0'))=0 then 0 else isnull([SJ 24 DES],'0')  as int) SJ24,

cast(case when isnumeric(isnull([SJ 25 DES],'0'))=0 then 0 else isnull([SJ 25 DES],'0')  as int) SJ25, 

cast(case when isnumeric(isnull([SJ 26 DES],'0'))=0 then 0 else isnull([SJ 26 DES],'0')  as int) SJ26, 

cast(case when isnumeric(isnull([SJ 27 DES],'0'))=0 then 0 else isnull([SJ 27 DES],'0')  as int) SJ27, 

cast(case when isnumeric(isnull([SJ 28 DES],'0'))=0 then 0 else isnull([SJ 28 DES],'0')  as int) SJ28,

cast(case when isnumeric(isnull([SJ 29 DES],'0'))=0 then 0 else isnull([SJ 29 DES],'0')  as int) SJ29, 

cast(case when isnumeric(isnull([SJ 30 DES],'0'))=0 then 0 else isnull([SJ 30 DES],'0')  as int) SJ30 

from PIUTANGKP12DEC2013AJC

*/



/*

select cast([Col001] as int) Urut, cast('2013'+right(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace([tgl kontrak],'mar','03'),'apr','04'),'mei','05'),'jun','06'),'jul','07'),'agust','08'),'sep','09'),'okt','10'),'nop','11'),'des','12'),2)+LEFT([tgl kontrak],2) as datetime) Tanggal,

--cast(right([tgl kontrak],4)+SUBSTRING([tgl kontrak],4,2)+LEFT([tgl kontrak],2) as datetime) Tanggal, 

[no. KP] NoBukti, [proyek] NamaProyek, 

[Col005] TipePPN,

[nama customer] NamaCustSupp,

[nama barang] NamaBrg, 

--cast(replace(replace(replace(replace([ Harga],'Rp',''),'.',''),',','.'),'-','0') as numeric(18,2)) Harga,

replace(replace(replace(replace([ Harga],'Rp',''),'.',''),',','.'),'-','0') Harga,

replace(replace(replace([ sisa 31 des],'.',''),')',''),'(','-') Sisa12,

replace(replace(replace(replace([ Jumlah],'Rp',''),'.',''),',','.'),'-','0') Jumlah

--replace([ sisa 31 des],'.','') Sisa12    

--cast([sisa 12 des] as int) Sisa12, 

--cast(case when isnumeric(isnull([SJ 13 DES],'0'))=0 then 0 else isnull([SJ 13 DES],'0')  as int) SJ13, 

--cast(case when isnumeric(isnull([SJ 14 DES],'0'))=0 then 0 else isnull([SJ 14 DES],'0')  as int) SJ14,

--cast(case when isnumeric(isnull([SJ 15 DES],'0'))=0 then 0 else isnull([SJ 15 DES],'0')  as int) SJ15, 

--cast(case when isnumeric(isnull([SJ 16 DES],'0'))=0 then 0 else isnull([SJ 16 DES],'0')  as int) SJ16, 

--cast(case when isnumeric(isnull([SJ 17 DES],'0'))=0 then 0 else isnull([SJ 17 DES],'0')  as int) SJ17, 

--cast(case when isnumeric(isnull([SJ 18 DES],'0'))=0 then 0 else isnull([SJ 18 DES],'0')  as int) SJ18,

--cast(case when isnumeric(isnull([SJ 19 DES],'0'))=0 then 0 else isnull([SJ 19 DES],'0')  as int) SJ19, 

--cast(case when isnumeric(isnull([SJ 20 DES],'0'))=0 then 0 else isnull([SJ 20 DES],'0')  as int) SJ20, 

--cast(case when isnumeric(isnull([SJ 21 DES],'0'))=0 then 0 else isnull([SJ 21 DES],'0')  as int) SJ21, 

--cast(case when isnumeric(isnull([SJ 22 DES],'0'))=0 then 0 else isnull([SJ 22 DES],'0')  as int) SJ22, 

--cast(case when isnumeric(isnull([SJ 23 DES],'0'))=0 then 0 else isnull([SJ 23 DES],'0')  as int) SJ23, 

--cast(case when isnumeric(isnull([SJ 24 DES],'0'))=0 then 0 else isnull([SJ 24 DES],'0')  as int) SJ24,

--cast(case when isnumeric(isnull([SJ 25 DES],'0'))=0 then 0 else isnull([SJ 25 DES],'0')  as int) SJ25, 

--cast(case when isnumeric(isnull([SJ 26 DES],'0'))=0 then 0 else isnull([SJ 26 DES],'0')  as int) SJ26, 

--cast(case when isnumeric(isnull([SJ 27 DES],'0'))=0 then 0 else isnull([SJ 27 DES],'0')  as int) SJ27, 

--cast(case when isnumeric(isnull([SJ 28 DES],'0'))=0 then 0 else isnull([SJ 28 DES],'0')  as int) SJ28,

--cast(case when isnumeric(isnull([SJ 29 DES],'0'))=0 then 0 else isnull([SJ 29 DES],'0')  as int) SJ29, 

--cast(case when isnumeric(isnull([SJ 30 DES],'0'))=0 then 0 else isnull([SJ 30 DES],'0')  as int) SJ30 

from PIUTANGKPNew

--where isnumeric(replace(replace(replace(replace([ Harga],'Rp',''),'.',''),',','.'),'-','0'))=0

*/

     

 select cast([NoUrut] as int) Urut, --cast('2013'+right(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace([tgl kontrak],'mar','03'),'apr','04'),'mei','05'),'jun','06'),'jul','07'),'agust','08'),'sep','09'),'okt','10'),'nop','11'),'des','12'),2)+LEFT([tgl kontrak],2) as datetime) Tanggal,

CAST([Tgl Kontrak] as datetime) Tanggal,

--cast(right([tgl kontrak],4)+SUBSTRING([tgl kontrak],4,2)+LEFT([tgl kontrak],2) as datetime) Tanggal, 

[no. KP] NoBukti, [proyek] NamaProyek, 

[Col005] TipePPN, KodeCust,

[nama customer] NamaCustSupp,

KodeBrg, [nama barang] NamaBrg, 

--cast(replace(replace(replace(replace([ Harga],'Rp',''),'.',''),',','.'),'-','0') as numeric(18,2)) Harga,

--replace(replace(replace(replace([ Harga],'Rp',''),'.',''),',','.'),'-','0') Harga,

Replace([ Harga],',','.') Harga,

Replace([ sisa 31 des],',','.') Sisa31,

Replace([ Jumlah],',','.') Jumlah

--replace(replace(replace([ sisa 31 des],'.',''),')',''),'(','-') Sisa12,

--replace(replace(replace(replace([ Jumlah],'Rp',''),'.',''),',','.'),'-','0') Jumlah

--replace([ sisa 31 des],'.','') Sisa12    

--cast([sisa 12 des] as int) Sisa12, 

--cast(case when isnumeric(isnull([SJ 13 DES],'0'))=0 then 0 else isnull([SJ 13 DES],'0')  as int) SJ13, 

--cast(case when isnumeric(isnull([SJ 14 DES],'0'))=0 then 0 else isnull([SJ 14 DES],'0')  as int) SJ14,

--cast(case when isnumeric(isnull([SJ 15 DES],'0'))=0 then 0 else isnull([SJ 15 DES],'0')  as int) SJ15, 

--cast(case when isnumeric(isnull([SJ 16 DES],'0'))=0 then 0 else isnull([SJ 16 DES],'0')  as int) SJ16, 

--cast(case when isnumeric(isnull([SJ 17 DES],'0'))=0 then 0 else isnull([SJ 17 DES],'0')  as int) SJ17, 

--cast(case when isnumeric(isnull([SJ 18 DES],'0'))=0 then 0 else isnull([SJ 18 DES],'0')  as int) SJ18,

--cast(case when isnumeric(isnull([SJ 19 DES],'0'))=0 then 0 else isnull([SJ 19 DES],'0')  as int) SJ19, 

--cast(case when isnumeric(isnull([SJ 20 DES],'0'))=0 then 0 else isnull([SJ 20 DES],'0')  as int) SJ20, 

--cast(case when isnumeric(isnull([SJ 21 DES],'0'))=0 then 0 else isnull([SJ 21 DES],'0')  as int) SJ21, 

--cast(case when isnumeric(isnull([SJ 22 DES],'0'))=0 then 0 else isnull([SJ 22 DES],'0')  as int) SJ22, 

--cast(case when isnumeric(isnull([SJ 23 DES],'0'))=0 then 0 else isnull([SJ 23 DES],'0')  as int) SJ23, 

--cast(case when isnumeric(isnull([SJ 24 DES],'0'))=0 then 0 else isnull([SJ 24 DES],'0')  as int) SJ24,

--cast(case when isnumeric(isnull([SJ 25 DES],'0'))=0 then 0 else isnull([SJ 25 DES],'0')  as int) SJ25, 

--cast(case when isnumeric(isnull([SJ 26 DES],'0'))=0 then 0 else isnull([SJ 26 DES],'0')  as int) SJ26, 

--cast(case when isnumeric(isnull([SJ 27 DES],'0'))=0 then 0 else isnull([SJ 27 DES],'0')  as int) SJ27, 

--cast(case when isnumeric(isnull([SJ 28 DES],'0'))=0 then 0 else isnull([SJ 28 DES],'0')  as int) SJ28,

--cast(case when isnumeric(isnull([SJ 29 DES],'0'))=0 then 0 else isnull([SJ 29 DES],'0')  as int) SJ29, 

--cast(case when isnumeric(isnull([SJ 30 DES],'0'))=0 then 0 else isnull([SJ 30 DES],'0')  as int) SJ30 

from PIUTANGKP31DESAJC A

left outer join (select Col001, Col005 from PIUTANGKP12DEC2013AJC) B on B.Col001=A.NoUrut

--where isnumeric(replace(replace(replace(replace([ Harga],'Rp',''),'.',''),',','.'),'-','0'))=0;

-- vwPostBiaya
CREATE VIEW IF NOT EXISTS vwPostBiaya AS Select A.KODEBAG, B.NamaBag, A.KodeMesin, C.NamaMesin, A.PERKIRAAN, D.Keterangan NamaPerkiraan,

       B.NamaBag+Case when B.NamaBag is null then '' else ' ('+B.KodeBag+')'  myBagian,

       C.NamaMesin+Case when C.NamaMesin is null then '' else ' ('+C.KodeMesin+')'  myMesin, 

       D.Keterangan+Case when D.Keterangan is null then '' else ' ('+D.Perkiraan+')'  myPerkiraan

from DBPOSTBIAYA A

     left outer join DBBAGIAN B on B.KodeBag=A.KODEBAG

     left outer join DBMESIN C on C.KodeMesin=A.KodeMesin

     left outer join DBPERKIRAAN D on D.Perkiraan=A.PERKIRAAN;

-- vwPostHutPiut
CREATE VIEW IF NOT EXISTS vwPostHutPiut AS --Beli

SELECT A.NOBUKTI NoFaktur, '' NoRetur, 'T' Tipetrans, A.KodeSupp KODECUSTSUPP, 

       A.NoJurnal Nobukti, CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) NoMsk, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) urut, A.TANGGAL, A.Tanggal JatuhTempo, 

	0 Debet, Sum(B.NNETRp)+Isnull(A1.Nilai,0) Kredit, Sum(B.NNETRp)+Isnull(A1.Nilai,0) Saldo, 

	A.KodeVls Valas, A.Kurs KURS, 

       0 DebetD, sum(B.NNet)+Isnull(A1.Nilai,0) Kreditd, sum(B.NNet)+Isnull(A1.Nilai,0) SaldoD, 

       '' KodeSales, 'HT' Tipe, 

       D.PERKIRAAN, '' Catatan, 'BL' NoInvoice, A.KodeVls KodeVls_, A.Kurs Kurs_,A.NoBukti NoPajak

FROM   dbo.DBBeli A      

LEft Outer join dbo.dbbelidet B on B.nobukti=A.nobukti

Left Outer Join (select SUM(Nilai)Nilai,NoBuktiInv from DBPBIAYA Group By NoBuktiInv)A1 On A1.NoBuktiInv=A.NOBUKTI

Left Outer join dbo.dbBarang C on C.kodebrg=B.kodebrg

Left Outer join dbo.DBPERKCUSTSUPP D on D.KODECUSTSUPP=A.KODESUPP and D.Perkiraan=Case When A.TIPEBAYAR=0 Then '332' else '331'  

Where A.NoJurnal<>'' and c.KODEGRP<>'JS'

Group by A.NoBukti, A.KodeSupp, A.Tanggal,

	A.KodeVls, A.Kurs, D.PERKIRAAN, A.NoJurnal,A1.Nilai



union all



SELECT A.NOBUKTI NoFaktur, '' NoRetur, 'T' Tipetrans, A.KodeSupp KODECUSTSUPP, 

       A.NoJurnal Nobukti, CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int)+500 NoMsk, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int)+500 urut, A.TANGGAL, A.Tanggal JatuhTempo, 

	0 Debet, Sum(B.NNETRp)+Isnull(A1.Nilai,0) Kredit, Sum(B.NNETRp)+Isnull(A1.Nilai,0) Saldo, 

	A.KodeVls Valas, A.Kurs KURS, 

       0 DebetD, sum(B.NNet)+Isnull(A1.Nilai,0) Kreditd, sum(B.NNet)+Isnull(A1.Nilai,0) SaldoD, 

       '' KodeSales, 'HT' Tipe, 

       '314' PERKIRAAN, '' Catatan, 'BL' NoInvoice, A.KodeVls KodeVls_, A.Kurs Kurs_,A.NoBukti NoPajak

FROM   dbo.DBBeli A      

LEft Outer join dbo.dbbelidet B on B.nobukti=A.nobukti

Left Outer Join (select SUM(Nilai)Nilai,NoBuktiInv from DBPBIAYA Group By NoBuktiInv)A1 On A1.NoBuktiInv=A.NOBUKTI

Left Outer join dbo.dbBarang C on C.kodebrg=B.kodebrg

Left Outer join dbo.DBPERKCUSTSUPP D on D.KODECUSTSUPP=A.KODESUPP and D.Perkiraan=Case When A.TIPEBAYAR=0 Then '332' else '331'  

Where A.NoJurnal<>'' and  c.KODEGRP='JS' and A.TIPEBAYAR=1

Group by A.NoBukti, A.KodeSupp, A.Tanggal,

	A.KodeVls, A.Kurs, D.PERKIRAAN, A.NoJurnal,A1.Nilai		

union all



--Retur Beli

SELECT Isnull(b1.NOBUKTI,'-') NoFaktur, A.NOBUKTI NoRetur, 'T' Tipetrans, A.KodeSupp KODECUSTSUPP, 

       A.NoJurnal Nobukti, CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) NoMsk, CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) urut, A.TANGGAL, A.Tanggal JatuhTempo, 

       Sum(B.NNETRp) Debet, 0.00 Kredit, -Sum(B.NNETRp) Saldo, 

       A.KodeVls Valas, A.Kurs KURS, 

       Sum(B.NNET) DebetD, 0.00 Kreditd, -sum(B.NNet) SaldoD, 

       '' KodeSales, 'HT' Tipe, 

       D.PERKIRAAN PERKIRAAN, '' Catatan, 'RBL' NoInvoice, A.KodeVls KodeVls_, A.Kurs Kurs_,A.NoBukti NoPajak

FROM   dbo.DBRBELI A      

LEft Outer join dbo.dbRbelidet B on B.nobukti=A.nobukti

Left Outer Join (select NOBUKTI from DBBELI Group By NOBUKTI)b1 On b1.NOBUKTI=B.NOPBL

Left Outer join dbo.dbBarang C on C.kodebrg=B.kodebrg

Left Outer join dbo.DBPERKCUSTSUPP D on D.KODECUSTSUPP=A.KODESUPP and D.Perkiraan=Case When A.TIPEBAYAR=0 Then '332' else '331'  

Group by b1.NOBUKTI,A.NoBukti, A.KodeSupp, A.Tanggal,

	A.KodeVls, A.Kurs, D.PERKIRAAN, A.NoJurnal, B.NOPBL

union all



--Invoice Penjualan

SELECT case when Upper(left(a.NOBUKTI,1))='B' then

      case when a.FLagTipe='P' then case when a.NoInv<>a.NoBukti then left(A.NOBUKTI,5)+SUBSTRING(a.NoBukti,8,6)+Right(A.NOBUKTI,2)+'-'+left(A.NoInv,15) else A.NOBUKTI  else A.NOBUKTI   

      else 

      case when a.FLagTipe='P' then case when a.NoInv<>'' then left(A.NOBUKTI,5)+SUBSTRING(a.NoBukti,8,6)+Right(A.NOBUKTI,2)+'-'+left(A.NoInv,15) else A.NOBUKTI  else A.NOBUKTI   NoFaktur, 

	 '' NoRetur, 'T' Tipetrans, A.KodeCustSupp KODECUSTSUPP, 

       A.NoJurnal Nobukti, CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) NoMsk, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) urut, A.TANGGAL, A.Tanggal JatuhTempo, 

       case when Isnull(SO.PPH22,0)<>0 Then  

        (Sum(B.NDPP)-Sum(B.NDPP*(Convert(Float,SO.Retensi)/100.00)))+((Sum(B.NDPP)-Sum(B.NDPP*(Convert(Float,SO.Retensi)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then NilaiPPN else (1+NilaiPPN) )-

		((Sum(B.NDPP)-Sum(B.NDPP*(Convert(Float,SO.Retensi)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		((Sum(B.NDPP)-Sum(B.NDPP*(Convert(Float,SO.Retensi)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then NilaiPPN else (1+NilaiPPN) )

		else

		((Sum(B.NDPP)-Sum(B.NDPP*(Convert(Float,SO.Retensi)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then NilaiPPN else (1+NilaiPPN) )*-1

		 

		else

		case when A.PPN>0 then Sum(B.NDPPRp)+(Isnull(A.DP,0)*NilaiPPN)+((Sum(B.NDPPRp)-Isnull(A.DP,0))*NilaiPPN) else Sum(B.NDPPRp)   Debet,

        0.00  Kredit,

       case when Isnull(SO.PPH22,0)<>0 Then  

        (Sum(B.NDPP)-Sum(B.NDPP*(Convert(Float,SO.Retensi)/100.00)))+((Sum(B.NDPP)-Sum(B.NDPP*(Convert(Float,SO.Retensi)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then NilaiPPN else (1+NilaiPPN) )-

		((Sum(B.NDPP)-Sum(B.NDPP*(Convert(Float,SO.Retensi)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		((Sum(B.NDPP)-Sum(B.NDPP*(Convert(Float,SO.Retensi)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then NilaiPPN else (1+NilaiPPN) )

		else

		((Sum(B.NDPP)-Sum(B.NDPP*(Convert(Float,SO.Retensi)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then NilaiPPN else (1+NilaiPPN) )*-1

		 

		else

		case when A.PPN>0 then Sum(B.NDPPRp)+(Isnull(A.DP,0)*NilaiPPN)+((Sum(B.NDPPRp)-Isnull(A.DP,0))*NilaiPPN) else Sum(B.NDPPRp)   Saldo, 

       A.Valas, A.Kurs KURS, 

       case when Isnull(SO.PPH22,0)<>0 Then  

        (Sum(B.NDPP)-Sum(B.NDPP*(Convert(Float,SO.Retensi)/100.00)))+((Sum(B.NDPP)-Sum(B.NDPP*(Convert(Float,SO.Retensi)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then NilaiPPN else (1+NilaiPPN) )-

		((Sum(B.NDPP)-Sum(B.NDPP*(Convert(Float,SO.Retensi)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		((Sum(B.NDPP)-Sum(B.NDPP*(Convert(Float,SO.Retensi)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then NilaiPPN else (1+NilaiPPN) )

		else

		((Sum(B.NDPP)-Sum(B.NDPP*(Convert(Float,SO.Retensi)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then NilaiPPN else (1+NilaiPPN) )*-1

		 

		else case when A.PPN>0 then Sum(B.NDPP)+(Isnull(A.DP,0)*NilaiPPN)+((Sum(B.NDPP)-Isnull(A.DP,0))*NilaiPPN) else Sum(B.NDPP)   DebetD, 0.00 Kreditd,

        case when Isnull(SO.PPH22,0)<>0 Then  

        (Sum(B.NDPP)-Sum(B.NDPP*(Convert(Float,SO.Retensi)/100.00)))+((Sum(B.NDPP)-Sum(B.NDPP*(Convert(Float,SO.Retensi)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then NilaiPPN else (1+NilaiPPN) )-

		((Sum(B.NDPP)-Sum(B.NDPP*(Convert(Float,SO.Retensi)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		((Sum(B.NDPP)-Sum(B.NDPP*(Convert(Float,SO.Retensi)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then NilaiPPN else (1+NilaiPPN) )

		else

		((Sum(B.NDPP)-Sum(B.NDPP*(Convert(Float,SO.Retensi)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then NilaiPPN else (1+NilaiPPN) )*-1

		 

		else 

		case when A.PPN>0 then Sum(B.NDPP)+(Isnull(A.DP,0)*NilaiPPN)+((Sum(B.NDPP)-Isnull(A.DP,0))*NilaiPPN) else Sum(B.NDPP)   SaldoD,  

       '' KodeSales, 'PT' Tipe, 

       E. PERKIRAAN, '' Catatan, 'BP' NoInvoice, A.Valas KodeVls_, A.Kurs Kurs_,A.NoBukti NoPajak

FROM   dbo.DBInvoicePL A      

Left Outer Join (select a.NoBukti,a.NoSO,(NDPP) NDPP,(NDPPRp) NDPPRp,NNET,NilaiPPN  from dbInvoicePLDet a 

                 )B On B.NoBukti=A.NoBukti

left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti

Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO                 

Left Outer Join dbo.vwBrowsCust E on E.KODECUSTSUPP=A.KodeCustSupp

Group by A.NoBukti, A.KodeCustSupp, A.Tanggal,so.PPH22,rpInv.TotNet,so.PPHDPP,

    ISNULL(A.PPh21,0),ISNULL(E.IsPPH21,0),ISNULL(NTotal,0),

	A.Valas, A.Kurs, A.NoJurnal, E.PERKIRAAN,A.DP,A.PPN,A.FLagTipe,A.NoInv,NilaiPPN

union all



--Retur Invoice

SELECT isnull(A.NOBUKTI,'-') NoFaktur, A.NoInvoice NoRetur, 'T' Tipetrans, A.KodeCustSupp KODECUSTSUPP, 

       A.NoJurnal Nobukti, CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) NoMsk, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) urut, A.TANGGAL, A.Tanggal JatuhTempo, 

        0.00 Debet, (Sum(B.NNETRp))  Kredit, (Sum(B.NNETRp)) Saldo, 

       A.KODEVLS, A.Kurs KURS, 

       0.00 DebetD, (Sum(B.NNETRp)) Kreditd, (Sum(B.NNETRp)) SaldoD,  

       '' KodeSales, 'PT' Tipe, 

       E. PERKIRAAN, '' Catatan, 'INVRPJ' NoInvoice, A.KODEVLS KodeVls_, A.Kurs Kurs_,A.NoBukti NoPajak

FROM   dbo.DBRInvoicePL A      

LEft Outer join dbo.dbRInvoicePLDet B on B.nobukti=A.nobukti

Left Outer Join dbo.vwBrowsCust E on E.KODECUSTSUPP=A.KodeCustSupp

Where A.NoJurnal<>'' --and a.NOBUKTI='bca/rinvc/0920/00001'

Group by A.NoBukti, A.KodeCustSupp, A.Tanggal,

	A.KODEVLS, A.Kurs, A.NoJurnal, E.PERKIRAAN,A.PPN,A.NoInvoice;

-- vwPostJurnalOto
CREATE VIEW IF NOT EXISTS vwPostJurnalOto AS --Beli

SELECT A.NoJurnal NOBUKTI, A.TglJurnal TANGGAL,

       case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI, 

       D.NAMACUSTSUPP + ' (' + A.KODESUPP + ')'  NOTE,0 LAMPIRAN, 

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) URUT, 

       F.PerkPers PERKIRAAN, D1.PERKIRAAN LAWAN,

       D.NamaCustSupp KETERANGAN, 

       '' KETERANGAN2, 

       SUM(B.NDPP) DEBET, 0 KREDIT, A.KODEVLS Valas, A.KURS, 

       SUM(B.NDPPRP) DEBETRP, 0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, 

       '' CUSTSUPPP,'' CUSTSUPPL, '' KODEP, 

       '' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO, null MYID, 'BL' JENIS, A.NoUrutJurnal NOURUT

       ,A.NOBUKTI NoBuktiTrans

FROM DBO.DBBELI A 

LEFT OUTER JOIN DBO.DBBELIDET B ON B.NOBUKTI = A.NOBUKTI 

LEFT OUTER JOIN DBO.VWBROWSSUPP D ON D.KODECUSTSUPP = A.KODESUPP

Left Outer join dbo.DBPERKCUSTSUPP D1 on D1.KODECUSTSUPP=A.KODESUPP and D1.Perkiraan=Case When A.TIPEBAYAR=0 Then '332' else '331'  

Left Outer Join dbo.DBBARANG E on E.KODEBRG=B.KODEBRG

Left Outer join dbo.dbSubGroup F on F.KodeGrp=E.KODEGRP and F.KodeSubGrp=E.KODESUBGRP

where A.NoJurnal<>'' and E.KodeGrp<>'JS'

GROUP BY A.NOBUKTI, A.TANGGAL, D.NAMACUSTSUPP, A.KODESUPP,

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5,

       F.PerkPers, D1.PERKIRAAN,  A.KODEVLS, A.KURS, A.NOURUT,

       B.NOPO,A.NoJurnal,A.TglJurnal, F.PerkH, A.NoUrutJurnal



Union ALL



SELECT A.NoJurnal NOBUKTI, A.TglJurnal TANGGAL,

       case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI, 

       D .NAMACUSTSUPP + ' (' + A.KODESUPP + ')'  NOTE,0 LAMPIRAN, 

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int)+500 URUT, 

       F.PerkPPN PERKIRAAN, D1.PERKIRAAN LAWAN,

       D.NamaCustSupp KETERANGAN,

       '' KETERANGAN2, 

       SUM(B.NPPN) DEBET, 0 KREDIT, A.KODEVLS Valas, A.KURS, 

       SUM(B.NPPNRp) DEBETRP, 0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, 

       '' CUSTSUPPP,'' CUSTSUPPL, '' KODEP, 

       '' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO, null MYID, 'BL' JENIS, A.NoUrutJurnal NOURUT

       ,A.NOBUKTI NoBuktiTrans

FROM DBO.DBBELI A 

LEFT OUTER JOIN DBO.DBBELIDET B ON B.NOBUKTI = A.NOBUKTI 

LEFT OUTER JOIN DBO.VWBROWSSUPP D ON D .KODECUSTSUPP = A.KODESUPP  

Left Outer join dbo.DBPERKCUSTSUPP D1 on D1.KODECUSTSUPP=A.KODESUPP and D1.Perkiraan=Case When A.TIPEBAYAR=0 Then '332' else '331'  

Left Outer Join dbo.DBBARANG E on E.KODEBRG=B.KODEBRG

Left Outer join dbo.dbSubGroup F on F.KodeGrp=E.KODEGRP and F.KodeSubGrp=E.KODESUBGRP

where A.NoJurnal<>'' and E.KodeGrp<>'JS'

GROUP BY A.NOBUKTI, A.TANGGAL, D.NAMACUSTSUPP, A.KODESUPP,

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5,

       F.PerkPPN, D1.PERKIRAAN,  A.KODEVLS, A.KURS, A.NOURUT,

       B.NOPO,A.NoJurnal,A.TglJurnal, F.PerkH, A.NoUrutJurnal



union all

 

SELECT A.NoJurnal NOBUKTI, A.TglJurnal TANGGAL,

       case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI, 

       D.NAMACUSTSUPP + ' (' + A.KODESUPP + ')'  NOTE,0 LAMPIRAN, 

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int)+1000 URUT, 

       a1.Perkiraan PERKIRAAN,  D1.PERKIRAAN LAWAN, 

       D.NamaCustSupp KETERANGAN, 

       '' KETERANGAN2, 

       Isnull(A1.Nilai,0) DEBET, 0 KREDIT, A.KODEVLS Valas, A.KURS, 

       Isnull(A1.Nilai,0) DEBETRP, 0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, 

       '' CUSTSUPPP,'' CUSTSUPPL, '' KODEP, 

       '' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO, null MYID, 'BL' JENIS, A.NoUrutJurnal NOURUT

       ,A.NOBUKTI NoBuktiTrans

FROM DBO.DBBELI A 

LEFT OUTER JOIN DBO.DBBELIDET B ON B.NOBUKTI = A.NOBUKTI 

LEFT OUTER JOIN DBO.VWBROWSSUPP D ON D.KODECUSTSUPP = A.KODESUPP

Left Outer join dbo.DBPERKCUSTSUPP D1 on D1.KODECUSTSUPP=A.KODESUPP and D1.Perkiraan=Case When A.TIPEBAYAR=0 Then '332' else '331'  

Left Outer Join dbo.DBBARANG E on E.KODEBRG=B.KODEBRG

left Outer Join (select SUM(Nilai)Nilai,NoBuktiInv,Perkiraan 

                 from DBPBIAYA a left outer join DBBIAYA b on b.Kodebiaya=a.Kodebiaya 

                 Group By NoBuktiInv,Perkiraan)A1 On A1.NoBuktiInv=A.NOBUKTI

where A.NoJurnal<>'' and E.KodeGrp<>'JS'

GROUP BY A.NOBUKTI, A.TANGGAL, D.NAMACUSTSUPP, A.KODESUPP,

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5,

        D1.PERKIRAAN,  A.KODEVLS, A.KURS, A.NOURUT,

       B.NOPO,A.NoJurnal,A.TglJurnal, A.NoUrutJurnal,A1.Nilai,a1.Perkiraan

having A1.Nilai>0



union all



SELECT A.NoJurnal NOBUKTI, A.TglJurnal TANGGAL,

       case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI, 

       D.NAMACUSTSUPP + ' (' + A.KODESUPP + ')'  NOTE,0 LAMPIRAN, 

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int)+1500 URUT, 

       F.PerkPers PERKIRAAN, F.PerkH LAWAN,

       D.NamaCustSupp KETERANGAN, 

       '' KETERANGAN2, 

       SUM(B.NDPP) DEBET, 0 KREDIT, A.KODEVLS Valas, A.KURS, 

       SUM(B.NDPPRP) DEBETRP, 0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, 

       '' CUSTSUPPP,'' CUSTSUPPL, '' KODEP, 

       '' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO, null MYID, 'BL' JENIS, A.NoUrutJurnal NOURUT

	   ,A.NOBUKTI NoBuktiTrans

FROM DBO.DBBELI A 

LEFT OUTER JOIN DBO.DBBELIDET B ON B.NOBUKTI = A.NOBUKTI 

LEFT OUTER JOIN DBO.VWBROWSSUPP D ON D.KODECUSTSUPP = A.KODESUPP

Left Outer join dbo.DBPERKCUSTSUPP D1 on D1.KODECUSTSUPP=A.KODESUPP and D1.Perkiraan=Case When A.TIPEBAYAR=0 Then '332' else '331'  

Left Outer Join dbo.DBBARANG E on E.KODEBRG=B.KODEBRG

Left Outer join dbo.dbSubGroup F on F.KodeGrp=E.KODEGRP and F.KodeSubGrp=E.KODESUBGRP

where A.NoJurnal<>'' and E.KodeGrp='JS' and A.TIPEBAYAR=1

GROUP BY A.NOBUKTI, A.TANGGAL, D.NAMACUSTSUPP, A.KODESUPP,

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5,

       F.PerkPers, D1.PERKIRAAN,  A.KODEVLS, A.KURS, A.NOURUT,

       B.NOPO,A.NoJurnal,A.TglJurnal, F.PerkH, A.NoUrutJurnal

union all

--Retur Beli

SELECT A.NoJurnal NOBUKTI, A.TglJurnal TANGGAL,

       case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI, 

       D .NAMACUSTSUPP + ' (' + A.KODESUPP + ')'  NOTE,0 LAMPIRAN, 

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) URUT, 

       D1.Perkiraan PERKIRAAN, F.PerkPers LAWAN,

       D.NamaCustSupp+A.NOBUKTI KETERANGAN, 

       '' KETERANGAN2, 

       SUM(B.NDPP) DEBET, 0 KREDIT, A.KODEVLS Valas, A.KURS, 

       SUM(B.NDPPRP) DEBETRP, 0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, 

       '' CUSTSUPPP,'' CUSTSUPPL, '' KODEP, 

       '' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO, null MYID, 'RBP' JENIS, A.NoUrutJurnal NOURUT

	   ,A.NOBUKTI NoBuktiTrans

FROM DBO.DBRBELI A 

LEFT OUTER JOIN DBO.DBRBELIDET B ON B.NOBUKTI = A.NOBUKTI 

LEFT OUTER JOIN DBO.VWBROWSSUPP D ON D .KODECUSTSUPP = A.KODESUPP

Left Outer join dbo.DBPERKCUSTSUPP D1 on D1.KODECUSTSUPP=A.KODESUPP and D1.Perkiraan=Case When A.TIPEBAYAR=0 Then '332' else '331'  

Left Outer Join dbo.DBBARANG E on E.KODEBRG=B.KODEBRG

Left Outer join dbo.dbSubGroup F on F.KodeGrp=E.KODEGRP and F.KodeSubGrp=E.KODESUBGRP

Left Outer join dbo.DBBELI G on G.NOBUKTI=B.NOPBL

where A.NoJurnal<>'' 

GROUP BY A.NOBUKTI, A.TANGGAL, D.NAMACUSTSUPP, A.KODESUPP,

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5,

       F.PerkPers, D.PERKIRAAN,  A.KODEVLS, A.KURS, A.NOURUT,

       A.NoJurnal,A.TglJurnal, F.PerkH, A.NoUrutJurnal, G.nobukti, G.Tanggal,D1.Perkiraan

union All

SELECT A.NoJurnal NOBUKTI, A.TglJurnal TANGGAL,

       case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI, 

       D .NAMACUSTSUPP + ' (' + A.KODESUPP + ')'  NOTE,0 LAMPIRAN, 

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int)+500 URUT, 

       D1.PERKIRAAN, F.PerkPPN LAWAN,

       D.NamaCustSupp+A.NOBUKTI KETERANGAN, 

       '' KETERANGAN2, 

       SUM(B.NPPN) DEBET, 0 KREDIT, A.KODEVLS Valas, A.KURS, 

       SUM(B.NPPNRP) DEBETRP, 0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, 

       '' CUSTSUPPP,'' CUSTSUPPL, '' KODEP, 

       '' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO, null MYID, 'RBP' JENIS, A.NoUrutJurnal NOURUT

	   ,A.NOBUKTI NoBuktiTrans

FROM DBO.DBRBELI A 

LEFT OUTER JOIN DBO.DBRBELIDET B ON B.NOBUKTI = A.NOBUKTI 

LEFT OUTER JOIN DBO.VWBROWSSUPP D ON D .KODECUSTSUPP = A.KODESUPP

Left Outer join dbo.DBPERKCUSTSUPP D1 on D1.KODECUSTSUPP=A.KODESUPP and D1.Perkiraan=Case When A.TIPEBAYAR=0 Then '332' else '331'  

Left Outer Join dbo.DBBARANG E on E.KODEBRG=B.KODEBRG

Left Outer join dbo.dbSubGroup F on F.KodeGrp=E.KODEGRP and F.KodeSubGrp=E.KODESUBGRP

Left Outer join dbo.DBBELI G on G.NOBUKTI=B.NOPBL

where A.NoJurnal<>'' 

GROUP BY A.NOBUKTI, A.TANGGAL, D.NAMACUSTSUPP, A.KODESUPP,

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5,

       F.PerkPPn, D.PERKIRAAN,  A.KODEVLS, A.KURS, A.NOURUT,

       A.NoJurnal,A.TglJurnal, F.PerkH, A.NoUrutJurnal, G.nobukti, G.Tanggal,D1.Perkiraan

union all



--SPB

SELECT A.NOBUKTI, A.TglJurnal TANGGAL,

       case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI, 

       I.NAMACUSTSUPP + ' (' + A.KodeCustSupp + ')'  NOTE,0 LAMPIRAN, 

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) URUT,  

       '511' PERKIRAAN, 

       H.PerkPers  LAWAN, 

       I.NAMACUSTSUPP KETERANGAN, '' KETERANGAN2, 

       Sum(B.Qnt * CONVERT(Numeric(18,2),Case When Isnull(G1.HPP,0)=0 Then F.Hrg1_2 else G1.HPP )) DEBET, 0 KREDIT, 'IDR' VALAS, 1 KURS, 

       Sum(B.Qnt * CONVERT(Numeric(18,2),Case When Isnull(G1.HPP,0)=0 Then F.Hrg1_2 else G1.HPP )) DEBETRP, 0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, '' CUSTSUPPP, '' CUSTSUPPL, '' KODEP, 

       '' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO, null MYID, 'SPB' JENIS, A.NoUrutJurnal NOURUT

	   ,A.NOBUKTI NoBuktiTrans

FROM  DBO.dbSPB A 

LEFT OUTER JOIN DBO.dbSPBDet B ON B.NOBUKTI = A.NOBUKTI 

left outer join dbSPPDet F1 on F1.NoBukti=b.NoSPP and F1.KodeBrg=b.KodeBrg and f1.Urut=b.UrutSPP

LEFT outer join (select Bulan,Tahun,KodeBrg,HPPBrg HPP from dbHPPProduksi)G1 on G1.KodeBrg=b.KodeBrg and G1.Bulan=month(A.TANGGAL) and G1.Tahun=YEAR(a.TANGGAL)

LEFT OUTER JOIN DBO.DBBARANG F ON F.KODEBRG = B.KODEBRG 

LEFT OUTER JOIN DBO.DBGROUP G ON G.KODEGRP = F.KODEGRP

LEFT OUTER JOIN DBO.dbSubGroup H ON H.KodeSubGrp = F.KODESUBGRP and H.KodeGrp=F.KODEGRP

Left outer join dbo.DBCUSTSUPP I on I.KODECUSTSUPP=A.KodeCustSupp

Group by A.NoJurnal, A.TglJurnal, 

      A.NOBUKTI, H.NamaSubGrp, H.KodeSubGrp,A.TANGGAL,

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       H.PerkPPN, H.PerkPers,A.NoUrutJurnal,I.NAMACUSTSUPP,A.KodeCustSupp

union all

SELECT A.NOBUKTI, A.TglJurnal TANGGAL,

       case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI,  

       D.NAMACUSTSUPP + ' (' + A.KodeCustSupp + ')'  NOTE,0 LAMPIRAN, 

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int)+500 URUT, 

       '133' PERKIRAAN, '501' LAWAN,

       D.NAMACUSTSUPP  KETERANGAN, 

       '' KETERANGAN2, 

       SUM((B.qnt*(case when isnull(G.PPN,0)=2 then G.HARGA/1.1 else G.HARGA ))-

           ((B.qnt*(case when isnull(G.PPN,0)=2 then G.HARGA/1.1 else G.HARGA ))*G.DISC/100)) DEBET, 

       0 KREDIT, 'IDR' Valas, 1 KURS, 

       SUM((B.qnt*(case when isnull(G.PPN,0)=2 then G.HARGA/1.1 else G.HARGA ))-

           ((B.qnt*(case when isnull(G.PPN,0)=2 then G.HARGA/1.1 else G.HARGA ))*G.DISC/100)) DEBETRP, 

       0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, 

       '' CUSTSUPPP,'' CUSTSUPPL, '' KODEP,'' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, 

       '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO,

       null MYID, 'SPB' JENIS, A.NoUrutJurnal NOURUT

	   ,A.NOBUKTI NoBuktiTrans

FROM dbo.dbspb A  

Left Outer Join dbSPBDet b on b.NoBukti=a.NoBukti

left outer join dbSPPDet F on F.NoBukti=b.NoSPP and F.KodeBrg=b.KodeBrg and F.Urut=B.UrutSPP

LEFT outer join DBSODET G on G.NOBUKTI=f.NoSO and G.KodeBrg=b.KodeBrg and G.URUT=F.UrutSO

LEFT outer join DBBARANG C on c.KODEBRG=b.KODEBRG

left outer join dbSubGroup E on E.KodeSubGrp=C.KODESUBGRP and E.KodeGrp=C.KODEGRP

LEFT OUTER JOIN DBO.dbCustSupp D ON D .KODECUSTSUPP = A.KodeCustSupp

GROUP BY A.NOBUKTI, A.TANGGAL, D.NAMACUSTSUPP,A.KodeCustSupp,e.perkh,

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5,

       A.NOURUT,

       A.NoJurnal,A.TglJurnal, A.NoUrutJurnal

union all

SELECT A.NOBUKTI, A.TglJurnal TANGGAL,

       case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI,  

       D.NAMACUSTSUPP + ' (' + A.KodeCustSupp + ')'  NOTE,0 LAMPIRAN, 

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int)+1000 URUT, 

       '133' PERKIRAAN,'367'  LAWAN,

       D.NAMACUSTSUPP  KETERANGAN, 

       '' KETERANGAN2, 

       SUM((B.qnt*(case when isnull(G.PPN,0)=2 then G.HARGA/1.1 else G.HARGA ))-

           ((B.qnt*(case when isnull(G.PPN,0)=2 then G.HARGA/1.1 else G.HARGA ))*G.DISC/100))*0.1 DEBET, 

       0 KREDIT, 'IDR' Valas, 1 KURS, 

       SUM((B.qnt*(case when isnull(G.PPN,0)=2 then G.HARGA/1.1 else G.HARGA ))-

           ((B.qnt*(case when isnull(G.PPN,0)=2 then G.HARGA/1.1 else G.HARGA ))*G.DISC/100))*0.1 DEBETRP, 

       0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, 

       '' CUSTSUPPP,'' CUSTSUPPL, '' KODEP,'' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, 

       '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO,

       null MYID, 'SPB' JENIS, A.NoUrutJurnal NOURUT

       ,A.NOBUKTI NoBuktiTrans

FROM dbo.dbspb A  

Left Outer Join dbSPBDet b on b.NoBukti=a.NoBukti

left outer join dbSPPDet F on F.NoBukti=b.NoSPP and F.KodeBrg=b.KodeBrg and F.Urut=B.UrutSPP

LEFT outer join DBSODET G on G.NOBUKTI=f.NoSO and G.KodeBrg=b.KodeBrg and G.URUT=F.UrutSO

LEFT outer join DBBARANG C on c.KODEBRG=b.KODEBRG

left outer join dbSubGroup E on E.KodeSubGrp=C.KODESUBGRP

LEFT OUTER JOIN DBO.dbCustSupp D ON D .KODECUSTSUPP = A.KodeCustSupp

where G.PPN IN(1,2)

GROUP BY A.NOBUKTI, A.TANGGAL, D.NAMACUSTSUPP,A.KodeCustSupp,e.perkh,

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5,

       A.NOURUT,

       A.NoJurnal,A.TglJurnal, A.NoUrutJurnal

union all



--RSPB

SELECT A.NOBUKTI, A.TglJurnal TANGGAL,

       case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI,  

       I.NAMACUSTSUPP + ' (' + A.KodeCustSupp + ')'  NOTE,0 LAMPIRAN, 

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) URUT,  

       H.PerkPers PERKIRAAN, 

       '511'  LAWAN, 

       I.NAMACUSTSUPP KETERANGAN, '' KETERANGAN2, 

       Sum(B.Qnt * CONVERT(Numeric(18,2),Case When Isnull(G1.HPP,0)=0 Then F.Hrg1_2 else G1.HPP )) DEBET, 0 KREDIT, 'IDR' VALAS, 1 KURS, 

       Sum(B.Qnt * CONVERT(Numeric(18,2),Case When Isnull(G1.HPP,0)=0 Then F.Hrg1_2 else G1.HPP )) DEBETRP, 0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, '' CUSTSUPPP, '' CUSTSUPPL, '' KODEP, 

       '' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO, null MYID, 'RSPB' JENIS, A.NoUrutJurnal NOURUT

	  ,A.NOBUKTI NoBuktiTrans

FROM  DBO.DBRSPB A 

LEFT OUTER JOIN DBO.DBRSPBDet B ON B.NOBUKTI = A.NOBUKTI 

Left Outer Join dbSPBDet C ON C.NoBukti=B.NoSPB and C.KodeBrg=B.KodeBrg

left outer join dbSPPDet F1 on F1.NoBukti=c.NoSPP and F1.KodeBrg=b.KodeBrg

LEFT outer join (select Bulan,Tahun,KodeBrg,HPPBrg HPP from dbHPPProduksi)G1 on G1.KodeBrg=b.KodeBrg and G1.Bulan=month(A.TANGGAL) and G1.Tahun=YEAR(a.TANGGAL)

LEFT OUTER JOIN DBO.DBBARANG F ON F.KODEBRG = B.KODEBRG 

LEFT OUTER JOIN DBO.DBGROUP G ON G.KODEGRP = F.KODEGRP

LEFT OUTER JOIN DBO.dbSubGroup H ON H.KodeSubGrp = F.KODESUBGRP and H.KodeGrp=F.KODEGRP

Left outer join dbo.DBCUSTSUPP I on I.KODECUSTSUPP=A.KodeCustSupp

Group by A.NoJurnal, A.TglJurnal, 

      A.NOBUKTI, H.NamaSubGrp, H.KodeSubGrp,A.TANGGAL,

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       H.PerkPPN, H.PerkPers,A.NoUrutJurnal,I.NAMACUSTSUPP,A.KodeCustSupp

union all

SELECT A.NOBUKTI, A.TglJurnal TANGGAL,

       case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI,  

       D.NAMACUSTSUPP + ' (' + A.KodeCustSupp + ')'  NOTE,0 LAMPIRAN, 

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int)+500 URUT, 

       '501' PERKIRAAN, '133' LAWAN,

       D.NAMACUSTSUPP  KETERANGAN, 

       '' KETERANGAN2, 

       SUM((B.qnt*(case when isnull(G.PPN,0)=2 then G.HARGA/1.1 else G.HARGA ))-

           ((B.qnt*(case when isnull(G.PPN,0)=2 then G.HARGA/1.1 else G.HARGA ))*G.DISC/100)) DEBET, 

       0 KREDIT, 'IDR' Valas, 1 KURS, 

       SUM((B.qnt*(case when isnull(G.PPN,0)=2 then G.HARGA/1.1 else G.HARGA ))-

           ((B.qnt*(case when isnull(G.PPN,0)=2 then G.HARGA/1.1 else G.HARGA ))*G.DISC/100)) DEBETRP, 

       0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, 

       '' CUSTSUPPP,'' CUSTSUPPL, '' KODEP,'' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, 

       '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO,

       null MYID, 'RSPB' JENIS, A.NoUrutJurnal NOURUT

       ,A.NOBUKTI NoBuktiTrans

FROM  dbo.DBRSPB A  

Left Outer Join DBRSPBDet b on b.NoBukti=a.NoBukti

LEFT Outer Join dbSPBDet C On C.NoBukti=b.NoSPB and C.KodeBrg=b.KodeBrg

left outer join dbSPPDet F on F.NoBukti=c.NoSPP and F.KodeBrg=b.KodeBrg and F.Urut=c.UrutSPP

LEFT outer join DBSODET G on G.NOBUKTI=f.NoSO and G.KodeBrg=b.KodeBrg and G.URUT=F.UrutSO

LEFT outer join DBBARANG C1 on c1.KODEBRG=b.KODEBRG

left outer join dbSubGroup E on E.KodeSubGrp=C1.KODESUBGRP

LEFT OUTER JOIN DBO.dbCustSupp D ON D .KODECUSTSUPP = A.KodeCustSupp

GROUP BY A.NOBUKTI, A.TANGGAL, D.NAMACUSTSUPP,A.KodeCustSupp,e.perkh,

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5,

       A.NOURUT,

       A.NoJurnal,A.TglJurnal, A.NoUrutJurnal

union all

SELECT A.NOBUKTI, A.TglJurnal TANGGAL,

       case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI, 

       D.NAMACUSTSUPP + ' (' + A.KodeCustSupp + ')'  NOTE,0 LAMPIRAN, 

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int)+1000 URUT, 

       '367' PERKIRAAN,'133' LAWAN,

       D.NAMACUSTSUPP  KETERANGAN, 

       '' KETERANGAN2, 

       SUM((B.qnt*(case when isnull(G.PPN,0)=2 then G.HARGA/1.1 else G.HARGA ))-

           ((B.qnt*(case when isnull(G.PPN,0)=2 then G.HARGA/1.1 else G.HARGA ))*G.DISC/100))*0.1 DEBET, 

       0 KREDIT, 'IDR' Valas, 1 KURS, 

       SUM((B.qnt*(case when isnull(G.PPN,0)=2 then G.HARGA/1.1 else G.HARGA ))-

           ((B.qnt*(case when isnull(G.PPN,0)=2 then G.HARGA/1.1 else G.HARGA ))*G.DISC/100))*0.1 DEBETRP, 

       0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, 

       '' CUSTSUPPP,'' CUSTSUPPL, '' KODEP,'' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, 

       '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO,

       null MYID, 'RSPB' JENIS, A.NoUrutJurnal NOURUT

       ,A.NOBUKTI NoBuktiTrans

FROM dbo.dbspb A  

Left Outer Join dbSPBDet b on b.NoBukti=a.NoBukti

left outer join dbSPPDet F on F.NoBukti=b.NoSPP and F.KodeBrg=b.KodeBrg and F.Urut=B.UrutSPP

LEFT outer join DBSODET G on G.NOBUKTI=f.NoSO and G.KodeBrg=b.KodeBrg and G.URUT=F.UrutSO

LEFT outer join DBBARANG C on c.KODEBRG=b.KODEBRG

left outer join dbSubGroup E on E.KodeSubGrp=C.KODESUBGRP

LEFT OUTER JOIN DBO.dbCustSupp D ON D .KODECUSTSUPP = A.KodeCustSupp

where G.PPN IN(1,2)

GROUP BY A.NOBUKTI, A.TANGGAL, D.NAMACUSTSUPP,A.KodeCustSupp,e.perkh,

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5,

       A.NOURUT,

       A.NoJurnal,A.TglJurnal, A.NoUrutJurnal

union all



--Invoice

SELECT A.NoJurnal NOBUKTI, A.TglJurnal TANGGAL,

       case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI,  

       D.NAMACUSTSUPP + ' (' + A.KodeCustSupp + ')'  NOTE,0 LAMPIRAN, 

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) URUT, 

       '131' PERKIRAAN, '133' LAWAN,

       D.NAMACUSTSUPP  KETERANGAN, 

       '' KETERANGAN2, 

       case when Isnull(SO.PPH22,0)<>0 Then 

       (Sum(B.NDPP)-Sum(B.NDPP*(Convert(Float,SO.Retensi)/100.00)))+((Sum(B.NDPP)-Sum(B.NDPP*(Convert(Float,SO.Retensi)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

       else

       case when A.PPN>0 then Sum(B.NDPPRp)+(Isnull(A.DP,0)*0.1)+((Sum(B.NDPPRp)-Isnull(A.DP,0))*0.1) else Sum(B.NDPPRp)   DEBET,

        0 KREDIT, 'IDR' Valas, 1 KURS, 

       case when Isnull(SO.PPH22,0)<>0 Then 

       (Sum(B.NDPP)-Sum(B.NDPP*(Convert(Float,SO.Retensi)/100.00)))+((Sum(B.NDPP)-Sum(B.NDPP*(Convert(Float,SO.Retensi)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

       else

       case when A.PPN>0 then Sum(B.NDPPRp)+(Isnull(A.DP,0)*0.1)+((Sum(B.NDPPRp)-Isnull(A.DP,0))*0.1) else Sum(B.NDPPRp)   DEBETRP,

        0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, 

       '' CUSTSUPPP,'' CUSTSUPPL, '' KODEP,'' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, 

       '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO,

       null MYID, 'BP' JENIS, A.NoUrutJurnal NOURUT

       ,A.NOBUKTI NoBuktiTrans

FROM dbo.dbInvoicePL A  

Left Outer Join dbInvoicePLDet b on b.NoBukti=a.NoBukti

left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti

Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO                 

LEFT OUTER JOIN DBO.dbCustSupp D ON D .KODECUSTSUPP = A.KodeCustSupp

where A.NoJurnal<>'' 

GROUP BY A.NOBUKTI, A.TANGGAL, D.NAMACUSTSUPP,A.KodeCustSupp,so.PPH22,so.PPHDPP,so.Retensi,rpInv.TotNet,

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5,

       A.NOURUT,ISNULL(A.PPh21,0),ISNULL(D.IsPPH21,0),ISNULL(NTotal,0),

       A.NoJurnal,A.TglJurnal, A.NoUrutJurnal,A.PPN,A.DP

union all

SELECT A.NoJurnal NOBUKTI, A.TglJurnal TANGGAL,

       case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI,  

       D.NAMACUSTSUPP + ' (' + A.KodeCustSupp + ')'  NOTE,0 LAMPIRAN, 

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int)+500 URUT, 

       Case When rpInv.TotNet<=SO.PPHDPP Then'131' else '133'  PERKIRAAN, Case When rpInv.TotNet<=SO.PPHDPP Then '133' else '131'  LAWAN,

       D.NAMACUSTSUPP  KETERANGAN, 

       '' KETERANGAN2, 

       case when Isnull(SO.PPH22,0)<>0 Then

       ((Sum(B.NDPP)-Sum(B.NDPP*(Convert(Float,SO.Retensi)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 ) else 0  DEBET,

       0 KREDIT, 'IDR' Valas, 1 KURS, 

       case when Isnull(SO.PPH22,0)<>0 Then

       ((Sum(B.NDPP)-Sum(B.NDPP*(Convert(Float,SO.Retensi)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 ) else 0  DEBETRP,

       0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, 

       '' CUSTSUPPP,'' CUSTSUPPL, '' KODEP,'' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, 

       '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO,

       null MYID, 'BP' JENIS, A.NoUrutJurnal NOURUT

       ,A.NOBUKTI NoBuktiTrans

FROM dbo.dbInvoicePL A  

Left Outer Join dbInvoicePLDet b on b.NoBukti=a.NoBukti

left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti

Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO                 

LEFT OUTER JOIN DBO.dbCustSupp D ON D .KODECUSTSUPP = A.KodeCustSupp

where A.NoJurnal<>'' 

GROUP BY A.NOBUKTI, A.TANGGAL, D.NAMACUSTSUPP,A.KodeCustSupp,SO.PPH22,so.Retensi,so.PPHDPP,rpInv.TotNet,

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5,

       A.NOURUT,ISNULL(A.PPh21,0),ISNULL(D.IsPPH21,0),ISNULL(NTotal,0),

       A.NoJurnal,A.TglJurnal, A.NoUrutJurnal,A.PPN,A.DP

union all

SELECT A.NoJurnal NOBUKTI, A.TglJurnal TANGGAL,

       case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI, 

       D.NAMACUSTSUPP + ' (' + A.KodeCustSupp + ')'  NOTE,0 LAMPIRAN, 

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int)+1000 URUT, 

       '181' PERKIRAAN, '131' LAWAN,

       D.NAMACUSTSUPP  KETERANGAN, 

       '' KETERANGAN2, 

       case when Isnull(SO.PPH22,0)<>0 Then 

       (Sum(B.NDPP)-Sum(B.NDPP*(Convert(Float,SO.Retensi)/100.00)))*(SO.PPH22/100)

       else

       0  DEBET,

        0 KREDIT, 'IDR' Valas, 1 KURS, 

       case when Isnull(SO.PPH22,0)<>0 Then 

       (Sum(B.NDPP)-Sum(B.NDPP*(Convert(Float,SO.Retensi)/100.00)))*(SO.PPH22/100)

       else

       0  DEBETRP,

        0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, 

       '' CUSTSUPPP,'' CUSTSUPPL, '' KODEP,'' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, 

       '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO,

       null MYID, 'BP' JENIS, A.NoUrutJurnal NOURUT

       ,A.NOBUKTI NoBuktiTrans

FROM dbo.dbInvoicePL A  

Left Outer Join dbInvoicePLDet b on b.NoBukti=a.NoBukti

left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti

Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO                 

LEFT OUTER JOIN DBO.dbCustSupp D ON D .KODECUSTSUPP = A.KodeCustSupp

where A.NoJurnal<>'' 

and Isnull(SO.PPH22,0)<>0

GROUP BY A.NOBUKTI, A.TANGGAL, D.NAMACUSTSUPP,A.KodeCustSupp,so.PPH22,so.PPHDPP,so.Retensi,rpInv.TotNet,

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5,

       A.NOURUT,

       A.NoJurnal,A.TglJurnal, A.NoUrutJurnal,A.PPN,A.DP

union all



--Retur Invoice

SELECT A.NoJurnal NOBUKTI, A.TglJurnal TANGGAL,case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI,  

      'Retur Invoice Penjualan : ' + isnull(I.NAMACUSTSUPP,'') + ' (' + Isnull(I.KODECUSTSUPP,'') + ')' NOTE,0 LAMPIRAN, 

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) URUT,  

       '503' PERKIRAAN, 

       '131'  LAWAN, 

       'Retur Invoice Penjualan : ' + A.NOBUKTI +' TANGGAL : '+ Convert(Varchar(15),A.Tanggal, 105)+CHAR(13)+ 

       'No. Invoice : '+A.NoInvoice+' TANGGAL : '+ Convert(Varchar(15),A.TglInvoice, 105) KETERANGAN, '' KETERANGAN2, 

       Sum(B.NDPP) DEBET, 0 KREDIT, A.Kodevls VALAS, A.Kurs, 

       Sum(B.NDPPRp) DEBETRP, 0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, '' CUSTSUPPP, A.KODECUSTSUPP CUSTSUPPL, '' KODEP, 

       '' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '01' KODEBAG, '' STATUSGIRO, A.MYID, 

       'INVRPJ' JENIS, A.NoUrutJurnal NOURUT,A.NOBUKTI NoBuktiTrans

FROM  DBO.dbRInvoicePL A 

LEFT OUTER JOIN DBO.DBRInvoicePLDET B ON B.NOBUKTI = A.NOBUKTI 

LEFT OUTER JOIN DBO.DBBARANG F ON F.KODEBRG = B.KODEBRG 

Left outer join dbo.DBCUSTSUPP I on I.KODECUSTSUPP=A.KodeCustSupp

Left Outer join (Select x.Perkiraan

                 from dbo.DBPOSTHUTPIUT x

                 where x.Kode='PD') J on 1=1

Where A.noJurnal<>'' 

Group by A.NoJurnal, A.TglJurnal,A.KODEVLS, A.Kurs, 

      A.NOBUKTI,i.NAMACUSTSUPP, I.KODECUSTSUPP,A.TANGGAL,A.KODECUSTSUPP,

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       J.Perkiraan,I.PERKIRAAN,A.NoUrutJurnal, A.MyID, A.NoInvoice,A.TglInvoice



Union All



SELECT A.NoJurnal NOBUKTI, A.TglJurnal TANGGAL,case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI, 

      'Retur Invoice Penjualan : ' + isnull(I.NAMACUSTSUPP,'') + ' (' + Isnull(I.KODECUSTSUPP,'') + ')' NOTE,0 LAMPIRAN, 

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int)+500 URUT,  

       '367' PERKIRAAN, 

       '131'  LAWAN, 

       'Retur Invoice Penjualan : ' + A.NOBUKTI +' TANGGAL : '+ Convert(Varchar(15),A.Tanggal, 105)+CHAR(13)+  

       'Faktur Pajak Retur : ' + isnull(I.NAMACUSTSUPP,'') + ' (' + Isnull(I.KODECUSTSUPP,'') + ')'+

       Case when isnull(L.NOFPJ,'')='' then '' else CHAR(13)+'No. FPJ : '+L.NOFPJ+' TANGGAL : '+ isnull(Convert(Varchar(15),L.TglFPJ, 105),'')+CHAR(13)+

       'Atas No. Invoice : '+A.NoInvoice+' TANGGAL : '+ Convert(Varchar(15),A.TglInvoice, 105)  KETERANGAN, '' KETERANGAN2, 

       Sum(B.NPPNRP) DEBET, 0 KREDIT, A.KODEVLS VALAS, A.Kurs, 

       Sum(B.NPPNRP) DEBETRP, 0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, '' CUSTSUPPP, A.KODECUSTSUPP CUSTSUPPL, '' KODEP, 

       '' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '01' KODEBAG, '' STATUSGIRO, A.MYID, 

       'INVRPJ' JENIS, A.NoUrutJurnal NOURUT,A.NOBUKTI NoBuktiTrans

FROM  DBO.dbRInvoicePL A 

LEFT OUTER JOIN (Select NoBukti,SUM(NPPNRp) NPPNRP From DBO.DBRInvoicePLDET Group by NoBukti) B ON B.NOBUKTI = A.NOBUKTI 

Left outer join dbo.DBCUSTSUPP I on I.KODECUSTSUPP=A.KodeCustSupp

Left Outer join (Select x.Perkiraan

                 from dbo.DBPOSTHUTPIUT x

                 where x.Kode='PPK') J on 1=1

Left Outer Join DBPajakMasuk L on L.NoBukti=A.NoBukti

Where A.noJurnal<>'' 

Group by A.NoJurnal, A.TglJurnal,A.KODECUSTSUPP,A.KODEVLS, A.Kurs,L.NOFPJ, L.TglFPJ,A.KODECUSTSUPP, 

      A.NOBUKTI,i.NAMACUSTSUPP, I.KODECUSTSUPP,A.TANGGAL,

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       J.Perkiraan,I.PERKIRAAN,A.NoUrutJurnal, A.MyID, A.NoInvoice,A.TglInvoice

Having SUM(B.NPPNRP)<>0



Union All



SELECT A.NoJurnal NOBUKTI, A.TglJurnal TANGGAL,

       case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI,  

       'Retur Invoice Penjualan Gudang : ' + isnull(I.NAMACUSTSUPP,'') + ' (' + Isnull(A.KODECUSTSUPP,'') + ')'  NOTE,0 LAMPIRAN, 

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int)+2000 URUT,  

       H.PerkPers PERKIRAAN, 

       '511'  LAWAN, 

       'Retur Invoice Penjualan Gudang : ' + A.NOBUKTI +' TANGGAL : '+ Convert(Varchar(15),A.Tanggal, 105)+CHAR(13)+ 

       'No. Bukti : '+A.NoBukti+' TANGGAL : '+ Convert(Varchar(15),A.Tanggal, 105) KETERANGAN, '' KETERANGAN2, 

       isnull(Sum(case when B.NOSAT=1 Then B.QNT Else B.QNT2 *case when B.NOSAT=1 Then case when F.KODEGRP='FG' then CONVERT(Numeric(18,2),Case When Isnull(G1.HPP,0)=0 Then isnull(F.Hrg1_2,0) else isnull(G1.HPP,0) ) else isnull(B.HPP,0)  else 

                                                                  case when F.KODEGRP='FG' then CONVERT(Numeric(18,2),Case When Isnull(G1.HPP,0)=0 Then isnull(F.Hrg1_2,0)*B.ISI else isnull(G1.HPP,0)*F.ISI2 ) else isnull(B.HPP,0)*F.ISI2   ),0) DEBET, 0 KREDIT, 'IDR' VALAS, 1 KURS, 

       isnull(Sum(case when B.NOSAT=1 Then B.QNT Else B.QNT2 *case when B.NOSAT=1 Then case when F.KODEGRP='FG' then CONVERT(Numeric(18,2),Case When Isnull(G1.HPP,0)=0 Then isnull(F.Hrg1_2,0) else isnull(G1.HPP,0) ) else isnull(B.HPP,0)  else 

                                                                  case when F.KODEGRP='FG' then CONVERT(Numeric(18,2),Case When Isnull(G1.HPP,0)=0 Then isnull(F.Hrg1_2,0)*B.ISI else isnull(G1.HPP,0)*F.ISI2 ) else isnull(B.HPP,0)*F.ISI2   ),0) DEBETRP, 0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, '' CUSTSUPPP, '' CUSTSUPPL, '' KODEP, 

       '' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO, null MYID, 'INVRPJ' JENIS, A.NoUrutJurnal NOURUT,A.NOBUKTI NoBuktiTrans

FROM  DBO.dbSPBRJual A 

LEFT OUTER JOIN DBO.dbSPBRJualDet B ON B.NOBUKTI = A.NOBUKTI 

LEFT outer join (select Bulan,Tahun,KodeBrg,HPPBrg HPP from dbHPPProduksi)G1 on G1.KodeBrg=b.KodeBrg and G1.Bulan=month(A.TANGGAL) and G1.Tahun=YEAR(a.TANGGAL)

LEFT OUTER JOIN DBO.DBBARANG F ON F.KODEBRG = B.KODEBRG 

LEFT OUTER JOIN DBO.DBGROUP G ON G.KODEGRP = F.KODEGRP

LEFT OUTER JOIN DBO.dbSubGroup H ON H.KodeSubGrp = F.KODESUBGRP and H.KodeGrp=F.KODEGRP

Left outer join dbo.DBCUSTSUPP I on I.KODECUSTSUPP=A.KodeCustSupp

Where A.noJurnal<>'' 

Group by A.NoJurnal, A.TglJurnal, 

      A.NOBUKTI, H.NamaSubGrp, H.KodeSubGrp,A.TANGGAL,

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       H.PerkPPN, H.PerkPers,A.NoUrutJurnal,I.NAMACUSTSUPP,A.KodeCustSupp



union all



--Hasil Produksi

SELECT A.NoJurnal NOBUKTI, A.TglJurnal TANGGAL,case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI, 

       A.NOBUKTI NOTE,0 LAMPIRAN, 

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) URUT,  

       H.PerkPers PERKIRAAN, '159' LAWAN,

       A.NOBUKTI+' HASIL PRODUKSI PRODUK '+h.NamaSubGrp KETERANGAN, '' KETERANGAN2, 

       Sum(case when B.NOSAT=1 then B.Qnt else B.Qnt*B.ISI *Case When Isnull(HPP.HPP,0)=0 Then b.HPP else HPP.HPP ) DEBET, 0 KREDIT, 'IDR' VALAS, 1 KURS, 

       Sum(case when B.NOSAT=1 then B.Qnt else B.Qnt*B.ISI *Case When Isnull(HPP.HPP,0)=0 Then b.HPP else HPP.HPP ) DEBETRP, 0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, '' CUSTSUPPP, '' CUSTSUPPL, '' KODEP, 

       '' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO, null MYID, 'HPR' JENIS, A.NoUrutJurnal NOURUT

       ,A.NOBUKTI NoBuktiTrans

FROM  DBO.DBHASILPRD A 

LEFT OUTER JOIN DBO.DBHASILPRDDet B ON B.NOBUKTI = A.NOBUKTI 

Left Outer Join (select Bulan,Tahun,KodeBrg,HPPBrg HPP from dbHPPProduksi) HPP on HPP.KODEBRG=b.KODEBRG and hpp.Bulan=month(A.TANGGAL) and hpp.Tahun=YEAR(a.TANGGAL)

LEFT OUTER JOIN DBO.DBBARANG F ON F.KODEBRG = B.KODEBRG 

LEFT OUTER JOIN DBO.DBGROUP G ON G.KODEGRP = F.KODEGRP

LEFT OUTER JOIN DBO.dbSubGroup H ON H.KodeSubGrp = F.KODESUBGRP and H.KodeGrp=F.KODEGRP

Where  Isnull(H.PerkPers,'')<>''

Group by A.NoJurnal, A.TglJurnal, 

      A.NOBUKTI, H.NamaSubGrp, H.KodeSubGrp,A.TANGGAL,

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       H.PerkPPN, H.PerkPers,A.NoUrutJurnal,A.NoJurnal,F.KODESUBGRP;

-- vwQntBeliDariPO
CREATE VIEW IF NOT EXISTS vwQntBeliDariPO AS select NOPO, UrutPO, KodeBrg, sum(Qnt*Isi) QntSat1 from dbBeliDet

where NOPO<>'-' group by NOPO, UrutPO, KodeBrg;

-- vwQntRBeliDariBeli
CREATE VIEW IF NOT EXISTS vwQntRBeliDariBeli AS select B.NoBeli, A.UrutPBL, A.KodeBrg, sum(A.Qnt) QntSat1, sum(A.Qnt2) QntSat2 from dbRBeliDet A, dbRBeli B

where A.NoBukti=B.NoBukti and B.NoBeli<>'-' group by B.NoBeli, A.UrutPBL, A.KodeBrg;

-- vwRegStock
CREATE VIEW IF NOT EXISTS vwRegStock AS Select 	Tipe, Prioritas, KodeBrg, QntDb, Qnt2Db, HrgDebet, QntCr, Qnt2Cr, HrgKredit, 

	QntSaldo, Qnt2Saldo, HrgSaldo, Tanggal, Bulan, Tahun, NoBukti, 

	KodeCustSupp, Keterangan, IDUser, HPP

From 	dbo.vwKartuStock;

-- VwReportBeliGudang
CREATE VIEW IF NOT EXISTS VwReportBeliGudang AS Select 	A.NoBukti,A.TANGGAL, B.NoPO, B.UrutPO,A.KODESUPP KodeCustSupp,I.NAMACUSTSUPP,

	    B.Urut, B.KodeBrg,case when H.IsJasa=1 Then Case When Isnull(B.NamaBrg,'')='' Then H.NamaBrg else B.NamaBrg  else H.NamaBrg  NamaBrg,b.QNT as qntbeli,b.SATUAN as satbeli,

	    isnull(B.Qnt1Terima,0) as qnt, h.SAT1 as satuan,

        isnull(b.Qnt2Terima,0) as Qnt2,h.SAT2 As satuan2,

        B.Qnt1Reject as qntreject,

        B.Qnt2Reject as qnt2reject,

        B.Harga, B.HrgNetto,B.DiscP,B.DiscTot,

        case when a.kodevls<>'IDR' then B.NDPP else 0  as NDPP

        ,B.NDPPRp,b.NPPNRp,b.NNETRp,

        B.KodeGdg,A.KODEVLS,A.KURS,A.FAKTURSUPP,

        Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                      Case when A.IsOtorisasi2=1 then 1 else 0 +

                      Case when A.IsOtorisasi3=1 then 1 else 0 +

                      Case when A.IsOtorisasi4=1 then 1 else 0 +

                      Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                 else 1

             As INTEGER) NeedOtorisasi,ISNULL(H.IsJasa,0)IsJasa,P.Keterangan,

        isnull(A1.Nilai,0) ByLain,isnull(B.NNETRp,0)+isnull(B.BYAngkut,0)+isnull(A1.Nilai,0) GrandTotal,A.TIPEBAYAR,

        k.Keterangan nmPerkiraan,b.Perkiraan,LEFT(H.KODESUBGRP,6)KodeGroup,J.NamaSubGrp,a.Devisi

From dbBeliDet B 

Left Outer Join dbBeli A On A.NoBukti=b.NoBukti

Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg

Left Outer Join (select a.NoBukti,a.urut,b.Keterangan from DBPODET a

                 Left Outer Join (select NoBukti,Urut,Keterangan from DBPPLDET Group By NoBukti,Urut,Keterangan) b on a.NoPPL=b.Nobukti and a.UrutPPL=b.urut)P on P.NOBUKTI=B.NoPO and P.urut=B.UrutPO 

Left Outer Join DBCUSTSUPP I on A.KODESUPP = I.KODECUSTSUPP

Left Outer Join (select SUM(Nilai)Nilai,NoBuktiInv from DBPBIAYA Group By NoBuktiInv)A1 On A1.NoBuktiInv=B.NOBUKTI and b.URUT=1

left outer join dbSubGroup J on J.KodeSubGrp=H.KODESUBGRP

left outer join DBPERKIRAAN K on k.Perkiraan=B.Perkiraan

where Isnull(H.ISAKTIF,0)=1;

-- VwreportBeliReject
CREATE VIEW IF NOT EXISTS VwreportBeliReject AS Select 	A.NoBukti,A.TANGGAL, B.NoPO, B.UrutPO,A.KODESUPP,I.KODECUSTSUPP,I.NAMACUSTSUPP,

	B.Urut, B.KodeBrg, H.NamaBrg, B.Qnt, B.NoSat, B.Isi, B.Satuan,

        0.00 Qnt2, '' SatuanRoll, B.Harga, B.HrgNetto,

        B.DiscP DiscP1, B.DiscTot DiscRp1,B.DiscTot,

        B.SubTotal TotalUSD, B.SubTotal TotalIDR, B.NDPP NDPP,

        B.NPPN NPPN, B.BYAngkut Beban, B.SubTotal + B.BYAngkut Total, B.KodeGdg

From dbBeliDet B 

Left Outer Join dbBeli A On A.NoBukti=b.NoBukti

Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg

Left Outer join DBCUSTSUPP I on A.KODESUPP = I.KODECUSTSUPP

where Isnull(H.ISAKTIF,0)=1;

-- VwreportBP
CREATE VIEW IF NOT EXISTS VwreportBP AS Select 	H1.NMDEP+' '+Case When A.KdDep='A.BR' Then Isnull(KK.NamaAlat,'') else ''  NMDEP,A.KdDep,A.NoBukti,A.NoBPPB,b.Harga,

	B.Urut, B.KodeBrg, H.NamaBrg, case when b.NoSat=1 then Qnt else Qnt2  Qnt ,B.Qnt2 , B.NoSat, B.Isi Isi, 

	case when b.NoSat=1 then h.SAT1 else h.SAT2  Satuan,B.HPP,B.Qnt * B.HPP NilaiHPP,B.Qnt2* B.HPP NilaiHPP2, A.Tanggal,Case when B.Nosat=1 Then B.HPP else B.HPP*/*b.NoSat*/isnull(ISI2,1)  Hrg, 

	case when b.NoSat=1 then Qnt else Qnt2 *Case when B.Nosat=1 Then B.HPP else B.HPP*/*b.NoSat*/isnull(ISI2,1)  NilaiBeli,

	Case when B.Nosat=1 Then B.Harga else B.Harga*/*b.NoSat*/isnull(ISI2,1)  HrgH, 

	isnull(case when b.NoSat=1 then Qnt else Qnt2 *Case when B.Nosat=1 Then B.Harga else B.Harga*/*b.NoSat*/isnull(ISI2,1) ,0) NilaiBeliH,

	B.Qnt2 *case when B.Nosat=1 Then B.Harga else B.Harga/B.Nosat  NilaiBeliSat2H,

	B.Qnt2 *case when B.Nosat=1 Then B1.Hrg else B1.Hrg/B.Nosat  NilaiBeliSat2,

	Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                      Case when A.IsOtorisasi2=1 then 1 else 0 +

                      Case when A.IsOtorisasi3=1 then 1 else 0 +

                      Case when A.IsOtorisasi4=1 then 1 else 0 +

                      Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                 else 1

             As INTEGER) NeedOtorisasi,LEFT(H.KODESUBGRP,6)KodeGroup,K.NamaSubGrp,Supir,NoPOL, a.NoJurnal,j.Keterangan,B.KetBrg

From dbPenyerahanBhn A

Left Outer join  dbPenyerahanBhnDet B on B.NoBukti=a.NoBukti

Left Outer Join (select b.noBukti,a.KodeBrg,AVG(Hrg)Hrg 

                 from VwHrgRata2 a

                 Left Outer Join DBPenyerahanBhnDET b On a.KodeBrg=b.kodebrg

                 Left Outer Join DBPenyerahanBhn c On c.Nobukti=b.Nobukti

                 where a.Tanggal<=c.tanggal or ( MONTH(a.Tanggal)=MONTH(c.Tanggal) and YEAR(a.Tanggal)=YEAR(c.Tanggal))

                 Group by b.noBukti,a.KodeBrg)B1 On B1.KODEBRG=B.kodebrg and B1.Nobukti=A.Nobukti 

Left Outer join dbBarang H on H.KodeBrg=b.KodeBrg

Left Outer Join(Select * from DBDEPART where Isnull(isSetPass,0)=0)H1 On H1.KDDEP=A.KdDep

left outer join DBPERKIRAAN J on J.Perkiraan=a.NoJurnal

left outer join dbSubGroup K on K.KodeSubGrp=H.KODESUBGRP

left Outer Join dbAlatBerat KK on KK.KodeAlat=a.NoPOL

where Isnull(H.ISAKTIF,0)=1 --and b.kodebrg='pslmj' 

--and YEAR(Tanggal)=2020 and MONTH(Tanggal)=7

--and Perkiraan='159';

-- VwReportBPPBKeluar
CREATE VIEW IF NOT EXISTS VwReportBPPBKeluar AS Select 	A.KodeGdgT,A.NoBukti, A.Tanggal, A.KdDep, C.NmDep,Qnt QMinta,Qnt2 QKirim,B.KodeBrg,D.NamaBrg,Nosat,Satuan

From dbBPPB A

Left Outer Join dbBPPBdet B On A.NoBukti=B.NoBukti

Left Outer Join dbBarang D On B.Kodebrg=D.Kodebrg

Left Outer Join dbDEPART C on c.KdDEP=a.KdDEP;

-- vwReportDaftarHarga
CREATE VIEW IF NOT EXISTS vwReportDaftarHarga AS Select X.KODEBRG,X.NAMABRG, MAX(X.Bln1) Bln1, MAX(X.Bln2) Bln2, MAX(X.Bln3) Bln3, MAX(X.Bln4) Bln4, MAX(X.Bln5) Bln5, MAX(X.Bln6) Bln6,

       MAX(X.Bln7) Bln7, MAX(X.Bln8) Bln8, MAX(X.Bln9) Bln9, MAX(X.Bln10) Bln10, MAX(X.Bln11) Bln11, MAX(X.Bln12) Bln12,

       X.Tahun, X.SAT_1

From (

	select b.KODEBRG, C.NAMABRG,YEAR(a.tanggal) Tahun,B.SAT_1,

			 Case when month(a.tanggal)= 1 then Case when SUM(b.qnt)<>0 then SUM(b.NDPPRp)/SUM(b.QNT) else 0 

					else 0

			  Bln1,

			 Case when month(a.tanggal)= 2 then Case when SUM(b.qnt)<>0 then SUM(b.NDPPRp)/SUM(b.QNT) else 0 

					else 0

			  Bln2,

			 Case when month(a.tanggal)= 3 then Case when SUM(b.qnt)<>0 then SUM(b.NDPPRp)/SUM(b.QNT) else 0 

					else 0

			  Bln3,

			 Case when month(a.tanggal)= 4 then Case when SUM(b.qnt)<>0 then SUM(b.NDPPRp)/SUM(b.QNT) else 0 

					else 0

			  Bln4,

			 Case when month(a.tanggal)= 5 then Case when SUM(b.qnt)<>0 then SUM(b.NDPPRp)/SUM(b.QNT) else 0 

					else 0

			  Bln5,

			 Case when month(a.tanggal)= 6 then Case when SUM(b.qnt)<>0 then SUM(b.NDPPRp)/SUM(b.QNT) else 0 

					else 0

			  Bln6,

			 Case when month(a.tanggal)= 7 then Case when SUM(b.qnt)<>0 then SUM(b.NDPPRp)/SUM(b.QNT) else 0 

					else 0

			  Bln7,

			 Case when month(a.tanggal)= 8 then Case when SUM(b.qnt)<>0 then SUM(b.NDPPRp)/SUM(b.QNT) else 0 

					else 0

			  Bln8,

			 Case when month(a.tanggal)= 9 then Case when SUM(b.qnt)<>0 then SUM(b.NDPPRp)/SUM(b.QNT) else 0 

					else 0

			  Bln9,

			 Case when month(a.tanggal)= 10 then Case when SUM(b.qnt)<>0 then SUM(b.NDPPRp)/SUM(b.QNT) else 0 

					else 0

			  Bln10,

			 Case when month(a.tanggal)= 11 then Case when SUM(b.qnt)<>0 then SUM(b.NDPPRp)/SUM(b.QNT) else 0 

					else 0

			  Bln11,

			 Case when month(a.tanggal)= 12 then Case when SUM(b.qnt)<>0 then SUM(b.NDPPRp)/SUM(b.QNT) else 0 

					else 0

			  Bln12       

	From DBPO a

		  left outer join DBPODET b on b.NOBUKTI=a.NOBUKTI

		  left outer join DBBARANG C on C.KODEBRG=b.KODEBRG    

	group by b.KODEBRG,C.NAMABRG,month(a.tanggal),YEAR(a.tanggal), B.SAT_1)X

	

	group by  X.KODEBRG,X.NAMABRG,x.Tahun,X.SAT_1;

-- VwreportDebetNotte
CREATE VIEW IF NOT EXISTS VwreportDebetNotte AS Select  a.NoBukti,x.tanggal,z.kodecustsupp,z.NAMACUSTSUPP, a.NoInv,a.KodeVLS,a.Kurs,

    Isnull(a.nilai,0) NDPP,Isnull(a.nilairp,0) NDPPRP,a.Keterangan,

      Cast(Case when Case when X.IsOtorisasi1=1 then 1 else 0 +

                      Case when X.IsOtorisasi2=1 then 1 else 0 +

                      Case when X.IsOtorisasi3=1 then 1 else 0 +

                      Case when X.IsOtorisasi4=1 then 1 else 0 +

                      Case when X.IsOtorisasi5=1 then 1 else 0 =X.MaxOL then 0

                 else 1

             As INTEGER) NeedOtorisasi

	From  dbDebetNoteDet a

	left Outer join DBDebetNote x on a.NOBUKTI = x.NOBUKTI

	Left Outer Join DBCUSTSUPP z on x.KodeSupp = z.KODECUSTSUPP;

-- vwReportFakturPenjualan
CREATE VIEW IF NOT EXISTS vwReportFakturPenjualan AS Select a.KodeCustSupp,NamaCustSupp,d.NAMACUSTSUPP+CHAR(13)+Isnull(d.ContactP,'')+Case When d.ContactP is Null or d.TelpContP is Null Then '' else '(' +Isnull(d.TelpContP,'')+Case When d.ContactP is Null or d.TelpContP is Null Then '' else')' Customer,a.NoBukti+CHAR(13)+'Batal: '+Case When a.IsClose=0 Then 'N' else 'B'  NoSJ,a.Tanggal,Case When ISNULL(a.CetakKe,0)=0 Then 'N' else CONVERT(Varchar(2),ISNULL(a.CetakKe,0)) CetakKe,

case when Isnull(b.isCetakKitir,0)=1 Then H.NamaBrg2 else Case When Isnull(H.IsJasa,0)=1 Then b.Namabrg else H.NAMABRG   NamaBrg,

b.QNT,b.SAT_1,b.QNT2,b.SAT_2,Isnull(c.HARGA,b1.Harga)harga,case when b.NOSAT=1 Then(B.QNT2/B.QNT) else (B.QNT/B.QNT2)  *Isnull(c.HARGA,b1.Harga) Hrg2,

b.QNT*Isnull(c.HARGA,b1.Harga) Total1,

b.QNT2*(case when b.NOSAT=1 Then(B.QNT2/B.QNT) else (B.QNT/B.QNT2)  *Isnull(c.HARGA,b1.Harga))Total2

from dbSPB a

Left Outer Join dbSPBDet b on a.NoBukti=b.NoBukti

Left Outer Join (select a.NoBukti,b.HARGA,a.KodeBrg from dbSPPDet a

                 Left Outer Join DBSODET b on a.NoSO=b.NOBUKTI and a.UrutSO=b.URUT

                 Group by a.NoBukti,b.HARGA,a.KodeBrg)b1 on b1.NoBukti=b.NoSPP and b.KodeBrg=b1.KodeBrg 

Left Outer Join (select Harga,NoSPB,UrutSPB from dbInvoicePLDet Group By Harga,NoSPB,UrutSPB)c on c.NoSPB=b.NoBukti and c.UrutSPB=b.Urut

Left Outer Join DBBARANG H On H.KODEBRG=b.KodeBrg

Left Outer Join (select * from DBCUSTSUPP where JENIS=1) d on a.KodeCustSupp=d.KODECUSTSUPP;

-- VwreportHasilPrd
CREATE VIEW IF NOT EXISTS VwreportHasilPrd AS Select A.nobukti,A.tanggal,A.keterangan,B.urut,B.Kodebrg,c.KODESUBGRP,D.NamaSubGrp,B.Qnt,B.Satuan,B.isi,B.Nospk,B.HPP,B.HPP*b.QNT*B.ISI as TotalHPP,C.NamaBrg,

       Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                      Case when A.IsOtorisasi2=1 then 1 else 0 +

                      Case when A.IsOtorisasi3=1 then 1 else 0 +

                      Case when A.IsOtorisasi4=1 then 1 else 0 +

                      Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                 else 1

             As INTEGER) NeedOtorisasi,f.NAMACUSTSUPP,g.NAMAPROJECT

From  dbHasilPrd A

Left Outer join DbHasilPRDDet B on a.nobukti = B.nobukti

Left Outer Join dbBarang C on C.KodeBrg=B.KodeBrg

Left outer join dbSubGroup D on d.KodeSubGrp=c.KODESUBGRP

left outer join DBSO E on e.NOBUKTI=b.NoSPK

left outer join DBCUSTSUPP f on f.KODECUSTSUPP=e.KODECUST

left outer join DBPROJECT G on g.KODEPROJECT=e.AlamatKirim

where Isnull(C.ISAKTIF,0)=1;

-- VwreportHasilPrdACC
CREATE VIEW IF NOT EXISTS VwreportHasilPrdACC AS Select A.nobukti,A.tanggal,A.keterangan,B.urut,B.Kodebrg,B.Qnt,B.Satuan,B.isi,B.Nospk,

       B.HPP*B.QNT*B.ISI as HPP,C.NamaBrg,

       Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                      Case when A.IsOtorisasi2=1 then 1 else 0 +

                      Case when A.IsOtorisasi3=1 then 1 else 0 +

                      Case when A.IsOtorisasi4=1 then 1 else 0 +

                      Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                 else 1

             As INTEGER) NeedOtorisasi 

From  dbHasilPrd A

Left Outer join DbHasilPRDDet B on a.nobukti = B.nobukti

Left Outer Join dbBarang C on C.KodeBrg=B.KodeBrg

where Isnull(C.ISAKTIF,0)=1;

-- VwreportInvoice
CREATE VIEW IF NOT EXISTS VwreportInvoice AS Select  a.NoBukti,c.kurs,c.kodevls,b.NoBukti NoBeli ,b.kodebrg,b.qnt,b.SATUAN,

		e.namabrg,b.harga,disctot,case when c.kodevls<>'IDR' then NDPPVLS else 0  as NDPPVLS,

		NDPP,NPPN,NNET,C.KodeSupp KodeCustSupp,D.NAMACUSTSUPP,C.TANGGAL,

		Cast(Case when Case when C.IsOtorisasi1=1 then 1 else 0 +

                      Case when C.IsOtorisasi2=1 then 1 else 0 +

                      Case when C.IsOtorisasi3=1 then 1 else 0 +

                      Case when C.IsOtorisasi4=1 then 1 else 0 +

                      Case when C.IsOtorisasi5=1 then 1 else 0 =C.MaxOL then 0

                 else 1

             As INTEGER) NeedOtorisasi

From  dbInvoiceDet a

Left Outer Join (select a.NoBukti,b.kodebrg,sum(b.qnt) qnt,b.satuan,b.harga,b.disctot, sum(ndpp) ndppvls,Sum(NDPPrp)NDPP,Sum(NPPNrp)NPPN,Sum(NNETrp)NNET 

from dbBeli a Left Outer Join dbBeliDet b On a.NoBukti=b.noBukti Group by a.NoBukti,b.KODEBRG,b.SATUAN,b.HARGA,b.DISCTOT)b On a.NoBeli=b.NoBukti

Left Outer join DBInvoice C on A.NOBUKTI = C.NOBUKTI 

Left Outer Join dbCustSupp D On C.KodeSupp=D.KodeCustSupp

left Outer Join DBBARANG E on E.KODEBRG=b.KODEBRG;

-- VwReportInvoicePembelian
CREATE VIEW IF NOT EXISTS VwReportInvoicePembelian AS Select  a.NoBukti,b.NoBukti NoBeli ,NDPP,NPPN,NNET

From  dbInvoiceDet a

Left Outer Join (select a.NoBukti,Sum(NDPP)NDPP,Sum(NPPN)NPPN,Sum(NNET)NNET from dbBeli a Left Outer Join dbBeliDet b On a.NoBukti=b.noBukti Group by a.NoBukti)b On a.NoBeli=b.NoBukti;

-- VwreportInvoicePenjualan
CREATE VIEW IF NOT EXISTS VwreportInvoicePenjualan AS select distinct	B.NoBukti, B.Urut, B.NoSPB, B.UrutSPB, B.KodeBrg, case when isnull(c.IsJasa,0)=1 then b.Namabrg else C.NAMABRG  NamaBrg,x.Tanggal tglSPB,B.NoSPP,z.NOBUKTI NoKP,

        a.KURS,a.Valas,z.kodesls,p.nama,

        case when b.NOSAT=1 then B.QNT else B.QNT2  as qnt,

        case when b.NOSAT=1 then B.SAT_1 else B.SAT_2  as satuan,

        B.HARGA, B.DiscP, B.DISCTOT, 

        case when Isnull(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(Convert(Float,SO.Retensi)/100.00))

        when ISNULL(A.PPh21,0)<>0 and (ISNULL(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (ISNULL(A.NTotal,0)*(ISNULL(A.FRetensi,0))/100))/1.1

        else B.NDPP  NDPP,

        case when Isnull(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(Convert(Float,SO.Retensi)/100.00))

        when ISNULL(A.PPh21,0)<>0 and (ISNULL(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (ISNULL(A.NTotal,0)*(ISNULL(A.FRetensi,0))/100))/1.1

        else B.NDPPRp  NDPPRp,case when Isnull(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(Convert(Float,SO.Retensi)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when ISNULL(A.PPh21,0)<>0 and (ISNULL(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (ISNULL(A.NTotal,0)*(ISNULL(A.FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp  NPPNRp, 

        case when Isnull(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(Convert(Float,SO.Retensi)/100.00)))+(((B.NDPP)-(B.NDPP*(Convert(Float,SO.Retensi)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(Convert(Float,SO.Retensi)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(Convert(Float,SO.Retensi)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(Convert(Float,SO.Retensi)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when ISNULL(A.PPh21,0)<>0 and (ISNULL(E.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (ISNULL(A.NTotal,0)*(ISNULL(A.FRetensi,0))/100))--((((Round(B.NNet,0))- (ISNULL(A.NTotal,0)*(ISNULL(FRetensi,0))/100))/1.1)*(ISNULL(A.PPh21,0)/100))

		else B.NNETRp  NNETRp, B.KetDetail,

        A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,   

        B.SAT_1,B.SAT_2,

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER) Needotorisasi,ISNULL(NoSO,'')Noso,B.PPN,x.NoResi,b.NoBukti NoInv

from	dbInvoicePLDet B

left outer join dbBarang C on C.KodeBrg=B.KodeBrg

left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

left outer join dbSPB X on B.NoSPB = X.NoBukti

left outer join dbSPP y on y.NoBukti=x.NoSPP

Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO                 

left outer join DBSO z on z.NOBUKTI=y.NoSHIP

left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti

left outer join dbKaryawan p on p.KeyNIK=z.KODESLS

Left Outer Join dbo.vwBrowsCust E on E.KODECUSTSUPP=A.KodeCustSupp

where Isnull(X.IsClose,0)=0  and ISNULL(a.IsBatal,0)=0

--and b.NoBukti='CA/INVC/0223/00002'

union all



select distinct	A0.NoBukti, 1 Urut, '' NoSPB, 1 UrutSPB, '' KodeBrg, A0.Keterangan NamaBrg,A0.Tanggal tglSPB,'' NoSPP,'' NoKP,

        1 KURS,'IDR' Valas,'' kodesls,'' nama,

        1 qnt,

        '' satuan,

        A0.SubTotal HARGA, 0 DiscP, 0 DISCTOT, 

        a0.TDPP NDPP,

        a0.TDPP NDPPRp,

        a0.TNPPN NPPNRp, 

        a0.TDPP+a0.TNPPN NNETRp, A0.Keterangan KetDetail,

        A0.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,   

        '' SAT_1,'' SAT_2,

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER) Needotorisasi,ISNULL(NoSO,'')Noso,B.PPN,x.NoResi,b.NoBukti NoInv

from dbo.dbInvoicePLRetensi A0    	

left outer join dbInvoicePLDet B on b.NoBukti=A0.NoInvoice

left outer join dbBarang C on C.KodeBrg=B.KodeBrg

left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

left outer join dbSPB X on B.NoSPB = X.NoBukti

left outer join dbSPP y on y.NoBukti=x.NoSPP

Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO                 

left outer join DBSO z on z.NOBUKTI=y.NoSHIP

left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti

left outer join dbKaryawan p on p.KeyNIK=z.KODESLS

Left Outer Join dbo.vwBrowsCust E on E.KODECUSTSUPP=A.KodeCustSupp

where Isnull(X.IsClose,0)=0  and ISNULL(a.IsBatal,0)=0 

--and a0.NoBukti='CA/INVC/0223/00002';

-- VwReportInVoiceRPembelian
CREATE VIEW IF NOT EXISTS VwReportInVoiceRPembelian AS Select 	B.NoBukti, B.UrutPBL,

	B.Urut, B.KodeBrg, H.NamaBrg, B.Qnt, B.NoSat, B.Isi, B.Satuan,

        0.00 Qnt2, '' SatuanRoll, B.Harga,

        B.DiscP DiscP1, B.DiscTot DiscRp1, B.DiscTot,

        B.SubTotal TotalUSD, B.SubTotal TotalIDR, B.NDPP NDPP,

        B.NPPN NPPN, B.BYAngkut Beban, B.SubTotal + B.BYAngkut Total

From dbRBeliDet B

Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg;

-- VwReportJual
CREATE VIEW IF NOT EXISTS VwReportJual AS Select 	A.NoBukti+right('00000000'+cast(A.Urut as varchar(8)),8) KeyNoBukti,

        A.*, C.NamaCustSupp, T.Nama NamaTipe, ST.Nama NamaSubTipe,

        cast(left(A.NoBukti,2) as varchar(50)) Left2NoBukti

From dbPenjualan A

Left Outer Join DBCUSTSUPP C on C.KODECUSTSUPP=A.KodeCustSupp

Left Outer Join DBTIPETRANS T on T.KODETIPE=A.KodeTipe

Left Outer Join DBSUBTIPETRANS ST on ST.KODETIPE=A.KodeTipe and ST.KODESUBTIPE=A.KodeSubTipe;

-- vwReportKartuBrg
CREATE VIEW IF NOT EXISTS vwReportKartuBrg AS Select  a.BULAN, a.TAHUN, a.KODEBRG, a.KODEGDG, Case when Tipe='AWL' Then a.QntDB else 0  QntAwal, Case when Tipe='AWL' Then a.HrgSaldo else 0  HRGAWAL, 

	Case when Tipe='PBL' Then QntDB else 0  QNTPBL, Case when Tipe='PBL' Then Qnt2DB else 0  QNT2PBL, 

	Case when Tipe='PBL' Then HrgDebet else 0  HRGPBL, Case when Tipe='RPB' Then QntDB else 0  QNTRPB, Case when Tipe='RPB' Then Qnt2DB else 0  QNT2RPB, 

	Case when Tipe='RPB' Then HrgDebet else 0  HRGRPB, 

	Case when Tipe='PNJ' and  NoBukti Not Like '%SJB%' and NoBukti not like '%SPBB%' and b.NAMABRG not like '%Jasa%'  Then QntCr else 0  QNTPNJ, 

	Case when Tipe='PNJ' and  NoBukti Not Like '%SJB%' and NoBukti not like '%SPBB%' and b.NAMABRG not like '%Jasa%'  Then Qnt2Cr else 0  QNT2PNJ, 

	Case when Tipe='PNJ' and  NoBukti Not Like '%SJB%' and NoBukti not like '%SPBB%' and b.NAMABRG not like '%Jasa%'  Then HrgKredit else 0  HRGPNJ, 

	Case when Tipe='RPJ' and  KodeCustSupp Not Like '%SJB%' and KodeCustSupp not like '%SPBB%' and b.NAMABRG not like '%Jasa%'  Then  QntDB else 0  QNTRPJ, 

	Case when Tipe='RPJ' and  KodeCustSupp Not Like '%SJB%' and KodeCustSupp not like '%SPBB%' and b.NAMABRG not like '%Jasa%'  Then Qnt2DB else 0  QNT2RPJ, 

	Case when Tipe='RPJ' and  KodeCustSupp Not Like '%SJB%' and KodeCustSupp not like '%SPBB%' and b.NAMABRG not like '%Jasa%'  Then a.HrgDebet else 0  HRGRPJ, 

	Case when Tipe='PNJ' and  b.NAMABRG  like '%Jasa%'  Then QntCr else 0  QNTPNJJ, 

	Case when Tipe='PNJ' and  b.NAMABRG  like '%Jasa%'  Then Qnt2Cr else 0  QNT2PNJJ, 

	Case when Tipe='PNJ' and  b.NAMABRG  like '%Jasa%'  Then HrgKredit else 0  HRGPNJJ, 

	Case when Tipe='RPJ' and    b.NAMABRG  like '%Jasa%'  Then  QntDB else 0  QNTRPJJ, 

	Case when Tipe='RPJ' and    b.NAMABRG  like '%Jasa%'  Then Qnt2DB else 0  QNT2RPJJ, 

	Case when Tipe='RPJ' and    b.NAMABRG  like '%Jasa%'  Then a.HrgDebet else 0  HRGRPJJ, 

	Case when Tipe='ADI' Then QntDB else 0  QNTADI, 

	Case when Tipe='ADI' Then Qnt2DB else 0  QNT2ADI, 

	Case when Tipe='ADI' Then HrgDebet else 0  HRGADI, 

	Case when Tipe='ADO' Then QntCr else 0  QNTADO, 

	Case when Tipe='ADO' Then Qnt2Cr else 0  QNT2ADO, 

	Case when Tipe='ADO' Then HrgKredit else 0  HRGADO, 

	Case when Tipe='UKI' Then QntDB else 0  QNTUKI,Case when Tipe='UKI' Then Qnt2DB else 0  QNT2UKI, Case when Tipe='UKI' Then HrgDebet else 0  HRGUKI

	, Case when Tipe='UKO' Then QntCr else 0  QNTUKO, Case when Tipe='UKO' Then Qnt2Cr else 0  QNT2UKO

	, Case when Tipe='UKO' Then HrgKredit else 0  HRGUKO, 

	Case when Tipe='TRI' Then QntDB else 0  QNTTRI, Case when Tipe='TRI' Then Qnt2DB else 0  QNT2TRI, Case when Tipe='TRI' Then HrgDebet else 0  HRGTRI,

	 Case when Tipe='TRO' Then QntCr else 0  QNTTRO, Case when Tipe='TRO' Then Qnt2Cr else 0  QNT2TRO, Case when Tipe='TRO' Then HrgKredit else 0  HRGTRO,

	Case when Tipe='PMK' Then QntCr else 0  QNTPMK, Case when Tipe='PMK' Then Qnt2Cr else 0  QNT2PMK, Case when Tipe='PMK' Then HrgKredit else 0  HRGPMK,

	 Case when Tipe='RPK' Then QntDB else 0  QNTRPK, Case when Tipe='RPK' Then Qnt2DB else 0  QNT2RPK, Case when Tipe='RPK' Then HrgDebet else 0  HRGRPK,

	Case when Tipe='HP' Then QntDB else 0  QntHPrd, Case when Tipe='HP' Then Qnt2DB else 0  Qnt2HPrd, Case when Tipe='HP' Then HrgDebet else 0  HRGHPrd, 

	Case when Tipe='PNJ' Then QntCr else 0  HRGRATA, 

	QntDB  QNTIN, Qnt2DB QNT2IN, HrgSaldo RPIN

	,  QntCr  QNTOUT,  Qnt2Cr  QNT2OUT, HrgKredit RPOUT, 

	a.QntSaldo SALDOQNT, a.Qnt2Saldo SALDO2QNT,  HrgSaldo  SALDORP, 0 SaldoAV, 0 Saldo2AV, 

	B.QntMin,B.QntMax,

    b.NAMABRG, c.NAMA Namagdg, b.SAT1, b.Sat2,B.ISI1,B.ISI2,B.ISI3,

    b.KODEGRP,e.NAMA NamaGrp,b.KODESUBGRP,f.NamaSubGrp

from vwKartuStock a

     --Left outer join (select HrgSaldo,Kodebrg,Bulan,Tahun,Kodegdg from vwKartuStock where Tipe='AWL' and Bulan=1 and Tahun=2015)d on d.Kodebrg=a.KODEBRG and d.Kodegdg=a.KODEGDG and d.Bulan=a.BULAN and d.Tahun=a.TAHUN

     left outer join DBBARANG b on b.KODEBRG=a.KODEBRG --and b.Kodegdg=a.KODEGDG

     left outer join DBGUDANG c on c.KODEGDG=a.KODEGDG

     left outer join DBGROUP e on e.KODEGRP=b.KODEGRP

     left outer join dbSubGroup f on f.KodeSubGrp=b.KODESUBGRP and f.KodeGrp=b.KODEGRP and f.KodeGrp=e.KodeGrp;

-- vwReportKPVSSJ
CREATE VIEW IF NOT EXISTS vwReportKPVSSJ AS select b.NoBukti,c.KodeProject,c.Lokasi,c.NAMAPROJECT,

c.KODESLS,c.Marketing,b.Tanggal,b.KodeCustSupp,d.NAMACUSTSUPP,

a.KodeBrg,e.NAMABRG,

Case When a.ISI=1 Then a.QNT-ISNULL(y.QntR,0) else a.QNT2-ISNULL(y.Qnt2R,0)  QntKirim,

Case When a.ISI=1 Then c.QntSO else c.Qnt2SO  QntSO,

Case When a.ISI=1 Then a.SAT_1 else a.SAT_2  Satuan

from DBSPBDet a

Left Outer Join dbSPB b on a.NoBukti=b.NoBukti

left Outer join (Select x.NoSPB, x.UrutSPB, Sum(x.QNT) QntR, Sum(x.QNT2) Qnt2R

                                            From DBRSPBDet x

                                            Group by x.NoSPB, x.UrutSPB) y on y.NoSPB=a.NoBukti and y.UrutSPB=a.Urut 

Left Outer Join(Select a.NoBukti,a.NoSO,a.UrutSO,a.Urut,b.* from dbSPPDet a

                Left Outer Join (select a.NOBUKTI BuktiSO,a.KODESLS,c.Nama Marketing,b1.URUT UrutnyaSO,a.AlamatKirim,b2.QNT QntSO, b2.QNT2  Qnt2SO,SATUAN SatSO,b1.KODEBRG KodeBrgSO,b.NAMAPROJECT,a.AlamatKirim KodeProject,b.ALAMATPROJECT,Case When Isnull(b.ALAMATPROJECT,'')='' Then b.NAMAPROJECT else Isnull(b.ALAMATPROJECT,'') Lokasi

                                 from DBSO a

                                 Left Outer Join DBSODET b1 on b1.NOBUKTI=a.NOBUKTI 

                                 Left Outer Join (Select NoBukti,KODEBRG,SUM(Qnt)Qnt,SUM(QNT2)Qnt2 from DBSODET Group by NOBUKTI,Kodebrg)b2 on b2.NOBUKTI=a.NOBUKTI and b2.KODEBRG=b1.KODEBRG

                                 Left Outer Join DBPROJECT b on a.AlamatKirim=b.KODEPROJECT 

                                 Left Outer Join dbKaryawan c on c.KeyNIK=a.KODESLS

                                 )b on a.NoSO=b.BuktiSO and a.UrutSO=b.UrutnyaSO

               )c on c.NoBukti=a.NoSPP and c.Urut=a.UrutSPP 

Left Outer Join DBCUSTSUPP d on  d.KODECUSTSUPP=b.KodeCustSupp

Left Outer Join DBBARANG e on e.KODEBRG=a.KodeBrg   

where Isnull(c.KodeProject,'')<>''     

and Isnull(Case When a.ISI=1 Then c.QntSO else c.Qnt2SO ,0)<>0;

-- VwReportKPvsSJVsSaku
CREATE VIEW IF NOT EXISTS VwReportKPvsSJVsSaku AS select a.NoBukti NOSO, a.KODECUST,a.TANGGAL,cust.NAMACUSTSUPP,Prj.NAMAPROJECT,a.NOBUKTI NoKontrak,

SOD.KODEBRG,Brg.NAMABRG,SOD.QntSO,SJ.NoBukti NoSJ,SJ.Qnt QntSJ,SJ.Qnt * SOD.HPP JumlahSJ,SAKU.NOBUKTI NoSAKU,SAKU.Total  

from DBSO a 

Left Outer Join (Select NoBukti,KodeBrg,SUM(Qnt) QntSO,HPP+BYANGKUT HPP from DBSODET 

                 Group By NoBukti,KodeBrg,HPP+BYANGKUT)SOD on SOD.NOBUKTI=a.NOBUKTI 

Left Outer Join (Select NOSO,a.NoBukti,a.KodeBrg,SUM(a.QNT)Qnt from dbSPBDet a

                 Left Outer Join dbSPPDet b on a.NoSPP=b.NoBukti and b.KodeBrg=a.KodeBrg and a.UrutSPP=b.Urut

                 Group by NoSO,a.NoBukti,a.KodeBrg)SJ on SJ.NoSO=a.NOBUKTI and SJ.KodeBrg=SOD.KODEBRG    

Left Outer Join (select a.NoBukti,a.Ket1 KodePrj,a.Ket2 KodeCust,SUM(Total)Total from DBRUTETRANS a 

                 Left Outer Join DBRUTETRANSDET b on a.NOBUKTI=b.NOBUKTI

                 Group by a.NoBukti,a.Ket1 ,a.Ket2  )SAKU on SAKU.KodePrj=a.AlamatKirim  and SAKU.KodeCust=a.KODECUST               

Left Outer Join DBCUSTSUPP cust on cust.KODECUSTSUPP=a.KODECUST 

Left Outer Join DBPROJECT Prj on Prj.KODEPROJECT=a.AlamatKirim

Left Outer Join DBBARANG Brg on Brg.Kodebrg=SOD.KODEBRG;

-- VwreportOpnameBahan
CREATE VIEW IF NOT EXISTS VwreportOpnameBahan AS Select * from vwdetailKoreksi;

-- VwreportOPnamebarang
CREATE VIEW IF NOT EXISTS VwreportOPnamebarang AS Select * from vwdetailKoreksi Where noBukti Like '%OPBJ%'--'OPN%';

-- vwreportoutSO
CREATE VIEW IF NOT EXISTS vwreportoutSO AS Select  A.NoBukti+right('00000'+cast(A.Urut as varchar(5)),5) KeyNoBukti, A.Nobukti, 

P.Tanggal, P.Kodecust KodeCustSupp, S.NamaCust NamaCustSupp,

A.urut, A.kodebrg, B.NamaBrg, A.Satuan, A.Isi,

A.Qnt, A.Qnt2, A.QntSPP, A.Qnt2SPP,

A.QntSisa, A.Qnt2Sisa,P.MasaBerlaku,P.NoPesanan,P.TglKirim,P.TGLJATUHTEMPO

From    vwBrowsOutSO_SPP A

Left Outer Join DBSO P on P.NoBukti=A.NoBukti

Left Outer Join vwBrowsCustomer S on S.KodeCust=P.KodeCust --and S.Sales=P.KODESLS

Left Outer Join dbBarang B on B.KodeBrg=A.KodeBrg

where A.islengkap=0;

-- VwreportOutSPB
CREATE VIEW IF NOT EXISTS VwreportOutSPB AS /*

Select A.*,B.NAMABRG NamaBarang,C.Tanggal,C.kodeCustSupp,D.NAMACUSTSUPP,

           A.Nobukti+Cast(A.Urut as varchar(5)) MyKey,Z.NOBUKTI Noso,Z.TANGGAL TanggalSO

from dbSPBDet A

     left outer join DBBARANG B on B.KODEBRG=A.Kodebrg

     Left Outer join dbSPB C on A.NoBukti = C.NoBukti

     Left Outer join DBCUSTSUPP D on c.KodeCustSupp = D.KODECUSTSUPP

     Left Outer join (Select x.NoBukti, x.NoSPP

                      from dbSPBDet x

                      group by x.NoBukti, x.NoSPP) y on y.NoBukti=C.NoBukti

     Left Outer Join (Select x.NoBukti, x.Tanggal,y.NoSO, x.TglKirim

                      from DBSPP x 

                        left outer join dbSPPDet y on y.NoBukti=x.NoBukti

                      Group by x.NoBukti, x.Tanggal,y.NoSO, x.TglKirim) v On v.NoBukti=y.NoSPP 

    left outer join DBSO Z on Z.NOBUKTI=v.NoSO

     

select * from dbSPBDet

select * from dbInvoicePLDet

*/

Select  A.NoBukti+right('00000'+cast(A.Urut as varchar(5)),5) KeyNoBukti, A.Nobukti, F.Tanggal, F.KodeCustSupp, S.Namacust NamaCustSupp,

        A.urut, A.kodebrg, B.NamaBrg, '' Jns_Kertas, '' Ukr_Kertas, A.Sat_1, A.Isi,A.Qnt qnt,a.qntinv qntinv,a.QntRetur, A.QntSisa qntsisa,

        A.SAT_1 Satuan, e.Tglkirim,e.NOBUKTI noso,e.tanggal tglso,e.NOSPB nopo,g.HARGA,Isnull(g1.HPPBrg,0) HPP, A.QntSisa *g.HARGA dppnet, A.QntSisa *Isnull(g1.HPPBrg,0) hppnet,A.Nosat,A.SAT_2,

        c.NoSPP,c.UrutSPP

From    vwBrowsOutSPB_RSPB A

left outer join dbSPB F on f.NoBukti=a.NoBukti

left outer join dbSPBDet c on c.NoBukti=a.NoBukti and c.KodeBrg=a.KodeBrg

left outer join dbSPPDet D on D.NoBukti=c.NoSPP and d.Urut=c.UrutSPP 

left Outer join DBSO E on E.NOBUKTI=d.NoSO

left outer join DBSODET G on G.NOBUKTI=e.NOBUKTI and g.KODEBRG=c.KodeBrg

Left outer join dbHPPProduksi G1 On G1.KodeBrg=A.KodeBrg and MONTH(F.Tanggal)=G1.Bulan and YEAR(F.Tanggal)=G1.Tahun

Left Outer Join vwBrowsCustomer S on S.KodeCust=F.KodeCustSupp --and s.Sales=E.KODESLS

Left Outer Join dbBarang B on B.KodeBrg=A.KodeBrg

Left Outer Join VWSatkecil B1 on B1.Kodebrg=A.KodeBrg

where Isnull(F.IsClose,0)=0    

   -- select * from vwBrowsOutSPB_RSPB

--select * from dbsppdet

--select * from dbSPBdet

--select * from dbsodet;

-- VwreportOUtSPK
CREATE VIEW IF NOT EXISTS VwreportOUtSPK AS select a.NOBUKTI ,E.TANGGAL, a.Kodebrg, d.NAMABRG, a.Qnt QntBPPB,

sum(case when a.NOSAT=1 then isnull(b.Qnt,0) else b.Qnt2 ) QntBP,

a.QNT-sum(case when a.NOSAT=1 then isnull(b.Qnt,0) else b.Qnt2 ) Sisa

from DBSPKDET a

left outer join DBPenyerahanBhnDET b on b.NoSPK=a.NOBUKTI and b.UrutSPK=a.URUT 

--left Outer Join (select Kodebrg,SUM(Qnt*isi)Qnt from DBPenyerahanBhnDET group by kodebrg)b On b.kodebrg=a.KodeBrg 

--left Outer Join (select Kodebrg,SUM(SALDOQNT)Qnt from DBSTOCKBRG group by kodebrg )c On c.kodebrg=a.KodeBrg

Left Outer Join DBBARANG d On a.KODEBRG=d.kodebrg 

Left outer Join DBSPK E on A.NOBUKTI = E.NOBUKTI

group by a.NOBUKTI, a.Urut, a.KodeBrg, a.Qnt, a.Isi, d.NAMABRG, E.TANGGAL

having a.QNT-sum(case when a.NOSAT=1 then isnull(b.Qnt,0) else b.Qnt2 )>0;

-- VwReportOutSPP
CREATE VIEW IF NOT EXISTS VwReportOutSPP AS Select  A.NoBukti+right('00000'+cast(A.Urut as varchar(5)),5) KeyNoBukti, A.Nobukti, P.Tanggal, P.KodeCustSupp, S.Namacust NamaCustSupp,

        A.urut, A.kodebrg, B.NamaBrg, '' Jns_Kertas, '' Ukr_Kertas, A.Sat_1, A.Sat_2, A.Isi,

        Case when A.NoSat=1 then A.Qnt

             when A.NoSat=2 then A.Qnt2

             else 0

         Qnt, A.Qnt2,

        Case when A.NoSat=1 then A.QntSPB

             when A.NoSat=2 then A.Qnt2SPB

             else 0

         QntSPB, A.Qnt2SPB,

        Case when A.NoSat=1 then A.QntSisa

             when A.NoSat=2 then A.Qnt2Sisa

             else 0

         QntSisa, A.Qnt2Sisa,

        Case when A.NOSAT=1 then A.SAT_1

             when A.NOSAT=2 then A.SAT_2

             else ''

         Satuan, P.Tglkirim,

        P.NoPesan

From    vwBrowsOutSPP A

Left Outer Join dbSPP P on P.NoBukti=A.NoBukti

left Outer join DBSO SO on SO.NOBUKTI=A.noso

Left Outer Join vwBrowsCustomer S on S.KodeCust=P.KodeCustSupp --and s.Sales=SO.KODESLS

Left Outer Join dbBarang B on B.KodeBrg=A.KodeBrg

where A.isclose=0;

-- VwReportOutStandingBPPB
CREATE VIEW IF NOT EXISTS VwReportOutStandingBPPB AS Select  a.NoBukti,Tanggal,b.KodeBrg,c.NamaBrg,Qnt,Qnt2,A.KodeGdg,A.KodeGdgT

From dbBPPB a Left Outer Join dbBPPBDet b On a.NoBukti=b.NoBukti

left Outer Join dbBarang c On c.KodeBrg=b.KodeBrg

where Qnt<>Qnt2;

-- VwReportOutStandingPO
CREATE VIEW IF NOT EXISTS VwReportOutStandingPO AS Select 	A.*, Case when H.IsJasa=1 Then A.NamaBrg else H.NamaBrg  NamaBrg2,I.TANGGAL,I.KODESUPP KOdeCustSupp,J.NAMACUSTSUPP,K.Tanggal TanggalKirim,

DATEDIFF(DAY,I.TANGGAL,K.Tanggal) TglSlshKrm

From vwOutstandingPO A

Left Outer Join dbBarang H on H.KodeBrg=A.KodeBrg

Left Outer Join DBPO I on A.NoBukti = I.NOBUKTI

left Outer Join DBCUSTSUPP J on I.KODESUPP = J.KODECUSTSUPP

Left Outer Join DBKirimDET K on K.NoBukti = A.NoBukti -- and A.Urut = K.Urut;

-- VwReportOutStandingPR
CREATE VIEW IF NOT EXISTS VwReportOutStandingPR AS select A1.Nobukti,A1.Tanggal,a.kodebrg,C.KODESUPP KOdeCustSupp,D.NAMACUSTSUPP, a.Sat,c.NAMABRG,SUM(a.Qnt*isi)QntPPL,Isnull(b.Qnt,0) QntPO,SUM(a.Qnt*isi)-Isnull(b.Qnt,0)sisa from DBPPLDET a

Left Outer Join (select NoPPL,Kodebrg,SUM(Qnt*isi)Qnt from DBPODET  group by NoPPL,Kodebrg)b On a.Nobukti=b.NoPPL and a.kodebrg=b.KODEBRG

left Outer Join DBBARANG c On c.KODEBRG=a.kodebrg

Left Outer Join dbPPL A1 On A1.NoBukti=A.NoBukti 

Left Outer Join DBCUSTSUPP D on C.KODESUPP=D.KODECUSTSUPP

where Case when Isnull(A1.IsClose,0)=0 Then Isnull(A.IsClose,0)else Isnull(A1.IsClose,0) =0

group by a.kodebrg,a.Sat,b.Qnt,c.NAMABRG,A1.Nobukti,A1.Tanggal,C.KODESUPP,D.NAMACUSTSUPP

having SUM(a.Qnt*isi)-Isnull(b.Qnt,0)<>0;

-- VwReportOutStandingSO
CREATE VIEW IF NOT EXISTS VwReportOutStandingSO AS select  A.NoBukti, A.Urut, A.NoBukti+right('000000'+cast(A.Urut as varchar(6)),6) KeyUrut,

        A.KODEBRG, A.NamaBrg, A.QNT, A.QNT2, A.NOSAT, A.Satuan, A.ISI, A.QntSJ, A.Qnt2SJ, A.SatuanRoll,

        A.QNT-A.QntSJ QntSisa, A.QNT2-A.QNT2SJ Qnt2Sisa,

        C.KODECUSTSUPP,C.NAMACUSTSUPP,A.Tanggal,A.NamaSls

--select * 

from    vwSOBelumSuratJlnDet A 

Left Outer Join  DBSO B on A.NoBukti = B.NOBUKTI

Left Outer Join DBCUSTSUPP C on B.KODECUST = C.KODECUSTSUPP;

-- VwReportOutstandingSO2
CREATE VIEW IF NOT EXISTS VwReportOutstandingSO2 AS Select  A.NoBukti+right('00000'+cast(A.Urut as varchar(5)),5) KeyNoBukti, A.Nobukti, P.Tanggal, P.Kodecust KodeCustSupp, S.NamaCust NamaCustSupp,

        A.urut, A.kodebrg, B.NamaBrg, A.Satuan, A.Isi,

        A.Qnt, A.Qnt2, A.QntSPP, A.Qnt2SPP,

        A.QntSisa, A.Qnt2Sisa

From    vwBrowsOutSO_SPP A

Left Outer Join DBSO P on P.NoBukti=A.NoBukti

Left Outer Join vwBrowsCustomer S on S.KodeCust=P.KodeCust and S.Sales=P.KODESLS

Left Outer Join dbBarang B on B.KodeBrg=A.KodeBrg;

-- VwReportPembelian
CREATE VIEW IF NOT EXISTS VwReportPembelian AS Select 	A.NoBukti+right('00000000'+cast(A.Urut as varchar(8)),8) KeyNoBukti,

        A.*, C.NamaCustSupp, T.Nama NamaTipe, ST.Nama NamaSubTipe,

        cast(left(A.NoBukti,2) as varchar(50)) Left2NoBukti

From dbPembelian A

Left Outer Join DBCUSTSUPP C on C.KODECUSTSUPP=A.KodeCustSupp

Left Outer Join DBTIPETRANS T on T.KODETIPE=A.KodeTipe

Left Outer Join DBSUBTIPETRANS ST on ST.KODETIPE=A.KodeTipe and ST.KODESUBTIPE=A.KodeSubTipe;

-- VwReportPenerimaanACC
CREATE VIEW IF NOT EXISTS VwReportPenerimaanACC AS Select 	B.NoBukti,B.NoPO,I.TANGGAL,I.KODESUPP KodeCustSupp,J.NAMACUSTSUPP,

	B.Urut, B.KodeBrg, H.NamaBrg, B.QntTerima qnt, B.NoSat, B.Isi, B.Satuan,

	    k.QNT qntpo,b.QNT qntgdg, b.QntReject reject,b.Qnt2Reject reject2,

        Qnt2Terima Qnt2, '' SatuanRoll, B.Harga,

        (B.NDISKON+B.DISCTOT)*i.kurs Disctotal,

        (B.NDPP+B.NPPN)*i.kurs TotalIDR, B.NDPP*i.kurs NDPP,

        B.NPPN*i.kurs NPPN, B.BYAngkut Beban, B.SubTotal + B.BYAngkut Total,

        case when i.kurs=1 then 0 else b.disctot  as disctotusd,

        case when i.kurs=1 then 0 else b.ndpp  as Ndppusd,

        case when i.kurs=1 then 0 else b.nppn  as NPPNusd,

        case when i.kurs=1 then 0 else b.subtotal  as totalusd,

        I.kurs,I.KODEVLS--,b.Qnt2 qntgdg2,

From  DBBELIDET B 

Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg

Left Outer join DBBELI I on B.NOBUKTI = I.NOBUKTI

Left Outer Join DBCUSTSUPP J on I.KODESUPP = J.KODECUSTSUPP

Left outer join DBPODET K on K.NOBUKTI=B.NOBUKTI and k.KODEBRG=b.KODEBRG;

-- VwreportPermintaanBahan
CREATE VIEW IF NOT EXISTS VwreportPermintaanBahan AS Select 	A.NoBukti, A.TANGGAL,A.KodeGdg,A.KodeGdgT,a.kddep,c.NMDEP,

	B.Urut, B.KodeBrg, H.NamaBrg, B.Qnt,B.Qnt2M, B.Satuan Satuan,

	B.Qnt2,B.Qnt2P,

	Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                      Case when A.IsOtorisasi2=1 then 1 else 0 +

                      Case when A.IsOtorisasi3=1 then 1 else 0 +

                      Case when A.IsOtorisasi4=1 then 1 else 0 +

                      Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                 else 1

             As INTEGER) NeedOtorisasi 

From dbBPPB A

Left Outer join dbBPPBDet B on B.NoBukti=a.NoBukti

Left Outer join dbBarang H on H.KodeBrg=b.KodeBrg

left outer join DBDEPART c on c.KDDEP=a.KDDEP;

-- VwreportPLinvoice
CREATE VIEW IF NOT EXISTS VwreportPLinvoice AS select 	B.NoBukti, B.Urut, B.NoSPB, B.UrutSPB, B.KodeBrg, C.NAMABRG,x.Tanggal tglSPB,B.NoSPP,

        B.PPN, B.DISC, B.KURS, B.QNT, B.QNT2, B.SAT_1, B.SAT_2, B.NOSAT, B.ISI, B.NetW, B.GrossW,

        B.HARGA, B.DiscP, B.DiscRp, B.DISCTOT, B.HRGNETTO, B.NDISKON, B.SUBTOTAL, B.NDPP, B.NPPN, B.NNET,

        B.SUBTOTALRp, B.NDPPRp, B.NPPNRp, B.NNETRp, B.KetDetail,

        A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP

from	dbInvoicePLDet B

left outer join dbBarang C on C.KodeBrg=B.KodeBrg

left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

left outer join dbSPB X on B.NoSPB = X.NoBukti;

-- VwReportPNW
CREATE VIEW IF NOT EXISTS VwReportPNW AS Select 	A.NoBukti, A.NoSPB, B.UrutSPB,A.TANGGAL,A.KODECUST KODECUSTSUPP,Case When A.KODECUST='-' Then A.INSBrg else I.NAMACUSTSUPP  NAMACUSTSUPP,

	A.NoBukti+right('0000000000'+cast(B.Urut as varchar(10)),10) NoBuktiUrut,

        B.Urut, B.KodeBrg, Case When H.NamaBrg='' Then B.NamaBrg else Isnull(H.NAMABRG,'')  NamaBrg,

        case when b.NOSAT=1 then B.Qnt else b.QNT2  as qntjual,b.QNT, B.NoSat, B.Isi, H.Sat1 Satuan,

        B.Qnt2, H.Sat2 Satuan2, B.Harga,

        B.DiscP1,B.DiscTot,B.NDPP,a.KURS,a.KODEVLS,B.NDPPRp,B.NPPNRp,B.NNETRp,

        Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                      Case when A.IsOtorisasi2=1 then 1 else 0 +

                      Case when A.IsOtorisasi3=1 then 1 else 0 +

                      Case when A.IsOtorisasi4=1 then 1 else 0 +

                      Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                 else 1

             As INTEGER) NeedOtorisasi,H.KodeSubGrp,H.NamaSubGrp,B.HPP,H.HPPBrg,KODESLS,KY.Nama Marketing,Pr.NAMAPROJECT,Pr.ALAMATPROJECT

From DBPNW A

Left Outer join DBPNWDET B on B.NoBukti=a.NoBukti

Left Outer Join vwSatuanBrg H on H.KodeBrg=B.KodeBrg --and H.NoSat=B.NoSat

Left Outer Join dbKaryawan Ky on Ky.NIK=KODESLS

Left Outer Join DBPROJECT Pr on Pr.KODEPROJECT=A.AlamatKirim

Left Outer join DBCUSTSUPP I on a.KODECUST = I.KODECUSTSUPP;

-- VwreportPO
CREATE VIEW IF NOT EXISTS VwreportPO AS Select 	B.NoBukti,I.TANGGAL,I.KODESUPP KodeCustSupp,J.NAMACUSTSUPP, '' NoSPP, 0 UrutSPP,

	B.Urut, B.KodeBrg, case when H.IsJasa=1 Then b.NamaBrg else H.NamaBrg  NamaBrg, B.Qnt, B.NoSat, B.Isi, B.Satuan,

        0.00 Qnt2, '' SatuanRoll, B.Harga,

        (B.NDISKON+B.DISCTOT)*i.kurs Disctotal,

        (B.NDPP+B.NPPN)*i.kurs TotalIDR, B.NDPP*i.kurs NDPP,

        B.NPPN*i.kurs NPPN, B.BYAngkut Beban, B.SubTotal + B.BYAngkut Total,

        case when i.kurs=1 then 0 else b.disctot  as disctotusd,

        case when i.kurs=1 then 0 else b.ndpp  as Ndppusd,

        case when i.kurs=1 then 0 else b.nppn  as NPPNusd,

        case when i.kurs=1 then 0 else b.subtotal  as totalusd,

        I.kurs,I.KODEVLS,

        Cast(Case when Case when I.IsOtorisasi1=1 then 1 else 0 +

                      Case when I.IsOtorisasi2=1 then 1 else 0 +

                      Case when I.IsOtorisasi3=1 then 1 else 0 +

                      Case when I.IsOtorisasi4=1 then 1 else 0 +

                      Case when I.IsOtorisasi5=1 then 1 else 0 =I.MaxOL then 0

                 else 1

             As INTEGER) NeedOtorisasi,i.Devisi

From  dbPODet B 

Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg

Left Outer join DBPO I on B.NOBUKTI = I.NOBUKTI

Left Outer Join DBCUSTSUPP J on I.KODESUPP = J.KODECUSTSUPP;

-- VwReportPurchasingReq
CREATE VIEW IF NOT EXISTS VwReportPurchasingReq AS Select 	A.NoBukti,A.Tanggal,H.KODESUPP KodeCustSupp,I.NAMACUSTSUPP, 

	B.Urut, B.KodeBrg, Case when Isnull(H.IsJasa,0)=1 Then B.NamaBrg else H.NamaBrg  NamaBrg, B.Qnt, B.NoSat, B.Isi Isi, B.Sat Satuan,B.Keterangan,

	 Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                      Case when A.IsOtorisasi2=1 then 1 else 0 +

                      Case when A.IsOtorisasi3=1 then 1 else 0 +

                      Case when A.IsOtorisasi4=1 then 1 else 0 +

                      Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                 else 1

             As INTEGER) NeedOtorisasi,a.Devisi



From dbPPL A

Left Outer join dbPPLDet B on B.NoBukti=a.NoBukti

Left Outer join dbBarang H on H.KodeBrg=b.KodeBrg

Left Outer Join DBCUSTSUPP I on H.KODESUPP=i.KODECUSTSUPP;

-- VwReportRBeli
CREATE VIEW IF NOT EXISTS VwReportRBeli AS Select 	A.NoBukti+right('00000000'+cast(A.Urut as varchar(8)),8) KeyNoBukti,

        A.*, C.NamaCustSupp, T.Nama NamaTipe, ST.Nama NamaSubTipe,

        cast(left(A.NoBukti,2) as varchar(50)) Left2NoBukti

From dbRPembelian A

Left Outer Join DBCUSTSUPP C on C.KODECUSTSUPP=A.KodeCustSupp

Left Outer Join DBTIPETRANS T on T.KODETIPE=A.KodeTipe

Left Outer Join DBSUBTIPETRANS ST on ST.KODETIPE=A.KodeTipe and ST.KODESUBTIPE=A.KodeSubTipe;

-- VwReportRealisasiKP
CREATE VIEW IF NOT EXISTS VwReportRealisasiKP AS select a.NoBukti NOSO, a.KODECUST,a.TANGGAL,cust.NAMACUSTSUPP,Prj.NAMAPROJECT,a.NOBUKTI NoKontrak,

SOD.KODEBRG,Brg.NAMABRG,isnull(SOD.QntSO,0)QntSO,isnull(SJ.Qnt,0) QntSJ,isnull(SOD.QntSO,0)-isnull(SJ.Qnt,0) OSSJ

from DBSO a 

Left Outer Join (Select NoBukti,KodeBrg,SUM(isnull(Qnt,0)) QntSO from DBSODET 

                 Group By NoBukti,KodeBrg)SOD on SOD.NOBUKTI=a.NOBUKTI 

Left Outer Join (Select c.NOBUKTI,c.KodeBrg,SUM(isnull(a.QNT,0))Qnt from dbSPBDet a

                 Left Outer Join dbSPPDet b on a.NoSPP=b.NoBukti and b.KodeBrg=a.KodeBrg and a.UrutSPP=b.Urut

                 left outer join DBSODET c on c.NoBukti=b.NoSO and c.URUT=b.UrutSO and c.KODEBRG=b.KodeBrg

                 Group by c.NOBUKTI,c.KodeBrg)SJ on SJ.NOBUKTI=a.NOBUKTI and SJ.KodeBrg=SOD.KODEBRG            

Left Outer Join DBCUSTSUPP cust on cust.KODECUSTSUPP=a.KODECUST 

Left Outer Join DBPROJECT Prj on Prj.KODEPROJECT=a.AlamatKirim

Left Outer Join DBBARANG Brg on Brg.Kodebrg=SOD.KODEBRG;

-- vwReportRekapKirim
CREATE VIEW IF NOT EXISTS vwReportRekapKirim AS select 1 Urut,B2.NoSO,a.KodeCustSupp,d.NAMACUSTSUPP,a.NoResi Kodeproject,e.NAMAPROJECT,a.Tanggal,a.NOPOLKend,Isnull(c.Ukuran,0)Ukuran,Case When b.KodeBrg Like '%PC%' Then  Isnull(c.Ukuran,0)* (Sum(b.QNT)-Isnull(b1.Qnt,0)) else Null  LM,

       b.KodeBrg,c.NAMABRG,a.NoBukti, Sum(b.QNT)Qnt,SUM(b.QNT2)Qnt2,(Sum(b.QNT)-Isnull(b1.Qnt,0))QntSisa,(Sum(b.QNT2)-Isnull(b1.Qnt2,0))Qnt2Sisa,Isnull(b1.Qnt,0)QntRetur,Isnull(b1.Qnt2,0)Qnt2Retur,b.SAT_1,b.SAT_2,b.KodeGdg--,b.NOSAT 

from dbSPB a

Left Outer Join dbSPBDet b On a.NoBukti=b.NoBukti

Left Outer Join (select NoBukti,NoSO from dbSPPDet Group by NoBukti,NOSO)b2 On B2.NoBukti=b.NoSPP

Left Outer Join (select Kodebrg,NoSPB,SUM(Qnt)Qnt,SUM(QNT2)Qnt2 from DBRSPBDet Group by Kodebrg,NoSPB

                 UNION ALL

                 select a.KodeBrg,c.NoSPB,SUM(a.QNT)Qnt,SUM(a.QNT2)Qnt2 from dbSPBRJualDet a

                 Left Outer Join DBRInvoicePLDET b on a.NoRPJ=b.NOBUKTI and a.UrutRPJ=b.URUT

                 Left Outer Join dbInvoicePLDet c on c.NoBukti=b.NoInvoice and c.Urut=b.UrutInvoice

                 where a.NoRPJ=b.NOBUKTI and a.UrutRPJ=b.URUT

                 Group by a.KodeBrg,c.NoSPB)b1 On b.NoBukti=b1.NoSPB and b1.KodeBrg=b.KodeBrg

Left Outer Join DBBARANG c On c.KODEBRG=b.KodeBrg

Left Outer Join DBCUSTSUPP d On d.KODECUSTSUPP=a.KodeCustSupp

Left Outer Join DBPROJECT e On e.KODEPROJECT=a.NoResi

Group by a.KodeCustSupp,d.NAMACUSTSUPP,a.NoResi,e.NAMAPROJECT,a.Tanggal,a.NOPOLKend, 

       b.KodeBrg,c.NAMABRG,a.NoBukti,b.SAT_1,b1.Qnt,b1.Qnt2,b.SAT_2,B2.NoSO,ISNULL(c.Ukuran,0),b.KodeGdg--,b.NOSAT;

-- VwReportRekapPengirimanBarang
CREATE VIEW IF NOT EXISTS VwReportRekapPengirimanBarang AS select NAMAPROJECT,c.KODEPROJECT,a.Tanggal,b.KodeBrg,d.NamaBrg,a.NoBukti,NoPolKend,Sum(b.QNT)-Isnull(b1.Qnt,0) Qnt,b.SAT_1,Sum(b.QNT2)-Isnull(b1.Qnt2,0)Qnt2,b.SAT_2 

from dbSPB a

Left Outer Join dbSPBDet b on a.NoBukti=b.NoBukti

Left Outer Join (select Kodebrg,NoSPB,SUM(Qnt)Qnt,SUM(QNT2)Qnt2 from DBRSPBDet Group by Kodebrg,NoSPB

                 UNION ALL

                 select a.KodeBrg,c.NoSPB,SUM(a.QNT)Qnt,SUM(a.QNT2)Qnt2 from dbSPBRJualDet a

                 Left Outer Join DBRInvoicePLDET b on a.NoRPJ=b.NOBUKTI and a.UrutRPJ=b.URUT

                 Left Outer Join dbInvoicePLDet c on c.NoBukti=b.NoInvoice and c.Urut=b.UrutInvoice

                 where a.NoRPJ=b.NOBUKTI and a.UrutRPJ=b.URUT

                 Group by a.KodeBrg,c.NoSPB)b1 On b.NoBukti=b1.NoSPB and b1.KodeBrg=b.KodeBrg

Left Outer Join DBPROJECT c On c.KODEPROJECT=a.NoResi

Left Outer Join DBBARANG d On d.KODEBRG=b.KodeBrg

Group By NAMAPROJECT,c.KODEPROJECT,a.Tanggal,b.KodeBrg,d.NamaBrg,a.NoBukti,NoPolKend,b.SAT_1,b.SAT_2,Isnull(b1.Qnt,0),Isnull(b1.Qnt2,0);

-- VwReportRevisiPO
CREATE VIEW IF NOT EXISTS VwReportRevisiPO AS Select 	B.NoBukti,I.TANGGAL,I.KODESUPP KodeCustSupp,J.NAMACUSTSUPP, '' NoSPP, 0 UrutSPP,

	B.Urut, B.KodeBrg, H.NamaBrg, B.Qnt, B.NoSat, B.Isi, B.Satuan,

        0.00 Qnt2, '' SatuanRoll, B.Harga,

        B.DiscP DiscP1, B.DiscTot DiscRp1, B.DiscTot,

        B.SubTotal TotalUSD, B.SubTotal TotalIDR, B.NDPP NDPP,

        B.NPPN NPPN, B.BYAngkut Beban, B.SubTotal + B.BYAngkut Total

From  dbPODet B 

Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg

Left Outer join DBPO I on B.NOBUKTI = I.NOBUKTI

Left Outer Join DBCUSTSUPP J on I.KODESUPP = J.KODECUSTSUPP;

-- VwreportRInvoice
CREATE VIEW IF NOT EXISTS VwreportRInvoice AS Select 	B.NoBukti, B.UrutPBL,I.KODESUPP KodeCustSupp,j.NAMACUSTSUPP,I.TANGGAL,

	B.Urut, B.KodeBrg, H.NamaBrg, B.Qnt, B.NoSat, B.Isi, B.Satuan,

        0.00 Qnt2, '' SatuanRoll, B.Harga,

        B.DiscP DiscP1, B.DiscTot DiscRp1, B.DiscTot,

        B.SubTotal TotalUSD, B.SubTotal TotalIDR, B.NDPP NDPP,

        B.NPPN NPPN, B.BYAngkut Beban, B.SubTotal + B.BYAngkut Total

        

From dbRBeliDet B

Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg 

Left Outer Join DBRBELI I on B.NOBUKTI = I.NOBUKTI

Left Outer Join DBCUSTSUPP J on I.KODESUPP = J.KODECUSTSUPP;

-- VwReportRInvoicePenjualan
CREATE VIEW IF NOT EXISTS VwReportRInvoicePenjualan AS select 	B.NOBUKTI,D.TANGGAL, B.URUT, B.KODEBRG, B1.PPN, B1.DISC, B1.KURS,D1.NOSPB,D1.NoSPP,E.Tanggal TglSPBl,

        case when b.ISI>=0 Then Case When b.Nosat=2 Then b.Qnt2 else b.QNT   Else Case when b.Nosat=2 Then b.QNT else b.QNT2   QNT,B.QNT QNT1, B.QNT2, B.SAT_1 , B.SAT_2, B.ISI, B1.HARGA, B1.DiscP1, B1.DiscRp1,

        B1.DiscP2, B1.DiscRp2, B1.DiscP3, B1.DiscRp3, B1.DiscP4, B1.DiscRp4, B1.DISCTOT,

        B1.BYANGKUT, B1.HRGNETTO, B1.NDISKON, B1.SUBTOTAL, B1.NDPP, B1.NPPN, B1.NNET, B1.SUBTOTALRp,

        B1.NDPPRp, B1.NPPNRp, B1.NNETRp, B1.NOInvoice, B1.URUTInvoice, B1.Keterangan,

        C.NamaBrg, B1.QntTukar, B1.Qnt2Tukar, B.netW, B.GrossW,

        'Nama Produk : '+c.Namabrg+' '+'Nama Komersil : '+ b.namabrg NamaProduk,

        D.KODECUSTSUPP,G.NAMACUSTSUPP,

		Cast(Case when Case when D.IsOtorisasi1=1 then 1 else 0 +

		Case when D.IsOtorisasi2=1 then 1 else 0 +

		Case when D.IsOtorisasi3=1 then 1 else 0 +

		Case when D.IsOtorisasi4=1 then 1 else 0 +

		Case when D.IsOtorisasi5=1 then 1 else 0 =D.MaxOL then 0

		else 1

		 As INTEGER) Needotorisasi,Pr.NAMAPROJECT,ky.Nama,

		case when B.NOSAT=1 then CONVERT(Numeric(18,2),case When ISNULL(F.HPPBrg,0)<>0  Then F.HPPBrg else B.HPP )  else

		CONVERT(Numeric(18,2),case When ISNULL(F.HPPBrg,0)<>0  Then F.HPPBrg*B.ISI else B.HPP*B.Isi )  Hpp,

		case when b.ISI>=0 Then Case When b.Nosat=2 Then b.Qnt2 else b.QNT   Else Case when b.Nosat=2 Then b.QNT else b.QNT2  *

        case when B.NOSAT=1 then CONVERT(Numeric(18,2),case When ISNULL(F.HPPBrg,0)<>0  Then F.HPPBrg else B.HPP )  else

		CONVERT(Numeric(18,2),case When ISNULL(F.HPPBrg,0)<>0  Then F.HPPBrg*B.ISI else B.HPP*B.Isi )  DppHpp,

		B1.NDPP-(case when b.ISI>=0 Then Case When b.Nosat=2 Then b.Qnt2 else b.QNT   Else Case when b.Nosat=2 Then b.QNT else b.QNT2  *

        case when B.NOSAT=1 then CONVERT(Numeric(18,2),case When ISNULL(F.HPPBrg,0)<>0  Then F.HPPBrg else B.HPP )  else

		CONVERT(Numeric(18,2),case When ISNULL(F.HPPBrg,0)<>0  Then F.HPPBrg*B.ISI else B.HPP*B.Isi ) ) Laba,

		c.KODESUBGRP,D1.Devisi

from	dbSPBRJualDet B

Left Outer join dbRInvoicePLDet B1 on B1.NOBUKTI=B.NoRPJ and B1.Urut=B.UrutRPJ

Left Outer Join (Select NoBukti,Urut,NoSPB,NoSO from dbInvoicePLDet group by NoBukti,NoSPB,Urut,NoSO)x  on x.NoBukti=B1.NoInvoice and B1.UrutInvoice=x.Urut

Left Outer Join DBRInvoicePL D1 on D1.NOBUKTI=B1.NOBUKTI

left outer join dbBarang C on C.KodeBrg=B.KodeBrg

left outer join dbSPBRjual D on B.NOBUKTI=D.NOBUKTI

Left Outer Join dbSPB E on x.NOSPB = E.NoBukti

Left Outer Join DBSO SO on SO.NOBUKTI=x.NoSO

Left Outer Join dbKaryawan ky on Ky.KeyNIK=SO.KODESLS

Left Outer Join DBPROJECT Pr on Pr.KODEPROJECT=E.NoResi

Left Outer join DBCUSTSUPP G on D.KODECUSTSUPP=G.KODECUSTSUPP

left outer join dbHPPProduksi F on  F.KodeBrg=b.KodeBrg  and F.Bulan=MONTH(D.Tanggal) and F.Tahun=YEAR(D.Tanggal)

--where d.NOBUKTI='bcb/spr/0520/00001';

-- VwReportRjual
CREATE VIEW IF NOT EXISTS VwReportRjual AS Select 	A.NoBukti+right('00000000'+cast(A.Urut as varchar(8)),8) KeyNoBukti,

        A.*, C.NamaCustSupp, T.Nama NamaTipe, ST.Nama NamaSubTipe,

        cast(left(A.NoBukti,2) as varchar(50)) Left2NoBukti

From dbRPenjualan A

Left Outer Join DBCUSTSUPP C on C.KODECUSTSUPP=A.KodeCustSupp

Left Outer Join DBTIPETRANS T on T.KODETIPE=A.KodeTipe

Left Outer Join DBSUBTIPETRANS ST on ST.KODETIPE=A.KodeTipe and ST.KODESUBTIPE=A.KodeSubTipe;

-- VwReportRPembelianGDg
CREATE VIEW IF NOT EXISTS VwReportRPembelianGDg AS Select 	A.NoBukti,A.TANGGAL, a.Nobeli, A.KODESUPP KodeCustSupp,I.NAMACUSTSUPP,

	    B.Urut, B.KodeBrg, H.NamaBrg,b.QNT as qntretur,b.SATUAN as satrbeli,

	    isnull(B.Qnt1,0) as qnt, h.SAT1 as satuan,

        isnull(b.Qnt2,0) as Qnt2,h.SAT2 As satuan2,

        B.Harga, B.HrgNetto,B.DiscP,B.DiscTot,

        case when a.KODEVLS<>'IDR' then b.NDPP else 0  as ndpp,B.NDPPRp,b.NPPNRp,b.NNETRp,

        A.KODEVLS,A.KURS,A.FAKTURSUPP,

        Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                      Case when A.IsOtorisasi2=1 then 1 else 0 +

                      Case when A.IsOtorisasi3=1 then 1 else 0 +

                      Case when A.IsOtorisasi4=1 then 1 else 0 +

                      Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                 else 1

             As INTEGER) NeedOtorisasi

        

From dbRBeliDet B

Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg 

left Outer Join DBRBELI A on B.NOBUKTI=A.NOBUKTI

Left Outer Join DBCUSTSUPP I on A.KODESUPP = I.KODECUSTSUPP;

-- VwReportRPenjualanGdg
CREATE VIEW IF NOT EXISTS VwReportRPenjualanGdg AS select 	B.NOBUKTI,D.TANGGAL, B.URUT, B.KODEBRG, B1.PPN, B1.DISC, B1.KURS,D1.NOSPB,D1.NoSPP,E.Tanggal TglSPBl,

        case when b.ISI>=1 Then Case When b.Nosat=2 Then b.Qnt2 else b.QNT   Else Case when b.Nosat=2 Then b.QNT else b.QNT2   QNT,B.QNT QNT1, B.QNT2, B.SAT_1 , B.SAT_2, B.ISI, B1.HARGA, B1.DiscP1, B1.DiscRp1,

        B1.DiscP2, B1.DiscRp2, B1.DiscP3, B1.DiscRp3, B1.DiscP4, B1.DiscRp4, B1.DISCTOT,

        B1.BYANGKUT, B1.HRGNETTO, B1.NDISKON, B1.SUBTOTAL, B1.NDPP, B1.NPPN, B1.NNET, B1.SUBTOTALRp,

        B1.NDPPRp, B1.NPPNRp, B1.NNETRp, B1.NOInvoice, B1.URUTInvoice, B1.Keterangan,

        C.NamaBrg, B1.QntTukar, B1.Qnt2Tukar, B.netW, B.GrossW,

        'Nama Produk : '+c.Namabrg+' '+'Nama Komersil : '+ b.namabrg NamaProduk,

        D.KODECUSTSUPP,G.NAMACUSTSUPP,

		Cast(Case when Case when D.IsOtorisasi1=1 then 1 else 0 +

		Case when D.IsOtorisasi2=1 then 1 else 0 +

		Case when D.IsOtorisasi3=1 then 1 else 0 +

		Case when D.IsOtorisasi4=1 then 1 else 0 +

		Case when D.IsOtorisasi5=1 then 1 else 0 =D.MaxOL then 0

		else 1

		 As INTEGER) Needotorisasi,Pr.NAMAPROJECT,ky.Nama

        

from	dbSPBRJualDet B

Left Outer join dbRInvoicePLDet B1 on B1.NOBUKTI=B.NoRPJ and B1.Urut=B.UrutRPJ

Left Outer Join (Select NoBukti,Urut,NoSPB,NoSO from dbInvoicePLDet group by NoBukti,NoSPB,Urut,NoSO)x  on x.NoBukti=B1.NoInvoice and B1.UrutInvoice=x.Urut

Left Outer Join DBRInvoicePL D1 on D1.NOBUKTI=B1.NOBUKTI

left outer join dbBarang C on C.KodeBrg=B.KodeBrg

left outer join dbSPBRjual D on B.NOBUKTI=D.NOBUKTI

Left Outer Join dbSPB E on x.NOSPB = E.NoBukti

Left Outer Join DBSO SO on SO.NOBUKTI=x.NoSO

Left Outer Join dbKaryawan ky on Ky.KeyNIK=SO.KODESLS

Left Outer Join DBPROJECT Pr on Pr.KODEPROJECT=E.NoResi

Left Outer join DBCUSTSUPP G on D.KODECUSTSUPP=G.KODECUSTSUPP;

-- VwReportRPenyerahanBahan
CREATE VIEW IF NOT EXISTS VwReportRPenyerahanBahan AS Select 	A.NoBukti, 

B.Urut, B.KodeBrg, H.NamaBrg, B.Qnt, B.NoSat, B.Isi Isi, B.Sat Satuan,A.Tanggal,

Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                      Case when A.IsOtorisasi2=1 then 1 else 0 +

                      Case when A.IsOtorisasi3=1 then 1 else 0 +

                      Case when A.IsOtorisasi4=1 then 1 else 0 +

                      Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                 else 1

             As INTEGER) NeedOtorisasi 

From dbRPenyerahanBhn A

Left Outer join  dbRPenyerahanBhnDet B on B.NoBukti=a.NoBukti

Left Outer join dbBarang H on H.KodeBrg=b.KodeBrg;

-- VwReportRPLInvoice
CREATE VIEW IF NOT EXISTS VwReportRPLInvoice AS select 	B.NOBUKTI,D.TANGGAL, B.URUT, B.KODEBRG, B.PPN, B.DISC, B.KURS,D.NOSPB,D.NoSPP,E.Tanggal TglSPB,F.Tanggal TglSpp,

        B.QNT, B.QNT2, B.SAT_1, B.SAT_2, B.ISI, B.HARGA, B.DiscP1, B.DiscRp1,

        B.DiscP2, B.DiscRp2, B.DiscP3, B.DiscRp3, B.DiscP4, B.DiscRp4, B.DISCTOT,

        B.BYANGKUT, B.HRGNETTO, B.NDISKON, B.SUBTOTAL, B.NDPP, B.NPPN, B.NNET, B.SUBTOTALRp,

        B.NDPPRp, B.NPPNRp, B.NNETRp, B.NOInvoice, B.URUTInvoice, B.Keterangan,

        C.NamaBrg, B.QntTukar, B.Qnt2Tukar, B.netW, B.GrossW,

        'Nama Produk : '+c.Namabrg+' '+'Nama Komersil : '+ b.namabrg NamaProduk,

        D.KODECUSTSUPP,G.NAMACUSTSUPP

from	dbRInvoicePLDet B

left outer join dbBarang C on C.KodeBrg=B.KodeBrg

left outer join DBRInvoicePL D on B.NOBUKTI=D.NOBUKTI

Left Outer Join dbSPB E on D.NOSPB = E.NoBukti

Left Outer join dbSPP F on D.NoSPP = F.NoBukti

Left Outer join DBCUSTSUPP G on D.KODECUSTSUPP=G.KODECUSTSUPP;

-- VwReportSO
CREATE VIEW IF NOT EXISTS VwReportSO AS Select 	A.NoBukti, A.NoSPB, B.UrutSPB,A.TANGGAL,I.KODECUSTSUPP,I.NAMACUSTSUPP,

	A.NoBukti+right('0000000000'+cast(B.Urut as varchar(10)),10) NoBuktiUrut,

        B.Urut, B.KodeBrg, Case WHen isnull(b.KodeBrgM,'')<>'' Then '' when Isnull(B.NamaBrg,'')='' Then H.NamaBrg else ISNULL(B.NamaBrg,'') NamaBrg,

        case when b.NOSAT=1 then B.Qnt else b.QNT2  as qntjual,b.QNT, B.NoSat, B.Isi,Case When B.NOSAT=1 Then H.Sat1  else H.Sat2  Satuan,

        B.Qnt2, H.Sat2 Satuan2, B.Harga,

        B.DiscP1,B.DiscTot,B.NDPP,a.KURS,a.KODEVLS,B.NDPPRp,B.NPPNRp,B.NNETRp,

        Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 /*+

                      Case when A.IsOtorisasi2=1 then 1 else 0 +

                      Case when A.IsOtorisasi3=1 then 1 else 0 +

                      Case when A.IsOtorisasi4=1 then 1 else 0 +

                      Case when A.IsOtorisasi5=1 then 1 else 0 */=1/*A.MaxOL*/ then 0

                 else 1

             As INTEGER) NeedOtorisasi,H.KodeSubGrp,H.NamaSubGrp,B.HPP,H.HPPBrg,A.KODESLS,Kar.Nama NamaSls,

            Pr.NAMAPROJECT,A.Devisi  

From dbSO A

Left Outer join dbSODet B on B.NoBukti=a.NoBukti

Left Outer Join vwSatuanBrg H on H.KodeBrg=B.KodeBrg --and H.NoSat=B.NoSat

Left Outer join DBCUSTSUPP I on a.KODECUST = I.KODECUSTSUPP

Left Outer Join dbKaryawan Kar on Kar.KeyNIK=A.KODESLS

Left Outer Join DBPROJECT Pr on Pr.KODEPROJECT=A.AlamatKirim

where  Isnull(KodeBrgM,'')='';

-- vwreportSOx
CREATE VIEW IF NOT EXISTS vwreportSOx AS Select  A.NoBukti+right('00000'+cast(A.Urut as varchar(5)),5) KeyNoBukti, A.Nobukti, 

P.Tanggal, P.Kodecust KodeCustSupp, S.NamaCust NamaCustSupp,

A.urut, A.kodebrg, B.NamaBrg, A.Satuan, A.Isi,

A.Qnt, A.Qnt2, A.QntSPP, A.Qnt2SPP,

A.QntSisa, A.Qnt2Sisa,P.MasaBerlaku,P.NoPesanan,P.TglKirim,P.TGLJATUHTEMPO

From    vwBrowsOutSO_SPP A

Left Outer Join DBSO P on P.NoBukti=A.NoBukti

Left Outer Join vwBrowsCustomer S on S.KodeCust=P.KodeCust and S.Sales=P.KODESLS

Left Outer Join dbBarang B on B.KodeBrg=A.KodeBrg

where A.islengkap=0;

-- VwreportSparePartTruck
CREATE VIEW IF NOT EXISTS VwreportSparePartTruck AS Select 	H1.NMDEP,A.KdDep,A.NoBukti,A.NoBPPB,

	B.Urut, B.KodeBrg, H.NamaBrg, B.Qnt ,B.Qnt2 , B.NoSat, B.Isi Isi, B.Sat Satuan, B.Qnt * B.HPP NilaiHPP,B.Qnt2* B.HPP NilaiHPP2, A.Tanggal,Case when B.Nosat=1 Then B1.Hrg else B1.Hrg/B.Nosat  Hrg, B.Qnt *case when B.Nosat=1 Then B1.Hrg else b1.Hrg/b.nosat  NilaiBeli,B.Qnt2 *case when B.Nosat=1 Then B1.Hrg else B1.Hrg/B.Nosat  NilaiBeliSat2,

	Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                      Case when A.IsOtorisasi2=1 then 1 else 0 +

                      Case when A.IsOtorisasi3=1 then 1 else 0 +

                      Case when A.IsOtorisasi4=1 then 1 else 0 +

                      Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                 else 1

             As INTEGER) NeedOtorisasi,LEFT(KODESUBGRP,6)KodeGroup, NoPOL,Supir

From dbPenyerahanBhn A

Left Outer join  dbPenyerahanBhnDet B on B.NoBukti=a.NoBukti

Left Outer Join (select b.noBukti,a.KodeBrg,AVG(Hrg)Hrg 

                 from VwHrgRata2 a

                 Left Outer Join DBPenyerahanBhnDET b On a.KodeBrg=b.kodebrg

                 Left Outer Join DBPenyerahanBhn c On c.Nobukti=b.Nobukti

                 where a.Tanggal<=c.tanggal or ( MONTH(a.Tanggal)=MONTH(c.Tanggal) and YEAR(a.Tanggal)=YEAR(c.Tanggal))

                 Group by b.noBukti,a.KodeBrg)B1 On B1.KODEBRG=B.kodebrg and B1.Nobukti=A.Nobukti 

Left Outer join dbBarang H on H.KodeBrg=b.KodeBrg

Left Outer Join(Select * from DBDEPART where Isnull(isSetPass,0)=0)H1 On H1.KDDEP=A.KdDep

where Isnull(H.ISAKTIF,0)=1;

-- VwreportSPB
CREATE VIEW IF NOT EXISTS VwreportSPB AS select 	B.NOBUKTI, B.URUT, B.NoSPP NoSC, B.UrutSPP UrutSC, B.KODEBRG, 'NoPOL.:'+A.NoPolKend+CHAR(13)+'Pengemudi :'+A.Sopir+CHAR(13)+C.NAMABRG NamaBrg, '' Jns_Kertas, ''Ukr_Kertas,

        B.QNT, B.QNT2, B.SAT_1, B.SAT_2, B.ISI, B.NetW, B.GrossW, '' KetDetail,

        A.Tanggal,a.KodeCustSupp,D.NAMACUSTSUPP+'/ '+Isnull(D.ContactP,'')+'  '+Isnull(D.TelpContP,'')+CHAR(13)+D.ALAMAT1 NAMACUSTSUPP, 

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER)NeedOtorisasi,b1.NoSO,e.NAMAPROJECT,b.KodeGdg,A.NoPolKend

		,a.Devisi  

from	dbSPBDet B

left outer join dbBarang C on C.KodeBrg=B.KodeBrg

Left Outer join dbSPB A on B.NoBukti = A.NoBukti

Left Outer Join (select Noso,NoBukti,KodeBrg from dbSPPDet Group by Noso,NoBukti,KodeBrg)b1 on b1.NoBukti=B.NoSPP and b1.KodeBrg=b.KodeBrg

Left Outer Join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

Left Outer Join DBPROJECT e On e.KODEPROJECT=A.NoResi

--where  B.NoBukti Not like '%SJB%';

-- VwreportSPBACC
CREATE VIEW IF NOT EXISTS VwreportSPBACC AS select distinct	B.NOBUKTI, B.URUT, B.NoSPP NoSC, B.UrutSPP UrutSC, B.KODEBRG, C.NAMABRG, '' Jns_Kertas, ''Ukr_Kertas,

        case when B.NOSAT=1 Then B.QNT Else B.QNT2  Qnt, B.QNT2, case when B.NOSAT=1 Then B.SAT_1 else B.SAT_2   SAT_1, B.SAT_2, B.ISI, B.NetW, B.GrossW, '' KetDetail,F2.HARGA,case when B.NOSAT=1 Then B.QNT Else B.QNT2 *F2.HARGA dpp,case when F2.PPN IN(1,2)Then (case when B.NOSAT=1 Then B.QNT Else B.QNT2 *F2.HARGA)*0.1 else 0  ppn ,case when B.NOSAT=1 Then B.QNT Else B.QNT2 *(CONVERT(Numeric(18,2),Case When Isnull(F.HPPBrg,0)=0 Then C.Hrg1_2 else Isnull(F.HPPBrg,0) )) dpphpp,

        (case when B.NOSAT=1 Then B.QNT Else B.QNT2 *F2.HARGA)-(case when B.NOSAT=1 Then B.QNT Else B.QNT2 *(CONVERT(Numeric(18,2),Case When Isnull(F.HPPBrg,0)=0 Then C.Hrg1_2 else F.HPPBrg ))) Laba,

        A.Tanggal,a.KodeCustSupp,D.NAMACUSTSUPP+CHAR(13)+Isnull(Prj.NAMAPROJECT,'') NAMACUSTSUPP, 

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER)NeedOtorisasi, (CONVERT(Numeric(18,2), Isnull(F.HPPBrg,0) ))HPP, (f2.HARGA*case when B.NOSAT=1 Then B.QNT Else B.QNT2 )/*-(F.HPP*B.QNT)*/+case when F2.PPN IN(1,2)Then (case when B.NOSAT=1 Then B.QNT Else B.QNT2 *F2.HARGA)*0.1 else 0  Total,C1.NoBukti NoInv,

		'' Noso,D.KODECUSTSUPP+A.NoResi CustProject,b.KodeGdg,gdg.NAMA NamaGdg,a.Devisi 

from	dbSPBDet B

left outer join dbBarang C on C.KodeBrg=B.KodeBrg

Left outer join(select NoBukti,NoSPB,KodeBrg from dbInvoicePLDet Group by NoBukti,NoSPB,KodeBrg)C1 On C1.NoSPB=b.NoBukti and C1.KodeBrg=B.KodeBrg

Left Outer join dbSPB A on B.NoBukti = A.NoBukti

Left Outer Join DBGUDANG gdg on gdg.KODEGDG=b.KodeGdg

Left Outer Join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

left outer join dbSPPDet E on e.NoBukti=B.NoSPP and e.KodeBrg=b.KodeBrg and E.Urut=B.UrutSPP

left outer join DBSODET F2 on F2.NoBukti=E.NoSO and F2.KodeBrg=b.KodeBrg and F2.URUT=E.UrutSO

Left Outer Join DBPROJECT Prj on Prj.KODEPROJECT=A.NoResi

left outer join dbHPPProduksi F on  F.KodeBrg=b.KodeBrg  and F.Bulan=MONTH(A.Tanggal) and F.Tahun=YEAR(A.Tanggal)

where /*(Left(B.NoBukti,3) Like '%BCA%' or Left(B.NoBukti,3) Like '%BCB%') and*/ B.NoBukti Not Like '%SJB%' and ISNULL(a.IsClose,0)=0;

-- VwreportSPBPlusReturACC
CREATE VIEW IF NOT EXISTS VwreportSPBPlusReturACC AS select distinct	B.NOBUKTI, B.URUT, B.NoSPP NoSC, B.UrutSPP UrutSC, B.KODEBRG, case when isnull(c.IsJasa,0)=1 then b.Namabrg else C.NAMABRG  NAMABRG, '' Jns_Kertas, ''Ukr_Kertas,

        case when B.NOSAT=1 Then B.QNT Else B.QNT2  Qnt, B.QNT2, case when B.NOSAT=1 Then B.SAT_1 else B.SAT_2   SAT_1, 

        B.SAT_2, B.ISI, B.NetW, B.GrossW,'' KetDetail,case when B.NoBukti not Like '%SJB%' then case when isnull(f2.PPN,0)=2 then F2.HARGA/(1+NilaiPPN) else F2.HARGA  else B.GrossW  Harga,

        ((case when B.NOSAT=1 Then B.QNT Else B.QNT2 +isnull(c2.QntKoreksi,0))*case when a.Tanggal>='2018-11-01' then case when isnull(f2.PPN,0)=2 then case when B.NoBukti not Like '%SJB%' then  F2.HARGA else B.GrossW /(1+NilaiPPN) else case when B.NoBukti not Like '%SJB%' then  F2.HARGA else B.GrossW   else case when B.NoBukti not Like '%SJB%' then  F2.HARGA else B.GrossW  )-isnull((((case when B.NOSAT=1 Then B.QNT Else B.QNT2 +isnull(c2.QntKoreksi,0))*case when a.Tanggal>='2018-11-01' then case when isnull(f2.PPN,0)=2 then case when B.NoBukti not Like '%SJB%' then  F2.HARGA else B.GrossW /(1+NilaiPPN) else case when B.NoBukti not Like '%SJB%' then  F2.HARGA else B.GrossW   else case when B.NoBukti not Like '%SJB%' then  F2.HARGA else B.GrossW  )*f2.DISC/100),0) dpp,

         case when F2.PPN IN(1,2)Then (((case when B.NOSAT=1 Then B.QNT Else B.QNT2 +isnull(c2.QntKoreksi,0))*case when a.Tanggal>='2018-11-01' then case when isnull(f2.PPN,0)=2 then case when B.NoBukti not Like '%SJB%' then  F2.HARGA else B.GrossW /(1+NilaiPPN) else case when B.NoBukti not Like '%SJB%' then  F2.HARGA else B.GrossW   else case when B.NoBukti not Like '%SJB%' then  F2.HARGA else B.GrossW  )-isnull((((case when B.NOSAT=1 Then B.QNT Else B.QNT2 +isnull(c2.QntKoreksi,0))*case when a.Tanggal>='2018-11-01' then case when isnull(f2.PPN,0)=2 then case when B.NoBukti not Like '%SJB%' then  F2.HARGA else B.GrossW /(1+NilaiPPN) else case when B.NoBukti not Like '%SJB%' then  F2.HARGA else B.GrossW   else case when B.NoBukti not Like '%SJB%' then  F2.HARGA else B.GrossW  )*f2.DISC/100),0))*NilaiPPN else 0  ppn ,

        ((((case when B.NOSAT=1 Then B.QNT Else B.QNT2 +isnull(c2.QntKoreksi,0))*case when a.Tanggal>='2018-11-01' then case when isnull(f2.PPN,0)=2 then case when B.NoBukti not Like '%SJB%' then  F2.HARGA else B.GrossW /(1+NilaiPPN) else case when B.NoBukti not Like '%SJB%' then  F2.HARGA else B.GrossW   else case when B.NoBukti not Like '%SJB%' then  F2.HARGA else B.GrossW  )-((case when B.NOSAT=1 Then B.QNT Else B.QNT2 +isnull(c2.QntKoreksi,0))*case when a.Tanggal>='2018-11-01' then case when isnull(f2.PPN,0)=2 then case when B.NoBukti not Like '%SJB%' then  F2.HARGA else B.GrossW /(1+NilaiPPN) else case when B.NoBukti not Like '%SJB%' then  F2.HARGA else B.GrossW   else case when B.NoBukti not Like '%SJB%' then  F2.HARGA else B.GrossW  )*isnull(f2.DISC,0)/100)+

          (case when F2.PPN IN(1,2)Then (((case when B.NOSAT=1 Then B.QNT Else B.QNT2 +isnull(c2.QntKoreksi,0))*case when a.Tanggal>='2018-11-01' then case when isnull(f2.PPN,0)=2 then case when B.NoBukti not Like '%SJB%' then  F2.HARGA else B.GrossW /(1+NilaiPPN) else case when B.NoBukti not Like '%SJB%' then  F2.HARGA else B.GrossW   else case when B.NoBukti not Like '%SJB%' then  F2.HARGA else B.GrossW  )-isnull((((case when B.NOSAT=1 Then B.QNT Else B.QNT2 +isnull(c2.QntKoreksi,0))*case when a.Tanggal>='2018-11-01' then case when isnull(f2.PPN,0)=2 then case when B.NoBukti not Like '%SJB%' then  F2.HARGA else B.GrossW /(1+NilaiPPN) else case when B.NoBukti not Like '%SJB%' then  F2.HARGA else B.GrossW   else case when B.NoBukti not Like '%SJB%' then  F2.HARGA else B.GrossW  )*f2.DISC/100),0))*NilaiPPN else 0 )) Total,

        case when B.NOSAT=1 Then B.QNT Else B.QNT2 *(case when B.NOSAT=1 then CONVERT(Numeric(18,2),case When ISNULL(F.HPPBrg,0)<>0  Then F.HPPBrg else B.HPP )  else

		CONVERT(Numeric(18,2),case When ISNULL(F.HPPBrg,0)<>0  Then F.HPPBrg*cast(b.ISI as numeric(18,2)) else B.HPP*cast(b.ISI as numeric(18,2)) ) ) dpphpp,

        (isnull(((case when B.NOSAT=1 Then B.QNT Else B.QNT2 +isnull(c2.QntKoreksi,0))*case when a.Tanggal>='2018-11-01' then case when isnull(f2.PPN,0)=2 then case when B.NoBukti not Like '%SJB%' then  F2.HARGA else B.GrossW /(1+NilaiPPN) else case when B.NoBukti not Like '%SJB%' then  F2.HARGA else B.GrossW   else case when B.NoBukti not Like '%SJB%' then  F2.HARGA else B.GrossW  )-isnull((((case when B.NOSAT=1 Then B.QNT Else B.QNT2 +isnull(c2.QntKoreksi,0))*case when a.Tanggal>='2018-11-01' then case when isnull(f2.PPN,0)=2 then case when B.NoBukti not Like '%SJB%' then  F2.HARGA else B.GrossW /(1+NilaiPPN) else case when B.NoBukti not Like '%SJB%' then  F2.HARGA else B.GrossW   else case when B.NoBukti not Like '%SJB%' then  F2.HARGA else B.GrossW  )*f2.DISC/100),0),0)-

        isnull((case when B.NOSAT=1 Then B.QNT Else B.QNT2 *(case when B.NOSAT=1 then CONVERT(Numeric(18,2),case When ISNULL(F.HPPBrg,0)<>0  Then F.HPPBrg else B.HPP )  else

		CONVERT(Numeric(18,2),case When ISNULL(F.HPPBrg,0)<>0  Then F.HPPBrg*cast(b.ISI as numeric(18,2)) else B.HPP*cast(b.ISI as numeric(18,2)) ) )),0)

		) Laba,

        A.Tanggal,a.KodeCustSupp,--D.NAMACUSTSUPP+CHAR(13)+Isnull(Prj.NAMAPROJECT,'') NAMACUSTSUPP, 

        D.NAMACUSTSUPP NAMACUSTSUPP,a.NoResi,Isnull(Prj.NAMAPROJECT,'') NAMAPROJECT,  

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0 else 1  As INTEGER)NeedOtorisasi,

		case when B.NOSAT=1 then CONVERT(Numeric(18,2),case When ISNULL(F.HPPBrg,0)<>0  Then F.HPPBrg else B.HPP )  else

		CONVERT(Numeric(18,2),case When ISNULL(F.HPPBrg,0)<>0  Then F.HPPBrg*cast(b.ISI as numeric(18,2)) else B.HPP*cast(b.ISI as numeric(18,2)) )   HPP,

		 C1.NoBukti NoInv,'' Noso,0 QntRetur,D.KODECUSTSUPP+A.NoResi CustProject,A.Tanggal TglSPB,'' NoSPB,B.NoSPP,

		case when upper(b.SAT_1)='PCS' then b.QNT when upper(b.SAT_2)='PCS' then b.QNT2 else 0  QntSJPcs,

		case when upper(b.SAT_1)='PCS' then b.SAT_1 when upper(b.SAT_2)='PCS' then b.SAT_2 else ''  SatSJPcs,

		case when upper(b.SAT_1)<>'PCS' then b.QNT when (upper(b.SAT_2)<>'PCS' and upper(b.SAT_2)<>'') then b.QNT2 else 0  QntSJNonPcs,

		case when upper(b.SAT_1)<>'PCS' then b.SAT_1 when upper(b.SAT_2)<>'PCS' then b.SAT_2 else ''  SatSJNonPcs,

		case when upper(b.SAT_1)='PCS' then 0 when upper(b.SAT_2)='PCS' then 0 else 0  QntRSJPcs,

		case when upper(b.SAT_1)='PCS' then '' when upper(b.SAT_2)='PCS' then '' else ''  SatRSJPcs,

		case when upper(b.SAT_1)<>'PS' then 0 when upper(b.SAT_2)<>'PCS' then 0 else 0  QntRSJNonPcs,

		case when upper(b.SAT_1)<>'PCS' then '' when upper(b.SAT_2)<>'PCS' then '' else ''  SatRSJNonPcs,B.NoBukti NoBuktiSJ,

		isnull(((case when a.Tanggal>='2018-11-01' then case when isnull(f2.PPN,0)=2 then case when B.NoBukti not Like '%SJB%' then  F2.HARGA else B.GrossW /(1+NilaiPPN) else case when B.NoBukti not Like '%SJB%' then  F2.HARGA else B.GrossW   else case when B.NoBukti not Like '%SJB%' then  F2.HARGA else B.GrossW  )*f2.DISC/100),0) DISCTOT,

	    c.KODESUBGRP,b.KodeGdg,gdg.NAMA NamaGdg,a.Devisi

from	dbSPBDet B

left outer join dbBarang C on C.KodeBrg=B.KodeBrg

Left outer join(select min(NoBukti) NoBukti,NoSPB,KodeBrg from dbInvoicePLDet Group by NoSPB,KodeBrg)C1 On C1.NoSPB=b.NoBukti and C1.KodeBrg=B.KodeBrg

Left outer join(select NoBukti,NoSPB,KodeBrg,QntKoreksi,UrutSPB from dbInvoicePLDet)C2 On C2.NoSPB=b.NoBukti and C2.KodeBrg=B.KodeBrg and c2.UrutSPB=b.Urut

Left Outer join dbSPB A on B.NoBukti = A.NoBukti

Left Outer Join DBGUDANG gdg on gdg.KODEGDG=b.KodeGdg

LEFT Outer Join (select SUM(QNT)Qnt,SUM(QNT2)Qnt2,NOSPB,UrutSPB from DBRSPBDet Group By NOSPB,UrutSPB)AB on AB.NoSPB=B.NoBukti and AB.UrutSPB=B.Urut 

Left Outer Join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

left outer join dbSPPDet E on e.NoBukti=B.NoSPP and e.KodeBrg=b.KodeBrg and E.Urut=B.UrutSPP

left outer join DBSODET F2 on F2.NoBukti=E.NoSO and F2.KodeBrg=b.KodeBrg and F2.URUT=E.UrutSO

Left Outer Join DBPROJECT Prj on Prj.KODEPROJECT=A.NoResi

left outer join dbHPPProduksi F on  F.KodeBrg=b.KodeBrg  and F.Bulan=MONTH(A.Tanggal) and F.Tahun=YEAR(A.Tanggal)

where /*((Left(B.NoBukti,3) Like 'BCA%' or Left(B.NoBukti,3) Like 'BCB%')) and*/ B.NoBukti Not Like '%SJB%' and B.NoBukti not like '%SPBB%' and C.NAMABRG not like '%Jasa%' and

ISNULL(A.IsClose,0)=0

union all

select 	B.NOBUKTI, B.URUT, B.NoSPB NoSC, B.UrutSPB UrutSC, B.KODEBRG, case when isnull(c.IsJasa,0)=1 then b.Namabrg else C.NAMABRG  NAMABRG, '' Jns_Kertas, ''Ukr_Kertas,

0 Qnt, 0 QNT2, case when B.NOSAT=1 Then B.SAT_1 else B.SAT_2   SAT_1,

 B.SAT_2, B.ISI, B.NetW, B.GrossW,'' KetDetail,case when a1.NoBukti not Like '%SJB%' then  case when isnull(f2.PPN,0)=2 then F2.HARGA/(1+NilaiPPN) else F2.HARGA   else a1.GrossW  HARGA,

         (((case when B.NOSAT=1 Then B.QNT Else B.QNT2 )*case when a.Tanggal>='2018-11-01' then case when isnull(f2.PPN,0)=2 then case when a1.NoBukti not Like '%SJB%' then  F2.HARGA else a1.GrossW /(1+NilaiPPN) else case when a1.NoBukti not Like '%SJB%' then  F2.HARGA else a1.GrossW   else case when a1.NoBukti not Like '%SJB%' then  F2.HARGA else a1.GrossW  )-(((case when B.NOSAT=1 Then B.QNT Else B.QNT2 )*case when a.Tanggal>='2018-11-01' then case when isnull(f2.PPN,0)=2 then case when a1.NoBukti not Like '%SJB%' then  F2.HARGA else a1.GrossW /(1+NilaiPPN) else case when a1.NoBukti not Like '%SJB%' then  F2.HARGA else a1.GrossW   else case when a1.NoBukti not Like '%SJB%' then  F2.HARGA else a1.GrossW  )*isnull(f2.DISC,0)/100))*-1 dpp,

         (case when F2.PPN IN(1,2)Then (((case when B.NOSAT=1 Then B.QNT Else B.QNT2 )*case when a.Tanggal>='2018-11-01' then case when isnull(f2.PPN,0)=2 then case when a1.NoBukti not Like '%SJB%' then  F2.HARGA else a1.GrossW /(1+NilaiPPN) else case when a1.NoBukti not Like '%SJB%' then  F2.HARGA else a1.GrossW   else case when a1.NoBukti not Like '%SJB%' then  F2.HARGA else a1.GrossW  )-(((case when B.NOSAT=1 Then B.QNT Else B.QNT2 )*case when a.Tanggal>='2018-11-01' then case when isnull(f2.PPN,0)=2 then case when a1.NoBukti not Like '%SJB%' then  F2.HARGA else a1.GrossW /(1+NilaiPPN) else case when a1.NoBukti not Like '%SJB%' then  F2.HARGA else a1.GrossW   else case when a1.NoBukti not Like '%SJB%' then  F2.HARGA else a1.GrossW  )*isnull(f2.DISC,0)/100))*NilaiPPN else 0 )*-1 ppn,

        ((((case when B.NOSAT=1 Then B.QNT Else B.QNT2 )*case when a.Tanggal>='2018-11-01' then case when isnull(f2.PPN,0)=2 then case when a1.NoBukti not Like '%SJB%' then  F2.HARGA else a1.GrossW /(1+NilaiPPN) else case when a1.NoBukti not Like '%SJB%' then  F2.HARGA else a1.GrossW   else case when a1.NoBukti not Like '%SJB%' then  F2.HARGA else a1.GrossW  )-(((case when B.NOSAT=1 Then B.QNT Else B.QNT2 )*case when a.Tanggal>='2018-11-01' then case when isnull(f2.PPN,0)=2 then case when a1.NoBukti not Like '%SJB%' then  F2.HARGA else a1.GrossW /(1+NilaiPPN) else case when a1.NoBukti not Like '%SJB%' then  F2.HARGA else a1.GrossW   else case when a1.NoBukti not Like '%SJB%' then  F2.HARGA else a1.GrossW  )*isnull(f2.DISC,0)/100))+

          (case when F2.PPN IN(1,2)Then (((case when B.NOSAT=1 Then B.QNT Else B.QNT2 )*case when a.Tanggal>='2018-11-01' then case when isnull(f2.PPN,0)=2 then case when a1.NoBukti not Like '%SJB%' then  F2.HARGA else a1.GrossW /(1+NilaiPPN) else case when a1.NoBukti not Like '%SJB%' then  F2.HARGA else a1.GrossW   else case when a1.NoBukti not Like '%SJB%' then  F2.HARGA else a1.GrossW  )-(((case when B.NOSAT=1 Then B.QNT Else B.QNT2 )*case when a.Tanggal>='2018-11-01' then case when isnull(f2.PPN,0)=2 then case when a1.NoBukti not Like '%SJB%' then  F2.HARGA else a1.GrossW /(1+NilaiPPN) else case when a1.NoBukti not Like '%SJB%' then  F2.HARGA else a1.GrossW   else case when a1.NoBukti not Like '%SJB%' then  F2.HARGA else a1.GrossW  )*isnull(f2.DISC,0)/100))*NilaiPPN else 0 ))*-1 Total,

        /*(case when B.NOSAT=1 Then B.QNT Else B.QNT2 *(case when B.NOSAT=1 then CONVERT(Numeric(18,2),case When ISNULL(F.HPPBrg,0)<>0  Then F.HPPBrg else B.HPP )  else

		CONVERT(Numeric(18,2),case When ISNULL(F.HPPBrg,0)<>0  Then F.HPPBrg*B.ISI else B.HPP*B.Isi ) ))*/

		isnull(B.Qnt*case When ISNULL(F.HPPBrg,0)<>0  Then F.HPPBrg else B.HPP ,0)*-1 dpphpp,

        (isnull((((case when B.NOSAT=1 Then B.QNT Else B.QNT2 )*case when a.Tanggal>='2018-11-01' then case when isnull(f2.PPN,0)=2 then case when a1.NoBukti not Like '%SJB%' then  F2.HARGA else a1.GrossW /(1+NilaiPPN) else case when a1.NoBukti not Like '%SJB%' then  F2.HARGA else a1.GrossW   else case when a1.NoBukti not Like '%SJB%' then  F2.HARGA else a1.GrossW  )-(((case when B.NOSAT=1 Then B.QNT Else B.QNT2 )*case when a.Tanggal>='2018-11-01' then case when isnull(f2.PPN,0)=2 then case when a1.NoBukti not Like '%SJB%' then  F2.HARGA else a1.GrossW /(1+NilaiPPN) else case when a1.NoBukti not Like '%SJB%' then  F2.HARGA else a1.GrossW   else case when a1.NoBukti not Like '%SJB%' then  F2.HARGA else a1.GrossW  )*isnull(f2.DISC,0)/100)),0)-

        /*isnull(case when B.NOSAT=1 Then B.QNT Else B.QNT2 *(case when B.NOSAT=1 then CONVERT(Numeric(18,2),case When ISNULL(F.HPPBrg,0)<>0  Then F.HPPBrg else B.HPP )  else

		CONVERT(Numeric(18,2),case When ISNULL(F.HPPBrg,0)<>0  Then F.HPPBrg*B.ISI else B.HPP*B.Isi ) ),0)*/

		isnull(B.Qnt*case When ISNULL(F.HPPBrg,0)<>0  Then F.HPPBrg else B.HPP ,0)

		)*-1 Laba,

        A.Tanggal,a.KodeCustSupp,--D.NAMACUSTSUPP+CHAR(13)+Isnull(Prj.NAMAPROJECT,'') NAMACUSTSUPP, 

        D.NAMACUSTSUPP NAMACUSTSUPP,a2.NoResi,Isnull(Prj.NAMAPROJECT,'') NAMAPROJECT,  

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0 else 1  As INTEGER)NeedOtorisasi, 

		case when B.NOSAT=1 then CONVERT(Numeric(18,2),case When ISNULL(F.HPPBrg,0)<>0  Then F.HPPBrg else B.HPP )  else

		CONVERT(Numeric(18,2),case When ISNULL(F.HPPBrg,0)<>0  Then F.HPPBrg*B.ISI else B.HPP*B.Isi )  HPP, '' NoInv,

		'' Noso,case when B.NOSAT=1 Then Isnull(B.QNT,0) Else Isnull(B.Qnt2,0)  QntRetur,D.KODECUSTSUPP+A2.NoResi CustProject,a2.Tanggal TglSPB,a2.NoBukti,e.NoBukti NoSPP,

		case when upper(b.SAT_1)='PCS' then 0 when upper(b.SAT_2)='PCS' then 0 else 0  QntSJPcs,

		case when upper(b.SAT_1)='PCS' then '' when upper(b.SAT_2)='PCS' then '' else ''  SatSJPcs,

		case when upper(b.SAT_1)<>'PCS' then 0 when upper(b.SAT_2)<>'PCS' then 0 else 0  QntSJNonPcs,

		case when upper(b.SAT_1)<>'PCS' then '' when upper(b.SAT_2)<>'PCS' then '' else ''  SatSJNonPcs,

		case when upper(b.SAT_1)='PCS' then b.QNT when upper(b.SAT_2)='PCS' then b.QNT2 else 0  QntRSJPcs,

		case when upper(b.SAT_1)='PCS' then b.SAT_1 when upper(b.SAT_2)='PCS' then b.SAT_2 else ''  SatRSJPcs,

		case when upper(b.SAT_1)<>'PCS' then b.QNT when (upper(b.SAT_2)<>'PCS' and upper(b.SAT_2)<>'') then b.QNT2 else 0  QntRSJNonPcs,

		case when upper(b.SAT_1)<>'PCS' then b.SAT_1 when upper(b.SAT_2)<>'PCS' then b.SAT_2 else ''  SatRSJNonPcs,a1.NoBukti NoBuktiSJ,

		isnull(((case when a.Tanggal>='2018-11-01' then case when isnull(f2.PPN,0)=2 then case when B.NoBukti not Like '%SJB%' then  F2.HARGA else B.GrossW /(1+NilaiPPN) else case when B.NoBukti not Like '%SJB%' then  F2.HARGA else B.GrossW   else case when B.NoBukti not Like '%SJB%' then  F2.HARGA else B.GrossW  )*f2.DISC/100),0) DISCTOT,

        c.KODESUBGRP,a.KodeGdg,gdg.NAMA NamaGdg,a.Devisi

from DBRSPBDet b

left outer join DBBARANG c on c.KODEBRG=b.KodeBrg

left outer join DBRSPB a on a.NoBukti=b.NoBukti

LEFT outer join dbSPBDet a1 on a1.NoBukti=b.NoSPB and a1.Urut=b.UrutSPB

LEFT outer join dbSPB a2 on a2.NoBukti=a1.NoBukti

Left Outer Join DBGUDANG gdg on gdg.KODEGDG=a.KodeGdg

Left Outer Join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

left outer join dbSPPDet E on e.NoBukti=a1.NoSPP and e.KodeBrg=a1.KodeBrg and E.Urut=a1.UrutSPP

left outer join DBSODET F2 on F2.NoBukti=E.NoSO and F2.KodeBrg=e.KodeBrg and F2.URUT=E.UrutSO

Left Outer Join DBPROJECT Prj on Prj.KODEPROJECT=A2.NoResi

left outer join dbHPPProduksi F on  F.KodeBrg=b.KodeBrg  and F.Bulan=MONTH(A.Tanggal) and F.Tahun=YEAR(A.Tanggal)

where /*((Left(B.NoBukti,3) Like 'BCA%' or Left(B.NoBukti,3) Like 'BCB%')) and*/ a1.NoBukti Not Like '%SJB%' and B.NoBukti not like '%SPBB%' and C.NAMABRG not like '%Jasa%' and

ISNULL(A2.IsClose,0)=0

/*

select distinct	B.NOBUKTI, B.URUT, B.NoSPP NoSC, B.UrutSPP UrutSC, B.KODEBRG, case when isnull(c.IsJasa,0)=1 then b.Namabrg else C.NAMABRG  NAMABRG, '' Jns_Kertas, ''Ukr_Kertas,

        case when B.ISI>=1 Then B.QNT Else B.QNT2  Qnt, B.QNT2, case when B.ISI>=1 Then B.SAT_1 else B.SAT_2   SAT_1, 

        B.SAT_2, B.ISI, B.NetW, B.GrossW,'' KetDetail,F2.HARGA,

        (case when B.ISI>=1 Then B.QNT Else B.QNT2 +isnull(c2.QntKoreksi,0)-case when B.ISI>=1 Then Isnull(AB.QNT,0) Else Isnull(AB.Qnt2,0) )*F2.HARGA dpp,

         case when F2.PPN IN(1,2)Then ((case when B.ISI>=1 Then B.QNT Else B.QNT2 +isnull(c2.QntKoreksi,0)-case when B.ISI>=1 Then 

            Isnull(AB.QNT,0) Else Isnull(AB.Qnt2,0) )*F2.HARGA)*0.1 else 0  ppn ,

        (((case when B.ISI>=1 Then B.QNT Else B.QNT2 +isnull(c2.QntKoreksi,0)-case when B.ISI>=1 Then Isnull(AB.QNT,0) Else Isnull(AB.Qnt2,0) )*F2.HARGA)+

          (case when F2.PPN IN(1,2)Then ((case when B.ISI>=1 Then B.QNT Else B.QNT2 +isnull(c2.QntKoreksi,0)-case when B.ISI>=1 Then 

            Isnull(AB.QNT,0) Else Isnull(AB.Qnt2,0) )*F2.HARGA)*0.1 else 0 )) Total,

        case when B.ISI>=1 Then B.QNT Else B.QNT2 *(CONVERT(Numeric(18,2),Case When Isnull(F.HPPBrg,0)=0 Then C.Hrg1_2 else Isnull(F.HPPBrg,0) )) dpphpp,

        ((case when B.ISI>=1 Then B.QNT Else B.QNT2 +isnull(c2.QntKoreksi,0)-case when B.ISI>=1 Then Isnull(AB.QNT,0) Else Isnull(AB.Qnt2,0) )*F2.HARGA)-((case when B.ISI>=1 Then B.QNT Else B.QNT2 -case when B.ISI>=1 Then Isnull(AB.QNT,0) Else Isnull(AB.Qnt2,0) )*(CONVERT(Numeric(18,2),Case When Isnull(F.HPPBrg,0)=0 Then C.Hrg1_2 else F.HPPBrg ))) Laba,

        A.Tanggal,a.KodeCustSupp,--D.NAMACUSTSUPP+CHAR(13)+Isnull(Prj.NAMAPROJECT,'') NAMACUSTSUPP, 

        D.NAMACUSTSUPP NAMACUSTSUPP,Isnull(Prj.NAMAPROJECT,'') NAMAPROJECT,  

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER)NeedOtorisasi, (CONVERT(Numeric(18,2), Isnull(F.HPPBrg,0) ))HPP, C1.NoBukti NoInv,

		'' Noso,case when B.ISI>=1 Then Isnull(AB.QNT,0) Else Isnull(AB.Qnt2,0)  QntRetur,D.KODECUSTSUPP+A.NoResi CustProject

from	dbSPBDet B

left outer join dbBarang C on C.KodeBrg=B.KodeBrg

Left outer join(select NoBukti,NoSPB,KodeBrg from dbInvoicePLDet Group by NoBukti,NoSPB,KodeBrg)C1 On C1.NoSPB=b.NoBukti and C1.KodeBrg=B.KodeBrg

Left outer join(select NoBukti,NoSPB,KodeBrg,QntKoreksi,UrutSPB from dbInvoicePLDet)C2 On C2.NoSPB=b.NoBukti and C2.KodeBrg=B.KodeBrg and c2.UrutSPB=b.Urut

Left Outer join dbSPB A on B.NoBukti = A.NoBukti

LEFT Outer Join (select SUM(QNT)Qnt,SUM(QNT2)Qnt2,NOSPB,UrutSPB from DBRSPBDet Group By NOSPB,UrutSPB)AB on AB.NoSPB=B.NoBukti and AB.UrutSPB=B.Urut 

Left Outer Join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

left outer join dbSPPDet E on e.NoBukti=B.NoSPP and e.KodeBrg=b.KodeBrg and E.Urut=B.UrutSPP

left outer join DBSODET F2 on F2.NoBukti=E.NoSO and F2.KodeBrg=b.KodeBrg and F2.URUT=E.UrutSO

Left Outer Join DBPROJECT Prj on Prj.KODEPROJECT=A.NoResi

left outer join dbHPPProduksi F on  F.KodeBrg=b.KodeBrg  and F.Bulan=MONTH(A.Tanggal) and F.Tahun=YEAR(A.Tanggal)

where ((Left(B.NoBukti,3) Like 'BCA%' or Left(B.NoBukti,3) Like 'BCB%')) and B.NoBukti Not Like '%SJB%' and ISNULL(A.IsClose,0)=0

*/;

-- VwReportSPK
CREATE VIEW IF NOT EXISTS VwReportSPK AS select a.NOBUKTI,a.TANGGAL,b.KODEBRG,Brg.NAMABRG NamaBrg,c.KODEBRG KodeBrgD,BrgD.NAMABRG NamaBrgD,

b.QNT QntM,Cs.NAMACUSTSUPP,Pr.NAMAPROJECT,a.NOSO,c.QNT QntD

from dbSPK a

Left Outer Join DBSPKMDET b on a.NOBUKTI=b.NOBUKTI

Left Outer Join DBSO SO On SO.NOBUKTI=a.NOSO

Left Outer Join DBPROJECT Pr On Pr.KODEPROJECT=SO.AlamatKirim

Left Outer Join DBCUSTSUPP Cs On Cs.KODECUSTSUPP=SO.KODECUST

Left Outer Join DBBARANG Brg on Brg.KODEBRG=b.KODEBRG

Left Outer Join DBSPKDET c on c.NOBUKTI=a.NOBUKTI and c.UrutM=b.URUT

Left Outer Join DBBARANG BrgD on BrgD.KODEBRG=c.KODEBRG;

-- VwReportSPP
CREATE VIEW IF NOT EXISTS VwReportSPP AS select 	B.NOBUKTI, B.URUT, B.NoSO, B.UrutSO, B.KODEBRG, C.NAMABRG,D.Tanggal,D.KodeCustSupp,E.NAMACUSTSUPP,

        B.QNT, B.QNT2, B.SAT_1, B.SAT_2, B.ISI, B.NetW, B.GrossW, B.KetDetail,

        B.Nobukti+Cast(B.urut As Varchar(5)) MyKey,

        B.NamaBrg+Char(13)+'('+C.NamaBrg+')' NamaBrgKom,

        B.ShippingMark, Case when B.Nosat=1 then B.Sat_1 when B.nosat=2 then B.Sat_2 else ''  Satuan,

        D.NoPesan,D.TglKirim,B.Kodegdg,       

	Cast(Case when Case when D.IsOtorisasi1=1 then 1 else 0 +

    Case when D.IsOtorisasi2=1 then 1 else 0 +

    Case when D.IsOtorisasi3=1 then 1 else 0 +

    Case when D.IsOtorisasi4=1 then 1 else 0 +

    Case when D.IsOtorisasi5=1 then 1 else 0 =D.MaxOL then 0

    else 1

     As INTEGER) NeeDOtorisasi

from	dbSPPDet B

left outer join dbBarang C on C.KodeBrg=B.KodeBrg

Left Outer join dbSPP D on B.NoBukti = D.NoBukti

Left Outer join DBCUSTSUPP E on D.KodeCustSupp = E.KODECUSTSUPP;

-- VwreportSPPB
CREATE VIEW IF NOT EXISTS VwreportSPPB AS Select A.*,B.NAMABRG NamaBarang,C.Tanggal,C.kodeCustSupp,D.NAMACUSTSUPP,

           A.Nobukti+Cast(A.Urut as varchar(5)) MyKey,Z.NOBUKTI Noso,Z.TANGGAL TanggalSO

from dbSPBDet A

     left outer join DBBARANG B on B.KODEBRG=A.Kodebrg

     Left Outer join dbSPB C on A.NoBukti = C.NoBukti

     Left Outer join DBCUSTSUPP D on c.KodeCustSupp = D.KODECUSTSUPP

     Left Outer join (Select x.NoBukti, x.NoSPP

                      from dbSPBDet x

                      group by x.NoBukti, x.NoSPP) y on y.NoBukti=C.NoBukti

     Left Outer Join (Select x.NoBukti, x.Tanggal,y.NoSO, x.TglKirim

                      from DBSPP x 

                        left outer join dbSPPDet y on y.NoBukti=x.NoBukti

                      Group by x.NoBukti, x.Tanggal,y.NoSO, x.TglKirim) v On v.NoBukti=y.NoSPP 

    left outer join DBSO Z on Z.NOBUKTI=v.NoSO;

-- VwReportSppx
CREATE VIEW IF NOT EXISTS VwReportSppx AS Select  A.NoBukti+right('00000'+cast(A.Urut as varchar(5)),5) KeyNoBukti, A.Nobukti, P.Tanggal, P.KodeCustSupp, S.Namacust NamaCustSupp,

        A.urut, A.kodebrg, B.NamaBrg, '' Jns_Kertas, '' Ukr_Kertas, A.Sat_1, A.Sat_2, A.Isi,

        Case when A.NoSat=1 then A.Qnt

             when A.NoSat=2 then A.Qnt2

             else 0

         Qnt, A.Qnt2,

        Case when A.NoSat=1 then A.QntSPB

             when A.NoSat=2 then A.Qnt2SPB

             else 0

         QntSPB, A.Qnt2SPB,

        Case when A.NoSat=1 then A.QntSisa

             when A.NoSat=2 then A.Qnt2Sisa

             else 0

         QntSisa, A.Qnt2Sisa,

        Case when A.NOSAT=1 then A.SAT_1

             when A.NOSAT=2 then A.SAT_2

             else ''

         Satuan, P.Tglkirim,

        P.NoPesan

From    vwBrowsOutSPP A

Left Outer Join dbSPP P on P.NoBukti=A.NoBukti

left Outer join DBSO SO on SO.NOBUKTI=A.noso

Left Outer Join vwBrowsCustomer S on S.KodeCust=P.KodeCustSupp and s.Sales=SO.KODESLS

Left Outer Join dbBarang B on B.KodeBrg=A.KodeBrg

where A.isclose=0;

-- VwReportSpRk
CREATE VIEW IF NOT EXISTS VwReportSpRk AS Select 	A.Tanggal,B.NoBukti,A.KODEBRG KodeBrgJadi,i.NAMABRG NmBrgjadi,

	B.Urut, B.KodeBrg, H.NamaBrg, B.Qnt, B.NoSat, B.Isi Isi, B.Satuan Satuan

	 ,Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                      Case when A.IsOtorisasi2=1 then 1 else 0 +

                      Case when A.IsOtorisasi3=1 then 1 else 0 +

                      Case when A.IsOtorisasi4=1 then 1 else 0 +

                      Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                 else 1

             As INTEGER) NeedOtorisasi 

From dbSPKDet B 

Left Outer Join DbSPK A on  B.nobukti = A.nobukti

Left Outer join dbBarang H on H.KodeBrg=b.KodeBrg

Left Outer Join DBBARANG I on A.KODEBRG = I.KODEBRG;

-- vwReportStockBrg
CREATE VIEW IF NOT EXISTS vwReportStockBrg AS Select  a.BULAN, a.TAHUN, a.KODEBRG, a.KODEGDG, a.QNTAWAL, case when d.HrgSaldo Is Null Then a.HRGAWAL else d.HrgSaldo  HRGAWAL, 

	a.QNTPBL, a.QNT2PBL, a.HRGPBL, a.QNTRPB, a.QNT2RPB, a.HRGRPB, 

	a.QNTPNJ, a.QNT2PNJ, a.HRGPNJ, a.QNTRPJ, a.QNT2RPJ, a.HRGRPJ, 

	a.QNTADI, a.QNT2ADI, a.HRGADI, a.QNTADO, a.QNT2ADO, a.HRGADO, 

	a.QNTUKI, a.QNT2UKI, a.HRGUKI, a.QNTUKO, a.QNT2UKO, a.HRGUKO, 

	a.QNTTRI, a.QNT2TRI, a.HRGTRI, a.QNTTRO, a.QNT2TRO, a.HRGTRO,

	a.QNTPMK, a.QNT2PMK, a.HRGPMK, a.QNTRPK, a.QNT2RPK, a.HRGRPK,

	a.QntHPrd, a.Qnt2HPrd, a.HRGHPrd, 

	a.HRGRATA, a.QNTIN, a.QNT2IN, a.RPIN, a.QNTOUT, a.QNT2OUT, a.RPOUT, 

	a.SALDOQNT, a.SALDO2QNT, a.SALDORP-HRGAWAL+case when d.HrgSaldo Is Null Then a.HRGAWAL else d.HrgSaldo  SALDORP, a.SaldoAV, a.Saldo2AV, 

	B.QntMin,B.QntMax,

    b.NAMABRG, c.NAMA Namagdg, b.SAT1, b.Sat2,B.ISI1,B.ISI2,B.ISI3,

    b.KODEGRP,e.NAMA NamaGrp,b.KODESUBGRP,f.NamaSubGrp

from DBSTOCKBRG a

     Left outer join (select HrgSaldo,Kodebrg,Bulan,Tahun,Kodegdg from vwKartuStock where Tipe='AWL' and Bulan=1 and Tahun=2015)d on d.Kodebrg=a.KODEBRG and d.Kodegdg=a.KODEGDG and d.Bulan=a.BULAN and d.Tahun=a.TAHUN

     left outer join DBBARANG b on b.KODEBRG=a.KODEBRG --and b.Kodegdg=a.KODEGDG

     left outer join DBGUDANG c on c.KODEGDG=a.KODEGDG

     left outer join DBGROUP e on e.KODEGRP=b.KODEGRP

     left outer join dbSubGroup f on f.KodeSubGrp=b.KODESUBGRP and f.KodeGrp=b.KODEGRP and f.KodeGrp=e.KodeGrp;

-- vwReportStockBrgPCS
CREATE VIEW IF NOT EXISTS vwReportStockBrgPCS AS Select  a.BULAN, a.TAHUN, a.KODEBRG, a.KODEGDG, Case when SAT1='PCS' Then a.QNTAWAL when SAT2='PCS' Then a.QNT2AWAL else 0  QNTAWAL ,  

	Case when SAT1='PCS' Then a.QNTPBL when SAT2='PCS' Then a.QNT2PBL else 0  QNTPBL, 

	Case when SAT1='PCS' Then a.QNTRPB when SAT2='PCS' Then a.QNT2RPB else 0  QNTRPB, 

	Case when SAT1='PCS' Then a.QNTPNJ when SAT2='PCS' Then a.QNT2PNJ  QNTPNJ, 

	Case when SAT1='PCS' Then a.QNTRPJ when SAT2='PCS' Then a.QNT2RPJ  QNTRPJ, 

	Case when SAT1='PCS' Then a.QNTADI when SAT2='PCS' Then a.QNT2ADI  QNTADI, 

	Case when SAT1='PCS' Then a.QNTADO when SAT2='PCS' Then a.QNT2ADO  QNTADO,  

	Case when SAT1='PCS' Then a.QNTUKI when SAT2='PCS' Then a.QNT2UKI  QNTUKI,  

	Case when SAT1='PCS' Then a.QNTUKO when SAT2='PCS' Then a.QNT2UKO  QNTUKO,  

	Case when SAT1='PCS' Then a.QNTTRI when SAT2='PCS' Then a.QNT2TRI  QNTTRI, 

	Case when SAT1='PCS' Then a.QNTTRO when SAT2='PCS' Then a.QNT2TRO  QNTTRO, 

	Case when SAT1='PCS' Then a.QNTPMK when SAT2='PCS' Then a.QNT2PMK  QNTPMK, 

	Case when SAT1='PCS' Then a.QNTRPK when SAT2='PCS' Then a.QNT2RPK  QNTRPK, 

	Case when SAT1='PCS' Then a.QntHPrd when SAT2='PCS' Then a.Qnt2HPrd  QntHPrd, 

	Case when SAT1='PCS' Then a.QNTIN  when SAT2='PCS' Then a.QNT2IN  QNTIN, 

	Case when SAT1='PCS' Then a.QNTOUT when SAT2='PCS' Then a.QNT2OUT  QNTOUT, 

	Case when SAT1='PCS' Then a.SALDOQNT when SAT2='PCS' Then a.SALDO2QNT  SALDOQNT,

    b.NAMABRG, c.NAMA Namagdg, b.SAT1, b.Sat2,B.ISI1,B.ISI2,B.ISI3,

    b.KODEGRP,e.NAMA NamaGrp,b.KODESUBGRP,f.NamaSubGrp

from DBSTOCKBRG a

     --Left outer join (select HrgSaldo,Kodebrg,Bulan,Tahun,Kodegdg from vwKartuStock where Tipe='AWL' and Bulan=1 and Tahun=2015)d on d.Kodebrg=a.KODEBRG and d.Kodegdg=a.KODEGDG and d.Bulan=a.BULAN and d.Tahun=a.TAHUN

     left outer join DBBARANG b on b.KODEBRG=a.KODEBRG 

     left outer join DBGUDANG c on c.KODEGDG=a.KODEGDG

     left outer join DBGROUP e on e.KODEGRP=b.KODEGRP

     left outer join dbSubGroup f on f.KodeSubGrp=b.KODESUBGRP and f.KodeGrp=b.KODEGRP and f.KodeGrp=e.KodeGrp

     where b.KodeGrp='FG'

     and (SAT1='PCS' or SAT2='PCS');

-- VwReporttransfer
CREATE VIEW IF NOT EXISTS VwReporttransfer AS /*Select A.nobukti, a.NoUrut, a.Tanggal,  A.Note Keterangan, A.NoPenyerahan,

	 B.URUT,  B.KODEBRG, C.NAMABRG, '' Jns_Kertas, '' Ukr_Kertas,

    B.QNT, B.QNT2, B.SAT_1, B.SAT_2, B.ISI, B.GdgAsal, B.GdgTujuan, D.Nama+' ('+B.gdgAsal+')' NamagdgAsal,

    E.Nama+' ('+B.GdgTujuan+')' NamagdgTujuan,

    A.IsOtorisasi1, A.OtoUser1, A.TglOto1, A.IsOtorisasi2, A.OtoUser2, A.TglOto2,

	A.IsOtorisasi3, A.OtoUser3, A.TglOto3, A.IsOtorisasi4, A.OtoUser4, A.TglOto4,

	A.IsOtorisasi5, A.OtoUser5, A.TglOto5,

        Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                       Case when A.IsOtorisasi2=1 then 1 else 0 +

                       Case when A.IsOtorisasi3=1 then 1 else 0 +

                       Case when A.IsOtorisasi4=1 then 1 else 0 +

                       Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                  else 1

              As INTEGER) NeedOtorisasi,C.KODEGRP,C.KODESUBGRP,

             C1.NAMA NamaGrp,C2.NamaSubGrp

from dbTransfer a

Left Outer JOin DBTRANSFERDET B on A.NOBUKTI=B.NOBUKTI

left outer join dbBarang C on C.KodeBrg=B.KodeBrg

left Outer join DBGROUP C1 On C1.KODEGRP=C.KODEGRP

Left Outer Join dbSubGroup C2 On C2.KodeGrp=C.KODEGRP and C2.KodeSubGrp=C.KODESUBGRP

left outer join dbGudang D on d.Kodegdg=B.GdgAsal

left outer join dbgudang E on E.kodegdg=B.GdgTujuan*/

Select A.nobukti, a.NoUrut, a.Tanggal,  A.Note Keterangan, A.NoPenyerahan,

	 B.URUT,  B.KODEBRG, C.NAMABRG, '' Jns_Kertas, '' Ukr_Kertas,

    Case When B.NOSAT=1 Then B.QNT else B.QNT2  QNT,B.QNT QNT1, B.QNT2, Case When B.NOSAT=1 Then B.SAT_1 else B.SAT_2  SAT_1,B.SAT_1 SAT11, B.SAT_2, B.ISI, B.GdgAsal, B.GdgTujuan, D.Nama+' ('+B.gdgAsal+')' NamagdgAsal,

    E.Nama+' ('+B.GdgTujuan+')' NamagdgTujuan,

    A.IsOtorisasi1, A.OtoUser1, A.TglOto1, A.IsOtorisasi2, A.OtoUser2, A.TglOto2,

	A.IsOtorisasi3, A.OtoUser3, A.TglOto3, A.IsOtorisasi4, A.OtoUser4, A.TglOto4,

	A.IsOtorisasi5, A.OtoUser5, A.TglOto5,

        Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                       Case when A.IsOtorisasi2=1 then 1 else 0 +

                       Case when A.IsOtorisasi3=1 then 1 else 0 +

                       Case when A.IsOtorisasi4=1 then 1 else 0 +

                       Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                  else 1

              As INTEGER) NeedOtorisasi,C.KODEGRP,C.KODESUBGRP,

             C1.NAMA NamaGrp,C2.NamaSubGrp,Supp.NAMACUSTSUPP,a.Nopol,a.Sopir,a.Devisi

from dbTransfer a

Left Outer JOin DBTRANSFERDET B on A.NOBUKTI=B.NOBUKTI

left outer join dbBarang C on C.KodeBrg=B.KodeBrg

left Outer join DBGROUP C1 On C1.KODEGRP=C.KODEGRP

Left Outer Join dbSubGroup C2 On C2.KodeGrp=C.KODEGRP and C2.KodeSubGrp=C.KODESUBGRP

Left Outer Join DBCUSTSUPP Supp On Supp.KODECUSTSUPP=a.NoPenyerahan

left outer join dbGudang D on d.Kodegdg=B.GdgAsal

left outer join dbgudang E on E.kodegdg=B.GdgTujuan


--select * from VwReporttransfer;

-- VWREPORTUAS
CREATE VIEW IF NOT EXISTS VWREPORTUAS AS SELECT A.NOBUKTI,A.URUT,A.BIAYA,A.TARIF,A.QNT,A.TOTAL,B.TANGGAL,B.KODEKEND,B.SUPIR,

B.RUTE,B.Ket1,B.Ket2,D.NAMARUTE,e.NAMAPROJECT,c.NAMAKEND,f.NAMAJENISKEND,SPB.NoBukti NoSJ

FROM DBRUTETRANSDET A

LEFT OUTER JOIN DBRUTETRANS B ON A.NOBUKTI=B.NOBUKTI

LEFT OUTER JOIN  DBKENDARAAN C ON B.KODEKEND=C.KODEKEND

LEFT OUTER JOIN DBRUTE D ON B.RUTE=D.KODERUTE

left outer join DBPROJECT E on e.KODEPROJECT=b.Ket1

left outer join DBJENISKEND F on f.KODEJENISKEND=c.KODEJENISKEND

Left Outer join dbSPB SPB on SPB.NoTarif=A.NOBUKTI;

-- VwReportUbahKemasanBahan
CREATE VIEW IF NOT EXISTS VwReportUbahKemasanBahan AS Select * from vwDetailUbahKemasan where NoBukti Like '%KMBJ%';

-- vwRepPO
CREATE VIEW IF NOT EXISTS vwRepPO AS Select 	A.NOBUKTI, A.Tanggal, A.TglJatuhTempo, A.KodeCustSupp, C.NamaCustSupp, A.KodeVls, A.Kurs, 

	B.Urut, B.KODEBRG, D.NAMABRG, case when B.NoSat=1 then B.Qnt else B.Qnt2  Qnt,

	case when B.NoSat=1 then D.SAT1 else D.Sat2  Satuan, 

	B.HRGNETTO Harga, B.SUBTOTAL, B.NDPP, B.NPPN , B.NNET,

	E.SyaratPembayaran, E.SyaratPengiriman,

	A.Tipe, F.QntSisa, F.Qnt2Sisa, F.QntBeli, F.Qnt2Beli 

From 	DBPO A

Left Outer Join DBPODET B on B.NOBUKTI=A.NOBUKTI

Left Outer Join DBCUSTSUPP C on C.KODECUSTSUPP=A.KODECUSTSUPP 

Left Outer Join DBBARANG D on D.KODEBRG=B.KODEBRG

Left Outer Join DBNOTEPO E on E.NOBUKTI=A.NOBUKTI 

left Outer join vwOutPO F on F.Nobukti=B.NOBUKTI and F.urut=B.URUT;

-- vwRpDetBeli
CREATE VIEW IF NOT EXISTS vwRpDetBeli AS Select 	NoBukti, Sum(SubTotal) TotSubTotal, Sum(NDiskon) TotDiskon, Sum(SubTotal)-Sum(NDiskon) TotTotal,

	Sum(NDPP) TotDPP, Sum(NPPN) TotPPN, SUm(NNet) TotNet, Sum(SubTotalRp) TotSubTotalRp, Sum(NDiskon*Kurs) TotDiskonRp,

	Sum(SubTotalRp)-Sum(NDiskon*Kurs) TotTotalRp, Sum(NDPPRp) TotDPPRp, Sum(NPPNRp) TotPPNRp, Sum(NNETRp) TotNetRp

From 	dbBeliDet

Group By NoBukti;

-- vwRpDetInvoicePL
CREATE VIEW IF NOT EXISTS vwRpDetInvoicePL AS Select 	NoBukti, Sum(SubTotal) TotSubTotal, Sum(NDiskon) TotDiskon, Sum(SubTotal)-Sum(NDiskon) TotTotal,

	Sum(Case When FRetensi<>0 then NDPPRRp else NDPP ) TotDPP, Sum(Case When FRetensi<>0 then NPPNRRp else NPPN ) TotPPN, SUm(Case When FRetensi<>0 then NNETRRp else NNet ) TotNet, Sum(SubTotalRp) TotSubTotalRp, Sum(NDiskon*Kurs) TotDiskonRp,

	Sum(SubTotalRp)-Sum(NDiskon*Kurs) TotTotalRp, Sum(Case When FRetensi<>0 then NDPPRRp else NDPPRp  ) TotDPPRp, Sum(Case When FRetensi<>0 then NPPNRRp else NPPNRp ) TotPPNRp, Sum(Case When FRetensi<>0 then NNETRRp else NNETRp ) TotNetRp,SUM(NPPH)TotPPH

From 	dbInvoicePLDet

Group By NoBukti;

-- vwRpDetInvoiceRPJ
CREATE VIEW IF NOT EXISTS vwRpDetInvoiceRPJ AS Select 	NoBukti, Sum(SubTotal) TotSubTotal, Sum(NDiskon) TotDiskon, Sum(SubTotal)-Sum(NDiskon) TotTotal,

	Sum(NDPP) TotDPP, Sum(NPPN) TotPPN, SUm(NNet) TotNet, Sum(SubTotalRp) TotSubTotalRp, Sum(NDiskon*Kurs) TotDiskonRp,

	Sum(SubTotalRp)-Sum(NDiskon*Kurs) TotTotalRp, Sum(NDPPRp) TotDPPRp, Sum(NPPNRp) TotPPNRp, Sum(NNETRp) TotNetRp

From 	DBINVOICERPJDet

Group By NoBukti;

-- vwRpDetPNW
CREATE VIEW IF NOT EXISTS vwRpDetPNW AS Select 	NoBukti, Sum(SubTotal) TotSubTotal, Sum(NDiskon) TotDiskon, Sum(SubTotal)-Sum(NDiskon) TotTotal,

	Sum(NDPP) TotDPP, Sum(NPPN) TotPPN, SUm(NNet) TotNet, Sum(SubTotalRp) TotSubTotalRp, Sum(NDiskon*Kurs) TotDiskonRp,

	Sum(SubTotalRp)-Sum(NDiskon*Kurs) TotTotalRp, Sum(NDPPRp) TotDPPRp, Sum(NPPNRp) TotPPNRp, Sum(NNETRp) TotNetRp,

	SUM(Qnt) Qnt, SUM(Qnt2) Qnt2,SUM(Npph)TotPPH

From 	dbPNWDet

Group By NoBukti;

-- vwRpDetPO
CREATE VIEW IF NOT EXISTS vwRpDetPO AS Select 	NoBukti, Sum(Brutto) TotBrutto,Sum(SubTotal) TotSubTotal, Sum(NDISKONTOT) TotDiskon, Sum(SubTotal)-Sum(NDiskon) TotTotal,

	Sum(NDPP) TotDPP, Sum(NPPN) TotPPN, SUm(NNet) TotNet, Sum(SubTotalRp) TotSubTotalRp, Sum(NDISKONTOT*Kurs) TotDiskonRp,

	Sum(SubTotalRp)-Sum(NDISKONTOT*Kurs) TotTotalRp, Sum(NDPPRp) TotDPPRp, Sum(NPPNRp) TotPPNRp, Sum(NNETRp) TotNetRp

From 	dbo.dbPODet

Group By NoBukti;

-- vwRpDetRBeli
CREATE VIEW IF NOT EXISTS vwRpDetRBeli AS Select 	NoBukti, Sum(SubTotal) TotSubTotal, Sum(NDiskon) TotDiskon, Sum(SubTotal)-Sum(NDiskon) TotTotal,

	Sum(NDPP) TotDPP, Sum(NPPN) TotPPN, SUm(NNet) TotNet, Sum(SubTotalRp) TotSubTotalRp, Sum(NDiskon*Kurs) TotDiskonRp,

	Sum(SubTotalRp)-Sum(NDiskon*Kurs) TotTotalRp, Sum(NDPPRp) TotDPPRp, Sum(NPPNRp) TotPPNRp, Sum(NNETRp) TotNetRp

From 	dbRBeliDet

Group By NoBukti;

-- vwRpDetRevPO
CREATE VIEW IF NOT EXISTS vwRpDetRevPO AS Select 	NoBukti, Sum(Brutto) TotBrutto,Sum(SubTotal) TotSubTotal, Sum(NDISKONTOT) TotDiskon, Sum(SubTotal)-Sum(NDiskon) TotTotal,

	Sum(NDPP) TotDPP, Sum(NPPN) TotPPN, SUm(NNet) TotNet, Sum(SubTotalRp) TotSubTotalRp, Sum(NDISKONTOT*Kurs) TotDiskonRp,

	Sum(SubTotalRp)-Sum(NDISKONTOT*Kurs) TotTotalRp, Sum(NDPPRp) TotDPPRp, Sum(NPPNRp) TotPPNRp, Sum(NNETRp) TotNetRp

From 	dbo.dbRevPODet

Group By NoBukti;

-- vwRpDetRInvoicePL
CREATE VIEW IF NOT EXISTS vwRpDetRInvoicePL AS SELECT     NOBUKTI, SUM(SUBTOTAL) AS TotSubTotal, SUM(NDISKON) AS TotDiskon, SUM(SUBTOTAL) - SUM(NDISKON) AS TotTotal, SUM(Case When FRetensi<>0 then NDPPRRp else NDPP ) AS TotDPP, SUM(Case When FRetensi<>0 then NPPNRRp else NPPN ) 

                      AS TotPPN, SUM(Case When FRetensi<>0 then NNETRRp else NNET ) AS TotNet, SUM(SUBTOTALRp) AS TotSubTotalRp, SUM(NDISKON * KURS) AS TotDiskonRp, SUM(SUBTOTALRp) - SUM(NDISKON * KURS) 

                      AS TotTotalRp, SUM(Case When FRetensi<>0 then NDPPRRp else NDPPRp ) AS TotDPPRp, SUM(Case When FRetensi<>0 then NPPNRRp else NPPNRp ) AS TotPPNRp, SUM(Case When FRetensi<>0 then NNETRRp else NNETRp ) AS TotNetRp

FROM         dbo.DBRInvoicePLDET

GROUP BY NOBUKTI;

-- vwRpDetSO
CREATE VIEW IF NOT EXISTS vwRpDetSO AS Select 	NoBukti, Sum(case when Isnull(KodeBrgM,'')='' Then SubTotal else 0 ) TotSubTotal, Sum(NDiskon) TotDiskon, Sum(SubTotal)-Sum(NDiskon) TotTotal,

	Sum(NDPP) TotDPP, Sum(NPPN) TotPPN, SUm(NNet) TotNet, Sum(SubTotalRp) TotSubTotalRp, Sum(NDiskon*Kurs) TotDiskonRp,

	Sum(SubTotalRp)-Sum(NDiskon*Kurs) TotTotalRp, Sum(NDPPRp) TotDPPRp, Sum(NPPNRp) TotPPNRp, Sum(NNETRp) TotNetRp,

	SUM(Qnt) Qnt, SUM(Qnt2) Qnt2,SUM(Npph)TotPPH

From 	dbSODet

Group By NoBukti;

-- vwRPemakaianBrg
CREATE VIEW IF NOT EXISTS vwRPemakaianBrg AS SELECT a.Nobukti,b.Tanggal, a.kodebrg,c.NAMABRG,b.Kodebag,d.NamaBag,c.KodeJnsBrg,b.KodeJnsPakai,

e.Keterangan,a.Hpp,a.NNet,

Case when b.JnsPakai=0 then 'Stock'

	  when b.JnsPakai=1 then 'Investasi'

	  when b.JnsPakai=2 then 'Rep & Pem Teknik'

	  when b.JnsPakai=3 then 'Rep & Pem Komputer'

	  when b.JnsPakai=4 then 'Rep & Pem Peralatan'

 MyJnsPakai,b.JnsPakai

,case when a.Nosat = 1 then a.Sat_1 else a.Sat_2  as satuan,

case when a.Nosat = 1 then a.Qnt else a.Qnt2  as QNT,

case when a.Nosat = 1 then a.Qnt * a.Hpp else a.Qnt2 * a.Hpp  as total

FROM DBRPenyerahanBrgDET a 

left outer join DBRPenyerahanBrg b on a.Nobukti = b.Nobukti

left outer join DBBARANG c on a.kodebrg = c.KODEBRG

left outer join DBBAGIAN d on b.Kodebag = d.KodeBag

left outer join DBJNSPAKAI e on b.KodeJnsPakai = e.KodeJNSPakai;

-- vwRpenerimaanbrg
CREATE VIEW IF NOT EXISTS vwRpenerimaanbrg AS select  a.NOBUKTI,b.TANGGAL,b.KODECUSTSUPP, d.NAMACUSTSUPP,a.KODEBRG,c.NAMABRG,a.Nosat,a.QNT,a.QNT2,a.SAT_1,a.SAT_2,f.NOPPL,c.ISJASA,c.KodeJnsBrg,

        isnull(z.tipe,0) Tipe,

        case when a.nosat =1 then a.sat_1 else a.sat_2  as satuan,a.nnet,a.PPN,

        case when a.Nosat = 1 then a.QNT else a.QNT2  as quantity,a.harga,b.KODEVLS,b.KURS,

        case when a.Nosat = 1 then a.QNT *  a.HARGA else a.QNT2 * a.HARGA  as jumlah,

        case when a.Nosat =1 then (a.QNT * a.HARGA) * a.KURS else (a.QNT2 * a.HARGA) * a.KURS  as NilaiDPp,a.NPPN,

        case when a.Nosat =1 then ((a.QNT * a.HARGA) * a.KURS) + a.nppn else ((a.QNT2 * a.HARGA) * a.KURS) + a.PPN  as total

from DBRBELIDET a 

     left outer join DBRBELI b on a.NOBUKTI = b.NOBUKTI

     left outer join DBBARANG c on a.KODEBRG = c.KODEBRG

     left outer join vwBrowsSupp d on b.KODECUSTSUPP = d.KODECUSTSUPP

     left outer join dbpo z on z.NOBUKTI=a.NOPO

     LEFT OUTER JOIN (select NoPPL, NOBUKTI NOPO, URUT URutPO

                      from DBPODET 

                      GRoup by NoPPL, NOBUKTI, URUT) f on f.NOPO=a.NOPO and f.URutPO=a.URUTPO;

-- VWSatkecil
CREATE VIEW IF NOT EXISTS VWSatkecil AS select Case When ISI2>1 Then SAT1 else SAT2  SAT,Kodebrg from DBBARANG;

-- vwSatuanBrg
CREATE VIEW IF NOT EXISTS vwSatuanBrg AS select A.KODEBRG, A.NAMABRG ,A.SAT1, A.ISI1,A.Sat2,A.Isi2,A.KODEGRP, E.NAMA NamaGrp,ISNULL(A.ISJasa,0)IsJasa,A.KODESUBGRP,F.NamaSubGrp,

A.Hrg1_2 HPPBrg

from dbBarang A

     left outer join DBGROUP E on E.KODEGRP=A.KODEGRP

     Left outer join dbSubGroup F on F.KodeGrp=A.KODEGRP and F.KodeSubGrp=A.KODESUBGRP;

-- vwSOBelumLengkap
CREATE VIEW IF NOT EXISTS vwSOBelumLengkap AS select distinct A.NoBukti

from dbSODet A

left outer join DBSPPDET C on C.NOSO=A.NOBukti and C.UrutSO=A.Urut

group by A.NoBukti, A.Urut, A.Qnt, A.Qnt2

having	A.Qnt-sum(isnull(C.Qnt,0))>0 or A.Qnt2-sum(isnull(C.Qnt2,0))>0;

-- vwSOBelumSuratJln
CREATE VIEW IF NOT EXISTS vwSOBelumSuratJln AS select 	B.Kota KodeKota, B.kota NamaKota, A.NoBukti, A.Tanggal, A.KodeCust, B.NamaCustsupp, A.NoAlamatKirim, F.Alamat AlamatKirim,

	A.Catatan, A.KodeGdg, A.INSGdg, A.INSBrg, Cast(0 as INTEGER)IsPPN,a.Jam, A.FlagTipe, a.IsLengkap

from 	dbSO A

left outer join dbCustsupp B on B.KodeCustsupp=A.KodeCust

left outer join (select distinct NOSO from DBSPPDET) D on D.NOSO=A.NOBUKTI

left outer join vwSOBelumLengkap E on E.NoBukti=A.NOBUKTI

left outer join vwAlamatCust F on F.KodeCustSupp=A.KodeCust and F.Nomor=A.NoAlamatKirim

--where 	D.NoBukti is null or isnull(E.NOBUKTI,'')<>''

where 	A.NoUrut<>'BONUS' and (D.NoSO is null or isnull(E.NOBUKTI,'')<>'') and

      Masaberlaku>=GETDATE()

group by  B.Kota, A.NoBukti, A.Tanggal, A.KodeCust, B.NamaCustsupp, A.NoAlamatKirim, 

         F.Alamat, A.Catatan, A.KodeGdg, A.INSGdg, A.INSBrg,a.Jam, A.FlagTipe, A.IsLengkap;

-- vwSOBelumSuratJlnDet
CREATE VIEW IF NOT EXISTS vwSOBelumSuratJlnDet AS select 	C0.Kota KodeKota, C0.Kota NamaKota, A0.KodeGdg, A.NoBukti, A0.Tanggal, A.Urut, A.KODEBRG, D.NamaBrg, 

	A.QNT, A.QNT2, A.NOSAT, D.Sat1 Satuan, A.ISI, D.Sat2 SatuanRoll, 

	(isnull(C.Qnt,0)) QntSJ, (isnull(C.Qnt2,0)) Qnt2SJ, A.IsCetakKitir,Ky.Nama NamaSls

from dbSODet A

left outer join dbSO A0 on A0.NoBukti=A.NoBukti

Left outer Join dbKaryawan Ky on Ky.KeyNIK=A0.KODESLS

left outer join dbCustSupp C0 on C0.KodeCustsupp=A0.KodeCust

left outer join (Select x.noso,x.urutso,sum(x.Qnt) qnt,Sum(x.Qnt2) qnt2

                 from dbSPPDet x

                 group by x.noso,x.urutso) C on C.NOSO=A.NoBukti and C.UrutSO=A.Urut

left outer join vwSatuanBrg D on D.KodeBrg=A.KodeBrg

where (not ((A.Qnt2<>0 and (A.Qnt2<=(isnull(C.Qnt2,0)))) or (A.Qnt2=0 and (A.Qnt<=(isnull(C.Qnt,0))))));

-- vwSPB
CREATE VIEW IF NOT EXISTS vwSPB AS Select x.NoBukti NoSPB, x.Tanggal TglSPB, y.NoSPP, y.TglSPP, '' Noship, null TglShip, Case When x.NoBukti Like '%SJBI/%' Then 'SJBI' else w.NoSC  NoSC, w.TglSC,0 IsLokal,

       x.KodeCustSupp,w.NAMAPROJECT

from (Select x.NoBukti,y.Tanggal, x.NoSPP, y.KodeCustSupp

      From DBSPBDet x           

           left Outer join DBSPB y on y.NoBukti=x.NoBukti

      Group by x.NoBukti,y.Tanggal, x.NoSPP, y.KodeCustSupp) x 

     

     left Outer Join (Select x.NoBukti NoSPP, y.Tanggal TglSPP, x.NoSO

                     from DBSPPDet x

                          left outer join DBSPP y on y.NoBukti=x.NoBukti

                     Group by x.NoBukti,y.Tanggal, x.NoSO) y on y.NoSPP=x.NoSPP

    left Outer join (Select x.Nobukti NoSC, y.Tanggal TglSC,P.NAMAPROJECT

                     From DBSODET x

                          left Outer join (select * from DBSO) y on y.Nobukti=x.Nobukti

                          Left Outer Join DBPROJECT P on P.KODEPROJECT=y.AlamatKirim

                     Group by x.Nobukti,y.Tanggal,P.NAMAPROJECT) w on w.NoSC=y.NoSO;

-- vwStock
CREATE VIEW IF NOT EXISTS vwStock AS SELECT 'AWL' AS tipe, '00' Prioritas, b.Kodebrg, b.Kodegdg, 

       (b.qntAwal) AS QntDB, (b.Qnt2Awal) Qnt2DB, (b.HrgAwal) HrgDebet, 

       0.00 QntCr,  0.00 Qnt2Cr, 0.00 HrgKredit,

       (b.qntAwal) AS QntSaldo, (b.Qnt2Awal) Qnt2Saldo, (b.HrgAwal) HrgSaldo, 

       Dateadd(MM, 0, Cast(CASE WHEN b.Bulan < 10 THEN '0' ELSE ''  + Cast(b.Bulan AS varchar(2))+'-01-'+ 

                           Cast(b.Tahun AS varchar(4)) AS Datetime)) Tanggal, b.Bulan, b.Tahun, 'Saldo Awal' Nobukti,

      '' KodeCustSupp, '' Keterangan, '' IDUSER, B.HRGRATA, '' Ket, 'BHN' xCode

FROM  DBSTOCKBRG b

where b.QNTAWAL<>0 or b.QNT2AWAL<>0

UNION all

Select 	'BP' Tipe, '01' Prioritas, B.KodeBrg, B.kodegdg,

          Case when B.NOSAT=1 then  B.Qnt 

               when B.NOSAT=2 then  B.Qnt*B.ISI

               else 0

            QntDb, 

          Case when B.NOSAT=1 then  B.Qnt/B.ISI 

               when B.NOSAT=2 then  B.Qnt

               else 0

           Qnt2Db, B.NDPPRp HrgDebet,

	0.00 QntCr, 0.00 Qnt2Cr, 0.00 HrgKredit,

	Case when B.NOSAT=1 then  B.Qnt 

               when B.NOSAT=2 then  B.Qnt*B.ISI

               else 0

            QntSaldo, 

          Case when B.NOSAT=1 then  B.Qnt/B.ISI 

               when B.NOSAT=2 then  B.Qnt

               else 0

           Qnt2Saldo, B.NDPPRp HrgSaldo,

	A.TANGGAL , month(A.TANGGAL) Bulan, year(A.TANGGAL) Tahun, A.NoBukti,

	A.KODESUPP, d.NAMACUSTSUPP Keterangan, '' IDUser,

	case when Case when B.Nosat=1 then B.QNT 

	               when B.Nosat=2 then B.QNT/B.ISI

	          =0 then 0.00 

	    else B.NDPPRp/Case when B.Nosat=1 then B.QNT 

	                       when B.Nosat=2 then B.QNT*B.ISI

	                    HPP,d.NAMACUSTSUPP ket, 'BHN' xCode

from 	dbBeli A

left outer join dbBeliDet B on B.NoBukti=A.NoBukti

left outer join DBBARANG C on C.KODEBRG=B.KodeBrg

left outer join vwBrowsSupp d on d.KODECUSTSUPP=A.KODESUPP

union all

Select 	'RPB' Tipe, '10' Prioritas, B.KodeBrg, A.KODEGDG,

          0.00 QntDb, 0.00 Qnt2Db, 0.00 HrgDebet,

	Case when B.NOSAT=1 then  B.Qnt 

               when B.NOSAT=2 then  B.Qnt*B.ISI

               else 0

           QntCr, 

          Case when B.NOSAT=1 then  B.Qnt/B.ISI 

               when B.NOSAT=2 then  B.Qnt

               else 0

           Qnt2Cr, B.NDPPRp HrgKredit,

	-Case when B.NOSAT=1 then  B.Qnt 

               when B.NOSAT=2 then  B.Qnt*B.ISI

               else 0

           QntSaldo, 

          -Case when B.NOSAT=1 then  B.Qnt/B.ISI 

               when B.NOSAT=2 then  B.Qnt

               else 0

           Qnt2Saldo, -B.NDPPRp HrgSaldo,

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti,

	A.KodeSupp, d.NAMACUSTSUPP Keterangan, '' IDUser,

	case when Case when B.Nosat=1 then B.QNT 

	               when B.Nosat=2 then B.QNT/B.ISI

	          =0 then 0.00 

	    else B.NDPPRp/Case when B.Nosat=1 then B.QNT 

	                       when B.Nosat=2 then B.QNT*B.ISI 

	                    HPP,d.NAMACUSTSUPP Ket, 'BHN' xCode

from 	dbRBeli A

left outer join dbRBeliDet B on B.NoBukti=A.NoBukti

left outer join DBBARANG C on C.KODEBRG=B.KodeBrg

left outer join vwBrowsSupp d on a.KODESUPP = d.KODECUSTSUPP

union all

Select 	'BPPB' Tipe, '00' Prioritas, B.KodeBrg, A.KodeGdg, 

          0.00 QntDb, 0.00 Qnt2Db, (B.Qnt*B.HPP) HrgDebet,

	B.Qnt  QntCr, B.Qnt2 Qnt2Cr, (B.Qnt*B.HPP) HrgKredit,

	-B.Qnt QntSaldo, -B.Qnt2 Qnt2Saldo, -(B.Qnt*B.HPP) HrgSaldo,

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti,

	'' KodeCustSupp, '' Keterangan, '' IDUser,

	B.HPP,'' Ket, 'BHN' xCode

from DBBPPBT A

left outer join DBBPPBTDET B on B.NoBukti=A.NoBukti

union all

Select 	'BPPBT' Tipe, '00' Prioritas, B.KodeBrg, A.KodeGdgT, 

          B.Qnt QntDb, B.Qnt2 Qnt2Db,(B.Qnt*B.HPP) HrgDebet,

	0.00 QntCr, 0.00 Qnt2Cr, 0.00 HrgKredit,

	B.Qnt QntSaldo, B.Qnt2 Qnt2Saldo, (B.Qnt*B.HPP) HrgSaldo,

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti,

	'' KodeCustSupp, '' Keterangan, '' IDUser,

	B.HPP,'' Ket, 'BHN' xCode

from DBBPPBT A

left outer join DBBPPBTDET B on B.NoBukti=A.NoBukti

union all

Select 'BPB' Tipe, '02' Prioritas, B.KodeBrg, A.KODEGDG, 

       0.00 QntDb, 0.00 Qnt2Db,0 HrgDebet,

       B.Qnt QntCr, B.Qnt2 Qnt2Cr, (B.Qnt*B.HPP) HrgKredit,

       -B.Qnt QntSaldo, -B.Qnt2 Qnt2Saldo, -(B.Qnt*B.HPP) HrgSaldo,

       A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti,

       '' KodeCustSupp, '' Keterangan,'' IDUser,

       B.HPP,'' Ket, 'BHN' xCode

from DBPenyerahanBhn A

left outer join DBPenyerahanBhnDET B on B.NoBukti=A.NoBukti

left Outer join DBBARANG E on E.KODEBRG=B.kodebrg

union all

Select 	'RBPB' Tipe, '02' Prioritas, B.KodeBrg,A.KODEGDG,

          B.Qnt QntDb, B.Qnt2 Qnt2Db,(B.Qnt*B.HPP) HrgDebet,

	0.00 QntCr, 0.00 Qnt2Cr, 0.00 HrgKredit,

	B.Qnt QntSaldo, B.Qnt2 Qnt2Saldo, (B.Qnt*B.HPP) HrgSaldo,

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti,

	'' KodeCustSupp, '' Keterangan, '' IDUser,

          B.HPP,'' Ket, 'BHN' xCode

from DBRPenyerahanBhn A

left outer join DBRPenyerahanBhnDET B on B.NoBukti=A.NoBukti

left Outer join DBBARANG E on E.KODEBRG=B.kodebrg

union all

Select 	'ADI' Tipe, '03' Prioritas, B.KodeBrg, A.kodegdg,

          Case when B.NOSAT=1 then  B.QNTDB 

               when B.NOSAT=2 then  B.QNTDB*B.ISI

               else 0

           QntDb, 

          Case when B.NOSAT=1 then  B.QNTDB/B.ISI 

               when B.NOSAT=2 then  B.QNTDB

               else 0

           Qnt2Db, 

          Case when B.NOSAT=1 then  B.QNTDB 

               when B.NOSAT=2 then  B.QNTDB*B.ISI

               else 0

          *B.Harga HrgDebet,

	0.00 QntCr, 0.00 Qnt2Cr, 0.00 HrgKredit,

	Case when B.NOSAT=1 then  B.QNTDB 

               when B.NOSAT=2 then  B.QNTDB*B.ISI

               else 0

           QntSaldo, 

          Case when B.NOSAT=1 then  B.QNTDB/B.ISI 

               when B.NOSAT=2 then  B.QNTDB

               else 0

           Qnt2Saldo, 

          Case when B.NOSAT=1 then  B.QNTDB 

               when B.NOSAT=2 then  B.QNTDB*B.ISI

               else 0

          *B.Harga HrgSaldo, 

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti,

	'' KodeCustSupp, '' Keterangan, '' IDUser,

	B.Harga HPP,'' Ket, 'BHN' xCode

from 	dbKoreksi A

left outer join dbKoreksiDet B on B.NoBukti=A.NoBukti

where 	B.QntDb<>0

union all

Select 	'ADO' Tipe, '11' Prioritas, B.KodeBrg,A.KodeGdg, 

          0.00 QntDb, 0.00 Qnt2Db, 0.00 HrgDebet,

	Case when B.NOSAT=1 then  B.QNTCR 

               when B.NOSAT=2 then  B.QNTCR*B.ISI

               else 0

           QntCr, 

          Case when B.NOSAT=1 then  B.QNTCR/B.ISI 

               when B.NOSAT=2 then  B.QNTCR

               else 0

           Qnt2Cr, B.QntCr*B.HPP HrgKredit,

	-Case when B.NOSAT=1 then  B.QNTCR 

               when B.NOSAT=2 then  B.QNTCR*B.ISI

               else 0

           QntSaldo, 

          -Case when B.NOSAT=1 then  B.QNTCR/B.ISI 

               when B.NOSAT=2 then  B.QNTCR

               else 0

           Qnt2Saldo,          

          -Case when B.NOSAT=1 then  B.QNTCR/B.ISI 

               when B.NOSAT=2 then  B.QNTCR

               else 0

          *B.HPP HrgSaldo, 

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti,

	'' KodeCustSupp, '' Keterangan, '' IDUser,

	B.HPP,'' Ket, 'BHN' xCode

from 	dbKoreksi A

left outer join dbKoreksiDet B on B.NoBukti=A.NoBukti

where 	B.QntCr<>0

union ALL

Select 	'PRD' Tipe, '03' Prioritas, B.KodeBrg, B.kodegdg,

          Case when B.NOSAT=1 then  B.QNT 

               when B.NOSAT=2 then  B.QNT*B.ISI

               else 0

           QntDb, 

          Case when B.NOSAT=1 then  B.QNT/B.ISI 

               when B.NOSAT=2 then  B.QNT

               else 0

           Qnt2Db, 

          Case when B.NOSAT=1 then  B.QNT/B.ISI  

               when B.NOSAT=2 then  B.QNT

               else 0

          *isnull(c.HPPBrg,0) HrgDebet,

	0.00 QntCr, 0.00 Qnt2Cr, 0.00 HrgKredit,

	Case when B.NOSAT=1 then  B.QNT 

               when B.NOSAT=2 then  B.QNT*B.ISI

               else 0

           QntSaldo, 

          Case when B.NOSAT=1 then  B.QNT/B.ISI 

               when B.NOSAT=2 then  B.QNT

               else 0

           Qnt2Saldo, 

          Case when B.NOSAT=1 then  B.QNT/B.ISI  

               when B.NOSAT=2 then  B.QNT

               else 0

          *isnull(C.HPPBrg,0) HrgSaldo, 

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti,

	'' KodeCustSupp, '' Keterangan, '' IDUser,

	isnull(c.HPPBrg,0) HPP,'' Ket, 'BHN' xCode

from 	DBHASILPRD A

left outer join DBHASILPRDDET B on B.NoBukti=A.NoBukti

left Outer join dbHPPProduksi C on C.KodeBrg=B.KODEBRG and C.Bulan=month(A.Tanggal) and c.Tahun=year(A.Tanggal)

where 	B.Qnt<>0

union All

Select 	'TRI' Tipe, '05' Prioritas, B.KodeBrg, B.GDGTUJUAN,

		B.QNT QNTDB, B.QNT2 QNT2DB,(B.QNT*B.HPP) HRGDEBET,

		0.00 QNTCR, 0.00 QNT2CR, 0.00 HRGKREDIT,

		B.QNT QNTSALDO, B.QNT2 QNT2SALDO, (B.QNT*B.HPP) HRGSALDO,

		A.TANGGAL, MONTH(A.TANGGAL) BULAN, YEAR(A.TANGGAL) TAHUN, A.NOBUKTI,

		A.IDUSER KODECUSTSUPP,A.IDUSER KETERANGAN, A.IDUSER,

		B.HPP,A.IDUSER KET, 'BHN' xCode

from DBTRANSFER A

left outer join DBTRANSFERDET B on B.NoBukti=A.NoBukti

union all

Select 	'TRO' Tipe, '13' Prioritas, B.KodeBrg, B.GDGASAL,

		0.00 QntDb, 0.00 Qnt2Db,0.00 HrgDebet,

		B.Qnt  QntCr, B.Qnt2 Qnt2Cr, (B.Qnt*B.HPP) HrgKredit,

		-B.Qnt QntSaldo, -B.Qnt2 Qnt2Saldo, -(B.Qnt*B.HPP) HrgSaldo,

		A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti,

		A.iduser KodeCustSupp, a.IDUser Keterangan, A.IDUser,

		B.HPP,a.IDUser Ket, 'BHN' xCode

from DBTRANSFER A

left outer join DBTRANSFERDET B on B.NoBukti=A.NoBukti

union All

Select 	'SPB' Tipe, '05' Prioritas, B.KodeBrg,B.Kodegdg,

		0.00 QNTDB, 0.00 QNT2DB,0.00 HRGDEBET,

		B.QNT QNTCR, B.QNT2 QNT2CR, (B.QNT*B.HPP) HRGKREDIT,

		-B.QNT QNTSALDO, -B.QNT2 QNT2SALDO, -(B.QNT*B.HPP) HRGSALDO,

		A.TANGGAL, MONTH(A.TANGGAL) BULAN, YEAR(A.TANGGAL) TAHUN, A.NOBUKTI,

		A.IDUSER KODECUSTSUPP,A.IDUSER KETERANGAN, A.IDUSER,

		B.HPP,D.NAMACUSTSUPP KET, 'BHN' xCode

from DBSPB A

left outer join dbSPBDet B on B.NoBukti=A.NoBukti

Left Outer join vwBrowsCust D on D.KODECUSTSUPP=A.KodeCustSupp

union all

Select 	'RSPB' Tipe, '05' Prioritas, B.KodeBrg,A.Kodegdg,

		B.QNT QNTDB, B.QNT2 QNT2DB,(B.QNT*B.HPP) HRGDEBET,

		0.00 QNTCR, 0.00 QNT2CR, 0.00 HRGKREDIT,

		B.QNT QNTSALDO, B.QNT2 QNT2SALDO, (B.QNT*B.HPP) HRGSALDO,

		A.TANGGAL, MONTH(A.TANGGAL) BULAN, YEAR(A.TANGGAL) TAHUN, A.NOBUKTI,

		A.IDUSER KODECUSTSUPP,A.IDUSER KETERANGAN, A.IDUSER,

		B.HPP,A.IDUSER KET, 'BHN' xCode

from DBRSPB A

left outer join DBRSPBDet B on B.NoBukti=A.NoBukti

union all

Select 	'RSPB' Tipe, '04' Prioritas, B.KodeBrg,B.Kodegdg,

		B.QNT QNTDB, B.QNT2 QNT2DB,(B.QNT*B.HPP) HRGDEBET,

		0.00 QNTCR, 0.00 QNT2CR, 0.00 HRGKREDIT,

		B.QNT QNTSALDO, B.QNT2 QNT2SALDO, (B.QNT*B.HPP) HRGSALDO,

		A.TANGGAL, MONTH(A.TANGGAL) BULAN, YEAR(A.TANGGAL) TAHUN, A.NOBUKTI,

		A.IDUSER KODECUSTSUPP,A.IDUSER KETERANGAN, A.IDUSER,

		B.HPP,A.IDUSER KET, 'BHN' xCode

from dbSPBRJual A

left outer join dbSPBRJualDet B on B.NoBukti=A.NoBukti

union All

Select 	'INVC' Tipe, '05' Prioritas, B.KodeBrg,C.KodeGdg,

		B.QNT QNTDB, B.QNT2 QNT2DB,(B.QNT*B.HPP) HRGDEBET,

		0.00 QNTCR, 0.00 QNT2CR, 0.00 HRGKREDIT,

		B.QNT QNTSALDO, B.QNT2 QNT2SALDO, (B.QNT*B.HPP ) HRGSALDO,

		A.TANGGAL, MONTH(A.TANGGAL) BULAN, YEAR(A.TANGGAL) TAHUN, A.NOBUKTI,

		A.KODECUSTSUPP,D.NAMACUSTSUPP KETERANGAN, '' IDUSER,

		B.HPP,'' KET, 'BHN' xCode

from DBInvoicePL A

left outer join dbInvoicePLDet B on B.NoBukti=A.NoBukti

left Outer join (Select Kodegdg, NoBukti,Urut 

                 from dbSPBDet 

                 Group by Kodegdg, NoBukti,Urut) C on C.NoBukti=B.NoSPB and C.Urut=B.UrutSPB

Left Outer join vwBrowsCust D on D.KODECUSTSUPP=A.KodeCustSupp

union all

Select 	'RINVC' Tipe, '05' Prioritas, B.KodeBrg,''KodeGdg,

		B.QNT QNTDB, B.QNT2 QNT2DB,(B.QNT*B.HPP) HRGDEBET,

		0.00 QNTCR, 0.00 QNT2CR, 0.00 HRGKREDIT,

		B.QNT QNTSALDO, B.QNT2 QNT2SALDO, (B.QNT*B.HPP ) HRGSALDO,

		A.TANGGAL, MONTH(A.TANGGAL) BULAN, YEAR(A.TANGGAL) TAHUN, A.NOBUKTI,

		A.KODECUSTSUPP,D.NAMACUSTSUPP KETERANGAN, '' IDUSER,

		B.HPP,'' KET, 'BHN' xCode

from DBInvoiceRPJ A

left outer join DBINVOICERPJDet B on B.NoBukti=A.NoBukti

Left Outer join vwBrowsCust D on D.KODECUSTSUPP=A.KodeCustSupp;

-- vwSubJenis
CREATE VIEW IF NOT EXISTS vwSubJenis AS Select A.*, B.Keterangan NamaJnsBrg,

       B.Keterangan+Case when B.Keterangan is null then '' else ' ('+B.KodeJnsBrg+')'  myJenis

from DBSUBJENIS A     

     left Outer join DBJenis B on B.KodeJnsBrg=A.KodeJnsBrg;

-- vwSubJenisJadi
CREATE VIEW IF NOT EXISTS vwSubJenisJadi AS Select A.*       

from DBSUBJENISBRGJADI A;

-- vwSubKategori
CREATE VIEW IF NOT EXISTS vwSubKategori AS Select A.*,B.Keterangan NamaKategori,

       B.Keterangan+Case when B.Keterangan is null then '' else ' ('+B.KodeKategori+')'  myKategori

from DBSUBKATEGORI A     

     left Outer join DBKATEGORI B on B.KodeKategori=A.KodeKategori;

-- vwSubKategoriJadi
CREATE VIEW IF NOT EXISTS vwSubKategoriJadi AS Select A.*

from DBSUBKATEGORIBRGJADI A;

-- vwSumberAktivitasUser
CREATE VIEW IF NOT EXISTS vwSumberAktivitasUser AS Select 1 Urutan, 'USR' KodeSumber, 'Pemakai' NamaSumber

union all Select 5 Urutan, 'GDG' KodeSumber, 'Gudang' NamaSumber

union all Select 8 Urutan, 'GRP' KodeSumber, 'Group Brg' NamaSumber

union all Select 10 Urutan, 'BRG' KodeSumber, 'Barang' NamaSumber

union all Select 13 Urutan, 'SUP' KodeSumber, 'Supplier' NamaSumber

union all Select 15 Urutan, 'ARE' KodeSumber, 'Area' NamaSumber

union all Select 17 Urutan, 'SSA' KodeSumber, 'Sub Area' NamaSumber

union all Select 30 Urutan, 'KOT' KodeSumber, 'Kota/ Kab.' NamaSumber

union all Select 33 Urutan, 'KEC' KodeSumber, 'Kecamatan' NamaSumber

union all Select 35 Urutan, 'DES' KodeSumber, 'Desa/ Kel.' NamaSumber

union all Select 40 Urutan, 'SLS' KodeSumber, 'Salesman' NamaSumber

union all Select 46 Urutan, 'JCU' KodeSumber, 'Jenis Cust' NamaSumber

union all Select 48 Urutan, 'LCU' KodeSumber, 'Lokasi Cust' NamaSumber

union all Select 50 Urutan, 'CUS' KodeSumber, 'Customer' NamaSumber

union all Select 60 Urutan, 'PO' KodeSumber, 'P.O' NamaSumber

union all Select 63 Urutan, 'PBL' KodeSumber, 'Pembelian' NamaSumber

union all Select 70 Urutan, 'RPB' KodeSumber, 'Retur Beli' NamaSumber

union all Select 80 Urutan, 'SO' KodeSumber, 'S.O' NamaSumber

union all Select 83 Urutan, 'PNJ' KodeSumber, 'Penjualan' NamaSumber

union all Select 86 Urutan, 'RPJ' KodeSumber, 'Retur Jual' NamaSumber

union all Select 88 Urutan, 'PT' KodeSumber, 'Lunas Piutang' NamaSumber

union all Select 90 Urutan, 'OPN' KodeSumber, 'Opname' NamaSumber

union all Select 93 Urutan, 'TRS' KodeSumber, 'Transfer Brg' NamaSumber

union all Select 96 Urutan, 'KMS' KodeSumber, 'U Kemas' NamaSumber

union all Select 100 Urutan, 'LN' KodeSumber, 'Lain-lain' NamaSumber;

-- vwSumberJurnal
CREATE VIEW IF NOT EXISTS vwSumberJurnal AS select '010' MyUrut, 'BL' JenisTrans, 'Pembelian' NamaTrans, 'dbBeli' NamaTabel

union all 

select '011' MyUrut, 'RBL' JenisTrans, 'Retur Pembelian' NamaTrans, 'dbRBeli' NamaTabel

union all

select '012' MyUrut, 'SPB' JenisTrans, 'Surat Jalan' NamaTrans, 'dbSPB' NamaTabel

union all

select '013' MyUrut, 'RSPB' JenisTrans, 'Retur Surat Jalan' NamaTrans, 'DBRSPB' NamaTabel

union all

select '014' MyUrut, 'BP' JenisTrans, 'Invoice KP' NamaTrans, 'dbInvoicePL' NamaTabel

union all

select '015' MyUrut, 'INVRPJ' JenisTrans, 'Retur Invoice KP' NamaTrans, 'dbRInvoicePL' NamaTabel

union all

select '016' MyUrut, 'SPBRJUAL' JenisTrans, 'Retur Invoice Gudang' NamaTrans, 'dbSPBRJual' NamaTabel

union all

select '017' MyUrut, 'HPR' JenisTrans, 'Hasil Produksi' NamaTrans, 'DBHASILPRD' NamaTabel;

-- vwtransaksi
CREATE VIEW IF NOT EXISTS vwtransaksi AS SELECT A.NOBUKTI, A.TANGGAL, B.DEVISI, A.NOTE,A.LAMPIRAN, ISOTORISASI1, OTOUSER1, TGLOTO1, ISOTORISASI2, OTOUSER2, TGLOTO2, ISOTORISASI3, OTOUSER3, TGLOTO3, ISOTORISASI4, OTOUSER4, TGLOTO4, 

       ISOTORISASI5, OTOUSER5, TGLOTO5, B.URUT, CASE WHEN (B.FlagSimbol='LB') or (B.FlagSimbol='TG') THEN B.Lawan ELSE B.PERKIRAAN  PERKIRAAN,

                                                CASE WHEN (B.FlagSimbol='LB') or (B.FlagSimbol='TG') THEN B.Perkiraan ELSE B.LAWAN  LAWAN, B.KETERANGAN, B.KETERANGAN2,

                                                CASE WHEN (B.FlagSimbol='LB') or (B.FlagSimbol='TG') THEN -1*B.DEBET ELSE B.Debet  DEBET, B.KREDIT, B.VALAS, B.KURS, 

                                                CASE WHEN (B.FlagSimbol='LB') or (B.FlagSimbol='TG') THEN -1*B.DEBETRP ELSE B.DebetRp  DEBETRP, B.KREDITRP, 

       B.TIPETRANS, B.TPHC, B.CUSTSUPPP, B.CUSTSUPPL, B.KODEP, B.KODEL, B.NOAKTIVAP, B.NOAKTIVAL, B.STATUSAKTIVAP, B.STATUSAKTIVAL, B.NOBON, B.KODEBAG, 

       B.STATUSGIRO, 'KASBANK' JENIS, A.NOURUT

FROM DBO.DBTRANS A LEFT OUTER JOIN

     DBO.DBTRANSAKSI B ON B.NOBUKTI = A.NOBUKTI

where DebetRp+KreditRp<>0 and (B.NoBukti+cast(B.Urut as varchar(3)) not in 

      ( select NoBukti+cast(Urut as varchar(3)) from dbTransaksi where NoBukti like '%BBK%' and ((FlagSimbol='LB') or (FlagSimbol='TG')) and Lawan like '11%' and Perkiraan='131'   )

       and B.NoBukti+cast(B.Urut as varchar(3)) not in ( select NoBukti+cast(Urut as varchar(3)) from dbTransaksi where NoBukti like '%BMM%'  and B.FlagSimbol<>'LB' and Perkiraan='131' and Lawan='807'   ))



UNION ALL

SELECT A.NOBUKTI, A.TANGGAL, B.DEVISI, A.NOTE,A.LAMPIRAN, ISOTORISASI1, OTOUSER1, TGLOTO1, ISOTORISASI2, OTOUSER2, TGLOTO2, ISOTORISASI3, OTOUSER3, TGLOTO3, ISOTORISASI4, OTOUSER4, TGLOTO4, 

       ISOTORISASI5, OTOUSER5, TGLOTO5, B.URUT, 

       case when ((B.FlagSimbol='LB') or (B.FlagSimbol='TG')) and (CASE WHEN (B.FlagSimbol='LB') or (B.FlagSimbol='TG') THEN B.Lawan ELSE B.PERKIRAAN ) like '11%' then '109' else

       (CASE WHEN (B.FlagSimbol='LB') or (B.FlagSimbol='TG') THEN B.Lawan ELSE B.PERKIRAAN )  PERKIRAAN,

       CASE WHEN (B.FlagSimbol='LB') or (B.FlagSimbol='TG') THEN B.Perkiraan ELSE B.LAWAN  LAWAN, B.KETERANGAN, B.KETERANGAN2,

                                                CASE WHEN ((B.FlagSimbol='LB') or (B.FlagSimbol='TG'))   THEN -1*B.DEBETRP ELSE B.Debet  DEBET, B.KREDIT, B.VALAS, B.KURS, 

                                                CASE WHEN (B.FlagSimbol='LB') or (B.FlagSimbol='TG') THEN -1*B.DEBETRP ELSE B.DebetRp  DEBETRP, B.KREDITRP, 

       B.TIPETRANS, B.TPHC, B.CUSTSUPPP, B.CUSTSUPPL, B.KODEP, B.KODEL, B.NOAKTIVAP, B.NOAKTIVAL, B.STATUSAKTIVAP, B.STATUSAKTIVAL, B.NOBON, B.KODEBAG, 

       B.STATUSGIRO, 'KASBANK' JENIS, A.NOURUT

FROM DBO.DBTRANS A LEFT OUTER JOIN

     DBO.DBTRANSAKSI B ON B.NOBUKTI = A.NOBUKTI

where DebetRp+KreditRp<>0 and B.NoBukti like '%BBK%' and ((B.FlagSimbol='LB') or (B.FlagSimbol='TG')) and Lawan like '11%' 



Union All

SELECT A.NOBUKTI, A.TANGGAL, B.DEVISI, A.NOTE,A.LAMPIRAN, ISOTORISASI1, OTOUSER1, TGLOTO1, ISOTORISASI2, OTOUSER2, TGLOTO2, ISOTORISASI3, OTOUSER3, TGLOTO3, ISOTORISASI4, OTOUSER4, TGLOTO4, 

       ISOTORISASI5, OTOUSER5, TGLOTO5, B.URUT, 

       case when ((B.FlagSimbol='LB') or (B.FlagSimbol='TG')) and (CASE WHEN (B.FlagSimbol='LB') or (B.FlagSimbol='TG') THEN B.Lawan ELSE B.PERKIRAAN ) like '11%' then '109' else

       (CASE WHEN (B.FlagSimbol='LB') or (B.FlagSimbol='TG') THEN B.Lawan ELSE B.PERKIRAAN )  PERKIRAAN,

       CASE WHEN (B.FlagSimbol='LB') or (B.FlagSimbol='TG') and (CASE WHEN (B.FlagSimbol='LB') or (B.FlagSimbol='TG') THEN B.Perkiraan ELSE B.LAWAN )='131' then b.Lawan else

       CASE WHEN (B.FlagSimbol='LB') or (B.FlagSimbol='TG') THEN B.Perkiraan ELSE B.LAWAN  

       LAWAN, B.KETERANGAN, B.KETERANGAN2,

                                                CASE WHEN ((B.FlagSimbol='LB') or (B.FlagSimbol='TG'))   THEN B.DEBETRP ELSE B.Debet  DEBET, B.KREDIT, B.VALAS, B.KURS, 

                                                CASE WHEN (B.FlagSimbol='LB') or (B.FlagSimbol='TG') THEN B.DEBETRP ELSE B.DebetRp  DEBETRP, B.KREDITRP, 

       B.TIPETRANS, B.TPHC, B.CUSTSUPPP, B.CUSTSUPPL, B.KODEP, B.KODEL, B.NOAKTIVAP, B.NOAKTIVAL, B.STATUSAKTIVAP, B.STATUSAKTIVAL, B.NOBON, B.KODEBAG, 

       B.STATUSGIRO, 'KASBANK' JENIS, A.NOURUT

FROM DBO.DBTRANS A LEFT OUTER JOIN

     DBO.DBTRANSAKSI B ON B.NOBUKTI = A.NOBUKTI

where DebetRp+KreditRp<>0 and B.NoBukti like '%BBK%' and ((B.FlagSimbol='LB') or (B.FlagSimbol='TG')) and Perkiraan='131'



Union All

SELECT A.NOBUKTI, A.TANGGAL, B.DEVISI, A.NOTE,A.LAMPIRAN, ISOTORISASI1, OTOUSER1, TGLOTO1, ISOTORISASI2, OTOUSER2, TGLOTO2, ISOTORISASI3, OTOUSER3, TGLOTO3, ISOTORISASI4, OTOUSER4, TGLOTO4, 

       ISOTORISASI5, OTOUSER5, TGLOTO5, B.URUT, CASE WHEN Perkiraan='131' and Lawan='807' THEN B.Lawan ELSE B.PERKIRAAN  PERKIRAAN,

                                                CASE WHEN Perkiraan='131' and Lawan='807' THEN B.Perkiraan ELSE B.LAWAN  LAWAN, B.KETERANGAN, B.KETERANGAN2,

                                                CASE WHEN Perkiraan='131' and Lawan='807' THEN -1*B.DEBET ELSE B.Debet  DEBET, B.KREDIT, B.VALAS, B.KURS, 

                                                CASE WHEN Perkiraan='131' and Lawan='807' THEN -1*B.DEBETRP ELSE B.DebetRp  DEBETRP, B.KREDITRP, 

       B.TIPETRANS, B.TPHC, B.CUSTSUPPP, B.CUSTSUPPL, B.KODEP, B.KODEL, B.NOAKTIVAP, B.NOAKTIVAL, B.STATUSAKTIVAP, B.STATUSAKTIVAL, B.NOBON, B.KODEBAG, 

       B.STATUSGIRO, 'KASBANK' JENIS, A.NOURUT

FROM DBO.DBTRANS A LEFT OUTER JOIN

     DBO.DBTRANSAKSI B ON B.NOBUKTI = A.NOBUKTI

where DebetRp+KreditRp<>0 and B.NoBukti like '%BMM%'  and B.FlagSimbol<>'LB' and Perkiraan='131' and Lawan='807'   



UNION ALL

Select NoBukti, Tanggal, Devisi, Note, Lampiran, IsOtorisasi1, OtoUser1, TglOto1, IsOtorisasi2, OtoUser2, TglOto2, IsOtorisasi3, OtoUser3, TglOto3, IsOtorisasi4, OtoUser4, 

       TglOto4, IsOtorisasi5, OtoUser5, TglOto5, Urut, Perkiraan, Lawan, Keterangan, Keterangan2, Debet, Kredit, Valas, Kurs, DebetRp, KreditRp, TipeTrans, TPHC, 

       CustSuppP, CustSuppL, KodeP, KodeL, NoAktivaP, NoAktivaL, StatusAktivaP, StatusAktivaL, Nobon, KodeBag, StatusGiro, Jenis, NOURUT

From dbo.dbJurnalOto where DebetRp+KreditRp<>0



union all



SELECT A.NOBUKTI, A.Tanggal,case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI, 

      'Opname : ' + A.NOBUKTI + ' ' + H.NamaSubGrp + ' (' + H.KodeSubGrp + ')' NOTE,0 LAMPIRAN, 

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) URUT,  

       Case when Sum(B.QNTDB)<>0 then H.PerkPers

            when Sum(B.QNTCR)<>0 then case when a.NOBUKTI like '%KRS%' then case when a.NOBUKTI in('CA/KRS/0121/00035','BCA/KRS/0121/00039') then '410' else J.Perkiraan 

            else '410'    PERKIRAAN, 

       Case when Sum(B.QNTDB)<>0 then case when a.NOBUKTI like '%KRS%' then case when a.NOBUKTI in('CA/KRS/0121/00035','BCA/KRS/0121/00039') then '410' else J.Perkiraan 

            else '410'  

            when Sum(B.QNTCR)<>0 then H.PerkPers

            else ''

        LAWAN, 

       'Opname : ' + + H.NamaSubGrp + ' (' + H.KodeSubGrp + ')'+CHAR(13)+ 

       'No. Opname : '+A.Nobukti+' TANGGAL : '+ Convert(Varchar(15),A.Tanggal, 105) +CHAR(13)+ 

       a.NOTE KETERANGAN, '' KETERANGAN2, 

       Sum(Case when B.QNTDB<>0 then B.QNTDB*CASE When F.KODEGRP='BM' then case when isnull(B.HARGA,0)=0 then isnull(B.HPP,0) else isnull(B.HARGA,0)  else case when a.NOBUKTI in('BCA/OPBJ/0621/0001','BCA/OPBJ/0621/0003','BCA/OPBJ/0621/0005','CA/OPBJ/0621/0002') then isnull(B.HARGA,0) else c1.HPPBrg   

                when B.QNTCR<>0 then B.QNTCR*case when a.NOBUKTI in('CA/KRS/0121/00035','BCA/KRS/0121/00039') then b.HARGA else case When ISNULL(c1.HPPBrg,0)<>0 Then c1.HPPBrg else B.HPP   

                else 0

           )  DEBET, 0 KREDIT, 'IDR' VALAS, 1 KURS, 

       Sum(Case when B.QNTDB<>0 then B.QNTDB*CASE When F.KODEGRP='BM' then case when isnull(B.HARGA,0)=0 then isnull(B.HPP,0) else isnull(B.HARGA,0)  else case when a.NOBUKTI in('BCA/OPBJ/0621/0001','BCA/OPBJ/0621/0003','BCA/OPBJ/0621/0005','CA/OPBJ/0621/0002') then isnull(B.HARGA,0) else c1.HPPBrg   

                when B.QNTCR<>0 then B.QNTCR*case when a.NOBUKTI in('CA/KRS/0121/00035','BCA/KRS/0121/00039') then b.HARGA else case When ISNULL(c1.HPPBrg,0)<>0 Then c1.HPPBrg else B.HPP   

                else 0

           ) DEBETRP, 0 KREDITRP, 'BJK' TIPETRANS, 'C' TPHC, '' CUSTCUPPP, '' CUSTSUPPL, '' KODEP, 

       '' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '01' KODEBAG, '' STATUSGIRO,  

      'ADJ' JENIS, A.NoUrutJurnal NOURUT

FROM  DBO.DBKOREKSI A 

LEFT OUTER JOIN DBO.DBKOREKSIDET B ON B.NOBUKTI = A.NOBUKTI 

LEFT OUTER JOIN DBO.DBBARANG F ON F.KODEBRG = B.KODEBRG LEFT OUTER JOIN DBO.DBGROUP G ON G.KODEGRP = F.KODEGRP

LEFT OUTER JOIN DBO.dbSubGroup H ON H.KodeGrp = F.KODEGRP and H.KodeSubGrp=F.KODESUBGRP

Left outer Join (select b.noBukti,a.KodeBrg,AVG(cast(Hrg as numeric(18,2)))Hpp 

                 from VwHrgRata2 a

                 Left Outer Join DBKOREKSIDET b On a.KodeBrg=b.kodebrg

                 Left Outer Join DBKOREKSI c On c.Nobukti=b.Nobukti

                 where a.Tanggal<=c.tanggal or ( MONTH(a.Tanggal)=MONTH(c.Tanggal) and YEAR(a.Tanggal)=YEAR(c.Tanggal))

                 Group by b.noBukti,a.KodeBrg

                )c2 On c2.KODEBRG=B.kodebrg and c2.Nobukti=A.Nobukti 

Left Outer Join dbHPPProduksi c1 on B.KODEBRG=c1.KodeBrg and MONTH(a.Tanggal)=c1.Bulan and YEAR(a.TANGGAL)=c1.Tahun

Left outer Join (select b.noBukti,a.KodeBrg,AVG(cast(Hrg as numeric(18,2)))Hpp 

                 from VwHrgRata2 a

                 Left Outer Join DBKOREKSIDET b On a.KodeBrg=b.kodebrg

                 Left Outer Join DBKOREKSI c On c.Nobukti=b.Nobukti

                 Group by b.noBukti,a.KodeBrg

                )d On d.KODEBRG=B.kodebrg and d.Nobukti=A.Nobukti 

Left Outer Join (Select Perkiraan 

                 from dbo.DBPOSTHUTPIUT 

                 where Kode='BYO') J on 1=1

Where A.NOBUKTI<>'' and B.QNTDB<>0 and ((MONTH(TANGGAL)=1 and YEAR(TANGGAL)=2020 and a.NOBUKTI not like '%OPBJ%' ) 

                                         or (((MONTH(TANGGAL)>1 and YEAR(TANGGAL)=2020) or (YEAR(TANGGAL)>2020)) and 1=1))

                                   and a.NOBUKTI not in ('BCA/KRS/1221/00118','BCA/KRS/0522/00068','BCA/KRS/1122/00201')

Group by A.NoJurnal, A.TglJurnal, H.KodeSubGrp,

      A.NOBUKTI, H.NamaSubGrp, H.KodeSubGrp,A.TANGGAL,

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       A.NoUrutJurnal,H.PerkPers, J.Perkiraan,a.NOTE

union all

SELECT A.NOBUKTI, A.Tanggal,case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI, 

      'Opname : ' + A.NOBUKTI + ' ' + H.NamaSubGrp + ' (' + H.KodeSubGrp + ')' NOTE,0 LAMPIRAN, 

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) URUT,  

       Case when Sum(B.QNTDB)<>0 then H.PerkPers

            when Sum(B.QNTCR)<>0 then case when a.NOBUKTI like '%KRS%' then case when a.NOBUKTI in('CA/KRS/0121/00035','BCA/KRS/0121/00039') then '410' else J.Perkiraan 

            else '410'    PERKIRAAN, 

       Case when Sum(B.QNTDB)<>0 then case when a.NOBUKTI like '%KRS%' then case when a.NOBUKTI in('CA/KRS/0121/00035','BCA/KRS/0121/00039') then '410' else J.Perkiraan 

            else '410'  

            when Sum(B.QNTCR)<>0 then H.PerkPers

            else ''

        LAWAN, 

       'Opname : ' + + H.NamaSubGrp + ' (' + H.KodeSubGrp + ')'+CHAR(13)+ 

       'No. Opname : '+A.Nobukti+' TANGGAL : '+ Convert(Varchar(15),A.Tanggal, 105)  +CHAR(13)+ 

       a.NOTE KETERANGAN, '' KETERANGAN2, 

       case when (a.NOBUKTI='BCA/OPN/1020/0002' and H.PerkPers='155') then 192264931.31

       else Sum(Case when B.QNTDB<>0 then B.QNTDB*CASE When F.KODEGRP='BM' then case when isnull(B.HARGA,0)=0 then isnull(B.HPP,0) else isnull(B.HARGA,0)  else c1.HPPBrg  

                when B.QNTCR<>0 then B.QNTCR*case when a.NOBUKTI in('CA/KRS/0121/00035','BCA/KRS/0121/00039','BCA/OPBJ/0621/0001','BCA/OPBJ/0621/0002','BCA/OPBJ/0621/0004','BCA/OPBJ/0621/0006','CA/OPN/0621/0002','CA/OPBJ/0621/0003') then b.HARGA else case When ISNULL(c1.HPPBrg,0)<>0 Then c1.HPPBrg else B.HPP   

                else 0

           )   DEBET, 0 KREDIT, 'IDR' VALAS, 1 KURS, 

       case when (a.NOBUKTI='BCA/OPN/1020/0002' and H.PerkPers='155') then 192264931.31

       else Sum(Case when B.QNTDB<>0 then B.QNTDB*CASE When F.KODEGRP='BM' then case when isnull(B.HARGA,0)=0 then isnull(B.HPP,0) else isnull(B.HARGA,0)  else c1.HPPBrg  

                when B.QNTCR<>0 then B.QNTCR*case when a.NOBUKTI in('CA/KRS/0121/00035','BCA/KRS/0121/00039','BCA/OPBJ/0621/0001','BCA/OPBJ/0621/0002','BCA/OPBJ/0621/0004','BCA/OPBJ/0621/0006','CA/OPN/0621/0002','CA/OPBJ/0621/0003') then b.HARGA else case When ISNULL(c1.HPPBrg,0)<>0 Then c1.HPPBrg else B.HPP   

                else 0

           )   DEBETRP, 0 KREDITRP, 'BJK' TIPETRANS, 'C' TPHC, '' CUSTCUPPP, '' CUSTSUPPL, '' KODEP, 

       '' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '01' KODEBAG, '' STATUSGIRO,  

      'ADJ' JENIS, A.NoUrutJurnal NOURUT

FROM  DBO.DBKOREKSI A 

LEFT OUTER JOIN DBO.DBKOREKSIDET B ON B.NOBUKTI = A.NOBUKTI 

LEFT OUTER JOIN DBO.DBBARANG F ON F.KODEBRG = B.KODEBRG LEFT OUTER JOIN DBO.DBGROUP G ON G.KODEGRP = F.KODEGRP

LEFT OUTER JOIN DBO.dbSubGroup H ON H.KodeGrp = F.KODEGRP and H.KodeSubGrp=F.KODESUBGRP

Left outer Join (select b.noBukti,a.KodeBrg,AVG(cast(Hrg as numeric(18,2)))Hpp 

                 from VwHrgRata2 a

                 Left Outer Join DBKOREKSIDET b On a.KodeBrg=b.kodebrg

                 Left Outer Join DBKOREKSI c On c.Nobukti=b.Nobukti

                 where a.Tanggal<=c.tanggal or ( MONTH(a.Tanggal)=MONTH(c.Tanggal) and YEAR(a.Tanggal)=YEAR(c.Tanggal))

                 Group by b.noBukti,a.KodeBrg

                )c2 On c2.KODEBRG=B.kodebrg and c2.Nobukti=A.Nobukti 

Left Outer Join dbHPPProduksi c1 on B.KODEBRG=c1.KodeBrg and MONTH(a.Tanggal)=c1.Bulan and YEAR(a.TANGGAL)=c1.Tahun

Left outer Join (select b.noBukti,a.KodeBrg,AVG(cast(Hrg as numeric(18,2)))Hpp 

                 from VwHrgRata2 a

                 Left Outer Join DBKOREKSIDET b On a.KodeBrg=b.kodebrg

                 Left Outer Join DBKOREKSI c On c.Nobukti=b.Nobukti

                 Group by b.noBukti,a.KodeBrg

                )d On d.KODEBRG=B.kodebrg and d.Nobukti=A.Nobukti 

Left Outer Join (Select Perkiraan 

                 from dbo.DBPOSTHUTPIUT 

                 where Kode='BYO') J on 1=1

Where A.NOBUKTI<>'' and B.QNTCR<>0 and ((MONTH(TANGGAL)=1 and YEAR(TANGGAL)=2020 and a.NOBUKTI not like '%OPBJ%' ) 

                                         or (((MONTH(TANGGAL)>1 and YEAR(TANGGAL)=2020) or (YEAR(TANGGAL)>2020)) and 1=1))

                                   and a.NOBUKTI not in ('BCA/KRS/1221/00118','BCA/KRS/0522/00068','BCA/KRS/1122/00201','BCA/KRS/0223/00045','BCA/KRS/0323/00061','BCA/KRS/0423/00018')

Group by A.NoJurnal, A.TglJurnal, H.KodeSubGrp,

      A.NOBUKTI, H.NamaSubGrp, H.KodeSubGrp,A.TANGGAL,

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       A.NoUrutJurnal,H.PerkPers, J.Perkiraan,a.NOTE



Union ALL

SELECT A.NoJurnal NOBUKTI, A.Tanggal,case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI, 

      'Ubah Kemasan : ' + A.NOBUKTI + ' ' + H.NamaSubGrp + ' (' + H.KodeSubGrp + ')' NOTE,0 LAMPIRAN, 

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) URUT,  

       Case when Sum(B.QNTDB)<>0 then J.Perkiraan

            when Sum(B.QNTCR)<>0 then H.PerkPers

            else ''

         PERKIRAAN, 

       Case when Sum(B.QNTDB)<>0 then H.PerkPers

            when Sum(B.QNTCR)<>0 then J.Perkiraan

            else ''

        LAWAN, 

       'Ubah Kemasan : ' + + H.NamaSubGrp + ' (' + H.KodeSubGrp + ')'+CHAR(13)+ 

       'No. Ubah Kemasan : '+A.Nobukti+' TANGGAL : '+ Convert(Varchar(15),A.Tanggal, 105)KETERANGAN, '' KETERANGAN2, 

       Sum(Case when B.QNTDB<>0 then B.QNTDB 

                when B.QNTCR<>0 then B.QNTCR

                else 0

            * B.HPP) DEBET, 0 KREDIT, 'IDR' VALAS, 1 KURS, 

       Sum(Case when B.QNTDB<>0 then B.QNTDB 

                when B.QNTCR<>0 then B.QNTCR

                else 0

            * B.HPP) DEBETRP, 0 KREDITRP, 'BJK' TIPETRANS, 'C' TPHC, '' CUSTCUPPP, '' CUSTSUPPL, '' KODEP, 

       '' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '01' KODEBAG, '' STATUSGIRO,  

      'UKM' JENIS, A.NoUrutJurnal NOURUT

FROM  DBO.DBUBAHKEMASAN A 

LEFT OUTER JOIN DBO.DBUBAHKEMASANDET B ON B.NOBUKTI = A.NOBUKTI 

LEFT OUTER JOIN DBO.DBBARANG F ON F.KODEBRG = B.KODEBRG LEFT OUTER JOIN DBO.DBGROUP G ON G.KODEGRP = F.KODEGRP

LEFT OUTER JOIN DBO.dbSubGroup H ON H.KodeGrp = F.KODEGRP and H.KodeSubGrp=F.KODESUBGRP

Left Outer Join (Select Perkiraan 

                 from dbo.DBPOSTHUTPIUT 

                 where Kode='BYO') J on 1=1

Where A.noJurnal<>''

Group by A.NoJurnal, A.TglJurnal, H.KodeSubGrp,

      A.NOBUKTI, H.NamaSubGrp, H.KodeSubGrp,A.TANGGAL,

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       A.NoUrutJurnal,H.PerkPers, J.Perkiraan

 -----------------------------------------------



Union All



SELECT A.Nobukti NOBUKTI, A.Tanggal TANGGAL,case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI, 

       dbo.fnc_NamaBrg(A.NOBUKTI,LEFT(B.KodeBrg,8)) NOTE,0 LAMPIRAN, 

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) URUT,  

       a.NoJurnal PERKIRAAN, 

       PerkPers  LAWAN, 

       dbo.fnc_NamaBrg(A.NOBUKTI,LEFT(B.KodeBrg,8)) KETERANGAN, '' KETERANGAN2, 

       case when a.nobukti='BCA/BP/1020/0215' then 50600 

       when a.nobukti='BCA/BP/1020/0271' then 126500

       when a.nobukti='BCA/BP/1020/0364' then 121250 

        else Sum(B.Qnt * isnull(B.HPP,0) )  DEBET, 0 KREDIT, 'IDR' VALAS, 1 KURS, 

       case when a.nobukti='BCA/BP/1020/0215' then 50600 

       when a.nobukti='BCA/BP/1020/0271' then 126500

       when a.nobukti='BCA/BP/1020/0364' then 121250 

       else Sum(B.Qnt * isnull(B.HPP,0) )  DEBETRP, 0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, '' CUSTSUPPP, '' CUSTSUPPL, '' KODEP, 

       '' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, A.KdDep, '' STATUSGIRO,

        'PMK' JENIS, A.NoUrutJurnal NOURUT

FROM  DBO.DBPenyerahanBhn A 

LEFT OUTER JOIN DBO.DBPenyerahanBhnDET B ON B.NOBUKTI = A.NOBUKTI 

Left Outer Join (select b.noBukti,a.KodeBrg,AVG(cast(Hrg as numeric(18,2)))Hrg 

                 from VwHrgRata2 a

                 Left Outer Join DBPenyerahanBhnDET b On a.KodeBrg=b.kodebrg

                 Left Outer Join DBPenyerahanBhn c On c.Nobukti=b.Nobukti

                 where a.Tanggal<=c.tanggal  or ( MONTH(a.Tanggal)=MONTH(c.Tanggal) and YEAR(a.Tanggal)=YEAR(c.Tanggal))

                 Group by b.noBukti,a.KodeBrg)B1 On B1.KODEBRG=B.kodebrg and B1.Nobukti=A.Nobukti

LEFT OUTER JOIN DBO.DBBARANG F ON F.KODEBRG = B.KODEBRG 

LEFT OUTER JOIN DBO.DBGROUP G ON G.KODEGRP = F.KODEGRP

LEFT OUTER JOIN DBO.dbSubGroup H ON H.KodeSubGrp = F.KODESUBGRP and H.KodeGrp=F.KODEGRP 

Group by A.NoJurnal, A.TglJurnal, 

      A.NOBUKTI, H.NamaSubGrp, H.KodeSubGrp,A.TANGGAL,

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       H.PerkPPN, H.PerkPers,A.NoUrutJurnal,A.NoJurnal,A.KdDep,LEFT(B.KodeBrg,8)

------------------------

/*Union All 

SELECT A.Nobukti NOBUKTI, A.Tanggal TANGGAL,case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI, 

       dbo.fnc_NamaBrg(A.NOBUKTI,LEFT(B.KodeBrg,8)) NOTE,0 LAMPIRAN, 

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) URUT,  

       '153' PERKIRAAN, 

       '159'  LAWAN, 

       dbo.fnc_NamaBrg(A.NOBUKTI,LEFT(B.KodeBrg,8)) KETERANGAN, '' KETERANGAN2, 

       case when a.nobukti='BCA/BP/1020/0215' then 50600

       when a.nobukti='BCA/BP/1020/0271' then 126500

       when a.nobukti='BCA/BP/1020/0364' then 121250 

       else Sum(B.Qnt *isnull(B.HPP,0) )  DEBET, 0 KREDIT, 'IDR' VALAS, 1 KURS, 

       case when a.nobukti='BCA/BP/1020/0215' then 50600

       when a.nobukti='BCA/BP/1020/0271' then 126500

       when a.nobukti='BCA/BP/1020/0364' then 121250 

       else Sum(B.Qnt * isnull(B.HPP,0) )  DEBETRP, 0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, '' CUSTSUPPP, '' CUSTSUPPL, '' KODEP, 

       '' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, A.KdDep, '' STATUSGIRO,

        'HPR' JENIS, A.NoUrutJurnal NOURUT

FROM  DBO.DBPenyerahanBhn A 

LEFT OUTER JOIN DBO.DBPenyerahanBhnDET B ON B.NOBUKTI = A.NOBUKTI 

Left Outer Join (select b.noBukti,a.KodeBrg,AVG(cast(Hrg as numeric(18,2)))Hrg 

                 from VwHrgRata2 a

                 Left Outer Join DBPenyerahanBhnDET b On a.KodeBrg=b.kodebrg

                 Left Outer Join DBPenyerahanBhn c On c.Nobukti=b.Nobukti

                 where a.Tanggal<=c.tanggal  or ( MONTH(a.Tanggal)=MONTH(c.Tanggal) and YEAR(a.Tanggal)=YEAR(c.Tanggal))

                 Group by b.noBukti,a.KodeBrg)B1 On B1.KODEBRG=B.kodebrg and B1.Nobukti=A.Nobukti

LEFT OUTER JOIN DBO.DBBARANG F ON F.KODEBRG = B.KODEBRG 

LEFT OUTER JOIN DBO.DBGROUP G ON G.KODEGRP = F.KODEGRP

LEFT OUTER JOIN DBO.dbSubGroup H ON H.KodeSubGrp = F.KODESUBGRP and H.KodeGrp=F.KODEGRP

where a.NoJurnal='159'

Group by A.NoJurnal, A.TglJurnal, 

      A.NOBUKTI, H.NamaSubGrp, H.KodeSubGrp,A.TANGGAL,

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       H.PerkPPN, H.PerkPers,A.NoUrutJurnal,A.NoJurnal,A.KdDep,LEFT(B.KodeBrg,8)

*/;

-- VWTransaksiBB
CREATE VIEW IF NOT EXISTS VWTransaksiBB AS SELECT A.NOBUKTI, A.TANGGAL, B.DEVISI, A.NOTE,A.LAMPIRAN, ISOTORISASI1, OTOUSER1, TGLOTO1, ISOTORISASI2, OTOUSER2, TGLOTO2, ISOTORISASI3, OTOUSER3, TGLOTO3, ISOTORISASI4, OTOUSER4, TGLOTO4, 

       ISOTORISASI5, OTOUSER5, TGLOTO5, B.URUT, CASE WHEN (B.FlagSimbol='LB') or (B.FlagSimbol='TG') THEN B.Lawan ELSE B.PERKIRAAN  PERKIRAAN,

                                                CASE WHEN (B.FlagSimbol='LB') or (B.FlagSimbol='TG') THEN B.Perkiraan ELSE B.LAWAN  LAWAN, B.KETERANGAN, B.KETERANGAN2,

                                                CASE WHEN (B.FlagSimbol='LB') or (B.FlagSimbol='TG') THEN -1*B.DEBET ELSE B.Debet  DEBET, B.KREDIT, B.VALAS, B.KURS, 

                                                CASE WHEN (B.FlagSimbol='LB') or (B.FlagSimbol='TG') THEN -1*B.DEBETRP ELSE B.DebetRp  DEBETRP, B.KREDITRP, 

       B.TIPETRANS, B.TPHC, B.CUSTSUPPP, B.CUSTSUPPL, B.KODEP, B.KODEL, B.NOAKTIVAP, B.NOAKTIVAL, B.STATUSAKTIVAP, B.STATUSAKTIVAL, B.NOBON, B.KODEBAG, 

       B.STATUSGIRO, 'KASBANK' JENIS, A.NOURUT

FROM DBO.DBTRANS A LEFT OUTER JOIN

     DBO.DBTRANSAKSI B ON B.NOBUKTI = A.NOBUKTI

where DebetRp+KreditRp<>0 and B.NoBukti+cast(B.Urut as varchar(3)) not in ( select NoBukti+cast(Urut as varchar(3)) from dbTransaksi where NoBukti like '%BMM%' and B.FlagSimbol<>'LB' and Perkiraan='131' and Lawan='807'   )



Union All



SELECT A.NOBUKTI, A.TANGGAL, B.DEVISI, A.NOTE,A.LAMPIRAN, ISOTORISASI1, OTOUSER1, TGLOTO1, ISOTORISASI2, OTOUSER2, TGLOTO2, ISOTORISASI3, OTOUSER3, TGLOTO3, ISOTORISASI4, OTOUSER4, TGLOTO4, 

       ISOTORISASI5, OTOUSER5, TGLOTO5, B.URUT, CASE WHEN Perkiraan='131' and Lawan='807' THEN B.Lawan ELSE B.PERKIRAAN  PERKIRAAN,

                                                CASE WHEN Perkiraan='131' and Lawan='807' THEN B.Perkiraan ELSE B.LAWAN  LAWAN, B.KETERANGAN, B.KETERANGAN2,

                                                CASE WHEN Perkiraan='131' and Lawan='807' THEN -1*B.DEBET ELSE B.Debet  DEBET, B.KREDIT, B.VALAS, B.KURS, 

                                                CASE WHEN Perkiraan='131' and Lawan='807' THEN -1*B.DEBETRP ELSE B.DebetRp  DEBETRP, B.KREDITRP, 

       B.TIPETRANS, B.TPHC, B.CUSTSUPPP, B.CUSTSUPPL, B.KODEP, B.KODEL, B.NOAKTIVAP, B.NOAKTIVAL, B.STATUSAKTIVAP, B.STATUSAKTIVAL, B.NOBON, B.KODEBAG, 

       B.STATUSGIRO, 'KASBANK' JENIS, A.NOURUT

FROM DBO.DBTRANS A LEFT OUTER JOIN

     DBO.DBTRANSAKSI B ON B.NOBUKTI = A.NOBUKTI

where DebetRp+KreditRp<>0 and B.NoBukti like '%BMM%' and B.FlagSimbol<>'LB' and Perkiraan='131' and Lawan='807'   



UNION ALL



Select NoBukti, Tanggal, Devisi, Note, Lampiran, IsOtorisasi1, OtoUser1, TglOto1, IsOtorisasi2, OtoUser2, TglOto2, IsOtorisasi3, OtoUser3, TglOto3, IsOtorisasi4, OtoUser4, 

       TglOto4, IsOtorisasi5, OtoUser5, TglOto5, Urut, Perkiraan, Lawan, Keterangan, Keterangan2, Debet, Kredit, Valas, Kurs, DebetRp, KreditRp, TipeTrans, TPHC, 

       CustSuppP, CustSuppL, KodeP, KodeL, NoAktivaP, NoAktivaL, StatusAktivaP, StatusAktivaL, Nobon, KodeBag, StatusGiro, Jenis, NOURUT

From dbo.dbJurnalOto where DebetRp+KreditRp<>0 --and Jenis in ('HPR')

--select Jenis from DBJurnalOto group by Jenis



union all 



SELECT A.NOBUKTI, A.Tanggal,case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI, 

      'Opname : ' + A.NOBUKTI + ' ' + H.NamaSubGrp + ' (' + H.KodeSubGrp + ')' NOTE,0 LAMPIRAN, 

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) URUT,  

       Case when Sum(B.QNTDB)<>0 then H.PerkPers

            when Sum(B.QNTCR)<>0 then case when a.NOBUKTI like '%KRS%' then case when a.NOBUKTI in('CA/KRS/0121/00035','BCA/KRS/0121/00039') then '410' else J.Perkiraan 

            else '410'    PERKIRAAN, 

       Case when Sum(B.QNTDB)<>0 then case when a.NOBUKTI like '%KRS%' then case when a.NOBUKTI in('CA/KRS/0121/00035','BCA/KRS/0121/00039') then '410' else J.Perkiraan 

            else '410'  

            when Sum(B.QNTCR)<>0 then H.PerkPers

            else ''

        LAWAN, 

       'Opname : ' + + H.NamaSubGrp + ' (' + H.KodeSubGrp + ')'+CHAR(13)+ 

       'No. Opname : '+A.Nobukti+' TANGGAL : '+ Convert(Varchar(15),A.Tanggal, 105) +CHAR(13)+ 

       a.NOTE KETERANGAN, '' KETERANGAN2, 

       Sum(Case when B.QNTDB<>0 then B.QNTDB*CASE When F.KODEGRP='BM' then case when isnull(B.HARGA,0)=0 then isnull(B.HPP,0) else isnull(B.HARGA,0)  else case when a.NOBUKTI in('BCA/OPBJ/0621/0001','BCA/OPBJ/0621/0003','BCA/OPBJ/0621/0005','CA/OPBJ/0621/0002') then isnull(B.HARGA,0) else c1.HPPBrg   

                when B.QNTCR<>0 then B.QNTCR*case when a.NOBUKTI in('CA/KRS/0121/00035','BCA/KRS/0121/00039') then b.HARGA else case When ISNULL(c1.HPPBrg,0)<>0 Then c1.HPPBrg else B.HPP   

                else 0

           )  DEBET, 0 KREDIT, 'IDR' VALAS, 1 KURS, 

       Sum(Case when B.QNTDB<>0 then B.QNTDB*CASE When F.KODEGRP='BM' then case when isnull(B.HARGA,0)=0 then isnull(B.HPP,0) else isnull(B.HARGA,0)  else case when a.NOBUKTI in('BCA/OPBJ/0621/0001','BCA/OPBJ/0621/0003','BCA/OPBJ/0621/0005','CA/OPBJ/0621/0002') then isnull(B.HARGA,0) else c1.HPPBrg   

                when B.QNTCR<>0 then B.QNTCR*case when a.NOBUKTI in('CA/KRS/0121/00035','BCA/KRS/0121/00039') then b.HARGA else case When ISNULL(c1.HPPBrg,0)<>0 Then c1.HPPBrg else B.HPP   

                else 0

           ) DEBETRP, 0 KREDITRP, 'BJK' TIPETRANS, 'C' TPHC, '' CUSTCUPPP, '' CUSTSUPPL, '' KODEP, 

       '' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '01' KODEBAG, '' STATUSGIRO,  

      'ADJ' JENIS, A.NoUrutJurnal NOURUT

FROM  DBO.DBKOREKSI A 

LEFT OUTER JOIN DBO.DBKOREKSIDET B ON B.NOBUKTI = A.NOBUKTI 

LEFT OUTER JOIN DBO.DBBARANG F ON F.KODEBRG = B.KODEBRG LEFT OUTER JOIN DBO.DBGROUP G ON G.KODEGRP = F.KODEGRP

LEFT OUTER JOIN DBO.dbSubGroup H ON H.KodeGrp = F.KODEGRP and H.KodeSubGrp=F.KODESUBGRP

Left outer Join (select b.noBukti,a.KodeBrg,AVG(cast(Hrg as numeric(18,2)))Hpp 

                 from VwHrgRata2 a

                 Left Outer Join DBKOREKSIDET b On a.KodeBrg=b.kodebrg

                 Left Outer Join DBKOREKSI c On c.Nobukti=b.Nobukti

                 where a.Tanggal<=c.tanggal or ( MONTH(a.Tanggal)=MONTH(c.Tanggal) and YEAR(a.Tanggal)=YEAR(c.Tanggal))

                 Group by b.noBukti,a.KodeBrg

                )c2 On c2.KODEBRG=B.kodebrg and c2.Nobukti=A.Nobukti 

Left Outer Join dbHPPProduksi c1 on B.KODEBRG=c1.KodeBrg and MONTH(a.Tanggal)=c1.Bulan and YEAR(a.TANGGAL)=c1.Tahun

Left outer Join (select b.noBukti,a.KodeBrg,AVG(cast(Hrg as numeric(18,2)))Hpp 

                 from VwHrgRata2 a

                 Left Outer Join DBKOREKSIDET b On a.KodeBrg=b.kodebrg

                 Left Outer Join DBKOREKSI c On c.Nobukti=b.Nobukti

                 Group by b.noBukti,a.KodeBrg

                )d On d.KODEBRG=B.kodebrg and d.Nobukti=A.Nobukti 

Left Outer Join (Select Perkiraan 

                 from dbo.DBPOSTHUTPIUT 

                 where Kode='BYO') J on 1=1

Where A.NOBUKTI<>'' and B.QNTDB<>0 and ((MONTH(TANGGAL)=1 and YEAR(TANGGAL)=2020 and a.NOBUKTI not like '%OPBJ%' ) 

                                         or (((MONTH(TANGGAL)>1 and YEAR(TANGGAL)=2020) or (YEAR(TANGGAL)>2020)) and 1=1))

                                   and a.NOBUKTI not in ('BCA/KRS/1221/00118','BCA/KRS/0522/00068','BCA/KRS/1122/00201')

Group by A.NoJurnal, A.TglJurnal, H.KodeSubGrp,

      A.NOBUKTI, H.NamaSubGrp, H.KodeSubGrp,A.TANGGAL,

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       A.NoUrutJurnal,H.PerkPers, J.Perkiraan,a.NOTE



union all



SELECT A.NOBUKTI, A.Tanggal,case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI, 

      'Opname : ' + A.NOBUKTI + ' ' + H.NamaSubGrp + ' (' + H.KodeSubGrp + ')' NOTE,0 LAMPIRAN, 

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) URUT,  

       Case when Sum(B.QNTDB)<>0 then H.PerkPers

            when Sum(B.QNTCR)<>0 then case when a.NOBUKTI like '%KRS%' then case when a.NOBUKTI in('CA/KRS/0121/00035','BCA/KRS/0121/00039') then '410' else J.Perkiraan 

            else '410'    PERKIRAAN, 

       Case when Sum(B.QNTDB)<>0 then case when a.NOBUKTI like '%KRS%' then case when a.NOBUKTI in('CA/KRS/0121/00035','BCA/KRS/0121/00039') then '410' else J.Perkiraan 

            else '410'  

            when Sum(B.QNTCR)<>0 then H.PerkPers

            else ''

        LAWAN, 

       'Opname : ' + + H.NamaSubGrp + ' (' + H.KodeSubGrp + ')'+CHAR(13)+ 

       'No. Opname : '+A.Nobukti+' TANGGAL : '+ Convert(Varchar(15),A.Tanggal, 105)  +CHAR(13)+ 

       a.NOTE KETERANGAN, '' KETERANGAN2, 

       case when (a.NOBUKTI='BCA/OPN/1020/0002' and H.PerkPers='155') then 192264931.31

       else Sum(Case when B.QNTDB<>0 then B.QNTDB*CASE When F.KODEGRP='BM' then case when isnull(B.HARGA,0)=0 then isnull(B.HPP,0) else isnull(B.HARGA,0)  else c1.HPPBrg  

                when B.QNTCR<>0 then B.QNTCR*case when a.NOBUKTI in('CA/KRS/0121/00035','BCA/KRS/0121/00039','BCA/OPBJ/0621/0001','BCA/OPBJ/0621/0002','BCA/OPBJ/0621/0004','BCA/OPBJ/0621/0006','CA/OPN/0621/0002','CA/OPBJ/0621/0003') then b.HARGA else case When ISNULL(c1.HPPBrg,0)<>0 Then c1.HPPBrg else B.HPP   

                else 0

           )   DEBET, 0 KREDIT, 'IDR' VALAS, 1 KURS, 

       case when (a.NOBUKTI='BCA/OPN/1020/0002' and H.PerkPers='155') then 192264931.31

       else Sum(Case when B.QNTDB<>0 then B.QNTDB*CASE When F.KODEGRP='BM' then case when isnull(B.HARGA,0)=0 then isnull(B.HPP,0) else isnull(B.HARGA,0)  else c1.HPPBrg  

                when B.QNTCR<>0 then B.QNTCR*case when a.NOBUKTI in('CA/KRS/0121/00035','BCA/KRS/0121/00039','BCA/OPBJ/0621/0001','BCA/OPBJ/0621/0002','BCA/OPBJ/0621/0004','BCA/OPBJ/0621/0006','CA/OPN/0621/0002','CA/OPBJ/0621/0003') then b.HARGA else case When ISNULL(c1.HPPBrg,0)<>0 Then c1.HPPBrg else B.HPP   

                else 0

           )   DEBETRP, 0 KREDITRP, 'BJK' TIPETRANS, 'C' TPHC, '' CUSTCUPPP, '' CUSTSUPPL, '' KODEP, 

       '' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '01' KODEBAG, '' STATUSGIRO,  

      'ADJ' JENIS, A.NoUrutJurnal NOURUT

FROM  DBO.DBKOREKSI A 

LEFT OUTER JOIN DBO.DBKOREKSIDET B ON B.NOBUKTI = A.NOBUKTI 

LEFT OUTER JOIN DBO.DBBARANG F ON F.KODEBRG = B.KODEBRG LEFT OUTER JOIN DBO.DBGROUP G ON G.KODEGRP = F.KODEGRP

LEFT OUTER JOIN DBO.dbSubGroup H ON H.KodeGrp = F.KODEGRP and H.KodeSubGrp=F.KODESUBGRP

Left outer Join (select b.noBukti,a.KodeBrg,AVG(cast(Hrg as numeric(18,2)))Hpp 

                 from VwHrgRata2 a

                 Left Outer Join DBKOREKSIDET b On a.KodeBrg=b.kodebrg

                 Left Outer Join DBKOREKSI c On c.Nobukti=b.Nobukti

                 where a.Tanggal<=c.tanggal or ( MONTH(a.Tanggal)=MONTH(c.Tanggal) and YEAR(a.Tanggal)=YEAR(c.Tanggal))

                 Group by b.noBukti,a.KodeBrg

                )c2 On c2.KODEBRG=B.kodebrg and c2.Nobukti=A.Nobukti 

Left Outer Join dbHPPProduksi c1 on B.KODEBRG=c1.KodeBrg and MONTH(a.Tanggal)=c1.Bulan and YEAR(a.TANGGAL)=c1.Tahun

Left outer Join (select b.noBukti,a.KodeBrg,AVG(cast(Hrg as numeric(18,2)))Hpp 

                 from VwHrgRata2 a

                 Left Outer Join DBKOREKSIDET b On a.KodeBrg=b.kodebrg

                 Left Outer Join DBKOREKSI c On c.Nobukti=b.Nobukti

                 Group by b.noBukti,a.KodeBrg

                )d On d.KODEBRG=B.kodebrg and d.Nobukti=A.Nobukti 

Left Outer Join (Select Perkiraan 

                 from dbo.DBPOSTHUTPIUT 

                 where Kode='BYO') J on 1=1

Where A.NOBUKTI<>'' and B.QNTCR<>0 and ((MONTH(TANGGAL)=1 and YEAR(TANGGAL)=2020 and a.NOBUKTI not like '%OPBJ%' ) 

                                         or (((MONTH(TANGGAL)>1 and YEAR(TANGGAL)=2020) or (YEAR(TANGGAL)>2020)) and 1=1))

                                   and a.NOBUKTI not in ('BCA/KRS/1221/00118','BCA/KRS/0522/00068','BCA/KRS/1122/00201','BCA/KRS/0223/00045','BCA/KRS/0323/00061','BCA/KRS/0423/00018')

Group by A.NoJurnal, A.TglJurnal, H.KodeSubGrp,

      A.NOBUKTI, H.NamaSubGrp, H.KodeSubGrp,A.TANGGAL,

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       A.NoUrutJurnal,H.PerkPers, J.Perkiraan,a.NOTE



Union ALL



SELECT A.NoJurnal NOBUKTI, A.Tanggal,case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI, 

      'Ubah Kemasan : ' + A.NOBUKTI + ' ' + H.NamaSubGrp + ' (' + H.KodeSubGrp + ')' NOTE,0 LAMPIRAN, 

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) URUT,  

       Case when Sum(B.QNTDB)<>0 then J.Perkiraan

            when Sum(B.QNTCR)<>0 then H.PerkPers

            else ''

         PERKIRAAN, 

       Case when Sum(B.QNTDB)<>0 then H.PerkPers

            when Sum(B.QNTCR)<>0 then J.Perkiraan

            else ''

        LAWAN, 

       'Ubah Kemasan : ' + + H.NamaSubGrp + ' (' + H.KodeSubGrp + ')'+CHAR(13)+ 

       'No. Ubah Kemasan : '+A.Nobukti+' TANGGAL : '+ Convert(Varchar(15),A.Tanggal, 105)KETERANGAN, '' KETERANGAN2, 

       Sum(Case when B.QNTDB<>0 then B.QNTDB 

                when B.QNTCR<>0 then B.QNTCR

                else 0

            * B.HPP) DEBET, 0 KREDIT, 'IDR' VALAS, 1 KURS, 

       Sum(Case when B.QNTDB<>0 then B.QNTDB 

                when B.QNTCR<>0 then B.QNTCR

                else 0

            * B.HPP) DEBETRP, 0 KREDITRP, 'BJK' TIPETRANS, 'C' TPHC, '' CUSTCUPPP, '' CUSTSUPPL, '' KODEP, 

       '' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '01' KODEBAG, '' STATUSGIRO,  

      'UKM' JENIS, A.NoUrutJurnal NOURUT

FROM  DBO.DBUBAHKEMASAN A 

LEFT OUTER JOIN DBO.DBUBAHKEMASANDET B ON B.NOBUKTI = A.NOBUKTI 

LEFT OUTER JOIN DBO.DBBARANG F ON F.KODEBRG = B.KODEBRG LEFT OUTER JOIN DBO.DBGROUP G ON G.KODEGRP = F.KODEGRP

LEFT OUTER JOIN DBO.dbSubGroup H ON H.KodeGrp = F.KODEGRP and H.KodeSubGrp=F.KODESUBGRP

Left Outer Join (Select Perkiraan 

                 from dbo.DBPOSTHUTPIUT 

                 where Kode='BYO') J on 1=1

Where A.noJurnal<>''

Group by A.NoJurnal, A.TglJurnal, H.KodeSubGrp,

      A.NOBUKTI, H.NamaSubGrp, H.KodeSubGrp,A.TANGGAL,

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       A.NoUrutJurnal,H.PerkPers, J.Perkiraan

 -----------------------------------------------



Union All


SELECT A.Nobukti NOBUKTI, A.Tanggal TANGGAL,case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI, 

       dbo.fnc_NamaBrg(A.NOBUKTI,LEFT(B.KodeBrg,8)) NOTE,0 LAMPIRAN, 

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) URUT,  

       a.NoJurnal PERKIRAAN, 

       PerkPers  LAWAN, 

       dbo.fnc_NamaBrg(A.NOBUKTI,LEFT(B.KodeBrg,8)) KETERANGAN, '' KETERANGAN2, 

       case when a.nobukti='BCA/BP/1020/0215' then 50600 

       when a.nobukti='BCA/BP/1020/0271' then 126500

       when a.nobukti='BCA/BP/1020/0364' then 121250 

        else Sum(B.Qnt * isnull(B.HPP,0) )  DEBET, 0 KREDIT, 'IDR' VALAS, 1 KURS, 

       case when a.nobukti='BCA/BP/1020/0215' then 50600 

       when a.nobukti='BCA/BP/1020/0271' then 126500

       when a.nobukti='BCA/BP/1020/0364' then 121250 

       else Sum(B.Qnt * isnull(B.HPP,0) )  DEBETRP, 0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, '' CUSTSUPPP, '' CUSTSUPPL, '' KODEP, 

       '' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, A.KdDep, '' STATUSGIRO,

        'PMK' JENIS, A.NoUrutJurnal NOURUT

FROM  DBO.DBPenyerahanBhn A 

LEFT OUTER JOIN DBO.DBPenyerahanBhnDET B ON B.NOBUKTI = A.NOBUKTI 

Left Outer Join (select b.noBukti,a.KodeBrg,AVG(cast(Hrg as numeric(18,2)))Hrg 

                 from VwHrgRata2 a

                 Left Outer Join DBPenyerahanBhnDET b On a.KodeBrg=b.kodebrg

                 Left Outer Join DBPenyerahanBhn c On c.Nobukti=b.Nobukti

                 where a.Tanggal<=c.tanggal  or ( MONTH(a.Tanggal)=MONTH(c.Tanggal) and YEAR(a.Tanggal)=YEAR(c.Tanggal))

                 Group by b.noBukti,a.KodeBrg)B1 On B1.KODEBRG=B.kodebrg and B1.Nobukti=A.Nobukti

LEFT OUTER JOIN DBO.DBBARANG F ON F.KODEBRG = B.KODEBRG 

LEFT OUTER JOIN DBO.DBGROUP G ON G.KODEGRP = F.KODEGRP

LEFT OUTER JOIN DBO.dbSubGroup H ON H.KodeSubGrp = F.KODESUBGRP and H.KodeGrp=F.KODEGRP 

Group by A.NoJurnal, A.TglJurnal, 

      A.NOBUKTI, H.NamaSubGrp, H.KodeSubGrp,A.TANGGAL,

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       H.PerkPPN, H.PerkPers,A.NoUrutJurnal,A.NoJurnal,A.KdDep,LEFT(B.KodeBrg,8);

-- vwTransLunasUMHutPiut
CREATE VIEW IF NOT EXISTS vwTransLunasUMHutPiut AS select A.NoBukti, A.NoUrut, A.TipeTrans TipeTransL, A.Tanggal, A.Devisi, A.KodeCustSupp, 

	Cs.NAMACUSTSUPP,

	Cs.ALAMATKOTA Alamat, Cs.ALAMATKOTA, Cs.KOTA, Cs.NamaKota,

	A.NoUangMuka, A.Valas ValasL, A.Kurs KursL, A.Keterangan, A.CetakKe,  

	A.IDUser, 

	A.IsOtorisasi1, A.OtoUser1, A.TglOto1, 

	A.IsOtorisasi2, A.OtoUser2, A.TglOto2, 

	A.IsOtorisasi3, A.OtoUser3, A.TglOto3, 

	A.IsOtorisasi4, A.OtoUser4, A.TglOto4, 

	A.IsOtorisasi5, A.OtoUser5, A.TglOto5,

	Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                       Case when A.IsOtorisasi2=1 then 1 else 0 +

                       Case when A.IsOtorisasi3=1 then 1 else 0 +

                       Case when A.IsOtorisasi4=1 then 1 else 0 +

                       Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                  else 1

              As INTEGER) NeedOtorisasi,  

	A.NoJurnal, A.NoUrutJurnal, A.TglJurnal, A.MaxOL,

	B.NoFaktur, B.NoRetur, B.TipeTrans, B.NoMsk, B.Urut, B.JatuhTempo, 

	B.Debet, B.Kredit, B.Saldo, B.Valas, B.Kurs, 

	B.DebetD, B.KreditD, B.SaldoD, B.KodeSales, 

	B.Tipe, B.Perkiraan, B.Catatan, B.MyID, 

	B.NOINVOICE, B.TGLINVOICE, B.NOPAJAK, B.TGLFPJ, 

	B.KodeVls_, B.Kurs_, B.KursBayar, B.FlagSimbol, B.KBLB 

from dbLunasUMHutPiut A

left outer join DBHUTPIUT B on B.NOBUKTI=A.NOBUKTI

left outer join vwCUSTSUPP Cs on Cs.KODECUSTSUPP=A.KodeCustSupp;

-- vwUserOto
CREATE VIEW IF NOT EXISTS vwUserOto AS select a.UserId,b.ACCESS,b.OL,IsOtorisasi1,IsOtorisasi2,IsOtorisasi3,IsOtorisasi4,IsOtorisasi5 from dbflmenu  a

Left Outer Join DBMENU  b on a.L1=b.KODEMENU;

-- vwValas
CREATE VIEW IF NOT EXISTS vwValas AS Select A.KODEVLS,A.NAMAVLS,A.Simbol,B.Tanggal,B.Kurs 

from dbVALAS A

     left Outer join DBVALASDET B on B.Kodevls=A.KODEVLS;

-- VwVerifikasi
CREATE VIEW IF NOT EXISTS VwVerifikasi AS SELECT     NOBUKTI AS noBP, TANGGAL AS tglbp, NOSPB, TGLSPB, KODECUSTSUPP

FROM         dbo.DBBELI AS a;

-- =============================================

-- =============================================
-- END OF VIEWS
-- =============================================