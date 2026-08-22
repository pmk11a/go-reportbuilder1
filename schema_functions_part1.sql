-- =============================================
-- DAPEN Backend - SQLite Schema
-- Auto-generated from dbbcagroup SQL Server
-- Total routines: 478
-- =============================================

/* ============================================= */
/* FUNCTIONS (81) */
/* ============================================= */

-- BeliAkhir (FUNCTION)
CREATE FUNCTION IF NOT EXISTS BeliAkhir AS -- DECLARE REMOVED

  Select @Total= harga from 

                 ( select top 1 harga from (

                   select case when NOSAT>1 then (a.HARGA*a.KURS)/case when COALESCE(a.ISI,0)<=0 then 1 else COALESCE(a.ISI,1)  else a.HARGA*a.KURS  harga,TANGGAL 

                   from DBBELIDET a

                   left outer join DBBELI b on b.NOBUKTI=a.NOBUKTI

                   where KODEBRG=@KodeBrg and TANGGAL<=@Tgl

                   union all

                   select   

                   case when NOSAT>1 then (a.HARGA*a.KURS)/case when COALESCE(a.ISI,0)<=0 then 1 else COALESCE(a.ISI,1)  else a.HARGA*a.KURS  harga,TANGGAL 

                   from DBCA..DBBELIDET a

                   left outer join DBCA..DBBELI b on b.NOBUKTI=a.NOBUKTI

                   left outer join DBBARANG c on c.NamaBrg2=a.KODEBRG

                   where ((c.KODEBRG=@KodeBrg and COALESCE(c.NamaBrg2,'')<>'') or (a.KODEBRG=@KodeBrg and COALESCE(c.NamaBrg2,'')='' )) and TANGGAL<=@Tgl

                   ) Z order by TANGGAL desc 

                 ) a

  Return @Total;

-- BeliAtas (FUNCTION)
CREATE FUNCTION IF NOT EXISTS BeliAtas AS -- DECLARE REMOVED

  Select @Total= harga from 

                 ( select top 1 harga from (

                   select case when NOSAT>1 then (a.HARGA*a.KURS)/case when COALESCE(a.ISI,0)<=0 then 1 else COALESCE(a.ISI,1)  else a.HARGA*a.KURS  harga,TANGGAL 

                   from DBBELIDET a

                   left outer join DBBELI b on b.NOBUKTI=a.NOBUKTI

                   where KODEBRG=@KodeBrg and TANGGAL>@Tgl

                   union all

                   select   

                   case when NOSAT>1 then (a.HARGA*a.KURS)/case when COALESCE(a.ISI,0)<=0 then 1 else COALESCE(a.ISI,1)  else a.HARGA*a.KURS  harga,TANGGAL 

                   from DBCA..DBBELIDET a

                   left outer join DBCA..DBBELI b on b.NOBUKTI=a.NOBUKTI

                   left outer join DBBARANG c on c.NamaBrg2=a.KODEBRG

                   where ((c.KODEBRG=@KodeBrg and COALESCE(c.NamaBrg2,'')<>'') or (a.KODEBRG=@KodeBrg and COALESCE(c.NamaBrg2,'')='' )) and TANGGAL>@Tgl

                   ) Z order by TANGGAL asc 

                 ) a

  Return @Total;

-- BlnJurnalOto (FUNCTION)
CREATE FUNCTION IF NOT EXISTS BlnJurnalOto AS -- DECLARE REMOVED

  Select @Thn=case when @Nobukti='' then Bln  from TempJurnalOtoPeriode 

  Return @Thn;

-- DataBP (FUNCTION)
CREATE FUNCTION IF NOT EXISTS DataBP AS -- =============================================

-- Author:		Noviyanto

-- Create date: 02 agustus 2012

-- Description:	Get String NoBP

-- =============================================

-- DECLARE REMOVED, @The_BP varchar(8000), @Counter int, @i int

  Select @Counter=COUNT(NoBeli) from DBO.dbInvoiceDet where NoBukti=@NoTT 

  -- SET REMOVED1

  -- SET REMOVED'' 

  Declare Mydata Cursor For

  Select NoBeli

  From DBO.dbInvoiceDet

  where NoBukti=@NoTT

  open Mydata 

  Fetch next from mydata Into @NoBP

  While @@FETCH_STATUS=0

  if @Counter=@i 

       -- SET REMOVED@The_BP+@noBP

    else 

       -- SET REMOVED@The_BP+@noBP+', '



    ---- SET REMOVED@i+1

    Fetch next from mydata Into @NoBP

    -- SET REMOVED@i+1

  

  Close Mydata

  Deallocate mydata 	

  Return @The_BP;

-- DataPostHutPiut (FUNCTION)
CREATE FUNCTION IF NOT EXISTS DataPostHutPiut AS -- =============================================

-- Author:		Noviyanto

-- Create date: 02 agustus 2012

-- Description:	Get String NoBP

-- =============================================

-- DECLARE REMOVED, @The_BP varchar(8000), @Counter int, @i int

  Select @Counter=COUNT(KodeCustSupp) 

from dbo.dbPerkCustSupp  a

     --left outer join dbo.dbPosthutPiut b on b.Perkiraan=a.Perkiraan

     left Outer Join dbo.dbPerkiraan c on c.Perkiraan=a.Perkiraan

where a.KodeCustsupp=@KodeCustSupp --and B.Kode=@TipeTrans



  -- SET REMOVED1

  -- SET REMOVED'' 

  Declare Mydata Cursor For

  select COALESCE(c.Keterangan,'')+' ('+a.Perkiraan+')' NamaPerkiraan

  from dbo.dbPerkCustSupp  a

     --left outer join dbo.dbPosthutPiut b on b.Perkiraan=a.Perkiraan

     left Outer Join dbo.dbPerkiraan c on c.Perkiraan=a.Perkiraan

  where a.KodeCustsupp=@KodeCustSupp --and b.Kode=@TipeTrans



  open Mydata 

  Fetch next from mydata Into @NoBP

  While @@FETCH_STATUS=0

  if @Counter=@i 

       -- SET REMOVED@The_BP+@noBP

    else 

       -- SET REMOVED@The_BP+@noBP+CHAR(13)



    ---- SET REMOVED@i+1

    Fetch next from mydata Into @NoBP

    -- SET REMOVED@i+1

  

  Close Mydata

  Deallocate mydata 	

  Return @The_BP;

-- DP (FUNCTION)
CREATE FUNCTION IF NOT EXISTS DP AS -- DECLARE REMOVED

  if @Id=''

  Select @DP=(sum(a.Debet)-sum(a.Kredit))*-1 

 	             from vwHutpiut a

 	             left outer join DBCUSTSUPP b on(a.KodeCustSupp=b.KodeCustSupp)

 	             where  a.tanggal<=@SmpTgl and a.perkiraan='131' and a.KodeCustSupp=@KODECUSTSUPP 

 	                  --  and a.Devisi=case when a.KodeCustSupp not like '%@ca' then '01' else '02' 

 	             group by a.KodeCustSupp having (sum(a.Debet)-sum(a.Kredit)) <0

   else

  if @Id='B'

  Select @DP=(sum(a.Debet)-sum(a.Kredit))*-1 

 	             from vwHutpiut a

 	             left outer join DBCUSTSUPP b on(a.KodeCustSupp=b.KodeCustSupp)

 	             where a.KodeCustSupp not like '%@ca' and  a.tanggal<=@SmpTgl and a.perkiraan='131' and a.KodeCustSupp=@KODECUSTSUPP

        	            -- and a.Devisi=case when a.KodeCustSupp not like '%@ca' then '01' else '02' 

 	             group by a.KodeCustSupp having (sum(a.Debet)-sum(a.Kredit)) <0  

   else

  Select @DP=(sum(a.Debet)-sum(a.Kredit))*-1 

 	             from vwHutpiut a

 	             left outer join DBCUSTSUPP b on(a.KodeCustSupp=b.KodeCustSupp)

 	             where a.KodeCustSupp like '%@ca' and  a.tanggal<=@SmpTgl and a.perkiraan='131' and a.KodeCustSupp=@KODECUSTSUPP

        	             --and a.Devisi=case when a.KodeCustSupp not like '%@ca' then '01' else '02' 

 	             group by a.KodeCustSupp having (sum(a.Debet)-sum(a.Kredit)) <0    


  Return @DP;

-- fn_diagramobjects (FUNCTION)
CREATE FUNCTION IF NOT EXISTS fn_diagramobjects AS N'dbo'

	AS

	-- DECLARE REMOVED

		-- DECLARE REMOVED

		-- DECLARE REMOVED

		-- DECLARE REMOVED

		-- DECLARE REMOVED

		-- DECLARE REMOVED

		-- DECLARE REMOVED 

		-- DECLARE REMOVED

		-- DECLARE REMOVED



		select @InstalledObjects = 0



		select 	@id_upgraddiagrams = object_id(N'dbo.sp_upgraddiagrams'),

			@id_sysdiagrams = object_id(N'dbo.sysdiagrams'),

			@id_helpdiagrams = object_id(N'dbo.sp_helpdiagrams'),

			@id_helpdiagramdefinition = object_id(N'dbo.sp_helpdiagramdefinition'),

			@id_creatediagram = object_id(N'dbo.sp_creatediagram'),

			@id_renamediagram = object_id(N'dbo.sp_renamediagram'),

			@id_alterdiagram = object_id(N'dbo.sp_alterdiagram'), 

			@id_dropdiagram = object_id(N'dbo.sp_dropdiagram')



		if @id_upgraddiagrams is not null

			select @InstalledObjects = @InstalledObjects + 1

		if @id_sysdiagrams is not null

			select @InstalledObjects = @InstalledObjects + 2

		if @id_helpdiagrams is not null

			select @InstalledObjects = @InstalledObjects + 4

		if @id_helpdiagramdefinition is not null

			select @InstalledObjects = @InstalledObjects + 8

		if @id_creatediagram is not null

			select @InstalledObjects = @InstalledObjects + 16

		if @id_renamediagram is not null

			select @InstalledObjects = @InstalledObjects + 32

		if @id_alterdiagram  is not null

			select @InstalledObjects = @InstalledObjects + 64

		if @id_dropdiagram is not null

			select @InstalledObjects = @InstalledObjects + 128

		

		return @InstalledObjects;

-- fnc_JurnalBP (FUNCTION)
CREATE FUNCTION IF NOT EXISTS fnc_JurnalBP AS RETURN 

(SELECT A.NoJurnal NOBUKTI, A.TglJurnal TANGGAL,

      A.Devisi,--case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI,

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

FROM DBO.DBBELI A 

LEFT OUTER JOIN DBO.DBBELIDET B ON B.NOBUKTI = A.NOBUKTI 

LEFT OUTER JOIN DBO.VWBROWSSUPP D ON D.KODECUSTSUPP = A.KODESUPP

Left Outer join dbo.DBPERKCUSTSUPP D1 on D1.KODECUSTSUPP=A.KODESUPP and D1.Perkiraan=Case When A.TIPEBAYAR=0 Then '332' else '331'  

Left Outer Join dbo.DBBARANG E on E.KODEBRG=B.KODEBRG

Left Outer join dbo.dbSubGroup F on F.KodeGrp=E.KODEGRP and F.KodeSubGrp=E.KODESUBGRP

where A.NoJurnal<>'' and E.KodeGrp<>'JS' and A.NOBUKTI=@Nobukti 

GROUP BY A.NOBUKTI, A.TANGGAL, D.NAMACUSTSUPP, A.KODESUPP,

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5,

       F.PerkPers, D1.PERKIRAAN,  A.KODEVLS, A.KURS, A.NOURUT,

       B.NOPO,A.NoJurnal,A.TglJurnal, F.PerkH, A.NoUrutJurnal,A.Devisi



Union ALL



SELECT A.NoJurnal NOBUKTI, A.TglJurnal TANGGAL,

       A.Devisi,--case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI,

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

FROM DBO.DBBELI A 

LEFT OUTER JOIN DBO.DBBELIDET B ON B.NOBUKTI = A.NOBUKTI 

LEFT OUTER JOIN DBO.VWBROWSSUPP D ON D .KODECUSTSUPP = A.KODESUPP  

Left Outer join dbo.DBPERKCUSTSUPP D1 on D1.KODECUSTSUPP=A.KODESUPP and D1.Perkiraan=Case When A.TIPEBAYAR=0 Then '332' else '331'  

Left Outer Join dbo.DBBARANG E on E.KODEBRG=B.KODEBRG

Left Outer join dbo.dbSubGroup F on F.KodeGrp=E.KODEGRP and F.KodeSubGrp=E.KODESUBGRP

where A.NoJurnal<>'' and E.KodeGrp<>'JS'

and (A.NOBUKTI=@Nobukti) 

GROUP BY A.NOBUKTI, A.TANGGAL,a.Devisi, D.NAMACUSTSUPP, A.KODESUPP,

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5,

       F.PerkPPN, D1.PERKIRAAN,  A.KODEVLS, A.KURS, A.NOURUT,

       B.NOPO,A.NoJurnal,A.TglJurnal, F.PerkH, A.NoUrutJurnal



union all

 

SELECT A.NoJurnal NOBUKTI, A.TglJurnal TANGGAL,

       A.Devisi,--case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI,

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

       COALESCE(A1.Nilai,0) DEBET, 0 KREDIT, A.KODEVLS Valas, A.KURS, 

       COALESCE(A1.Nilai,0) DEBETRP, 0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, 

       '' CUSTSUPPP,'' CUSTSUPPL, '' KODEP, 

       '' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO, null MYID, 'BL' JENIS, A.NoUrutJurnal NOURUT

FROM DBO.DBBELI A 

LEFT OUTER JOIN DBO.DBBELIDET B ON B.NOBUKTI = A.NOBUKTI 

LEFT OUTER JOIN DBO.VWBROWSSUPP D ON D.KODECUSTSUPP = A.KODESUPP

Left Outer join dbo.DBPERKCUSTSUPP D1 on D1.KODECUSTSUPP=A.KODESUPP and D1.Perkiraan=Case When A.TIPEBAYAR=0 Then '332' else '331'  

Left Outer Join dbo.DBBARANG E on E.KODEBRG=B.KODEBRG

left Outer Join (select SUM(Nilai)Nilai,NoBuktiInv,Perkiraan 

                 from DBPBIAYA a left outer join DBBIAYA b on b.Kodebiaya=a.Kodebiaya 

                 Group By NoBuktiInv,Perkiraan)A1 On A1.NoBuktiInv=A.NOBUKTI

where A.NoJurnal<>'' and E.KodeGrp<>'JS'

and (A.NOBUKTI=@Nobukti) 

GROUP BY A.NOBUKTI, A.TANGGAL,a.Devisi, D.NAMACUSTSUPP, A.KODESUPP,

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

       A.Devisi,--case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI,

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

FROM DBO.DBBELI A 

LEFT OUTER JOIN DBO.DBBELIDET B ON B.NOBUKTI = A.NOBUKTI 

LEFT OUTER JOIN DBO.VWBROWSSUPP D ON D.KODECUSTSUPP = A.KODESUPP

Left Outer join dbo.DBPERKCUSTSUPP D1 on D1.KODECUSTSUPP=A.KODESUPP and D1.Perkiraan=Case When A.TIPEBAYAR=0 Then '332' else '331'  

Left Outer Join dbo.DBBARANG E on E.KODEBRG=B.KODEBRG

Left Outer join dbo.dbSubGroup F on F.KodeGrp=E.KODEGRP and F.KodeSubGrp=E.KODESUBGRP

where A.NoJurnal<>'' and E.KodeGrp='JS' and A.TIPEBAYAR=1

and (A.NOBUKTI=@Nobukti) 

GROUP BY A.NOBUKTI, A.TANGGAL,a.Devisi, D.NAMACUSTSUPP, A.KODESUPP,

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5,

       F.PerkPers, D1.PERKIRAAN,  A.KODEVLS, A.KURS, A.NOURUT,

       B.NOPO,A.NoJurnal,A.TglJurnal, F.PerkH, A.NoUrutJurnal


);

-- fnc_JurnalDebetNote (FUNCTION)
CREATE FUNCTION IF NOT EXISTS fnc_JurnalDebetNote AS -- =============================================

-- Author:		Noviyanto

-- Create date: 16-05-2013

-- Description:	Jurnal Debet Note

-- =============================================

RETURN 

(

SELECT A.NoJurnal NOBUKTI, A.TglJurnal TANGGAL,'01' DEVISI, 

      'Debet Note : ' + A.NOBUKTI +' TANGGAL : '+ CAST(A.Tanggal, 105 AS TEXT) NOTE,0 LAMPIRAN, 

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) URUT,  

       J.Perkiraan PERKIRAAN, 

       I.Perkiraan  LAWAN, 

       'Debet Note : ' + COALESCE(I.NAMACUSTSUPP,'') + ' (' + COALESCE(I.KODECUSTSUPP,'') + ')'+CHAR(13)+ 

       'No. Invoice : '+B.NoInv KETERANGAN, '' KETERANGAN2, 

       Sum(B.Nilai) DEBET, 0 KREDIT, B.KodeVLS VALAS, B.Kurs, 

       Sum(B.NilaiRp) DEBETRP, 0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, '' CUSTSUPPP, '' CUSTSUPPL, '' KODEP, 

       '' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '01' KODEBAG, '' STATUSGIRO, null MYID, 

       'KN' JENIS, A.NoUrutJurnal NOURUT

FROM  DBO.DBDebetNote A 

LEFT OUTER JOIN DBO.DBDebetNoteDET B ON B.NOBUKTI = A.NOBUKTI 

Left Outer join (Select x.NoFaktur, Min(x.Tanggal) Tanggal

                 From dbo.vwHutPiut x

                 where TipeTrans='T'

                 Group by x.NoFaktur) C on C.NoFaktur=B.NoInv

Left outer join dbo.vwBrowsSupp I on I.KODECUSTSUPP=A.KodeSupp 

Left Outer join (Select x.Perkiraan

                 from dbo.DBPOSTHUTPIUT x

                 where x.Kode='BD') J on 1=1

Where A.noJurnal<>'' and A.NoBukti=@Nobukti

Group by A.NoJurnal, A.TglJurnal,B.kodevls, B.Kurs,B.NoInv, C.Tanggal, 

      A.NOBUKTI,i.NAMACUSTSUPP, I.KODECUSTSUPP,A.TANGGAL,A.KodeSupp,

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       J.Perkiraan,I.PERKIRAAN,A.NoUrutJurnal

);

-- fnc_JurnalHasilPrd (FUNCTION)
CREATE FUNCTION IF NOT EXISTS fnc_JurnalHasilPrd AS RETURN 

(

SELECT A.NoJurnal NOBUKTI, A.TglJurnal TANGGAL,a.Devisi,--case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI, 

       A.NOBUKTI NOTE,0 LAMPIRAN, 

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) URUT,  

       H.PerkPers PERKIRAAN, '159' LAWAN,

       A.NOBUKTI KETERANGAN, '' KETERANGAN2, 

       Sum(case when B.NOSAT=1 then B.Qnt else B.Qnt*B.ISI *Case When COALESCE(HPP.HPP,0)=0 Then COALESCE(b.HPP,0) else COALESCE(HPP.HPP,0) ) DEBET, 0 KREDIT, 'IDR' VALAS, 1 KURS, 

       Sum(case when B.NOSAT=1 then B.Qnt else B.Qnt*B.ISI *Case When COALESCE(HPP.HPP,0)=0 Then COALESCE(b.HPP,0) else COALESCE(HPP.HPP,0) ) DEBETRP, 0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, '' CUSTSUPPP, '' CUSTSUPPL, '' KODEP, 

       '' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO, null MYID, 'HPR' JENIS, A.NoUrutJurnal NOURUT

FROM  DBO.DBHASILPRD A 

LEFT OUTER JOIN DBO.DBHASILPRDDet B ON B.NOBUKTI = A.NOBUKTI 

Left Outer Join (select Bulan,Tahun,KodeBrg,HPPBrg HPP from dbHPPProduksi) HPP on HPP.KODEBRG=b.KODEBRG and hpp.Bulan=month(A.TANGGAL) and hpp.Tahun=YEAR(a.TANGGAL)

LEFT OUTER JOIN DBO.DBBARANG F ON F.KODEBRG = B.KODEBRG 

LEFT OUTER JOIN DBO.DBGROUP G ON G.KODEGRP = F.KODEGRP

LEFT OUTER JOIN DBO.dbSubGroup H ON H.KodeSubGrp = F.KODESUBGRP and H.KodeGrp=F.KODEGRP

Where  A.NoBukti=@Nobukti and 

COALESCE(H.PerkPers,'')<>''

Group by A.NoJurnal, A.TglJurnal, 

      A.NOBUKTI, H.NamaSubGrp, H.KodeSubGrp,A.TANGGAL,

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       H.PerkPPN, H.PerkPers,A.NoUrutJurnal,A.NoJurnal,F.KODESUBGRP,a.Devisi

   

)



----------------------------

--USE [DBBCAGROUP050620];

-- fnc_JurnalHutang (FUNCTION)
CREATE FUNCTION IF NOT EXISTS fnc_JurnalHutang AS -- =============================================

-- Author:		Noviyanto

-- Create date: 17-04-2013

-- Description:	Jurnal Hutang

-- =============================================

RETURN 

(SELECT A.NoJurnal NOBUKTI, A.TglJurnal TANGGAL,'01' DEVISI, 

       D .NAMACUSTSUPP + ' (' + A.KODESUPP + ')'  NOTE,0 LAMPIRAN, 

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) URUT, 

       J.Perkiraan PERKIRAAN, F.Perkiraan LAWAN,

       'Invoice Pembelian SUPPLIER : '+D.NamaCustSupp+ ' (' + A.KODESUPP + ')'+CHAR(13)+       

       'NO. BP : '+DBO.DataBP(A.NOBUKTI)+CHAR(13) KETERANGAN, 

       '' KETERANGAN2, 

       SUM(B.NDPP) DEBET, 0 KREDIT, A.KODEVLS Valas, A.KURS, 

       SUM(B.NDPPRP) DEBETRP, 0 KREDITRP, 'PBL' TIPETRANS, 'C' TPHC, 

       '' CUSTSUPPP,'' CUSTSUPPL, '' KODEP, 

       '' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO, null MYID, 

       'INVBP' JENIS, A.NoUrutJurnal NOURUT

FROM DBO.DBInvoice A 

Left Outer join (Select y.NOBUKTI, SUM(x.NDPP) nDPP, SUM(x.NDPPRp) nDPPRp

                 from DBBELIDET x

                      left Outer join DBO.DBInvoiceDET y on y.NoBeli=x.NOBUKTI

                 GRoup by y.NOBUKTI) B ON B.NOBUKTI = A.NOBUKTI 

LEFT OUTER JOIN DBO.VWBROWSSUPP D ON D .KODECUSTSUPP = A.KODESUPP

Left Outer join (Select x.KodeCustSupp, x.Perkiraan 

                 from dbo.DBPERKCUSTSUPP x

                      left Outer join dbo.DBPOSTHUTPIUT y on y.Perkiraan=x.Perkiraan

                 where y.Kode='HT')F on F.KodeCustSupp=A.KodeSupp

Left Outer join (Select x.Perkiraan

                 from dbo.DBPOSTHUTPIUT x

                 where x.Kode='HTS') J on 1=1

where A.NoJurnal<>'' and A.NOBUKTI=@Nobukti

GROUP BY A.NOBUKTI, A.TANGGAL, D.NAMACUSTSUPP, A.KODESUPP,

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5,

       F.Perkiraan, D.PERKIRAAN,  A.KODEVLS, A.KURS, 

       A.NoJurnal,A.TglJurnal, J.Perkiraan, A.NoUrutJurnal

);

-- fnc_JurnalInvoicePL (FUNCTION)
CREATE FUNCTION IF NOT EXISTS fnc_JurnalInvoicePL AS -- =============================================

-- Author:		Noviyanto

-- ALter date: 06-05-2013

-- Description:	Jurnal Penjualan

-- =============================================

RETURN 

(SELECT A.NoJurnal NOBUKTI, A.TglJurnal TANGGAL,'01' DEVISI, 

      'Invoice Penjualan : ' + A.NOBUKTI +' TANGGAL : '+ CAST(A.Tanggal, 105 AS TEXT) NOTE,0 LAMPIRAN, 

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) URUT,  

       '103001' PERKIRAAN, 

       '401'  LAWAN, 

       'Invoice Penjualan : ' + COALESCE(I.NAMACUSTSUPP,'') + ' (' + COALESCE(I.KODECUSTSUPP,'') + ')'+CHAR(13)+ 

       'No. Invoice : '+A.Nobukti+' TANGGAL : '+ CAST(A.Tanggal, 105 AS TEXT) KETERANGAN, '' KETERANGAN2, 

       Sum(B.NDPP) DEBET, 0 KREDIT, A.VALAS, A.Kurs, 

       Sum(B.NDPPRp) DEBETRP, 0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, A.KodeCustSupp CUSTSUPPP, '' CUSTSUPPL, '' KODEP, 

       '' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '01' KODEBAG, '' STATUSGIRO, null MYID, 

       'INVPL' JENIS, A.NoUrutJurnal NOURUT

FROM  DBO.DBInvoicePL A 

LEFT OUTER JOIN DBO.dbInvoicePLDet B ON B.NOBUKTI = A.NOBUKTI 

LEFT OUTER JOIN DBO.DBBARANG F ON F.KODEBRG = B.KODEBRG 

--Left outer join dbo.vwBrowsCust I on I.KODECUSTSUPP=A.KodeCustSupp

Left outer join dbo.DBCUSTSUPP I on I.KODECUSTSUPP=A.KodeCustSupp

--Left Outer join (Select x.Perkiraan

--                 from dbo.DBPOSTHUTPIUT x

--                 where x.Kode='PTS') J on 1=1

Where A.noJurnal<>'' and A.NoBukti=@Nobukti

Group by A.NoJurnal, A.TglJurnal,A.Valas, A.Kurs, 

      A.NOBUKTI,i.NAMACUSTSUPP, I.KODECUSTSUPP,A.TANGGAL,A.KodeCustSupp,

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       --J.Perkiraan,I.PERKIRAAN,

       A.NoUrutJurnal

Union All

SELECT A.NoJurnal NOBUKTI, A.TglJurnal TANGGAL,'01' DEVISI, 

      'Invoice Penjualan : ' + A.NOBUKTI +' TANGGAL : '+ CAST(A.Tanggal, 105 AS TEXT) NOTE,0 LAMPIRAN, 

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) URUT,  

       I.Perkiraan PERKIRAAN, 

       J.Perkiraan  LAWAN, 

       'Faktur Pajak : ' + COALESCE(I.NAMACUSTSUPP,'') + ' (' + COALESCE(I.KODECUSTSUPP,'') + ')'+

       Case when A.NoPajak='' then '' else CHAR(13)+'No. FPJ : '+A.NoPajak+' TANGGAL : '+ COALESCE(CAST(A.TglFPJ, 105 AS TEXT),'')+CHAR(13)+

       'Atas No. Invoice : '+A.Nobukti+' TANGGAL : '+ CAST(A.Tanggal, 105 AS TEXT)  KETERANGAN, '' KETERANGAN2, 

       Sum(B.NPPN) DEBET, 0 KREDIT, A.VALAS, A.Kurs, 

       Sum(B.NPPNRp) DEBETRP, 0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, A.KodeCustSupp CUSTSUPPP, '' CUSTSUPPL, '' KODEP, 

       '' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '01' KODEBAG, '' STATUSGIRO, null MYID, 

       'FPJPL' JENIS, A.NoUrutJurnal NOURUT

FROM  DBO.DBInvoicePL A 

LEFT OUTER JOIN DBO.dbInvoicePLDet B ON B.NOBUKTI = A.NOBUKTI 

LEFT OUTER JOIN DBO.DBBARANG F ON F.KODEBRG = B.KODEBRG 

Left outer join dbo.vwBrowsCust I on I.KODECUSTSUPP=A.KodeCustSupp

Left Outer join (Select x.Perkiraan

                 from dbo.DBPOSTHUTPIUT x

                 where x.Kode='PPK') J on 1=1

Where A.noJurnal<>'' and A.NoBukti=@Nobukti

Group by A.NoJurnal, A.TglJurnal,A.Valas, A.Kurs,A.NoPajak, A.TglFPJ, A.KodeCustSupp,

      A.NOBUKTI,i.NAMACUSTSUPP, I.KODECUSTSUPP,A.TANGGAL,

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       J.Perkiraan,I.PERKIRAAN,A.NoUrutJurnal

       Having SUM(B.NPPN)<>0

);

-- fnc_JurnalInvoiceRPJ (FUNCTION)
CREATE FUNCTION IF NOT EXISTS fnc_JurnalInvoiceRPJ AS RETURN 

(SELECT A.NoJurnal NOBUKTI, A.TglJurnal TANGGAL,a.Devisi,--case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI,  

      'Retur Invoice Penjualan : ' + COALESCE(I.NAMACUSTSUPP,'') + ' (' + COALESCE(I.KODECUSTSUPP,'') + ')' NOTE,0 LAMPIRAN, 

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) URUT,  

       '503' PERKIRAAN, 

       '131'  LAWAN, 

       'Retur Invoice Penjualan : ' + A.NOBUKTI +' TANGGAL : '+ CAST(A.Tanggal, 105 AS TEXT)+CHAR(13)+ 

       'No. Invoice : '+A.NoInvoice+' TANGGAL : '+ CAST(A.TglInvoice, 105 AS TEXT) KETERANGAN, '' KETERANGAN2, 

       Sum(B.NDPP) DEBET, 0 KREDIT, A.Kodevls VALAS, A.Kurs, 

       Sum(B.NDPPRp) DEBETRP, 0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, '' CUSTSUPPP, A.KODECUSTSUPP CUSTSUPPL, '' KODEP, 

       '' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '01' KODEBAG, '' STATUSGIRO, A.MYID, 

       'INVRPJ' JENIS, A.NoUrutJurnal NOURUT

FROM  DBO.dbRInvoicePL A 

LEFT OUTER JOIN DBO.DBRInvoicePLDET B ON B.NOBUKTI = A.NOBUKTI 

LEFT OUTER JOIN DBO.DBBARANG F ON F.KODEBRG = B.KODEBRG 

Left outer join dbo.DBCUSTSUPP I on I.KODECUSTSUPP=A.KodeCustSupp

Left Outer join (Select x.Perkiraan

                 from dbo.DBPOSTHUTPIUT x

                 where x.Kode='PD') J on 1=1

Where A.noJurnal<>'' and (A.NOBUKTI=@Nobukti) 

Group by A.NoJurnal, A.TglJurnal,A.KODEVLS, A.Kurs, 

      A.NOBUKTI,i.NAMACUSTSUPP, I.KODECUSTSUPP,A.TANGGAL,A.KODECUSTSUPP,

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       J.Perkiraan,I.PERKIRAAN,A.NoUrutJurnal, A.MyID, A.NoInvoice,A.TglInvoice,a.Devisi



Union All



SELECT A.NoJurnal NOBUKTI, A.TglJurnal TANGGAL,a.Devisi,--case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI, 

      'Retur Invoice Penjualan : ' + COALESCE(I.NAMACUSTSUPP,'') + ' (' + COALESCE(I.KODECUSTSUPP,'') + ')' NOTE,0 LAMPIRAN, 

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int)+500 URUT,  

       '367' PERKIRAAN, 

       '131'  LAWAN, 

       'Retur Invoice Penjualan : ' + A.NOBUKTI +' TANGGAL : '+ CAST(A.Tanggal, 105 AS TEXT)+CHAR(13)+  

       'Faktur Pajak Retur : ' + COALESCE(I.NAMACUSTSUPP,'') + ' (' + COALESCE(I.KODECUSTSUPP,'') + ')'+

       Case when COALESCE(L.NOFPJ,'')='' then '' else CHAR(13)+'No. FPJ : '+L.NOFPJ+' TANGGAL : '+ COALESCE(CAST(L.TglFPJ, 105 AS TEXT),'')+CHAR(13)+

       'Atas No. Invoice : '+A.NoInvoice+' TANGGAL : '+ CAST(A.TglInvoice, 105 AS TEXT)  KETERANGAN, '' KETERANGAN2, 

       Sum(B.NPPNRP) DEBET, 0 KREDIT, A.KODEVLS VALAS, A.Kurs, 

       Sum(B.NPPNRP) DEBETRP, 0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, '' CUSTSUPPP, A.KODECUSTSUPP CUSTSUPPL, '' KODEP, 

       '' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '01' KODEBAG, '' STATUSGIRO, A.MYID, 

       'INVRPJ' JENIS, A.NoUrutJurnal NOURUT

FROM  DBO.dbRInvoicePL A 

LEFT OUTER JOIN (Select NoBukti,SUM(NPPNRp) NPPNRP From DBO.DBRInvoicePLDET Group by NoBukti) B ON B.NOBUKTI = A.NOBUKTI 

Left outer join dbo.DBCUSTSUPP I on I.KODECUSTSUPP=A.KodeCustSupp

Left Outer join (Select x.Perkiraan

                 from dbo.DBPOSTHUTPIUT x

                 where x.Kode='PPK') J on 1=1



Left Outer Join DBPajakMasuk L on L.NoBukti=A.NoBukti

Where A.noJurnal<>'' and (A.NOBUKTI=@Nobukti) 

Group by A.NoJurnal, A.TglJurnal,A.KODECUSTSUPP,A.KODEVLS, A.Kurs,L.NOFPJ, L.TglFPJ,A.KODECUSTSUPP, 

      A.NOBUKTI,i.NAMACUSTSUPP, I.KODECUSTSUPP,A.TANGGAL,

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       J.Perkiraan,I.PERKIRAAN,A.NoUrutJurnal, A.MyID, A.NoInvoice,A.TglInvoice,a.Devisi

Having SUM(B.NPPNRP)<>0

);

-- fnc_JurnalKreditNote (FUNCTION)
CREATE FUNCTION IF NOT EXISTS fnc_JurnalKreditNote AS -- =============================================

-- Author:		Noviyanto

-- Create date: 16-05-2013

-- Description:	Jurnal Kredit Note

-- =============================================

RETURN 

(

SELECT A.NoJurnal NOBUKTI, A.TglJurnal TANGGAL,'01' DEVISI, 

      'Kredit Note : ' + A.NOBUKTI +' TANGGAL : '+ CAST(A.Tanggal, 105 AS TEXT) NOTE,0 LAMPIRAN, 

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) URUT,  

       J.Perkiraan PERKIRAAN, 

       I.Perkiraan  LAWAN, 

       'Kredit Note : ' + COALESCE(I.NAMACUSTSUPP,'') + ' (' + COALESCE(I.KODECUSTSUPP,'') + ')'+CHAR(13)+ 

       'No. Invoice : '+B.NoInv+' TANGGAL : '+ CAST(C.Tanggal, 105 AS TEXT) KETERANGAN, '' KETERANGAN2, 

       Sum(B.Nilai) DEBET, 0 KREDIT, B.KodeVLS VALAS, B.Kurs, 

       Sum(B.NilaiRp) DEBETRP, 0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, '' CUSTSUPPP, '' CUSTSUPPL, '' KODEP, 

       '' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '01' KODEBAG, '' STATUSGIRO, null MYID, 

       'KN' JENIS, A.NoUrutJurnal NOURUT

FROM  DBO.DBKreditNote A 

LEFT OUTER JOIN DBO.DBKreditNoteDET B ON B.NOBUKTI = A.NOBUKTI 

Left Outer join (Select x.NoFaktur,Min(x.Tanggal) Tanggal

                 From dbo.vwHutPiut x

                 where TipeTrans='T'

                 Group by x.NoFaktur) C on C.NoFaktur=B.NoInv

Left outer join dbo.vwBrowsCust I on I.KODECUSTSUPP=A.KodeSupp

Left Outer join (Select x.Perkiraan

                 from dbo.DBPOSTHUTPIUT x

                 where x.Kode='BK') J on 1=1

Where A.noJurnal<>'' and A.NoBukti=@Nobukti

Group by A.NoJurnal, A.TglJurnal,B.kodevls, B.Kurs,B.NoInv, C.Tanggal, 

      A.NOBUKTI,i.NAMACUSTSUPP, I.KODECUSTSUPP,A.TANGGAL,

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       J.Perkiraan,I.PERKIRAAN,A.NoUrutJurnal

);

-- fnc_JurnalPenjualan (FUNCTION)
CREATE FUNCTION IF NOT EXISTS fnc_JurnalPenjualan AS RETURN 

(SELECT A.NoJurnal NOBUKTI, A.TglJurnal TANGGAL,

       A.Devisi,--case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI,

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

       case when a.NoBukti='BCB/INVC/0720/00014' then 41263750 

            when a.NoBukti='BCA/INVC/0720/00015' then 134011581

            when a.NoBukti='BCB/INVC/1020/00013' then 180396000   

            when a.NoBukti='BCB/INVC/1120/00018' then 225000000   

            when a.NoBukti='BCB/INVC/1120/00019' then 750000

            when a.NoBukti='BCB/INVC/1220/00010' then 97135000

            when a.NoBukti='BCB/INVC/1220/00011' then 104620000

            when a.NoBukti='BCB/INVC/1220/00012' then 33453800  

            when a.NoBukti='CB/INVC/0221/00004' then 128660000  

            when a.NoBukti='BCB/INVC/0521/00006' then 26701250

            when a.NoBukti='CB/INVC/0621/00002' then 19525000 

            when a.NoBukti='BCA/INVC/0921/00026' then 56316900

            when a.NoBukti='BCA/INVC/0622/00013' then 192000000

            when a.NoBukti='BCB/INVC/0323/00022' then 3360000

       else

       case when COALESCE(SO.PPH22,0)<>0 Then 

       (Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))

       else

       Sum(B.NDPPRp)   DEBET,

        0 KREDIT, 'IDR' Valas, 1 KURS, 

       case when a.NoBukti='BCB/INVC/0720/00014' then 41263750 

            when a.NoBukti='BCA/INVC/0720/00015' then 134011581

            when a.NoBukti='BCB/INVC/1020/00013' then 180396000

            when a.NoBukti='BCB/INVC/1120/00018' then 225000000   

            when a.NoBukti='BCB/INVC/1120/00019' then 750000

            when a.NoBukti='BCB/INVC/1220/00010' then 97135000

            when a.NoBukti='BCB/INVC/1220/00011' then 104620000

            when a.NoBukti='BCB/INVC/1220/00012' then 33453800 

            when a.NoBukti='CB/INVC/0221/00004' then 128660000  

            when a.NoBukti='BCB/INVC/0521/00006' then 26701250

            when a.NoBukti='CB/INVC/0621/00002' then 19525000  

            when a.NoBukti='BCA/INVC/0921/00026' then 56316900 

            when a.NoBukti='BCA/INVC/0622/00013' then 192000000 

            when a.NoBukti='BCB/INVC/0323/00022' then 3360000     

       else

       case when COALESCE(SO.PPH22,0)<>0 Then 

       (Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))

       else

       Sum(B.NDPPRp)   DEBETRP,

        0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, 

       '' CUSTSUPPP,'' CUSTSUPPL, '' KODEP,'' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, 

       '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO,

       null MYID, 'BP' JENIS, A.NoUrutJurnal NOURUT

FROM dbo.dbInvoicePL A  

Left Outer Join dbInvoicePLDet b on b.NoBukti=a.NoBukti

left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti

Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO                 

LEFT OUTER JOIN DBO.dbCustSupp D ON D .KODECUSTSUPP = A.KodeCustSupp

where A.NoJurnal<>'' and (A.NOBUKTI=@Nobukti) and B.NoSPB Not Like '%SJB%' and B.NoSPB not like '%SPBB%' and b.Namabrg not like '%Jasa%'

--and so.NOBUKTI not in (select NOBUKTI from TempSOTerpasang) 

GROUP BY A.NOBUKTI, A.TANGGAL,A.DEVISI,D.NAMACUSTSUPP,A.KodeCustSupp,so.PPH22,so.PPHDPP,so.Retensi,rpInv.TotNet,

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5,

       A.NOURUT,COALESCE(A.PPh21,0),COALESCE(D.IsPPH21,0),COALESCE(NTotal,0),

       A.NoJurnal,A.TglJurnal, A.NoUrutJurnal,A.PPN,A.DP

/*union all

SELECT A.NoJurnal NOBUKTI, A.TglJurnal TANGGAL,

       A.Devisi,--case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI,

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

       E.SJ DEBET,

        0 KREDIT, 'IDR' Valas, 1 KURS, 

       E.SJ DEBETRP,

        0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, 

       '' CUSTSUPPP,'' CUSTSUPPL, '' KODEP,'' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, 

       '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO,

       null MYID, 'BP' JENIS, A.NoUrutJurnal NOURUT

FROM dbo.dbInvoicePL A  

Left Outer Join dbInvoicePLDet b on b.NoBukti=a.NoBukti

left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti

Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO                 

LEFT OUTER JOIN DBO.dbCustSupp D ON D .KODECUSTSUPP = A.KodeCustSupp

left outer join 

(SELECT A.KodeCustSupp,

       COALESCE(SUM(((case when B.NOSAT=1 Then B.QNT Else B.QNT2 +COALESCE(c2.QntKoreksi,0))*

       (COALESCE(case when COALESCE(G.PPN,0)=2 then case when b.NoBukti not Like '%SJB%' then G.HARGA else B.GrossW /1.1 else case when b.NoBukti not Like '%SJB%' then G.HARGA else B.GrossW  ,0)))-

       (((case when B.NOSAT=1 Then B.QNT Else B.QNT2 +COALESCE(c2.QntKoreksi,0))*

       (COALESCE(case when COALESCE(G.PPN,0)=2 then case when b.NoBukti not Like '%SJB%' then G.HARGA else B.GrossW /1.1 else case when b.NoBukti not Like '%SJB%' then G.HARGA else B.GrossW  ,0)))*COALESCE(G.DISC,0)/100)),0) SJ

 FROM dbo.dbspb A  

 Left Outer Join dbSPBDet b on b.NoBukti=a.NoBukti

 Left outer join(select NoBukti,NoSPB,KodeBrg,QntKoreksi,UrutSPB from dbInvoicePLDet)C2 On C2.NoSPB=b.NoBukti and C2.KodeBrg=B.KodeBrg and c2.UrutSPB=b.Urut 

 left outer join dbSPPDet F on F.NoBukti=b.NoSPP and F.KodeBrg=b.KodeBrg and F.Urut=B.UrutSPP

 LEFT outer join DBSODET G on G.NOBUKTI=f.NoSO and G.KodeBrg=b.KodeBrg and G.URUT=F.UrutSO

 LEFT outer join DBBARANG C on c.KODEBRG=b.KODEBRG

 where B.NoBukti Not Like '%SJB%' and B.NoBukti not like '%SPBB%' and C.NAMABRG not like '%Jasa%' 

 GROUP BY A.KodeCustSupp

) E on E.KodeCustSupp=A.KodeCustSupp

where A.NoJurnal<>'' and (A.NOBUKTI=@Nobukti) and B.NoSPB Not Like '%SJB%' and B.NoSPB not like '%SPBB%' and b.Namabrg not like '%Jasa%'  

and so.NOBUKTI in (select NOBUKTI from TempSOTerpasang) 

GROUP BY A.NOBUKTI, A.TANGGAL, D.NAMACUSTSUPP,A.KodeCustSupp,so.PPH22,so.PPHDPP,so.Retensi,rpInv.TotNet,

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5,

       A.NOURUT,COALESCE(A.PPh21,0),COALESCE(D.IsPPH21,0),COALESCE(NTotal,0),COALESCE(FRetensi,0),

       A.NoJurnal,A.TglJurnal, A.NoUrutJurnal,A.PPN,A.DP,E.SJ 

union all

SELECT A.NoJurnal NOBUKTI, A.TglJurnal TANGGAL,

       A.Devisi,--case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI,

       D.NAMACUSTSUPP + ' (' + A.KodeCustSupp + ')'  NOTE,0 LAMPIRAN, 

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) URUT, 

       '131' PERKIRAAN, '806' LAWAN,

       D.NAMACUSTSUPP  KETERANGAN, 

       '' KETERANGAN2, 

       (case when COALESCE(SO.PPH22,0)<>0 Then 

       (Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))

       else

       Sum(B.NDPPRp) )-E.SJ DEBET,

        0 KREDIT, 'IDR' Valas, 1 KURS, 

       (case when COALESCE(SO.PPH22,0)<>0 Then 

       (Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))

       else

       Sum(B.NDPPRp) )-E.SJ DEBETRP,

        0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, 

       '' CUSTSUPPP,'' CUSTSUPPL, '' KODEP,'' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, 

       '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO,

       null MYID, 'BP' JENIS, A.NoUrutJurnal NOURUT

FROM dbo.dbInvoicePL A  

Left Outer Join dbInvoicePLDet b on b.NoBukti=a.NoBukti

left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti

Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO                 

LEFT OUTER JOIN DBO.dbCustSupp D ON D .KODECUSTSUPP = A.KodeCustSupp

left outer join 

(SELECT A.KodeCustSupp,

       COALESCE(SUM(((case when B.NOSAT=1 Then B.QNT Else B.QNT2 +COALESCE(c2.QntKoreksi,0))*

       (COALESCE(case when COALESCE(G.PPN,0)=2 then case when b.NoBukti not Like '%SJB%' then G.HARGA else B.GrossW /1.1 else case when b.NoBukti not Like '%SJB%' then G.HARGA else B.GrossW  ,0)))-

       (((case when B.NOSAT=1 Then B.QNT Else B.QNT2 +COALESCE(c2.QntKoreksi,0))*

       (COALESCE(case when COALESCE(G.PPN,0)=2 then case when b.NoBukti not Like '%SJB%' then G.HARGA else B.GrossW /1.1 else case when b.NoBukti not Like '%SJB%' then G.HARGA else B.GrossW  ,0)))*COALESCE(G.DISC,0)/100)),0) SJ

 FROM dbo.dbspb A  

 Left Outer Join dbSPBDet b on b.NoBukti=a.NoBukti

 Left outer join(select NoBukti,NoSPB,KodeBrg,QntKoreksi,UrutSPB from dbInvoicePLDet)C2 On C2.NoSPB=b.NoBukti and C2.KodeBrg=B.KodeBrg and c2.UrutSPB=b.Urut 

 left outer join dbSPPDet F on F.NoBukti=b.NoSPP and F.KodeBrg=b.KodeBrg and F.Urut=B.UrutSPP

 LEFT outer join DBSODET G on G.NOBUKTI=f.NoSO and G.KodeBrg=b.KodeBrg and G.URUT=F.UrutSO

 LEFT outer join DBBARANG C on c.KODEBRG=b.KODEBRG

 where B.NoBukti Not Like '%SJB%' and B.NoBukti not like '%SPBB%' and C.NAMABRG not like '%Jasa%' 

 GROUP BY A.KodeCustSupp

) E on E.KodeCustSupp=A.KodeCustSupp

where A.NoJurnal<>'' and (A.NOBUKTI=@Nobukti) and B.NoSPB Not Like '%SJB%' and B.NoSPB not like '%SPBB%' and b.Namabrg not like '%Jasa%'  

and so.NOBUKTI in (select NOBUKTI from TempSOTerpasang) 

GROUP BY A.NOBUKTI, A.TANGGAL, D.NAMACUSTSUPP,A.KodeCustSupp,so.PPH22,so.PPHDPP,so.Retensi,rpInv.TotNet,

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5,

       A.NOURUT,COALESCE(A.PPh21,0),COALESCE(D.IsPPH21,0),COALESCE(NTotal,0),COALESCE(FRetensi,0),

       A.NoJurnal,A.TglJurnal, A.NoUrutJurnal,A.PPN,A.DP,E.SJ */

union all

SELECT A.NoJurnal NOBUKTI, A.TglJurnal TANGGAL,

       A.Devisi,--case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI,

       D.NAMACUSTSUPP + ' (' + A.KodeCustSupp + ')'  NOTE,0 LAMPIRAN, 

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) URUT, 

       '131' PERKIRAAN, '806' LAWAN,

       D.NAMACUSTSUPP  KETERANGAN, 

       '' KETERANGAN2, 

       case when a.NoBukti='BCB/INVC/0720/00014' then 1942250 

            when a.NoBukti='BCA/INVC/0720/00015' then 795031.50 

            when a.NoBukti='BCB/INVC/1020/00013' then  49613760 

            when a.NoBukti='BCB/INVC/1120/00018' then  80000000 

            when a.NoBukti='BCB/INVC/1120/00019' then  300 

            when a.NoBukti='BCB/INVC/1220/00010' then  33665000

            when a.NoBukti='BCB/INVC/1220/00011' then  34880000

            when a.NoBukti='BCB/INVC/1220/00012' then  8273700 

            when a.NoBukti='CB/INVC/0221/00004'  then  35308000

            when a.NoBukti='BCB/INVC/0521/00006' then  6216250 

            when a.NoBukti='CB/INVC/0621/00002' then 5405367.50 

            when a.NoBukti='BCA/INVC/0921/00026' then  158773230

            when a.NoBukti='BCA/INVC/0622/00013' then 6918918.92

            when a.NoBukti='BCB/INVC/0323/00022' then 6810000

       else

       case when COALESCE(SO.PPH22,0)<>0 Then 

       (Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))

       else

       Sum(B.NDPPRp)   DEBET,

        0 KREDIT, 'IDR' Valas, 1 KURS, 

       case when a.NoBukti='BCB/INVC/0720/00014' then 1942250 

            when a.NoBukti='BCA/INVC/0720/00015' then 795031.50 

            when a.NoBukti='BCB/INVC/1020/00013' then  49613760

            when a.NoBukti='BCB/INVC/1120/00018' then  80000000

            when a.NoBukti='BCB/INVC/1120/00019' then  300

            when a.NoBukti='BCB/INVC/1220/00010' then  33665000

            when a.NoBukti='BCB/INVC/1220/00011' then  34880000

            when a.NoBukti='BCB/INVC/1220/00012' then  8273700 

            when a.NoBukti='CB/INVC/0221/00004'  then  35308000 

            when a.NoBukti='BCB/INVC/0521/00006' then  6216250 

            when a.NoBukti='CB/INVC/0621/00002' then 5405367.50 

            when a.NoBukti='BCA/INVC/0921/00026' then  158773230  

            when a.NoBukti='BCA/INVC/0622/00013' then 6918918.92 

            when a.NoBukti='BCB/INVC/0323/00022' then 6810000

       else

       case when COALESCE(SO.PPH22,0)<>0 Then 

       (Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))

       else

       Sum(B.NDPPRp)   DEBETRP,

        0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, 

       '' CUSTSUPPP,'' CUSTSUPPL, '' KODEP,'' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, 

       '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO,

       null MYID, 'BP' JENIS, A.NoUrutJurnal NOURUT

FROM dbo.dbInvoicePL A  

Left Outer Join dbInvoicePLDet b on b.NoBukti=a.NoBukti

left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti

Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO                 

LEFT OUTER JOIN DBO.dbCustSupp D ON D .KODECUSTSUPP = A.KodeCustSupp

where A.NoJurnal<>'' and (A.NOBUKTI=@Nobukti) and (B.NoSPB Like '%SJB%' or B.NoSPB like '%SPBB%' or b.Namabrg like '%Jasa%'

or a.NoBukti in ('BCB/INVC/0720/00014','BCA/INVC/0720/00015','BCB/INVC/1020/00013','BCB/INVC/1120/00018','BCB/INVC/1120/00019',

                 'BCB/INVC/1220/00010','BCB/INVC/1220/00011','BCB/INVC/1220/00012','CB/INVC/0221/00004','BCB/INVC/0521/00006',

                 'CB/INVC/0621/00002','BCA/INVC/0921/00026','BCA/INVC/0622/00013','BCB/INVC/0323/00022'))   

GROUP BY A.NOBUKTI, A.TANGGAL,A.DEVISI,D.NAMACUSTSUPP,A.KodeCustSupp,so.PPH22,so.PPHDPP,so.Retensi,rpInv.TotNet,

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5,

       A.NOURUT,COALESCE(A.PPh21,0),COALESCE(D.IsPPH21,0),COALESCE(NTotal,0),

       A.NoJurnal,A.TglJurnal, A.NoUrutJurnal,A.PPN,A.DP

union all

SELECT A.NoJurnal NOBUKTI, A.TglJurnal TANGGAL,

       A.Devisi,--case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI,

       D.NAMACUSTSUPP + ' (' + A.KodeCustSupp + ')'  NOTE,0 LAMPIRAN, 

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) URUT, 

       '131' PERKIRAAN, '367' LAWAN,

       D.NAMACUSTSUPP  KETERANGAN, 

       '' KETERANGAN2, 

       case when COALESCE(SO.PPH22,0)<>0 Then 

       ((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then NilaiPPN else (1+NilaiPPN) )

       else

       (COALESCE(A.DP,0)*NilaiPPN)+((Sum(B.NDPPRp)-COALESCE(A.DP,0))*NilaiPPN)  DEBET,

        0 KREDIT, 'IDR' Valas, 1 KURS, 

       case when COALESCE(SO.PPH22,0)<>0 Then 

       ((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then NilaiPPN else (1+NilaiPPN) )

       else

       (COALESCE(A.DP,0)*NilaiPPN)+((Sum(B.NDPPRp)-COALESCE(A.DP,0))*NilaiPPN)  DEBETRP,

        0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, 

       '' CUSTSUPPP,'' CUSTSUPPL, '' KODEP,'' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, 

       '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO,

       null MYID, 'BP' JENIS, A.NoUrutJurnal NOURUT

FROM dbo.dbInvoicePL A  

Left Outer Join dbInvoicePLDet b on b.NoBukti=a.NoBukti

left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti

Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO                 

LEFT OUTER JOIN DBO.dbCustSupp D ON D .KODECUSTSUPP = A.KodeCustSupp

where A.NoJurnal<>'' and a.PPN<>0 and (A.NOBUKTI=@Nobukti) 

GROUP BY A.NOBUKTI, A.TANGGAL,A.DEVISI,D.NAMACUSTSUPP,A.KodeCustSupp,so.PPH22,so.PPHDPP,so.Retensi,rpInv.TotNet,

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5,

       A.NOURUT,COALESCE(A.PPh21,0),COALESCE(D.IsPPH21,0),COALESCE(NTotal,0),

       A.NoJurnal,A.TglJurnal, A.NoUrutJurnal,A.PPN,A.DP,NilaiPPN

union all

SELECT A.NoJurnal NOBUKTI, A.TglJurnal TANGGAL,

       A.Devisi,--case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI,

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

       case when COALESCE(SO.PPH22,0)<>0 Then

       ((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then NilaiPPN else (1+NilaiPPN) ) else 0  DEBET,

       0 KREDIT, 'IDR' Valas, 1 KURS, 

       case when COALESCE(SO.PPH22,0)<>0 Then

       ((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then NilaiPPN else (1+NilaiPPN) ) else 0  DEBETRP,

       0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, 

       '' CUSTSUPPP,'' CUSTSUPPL, '' KODEP,'' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, 

       '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO,

       null MYID, 'BP' JENIS, A.NoUrutJurnal NOURUT

FROM dbo.dbInvoicePL A  

Left Outer Join dbInvoicePLDet b on b.NoBukti=a.NoBukti

left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti

Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO                 

LEFT OUTER JOIN DBO.dbCustSupp D ON D .KODECUSTSUPP = A.KodeCustSupp

where A.NoJurnal<>'' and (A.NOBUKTI=@Nobukti) 

GROUP BY A.NOBUKTI, A.TANGGAL,A.DEVISI,D.NAMACUSTSUPP,A.KodeCustSupp,SO.PPH22,so.Retensi,so.PPHDPP,rpInv.TotNet,

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5,

       A.NOURUT,COALESCE(A.PPh21,0),COALESCE(D.IsPPH21,0),COALESCE(NTotal,0),

       A.NoJurnal,A.TglJurnal, A.NoUrutJurnal,A.PPN,A.DP,NilaiPPN

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

       case when COALESCE(SO.PPH22,0)<>0 Then 

       (Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100)

       else

       0  DEBET,

        0 KREDIT, 'IDR' Valas, 1 KURS, 

       case when COALESCE(SO.PPH22,0)<>0 Then 

       (Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100)

       else

       0  DEBETRP,

        0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, 

       '' CUSTSUPPP,'' CUSTSUPPL, '' KODEP,'' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, 

       '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO,

       null MYID, 'BP' JENIS, A.NoUrutJurnal NOURUT

FROM dbo.dbInvoicePL A  

Left Outer Join dbInvoicePLDet b on b.NoBukti=a.NoBukti

left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti

Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO                 

LEFT OUTER JOIN DBO.dbCustSupp D ON D .KODECUSTSUPP = A.KodeCustSupp

where A.NoJurnal<>'' and (A.NOBUKTI=@Nobukti) 

and COALESCE(SO.PPH22,0)<>0

GROUP BY A.NOBUKTI, A.TANGGAL,A.DEVISI,D.NAMACUSTSUPP,A.KodeCustSupp,so.PPH22,so.PPHDPP,so.Retensi,rpInv.TotNet,

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5,

       A.NOURUT,

       A.NoJurnal,A.TglJurnal, A.NoUrutJurnal,A.PPN,A.DP

);

-- fnc_JurnalPenjualanPlusSO (FUNCTION)
CREATE FUNCTION IF NOT EXISTS fnc_JurnalPenjualanPlusSO AS RETURN 

Select A.NOBUKTI, A.TANGGAL,A.DEVISI, 

       A.NOTE,A.LAMPIRAN, 

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NOBUKTI Order by A.NOBUKTI) As int) URUT, 

       '11030100' PERKIRAAN, '11030200' LAWAN,

       A.KETERANGAN, 

       '' KETERANGAN2, 

       SUM(DEBET)DEBET, 0 KREDIT, 'IDR' Valas, 1 KURS, 

       SUM(DEBETRP) DEBETRP, 0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, 

       '' CUSTSUPPP,'' CUSTSUPPL, '' KODEP,'' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, 

       '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO,

       null MYID, A.JENIS, A.NOURUT from(

SELECT A.NoJurnal NOBUKTI, A.TglJurnal TANGGAL,'01' DEVISI, 

       D.NAMACUSTSUPP + ' (' + A.KodeCustSupp + ')'  NOTE,0 LAMPIRAN, 

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) URUT, 

       '11030100' PERKIRAAN, '11030200' LAWAN,

       D.NAMACUSTSUPP  KETERANGAN, 

       '' KETERANGAN2, 

       SUM(B.NDPP+b.nppn) DEBET, 0 KREDIT, 'IDR' Valas, 1 KURS, 

       SUM(B.NDPP+b.NPPN) DEBETRP, 0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, 

       '' CUSTSUPPP,'' CUSTSUPPL, '' KODEP,'' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, 

       '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO,

       null MYID, 'BP' JENIS, A.NoUrutJurnal NOURUT

FROM dbo.dbInvoicePL A  

Left Outer Join dbInvoicePLDet b on b.NoBukti=a.NoBukti

LEFT OUTER JOIN DBO.dbCustSupp D ON D .KODECUSTSUPP = A.KodeCustSupp

where A.NOBUKTI=@Nobukti

GROUP BY A.NOBUKTI, A.TANGGAL, D.NAMACUSTSUPP,A.KodeCustSupp,

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5,

       A.NOURUT,

       A.NoJurnal,A.TglJurnal, A.NoUrutJurnal,A.PPN

union all

SELECT A.NoJurnal NOBUKTI, A.TglJurnal TANGGAL,'01' DEVISI, 

       D.NAMACUSTSUPP + ' (' + A.KodeCustSupp + ')'  NOTE,0 LAMPIRAN, 

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) URUT, 

       '11030100' PERKIRAAN, '11030200' LAWAN,

       D.NAMACUSTSUPP  KETERANGAN, 

       '' KETERANGAN2, 

       SUM(E.NDPP+E.nppn) DEBET, 0 KREDIT, 'IDR' Valas, 1 KURS, 

       SUM(E.NDPP+E.NPPN) DEBETRP, 0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, 

       '' CUSTSUPPP,'' CUSTSUPPL, '' KODEP,'' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, 

       '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO,

       null MYID, 'BP' JENIS, A.NoUrutJurnal NOURUT

FROM dbo.dbInvoicePL A  

Left Outer Join dbInvoicePLDet b on b.NoBukti=a.NoBukti

LEFT OUTER JOIN DBO.dbCustSupp D ON D .KODECUSTSUPP = A.KodeCustSupp

LEFT Outer Join DBSODET E on E.NOBUKTI=B.NoSO

LEFT Outer Join DBBARANG G on G.KODEBRG=E.KODEBRG and G.NamaBrg Like '%JASA%'

where  A.NOBUKTI=@Nobukti and COALESCE(B.IsAngkutJasa,0)=1 and G.NamaBrg Like '%JASA%'

GROUP BY A.NOBUKTI, A.TANGGAL, D.NAMACUSTSUPP,A.KodeCustSupp,

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5,

       A.NOURUT,

       A.NoJurnal,A.TglJurnal, A.NoUrutJurnal,A.PPN)

a

Group By A.NOBUKTI, A.TANGGAL,DEVISI, 

       A.NOTE,A.LAMPIRAN, 

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5,A.Keterangan,A.Jenis,A.NOURUT

union all

SELECT A.NoJurnal NOBUKTI, A.TglJurnal TANGGAL,'01' DEVISI, 

       D.NAMACUSTSUPP + ' (' + A.KodeCustSupp + ')'  NOTE,0 LAMPIRAN, 

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) URUT, 

       '21030005' PERKIRAAN, '21030001' LAWAN,

       D.NAMACUSTSUPP  KETERANGAN, 

       '' KETERANGAN2, 

       SUM(B.NPPN) DEBET, 0 KREDIT, 'IDR' Valas, 1 KURS, 

       SUM(B.NPPN) DEBETRP, 0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, 

       '' CUSTSUPPP,'' CUSTSUPPL, '' KODEP,'' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, 

       '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO,

       null MYID, 'BP' JENIS, A.NoUrutJurnal NOURUT

FROM dbo.dbInvoicePL A  

Left Outer Join dbInvoicePLDet b on b.NoBukti=a.NoBukti

LEFT OUTER JOIN DBO.dbCustSupp D ON D .KODECUSTSUPP = A.KodeCustSupp

where A.NoJurnal<>'' and A.NOBUKTI=@Nobukti and A.PPN in(1,2)

GROUP BY A.NOBUKTI, A.TANGGAL, D.NAMACUSTSUPP,A.KodeCustSupp,

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5,

       A.NOURUT,

       A.NoJurnal,A.TglJurnal, A.NoUrutJurnal,A.PPN;

-- fnc_JurnalPenjualanRetensi (FUNCTION)
CREATE FUNCTION IF NOT EXISTS fnc_JurnalPenjualanRetensi AS RETURN 

(SELECT A.NOBUKTI, A.TANGGAL,

       B.Devisi,--case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI, 

       D.NAMACUSTSUPP + ' (' + b.KodeCustSupp + ')'  NOTE,0 LAMPIRAN, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoBukti Order by A.NoBukti) As int) URUT, 

       '131' PERKIRAAN, '133' LAWAN,

       D.NAMACUSTSUPP  KETERANGAN, 

       '' KETERANGAN2, 

     SUM( a.TDPP) DEBET,

        0 KREDIT, 'IDR' Valas, 1 KURS, 

     SUM( a.TDPP) DEBETRP,

        0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, 

       '' CUSTSUPPP,'' CUSTSUPPL, '' KODEP,'' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, 

       '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO,

       null MYID, 'RP' JENIS, '00001' NOURUT

FROM dbo.dbInvoicePLRetensi A  

Left Outer Join dbInvoicePL b on b.NoBukti=a.NoInvoice

lEFT OUTER JOIN DBO.dbCustSupp D ON D .KODECUSTSUPP = b.KodeCustSupp

where (A.NOBUKTI=@Nobukti) and b.NoBukti in ( select NoBukti from DBInvoicePLdet where NoSPB Not Like '%SJB%' and NoSPB not like '%SPBB%' and Namabrg not like '%Jasa%' )

GROUP BY A.NOBUKTI, A.TANGGAL, D.NAMACUSTSUPP,b.KodeCustSupp,b.DEVISI

union all

SELECT A.NOBUKTI, A.TANGGAL,

       B.Devisi,--case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI, 

       D.NAMACUSTSUPP + ' (' + b.KodeCustSupp + ')'  NOTE,0 LAMPIRAN, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoBukti Order by A.NoBukti) As int) URUT, 

       '131' PERKIRAAN, '806' LAWAN,

       D.NAMACUSTSUPP  KETERANGAN, 

       '' KETERANGAN2, 

     SUM( a.TDPP) DEBET,

        0 KREDIT, 'IDR' Valas, 1 KURS, 

     SUM( a.TDPP) DEBETRP,

        0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, 

       '' CUSTSUPPP,'' CUSTSUPPL, '' KODEP,'' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, 

       '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO,

       null MYID, 'RP' JENIS, '00001' NOURUT

FROM dbo.dbInvoicePLRetensi A  

Left Outer Join dbInvoicePL b on b.NoBukti=a.NoInvoice

lEFT OUTER JOIN DBO.dbCustSupp D ON D .KODECUSTSUPP = b.KodeCustSupp

where (A.NOBUKTI=@Nobukti) and b.NoBukti in ( select NoBukti from dbInvoicePLDet where (NoSPB Like '%SJB%' or NoSPB like '%SPBB%' or Namabrg like '%Jasa%'))

GROUP BY A.NOBUKTI, A.TANGGAL, D.NAMACUSTSUPP,b.KodeCustSupp,b.DEVISI

union all

SELECT A.NOBUKTI, A.TANGGAL,

       B.Devisi,--case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI, 

       D.NAMACUSTSUPP + ' (' + b.KodeCustSupp + ')'  NOTE,0 LAMPIRAN, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoBukti Order by A.NoBukti) As int) URUT, 

       '131' PERKIRAAN, '367' LAWAN,

       D.NAMACUSTSUPP  KETERANGAN, 

       '' KETERANGAN2, 

     SUM( a.TNPPN) DEBET,

        0 KREDIT, 'IDR' Valas, 1 KURS, 

     SUM( a.TNPPN) DEBETRP,

        0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, 

       '' CUSTSUPPP,'' CUSTSUPPL, '' KODEP,'' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, 

       '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO,

       null MYID, 'RP' JENIS, '00002' NOURUT

FROM dbo.dbInvoicePLRetensi A  

Left Outer Join dbInvoicePL b on b.NoBukti=a.NoInvoice

lEFT OUTER JOIN DBO.dbCustSupp D ON D .KODECUSTSUPP = b.KodeCustSupp

where (A.NOBUKTI=@Nobukti) 

GROUP BY A.NOBUKTI, A.TANGGAL, D.NAMACUSTSUPP,b.KodeCustSupp,b.DEVISI

Having  SUM( a.TNPPN) <>0

);

-- fnc_JurnalRBP (FUNCTION)
CREATE FUNCTION IF NOT EXISTS fnc_JurnalRBP AS RETURN 

(SELECT A.NoJurnal NOBUKTI, A.TglJurnal TANGGAL,

       A.Devisi,--case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI,

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

FROM DBO.DBRBELI A 

LEFT OUTER JOIN DBO.DBRBELIDET B ON B.NOBUKTI = A.NOBUKTI 

LEFT OUTER JOIN DBO.VWBROWSSUPP D ON D .KODECUSTSUPP = A.KODESUPP

Left Outer join dbo.DBPERKCUSTSUPP D1 on D1.KODECUSTSUPP=A.KODESUPP and D1.Perkiraan=Case When A.TIPEBAYAR=0 Then '332' else '331'  

Left Outer Join dbo.DBBARANG E on E.KODEBRG=B.KODEBRG

Left Outer join dbo.dbSubGroup F on F.KodeGrp=E.KODEGRP and F.KodeSubGrp=E.KODESUBGRP

Left Outer join dbo.DBBELI G on G.NOBUKTI=B.NOPBL

where A.NoJurnal<>'' and (A.NOBUKTI=@Nobukti) 

GROUP BY A.NOBUKTI, A.TANGGAL,A.DEVISI, D.NAMACUSTSUPP, A.KODESUPP,

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5,

       F.PerkPers, D.PERKIRAAN,  A.KODEVLS, A.KURS, A.NOURUT,

       A.NoJurnal,A.TglJurnal, F.PerkH, A.NoUrutJurnal, G.nobukti, G.Tanggal,D1.Perkiraan

union All

SELECT A.NoJurnal NOBUKTI, A.TglJurnal TANGGAL,

       A.Devisi,--case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI,

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

FROM DBO.DBRBELI A 

LEFT OUTER JOIN DBO.DBRBELIDET B ON B.NOBUKTI = A.NOBUKTI 

LEFT OUTER JOIN DBO.VWBROWSSUPP D ON D .KODECUSTSUPP = A.KODESUPP

Left Outer join dbo.DBPERKCUSTSUPP D1 on D1.KODECUSTSUPP=A.KODESUPP and D1.Perkiraan=Case When A.TIPEBAYAR=0 Then '332' else '331'  

Left Outer Join dbo.DBBARANG E on E.KODEBRG=B.KODEBRG

Left Outer join dbo.dbSubGroup F on F.KodeGrp=E.KODEGRP and F.KodeSubGrp=E.KODESUBGRP

Left Outer join dbo.DBBELI G on G.NOBUKTI=B.NOPBL

where A.NoJurnal<>'' and (A.NOBUKTI=@Nobukti) 

GROUP BY A.NOBUKTI, A.TANGGAL,A.DEVISI, D.NAMACUSTSUPP, A.KODESUPP,

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5,

       F.PerkPPn, D.PERKIRAAN,  A.KODEVLS, A.KURS, A.NOURUT,

       A.NoJurnal,A.TglJurnal, F.PerkH, A.NoUrutJurnal, G.nobukti, G.Tanggal,D1.Perkiraan

);

-- fnc_JurnalRPenjualanRetensi (FUNCTION)
CREATE FUNCTION IF NOT EXISTS fnc_JurnalRPenjualanRetensi AS RETURN 

(SELECT A.NOBUKTI, A.TANGGAL,

       B.Devisi,--case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI,

       D.NAMACUSTSUPP + ' (' + b.KodeCustSupp + ')'  NOTE,0 LAMPIRAN, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoBukti Order by A.NoBukti) As int) URUT, 

       '131' PERKIRAAN, '133' LAWAN,

       D.NAMACUSTSUPP  KETERANGAN, 

       '' KETERANGAN2, 

     SUM( a.TDPP) DEBET,

        0 KREDIT, 'IDR' Valas, 1 KURS, 

     SUM( a.TDPP) DEBETRP,

        0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, 

       '' CUSTSUPPP,'' CUSTSUPPL, '' KODEP,'' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, 

       '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO,

       null MYID, 'RP' JENIS, '00001' NOURUT

FROM dbo.dbRInvoicePLRetensi A  

Left Outer Join dbRInvoicePL b on b.NoBukti=a.NoInvoice

lEFT OUTER JOIN DBO.dbCustSupp D ON D .KODECUSTSUPP = b.KodeCustSupp

where (A.NOBUKTI=@Nobukti) 

GROUP BY A.NOBUKTI, A.TANGGAL, D.NAMACUSTSUPP,b.KodeCustSupp,B.DEVISI

union all

SELECT A.NOBUKTI, A.TANGGAL,

       B.Devisi,--case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI,

       D.NAMACUSTSUPP + ' (' + b.KodeCustSupp + ')'  NOTE,0 LAMPIRAN, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoBukti Order by A.NoBukti) As int) URUT, 

       '131' PERKIRAAN, '367' LAWAN,

       D.NAMACUSTSUPP  KETERANGAN, 

       '' KETERANGAN2, 

     SUM( a.TNPPN) DEBET,

        0 KREDIT, 'IDR' Valas, 1 KURS, 

     SUM( a.TNPPN) DEBETRP,

        0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, 

       '' CUSTSUPPP,'' CUSTSUPPL, '' KODEP,'' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, 

       '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO,

       null MYID, 'RP' JENIS, '00002' NOURUT

FROM dbo.dbRInvoicePLRetensi A  

Left Outer Join dbRInvoicePL b on b.NoBukti=a.NoInvoice

lEFT OUTER JOIN DBO.dbCustSupp D ON D .KODECUSTSUPP = b.KodeCustSupp

where (A.NOBUKTI=@Nobukti) 

GROUP BY A.NOBUKTI, A.TANGGAL, D.NAMACUSTSUPP,b.KodeCustSupp,B.DEVISI

Having  SUM( a.TNPPN) <>0

);

-- fnc_JurnalRSPB (FUNCTION)
CREATE FUNCTION IF NOT EXISTS fnc_JurnalRSPB AS RETURN 

(

SELECT A.NOBUKTI, A.TglJurnal TANGGAL,

       A.Devisi,--case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI,

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

       /*COALESCE(Sum(case when B.NOSAT=1 Then B.QNT Else B.QNT2 *case when B.NOSAT=1 Then CAST(2 AS Numeric(18),case When COALESCE(G1.HPP,0)<>0  Then G1.HPP else B.HPP ) else 

                                                                  CAST(2 AS Numeric(18),case When COALESCE(G1.HPP,0)<>0  Then G1.HPP*B.ISI else B.HPP*B.ISI )  ),0)*/ 

       COALESCE(sum(B.Qnt*case When COALESCE(G1.HPP,0)<>0  Then G1.HPP else B.HPP ),0)DEBET, 0 KREDIT, 'IDR' VALAS, 1 KURS, 

       /*COALESCE(Sum(case when B.NOSAT=1 Then B.QNT Else B.QNT2 *case when B.NOSAT=1 Then CAST(2 AS Numeric(18),case When COALESCE(G1.HPP,0)<>0  Then G1.HPP else B.HPP ) else 

                                                                  CAST(2 AS Numeric(18),case When COALESCE(G1.HPP,0)<>0  Then G1.HPP*B.ISI else B.HPP*B.ISI )  ),0)*/ 

        COALESCE(sum(B.Qnt*case When COALESCE(G1.HPP,0)<>0  Then G1.HPP else B.HPP ),0) DEBETRP, 0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, '' CUSTSUPPP, '' CUSTSUPPL, '' KODEP, 

       '' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO, null MYID, 'RSPB' JENIS, A.NoUrutJurnal NOURUT

FROM  DBO.DBRSPB A 

LEFT OUTER JOIN DBO.DBRSPBDet B ON B.NOBUKTI = A.NOBUKTI 

Left Outer Join dbSPBDet C ON C.NoBukti=B.NoSPB and C.KodeBrg=B.KodeBrg

left outer join dbSPPDet F1 on F1.NoBukti=c.NoSPP and F1.KodeBrg=b.KodeBrg

LEFT outer join (select Bulan,Tahun,KodeBrg,HPPBrg HPP from dbHPPProduksi)G1 on G1.KodeBrg=b.KodeBrg and G1.Bulan=month(A.TANGGAL) and G1.Tahun=YEAR(a.TANGGAL)

LEFT OUTER JOIN DBO.DBBARANG F ON F.KODEBRG = B.KODEBRG 

LEFT OUTER JOIN DBO.DBGROUP G ON G.KODEGRP = F.KODEGRP

LEFT OUTER JOIN DBO.dbSubGroup H ON H.KodeSubGrp = F.KODESUBGRP and H.KodeGrp=F.KODEGRP

Left outer join dbo.DBCUSTSUPP I on I.KODECUSTSUPP=A.KodeCustSupp

Where  (A.NOBUKTI=@Nobukti) 

Group by A.NoJurnal, A.TglJurnal, a.Devisi,

      A.NOBUKTI, H.NamaSubGrp, H.KodeSubGrp,A.TANGGAL,

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       H.PerkPPN, H.PerkPers,A.NoUrutJurnal,I.NAMACUSTSUPP,A.KodeCustSupp

union all

SELECT A.NOBUKTI, A.TglJurnal TANGGAL,

       A.Devisi,--case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI,

       D.NAMACUSTSUPP + ' (' + A.KodeCustSupp + ')'  NOTE,0 LAMPIRAN, 

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int)+500 URUT, 

       '133' PERKIRAAN,  '501' LAWAN,

       D.NAMACUSTSUPP  KETERANGAN, 

       '' KETERANGAN2, 

       COALESCE(SUM(((case when B.NOSAT=1 Then B.QNT Else B.QNT2 +COALESCE(c2.QntKoreksi,0))*

       (COALESCE(case when COALESCE(G.PPN,0)=2 then case when c.NoBukti not Like '%SJB%' then G.HARGA else C.GrossW /(1+NilaiPPN) else case when c.NoBukti not Like '%SJB%' then G.HARGA else c.GrossW  ,0)))-

       (((case when B.NOSAT=1 Then B.QNT Else B.QNT2 +COALESCE(c2.QntKoreksi,0))*

       (COALESCE(case when COALESCE(G.PPN,0)=2 then case when c.NoBukti not Like '%SJB%' then G.HARGA else c.GrossW /(1+NilaiPPN) else case when c.NoBukti not Like '%SJB%' then G.HARGA else c.GrossW  ,0)))*COALESCE(G.DISC,0)/100)),0)*-1 DEBET, 

       0 KREDIT, 'IDR' Valas, 1 KURS, 

              COALESCE(SUM(((case when B.NOSAT=1 Then B.QNT Else B.QNT2 +COALESCE(c2.QntKoreksi,0))*

       (COALESCE(case when COALESCE(G.PPN,0)=2 then case when c.NoBukti not Like '%SJB%' then G.HARGA else C.GrossW /(1+NilaiPPN) else case when c.NoBukti not Like '%SJB%' then G.HARGA else c.GrossW  ,0)))-

       (((case when B.NOSAT=1 Then B.QNT Else B.QNT2 +COALESCE(c2.QntKoreksi,0))*

       (COALESCE(case when COALESCE(G.PPN,0)=2 then case when c.NoBukti not Like '%SJB%' then G.HARGA else c.GrossW /(1+NilaiPPN) else case when c.NoBukti not Like '%SJB%' then G.HARGA else c.GrossW  ,0)))*COALESCE(G.DISC,0)/100)),0)*-1 DEBETRP, 

       0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, 

       '' CUSTSUPPP,'' CUSTSUPPL, '' KODEP,'' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, 

       '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO,

       null MYID, 'RSPB' JENIS, A.NoUrutJurnal NOURUT

FROM  dbo.DBRSPB A  

Left Outer Join DBRSPBDet b on b.NoBukti=a.NoBukti

Left outer join(select NoBukti,NoSPB,KodeBrg,QntKoreksi,UrutSPB from dbInvoicePLDet)C2 On C2.NoSPB=b.NoBukti and C2.KodeBrg=B.KodeBrg and c2.UrutSPB=b.Urut

LEFT Outer Join dbSPBDet C On C.NoBukti=b.NoSPB and C.KodeBrg=b.KodeBrg

left outer join dbSPPDet F on F.NoBukti=c.NoSPP and F.KodeBrg=b.KodeBrg and F.Urut=c.UrutSPP

LEFT outer join DBSODET G on G.NOBUKTI=f.NoSO and G.KodeBrg=b.KodeBrg and G.URUT=F.UrutSO

LEFT outer join DBBARANG C1 on c1.KODEBRG=b.KODEBRG

left outer join dbSubGroup E on E.KodeSubGrp=C1.KODESUBGRP

LEFT OUTER JOIN DBO.dbCustSupp D ON D .KODECUSTSUPP = A.KodeCustSupp

where (A.NOBUKTI=@Nobukti) and C.NoBukti Not Like '%SJB%' and C.NoBukti not like '%SPBB%' and C1.NAMABRG not like '%Jasa%'  

GROUP BY A.NOBUKTI, A.TANGGAL,A.DEVISI, D.NAMACUSTSUPP,A.KodeCustSupp,e.perkh,

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5,

       A.NOURUT,

       A.NoJurnal,A.TglJurnal, A.NoUrutJurnal

/*union all

SELECT A.NOBUKTI, A.TglJurnal TANGGAL,

       case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI, 

       D.NAMACUSTSUPP + ' (' + A.KodeCustSupp + ')'  NOTE,0 LAMPIRAN, 

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int)+1000 URUT, 

      '133'  PERKIRAAN,'367' LAWAN,

       D.NAMACUSTSUPP  KETERANGAN, 

       '' KETERANGAN2, 

       (SUM((B.qnt*(case when COALESCE(G.PPN,0)=2 then G.HARGA/1.1 else G.HARGA ))-

           ((B.qnt*(case when COALESCE(G.PPN,0)=2 then G.HARGA/1.1 else G.HARGA ))*G.DISC/100))*0.1)*-1 DEBET, 

       0 KREDIT, 'IDR' Valas, 1 KURS, 

       (SUM((B.qnt*(case when COALESCE(G.PPN,0)=2 then G.HARGA/1.1 else G.HARGA ))-

           ((B.qnt*(case when COALESCE(G.PPN,0)=2 then G.HARGA/1.1 else G.HARGA ))*G.DISC/100))*0.1)*-1 DEBETRP, 

       0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, 

       '' CUSTSUPPP,'' CUSTSUPPL, '' KODEP,'' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, 

       '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO,

       null MYID, 'RSPB' JENIS, A.NoUrutJurnal NOURUT

FROM dbo.dbspb A  

Left Outer Join dbSPBDet b on b.NoBukti=a.NoBukti

left outer join dbSPPDet F on F.NoBukti=b.NoSPP and F.KodeBrg=b.KodeBrg and F.Urut=B.UrutSPP

LEFT outer join DBSODET G on G.NOBUKTI=f.NoSO and G.KodeBrg=b.KodeBrg and G.URUT=F.UrutSO

LEFT outer join DBBARANG C on c.KODEBRG=b.KODEBRG

left outer join dbSubGroup E on E.KodeSubGrp=C.KODESUBGRP

LEFT OUTER JOIN DBO.dbCustSupp D ON D .KODECUSTSUPP = A.KodeCustSupp

where (A.NOBUKTI=@Nobukti) 

and G.PPN IN(1,2)

GROUP BY A.NOBUKTI, A.TANGGAL,A.DEVISI, D.NAMACUSTSUPP,A.KodeCustSupp,e.perkh,

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5,

       A.NOURUT,

       A.NoJurnal,A.TglJurnal, A.NoUrutJurnal

*/

);

-- fnc_JurnalRTransRute (FUNCTION)
CREATE FUNCTION IF NOT EXISTS fnc_JurnalRTransRute AS RETURN 

(SELECT A.NoJurnal NOBUKTI, A.TglJurnal TANGGAL,'01' DEVISI, 

       D.NAMACUSTSUPP + ' (' + A.KODEKEND + ')'  NOTE,0 LAMPIRAN, 

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) URUT, 

       '11010200' PERKIRAAN, '61030001' LAWAN,

       'Retur No. Saku  '+A.NOBUKTI KETERANGAN, 

       '' KETERANGAN2, 

       SUM(B.TOTAL) DEBET, 0 KREDIT, 'IDR' Valas, 1 KURS, 

       SUM(B.TOTAL) DEBETRP, 0 KREDITRP, 'BKM' TIPETRANS, 'C' TPHC, 

       '' CUSTSUPPP,'' CUSTSUPPL, '' KODEP, 

       '' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO, null MYID, 'BP' JENIS, A.NoUrutJurnal NOURUT

FROM dbo.DBRRUTETRANS A  

LEFT OUTER JOIN DBO.DBRRUTETRANSDET B ON B.NOBUKTI = A.NOBUKTI 

LEFT OUTER JOIN DBO.dbCustSupp D ON D .KODECUSTSUPP = A.Ket2

where A.NoJurnal<>'' and A.NOBUKTI=@Nobukti

GROUP BY A.NOBUKTI, A.TANGGAL, D.NAMACUSTSUPP, A.Ket2,A.KODEKEND,

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5,

       A.NOURUT,

       A.NoJurnal,A.TglJurnal, A.NoUrutJurnal);

-- fnc_JurnalSO (FUNCTION)
CREATE FUNCTION IF NOT EXISTS fnc_JurnalSO AS RETURN 

(SELECT A.NOBUKTI+'-CB' NoBukti, B.TglJurnal TANGGAL,'01' DEVISI, 

       A.NAMACUSTSUPP + ' (' + A.KodeCustSupp + ')'  NOTE,0 LAMPIRAN, 

       B.IsOtorisasi1, B.OTOUSER1, B.TGLOTO1, 

       B.ISOTORISASI2, B.OTOUSER2, B.TGLOTO2, 

       B.ISOTORISASI3, B.OTOUSER3, B.TGLOTO3, 

       B.ISOTORISASI4, B.OTOUSER4, B.TGLOTO4, 

       B.ISOTORISASI5, B.OTOUSER5, B.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NOBUKTI Order by A.NOBUKTI) As int) URUT,  

       '61050002' PERKIRAAN, 

       '21040003'  LAWAN, 

       A.NAMACUSTSUPP KETERANGAN, '' KETERANGAN2, 

       Sum(KelebihanK) DEBET, 0 KREDIT, 'IDR' VALAS, 1 KURS, 

       Sum(KelebihanK) DEBETRP, 0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, '' CUSTSUPPP, '' CUSTSUPPL, '' KODEP, 

       '' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO, null MYID, 'CB' JENIS, B.NoUrutJurnal NOURUT

FROM  [Vw_ReportSPBCashBack] A

      Left Outer Join dbSPB B on A.NoBukti=B.NOBUKTI

Where A.NoBukti=@Nobukti

Group by A.NOBUKTI, B.TglJurnal, 

      A.NOBUKTI,A.TANGGAL,

       B.IsOtorisasi1, B.OTOUSER1, B.TGLOTO1, 

       B.ISOTORISASI2, B.OTOUSER2, B.TGLOTO2, 

       B.ISOTORISASI3, B.OTOUSER3, B.TGLOTO3, 

       B.ISOTORISASI4, B.OTOUSER4, B.TGLOTO4, 

       B.ISOTORISASI5, B.OTOUSER5, B.TGLOTO5, 

       B.NoUrutJurnal,A.NAMACUSTSUPP,A.KodeCustSupp



);

-- fnc_JurnalSPB (FUNCTION)
CREATE FUNCTION IF NOT EXISTS fnc_JurnalSPB AS RETURN 

(SELECT A.NOBUKTI, A.TglJurnal TANGGAL,

      A.Devisi,-- case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI, 

       I.NAMACUSTSUPP + ' (' + A.KodeCustSupp + ')'  NOTE,0 LAMPIRAN, 

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) URUT,  

       '511' PERKIRAAN, 

       H.PerkPers  LAWAN, 

       I.NAMACUSTSUPP+case when COALESCE(a.Catatan,'')<>'' then +' - '+a.Catatan else ''  KETERANGAN, '' KETERANGAN2, 

       COALESCE(Sum(case when B.NOSAT=1 Then B.QNT Else B.QNT2 *case when B.NOSAT=1 Then CAST(2 AS Numeric(18),case When COALESCE(G1.HPP,0)<>0  Then G1.HPP else B.HPP ) else 

                                                                  CAST(2 AS Numeric(18),case When COALESCE(G1.HPP,0)<>0  Then G1.HPP*cast(b.ISI as numeric(18,2)) else B.HPP*cast(b.ISI as numeric(18,2)) )  ),0) DEBET, 0 KREDIT, 'IDR' VALAS, 1 KURS, 

       COALESCE(Sum(case when B.NOSAT=1 Then B.QNT Else B.QNT2 *case when B.NOSAT=1 Then CAST(2 AS Numeric(18),case When COALESCE(G1.HPP,0)<>0  Then G1.HPP else B.HPP ) else 

                                                                  CAST(2 AS Numeric(18),case When COALESCE(G1.HPP,0)<>0  Then G1.HPP*cast(b.ISI as numeric(18,2)) else B.HPP*cast(b.ISI as numeric(18,2)) )  ),0) DEBETRP, 0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, '' CUSTSUPPP, '' CUSTSUPPL, '' KODEP, 

       '' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO, null MYID, 'SPB' JENIS, A.NoUrutJurnal NOURUT

FROM  DBO.dbSPB A 

LEFT OUTER JOIN DBO.dbSPBDet B ON B.NOBUKTI = A.NOBUKTI 

left outer join dbSPPDet F1 on F1.NoBukti=b.NoSPP and F1.KodeBrg=b.KodeBrg and f1.Urut=b.UrutSPP

LEFT outer join (select Bulan,Tahun,KodeBrg,HPPBrg HPP from dbHPPProduksi)G1 on G1.KodeBrg=b.KodeBrg and G1.Bulan=month(A.TANGGAL) and G1.Tahun=YEAR(a.TANGGAL)

LEFT OUTER JOIN DBO.DBBARANG F ON F.KODEBRG = B.KODEBRG 

LEFT OUTER JOIN DBO.DBGROUP G ON G.KODEGRP = F.KODEGRP

LEFT OUTER JOIN DBO.dbSubGroup H ON H.KodeSubGrp = F.KODESUBGRP and H.KodeGrp=F.KODEGRP

Left outer join dbo.DBCUSTSUPP I on I.KODECUSTSUPP=A.KodeCustSupp

Where (A.NOBUKTI=@Nobukti) and B.NoBukti Not Like '%SJB%' and B.NoBukti not like '%SPBB%' and F.NAMABRG not like '%Jasa%' and COALESCE(A.IsClose,0)=0

Group by A.NoJurnal, A.TglJurnal, 

      A.NOBUKTI, H.NamaSubGrp, H.KodeSubGrp,A.TANGGAL,A.Devisi,

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       H.PerkPPN, H.PerkPers,A.NoUrutJurnal,I.NAMACUSTSUPP,A.KodeCustSupp,a.Catatan

union all

SELECT A.NOBUKTI, A.TglJurnal TANGGAL,

       A.Devisi,--case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI, 

       I.NAMACUSTSUPP + ' (' + A.KodeCustSupp + ')'  NOTE,0 LAMPIRAN, 

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) URUT,  

       '809' PERKIRAAN, 

       H.PerkPers  LAWAN, 

       I.NAMACUSTSUPP+case when COALESCE(a.Catatan,'')<>'' then +' - '+a.Catatan else ''  KETERANGAN, '' KETERANGAN2, 

       COALESCE(Sum(case when B.NOSAT=1 Then B.QNT Else B.QNT2 *case when B.NOSAT=1 Then CAST(2 AS Numeric(18),case When COALESCE(G1.HPP,0)<>0  Then G1.HPP else B.HPP ) else 

                                                                  CAST(2 AS Numeric(18),case When COALESCE(G1.HPP,0)<>0  Then G1.HPP*cast(b.ISI as numeric(18,2)) else B.HPP*cast(b.ISI as numeric(18,2)) )  ),0) DEBET, 0 KREDIT, 'IDR' VALAS, 1 KURS, 

       COALESCE(Sum(case when B.NOSAT=1 Then B.QNT Else B.QNT2 *case when B.NOSAT=1 Then CAST(2 AS Numeric(18),case When COALESCE(G1.HPP,0)<>0  Then G1.HPP else B.HPP ) else 

                                                                  CAST(2 AS Numeric(18),case When COALESCE(G1.HPP,0)<>0  Then G1.HPP*cast(b.ISI as numeric(18,2)) else B.HPP*cast(b.ISI as numeric(18,2)) )  ),0) DEBETRP, 0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, '' CUSTSUPPP, '' CUSTSUPPL, '' KODEP, 

       '' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO, null MYID, 'SPB' JENIS, A.NoUrutJurnal NOURUT

FROM  DBO.dbSPB A 

LEFT OUTER JOIN DBO.dbSPBDet B ON B.NOBUKTI = A.NOBUKTI 

left outer join dbSPPDet F1 on F1.NoBukti=b.NoSPP and F1.KodeBrg=b.KodeBrg and f1.Urut=b.UrutSPP

LEFT outer join (select Bulan,Tahun,KodeBrg,HPPBrg HPP from dbHPPProduksi)G1 on G1.KodeBrg=b.KodeBrg and G1.Bulan=month(A.TANGGAL) and G1.Tahun=YEAR(a.TANGGAL)

LEFT OUTER JOIN DBO.DBBARANG F ON F.KODEBRG = B.KODEBRG 

LEFT OUTER JOIN DBO.DBGROUP G ON G.KODEGRP = F.KODEGRP

LEFT OUTER JOIN DBO.dbSubGroup H ON H.KodeSubGrp = F.KODESUBGRP and H.KodeGrp=F.KODEGRP

Left outer join dbo.DBCUSTSUPP I on I.KODECUSTSUPP=A.KodeCustSupp

Where (A.NOBUKTI=@Nobukti) and (B.NoBukti Like '%SJB%' or B.NoBukti like '%SPBB%' or F.Namabrg like '%Jasa%') and COALESCE(A.IsClose,0)=0

Group by A.NoJurnal, A.TglJurnal, A.Devisi, 

      A.NOBUKTI, H.NamaSubGrp, H.KodeSubGrp,A.TANGGAL,

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       H.PerkPPN, H.PerkPers,A.NoUrutJurnal,I.NAMACUSTSUPP,A.KodeCustSupp,a.Catatan

union all

SELECT A.NOBUKTI, A.TglJurnal TANGGAL,

       A.Devisi,--case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI,

       D.NAMACUSTSUPP + ' (' + A.KodeCustSupp + ')'  NOTE,0 LAMPIRAN, 

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int)+500 URUT, 

       '133' PERKIRAAN, '501' LAWAN,

       D.NAMACUSTSUPP+case when COALESCE(a.Catatan,'')<>'' then +' - '+a.Catatan else ''   KETERANGAN, 

       '' KETERANGAN2, 

       COALESCE(SUM(((case when B.NOSAT=1 Then B.QNT Else B.QNT2 +COALESCE(c2.QntKoreksi,0))*

       (COALESCE(case when COALESCE(G.PPN,0)=2 then case when b.NoBukti not Like '%SJB%' then G.HARGA else B.GrossW /(1+NilaiPPN) else case when b.NoBukti not Like '%SJB%' then G.HARGA else B.GrossW  ,0)))-

       (((case when B.NOSAT=1 Then B.QNT Else B.QNT2 +COALESCE(c2.QntKoreksi,0))*

       (COALESCE(case when COALESCE(G.PPN,0)=2 then case when b.NoBukti not Like '%SJB%' then G.HARGA else B.GrossW /(1+NilaiPPN) else case when b.NoBukti not Like '%SJB%' then G.HARGA else B.GrossW  ,0)))*COALESCE(G.DISC,0)/100)),0) DEBET, 

       0 KREDIT, 'IDR' Valas, 1 KURS, 

       COALESCE(SUM(((case when B.NOSAT=1 Then B.QNT Else B.QNT2 +COALESCE(c2.QntKoreksi,0))*

       (COALESCE(case when COALESCE(G.PPN,0)=2 then case when b.NoBukti not Like '%SJB%' then G.HARGA else B.GrossW /(1+NilaiPPN) else case when b.NoBukti not Like '%SJB%' then G.HARGA else B.GrossW  ,0)))-

       (((case when B.NOSAT=1 Then B.QNT Else B.QNT2 +COALESCE(c2.QntKoreksi,0))*

       (COALESCE(case when COALESCE(G.PPN,0)=2 then case when b.NoBukti not Like '%SJB%' then G.HARGA else B.GrossW /(1+NilaiPPN) else case when b.NoBukti not Like '%SJB%' then G.HARGA else B.GrossW  ,0)))*COALESCE(G.DISC,0)/100)),0) DEBETRP, 

       0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, 

       '' CUSTSUPPP,'' CUSTSUPPL, '' KODEP,'' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, 

       '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO,

       null MYID, 'SPB' JENIS, A.NoUrutJurnal NOURUT

FROM dbo.dbspb A  

Left Outer Join dbSPBDet b on b.NoBukti=a.NoBukti

Left outer join(select min(NoBukti) NoBukti,NoSPB,KodeBrg,QntKoreksi,UrutSPB 

                  from dbInvoicePLDet group by NoSPB,KodeBrg,QntKoreksi,UrutSPB)C2 On C2.NoSPB=b.NoBukti and C2.KodeBrg=B.KodeBrg and c2.UrutSPB=b.Urut

left outer join dbSPPDet F on F.NoBukti=b.NoSPP and F.KodeBrg=b.KodeBrg and F.Urut=B.UrutSPP

LEFT outer join DBSODET G on G.NOBUKTI=f.NoSO and G.KodeBrg=b.KodeBrg and G.URUT=F.UrutSO

LEFT outer join DBBARANG C on c.KODEBRG=b.KODEBRG

left outer join dbSubGroup E on E.KodeSubGrp=C.KODESUBGRP and E.KodeGrp=C.KODEGRP

LEFT OUTER JOIN DBO.dbCustSupp D ON D .KODECUSTSUPP = A.KodeCustSupp

where (A.NOBUKTI=@Nobukti) and B.NoBukti Not Like '%SJB%' and B.NoBukti not like '%SPBB%' and C.NAMABRG not like '%Jasa%' and COALESCE(A.IsClose,0)=0

GROUP BY A.NOBUKTI, A.TANGGAL,A.DEVISI, D.NAMACUSTSUPP,A.KodeCustSupp,e.perkh,

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5,

       A.NOURUT,

       A.NoJurnal,A.TglJurnal, A.NoUrutJurnal,a.Catatan

/*

union all

SELECT A.NOBUKTI, A.TglJurnal TANGGAL,

       A.Devisi,--case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI,

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

       COALESCE(SUM((B.qnt*(case when COALESCE(G.PPN,0)=2 then COALESCE(G.HARGA,0)/1.1 else COALESCE(G.HARGA,0) ))-

           ((B.qnt*(case when COALESCE(G.PPN,0)=2 then COALESCE(G.HARGA,0)/1.1 else COALESCE(G.HARGA,0) ))*G.DISC/100))*0.1,0) DEBET, 

       0 KREDIT, 'IDR' Valas, 1 KURS, 

       COALESCE(SUM((B.qnt*(case when COALESCE(G.PPN,0)=2 then COALESCE(G.HARGA,0)/1.1 else COALESCE(G.HARGA,0) ))-

           ((B.qnt*(case when COALESCE(G.PPN,0)=2 then COALESCE(G.HARGA,0)/1.1 else COALESCE(G.HARGA,0) ))*G.DISC/100))*0.1,0) DEBETRP, 

       0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, 

       '' CUSTSUPPP,'' CUSTSUPPL, '' KODEP,'' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, 

       '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO,

       null MYID, 'SPB' JENIS, A.NoUrutJurnal NOURUT

FROM dbo.dbspb A  

Left Outer Join dbSPBDet b on b.NoBukti=a.NoBukti

left outer join dbSPPDet F on F.NoBukti=b.NoSPP and F.KodeBrg=b.KodeBrg and F.Urut=B.UrutSPP

LEFT outer join DBSODET G on G.NOBUKTI=f.NoSO and G.KodeBrg=b.KodeBrg and G.URUT=F.UrutSO

LEFT outer join DBBARANG C on c.KODEBRG=b.KODEBRG

left outer join dbSubGroup E on E.KodeSubGrp=C.KODESUBGRP

LEFT OUTER JOIN DBO.dbCustSupp D ON D .KODECUSTSUPP = A.KodeCustSupp

where (A.NOBUKTI=@Nobukti) 

and G.PPN IN(1,2)

GROUP BY A.NOBUKTI, A.TANGGAL,A.DEVISI, D.NAMACUSTSUPP,A.KodeCustSupp,e.perkh,

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5,

       A.NOURUT,

       A.NoJurnal,A.TglJurnal, A.NoUrutJurnal

      

*/

);

-- fnc_JurnalSPBRJual (FUNCTION)
CREATE FUNCTION IF NOT EXISTS fnc_JurnalSPBRJual AS RETURN 

(

SELECT A.NoJurnal NOBUKTI, A.TglJurnal TANGGAL,

      a.Devisi,-- case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI,  

       'Retur Invoice Penjualan Gudang : ' + COALESCE(I.NAMACUSTSUPP,'') + ' (' + COALESCE(A.KODECUSTSUPP,'') + ')'  NOTE,0 LAMPIRAN, 

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) URUT,  

       H.PerkPers PERKIRAAN, 

       '511'  LAWAN, 

       'Retur Invoice Penjualan Gudang : ' + A.NOBUKTI +' TANGGAL : '+ CAST(A.Tanggal, 105 AS TEXT)+CHAR(13)+ 

       'No. Bukti : '+A.NoBukti+' TANGGAL : '+ CAST(A.Tanggal, 105 AS TEXT) KETERANGAN, '' KETERANGAN2, 

       COALESCE(Sum(case when B.NOSAT=1 Then B.QNT Else B.QNT2 *case when B.NOSAT=1 Then CAST(2 AS Numeric(18),case When COALESCE(G1.HPP,0)<>0  Then G1.HPP else B.HPP ) else 

                                                                  CAST(2 AS Numeric(18),case When COALESCE(G1.HPP,0)<>0  Then G1.HPP*B.ISI else B.HPP*B.ISI )  ),0) DEBET, 0 KREDIT, 'IDR' VALAS, 1 KURS, 

       COALESCE(Sum(case when B.NOSAT=1 Then B.QNT Else B.QNT2 *case when B.NOSAT=1 Then CAST(2 AS Numeric(18),case When COALESCE(G1.HPP,0)<>0  Then G1.HPP else B.HPP ) else 

                                                                  CAST(2 AS Numeric(18),case When COALESCE(G1.HPP,0)<>0  Then G1.HPP*B.ISI else B.HPP*B.ISI )  ),0) DEBETRP, 0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, '' CUSTSUPPP, '' CUSTSUPPL, '' KODEP, 

       '' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO, null MYID, 'SPBRJUAL' JENIS, A.NoUrutJurnal NOURUT

FROM  DBO.dbSPBRJual A 

LEFT OUTER JOIN DBO.dbSPBRJualDet B ON B.NOBUKTI = A.NOBUKTI 

LEFT outer join (select Bulan,Tahun,KodeBrg,HPPBrg HPP from dbHPPProduksi)G1 on G1.KodeBrg=b.KodeBrg and G1.Bulan=month(A.TANGGAL) and G1.Tahun=YEAR(a.TANGGAL)

LEFT OUTER JOIN DBO.DBBARANG F ON F.KODEBRG = B.KODEBRG 

LEFT OUTER JOIN DBO.DBGROUP G ON G.KODEGRP = F.KODEGRP

LEFT OUTER JOIN DBO.dbSubGroup H ON H.KodeSubGrp = F.KODESUBGRP and H.KodeGrp=F.KODEGRP

Left outer join dbo.DBCUSTSUPP I on I.KODECUSTSUPP=A.KodeCustSupp

Where  (A.NOBUKTI=@Nobukti) 

Group by A.NoJurnal, A.TglJurnal, 

      A.NOBUKTI, H.NamaSubGrp, H.KodeSubGrp,A.TANGGAL,

       A.IsOtorisasi1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       H.PerkPPN, H.PerkPers,A.NoUrutJurnal,I.NAMACUSTSUPP,A.KodeCustSupp,a.Devisi



);

-- fnc_JurnalTransRute (FUNCTION)
CREATE FUNCTION IF NOT EXISTS fnc_JurnalTransRute AS RETURN 

(SELECT A.NoJurnal NOBUKTI, A.TglJurnal TANGGAL,'01' DEVISI, 

       D.NAMACUSTSUPP + ' (' + A.KODEKEND + ')'  NOTE,0 LAMPIRAN, 

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) URUT, 

       '61030001' PERKIRAAN, '11010200' LAWAN,

       'No. Saku  '+A.NOBUKTI KETERANGAN, 

       '' KETERANGAN2, 

       SUM(B.TOTAL) DEBET, 0 KREDIT, 'IDR' Valas, 1 KURS, 

       SUM(B.TOTAL) DEBETRP, 0 KREDITRP, 'BKK' TIPETRANS, 'C' TPHC, 

       '' CUSTSUPPP,'' CUSTSUPPL, '' KODEP, 

       '' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO, null MYID, 'BP' JENIS, A.NoUrutJurnal NOURUT

FROM dbo.DBRUTETRANS A  

LEFT OUTER JOIN DBO.DBRUTETRANSDET B ON B.NOBUKTI = A.NOBUKTI 

LEFT OUTER JOIN DBO.dbCustSupp D ON D .KODECUSTSUPP = A.Ket2

where A.NOBUKTI=@Nobukti

GROUP BY A.NOBUKTI, A.TANGGAL, D.NAMACUSTSUPP, A.Ket2,A.KODEKEND,

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5,

       A.NOURUT,

       A.NoJurnal,A.TglJurnal, A.NoUrutJurnal);

-- fnc_JurnalUangMuka (FUNCTION)
CREATE FUNCTION IF NOT EXISTS fnc_JurnalUangMuka AS RETURN 

(SELECT A.NoJurnal NOBUKTI, A.TglJurnal TANGGAL,'01' DEVISI, 

       D.NAMACUSTSUPP + ' (' + A.KodeCustSupp + ')'  NOTE,0 LAMPIRAN, 

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) URUT, 

       '341' PERKIRAAN, '131' LAWAN,

       A.NoBukti+','+D.NAMACUSTSUPP  KETERANGAN, 

       '' KETERANGAN2, 

       SUM(A.DP)  DEBET, 0 KREDIT, 'IDR' Valas, 1 KURS, 

       SUM(A.DP)  DEBETRP, 0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, 

       '' CUSTSUPPP,'' CUSTSUPPL, '' KODEP, 

       '' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO, null MYID, 'BP' JENIS, A.NoUrutJurnal NOURUT

FROM dbo.dbInvoicePL A  

LEFT OUTER JOIN DBO.dbCustSupp D ON D .KODECUSTSUPP = A.KodeCustSupp

where A.NoJurnal<>'' and A.NOBUKTI=@Nobukti and a.DP<>0

GROUP BY A.NOBUKTI, A.TANGGAL, D.NAMACUSTSUPP,A.KodeCustSupp,

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5,

       A.NOURUT,

       A.NoJurnal,A.TglJurnal, A.NoUrutJurnal,A.PPN);

-- fnc_JurnalUMPPN (FUNCTION)
CREATE FUNCTION IF NOT EXISTS fnc_JurnalUMPPN AS RETURN 

(SELECT A.NoJurnal NOBUKTI, A.TglJurnal TANGGAL,'01' DEVISI, 

       D.NAMACUSTSUPP + ' (' + A.KodeCustSupp + ')'  NOTE,0 LAMPIRAN, 

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) URUT, 

       '362' PERKIRAAN, '131' LAWAN,

       A.NoBukti+','+D.NAMACUSTSUPP  KETERANGAN, 

       '' KETERANGAN2, 

       Case when A.PPN>0 Then SUM(A.DP)*0.1 else 0  DEBET, 0 KREDIT, 'IDR' Valas, 1 KURS, 

       Case when A.PPN>0 Then SUM(A.DP)*0.1 else 0  DEBETRP, 0 KREDITRP, 'BMM' TIPETRANS, 'C' TPHC, 

       '' CUSTSUPPP,'' CUSTSUPPL, '' KODEP, 

       '' KODEL, '' NOAKTIVAP, '' NOAKTIVAL, '' STATUSAKTIVAP, '' STATUSAKTIVAL, '' NOBON, '' KODEBAG, '' STATUSGIRO, null MYID, 'BP' JENIS, A.NoUrutJurnal NOURUT

FROM dbo.dbInvoicePL A  

Left Outer Join (Select a.NoBukti,SUM(NDPP)-ByAngkut NDPP from dbInvoicePLDet a

                 Left Outer Join (select NoBukti,SUM(COALESCE(Byangkut,0))ByAngkut from DBSODET Group by NOBUKTI)b on a.NoSO=b.NOBUKTI 

                 Group by a.NoBukti,BYANGKUT)B On B.NoBukti=A.NoBukti

LEFT OUTER JOIN DBO.dbCustSupp D ON D .KODECUSTSUPP = A.KodeCustSupp

where A.NoJurnal<>'' and A.NOBUKTI=@Nobukti and a.DP<>0

GROUP BY A.NOBUKTI, A.TANGGAL, D.NAMACUSTSUPP,A.KodeCustSupp,

       A.ISOTORISASI1, A.OTOUSER1, A.TGLOTO1, 

       A.ISOTORISASI2, A.OTOUSER2, A.TGLOTO2, 

       A.ISOTORISASI3, A.OTOUSER3, A.TGLOTO3, 

       A.ISOTORISASI4, A.OTOUSER4, A.TGLOTO4, 

       A.ISOTORISASI5, A.OTOUSER5, A.TGLOTO5,

       A.NOURUT,

       A.NoJurnal,A.TglJurnal, A.NoUrutJurnal,A.PPN);

-- fnc_MutuBesiSO (FUNCTION)
CREATE FUNCTION IF NOT EXISTS fnc_MutuBesiSO AS -- DECLARE REMOVED, @MyBesi varchar(50), @Counter int

	--select * from dbSpesifikasiSO

	-- SET REMOVED1

	-- SET REMOVED'' 

	declare MyData cursor for

	select MyBesi from

	( 

	select 1 Urut, 'Wire Rod U 50' MyBesi

	from dbSpesifikasiSO A

	where A.NoBukti=@NoBukti and A.Besi_WRU50=1

	union all

	select 2 Urut, 'BJTD 40' MyBesi

	from dbSpesifikasiSO A

	where A.NoBukti=@NoBukti and A.Besi_BJTD40=1

	union all

	select 3 Urut, 'BJTP 24' MyBesi

	from dbSpesifikasiSO A

	where A.NoBukti=@NoBukti and A.Besi_BJTP24=1

	union all

	select 4 Urut, 'PC Wire 4 ea' MyBesi

	from dbSpesifikasiSO A

	where A.NoBukti=@NoBukti and A.Besi_PCWire=1

	) X 

	order by Urut

	open MyData 

	fetch next from MyData into @MyBesi

	while @@FETCH_STATUS=0

	if @Counter=1 

			-- SET REMOVED@MyMutuBesi+@MyBesi

		else 

			-- SET REMOVED@MyMutuBesi+', '+@MyBesi

		-- SET REMOVED@Counter+1

		fetch next from MyData into @MyBesi

	

	close MyData

	deallocate MyData 	

	return @MyMutuBesi;

-- fnc_MutuBetonSO (FUNCTION)
CREATE FUNCTION IF NOT EXISTS fnc_MutuBetonSO AS -- DECLARE REMOVED, @MyBeton varchar(50), @Counter int

	    

	-- SET REMOVED1

	-- SET REMOVED'' 

	declare MyData cursor for

	select MyBeton from

	( 

	select 1 Urut, 'K-350' MyBeton

	from dbSpesifikasiSO A

	where A.NoBukti=@NoBukti and A.Beton_K350=1

	union all

	select 2 Urut, 'K-400' MyBeton

	from dbSpesifikasiSO A

	where A.NoBukti=@NoBukti and A.Beton_K400=1

	union all

	select 3 Urut, 'K-500' MyBeton

	from dbSpesifikasiSO A

	where A.NoBukti=@NoBukti and A.Beton_K500=1

	) X 

	order by Urut

	open MyData 

	fetch next from MyData into @MyBeton

	while @@FETCH_STATUS=0

	if @Counter=1 

			-- SET REMOVED@MyMutuBeton+@MyBeton

		else 

			-- SET REMOVED@MyMutuBeton+', '+@MyBeton

		-- SET REMOVED@Counter+1

		fetch next from MyData into @MyBeton

	

	close MyData

	deallocate MyData 	

	return @MyMutuBeton;

-- fnc_NamaBrg (FUNCTION)
CREATE FUNCTION IF NOT EXISTS fnc_NamaBrg AS -- DECLARE REMOVED, @MyNama varchar(50), @Counter int

	--select * from dbSpesifikasiSO

	-- SET REMOVED1

	-- SET REMOVED'' 

	declare MyData cursor for

	select MyNama from

	( 

	select Urut, NamaBrg MyNama

	from dbPenyerahanBhnDet A

	Left Outer Join dbBarang B on A.KodeBrg=B.KodeBrg

	where A.NoBukti=@NoBukti and LEFT(B.KodeBrg,8)=@KodeBrg

	

	) X 

	order by Urut

	open MyData 

	fetch next from MyData into @MyNama

	while @@FETCH_STATUS=0

	if @Counter=1 

			-- SET REMOVED@MyNamaBrg+@MyNama

		else 

			-- SET REMOVED@MyNamaBrg+', '+@MyNama

		-- SET REMOVED@Counter+1

		fetch next from MyData into @MyNama

	

	close MyData

	deallocate MyData 	

	return @MyNamaBrg;

-- fnc_NamaBrgPNW (FUNCTION)
CREATE FUNCTION IF NOT EXISTS fnc_NamaBrgPNW AS -- DECLARE REMOVED, @MyNama varchar(300), @Counter int

	--select * from dbSpesifikasiSO

	-- SET REMOVED1

	-- SET REMOVED'' 

	declare MyData cursor for

	select MyNama from

	( 

	select Urut, B.NamaBrg+' :'+case when a.nosat=1 then CAST(A.Qnt AS TEXT) else CAST(A.Qnt2 AS TEXT)+' '+A.Satuan MyNama

	from dbPNWDet A

	Left Outer Join dbBarang B on A.KodeBrg=B.KodeBrg

	where A.NoBukti=@NoBukti and A.KodebrgM=@KodeBrg

	

	) X 

	order by Urut

	open MyData 

	fetch next from MyData into @MyNama

	while @@FETCH_STATUS=0

	if @Counter=1 

			-- SET REMOVED@MyNamaBrg+@MyNama

		else 

			-- SET REMOVED@MyNamaBrg+CHAR(13)+'- '+@MyNama

		-- SET REMOVED@Counter+1

		fetch next from MyData into @MyNama

	

	close MyData

	deallocate MyData 	

	return @MyNamaBrg;

-- fnc_NamaBrgSO (FUNCTION)
CREATE FUNCTION IF NOT EXISTS fnc_NamaBrgSO AS -- DECLARE REMOVED, @MyNama varchar(300), @Counter int

	--select * from dbSpesifikasiSO

	-- SET REMOVED1

	-- SET REMOVED'' 

	declare MyData cursor for

	select MyNama from

	( 

	select Urut, B.NamaBrg+' :'+Case when a.Nosat=2 Then  CAST(A.Qnt2 AS TEXT) else  CAST(A.Qnt AS TEXT)+' '+A.Satuan MyNama

	from dbSODet A

	Left Outer Join dbBarang B on A.KodeBrg=B.KodeBrg

	where A.NoBukti=@NoBukti and A.KodebrgM=@KodeBrg

	

	) X 

	order by Urut

	open MyData 

	fetch next from MyData into @MyNama

	while @@FETCH_STATUS=0

	if @Counter=1 

			-- SET REMOVED@MyNamaBrg+@MyNama

		else 

			-- SET REMOVED@MyNamaBrg+CHAR(13)+'- '+@MyNama

		-- SET REMOVED@Counter+1

		fetch next from MyData into @MyNama

	

	close MyData

	deallocate MyData 	

	return @MyNamaBrg;

-- fnc_NamaSJ (FUNCTION)
CREATE FUNCTION IF NOT EXISTS fnc_NamaSJ AS ---- DECLARE REMOVED

    ---- SET REMOVED'CA/KP/1214/00017'

	-- DECLARE REMOVED, @MySPK varchar(50), @Counter int

	-- SET REMOVED1

	-- SET REMOVED'' 

	declare MyData cursor for

	select MySPK from

	( 

	select  CAST(ROW_NUMBER() Over(PARTITION BY B.NoBukti Order by B.NoBukti) As int) urut,A.NoSJ MySPK

	from DBSJRUTETRANS A

	Left Outer Join DBRUTETRANS B On B.NoBukti=A.NOSaku

	where B.NoBukti=@NoBukti 

	Group by B.NoBukti, A.NoSJ	

	) X 

	order by Urut

	open MyData 

	

	fetch next from MyData into @MySPK

	while @@FETCH_STATUS=0

	if @Counter=1 

			-- SET REMOVED@NoSPK+@MySPK

		else 

			-- SET REMOVED@NoSPK+CHAR(13)+@MySPK

		-- SET REMOVED@Counter+1

		fetch next from MyData into @MySPK

	

	close MyData

	deallocate MyData 	

	return @NoSPK;

-- fnc_NamaSPK (FUNCTION)
CREATE FUNCTION IF NOT EXISTS fnc_NamaSPK AS ---- DECLARE REMOVED

    ---- SET REMOVED'CA/KP/1214/00017'

	-- DECLARE REMOVED, @MySPK varchar(50), @Counter int

	-- SET REMOVED1

	-- SET REMOVED'' 

	declare MyData cursor for

	select MySPK from

	( 

	select  CAST(ROW_NUMBER() Over(PARTITION BY A.NoBukti Order by A.NoBukti) As int) urut,B.NoBukti MySPK

	from DBSO A

	left Outer Join dbSPK B On A.NoBukti=B.NOSO

	where A.NoBukti=@NoBukti 

	Group by B.NoBukti, A.NoBukti	

	) X 

	order by Urut

	open MyData 

	

	fetch next from MyData into @MySPK

	while @@FETCH_STATUS=0

	if @Counter=1 

			-- SET REMOVED@NoSPK+@MySPK

		else 

			-- SET REMOVED@NoSPK+', '+@MySPK

		-- SET REMOVED@Counter+1

		fetch next from MyData into @MySPK

	

	close MyData

	deallocate MyData 	

	return @NoSPK;

-- fnc_PostDebetNote (FUNCTION)
CREATE FUNCTION IF NOT EXISTS fnc_PostDebetNote AS -- =============================================

-- Author:		Noviyanto

-- Create date: 16-05-2013

-- Description:	Posting Debet Note ke Hutang

-- =============================================

RETURN 

(SELECT B.NoInv NoFaktur, A.NOBUKTI NoRetur, 'T' Tipetrans, A.KodeSupp KODECUSTSUPP, 

       A.NoJurnal Nobukti, CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) NoMsk, CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) urut, A.TANGGAL, A.Tanggal JatuhTempo, 

       Sum(B.NilaiRp) Debet, 0.00 Kredit, -Sum(B.NilaiRp) Saldo, 

       B.KodeVls Valas, B.Kurs KURS, 

       sum(B.Nilai) DebetD, 0.00 Kreditd, -sum(B.Nilai) SaldoD, 

       '' KodeSales, 'HT' Tipe, 

       C.PERKIRAAN PERKIRAAN, '' Catatan, A.KodeSupp NoInvoice, B.KodeVls KodeVls_, B.Kurs Kurs_

FROM   dbo.DBDebetNote A      

LEft Outer join dbo.DBDebetNoteDET B on B.nobukti=A.nobukti

Left Outer join dbo.vwBrowsSupp C on C.KODECUSTSUPP=A.KodeSupp

Where A.NoJurnal<>'' and A.NOBUKTI=@Nobukti

Group by A.NoBukti, A.KodeSupp, A.Tanggal,

	B.KodeVls, B.Kurs, c.PERKIRAAN, A.NoJurnal, b.NoInv

);

-- fnc_PostKreditNote (FUNCTION)
CREATE FUNCTION IF NOT EXISTS fnc_PostKreditNote AS -- =============================================

-- Author:		Noviyanto

-- Create date: 16-05-2013

-- Description:	Posting Kredit Note ke Piutang

-- =============================================

RETURN 

(SELECT B.NoInv NoFaktur, A.NOBUKTI NoRetur, 'T' Tipetrans, A.KodeSupp KODECUSTSUPP, 

       A.NoJurnal Nobukti, CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) NoMsk, CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) urut, A.TANGGAL, A.Tanggal JatuhTempo, 

       0.00 Debet, Sum(B.NilaiRp) Kredit, -Sum(B.NilaiRp) Saldo, 

       B.KodeVls Valas, B.Kurs KURS, 

       0.00 DebetD, sum(B.Nilai) Kreditd, -sum(B.Nilai) SaldoD, 

       '' KodeSales, 'PT' Tipe, 

       C.PERKIRAAN PERKIRAAN, '' Catatan, A.KodeSupp NoInvoice, B.KodeVls KodeVls_, B.Kurs Kurs_

FROM   dbo.DBKreditNote A      

LEft Outer join dbo.DBKreditNoteDET B on B.nobukti=A.nobukti

Left Outer join dbo.vwBrowsCust C on C.KODECUSTSUPP=A.KodeSupp

Where A.NoJurnal<>'' and A.NOBUKTI=@Nobukti

Group by A.NoBukti, A.KodeSupp, A.Tanggal,

	B.KodeVls, B.Kurs, c.PERKIRAAN, A.NoJurnal, b.NoInv

);

-- fnc_PostPembelian (FUNCTION)
CREATE FUNCTION IF NOT EXISTS fnc_PostPembelian AS RETURN 

(

SELECT A.NOBUKTI NoFaktur, '' NoRetur, 'T' Tipetrans, A.KodeSupp KODECUSTSUPP, 

       A.NoJurnal Nobukti, CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) NoMsk, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) urut, A.TANGGAL, A.Tanggal JatuhTempo, 

	0 Debet, Sum(B.NNETRp)+COALESCE(A1.Nilai,0) Kredit, Sum(B.NNETRp)+COALESCE(A1.Nilai,0) Saldo, 

	A.KodeVls Valas, A.Kurs KURS, 

       0 DebetD, sum(B.NNet)+COALESCE(A1.Nilai,0) Kreditd, sum(B.NNet)+COALESCE(A1.Nilai,0) SaldoD, 

       '' KodeSales, 'HT' Tipe, 

       D.PERKIRAAN, '' Catatan, 'BL' NoInvoice, A.KodeVls KodeVls_, A.Kurs Kurs_,A.NoBukti NoPajak

       ,A.Devisi--case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI

FROM   dbo.DBBeli A      

LEft Outer join dbo.dbbelidet B on B.nobukti=A.nobukti

Left Outer Join (select SUM(Nilai)Nilai,NoBuktiInv from DBPBIAYA Group By NoBuktiInv)A1 On A1.NoBuktiInv=A.NOBUKTI

Left Outer join dbo.dbBarang C on C.kodebrg=B.kodebrg

Left Outer join dbo.DBPERKCUSTSUPP D on D.KODECUSTSUPP=A.KODESUPP and D.Perkiraan=Case When A.TIPEBAYAR=0 Then '332' else '331'  

Where A.NoJurnal<>'' and c.KODEGRP<>'JS'

and (A.NOBUKTI=@Nobukti) 

Group by A.NoBukti, A.KodeSupp, A.Tanggal,

	A.KodeVls, A.Kurs, D.PERKIRAAN, A.NoJurnal,A1.Nilai,A.Devisi



union all



SELECT A.NOBUKTI NoFaktur, '' NoRetur, 'T' Tipetrans, A.KodeSupp KODECUSTSUPP, 

       A.NoJurnal Nobukti, CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int)+500 NoMsk, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int)+500 urut, A.TANGGAL, A.Tanggal JatuhTempo, 

	0 Debet, Sum(B.NNETRp)+COALESCE(A1.Nilai,0) Kredit, Sum(B.NNETRp)+COALESCE(A1.Nilai,0) Saldo, 

	A.KodeVls Valas, A.Kurs KURS, 

       0 DebetD, sum(B.NNet)+COALESCE(A1.Nilai,0) Kreditd, sum(B.NNet)+COALESCE(A1.Nilai,0) SaldoD, 

       '' KodeSales, 'HT' Tipe, 

       '314' PERKIRAAN, '' Catatan, 'BL' NoInvoice, A.KodeVls KodeVls_, A.Kurs Kurs_,A.NoBukti NoPajak

       ,A.Devisi--case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI

FROM   dbo.DBBeli A      

LEft Outer join dbo.dbbelidet B on B.nobukti=A.nobukti

Left Outer Join (select SUM(Nilai)Nilai,NoBuktiInv from DBPBIAYA Group By NoBuktiInv)A1 On A1.NoBuktiInv=A.NOBUKTI

Left Outer join dbo.dbBarang C on C.kodebrg=B.kodebrg

Left Outer join dbo.DBPERKCUSTSUPP D on D.KODECUSTSUPP=A.KODESUPP and D.Perkiraan=Case When A.TIPEBAYAR=0 Then '332' else '331'  

Where A.NoJurnal<>'' and  c.KODEGRP='JS' and A.TIPEBAYAR=1

and (A.NOBUKTI=@Nobukti) 

Group by A.NoBukti, A.KodeSupp, A.Tanggal,

	A.KodeVls, A.Kurs, D.PERKIRAAN, A.NoJurnal,A1.Nilai,A.Devisi	

);

-- fnc_PostPenjualan (FUNCTION)
CREATE FUNCTION IF NOT EXISTS fnc_PostPenjualan AS RETURN 

(

	SELECT case when Upper(left(a.NOBUKTI,1))='B' and a.Devisi<>'02' then

      case when a.FLagTipe='P' then case when a.NoInv<>a.NoBukti then left(A.NOBUKTI,5)+SUBSTRING(a.NoBukti,8,6)+SUBSTR(A.NOBUKTI, LENGTH(A.NOBUKTI)-2+1)+'-'+left(A.NoInv,15) else A.NOBUKTI  else A.NOBUKTI   

      else 

      case when a.FLagTipe='P' then case when a.NoInv<>'' then left(A.NOBUKTI,5)+SUBSTRING(a.NoBukti,8,6)+SUBSTR(A.NOBUKTI, LENGTH(A.NOBUKTI)-2+1)+'-'+left(A.NoInv,15) else A.NOBUKTI  else A.NOBUKTI    NoFaktur, 

	 '' NoRetur, 'T' Tipetrans, A.KodeCustSupp KODECUSTSUPP, 

       A.NoJurnal Nobukti, CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) NoMsk, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) urut, A.TANGGAL, A.Tanggal JatuhTempo, 

       case when COALESCE(SO.PPH22,0)<>0 Then  

        (Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then NilaiPPN else (1+NilaiPPN) )-

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then NilaiPPN else (1+NilaiPPN) )

		else

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then NilaiPPN else (1+NilaiPPN) )*-1

		 

		else

		case when A.PPN>0 then Sum(B.NDPPRp)+(COALESCE(A.DP,0)*NilaiPPN)+((Sum(B.NDPPRp)-COALESCE(A.DP,0))*NilaiPPN) else Sum(B.NDPPRp)   Debet,

        0.00  Kredit,

       case when COALESCE(SO.PPH22,0)<>0 Then  

        (Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then NilaiPPN else (1+NilaiPPN) )-

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then NilaiPPN else (1+NilaiPPN) )

		else

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then NilaiPPN else (1+NilaiPPN) )*-1

		 

		else

		case when A.PPN>0 then Sum(B.NDPPRp)+(COALESCE(A.DP,0)*NilaiPPN)+((Sum(B.NDPPRp)-COALESCE(A.DP,0))*NilaiPPN) else Sum(B.NDPPRp)   Saldo, 

       A.Valas, A.Kurs KURS, 

       case when COALESCE(SO.PPH22,0)<>0 Then  

        (Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then NilaiPPN else (1+NilaiPPN) )-

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then NilaiPPN else (1+NilaiPPN) )

		else

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then NilaiPPN else (1+NilaiPPN) )*-1

		 

		else case when A.PPN>0 then Sum(B.NDPP)+(COALESCE(A.DP,0)*NilaiPPN)+((Sum(B.NDPP)-COALESCE(A.DP,0))*NilaiPPN) else Sum(B.NDPP)   DebetD, 0.00 Kreditd,

        case when COALESCE(SO.PPH22,0)<>0 Then  

        (Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then NilaiPPN else (1+NilaiPPN) )-

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then NilaiPPN else (1+NilaiPPN) )

		else

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then NilaiPPN else (1+NilaiPPN) )*-1

		 

		else 

		case when A.PPN>0 then Sum(B.NDPP)+(COALESCE(A.DP,0)*NilaiPPN)+((Sum(B.NDPP)-COALESCE(A.DP,0))*NilaiPPN) else Sum(B.NDPP)   SaldoD,  

       '' KodeSales, 'PT' Tipe, 

       E. PERKIRAAN, '' Catatan, 'BP' NoInvoice, A.Valas KodeVls_, A.Kurs Kurs_,A.NoBukti NoPajak,a.Devisi--case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI

FROM   dbo.DBInvoicePL A      

Left Outer Join (select a.NoBukti,a.NoSO,(NDPP) NDPP,(NDPPRp) NDPPRp,NNET,NilaiPPN  from dbInvoicePLDet a 

                 )B On B.NoBukti=A.NoBukti

left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti

Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO                 

Left Outer Join dbo.vwBrowsCust E on E.KODECUSTSUPP=A.KodeCustSupp

Where (A.NOBUKTI=@Nobukti)

Group by A.NoBukti, A.KodeCustSupp, A.Tanggal,so.PPH22,rpInv.TotNet,so.PPHDPP,

    COALESCE(A.PPh21,0),COALESCE(E.IsPPH21,0),COALESCE(NTotal,0),COALESCE(FRetensi,0),

	A.Valas, A.Kurs, A.NoJurnal, E.PERKIRAAN,A.DP,A.PPN,A.FLagTipe,A.NoInv,NilaiPPN,a.Devisi



)

/*(

	SELECT case when Upper(left(a.NOBUKTI,1))='B' then

      case when a.FLagTipe='P' then case when a.NoInv<>a.NoBukti then left(A.NOBUKTI,5)+SUBSTRING(a.NoBukti,8,6)+SUBSTR(A.NOBUKTI, LENGTH(A.NOBUKTI)-2+1)+'-'+left(A.NoInv,15) else A.NOBUKTI  else A.NOBUKTI   

      else 

      case when a.FLagTipe='P' then case when a.NoInv<>'' then left(A.NOBUKTI,5)+SUBSTRING(a.NoBukti,8,6)+SUBSTR(A.NOBUKTI, LENGTH(A.NOBUKTI)-2+1)+'-'+left(A.NoInv,15) else A.NOBUKTI  else A.NOBUKTI    NoFaktur, 

	 '' NoRetur, 'T' Tipetrans, A.KodeCustSupp KODECUSTSUPP, 

       A.NoJurnal Nobukti, CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) NoMsk, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) urut, A.TANGGAL, A.Tanggal JatuhTempo, 

       case when COALESCE(SO.PPH22,0)<>0 Then  

        (Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

		else

		case when A.PPN>0 then Sum(B.NDPPRp)+(COALESCE(A.DP,0)*0.1)+((Sum(B.NDPPRp)-COALESCE(A.DP,0))*0.1) else Sum(B.NDPPRp)   Debet,

        0.00  Kredit,

       case when COALESCE(SO.PPH22,0)<>0 Then  

        (Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

		else

		case when A.PPN>0 then Sum(B.NDPPRp)+(COALESCE(A.DP,0)*0.1)+((Sum(B.NDPPRp)-COALESCE(A.DP,0))*0.1) else Sum(B.NDPPRp)   Saldo, 

       A.Valas, A.Kurs KURS, 

       case when COALESCE(SO.PPH22,0)<>0 Then  

        (Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

		else case when A.PPN>0 then Sum(B.NDPP)+(COALESCE(A.DP,0)*0.1)+((Sum(B.NDPP)-COALESCE(A.DP,0))*0.1) else Sum(B.NDPP)   DebetD, 0.00 Kreditd,

        case when COALESCE(SO.PPH22,0)<>0 Then  

        (Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		((Sum(B.NDPP)-Sum(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

		else 

		case when A.PPN>0 then Sum(B.NDPP)+(COALESCE(A.DP,0)*0.1)+((Sum(B.NDPP)-COALESCE(A.DP,0))*0.1) else Sum(B.NDPP)   SaldoD,  

       '' KodeSales, 'PT' Tipe, 

       E. PERKIRAAN, '' Catatan, 'BP' NoInvoice, A.Valas KodeVls_, A.Kurs Kurs_,A.NoBukti NoPajak,case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI

FROM   dbo.DBInvoicePL A      

Left Outer Join (select a.NoBukti,a.NoSO,(NDPP) NDPP,(NDPPRp) NDPPRp,NNET  from dbInvoicePLDet a 

                 )B On B.NoBukti=A.NoBukti

left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti

Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO                 

Left Outer Join dbo.vwBrowsCust E on E.KODECUSTSUPP=A.KodeCustSupp

Where (A.NOBUKTI=@Nobukti)

Group by A.NoBukti, A.KodeCustSupp, A.Tanggal,so.PPH22,rpInv.TotNet,so.PPHDPP,

    COALESCE(A.PPh21,0),COALESCE(E.IsPPH21,0),COALESCE(NTotal,0),COALESCE(FRetensi,0),

	A.Valas, A.Kurs, A.NoJurnal, E.PERKIRAAN,A.DP,A.PPN,A.FLagTipe,A.NoInv



)



*/;

-- fnc_PostPenjualanRetensi (FUNCTION)
CREATE FUNCTION IF NOT EXISTS fnc_PostPenjualanRetensi AS RETURN 

(

	SELECT a.NoBukti  NoFaktur, 

	 '' NoRetur, 'T' Tipetrans, b.KodeCustSupp KODECUSTSUPP, 

       A.NoBukti, CAST(ROW_NUMBER() Over(PARTITION BY A.NoBukti Order by A.NoBukti) As int) NoMsk, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoBukti Order by A.NoBukti) As int) urut, A.TANGGAL, A.Tanggal JatuhTempo, 

       SUM(a.TDPP+a.TNPPN) Debet,

        0.00  Kredit,

       SUM(a.TDPP+a.TNPPN)  Saldo, 

       b.Valas, b.Kurs KURS, 

       SUM(a.TDPP+a.TNPPN) DebetD, 0.00 Kreditd,

       SUM(a.TDPP+a.TNPPN)  SaldoD,  

       '' KodeSales, 'PT' Tipe, 

       E. PERKIRAAN, '' Catatan, 'RP' NoInvoice, B.Valas KodeVls_, B.Kurs Kurs_,A.NoBukti NoPajak,b.Devisi--case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI

FROM   dbo.dbInvoicePLRetensi A      

left Outer join dbo.dbInvoicePL b on b.NoBukti=a.NoInvoice      

Left Outer Join dbo.vwBrowsCust E on E.KODECUSTSUPP=b.KodeCustSupp

Where (A.NOBUKTI=@Nobukti)

Group by A.NoBukti, b.KodeCustSupp, A.Tanggal,

	b.Valas, b.Kurs,E.PERKIRAAN,b.Devisi

);

-- fnc_PostReturPembelian (FUNCTION)
CREATE FUNCTION IF NOT EXISTS fnc_PostReturPembelian AS RETURN 

(

SELECT COALESCE(b1.NOBUKTI,'-') NoFaktur, A.NOBUKTI NoRetur, 'T' Tipetrans, A.KodeSupp KODECUSTSUPP, 

       A.NoJurnal Nobukti, CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) NoMsk, CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) urut, A.TANGGAL, A.Tanggal JatuhTempo, 

       Sum(B.NNETRp) Debet, 0.00 Kredit, -Sum(B.NNETRp) Saldo, 

       A.KodeVls Valas, A.Kurs KURS, 

       Sum(B.NNET) DebetD, 0.00 Kreditd, -sum(B.NNet) SaldoD, 

       '' KodeSales, 'HT' Tipe, 

       D.PERKIRAAN PERKIRAAN, '' Catatan, 'RBL' NoInvoice, A.KodeVls KodeVls_, A.Kurs Kurs_,A.NoBukti NoPajak

       ,a.Devisi--case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI

FROM   dbo.DBRBELI A      

LEft Outer join dbo.dbRbelidet B on B.nobukti=A.nobukti

Left Outer Join (select NOBUKTI from DBBELI Group By NOBUKTI)b1 On b1.NOBUKTI=B.NOPBL

Left Outer join dbo.dbBarang C on C.kodebrg=B.kodebrg

Left Outer join dbo.DBPERKCUSTSUPP D on D.KODECUSTSUPP=A.KODESUPP and D.Perkiraan=Case When A.TIPEBAYAR=0 Then '332' else '331' 

Where  A.NOBUKTI=@Nobukti 

Group by b1.NOBUKTI,A.NoBukti, A.KodeSupp, A.Tanggal,

	A.KodeVls, A.Kurs, D.PERKIRAAN, A.NoJurnal, B.NOPBL,a.Devisi

);

-- fnc_PostReturPenjualan (FUNCTION)
CREATE FUNCTION IF NOT EXISTS fnc_PostReturPenjualan AS RETURN 

(

SELECT COALESCE(A.NOBUKTI,'-') NoFaktur, A.NoInvoice NoRetur, 'T' Tipetrans, A.KodeCustSupp KODECUSTSUPP, 

       A.NoJurnal Nobukti, CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) NoMsk, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) urut, A.TANGGAL, A.Tanggal JatuhTempo, 

        0.00 Debet, sum(b.NNETRp)  Kredit, sum(b.NNETRp) Saldo, 

       A.KODEVLS, A.Kurs KURS, 

       0.00 DebetD, sum(b.NNET) Kreditd, sum(b.NNET) SaldoD,  

       '' KodeSales, 'PT' Tipe, 

       E. PERKIRAAN, '' Catatan, 'INVRPJ' NoInvoice, A.KODEVLS KodeVls_, A.Kurs Kurs_,A.NoBukti NoPajak

       ,a.Devisi--case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI

FROM   dbo.DBRInvoicePL A      

LEft Outer join dbo.dbRInvoicePLDet B on B.nobukti=A.nobukti

Left Outer Join dbo.vwBrowsCust E on E.KODECUSTSUPP=A.KodeCustSupp

Where A.NoJurnal<>'' and A.NOBUKTI=@Nobukti 

Group by A.NoBukti, A.KodeCustSupp, A.Tanggal,

	A.KODEVLS, A.Kurs, A.NoJurnal, E.PERKIRAAN,A.PPN,A.NoInvoice,a.Devisi

);

-- fnc_PostRPenjualanRetensi (FUNCTION)
CREATE FUNCTION IF NOT EXISTS fnc_PostRPenjualanRetensi AS RETURN 

(

	SELECT a.NoBukti  NoFaktur, 

	 '' NoRetur, 'T' Tipetrans, b.KodeCustSupp KODECUSTSUPP, 

       A.NoBukti, CAST(ROW_NUMBER() Over(PARTITION BY A.NoBukti Order by A.NoBukti) As int) NoMsk, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoBukti Order by A.NoBukti) As int) urut, A.TANGGAL, A.Tanggal JatuhTempo, 

       SUM(a.TNNET) Debet,

        0.00  Kredit,

       SUM(a.TNNET)  Saldo, 

       b.KODEVLS Valas, b.Kurs KURS, 

       SUM(a.TNNET) DebetD, 0.00 Kreditd,

       SUM(a.TNNET)  SaldoD,  

       '' KodeSales, 'PT' Tipe, 

       E. PERKIRAAN, '' Catatan, 'RP' NoInvoice, B.KODEVLS KodeVls_, B.Kurs Kurs_,A.NoBukti NoPajak,b.Devisi--case when Upper(left(a.NOBUKTI,1))='B' then '01' else '02'  DEVISI

FROM   dbo.dbRInvoicePLRetensi A      

left Outer join dbo.dbRInvoicePL b on b.NoBukti=a.NoInvoice      

Left Outer Join dbo.vwBrowsCust E on E.KODECUSTSUPP=b.KodeCustSupp

Where (A.NOBUKTI=@Nobukti)

Group by A.NoBukti, b.KodeCustSupp, A.Tanggal,

	b.KODEVLS, b.Kurs,E.PERKIRAAN,b.Devisi

);

-- fnc_PostSO (FUNCTION)
CREATE FUNCTION IF NOT EXISTS fnc_PostSO AS RETURN 

(

SELECT A.NOBUKTI NoFaktur, '' NoRetur, 'T' Tipetrans, A.KODECUSTSUPP, 

       A.NOBUKTI Nobukti, CAST(ROW_NUMBER() Over(PARTITION BY A.NOBUKTI Order by A.NOBUKTI) As int) NoMsk, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NOBUKTI Order by A.NOBUKTI) As int) urut, A.TANGGAL, A.Tanggal JatuhTempo, 

      0.00  Debet, Sum(KelebihanK) Kredit, Sum(KelebihanK)  Saldo, 

       'IDR' VALAS, 1 KURS, 

      0.00  DebetD,   Sum(KelebihanK) Kreditd, Sum(KelebihanK)SaldoD,  

       '' KodeSales, 'HT' Tipe, 

       '21040003' Perkiraan , '' Catatan, '' NoInvoice, 'IDR'KodeVls_, 1 Kurs_

FROM    [Vw_ReportSPBCashBack] A

      Left Outer Join dbSPB B on A.NoBukti=B.NOBUKTI

Where A.NOBUKTI=@Nobukti

Group by A.NoBukti, A.KODECUSTSUPP,  A.Tanggal

);

-- fnc_PostUangMuka (FUNCTION)
CREATE FUNCTION IF NOT EXISTS fnc_PostUangMuka AS RETURN 

(

SELECT A.NOBUKTI NoFaktur, '' NoRetur, 'T' Tipetrans, A.KodeCustSupp KODECUSTSUPP, 

       A.NoJurnal Nobukti, CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) NoMsk, 

       CAST(ROW_NUMBER() Over(PARTITION BY A.NoJurnal Order by A.Nojurnal) As int) urut, A.TANGGAL, A.Tanggal JatuhTempo, 

       0.00 Debet, Sum(A.DP)+Case when a.PPN in(1,2) Then Sum(A.DP)*0.1 else 0    Kredit, Sum(A.DP)+Case when a.PPN in(1,2) Then Sum(A.DP)*0.1 else 0   Saldo, 

       A.Valas, A.Kurs KURS, 

       0.00 DebetD, Sum(A.DP)+Case when a.PPN in(1,2) Then Sum(A.DP)*0.1 else 0   Kreditd, Sum(A.DP)SaldoD,  

       '' KodeSales, 'PT' Tipe, 

       '131' PERKIRAAN, '' Catatan, A.KodeCustSupp NoInvoice, A.Valas KodeVls_, A.Kurs Kurs_

FROM   dbo.DBInvoicePL A      

Left Outer Join dbo.vwBrowsCust E on E.KODECUSTSUPP=A.KodeCustSupp

Where A.NoJurnal<>'' and A.NOBUKTI=@Nobukti

Group by A.NoBukti, A.KodeCustSupp, A.Tanggal,

	A.Valas, A.Kurs, A.NoJurnal, E.PERKIRAAN,A.DP,A.PPN

);

-- fnc_ReportDP (FUNCTION)
CREATE FUNCTION IF NOT EXISTS fnc_ReportDP AS RETURN 

(

select a1.KodeCustSupp+a1.KodeProject KodeGab,'' NoSeri,'' NoPajak,a1.KodeCustSupp,a1.KodeProject KodeProject,b.NAMAPROJECT,c.NAMACUSTSUPP

     ,B1.Total Total,COALESCE(SUM(DP-COALESCE(RDP,0)+Case when Left(NoBukti,2)='CB' Then 0 else (DP*0.1 )),0) DP,'' NoKwitansi,'DP Invoice AWL' NoInv,Null TglInv

     ,MAX(a.NoBukti)NoBukti,Sum(COALESCE(a.RDP,0))RDP

     from dbDP a1  

     Left Outer Join (Select * from dbInvoicePL where Tanggal<  @Tanggal) a on a1.KodeCustSupp=a.KodeCustSupp and a1.KodeProject=a.NoBL

     Left Outer Join DBPROJECT b on a1.KodeProject=b.KODEPROJECT

     Left Outer Join (select KodeCustSupp,KodeProject,Sum(Total)Total from dbDP Group by KodeCustSupp,KodeProject) b1 On B1.KodeProject=a1.KodeProject and b1.KodeCustSupp=a1.KodeCustSupp 

     Left Outer Join DBCUSTSUPP c on a1.KodeCustSupp=c.KODECUSTSUPP

     where a1.Tanggal<  @Tanggal

     and B1.Total<>0

     and a1.KodeProject<>''

     Group By  a1.KodeCustSupp,a1.KodeProject,b.NAMAPROJECT,c.NAMACUSTSUPP,B1.Total

     Having B1.Total-COALESCE(SUM(DP-COALESCE(RDP,0)+Case when Left(NoBukti,2)='CB' Then 0 else (DP*0.1)),0)>10

     Union ALL

     select * from vw_DP where (TglInv Between @Tanggal and @Tanggal1) 

    

 );

-- fnc_SambunganSO (FUNCTION)
CREATE FUNCTION IF NOT EXISTS fnc_SambunganSO AS -- DECLARE REMOVED, @MySambungan varchar(50), @Counter int

	--select * from dbSpesifikasiSO

	-- SET REMOVED1

	-- SET REMOVED'' 

	declare MyData cursor for

	select MySambungan from

	( 

	select 1 Urut, 'But Joint' MySambungan

	from dbSpesifikasiSO A

	where A.NoBukti=@NoBukti and A.Samb_ButJoint=1

	union all

	select 2 Urut, 'Quickly Joint' MySambungan

	from dbSpesifikasiSO A

	where A.NoBukti=@NoBukti and A.Samb_QuicklyJoint=1

	union all

	select 3 Urut, 'Socket Spigot' MySambungan

	from dbSpesifikasiSO A

	where A.NoBukti=@NoBukti and A.Samb_SocketSpigot=1

	union all

	select 4 Urut, 'Male Female' MySambungan

	from dbSpesifikasiSO A

	where A.NoBukti=@NoBukti and A.Samb_MaleFemale=1

	union all

	select 5 Urut, 'Sambungan Pelat' MySambungan

	from dbSpesifikasiSO A

	where A.NoBukti=@NoBukti and A.Samb_Plat=1

	union all

	select 6 Urut, 'Tanpa Sambungan' MySambungan

	from dbSpesifikasiSO A

	where A.NoBukti=@NoBukti and A.Samb_Tanpa=1

	) X 

	order by Urut

	open MyData 

	fetch next from MyData into @MySambungan

	while @@FETCH_STATUS=0

	if @Counter=1 

			-- SET REMOVED@MyMutuSambungan+@MySambungan

		else 

			-- SET REMOVED@MyMutuSambungan+', '+@MySambungan

		-- SET REMOVED@Counter+1

		fetch next from MyData into @MySambungan

	

	close MyData

	deallocate MyData 	

	return @MyMutuSambungan;

-- fnc_SifatPengiriman (FUNCTION)
CREATE FUNCTION IF NOT EXISTS fnc_SifatPengiriman AS -- DECLARE REMOVED, @MySambungan varchar(50), @Counter int

	--select * from dbSpesifikasiSO

	-- SET REMOVED1

	-- SET REMOVED'' 

	declare MyData cursor for

	select MySambungan from

	( 

	select 1 Urut, 'Loko' MySambungan

	from DBSO A

	where A.NoBukti=@NoBukti and A.NoAlamatKirim=0

	union all

	select 2 Urut, 'Franko on truck' MySambungan

	from DBSO A

	where A.NoBukti=@NoBukti and A.NoAlamatKirim=1

	union all

	select 3 Urut, 'Franko on site' MySambungan

	from DBSO A

	where A.NoBukti=@NoBukti and A.NoAlamatKirim=2

	union all

	select 4 Urut, 'Terpasang' MySambungan

	from DBSO A

	where A.NoBukti=@NoBukti and A.NoAlamatKirim=3

	

	) X 

	order by Urut

	open MyData 

	fetch next from MyData into @MySambungan

	while @@FETCH_STATUS=0

	if @Counter=1 

			-- SET REMOVED@MyMutuSambungan+@MySambungan

		else 

			-- SET REMOVED@MyMutuSambungan+', '+@MySambungan

		-- SET REMOVED@Counter+1

		fetch next from MyData into @MySambungan

	

	close MyData

	deallocate MyData 	

	return @MyMutuSambungan;

-- fnc_vwCekStok (FUNCTION)
CREATE FUNCTION IF NOT EXISTS fnc_vwCekStok AS RETURN 

( 

select SUM(Case When b.IsBarang=8 Then 1000 else QntSaldo )Saldo,SUM(Case When b.IsBarang=8 Then 1000 else Qnt2Saldo )Saldo2 from vwKartuStock a

Left Outer Join DBBARANG b on a.Kodebrg=b.KODEBRG

where Kodegdg=@Kodegd and b.Kodebrg=@Kodebrg

and Tanggal<=@Tanggal and MONTH(@Tanggal)=Case When COALESCE(IsBarang,0)=8 Then MONTH(@Tanggal) else Bulan   and YEAR(@Tanggal)=Case When COALESCE(IsBarang,0)=8 Then YEAR(@Tanggal) else Tahun 



);

-- fnc_vwKartuStock (FUNCTION)
CREATE FUNCTION IF NOT EXISTS fnc_vwKartuStock AS RETURN 

( 

SELECT 'AWL' AS Tipe, 'AWL' AS MyTipe, 'A00' Prioritas, b.Kodebrg, b.Kodegdg,0.00 QNT,0.00 NilaiDPP,0.00 NilaiPPN,0.00 jumlahNetto, 

       Sum(b.qntAwal) AS QntDB, Sum(b.Qnt2Awal) Qnt2DB, Sum(b.QNTAWAL)* Case when Left(d.KODEGRP,3)='110' Then case When b.TAHUN<2015 or (b.TAHUN=2015 and b.BULAN=1) Then c.Hrg else case when Sum(b.qntAwal)=0 then 0 else Sum(B.HRGAwal)/Sum(b.qntAwal)   else case When b.TAHUN=2015 and b.BULAN=1 Then d.Hrg1_2 else case when Sum(b.qntAwal)=0 then 0 else Sum(B.HRGAwal)/Sum(b.qntAwal)    HrgDebet, 

       CAST(2 AS Numeric(18),0.00) QntCr,  0.00 Qnt2Cr, 0.00 HrgKredit,

       Sum(b.qntAwal) AS QntSaldo, Sum(b.Qnt2Awal) Qnt2Saldo, Sum(b.QNTAWAL)* Case when Left(d.KODEGRP,3)='110' Then case When b.TAHUN<2015 or (b.TAHUN=2015 and b.BULAN=1) Then c.Hrg else case when Sum(b.qntAwal)=0 then 0 else Sum(B.HRGAwal)/Sum(b.qntAwal)   else case When b.TAHUN=2015 and b.BULAN=1 Then d.Hrg1_2 else case when Sum(b.qntAwal)=0 then 0 else Sum(B.HRGAwal)/Sum(b.qntAwal)    HrgSaldo, 

       Dateadd(MM, 0, Cast(CASE WHEN b.Bulan < 10 THEN '0' ELSE ''  + Cast(b.Bulan AS varchar(2))+'-01-'+ 

                           Cast(b.Tahun AS varchar(4)) AS Datetime)) Tanggal, b.Bulan, b.Tahun, 

      'Saldo Awal' Nobukti, 0 Urut,

      '' KodeCustSupp, '' Keterangan, '' IDUSER, 

      --case when Sum(b.qntAwal)=0 then 0 else Sum(B.HRGAwal)/Sum(b.qntAwal)  HPP

     Case when Left(d.KODEGRP,3)='110' Then case When b.TAHUN<2015 or (b.TAHUN=2015 and b.BULAN=1) Then c.Hrg else case when Sum(b.qntAwal)=0 then 0 else Sum(B.HRGAwal)/Sum(b.qntAwal)   else case When b.TAHUN=2015 and b.BULAN=1 Then d.Hrg1_2 else case when Sum(b.qntAwal)=0 then 0 else Sum(B.HRGAwal)/Sum(b.qntAwal)    HPP,NamaBrg

FROM  DBSTOCKBRG b

Left Outer Join dbBarang d on d.KodeBrg=b.KODEBRG

Left Outer Join (select Kodebrg,MONTH(Tanggal)Bulan,YEAR(Tanggal)Tahun,AVG(Hrg)Hrg from VwHrgRata2 Group By Kodebrg,MONTH(Tanggal),YEAR(Tanggal))c On c.Kodebrg=b.Kodebrg and c.Bulan=case when b.Bulan=1 Then 12 else b.Bulan-1  and  c.Tahun=case when b.Bulan=1 Then b.Tahun-1 else b.TAHUN 

--Left Outer Join (Select Kodebrg,MONTH(MAX(Tanggal))Bulan,YEAR(MAX(TANGGAL))Tahun,AVG(HPP)HPP from DBSODET a Left Outer Join DBSO b On a.NOBUKTI=b.NOBUKTI where HPP<>0 Group by Kodebrg)c1 on c1.Kodebrg=b.Kodebrg and c1.Bulan<=case when b.Bulan=1 Then 12 else b.Bulan-1  and  c1.Tahun<=case when b.Bulan=1 Then b.Tahun-1 else b.TAHUN 

left outer join (select Bulan,Tahun,KodeBrg,HPPBrg HPP from dbHPPProduksi)HPP on HPP.KODEBRG=b.KODEBRG and hpp.Bulan=b.BULAN and hpp.Tahun=b.BULAN

where b.QNTAWAL<>0 or b.QNT2AWAL<>0 and c.Bulan=case when b.Bulan=1 Then 12 else b.Bulan-1  and  c.Tahun=case when b.Bulan=1 Then b.Tahun-1 else b.TAHUN 

and b.Bulan=@Bulan and  b.Tahun=@tahun 

Group by b.Kodebrg, b.Kodegdg,c.Hrg,b.BULAN,b.TAHUN,Left(d.KODEGRP,3),d.Hrg1_2,NamaBrg --,d.Hrg1_2

union ALL

Select 	'PBL' Tipe, 'PBL' MyTipe, 'A10' Prioritas, B.KodeBrg, B.KodeGdg, B.QNT Qnt, B.NDPP NilaiDpp ,B.NPPN NilaiPPN, b.NNET Jumlahnetto,

 case When a.NOBUKTI Like '%INT%' Then Case When Nosat=2 Then (COALESCE(B.Qnt1Terima,Qnt2Terima*B.ISI)-COALESCE(B.Qnt1Reject,0)) else B.QNT  else Case When Nosat=2 Then (COALESCE(B.Qnt1Terima,Qnt2Terima*B.ISI)-COALESCE(B.Qnt1Reject,0)) else B.QNT    QntDb, COALESCE(B.Qnt2Terima,0)-COALESCE(B.Qnt2Reject,0) Qnt2Db, B.NDPPRp HrgDebet,

	(case when c.IsJasa=1 Then COALESCE(B.Qnt1Terima,0)-COALESCE(B.Qnt1Reject,0) else 0.00 ) QntCr, 0.00 Qnt2Cr, case when c.IsJasa=1 Then B.NDPPRp else 0.00  HrgKredit,

	case When a.NOBUKTI Like '%INT%' Then (case when c.IsJasa=1 Then 0.00 else COALESCE(B.Qnt1Terima,Qnt2Terima*B.ISI)-COALESCE(B.Qnt1Reject,0) ) else (case when c.IsJasa=1 Then 0.00 else COALESCE(B.Qnt1Terima,Qnt2Terima*B.ISI)-COALESCE(B.Qnt1Reject,0) )   QntSaldo, COALESCE(B.Qnt2Terima,0)-COALESCE(B.Qnt2Reject,0) Qnt2Saldo, case when c.IsJasa=1 Then B.NDPPRp else B.NDPPRp  HrgSaldo,

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti, B.Urut,

	A.KodeSupp,case when c.IsJasa=1 Then b.NamaBrg else d.namacustsupp  as  Keterangan, ''IDUser,

	--B.NDPPRp/case when COALESCE(B.Qnt1Terima,0)-COALESCE(B.Qnt1Reject,0)=0 then 1 else COALESCE(B.Qnt1Terima,0)-COALESCE(B.Qnt1Reject,0)    HPP

    --Case When c1.KodeBrg Is null Then COALESCE(c.Hrg1_2,B.Harga) else COALESCE(c1.HPP,B.Harga)  

    case when isi=0 then case when b.PPN=2 then (HARGA/1.1)/1 else HARGA /1  else case when b.PPN=2 then (HARGA/1.1)/ISI else   Harga/ISI   HPP,c.NamaBrg

from 	dbBeli A

left outer join dbBeliDet B on B.NoBukti=A.NoBukti

left outer join DBBARANG C on C.KODEBRG=B.KodeBrg

left outer join dbcustsupp D on d.kodecustsupp=a.kodesupp

--Left Outer Join HPPSO c1 On c1.Kodebrg=b.Kodebrg

where B.KODEBRG is not null

--Group By B.KodeBrg, B.KodeGdg,A.TANGGAL,A.NOBUKTI,A.KODESUPP, B.Urut

union all

Select 	'RPB' Tipe, 'RPB' MyTipe, 'B10' Prioritas, B.KodeBrg, A.KodeGdg,COALESCE(B.QNT,0) QNT, B.NDPP NilaiDpp ,B.NPPN NilaiPPN, b.NNET Jumlahnetto,

   0.00 QntDb, 0.00 Qnt2Db, 0.00 HrgDebet,

	COALESCE(B.Qnt1,0) QntCr, COALESCE(B.Qnt2,0) Qnt2Cr, B.NDPP HrgKredit,

	-1*COALESCE(B.Qnt1,0) QntSaldo, -1*COALESCE(B.Qnt2,0) Qnt2Saldo, -1*B.NDPP HrgSaldo,

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

where 	(B.Qnt<>0 )and c1.Bulan=MONTH(a.TANGGAL) and c1.Tahun=YEAR(a.Tanggal)

and Month(a.Tanggal)=@Bulan and Year(a.Tanggal)=@Tahun

--Group By B.KodeBrg, A.kodegdg,A.Tanggal, A.NoBukti, B.URUT

--Left Outer Join HPPSO c1 On c1.Kodebrg=b.Kodebrg

--Group By B.KodeBrg, A.KodeGdg,A.TANGGAL,A.NOBUKTI,A.KODESUPP, B.Urut

union all

Select 	'PMK' Tipe, 'PMK' MyTipe, 'B20' Prioritas, B.KodeBrg, A.KodeGdg,B.QNT QNt,0.00 NilaiDpp ,0.00 NilaiPPN,0.00 Jumlahnetto,

   0.00 QntDb, 0.00 Qnt2Db, 0.00 HrgDebet,

	COALESCE(B.Qnt,0) QntCr, COALESCE(B.Qnt2,0) Qnt2Cr, B.Qnt*COALESCE(B.HPP,0)  HrgKredit,

	COALESCE(B.Qnt,0) *-1 QntSaldo, COALESCE(B.Qnt2,0)*-1 Qnt2Saldo, -1*B.Qnt*COALESCE(B.HPP,0)  HrgSaldo,

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti, B.Urut,

	''KodeSupp, Upper(/*B.NoSPK+' '+dp.NMDEP+' '+*/case when a.KdDep='A.BR' then E.NamaAlat else a.NoPOL ) Keterangan, ''IDUser,

	COALESCE(B.HPP,0) HPP,c.NamaBrg

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

where Month(a.Tanggal)=@Bulan and Year(a.Tanggal)=@Tahun

--Group By  B.KodeBrg, A.KodeGdg,A.Tanggal,A.Nobukti, B.Urut

union all

Select 	'RPK' Tipe, 'RPK' MyTipe, 'A20' Prioritas, B.KodeBrg, A.KodeGdg, B.QNT Qnt,0.00 NilaiDpp ,0.00 NilaiPPN,0.00 Jumlahnetto,

   B.Qnt QntDb, B.Qnt2 Qnt2Db, B.Qnt*COALESCE(B.HPP,0) HrgDebet,

	0.00 QntCr, 0.00 Qnt2Cr, 0.00 HrgKredit, 

	B.Qnt QntSaldo, B.Qnt2 Qnt2Saldo, B.Qnt*COALESCE(B.HPP,0) HrgSaldo,

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti, B.Urut,

	''KodeSupp, '' Keterangan, ''IDUser,

	COALESCE(B.HPP,0) HPP,c.NamaBrg

	--Case When c1.KodeBrg Is null Then c.Hrg1_2 else c1.HPP  HPP

from 	DBRPenyerahanBhn A

left outer join DBRPenyerahanBhndet B on B.NoBukti=A.NoBukti

left outer join DBBARANG C on C.KODEBRG=B.KodeBrg

where Month(a.Tanggal)=@Bulan and Year(a.Tanggal)=@Tahun

--Left Outer Join HPPSO c1 On c1.Kodebrg=b.Kodebrg

--Group By B.KodeBrg, A.KodeGdg,A.Tanggal,A.Nobukti, B.Urut

Union All

Select 	'TRI' Tipe, 'TRI' MyTipe, 'A05' Prioritas, B.KodeBrg, B.GdgTujuan,B.QNT Qnt,0.00 NilaiDpp ,0.00 NilaiPPN,0.00 Jumlahnetto,

   B.Qnt, B.Qnt2 Qnt2Db, B.Qnt*case When COALESCE(c1.HPP,0)<>0  Then c1.HPP else B.HPP  HrgDebet,

	0.00 QntCr, 0.00 Qnt2Cr, 0.00 HrgKredit,

	B.Qnt QntSaldo, B.Qnt2 Qnt2Saldo, B.Qnt*case When COALESCE(c1.HPP,0)<>0  Then c1.HPP else B.HPP  HrgSaldo, 

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti, B.Urut,

	'' KodeCustSupp, '' Keterangan, '' IDUSER,

	--B.HPP HPP

	case When COALESCE(c1.HPP,0)<>0  Then c1.HPP else B.HPP  HPP,c.NamaBrg

from 	DBTRANSFER A

left outer join DBTRANSFERDET B on B.NoBukti=A.NoBukti

left outer join DBBARANG C on C.KODEBRG=B.KodeBrg

--Left Outer Join (select Kodebrg,AVG(HPP)HPP from HPPSO Group By KODEBRG) c1 On c1.Kodebrg=b.Kodebrg

Left Outer Join (select Bulan,Tahun,KodeBrg,HPPBrg HPP from dbHPPProduksi) c1 on c1.KODEBRG=b.KODEBRG and c1.Bulan=month(A.TANGGAL) and c1.Tahun=YEAR(a.TANGGAL)

where 	(B.Qnt<>0 or B.Qnt2<>0)

and Month(a.Tanggal)=@Bulan and Year(a.Tanggal)=@Tahun

--and A.NOBUKTI Like '%-GM%' 

--Group By B.KodeBrg, B.GdgTujuan,A.Tanggal, A.NoBukti, B.Urut

union all

Select 	'TRO' Tipe, 'TRO' MyTipe, 'B05' Prioritas, B.KodeBrg,B.GDGAsal,B.QNT QNT,0.00 NilaiDpp ,0.00 NilaiPPN,0.00 Jumlahnetto,

   0.00 QntDb, 0.00 Qnt2Db, 0.00 HrgDebet,

	B.Qnt, B.Qnt2 Qnt2Cr, B.Qnt*case When COALESCE(c1.HPP,0)<>0  Then c1.HPP else B.HPP  HrgKredit,

	-1*B.Qnt QntSaldo, -1*B.Qnt2 Qnt2Saldo, -1*B.Qnt*case When COALESCE(c1.HPP,0)<>0  Then c1.HPP else B.HPP  HrgSaldo, 

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti, B.Urut,

	'' KodeCustSupp, '' Keterangan, ''IDUser,

	case When COALESCE(c1.HPP,0)<>0  Then c1.HPP else B.HPP  HPP,c.NamaBrg

	-- case when B.GDGTUJUAN='R1' Then 0 else c1.Hrg   HPP

from 	DBTRANSFER A

left outer join DBTRANSFERDET B on B.NoBukti=A.NoBukti

left outer join DBBARANG C on C.KODEBRG=B.KodeBrg

Left Outer Join (select Bulan,Tahun,KodeBrg,HPPBrg HPP from dbHPPProduksi) c1 on c1.KODEBRG=b.KODEBRG and c1.Bulan=month(A.TANGGAL) and c1.Tahun=YEAR(a.TANGGAL)

--Left Outer Join (select Kodebrg,MONTH(Tanggal)Bulan,YEAR(Tanggal)Tahun,AVG(Hrg)Hrg from VwHrgRata2 Group By Kodebrg,MONTH(Tanggal),YEAR(Tanggal))c1 On c1.Kodebrg=b.Kodebrg and c1.Bulan=MONTH(a.TANGGAL) and c1.Tahun=YEAR(a.Tanggal)

where 	(B.Qnt<>0 or B.Qnt2<>0) and

Month(a.Tanggal)=@Bulan and Year(a.Tanggal)=@Tahun

--and A.NOBUKTI Like '%-GK%' 

--Group By B.KodeBrg, B.GDGASAL,A.Tanggal, A.NoBukti, B.Urut

/*union all

Select 	'PBI' Tipe, 'PBI' MyTipe, 'B06' Prioritas, B.KodeBrg, A.KodeGdgT, COALESCE(B.QNT,0) Qnt,0.00 NilaiDpp ,0.00 NilaiPPN,0.00 Jumlahnetto,

   COALESCE(B.Qnt,0) QntDb, COALESCE(B.Qnt2,0) Qnt2Db, COALESCE(B.Qnt,0)*Case When c1.KodeBrg Is null Then c.Hrg1_2 else c1.HPP  HrgDebet,

	0.00 QntCr, 0.00 Qnt2Cr, 0.00 HrgKredit,

	COALESCE(B.Qnt,0) QntSaldo, COALESCE(B.Qnt2,0) Qnt2Saldo, COALESCE(B.Qnt,0)*Case When c1.KodeBrg Is null Then c.Hrg1_2 else c1.HPP  HrgSaldo,

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti, B.Urut,

	''KodeSupp, '' Keterangan, ''IDUser,

	--COALESCE(B.HPP,0) HPP

	Case When c1.KodeBrg Is null Then c.Hrg1_2 else c1.HPP  HPP

from 	DBBPPBT A

left outer join DBBPPBTDET B on B.NoBukti=A.NoBukti

left outer join DBBARANG C on C.KODEBRG=B.KodeBrg

Left Outer Join HPPSO c1 On c1.Kodebrg=b.Kodebrg

--Group By B.KodeBrg, A.KodeGdgT,A.TANGGAL,A.NOBUKTI, B.Urut

Union All

Select 	'PBO' Tipe, 'PBO' MyTipe, 'B06' Prioritas, B.KodeBrg, 'G001' KodeGdg,COALESCE(B.QNT,0) Qnt,0.00 NilaiDpp ,0.00 NilaiPPN,0.00 Jumlahnetto,

    0.00 QntDb, 0.00 Qnt2Db, 0.00 HrgDebet,

	COALESCE(B.Qnt,0) QntCr, COALESCE(B.Qnt2,0) Qnt2Cr, COALESCE(B.Qnt,0)*Case When c1.KodeBrg Is null Then c.Hrg1_2 else c1.HPP  HrgKredit, 

	COALESCE(B.Qnt,0)*-1 QntSaldo, COALESCE(B.Qnt2,0)*-1 Qnt2Saldo, -1*COALESCE(B.Qnt,0)*Case When c1.KodeBrg Is null Then c.Hrg1_2 else c1.HPP  HrgSaldo,

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti, B.Urut,

	''KodeSupp, '' Keterangan, ''IDUser,

	--COALESCE(B.HPP,0) HPP

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

where	b.qntdb<>0 and

Month(a.Tanggal)=@Bulan and Year(a.Tanggal)=@Tahun

--Group By B.KodeBrg, B.KodeGdg,A.NOBUKTI,A.Tanggal,B.UserID, B.Urut

union all

Select 	'UK0' Tipe, 'UK0' MyTipe, 'B60' Prioritas, B.KodeBrg, B.KodeGdg,B.QNTCR QNT,0.00 NilaiDpp ,0.00 NilaiPPN,0.00 Jumlahnetto,

   0.00 QNTDB, 0.00 Qnt2Db, 0.00 HrgDebet,

	B.QNTCR, Case when B.NOSAT=2 Then B.QNTCR else (B.QNTCR/(Case when B.ISI=0 Then 1 else C.ISI2 ))  Qnt2Cr,B.HARGA HrgKredit,

	B.QNTCR*-1 QntSaldo,Case when B.NOSAT=2 Then B.QNTCR else (B.QNTCR/(Case when B.ISI=0 Then 1 else C.ISI2 )) *-1 Qnt2Saldo, 0.00 HrgSaldo,

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti,B.Urut,

	''KodeSupp, '' Keterangan,B.UserID IDUser,

	--0.00 HPP

	Case When COALESCE(c1.HPP,0)=0 Then b.HPP else c1.HPP  HPP,c.NamaBrg

from 	DBUBAHKEMASAN A

left outer join DBUBAHKEMASANDET B on B.NoBukti=A.NoBukti

left outer join DBBARANG C on C.KODEBRG=B.KodeBrg

--Left Outer Join HPPSO c1 On c1.Kodebrg=b.Kodebrg

Left Outer Join (select Bulan,Tahun,KodeBrg,HPPBrg HPP from dbHPPProduksi) c1 on c1.KODEBRG=b.KODEBRG and c1.Bulan=month(A.TANGGAL) and c1.Tahun=YEAR(a.TANGGAL)

where	b.qntcr<>0 and Month(a.Tanggal)=@Bulan and Year(a.Tanggal)=@Tahun

--Group By B.KodeBrg, B.KodeGdg,A.NOBUKTI,A.Tanggal,B.UserID, B.URUT



union all

Select 	'ADI' Tipe, 'ADI' MyTipe, 'A70' Prioritas, B.KodeBrg, A.kodegdg, B.QNTDB Qnt,0.00 NilaiDpp ,0.00 NilaiPPN,0.00 Jumlahnetto,

   B.QntDb , B.Qnt2DB Qnt2Db, B.QntDb*CASE When C.KODEGRP='BM' then case when COALESCE(B.HARGA,0)=0 then COALESCE(B.HPP,0) else COALESCE(B.HARGA,0)  else case when a.NOBUKTI in('BCA/OPBJ/0621/0001','BCA/OPBJ/0621/0003','BCA/OPBJ/0621/0005','CA/OPBJ/0621/0002') then COALESCE(B.HARGA,0) else c1.HPPBrg   HrgDebet,

	0.00 QntCr, 0.00 Qnt2Cr, 0.00 HrgKredit,

	B.QntDb QntSaldo, B.Qnt2DB Qnt2Saldo, B.QntDb*CASE When C.KODEGRP='BM' then case when COALESCE(B.HARGA,0)=0 then COALESCE(B.HPP,0) else COALESCE(B.HARGA,0)  else case when a.NOBUKTI in('BCA/OPBJ/0621/0001','BCA/OPBJ/0621/0003','BCA/OPBJ/0621/0005','CA/OPBJ/0621/0002') then COALESCE(B.HARGA,0) else c1.HPPBrg   HrgSaldo, 

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti, B.Urut,

	'' KodeCustSupp, A.Note Keterangan, '' IDUSER,

    --B.Harga HPP

	CASE When C.KODEGRP='BM' then case when COALESCE(B.HARGA,0)=0 then COALESCE(B.HPP,0) else COALESCE(B.HARGA,0)  else case when a.NOBUKTI in('BCA/OPBJ/0621/0001','BCA/OPBJ/0621/0003','BCA/OPBJ/0621/0005','CA/OPBJ/0621/0002') then COALESCE(B.HARGA,0) else c1.HPPBrg   HPP,c.NamaBrg

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

and Month(a.Tanggal)=@Bulan and Year(a.Tanggal)=@Tahun

--Group By B.KodeBrg, A.kodegdg,A.Tanggal, A.NoBukti, B.URUT

union all

Select 	'ADO' Tipe, 'ADO' MyTipe, 'B70' Prioritas, B.KodeBrg,A.KodeGdg, B.QNTCR QNT,0.00 NilaiDpp ,0.00 NilaiPPN,0.00 Jumlahnetto,

   0.00 QntDb, 0.00 Qnt2Db, 0.00 HrgDebet,

	B.QntCr, B.Qnt2Cr Qnt2Cr, B.QntCr*case when a.NOBUKTI in('CA/KRS/0121/00035','BCA/KRS/0121/00039','BCA/OPBJ/0621/0001','BCA/OPBJ/0621/0002','BCA/OPBJ/0621/0004','BCA/OPBJ/0621/0006','CA/OPN/0621/0002','CA/OPBJ/0621/0003') then b.HARGA else case When COALESCE(c1.HPPBrg,0)<>0 Then c1.HPPBrg else B.HPP   HrgKredit,

	-1*B.QntCr QntSaldo, -1*B.Qnt2Cr Qnt2Saldo, -1*B.QntCr*case when a.NOBUKTI in('CA/KRS/0121/00035','BCA/KRS/0121/00039','BCA/OPBJ/0621/0001','BCA/OPBJ/0621/0002','BCA/OPBJ/0621/0004','BCA/OPBJ/0621/0006','CA/OPN/0621/0002','CA/OPBJ/0621/0003') then b.HARGA else case When COALESCE(c1.HPPBrg,0)<>0  Then c1.HPPBrg else B.HPP   HrgSaldo, 

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti, B.Urut,

	'' KodeCustSupp, A.NOTE Keterangan, ''IDUser,

  case when a.NOBUKTI in('CA/KRS/0121/00035','BCA/KRS/0121/00039','BCA/OPBJ/0621/0001','BCA/OPBJ/0621/0002','BCA/OPBJ/0621/0004','BCA/OPBJ/0621/0006','CA/OPN/0621/0002','CA/OPBJ/0621/0003') then b.HARGA else case When COALESCE(c1.HPPBrg,0)<>0 Then c1.HPPBrg else B.HPP   HPP,c.NamaBrg

	--COALESCE(c1.Hrg,0) HPP

from 	dbKoreksi A

left outer join dbKoreksiDet B on B.NoBukti=A.NoBukti

left outer join DBBARANG C on C.KODEBRG=B.KodeBrg

Left Outer Join dbHPPProduksi c1 on B.KODEBRG=c1.KodeBrg and MONTH(a.Tanggal)=c1.Bulan and YEAR(a.TANGGAL)=c1.Tahun

--Left Outer Join (select Kodebrg,MONTH(Tanggal)Bulan,YEAR(Tanggal)Tahun,AVG(Hrg)Hrg from VwHrgRata2 Group By Kodebrg,MONTH(Tanggal),YEAR(Tanggal))c1 On c1.Kodebrg=b.Kodebrg and c1.Bulan=MONTH(a.TANGGAL) and c1.Tahun=YEAR(a.Tanggal)

where 	(B.QntCr<>0 or B.Qnt2CR<>0) and

Month(a.Tanggal)=@Bulan and Year(a.Tanggal)=@Tahun --and c1.Bulan=MONTH(a.TANGGAL) and c1.Tahun=YEAR(a.Tanggal)

--Group By B.KodeBrg, A.kodegdg,A.Tanggal, A.NoBukti, B.URUT

Union ALL

Select 	'PNJ' Tipe, 'PNJ' MyTipe, 'B80' Prioritas, B.KodeBrg,B.KodeGdg,B.QNT QNT,0.00 NilaiDpp ,0.00 NilaiPPN,0.00 Jumlahnetto,

   0.00 QntDb, 0.00 Qnt2Db, 0.00 HrgDebet,

	B.QNT, B.QNT2 Qnt2Cr, B.QNT*case When COALESCE(c1.HPPBrg,0)<>0  Then c1.HPPBrg else B.HPP  HrgKredit,

	-1*B.Qnt QntSaldo, -1*B.Qnt2 Qnt2Saldo, -1*B.Qnt*case When COALESCE(c1.HPPBrg,0)<>0  Then c1.HPPBrg else B.HPP  HrgSaldo, 

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti, B.Urut,

	'' KodeCustSupp, case when c.IsJasa=1 Then b.NamaBrg else d.NAMACUSTSUPP  as Keterangan, ''IDUser,

	case When COALESCE(c1.HPPBrg,0)<>0  Then c1.HPPBrg else B.HPP  HPP,c.NamaBrg

	--B.HPP HPP

	--Case When COALESCE(c1.HPP,0)=0 Then c.Hrg1_2 else c1.HPP  HPP

from 	dbSPB A

left outer join dbSPBDet B on B.NoBukti=A.NoBukti

left outer join dbcustsupp D on d.kodecustsupp=a.kodecustsupp

left outer join DBBARANG C on C.KODEBRG=B.KodeBrg

Left Outer Join dbHPPProduksi c1 On c1.Kodebrg=b.Kodebrg and C1.Bulan=MONTH(a.Tanggal) and C1.Tahun=YEAR(a.Tanggal)

where 	B.Qnt<>0 or B.Qnt2<>0 and

Month(a.Tanggal)=@Bulan and Year(a.Tanggal)=@Tahun

--and COALESCE(isDO,0)=0

--Group By B.KodeBrg, B.KodeGdg,A.Tanggal, A.NoBukti, B.Urut

Union ALL

Select 	'RPJ' Tipe, 'RPJ' MyTipe, 'A80' Prioritas, B.KODEBRG,A.KodeGdg,B.QNT QNT,0.00 NilaiDpp ,0.00 NilaiPPN,0.00 Jumlahnetto,

   B.QNT QntDb, B.QNT2 Qnt2Db, --B.QNT*case When C.KODEGRP='FG' Then c1.HPPBrg else B.HPP  HrgDebet,

   B.QNT*case When COALESCE(c1.HPPBrg,0)<>0  Then c1.HPPBrg else B.HPP  HrgDebet,

	0.00,  0.00 Qnt2Cr, 0.00 HrgKredit,

	B.Qnt QntSaldo, B.Qnt2 Qnt2Saldo, B.Qnt*case When COALESCE(c1.HPPBrg,0)<>0  Then c1.HPPBrg else B.HPP   HrgSaldo, 

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti, B.Urut,

	B.NoSPB KodeCustSupp, case when c.IsJasa=1 Then b.NamaBrg else d.NAMACUSTSUPP  as Keterangan, ''IDUser,

	--case When C.KODEGRP='FG' Then c1.HPPBrg else B.HPP  HPP

	--Case When COALESCE(c1.KodeBrg,'')='' Then c.Hrg1_2 else c1.HPP  HPP

	case When COALESCE(c1.HPPBrg,0)<>0  Then c1.HPPBrg else B.HPP  HPP,c.NamaBrg

from 	DBRSPB A

left outer join DBRSPBDet B on B.NoBukti=A.NoBukti

--Left Outer Join (select NoBukti,Urut,NoSPP from dbSPBDet Group By NoBukti,Urut,NoSPP)SPB On SPB.NoBukti=B.NoSPB 

left Outer join dbcustsupp D on d.kodecustsupp=a.kodecustsupp

left outer join DBBARANG C on C.KODEBRG=B.KodeBrg

Left Outer Join dbHPPProduksi c1 On c1.Kodebrg=b.Kodebrg and C1.Bulan=MONTH(a.Tanggal) and C1.Tahun=YEAR(a.Tanggal)

where 	(B.Qnt<>0 or B.Qnt2<>0)

and Month(a.Tanggal)=@Bulan and Year(a.Tanggal)=@Tahun

--Group By B.KodeBrg,B.KodeGdg, A.Tanggal, A.NoBukti, B.Urut

Union ALL

Select 	'RPJ' Tipe, 'RPJ' MyTipe, 'C80' Prioritas, B.KODEBRG,B.KodeGdg,B.QNT QNT,0.00 NilaiDpp ,0.00 NilaiPPN,0.00 Jumlahnetto,

   B.QNT QntDb, B.QNT2 Qnt2Db, --B.QNT*case When C.KODEGRP='FG' Then c1.HPPBrg else B.HPP  HrgDebet,

   B.QNT*case When COALESCE(c1.HPPBrg,0)<>0  Then c1.HPPBrg else B.HPP  HrgDebet,

	0.00,  0.00 Qnt2Cr, 0.00 HrgKredit,

	B.Qnt QntSaldo, B.Qnt2 Qnt2Saldo, B.Qnt*case When COALESCE(c1.HPPBrg,0)<>0  Then c1.HPPBrg else B.HPP   HrgSaldo, 

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti, B.Urut,

	'' KodeCustSupp, case when c.IsJasa=1 Then b.NamaBrg else d.NAMACUSTSUPP  as Keterangan, ''IDUser,

	--case When C.KODEGRP='FG' Then c1.HPPBrg else B.HPP  HPP

	--Case When COALESCE(c1.KodeBrg,'')='' Then c.Hrg1_2 else c1.HPP  HPP

	case When COALESCE(c1.HPPBrg,0)<>0  Then c1.HPPBrg else B.HPP  HPP,c.NamaBrg

from 	dbSPBRJual A

left outer join dbSPBRJualDet B on B.NoBukti=A.NoBukti

--Left Outer Join (select NoBukti,Urut,NoSPP from dbSPBDet Group By NoBukti,Urut,NoSPP)SPB On SPB.NoBukti=B.NoSPB 

left Outer join dbcustsupp D on d.kodecustsupp=a.kodecustsupp

left outer join DBBARANG C on C.KODEBRG=B.KodeBrg

Left Outer Join dbHPPProduksi c1 On c1.Kodebrg=b.Kodebrg and C1.Bulan=MONTH(a.Tanggal) and C1.Tahun=YEAR(a.Tanggal)

where 	(B.Qnt<>0 or B.Qnt2<>0)

and Month(a.Tanggal)=@Bulan and Year(a.Tanggal)=@Tahun

Union ALL

Select 	'HP' Tipe, 'HP' MyTipe, 'A90' Prioritas, B.KODEBRG,B.KodeGdg, Case when B.NOSAT=1 Then (B.Qnt) else (B.Qnt*B.ISI)   QNT,0.00 NilaiDpp ,0.00 NilaiPPN,0.00 Jumlahnetto,

   Case when B.NOSAT=1 Then (B.Qnt) else (B.Qnt*B.ISI)   QntDb, Case when B.NOSAT=2 Then B.QNT else (B.QNT/(Case when B.ISI=0 Then 1 else C.ISI2 ))  Qnt2Db, 

   case when B.NOSAT=1 then B.Qnt else B.Qnt*B.ISI *Case When COALESCE(HPP.HPP,0)=0 Then b.HPP else HPP.HPP  HrgDebet,

	0.00,  0.00 Qnt2Cr, 0.00 HrgKredit,

	Case when B.NOSAT=1 Then (B.Qnt) else (B.Qnt*B.ISI)   QntSaldo, Case when B.NOSAT=2 Then B.QNT else (B.QNT/(Case when B.ISI=0 Then 1 else C.ISI2 ))  Qnt2Saldo, 

	case when B.NOSAT=1 then B.Qnt else B.Qnt*B.ISI *Case When COALESCE(HPP.HPP,0)=0 Then b.HPP else HPP.HPP  HrgSaldo, 

	A.Tanggal, month(A.Tanggal) Bulan, year(A.Tanggal) Tahun, A.NoBukti, B.Urut,

	'' KodeCustSupp,'' Keterangan, ''IDUser,

	--B.HPP HPP

	Case When COALESCE(HPP.HPP,0)=0 Then b.HPP else HPP.HPP  HPP,c.NamaBrg

from 	DBHASILPRD A

left outer join DBHASILPRDDet B on B.NoBukti=A.NoBukti

--Left Outer Join(Select a.NOBUKTI NoSPK,c.NAMACUSTSUPP from DBSPK a

--                Left Outer Join DBSO b on b.NOBUKTI=a.NOSO 

--                Left Outer Join DBCUSTSUPP c On c.KODECUSTSUPP=b.KODECUST)B1 On B1.NoSPK=B.NoSPK

Left Outer Join DBBARANG C on C.KODEBRG=B.KODEBRG

Left Outer Join (select Bulan,Tahun,KodeBrg,HPPBrg HPP from dbHPPProduksi) HPP on HPP.KODEBRG=b.KODEBRG and hpp.Bulan=month(A.TANGGAL) and hpp.Tahun=YEAR(a.TANGGAL)

where Month(a.Tanggal)=@Bulan and Year(a.Tanggal)=@Tahun

);

-- NamaSales (FUNCTION)
CREATE FUNCTION IF NOT EXISTS NamaSales AS -- DECLARE REMOVED 

  Select @NamaSales =b.Nama 

                     from dbInvoicePLDet a

                     left outer join DBInvoicePL a1 on a1.NoBukti=a.NoBukti

                     left outer join 

                       (select a.NOBUKTI,b.Nama from DBSO a

                        left outer join dbKaryawan b on b.KeyNIK=a.KODESLS) b on b.NOBUKTI=a.NoSO

                     where a1.NoJurnal in (select NoJurnal from dbinvoicepl where 

                     case when A1.FLagTipe='P' then case when A1.NoInv<>A1.NoBukti then left(A1.NOBUKTI,5)+SUBSTRING(A1.NoBukti,8,6)+SUBSTR(A1.NOBUKTI, LENGTH(A1.NOBUKTI)-2+1)+'-'+A1.NoInv else A1.NOBUKTI  else A1.NOBUKTI =@Nobukti )

   Return @NamaSales;

-- PiutSjVsInv (FUNCTION)
CREATE FUNCTION IF NOT EXISTS PiutSjVsInv AS RETURN 

(

select A.KODECUSTSUPP,A.NAMACUSTSUPP,B.PiutSJ,C.INV from DBCUSTSUPP A

left outer join 

(

  select a.KodeCustSupp,sum(COALESCE(a.INV,0)) PiutSJ

  from (

  Select  A.NoBukti+SUBSTR('00000'+cast(A.Urut as varchar(5)), LENGTH('00000'+cast(A.Urut as varchar(5)))-5+1) KeyNoBukti, A.Nobukti, F.Tanggal, F.KodeCustSupp, S.Namacust NamaCustSupp,F.NoResi,P.NAMAPROJECT,

          A.urut, A.kodebrg, B.NamaBrg, '' Jns_Kertas, '' Ukr_Kertas, A.Sat_1, A.Isi,A.Qnt qnt,a.qntinv qntinv,a.QntRetur, A.QntSisa qntsisa,

          A.SAT_1 Satuan, e.Tglkirim,e.NOBUKTI noso,e.tanggal tglso,e.NOSPB nopo,g.HARGA,COALESCE(g1.HPPBrg,0) HPP, (A.QntSisa *g.HARGA)-((A.QntSisa *g.HARGA)*g.DISC/100) dppnet, A.QntSisa *COALESCE(g1.HPPBrg,0) hppnet,A.Nosat,A.SAT_2,

          c.NoSPP,c.UrutSPP,A.Qnt*g.HARGA SJ,(a.qntinv*g.HARGA)-((a.qntinv*g.HARGA)*g.DISC/100) INV

  From    vwPiutSJ_DPPINV(@TglAwal,@TglAkhir) A

  left outer join dbSPB F on f.NoBukti=a.NoBukti

  left outer join dbSPBDet c on c.NoBukti=a.NoBukti and c.KodeBrg=a.KodeBrg

  left outer join dbSPPDet D on D.NoBukti=c.NoSPP and d.Urut=c.UrutSPP 

  left Outer join DBSO E on E.NOBUKTI=d.NoSO

  left outer join DBSODET G on G.NOBUKTI=e.NOBUKTI and g.KODEBRG=c.KodeBrg

  Left outer join dbHPPProduksi G1 On G1.KodeBrg=A.KodeBrg and MONTH(F.Tanggal)=G1.Bulan and YEAR(F.Tanggal)=G1.Tahun

  Left Outer Join vwBrowsCustomer S on S.KodeCust=F.KodeCustSupp --and s.Sales=E.KODESLS

  Left Outer Join dbBarang B on B.KodeBrg=A.KodeBrg

  Left Outer Join VWSatkecil B1 on B1.Kodebrg=A.KodeBrg

  left outer join DBPROJECT P on P.KODEPROJECT=F.NoResi

  where COALESCE(F.IsClose,0)=0 and A.Tanggal between @TglAwal and @TglAkhir and e.NOBUKTI<>''

  ) A group by a.KodeCustSupp

) B on B.KodeCustSupp=A.KODECUSTSUPP

left outer join 

(select KodeCustSupp,sum(NDPPRp) INV from VwreportinvoicePenjualan where Tanggal Between  @TglAwal and @TglAkhir and NeedOtorisasi=0 group by KodeCustSupp ) C on c.KodeCustSupp=a.KODECUSTSUPP

where ((COALESCE(PiutSJ,0)<>0) or (COALESCE(INV,0)<>0)) and (COALESCE(PiutSJ,0)<>COALESCE(INV,0))  

);

-- Qnt2Awal (FUNCTION)
CREATE FUNCTION IF NOT EXISTS Qnt2Awal AS -- DECLARE REMOVED

  Select @SaldoQnt=SUM(COALESCE(Saldo2Qnt,0)) 

  From dbStockAV

  where KODEBRG=@Kodebrg and BULAN=Case when @Bulan=1 then 12 else @Bulan-1   and TAHUN=Case when @bulan=1 then @Tahun-1 else @Tahun  and

        Kodegdg=@kodegdg

  Return COALESCE(@SaldoQnt,0);

-- Qnt2SPP (FUNCTION)
CREATE FUNCTION IF NOT EXISTS Qnt2SPP AS -- DECLARE REMOVED

  Select @SaldoQnt=SUM(COALESCE(QNT2,0)) 

  From dbSPP a

       left Outer join dbSPPDet b on b.NoBukti=a.NoBukti

  where month(a.tanggal)=@Bulan and YEAR(a.Tanggal)=@Tahun and b.KodeBrg=@Kodebrg and b.kodegdg=@Kodegdg 

  Return @SaldoQnt;

-- QntAwal (FUNCTION)
CREATE FUNCTION IF NOT EXISTS QntAwal AS -- DECLARE REMOVED

  Select @SaldoQnt=SUM(COALESCE(SaldoQnt,0)) 

  From dbStockAV

  where KODEBRG=@Kodebrg and BULAN=Case when @Bulan=1 then 12 else @Bulan-1   and TAHUN=Case when @bulan=1 then @Tahun-1 else @Tahun  and

        Kodegdg=@Kodegdg

  Return COALESCE(@SaldoQnt,0);

-- QntSPP (FUNCTION)
CREATE FUNCTION IF NOT EXISTS QntSPP AS -- DECLARE REMOVED

  Select @SaldoQnt=SUM(COALESCE(Qnt,0)) 

  From dbSPP a

       left Outer join dbSPPDet b on b.NoBukti=a.NoBukti

  where month(a.tanggal)=@Bulan and YEAR(a.Tanggal)=@Tahun and b.KodeBrg=@Kodebrg and 

        b.kodegdg=@Kodegdg

  Return @SaldoQnt;

-- Saldo2IN (FUNCTION)
CREATE FUNCTION IF NOT EXISTS Saldo2IN AS -- =============================================

-- Author:		Noviyanto

-- Create date: 22 Januari 2013

-- Description:	Get Saldo Qnt In 2

-- =============================================

-- DECLARE REMOVED

  Select @SaldoQnt=SUM(COALESCE(Qnt2in,0)) From DBSTOCKBRG where KODEBRG=@Kodebrg and BULAN=@Bulan and TAHUN=@Tahun and

         KODEGDG=@Kodegdg

  Return @SaldoQnt;

-- Saldo2Out (FUNCTION)
CREATE FUNCTION IF NOT EXISTS Saldo2Out AS -- =============================================

-- Author:		Noviyanto

-- Create date: 22 Januari 2013

-- Description:	Get Saldo Qnt In 2

-- =============================================

-- DECLARE REMOVED

  Select @SaldoQnt=SUM(COALESCE(Qnt2Out,0)-COALESCE(QNT2PNJ,0)) From DBSTOCKBRG where KODEBRG=@Kodebrg and BULAN=@Bulan and TAHUN=@Tahun and

         KODEGDG=@Kodegdg

  Return @SaldoQnt;

-- Saldo2Qnt (FUNCTION)
CREATE FUNCTION IF NOT EXISTS Saldo2Qnt AS -- DECLARE REMOVED

  Select @SaldoQnt=SUM((COALESCE(Qnt2Awal,0)+COALESCE(Qnt2In,0))-(COALESCE(Qnt2Out,0)+COALESCE(Qnt2SPP,0))) 

  From dbStockAV

  where KODEBRG=@Kodebrg and BULAN=@Bulan and TAHUN=@Tahun and kodegdg=@Kodegdg

  Return @SaldoQnt;

-- SaldoIN (FUNCTION)
CREATE FUNCTION IF NOT EXISTS SaldoIN AS -- =============================================

-- Author:		Noviyanto

-- Create date: 22 Januari 2013

-- Description:	Get Saldo Qnt In

-- =============================================

-- DECLARE REMOVED

  Select @SaldoQnt=SUM(COALESCE(Qntin,0)) From DBSTOCKBRG where KODEBRG=@Kodebrg and BULAN=@Bulan and TAHUN=@Tahun and KODEGDG=@Kodegdg

  Return @SaldoQnt;

-- SaldoOut (FUNCTION)
CREATE FUNCTION IF NOT EXISTS SaldoOut AS -- =============================================

-- Author:		Noviyanto

-- Create date: 22 Januari 2013

-- Description:	Get Saldo Qnt In 2

-- =============================================

-- DECLARE REMOVED

  Select @SaldoQnt=SUM(COALESCE(QntOut,0)-COALESCE(QNTPNJ,0)) From DBSTOCKBRG where KODEBRG=@Kodebrg and BULAN=@Bulan and TAHUN=@Tahun and

         KODEGDG=@Kodegdg

  Return @SaldoQnt;

-- SaldoQnt (FUNCTION)
CREATE FUNCTION IF NOT EXISTS SaldoQnt AS -- DECLARE REMOVED

  Select @SaldoQnt=SUM((COALESCE(QntAwal,0)+COALESCE(QntIn,0))-(COALESCE(QntOut,0)+COALESCE(QntSPP,0))) 

  From dbStockAV

  where KODEBRG=@Kodebrg and BULAN=@Bulan and TAHUN=@Tahun and Kodegdg=@Kodegdg

  Return @SaldoQnt;

-- Terbilang (FUNCTION)
CREATE FUNCTION IF NOT EXISTS Terbilang AS -- DECLARE REMOVED,

	@large_amount	money,

	@tiny_amount	money,

	@dividen	money,

	@dummy		money,

	@the_word	varchar(250),

	@weight	varchar(100),

	@unit		varchar(30),

	@follower	varchar(50),

	@prefix	varchar(10),

	@sufix		varchar(10)


-- SET REMOVED ''

-- SET REMOVED FLOOR(ABS(@the_amount) )

-- SET REMOVED ROUND((ABS(@the_amount) - @large_amount ) * 100.00,0)

-- SET REMOVED 1000000000000.00



IF @large_amount > @divisor * 1000.00

	RETURN 'OUT OF RANGE' 



WHILE @divisor >= 1

-- SET REMOVED FLOOR(@large_amount / @divisor)

	

	-- SET REMOVED CAST(@large_amount AS bigint) % @divisor

	

	-- SET REMOVED ''

	IF @dividen > 0.00

		-- SET REMOVED(CASE @divisor

			WHEN 1000000000000.00 THEN 'Trilliyun '

			WHEN 1000000000.00 THEN 'Milyar '			

			WHEN 1000000.00 THEN 'Juta '				

			WHEN 1000.00 THEN 'Ribu '

			ELSE @unit

		 )



	-- SET REMOVED ''	

	-- SET REMOVED @dividen

	IF @dummy >= 100.00

		-- SET REMOVED (CASE FLOOR(@dummy / 100.00)

			WHEN 1 THEN 'Se'

			WHEN 2 THEN 'Dua '

			WHEN 3 THEN 'Tiga '

			WHEN 4 THEN 'Empat '

			WHEN 5 THEN 'Lima '

			WHEN 6 THEN 'Enam '

			WHEN 7 THEN 'Tujuh '

			WHEN 8 THEN 'Delapan '

			ELSE 'Sembilan '  ) + 'Ratus '



	-- SET REMOVED CAST(@dividen AS bigint) % 100



	IF @dummy < 10.00

	IF @dummy = 1.00 AND @unit = 'Ribu'

		IF @dividen=@dummy

				-- SET REMOVED @weight + 'Se'

			ELSE

				-- SET REMOVED @weight + 'Satu '

		

		ELSE

		IF @dummy > 0.00 

			-- SET REMOVED @weight + (CASE @dummy

				WHEN 1 THEN 'Satu '

				WHEN 2 THEN 'Dua '

				WHEN 3 THEN 'Tiga '

				WHEN 4 THEN 'Empat '

				WHEN 5 THEN 'Lima '

				WHEN 6 THEN 'Enam '

				WHEN 7 THEN 'Tujuh '

				WHEN 8 THEN 'Delapan '

				ELSE 'Sembilan ' )

	

	ELSE

	IF @dummy BETWEEN 11 AND 19

		-- SET REMOVED @weight + (CASE CAST(@dummy AS bigint) % 10 

			WHEN 1 THEN 'Se'

			WHEN 2 THEN 'Dua '

			WHEN 3 THEN 'Tiga '

			WHEN 4 THEN 'Empat '

			WHEN 5 THEN 'Lima '

			WHEN 6 THEN 'Enam '

			WHEN 7 THEN 'Tujuh '

			WHEN 8 THEN 'Delapan '

			ELSE 'Sembilan '  ) + 'Belas '

	ELSE

	-- SET REMOVED @weight + (CASE FLOOR(@dummy / 10) 

			WHEN 1 THEN 'Se'

			WHEN 2 THEN 'Dua '

			WHEN 3 THEN 'Tiga '

			WHEN 4 THEN 'Empat '

			WHEN 5 THEN 'Lima '

			WHEN 6 THEN 'Enam '

			WHEN 7 THEN 'Tujuh '

			WHEN 8 THEN 'Delapan '

			ELSE 'Sembilan '  ) + 'Puluh '

		IF CAST(@dummy AS bigint) % 10 > 0 

			-- SET REMOVED @weight + (CASE CAST(@dummy AS bigint) % 10 

				WHEN 1 THEN 'Satu '

				WHEN 2 THEN 'Dua '

				WHEN 3 THEN 'Tiga '

				WHEN 4 THEN 'Empat '

				WHEN 5 THEN 'Lima '

				WHEN 6 THEN 'Enam '

				WHEN 7 THEN 'Tujuh '

				WHEN 8 THEN 'Delapan '

				ELSE 'Sembilan '  )


	-- SET REMOVED @the_word + @weight + @unit

	-- SET REMOVED @divisor / 1000.00


IF FLOOR(@the_amount) = 0.00 

	-- SET REMOVED 'Nol '



-- SET REMOVED ''

IF @tiny_amount < 10.00

IF @tiny_amount > 0.00 

		-- SET REMOVED 'Koma Nol ' + (CASE @tiny_amount

			WHEN 1 THEN 'Satu '

			WHEN 2 THEN 'Dua '

			WHEN 3 THEN 'Tiga '

			WHEN 4 THEN 'Empat '

			WHEN 5 THEN 'Lima '

			WHEN 6 THEN 'Enam '

			WHEN 7 THEN 'Tujuh '

			WHEN 8 THEN 'Delapan '

			ELSE 'Sembilan ' )



ELSE

-- SET REMOVED 'Koma ' + (CASE FLOOR(@tiny_amount / 10.00)

			WHEN 1 THEN 'Satu '

			WHEN 2 THEN 'Dua '

			WHEN 3 THEN 'Tiga '

			WHEN 4 THEN 'Empat '

			WHEN 5 THEN 'Lima '

			WHEN 6 THEN 'Enam '

			WHEN 7 THEN 'Tujuh '

			WHEN 8 THEN 'Delapan '

			ELSE 'Sembilan ' )

	IF CAST(@tiny_amount AS bigint) % 10 > 0 

		-- SET REMOVED @follower + (CASE CAST(@tiny_amount AS bigint) % 10

			WHEN 1 THEN 'Satu '

			WHEN 2 THEN 'Dua '

			WHEN 3 THEN 'Tiga '

			WHEN 4 THEN 'Empat '

			WHEN 5 THEN 'Lima '

			WHEN 6 THEN 'Enam '

			WHEN 7 THEN 'Tujuh '

			WHEN 8 THEN 'Delapan '

			ELSE 'Sembilan ' )


-- SET REMOVED @the_word + @follower



IF @the_amount < 0.00

	-- SET REMOVED 'Minus ' + @the_word

	

RETURN @the_word;

-- ThnJurnalOto (FUNCTION)
CREATE FUNCTION IF NOT EXISTS ThnJurnalOto AS -- DECLARE REMOVED

  Select @Thn=case when @Nobukti='' then Thn  from TempJurnalOtoPeriode 

  Return @Thn;

-- TotalDP (FUNCTION)
CREATE FUNCTION IF NOT EXISTS TotalDP AS -- DECLARE REMOVED

  if @Id=''

  Select @TotalDP= SUM(A.DP) 

                   from 

                     (select (sum(a.Debet)-sum(a.Kredit))*-1 DP

 	                  from vwHutpiut a

 	                  left outer join DBCUSTSUPP b on(a.KodeCustSupp=b.KodeCustSupp)

 	                  where  a.tanggal<=@SmpTgl and a.perkiraan='131' 

 	                  --and a.Devisi=case when a.KodeCustSupp not like '%@ca' then '01' else '02' 

 	                  group by a.KodeCustSupp having (sum(a.Debet)-sum(a.Kredit)) <0 ) A

   else

  if @Id='B'

  Select @TotalDP= SUM(A.DP) 

                   from 

                     (select (sum(a.Debet)-sum(a.Kredit))*-1 DP

 	                  from vwHutpiut a

 	                  left outer join DBCUSTSUPP b on(a.KodeCustSupp=b.KodeCustSupp)

 	                  where a.KodeCustSupp not like '%@ca' and  a.tanggal<=@SmpTgl and a.perkiraan='131' 

 	                  --and a.Devisi=case when a.KodeCustSupp not like '%@ca' then '01' else '02' 

 	                  group by a.KodeCustSupp having (sum(a.Debet)-sum(a.Kredit)) <0 ) A

   else

  Select @TotalDP= SUM(A.DP) 

                   from 

                     (select (sum(a.Debet)-sum(a.Kredit))*-1 DP

 	                  from vwHutpiut a

 	                  left outer join DBCUSTSUPP b on(a.KodeCustSupp=b.KodeCustSupp)

 	                  where a.KodeCustSupp like '%@ca' and  a.tanggal<=@SmpTgl and a.perkiraan='131' 

 	                  --and a.Devisi=case when a.KodeCustSupp not like '%@ca' then '01' else '02' 

 	                  group by a.KodeCustSupp having (sum(a.Debet)-sum(a.Kredit)) <0 ) A  


  Return @TotalDP;

-- vwBrowsOutSPB_RSPBN (FUNCTION)
CREATE FUNCTION IF NOT EXISTS vwBrowsOutSPB_RSPBN AS RETURN 

(

Select 	NoBukti, Urut, KodeBrg,Namabrg, Qnt,CAST(2 AS Numeric(18),0)Qnt2, QntInv,Nosat,Sat_1,ISI,SAT_2, 

	QntRetur,CAST(2 AS Numeric(18),0)Qnt2Retur, QntSisa,CAST(2 AS Numeric(18),Qnt2Sisa)Qnt2Sisa,Kodegdg

	From 	vwOutSPB_RSPBN(@TglAwal,@TglAkhir) a

where 	QntSisa>=0

);

-- vwOutSPB_RSPBN (FUNCTION)
CREATE FUNCTION IF NOT EXISTS vwOutSPB_RSPBN AS RETURN 

(

/*

select X.NoBukti, X.Tanggal,(X.KodeGdg)Kodegdg, X.KodeCustSupp, Cs.NAMACUSTSUPP, X.NoSPP, X.Urut, X.KodeBrg, Br.NAMABRG, 

SUM(X.QNT) Qnt, SUM(X.QntInv) QntInv, SUM(X.QntRetur) QntRetur, SUM(X.QntSisa) QntSisa,SUM(X.Qnt2Sisa)Qnt2Sisa,NOSAT,SAT_1,ISI,SAT_2

from

	(

	select A.NoBukti, A.Tanggal,B.KodeGdg, A.KodeCustSupp, A.NoSPP, B.Urut, B.KodeBrg, case when B.NOSAT=1 Then B.QNT Else B.QNT2  Qnt,B.QNT2, 0 QntInv,0 Qnt2Inv, 0 QntRetur,0 Qnt2Retur, case when B.NOSAT=1 Then B.QNT Else B.QNT2  QntSisa,B.QNT2 Qnt2Sisa,NOSAT,case when B.NOSAT=1 Then B.SAT_1 else B.SAT_2  SAT_1,SAT_2,ISI

	from dbSPB A, dbSPBDet B

	where B.NoBukti=A.NoBukti and COALESCE(A.IsClose,0)=0

	union all

	select A.NoBukti, A.Tanggal,X.KodeGdg, A.KodeCustSupp, A.NoSPP, B.UrutSPB, B.KodeBrg, 0 QNT,0, case when B.NOSAT=1 Then B.QNT+COALESCE(B.QntKoreksi,0) Else B.QNT2+COALESCE(B.QntKoreksi,0)  QntInv,B.QNT2, 0 QntRetur,0, -1*(case when B.NOSAT=1 Then B.QNT+COALESCE(B.QntKoreksi,0) Else B.QNT2+COALESCE(B.QntKoreksi,0) ),-1*(B.QNT2+COALESCE(B.QntKoreksi,0)) Qnt2Sisa,B.NOSAT,case when B.NOSAT=1 Then B.SAT_1 else B.SAT_2  SAT_1,B.SAT_2,B.ISI 

	from dbSPB A, dbInvoicePLDet B,dbSPBDet X,dbInvoicePL Y

	where B.NoSPB=A.NoBukti and A.NoBukti=X.NoBukti and X.Urut=B.UrutSPB and COALESCE(A.IsClose,0)=0 and B.NoBukti=Y.NoBukti and COALESCE(Y.IsBatal,0)=0

	and Y.Tanggal Between  @TglAwal and @TglAkhir

	union all

	select A.NoBukti, A.Tanggal,X.Kodegdg, A.KodeCustSupp, A.NoSPP, B.UrutSPB, B.KodeBrg, 0 QNT,0, 0 QntInv,0, case when B.NOSAT=1 Then B.QNT Else B.QNT2  QntRetur,0, -1*case when B.NOSAT=1 Then B.QNT Else B.QNT2  QntSisa,0 QNT2,B.NOSAT,case when B.NOSAT=1 Then B.SAT_1 else B.SAT_2  SAT_1,B.SAT_2,B.ISI 

	from dbSPB A, DBRSPBDet B,dbSPBDet X,DBRSPB Y

	where B.NoSPB=A.NoBukti and A.NoBukti=X.NoBukti and B.KodeBrg=X.KodeBrg and B.NoBukti=Y.NoBukti and X.Urut=B.UrutSPB and COALESCE(A.IsClose,0)=0

	and Y.Tanggal Between  @TglAwal and @TglAkhir

	) X

left outer join DBCUSTSUPP Cs on Cs.KODECUSTSUPP=X.KodeCustSupp

left outer join DBBARANG Br on Br.KODEBRG=X.KodeBrg 

group by X.NoBukti, X.Tanggal,X.KodeGdg, X.KodeCustSupp, Cs.NAMACUSTSUPP, X.NoSPP, X.Urut, X.KodeBrg, Br.NAMABRG,NOSAT,SAT_1,ISI,SAT_2

*/

Select * from (

select X.NoBukti, X.Tanggal,(X.KodeGdg)Kodegdg, X.KodeCustSupp, Cs.NAMACUSTSUPP, X.NoSPP, X.Urut, X.KodeBrg, Br.NAMABRG, 

SUM(X.QNT) Qnt, SUM(X.QntInv) QntInv, SUM(X.QntRetur) QntRetur, SUM(X.QntSisa) QntSisa,SUM(X.Qnt2Sisa)Qnt2Sisa,X.NOSAT,X.SAT_1,X.ISI,X.SAT_2

from

	(

    select A.NoBukti, A.Tanggal,A.MaxOL,A.IsOtorisasi1,A.IsOtorisasi2,A.IsOtorisasi3,A.IsOtorisasi4,A.IsOtorisasi5,B.KodeGdg, A.KodeCustSupp, A.NoSPP, B.Urut, B.KodeBrg, case when B.NOSAT=1 Then B.QNT Else B.QNT2 +COALESCE(C.QntKoreksi,0) Qnt,B.QNT2, 0 QntInv,0 Qnt2Inv, 0 QntRetur,0 Qnt2Retur, case when B.NOSAT=1 Then B.QNT Else B.QNT2 +COALESCE(C.QntKoreksi,0) QntSisa,B.QNT2 Qnt2Sisa,b.NOSAT,case when B.NOSAT=1 Then B.SAT_1 else B.SAT_2  SAT_1,b.SAT_2,b.ISI

	from dbSPB A 

	left outer join dbSPBDet B on b.NoBukti=a.NoBukti

	left outer join dbInvoicePLDet C on c.NoSPB=b.NoBukti and c.UrutSPB=b.Urut and c.KodeBrg=b.KodeBrg

	where COALESCE(A.IsOS,0)=0

	union all

	select A.NoBukti, A.Tanggal,A.MaxOL,A.IsOtorisasi1,A.IsOtorisasi2,A.IsOtorisasi3,A.IsOtorisasi4,A.IsOtorisasi5,X.KodeGdg, A.KodeCustSupp, A.NoSPP, B.UrutSPB, B.KodeBrg, 0 QNT,0, case when X.NOSAT=1 Then B.QNT+COALESCE(B.QntKoreksi,0) Else B.QNT2+COALESCE(B.QntKoreksi,0)  QntInv,B.QNT2, 0 QntRetur,0, -1*(case when X.NOSAT=1 Then B.QNT+COALESCE(B.QntKoreksi,0) Else B.QNT2+COALESCE(B.QntKoreksi,0) ),-1*(B.QNT2+COALESCE(B.QntKoreksi,0)) Qnt2Sisa,X.NOSAT,case when X.NOSAT=1 Then X.SAT_1 else X.SAT_2  SAT_1,X.SAT_2,X.ISI 

	from dbSPB A, dbInvoicePLDet B,dbSPBDet X,dbInvoicePL Y

	where B.NoSPB=A.NoBukti and A.NoBukti=X.NoBukti and X.Urut=B.UrutSPB and COALESCE(A.IsOS,0)=0 and COALESCE(A.IsOsInv,0)=0 and B.NoBukti=Y.NoBukti and COALESCE(Y.IsBatal,0)=0

	and Y.Tanggal Between  @TglAwal and @TglAkhir

	union all

	select A.NoBukti, A.Tanggal,A.MaxOL,A.IsOtorisasi1,A.IsOtorisasi2,A.IsOtorisasi3,A.IsOtorisasi4,A.IsOtorisasi5,X.Kodegdg, A.KodeCustSupp, A.NoSPP, B.UrutSPB, B.KodeBrg, 0 QNT,0, 0 QntInv,0, case when X.NOSAT=1 Then B.QNT Else B.QNT2  QntRetur,0, -1*case when X.NOSAT=1 Then B.QNT Else B.QNT2  QntSisa,0 QNT2,X.NOSAT,case when X.NOSAT=1 Then X.SAT_1 else X.SAT_2  SAT_1,X.SAT_2,X.ISI 

	from dbSPB A, DBRSPBDet B,dbSPBDet X,DBRSPB Y

	where B.NoSPB=A.NoBukti and A.NoBukti=X.NoBukti and B.KodeBrg=X.KodeBrg and B.NoBukti=Y.NoBukti and X.Urut=B.UrutSPB and COALESCE(A.IsOS,0)=0

	and Y.Tanggal Between  @TglAwal and @TglAkhir

	) X

left outer join DBCUSTSUPP Cs on Cs.KODECUSTSUPP=X.KodeCustSupp

left outer join DBBARANG Br on Br.KODEBRG=X.KodeBrg

Left Outer Join dbSPPDet SPP on SPP.NoBukti=X.NoSPP  and SPP.KodeBrg=X.KodeBrg

where SPP.NoSO not in(Select NoBukti from TempSOTerpasang Group By NoBukti)

group by X.NoBukti, X.Tanggal,X.MaxOL,X.IsOtorisasi1,X.IsOtorisasi2,X.IsOtorisasi3,X.IsOtorisasi4,X.IsOtorisasi5,X.KodeGdg, X.KodeCustSupp, Cs.NAMACUSTSUPP, X.NoSPP, X.Urut, X.KodeBrg, Br.NAMABRG,X.NOSAT,X.SAT_1,X.ISI,X.SAT_2

HAving  SUM(X.QntSisa)>=0

and

(Cast(Case when Case when X.IsOtorisasi1=1 then 1 else 0 +

                     Case when X.IsOtorisasi2=1 then 1 else 0 +

                     Case when X.IsOtorisasi3=1 then 1 else 0 +

                     Case when X.IsOtorisasi4=1 then 1 else 0 +

                     Case when X.IsOtorisasi5=1 then 1 else 0 

                     =X.MaxOL then 0

                else 1

            As INTEGER)=0) 

union All 

select X.NoBukti, X.Tanggal,X.Kodegdg, X.KodeCustSupp, Cs.NAMACUSTSUPP, X.NoSPP, X.Urut, X.KodeBrg, Br.NAMABRG, 

SUM(X.QNT) Qnt, SUM(X.QntInv) QntInv, SUM(X.QntRetur) QntRetur, SUM(X.QntSisa) QntSisa,SUM(X.Qnt2Sisa)Qnt2Sisa,X.NOSAT,X.SAT_1,X.ISI,X.SAT_2

from (

        Select A.NoBukti,A.Tanggal,b.KodeGdg,A.KodeCustSupp,'' NoSPP,0 Urut,b.KodeBrg,

        case when (SUM(COALESCE(f.QNt,0))/SUM(d.Qnt))<=1 then SUM(b.Qnt) else SUM(b.Qnt)*(SUM(COALESCE(f.QNt,0))/SUM(d.Qnt)) Qnt,

        SUM(b.Qnt)*(SUM(COALESCE(f.QNt,0))/SUM(d.Qnt)) QntInv,0 QntRetur,case when (SUM(COALESCE(f.QNt,0))/SUM(d.Qnt))<=1 then SUM(b.Qnt) else SUM(b.Qnt)*(SUM(COALESCE(f.QNt,0))/SUM(d.Qnt))-SUM(b.Qnt)*(SUM(COALESCE(f.QNt,0))/SUM(d.Qnt)) QntSisa,

        0 Qnt2Sisa,b.NOSAT,b.ISI,b.SAT_1,''SAT_2

        from dbSPB a

        Left Outer join (Select x.NoBukti,x.KodeBrg,''Kodegdg, x.NoSPP, Sum((case when x.NOSAT=1 Then x.QNT Else x.QNT2 )-COALESCE((case when y.NOSAT=1 Then y.QNT Else y.QNT2 ),0)) Qnt, Sum(x.QNT2-COALESCE(y.Qnt2,0)) Qnt2,x.NOSAT,x.ISI,x.SAT_1

                      from dbSPBDet x

                           left Outer join (Select x.NoSPB, x.UrutSPB,x.KodeBrg, Sum(x.QNT) Qnt, Sum(x.QNT2) Qnt2,x.NOSAT

                                            From DBRSPBDet x left outer join DBRSPB y on y.NoBukti=x.NoBukti where y.Tanggal<=@TglAkhir

                                            Group by x.NoSPB, x.UrutSPB,x.KodeBrg,x.NOSAT) y on y.NoSPB=x.NoBukti and y.UrutSPB=x.Urut

                      group by x.NoBukti, x.NoSPP, y.NoSPB,x.KodeBrg,x.NOSAT,x.ISI,x.SAT_1) B on B.NoBukti=A.NoBukti

        Left Outer Join (Select x.NoBukti, x.Tanggal,y.NoSO, x.TglKirim

                     from DBSPP x

                           left outer join dbSPPDet y on y.NoBukti=x.NoBukti where Qnt-COALESCE(QntBatal,0)<>0

                      Group by x.NoBukti, x.Tanggal, x.TglKirim,y.NoSO) C On C.NoBukti=B.NoSPP

        left outer join (select a.NOBUKTI,b.TANGGAL,b.PPN,NOSAT,SATUAN,ISI,a.KODEBRG,Sum(case when a.NOSAT=1 Then a.QNT Else a.QNT2 )Qnt from dbSOdet a

                      Left Outer Join DBSO b on a.NOBUKTI=b.NOBUKTI

                      where a.NOBUKTI in(select NoBukti from TempSOTerpasang Group by NoBukti)

                      and COALESCE(NamaBrg,'')<>''  and COALESCE(KodeBrgM,'')=''

                      Group By a.NOBUKTI,b.PPN,NOSAT,SATUAN,ISI,b.TANGGAL,a.KODEBRG) D on D.Nobukti=C.NoSO

     left outer join vwBrowsCustomer E on E.Kodecust=A.KodeCustSupp --and E.Sales=D.KODESLS

     left outer join (Select NoSO,Kodebrg,SUM(case when NOSAT=1 Then QNT Else QNT2 +COALESCE(QntKoreksi,0))QNt from dbInvoicePLDet a Left Outer Join dbInvoicePL b on a.NoBukti=b.NoBukti where b.Tanggal<=@Tglakhir and COALESCE(b.isBatal,0)=0 Group By NoSO,Kodebrg) F on F.NoSO=D.NoBukti

     where ((Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                     Case when A.IsOtorisasi2=1 then 1 else 0 +

                     Case when A.IsOtorisasi3=1 then 1 else 0 +

                     Case when A.IsOtorisasi4=1 then 1 else 0 +

                     Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                else 1

            As INTEGER)=0     )

     )and COALESCE(A.IsOS,0)=0 and  D.NOBUKTI in(select NoBukti from TempSOTerpasang Group by NoBukti)

     Group By A.KodeCustSupp,a.NOBUKTI,a.Tanggal,b.KodeBrg ,b.Kodegdg,b.NOSAT,b.ISI,b.SAT_1,D.Tanggal,E.NamaCust, A.IsOS

     Having SUM(D.Qnt)>SUM(COALESCE(F.Qnt,0)) and SUM(COALESCE(F.Qnt,0))>=0        

  ) X

left outer join DBCUSTSUPP Cs on Cs.KODECUSTSUPP=X.KodeCustSupp

left outer join DBBARANG Br on Br.KODEBRG=X.KodeBrg

group by X.NoBukti, X.Tanggal,X.Kodegdg, X.KodeCustSupp, Cs.NAMACUSTSUPP, X.NoSPP, X.Urut, X.KodeBrg, Br.NAMABRG

,X.NOSAT,X.SAT_1,X.ISI,X.SAT_2

)a --where a.NoBukti in ('BCA/SJ/1018/00004')


);

-- vwPiutSJ_DPPINV (FUNCTION)
CREATE FUNCTION IF NOT EXISTS vwPiutSJ_DPPINV AS RETURN 

(

select X.NoBukti, X.Tanggal,(X.KodeGdg)Kodegdg, X.KodeCustSupp, Cs.NAMACUSTSUPP, X.NoSPP, X.Urut, X.KodeBrg, Br.NAMABRG, 

SUM(X.QNT) Qnt, SUM(X.QntInv) QntInv, SUM(X.QntRetur) QntRetur, SUM(X.QntSisa) QntSisa,SUM(X.Qnt2Sisa)Qnt2Sisa,X.NOSAT,X.SAT_1,X.ISI,X.SAT_2

from

	(

	select A.NoBukti,Y.Tanggal,A.MaxOL,A.IsOtorisasi1,A.IsOtorisasi2,A.IsOtorisasi3,A.IsOtorisasi4,A.IsOtorisasi5,X.KodeGdg, A.KodeCustSupp, A.NoSPP, B.UrutSPB Urut, B.KodeBrg, 0 QNT,0 QNT2, case when X.NOSAT=1 Then B.QNT+COALESCE(B.QntKoreksi,0) Else B.QNT2+COALESCE(B.QntKoreksi,0)  QntInv,B.QNT2 Qnt2Inv, 0 QntRetur,0 Qnt2Retur, -1*(case when X.NOSAT=1 Then B.QNT+COALESCE(B.QntKoreksi,0) Else B.QNT2+COALESCE(B.QntKoreksi,0) )QntSisa,-1*(B.QNT2+COALESCE(B.QntKoreksi,0)) Qnt2Sisa,X.NOSAT,case when X.NOSAT=1 Then X.SAT_1 else X.SAT_2  SAT_1,X.SAT_2,X.ISI 

	from dbSPB A, dbInvoicePLDet B,dbSPBDet X,dbInvoicePL Y

	where B.NoSPB=A.NoBukti and A.NoBukti=X.NoBukti and X.Urut=B.UrutSPB and COALESCE(A.IsClose,0)=0 and B.NoBukti=Y.NoBukti and COALESCE(Y.IsBatal,0)=0 

	and Y.Tanggal Between  @TglAwal and @TglAkhir and X.NoBukti Not Like '%SJB%' and X.NoBukti not like '%SPBB%' and X.NAMABRG not like '%Jasa%' 

	) X

left outer join DBCUSTSUPP Cs on Cs.KODECUSTSUPP=X.KodeCustSupp

left outer join DBBARANG Br on Br.KODEBRG=X.KodeBrg

Left Outer Join dbSPPDet SPP on SPP.NoBukti=X.NoSPP  and SPP.KodeBrg=X.KodeBrg

where SPP.NoSO not in(Select NoBukti from TempSOTerpasang Group By NoBukti)

group by X.NoBukti, X.Tanggal,X.MaxOL,X.IsOtorisasi1,X.IsOtorisasi2,X.IsOtorisasi3,X.IsOtorisasi4,X.IsOtorisasi5,X.KodeGdg, X.KodeCustSupp, Cs.NAMACUSTSUPP, X.NoSPP, X.Urut, X.KodeBrg, Br.NAMABRG,X.NOSAT,X.SAT_1,X.ISI,X.SAT_2

HAving  

(Cast(Case when Case when X.IsOtorisasi1=1 then 1 else 0 +

                     Case when X.IsOtorisasi2=1 then 1 else 0 +

                     Case when X.IsOtorisasi3=1 then 1 else 0 +

                     Case when X.IsOtorisasi4=1 then 1 else 0 +

                     Case when X.IsOtorisasi5=1 then 1 else 0 

                     =X.MaxOL then 0

                else 1

            As INTEGER)=0) 

/*           

union All

select X.NoBukti, X.Tanggal,X.Kodegdg, X.KodeCustSupp, Cs.NAMACUSTSUPP, X.NoSPP, X.Urut, X.KodeBrg, Br.NAMABRG, 

SUM(X.QNT) Qnt, SUM(X.QntInv) QntInv, SUM(X.QntRetur) QntRetur, SUM(X.QntSisa) QntSisa,SUM(X.Qnt2Sisa)Qnt2Sisa,X.NOSAT,X.SAT_1,X.ISI,X.SAT_2

from

	(

    Select A.NoBukti,A.Tanggal,b.KodeGdg,A.KodeCustSupp,'' NoSPP,0 Urut,b.KodeBrg,

        SUM(b.Qnt)Qnt,SUM(b.Qnt)*(SUM(COALESCE(f.QNt,0))/SUM(d.Qnt)) QntInv,0 QntRetur,SUM(b.Qnt)-SUM(b.Qnt)*(SUM(COALESCE(f.QNt,0))/SUM(d.Qnt)) QntSisa,0 Qnt2Sisa,b.NOSAT,b.ISI,b.SAT_1,''SAT_2

        from dbSPB a

        Left Outer join (Select x.NoBukti,x.KodeBrg,''Kodegdg, x.NoSPP, Sum(case when x.NOSAT=1 then x.QNT else x.QNT2  -COALESCE(y.qnt,0)) Qnt, Sum(x.QNT2-COALESCE(y.Qnt2,0)) Qnt2,x.NOSAT,x.ISI,x.SAT_1

                      from dbSPBDet x

                           left Outer join (Select x.NoSPB, x.UrutSPB,x.KodeBrg, Sum(case when x.NOSAT=1 then x.QNT else x.QNT2 ) Qnt, Sum(x.QNT2) Qnt2

                                            From DBRSPBDet x

                                            Group by x.NoSPB, x.UrutSPB,x.KodeBrg) y on y.NoSPB=x.NoBukti and y.UrutSPB=x.Urut

                      group by x.NoBukti, x.NoSPP, y.NoSPB,x.KodeBrg,x.NOSAT,x.ISI,x.SAT_1) B on B.NoBukti=A.NoBukti

        Left Outer Join (Select x.NoBukti, x.Tanggal,y.NoSO, x.TglKirim

                      from DBSPP x

                           left outer join dbSPPDet y on y.NoBukti=x.NoBukti where (case when y.NOSAT=1 then Qnt else QNT2 ) -COALESCE(QntBatal,0)<>0

                      Group by x.NoBukti, x.Tanggal, x.TglKirim,y.NoSO) C On C.NoBukti=B.NoSPP

        left outer join (select a.NOBUKTI,b.TANGGAL,b.PPN,NOSAT,SATUAN,ISI,a.KODEBRG,Sum(case when a.NOSAT=1 then a.QNT else a.QNT2 )Qnt from dbSOdet a

                      Left Outer Join DBSO b on a.NOBUKTI=b.NOBUKTI

                      where a.NOBUKTI in(select NoBukti from TempSOTerpasang Group by NoBukti)

                      and COALESCE(NamaBrg,'')<>''  and COALESCE(KodeBrgM,'')=''

                      Group By a.NOBUKTI,b.PPN,NOSAT,SATUAN,ISI,b.TANGGAL,a.KODEBRG) D on D.Nobukti=C.NoSO

     left outer join vwBrowsCustomer E on E.Kodecust=A.KodeCustSupp --and E.Sales=D.KODESLS

     left outer join (Select NoSO,Kodebrg,SUM(case when a.NOSAT=1 then Qnt else QNT2 +COALESCE(QntKoreksi,0))QNt from dbInvoicePLDet a Left Outer Join dbInvoicePL b on a.NoBukti=b.NoBukti where b.Tanggal<=@Tglakhir and COALESCE(b.isBatal,0)=0 Group By NoSO,Kodebrg) F on F.NoSO=D.NoBukti

     where ((Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                     Case when A.IsOtorisasi2=1 then 1 else 0 +

                     Case when A.IsOtorisasi3=1 then 1 else 0 +

                     Case when A.IsOtorisasi4=1 then 1 else 0 +

                     Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                else 1

            As INTEGER)=0     )

     )and COALESCE(A.IsClose,0)=0 and  D.NOBUKTI in(select NoBukti from TempSOTerpasang Group by NoBukti) --and a.KodeCustSupp='M0000039'

     Group By A.KodeCustSupp,a.NOBUKTI,a.Tanggal,b.KodeBrg ,b.Kodegdg,b.NOSAT,b.ISI,b.SAT_1,D.Tanggal,E.NamaCust, A.IsClose

   Having SUM(COALESCE(F.Qnt,0))>=0

  ) X

left outer join DBCUSTSUPP Cs on Cs.KODECUSTSUPP=X.KodeCustSupp

left outer join DBBARANG Br on Br.KODEBRG=X.KodeBrg

group by X.NoBukti, X.Tanggal,X.Kodegdg, X.KodeCustSupp, Cs.NAMACUSTSUPP, X.NoSPP, X.Urut, X.KodeBrg, Br.NAMABRG

,X.NOSAT,X.SAT_1,X.ISI,X.SAT_2

*/

);

-- vwPiutSJ_DPPSJ (FUNCTION)
CREATE FUNCTION IF NOT EXISTS vwPiutSJ_DPPSJ AS RETURN 

(

select X.NoBukti, X.Tanggal,(X.KodeGdg)Kodegdg, X.KodeCustSupp, Cs.NAMACUSTSUPP, X.NoSPP, X.Urut, X.KodeBrg, Br.NAMABRG, 

SUM(X.QNT) Qnt, SUM(X.QntInv) QntInv, SUM(X.QntRetur) QntRetur, SUM(X.QntSisa) QntSisa,SUM(X.Qnt2Sisa)Qnt2Sisa,X.NOSAT,X.SAT_1,X.ISI,X.SAT_2

from

	(

    select A.NoBukti, A.Tanggal,A.MaxOL,A.IsOtorisasi1,A.IsOtorisasi2,A.IsOtorisasi3,A.IsOtorisasi4,A.IsOtorisasi5,B.KodeGdg, A.KodeCustSupp, A.NoSPP, B.Urut, B.KodeBrg, case when B.NOSAT=1 Then B.QNT Else B.QNT2 +COALESCE(C.QntKoreksi,0) Qnt,B.QNT2, 0 QntInv,0 Qnt2Inv, 0 QntRetur,0 Qnt2Retur, case when B.NOSAT=1 Then B.QNT Else B.QNT2 +COALESCE(C.QntKoreksi,0) QntSisa,B.QNT2 Qnt2Sisa,b.NOSAT,case when B.NOSAT=1 Then B.SAT_1 else B.SAT_2  SAT_1,b.SAT_2,b.ISI

	from dbSPB A 

	left outer join dbSPBDet B on b.NoBukti=a.NoBukti

	left outer join dbInvoicePLDet C on c.NoSPB=b.NoBukti and c.UrutSPB=b.Urut and c.KodeBrg=b.KodeBrg

	where COALESCE(A.IsClose,0)=0 and B.NoBukti Not Like '%SJB%' and B.NoBukti not like '%SPBB%' and B.NAMABRG not like '%Jasa%' 

	union all

	select A.NoBukti, Y.Tanggal,A.MaxOL,A.IsOtorisasi1,A.IsOtorisasi2,A.IsOtorisasi3,A.IsOtorisasi4,A.IsOtorisasi5,X.Kodegdg, A.KodeCustSupp, A.NoSPP, B.UrutSPB, B.KodeBrg, -1*case when X.NOSAT=1 Then B.QNT Else B.QNT2  QNT,0, 0 QntInv,0, case when X.NOSAT=1 Then B.QNT Else B.QNT2  QntRetur,0, -1*case when X.NOSAT=1 Then B.QNT Else B.QNT2  QntSisa,0 QNT2,X.NOSAT,case when X.NOSAT=1 Then X.SAT_1 else X.SAT_2  SAT_1,X.SAT_2,X.ISI 

	from dbSPB A, DBRSPBDet B,dbSPBDet X,DBRSPB Y

	where B.NoSPB=A.NoBukti and A.NoBukti=X.NoBukti and B.KodeBrg=X.KodeBrg and B.NoBukti=Y.NoBukti and X.Urut=B.UrutSPB and COALESCE(A.IsClose,0)=0

	and Y.Tanggal Between  @TglAwal and @TglAkhir and B.NoBukti Not Like '%SJB%' and B.NoBukti not like '%SPBB%' and B.NAMABRG not like '%Jasa%' 

	) X

left outer join DBCUSTSUPP Cs on Cs.KODECUSTSUPP=X.KodeCustSupp

left outer join DBBARANG Br on Br.KODEBRG=X.KodeBrg

Left Outer Join dbSPPDet SPP on SPP.NoBukti=X.NoSPP  and SPP.KodeBrg=X.KodeBrg

where SPP.NoSO not in(Select NoBukti from TempSOTerpasang Group By NoBukti)

group by X.NoBukti, X.Tanggal,X.MaxOL,X.IsOtorisasi1,X.IsOtorisasi2,X.IsOtorisasi3,X.IsOtorisasi4,X.IsOtorisasi5,X.KodeGdg, X.KodeCustSupp, Cs.NAMACUSTSUPP, X.NoSPP, X.Urut, X.KodeBrg, Br.NAMABRG,X.NOSAT,X.SAT_1,X.ISI,X.SAT_2

HAving  

(Cast(Case when Case when X.IsOtorisasi1=1 then 1 else 0 +

                     Case when X.IsOtorisasi2=1 then 1 else 0 +

                     Case when X.IsOtorisasi3=1 then 1 else 0 +

                     Case when X.IsOtorisasi4=1 then 1 else 0 +

                     Case when X.IsOtorisasi5=1 then 1 else 0 

                     =X.MaxOL then 0

                else 1

            As INTEGER)=0) 



);

-- VwreportOutSPBN (FUNCTION)
CREATE FUNCTION IF NOT EXISTS VwreportOutSPBN AS RETURN

(

Select  A.NoBukti+SUBSTR('00000'+cast(A.Urut as varchar(5)), LENGTH('00000'+cast(A.Urut as varchar(5)))-5+1) KeyNoBukti, A.Nobukti, F.Tanggal, F.KodeCustSupp, S.Namacust NamaCustSupp,

        A.urut, A.kodebrg, B.NamaBrg, '' Jns_Kertas, '' Ukr_Kertas, A.Sat_1, A.Isi,A.Qnt qnt,a.qntinv qntinv,a.QntRetur, A.QntSisa qntsisa,

        A.SAT_1 Satuan, e.Tglkirim,e.NOBUKTI noso,e.tanggal tglso,e.NOSPB nopo,g.HARGA,COALESCE(g1.HPPBrg,0) HPP,

        case when (COALESCE(K.DISC,0)>0 and COALESCE(G.DISC,0)=0 and a.QntSisa=0) then 

          ((a.Qnt *case when F.Tanggal>='2018-11-01' then case when COALESCE(G.PPN,0)=2 then G.HARGA/1.1 else G.HARGA  else G.HARGA )-((a.Qnt *case when F.Tanggal>='2018-11-01' then 

          case when COALESCE(G.PPN,0)=2 then G.HARGA/1.1 else G.HARGA  else G.HARGA )*g.DISC/100) -

         COALESCE((A.Qnt *case when F.Tanggal>='2018-11-01' then case when COALESCE(K.PPN,0)=2 then K.HARGA/1.1 else K.HARGA  else K.HARGA )-((A.Qnt *case when F.Tanggal>='2018-11-01' then 

          case when COALESCE(K.PPN,0)=2 then K.HARGA/1.1 else K.HARGA  else K.HARGA )*K.DISC/100),0)) 

        else 

          (case when a.NoBukti='BCA/SJ/0618/00074' and d.Urut= 1 then 6440000

             when a.NoBukti='BCA/SJ/0618/00074' and d.Urut= 2 then 8450000

             when a.NoBukti='BCB/SJ/1018/00035' and d.Urut= 2 then 6936600 

             when a.NoBukti='BCB/SJ/1018/00055' and d.Urut= 2 then 6640500 

              else

         (A.QntSisa *case when F.Tanggal>='2018-11-01' then case when COALESCE(G.PPN,0)=2 then G.HARGA/1.1 else G.HARGA  else G.HARGA )-((A.QntSisa *case when F.Tanggal>='2018-11-01' then 

          case when COALESCE(G.PPN,0)=2 then G.HARGA/1.1 else G.HARGA  else G.HARGA )*g.DISC/100) )            

         dppnet, A.QntSisa *COALESCE(g1.HPPBrg,0) hppnet,A.Nosat,A.SAT_2,

        c.NoSPP,c.UrutSPP

From    vwBrowsOutSPB_RSPBN(@TglAwal,@TglAkhir) A

left outer join dbSPB F on f.NoBukti=a.NoBukti

left outer join dbSPBDet c on c.NoBukti=a.NoBukti and c.KodeBrg=a.KodeBrg

left outer join dbSPPDet D on D.NoBukti=c.NoSPP and d.Urut=c.UrutSPP 

left Outer join DBSO E on E.NOBUKTI=d.NoSO

left outer join DBSODET G on G.NOBUKTI=e.NOBUKTI and g.KODEBRG=c.KodeBrg

Left outer join dbHPPProduksi G1 On G1.KodeBrg=A.KodeBrg and MONTH(F.Tanggal)=G1.Bulan and YEAR(F.Tanggal)=G1.Tahun

Left Outer Join vwBrowsCustomer S on S.KodeCust=F.KodeCustSupp --and s.Sales=E.KODESLS

Left Outer Join dbBarang B on B.KodeBrg=A.KodeBrg

Left Outer Join VWSatkecil B1 on B1.Kodebrg=A.KodeBrg

left outer join dbInvoicePLDet K on K.NoSPB=a.NoBukti and K.KodeBrg=a.KodeBrg

where COALESCE(F.IsClose,0)=0 and (a.QntSisa>0 or (COALESCE(K.DISC,0)>0 and COALESCE(G.DISC,0)=0 and a.QntSisa=0))  

);

-- xBrgCA (FUNCTION)
CREATE FUNCTION IF NOT EXISTS xBrgCA AS -- DECLARE REMOVED 

  Select @xKodebrg =COALESCE(KODEBRG,'')  from DBBARANG

                    where NamaBrg2=@KodeBrg and 

                    COALESCE(NamaBrg2,'')<>'' and KODEBRG like '%@CA%' 

   Return @xKodebrg;

/* ============================================= */
