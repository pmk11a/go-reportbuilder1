;

-- SP_ReportOutStandingSPk
CREATE PROCEDURE IF NOT EXISTS SP_ReportOutStandingSPk AS select d.Sat1,a.Kodebrg,d.NAMABRG,COALESCE(c.Qnt,0)Stok,COALESCE(c.Qnt2,0)Stok2,COALESCE(SUM(a.QNT*isi),0)QntBPPB,COALESCE(b.Qnt,0)QntBP,COALESCE(b.Qnt2,0)Qnt2BP,COALESCE(SUM(a.QNT*isi),0)-COALESCE(b.Qnt,0)Sisa,COALESCE(e.Sisa,0)OSPPL,COALESCE(f.sisa,0)OSPO,

(COALESCE(SUM(a.QNT*isi),0)-COALESCE(b.Qnt,0))-COALESCE(e.Sisa,0)-COALESCE(f.sisa,0)- COALESCE(c.Qnt,0)Xsisa from DBSPKDET a 

left Outer Join (select Kodebrg,SUM(Qnt)Qnt,SUM(Qnt2)Qnt2 from DBPenyerahanBhnDET group by kodebrg)b On b.kodebrg=a.KodeBrg 

left Outer Join (select Kodebrg,SUM(SALDOQNT)Qnt,SUM(SALDO2QNT)Qnt2 from DBSTOCKBRG where Bulan=@Bulan and Tahun=@Tahun group by kodebrg)c On c.kodebrg=a.KodeBrg

Left Outer join (select a.kodebrg,SUM(a.Qnt*isi)QntPPL,COALESCE(b.Qnt,0) QntPO,SUM(a.Qnt*isi)-COALESCE(b.Qnt,0)sisa from DBPPLDET a

                 Left Outer Join (select Kodebrg,SUM(Qnt*isi)Qnt from DBPODET group by Kodebrg)b On  a.kodebrg=b.KODEBRG

                 group by a.kodebrg,b.Qnt

                 having SUM(a.Qnt*isi)-COALESCE(b.Qnt,0)<>0)e on e.KODEBRG=a.KODEBRG

Left Outer Join (select a.kodebrg,sum(a.Qnt*a.isi)QntPO,COALESCE((b.Qnt),0)QntBeli,Sum(a.Qnt*isi)-(COALESCE((b.Qnt),0))as sisa from DBPODET a

                 left Outer Join (select Kodebrg,COALESCE(Sum(Qnt),0)Qnt from DBBELIDET Group by KODEBRG)b On a.KODEBRG=b.KODEBRG

                 group by a.KodeBrg,b.Qnt

                 having SUM(a.Qnt*a.ISI)-(COALESCE((b.Qnt),0))<>0)f On f.KODEBRG=a.KODEBRG                 

Left Outer Join DBBARANG d On a.KODEBRG=d.kodebrg 

group by a.KodeBrg,b.Qnt,b.Qnt2,c.Qnt,c.Qnt2,d.NAMABRG,e.Sisa,f.sisa,d.Sat1

having (COALESCE(SUM(a.QNT*isi),0)-COALESCE(b.Qnt,0))-COALESCE(e.Sisa,0)-COALESCE(f.sisa,0)-COALESCE(c.Qnt,0) >0;

-- Sp_reportOutStandingSPKRek
CREATE PROCEDURE IF NOT EXISTS Sp_reportOutStandingSPKRek AS ---- DECLARE REMOVED,@Bulan Int,@Tahun Int

--Select @Choice='B',@Bulan=1,@Tahun=2012



If @Choice='N'

select a.NOBUKTI BPPB,Sum(COALESCE(c.Qnt,0))Stok,COALESCE(SUM(a.QNT*isi),0)QntBPPB,Sum(COALESCE(b.Qnt,0))QntBP,

	COALESCE(b.Qnt,0)QntBP,COALESCE(SUM(a.QNT*isi),0)-COALESCE(b.Qnt,0)Sisa,COALESCE(c.Qnt,0)-(COALESCE(SUM(a.QNT*isi),0)-COALESCE(b.Qnt,0))Xsisa 

	from DBSPKDET a 

	left Outer Join (select Kodebrg,SUM(Qnt*isi)Qnt from DBPenyerahanBhnDET group by kodebrg)b On b.kodebrg=a.KodeBrg 

	left Outer Join (select Kodebrg,SUM(SALDOQNT)Qnt from DBSTOCKBRG where Bulan=@Bulan and Tahun=@Tahun group by kodebrg )c On c.kodebrg=a.KodeBrg

	Left Outer Join DBBARANG d On a.KODEBRG=d.kodebrg   

	group by a.NOBUKTI,B.Qnt,C.Qnt--,a.KodeBrg,b.Qnt,c.Qnt,d.NAMABRG

	having COALESCE(SUM(a.QNT*isi),0)-COALESCE(b.Qnt,0)<>0

        order by nobukti


If @Choice='B'

select a.Kodebrg ,D.namaBrg,Sum(COALESCE(c.Qnt,0))Stok,COALESCE(SUM(a.QNT*isi),0)QntBPPB,Sum(COALESCE(b.Qnt,0))QntBP,

	COALESCE(b.Qnt,0)QntBP,COALESCE(SUM(a.QNT*isi),0)-COALESCE(b.Qnt,0)Sisa,COALESCE(c.Qnt,0)-(COALESCE(SUM(a.QNT*isi),0)-COALESCE(b.Qnt,0))Xsisa 

	from DBSPKDET a 

	left Outer Join (select Kodebrg,SUM(Qnt*isi)Qnt from DBPenyerahanBhnDET group by kodebrg)b On b.kodebrg=a.KodeBrg 

	left Outer Join (select Kodebrg,SUM(SALDOQNT)Qnt from DBSTOCKBRG where Bulan=@Bulan and Tahun=@Tahun group by kodebrg )c On c.kodebrg=a.KodeBrg

	Left Outer Join DBBARANG d On a.KODEBRG=d.kodebrg   

	group by a.Kodebrg,D.namaBrg,B.Qnt,C.Qnt--,a.KodeBrg,b.Qnt,c.Qnt,d.NAMABRG

	having COALESCE(SUM(a.QNT*isi),0)-COALESCE(b.Qnt,0)<>0

        order by A.Kodebrg,D.NamaBrg;

-- Sp_ReportPelunasanHutang
CREATE PROCEDURE IF NOT EXISTS Sp_ReportPelunasanHutang AS -- SET REMOVEDCase when @devisi in ('-','') then '%' else @devisi 

if @tipe=0 

Select S.KODECUSTSUPP as kode,S.NAMACUSTSUPP as nama,S.kota,H.Tanggal,h.nofaktur,h.debet, h.debetd, h.catatan,h.nobukti,'' bank, '' nogiro, cast(null as datetime) tglgiro

 from DBCUSTSUPP S

 left outer join vwHutpiut H

        on (S.KODECUSTSUPP=H.KODECUSTSUPP and (H.Tanggal>=@tanggal1 and h.tanggal<=@tanggal2) )

 where s.KODECUSTSUPP>=@awal and s.KODECUSTSUPP<=@akhir and h.debet <> 0 and s.perkiraan=@perkiraan

 and (H.Devisi like @devisi) 	

--	and ((H.Valas=@KodeVls and @KodeVls<>'IDR') or (H.Valas like '%' and @KodeVls='IDR'))

 order by s.KODECUSTSUPP,h.tanggal,h.nofaktur



else

Select S.KODECUSTSUPP as kode,S.NAMACUSTSUPP as nama,S.kota,H.Tanggal,h.nofaktur,h.debet, h.debetd, h.catatan,h.nobukti, '' bank, '' nogiro, cast(null as datetime) tglgiro

 from DBCUSTSUPP S

 left outer join vwHutpiut H

        on (S.KODECUSTSUPP=H.KODECUSTSUPP and (H.Tanggal>=@tanggal1 and h.tanggal<=@tanggal2) )

 where s.KODECUSTSUPP>=@awal and s.KODECUSTSUPP<=@akhir and h.debet <> 0 and s.perkiraan=@perkiraan

 and (H.Devisi like @devisi) 	

--	and ((H.Valas=@KodeVls and @KodeVls<>'IDR') or (H.Valas like '%' and @KodeVls='IDR'))

 order by s.KODECUSTSUPP,SUBSTR(h.nofaktur, LENGTH(h.nofaktur)-4+1),SUBSTR(h.nofaktur, LENGTH(h.nofaktur)-7+1),nofaktur,h.tanggal;

-- sp_ReportPelunasanPiutang
CREATE PROCEDURE IF NOT EXISTS sp_ReportPelunasanPiutang AS -- SET REMOVEDCase when @devisi in ('-','') then '%' else @devisi 

if @tipe=0 

Select S.KODECUSTSUPP as kode,S.NAMACUSTSUPP as nama,S.kota,H.Tanggal, T.TglNota, h.nofaktur,h.Kredit debet, h.KreditD debetd, h.catatan,h.nobukti,Tr.Keterangan bank,'' nogiro, cast(null as datetime) tglgiro

	from DBCUSTSUPP S

	left outer join vwHutpiut H

	 Left Outer Join (select NoBukti,Urut,a.Perkiraan,b.Keterangan from dbTransaksi a Left Outer Join DBPERKIRAAN b On Case When Substring(a.NoBukti,5,3)='BBM' Then a.Perkiraan when Substring(a.NoBukti,5,3)='BBK' Then a.Lawan  =b.Perkiraan ) Tr on Tr.NoBukti=H.NoBukti and H.NoMsk=Tr.Urut

        on (S.KODECUSTSUPP=H.KODECUSTSUPP and (H.Tanggal>=@tanggal1 and h.tanggal<=@tanggal2))

    left outer join

		(select KodeCustSupp, NoFaktur, MIN(Tanggal) TglNota

		from vwHutPiut 

		

		group by KodeCustSupp, NoFaktur

		) T on T.KodeCustSupp=H.KodeCustSupp and T.NoFaktur=H.NoFaktur   

	where s.KODECUSTSUPP>=@awal and s.KODECUSTSUPP<=@akhir and (h.Kredit<>0 or H.KreditD<>0) and H.perkiraan=@perkiraan

    and (H.Devisi like @devisi) 	

	--and ((H.Valas=@KodeVls and @KodeVls<>'IDR') or (H.Valas like '%' and @KodeVls='IDR'))

 order by s.KODECUSTSUPP,h.tanggal,h.nofaktur



else

Select S.KODECUSTSUPP as kode,S.NAMACUSTSUPP as nama,S.kota,H.Tanggal, T.TglNota, h.nofaktur,h.Kredit debet, h.KreditD debetd, h.catatan,h.nobukti, Tr.Keterangan bank, '' nogiro, cast(null as datetime) tglgiro

 from DBCUSTSUPP S

 left outer join vwHutpiut H

 Left Outer Join (select NoBukti,Urut,a.Perkiraan,b.Keterangan from dbTransaksi a Left Outer Join DBPERKIRAAN b On Case When Substring(a.NoBukti,5,3)='BBM' Then a.Perkiraan when Substring(a.NoBukti,5,3)='BBK' Then a.Lawan  =b.Perkiraan ) Tr on Tr.NoBukti=H.NoBukti and H.NoMsk=Tr.Urut

        on (S.KODECUSTSUPP=H.KODECUSTSUPP and (H.Tanggal>=@tanggal1 and H.tanggal<=@tanggal2) )

 left outer join

		(select KodeCustSupp, NoFaktur, MIN(Tanggal) TglNota

		from vwHutPiut 

		

		group by KodeCustSupp, NoFaktur

		) T on T.KodeCustSupp=H.KodeCustSupp and T.NoFaktur=H.NoFaktur

 where s.KODECUSTSUPP>=@awal and s.KODECUSTSUPP<=@akhir and (h.Kredit<>0 or H.KreditD<>0) and H.perkiraan=@perkiraan

 and (H.Devisi like @devisi) 	

	--and ((H.Valas=@KodeVls and @KodeVls<>'IDR') or (H.Valas like '%' and @KodeVls='IDR'))

 order by s.KODECUSTSUPP,SUBSTR(h.nofaktur, LENGTH(h.nofaktur)-4+1),SUBSTR(h.nofaktur, LENGTH(h.nofaktur)-7+1),nofaktur,h.tanggal;

-- SP_ReportPemakaianBP
CREATE PROCEDURE IF NOT EXISTS SP_ReportPemakaianBP AS select Tanggal,a.Nobukti,TGLJAM,KetBrg,

Case when a.kodebrg='1-2' Then Qnt else 0  ['1-2'],

Case when a.kodebrg='5-10' Then Qnt else 0  ['5-10'],

Case when a.kodebrg='AB' Then Qnt else 0  ['AB'],

Case when a.kodebrg='1-1' Then Qnt else 0  ['1-1'],

Case when a.kodebrg='PS' Then Qnt else 0  ['PS'],

Case when a.kodebrg='AIR' Then Qnt else 0  ['AIR'],

Case when a.kodebrg='SM' Then Qnt else 0  ['SM']

from DBPenyerahanBhnDET a

Left Outer Join DBPenyerahanBhn b on a.Nobukti=b.Nobukti

Left Outer Join DBBARANG c on c.KODEBRG=a.kodebrg

where a.kodebrg in('1-2','5-10','AB','1-1','PS','AIR','C1','C2','ADD','ADD2','SM')

and Tanggal >=@Tglawal and Tanggal<=@TglAkhir

and b.TGLJAM is not null;

-- Sp_reportPenerimaanAccDet
CREATE PROCEDURE IF NOT EXISTS Sp_reportPenerimaanAccDet AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 



if @SReport='T'

If @Ordr='N'

		select * from VwReportPenerimaanACC where Tanggal between @tgl1 and @tgl2 order by NoBukti,Tanggal

		 

	else If @Ordr='B'

		select * from VwReportPenerimaanACC where Tanggal between @tgl1 and @tgl2 order by KodeBrg

		 

	else If @Ordr='S'

		select * from VwReportPenerimaanACC where Tanggal between @tgl1 and @tgl2 order by KodeCustSupp;

-- Sp_ReportPenerimaanACCRek
CREATE PROCEDURE IF NOT EXISTS Sp_ReportPenerimaanACCRek AS ---- DECLARE REMOVED,@Tgl1 Datetime,@tgl2 datetime

--select @Tgl1='01/01/2012',@tgl2='07/17/2013',@Choice='B'



If @Choice='N'

Select 	I.NoBukti,I.TANGGAL,I.KODESUPP KodeCustSupp,J.NAMACUSTSUPP,I.KODEVLS,i.KURS,

        I.nilaipot*i.kurs disctot,I.nilaiDPP*i.kurs NDPP,I.nilaiPPN*I.kurs NPPN,I.NilaiNet*I.kurs TotalIDR,

    case when i.kurs=1 then 0 else i.nilaipot  as disctotusd,

    case when i.kurs=1 then 0 else i.nilaidpp  as Ndppusd,

    case when i.kurs=1 then 0 else i.nilaippn  as NPPNusd,

    case when i.kurs=1 then 0 else i.nilainet  as totalusd

    From  dbBeli I 

	Left Outer Join DBCUSTSUPP J on I.KODESUPP = J.KODECUSTSUPP 

	Where I.TANGGAL between @tgl1 and @tgl2

	order by  I.NOBUKTI,I.TANGGAL



else if @Choice='S'

Select 	I.NoBukti,I.TANGGAL,I.KODESUPP KodeCustSupp,J.NAMACUSTSUPP,i.KODEVLS,i.KURS,

        I.nilaipot*i.kurs disctot,I.nilaiDPP*i.kurs NDPP,I.nilaiPPN*I.kurs NPPN,I.NilaiNet*I.kurs TotalIDR,

        case when i.kurs=1 then 0 else i.nilaipot  as disctotusd,

        case when i.kurs=1 then 0 else i.nilaidpp  as Ndppusd,

        case when i.kurs=1 then 0 else i.nilaippn  as NPPNusd,

        case when i.kurs=1 then 0 else i.nilainet  as totalusd

    From  DBBELI I 

	Left Outer Join DBCUSTSUPP J on I.KODESUPP = J.KODECUSTSUPP 

	where I.TANGGAL between @tgl1 and @tgl2

	order by  J.NAMACUSTSUPP,i.kodesupp,I.NOBUKTI



else if @Choice='B'

Select 	B.KodeBrg, H.NamaBrg,sum(B.QntTerima*B.isi) qnt,

        sum((B.NDISKON+B.DISCTOT)*i.kurs) Disctotal,

        sum((B.NDPP+B.NPPN)*i.kurs) TotalIDR, 

        sum(B.NDPP*i.kurs) NDPP,

        sum(B.NPPN*i.kurs) NPPN, 

        case when i.kurs=1 then 0 else sum(b.disctot)  as disctotusd,

        case when i.kurs=1 then 0 else sum(b.ndpp)  as Ndppusd,

        case when i.kurs=1 then 0 else sum(b.nppn)  as NPPNusd,

        case when i.kurs=1 then 0 else sum(b.subtotal)  as totalusd,

        I.kurs,I.KODEVLS

        From  DBBELIDET B 

        Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg

		Left Outer join DBBELI I on B.NOBUKTI = I.NOBUKTI

		Left Outer Join DBCUSTSUPP J on I.KODESUPP = J.KODECUSTSUPP 

		where I.TANGGAL between @tgl1 and @tgl2

		Group by  B.KodeBrg, H.NamaBrg,i.kurs,i.KODEVLS

		order by B.KodeBrg, H.NamaBrg;

-- Sp_reportpenyerahanbahanRek
CREATE PROCEDURE IF NOT EXISTS Sp_reportpenyerahanbahanRek AS ---- DECLARE REMOVED (1),@tgl1 datetime,@tgl2 DateTime

--Select @Choice='B',@tgl1='10/10/2010',@tgl2='10/10/2013'  

if @Choice='N'

Select 	A.NoBukti,A.TANGGAL,A.KodeGdg,A.KodeGdgT,Sum(COALESCE(B.Qnt,0)) Qnt,

	Sum(COALESCE(B.Qnt2M,0)) Qnt2M ,Sum(COALESCE(B.Qnt2P,0)) Qnt2P

	From dbBPPB A

	Left Outer join dbBPPBDet B on B.NoBukti=a.NoBukti

	Left Outer join dbBarang H on H.KodeBrg=b.KodeBrg

	where A.TANGGAL between @tgl1 and @tgl2

	Group by A.NoBukti,A.TANGGAL,A.KodeGdg,A.KodeGdgT

 

else if  @Choice='B'

Select B.KodeBrg, H.NamaBrg,A.TANGGAL,A.KodeGdg,A.KodeGdgT,Sum(COALESCE(B.Qnt,0)) Qnt,

	Sum(COALESCE(B.Qnt2M,0)) Qnt2M ,Sum(COALESCE(B.Qnt2P,0)) Qnt2P

	From dbBPPB A

	Left Outer join dbBPPBDet B on B.NoBukti=a.NoBukti

	Left Outer join dbBarang H on H.KodeBrg=b.KodeBrg

	where A.TANGGAL between @tgl1 and @tgl2

	Group by B.KodeBrg, H.NamaBrg,A.TANGGAL,A.KodeGdg,A.KodeGdgT;

-- Sp_reportPermintaanBahan
CREATE PROCEDURE IF NOT EXISTS Sp_reportPermintaanBahan AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 



if @SReport='T'

If @Ordr='N'

		If @NeedOto=0 Or @NeedOto=1

		  select * from VwreportPermintaanBahan where Tanggal between @tgl1 and @tgl2 and NeedOtorisasi=@NeedOto

		  order by NoBukti,TANGGAL

		 else If @NeedOto=2

		  select * from VwreportPermintaanBahan where Tanggal between @tgl1 and @tgl2

		  order by NoBukti,TANGGAL

		 

	else If @Ordr='B'

		If @NeedOto=0 Or @NeedOto=1

		  select * from VwreportPermintaanBahan where Tanggal between @tgl1 and @tgl2 and NeedOtorisasi=@NeedOto

		  order by KodeBrg

		 If @NeedOto=2

		  select * from VwreportPermintaanBahan where Tanggal between @tgl1 and @tgl2 

		  order by KodeBrg

		 

	else If @Ordr='D'

		If @NeedOto=0 Or @NeedOto=1

		  select * from VwreportPermintaanBahan where Tanggal between @tgl1 and @tgl2 and NeedOtorisasi=@NeedOto

		  order by kddep,NMDEP

		If @NeedOto=2

		  select * from VwreportPermintaanBahan where Tanggal between @tgl1 and @tgl2

		  order by kddep,NMDEP;

-- Sp_reportPerMintaanBahanRek
CREATE PROCEDURE IF NOT EXISTS Sp_reportPerMintaanBahanRek AS ---- DECLARE REMOVED (1),@tgl1 datetime,@tgl2 DateTime

--Select @Choice='B',@tgl1='10/10/2010',@tgl2='10/10/2013'  

if @Choice='N'

If @NeedOto=0 or @NeedOto=1

	Select 	A.NoBukti,A.TANGGAL,A.KodeGdg,A.KodeGdgT,Sum(COALESCE(B.Qnt,0)) Qnt,

	Sum(COALESCE(B.Qnt2M,0)) Qnt2M ,Sum(COALESCE(B.Qnt2P,0)) Qnt2P

    From dbBPPB A

	Left Outer join dbBPPBDet B on B.NoBukti=a.NoBukti

	Left Outer join dbBarang H on H.KodeBrg=b.KodeBrg

	where A.TANGGAL between @tgl1 and @tgl2 and

	Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                      Case when A.IsOtorisasi2=1 then 1 else 0 +

                      Case when A.IsOtorisasi3=1 then 1 else 0 +

                      Case when A.IsOtorisasi4=1 then 1 else 0 +

                      Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                 else 1

             As INTEGER)=@NeedOto 

	Group by A.NoBukti,A.TANGGAL,A.KodeGdg,A.KodeGdgT

else If @NeedOto=2

	Select 	A.NoBukti,A.TANGGAL,A.KodeGdg,A.KodeGdgT,Sum(COALESCE(B.Qnt,0)) Qnt,

	Sum(COALESCE(B.Qnt2M,0)) Qnt2M ,Sum(COALESCE(B.Qnt2P,0)) Qnt2P

    From dbBPPB A

	Left Outer join dbBPPBDet B on B.NoBukti=a.NoBukti

	Left Outer join dbBarang H on H.KodeBrg=b.KodeBrg

	where A.TANGGAL between @tgl1 and @tgl2

	Group by A.NoBukti,A.TANGGAL,A.KodeGdg,A.KodeGdgT

 

else if  @Choice='B'

If @NeedOto=0 Or @NeedOto=1

	Select B.KodeBrg, H.NamaBrg,A.TANGGAL,A.KodeGdg,A.KodeGdgT,Sum(COALESCE(B.Qnt,0)) Qnt,

	Sum(COALESCE(B.Qnt2M,0)) Qnt2M ,Sum(COALESCE(B.Qnt2P,0)) Qnt2P

	From dbBPPB A

	Left Outer join dbBPPBDet B on B.NoBukti=a.NoBukti

	Left Outer join dbBarang H on H.KodeBrg=b.KodeBrg

	where A.TANGGAL between @tgl1 and @tgl2

	and Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                      Case when A.IsOtorisasi2=1 then 1 else 0 +

                      Case when A.IsOtorisasi3=1 then 1 else 0 +

                      Case when A.IsOtorisasi4=1 then 1 else 0 +

                      Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                 else 1

             As INTEGER)=@NeedOto 

	Group by B.KodeBrg, H.NamaBrg,A.TANGGAL,A.KodeGdg,A.KodeGdgT

Else If @NeedOto=2

	Select B.KodeBrg, H.NamaBrg,A.TANGGAL,A.KodeGdg,A.KodeGdgT,Sum(COALESCE(B.Qnt,0)) Qnt,

	Sum(COALESCE(B.Qnt2M,0)) Qnt2M ,Sum(COALESCE(B.Qnt2P,0)) Qnt2P

	From dbBPPB A

	Left Outer join dbBPPBDet B on B.NoBukti=a.NoBukti

	Left Outer join dbBarang H on H.KodeBrg=b.KodeBrg

	where A.TANGGAL between @tgl1 and @tgl2

	Group by B.KodeBrg, H.NamaBrg,A.TANGGAL,A.KodeGdg,A.KodeGdgT



else if  @Choice='D'

If @NeedOto=0 Or @NeedOto=1

	Select A.KDDEP, I.NMDEP,A.TANGGAL,A.KodeGdg,A.KodeGdgT,Sum(COALESCE(B.Qnt,0)) Qnt,

	Sum(COALESCE(B.Qnt2M,0)) Qnt2M ,Sum(COALESCE(B.Qnt2P,0)) Qnt2P

	From dbBPPB A

	Left Outer join dbBPPBDet B on B.NoBukti=a.NoBukti

	Left Outer join dbBarang H on H.KodeBrg=b.KodeBrg

	Left Outer Join DBDEPART I on A.KDDEP = I.KDDEP

	where A.TANGGAL between @tgl1 and @tgl2 and

	 Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                      Case when A.IsOtorisasi2=1 then 1 else 0 +

                      Case when A.IsOtorisasi3=1 then 1 else 0 +

                      Case when A.IsOtorisasi4=1 then 1 else 0 +

                      Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                 else 1

             As INTEGER)=@NeedOto 

	Group by  A.KDDEP, I.NMDEP,A.TANGGAL,A.KodeGdg,A.KodeGdgT

Else If @NeedOto=2

	Select A.KDDEP, I.NMDEP,A.TANGGAL,A.KodeGdg,A.KodeGdgT,Sum(COALESCE(B.Qnt,0)) Qnt,

	Sum(COALESCE(B.Qnt2M,0)) Qnt2M ,Sum(COALESCE(B.Qnt2P,0)) Qnt2P

	From dbBPPB A

	Left Outer join dbBPPBDet B on B.NoBukti=a.NoBukti

	Left Outer join dbBarang H on H.KodeBrg=b.KodeBrg

	Left Outer Join DBDEPART I on A.KDDEP = I.KDDEP

	where A.TANGGAL between @tgl1 and @tgl2 

	Group by  A.KDDEP, I.NMDEP,A.TANGGAL,A.KodeGdg,A.KodeGdgT;

-- Sp_ReportPiutangDetail
CREATE PROCEDURE IF NOT EXISTS Sp_ReportPiutangDetail AS if @isiList=''  

   Exec('select * from vwPiutangDetail where (TglInv Between '+@Tgl1+''+' and '+''+@Tgl2+') 

   order by Kode')

   else

   Exec('select * from vwPiutangDetail where Kode IN'+@isiList+ ' and (TglInv Between '+@Tgl1+''+' and '+''+@Tgl2+') 

   order by Kode');

-- sp_ReportPiutangSrtJln
CREATE PROCEDURE IF NOT EXISTS sp_ReportPiutangSrtJln AS --Declare 

Select @Id=LEFT(@Id,1)



-- DECLARE REMOVED, @SmpTgl DateTime, @SmpBln int,@SmpThn int, @SblTgl DateTime

-- SET REMOVEDDateadd(MM, 0, Cast(CASE WHEN @Bulan < 10 THEN '0' ELSE ''  + Cast(@Bulan AS varchar(2))+'-01-'+ 

                           Cast(@Tahun AS varchar(4)) AS Datetime))

-- SET REMOVED@Bulan+1 

select @SmpThn=case when @SmpBln=13 then @Tahun+1 else @Tahun 

select @SmpBln=case when @SmpBln=13 then 1 else @SmpBln 


-- SET REMOVEDDateadd(MM, 0, Cast(CASE WHEN @SmpBln < 10 THEN '0' ELSE ''  + Cast(@SmpBln AS varchar(2))+'-01-'+ 

                           Cast(@SmpThn AS varchar(4)) AS Datetime))

Select @SmpTgl=@SmpTgl-1

select @SblTgl=@Tanggal-1



if @Tahun>2019

if @Id=''

--gabungan

select 'Gabungan' Perusahaan,* from (

select distinct a.KODECUSTSUPP,a.NAMACUSTSUPP,prj.KODEPROJECT,prj.NAMAPROJECT,

COALESCE(b.OSAwal,0) OSAwal,COALESCE(c.SJ,0) SJDPP, COALESCE(d.INV,0)DPPInv,

case when COALESCE(b.OSAwal,0)+COALESCE(c.SJ,0)-COALESCE(d.INV,0)>0 then

COALESCE(b.OSAwal,0)+COALESCE(c.SJ,0)-COALESCE(d.INV,0) else COALESCE(b.OSAwal,0)+COALESCE(c.SJ,0)-COALESCE(d.INV,0)  OSAKHIR, 

COALESCE(dbo.DP(a.KODECUSTSUPP,@SmpTgl,@Id),0) DP,COALESCE(dbo.TotalDP(@SmpTgl,@Id),0)TotalDP

from DBCUSTSUPP a

Left Outer Join DBPROJECT prj on prj.KODECUST=a.KODECUSTSUPP 

left outer join

(

  select a.KodeCust KodeCustSupp,a.KODEPROJECT NoResi,

  case when ((@Bulan<=6 and @Tahun=2017) or @Tahun<2017) then b.Nilai else c.Nilai  OSAwal 

  from DBPROJECT a

  left outer join DBPiutSJAwl b on b.KodeCust=a.KODECUST and b.KodePrj=a.KODEPROJECT

  left outer join (select * from DBPiutSJ where Bulan=@Bulan and Tahun=@Tahun) c on c.KodeCust=a.KodeCust and c.KodePrj=a.KODEPROJECT

  --where a.KODEPROJECT not like '%@ca'

) B on B.KodeCustSupp=A.KODECUSTSUPP and B.NoResi=prj.KODEPROJECT

left outer join

(

  Select a.KodeCustSupp,a.NoResi,SUM(a.dpp) SJ

                from VwreportSPBPlusReturACC a      

                where MONTH(a.Tanggal)=@Bulan and YEAR(a.Tanggal)=@Tahun

                and a.KodeCustSupp not like '%@ca' --and (Left(a.NoSC,3) Like 'BCA%' or Left(a.NoSC,3) Like 'BCB%') 

                Group By a.KodeCustSupp,a.NoResi

) C on C.KodeCustSupp=a.KODECUSTSUPP and c.NoResi=prj.KODEPROJECT

left outer join

(

 Select a.KodeCustSupp,a.NoResi,case when @Bulan=4 and @Tahun=2020 

                                and a.KodeCustSupp='L0000023' and a.NoResi='PRO03464' then 31650000 

                                when @Bulan=7 and @Tahun=2020 

                                and a.KodeCustSupp='P0000092' and a.NoResi='PRB00044' then 41263750

                                when @Bulan=7 and @Tahun=2020 

                                and a.KodeCustSupp='S0000123' and a.NoResi='PRO03295' then 134011581

                                when @Bulan=10 and @Tahun=2020 

                                and a.KodeCustSupp='J0000047' and a.NoResi='PRB00108' then 180396000

                                when @Bulan=11 and @Tahun=2020 

                                and a.KodeCustSupp='S0000154' and a.NoResi='PRB00316' then 225000000

                                when @Bulan=11 and @Tahun=2020 

                                and a.KodeCustSupp='S0000154' and a.NoResi='PRB00381' then 750000

                                when @Bulan=12 and @Tahun=2020 

                                and a.KodeCustSupp='S0000152' and a.NoResi='PRB00268' then 97135000

                                when @Bulan=12 and @Tahun=2020 

                                and a.KodeCustSupp='S0000152' and a.NoResi='PRB00269' then 104620000

                                when @Bulan=12 and @Tahun=2020 

                                and a.KodeCustSupp='S0000152' and a.NoResi='PRB00365' then 33453800 

                                when @Bulan=2 and @Tahun=2021 

                                and a.KodeCustSupp='A0000165' and a.NoResi='PRC00263' then  128660000 

                                when @Bulan=5 and @Tahun=2021 

                                and a.KodeCustSupp='F0000025' and a.NoResi='PRB00679' then  26701250

                                when @Bulan=6 and @Tahun=2021 

                                and a.KodeCustSupp='S0000032' and a.NoResi='PRC00459' then  19525000

                                when @Bulan=9 and @Tahun=2021 

                                and a.KodeCustSupp='I0000049' and a.NoResi='PRB00674' then  56316900 

                                else SUM(a.NDPPRp)  INV

                                

                from VwreportInvoicePenjualan a      

                where MONTH(a.Tanggal)=@Bulan and YEAR(a.Tanggal)=@Tahun --and a.Noso not in (select NoBukti from TempSOTerpasang Group by NoBukti)

                and a.KodeCustSupp not like '%@ca' and a.NoInv in ( select NoBukti from DBInvoicePLdet where NoSPB Not Like '%SJB%' and NoSPB not like '%SPBB%' and Namabrg not like '%Jasa%' )--NoSPB Not Like '%SJB%' and NoSPB not like '%SPBB%' and Namabrg not like '%Jasa%'   

                Group By a.KodeCustSupp,a.NoResi

   /* union all

    select b.KodeCustSupp,d.NoResi, SUM(a.TDPP+a.TNPPN) INV FROM   dbo.dbInvoicePLRetensi A      

    left Outer join dbo.dbInvoicePL b on b.NoBukti=a.NoInvoice 

    left outer join dbo.dbInvoicePLDet c on c.NoBukti=b.NoBukti

    left outer join dbSPB d on c.NoSPB = d.NoBukti

    where MONTH(a.Tanggal)=@Bulan and YEAR(a.Tanggal)=@Tahun and 

    b.KodeCustSupp not like '%@ca' and NoSPB Not Like '%SJB%' and NoSPB not like '%SPBB%' and Namabrg not like '%Jasa%' 

    group by b.KodeCustSupp,d.NoResi  

  Union all

  Select a.KodeCustSupp,a.NoResi,b.Nilai INV

                from VwreportInvoicePenjualan a     

                left outer join DBPiutSJ b on b.KodeCust=a.KodeCustSupp and b.KodePrj=a.NoResi 

                where MONTH(a.Tanggal)=@Bulan and YEAR(a.Tanggal)=@Tahun and b.Bulan=@Bulan and b.Tahun=@Tahun

                and a.Noso in (select NoBukti from TempSOTerpasang Group by NoBukti)

                and a.KodeCustSupp not like '%@ca' and NoSPB Not Like '%SJB%' and NoSPB not like '%SPBB%' and Namabrg not like '%Jasa%'  

                Group By a.KodeCustSupp,a.NoResi,b.Nilai*/

) D on D.KodeCustSupp=a.KODECUSTSUPP and D.NoResi=prj.KODEPROJECT

where a.KODECUSTSUPP not like '%@ca' and

((COALESCE(dbo.DP(a.KODECUSTSUPP,@SmpTgl,@Id),0)=0 ) or 

(COALESCE(dbo.DP(a.KODECUSTSUPP,@SmpTgl,@Id),0)<>0)) and 

(COALESCE(b.OSAwal,0)<>0 or COALESCE(c.SJ,0)<>0 or COALESCE(d.INV,0)<>0 or

COALESCE(b.OSAwal,0)+COALESCE(c.SJ,0)-COALESCE(d.INV,0)<>0 or 

COALESCE(dbo.DP(a.KODECUSTSUPP,@SmpTgl,@Id),0)<>0)



union all

select distinct a.KODECUSTSUPP,a.NAMACUSTSUPP,prj.KODEPROJECT,prj.NAMAPROJECT,

COALESCE(b.OSAwal,0) OSAwal,COALESCE(c.SJ,0) SJDPP, COALESCE(d.INV,0)DPPInv,

case when COALESCE(b.OSAwal,0)+COALESCE(c.SJ,0)-COALESCE(d.INV,0)>0 then

COALESCE(b.OSAwal,0)+COALESCE(c.SJ,0)-COALESCE(d.INV,0) else 0  OSAKHIR, 

COALESCE(dbo.DP(a.KODECUSTSUPP,@SmpTgl,@Id),0) DP,COALESCE(dbo.TotalDP(@SmpTgl,@Id),0)TotalDP

from DBCUSTSUPP a

Left Outer Join DBPROJECT prj on prj.KODECUST=a.KODECUSTSUPP

left outer join

(

  select a.KodeCust KodeCustSupp,a.KODEPROJECT NoResi,

  case when ((@Bulan<=6 and @Tahun=2017) or @Tahun<2017) then b.Nilai else c.Nilai  OSAwal 

  from DBPROJECT a

  left outer join DBPiutSJAwl b on b.KodeCust=a.KODECUST and b.KodePrj=a.KODEPROJECT

  left outer join (select * from DBPiutSJ where Bulan=@Bulan and Tahun=@Tahun) c on c.KodeCust=a.KodeCust and c.KodePrj=a.KODEPROJECT

  --where a.KODEPROJECT like '%@ca'

) B on B.KodeCustSupp=A.KODECUSTSUPP and B.NoResi=prj.KODEPROJECT

left outer join

(

  Select a.KodeCustSupp,a.NoResi,SUM(a.dpp) SJ

                from VwreportSPBPlusReturACC a      

                where MONTH(a.Tanggal)=@Bulan and YEAR(a.Tanggal)=@Tahun

                and a.KodeCustSupp like '%@ca' --and(Left(a.NoSC,2) Like 'CA%' or Left(a.NoSC,2) Like 'CB%') 

                Group By a.KodeCustSupp,a.NoResi

) C on C.KodeCustSupp=a.KODECUSTSUPP and c.NoResi=prj.KODEPROJECT

left outer join

(

 Select a.KodeCustSupp,a.NoResi,case when @Bulan=3 and @Tahun=2023 

                                and a.KodeCustSupp='T0000043@CA' and a.NoResi='PRB02839' then 3360000 

                                else SUM(a.NDPPRp)  INV

                from VwreportInvoicePenjualan a      

                where MONTH(a.Tanggal)=@Bulan and YEAR(a.Tanggal)=@Tahun --and a.Noso not in (select NoBukti from TempSOTerpasang Group by NoBukti)

                and a.KodeCustSupp like '%@ca' and a.NoInv in ( select NoBukti from DBInvoicePLdet where NoSPB Not Like '%SJB%' and NoSPB not like '%SPBB%' and Namabrg not like '%Jasa%' )--NoSPB Not Like '%SJB%' and NoSPB not like '%SPBB%' and Namabrg not like '%Jasa%'   

                Group By a.KodeCustSupp,a.NoResi

   /* union all

    select b.KodeCustSupp,d.NoResi, SUM(a.TDPP+a.TNPPN) INV FROM   dbo.dbInvoicePLRetensi A      

    left Outer join dbo.dbInvoicePL b on b.NoBukti=a.NoInvoice 

    left outer join dbo.dbInvoicePLDet c on c.NoBukti=b.NoBukti

    left outer join dbSPB d on c.NoSPB = d.NoBukti

    where MONTH(a.Tanggal)=@Bulan and YEAR(a.Tanggal)=@Tahun and 

    b.KodeCustSupp like '%@ca' and NoSPB Not Like '%SJB%' and NoSPB not like '%SPBB%' and Namabrg not like '%Jasa%' 

    group by b.KodeCustSupp,d.NoResi  

 Union all

  Select a.KodeCustSupp,a.NoResi,b.Nilai INV

                from VwreportInvoicePenjualan a     

                left outer join DBPiutSJ b on b.KodeCust=a.KodeCustSupp and b.KodePrj=a.NoResi 

                where MONTH(a.Tanggal)=@Bulan and YEAR(a.Tanggal)=@Tahun and b.Bulan=@Bulan and b.Tahun=@Tahun

                and a.Noso in (select NoBukti from TempSOTerpasang Group by NoBukti)

                and a.KodeCustSupp like '%@ca' and NoSPB Not Like '%SJB%' and NoSPB not like '%SPBB%' and Namabrg not like '%Jasa%'   

                Group By a.KodeCustSupp,a.NoResi,b.Nilai*/

) D on D.KodeCustSupp=a.KODECUSTSUPP and D.NoResi=prj.KODEPROJECT

where a.KODECUSTSUPP like '%@ca' and

((COALESCE(dbo.DP(a.KODECUSTSUPP,@SmpTgl,@Id),0)=0 ) or 

(COALESCE(dbo.DP(a.KODECUSTSUPP,@SmpTgl,@Id),0)<>0)) and 

(COALESCE(b.OSAwal,0)<>0 or COALESCE(c.SJ,0)<>0 or COALESCE(d.INV,0)<>0 or

COALESCE(b.OSAwal,0)+COALESCE(c.SJ,0)-COALESCE(d.INV,0)<>0 or 

COALESCE(dbo.DP(a.KODECUSTSUPP,@SmpTgl,@Id),0)<>0)) A

order by case when a.KODECUSTSUPP not like '%@ca' then 0 else 1 , a.KODECUSTSUPP,a.KODEPROJECT



delete DBPiutSJ where (Bulan=case when @Bulan=12 then 1 else @Bulan+1 ) and (tahun=case when @Bulan=12 then @Tahun+1 else @Tahun )

and KodeCust not like '%@ca'   

insert DBPiutSJ(Bulan,Tahun,KodeCust,KodePrj,Nilai)

select distinct case when @Bulan=12 then 1 else @Bulan+1 ,case when @Bulan=12 then @Tahun+1 else @Tahun ,

    a.KODECUSTSUPP,prj.KODEPROJECT,

    case when COALESCE(b.OSAwal,0)+COALESCE(c.SJ,0)-COALESCE(d.INV,0)>0 then

    COALESCE(b.OSAwal,0)+COALESCE(c.SJ,0)-COALESCE(d.INV,0) else COALESCE(b.OSAwal,0)+COALESCE(c.SJ,0)-COALESCE(d.INV,0) 

from DBCUSTSUPP a

Left Outer Join DBPROJECT prj on prj.KODECUST=a.KODECUSTSUPP 

left outer join

(

  select a.KodeCust KodeCustSupp,a.KODEPROJECT NoResi,

  case when ((@Bulan<=6 and @Tahun=2017) or @Tahun<2017) then b.Nilai else c.Nilai  OSAwal 

  from DBPROJECT a

  left outer join DBPiutSJAwl b on b.KodeCust=a.KODECUST and b.KodePrj=a.KODEPROJECT

  left outer join (select * from DBPiutSJ where Bulan=@Bulan and Tahun=@Tahun) c on c.KodeCust=a.KodeCust and c.KodePrj=a.KODEPROJECT

  --where a.KODEPROJECT not like '%@ca'

) B on B.KodeCustSupp=A.KODECUSTSUPP and B.NoResi=prj.KODEPROJECT

left outer join

(

  Select a.KodeCustSupp,a.NoResi,SUM(a.dpp) SJ

                from VwreportSPBPlusReturACC a      

                where MONTH(a.Tanggal)=@Bulan and YEAR(a.Tanggal)=@Tahun

                and a.KodeCustSupp not like '%@ca' --and (Left(a.NoSC,3) Like 'BCA%' or Left(a.NoSC,3) Like 'BCB%') 

                Group By a.KodeCustSupp,a.NoResi

) C on C.KodeCustSupp=a.KODECUSTSUPP and c.NoResi=prj.KODEPROJECT

left outer join

(

 Select a.KodeCustSupp,a.NoResi,case when @Bulan=4 and @Tahun=2020 

                                and a.KodeCustSupp='L0000023' and a.NoResi='PRO03464' then 31650000 

                                when @Bulan=7 and @Tahun=2020 

                                and a.KodeCustSupp='P0000092' and a.NoResi='PRB00044' then 41263750

                                when @Bulan=7 and @Tahun=2020 

                                and a.KodeCustSupp='S0000123' and a.NoResi='PRO03295' then 134011581

                                when @Bulan=10 and @Tahun=2020 

                                and a.KodeCustSupp='J0000047' and a.NoResi='PRB00108' then  180396000

                                when @Bulan=11 and @Tahun=2020 

                                and a.KodeCustSupp='S0000154' and a.NoResi='PRB00316' then  225000000

                                when @Bulan=11 and @Tahun=2020 

                                and a.KodeCustSupp='S0000154' and a.NoResi='PRB00381' then  750000

                                when @Bulan=12 and @Tahun=2020 

                                and a.KodeCustSupp='S0000152' and a.NoResi='PRB00268' then 97135000

                                when @Bulan=12 and @Tahun=2020 

                                and a.KodeCustSupp='S0000152' and a.NoResi='PRB00269' then 104620000

                                when @Bulan=12 and @Tahun=2020 

                                and a.KodeCustSupp='S0000152' and a.NoResi='PRB00365' then 33453800 

                                when @Bulan=2 and @Tahun=2021 

                                and a.KodeCustSupp='A0000165' and a.NoResi='PRC00263' then  128660000 

                                when @Bulan=5 and @Tahun=2021 

                                and a.KodeCustSupp='F0000025' and a.NoResi='PRB00679' then  26701250

                                when @Bulan=6 and @Tahun=2021 

                                and a.KodeCustSupp='S0000032' and a.NoResi='PRC00459' then  19525000

                                when @Bulan=9 and @Tahun=2021 

                                and a.KodeCustSupp='I0000049' and a.NoResi='PRB00674' then  56316900 

                                else SUM(a.NDPPRp)  INV

                from VwreportInvoicePenjualan a      

                where MONTH(a.Tanggal)=@Bulan and YEAR(a.Tanggal)=@Tahun --and a.Noso not in (select NoBukti from TempSOTerpasang Group by NoBukti)

                and a.KodeCustSupp not like '%@ca' and a.NoInv in ( select NoBukti from DBInvoicePLdet where NoSPB Not Like '%SJB%' and NoSPB not like '%SPBB%' and Namabrg not like '%Jasa%' )--NoSPB Not Like '%SJB%' and NoSPB not like '%SPBB%' and Namabrg not like '%Jasa%'   

                Group By a.KodeCustSupp,a.NoResi

  /*  union all

    select b.KodeCustSupp,d.NoResi, SUM(a.TDPP+a.TNPPN) INV FROM   dbo.dbInvoicePLRetensi A      

    left Outer join dbo.dbInvoicePL b on b.NoBukti=a.NoInvoice 

    left outer join dbo.dbInvoicePLDet c on c.NoBukti=b.NoBukti

    left outer join dbSPB d on c.NoSPB = d.NoBukti

    where MONTH(a.Tanggal)=@Bulan and YEAR(a.Tanggal)=@Tahun and 

    b.KodeCustSupp not like '%@ca' and NoSPB Not Like '%SJB%' and NoSPB not like '%SPBB%' and Namabrg not like '%Jasa%' 

    group by b.KodeCustSupp,d.NoResi  

  Union all

  Select a.KodeCustSupp,a.NoResi,b.Nilai INV

                from VwreportInvoicePenjualan a     

                left outer join DBPiutSJ b on b.KodeCust=a.KodeCustSupp and b.KodePrj=a.NoResi 

                where MONTH(a.Tanggal)=@Bulan and YEAR(a.Tanggal)=@Tahun and b.Bulan=@Bulan and b.Tahun=@Tahun

                and a.Noso in (select NoBukti from TempSOTerpasang Group by NoBukti)

                and a.KodeCustSupp not like '%@ca' and NoSPB Not Like '%SJB%' and NoSPB not like '%SPBB%' and Namabrg not like '%Jasa%'  

                Group By a.KodeCustSupp,a.NoResi,b.Nilai*/

) D on D.KodeCustSupp=a.KODECUSTSUPP and D.NoResi=prj.KODEPROJECT

where a.KODECUSTSUPP not like '%@ca' and

((COALESCE(dbo.DP(a.KODECUSTSUPP,@SmpTgl,@Id),0)=0 ) or 

(COALESCE(dbo.DP(a.KODECUSTSUPP,@SmpTgl,@Id),0)<>0)) and 

(COALESCE(b.OSAwal,0)<>0 or COALESCE(c.SJ,0)<>0 or COALESCE(d.INV,0)<>0 or

COALESCE(b.OSAwal,0)+COALESCE(c.SJ,0)-COALESCE(d.INV,0)<>0 or 

COALESCE(dbo.DP(a.KODECUSTSUPP,@SmpTgl,@Id),0)<>0)

order by a.KODECUSTSUPP,prj.KODEPROJECT



delete DBPiutSJ where (Bulan=case when @Bulan=12 then 1 else @Bulan+1 ) and (tahun=case when @Bulan=12 then @Tahun+1 else @Tahun ) 

and KodeCust like '%@ca'    

insert DBPiutSJ(Bulan,Tahun,KodeCust,KodePrj,Nilai)

select distinct case when @Bulan=12 then 1 else @Bulan+1 ,case when @Bulan=12 then @Tahun+1 else @Tahun ,

    a.KODECUSTSUPP,prj.KODEPROJECT,

    case when (COALESCE(b.OSAwal,0)+COALESCE(c.SJ,0)-COALESCE(d.INV,0))>0 then

    COALESCE(b.OSAwal,0)+COALESCE(c.SJ,0)-COALESCE(d.INV,0) else 0 

from DBCUSTSUPP a

Left Outer Join DBPROJECT prj on prj.KODECUST=a.KODECUSTSUPP

left outer join

(

  select a.KodeCust KodeCustSupp,a.KODEPROJECT NoResi,

  case when ((@Bulan<=6 and @Tahun=2017) or @Tahun<2017) then b.Nilai else c.Nilai  OSAwal 

  from DBPROJECT a

  left outer join DBPiutSJAwl b on b.KodeCust=a.KODECUST and b.KodePrj=a.KODEPROJECT

  left outer join (select * from DBPiutSJ where Bulan=@Bulan and Tahun=@Tahun) c on c.KodeCust=a.KodeCust and c.KodePrj=a.KODEPROJECT

  --where a.KODEPROJECT like '%@ca'

) B on B.KodeCustSupp=A.KODECUSTSUPP and B.NoResi=prj.KODEPROJECT

left outer join

(

  Select a.KodeCustSupp,a.NoResi,SUM(a.dpp) SJ

                from VwreportSPBPlusReturACC a      

                where MONTH(a.Tanggal)=@Bulan and YEAR(a.Tanggal)=@Tahun

                and a.KodeCustSupp like '%@ca' --and(Left(a.NoSC,2) Like 'CA%' or Left(a.NoSC,2) Like 'CB%') 

                Group By a.KodeCustSupp,a.NoResi

) C on C.KodeCustSupp=a.KODECUSTSUPP and c.NoResi=prj.KODEPROJECT

left outer join

(

 Select a.KodeCustSupp,a.NoResi,case when @Bulan=3 and @Tahun=2023 

                                and a.KodeCustSupp='T0000043@CA' and a.NoResi='PRB02839' then 3360000 

                                else SUM(a.NDPPRp)  INV

                from VwreportInvoicePenjualan a      

                where MONTH(a.Tanggal)=@Bulan and YEAR(a.Tanggal)=@Tahun --and a.Noso not in (select NoBukti from TempSOTerpasang Group by NoBukti)

                and a.KodeCustSupp like '%@ca' and a.NoInv in ( select NoBukti from DBInvoicePLdet where NoSPB Not Like '%SJB%' and NoSPB not like '%SPBB%' and Namabrg not like '%Jasa%' )--NoSPB Not Like '%SJB%' and NoSPB not like '%SPBB%' and Namabrg not like '%Jasa%'   

                Group By a.KodeCustSupp,a.NoResi

   /* union all

    select b.KodeCustSupp,d.NoResi, SUM(a.TDPP+a.TNPPN) INV FROM   dbo.dbInvoicePLRetensi A      

    left Outer join dbo.dbInvoicePL b on b.NoBukti=a.NoInvoice 

    left outer join dbo.dbInvoicePLDet c on c.NoBukti=b.NoBukti

    left outer join dbSPB d on c.NoSPB = d.NoBukti

    where MONTH(a.Tanggal)=@Bulan and YEAR(a.Tanggal)=@Tahun and 

    b.KodeCustSupp like '%@ca' and NoSPB Not Like '%SJB%' and NoSPB not like '%SPBB%' and Namabrg not like '%Jasa%' 

    group by b.KodeCustSupp,d.NoResi  

 Union all

  Select a.KodeCustSupp,a.NoResi,b.Nilai INV

                from VwreportInvoicePenjualan a     

                left outer join DBPiutSJ b on b.KodeCust=a.KodeCustSupp and b.KodePrj=a.NoResi 

                where MONTH(a.Tanggal)=@Bulan and YEAR(a.Tanggal)=@Tahun and b.Bulan=@Bulan and b.Tahun=@Tahun

                and a.Noso in (select NoBukti from TempSOTerpasang Group by NoBukti)

                and a.KodeCustSupp like '%@ca' and NoSPB Not Like '%SJB%' and NoSPB not like '%SPBB%' and Namabrg not like '%Jasa%'   

                Group By a.KodeCustSupp,a.NoResi,b.Nilai*/

) D on D.KodeCustSupp=a.KODECUSTSUPP and D.NoResi=prj.KODEPROJECT

where a.KODECUSTSUPP like '%@ca' and

((COALESCE(dbo.DP(a.KODECUSTSUPP,@SmpTgl,@Id),0)=0 ) or 

(COALESCE(dbo.DP(a.KODECUSTSUPP,@SmpTgl,@Id),0)<>0)) and 

(COALESCE(b.OSAwal,0)<>0 or COALESCE(c.SJ,0)<>0 or COALESCE(d.INV,0)<>0 or

COALESCE(b.OSAwal,0)+COALESCE(c.SJ,0)-COALESCE(d.INV,0)<>0 or 

COALESCE(dbo.DP(a.KODECUSTSUPP,@SmpTgl,@Id),0)<>0)

order by a.KODECUSTSUPP,prj.KODEPROJECT


else

--bca

if @Id='B'

select distinct Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan, a.KODECUSTSUPP,a.NAMACUSTSUPP,prj.KODEPROJECT,prj.NAMAPROJECT,

COALESCE(b.OSAwal,0) OSAwal,COALESCE(c.SJ,0) SJDPP, COALESCE(d.INV,0)DPPInv,

case when COALESCE(b.OSAwal,0)+COALESCE(c.SJ,0)-COALESCE(d.INV,0)>0 then

COALESCE(b.OSAwal,0)+COALESCE(c.SJ,0)-COALESCE(d.INV,0) else 0  OSAKHIR, 

COALESCE(dbo.DP(a.KODECUSTSUPP,@SmpTgl,@Id),0) DP,COALESCE(dbo.TotalDP(@SmpTgl,@Id),0)TotalDP

from DBCUSTSUPP a

Left Outer Join DBPROJECT prj on prj.KODECUST=a.KODECUSTSUPP 

left outer join

(

  select a.KodeCust KodeCustSupp,a.KODEPROJECT NoResi,

  case when ((@Bulan<=6 and @Tahun=2017) or @Tahun<2017) then b.Nilai else c.Nilai  OSAwal 

  from DBPROJECT a

  left outer join DBPiutSJAwl b on b.KodeCust=a.KODECUST and b.KodePrj=a.KODEPROJECT

  left outer join (select * from DBPiutSJ where Bulan=@Bulan and Tahun=@Tahun) c on c.KodeCust=a.KodeCust and c.KodePrj=a.KODEPROJECT

  --where a.KODEPROJECT not like '%@ca'

) B on B.KodeCustSupp=A.KODECUSTSUPP and B.NoResi=prj.KODEPROJECT

left outer join

(

 Select a.KodeCustSupp,a.NoResi,SUM(a.dpp) SJ

                from VwreportSPBPlusReturACC a      

                where MONTH(a.Tanggal)=@Bulan and YEAR(a.Tanggal)=@Tahun

                and a.KodeCustSupp not like '%@ca' --and (Left(a.NoSC,3) Like 'BCA%' or Left(a.NoSC,3) Like 'BCB%') 

                Group By a.KodeCustSupp,a.NoResi

) C on C.KodeCustSupp=a.KODECUSTSUPP and c.NoResi=prj.KODEPROJECT

left outer join

(

 Select a.KodeCustSupp,a.NoResi,case when @Bulan=4 and @Tahun=2020 

                                and a.KodeCustSupp='L0000023' and a.NoResi='PRO03464' then 31650000 

                                when @Bulan=7 and @Tahun=2020 

                                and a.KodeCustSupp='P0000092' and a.NoResi='PRB00044' then 41263750

                                when @Bulan=7 and @Tahun=2020 

                                and a.KodeCustSupp='S0000123' and a.NoResi='PRO03295' then 134011581

                                when @Bulan=10 and @Tahun=2020 

                                and a.KodeCustSupp='J0000047' and a.NoResi='PRB00108' then  180396000

                                when @Bulan=11 and @Tahun=2020 

                                and a.KodeCustSupp='S0000154' and a.NoResi='PRB00316' then  225000000

                                when @Bulan=11 and @Tahun=2020 

                                and a.KodeCustSupp='S0000154' and a.NoResi='PRB00381' then  750000

                                when @Bulan=12 and @Tahun=2020 

                                and a.KodeCustSupp='S0000152' and a.NoResi='PRB00268' then 97135000

                                when @Bulan=12 and @Tahun=2020 

                                and a.KodeCustSupp='S0000152' and a.NoResi='PRB00269' then 104620000

                                when @Bulan=12 and @Tahun=2020 

                                and a.KodeCustSupp='S0000152' and a.NoResi='PRB00365' then 33453800 

                                when @Bulan=2 and @Tahun=2021 

                                and a.KodeCustSupp='A0000165' and a.NoResi='PRC00263' then  128660000

                                when @Bulan=5 and @Tahun=2021 

                                and a.KodeCustSupp='F0000025' and a.NoResi='PRB00679' then  26701250

                                when @Bulan=6 and @Tahun=2021 

                                and a.KodeCustSupp='S0000032' and a.NoResi='PRC00459' then  19525000 

                                when @Bulan=9 and @Tahun=2021 

                                and a.KodeCustSupp='I0000049' and a.NoResi='PRB00674' then  56316900 

                                else SUM(a.NDPPRp)  INV

                from VwreportInvoicePenjualan a      

                where MONTH(a.Tanggal)=@Bulan and YEAR(a.Tanggal)=@Tahun --and a.Noso not in (select NoBukti from TempSOTerpasang Group by NoBukti)

                and a.KodeCustSupp not like '%@ca' and a.NoInv in ( select NoBukti from DBInvoicePLdet where NoSPB Not Like '%SJB%' and NoSPB not like '%SPBB%' and Namabrg not like '%Jasa%' )--NoSPB Not Like '%SJB%' and NoSPB not like '%SPBB%' and Namabrg not like '%Jasa%'   

                Group By a.KodeCustSupp,a.NoResi

   /* union all

    select b.KodeCustSupp,d.NoResi, SUM(a.TDPP+a.TNPPN) INV FROM   dbo.dbInvoicePLRetensi A      

    left Outer join dbo.dbInvoicePL b on b.NoBukti=a.NoInvoice 

    left outer join dbo.dbInvoicePLDet c on c.NoBukti=b.NoBukti

    left outer join dbSPB d on c.NoSPB = d.NoBukti

    where MONTH(a.Tanggal)=@Bulan and YEAR(a.Tanggal)=@Tahun and 

    b.KodeCustSupp not like '%@ca' and NoSPB Not Like '%SJB%' and NoSPB not like '%SPBB%' and Namabrg not like '%Jasa%' 

    group by b.KodeCustSupp,d.NoResi  

 Union all

  Select a.KodeCustSupp,a.NoResi,b.Nilai INV

                from VwreportInvoicePenjualan a     

                left outer join DBPiutSJ b on b.KodeCust=a.KodeCustSupp and b.KodePrj=a.NoResi 

                where MONTH(a.Tanggal)=@Bulan and YEAR(a.Tanggal)=@Tahun and b.Bulan=@Bulan and b.Tahun=@Tahun

                and a.Noso in (select NoBukti from TempSOTerpasang Group by NoBukti)

                and a.KodeCustSupp not like '%@ca' and NoSPB Not Like '%SJB%' and NoSPB not like '%SPBB%' and Namabrg not like '%Jasa%'  

                Group By a.KodeCustSupp,a.NoResi,b.Nilai*/

) D on D.KodeCustSupp=a.KODECUSTSUPP and D.NoResi=prj.KODEPROJECT

where a.KODECUSTSUPP not like '%@ca' and

((COALESCE(dbo.DP(a.KODECUSTSUPP,@SmpTgl,@Id),0)=0 ) or 

(COALESCE(dbo.DP(a.KODECUSTSUPP,@SmpTgl,@Id),0)<>0)) and 

(COALESCE(b.OSAwal,0)<>0 or COALESCE(c.SJ,0)<>0 or COALESCE(d.INV,0)<>0 or

COALESCE(b.OSAwal,0)+COALESCE(c.SJ,0)-COALESCE(d.INV,0)<>0 or 

COALESCE(dbo.DP(a.KODECUSTSUPP,@SmpTgl,@Id),0)<>0)

order by a.KODECUSTSUPP,prj.KODEPROJECT



delete DBPiutSJ where (Bulan=case when @Bulan=12 then 1 else @Bulan+1 ) and (tahun=case when @Bulan=12 then @Tahun+1 else @Tahun )

and KodeCust not like '%@ca'   

insert DBPiutSJ(Bulan,Tahun,KodeCust,KodePrj,Nilai)

select distinct case when @Bulan=12 then 1 else @Bulan+1 ,case when @Bulan=12 then @Tahun+1 else @Tahun ,

    a.KODECUSTSUPP,prj.KODEPROJECT,

    case when COALESCE(b.OSAwal,0)+COALESCE(c.SJ,0)-COALESCE(d.INV,0)>0 then

    COALESCE(b.OSAwal,0)+COALESCE(c.SJ,0)-COALESCE(d.INV,0) else 0 

from DBCUSTSUPP a

Left Outer Join DBPROJECT prj on prj.KODECUST=a.KODECUSTSUPP 

left outer join

(

  select a.KodeCust KodeCustSupp,a.KODEPROJECT NoResi,

  case when ((@Bulan<=6 and @Tahun=2017) or @Tahun<2017) then b.Nilai else c.Nilai  OSAwal 

  from DBPROJECT a

  left outer join DBPiutSJAwl b on b.KodeCust=a.KODECUST and b.KodePrj=a.KODEPROJECT

  left outer join (select * from DBPiutSJ where Bulan=@Bulan and Tahun=@Tahun) c on c.KodeCust=a.KodeCust and c.KodePrj=a.KODEPROJECT

  --where a.KODEPROJECT not like '%@ca'

) B on B.KodeCustSupp=A.KODECUSTSUPP and B.NoResi=prj.KODEPROJECT

left outer join

(

 Select a.KodeCustSupp,a.NoResi,SUM(a.dpp) SJ

                from VwreportSPBPlusReturACC a      

                where MONTH(a.Tanggal)=@Bulan and YEAR(a.Tanggal)=@Tahun

                and a.KodeCustSupp not like '%@ca' --and (Left(a.NoSC,3) Like 'BCA%' or Left(a.NoSC,3) Like 'BCB%') 

                Group By a.KodeCustSupp,a.NoResi

) C on C.KodeCustSupp=a.KODECUSTSUPP and c.NoResi=prj.KODEPROJECT

left outer join

(

 Select a.KodeCustSupp,a.NoResi,case when @Bulan=4 and @Tahun=2020 

                                and a.KodeCustSupp='L0000023' and a.NoResi='PRO03464' then 31650000 

                                when @Bulan=7 and @Tahun=2020 

                                and a.KodeCustSupp='P0000092' and a.NoResi='PRB00044' then 41263750

                                when @Bulan=7 and @Tahun=2020 

                                and a.KodeCustSupp='S0000123' and a.NoResi='PRO03295' then 134011581

                                when @Bulan=10 and @Tahun=2020 

                                and a.KodeCustSupp='J0000047' and a.NoResi='PRB00108' then  180396000

                                when @Bulan=11 and @Tahun=2020 

                                and a.KodeCustSupp='S0000154' and a.NoResi='PRB00316' then  225000000

                                when @Bulan=11 and @Tahun=2020 

                                and a.KodeCustSupp='S0000154' and a.NoResi='PRB00381' then  750000

                                when @Bulan=12 and @Tahun=2020 

                                and a.KodeCustSupp='S0000152' and a.NoResi='PRB00268' then 97135000

                                when @Bulan=12 and @Tahun=2020 

                                and a.KodeCustSupp='S0000152' and a.NoResi='PRB00269' then 104620000

                                when @Bulan=12 and @Tahun=2020 

                                and a.KodeCustSupp='S0000152' and a.NoResi='PRB00365' then 33453800 

                                when @Bulan=2 and @Tahun=2021 

                                and a.KodeCustSupp='A0000165' and a.NoResi='PRC00263' then  128660000 

                                when @Bulan=5 and @Tahun=2021 

                                and a.KodeCustSupp='F0000025' and a.NoResi='PRB00679' then  26701250

                                when @Bulan=6 and @Tahun=2021 

                                and a.KodeCustSupp='S0000032' and a.NoResi='PRC00459' then  19525000

                                when @Bulan=9 and @Tahun=2021 

                                and a.KodeCustSupp='I0000049' and a.NoResi='PRB00674' then  56316900 

                                else SUM(a.NDPPRp)  INV

                from VwreportInvoicePenjualan a      

                where MONTH(a.Tanggal)=@Bulan and YEAR(a.Tanggal)=@Tahun --and a.Noso not in (select NoBukti from TempSOTerpasang Group by NoBukti)

                and a.KodeCustSupp not like '%@ca' and a.NoInv in ( select NoBukti from DBInvoicePLdet where NoSPB Not Like '%SJB%' and NoSPB not like '%SPBB%' and Namabrg not like '%Jasa%' )--NoSPB Not Like '%SJB%' and NoSPB not like '%SPBB%' and Namabrg not like '%Jasa%'   

                Group By a.KodeCustSupp,a.NoResi

   /* union all

    select b.KodeCustSupp,d.NoResi, SUM(a.TDPP+a.TNPPN) INV FROM   dbo.dbInvoicePLRetensi A      

    left Outer join dbo.dbInvoicePL b on b.NoBukti=a.NoInvoice 

    left outer join dbo.dbInvoicePLDet c on c.NoBukti=b.NoBukti

    left outer join dbSPB d on c.NoSPB = d.NoBukti

    where MONTH(a.Tanggal)=@Bulan and YEAR(a.Tanggal)=@Tahun and 

    b.KodeCustSupp not like '%@ca' and NoSPB Not Like '%SJB%' and NoSPB not like '%SPBB%' and Namabrg not like '%Jasa%' 

    group by b.KodeCustSupp,d.NoResi  

 Union all

  Select a.KodeCustSupp,a.NoResi,b.Nilai INV

                from VwreportInvoicePenjualan a     

                left outer join DBPiutSJ b on b.KodeCust=a.KodeCustSupp and b.KodePrj=a.NoResi 

                where MONTH(a.Tanggal)=@Bulan and YEAR(a.Tanggal)=@Tahun and b.Bulan=@Bulan and b.Tahun=@Tahun

                and a.Noso in (select NoBukti from TempSOTerpasang Group by NoBukti)

                and a.KodeCustSupp not like '%@ca' and NoSPB Not Like '%SJB%' and NoSPB not like '%SPBB%' and Namabrg not like '%Jasa%'  

                Group By a.KodeCustSupp,a.NoResi,b.Nilai*/

) D on D.KodeCustSupp=a.KODECUSTSUPP and D.NoResi=prj.KODEPROJECT

where a.KODECUSTSUPP not like '%@ca' and

((COALESCE(dbo.DP(a.KODECUSTSUPP,@SmpTgl,@Id),0)=0 ) or 

(COALESCE(dbo.DP(a.KODECUSTSUPP,@SmpTgl,@Id),0)<>0)) and 

(COALESCE(b.OSAwal,0)<>0 or COALESCE(c.SJ,0)<>0 or COALESCE(d.INV,0)<>0 or

COALESCE(b.OSAwal,0)+COALESCE(c.SJ,0)-COALESCE(d.INV,0)<>0 or 

COALESCE(dbo.DP(a.KODECUSTSUPP,@SmpTgl,@Id),0)<>0)

order by a.KODECUSTSUPP,prj.KODEPROJECT



 else

--ca

select distinct Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan, a.KODECUSTSUPP,a.NAMACUSTSUPP,prj.KODEPROJECT,prj.NAMAPROJECT,

COALESCE(b.OSAwal,0) OSAwal,COALESCE(c.SJ,0) SJDPP, COALESCE(d.INV,0)DPPInv,

case when COALESCE(b.OSAwal,0)+COALESCE(c.SJ,0)-COALESCE(d.INV,0)>0 then

COALESCE(b.OSAwal,0)+COALESCE(c.SJ,0)-COALESCE(d.INV,0) else 0  OSAKHIR, 

COALESCE(dbo.DP(a.KODECUSTSUPP,@SmpTgl,@Id),0) DP,COALESCE(dbo.TotalDP(@SmpTgl,@Id),0)TotalDP

from DBCUSTSUPP a

Left Outer Join DBPROJECT prj on prj.KODECUST=a.KODECUSTSUPP

left outer join

(

  select a.KodeCust KodeCustSupp,a.KODEPROJECT NoResi,

  case when ((@Bulan<=6 and @Tahun=2017) or @Tahun<2017) then b.Nilai else c.Nilai  OSAwal 

  from DBPROJECT a

  left outer join DBPiutSJAwl b on b.KodeCust=a.KODECUST and b.KodePrj=a.KODEPROJECT

  left outer join (select * from DBPiutSJ where Bulan=@Bulan and Tahun=@Tahun) c on c.KodeCust=a.KodeCust and c.KodePrj=a.KODEPROJECT

  --where a.KODEPROJECT like '%@ca'

) B on B.KodeCustSupp=A.KODECUSTSUPP and B.NoResi=prj.KODEPROJECT

left outer join

(

 Select a.KodeCustSupp,a.NoResi,SUM(a.dpp) SJ

                from VwreportSPBPlusReturACC a      

                where MONTH(a.Tanggal)=@Bulan and YEAR(a.Tanggal)=@Tahun

                and a.KodeCustSupp like '%@ca' --and(Left(a.NoSC,2) Like 'CA%' or Left(a.NoSC,2) Like 'CB%') 

                Group By a.KodeCustSupp,a.NoResi

) C on C.KodeCustSupp=a.KODECUSTSUPP and c.NoResi=prj.KODEPROJECT

left outer join

(

  Select a.KodeCustSupp,a.NoResi,case when @Bulan=3 and @Tahun=2023 

                                and a.KodeCustSupp='T0000043@CA' and a.NoResi='PRB02839' then 3360000 

                                else SUM(a.NDPPRp)  INV

                from VwreportInvoicePenjualan a      

                where MONTH(a.Tanggal)=@Bulan and YEAR(a.Tanggal)=@Tahun --and a.Noso not in (select NoBukti from TempSOTerpasang Group by NoBukti)

                and a.KodeCustSupp like '%@ca' and a.NoInv in ( select NoBukti from DBInvoicePLdet where NoSPB Not Like '%SJB%' and NoSPB not like '%SPBB%' and Namabrg not like '%Jasa%' )--NoSPB Not Like '%SJB%' and NoSPB not like '%SPBB%' and Namabrg not like '%Jasa%'   

                Group By a.KodeCustSupp,a.NoResi

    /*union all

    select b.KodeCustSupp,d.NoResi, SUM(a.TDPP+a.TNPPN) INV FROM   dbo.dbInvoicePLRetensi A      

    left Outer join dbo.dbInvoicePL b on b.NoBukti=a.NoInvoice 

    left outer join dbo.dbInvoicePLDet c on c.NoBukti=b.NoBukti

    left outer join dbSPB d on c.NoSPB = d.NoBukti

    where MONTH(a.Tanggal)=@Bulan and YEAR(a.Tanggal)=@Tahun and 

    b.KodeCustSupp like '%@ca' and NoSPB Not Like '%SJB%' and NoSPB not like '%SPBB%' and Namabrg not like '%Jasa%' 

    group by b.KodeCustSupp,d.NoResi  

  union all

  Select a.KodeCustSupp,a.NoResi,b.Nilai INV

                from VwreportInvoicePenjualan a     

                left outer join DBPiutSJ b on b.KodeCust=a.KodeCustSupp and b.KodePrj=a.NoResi 

                where MONTH(a.Tanggal)=@Bulan and YEAR(a.Tanggal)=@Tahun and b.Bulan=@Bulan and b.Tahun=@Tahun

                and a.Noso in (select NoBukti from TempSOTerpasang Group by NoBukti)

                and a.KodeCustSupp like '%@ca' and NoSPB Not Like '%SJB%' and NoSPB not like '%SPBB%' and Namabrg not like '%Jasa%'   

                Group By a.KodeCustSupp,a.NoResi,b.Nilai*/

) D on D.KodeCustSupp=a.KODECUSTSUPP and D.NoResi=prj.KODEPROJECT

where a.KODECUSTSUPP like '%@ca' and

((COALESCE(dbo.DP(a.KODECUSTSUPP,@SmpTgl,@Id),0)=0 ) or 

(COALESCE(dbo.DP(a.KODECUSTSUPP,@SmpTgl,@Id),0)<>0)) and 

(COALESCE(b.OSAwal,0)<>0 or COALESCE(c.SJ,0)<>0 or COALESCE(d.INV,0)<>0 or

COALESCE(b.OSAwal,0)+COALESCE(c.SJ,0)-COALESCE(d.INV,0)<>0 or 

COALESCE(dbo.DP(a.KODECUSTSUPP,@SmpTgl,@Id),0)<>0)

order by a.KODECUSTSUPP,prj.KODEPROJECT



delete DBPiutSJ where (Bulan=case when @Bulan=12 then 1 else @Bulan+1 ) and (tahun=case when @Bulan=12 then @Tahun+1 else @Tahun ) 

and KodeCust like '%@ca'    

insert DBPiutSJ(Bulan,Tahun,KodeCust,KodePrj,Nilai)

select distinct case when @Bulan=12 then 1 else @Bulan+1 ,case when @Bulan=12 then @Tahun+1 else @Tahun ,

    a.KODECUSTSUPP,prj.KODEPROJECT,

    case when (COALESCE(b.OSAwal,0)+COALESCE(c.SJ,0)-COALESCE(d.INV,0))>0 then

    COALESCE(b.OSAwal,0)+COALESCE(c.SJ,0)-COALESCE(d.INV,0) else 0 

from DBCUSTSUPP a

Left Outer Join DBPROJECT prj on prj.KODECUST=a.KODECUSTSUPP

left outer join

(

  select a.KodeCust KodeCustSupp,a.KODEPROJECT NoResi,

  case when ((@Bulan<=6 and @Tahun=2017) or @Tahun<2017) then b.Nilai else c.Nilai  OSAwal 

  from DBPROJECT a

  left outer join DBPiutSJAwl b on b.KodeCust=a.KODECUST and b.KodePrj=a.KODEPROJECT

  left outer join (select * from DBPiutSJ where Bulan=@Bulan and Tahun=@Tahun) c on c.KodeCust=a.KodeCust and c.KodePrj=a.KODEPROJECT

 -- where a.KODEPROJECT like '%@ca'

) B on B.KodeCustSupp=A.KODECUSTSUPP and B.NoResi=prj.KODEPROJECT

left outer join

(

 Select a.KodeCustSupp,a.NoResi,SUM(a.dpp) SJ

                from VwreportSPBPlusReturACC a      

                where MONTH(a.Tanggal)=@Bulan and YEAR(a.Tanggal)=@Tahun

                and a.KodeCustSupp like '%@ca' --and(Left(a.NoSC,2) Like 'CA%' or Left(a.NoSC,2) Like 'CB%') 

                Group By a.KodeCustSupp,a.NoResi

) C on C.KodeCustSupp=a.KODECUSTSUPP and c.NoResi=prj.KODEPROJECT

left outer join

(

  Select a.KodeCustSupp,a.NoResi,case when @Bulan=3 and @Tahun=2023 

                                and a.KodeCustSupp='T0000043@CA' and a.NoResi='PRB02839' then 3360000 

                                else SUM(a.NDPPRp)  INV

                from VwreportInvoicePenjualan a      

                where MONTH(a.Tanggal)=@Bulan and YEAR(a.Tanggal)=@Tahun --and a.Noso not in (select NoBukti from TempSOTerpasang Group by NoBukti)

                and a.KodeCustSupp like '%@ca' and a.NoInv in ( select NoBukti from DBInvoicePLdet where NoSPB Not Like '%SJB%' and NoSPB not like '%SPBB%' and Namabrg not like '%Jasa%' )--NoSPB Not Like '%SJB%' and NoSPB not like '%SPBB%' and Namabrg not like '%Jasa%'   

                Group By a.KodeCustSupp,a.NoResi

  /*  union all

    select b.KodeCustSupp,d.NoResi, SUM(a.TDPP+a.TNPPN) INV FROM   dbo.dbInvoicePLRetensi A      

    left Outer join dbo.dbInvoicePL b on b.NoBukti=a.NoInvoice 

    left outer join dbo.dbInvoicePLDet c on c.NoBukti=b.NoBukti

    left outer join dbSPB d on c.NoSPB = d.NoBukti

    where MONTH(a.Tanggal)=@Bulan and YEAR(a.Tanggal)=@Tahun and 

    b.KodeCustSupp like '%@ca' and NoSPB Not Like '%SJB%' and NoSPB not like '%SPBB%' and Namabrg not like '%Jasa%' 

    group by b.KodeCustSupp,d.NoResi  

  union all

  Select a.KodeCustSupp,a.NoResi,b.Nilai INV

                from VwreportInvoicePenjualan a     

                left outer join DBPiutSJ b on b.KodeCust=a.KodeCustSupp and b.KodePrj=a.NoResi 

                where MONTH(a.Tanggal)=@Bulan and YEAR(a.Tanggal)=@Tahun and b.Bulan=@Bulan and b.Tahun=@Tahun

                and a.Noso in (select NoBukti from TempSOTerpasang Group by NoBukti)

                and a.KodeCustSupp like '%@ca' and NoSPB Not Like '%SJB%' and NoSPB not like '%SPBB%' and Namabrg not like '%Jasa%'   

                Group By a.KodeCustSupp,a.NoResi,b.Nilai*/

) D on D.KodeCustSupp=a.KODECUSTSUPP and D.NoResi=prj.KODEPROJECT

where a.KODECUSTSUPP like '%@ca' and

((COALESCE(dbo.DP(a.KODECUSTSUPP,@SmpTgl,@Id),0)=0 ) or 

(COALESCE(dbo.DP(a.KODECUSTSUPP,@SmpTgl,@Id),0)<>0)) and 

(COALESCE(b.OSAwal,0)<>0 or COALESCE(c.SJ,0)<>0 or COALESCE(d.INV,0)<>0 or

COALESCE(b.OSAwal,0)+COALESCE(c.SJ,0)-COALESCE(d.INV,0)<>0 or 

COALESCE(dbo.DP(a.KODECUSTSUPP,@SmpTgl,@Id),0)<>0)

order by a.KODECUSTSUPP,prj.KODEPROJECT;

-- Sp_ReportPlInvoicedet
CREATE PROCEDURE IF NOT EXISTS Sp_ReportPlInvoicedet AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 



if @SReport='T'

If @Ordr='N'

		select * from VwreportPLinvoice where Tanggal between @tgl1 and @tgl2 order by NoBukti,Tanggal

		 

	else If @Ordr='B'

		select * from VwreportPLinvoice where Tanggal between @tgl1 and @tgl2 order by KodeBrg

		 

	else If @Ordr='C'

		select * from VwreportPLinvoice where Tanggal between @tgl1 and @tgl2 order by KodeCustSupp;

-- Sp_ReportPLInvoiceRek
CREATE PROCEDURE IF NOT EXISTS Sp_ReportPLInvoiceRek AS ---- DECLARE REMOVED,@Tgl1 DateTime,@Tgl2 Datetime

--Select @Choice='B',@Tgl1='01/01/2011',@Tgl2='01/01/2013'



If @Choice='N'

select 	B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,

		sum(COALESCE(B.PPN,0))PPN,sum(COALESCE(B.DISC,0))Disc, 

		sum(COALESCE(B.KURS,0))Kurs, sum(COALESCE(B.QNT,0)) QNT, sum(COALESCE(B.QNT2,0))QNT2, 

		sum(COALESCE(B.NetW,0)) NetW,sum(COALESCE(B.GrossW,0))GrossW,

        sum(COALESCE(B.DiscP,0)) DiscP,sum(COALESCE(B.DiscRp,0)) DiscRp,sum(COALESCE(B.DISCTOT,0))Disctot, 

        sum(COALESCE(B.HRGNETTO,0)) HrgNetto, sum(COALESCE(B.NDISKON,0)) NDiskon, 

        sum(COALESCE(B.SUBTOTAL,0)) SubTotal, sum(COALESCE(B.NDPP,0)) NDPP,

        sum(COALESCE(B.NPPN,0)) NPPN,sum(COALESCE(B.NNET,0)) NNet,

        sum(COALESCE(B.SUBTOTALRp,0)) SubtotalRp, sum(COALESCE(B.NDPPRp,0)) NDPPRP, 

        sum(COALESCE(B.NPPNRp,0)) NPPNRP, sum(COALESCE(B.NNETRp,0)) NNETRP

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP

		Order by B.NoBukti,A.Tanggal



Else If @Choice='B'

select 	B.KodeBrg,C.NAMABRG,A.Tanggal,sum(COALESCE(B.PPN,0))PPN,sum(COALESCE(B.DISC,0))Disc, 

		sum(COALESCE(B.KURS,0))Kurs, sum(COALESCE(B.QNT,0)) QNT, sum(COALESCE(B.QNT2,0))QNT2, 

		sum(COALESCE(B.NetW,0)) NetW,sum(COALESCE(B.GrossW,0))GrossW,

        sum(COALESCE(B.DiscP,0)) DiscP,sum(COALESCE(B.DiscRp,0)) DiscRp,sum(COALESCE(B.DISCTOT,0))Disctot, 

        sum(COALESCE(B.HRGNETTO,0)) HrgNetto, sum(COALESCE(B.NDISKON,0)) NDiskon, 

        sum(COALESCE(B.SUBTOTAL,0)) SubTotal, sum(COALESCE(B.NDPP,0)) NDPP,

        sum(COALESCE(B.NPPN,0)) NPPN,sum(COALESCE(B.NNET,0)) NNet,

        sum(COALESCE(B.SUBTOTALRp,0)) SubtotalRp, sum(COALESCE(B.NDPPRp,0)) NDPPRP, 

        sum(COALESCE(B.NPPNRp,0)) NPPNRP, sum(COALESCE(B.NNETRp,0)) NNETRP

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		Group By B.KodeBrg,C.NAMABRG,A.Tanggal

		order By B.KodeBrg,C.NAMABRG,A.Tanggal



Else If @Choice='C'

select 	A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal,sum(COALESCE(B.PPN,0))PPN,sum(COALESCE(B.DISC,0))Disc, 

		sum(COALESCE(B.KURS,0))Kurs, sum(COALESCE(B.QNT,0)) QNT, sum(COALESCE(B.QNT2,0))QNT2, 

		sum(COALESCE(B.NetW,0)) NetW,sum(COALESCE(B.GrossW,0))GrossW,

        sum(COALESCE(B.DiscP,0)) DiscP,sum(COALESCE(B.DiscRp,0)) DiscRp,sum(COALESCE(B.DISCTOT,0))Disctot, 

        sum(COALESCE(B.HRGNETTO,0)) HrgNetto, sum(COALESCE(B.NDISKON,0)) NDiskon, 

        sum(COALESCE(B.SUBTOTAL,0)) SubTotal, sum(COALESCE(B.NDPP,0)) NDPP,

        sum(COALESCE(B.NPPN,0)) NPPN,sum(COALESCE(B.NNET,0)) NNet,

        sum(COALESCE(B.SUBTOTALRp,0)) SubtotalRp, sum(COALESCE(B.NDPPRp,0)) NDPPRP, 

        sum(COALESCE(B.NPPNRp,0)) NPPNRP, sum(COALESCE(B.NNETRp,0)) NNETRP

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		Group By A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal

		order By A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal;

-- Sp_ReportPNWDet
CREATE PROCEDURE IF NOT EXISTS Sp_ReportPNWDet AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 



if @Id =''

if @SReport='T'

If @Ordr='N'

		if @isiList=''

			exec('select ''Gabungan'' Perusahaan,* from VwReportPNW where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

			order by Tanggal,NoBukti')

		 else

			exec('select ''Gabungan'' Perusahaan,* from VwReportPNW where NoBukti IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

			order by Tanggal,NoBukti')

		 

	else If @Ordr='B'

		if @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwReportPNW where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  order by KodeBrg')

		  else

		   exec('select ''Gabungan'' Perusahaan,* from VwReportPNW where Kodebrg IN'+@isiList+ ' and ( Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		  order by KodeBrg')


	else If @Ordr='C'

		if @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwReportPNW where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  order by KODECUSTSUPP ')

		  else

		  exec('select * from VwReportPNW where KODECUSTSUPP IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  

		  order by KODECUSTSUPP')

		  

	else If @Ordr='s'

		if @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwReportPNW where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  order by Tanggal,KodeSls,Urut,Marketing ')

		  else

		  exec('select ''Gabungan'' Perusahaan,* from VwReportPNW where KodeSls IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  

		  order by Tanggal,KodeSls,Urut')


else

if @SReport='T'

If @Ordr='N'

		if @isiList=''

			exec('select case when '''+@ID+'''=''BCA'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportPNW where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

			and '''+@ID+'''=Case When Len('''+@ID+''')=3 Then Left(NoBukti,3) else Left(NoBukti,2)

			order by Tanggal,NoBukti')

		 else

			exec('select case when '''+@ID+'''=''BCA'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportPNW where NoBukti IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

			and '''+@ID+'''=Case When Len('''+@ID+''')=3 Then Left(NoBukti,3) else Left(NoBukti,2)

			order by Tanggal,NoBukti')

		 

	else If @Ordr='B'

		if @isiList=''

		  exec('select case when '''+@ID+'''=''BCA'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportPNW where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and '''+@ID+'''=Case When Len('''+@ID+''')=3 Then Left(NoBukti,3) else Left(NoBukti,2)

		  order by KodeBrg')

		  else

		   exec('select case when '''+@ID+'''=''BCA'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportPNW where Kodebrg IN'+@isiList+ ' and ( Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		  and '''+@ID+'''=Case When Len('''+@ID+''')=3 Then Left(NoBukti,3) else Left(NoBukti,2)

		  order by KodeBrg')


	else If @Ordr='C'

		if @isiList=''

		  exec('select case when '''+@ID+'''=''BCA'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportPNW where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and '''+@ID+'''=Case When Len('''+@ID+''')=3 Then Left(NoBukti,3) else Left(NoBukti,2)

		  order by KODECUSTSUPP ')

		  else

		  exec('select case when '''+@ID+'''=''BCA'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportPNW where KODECUSTSUPP IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  

		  and '''+@ID+'''=Case When Len('''+@ID+''')=3 Then Left(NoBukti,3) else Left(NoBukti,2)

		  order by KODECUSTSUPP')

		  

	else If @Ordr='s'

		if @isiList=''

		  exec('select case when '''+@ID+'''=''BCA'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportPNW where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and '''+@ID+'''=Case When Len('''+@ID+''')=3 Then Left(NoBukti,3) else Left(NoBukti,2)

		  order by Tanggal,KodeSls,Urut,Marketing ')

		  else

		  exec('select case when '''+@ID+'''=''BCA'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportPNW where KodeSls IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  

		  and '''+@ID+'''=Case When Len('''+@ID+''')=3 Then Left(NoBukti,3) else Left(NoBukti,2)

		  order by Tanggal,KodeSls,Urut');

-- Sp_reportPNWRek
CREATE PROCEDURE IF NOT EXISTS Sp_reportPNWRek AS ---- DECLARE REMOVED,@tgl1 Datetime,@Tgl2 DateTime

--select @Choice='B',@Tgl1='10/10/2011',@tgl2='01/29/2012'



if @Id =''

IF @Choice='N'

Select 	'Gabungan' Perusahaan,A.NoBukti,A.tanggal, A.KodeCust,Case When A.KODECUST='-' Then A.INSBrg else I.NAMACUSTSUPP  NAMACUSTSUPP,a.KODEVLS,a.KURS,a.KODESLS,C.Nama,

        SUM(COALESCE(b.ndpp,0)) nDPP, Sum(COALESCE(B.NDPPRp,0)) NDPPRp,

        Sum(COALESCE(B.NPPNRp,0)) NPPNRP, Sum(COALESCE(B.NNETRp,0)) NnetRp     

	From DBPNW A

	Left Outer join DBPNWDET B on B.NoBukti=a.NoBukti

	Left Outer join DbCustSupp I on A.KodeCust=I.KodeCustSupp

	Left outer Join dbKaryawan C on c.KeyNIK=a.kodesls

	Where a.Tanggal between @tgl1 and @tgl2 

	Group By A.NoBukti,A.tanggal,a.KODECUST,i.NAMACUSTSUPP,a.KODEVLS,a.KURS,a.KODESLS,c.Nama,A.INSBrg

	Order By A.NoBukti,A.tanggal



else if @Choice ='C'

Select 	'Gabungan' Perusahaan,A.NoBukti,A.tanggal, A.KodeCust,Case When A.KODECUST='-' Then A.INSBrg else I.NAMACUSTSUPP  NAMACUSTSUPP,a.KODEVLS,a.KURS,a.KODESLS,C.Nama,

        SUM(COALESCE(b.ndpp,0)) nDPP, Sum(COALESCE(B.NDPPRp,0)) NDPPRp,

        Sum(COALESCE(B.NPPNRp,0)) NPPNRP, Sum(COALESCE(B.NNETRp,0)) NnetRp

	From DBPNW A

	Left Outer join DBPNWDet B on B.NoBukti=a.NoBukti

	Left Outer join DbCustSupp I on A.KodeCust=I.KodeCustSupp

	Left outer Join dbKaryawan C on c.KeyNIK=a.kodesls

	Where a.Tanggal between @tgl1 and @tgl2 

	Group By a.KODECUST,A.tanggal,A.NoBukti,i.NAMACUSTSUPP,a.KODEVLS,a.KURS,a.KODESLS,c.Nama,A.INSBrg

	Order By I.NamaCustSupp,A.NOBUKTI



else if @Choice='B'

Select 'Gabungan' Perusahaan,B.KODEBRG,A.TANGGAL,Case When A.KODECUST='-' Then A.INSBrg else I.NAMACUSTSUPP  NAMACUSTSUPP,h.namabrg,sum(COALESCE(b.QNT,0)) Qnt,sum(COALESCE(b.QNT2,0)) qnt2,h.SAT1,h.SAT2,

        SUM(COALESCE(b.ndpp,0)) nDPP, Sum(COALESCE(B.NDPPRp,0)) NDPPRp,

        Sum(COALESCE(B.NPPNRp,0)) NPPNRP, Sum(COALESCE(B.NNETRp,0)) NnetRp

	From DBPNW A

	Left Outer join DBPNWDet B on B.NoBukti=a.NoBukti

	Left Outer join DbCustSupp I on A.KodeCust=I.KodeCustSupp

	Left outer join DBBARANG H on H.KODEBRG=b.KODEBRG

	Where a.Tanggal between @tgl1 and @tgl2

	Group By B.kodeBrg,H.namaBrg,h.SAT1,h.SAT2,A.TANGGAL,A.INSBrg,A.KODECUST,I.NAMACUSTSUPP

	Order By B.kodeBrg



else if @Choice='S'

Select 'Gabungan' Perusahaan,A.KodeSLS,A.TANGGAL,Ky.Nama Marketing,Case When A.KODECUST='-' Then A.INSBrg else I.NAMACUSTSUPP  NAMACUSTSUPP,h.namabrg,sum(COALESCE(b.QNT,0)) Qnt,sum(COALESCE(b.QNT2,0)) qnt2,h.SAT1,h.SAT2,

        SUM(COALESCE(b.ndpp,0)) nDPP, Sum(COALESCE(B.NDPPRp,0)) NDPPRp,

        Sum(COALESCE(B.NPPNRp,0)) NPPNRP, Sum(COALESCE(B.NNETRp,0)) NnetRp

	From DBPNW A

	Left Outer join DBPNWDet B on B.NoBukti=a.NoBukti

	Left Outer join DbCustSupp I on A.KodeCust=I.KodeCustSupp

	Left Outer Join dbKaryawan Ky on Ky.NIK=A.KODESLS

	Left outer join DBBARANG H on H.KODEBRG=b.KODEBRG

	Where a.Tanggal between @tgl1 and @tgl2

	Group By A.KodeSLS,A.TANGGAL,Ky.Nama,h.SAT1,h.SAT2,A.INSBrg,A.KODECUST,I.NAMACUSTSUPP,h.NamaBrg

	Order By A.KODESLS


else----------

IF @Choice='N'

Select 	Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,A.NoBukti,A.tanggal, A.KodeCust,Case When A.KODECUST='-' Then A.INSBrg else I.NAMACUSTSUPP  NAMACUSTSUPP,a.KODEVLS,a.KURS,a.KODESLS,C.Nama,

        SUM(COALESCE(b.ndpp,0)) nDPP, Sum(COALESCE(B.NDPPRp,0)) NDPPRp,

        Sum(COALESCE(B.NPPNRp,0)) NPPNRP, Sum(COALESCE(B.NNETRp,0)) NnetRp     

	From DBPNW A

	Left Outer join DBPNWDET B on B.NoBukti=a.NoBukti

	Left Outer join DbCustSupp I on A.KodeCust=I.KodeCustSupp

	Left outer Join dbKaryawan C on c.KeyNIK=a.kodesls

	Where a.Tanggal between @tgl1 and @tgl2 

	and @Id=Case When Len(@ID)=3 Then Left(a.NoBukti,3) else Left(a.NOBUKTI,2)

	Group By A.NoBukti,A.tanggal,a.KODECUST,i.NAMACUSTSUPP,a.KODEVLS,a.KURS,a.KODESLS,c.Nama,A.INSBrg

	Order By A.NoBukti,A.tanggal



else if @Choice ='C'

Select Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,	A.NoBukti,A.tanggal, A.KodeCust,Case When A.KODECUST='-' Then A.INSBrg else I.NAMACUSTSUPP  NAMACUSTSUPP,a.KODEVLS,a.KURS,a.KODESLS,C.Nama,

        SUM(COALESCE(b.ndpp,0)) nDPP, Sum(COALESCE(B.NDPPRp,0)) NDPPRp,

        Sum(COALESCE(B.NPPNRp,0)) NPPNRP, Sum(COALESCE(B.NNETRp,0)) NnetRp

	From DBPNW A

	Left Outer join DBPNWDet B on B.NoBukti=a.NoBukti

	Left Outer join DbCustSupp I on A.KodeCust=I.KodeCustSupp

	Left outer Join dbKaryawan C on c.KeyNIK=a.kodesls

	Where a.Tanggal between @tgl1 and @tgl2 

	and @Id=Case When Len(@ID)=3 Then Left(a.NoBukti,3) else Left(a.NOBUKTI,2)

	Group By a.KODECUST,A.tanggal,A.NoBukti,i.NAMACUSTSUPP,a.KODEVLS,a.KURS,a.KODESLS,c.Nama,A.INSBrg

	Order By I.NamaCustSupp,A.NOBUKTI



else if @Choice='B'

Select Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,B.KODEBRG,A.TANGGAL,Case When A.KODECUST='-' Then A.INSBrg else I.NAMACUSTSUPP  NAMACUSTSUPP,h.namabrg,sum(COALESCE(b.QNT,0)) Qnt,sum(COALESCE(b.QNT2,0)) qnt2,h.SAT1,h.SAT2,

        SUM(COALESCE(b.ndpp,0)) nDPP, Sum(COALESCE(B.NDPPRp,0)) NDPPRp,

        Sum(COALESCE(B.NPPNRp,0)) NPPNRP, Sum(COALESCE(B.NNETRp,0)) NnetRp

	From DBPNW A

	Left Outer join DBPNWDet B on B.NoBukti=a.NoBukti

	Left Outer join DbCustSupp I on A.KodeCust=I.KodeCustSupp

	Left outer join DBBARANG H on H.KODEBRG=b.KODEBRG

	Where a.Tanggal between @tgl1 and @tgl2

	and @Id=Case When Len(@ID)=3 Then Left(a.NoBukti,3) else Left(a.NOBUKTI,2)

	Group By B.kodeBrg,H.namaBrg,h.SAT1,h.SAT2,A.TANGGAL,A.INSBrg,A.KODECUST,I.NAMACUSTSUPP

	Order By B.kodeBrg



else if @Choice='S'

Select Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,A.KodeSLS,A.TANGGAL,Ky.Nama Marketing,Case When A.KODECUST='-' Then A.INSBrg else I.NAMACUSTSUPP  NAMACUSTSUPP,h.namabrg,sum(COALESCE(b.QNT,0)) Qnt,sum(COALESCE(b.QNT2,0)) qnt2,h.SAT1,h.SAT2,

        SUM(COALESCE(b.ndpp,0)) nDPP, Sum(COALESCE(B.NDPPRp,0)) NDPPRp,

        Sum(COALESCE(B.NPPNRp,0)) NPPNRP, Sum(COALESCE(B.NNETRp,0)) NnetRp

	From DBPNW A

	Left Outer join DBPNWDet B on B.NoBukti=a.NoBukti

	Left Outer join DbCustSupp I on A.KodeCust=I.KodeCustSupp

	Left Outer Join dbKaryawan Ky on Ky.NIK=A.KODESLS

	Left outer join DBBARANG H on H.KODEBRG=b.KODEBRG

	Where a.Tanggal between @tgl1 and @tgl2

	and @Id=Case When Len(@ID)=3 Then Left(a.NoBukti,3) else Left(a.NOBUKTI,2)

	Group By A.KodeSLS,A.TANGGAL,Ky.Nama,h.SAT1,h.SAT2,A.INSBrg,A.KODECUST,I.NAMACUSTSUPP,h.NamaBrg

	Order By A.KODESLS;

-- Sp_ReportPODet
CREATE PROCEDURE IF NOT EXISTS Sp_ReportPODet AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 

-- DECLARE REMOVED (10)

select @Devisi=Devisi from dbDevisi where NamaDevisi=@ID

if @Id=''

if @SReport='T'

if @IsCustome=0

If @Ordr='N'

		if @NeedOto=0 or @NeedOto=1

		      select 'Gabungan' Perusahaan,* from VwreportPO where Tanggal between @tgl1 and @tgl2 and NeedOtorisasi=@NeedOto

		      and NoBukti in(select KodeInputan from TempCustomizeReport where IDUser=@IDUser)

		      order by NoBukti,Tanggal

		   if @NeedOto=2

			  select 'Gabungan' Perusahaan,* from VwreportPO where Tanggal between @tgl1 and @tgl2 

		       and NoBukti in(select KodeInputan from TempCustomizeReport where IDUser=@IDUser)

		      order by NoBukti,Tanggal

		 

	else If @Ordr='B'

		if @NeedOto=0 or @NeedOto=1

			  select 'Gabungan' Perusahaan,* from VwreportPO where Tanggal between @tgl1 and @tgl2 and NeedOtorisasi=@NeedOto

			   and KodeBrg in(select KodeInputan from TempCustomizeReport where IDUser=@IDUser)

			  order by KodeBrg

		  if @NeedOto=2

			  select 'Gabungan' Perusahaan,* from VwreportPO where Tanggal between @tgl1 and @tgl2 

			   and KodeBrg in(select KodeInputan from TempCustomizeReport where IDUser=@IDUser)

			  order by KodeBrg

		 

	else If @Ordr='S'

		if @NeedOto=0 or @NeedOto=1

			 select 'Gabungan' Perusahaan,* from VwreportPO where Tanggal between @tgl1 and @tgl2 and NeedOtorisasi=@NeedOto

			  and KodeCustSupp in(select KodeInputan from TempCustomizeReport where IDUser=@IDUser)

			 order by KodeCustSupp

		  if @NeedOto=2

			 select 'Gabungan' Perusahaan,* from VwreportPO where Tanggal between @tgl1 and @tgl2 

			   and KodeCustSupp in(select KodeInputan from TempCustomizeReport where IDUser=@IDUser)

			 order by KodeCustSupp


else

If @Ordr='N'

		if @NeedOto=0 or @NeedOto=1

		      select 'Gabungan' Perusahaan,* from VwreportPO where Tanggal between @tgl1 and @tgl2 and NeedOtorisasi=@NeedOto

		      order by NoBukti,Tanggal

		   if @NeedOto=2

			  select 'Gabungan' Perusahaan,* from VwreportPO where Tanggal between @tgl1 and @tgl2 

		      order by NoBukti,Tanggal

		 

	else If @Ordr='B'

		if @NeedOto=0 or @NeedOto=1

			  select 'Gabungan' Perusahaan,* from VwreportPO where Tanggal between @tgl1 and @tgl2 and NeedOtorisasi=@NeedOto

			  order by KodeBrg

		  if @NeedOto=2

			  select 'Gabungan' Perusahaan,* from VwreportPO where Tanggal between @tgl1 and @tgl2 

			  order by KodeBrg

		 

	else If @Ordr='S'

		if @NeedOto=0 or @NeedOto=1

			 select 'Gabungan' Perusahaan,* from VwreportPO where Tanggal between @tgl1 and @tgl2 and NeedOtorisasi=@NeedOto

			 order by KodeCustSupp

		  if @NeedOto=2

			 select 'Gabungan' Perusahaan,* from VwreportPO where Tanggal between @tgl1 and @tgl2 

			 order by KodeCustSupp


else

if @SReport='T'

if @IsCustome=0

If @Ordr='N'

		if @NeedOto=0 or @NeedOto=1

		      select Case When Devisi<>'02' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwreportPO where Tanggal between @tgl1 and @tgl2 and NeedOtorisasi=@NeedOto

		      and Devisi=@Devisi

		      and NoBukti in(select KodeInputan from TempCustomizeReport where IDUser=@IDUser)

		      order by NoBukti,Tanggal

		   if @NeedOto=2

			  select * from VwreportPO where Tanggal between @tgl1 and @tgl2 

			  and Devisi=@Devisi

			  and NoBukti in(select KodeInputan from TempCustomizeReport where IDUser=@IDUser)

		      order by NoBukti,Tanggal

		 

	else If @Ordr='B'

		if @NeedOto=0 or @NeedOto=1

			  select Case When Devisi<>'02' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwreportPO where Tanggal between @tgl1 and @tgl2 and NeedOtorisasi=@NeedOto

			   and Devisi=@Devisi

			   and KodeBrg in(select KodeInputan from TempCustomizeReport where IDUser=@IDUser)

			  order by KodeBrg

		  if @NeedOto=2

			  select Case When Devisi<>'02' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwreportPO where Tanggal between @tgl1 and @tgl2 

			   and Devisi=@Devisi

			   and KodeBrg in(select KodeInputan from TempCustomizeReport where IDUser=@IDUser)

			  order by KodeBrg

		 

	else If @Ordr='S'

		if @NeedOto=0 or @NeedOto=1

			 select Case When Devisi<>'02' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwreportPO where Tanggal between @tgl1 and @tgl2 and NeedOtorisasi=@NeedOto

			  and Devisi=@Devisi

			    and KodeCustSupp in(select KodeInputan from TempCustomizeReport where IDUser=@IDUser)

			 order by KodeCustSupp

		  if @NeedOto=2

			 select Case When Devisi<>'02' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwreportPO where Tanggal between @tgl1 and @tgl2 

			  and Devisi=@Devisi

			  	    and KodeCustSupp in(select KodeInputan from TempCustomizeReport where IDUser=@IDUser)

			 order by KodeCustSupp


else

If @Ordr='N'

		if @NeedOto=0 or @NeedOto=1

		      select Case When Devisi<>'02' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwreportPO where Tanggal between @tgl1 and @tgl2 and NeedOtorisasi=@NeedOto

		      and Devisi=@Devisi

		      order by NoBukti,Tanggal

		   if @NeedOto=2

			  select * from VwreportPO where Tanggal between @tgl1 and @tgl2 

			  and Devisi=@Devisi

		      order by NoBukti,Tanggal

		 

	else If @Ordr='B'

		if @NeedOto=0 or @NeedOto=1

			  select Case When Devisi<>'02' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwreportPO where Tanggal between @tgl1 and @tgl2 and NeedOtorisasi=@NeedOto

			   and Devisi=@Devisi

			  order by KodeBrg

		  if @NeedOto=2

			  select Case When Devisi<>'02' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwreportPO where Tanggal between @tgl1 and @tgl2 

			   and Devisi=@Devisi

			  order by KodeBrg

		 

	else If @Ordr='S'

		if @NeedOto=0 or @NeedOto=1

			 select Case When Devisi<>'02' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwreportPO where Tanggal between @tgl1 and @tgl2 and NeedOtorisasi=@NeedOto

			  and Devisi=@Devisi

			 order by KodeCustSupp

		  if @NeedOto=2

			 select Case When Devisi<>'02' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwreportPO where Tanggal between @tgl1 and @tgl2 

			  and Devisi=@Devisi

			 order by KodeCustSupp;

-- Sp_ReportPORek
CREATE PROCEDURE IF NOT EXISTS Sp_ReportPORek AS ---- DECLARE REMOVED,@Tgl1 Datetime,@tgl2 datetime

--select @Tgl1='01/01/2012',@tgl2='07/17/2013',@Choice='f'



if @Id=''

If @Choice='N'

if @NeedOto=0 or @NeedOto=1

        Select 	'Gabungan' Perusahaan,I.NoBukti,I.TANGGAL,I.KODESUPP KodeCustSupp,J.NAMACUSTSUPP,I.KODEVLS,i.KURS,

        sum(COALESCE(K.NDPP*i.KURS,0)) NDPP,Sum (COALESCE(K.NPPN*I.kurs,0)) NPPN,Sum(COALESCE(K.NNET*I.kurs,0)) TotalIDR,

        Sum(case when i.kurs=1 then 0 else k.disctot ) as disctotusd,

        Sum(case when i.kurs=1 then 0 else k.ndpp ) as Ndppusd,

        Sum(case when i.kurs=1 then 0 else k.nppn ) as NPPNusd,

        Sum(case when i.kurs=1 then 0 else k.subtotal ) as totalusd

        From  dbPO I 

		Left Outer Join DBCUSTSUPP J on I.KODESUPP = J.KODECUSTSUPP 

		Left Outer Join DBPODET K on I.NOBUKTI= K.NOBUKTI

		where I.TANGGAL between @tgl1 and @tgl2 and 

		Cast(Case when Case when I.IsOtorisasi1=1 then 1 else 0 +

                      Case when I.IsOtorisasi2=1 then 1 else 0 +

                      Case when I.IsOtorisasi3=1 then 1 else 0 +

                      Case when I.IsOtorisasi4=1 then 1 else 0 +

                      Case when I.IsOtorisasi5=1 then 1 else 0 =I.MaxOL then 0

                 else 1

             As INTEGER) =@NeedOto

       Group By I.NoBukti,I.TANGGAL,I.KODESUPP ,J.NAMACUSTSUPP,I.KODEVLS,i.KURS

	   order by  I.NOBUKTI,I.TANGGAL

	if @NeedOto=2 

        Select 	'Gabungan' Perusahaan,I.NoBukti,I.TANGGAL,I.KODESUPP KodeCustSupp,J.NAMACUSTSUPP,I.KODEVLS,i.KURS,

        sum(COALESCE(K.NDPP*i.KURS,0)) NDPP,Sum (COALESCE(K.NPPN*I.kurs,0)) NPPN,Sum(COALESCE(K.NNET*I.kurs,0)) TotalIDR,

        Sum(case when i.kurs=1 then 0 else k.disctot ) as disctotusd,

        Sum(case when i.kurs=1 then 0 else k.ndpp ) as Ndppusd,

        Sum(case when i.kurs=1 then 0 else k.nppn ) as NPPNusd,

        Sum(case when i.kurs=1 then 0 else k.subtotal ) as totalusd

        From  dbPO I 

		Left Outer Join DBCUSTSUPP J on I.KODESUPP = J.KODECUSTSUPP 

		Left Outer Join DBPODET K on I.NOBUKTI= K.NOBUKTI

		where I.TANGGAL between @tgl1 and @tgl2 

		Group By I.NoBukti,I.TANGGAL,I.KODESUPP ,J.NAMACUSTSUPP,I.KODEVLS,i.KURS

		order by  I.NOBUKTI,I.TANGGAL 		



If @choice='S'

if @NeedOto=0 or @NeedOto=1

		Select 	'Gabungan' Perusahaan,I.NoBukti,I.TANGGAL,I.KODESUPP KodeCustSupp,J.NAMACUSTSUPP,i.KODEVLS,i.KURS,

        sum(COALESCE(K.NDPP*i.KURS,0)) NDPP,Sum (COALESCE(K.NPPN*I.kurs,0)) NPPN,Sum(COALESCE(K.NNET*I.kurs,0)) TotalIDR,

        Sum(case when i.kurs=1 then 0 else k.disctot ) as disctotusd,

        Sum(case when i.kurs=1 then 0 else k.ndpp ) as Ndppusd,

        Sum(case when i.kurs=1 then 0 else k.nppn ) as NPPNusd,

        Sum(case when i.kurs=1 then 0 else k.subtotal ) as totalusd

        From  dbPO I 

		Left Outer Join DBCUSTSUPP J on I.KODESUPP = J.KODECUSTSUPP 

		Left Outer Join DBPODET K on I.NOBUKTI= K.NOBUKTI

		where I.TANGGAL between @tgl1 and @tgl2  and 

		Cast(Case when Case when I.IsOtorisasi1=1 then 1 else 0 +

                      Case when I.IsOtorisasi2=1 then 1 else 0 +

                      Case when I.IsOtorisasi3=1 then 1 else 0 +

                      Case when I.IsOtorisasi4=1 then 1 else 0 +

                      Case when I.IsOtorisasi5=1 then 1 else 0 =I.MaxOL then 0

                 else 1

             As INTEGER) =@NeedOto

        Group By I.NoBukti,I.TANGGAL,I.KODESUPP ,J.NAMACUSTSUPP,I.KODEVLS,i.KURS

		order by  J.NAMACUSTSUPP,i.kodesupp,I.NOBUKTI

	if @NeedOto=2

		Select 	'Gabungan' Perusahaan,I.NoBukti,I.TANGGAL,I.KODESUPP KodeCustSupp,J.NAMACUSTSUPP,i.KODEVLS,i.KURS,

        sum(COALESCE(K.NDPP*i.KURS,0)) NDPP,Sum (COALESCE(K.NPPN*I.kurs,0)) NPPN,Sum(COALESCE(K.NNET*I.kurs,0)) TotalIDR,

        Sum(case when i.kurs=1 then 0 else k.disctot ) as disctotusd,

        Sum(case when i.kurs=1 then 0 else k.ndpp ) as Ndppusd,

        Sum(case when i.kurs=1 then 0 else k.nppn ) as NPPNusd,

        Sum(case when i.kurs=1 then 0 else k.subtotal ) as totalusd

        From  dbPO I 

		Left Outer Join DBCUSTSUPP J on I.KODESUPP = J.KODECUSTSUPP 

		Left Outer Join DBPODET K on I.NOBUKTI= K.NOBUKTI

		where I.TANGGAL between @tgl1 and @tgl2  

		Group By I.NoBukti,I.TANGGAL,I.KODESUPP ,J.NAMACUSTSUPP,I.KODEVLS,i.KURS

		order by  J.NAMACUSTSUPP,i.kodesupp,I.NOBUKTI


else if @Choice ='B'

if @NeedOto=0 or @NeedOto=1

		Select 	'Gabungan' Perusahaan,B.KodeBrg, H.NamaBrg,sum(B.Qnt*B.isi) qnt,

        sum((B.NDISKON+B.DISCTOT)*i.kurs) Disctotal,

        sum((B.NDPP+B.NPPN)*i.kurs) TotalIDR, 

        sum(B.NDPP*i.kurs) NDPP,

        sum(B.NPPN*i.kurs) NPPN, 

        case when i.kurs=1 then 0 else sum(b.disctot)  as disctotusd,

        case when i.kurs=1 then 0 else sum(b.ndpp)  as Ndppusd,

        case when i.kurs=1 then 0 else sum(b.nppn)  as NPPNusd,

        case when i.kurs=1 then 0 else sum(b.subtotal)  as totalusd,

        I.kurs,I.KODEVLS

        From  dbPODet B 

        Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg

		Left Outer join DBPO I on B.NOBUKTI = I.NOBUKTI

		Left Outer Join DBCUSTSUPP J on I.KODESUPP = J.KODECUSTSUPP 

		where I.TANGGAL between @tgl1 and @tgl2 and 

		Cast(Case when Case when I.IsOtorisasi1=1 then 1 else 0 +

                      Case when I.IsOtorisasi2=1 then 1 else 0 +

                      Case when I.IsOtorisasi3=1 then 1 else 0 +

                      Case when I.IsOtorisasi4=1 then 1 else 0 +

                      Case when I.IsOtorisasi5=1 then 1 else 0 =I.MaxOL then 0

                 else 1

             As INTEGER) =@NeedOto

		Group by  B.KodeBrg, H.NamaBrg,i.kurs,i.KODEVLS

		order by B.KodeBrg, H.NamaBrg

	if @NeedOto=2

		Select 	'Gabungan' Perusahaan,B.KodeBrg, H.NamaBrg,sum(B.Qnt*B.isi) qnt,

        sum((B.NDISKON+B.DISCTOT)*i.kurs) Disctotal,

        sum((B.NDPP+B.NPPN)*i.kurs) TotalIDR, 

        sum(B.NDPP*i.kurs) NDPP,

        sum(B.NPPN*i.kurs) NPPN, 

        case when i.kurs=1 then 0 else sum(b.disctot)  as disctotusd,

        case when i.kurs=1 then 0 else sum(b.ndpp)  as Ndppusd,

        case when i.kurs=1 then 0 else sum(b.nppn)  as NPPNusd,

        case when i.kurs=1 then 0 else sum(b.subtotal)  as totalusd,

        I.kurs,I.KODEVLS

        From  dbPODet B 

        Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg

		Left Outer join DBPO I on B.NOBUKTI = I.NOBUKTI

		Left Outer Join DBCUSTSUPP J on I.KODESUPP = J.KODECUSTSUPP 

		where I.TANGGAL between @tgl1 and @tgl2

		Group by  B.KodeBrg, H.NamaBrg,i.kurs,i.KODEVLS

		order by B.KodeBrg, H.NamaBrg



-----------

else

If @Choice='N'

if @NeedOto=0 or @NeedOto=1

        Select 	Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,I.NoBukti,I.TANGGAL,I.KODESUPP KodeCustSupp,J.NAMACUSTSUPP,I.KODEVLS,i.KURS,

        sum(COALESCE(K.NDPP*i.KURS,0)) NDPP,Sum (COALESCE(K.NPPN*I.kurs,0)) NPPN,Sum(COALESCE(K.NNET*I.kurs,0)) TotalIDR,

        Sum(case when i.kurs=1 then 0 else k.disctot ) as disctotusd,

        Sum(case when i.kurs=1 then 0 else k.ndpp ) as Ndppusd,

        Sum(case when i.kurs=1 then 0 else k.nppn ) as NPPNusd,

        Sum(case when i.kurs=1 then 0 else k.subtotal ) as totalusd

        From  dbPO I 

		Left Outer Join DBCUSTSUPP J on I.KODESUPP = J.KODECUSTSUPP 

		Left Outer Join DBPODET K on I.NOBUKTI= K.NOBUKTI

		where I.TANGGAL between @tgl1 and @tgl2 and 

		Cast(Case when Case when I.IsOtorisasi1=1 then 1 else 0 +

                      Case when I.IsOtorisasi2=1 then 1 else 0 +

                      Case when I.IsOtorisasi3=1 then 1 else 0 +

                      Case when I.IsOtorisasi4=1 then 1 else 0 +

                      Case when I.IsOtorisasi5=1 then 1 else 0 =I.MaxOL then 0

                 else 1

             As INTEGER) =@NeedOto

       and @Id=Case When Len(@ID)=3 Then Left(I.NoBukti,3) else Left(I.NOBUKTI,2)     

       Group By I.NoBukti,I.TANGGAL,I.KODESUPP ,J.NAMACUSTSUPP,I.KODEVLS,i.KURS

	   order by  I.NOBUKTI,I.TANGGAL

	if @NeedOto=2 

        Select 	Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,I.NoBukti,I.TANGGAL,I.KODESUPP KodeCustSupp,J.NAMACUSTSUPP,I.KODEVLS,i.KURS,

        sum(COALESCE(K.NDPP*i.KURS,0)) NDPP,Sum (COALESCE(K.NPPN*I.kurs,0)) NPPN,Sum(COALESCE(K.NNET*I.kurs,0)) TotalIDR,

        Sum(case when i.kurs=1 then 0 else k.disctot ) as disctotusd,

        Sum(case when i.kurs=1 then 0 else k.ndpp ) as Ndppusd,

        Sum(case when i.kurs=1 then 0 else k.nppn ) as NPPNusd,

        Sum(case when i.kurs=1 then 0 else k.subtotal ) as totalusd

        From  dbPO I 

		Left Outer Join DBCUSTSUPP J on I.KODESUPP = J.KODECUSTSUPP 

		Left Outer Join DBPODET K on I.NOBUKTI= K.NOBUKTI

		where I.TANGGAL between @tgl1 and @tgl2 

		and @Id=Case When Len(@ID)=3 Then Left(I.NoBukti,3) else Left(I.NOBUKTI,2)    

		Group By I.NoBukti,I.TANGGAL,I.KODESUPP ,J.NAMACUSTSUPP,I.KODEVLS,i.KURS

		order by  I.NOBUKTI,I.TANGGAL 		



If @choice='S'

if @NeedOto=0 or @NeedOto=1

		Select 	Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,I.NoBukti,I.TANGGAL,I.KODESUPP KodeCustSupp,J.NAMACUSTSUPP,i.KODEVLS,i.KURS,

        sum(COALESCE(K.NDPP*i.KURS,0)) NDPP,Sum (COALESCE(K.NPPN*I.kurs,0)) NPPN,Sum(COALESCE(K.NNET*I.kurs,0)) TotalIDR,

        Sum(case when i.kurs=1 then 0 else k.disctot ) as disctotusd,

        Sum(case when i.kurs=1 then 0 else k.ndpp ) as Ndppusd,

        Sum(case when i.kurs=1 then 0 else k.nppn ) as NPPNusd,

        Sum(case when i.kurs=1 then 0 else k.subtotal ) as totalusd

        From  dbPO I 

		Left Outer Join DBCUSTSUPP J on I.KODESUPP = J.KODECUSTSUPP 

		Left Outer Join DBPODET K on I.NOBUKTI= K.NOBUKTI

		where I.TANGGAL between @tgl1 and @tgl2  and 

		Cast(Case when Case when I.IsOtorisasi1=1 then 1 else 0 +

                      Case when I.IsOtorisasi2=1 then 1 else 0 +

                      Case when I.IsOtorisasi3=1 then 1 else 0 +

                      Case when I.IsOtorisasi4=1 then 1 else 0 +

                      Case when I.IsOtorisasi5=1 then 1 else 0 =I.MaxOL then 0

                 else 1

             As INTEGER) =@NeedOto

        and @Id=Case When Len(@ID)=3 Then Left(I.NoBukti,3) else Left(I.NOBUKTI,2)        

        Group By I.NoBukti,I.TANGGAL,I.KODESUPP ,J.NAMACUSTSUPP,I.KODEVLS,i.KURS

		order by  J.NAMACUSTSUPP,i.kodesupp,I.NOBUKTI

	if @NeedOto=2

		Select Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,	I.NoBukti,I.TANGGAL,I.KODESUPP KodeCustSupp,J.NAMACUSTSUPP,i.KODEVLS,i.KURS,

        sum(COALESCE(K.NDPP*i.KURS,0)) NDPP,Sum (COALESCE(K.NPPN*I.kurs,0)) NPPN,Sum(COALESCE(K.NNET*I.kurs,0)) TotalIDR,

        Sum(case when i.kurs=1 then 0 else k.disctot ) as disctotusd,

        Sum(case when i.kurs=1 then 0 else k.ndpp ) as Ndppusd,

        Sum(case when i.kurs=1 then 0 else k.nppn ) as NPPNusd,

        Sum(case when i.kurs=1 then 0 else k.subtotal ) as totalusd

        From  dbPO I 

		Left Outer Join DBCUSTSUPP J on I.KODESUPP = J.KODECUSTSUPP 

		Left Outer Join DBPODET K on I.NOBUKTI= K.NOBUKTI

		where I.TANGGAL between @tgl1 and @tgl2  

		and @Id=Case When Len(@ID)=3 Then Left(I.NoBukti,3) else Left(I.NOBUKTI,2)    

		Group By I.NoBukti,I.TANGGAL,I.KODESUPP ,J.NAMACUSTSUPP,I.KODEVLS,i.KURS

		order by  J.NAMACUSTSUPP,i.kodesupp,I.NOBUKTI


else if @Choice ='B'

if @NeedOto=0 or @NeedOto=1

		Select 	Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,B.KodeBrg, H.NamaBrg,sum(B.Qnt*B.isi) qnt,

        sum((B.NDISKON+B.DISCTOT)*i.kurs) Disctotal,

        sum((B.NDPP+B.NPPN)*i.kurs) TotalIDR, 

        sum(B.NDPP*i.kurs) NDPP,

        sum(B.NPPN*i.kurs) NPPN, 

        case when i.kurs=1 then 0 else sum(b.disctot)  as disctotusd,

        case when i.kurs=1 then 0 else sum(b.ndpp)  as Ndppusd,

        case when i.kurs=1 then 0 else sum(b.nppn)  as NPPNusd,

        case when i.kurs=1 then 0 else sum(b.subtotal)  as totalusd,

        I.kurs,I.KODEVLS

        From  dbPODet B 

        Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg

		Left Outer join DBPO I on B.NOBUKTI = I.NOBUKTI

		Left Outer Join DBCUSTSUPP J on I.KODESUPP = J.KODECUSTSUPP 

		where I.TANGGAL between @tgl1 and @tgl2 and 

		Cast(Case when Case when I.IsOtorisasi1=1 then 1 else 0 +

                      Case when I.IsOtorisasi2=1 then 1 else 0 +

                      Case when I.IsOtorisasi3=1 then 1 else 0 +

                      Case when I.IsOtorisasi4=1 then 1 else 0 +

                      Case when I.IsOtorisasi5=1 then 1 else 0 =I.MaxOL then 0

                 else 1

             As INTEGER) =@NeedOto

            and @Id=Case When Len(@ID)=3 Then Left(I.NoBukti,3) else Left(I.NOBUKTI,2)    

		Group by  B.KodeBrg, H.NamaBrg,i.kurs,i.KODEVLS

		order by B.KodeBrg, H.NamaBrg

	if @NeedOto=2

		Select 	Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,B.KodeBrg, H.NamaBrg,sum(B.Qnt*B.isi) qnt,

        sum((B.NDISKON+B.DISCTOT)*i.kurs) Disctotal,

        sum((B.NDPP+B.NPPN)*i.kurs) TotalIDR, 

        sum(B.NDPP*i.kurs) NDPP,

        sum(B.NPPN*i.kurs) NPPN, 

        case when i.kurs=1 then 0 else sum(b.disctot)  as disctotusd,

        case when i.kurs=1 then 0 else sum(b.ndpp)  as Ndppusd,

        case when i.kurs=1 then 0 else sum(b.nppn)  as NPPNusd,

        case when i.kurs=1 then 0 else sum(b.subtotal)  as totalusd,

        I.kurs,I.KODEVLS

        From  dbPODet B 

        Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg

		Left Outer join DBPO I on B.NOBUKTI = I.NOBUKTI

		Left Outer Join DBCUSTSUPP J on I.KODESUPP = J.KODECUSTSUPP 

		where I.TANGGAL between @tgl1 and @tgl2

		and @Id=Case When Len(@ID)=3 Then Left(I.NoBukti,3) else Left(I.NOBUKTI,2)    

		Group by  B.KodeBrg, H.NamaBrg,i.kurs,i.KODEVLS

		order by B.KodeBrg, H.NamaBrg;

-- Sp_ReportPurchasingReqDet
CREATE PROCEDURE IF NOT EXISTS Sp_ReportPurchasingReqDet AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 

-- DECLARE REMOVED (10)

select @Devisi=Devisi from dbDevisi where NamaDevisi=@ID

if @Id='' 

if @SReport='T'

if @IsCustome=0

If @Ordr='N'

		if @NeedOto=0 or @NeedOto=1

				select 'Gabungan' Perusahaan,* from VwReportPurchasingReq where Tanggal between @tgl1 and @tgl2 and NeedOtorisasi=@NeedOto 

				and NoBukti in(select KodeInputan from TempCustomizeReport where IDUser=@IDUser)

				order by NoBukti,Tanggal

		  else if @NeedOto=2

				select 'Gabungan' Perusahaan,* from VwReportPurchasingReq where Tanggal between @tgl1 and @tgl2 

				and NoBukti in(select KodeInputan from TempCustomizeReport where IDUser=@IDUser)

				order by NoBukti,Tanggal

		 

	else If @Ordr='B'

		if @NeedOto=0 or @NeedOto=1

				select 'Gabungan' Perusahaan,* from VwReportPurchasingReq where Tanggal between @tgl1 and @tgl2 and NeedOtorisasi=@NeedOto

				and KodeBrg in(select KodeInputan from TempCustomizeReport where IDUser=@IDUser)

				order by KodeBrg

		  else if @NeedOto=2  

				select 'Gabungan' Perusahaan,* from VwReportPurchasingReq where Tanggal between @tgl1 and @tgl2 

				and KodeBrg in(select KodeInputan from TempCustomizeReport where IDUser=@IDUser)

				order by KodeBrg

		 

	else If @Ordr='S'

		if @NeedOto=0 or @NeedOto=1

				select 'Gabungan' Perusahaan,* from VwReportPurchasingReq where Tanggal between @tgl1 and @tgl2 and NeedOtorisasi=@NeedOto

				and KodeCustSupp in(select KodeInputan from TempCustomizeReport where IDUser=@IDUser)

				order by KodeCustSupp

		  else if @NeedOto=2

				select 'Gabungan' Perusahaan,* from VwReportPurchasingReq where Tanggal between @tgl1 and @tgl2 

				and KodeCustSupp in(select KodeInputan from TempCustomizeReport where IDUser=@IDUser)

				order by KodeCustSupp 


else

If @Ordr='N'

		if @NeedOto=0 or @NeedOto=1

				select 'Gabungan' Perusahaan,* from VwReportPurchasingReq where Tanggal between @tgl1 and @tgl2 and NeedOtorisasi=@NeedOto 

				

				order by NoBukti,Tanggal

		  else if @NeedOto=2

				select 'Gabungan' Perusahaan,* from VwReportPurchasingReq where Tanggal between @tgl1 and @tgl2 

				order by NoBukti,Tanggal

		 

	else If @Ordr='B'

		if @NeedOto=0 or @NeedOto=1

				select 'Gabungan' Perusahaan,* from VwReportPurchasingReq where Tanggal between @tgl1 and @tgl2 and NeedOtorisasi=@NeedOto

				order by KodeBrg

		  else if @NeedOto=2  

				select 'Gabungan' Perusahaan,* from VwReportPurchasingReq where Tanggal between @tgl1 and @tgl2 

				order by KodeBrg

		 

	else If @Ordr='S'

		if @NeedOto=0 or @NeedOto=1

				select 'Gabungan' Perusahaan,* from VwReportPurchasingReq where Tanggal between @tgl1 and @tgl2 and NeedOtorisasi=@NeedOto

				order by KodeCustSupp

		  else if @NeedOto=2

				select 'Gabungan' Perusahaan,* from VwReportPurchasingReq where Tanggal between @tgl1 and @tgl2 

				order by KodeCustSupp 


else

if @SReport='T'

if @IsCustome=0 

If @Ordr='N'

		if @NeedOto=0 or @NeedOto=1

				select Case When Devisi<>'02' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwReportPurchasingReq where Tanggal between @tgl1 and @tgl2 and NeedOtorisasi=@NeedOto 

				and Devisi=@Devisi

				and NoBukti in(select KodeInputan from TempCustomizeReport where IDUser=@IDUser)

				order by NoBukti,Tanggal

		  else if @NeedOto=2

				select Case When Devisi<>'02' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwReportPurchasingReq where Tanggal between @tgl1 and @tgl2 

				 and Devisi=@Devisi

				 and NoBukti in(select KodeInputan from TempCustomizeReport where IDUser=@IDUser)

				order by NoBukti,Tanggal

		 

	else If @Ordr='B'

		if @NeedOto=0 or @NeedOto=1

				select Case When Devisi<>'02' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwReportPurchasingReq where Tanggal between @tgl1 and @tgl2 and NeedOtorisasi=@NeedOto

				 and Devisi=@Devisi

				 and KodeBrg in(select KodeInputan from TempCustomizeReport where IDUser=@IDUser)

				order by KodeBrg

		  else if @NeedOto=2  

				select Case When Devisi<>'02' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwReportPurchasingReq where Tanggal between @tgl1 and @tgl2 

				 and Devisi=@Devisi

				 and KodeBrg in(select KodeInputan from TempCustomizeReport where IDUser=@IDUser)

				order by KodeBrg

		 

	else If @Ordr='S'

		if @NeedOto=0 or @NeedOto=1

				select Case When Devisi<>'02' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwReportPurchasingReq where Tanggal between @tgl1 and @tgl2 and NeedOtorisasi=@NeedOto

				 and Devisi=@Devisi

				 and KodeCustSupp in(select KodeInputan from TempCustomizeReport where IDUser=@IDUser)

				order by KodeCustSupp

		  else if @NeedOto=2

				select Case When Devisi<>'02' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwReportPurchasingReq where Tanggal between @tgl1 and @tgl2 

				 and Devisi=@Devisi

				  and KodeCustSupp in(select KodeInputan from TempCustomizeReport where IDUser=@IDUser)

				order by KodeCustSupp 


else

If @Ordr='N'

		if @NeedOto=0 or @NeedOto=1

				select Case When Devisi<>'02' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwReportPurchasingReq where Tanggal between @tgl1 and @tgl2 and NeedOtorisasi=@NeedOto 

				and Devisi=@Devisi

				order by NoBukti,Tanggal

		  else if @NeedOto=2

				select Case When Devisi<>'02' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwReportPurchasingReq where Tanggal between @tgl1 and @tgl2 

				 and Devisi=@Devisi

				order by NoBukti,Tanggal

		 

	else If @Ordr='B'

		if @NeedOto=0 or @NeedOto=1

				select Case When Devisi<>'02' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwReportPurchasingReq where Tanggal between @tgl1 and @tgl2 and NeedOtorisasi=@NeedOto

				 and Devisi=@Devisi

				order by KodeBrg

		  else if @NeedOto=2  

				select Case When Devisi<>'02' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwReportPurchasingReq where Tanggal between @tgl1 and @tgl2 

				 and Devisi=@Devisi

				order by KodeBrg

		 

	else If @Ordr='S'

		if @NeedOto=0 or @NeedOto=1

				select Case When Devisi<>'02' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwReportPurchasingReq where Tanggal between @tgl1 and @tgl2 and NeedOtorisasi=@NeedOto

				 and Devisi=@Devisi

				order by KodeCustSupp

		  else if @NeedOto=2

				select Case When Devisi<>'02' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwReportPurchasingReq where Tanggal between @tgl1 and @tgl2 

				 and Devisi=@Devisi

				order by KodeCustSupp;

-- Sp_reportRBeliGDGDet
CREATE PROCEDURE IF NOT EXISTS Sp_reportRBeliGDGDet AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 



if @Id=''

if @SReport='T'

If @Ordr='N'

		if @NeedOto=0 or @NeedOto=1

				select 'Gabungan' Perusahaan,* from VwReportRPembelianGDg where Tanggal between @tgl1 and @tgl2 and NeedOtorisasi=@NeedOto

				order by NoBukti,Tanggal

			if @NeedOto=2

				select 'Gabungan' Perusahaan,* from VwReportRPembelianGDg where Tanggal between @tgl1 and @tgl2 

				order by NoBukti,Tanggal	

		 

	else If @Ordr='B'

		if @NeedOto=0 or @NeedOto=1

				select 'Gabungan' Perusahaan,* from VwReportRPembelianGDg where Tanggal between @tgl1 and @tgl2 and NeedOtorisasi=@NeedOto

				order by KodeBrg

			if @NeedOto=2

				select * from VwReportRPembelianGDg where Tanggal between @tgl1 and @tgl2 

				order by KodeBrg

		 

	else If @Ordr='S'

		if @NeedOto=0 or @NeedOto=1

				select 'Gabungan' Perusahaan,* from VwReportRPembelianGDg where Tanggal between @tgl1 and @tgl2 and NeedOtorisasi=@NeedOto

				order by KodeCustSupp

			if @NeedOto=2

				select 'Gabungan' Perusahaan,* from VwReportRPembelianGDg where Tanggal between @tgl1 and @tgl2

				order by KodeCustSupp


else----------

if @SReport='T'

If @Ordr='N'

		if @NeedOto=0 or @NeedOto=1

				select Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwReportRPembelianGDg where Tanggal between @tgl1 and @tgl2 and NeedOtorisasi=@NeedOto

				 and @Id=Case When Len(@ID)=3 Then Left(NoBukti,3) else Left(NOBUKTI,2)

				order by NoBukti,Tanggal

			if @NeedOto=2

				select Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwReportRPembelianGDg where Tanggal between @tgl1 and @tgl2 

				and @Id=Case When Len(@ID)=3 Then Left(NoBukti,3) else Left(NOBUKTI,2)

				order by NoBukti,Tanggal	

		 

	else If @Ordr='B'

		if @NeedOto=0 or @NeedOto=1

				select Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwReportRPembelianGDg where Tanggal between @tgl1 and @tgl2 and NeedOtorisasi=@NeedOto

				and @Id=Case When Len(@ID)=3 Then Left(NoBukti,3) else Left(NOBUKTI,2)

				order by KodeBrg

			if @NeedOto=2

				select Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwReportRPembelianGDg where Tanggal between @tgl1 and @tgl2 

				and @Id=Case When Len(@ID)=3 Then Left(NoBukti,3) else Left(NOBUKTI,2)

				order by KodeBrg

		 

	else If @Ordr='S'

		if @NeedOto=0 or @NeedOto=1

				select Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwReportRPembelianGDg where Tanggal between @tgl1 and @tgl2 and NeedOtorisasi=@NeedOto

				and @Id=Case When Len(@ID)=3 Then Left(NoBukti,3) else Left(NOBUKTI,2)

				order by KodeCustSupp

			if @NeedOto=2

				select Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwReportRPembelianGDg where Tanggal between @tgl1 and @tgl2

				and @Id=Case When Len(@ID)=3 Then Left(NoBukti,3) else Left(NOBUKTI,2)

				order by KodeCustSupp;

-- Sp_reportRBPrek
CREATE PROCEDURE IF NOT EXISTS Sp_reportRBPrek AS ---- DECLARE REMOVED,@Bulan Int,@Tahun Int

--Select @Choice='B',@Bulan=1,@Tahun=2012



If @Choice='N'

Select 	A.NoBukti,A.tanggal, 

	Sum(COALESCE(B.Qnt,0)) Qnt

	From dbRPenyerahanBhn A

	Left Outer join  dbRPenyerahanBhnDet B on B.NoBukti=a.NoBukti

	Left Outer join dbBarang H on H.KodeBrg=b.KodeBrg

	Where A.tanggal Between @Tgl1 And @Tgl2

	Group By A.Nobukti,A.tanggal

	Order BY A.nobukti,A.tanggal


If @Choice='B'

Select 	B.KOdebrg,H.namaBrg,A.Tanggal, 

	Sum(COALESCE(B.Qnt,0)) Qnt

	From dbRPenyerahanBhn A

	Left Outer join  dbRPenyerahanBhnDet B on B.NoBukti=a.NoBukti

	Left Outer join dbBarang H on H.KodeBrg=b.KodeBrg

	Where A.tanggal Between @Tgl1 And @Tgl2

	Group By B.kodebrg,H.namaBrg,A.tanggal

	Order BY B.kodebrg,H.namaBrg,A.Tanggal;

-- Sp_ReportRekapKirim
CREATE PROCEDURE IF NOT EXISTS Sp_ReportRekapKirim AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 

select @Id=SUBSTRING(@Id,1,1)

if @Id=''

if @isiList='' 

     exec('select ''Gabungan'' Perusahaan,* from vwReportRekapKirim where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

      and KodeGdg Like ''%'+@Kodegdg+'%''

      order by KodeCustSupp')

	 

 else

     exec('select ''Gabungan'' Perusahaan,* from vwReportRekapKirim where KodeCustSupp+KodeProject IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

      and KodeGdg Like ''%'+@Kodegdg+'%''

      order by KodeCustSupp')


else

if @isiList='' 

     exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from vwReportRekapKirim where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

      and KodeGdg Like ''%'+@Kodegdg+'%''

      and '''+@ID+'''= Left(NOSO,1)

      order by KodeCustSupp')

	 

 else

     exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from vwReportRekapKirim where KodeCustSupp+KodeProject IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

      and KodeGdg Like ''%'+@Kodegdg+'%''

      and '''+@ID+'''= Left(NOSO,1)

      order by KodeCustSupp');

-- Sp_ReportRekapPengirimanBarang
CREATE PROCEDURE IF NOT EXISTS Sp_ReportRekapPengirimanBarang AS if @isiList=''

	exec('select * from VwReportRekapPengirimanBarang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

         order by NAMAPROJECT')

  else

   	exec('select * from VwReportRekapPengirimanBarang where KODEPROJECT IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

         order by NAMAPROJECT');

-- Sp_ReportReportKPvsSJVsSaku
CREATE PROCEDURE IF NOT EXISTS Sp_ReportReportKPvsSJVsSaku AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 

select @Id=SUBSTRING(@Id,1,1)

if @Id=''

if @Ordr='N'

		if @isiList='' 

		 exec('select ''Gabungan'' Perusahaan,* from VwReportKPvsSJVsSaku where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		 order by NoSO,Tanggal')

		 else

		 Exec('select ''Gabungan'' Perusahaan,* from VwReportKPvsSJVsSaku where NOSO IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

         order by NoSO,Tanggal')

		 

	else If @Ordr='B'

		if @isiList=''

		 exec('select ''Gabungan'' Perusahaan,* from VwReportKPvsSJVsSaku where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		 order by KodeBrg')

		else

		 exec('select ''Gabungan'' Perusahaan,* from VwReportKPvsSJVsSaku where Kodebrg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		 order by KodeBrg') 

		 

	else If @Ordr='C'

		if @isiList=''

		exec(' select ''Gabungan'' Perusahaan,* from VwReportRealisasiKP where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		order by KodeCust')

		else

		exec(' select ''Gabungan'' Perusahaan,* from VwReportRealisasiKP where KodeCust IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		order by KodeCust')


else

if @Ordr='N'

		if @isiList='' 

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportKPvsSJVsSaku where --(Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  '''+@ID+'''= Left(NOSO,1)

		 order by NoSO,Tanggal')

		 else

		 Exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportKPvsSJVsSaku where NOSO IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

         and '''+@ID+'''= Left(NOSO,1)

         order by NoSO,Tanggal')

		 

	else If @Ordr='B'

		if @isiList=''

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportKPvsSJVsSaku where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		 and '''+@ID+'''= Left(NOSO,1)

		 order by KodeBrg')

		else

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportKPvsSJVsSaku where Kodebrg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		 and '''+@ID+'''= Left(NOSO,1) 

		 order by KodeBrg') 

		 

	else If @Ordr='C'

		if @isiList=''

		exec(' select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportRealisasiKP where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		where '''+@ID+'''= Left(NOSO,1)

		order by KodeCust')

		else

		exec(' select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportRealisasiKP where KodeCust IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		and '''+@ID+'''= Left(NOSO,1)

		order by KodeCust');

-- Sp_reportRevisiPOdet
CREATE PROCEDURE IF NOT EXISTS Sp_reportRevisiPOdet AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 



if @SReport='T'

If @Ordr='N'

		select * from VwReportRevisiPO where Tanggal between @tgl1 and @tgl2 order by NoBukti,Tanggal

		 

	else If @Ordr='B'

		select * from VwReportRevisiPO where Tanggal between @tgl1 and @tgl2 order by KodeBrg

		 

	else If @Ordr='S'

		select * from VwReportRevisiPO where Tanggal between @tgl1 and @tgl2 order by KodeCustSupp;

-- Sp_ReportRevisiPOrek
CREATE PROCEDURE IF NOT EXISTS Sp_ReportRevisiPOrek AS ---- DECLARE REMOVED,@Tgl1 Datetime,@tgl2 datetime

--select @Tgl1='01/01/2012',@tgl2='07/17/2013',@Choice='f'



if @Id=''

If @Choice='N'

Select 	'Gabungan' Perusahaan,B.NoBukti,I.TANGGAL,I.KODESUPP KodeCustSupp,J.NAMACUSTSUPP, 

	    Sum(COALESCE(B.Qnt,0)) Qnt, Sum(COALESCE(B.Harga,0)) Harga,

        Sum(COALESCE(B.DiscP,0)) DiscP1, Sum(COALESCE(B.DiscTot,0)) DiscRp1, Sum(COALESCE(B.DiscTot,0)) DiscTot,

        Sum(COALESCE(B.SubTotal,0)) TotalUSD, Sum(COALESCE(B.SubTotal,0)) TotalIDR, Sum(COALESCE(B.NDPP,0)) NDPP,

        Sum(COALESCE(B.NPPN,0)) NPPN, Sum(COALESCE(B.BYAngkut,0)) Beban, Sum(COALESCE(B.SubTotal,0)) + Sum(COALESCE(B.BYAngkut,0)) Total

        From  dbPODet B 

		Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg

		Left Outer join DBPO I on B.NOBUKTI = I.NOBUKTI

		Left Outer Join DBCUSTSUPP J on I.KODESUPP = J.KODECUSTSUPP 

		where I.TANGGAL between @tgl1 and @tgl2

		Group by B.NOBUKTI,I.TANGGAL,I.KODESUPP,J.NAMACUSTSUPP

		order by  B.NOBUKTI,I.TANGGAL



If @choice='S'

Select 'Gabungan' Perusahaan,	I.TANGGAL,I.KODESUPP KodeCustSupp,J.NAMACUSTSUPP, 

	    Sum(COALESCE(B.Qnt,0)) Qnt, Sum(COALESCE(B.Harga,0)) Harga,

        Sum(COALESCE(B.DiscP,0)) DiscP1, Sum(COALESCE(B.DiscTot,0)) DiscRp1, Sum(COALESCE(B.DiscTot,0)) DiscTot,

        Sum(COALESCE(B.SubTotal,0)) TotalUSD, Sum(COALESCE(B.SubTotal,0)) TotalIDR, Sum(COALESCE(B.NDPP,0)) NDPP,

        Sum(COALESCE(B.NPPN,0)) NPPN, Sum(COALESCE(B.BYAngkut,0)) Beban, Sum(COALESCE(B.SubTotal,0)) + Sum(COALESCE(B.BYAngkut,0)) Total

        From  dbPODet B 

		Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg

		Left Outer join DBPO I on B.NOBUKTI = I.NOBUKTI

		Left Outer Join DBCUSTSUPP J on I.KODESUPP = J.KODECUSTSUPP 

		where I.TANGGAL between @tgl1 and @tgl2

		Group by I.TANGGAL,I.KODESUPP,J.NAMACUSTSUPP

		Order By I.KODESUPP,J.NAMACUSTSUPP,I.TANGGAL


else if @Choice ='B'

Select  'Gabungan' Perusahaan,I.TANGGAL, B.KodeBrg, H.NamaBrg,

	    Sum(COALESCE(B.Qnt,0)) Qnt, Sum(COALESCE(B.Harga,0)) Harga,

        Sum(COALESCE(B.DiscP,0)) DiscP1, Sum(COALESCE(B.DiscTot,0)) DiscRp1, Sum(COALESCE(B.DiscTot,0)) DiscTot,

        Sum(COALESCE(B.SubTotal,0)) TotalUSD, Sum(COALESCE(B.SubTotal,0)) TotalIDR, Sum(COALESCE(B.NDPP,0)) NDPP,

        Sum(COALESCE(B.NPPN,0)) NPPN, Sum(COALESCE(B.BYAngkut,0)) Beban, Sum(COALESCE(B.SubTotal,0)) + Sum(COALESCE(B.BYAngkut,0)) Total

		From  dbPODet B 

		Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg

		Left Outer join DBPO I on B.NOBUKTI = I.NOBUKTI

		Left Outer Join DBCUSTSUPP J on I.KODESUPP = J.KODECUSTSUPP 

		where I.TANGGAL between @tgl1 and @tgl2

		Group by  B.KodeBrg, H.NamaBrg,I.TANGGAL

		order by B.KodeBrg, H.NamaBrg,I.TANGGAL


else------------------

If @Choice='N'

Select 	Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,B.NoBukti,I.TANGGAL,I.KODESUPP KodeCustSupp,J.NAMACUSTSUPP, 

	    Sum(COALESCE(B.Qnt,0)) Qnt, Sum(COALESCE(B.Harga,0)) Harga,

        Sum(COALESCE(B.DiscP,0)) DiscP1, Sum(COALESCE(B.DiscTot,0)) DiscRp1, Sum(COALESCE(B.DiscTot,0)) DiscTot,

        Sum(COALESCE(B.SubTotal,0)) TotalUSD, Sum(COALESCE(B.SubTotal,0)) TotalIDR, Sum(COALESCE(B.NDPP,0)) NDPP,

        Sum(COALESCE(B.NPPN,0)) NPPN, Sum(COALESCE(B.BYAngkut,0)) Beban, Sum(COALESCE(B.SubTotal,0)) + Sum(COALESCE(B.BYAngkut,0)) Total

        From  dbPODet B 

		Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg

		Left Outer join DBPO I on B.NOBUKTI = I.NOBUKTI

		Left Outer Join DBCUSTSUPP J on I.KODESUPP = J.KODECUSTSUPP 

		where I.TANGGAL between @tgl1 and @tgl2

		 and @Id=Case When Len(@ID)=3 Then Left(B.NoBukti,3) else Left(B.NOBUKTI,2)

		Group by B.NOBUKTI,I.TANGGAL,I.KODESUPP,J.NAMACUSTSUPP

		order by  B.NOBUKTI,I.TANGGAL



If @choice='S'

Select 	Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,I.TANGGAL,I.KODESUPP KodeCustSupp,J.NAMACUSTSUPP, 

	    Sum(COALESCE(B.Qnt,0)) Qnt, Sum(COALESCE(B.Harga,0)) Harga,

        Sum(COALESCE(B.DiscP,0)) DiscP1, Sum(COALESCE(B.DiscTot,0)) DiscRp1, Sum(COALESCE(B.DiscTot,0)) DiscTot,

        Sum(COALESCE(B.SubTotal,0)) TotalUSD, Sum(COALESCE(B.SubTotal,0)) TotalIDR, Sum(COALESCE(B.NDPP,0)) NDPP,

        Sum(COALESCE(B.NPPN,0)) NPPN, Sum(COALESCE(B.BYAngkut,0)) Beban, Sum(COALESCE(B.SubTotal,0)) + Sum(COALESCE(B.BYAngkut,0)) Total

        From  dbPODet B 

		Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg

		Left Outer join DBPO I on B.NOBUKTI = I.NOBUKTI

		Left Outer Join DBCUSTSUPP J on I.KODESUPP = J.KODECUSTSUPP 

		where I.TANGGAL between @tgl1 and @tgl2

		 and @Id=Case When Len(@ID)=3 Then Left(B.NoBukti,3) else Left(B.NOBUKTI,2)

		Group by I.TANGGAL,I.KODESUPP,J.NAMACUSTSUPP

		Order By I.KODESUPP,J.NAMACUSTSUPP,I.TANGGAL


else if @Choice ='B'

Select  Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,I.TANGGAL, B.KodeBrg, H.NamaBrg,

	    Sum(COALESCE(B.Qnt,0)) Qnt, Sum(COALESCE(B.Harga,0)) Harga,

        Sum(COALESCE(B.DiscP,0)) DiscP1, Sum(COALESCE(B.DiscTot,0)) DiscRp1, Sum(COALESCE(B.DiscTot,0)) DiscTot,

        Sum(COALESCE(B.SubTotal,0)) TotalUSD, Sum(COALESCE(B.SubTotal,0)) TotalIDR, Sum(COALESCE(B.NDPP,0)) NDPP,

        Sum(COALESCE(B.NPPN,0)) NPPN, Sum(COALESCE(B.BYAngkut,0)) Beban, Sum(COALESCE(B.SubTotal,0)) + Sum(COALESCE(B.BYAngkut,0)) Total

		From  dbPODet B 

		Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg

		Left Outer join DBPO I on B.NOBUKTI = I.NOBUKTI

		Left Outer Join DBCUSTSUPP J on I.KODESUPP = J.KODECUSTSUPP 

		where I.TANGGAL between @tgl1 and @tgl2

		 and @Id=Case When Len(@ID)=3 Then Left(B.NoBukti,3) else Left(B.NOBUKTI,2)

		Group by  B.KodeBrg, H.NamaBrg,I.TANGGAL

		order by B.KodeBrg, H.NamaBrg,I.TANGGAL


--exec Sp_ReportPORek 'N','01/01/2012','07/17/2013' where kodecustsupp='12';

-- Sp_ReportRevisirek
CREATE PROCEDURE IF NOT EXISTS Sp_ReportRevisirek AS ---- DECLARE REMOVED,@Tgl1 Datetime,@tgl2 datetime

--select @Tgl1='01/01/2012',@tgl2='07/17/2013',@Choice='f'



If @Choice='N'

Select 	B.NoBukti,I.TANGGAL,I.KODESUPP KodeCustSupp,J.NAMACUSTSUPP, 

	    Sum(COALESCE(B.Qnt,0)) Qnt, Sum(COALESCE(B.Harga,0)) Harga,

        Sum(COALESCE(B.DiscP,0)) DiscP1, Sum(COALESCE(B.DiscTot,0)) DiscRp1, Sum(COALESCE(B.DiscTot,0)) DiscTot,

        Sum(COALESCE(B.SubTotal,0)) TotalUSD, Sum(COALESCE(B.SubTotal,0)) TotalIDR, Sum(COALESCE(B.NDPP,0)) NDPP,

        Sum(COALESCE(B.NPPN,0)) NPPN, Sum(COALESCE(B.BYAngkut,0)) Beban, Sum(COALESCE(B.SubTotal,0)) + Sum(COALESCE(B.BYAngkut,0)) Total

        From  dbPODet B 

		Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg

		Left Outer join DBPO I on B.NOBUKTI = I.NOBUKTI

		Left Outer Join DBCUSTSUPP J on I.KODESUPP = J.KODECUSTSUPP 

		where I.TANGGAL between @tgl1 and @tgl2

		Group by B.NOBUKTI,I.TANGGAL,I.KODESUPP,J.NAMACUSTSUPP

		order by  B.NOBUKTI,I.TANGGAL



If @choice='S'

Select 	I.TANGGAL,I.KODESUPP KodeCustSupp,J.NAMACUSTSUPP, 

	    Sum(COALESCE(B.Qnt,0)) Qnt, Sum(COALESCE(B.Harga,0)) Harga,

        Sum(COALESCE(B.DiscP,0)) DiscP1, Sum(COALESCE(B.DiscTot,0)) DiscRp1, Sum(COALESCE(B.DiscTot,0)) DiscTot,

        Sum(COALESCE(B.SubTotal,0)) TotalUSD, Sum(COALESCE(B.SubTotal,0)) TotalIDR, Sum(COALESCE(B.NDPP,0)) NDPP,

        Sum(COALESCE(B.NPPN,0)) NPPN, Sum(COALESCE(B.BYAngkut,0)) Beban, Sum(COALESCE(B.SubTotal,0)) + Sum(COALESCE(B.BYAngkut,0)) Total

        From  dbPODet B 

		Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg

		Left Outer join DBPO I on B.NOBUKTI = I.NOBUKTI

		Left Outer Join DBCUSTSUPP J on I.KODESUPP = J.KODECUSTSUPP 

		where I.TANGGAL between @tgl1 and @tgl2

		Group by I.TANGGAL,I.KODESUPP,J.NAMACUSTSUPP

		Order By I.KODESUPP,J.NAMACUSTSUPP,I.TANGGAL


else if @Choice ='B'

Select  I.TANGGAL, B.KodeBrg, H.NamaBrg,

	    Sum(COALESCE(B.Qnt,0)) Qnt, Sum(COALESCE(B.Harga,0)) Harga,

        Sum(COALESCE(B.DiscP,0)) DiscP1, Sum(COALESCE(B.DiscTot,0)) DiscRp1, Sum(COALESCE(B.DiscTot,0)) DiscTot,

        Sum(COALESCE(B.SubTotal,0)) TotalUSD, Sum(COALESCE(B.SubTotal,0)) TotalIDR, Sum(COALESCE(B.NDPP,0)) NDPP,

        Sum(COALESCE(B.NPPN,0)) NPPN, Sum(COALESCE(B.BYAngkut,0)) Beban, Sum(COALESCE(B.SubTotal,0)) + Sum(COALESCE(B.BYAngkut,0)) Total

		From  dbPODet B 

		Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg

		Left Outer join DBPO I on B.NOBUKTI = I.NOBUKTI

		Left Outer Join DBCUSTSUPP J on I.KODESUPP = J.KODECUSTSUPP 

		where I.TANGGAL between @tgl1 and @tgl2

		Group by  B.KodeBrg, H.NamaBrg,I.TANGGAL

		order by B.KodeBrg, H.NamaBrg,I.TANGGAL


--exec Sp_ReportPORek 'N','01/01/2012','07/17/2013' where kodecustsupp='12';

-- Sp_reportRInvoicedet
CREATE PROCEDURE IF NOT EXISTS Sp_reportRInvoicedet AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 



if @SReport='T'

If @Ordr='N'

		select * from VwreportRINVoice where Tanggal between @tgl1 and @tgl2 order by NoBukti,Tanggal

		 

	else If @Ordr='B'

		select * from VwreportRINVoice where Tanggal between @tgl1 and @tgl2 --order by KodeBrg

		 

	else If @Ordr='S'

		select * from VwreportRINVoice where Tanggal between @tgl1 and @tgl2 order by KodeCustSupp;

-- Sp_reportRInvoicePenjualanDet
CREATE PROCEDURE IF NOT EXISTS Sp_reportRInvoicePenjualanDet AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 

select @Id=SUBSTRING(@Id,1,1)

if @Id=''

if @SReport='T'

If @Ordr='N'

		if @NeedOto=0 or @NeedOto=1

			select 'Gabungan' Perusahaan,* from VwReportRInvoicePenjualan where Tanggal between @tgl1 and @tgl2 and Needotorisasi=@NeedOto

			order by NoBukti,Tanggal

		if @NeedOto=2

			select 'Gabungan' Perusahaan,* from VwReportRInvoicePenjualan where Tanggal between @tgl1 and @tgl2 

			order by NoBukti,Tanggal

		 

	else If @Ordr='B'

		if @NeedOto=0 or @NeedOto=1

		  select 'Gabungan' Perusahaan,* from VwReportRInvoicePenjualan where Tanggal between @tgl1 and @tgl2 and Needotorisasi=@NeedOto

		  order by KodeBrg

		 if @NeedOto=2

		  select 'Gabungan' Perusahaan,* from VwReportRInvoicePenjualan where Tanggal between @tgl1 and @tgl2

		  order by KodeBrg

		 

	else If @Ordr='C'

		if @NeedOto=0 or @NeedOto=1

		  select 'Gabungan' Perusahaan,* from VwReportRInvoicePenjualan where Tanggal between @tgl1 and @tgl2 and Needotorisasi=@NeedOto

		  order by KodeCustSupp

		if @NeedOto=2

		  select 'Gabungan' Perusahaan,* from VwReportRInvoicePenjualan where Tanggal between @tgl1 and @tgl2 

		  order by KodeCustSupp

		

	else If @Ordr='S'

		if @NeedOto=0 or @NeedOto=1

		  select 'Gabungan' Perusahaan,* from VwReportRInvoicePenjualan where Tanggal between @tgl1 and @tgl2 and Needotorisasi=@NeedOto

		  order by KodeCustSupp

		 if @NeedOto=2

		  select 'Gabungan' Perusahaan,* from VwReportRInvoicePenjualan where Tanggal between @tgl1 and @tgl2 

		  order by KodeCustSupp


else

if @SReport='T'

If @Ordr='N'

		if @NeedOto=0 or @NeedOto=1

			select Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwReportRInvoicePenjualan where Tanggal between @tgl1 and @tgl2 and Needotorisasi=@NeedOto

			and @Id=LEFT(NOBUKTI,1)

			order by NoBukti,Tanggal

		if @NeedOto=2

			select Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwReportRInvoicePenjualan where Tanggal between @tgl1 and @tgl2 

			and @Id=LEFT(NOBUKTI,1)

			order by NoBukti,Tanggal

		 

	else If @Ordr='B'

		if @NeedOto=0 or @NeedOto=1

		  select Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwReportRInvoicePenjualan where Tanggal between @tgl1 and @tgl2 and Needotorisasi=@NeedOto

		  and @Id=LEFT(NOBUKTI,1)

		  order by KodeBrg

		 if @NeedOto=2

		  select Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwReportRInvoicePenjualan where Tanggal between @tgl1 and @tgl2

		  and @Id=LEFT(NOBUKTI,1)

		  order by KodeBrg

		 

	else If @Ordr='C'

		if @NeedOto=0 or @NeedOto=1

		  select Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwReportRInvoicePenjualan where Tanggal between @tgl1 and @tgl2 and Needotorisasi=@NeedOto

		  and @Id=LEFT(NOBUKTI,1)

		  order by KodeCustSupp

		if @NeedOto=2

		  select Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwReportRInvoicePenjualan where Tanggal between @tgl1 and @tgl2 

		  and @Id=LEFT(NOBUKTI,1) 

		  order by KodeCustSupp

		

	else If @Ordr='S'

		if @NeedOto=0 or @NeedOto=1

		  select Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwReportRInvoicePenjualan where Tanggal between @tgl1 and @tgl2 and Needotorisasi=@NeedOto

		  and @Id=LEFT(NOBUKTI,1)

		  order by KodeCustSupp

		 if @NeedOto=2

		  select Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwReportRInvoicePenjualan where Tanggal between @tgl1 and @tgl2 

		  and @Id=LEFT(NOBUKTI,1)

		  order by KodeCustSupp;

-- Sp_ReportRInvoicePenjualanRek
CREATE PROCEDURE IF NOT EXISTS Sp_ReportRInvoicePenjualanRek AS ---- DECLARE REMOVED,@Tgl1 DateTime,@Tgl2 Datetime

--Select @Choice='B',@Tgl1='01/01/2011',@Tgl2='01/01/2013'

select @Id=SUBSTRING(@Id,1,1)

if @Id=''

If @Choice='N'

If @Needoto=0 or @Needoto=1

		select 	'Gabungan' Perusahaan,B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,

		sum(COALESCE(B.PPN,0))PPN,sum(COALESCE(B.DISC,0))Disc, 

		sum(COALESCE(B.KURS,0))Kurs, sum(COALESCE(B.QNT,0)) QNT, sum(COALESCE(B.QNT2,0))QNT2, 

		sum(COALESCE(B.NetW,0)) NetW,sum(COALESCE(B.GrossW,0))GrossW,

       sum(COALESCE(B.DISCTOT,0))Disctot, 

        sum(COALESCE(B.HRGNETTO,0)) HrgNetto, sum(COALESCE(B.NDISKON,0)) NDiskon, 

        sum(COALESCE(B.SUBTOTAL,0)) SubTotal, sum(COALESCE(B.NDPP,0)) NDPP,

        sum(COALESCE(B.NPPN,0)) NPPN,sum(COALESCE(B.NNET,0)) NNet,

        sum(COALESCE(B.SUBTOTALRp,0)) SubtotalRp, sum(COALESCE(B.NDPPRp,0)) NDPPRP, 

        sum(COALESCE(B.NPPNRp,0)) NPPNRP, sum(COALESCE(B.NNETRp,0)) NNETRP

		from	DBRInvoicePLDET B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBRInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		where A.Tanggal between @Tgl1 and @Tgl2 and       

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER)= @Needoto

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP

		Order by B.NoBukti,A.Tanggal

  else If @Needoto=2

		select 	'Gabungan' Perusahaan,B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,

		sum(COALESCE(B.PPN,0))PPN,sum(COALESCE(B.DISC,0))Disc, 

		sum(COALESCE(B.KURS,0))Kurs, sum(COALESCE(B.QNT,0)) QNT, sum(COALESCE(B.QNT2,0))QNT2, 

		sum(COALESCE(B.NetW,0)) NetW,sum(COALESCE(B.GrossW,0))GrossW,

       sum(COALESCE(B.DISCTOT,0))Disctot, 

        sum(COALESCE(B.HRGNETTO,0)) HrgNetto, sum(COALESCE(B.NDISKON,0)) NDiskon, 

        sum(COALESCE(B.SUBTOTAL,0)) SubTotal, sum(COALESCE(B.NDPP,0)) NDPP,

        sum(COALESCE(B.NPPN,0)) NPPN,sum(COALESCE(B.NNET,0)) NNet,

        sum(COALESCE(B.SUBTOTALRp,0)) SubtotalRp, sum(COALESCE(B.NDPPRp,0)) NDPPRP, 

        sum(COALESCE(B.NPPNRp,0)) NPPNRP, sum(COALESCE(B.NNETRp,0)) NNETRP

		from	DBRInvoicePLDET B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBRInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		where A.Tanggal between @Tgl1 and @Tgl2       

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP

		Order by B.NoBukti,A.Tanggal



Else If @Choice='B'

If @Needoto=0 or @Needoto=1

		select 	'Gabungan' Perusahaan,B.KodeBrg,C.NAMABRG,A.Tanggal,sum(COALESCE(B.PPN,0))PPN,sum(COALESCE(B.DISC,0))Disc, 

		sum(COALESCE(B.KURS,0))Kurs, sum(COALESCE(B.QNT,0)) QNT, sum(COALESCE(B.QNT2,0))QNT2, 

		sum(COALESCE(B.NetW,0)) NetW,sum(COALESCE(B.GrossW,0))GrossW,

        sum(COALESCE(B.DISCTOT,0))Disctot, 

        sum(COALESCE(B.HRGNETTO,0)) HrgNetto, sum(COALESCE(B.NDISKON,0)) NDiskon, 

        sum(COALESCE(B.SUBTOTAL,0)) SubTotal, sum(COALESCE(B.NDPP,0)) NDPP,

        sum(COALESCE(B.NPPN,0)) NPPN,sum(COALESCE(B.NNET,0)) NNet,

        sum(COALESCE(B.SUBTOTALRp,0)) SubtotalRp, sum(COALESCE(B.NDPPRp,0)) NDPPRP, 

        sum(COALESCE(B.NPPNRp,0)) NPPNRP, sum(COALESCE(B.NNETRp,0)) NNETRP

		from	DBRInvoicePLDET B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBRInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		where A.Tanggal between @Tgl1 and @Tgl2 and       

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER)= @Needoto

		Group By B.KodeBrg,C.NAMABRG,A.Tanggal

		order By B.KodeBrg,C.NAMABRG,A.Tanggal

	else If @Needoto=2

		select 	'Gabungan' Perusahaan,B.KodeBrg,C.NAMABRG,A.Tanggal,sum(COALESCE(B.PPN,0))PPN,sum(COALESCE(B.DISC,0))Disc, 

		sum(COALESCE(B.KURS,0))Kurs, sum(COALESCE(B.QNT,0)) QNT, sum(COALESCE(B.QNT2,0))QNT2, 

		sum(COALESCE(B.NetW,0)) NetW,sum(COALESCE(B.GrossW,0))GrossW,

        sum(COALESCE(B.DISCTOT,0))Disctot, 

        sum(COALESCE(B.HRGNETTO,0)) HrgNetto, sum(COALESCE(B.NDISKON,0)) NDiskon, 

        sum(COALESCE(B.SUBTOTAL,0)) SubTotal, sum(COALESCE(B.NDPP,0)) NDPP,

        sum(COALESCE(B.NPPN,0)) NPPN,sum(COALESCE(B.NNET,0)) NNet,

        sum(COALESCE(B.SUBTOTALRp,0)) SubtotalRp, sum(COALESCE(B.NDPPRp,0)) NDPPRP, 

        sum(COALESCE(B.NPPNRp,0)) NPPNRP, sum(COALESCE(B.NNETRp,0)) NNETRP

		from	DBRInvoicePLDET B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBRInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		where A.Tanggal between @Tgl1 and @Tgl2

		Group By B.KodeBrg,C.NAMABRG,A.Tanggal

		order By B.KodeBrg,C.NAMABRG,A.Tanggal



Else If @Choice='C'

If @Needoto=0 or @Needoto=1

		select 	'Gabungan' Perusahaan,A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal,sum(COALESCE(B.PPN,0))PPN,sum(COALESCE(B.DISC,0))Disc, 

		sum(COALESCE(B.KURS,0))Kurs, sum(COALESCE(B.QNT,0)) QNT, sum(COALESCE(B.QNT2,0))QNT2, 

		sum(COALESCE(B.NetW,0)) NetW,sum(COALESCE(B.GrossW,0))GrossW,

        sum(COALESCE(B.DISCTOT,0))Disctot, 

        sum(COALESCE(B.HRGNETTO,0)) HrgNetto, sum(COALESCE(B.NDISKON,0)) NDiskon, 

        sum(COALESCE(B.SUBTOTAL,0)) SubTotal, sum(COALESCE(B.NDPP,0)) NDPP,

        sum(COALESCE(B.NPPN,0)) NPPN,sum(COALESCE(B.NNET,0)) NNet,

        sum(COALESCE(B.SUBTOTALRp,0)) SubtotalRp, sum(COALESCE(B.NDPPRp,0)) NDPPRP, 

        sum(COALESCE(B.NPPNRp,0)) NPPNRP, sum(COALESCE(B.NNETRp,0)) NNETRP

		from	DBRInvoicePLDET B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBRInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		where A.Tanggal between @Tgl1 and @Tgl2 and       

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER)= @Needoto

		Group By A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal

		order By A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal

	If @Needoto=2

		select 	'Gabungan' Perusahaan,A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal,sum(COALESCE(B.PPN,0))PPN,sum(COALESCE(B.DISC,0))Disc, 

		sum(COALESCE(B.KURS,0))Kurs, sum(COALESCE(B.QNT,0)) QNT, sum(COALESCE(B.QNT2,0))QNT2, 

		sum(COALESCE(B.NetW,0)) NetW,sum(COALESCE(B.GrossW,0))GrossW,

        sum(COALESCE(B.DISCTOT,0))Disctot, 

        sum(COALESCE(B.HRGNETTO,0)) HrgNetto, sum(COALESCE(B.NDISKON,0)) NDiskon, 

        sum(COALESCE(B.SUBTOTAL,0)) SubTotal, sum(COALESCE(B.NDPP,0)) NDPP,

        sum(COALESCE(B.NPPN,0)) NPPN,sum(COALESCE(B.NNET,0)) NNet,

        sum(COALESCE(B.SUBTOTALRp,0)) SubtotalRp, sum(COALESCE(B.NDPPRp,0)) NDPPRP, 

        sum(COALESCE(B.NPPNRp,0)) NPPNRP, sum(COALESCE(B.NNETRp,0)) NNETRP

		from	DBRInvoicePLDET B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBRInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		where A.Tanggal between @Tgl1 and @Tgl2

		Group By A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal

		order By A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal


Else If @Choice='S'

If @Needoto=0 or @Needoto=1

		select 	'Gabungan' Perusahaan,A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal,sum(COALESCE(B.PPN,0))PPN,sum(COALESCE(B.DISC,0))Disc, 

		sum(COALESCE(B.KURS,0))Kurs, sum(COALESCE(B.QNT,0)) QNT, sum(COALESCE(B.QNT2,0))QNT2, 

		sum(COALESCE(B.NetW,0)) NetW,sum(COALESCE(B.GrossW,0))GrossW,

        sum(COALESCE(B.DISCTOT,0))Disctot, 

        sum(COALESCE(B.HRGNETTO,0)) HrgNetto, sum(COALESCE(B.NDISKON,0)) NDiskon, 

        sum(COALESCE(B.SUBTOTAL,0)) SubTotal, sum(COALESCE(B.NDPP,0)) NDPP,

        sum(COALESCE(B.NPPN,0)) NPPN,sum(COALESCE(B.NNET,0)) NNet,

        sum(COALESCE(B.SUBTOTALRp,0)) SubtotalRp, sum(COALESCE(B.NDPPRp,0)) NDPPRP, 

        sum(COALESCE(B.NPPNRp,0)) NPPNRP, sum(COALESCE(B.NNETRp,0)) NNETRP

		from	DBRInvoicePLDET B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBRInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		where A.Tanggal between @Tgl1 and @Tgl2 and       

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER)= @Needoto

		Group By A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal

		order By A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal

	If @Needoto=2

		select 	'Gabungan' Perusahaan,A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal,sum(COALESCE(B.PPN,0))PPN,sum(COALESCE(B.DISC,0))Disc, 

		sum(COALESCE(B.KURS,0))Kurs, sum(COALESCE(B.QNT,0)) QNT, sum(COALESCE(B.QNT2,0))QNT2, 

		sum(COALESCE(B.NetW,0)) NetW,sum(COALESCE(B.GrossW,0))GrossW,

        sum(COALESCE(B.DISCTOT,0))Disctot, 

        sum(COALESCE(B.HRGNETTO,0)) HrgNetto, sum(COALESCE(B.NDISKON,0)) NDiskon, 

        sum(COALESCE(B.SUBTOTAL,0)) SubTotal, sum(COALESCE(B.NDPP,0)) NDPP,

        sum(COALESCE(B.NPPN,0)) NPPN,sum(COALESCE(B.NNET,0)) NNet,

        sum(COALESCE(B.SUBTOTALRp,0)) SubtotalRp, sum(COALESCE(B.NDPPRp,0)) NDPPRP, 

        sum(COALESCE(B.NPPNRp,0)) NPPNRP, sum(COALESCE(B.NNETRp,0)) NNETRP

		from	DBRInvoicePLDET B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBRInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		where A.Tanggal between @Tgl1 and @Tgl2

		Group By A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal

		order By A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal


else

If @Choice='N'

If @Needoto=0 or @Needoto=1

		select Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,	B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,

		sum(COALESCE(B.PPN,0))PPN,sum(COALESCE(B.DISC,0))Disc, 

		sum(COALESCE(B.KURS,0))Kurs, sum(COALESCE(B.QNT,0)) QNT, sum(COALESCE(B.QNT2,0))QNT2, 

		sum(COALESCE(B.NetW,0)) NetW,sum(COALESCE(B.GrossW,0))GrossW,

       sum(COALESCE(B.DISCTOT,0))Disctot, 

        sum(COALESCE(B.HRGNETTO,0)) HrgNetto, sum(COALESCE(B.NDISKON,0)) NDiskon, 

        sum(COALESCE(B.SUBTOTAL,0)) SubTotal, sum(COALESCE(B.NDPP,0)) NDPP,

        sum(COALESCE(B.NPPN,0)) NPPN,sum(COALESCE(B.NNET,0)) NNet,

        sum(COALESCE(B.SUBTOTALRp,0)) SubtotalRp, sum(COALESCE(B.NDPPRp,0)) NDPPRP, 

        sum(COALESCE(B.NPPNRp,0)) NPPNRP, sum(COALESCE(B.NNETRp,0)) NNETRP

		from	DBRInvoicePLDET B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBRInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		where A.Tanggal between @Tgl1 and @Tgl2 and       

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER)= @Needoto

		and @Id=LEFT(B.NOBUKTI,1)

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP

		Order by B.NoBukti,A.Tanggal

  else If @Needoto=2

		select 	Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,

		sum(COALESCE(B.PPN,0))PPN,sum(COALESCE(B.DISC,0))Disc, 

		sum(COALESCE(B.KURS,0))Kurs, sum(COALESCE(B.QNT,0)) QNT, sum(COALESCE(B.QNT2,0))QNT2, 

		sum(COALESCE(B.NetW,0)) NetW,sum(COALESCE(B.GrossW,0))GrossW,

       sum(COALESCE(B.DISCTOT,0))Disctot, 

        sum(COALESCE(B.HRGNETTO,0)) HrgNetto, sum(COALESCE(B.NDISKON,0)) NDiskon, 

        sum(COALESCE(B.SUBTOTAL,0)) SubTotal, sum(COALESCE(B.NDPP,0)) NDPP,

        sum(COALESCE(B.NPPN,0)) NPPN,sum(COALESCE(B.NNET,0)) NNet,

        sum(COALESCE(B.SUBTOTALRp,0)) SubtotalRp, sum(COALESCE(B.NDPPRp,0)) NDPPRP, 

        sum(COALESCE(B.NPPNRp,0)) NPPNRP, sum(COALESCE(B.NNETRp,0)) NNETRP

		from	DBRInvoicePLDET B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBRInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		where A.Tanggal between @Tgl1 and @Tgl2   

		and @Id=LEFT(B.NOBUKTI,1)    

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP

		Order by B.NoBukti,A.Tanggal



Else If @Choice='B'

If @Needoto=0 or @Needoto=1

		select 	Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,B.KodeBrg,C.NAMABRG,A.Tanggal,sum(COALESCE(B.PPN,0))PPN,sum(COALESCE(B.DISC,0))Disc, 

		sum(COALESCE(B.KURS,0))Kurs, sum(COALESCE(B.QNT,0)) QNT, sum(COALESCE(B.QNT2,0))QNT2, 

		sum(COALESCE(B.NetW,0)) NetW,sum(COALESCE(B.GrossW,0))GrossW,

        sum(COALESCE(B.DISCTOT,0))Disctot, 

        sum(COALESCE(B.HRGNETTO,0)) HrgNetto, sum(COALESCE(B.NDISKON,0)) NDiskon, 

        sum(COALESCE(B.SUBTOTAL,0)) SubTotal, sum(COALESCE(B.NDPP,0)) NDPP,

        sum(COALESCE(B.NPPN,0)) NPPN,sum(COALESCE(B.NNET,0)) NNet,

        sum(COALESCE(B.SUBTOTALRp,0)) SubtotalRp, sum(COALESCE(B.NDPPRp,0)) NDPPRP, 

        sum(COALESCE(B.NPPNRp,0)) NPPNRP, sum(COALESCE(B.NNETRp,0)) NNETRP

		from	DBRInvoicePLDET B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBRInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		where A.Tanggal between @Tgl1 and @Tgl2 and       

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER)= @Needoto

		and @Id=LEFT(B.NOBUKTI,1)

		Group By B.KodeBrg,C.NAMABRG,A.Tanggal

		order By B.KodeBrg,C.NAMABRG,A.Tanggal

	else If @Needoto=2

		select 	Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,B.KodeBrg,C.NAMABRG,A.Tanggal,sum(COALESCE(B.PPN,0))PPN,sum(COALESCE(B.DISC,0))Disc, 

		sum(COALESCE(B.KURS,0))Kurs, sum(COALESCE(B.QNT,0)) QNT, sum(COALESCE(B.QNT2,0))QNT2, 

		sum(COALESCE(B.NetW,0)) NetW,sum(COALESCE(B.GrossW,0))GrossW,

        sum(COALESCE(B.DISCTOT,0))Disctot, 

        sum(COALESCE(B.HRGNETTO,0)) HrgNetto, sum(COALESCE(B.NDISKON,0)) NDiskon, 

        sum(COALESCE(B.SUBTOTAL,0)) SubTotal, sum(COALESCE(B.NDPP,0)) NDPP,

        sum(COALESCE(B.NPPN,0)) NPPN,sum(COALESCE(B.NNET,0)) NNet,

        sum(COALESCE(B.SUBTOTALRp,0)) SubtotalRp, sum(COALESCE(B.NDPPRp,0)) NDPPRP, 

        sum(COALESCE(B.NPPNRp,0)) NPPNRP, sum(COALESCE(B.NNETRp,0)) NNETRP

		from	DBRInvoicePLDET B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBRInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		where A.Tanggal between @Tgl1 and @Tgl2

		and @Id=LEFT(B.NOBUKTI,1)

		Group By B.KodeBrg,C.NAMABRG,A.Tanggal

		order By B.KodeBrg,C.NAMABRG,A.Tanggal



Else If @Choice='C'

If @Needoto=0 or @Needoto=1

		select 	Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal,sum(COALESCE(B.PPN,0))PPN,sum(COALESCE(B.DISC,0))Disc, 

		sum(COALESCE(B.KURS,0))Kurs, sum(COALESCE(B.QNT,0)) QNT, sum(COALESCE(B.QNT2,0))QNT2, 

		sum(COALESCE(B.NetW,0)) NetW,sum(COALESCE(B.GrossW,0))GrossW,

        sum(COALESCE(B.DISCTOT,0))Disctot, 

        sum(COALESCE(B.HRGNETTO,0)) HrgNetto, sum(COALESCE(B.NDISKON,0)) NDiskon, 

        sum(COALESCE(B.SUBTOTAL,0)) SubTotal, sum(COALESCE(B.NDPP,0)) NDPP,

        sum(COALESCE(B.NPPN,0)) NPPN,sum(COALESCE(B.NNET,0)) NNet,

        sum(COALESCE(B.SUBTOTALRp,0)) SubtotalRp, sum(COALESCE(B.NDPPRp,0)) NDPPRP, 

        sum(COALESCE(B.NPPNRp,0)) NPPNRP, sum(COALESCE(B.NNETRp,0)) NNETRP

		from	DBRInvoicePLDET B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBRInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		where A.Tanggal between @Tgl1 and @Tgl2 and       

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER)= @Needoto

		and @Id=LEFT(B.NOBUKTI,1)

		Group By A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal

		order By A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal

	If @Needoto=2

		select 	Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal,sum(COALESCE(B.PPN,0))PPN,sum(COALESCE(B.DISC,0))Disc, 

		sum(COALESCE(B.KURS,0))Kurs, sum(COALESCE(B.QNT,0)) QNT, sum(COALESCE(B.QNT2,0))QNT2, 

		sum(COALESCE(B.NetW,0)) NetW,sum(COALESCE(B.GrossW,0))GrossW,

        sum(COALESCE(B.DISCTOT,0))Disctot, 

        sum(COALESCE(B.HRGNETTO,0)) HrgNetto, sum(COALESCE(B.NDISKON,0)) NDiskon, 

        sum(COALESCE(B.SUBTOTAL,0)) SubTotal, sum(COALESCE(B.NDPP,0)) NDPP,

        sum(COALESCE(B.NPPN,0)) NPPN,sum(COALESCE(B.NNET,0)) NNet,

        sum(COALESCE(B.SUBTOTALRp,0)) SubtotalRp, sum(COALESCE(B.NDPPRp,0)) NDPPRP, 

        sum(COALESCE(B.NPPNRp,0)) NPPNRP, sum(COALESCE(B.NNETRp,0)) NNETRP

		from	DBRInvoicePLDET B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBRInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		where A.Tanggal between @Tgl1 and @Tgl2

		and @Id=LEFT(B.NOBUKTI,1)

		Group By A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal

		order By A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal


Else If @Choice='S'

If @Needoto=0 or @Needoto=1

		select 	Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal,sum(COALESCE(B.PPN,0))PPN,sum(COALESCE(B.DISC,0))Disc, 

		sum(COALESCE(B.KURS,0))Kurs, sum(COALESCE(B.QNT,0)) QNT, sum(COALESCE(B.QNT2,0))QNT2, 

		sum(COALESCE(B.NetW,0)) NetW,sum(COALESCE(B.GrossW,0))GrossW,

        sum(COALESCE(B.DISCTOT,0))Disctot, 

        sum(COALESCE(B.HRGNETTO,0)) HrgNetto, sum(COALESCE(B.NDISKON,0)) NDiskon, 

        sum(COALESCE(B.SUBTOTAL,0)) SubTotal, sum(COALESCE(B.NDPP,0)) NDPP,

        sum(COALESCE(B.NPPN,0)) NPPN,sum(COALESCE(B.NNET,0)) NNet,

        sum(COALESCE(B.SUBTOTALRp,0)) SubtotalRp, sum(COALESCE(B.NDPPRp,0)) NDPPRP, 

        sum(COALESCE(B.NPPNRp,0)) NPPNRP, sum(COALESCE(B.NNETRp,0)) NNETRP

		from	DBRInvoicePLDET B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBRInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		where A.Tanggal between @Tgl1 and @Tgl2 and       

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER)= @Needoto

		and @Id=LEFT(B.NOBUKTI,1)

		Group By A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal

		order By A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal

	If @Needoto=2

		select 	Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal,sum(COALESCE(B.PPN,0))PPN,sum(COALESCE(B.DISC,0))Disc, 

		sum(COALESCE(B.KURS,0))Kurs, sum(COALESCE(B.QNT,0)) QNT, sum(COALESCE(B.QNT2,0))QNT2, 

		sum(COALESCE(B.NetW,0)) NetW,sum(COALESCE(B.GrossW,0))GrossW,

        sum(COALESCE(B.DISCTOT,0))Disctot, 

        sum(COALESCE(B.HRGNETTO,0)) HrgNetto, sum(COALESCE(B.NDISKON,0)) NDiskon, 

        sum(COALESCE(B.SUBTOTAL,0)) SubTotal, sum(COALESCE(B.NDPP,0)) NDPP,

        sum(COALESCE(B.NPPN,0)) NPPN,sum(COALESCE(B.NNET,0)) NNet,

        sum(COALESCE(B.SUBTOTALRp,0)) SubtotalRp, sum(COALESCE(B.NDPPRp,0)) NDPPRP, 

        sum(COALESCE(B.NPPNRp,0)) NPPNRP, sum(COALESCE(B.NNETRp,0)) NNETRP

		from	DBRInvoicePLDET B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBRInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		where A.Tanggal between @Tgl1 and @Tgl2

		and @Id=LEFT(B.NOBUKTI,1)

		Group By A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal

		order By A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal


--select * from DBEXPEDISI;

-- Sp_ReportRInvoiceRek
CREATE PROCEDURE IF NOT EXISTS Sp_ReportRInvoiceRek AS ---- DECLARE REMOVED,@Tgl1 Datetime,@tgl2 datetime

--select @Tgl1='01/01/2012',@tgl2='07/17/2013',@Choice='S'

If @Choice='N'

Select 	B.NoBukti,I.TANGGAL,SUM(COALESCE(B.Qnt,0)) Qnt,Sum(COALESCE(B.Harga,0)) Harga,

        Sum(COALESCE(B.DiscP,0)) DiscP1, Sum(COALESCE(B.DiscTot,0)) DiscRp1, Sum(COALESCE(B.DiscTot,0)) Disctot,

        Sum(COALESCE(B.SubTotal,0)) TotalUSD, Sum(COALESCE(B.SubTotal,0)) TotalIDR, Sum(COALESCE(B.NDPP,0)) NDPP,

        Sum(COALESCE(B.NPPN,0)) Nppn,Sum(COALESCE(B.BYAngkut,0)) Beban, Sum(COALESCE(B.SubTotal,0)) + Sum(COALESCE(B.BYAngkut,0)) Total

		From dbRBeliDet B

		Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg 

	Left Outer Join DBRBELI I on B.NOBUKTI = I.NOBUKTI

	Left Outer Join DBCUSTSUPP J on I.KODESUPP = J.KODECUSTSUPP 

	group by B.NoBukti,I.TANGGAL

	Order by B.NoBukti,I.TANGGAL 



else If @Choice='B'

Select 	B.Kodebrg,H.NAMABRG,i.TANGGAL,SUM(COALESCE(B.Qnt,0)) Qnt,Sum(COALESCE(B.Harga,0)) Harga,

        Sum(COALESCE(B.DiscP,0)) DiscP1, Sum(COALESCE(B.DiscTot,0)) DiscRp1, Sum(COALESCE(B.DiscTot,0)) Disctot,

        Sum(COALESCE(B.SubTotal,0)) TotalUSD, Sum(COALESCE(B.SubTotal,0)) TotalIDR, Sum(COALESCE(B.NDPP,0)) NDPP,

        Sum(COALESCE(B.NPPN,0)) Nppn,Sum(COALESCE(B.BYAngkut,0)) Beban, Sum(COALESCE(B.SubTotal,0)) + Sum(COALESCE(B.BYAngkut,0)) Total

	From dbRBeliDet B

	Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg 

	Left Outer Join DBRBELI I on B.NOBUKTI = I.NOBUKTI

	Left Outer Join DBCUSTSUPP J on I.KODESUPP = J.KODECUSTSUPP 

	group by B.Kodebrg,H.NAMABRG,i.TANGGAL

	Order by B.Kodebrg,H.NAMABRG,i.TANGGAL



else If @Choice='S'

Select i.KODESUPP,J.NAMACUSTSUPP,i.TANGGAL,SUM(COALESCE(B.Qnt,0)) Qnt,Sum(COALESCE(B.Harga,0)) Harga,

        Sum(COALESCE(B.DiscP,0)) DiscP1, Sum(COALESCE(B.DiscTot,0)) DiscRp1, Sum(COALESCE(B.DiscTot,0)) Disctot,

        Sum(COALESCE(B.SubTotal,0)) TotalUSD, Sum(COALESCE(B.SubTotal,0)) TotalIDR, Sum(COALESCE(B.NDPP,0)) NDPP,

        Sum(COALESCE(B.NPPN,0)) Nppn,Sum(COALESCE(B.BYAngkut,0)) Beban, Sum(COALESCE(B.SubTotal,0)) + Sum(COALESCE(B.BYAngkut,0)) Total

	From dbRBeliDet B

	Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg 

	Left Outer Join DBRBELI I on B.NOBUKTI = I.NOBUKTI

	Left Outer Join DBCUSTSUPP J on I.KODESUPP = J.KODECUSTSUPP 

	group by i.KODESUPP,J.NAMACUSTSUPP,i.TANGGAL

	Order by i.KODESUPP,J.NAMACUSTSUPP,i.TANGGAL;

-- Sp_reportRPembelianGDGRek
CREATE PROCEDURE IF NOT EXISTS Sp_reportRPembelianGDGRek AS ---- DECLARE REMOVED,@Tgl1 Datetime,@tgl2 datetime

--select @Tgl1='01/01/2012',@tgl2='07/17/2013',@Choice='B'



if @Id=''

if @Choice='N'

If @NeedOto=0 or @NeedOto=1

		Select 	'Gabungan' Perusahaan,a.NoBukti,a.TANGGAL,J.NAMACUSTSUPP,a.KODEVLS,a.KURS,

            b.NDPP,b.NDPPRp,b.NPPNRp,B.nnetrp

		From  DBRBELI a 

		left outer join DBRBELIDET B on b.NOBUKTI=a.NOBUKTI

		Left Outer Join DBCUSTSUPP J on a.KODESUPP = J.KODECUSTSUPP 

		Where a.TANGGAL between @tgl1 and @tgl2 and 

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                      Case when A.IsOtorisasi2=1 then 1 else 0 +

                      Case when A.IsOtorisasi3=1 then 1 else 0 +

                      Case when A.IsOtorisasi4=1 then 1 else 0 +

                      Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                 else 1

             As INTEGER) =@NeedOto

		order by  a.NOBUKTI,a.TANGGAL

	else If @NeedOto=2

		Select 	'Gabungan' Perusahaan,a.NoBukti,a.TANGGAL,J.NAMACUSTSUPP,a.KODEVLS,a.KURS,

            b.NDPP,b.NDPPRp,b.NPPNRp,B.nnetrp

		From  DBRBELI a 

		left outer join DBRBELIDET B on b.NOBUKTI=a.NOBUKTI

		Left Outer Join DBCUSTSUPP J on a.KODESUPP = J.KODECUSTSUPP 

		Where a.TANGGAL between @tgl1 and @tgl2 

		order by  a.NOBUKTI,a.TANGGAL


Else if @Choice='S'

If @NeedOto=0 or @NeedOto=1

		Select 	'Gabungan' Perusahaan,a.NoBukti,a.TANGGAL,J.NAMACUSTSUPP,a.KODEVLS,a.KURS,

            b.NDPP,b.NDPPRp,b.NPPNRp,B.nnetrp

		From  DBRBELI a 

		left outer join DBRBELIDET B on b.NOBUKTI=a.NOBUKTI

		Left Outer Join DBCUSTSUPP J on a.KODESUPP = J.KODECUSTSUPP 

		Where a.TANGGAL between @tgl1 and @tgl2 and 

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                      Case when A.IsOtorisasi2=1 then 1 else 0 +

                      Case when A.IsOtorisasi3=1 then 1 else 0 +

                      Case when A.IsOtorisasi4=1 then 1 else 0 +

                      Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                 else 1

             As INTEGER) =@NeedOto

		order by  J.NAMACUSTSUPP,a.kodesupp,a.NOBUKTI

	else If @NeedOto=2

		Select 	'Gabungan' Perusahaan,a.NoBukti,a.TANGGAL,J.NAMACUSTSUPP,a.KODEVLS,a.KURS,

            b.NDPP,b.NDPPRp,b.NPPNRp,B.nnetrp

		From  DBRBELI a 

		left outer join DBRBELIDET B on b.NOBUKTI=a.NOBUKTI

		Left Outer Join DBCUSTSUPP J on a.KODESUPP = J.KODECUSTSUPP 

		Where a.TANGGAL between @tgl1 and @tgl2 

		order by  J.NAMACUSTSUPP,a.kodesupp,a.NOBUKTI



Else If @Choice='B'

If @NeedOto=0 or @NeedOto=1

		Select 'Gabungan' Perusahaan,B.KODEBRG,H.NAMABRG,

		Sum(COALESCE(B.Qnt,0)) QNT,Sum(COALESCE(B.Harga,0)) Harga,

        Sum(COALESCE(B.DiscP,0)) DiscP1, Sum(COALESCE(B.DiscTot,0)) DiscRp1, Sum(COALESCE(B.DiscTot,0)) DiscTot,

        Sum(COALESCE(B.SubTotal,0)) TotalUSD, Sum(COALESCE(B.SubTotal,0)) TotalIDR, Sum(COALESCE(B.NDPP,0)) NDPP,

        Sum(COALESCE(B.NPPN,0)) NPPN, Sum(COALESCE(B.BYAngkut,0)) Beban, Sum(COALESCE(B.SubTotal,0)) + Sum(COALESCE(B.BYAngkut,0)) Total

		From dbRBeliDet B 

		Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg 

		left Outer Join DBRBELI A on B.NOBUKTI=A.NOBUKTI

		Left Outer Join DBCUSTSUPP I on A.KODESUPP = I.KODECUSTSUPP

		Where a.TANGGAL between @tgl1 and @tgl2 and 

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                      Case when A.IsOtorisasi2=1 then 1 else 0 +

                      Case when A.IsOtorisasi3=1 then 1 else 0 +

                      Case when A.IsOtorisasi4=1 then 1 else 0 +

                      Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                 else 1

             As INTEGER) =@NeedOto

		Group By B.KODEBRG,H.NAMABRG

		Order by B.KODEBRG,H.NAMABRG

	else If @NeedOto=2

		Select 'Gabungan' Perusahaan,B.KODEBRG,H.NAMABRG,

		Sum(COALESCE(B.Qnt,0)) QNT,Sum(COALESCE(B.Harga,0)) Harga,

        Sum(COALESCE(B.DiscP,0)) DiscP1, Sum(COALESCE(B.DiscTot,0)) DiscRp1, Sum(COALESCE(B.DiscTot,0)) DiscTot,

        Sum(COALESCE(B.SubTotal,0)) TotalUSD, Sum(COALESCE(B.SubTotal,0)) TotalIDR, Sum(COALESCE(B.NDPP,0)) NDPP,

        Sum(COALESCE(B.NPPN,0)) NPPN, Sum(COALESCE(B.BYAngkut,0)) Beban, Sum(COALESCE(B.SubTotal,0)) + Sum(COALESCE(B.BYAngkut,0)) Total

		From dbRBeliDet B 

		Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg 

		left Outer Join DBRBELI A on B.NOBUKTI=A.NOBUKTI

		Left Outer Join DBCUSTSUPP I on A.KODESUPP = I.KODECUSTSUPP

		Where a.TANGGAL between @tgl1 and @tgl2 

		Group By B.KODEBRG,H.NAMABRG

		Order by B.KODEBRG,H.NAMABRG


else--------

if @Choice='N'

If @NeedOto=0 or @NeedOto=1

		Select 	Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,a.NoBukti,a.TANGGAL,J.NAMACUSTSUPP,a.KODEVLS,a.KURS,

            b.NDPP,b.NDPPRp,b.NPPNRp,B.nnetrp

		From  DBRBELI a 

		left outer join DBRBELIDET B on b.NOBUKTI=a.NOBUKTI

		Left Outer Join DBCUSTSUPP J on a.KODESUPP = J.KODECUSTSUPP 

		Where a.TANGGAL between @tgl1 and @tgl2 and 

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                      Case when A.IsOtorisasi2=1 then 1 else 0 +

                      Case when A.IsOtorisasi3=1 then 1 else 0 +

                      Case when A.IsOtorisasi4=1 then 1 else 0 +

                      Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                 else 1

             As INTEGER) =@NeedOto

		order by  a.NOBUKTI,a.TANGGAL

	else If @NeedOto=2

		Select 	Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,a.NoBukti,a.TANGGAL,J.NAMACUSTSUPP,a.KODEVLS,a.KURS,

            b.NDPP,b.NDPPRp,b.NPPNRp,B.nnetrp

		From  DBRBELI a 

		left outer join DBRBELIDET B on b.NOBUKTI=a.NOBUKTI

		Left Outer Join DBCUSTSUPP J on a.KODESUPP = J.KODECUSTSUPP 

		Where a.TANGGAL between @tgl1 and @tgl2 

		and @Id=Case When Len(@ID)=3 Then Left(a.NoBukti,3) else Left(a.NOBUKTI,2)

		order by  a.NOBUKTI,a.TANGGAL


Else if @Choice='S'

If @NeedOto=0 or @NeedOto=1

		Select 	Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,a.NoBukti,a.TANGGAL,J.NAMACUSTSUPP,a.KODEVLS,a.KURS,

            b.NDPP,b.NDPPRp,b.NPPNRp,B.nnetrp

		From  DBRBELI a 

		left outer join DBRBELIDET B on b.NOBUKTI=a.NOBUKTI

		Left Outer Join DBCUSTSUPP J on a.KODESUPP = J.KODECUSTSUPP 

		Where a.TANGGAL between @tgl1 and @tgl2 and 

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                      Case when A.IsOtorisasi2=1 then 1 else 0 +

                      Case when A.IsOtorisasi3=1 then 1 else 0 +

                      Case when A.IsOtorisasi4=1 then 1 else 0 +

                      Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                 else 1

             As INTEGER) =@NeedOto

        and @Id=Case When Len(@ID)=3 Then Left(a.NoBukti,3) else Left(a.NOBUKTI,2)    

		order by  J.NAMACUSTSUPP,a.kodesupp,a.NOBUKTI

	else If @NeedOto=2

		Select 	Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,a.NoBukti,a.TANGGAL,J.NAMACUSTSUPP,a.KODEVLS,a.KURS,

            b.NDPP,b.NDPPRp,b.NPPNRp,B.nnetrp

		From  DBRBELI a 

		left outer join DBRBELIDET B on b.NOBUKTI=a.NOBUKTI

		Left Outer Join DBCUSTSUPP J on a.KODESUPP = J.KODECUSTSUPP 

		Where a.TANGGAL between @tgl1 and @tgl2 

		and @Id=Case When Len(@ID)=3 Then Left(a.NoBukti,3) else Left(a.NOBUKTI,2)

		order by  J.NAMACUSTSUPP,a.kodesupp,a.NOBUKTI



Else If @Choice='B'

If @NeedOto=0 or @NeedOto=1

		Select Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,B.KODEBRG,H.NAMABRG,

		Sum(COALESCE(B.Qnt,0)) QNT,Sum(COALESCE(B.Harga,0)) Harga,

        Sum(COALESCE(B.DiscP,0)) DiscP1, Sum(COALESCE(B.DiscTot,0)) DiscRp1, Sum(COALESCE(B.DiscTot,0)) DiscTot,

        Sum(COALESCE(B.SubTotal,0)) TotalUSD, Sum(COALESCE(B.SubTotal,0)) TotalIDR, Sum(COALESCE(B.NDPP,0)) NDPP,

        Sum(COALESCE(B.NPPN,0)) NPPN, Sum(COALESCE(B.BYAngkut,0)) Beban, Sum(COALESCE(B.SubTotal,0)) + Sum(COALESCE(B.BYAngkut,0)) Total

		From dbRBeliDet B 

		Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg 

		left Outer Join DBRBELI A on B.NOBUKTI=A.NOBUKTI

		Left Outer Join DBCUSTSUPP I on A.KODESUPP = I.KODECUSTSUPP

		Where a.TANGGAL between @tgl1 and @tgl2 and 

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                      Case when A.IsOtorisasi2=1 then 1 else 0 +

                      Case when A.IsOtorisasi3=1 then 1 else 0 +

                      Case when A.IsOtorisasi4=1 then 1 else 0 +

                      Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                 else 1

             As INTEGER) =@NeedOto

        and @Id=Case When Len(@ID)=3 Then Left(a.NoBukti,3) else Left(a.NOBUKTI,2)    

		Group By B.KODEBRG,H.NAMABRG

		Order by B.KODEBRG,H.NAMABRG

	else If @NeedOto=2

		Select Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,B.KODEBRG,H.NAMABRG,

		Sum(COALESCE(B.Qnt,0)) QNT,Sum(COALESCE(B.Harga,0)) Harga,

        Sum(COALESCE(B.DiscP,0)) DiscP1, Sum(COALESCE(B.DiscTot,0)) DiscRp1, Sum(COALESCE(B.DiscTot,0)) DiscTot,

        Sum(COALESCE(B.SubTotal,0)) TotalUSD, Sum(COALESCE(B.SubTotal,0)) TotalIDR, Sum(COALESCE(B.NDPP,0)) NDPP,

        Sum(COALESCE(B.NPPN,0)) NPPN, Sum(COALESCE(B.BYAngkut,0)) Beban, Sum(COALESCE(B.SubTotal,0)) + Sum(COALESCE(B.BYAngkut,0)) Total

		From dbRBeliDet B 

		Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg 

		left Outer Join DBRBELI A on B.NOBUKTI=A.NOBUKTI

		Left Outer Join DBCUSTSUPP I on A.KODESUPP = I.KODECUSTSUPP

		Where a.TANGGAL between @tgl1 and @tgl2 

		and @Id=Case When Len(@ID)=3 Then Left(a.NoBukti,3) else Left(a.NOBUKTI,2)

		Group By B.KODEBRG,H.NAMABRG

		Order by B.KODEBRG,H.NAMABRG;

-- Sp_reportRPenjualanGdgDet
CREATE PROCEDURE IF NOT EXISTS Sp_reportRPenjualanGdgDet AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 



if @Id=''

if @SReport='T'

If @Ordr='N'

		if @NeedOto=0 or @NeedOto=1

			select * from [VwReportRPenjualanGdg] where Tanggal between @tgl1 and @tgl2 and Needotorisasi=@NeedOto

			order by NoBukti,Tanggal

		if @NeedOto=2

			select * from [VwReportRPenjualanGdg] where Tanggal between @tgl1 and @tgl2 

			order by NoBukti,Tanggal

		 

	else If @Ordr='B'

		if @NeedOto=0 or @NeedOto=1

		  select * from [VwReportRPenjualanGdg] where Tanggal between @tgl1 and @tgl2 and Needotorisasi=@NeedOto

		  order by KodeBrg

		 if @NeedOto=2

		  select * from [VwReportRPenjualanGdg] where Tanggal between @tgl1 and @tgl2

		  order by KodeBrg

		 

	else If @Ordr='C'

		if @NeedOto=0 or @NeedOto=1

		  select * from [VwReportRPenjualanGdg] where Tanggal between @tgl1 and @tgl2 and Needotorisasi=@NeedOto

		  order by KodeCustSupp

		if @NeedOto=2

		  select * from [VwReportRPenjualanGdg] where Tanggal between @tgl1 and @tgl2 

		  order by KodeCustSupp

		

	else If @Ordr='S'

		if @NeedOto=0 or @NeedOto=1

		  select * from [VwReportRPenjualanGdg] where Tanggal between @tgl1 and @tgl2 and Needotorisasi=@NeedOto

		  order by KodeCustSupp

		 if @NeedOto=2

		  select * from [VwReportRPenjualanGdg] where Tanggal between @tgl1 and @tgl2 

		  order by KodeCustSupp


else

if @SReport='T'

If @Ordr='N'

		if @NeedOto=0 or @NeedOto=1

			select * from [VwReportRPenjualanGdg] where Tanggal between @tgl1 and @tgl2 and Needotorisasi=@NeedOto and LEFT(@Id,1)=LEFT(NOBUKTI,1)

			order by NoBukti,Tanggal

		if @NeedOto=2

			select * from [VwReportRPenjualanGdg] where Tanggal between @tgl1 and @tgl2  and LEFT(@Id,1)=LEFT(NOBUKTI,1)

			order by NoBukti,Tanggal

		 

	else If @Ordr='B'

		if @NeedOto=0 or @NeedOto=1

		  select * from [VwReportRPenjualanGdg] where Tanggal between @tgl1 and @tgl2 and Needotorisasi=@NeedOto and LEFT(@Id,1)=LEFT(NOBUKTI,1)

		  order by KodeBrg

		 if @NeedOto=2

		  select * from [VwReportRPenjualanGdg] where Tanggal between @tgl1 and @tgl2 and LEFT(@Id,1)=LEFT(NOBUKTI,1)

		  order by KodeBrg

		 

	else If @Ordr='C'

		if @NeedOto=0 or @NeedOto=1

		  select * from [VwReportRPenjualanGdg] where Tanggal between @tgl1 and @tgl2 and Needotorisasi=@NeedOto and LEFT(@Id,1)=LEFT(NOBUKTI,1)

		  order by KodeCustSupp

		if @NeedOto=2

		  select * from [VwReportRPenjualanGdg] where Tanggal between @tgl1 and @tgl2  and LEFT(@Id,1)=LEFT(NOBUKTI,1)

		  order by KodeCustSupp

		

	else If @Ordr='S'

		if @NeedOto=0 or @NeedOto=1

		  select * from [VwReportRPenjualanGdg] where Tanggal between @tgl1 and @tgl2 and Needotorisasi=@NeedOto and LEFT(@Id,1)=LEFT(NOBUKTI,1)

		  order by KodeCustSupp

		 if @NeedOto=2

		  select * from [VwReportRPenjualanGdg] where Tanggal between @tgl1 and @tgl2  and LEFT(@Id,1)=LEFT(NOBUKTI,1)

		  order by KodeCustSupp;

-- Sp_ReportRPenjualanGdgRek
CREATE PROCEDURE IF NOT EXISTS Sp_ReportRPenjualanGdgRek AS ---- DECLARE REMOVED,@Tgl1 DateTime,@Tgl2 Datetime

--Select @Choice='B',@Tgl1='01/01/2011',@Tgl2='01/01/2013'

if @Id=''

If @Choice='N'

If @Needoto=0 or @Needoto=1

		select 	B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,

		sum(COALESCE(B.PPN,0))PPN,sum(COALESCE(B.DISC,0))Disc, 

		sum(COALESCE(B.KURS,0))Kurs, sum(COALESCE(B1.QNT,0)) QNT, sum(COALESCE(B1.QNT2,0))QNT2, 

		sum(COALESCE(B.NetW,0)) NetW,sum(COALESCE(B.GrossW,0))GrossW,

       sum(COALESCE(B.DISCTOT,0))Disctot, 

        sum(COALESCE(B.HRGNETTO,0)) HrgNetto, sum(COALESCE(B.NDISKON,0)) NDiskon, 

        sum(COALESCE(B.SUBTOTAL,0)) SubTotal, sum(COALESCE(B.NDPP,0)) NDPP,

        sum(COALESCE(B.NPPN,0)) NPPN,sum(COALESCE(B.NNET,0)) NNet,

        sum(COALESCE(B.SUBTOTALRp,0)) SubtotalRp, sum(COALESCE(B.NDPPRp,0)) NDPPRP, 

        sum(COALESCE(B.NPPNRp,0)) NPPNRP, sum(COALESCE(B.NNETRp,0)) NNETRP

		from

		dbSPBRJualDet B1 

		Left Outer JOin	DBRInvoicePLDET B on B1.NoRPJ=B.NOBUKTI and B1.UrutRPJ=B.URUT

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBRInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		where A.Tanggal between @Tgl1 and @Tgl2 and       

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER)= @Needoto

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP

		Order by B.NoBukti,A.Tanggal

  else If @Needoto=2

		select 	B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,

		sum(COALESCE(B.PPN,0))PPN,sum(COALESCE(B.DISC,0))Disc, 

		sum(COALESCE(B.KURS,0))Kurs, sum(COALESCE(B1.QNT,0)) QNT, sum(COALESCE(B1.QNT2,0))QNT2, 

		sum(COALESCE(B.NetW,0)) NetW,sum(COALESCE(B.GrossW,0))GrossW,

       sum(COALESCE(B.DISCTOT,0))Disctot, 

        sum(COALESCE(B.HRGNETTO,0)) HrgNetto, sum(COALESCE(B.NDISKON,0)) NDiskon, 

        sum(COALESCE(B.SUBTOTAL,0)) SubTotal, sum(COALESCE(B.NDPP,0)) NDPP,

        sum(COALESCE(B.NPPN,0)) NPPN,sum(COALESCE(B.NNET,0)) NNet,

        sum(COALESCE(B.SUBTOTALRp,0)) SubtotalRp, sum(COALESCE(B.NDPPRp,0)) NDPPRP, 

        sum(COALESCE(B.NPPNRp,0)) NPPNRP, sum(COALESCE(B.NNETRp,0)) NNETRP

		from dbSPBRJualDet B1 

		Left Outer JOin	DBRInvoicePLDET B on B1.NoRPJ=B.NOBUKTI and B1.UrutRPJ=B.URUT

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBRInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		where A.Tanggal between @Tgl1 and @Tgl2       

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP

		Order by B.NoBukti,A.Tanggal



Else If @Choice='B'

If @Needoto=0 or @Needoto=1

		select 	B.KodeBrg,C.NAMABRG,A.Tanggal,sum(COALESCE(B.PPN,0))PPN,sum(COALESCE(B.DISC,0))Disc, 

		sum(COALESCE(B.KURS,0))Kurs, sum(COALESCE(B1.QNT,0)) QNT, sum(COALESCE(B1.QNT2,0))QNT2, 

		sum(COALESCE(B.NetW,0)) NetW,sum(COALESCE(B.GrossW,0))GrossW,

        sum(COALESCE(B.DISCTOT,0))Disctot, 

        sum(COALESCE(B.HRGNETTO,0)) HrgNetto, sum(COALESCE(B.NDISKON,0)) NDiskon, 

        sum(COALESCE(B.SUBTOTAL,0)) SubTotal, sum(COALESCE(B.NDPP,0)) NDPP,

        sum(COALESCE(B.NPPN,0)) NPPN,sum(COALESCE(B.NNET,0)) NNet,

        sum(COALESCE(B.SUBTOTALRp,0)) SubtotalRp, sum(COALESCE(B.NDPPRp,0)) NDPPRP, 

        sum(COALESCE(B.NPPNRp,0)) NPPNRP, sum(COALESCE(B.NNETRp,0)) NNETRP

		from	

		dbSPBRJualDet B1 

		Left Outer JOin	DBRInvoicePLDET B on B1.NoRPJ=B.NOBUKTI and B1.UrutRPJ=B.URUT

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBRInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		where A.Tanggal between @Tgl1 and @Tgl2 and       

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER)= @Needoto

		Group By B.KodeBrg,C.NAMABRG,A.Tanggal

		order By B.KodeBrg,C.NAMABRG,A.Tanggal

	else If @Needoto=2

		select 	B.KodeBrg,C.NAMABRG,A.Tanggal,sum(COALESCE(B.PPN,0))PPN,sum(COALESCE(B.DISC,0))Disc, 

		sum(COALESCE(B.KURS,0))Kurs, sum(COALESCE(B1.QNT,0)) QNT, sum(COALESCE(B1.QNT2,0))QNT2, 

		sum(COALESCE(B.NetW,0)) NetW,sum(COALESCE(B.GrossW,0))GrossW,

        sum(COALESCE(B.DISCTOT,0))Disctot, 

        sum(COALESCE(B.HRGNETTO,0)) HrgNetto, sum(COALESCE(B.NDISKON,0)) NDiskon, 

        sum(COALESCE(B.SUBTOTAL,0)) SubTotal, sum(COALESCE(B.NDPP,0)) NDPP,

        sum(COALESCE(B.NPPN,0)) NPPN,sum(COALESCE(B.NNET,0)) NNet,

        sum(COALESCE(B.SUBTOTALRp,0)) SubtotalRp, sum(COALESCE(B.NDPPRp,0)) NDPPRP, 

        sum(COALESCE(B.NPPNRp,0)) NPPNRP, sum(COALESCE(B.NNETRp,0)) NNETRP

		from	

		dbSPBRJualDet B1 

		Left Outer JOin	DBRInvoicePLDET B on B1.NoRPJ=B.NOBUKTI and B1.UrutRPJ=B.URUT

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBRInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		where A.Tanggal between @Tgl1 and @Tgl2

		Group By B.KodeBrg,C.NAMABRG,A.Tanggal

		order By B.KodeBrg,C.NAMABRG,A.Tanggal



Else If @Choice='C'

If @Needoto=0 or @Needoto=1

		select 	A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal,sum(COALESCE(B.PPN,0))PPN,sum(COALESCE(B.DISC,0))Disc, 

		sum(COALESCE(B.KURS,0))Kurs, sum(COALESCE(B1.QNT,0)) QNT, sum(COALESCE(B1.QNT2,0))QNT2, 

		sum(COALESCE(B.NetW,0)) NetW,sum(COALESCE(B.GrossW,0))GrossW,

        sum(COALESCE(B.DISCTOT,0))Disctot, 

        sum(COALESCE(B.HRGNETTO,0)) HrgNetto, sum(COALESCE(B.NDISKON,0)) NDiskon, 

        sum(COALESCE(B.SUBTOTAL,0)) SubTotal, sum(COALESCE(B.NDPP,0)) NDPP,

        sum(COALESCE(B.NPPN,0)) NPPN,sum(COALESCE(B.NNET,0)) NNet,

        sum(COALESCE(B.SUBTOTALRp,0)) SubtotalRp, sum(COALESCE(B.NDPPRp,0)) NDPPRP, 

        sum(COALESCE(B.NPPNRp,0)) NPPNRP, sum(COALESCE(B.NNETRp,0)) NNETRP

		from	

		dbSPBRJualDet B1 

		Left Outer JOin	DBRInvoicePLDET B on B1.NoRPJ=B.NOBUKTI and B1.UrutRPJ=B.URUT

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBRInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		where A.Tanggal between @Tgl1 and @Tgl2 and       

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER)= @Needoto

		Group By A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal

		order By A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal

	If @Needoto=2

		select 	A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal,sum(COALESCE(B.PPN,0))PPN,sum(COALESCE(B.DISC,0))Disc, 

		sum(COALESCE(B.KURS,0))Kurs, sum(COALESCE(B1.QNT,0)) QNT, sum(COALESCE(B1.QNT2,0))QNT2, 

		sum(COALESCE(B.NetW,0)) NetW,sum(COALESCE(B.GrossW,0))GrossW,

        sum(COALESCE(B.DISCTOT,0))Disctot, 

        sum(COALESCE(B.HRGNETTO,0)) HrgNetto, sum(COALESCE(B.NDISKON,0)) NDiskon, 

        sum(COALESCE(B.SUBTOTAL,0)) SubTotal, sum(COALESCE(B.NDPP,0)) NDPP,

        sum(COALESCE(B.NPPN,0)) NPPN,sum(COALESCE(B.NNET,0)) NNet,

        sum(COALESCE(B.SUBTOTALRp,0)) SubtotalRp, sum(COALESCE(B.NDPPRp,0)) NDPPRP, 

        sum(COALESCE(B.NPPNRp,0)) NPPNRP, sum(COALESCE(B.NNETRp,0)) NNETRP

		from	

		dbSPBRJualDet B1 

		Left Outer JOin	DBRInvoicePLDET B on B1.NoRPJ=B.NOBUKTI and B1.UrutRPJ=B.URUT

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBRInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		where A.Tanggal between @Tgl1 and @Tgl2

		Group By A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal

		order By A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal


Else If @Choice='S'

If @Needoto=0 or @Needoto=1

		select 	A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal,sum(COALESCE(B.PPN,0))PPN,sum(COALESCE(B.DISC,0))Disc, 

		sum(COALESCE(B.KURS,0))Kurs, sum(COALESCE(B1.QNT,0)) QNT, sum(COALESCE(B1.QNT2,0))QNT2, 

		sum(COALESCE(B.NetW,0)) NetW,sum(COALESCE(B.GrossW,0))GrossW,

        sum(COALESCE(B.DISCTOT,0))Disctot, 

        sum(COALESCE(B.HRGNETTO,0)) HrgNetto, sum(COALESCE(B.NDISKON,0)) NDiskon, 

        sum(COALESCE(B.SUBTOTAL,0)) SubTotal, sum(COALESCE(B.NDPP,0)) NDPP,

        sum(COALESCE(B.NPPN,0)) NPPN,sum(COALESCE(B.NNET,0)) NNet,

        sum(COALESCE(B.SUBTOTALRp,0)) SubtotalRp, sum(COALESCE(B.NDPPRp,0)) NDPPRP, 

        sum(COALESCE(B.NPPNRp,0)) NPPNRP, sum(COALESCE(B.NNETRp,0)) NNETRP

		from	

		dbSPBRJualDet B1 

		Left Outer JOin	DBRInvoicePLDET B on B1.NoRPJ=B.NOBUKTI and B1.UrutRPJ=B.URUT

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBRInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		where A.Tanggal between @Tgl1 and @Tgl2 and       

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER)= @Needoto

		Group By A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal

		order By A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal

	If @Needoto=2

		select 	A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal,sum(COALESCE(B.PPN,0))PPN,sum(COALESCE(B.DISC,0))Disc, 

		sum(COALESCE(B.KURS,0))Kurs, sum(COALESCE(B1.QNT,0)) QNT, sum(COALESCE(B1.QNT2,0))QNT2, 

		sum(COALESCE(B.NetW,0)) NetW,sum(COALESCE(B.GrossW,0))GrossW,

        sum(COALESCE(B.DISCTOT,0))Disctot, 

        sum(COALESCE(B.HRGNETTO,0)) HrgNetto, sum(COALESCE(B.NDISKON,0)) NDiskon, 

        sum(COALESCE(B.SUBTOTAL,0)) SubTotal, sum(COALESCE(B.NDPP,0)) NDPP,

        sum(COALESCE(B.NPPN,0)) NPPN,sum(COALESCE(B.NNET,0)) NNet,

        sum(COALESCE(B.SUBTOTALRp,0)) SubtotalRp, sum(COALESCE(B.NDPPRp,0)) NDPPRP, 

        sum(COALESCE(B.NPPNRp,0)) NPPNRP, sum(COALESCE(B.NNETRp,0)) NNETRP

		from	

		dbSPBRJualDet B1 

		Left Outer JOin	DBRInvoicePLDET B on B1.NoRPJ=B.NOBUKTI and B1.UrutRPJ=B.URUT

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBRInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		where A.Tanggal between @Tgl1 and @Tgl2

		Group By A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal

		order By A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal


else

If @Choice='N'

If @Needoto=0 or @Needoto=1

		select 	B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,

		sum(COALESCE(B.PPN,0))PPN,sum(COALESCE(B.DISC,0))Disc, 

		sum(COALESCE(B.KURS,0))Kurs, sum(COALESCE(B1.QNT,0)) QNT, sum(COALESCE(B1.QNT2,0))QNT2, 

		sum(COALESCE(B.NetW,0)) NetW,sum(COALESCE(B.GrossW,0))GrossW,

       sum(COALESCE(B.DISCTOT,0))Disctot, 

        sum(COALESCE(B.HRGNETTO,0)) HrgNetto, sum(COALESCE(B.NDISKON,0)) NDiskon, 

        sum(COALESCE(B.SUBTOTAL,0)) SubTotal, sum(COALESCE(B.NDPP,0)) NDPP,

        sum(COALESCE(B.NPPN,0)) NPPN,sum(COALESCE(B.NNET,0)) NNet,

        sum(COALESCE(B.SUBTOTALRp,0)) SubtotalRp, sum(COALESCE(B.NDPPRp,0)) NDPPRP, 

        sum(COALESCE(B.NPPNRp,0)) NPPNRP, sum(COALESCE(B.NNETRp,0)) NNETRP

		from

		dbSPBRJualDet B1 

		Left Outer JOin	DBRInvoicePLDET B on B1.NoRPJ=B.NOBUKTI and B1.UrutRPJ=B.URUT

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBRInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		where A.Tanggal between @Tgl1 and @Tgl2 and LEFT(@Id,1)=LEFT(B1.NoBukti,1) and       

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER)= @Needoto

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP

		Order by B.NoBukti,A.Tanggal

  else If @Needoto=2

		select 	B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,

		sum(COALESCE(B.PPN,0))PPN,sum(COALESCE(B.DISC,0))Disc, 

		sum(COALESCE(B.KURS,0))Kurs, sum(COALESCE(B1.QNT,0)) QNT, sum(COALESCE(B1.QNT2,0))QNT2, 

		sum(COALESCE(B.NetW,0)) NetW,sum(COALESCE(B.GrossW,0))GrossW,

       sum(COALESCE(B.DISCTOT,0))Disctot, 

        sum(COALESCE(B.HRGNETTO,0)) HrgNetto, sum(COALESCE(B.NDISKON,0)) NDiskon, 

        sum(COALESCE(B.SUBTOTAL,0)) SubTotal, sum(COALESCE(B.NDPP,0)) NDPP,

        sum(COALESCE(B.NPPN,0)) NPPN,sum(COALESCE(B.NNET,0)) NNet,

        sum(COALESCE(B.SUBTOTALRp,0)) SubtotalRp, sum(COALESCE(B.NDPPRp,0)) NDPPRP, 

        sum(COALESCE(B.NPPNRp,0)) NPPNRP, sum(COALESCE(B.NNETRp,0)) NNETRP

		from dbSPBRJualDet B1 

		Left Outer JOin	DBRInvoicePLDET B on B1.NoRPJ=B.NOBUKTI and B1.UrutRPJ=B.URUT

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBRInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		where A.Tanggal between @Tgl1 and @Tgl2  and LEFT(@Id,1)=LEFT(B1.NoBukti,1)     

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP

		Order by B.NoBukti,A.Tanggal



Else If @Choice='B'

If @Needoto=0 or @Needoto=1

		select 	B.KodeBrg,C.NAMABRG,A.Tanggal,sum(COALESCE(B.PPN,0))PPN,sum(COALESCE(B.DISC,0))Disc, 

		sum(COALESCE(B.KURS,0))Kurs, sum(COALESCE(B1.QNT,0)) QNT, sum(COALESCE(B1.QNT2,0))QNT2, 

		sum(COALESCE(B.NetW,0)) NetW,sum(COALESCE(B.GrossW,0))GrossW,

        sum(COALESCE(B.DISCTOT,0))Disctot, 

        sum(COALESCE(B.HRGNETTO,0)) HrgNetto, sum(COALESCE(B.NDISKON,0)) NDiskon, 

        sum(COALESCE(B.SUBTOTAL,0)) SubTotal, sum(COALESCE(B.NDPP,0)) NDPP,

        sum(COALESCE(B.NPPN,0)) NPPN,sum(COALESCE(B.NNET,0)) NNet,

        sum(COALESCE(B.SUBTOTALRp,0)) SubtotalRp, sum(COALESCE(B.NDPPRp,0)) NDPPRP, 

        sum(COALESCE(B.NPPNRp,0)) NPPNRP, sum(COALESCE(B.NNETRp,0)) NNETRP

		from	

		dbSPBRJualDet B1 

		Left Outer JOin	DBRInvoicePLDET B on B1.NoRPJ=B.NOBUKTI and B1.UrutRPJ=B.URUT

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBRInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		where A.Tanggal between @Tgl1 and @Tgl2 and LEFT(@Id,1)=LEFT(B1.NoBukti,1) and       

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER)= @Needoto

		Group By B.KodeBrg,C.NAMABRG,A.Tanggal

		order By B.KodeBrg,C.NAMABRG,A.Tanggal

	else If @Needoto=2

		select 	B.KodeBrg,C.NAMABRG,A.Tanggal,sum(COALESCE(B.PPN,0))PPN,sum(COALESCE(B.DISC,0))Disc, 

		sum(COALESCE(B.KURS,0))Kurs, sum(COALESCE(B1.QNT,0)) QNT, sum(COALESCE(B1.QNT2,0))QNT2, 

		sum(COALESCE(B.NetW,0)) NetW,sum(COALESCE(B.GrossW,0))GrossW,

        sum(COALESCE(B.DISCTOT,0))Disctot, 

        sum(COALESCE(B.HRGNETTO,0)) HrgNetto, sum(COALESCE(B.NDISKON,0)) NDiskon, 

        sum(COALESCE(B.SUBTOTAL,0)) SubTotal, sum(COALESCE(B.NDPP,0)) NDPP,

        sum(COALESCE(B.NPPN,0)) NPPN,sum(COALESCE(B.NNET,0)) NNet,

        sum(COALESCE(B.SUBTOTALRp,0)) SubtotalRp, sum(COALESCE(B.NDPPRp,0)) NDPPRP, 

        sum(COALESCE(B.NPPNRp,0)) NPPNRP, sum(COALESCE(B.NNETRp,0)) NNETRP

		from	

		dbSPBRJualDet B1 

		Left Outer JOin	DBRInvoicePLDET B on B1.NoRPJ=B.NOBUKTI and B1.UrutRPJ=B.URUT

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBRInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		where A.Tanggal between @Tgl1 and @Tgl2 and LEFT(@Id,1)=LEFT(B1.NoBukti,1)

		Group By B.KodeBrg,C.NAMABRG,A.Tanggal

		order By B.KodeBrg,C.NAMABRG,A.Tanggal



Else If @Choice='C'

If @Needoto=0 or @Needoto=1

		select 	A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal,sum(COALESCE(B.PPN,0))PPN,sum(COALESCE(B.DISC,0))Disc, 

		sum(COALESCE(B.KURS,0))Kurs, sum(COALESCE(B1.QNT,0)) QNT, sum(COALESCE(B1.QNT2,0))QNT2, 

		sum(COALESCE(B.NetW,0)) NetW,sum(COALESCE(B.GrossW,0))GrossW,

        sum(COALESCE(B.DISCTOT,0))Disctot, 

        sum(COALESCE(B.HRGNETTO,0)) HrgNetto, sum(COALESCE(B.NDISKON,0)) NDiskon, 

        sum(COALESCE(B.SUBTOTAL,0)) SubTotal, sum(COALESCE(B.NDPP,0)) NDPP,

        sum(COALESCE(B.NPPN,0)) NPPN,sum(COALESCE(B.NNET,0)) NNet,

        sum(COALESCE(B.SUBTOTALRp,0)) SubtotalRp, sum(COALESCE(B.NDPPRp,0)) NDPPRP, 

        sum(COALESCE(B.NPPNRp,0)) NPPNRP, sum(COALESCE(B.NNETRp,0)) NNETRP

		from	

		dbSPBRJualDet B1 

		Left Outer JOin	DBRInvoicePLDET B on B1.NoRPJ=B.NOBUKTI and B1.UrutRPJ=B.URUT

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBRInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		where A.Tanggal between @Tgl1 and @Tgl2 and LEFT(@Id,1)=LEFT(B1.NoBukti,1) and       

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER)= @Needoto

		Group By A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal

		order By A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal

	If @Needoto=2

		select 	A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal,sum(COALESCE(B.PPN,0))PPN,sum(COALESCE(B.DISC,0))Disc, 

		sum(COALESCE(B.KURS,0))Kurs, sum(COALESCE(B1.QNT,0)) QNT, sum(COALESCE(B1.QNT2,0))QNT2, 

		sum(COALESCE(B.NetW,0)) NetW,sum(COALESCE(B.GrossW,0))GrossW,

        sum(COALESCE(B.DISCTOT,0))Disctot, 

        sum(COALESCE(B.HRGNETTO,0)) HrgNetto, sum(COALESCE(B.NDISKON,0)) NDiskon, 

        sum(COALESCE(B.SUBTOTAL,0)) SubTotal, sum(COALESCE(B.NDPP,0)) NDPP,

        sum(COALESCE(B.NPPN,0)) NPPN,sum(COALESCE(B.NNET,0)) NNet,

        sum(COALESCE(B.SUBTOTALRp,0)) SubtotalRp, sum(COALESCE(B.NDPPRp,0)) NDPPRP, 

        sum(COALESCE(B.NPPNRp,0)) NPPNRP, sum(COALESCE(B.NNETRp,0)) NNETRP

		from	

		dbSPBRJualDet B1 

		Left Outer JOin	DBRInvoicePLDET B on B1.NoRPJ=B.NOBUKTI and B1.UrutRPJ=B.URUT

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBRInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		where A.Tanggal between @Tgl1 and @Tgl2 and LEFT(@Id,1)=LEFT(B1.NoBukti,1)

		Group By A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal

		order By A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal


Else If @Choice='S'

If @Needoto=0 or @Needoto=1

		select 	A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal,sum(COALESCE(B.PPN,0))PPN,sum(COALESCE(B.DISC,0))Disc, 

		sum(COALESCE(B.KURS,0))Kurs, sum(COALESCE(B1.QNT,0)) QNT, sum(COALESCE(B1.QNT2,0))QNT2, 

		sum(COALESCE(B.NetW,0)) NetW,sum(COALESCE(B.GrossW,0))GrossW,

        sum(COALESCE(B.DISCTOT,0))Disctot, 

        sum(COALESCE(B.HRGNETTO,0)) HrgNetto, sum(COALESCE(B.NDISKON,0)) NDiskon, 

        sum(COALESCE(B.SUBTOTAL,0)) SubTotal, sum(COALESCE(B.NDPP,0)) NDPP,

        sum(COALESCE(B.NPPN,0)) NPPN,sum(COALESCE(B.NNET,0)) NNet,

        sum(COALESCE(B.SUBTOTALRp,0)) SubtotalRp, sum(COALESCE(B.NDPPRp,0)) NDPPRP, 

        sum(COALESCE(B.NPPNRp,0)) NPPNRP, sum(COALESCE(B.NNETRp,0)) NNETRP

		from	

		dbSPBRJualDet B1 

		Left Outer JOin	DBRInvoicePLDET B on B1.NoRPJ=B.NOBUKTI and B1.UrutRPJ=B.URUT

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBRInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		where A.Tanggal between @Tgl1 and @Tgl2 and LEFT(@Id,1)=LEFT(B1.NoBukti,1) and       

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER)= @Needoto

		Group By A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal

		order By A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal

	If @Needoto=2

		select 	A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal,sum(COALESCE(B.PPN,0))PPN,sum(COALESCE(B.DISC,0))Disc, 

		sum(COALESCE(B.KURS,0))Kurs, sum(COALESCE(B1.QNT,0)) QNT, sum(COALESCE(B1.QNT2,0))QNT2, 

		sum(COALESCE(B.NetW,0)) NetW,sum(COALESCE(B.GrossW,0))GrossW,

        sum(COALESCE(B.DISCTOT,0))Disctot, 

        sum(COALESCE(B.HRGNETTO,0)) HrgNetto, sum(COALESCE(B.NDISKON,0)) NDiskon, 

        sum(COALESCE(B.SUBTOTAL,0)) SubTotal, sum(COALESCE(B.NDPP,0)) NDPP,

        sum(COALESCE(B.NPPN,0)) NPPN,sum(COALESCE(B.NNET,0)) NNet,

        sum(COALESCE(B.SUBTOTALRp,0)) SubtotalRp, sum(COALESCE(B.NDPPRp,0)) NDPPRP, 

        sum(COALESCE(B.NPPNRp,0)) NPPNRP, sum(COALESCE(B.NNETRp,0)) NNETRP

		from	

		dbSPBRJualDet B1 

		Left Outer JOin	DBRInvoicePLDET B on B1.NoRPJ=B.NOBUKTI and B1.UrutRPJ=B.URUT

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBRInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		where A.Tanggal between @Tgl1 and @Tgl2 and LEFT(@Id,1)=LEFT(B1.NoBukti,1)

		Group By A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal

		order By A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal


--select * from DBEXPEDISI;

-- Sp_reportRPenyerahanBahan
CREATE PROCEDURE IF NOT EXISTS Sp_reportRPenyerahanBahan AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 



if @SReport='T'

If @Ordr='N'

		If @NeedOto=0 or @NeedOto=1

		  select * from VwReportRPenyerahanBahan where Tanggal between @tgl1 and @tgl2 And NeEdOtorisasi=@NeedOto

		   order by NoBukti,Tanggal

		If @NeedOto=2

		  select * from VwReportRPenyerahanBahan where Tanggal between @tgl1 and @tgl2 

		   order by NoBukti,Tanggal

		 

	else If @Ordr='B'

		If @NeedOto=0 Or @NeedOto=1

		  select * from VwReportRPenyerahanBahan where Tanggal between @tgl1 and @tgl2 And NeEdOtorisasi=@NeedOto

		  order by KodeBrg

		If @NeedOto=2

		  select * from VwReportRPenyerahanBahan where Tanggal between @tgl1 and @tgl2 

		  order by KodeBrg;

-- Sp_reportRPenyerahanBahanRek
CREATE PROCEDURE IF NOT EXISTS Sp_reportRPenyerahanBahanRek AS ---- DECLARE REMOVED,@Tgl1 datetime,@tgl2 Datetime

--Select @Choice='N',@Tgl1='01/01/2011',@tgl2='01/01/2013'



If @Choice='N'

If @NeedOto=0 Or @NeedOto=1

	Select 	A.NoBukti,A.Tanggal,Sum(COALESCE(B.Qnt,0)) Qnt,SUM(COALESCE(B.Qnt2,0)) Qnt2

	From dbRPenyerahanBhn A

	Left Outer join  dbRPenyerahanBhnDet B on B.NoBukti=a.NoBukti

	Left Outer join dbBarang H on H.KodeBrg=b.KodeBrg  

	where A.Tanggal between @Tgl1 and @tgl2 And

	Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                      Case when A.IsOtorisasi2=1 then 1 else 0 +

                      Case when A.IsOtorisasi3=1 then 1 else 0 +

                      Case when A.IsOtorisasi4=1 then 1 else 0 +

                      Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                 else 1

             As INTEGER)=@NeedOto 

	Group By A.NoBukti,A.Tanggal

 else If @NeedOto=2

	Select 	A.NoBukti,A.Tanggal,Sum(COALESCE(B.Qnt,0)) Qnt,SUM(COALESCE(B.Qnt2,0)) Qnt2

	From dbRPenyerahanBhn A

	Left Outer join  dbRPenyerahanBhnDet B on B.NoBukti=a.NoBukti

	Left Outer join dbBarang H on H.KodeBrg=b.KodeBrg  

	where A.Tanggal between @Tgl1 and @tgl2  

	Group By A.NoBukti,A.Tanggal



else If @Choice='B'

If @NeedOto=0 Or @NeedOto=1

	Select 	B.kodebrg,H.NAMABRG,A.Tanggal,Sum(COALESCE(B.Qnt,0)) Qnt,SUM(COALESCE(B.Qnt2,0)) Qnt2

	From dbRPenyerahanBhn A

	Left Outer join  dbRPenyerahanBhnDet B on B.NoBukti=a.NoBukti

	Left Outer join dbBarang H on H.KodeBrg=b.KodeBrg  

	where A.Tanggal between @Tgl1 and @tgl2 And

	Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                      Case when A.IsOtorisasi2=1 then 1 else 0 +

                      Case when A.IsOtorisasi3=1 then 1 else 0 +

                      Case when A.IsOtorisasi4=1 then 1 else 0 +

                      Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                 else 1

             As INTEGER)=@NeedOto 

	

	Group By 	B.kodebrg,H.NAMABRG,A.Tanggal

 else If @NeedOto=2

	Select 	B.kodebrg,H.NAMABRG,A.Tanggal,Sum(COALESCE(B.Qnt,0)) Qnt,SUM(COALESCE(B.Qnt2,0)) Qnt2

	From dbRPenyerahanBhn A

	Left Outer join  dbRPenyerahanBhnDet B on B.NoBukti=a.NoBukti

	Left Outer join dbBarang H on H.KodeBrg=b.KodeBrg  

	where A.Tanggal between @Tgl1 and @tgl2 

	Group By 	B.kodebrg,H.NAMABRG,A.Tanggal;

-- Sp_reportRPLInvoiceDet
CREATE PROCEDURE IF NOT EXISTS Sp_reportRPLInvoiceDet AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 



if @SReport='T'

If @Ordr='N'

		select * from VwReportRPLInvoice where Tanggal between @tgl1 and @tgl2 order by NoBukti,Tanggal

		 

	else If @Ordr='B'

		select * from VwReportRPLInvoice where Tanggal between @tgl1 and @tgl2 order by KodeBrg

		 

	else If @Ordr='C'

		select * from VwReportRPLInvoice where Tanggal between @tgl1 and @tgl2 order by KodeCustSupp;

-- Sp_ReportRPLInvoiceRek
CREATE PROCEDURE IF NOT EXISTS Sp_ReportRPLInvoiceRek AS ---- DECLARE REMOVED,@Tgl1 DateTime,@Tgl2 Datetime

--Select @Choice='B',@Tgl1='01/01/2011',@Tgl2='01/01/2013'



If @Choice='N'

select 	B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,

		sum(COALESCE(B.PPN,0))PPN,sum(COALESCE(B.DISC,0))Disc, 

		sum(COALESCE(B.KURS,0))Kurs, sum(COALESCE(B.QNT,0)) QNT, sum(COALESCE(B.QNT2,0))QNT2, 

		sum(COALESCE(B.NetW,0)) NetW,sum(COALESCE(B.GrossW,0))GrossW,

       sum(COALESCE(B.DISCTOT,0))Disctot, 

        sum(COALESCE(B.HRGNETTO,0)) HrgNetto, sum(COALESCE(B.NDISKON,0)) NDiskon, 

        sum(COALESCE(B.SUBTOTAL,0)) SubTotal, sum(COALESCE(B.NDPP,0)) NDPP,

        sum(COALESCE(B.NPPN,0)) NPPN,sum(COALESCE(B.NNET,0)) NNet,

        sum(COALESCE(B.SUBTOTALRp,0)) SubtotalRp, sum(COALESCE(B.NDPPRp,0)) NDPPRP, 

        sum(COALESCE(B.NPPNRp,0)) NPPNRP, sum(COALESCE(B.NNETRp,0)) NNETRP

		from	DBRInvoicePLDET B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBRInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP

		Order by B.NoBukti,A.Tanggal



Else If @Choice='B'

select 	B.KodeBrg,C.NAMABRG,A.Tanggal,sum(COALESCE(B.PPN,0))PPN,sum(COALESCE(B.DISC,0))Disc, 

		sum(COALESCE(B.KURS,0))Kurs, sum(COALESCE(B.QNT,0)) QNT, sum(COALESCE(B.QNT2,0))QNT2, 

		sum(COALESCE(B.NetW,0)) NetW,sum(COALESCE(B.GrossW,0))GrossW,

        sum(COALESCE(B.DISCTOT,0))Disctot, 

        sum(COALESCE(B.HRGNETTO,0)) HrgNetto, sum(COALESCE(B.NDISKON,0)) NDiskon, 

        sum(COALESCE(B.SUBTOTAL,0)) SubTotal, sum(COALESCE(B.NDPP,0)) NDPP,

        sum(COALESCE(B.NPPN,0)) NPPN,sum(COALESCE(B.NNET,0)) NNet,

        sum(COALESCE(B.SUBTOTALRp,0)) SubtotalRp, sum(COALESCE(B.NDPPRp,0)) NDPPRP, 

        sum(COALESCE(B.NPPNRp,0)) NPPNRP, sum(COALESCE(B.NNETRp,0)) NNETRP

		from	DBRInvoicePLDET B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBRInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		Group By B.KodeBrg,C.NAMABRG,A.Tanggal

		order By B.KodeBrg,C.NAMABRG,A.Tanggal



Else If @Choice='C'

select 	A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal,sum(COALESCE(B.PPN,0))PPN,sum(COALESCE(B.DISC,0))Disc, 

		sum(COALESCE(B.KURS,0))Kurs, sum(COALESCE(B.QNT,0)) QNT, sum(COALESCE(B.QNT2,0))QNT2, 

		sum(COALESCE(B.NetW,0)) NetW,sum(COALESCE(B.GrossW,0))GrossW,

        sum(COALESCE(B.DISCTOT,0))Disctot, 

        sum(COALESCE(B.HRGNETTO,0)) HrgNetto, sum(COALESCE(B.NDISKON,0)) NDiskon, 

        sum(COALESCE(B.SUBTOTAL,0)) SubTotal, sum(COALESCE(B.NDPP,0)) NDPP,

        sum(COALESCE(B.NPPN,0)) NPPN,sum(COALESCE(B.NNET,0)) NNet,

        sum(COALESCE(B.SUBTOTALRp,0)) SubtotalRp, sum(COALESCE(B.NDPPRp,0)) NDPPRP, 

        sum(COALESCE(B.NPPNRp,0)) NPPNRP, sum(COALESCE(B.NNETRp,0)) NNETRP

		from	DBRInvoicePLDET B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBRInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		Group By A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal

		order By A.KodeCustSupp,D.NAMACUSTSUPP,A.Tanggal;

-- Sp_ReportRSPBDET
CREATE PROCEDURE IF NOT EXISTS Sp_ReportRSPBDET AS ---- DECLARE REMOVED,@Tgl1 Datetime,@tgl2 datetime

--select @Tgl1='01/01/2012',@tgl2='07/17/2013',@Choice='B'

select @Id=SUBSTRING(@Id,1,1)

if @Id='' 

If @Choice='N'

		--select * from VIEWREPORTRSPB where Tanggal between @tgl1 and @tgl2 order by NoBukti,TANGGAL

	       if @isiList=''

			exec('select ''Gabungan'' Perusahaan,* from VIEWREPORTRSPB where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

			order by NoBukti,Tanggal')

		   else

		   	exec('select ''Gabungan'' Perusahaan,* from VIEWREPORTRSPB where NoBukti IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

			order by NoBukti,Tanggal')

		 

else If @Choice='B'

		-- select * from VIEWREPORTRSPB where Tanggal between @tgl1 and @tgl2 order by KodeBrg

		 if @isiList=''

			exec('select ''Gabungan'' Perusahaan,* from VIEWREPORTRSPB where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

			order by Kodebrg,namabrg,Tanggal')

		 else

			exec('select ''Gabungan'' Perusahaan,* from VIEWREPORTRSPB where NoBukti IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

			order by Kodebrg,namabrg,Tanggal')

		 

else If @Choice='C'

		--select * from VIEWREPORTRSPB where Tanggal between @tgl1 and @tgl2 order by KODECUSTSUPP

		 if @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VIEWREPORTRSPB where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  order by KODECUSTSUPP ')

		  else

		  exec('select ''Gabungan'' Perusahaan,* from VIEWREPORTRSPB where KODECUSTSUPP IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  

		  order by KODECUSTSUPP')  


else

If @Choice='N'

		--select * from VIEWREPORTRSPB where Tanggal between @tgl1 and @tgl2 order by NoBukti,TANGGAL

	       if @isiList=''

			exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VIEWREPORTRSPB where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

			and '''+@ID+'''= Left(NoBukti,1)

			order by NoBukti,Tanggal')

		   else

		   	exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VIEWREPORTRSPB where NoBukti IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

			and '''+@ID+'''= Left(NoBukti,1)

			order by NoBukti,Tanggal')

		 

else If @Choice='B'

		-- select * from VIEWREPORTRSPB where Tanggal between @tgl1 and @tgl2 order by KodeBrg

		 if @isiList=''

			exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VIEWREPORTRSPB where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

			and '''+@ID+'''= Left(NoBukti,1)

			order by Kodebrg,namabrg,Tanggal')

		 else

			exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VIEWREPORTRSPB where NoBukti IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

			and '''+@ID+'''= Left(NoBukti,1)

			order by Kodebrg,namabrg,Tanggal')

		 

else If @Choice='C'

		--select * from VIEWREPORTRSPB where Tanggal between @tgl1 and @tgl2 order by KODECUSTSUPP

		 if @isiList=''

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VIEWREPORTRSPB where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KODECUSTSUPP ')

		  else

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VIEWREPORTRSPB where KODECUSTSUPP IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KODECUSTSUPP');

-- sp_ReportSaldoHutang
CREATE PROCEDURE IF NOT EXISTS sp_ReportSaldoHutang AS --select @Perkiraan='131',@Tanggal1='2016-12-01',@Tanggal2='2016-12-31',@Awal='A0000013',@Akhir='A0000013',@Devisi='01',@Tipe=1,@KodeVls='IDR'

-- SET REMOVEDCase when @devisi in ('-','') then '%' else @devisi 

if @tipe=0 

Select 	H.KodeCustSupp Kode, COALESCE(S.NAMACUSTSUPP,'') Nama, COALESCE(S.Kota,'') Kota,

		sum(case when H.Tanggal<@Tanggal1 then COALESCE(Kredit,0)-COALESCE(Debet,0) else 0 ) Awal,

		sum(case when H.Tanggal>=@Tanggal1 and H.tanggal<=@Tanggal2 and H.NoRetur='' then COALESCE(H.Kredit,0) else 0 ) Jumlah,

		sum(case when H.Tanggal>=@Tanggal1 and H.tanggal<=@Tanggal2 and H.NoRetur='' then COALESCE(H.Debet,0) else 0 ) Pelunasan,

		sum(case when H.Tanggal>=@Tanggal1 and H.tanggal<=@Tanggal2 and H.NoRetur<>'' then COALESCE(H.Debet,0) else 0 ) Retur,

		sum(COALESCE(Kredit,0)-COALESCE(Debet,0)) SaldoAkhir,

		sum(case when H.Tanggal<@Tanggal1 then COALESCE(Kreditd,0)-COALESCE(Debetd,0) else 0 ) AwalD,

		sum(case when H.Tanggal>=@Tanggal1 and H.tanggal<=@Tanggal2 and H.NoRetur='' then COALESCE(H.Kreditd,0) else 0 ) JumlahD,

		sum(case when H.Tanggal>=@Tanggal1 and H.tanggal<=@Tanggal2 and H.NoRetur='' then COALESCE(H.Debetd,0) else 0 ) PelunasanD,

		sum(case when H.Tanggal>=@Tanggal1 and H.tanggal<=@Tanggal2 and H.NoRetur<>'' then COALESCE(H.Debetd,0) else 0 ) ReturD,

		sum(COALESCE(Kreditd,0)-COALESCE(Debetd,0)) SaldoAkhirD

 	from vwHutpiut H

 	left outer join DBCUSTSUPP S on S.KODECUSTSUPP=H.KodeCustSupp

 	where H.Tanggal<=@Tanggal2 and (H.KodeCustSupp between @awal and @akhir) and H.perkiraan=@perkiraan and H.Tipe='HT'

 	and (H.Devisi like @devisi) 	

 	group by H.KodeCustSupp, S.NAMACUSTSUPP, S.kota

 	Having

 	   sum(case when H.Tanggal<@Tanggal1 then COALESCE(Kredit,0)-COALESCE(Debet,0) else 0 )<>0 or

		sum(case when H.Tanggal>=@Tanggal1 and H.tanggal<=@Tanggal2 and H.NoRetur='' then COALESCE(H.Kredit,0) else 0 ) <>0 or

		sum(case when H.Tanggal>=@Tanggal1 and H.tanggal<=@Tanggal2 and H.NoRetur='' then COALESCE(H.Debet,0) else 0 ) <>0 or

		sum(case when H.Tanggal>=@Tanggal1 and H.tanggal<=@Tanggal2 and H.NoRetur<>'' then COALESCE(H.Debet,0) else 0 ) <>0 or

		sum(COALESCE(Kredit,0)-COALESCE(Debet,0)) <>0 or

		sum(case when H.Tanggal<@Tanggal1 then COALESCE(Kreditd,0)-COALESCE(Debetd,0) else 0 ) <>0 or

		sum(case when H.Tanggal>=@Tanggal1 and H.tanggal<=@Tanggal2 and H.NoRetur='' then COALESCE(H.Kreditd,0) else 0 ) <>0 or

		sum(case when H.Tanggal>=@Tanggal1 and H.tanggal<=@Tanggal2 and H.NoRetur='' then COALESCE(H.Debetd,0) else 0 ) <>0 or

		sum(case when H.Tanggal>=@Tanggal1 and H.tanggal<=@Tanggal2 and H.NoRetur<>'' then COALESCE(H.Debetd,0) else 0 ) <>0 or

		sum(COALESCE(Kreditd,0)-COALESCE(Debetd,0)) <>0 



else

Select Kode,Nama,Kota,SUM(Awal)Awal,SUM(Jumlah)Jumlah,SUM(Pelunasan)Pelunasan,SUM(Retur)Retur,

 SUM(SaldoAkhir)SaldoAkhir,SUM(AwalD)AwalD,SUM(JumlahD)JumlahD,SUM(PelunasanD)PelunasanD,SUM(ReturD),SUM(SaldoAkhirD),

 case when SUM(SaldoAkhir)=0 then 0 when SUM(SaldoAkhir)<0 then SUM(Saldo30)+SUM(Saldo60)+SUM(Saldo90)+SUM(Saldo120)+SUM(Saldo121) else SUM(Saldo30)  Saldo30,

 case when SUM(SaldoAkhir)<=0 then 0 else SUM(Saldo60)  Saldo60,

 case when SUM(SaldoAkhir)<=0 then 0 else SUM(Saldo90)  Saldo90,

 case when SUM(SaldoAkhir)<=0 then 0 else SUM(Saldo120)  Saldo120,

 case when SUM(SaldoAkhir)<=0 then 0 else  SUM(Saldo121)  Saldo121 from(

	Select 	H.KodeCustSupp Kode, COALESCE(S.NAMACUSTSUPP,'') Nama, COALESCE(S.Kota,'') Kota,

		sum(case when H.Tanggal<@Tanggal1 then COALESCE(Debet,0)-COALESCE(Kredit,0) else 0 ) Awal,

		sum(case when H.Tanggal>=@Tanggal1 then COALESCE(H.Debet,0) else 0 ) Jumlah,

		sum(case when H.Tanggal>=@Tanggal1 and H.NoRetur='' then COALESCE(H.Kredit,0) else 0 ) Pelunasan,

		sum(case when H.Tanggal>=@Tanggal1 and H.NoRetur<>'' then COALESCE(H.Kredit,0) else 0 ) Retur,

		sum(COALESCE(Debet,0)-COALESCE(Kredit,0)) SaldoAkhir,

		sum(case when H.Tanggal<@Tanggal1 then COALESCE(Debetd,0)-COALESCE(Kreditd,0) else 0 ) AwalD,

		sum(case when H.Tanggal>=@Tanggal1 then COALESCE(H.Debetd,0) else 0 ) JumlahD,

		sum(case when H.Tanggal>=@Tanggal1 and H.NoRetur='' then COALESCE(H.Kreditd,0) else 0 ) PelunasanD,

		sum(case when H.Tanggal>=@Tanggal1 and H.NoRetur<>'' then COALESCE(H.Kreditd,0) else 0 ) ReturD,

		sum(COALESCE(Debetd,0)-COALESCE(Kreditd,0)) SaldoAkhirD,

		Case when (datepart(dy,@Tanggal2-min(H.Tanggal))> 0) and (datepart(dy,@Tanggal2-min(H.Tanggal))<= 30) then

  			case when @KodeVls='IDR' then sum(COALESCE(H.Debet,0)-COALESCE(H.Kredit,0)) else sum(COALESCE(H.DebetD,0)-COALESCE(H.KreditD,0)) 

         		else 0  as Saldo30,

        case when (datepart(dy,@Tanggal2-min(H.Tanggal))> 30) and (datepart(dy,@Tanggal2-min(H.Tanggal))<= 60) then

  			case when @KodeVls='IDR' then sum(COALESCE(H.Debet,0)-COALESCE(H.Kredit,0)) else sum(COALESCE(H.DebetD,0)-COALESCE(H.KreditD,0)) 

         		else 0  as Saldo60,

        case when (datepart(dy,@Tanggal2-min(H.Tanggal))> 60) and (datepart(dy,@Tanggal2-min(H.Tanggal))<= 90) then

  			case when @KodeVls='IDR' then sum(COALESCE(H.Debet,0)-COALESCE(H.Kredit,0)) else sum(COALESCE(H.DebetD,0)-COALESCE(H.KreditD,0)) 

         		else 0  as Saldo90,

        case when (datepart(dy,@Tanggal2-min(H.Tanggal))> 90) and (datepart(dy,@Tanggal2-min(H.Tanggal))<= 120) then

  			case when @KodeVls='IDR' then sum(COALESCE(H.Debet,0)-COALESCE(H.Kredit,0)) else sum(COALESCE(H.DebetD,0)-COALESCE(H.KreditD,0)) 

         		else 0  as Saldo120,

        case when (datepart(dy,@Tanggal2-min(H.Tanggal))> 120) then

  			case when @KodeVls='IDR' then sum(COALESCE(H.Debet,0)-COALESCE(H.Kredit,0)) else sum(COALESCE(H.DebetD,0)-COALESCE(H.KreditD,0)) 

         		else 0  as Saldo121,min(H.Tanggal)Tanggal

 	from vwHutpiut H

 	left outer join DBCUSTSUPP S on S.KODECUSTSUPP=H.KodeCustSupp

 	where H.Tanggal<=@Tanggal2 and H.KodeCustSupp>=@awal and H.KodeCustSupp<=@akhir and H.perkiraan=@perkiraan and H.Tipe='PT'

 	and (H.Devisi like @devisi) 	

 	group by H.KodeCustSupp, S.NAMACUSTSUPP, S.Kota,H.NoFaktur

 	having sum(case when H.Tanggal<@Tanggal1 then COALESCE(Debet,0)-COALESCE(Kredit,0) else 0 ) <>0 or

		sum(case when H.Tanggal>=@Tanggal1 then COALESCE(H.Debet,0) else 0 ) <>0 or

		sum(case when H.Tanggal>=@Tanggal1 and H.NoRetur='' then COALESCE(H.Kredit,0) else 0 ) <>0 or

		sum(case when H.Tanggal>=@Tanggal1 and H.NoRetur<>'' then COALESCE(H.Kredit,0) else 0 ) <>0 or

		sum(COALESCE(Debet,0)-COALESCE(Kredit,0)) <>0 or

		sum(case when H.Tanggal<@Tanggal1 then COALESCE(Debetd,0)-COALESCE(Kreditd,0) else 0 ) <>0 or

		sum(case when H.Tanggal>=@Tanggal1 then COALESCE(H.Debetd,0) else 0 ) <>0 or

		sum(case when H.Tanggal>=@Tanggal1 and H.NoRetur='' then COALESCE(H.Kreditd,0) else 0 ) <>0 or

		sum(case when H.Tanggal>=@Tanggal1 and H.NoRetur<>'' then COALESCE(H.Kreditd,0) else 0 )<>0 or

		sum(COALESCE(Debetd,0)-COALESCE(Kreditd,0)) <>0	

	)a

	Group By Kode,Nama,Kota

	having SUM(Awal)<>0 or SUM(Jumlah)<>0 or SUM(Pelunasan)<>0 or SUM(Retur)<>0 or SUM(SaldoAkhir)<>0 or

 case when SUM(SaldoAkhir)<=0 then 0 when SUM(SaldoAkhir)<0 then SUM(Saldo30)+SUM(Saldo60)+SUM(Saldo90)+SUM(Saldo120)+SUM(Saldo121) else SUM(Saldo30) <>0 or

 case when SUM(SaldoAkhir)<=0 then 0 else SUM(Saldo60) <>0 or

 case when SUM(SaldoAkhir)<=0 then 0 else SUM(Saldo90) <>0 or

 case when SUM(SaldoAkhir)<=0 then 0 else SUM(Saldo120) <>0 or

 case when SUM(SaldoAkhir)<=0 then 0 else  SUM(Saldo121) <>0

	order by a.Kode;

-- sp_ReportSisaHutang
CREATE PROCEDURE IF NOT EXISTS sp_ReportSisaHutang AS -- SET REMOVEDCase when @devisi in ('-','') then '%' else @devisi 

if @tipe=0 

select 	a.KodeCustSupp KodeSupp,b.NAMACUSTSUPP namasupp,'' alamat,

		max(case when a.Kredit<>0 then a.Tanggal else '01/01/1900' ) Tanggal, 

		max(a.JatuhTempo) as JatuhTempo,a.Nofaktur,sum(a.kredit) as Jumlah,sum(a.debet) as Terbayar,sum(a.kredit)-sum(a.debet) as sisa,

		sum(a.kreditD) as JumlahD,sum(a.debetD) as TerbayarD,sum(a.kreditD)-sum(a.debetD) as sisaD  

 	from vwHutpiut a

 	left outer join DBCUSTSUPP b on(a.KodeCustSupp=b.KodeCustSupp)

 	where  a.tanggal<=@tanggal

  		and a.perkiraan=@perkiraan 

		--and ((a.Valas=@KodeVls and @KodeVls<>'IDR') or (a.Valas like '%' and @KodeVls='IDR'))

		and (a.KodeCustSupp between @awal and @akhir) and (a.Devisi like @devisi) 	

 	group by a.KodeCustSupp, a.Nofaktur,b.NAMACUSTSUPP

 	having (sum(a.kredit)-sum(a.debet)) <>0

 	order by a.KodeCustSupp, max(case when a.Kredit<>0 then a.Tanggal else '01/01/1900' ), a.nofaktur

 else

if @Tipe=1

select a.KodeCustSupp KodeSupp, b.NAMACUSTSUPP namasupp, '' alamat,

		max(case when a.Kredit<>0 then a.Tanggal else '01/01/1900' ) Tanggal, 

		max(a.JatuhTempo) as JatuhTempo,a.Nofaktur,sum(a.kredit) as Jumlah,sum(a.debet) as Terbayar,sum(a.kredit)-sum(a.debet) as sisa,

	sum(a.kreditD) as JumlahD,sum(a.debetD) as TerbayarD,sum(a.kreditD)-sum(a.debetD) as sisaD  

 from vwHutpiut a

 left outer join DBCUSTSUPP b on(a.KodeCustSupp=b.KodeCustSupp)

 where  a.tanggal<=@tanggal

  		and a.perkiraan=@perkiraan

	--and ((a.Valas=@KodeVls and @KodeVls<>'IDR') or (a.Valas like '%' and @KodeVls='IDR'))

	and (a.KodeCustSupp between @awal and @akhir) and (a.Devisi like @devisi) 	

 group by a.KodeCustSupp, a.Nofaktur, b.NAMACUSTSUPP

 having (sum(a.kredit)-sum(a.debet)) <>0

 order by a.KodeCustSupp,SUBSTR(a.nofaktur, LENGTH(a.nofaktur)-4+1),SUBSTR(a.nofaktur, LENGTH(a.nofaktur)-7+1),a.nofaktur, max(case when a.Kredit<>0 then a.Tanggal else '01/01/1900' )

 else



if @tipe=2

select 	'' kodesupp,'' namasupp, '' alamat,

		max(case when a.Kredit<>0 then a.Tanggal else '01/01/1900' ) Tanggal, 

		max(a.JatuhTempo) as JatuhTempo,a.Nofaktur,sum(a.kredit) as Jumlah,sum(a.debet) as Terbayar,sum(a.kredit)-sum(a.debet) as sisa,

		sum(a.kreditD) as JumlahD,sum(a.debetD) as TerbayarD,sum(a.kreditD)-sum(a.debetD) as sisaD  

 	from vwHutpiut a

 	left outer join DBCUSTSUPP b on(a.KodeCustSupp=b.KodeCustSupp)

 	where  a.tanggal<=@tanggal

  		and a.perkiraan=@perkiraan and (a.Devisi like @devisi) 	

	--	and ((a.Valas=@KodeVls and @KodeVls<>'IDR') or (a.Valas like '%' and @KodeVls='IDR'))

 	group by a.Nofaktur-- ,b.namasupp,b.alamat

 	having (sum(a.kredit)-sum(a.debet)) <>0

 	order by max(case when a.Kredit<>0 then a.Tanggal else '01/01/1900' ), a.nofaktur;

-- sp_ReportSisaPiutang
CREATE PROCEDURE IF NOT EXISTS sp_ReportSisaPiutang AS --select @tanggal='2016-03-31',@awal='A0000010',@akhir='A0000010',@devisi='01',@tipe=0,@Perkiraan='131',@KodeVls='IDR'

-- SET REMOVEDCase when @devisi in ('-','') then '%' else @devisi 

exec Sp_CekPiutAwl

if @tipe=0 

select 	a.KodeCustSupp KodeCust,b.NAMACUSTSUPP NamaCust,'' alamat,

		--max(case when a.Debet<>0 then a.Tanggal else '01/01/1900' ) Tanggal, 

		Min(a.Tanggal) Tanggal,

		Min(a.Tanggal)+30 as JatuhTempo,

		 a.NoFaktur, sum(a.Debet) as Jumlah, sum(a.Kredit) as Terbayar,sum(a.Debet)-sum(a.Kredit) as sisa,

		sum(a.DebetD) as JumlahD,sum(a.KreditD) as TerbayarD,sum(a.DebetD)-sum(a.KreditD) as sisaD, dbo.NamaSales(a.NoFaktur) Sales  

 	from vwHutpiut a

 	left outer join DBCUSTSUPP b on(a.KodeCustSupp=b.KodeCustSupp)

 	where  a.tanggal<=@tanggal

 	    --and a.NoFaktur not in (select NoFaktur from DBHUTPIUT where KODECUSTSUPP='C0000011' and NoFaktur like '%INTR%')

  		and a.perkiraan=@perkiraan and (a.Devisi like @devisi) 	

		--and ((a.Valas=@KodeVls and @KodeVls<>'IDR') or (a.Valas like '%' and @KodeVls='IDR'))

		and (a.KodeCustSupp between @awal and @akhir) and a.KodeCustSupp in (select a.KodeCustSupp KodeCust

 	                                                                         from vwHutpiut a

 	                                                                         left outer join DBCUSTSUPP b on(a.KodeCustSupp=b.KodeCustSupp)

 	                                                                         where  a.tanggal<=@tanggal and (a.Devisi like @devisi)

  		                                                                      and a.perkiraan=@perkiraan 

		                                                                      and (a.KodeCustSupp between @awal and @akhir)	

 	                                                                         group by a.KodeCustSupp

 	                                                                         having (sum(a.Debet)-sum(a.Kredit)) >0)	

 	group by a.KodeCustSupp, a.Nofaktur,b.NAMACUSTSUPP

 	having (sum(a.Debet)-sum(a.Kredit)) <>0

 	order by a.KodeCustSupp,Min(a.Tanggal) --max(case when a.Debet<>0 then a.Tanggal else '01/01/1900' )

 	, a.nofaktur

 else

if @Tipe=1

select a.KodeCustSupp KodeCust, b.NAMACUSTSUPP NamaCust, '' alamat,

		Min(a.Tanggal) Tanggal,

		Min(a.Tanggal)+30 as JatuhTempo,

		--max(case when a.Debet<>0 then a.Tanggal else '01/01/1900' ) Tanggal, 

		a.Nofaktur,sum(a.Debet) as Jumlah,sum(a.Kredit) as Terbayar,sum(a.Debet)-sum(a.Kredit) as sisa,

	sum(a.DebetD) as JumlahD,sum(a.KreditD) as TerbayarD,sum(a.DebetD)-sum(a.KreditD) as sisaD, dbo.NamaSales(a.NoFaktur) Sales  

 from vwHutpiut a

 left outer join DBCUSTSUPP b on(a.KodeCustSupp=b.KodeCustSupp)

 where  a.tanggal<=@tanggal

        --and a.NoFaktur not in (select NoFaktur from DBHUTPIUT where KODECUSTSUPP='C0000011' and NoFaktur like '%INTR%')

  		and a.perkiraan=@perkiraan and (a.Devisi like @devisi) 	

	--and ((a.Valas=@KodeVls and @KodeVls<>'IDR') or (a.Valas like '%' and @KodeVls='IDR'))

	and (a.KodeCustSupp between @awal and @akhir) and a.KodeCustSupp in (select a.KodeCustSupp KodeCust

 	                                                                         from vwHutpiut a

 	                                                                         left outer join DBCUSTSUPP b on(a.KodeCustSupp=b.KodeCustSupp)

 	                                                                         where  a.tanggal<=@tanggal and (a.Devisi like @devisi)

  		                                                                      and a.perkiraan=@perkiraan 

		                                                                      and (a.KodeCustSupp between @awal and @akhir)	

 	                                                                         group by a.KodeCustSupp

 	                                                                         having (sum(a.Debet)-sum(a.Kredit)) >0)	

 group by a.KodeCustSupp, a.Nofaktur, b.NAMACUSTSUPP

 having (sum(a.Debet)-sum(a.Kredit)) <>0

 order by a.KodeCustSupp,Min(a.Tanggal),SUBSTR(a.nofaktur, LENGTH(a.nofaktur)-4+1),SUBSTR(a.nofaktur, LENGTH(a.nofaktur)-7+1),a.nofaktur --max(case when a.Debet<>0 then a.Tanggal else '01/01/1900' )

 else



if @tipe=2

select 	'' KodeCust,'' NamaCust, '' alamat,

 	Min(a.Tanggal),

    Min(a.Tanggal)+30 as JatuhTempo,

		--max(case when a.Debet<>0 then a.Tanggal else '01/01/1900' ) Tanggal, 

	--	max(a.JatuhTempo) as JatuhTempo,

		a.Nofaktur,sum(a.Debet) as Jumlah,sum(a.Kredit) as Terbayar,sum(a.Debet)-sum(a.Kredit) as sisa,

		sum(a.DebetD) as JumlahD,sum(a.KreditD) as TerbayarD,sum(a.DebetD)-sum(a.KreditD) as sisaD, dbo.NamaSales(a.NoFaktur) Sales  

 	from vwHutpiut a

 	left outer join DBCUSTSUPP b on(a.KodeCustSupp=b.KodeCustSupp)

 	where  a.tanggal<=@tanggal and (a.Devisi like @devisi) 	

 	--and a.NoFaktur not in (select NoFaktur from DBHUTPIUT where KODECUSTSUPP='C0000011' and NoFaktur like '%INTR%')

  		and a.perkiraan=@perkiraan and a.KodeCustSupp in (select a.KodeCustSupp KodeCust

 	                                                                         from vwHutpiut a

 	                                                                         left outer join DBCUSTSUPP b on(a.KodeCustSupp=b.KodeCustSupp)

 	                                                                         where  a.tanggal<=@tanggal and (a.Devisi like @devisi)

  		                                                                      and a.perkiraan=@perkiraan 

		                                                                      and (a.KodeCustSupp between @awal and @akhir)	

 	                                                                         group by a.KodeCustSupp

 	                                                                         having (sum(a.Debet)-sum(a.Kredit)) >0)	

		--and ((a.Valas=@KodeVls and @KodeVls<>'IDR') or (a.Valas like '%' and @KodeVls='IDR'))

 	group by a.Nofaktur,a.NoBukti-- ,b.namasupp,b.alamat

 	having (sum(a.Debet)-sum(a.Kredit)) <>0

 	order by  --max(case when a.Debet<>0 then a.Tanggal else '01/01/1900' )

 	Min(a.Tanggal), a.nofaktur;

-- sp_ReportSisaPiutangDet
CREATE PROCEDURE IF NOT EXISTS sp_ReportSisaPiutangDet AS --select @tanggal='2016-03-31',@awal='A0000010',@akhir='A0000010',@devisi='01',@tipe=0,@Perkiraan='131',@KodeVls='IDR'

-- SET REMOVEDCase when @devisi in ('-','') then '%' else @devisi 

exec Sp_CekPiutAwl

if @tipe=0 

select 	a.KodeCustSupp KodeCust,b.NAMACUSTSUPP NamaCust,'' alamat,

		--max(case when a.Debet<>0 then a.Tanggal else '01/01/1900' ) Tanggal, 

		Min(a.Tanggal) Tanggal,

		Min(a.Tanggal)+30 as JatuhTempo,

		a.NoFaktur, sum(a.Debet) as Jumlah, sum(a.Kredit) as Terbayar,sum(a.Debet)-sum(a.Kredit) as sisa,

		sum(a.DebetD) as JumlahD,sum(a.KreditD) as TerbayarD,sum(a.DebetD)-sum(a.KreditD) as sisaD, dbo.NamaSales(a.NoFaktur) Sales  

 	from vwHutpiut a

 	left outer join DBCUSTSUPP b on(a.KodeCustSupp=b.KodeCustSupp)

 	where  a.tanggal<=@tanggal

  		and a.perkiraan=@perkiraan and (a.Devisi like @devisi) 	

		--and ((a.Valas=@KodeVls and @KodeVls<>'IDR') or (a.Valas like '%' and @KodeVls='IDR'))

		and (a.KodeCustSupp between @awal and @akhir) and a.KodeCustSupp in (select a.KodeCustSupp KodeCust

 	                                                                         from vwHutpiut a

 	                                                                         left outer join DBCUSTSUPP b on(a.KodeCustSupp=b.KodeCustSupp)

 	                                                                         where  a.tanggal<=@tanggal and (a.Devisi like @devisi)

  		                                                                      and a.perkiraan=@perkiraan 

		                                                                      and (a.KodeCustSupp between @awal and @akhir)	

 	                                                                         group by a.KodeCustSupp

 	                                                                         having (sum(a.Debet)-sum(a.Kredit)) <0)	

 	group by a.KodeCustSupp, a.Nofaktur,b.NAMACUSTSUPP

 	having (sum(a.Debet)-sum(a.Kredit)) <>0

 	order by a.KodeCustSupp, Min(a.tanggal)--max(case when a.Debet<>0 then a.Tanggal else '01/01/1900' )

 	, a.nofaktur

 else

if @Tipe=1

select a.KodeCustSupp KodeCust, b.NAMACUSTSUPP NamaCust, '' alamat,

		--max(case when a.Debet<>0 then a.Tanggal else '01/01/1900' ) Tanggal, 

	    Min(a.Tanggal) Tanggal,

		Min(a.Tanggal)+30 as JatuhTempo,

		a.Nofaktur,sum(a.Debet) as Jumlah,sum(a.Kredit) as Terbayar,sum(a.Debet)-sum(a.Kredit) as sisa,

	sum(a.DebetD) as JumlahD,sum(a.KreditD) as TerbayarD,sum(a.DebetD)-sum(a.KreditD) as sisaD, dbo.NamaSales(a.NoFaktur) Sales   

 from vwHutpiut a

 left outer join DBCUSTSUPP b on(a.KodeCustSupp=b.KodeCustSupp)

 where  a.tanggal<=@tanggal and (a.Devisi like @devisi) 	

  		and a.perkiraan=@perkiraan

	--and ((a.Valas=@KodeVls and @KodeVls<>'IDR') or (a.Valas like '%' and @KodeVls='IDR'))

	and (a.KodeCustSupp between @awal and @akhir) and a.KodeCustSupp in (select a.KodeCustSupp KodeCust

 	                                                                         from vwHutpiut a

 	                                                                         left outer join DBCUSTSUPP b on(a.KodeCustSupp=b.KodeCustSupp)

 	                                                                         where  a.tanggal<=@tanggal and (a.Devisi like @devisi)

  		                                                                      and a.perkiraan=@perkiraan 

		                                                                      and (a.KodeCustSupp between @awal and @akhir)	

 	                                                                         group by a.KodeCustSupp

 	                                                                         having (sum(a.Debet)-sum(a.Kredit)) <0)	

 group by a.KodeCustSupp, a.Nofaktur, b.NAMACUSTSUPP

 having (sum(a.Debet)-sum(a.Kredit)) <>0

 order by a.KodeCustSupp,Min(a.tanggal),SUBSTR(a.nofaktur, LENGTH(a.nofaktur)-4+1),SUBSTR(a.nofaktur, LENGTH(a.nofaktur)-7+1),a.nofaktur --max(case when a.Debet<>0 then a.Tanggal else '01/01/1900' )

 else



if @tipe=2

select 	'' KodeCust,'' NamaCust, '' alamat,

		--max(case when a.Debet<>0 then a.Tanggal else '01/01/1900' ) Tanggal, 

		Min(a.Tanggal) Tanggal,

		Min(a.Tanggal)+30 as JatuhTempo,

		a.Nofaktur,sum(a.Debet) as Jumlah,sum(a.Kredit) as Terbayar,sum(a.Debet)-sum(a.Kredit) as sisa,

		sum(a.DebetD) as JumlahD,sum(a.KreditD) as TerbayarD,sum(a.DebetD)-sum(a.KreditD) as sisaD, dbo.NamaSales(a.NoFaktur) Sales    

 	from vwHutpiut a

 	left outer join DBCUSTSUPP b on(a.KodeCustSupp=b.KodeCustSupp)

 	where  a.tanggal<=@tanggal and (a.Devisi like @devisi) 	

  		and a.perkiraan=@perkiraan and a.KodeCustSupp in (select a.KodeCustSupp KodeCust

 	                                                                         from vwHutpiut a

 	                                                                         left outer join DBCUSTSUPP b on(a.KodeCustSupp=b.KodeCustSupp)

 	                                                                         where  a.tanggal<=@tanggal and (a.Devisi like @devisi)

  		                                                                      and a.perkiraan=@perkiraan 

		                                                                      and (a.KodeCustSupp between @awal and @akhir)	

 	                                                                         group by a.KodeCustSupp

 	                                                                         having (sum(a.Debet)-sum(a.Kredit)) <0)	

		--and ((a.Valas=@KodeVls and @KodeVls<>'IDR') or (a.Valas like '%' and @KodeVls='IDR'))

 	group by a.Nofaktur-- ,b.namasupp,b.alamat

 	having (sum(a.Debet)-sum(a.Kredit)) <>0

 	order by  Min(a.tanggal)--max(case when a.Debet<>0 then a.Tanggal else '01/01/1900' )

 	, a.nofaktur;

-- Sp_ReportSODet
CREATE PROCEDURE IF NOT EXISTS Sp_ReportSODet AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 

-- DECLARE REMOVED

select @Devisi=Devisi from DBDEVISI where NamaDevisi=@Id 

--select @Id=SUBSTRING(@Id,1,1)

if @Id=''

if @SReport='T'

If @Ordr='N'

		if @NeedOto=0 or @needoto=1

		  if @isiList=''

			exec('select ''Gabungan'' Perusahaan,* from VwReportSO where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

			order by NoBukti,Tanggal')

		   else

		   	exec('select ''Gabungan'' Perusahaan,* from VwReportSO where NoBukti IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

			order by NoBukti,Tanggal')

		  

		else  	

		if @NeedOto=2

		if @isiList=''

			exec('select ''Gabungan'' Perusahaan,* from VwReportSO where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+'

			order by NoBukti,Tanggal')

		 else

			exec('select ''Gabungan'' Perusahaan,* from VwReportSO where NoBukti IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

			order by NoBukti,Tanggal')


	else If @Ordr='B'

		if @NeedOto=0 or @needoto=1	

		 if @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwReportSO where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

		    order by KodeBrg')

		 else

		   exec('select ''Gabungan'' Perusahaan,* from VwReportSO where Kodebrg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

		    order by KodeBrg')  

		 

		  if @NeedOto=2

		  if @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwReportSO where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+' 

		  order by KodeBrg')

		  else

		   exec('select ''Gabungan'' Perusahaan,* from VwReportSO where Kodebrg IN'+@isiList+ ' and ( Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		  order by KodeBrg')


	else If @Ordr='C'

		if @NeedOto=0 or @needOto=1	

		 if @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwReportSO where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and NeedOtorisasi='+@NeedOto+'

		  order by KODECUSTSUPP')

		  else

		  exec('select * from VwReportSO where KODECUSTSUPP IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and NeedOtorisasi='+@NeedOto+'

		  order by KODECUSTSUPP')

		  

		if @NeedOto=2

		 if @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwReportSO where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  order by KODECUSTSUPP ')

		  else

		  exec('select ''Gabungan'' Perusahaan,* from VwReportSO where KODECUSTSUPP IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  

		  order by KODECUSTSUPP')


	else If @Ordr='D'

	   if @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwReportSO where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  order by KodeSubGrp,KodeBrg ')

		  else

		  exec('select ''Gabungan'' Perusahaan,* from VwReportSO where KodeSubGrp IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  

		  order by KodeSubGrp,KodeBrg')

	   

	else If @Ordr='S'

		if @NeedOto=0 or @needOto=1	

		 if @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwReportSO where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and NeedOtorisasi='+@NeedOto+'

		  order by KodeSls,NamaSls')

		  else

		  exec('select ''Gabungan'' Perusahaan,* from VwReportSO where KodeSls IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and NeedOtorisasi='+@NeedOto+'

		  order by KodeSls,NamaSls')

		  

		if @NeedOto=2

		 if @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwReportSO where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  order by KodeSls,NamaSls ')

		  else

		  exec('select ''Gabungan'' Perusahaan,* from VwReportSO where KodeSls IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  

		  order by KodeSls,NamaSls')


else----------

if @SReport='T'

If @Ordr='N'

		if @NeedOto=0 or @needoto=1

		  if @isiList=''

			exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSO where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

			and Devisi='''+@Devisi+'''

			order by NoBukti,Tanggal')

		   else

		   	exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSO where NoBukti IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

			and Devisi='''+@Devisi+'''

			order by NoBukti,Tanggal')

		  

		else  	

		if @NeedOto=2

		if @isiList=''

			exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSO where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

			and Devisi='''+@Devisi+'''

			order by NoBukti,Tanggal')

		 else

			exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSO where NoBukti IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

			and Devisi='''+@Devisi+'''

			order by NoBukti,Tanggal')


	else If @Ordr='B'

		if @NeedOto=0 or @needoto=1	

		 if @isiList=''

		  exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSO where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

		    and Devisi='''+@Devisi+'''

		    order by KodeBrg')

		 else

		   exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSO where Kodebrg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

		    and Devisi='''+@Devisi+'''

		    order by KodeBrg')  

		 

		  if @NeedOto=2

		  if @isiList=''

		  exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSO where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		  and Devisi='''+@Devisi+'''

		  order by KodeBrg')

		  else

		   exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSO where Kodebrg IN'+@isiList+ ' and ( Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		  and Devisi='''+@Devisi+'''

		  order by KodeBrg')


	else If @Ordr='C'

		if @NeedOto=0 or @needOto=1	

		 if @isiList=''

		  exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSO where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and NeedOtorisasi='+@NeedOto+'

		  and Devisi='''+@Devisi+'''

		  order by KODECUSTSUPP')

		  else

		  exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSO where KODECUSTSUPP IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and NeedOtorisasi='+@NeedOto+'

		  and Devisi='''+@Devisi+'''

		  order by KODECUSTSUPP')

		  

		if @NeedOto=2

		 if @isiList=''

		  exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSO where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and Devisi='''+@Devisi+'''

		  order by KODECUSTSUPP ')

		  else

		  exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSO where KODECUSTSUPP IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  

		  and Devisi='''+@Devisi+'''

		  order by KODECUSTSUPP')


	else If @Ordr='D'

	   if @isiList=''

		  exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSO where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and Devisi='''+@Devisi+'''

		  order by KodeSubGrp,KodeBrg ')

		  else

		  exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSO where KodeSubGrp IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  

		  and Devisi='''+@Devisi+'''

		  order by KodeSubGrp,KodeBrg')

	   

	else If @Ordr='S'

		if @NeedOto=0 or @needOto=1	

		 if @isiList=''

		  exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSO where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and NeedOtorisasi='+@NeedOto+'

		  and Devisi='''+@Devisi+'''

		  order by KodeSls,NamaSls')

		  else

		  exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSO where KodeSls IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and NeedOtorisasi='+@NeedOto+'

		  and Devisi='''+@Devisi+'''

		  order by KodeSls,NamaSls')

		  

		if @NeedOto=2

		 if @isiList=''

		  exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSO where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and Devisi='''+@Devisi+'''

		  order by KodeSls,NamaSls ')

		  else

		  exec('select case when '''+@Devisi+'''<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSO where KodeSls IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  

		  and Devisi='''+@Devisi+'''

		  order by KodeSls,NamaSls');

-- Sp_reportSORek
CREATE PROCEDURE IF NOT EXISTS Sp_reportSORek AS ---- DECLARE REMOVED,@tgl1 Datetime,@Tgl2 DateTime

--select @Choice='B',@Tgl1='10/10/2011',@tgl2='01/29/2012'

select @Id=SUBSTRING(@Id,1,1)

if @Id=''

IF @Choice='N'

If @needOto=0 or @needoto=1

	Select 	'Gabungan' Perusahaan,A.NoBukti,A.tanggal, A.KodeCust,I.NamaCustSupp,a.KODEVLS,a.KURS,a.KODESLS,C.Nama,

        SUM(COALESCE(b.ndpp,0)) nDPP, Sum(COALESCE(B.NDPPRp,0)) NDPPRp,

        Sum(COALESCE(B.NPPNRp,0)) NPPNRP, Sum(COALESCE(B.NNETRp,0)) NnetRp

    ,b.HARGA ,br.NamaBrg,Pr.NAMAPROJECT,B.SATUAN,SUM(Case when NOSAT=1 Then B.QNT else B.QNT2 )Volume           

	From dbSO A

	Left Outer join dbSODet B on B.NoBukti=a.NoBukti

	Left Outer join DbCustSupp I on A.KodeCust=I.KodeCustSupp

	Left Outer Join DBBARANG br on br.KODEBRG=b.KODEBRG

	Left Outer Join DBPROJECT Pr on Pr.KODEPROJECT=a.AlamatKirim

	Left outer Join dbKaryawan C on c.KeyNIK=a.kodesls

	Where a.Tanggal between @tgl1 and @tgl2  and

	Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 /*+

    Case when A.IsOtorisasi2=1 then 1 else 0 +

    Case when A.IsOtorisasi3=1 then 1 else 0 +

    Case when A.IsOtorisasi4=1 then 1 else 0 +

    Case when A.IsOtorisasi5=1 then 1 else 0 */=1/*A.MaxOL*/ then 0

    else 1

     As INTEGER) =@NeedOto

	Group By A.NoBukti,A.tanggal,a.KODECUST,i.NAMACUSTSUPP,a.KODEVLS,a.KURS,a.KODESLS,c.Nama,b.HARGA,br.NamaBrg,Pr.NAMAPROJECT,B.SATUAN  

	Order By A.NoBukti,A.tanggal

 else if @needOto=2

    Select 	'Gabungan' Perusahaan,A.NoBukti,A.tanggal, A.KodeCust,I.NamaCustSupp,a.KODEVLS,a.KURS,a.KODESLS,C.Nama,

        SUM(COALESCE(b.ndpp,0)) nDPP, Sum(COALESCE(B.NDPPRp,0)) NDPPRp,

        Sum(COALESCE(B.NPPNRp,0)) NPPNRP, Sum(COALESCE(B.NNETRp,0)) NnetRp  

         ,b.HARGA,br.NamaBrg,Pr.NAMAPROJECT,B.SATUAN,SUM(Case when NOSAT=1 Then B.QNT else B.QNT2 )Volume     

	From dbSO A

	Left Outer join dbSODet B on B.NoBukti=a.NoBukti

	Left Outer join DbCustSupp I on A.KodeCust=I.KodeCustSupp

	Left Outer Join DBBARANG br on br.KODEBRG=b.KODEBRG

	Left Outer Join DBPROJECT Pr on Pr.KODEPROJECT=a.AlamatKirim

	Left outer Join dbKaryawan C on c.KeyNIK=a.kodesls

	Where a.Tanggal between @tgl1 and @tgl2 

	Group By A.NoBukti,A.tanggal,a.KODECUST,i.NAMACUSTSUPP,a.KODEVLS,a.KURS,a.KODESLS,c.Nama,b.HARGA,br.NamaBrg,Pr.NAMAPROJECT,B.SATUAN  

	Order By A.NoBukti,A.tanggal



else if @Choice ='S'

If @needOto=0 or @needoto=1

	Select 	'Gabungan' Perusahaan,A.NoBukti,A.tanggal, A.KodeCust,I.NamaCustSupp,a.KODEVLS,a.KURS,a.KODESLS,C.Nama,

        SUM(Case When COALESCE(KodeBrgM,'')='' Then COALESCE(b.ndpp,0) else 0  ) nDPP, Sum(Case When COALESCE(KodeBrgM,'')='' Then COALESCE(B.NDPPRp,0) else 0 ) NDPPRp,

        Sum(Case When COALESCE(KodeBrgM,'')='' Then COALESCE(B.NPPNRp,0) else 0 ) NPPNRP, Sum(Case When COALESCE(KodeBrgM,'')='' Then COALESCE(B.NNETRp,0)else 0 ) NnetRp

	From dbSO A

	Left Outer join dbSODet B on B.NoBukti=a.NoBukti

	Left Outer join DbCustSupp I on A.KodeCust=I.KodeCustSupp

	Left outer Join dbKaryawan C on c.KeyNIK=a.kodesls

	Where a.Tanggal between @tgl1 and @tgl2 and

	Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 /*+

    Case when A.IsOtorisasi2=1 then 1 else 0 +

    Case when A.IsOtorisasi3=1 then 1 else 0 +

    Case when A.IsOtorisasi4=1 then 1 else 0 +

    Case when A.IsOtorisasi5=1 then 1 else 0 */=1/*A.MaxOL*/ then 0

    else 1

     As INTEGER) =@NeedOto 

	Group By a.KODECUST,A.tanggal,A.NoBukti,i.NAMACUSTSUPP,a.KODEVLS,a.KURS,a.KODESLS,c.Nama

	Order By I.NamaCustSupp,A.NOBUKTI

else If @needOto=2

	Select 	'Gabungan' Perusahaan,A.NoBukti,A.tanggal, A.KodeCust,I.NamaCustSupp,a.KODEVLS,a.KURS,a.KODESLS,C.Nama,

        SUM(COALESCE(b.ndpp,0)) nDPP, Sum(COALESCE(B.NDPPRp,0)) NDPPRp,

        Sum(COALESCE(B.NPPNRp,0)) NPPNRP, Sum(COALESCE(B.NNETRp,0)) NnetRp

	From dbSO A

	Left Outer join dbSODet B on B.NoBukti=a.NoBukti

	Left Outer join DbCustSupp I on A.KodeCust=I.KodeCustSupp

	Left outer Join dbKaryawan C on c.KeyNIK=a.kodesls

	Where a.Tanggal between @tgl1 and @tgl2 

	Group By a.KODECUST,A.tanggal,A.NoBukti,i.NAMACUSTSUPP,a.KODEVLS,a.KURS,a.KODESLS,c.Nama

	Order By I.NamaCustSupp,A.NOBUKTI



else if @Choice ='K'

If @needOto=0 or @needoto=1

	Select 	'Gabungan' Perusahaan,A.NoBukti,A.tanggal, A.KodeCust,I.NamaCustSupp,a.KODEVLS,a.KURS,a.KODESLS,C.Nama,

        SUM(COALESCE(b.ndpp,0)) nDPP, Sum(COALESCE(B.NDPPRp,0)) NDPPRp,

        Sum(COALESCE(B.NPPNRp,0)) NPPNRP, Sum(COALESCE(B.NNETRp,0)) NnetRp

        ,br.NamaBrg,Pr.NAMAPROJECT,B.SATUAN,SUM(Case when NOSAT=1 Then B.QNT else B.QNT2 )Volume  

	From dbSO A

	Left Outer join dbSODet B on B.NoBukti=a.NoBukti

	Left Outer join DbCustSupp I on A.KodeCust=I.KodeCustSupp

	Left Outer Join DBBARANG br on br.KODEBRG=b.KODEBRG

	Left Outer Join DBPROJECT Pr on Pr.KODEPROJECT=a.AlamatKirim

	Left outer Join dbKaryawan C on c.KeyNIK=a.kodesls

	Where a.Tanggal between @tgl1 and @tgl2 and

	Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 /*+

    Case when A.IsOtorisasi2=1 then 1 else 0 +

    Case when A.IsOtorisasi3=1 then 1 else 0 +

    Case when A.IsOtorisasi4=1 then 1 else 0 +

    Case when A.IsOtorisasi5=1 then 1 else 0 */=1/*A.MaxOL*/ then 0

    else 1

     As INTEGER) =@NeedOto

	Group By a.KODECUST,A.tanggal,A.NoBukti,i.NAMACUSTSUPP,a.KODEVLS,a.KURS,a.KODESLS,c.Nama,br.NamaBrg,Pr.NAMAPROJECT,B.SATUAN  

	Order By C.Nama,a.KODESLS

else If @needOto=2

	Select 	'Gabungan' Perusahaan,A.NoBukti,A.tanggal, A.KodeCust,I.NamaCustSupp,a.KODEVLS,a.KURS,a.KODESLS,C.Nama,

        SUM(COALESCE(b.ndpp,0)) nDPP, Sum(COALESCE(B.NDPPRp,0)) NDPPRp,

        Sum(COALESCE(B.NPPNRp,0)) NPPNRP, Sum(COALESCE(B.NNETRp,0)) NnetRp

        ,br.NamaBrg,Pr.NAMAPROJECT,B.SATUAN,SUM(Case when NOSAT=1 Then B.QNT else B.QNT2 )Volume  

	From dbSO A

	Left Outer join dbSODet B on B.NoBukti=a.NoBukti

	Left Outer join DbCustSupp I on A.KodeCust=I.KodeCustSupp

	Left Outer Join DBBARANG br on br.KODEBRG=b.KODEBRG

	Left Outer Join DBPROJECT Pr on Pr.KODEPROJECT=a.AlamatKirim

	Left outer Join dbKaryawan C on c.KeyNIK=a.kodesls

	Where a.Tanggal between @tgl1 and @tgl2 

	Group By a.KODECUST,A.tanggal,A.NoBukti,i.NAMACUSTSUPP,a.KODEVLS,a.KURS,a.KODESLS,c.Nama,br.NamaBrg,Pr.NAMAPROJECT,B.SATUAN  

	Order By C.Nama,a.KODESLS



else if @Choice='B'

If @needOto=0 or @needoto=1

    Select 'Gabungan' Perusahaan,B.KODEBRG,h.namabrg,sum(COALESCE(b.QNT,0)) Qnt,sum(COALESCE(b.QNT2,0)) qnt2,h.SAT1,h.SAT2,

        SUM(COALESCE(b.ndpp,0)) nDPP, Sum(COALESCE(B.NDPPRp,0)) NDPPRp,

        Sum(COALESCE(B.NPPNRp,0)) NPPNRP, Sum(COALESCE(B.NNETRp,0)) NnetRp

	From dbSO A

	Left Outer join dbSODet B on B.NoBukti=a.NoBukti

	Left outer join DBBARANG H on H.KODEBRG=b.KODEBRG

	Where a.Tanggal between @tgl1 and @tgl2 and

	Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 /*+

    Case when A.IsOtorisasi2=1 then 1 else 0 +

    Case when A.IsOtorisasi3=1 then 1 else 0 +

    Case when A.IsOtorisasi4=1 then 1 else 0 +

    Case when A.IsOtorisasi5=1 then 1 else 0 */=1/*A.MaxOL*/ then 0

    else 1

     As INTEGER) =@NeedOto

	Group By B.kodeBrg,H.namaBrg,h.SAT1,h.SAT2

	Order By B.kodeBrg

If @needOto=2

    Select 'Gabungan' Perusahaan,B.KODEBRG,h.namabrg,sum(COALESCE(b.QNT,0)) Qnt,sum(COALESCE(b.QNT2,0)) qnt2,h.SAT1,h.SAT2,

        SUM(COALESCE(b.ndpp,0)) nDPP, Sum(COALESCE(B.NDPPRp,0)) NDPPRp,

        Sum(COALESCE(B.NPPNRp,0)) NPPNRP, Sum(COALESCE(B.NNETRp,0)) NnetRp

	From dbSO A

	Left Outer join dbSODet B on B.NoBukti=a.NoBukti

	Left outer join DBBARANG H on H.KODEBRG=b.KODEBRG

	Where a.Tanggal between @tgl1 and @tgl2

	Group By B.kodeBrg,H.namaBrg,h.SAT1,h.SAT2

	Order By B.kodeBrg


else

IF @Choice='N'

If @needOto=0 or @needoto=1

	Select 	Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,A.NoBukti,A.tanggal, A.KodeCust,I.NamaCustSupp,a.KODEVLS,a.KURS,a.KODESLS,C.Nama,

        SUM(COALESCE(b.ndpp,0)) nDPP, Sum(COALESCE(B.NDPPRp,0)) NDPPRp,

        Sum(COALESCE(B.NPPNRp,0)) NPPNRP, Sum(COALESCE(B.NNETRp,0)) NnetRp  

         ,b.HARGA,br.NamaBrg,Pr.NAMAPROJECT,B.SATUAN,SUM(Case when NOSAT=1 Then B.QNT else B.QNT2 )Volume     

	From dbSO A

	Left Outer join dbSODet B on B.NoBukti=a.NoBukti

	Left Outer join DbCustSupp I on A.KodeCust=I.KodeCustSupp

	Left Outer Join DBBARANG br on br.KODEBRG=b.KODEBRG

	Left Outer Join DBPROJECT Pr on Pr.KODEPROJECT=a.AlamatKirim

	Left outer Join dbKaryawan C on c.KeyNIK=a.kodesls

	Where a.Tanggal between @tgl1 and @tgl2  and

	Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 /*+

    Case when A.IsOtorisasi2=1 then 1 else 0 +

    Case when A.IsOtorisasi3=1 then 1 else 0 +

    Case when A.IsOtorisasi4=1 then 1 else 0 +

    Case when A.IsOtorisasi5=1 then 1 else 0 */=1/*A.MaxOL*/ then 0

    else 1

     As INTEGER) =@NeedOto

    and @Id= Left(a.NoBukti,1) 

	Group By A.NoBukti,A.tanggal,a.KODECUST,i.NAMACUSTSUPP,a.KODEVLS,a.KURS,a.KODESLS,c.Nama,b.HARGA,br.NamaBrg,Pr.NAMAPROJECT,B.SATUAN  

	Order By A.NoBukti,A.tanggal

 else if @needOto=2

    Select 	Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,A.NoBukti,A.tanggal, A.KodeCust,I.NamaCustSupp,a.KODEVLS,a.KURS,a.KODESLS,C.Nama,

        SUM(COALESCE(b.ndpp,0)) nDPP, Sum(COALESCE(B.NDPPRp,0)) NDPPRp,

        Sum(COALESCE(B.NPPNRp,0)) NPPNRP, Sum(COALESCE(B.NNETRp,0)) NnetRp  

        ,b.HARGA ,br.NamaBrg,Pr.NAMAPROJECT,B.SATUAN,SUM(Case when NOSAT=1 Then B.QNT else B.QNT2 )Volume     

	From dbSO A

	Left Outer join dbSODet B on B.NoBukti=a.NoBukti

	Left Outer join DbCustSupp I on A.KodeCust=I.KodeCustSupp

	Left Outer Join DBBARANG br on br.KODEBRG=b.KODEBRG

	Left Outer Join DBPROJECT Pr on Pr.KODEPROJECT=a.AlamatKirim

	Left outer Join dbKaryawan C on c.KeyNIK=a.kodesls

	Where a.Tanggal between @tgl1 and @tgl2 

	and @Id= Left(a.NoBukti,1)

	Group By A.NoBukti,A.tanggal,a.KODECUST,i.NAMACUSTSUPP,a.KODEVLS,a.KURS,a.KODESLS,c.Nama,b.HARGA,br.NamaBrg,Pr.NAMAPROJECT,B.SATUAN  

	Order By A.NoBukti,A.tanggal



else if @Choice ='S'

If @needOto=0 or @needoto=1

	Select 	Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,A.NoBukti,A.tanggal, A.KodeCust,I.NamaCustSupp,a.KODEVLS,a.KURS,a.KODESLS,C.Nama,

        SUM(Case When COALESCE(KodeBrgM,'')='' Then COALESCE(b.ndpp,0) else 0  ) nDPP, Sum(Case When COALESCE(KodeBrgM,'')='' Then COALESCE(B.NDPPRp,0) else 0 ) NDPPRp,

        Sum(Case When COALESCE(KodeBrgM,'')='' Then COALESCE(B.NPPNRp,0) else 0 ) NPPNRP, Sum(Case When COALESCE(KodeBrgM,'')='' Then COALESCE(B.NNETRp,0)else 0 ) NnetRp

	From dbSO A

	Left Outer join dbSODet B on B.NoBukti=a.NoBukti

	Left Outer join DbCustSupp I on A.KodeCust=I.KodeCustSupp

	Left outer Join dbKaryawan C on c.KeyNIK=a.kodesls

	Where a.Tanggal between @tgl1 and @tgl2 and

	Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 /*+

    Case when A.IsOtorisasi2=1 then 1 else 0 +

    Case when A.IsOtorisasi3=1 then 1 else 0 +

    Case when A.IsOtorisasi4=1 then 1 else 0 +

    Case when A.IsOtorisasi5=1 then 1 else 0 */=1/*A.MaxOL*/ then 0

    else 1

     As INTEGER) =@NeedOto 

    and @Id= Left(a.NoBukti,1)

	Group By a.KODECUST,A.tanggal,A.NoBukti,i.NAMACUSTSUPP,a.KODEVLS,a.KURS,a.KODESLS,c.Nama

	Order By I.NamaCustSupp,A.NOBUKTI

else If @needOto=2

	Select 	Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,A.NoBukti,A.tanggal, A.KodeCust,I.NamaCustSupp,a.KODEVLS,a.KURS,a.KODESLS,C.Nama,

        SUM(COALESCE(b.ndpp,0)) nDPP, Sum(COALESCE(B.NDPPRp,0)) NDPPRp,

        Sum(COALESCE(B.NPPNRp,0)) NPPNRP, Sum(COALESCE(B.NNETRp,0)) NnetRp

	From dbSO A

	Left Outer join dbSODet B on B.NoBukti=a.NoBukti

	Left Outer join DbCustSupp I on A.KodeCust=I.KodeCustSupp

	Left outer Join dbKaryawan C on c.KeyNIK=a.kodesls

	Where a.Tanggal between @tgl1 and @tgl2 

	and @Id= Left(a.NoBukti,1)

	Group By a.KODECUST,A.tanggal,A.NoBukti,i.NAMACUSTSUPP,a.KODEVLS,a.KURS,a.KODESLS,c.Nama

	Order By I.NamaCustSupp,A.NOBUKTI



else if @Choice ='K'

If @needOto=0 or @needoto=1

	Select Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,	A.NoBukti,A.tanggal, A.KodeCust,I.NamaCustSupp,a.KODEVLS,a.KURS,a.KODESLS,C.Nama,

        SUM(COALESCE(b.ndpp,0)) nDPP, Sum(COALESCE(B.NDPPRp,0)) NDPPRp,

        Sum(COALESCE(B.NPPNRp,0)) NPPNRP, Sum(COALESCE(B.NNETRp,0)) NnetRp

        ,br.NamaBrg,Pr.NAMAPROJECT,B.SATUAN,SUM(Case when NOSAT=1 Then B.QNT else B.QNT2 )Volume  

	From dbSO A

	Left Outer join dbSODet B on B.NoBukti=a.NoBukti

	Left Outer join DbCustSupp I on A.KodeCust=I.KodeCustSupp

	Left Outer Join DBBARANG br on br.KODEBRG=b.KODEBRG

	Left Outer Join DBPROJECT Pr on Pr.KODEPROJECT=a.AlamatKirim

	Left outer Join dbKaryawan C on c.KeyNIK=a.kodesls

	Where a.Tanggal between @tgl1 and @tgl2 and

	Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 /*+

    Case when A.IsOtorisasi2=1 then 1 else 0 +

    Case when A.IsOtorisasi3=1 then 1 else 0 +

    Case when A.IsOtorisasi4=1 then 1 else 0 +

    Case when A.IsOtorisasi5=1 then 1 else 0 */=1/*A.MaxOL*/ then 0

    else 1

     As INTEGER) =@NeedOto

    and @Id= Left(a.NoBukti,1)

	Group By a.KODECUST,A.tanggal,A.NoBukti,i.NAMACUSTSUPP,a.KODEVLS,a.KURS,a.KODESLS,c.Nama,br.NamaBrg,Pr.NAMAPROJECT,B.SATUAN  

	Order By C.Nama,a.KODESLS

else If @needOto=2

	Select 	Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,A.NoBukti,A.tanggal, A.KodeCust,I.NamaCustSupp,a.KODEVLS,a.KURS,a.KODESLS,C.Nama,

        SUM(COALESCE(b.ndpp,0)) nDPP, Sum(COALESCE(B.NDPPRp,0)) NDPPRp,

        Sum(COALESCE(B.NPPNRp,0)) NPPNRP, Sum(COALESCE(B.NNETRp,0)) NnetRp

        ,br.NamaBrg,Pr.NAMAPROJECT,B.SATUAN,SUM(Case when NOSAT=1 Then B.QNT else B.QNT2 )Volume  

	From dbSO A

	Left Outer join dbSODet B on B.NoBukti=a.NoBukti

	Left Outer join DbCustSupp I on A.KodeCust=I.KodeCustSupp

	Left Outer Join DBBARANG br on br.KODEBRG=b.KODEBRG

	Left Outer Join DBPROJECT Pr on Pr.KODEPROJECT=a.AlamatKirim

	Left outer Join dbKaryawan C on c.KeyNIK=a.kodesls

	Where a.Tanggal between @tgl1 and @tgl2 

	and @Id= Left(a.NoBukti,1)

	Group By a.KODECUST,A.tanggal,A.NoBukti,i.NAMACUSTSUPP,a.KODEVLS,a.KURS,a.KODESLS,c.Nama,br.NamaBrg,Pr.NAMAPROJECT,B.SATUAN  

	Order By C.Nama,a.KODESLS



else if @Choice='B'

If @needOto=0 or @needoto=1

    Select Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,B.KODEBRG,h.namabrg,sum(COALESCE(b.QNT,0)) Qnt,sum(COALESCE(b.QNT2,0)) qnt2,h.SAT1,h.SAT2,

        SUM(COALESCE(b.ndpp,0)) nDPP, Sum(COALESCE(B.NDPPRp,0)) NDPPRp,

        Sum(COALESCE(B.NPPNRp,0)) NPPNRP, Sum(COALESCE(B.NNETRp,0)) NnetRp

	From dbSO A

	Left Outer join dbSODet B on B.NoBukti=a.NoBukti

	Left outer join DBBARANG H on H.KODEBRG=b.KODEBRG

	Where a.Tanggal between @tgl1 and @tgl2 and

	Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 /*+

    Case when A.IsOtorisasi2=1 then 1 else 0 +

    Case when A.IsOtorisasi3=1 then 1 else 0 +

    Case when A.IsOtorisasi4=1 then 1 else 0 +

    Case when A.IsOtorisasi5=1 then 1 else 0 */=1/*A.MaxOL*/ then 0

    else 1

     As INTEGER) =@NeedOto

    and @Id= Left(a.NoBukti,1)

	Group By B.kodeBrg,H.namaBrg,h.SAT1,h.SAT2

	Order By B.kodeBrg

If @needOto=2

    Select Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,B.KODEBRG,h.namabrg,sum(COALESCE(b.QNT,0)) Qnt,sum(COALESCE(b.QNT2,0)) qnt2,h.SAT1,h.SAT2,

        SUM(COALESCE(b.ndpp,0)) nDPP, Sum(COALESCE(B.NDPPRp,0)) NDPPRp,

        Sum(COALESCE(B.NPPNRp,0)) NPPNRP, Sum(COALESCE(B.NNETRp,0)) NnetRp

	From dbSO A

	Left Outer join dbSODet B on B.NoBukti=a.NoBukti

	Left outer join DBBARANG H on H.KODEBRG=b.KODEBRG

	Where a.Tanggal between @tgl1 and @tgl2

	and @Id= Left(a.NoBukti,1)

	Group By B.kodeBrg,H.namaBrg,h.SAT1,h.SAT2

	Order By B.kodeBrg;

-- Sp_ReportSOvsSPKvsHasilPrd
CREATE PROCEDURE IF NOT EXISTS Sp_ReportSOvsSPKvsHasilPrd AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 

select @Id=SUBSTRING(@Id,1,1)

if @Id=''

if @Ordr='N'

		if @isiList='' 

		 exec('select ''Gabungan'' Perusahaan,* from vw_SOvsSPKvsHasilPrd where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		 order by NoSO,Tanggal')

		 else

		 Exec('select ''Gabungan'' Perusahaan,* from vw_SOvsSPKvsHasilPrd where NoBukti IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

         order by NoSO,Tanggal')

		 

	else If @Ordr='B'

		if @isiList=''

		 exec('select ''Gabungan'' Perusahaan,* from vw_SOvsSPKvsHasilPrd where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		 order by KodeBrg')

		else

		 exec('select ''Gabungan'' Perusahaan,* from vw_SOvsSPKvsHasilPrd where Kodebrg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		 order by KodeBrg') 

		 

	else If @Ordr='C'

		if @isiList=''

		exec(' select ''Gabungan'' Perusahaan,* from vw_SOvsSPKvsHasilPrd where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		order by KodeCust')

		else

		exec(' select ''Gabungan'' Perusahaan,* from vw_SOvsSPKvsHasilPrd where KodeCust IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		order by KodeCust')


else

if @Ordr='N'

		if @isiList='' 

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from vw_SOvsSPKvsHasilPrd where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		 and '''+@ID+'''= Left(NoBukti,1)

		 order by NoSO,Tanggal')

		 else

		 Exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from vw_SOvsSPKvsHasilPrd where NoBukti IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

         and '''+@ID+'''= Left(NoBukti,1)

         order by NoSO,Tanggal')

		 

	else If @Ordr='B'

		if @isiList=''

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from vw_SOvsSPKvsHasilPrd where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		 and '''+@ID+'''= Left(NoBukti,1)

		 order by KodeBrg')

		else

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from vw_SOvsSPKvsHasilPrd where Kodebrg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		 and '''+@ID+'''= Left(NoBukti,1)

		 order by KodeBrg') 

		 

	else If @Ordr='C'

		if @isiList=''

		exec(' select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from vw_SOvsSPKvsHasilPrd where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		and '''+@ID+'''= Left(NoBukti,1)

		order by KodeCust')

		else

		exec(' select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from vw_SOvsSPKvsHasilPrd where KodeCust IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		and '''+@ID+'''= Left(NoBukti,1)

		order by KodeCust');

-- Sp_ReportSOxDet
CREATE PROCEDURE IF NOT EXISTS Sp_ReportSOxDet AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 



if @SReport='T'

If @Ordr='N'

		select * from vwreportSOx where Tanggal between @tgl1 and @tgl2 order by NoBukti,Tanggal

		 

	else If @Ordr='B'

		select * from vwreportSOx where Tanggal between @tgl1 and @tgl2 order by KodeBrg

		 

	else If @Ordr='C'

		select * from vwreportSOx where Tanggal between @tgl1 and @tgl2 order by KodeCustSupp;

-- Sp_ReportSoxRek
CREATE PROCEDURE IF NOT EXISTS Sp_ReportSoxRek AS ---- DECLARE REMOVED,@Tgl1 Datetime,@tgl2 datetime

--select @Tgl1='01/01/2012',@tgl2='07/17/2013',@Choice='B'



If @Choice='N'

Select  A.Nobukti, P.Tanggal,P.KODECUST,C.NAMACUSTSUPP,P.NoPesanan,P.TGLJATUHTEMPO,P.TglKirim,

        sum(COALESCE(A.Qnt,0)) Qnt, sum(COALESCE(A.Qnt2,0)) Qnt2, sum(COALESCE(A.QntSPP,0))QntSpp, 

        sum(COALESCE(A.Qnt2SPP,0)) Qnt2Spp, sum(COALESCE(A.QntSisa,0)) QntSisa,  sum(COALESCE(A.Qnt2Sisa,0)) Qnt2Sisa

	From    vwBrowsOutSO_SPP A

	Left Outer Join DBSO P on P.NoBukti=A.NoBukti

	Left Outer Join vwBrowsCustomer S on S.KodeCust=P.KodeCust and S.Sales=P.KODESLS

	Left Outer Join dbBarang B on B.KodeBrg=A.KodeBrg

	Left outer join DBCUSTSUPP C on p.KODECUST = C.KODECUSTSUPP

	where A.islengkap=0 

	Group By A.nobukti,p.TANGGAL,P.KODECUST,C.NAMACUSTSUPP,P.NoPesanan,P.TGLJATUHTEMPO,P.TglKirim 

	order by A.NoBukti,p.TANGGAL,P.KODECUST,C.NAMACUSTSUPP 

 

else if @Choice='B'

Select  A.KodeBrg,B.NAMABRG, P.Tanggal, 

        sum(COALESCE(A.Qnt,0)) Qnt, sum(COALESCE(A.Qnt2,0)) Qnt2, sum(COALESCE(A.QntSPP,0))QntSpp, 

        sum(COALESCE(A.Qnt2SPP,0)) Qnt2Spp, sum(COALESCE(A.QntSisa,0)) QntSisa,  sum(COALESCE(A.Qnt2Sisa,0)) Qnt2Sisa

	From    vwBrowsOutSO_SPP A

	Left Outer Join DBSO P on P.NoBukti=A.NoBukti

	Left Outer Join vwBrowsCustomer S on S.KodeCust=P.KodeCust and S.Sales=P.KODESLS

	Left Outer Join dbBarang B on B.KodeBrg=A.KodeBrg

	where A.islengkap=0 

	Group by A.KodeBrg,B.NAMABRG,P.TANGGAL

	order by A.KodeBrg,B.NAMABRG,P.TANGGAL



else if @Choice='C'

Select  p.KODECUST,C.NAMACUSTSUPP, P.Tanggal,

        sum(COALESCE(A.Qnt,0)) Qnt, sum(COALESCE(A.Qnt2,0)) Qnt2, sum(COALESCE(A.QntSPP,0))QntSpp, 

        sum(COALESCE(A.Qnt2SPP,0)) Qnt2Spp, sum(COALESCE(A.QntSisa,0)) QntSisa,  sum(COALESCE(A.Qnt2Sisa,0)) Qnt2Sisa

	From    vwBrowsOutSO_SPP A

	Left Outer Join DBSO P on P.NoBukti=A.NoBukti

	Left Outer Join vwBrowsCustomer S on S.KodeCust=P.KodeCust and S.Sales=P.KODESLS

	Left Outer Join dbBarang B on B.KodeBrg=A.KodeBrg

	Left Outer join DBCUSTSUPP C on p.KODECUST = C.KODECUSTSUPP

	where A.islengkap=0 

	Group by  p.KODECUST,C.NAMACUSTSUPP, P.Tanggal

	order by  p.KODECUST,C.NAMACUSTSUPP, P.Tanggal;

-- Sp_ReportSPBACCDet
CREATE PROCEDURE IF NOT EXISTS Sp_ReportSPBACCDet AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 

--select @Id=Case when @Id='CA' Then SUBSTRING(@Id,1,1) else SUBSTRING(@Id,1,2) 

-- DECLARE REMOVED

select @Devisi=Devisi from DBDEVISI where NamaDevisi=@Id

if @Id='' 

if @SReport='T'

If @Ordr='N'

		If @NeedOto=0 or @NeedOto=1

		 if @isiList='' 

		  exec('select ''Gabungan'' Perusahaan,* from VwReportSpBACC where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

		  order by NoBukti,Tanggal')

		  else

		  exec('select * from VwReportSpBACC where NoBukti  IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

		  order by NoBukti,Tanggal')

		 

		If @NeedOto=2

		 if @isiList='' 

		  exec('select ''Gabungan'' Perusahaan,* from VwReportSpBACC where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  order by NoBukti,Tanggal') 

		 else

		  exec('select ''Gabungan'' Perusahaan,* from VwReportSpBACC where  NoBukti  IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  order by NoBukti,Tanggal') 


	else If @Ordr='B'

		If @NeedOto=0 or @NeedOto=1

		 if  @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwReportSpBACC where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

		  order by KodeBrg')

		  else

		  exec('select * from VwReportSpBACC where KodeBrg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

		  order by KodeBrg')

		  

		If @NeedOto=2

		 if  @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwReportSpBACC where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  order by KodeBrg') 

		  else

		  exec('select * from VwReportSpBACC where KodeBrg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  order by KodeBrg')


	else If @Ordr='C'

		If @NeedOto=0 or @NeedOto=1

		 if  @isiList='' 

		  exec('select ''Gabungan'' Perusahaan,* from VwReportSpBACC where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

		  order by KodeCustSupp')

		  else

		  exec('select ''Gabungan'' Perusahaan,* from VwReportSpBACC where CustProject IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

		  order by KodeCustSupp')

		 

		 If @NeedOto=2

		  if @isiList='' 

		  exec('select ''Gabungan'' Perusahaan,* from VwReportSpBACC where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		  order by KodeCustSupp')

		  else

		  exec('select ''Gabungan'' Perusahaan,* from VwReportSpBACC where CustProject IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		  order by KodeCustSupp')


	else If @Ordr='D'

		If @NeedOto=0 or @NeedOto=1

		 if  @isiList='' 

		  exec('select ''Gabungan'' Perusahaan,* from VwReportSpBACC where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

		  order by Kodegdg')

		  else

		  exec('select ''Gabungan'' Perusahaan,* from VwReportSpBACC where Kodegdg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

		  order by Kodegdg')

		 

		 If @NeedOto=2

		  if @isiList='' 

		  exec('select ''Gabungan'' Perusahaan,* from VwReportSpBACC where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		  order by Kodegdg')

		  else

		  exec('select ''Gabungan'' Perusahaan,* from VwReportSpBACC where Kodegdg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		  order by Kodegdg')


else

if @SReport='T'

If @Ordr='N'

		If @NeedOto=0 or @NeedOto=1

		 if @isiList='' 

		  exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSpBACC where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

		  and Devisi='''+@Devisi+''' /*'''+@ID+'''= case when '''+@ID+'''=''C'' then Left(NoBukti,1) else Left(NoBukti,2) */

		  order by NoBukti,Tanggal')

		  else

		  exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSpBACC where NoBukti  IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

		  and Devisi='''+@Devisi+''' 

		  order by NoBukti,Tanggal')

		 

		If @NeedOto=2

		 if @isiList='' 

		  exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSpBACC where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and Devisi='''+@Devisi+''' 

		  order by NoBukti,Tanggal') 

		 else

		  exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSpBACC where  NoBukti  IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and Devisi='''+@Devisi+''' 

		  order by NoBukti,Tanggal') 


	else If @Ordr='B'

		If @NeedOto=0 or @NeedOto=1

		 if  @isiList=''

		  exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSpBACC where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

		  and Devisi='''+@Devisi+''' 

		  order by KodeBrg')

		  else

		  exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSpBACC where KodeBrg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

		  and Devisi='''+@Devisi+''' 

		  order by KodeBrg')

		  

		If @NeedOto=2

		 if  @isiList=''

		  exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSpBACC where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and Devisi='''+@Devisi+''' 

		  order by KodeBrg') 

		  else

		  exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSpBACC where KodeBrg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and Devisi='''+@Devisi+''' 

		  order by KodeBrg')


	else If @Ordr='C'

		If @NeedOto=0 or @NeedOto=1

		 if  @isiList='' 

		  exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSpBACC where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

		  and Devisi='''+@Devisi+''' 

		  order by KodeCustSupp')

		  else

		  exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSpBACC where CustProject IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

		  and Devisi='''+@Devisi+''' 

		  order by KodeCustSupp')

		 

		 If @NeedOto=2

		  if @isiList='' 

		  exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSpBACC where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		  and Devisi='''+@Devisi+''' 

		  order by KodeCustSupp')

		  else

		  exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSpBACC where CustProject IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		  and Devisi='''+@Devisi+''' 

		  order by KodeCustSupp')


	else If @Ordr='D'

		If @NeedOto=0 or @NeedOto=1

		 if  @isiList='' 

		  exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSpBACC where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

		  and Devisi='''+@Devisi+''' 

		  order by Kodegdg')

		  else

		  exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSpBACC where Kodegdg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

		  and Devisi='''+@Devisi+''' 

		  order by Kodegdg')

		 

		 If @NeedOto=2

		  if @isiList='' 

		  exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSpBACC where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		  and Devisi='''+@Devisi+''' 

		  order by Kodegdg')

		  else

		  exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSpBACC where Kodegdg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		  and Devisi='''+@Devisi+''' 

		  order by Kodegdg');

-- Sp_ReportSPBACCPlusDet
CREATE PROCEDURE IF NOT EXISTS Sp_ReportSPBACCPlusDet AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 

select @Id=SUBSTRING(@Id,1,1)

if @Id=''

if @SReport='T'

If @Ordr='N'

		If @NeedOto=0 or @NeedOto=1

		 if @isiList='' 

		  exec('select ''Gabungan'' Perusahaan,* from [VwreportSPBPlusReturACC] where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and TglSPB>''2016-07-31''   and NeedOtorisasi='+@NeedOto+'

		  order by NoBukti,Tanggal')

		  else

		   exec('select ''Gabungan'' Perusahaan,* from VwreportSPBPlusReturACC where NoBukti  IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and TglSPB>''2016-07-31''  and NeedOtorisasi='+@NeedOto+'

		  order by NoBukti,Tanggal')

		  

		If @NeedOto=2

		 if @isiList='' 

		  exec('select ''Gabungan'' Perusahaan,* from [VwreportSPBPlusReturACC] where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and TglSPB>''2016-07-31'' 

		  order by NoBukti,Tanggal') 

		 else

		   exec('select ''Gabungan'' Perusahaan,* from [VwreportSPBPlusReturACC] where NoBukti  IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and TglSPB>''2016-07-31'' 

		  order by NoBukti,Tanggal')  


	else If @Ordr='B'

		If @NeedOto=0 or @NeedOto=1

		 if @isiList='' 

		  exec('select ''Gabungan'' Perusahaan,* from [VwreportSPBPlusReturACC] where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and TglSPB>''2016-07-31'' and NeedOtorisasi='+@NeedOto+'

		  order by KodeBrg')

		 else

		  exec('select ''Gabungan'' Perusahaan,* from [VwreportSPBPlusReturACC] where KodeBrg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and TglSPB>''2016-07-31'' and NeedOtorisasi='+@NeedOto+'

		  order by KodeBrg')

		 

		If @NeedOto=2

		 if @isiList='' 

		  exec('select * from [VwreportSPBPlusReturACC] where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and TglSPB>''2016-07-31'' 

		  order by KodeBrg')

		 else

		   exec('select * from [VwreportSPBPlusReturACC] where KodeBrg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and TglSPB>''2016-07-31'' 

		  order by KodeBrg')


	else If @Ordr='C'

		If @NeedOto=0 or @NeedOto=1

		 if @isiList='' 

		  exec('select ''Gabungan'' Perusahaan,* from [VwreportSPBPlusReturACC] where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and TglSPB>''2016-07-31''  and NeedOtorisasi='+@NeedOto+'

		  order by KodeCustSupp')

		 else

		  exec('select ''Gabungan'' Perusahaan,* from [VwreportSPBPlusReturACC] where CustProject IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and TglSPB>''2016-07-31''  and NeedOtorisasi='+@NeedOto+'

		  order by KodeCustSupp')

		  

		 If @NeedOto=2

		 if @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from [VwreportSPBPlusReturACC] where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and TglSPB>''2016-07-31'' 

		  order by KodeCustSupp')

		 else

		  exec('select ''Gabungan'' Perusahaan,* from [VwreportSPBPlusReturACC] where CustProject IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and TglSPB>''2016-07-31'' 

		  order by KodeCustSupp')


	  else If @Ordr='D'

		If @NeedOto=0 or @NeedOto=1

		 if @isiList='' 

		  exec('select ''Gabungan'' Perusahaan,* from [VwreportSPBPlusReturACC] where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and TglSPB>''2016-07-31''  and NeedOtorisasi='+@NeedOto+'

		  order by Kodegdg')

		 else

		  exec('select ''Gabungan'' Perusahaan,* from [VwreportSPBPlusReturACC] where Kodegdg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and TglSPB>''2016-07-31''  and NeedOtorisasi='+@NeedOto+'

		  order by Kodegdg')

		  

		 If @NeedOto=2

		 if @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from [VwreportSPBPlusReturACC] where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and TglSPB>''2016-07-31'' 

		  order by Kodegdg')

		 else

		  exec('select ''Gabungan'' Perusahaan,* from [VwreportSPBPlusReturACC] where Kodegdg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and TglSPB>''2016-07-31'' 

		  order by Kodegdg')


else

if @SReport='T'

If @Ordr='N'

		If @NeedOto=0 or @NeedOto=1

		 if @isiList='' 

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from [VwreportSPBPlusReturACC] where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and TglSPB>''2016-07-31''   and NeedOtorisasi='+@NeedOto+'

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by NoBukti,Tanggal')

		  else

		   exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportSPBPlusReturACC where NoBukti  IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and TglSPB>''2016-07-31''  and NeedOtorisasi='+@NeedOto+'

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by NoBukti,Tanggal')

		  

		If @NeedOto=2

		 if @isiList='' 

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from [VwreportSPBPlusReturACC] where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and TglSPB>''2016-07-31'' 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by NoBukti,Tanggal') 

		 else

		   exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from [VwreportSPBPlusReturACC] where NoBukti  IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and TglSPB>''2016-07-31'' 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by NoBukti,Tanggal')  


	else If @Ordr='B'

		If @NeedOto=0 or @NeedOto=1

		 if @isiList='' 

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from [VwreportSPBPlusReturACC] where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and TglSPB>''2016-07-31'' and NeedOtorisasi='+@NeedOto+'

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeBrg')

		 else

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from [VwreportSPBPlusReturACC] where KodeBrg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and TglSPB>''2016-07-31'' and NeedOtorisasi='+@NeedOto+'

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeBrg')

		 

		If @NeedOto=2

		 if @isiList='' 

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from [VwreportSPBPlusReturACC] where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and TglSPB>''2016-07-31'' 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeBrg')

		 else

		   exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from [VwreportSPBPlusReturACC] where KodeBrg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and TglSPB>''2016-07-31'' 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeBrg')


	else If @Ordr='C'

		If @NeedOto=0 or @NeedOto=1

		 if @isiList='' 

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from [VwreportSPBPlusReturACC] where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and TglSPB>''2016-07-31''  and NeedOtorisasi='+@NeedOto+'

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp')

		 else

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from [VwreportSPBPlusReturACC] where CustProject IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and TglSPB>''2016-07-31''  and NeedOtorisasi='+@NeedOto+'

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp')

		  

		 If @NeedOto=2

		 if @isiList=''

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from [VwreportSPBPlusReturACC] where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and TglSPB>''2016-07-31'' 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp')

		 else

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from [VwreportSPBPlusReturACC] where CustProject IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and TglSPB>''2016-07-31'' 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp')


	else If @Ordr='D'

		If @NeedOto=0 or @NeedOto=1

		 if @isiList='' 

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from [VwreportSPBPlusReturACC] where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and TglSPB>''2016-07-31''  and NeedOtorisasi='+@NeedOto+'

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeGdg')

		 else

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from [VwreportSPBPlusReturACC] where KodeGdg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and TglSPB>''2016-07-31''  and NeedOtorisasi='+@NeedOto+'

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeGdg')

		  

		 If @NeedOto=2

		 if @isiList=''

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from [VwreportSPBPlusReturACC] where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and TglSPB>''2016-07-31'' 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeGdg')

		 else

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from [VwreportSPBPlusReturACC] where KodeGdg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and TglSPB>''2016-07-31'' 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeGdg');

-- Sp_ReportSpbACCRek
CREATE PROCEDURE IF NOT EXISTS Sp_ReportSpbACCRek AS ---- DECLARE REMOVED,@Tgl1 Datetime,@tgl2 datetime

--select @Tgl1='01/01/2012',@tgl2='07/17/2013',@Choice='B'



If @Choice='N'

If @NeedOto=0 or @NeedOto=1

	select 	B.NOBUKTI, A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,

        Sum(COALESCE(B.QNT,0)) Qnt, Sum(COALESCE(B.QNT2,0)) Qnt2, Sum(COALESCE(B.NetW,0)) NetW, Sum(COALESCE(B.GrossW,0)) GrosW

	from	dbSPBDet B

	left outer join dbBarang C on C.KodeBrg=B.KodeBrg

	Left Outer join dbSPB A on B.NoBukti = A.NoBukti

	Left Outer Join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

	where A.Tanggal between @Tgl1 and @Tgl2 and       

	Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

    Case when A.IsOtorisasi2=1 then 1 else 0 +

    Case when A.IsOtorisasi3=1 then 1 else 0 +

    Case when A.IsOtorisasi4=1 then 1 else 0 +

    Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

    else 1

     As INTEGER)= @Needoto

	Group By B.NOBUKTI, A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP

	Order by B.NOBUKTI, A.Tanggal

ELSE If @NeedOto=2

	select 	B.NOBUKTI, A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,

        Sum(COALESCE(B.QNT,0)) Qnt, Sum(COALESCE(B.QNT2,0)) Qnt2, Sum(COALESCE(B.NetW,0)) NetW, Sum(COALESCE(B.GrossW,0)) GrosW

	from	dbSPBDet B

	left outer join dbBarang C on C.KodeBrg=B.KodeBrg

	Left Outer join dbSPB A on B.NoBukti = A.NoBukti

	Left Outer Join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

	where A.Tanggal between @Tgl1 and @Tgl2 

	Group By B.NOBUKTI, A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP

	Order by B.NOBUKTI, A.Tanggal



If @Choice='B'

If @NeedOto=0 or @NeedOto=1

	select 	B.KodeBrg,E.NAMABRG ,A.Tanggal,

        Sum(COALESCE(B.QNT,0)) Qnt, Sum(COALESCE(B.QNT2,0)) Qnt2, Sum(COALESCE(B.NetW,0)) NetW, Sum(COALESCE(B.GrossW,0)) GrosW

	from	dbSPBDet B

	left outer join dbBarang C on C.KodeBrg=B.KodeBrg

	Left Outer join dbSPB A on B.NoBukti = A.NoBukti

	Left Outer Join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

	Left Outer join DBBARANG E on b.KodeBrg = E.KODEBRG

	where A.Tanggal between @Tgl1 and @Tgl2 and       

	Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

    Case when A.IsOtorisasi2=1 then 1 else 0 +

    Case when A.IsOtorisasi3=1 then 1 else 0 +

    Case when A.IsOtorisasi4=1 then 1 else 0 +

    Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

    else 1

     As INTEGER)= @Needoto

	Group By B.KodeBrg,E.NAMABRG ,A.Tanggal

	Order by B.KodeBrg,E.NAMABRG ,A.Tanggal

ELSE If @NeedOto=2

	select 	B.KodeBrg,E.NAMABRG ,A.Tanggal,

        Sum(COALESCE(B.QNT,0)) Qnt, Sum(COALESCE(B.QNT2,0)) Qnt2, Sum(COALESCE(B.NetW,0)) NetW, Sum(COALESCE(B.GrossW,0)) GrosW

	from	dbSPBDet B

	left outer join dbBarang C on C.KodeBrg=B.KodeBrg

	Left Outer join dbSPB A on B.NoBukti = A.NoBukti

	Left Outer Join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

	Left Outer join DBBARANG E on b.KodeBrg = E.KODEBRG

	where A.Tanggal between @Tgl1 and @Tgl2 

	Group By B.KodeBrg,E.NAMABRG ,A.Tanggal

	Order by B.KodeBrg,E.NAMABRG ,A.Tanggal



If @Choice='C'

If @NeedOto=0 or @NeedOto=1

	select 	A.KodeCustSupp,D.NAMACUSTSUPP ,A.Tanggal,

        Sum(COALESCE(B.QNT,0)) Qnt, Sum(COALESCE(B.QNT2,0)) Qnt2, Sum(COALESCE(B.NetW,0)) NetW, Sum(COALESCE(B.GrossW,0)) GrosW

	from	dbSPBDet B

	left outer join dbBarang C on C.KodeBrg=B.KodeBrg

	Left Outer join dbSPB A on B.NoBukti = A.NoBukti

	Left Outer Join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

	Left Outer join DBBARANG E on b.KodeBrg = E.NAMABRG

	where A.Tanggal between @Tgl1 and @Tgl2 and       

	Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

    Case when A.IsOtorisasi2=1 then 1 else 0 +

    Case when A.IsOtorisasi3=1 then 1 else 0 +

    Case when A.IsOtorisasi4=1 then 1 else 0 +

    Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

    else 1

     As INTEGER)= @Needoto

	Group By A.KodeCustSupp,D.NAMACUSTSUPP ,A.Tanggal

	Order by A.KodeCustSupp,D.NAMACUSTSUPP ,A.Tanggal

else If @NeedOto=2

	select 	A.KodeCustSupp,D.NAMACUSTSUPP ,A.Tanggal,

        Sum(COALESCE(B.QNT,0)) Qnt, Sum(COALESCE(B.QNT2,0)) Qnt2, Sum(COALESCE(B.NetW,0)) NetW, Sum(COALESCE(B.GrossW,0)) GrosW

	from	dbSPBDet B

	left outer join dbBarang C on C.KodeBrg=B.KodeBrg

	Left Outer join dbSPB A on B.NoBukti = A.NoBukti

	Left Outer Join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

	Left Outer join DBBARANG E on b.KodeBrg = E.NAMABRG

	where A.Tanggal between @Tgl1 and @Tgl2 

	Group By A.KodeCustSupp,D.NAMACUSTSUPP ,A.Tanggal

	Order by A.KodeCustSupp,D.NAMACUSTSUPP ,A.Tanggal



If @Choice='D'

If @NeedOto=0 or @NeedOto=1

	select 	b.KodeGdg,D.NAMACUSTSUPP ,A.Tanggal,

        Sum(COALESCE(B.QNT,0)) Qnt, Sum(COALESCE(B.QNT2,0)) Qnt2, Sum(COALESCE(B.NetW,0)) NetW, Sum(COALESCE(B.GrossW,0)) GrosW

	from	dbSPBDet B

	left outer join dbBarang C on C.KodeBrg=B.KodeBrg

	Left Outer join dbSPB A on B.NoBukti = A.NoBukti

	Left Outer Join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

	Left Outer join DBBARANG E on b.KodeBrg = E.NAMABRG

	where A.Tanggal between @Tgl1 and @Tgl2 and       

	Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

    Case when A.IsOtorisasi2=1 then 1 else 0 +

    Case when A.IsOtorisasi3=1 then 1 else 0 +

    Case when A.IsOtorisasi4=1 then 1 else 0 +

    Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

    else 1

     As INTEGER)= @Needoto

	Group By b.KodeGdg,D.NAMACUSTSUPP ,A.Tanggal

	Order by b.KodeGdg,D.NAMACUSTSUPP ,A.Tanggal

else If @NeedOto=2

	select 	b.KodeGdg,D.NAMACUSTSUPP ,A.Tanggal,

        Sum(COALESCE(B.QNT,0)) Qnt, Sum(COALESCE(B.QNT2,0)) Qnt2, Sum(COALESCE(B.NetW,0)) NetW, Sum(COALESCE(B.GrossW,0)) GrosW

	from	dbSPBDet B

	left outer join dbBarang C on C.KodeBrg=B.KodeBrg

	Left Outer join dbSPB A on B.NoBukti = A.NoBukti

	Left Outer Join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

	Left Outer join DBBARANG E on b.KodeBrg = E.NAMABRG

	where A.Tanggal between @Tgl1 and @Tgl2 

	Group By b.KodeGdg,D.NAMACUSTSUPP ,A.Tanggal

	Order by b.KodeGdg,D.NAMACUSTSUPP ,A.Tanggal;

-- Sp_ReportSPBDet
CREATE PROCEDURE IF NOT EXISTS Sp_ReportSPBDet AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 



/*if @SReport='T'

If @Ordr='N'

		If @NeedOto=0 or @NeedOto=1

		  select * from VwReportSpB where Tanggal between @tgl1 and @tgl2 and NeedOtorisasi=@NeedOto

		  order by NoBukti

		If @NeedOto=2

		  select * from VwReportSpB where Tanggal between @tgl1 and @tgl2

		  order by NoBukti

		 

	else If @Ordr='B'

		If @NeedOto=0 or @NeedOto=1

		  select * from VwReportSpB where Tanggal between @tgl1 and @tgl2 and NeedOtorisasi=@NeedOto

		  order by KodeBrg

		If @NeedOto=2

		  select * from VwReportSpB where Tanggal between @tgl1 and @tgl2

		  order by KodeBrg  

		 

	else If @Ordr='C'

		If @NeedOto=0 or @NeedOto=1

		  select * from VwReportSpB where Tanggal between @tgl1 and @tgl2 and NeedOtorisasi=@NeedOto

		  order by KodeCustSupp,NOBUKTI

		 If @NeedOto=2

		  select * from VwReportSpB where Tanggal between @tgl1 and @tgl2 

		  order by KodeCustSupp


*/

--select @Id=Case when @Id='CA' Then SUBSTRING(@Id,1,1) else SUBSTRING(@Id,1,2) 

-- DECLARE REMOVED

select @Devisi=Devisi from DBDEVISI where NamaDevisi=@Id

if @Id=''

if @SReport='T'

If @Ordr='N'

		If @NeedOto=0 or @NeedOto=1

		 if @isiList='' 

		  exec('select ''Gabungan'' Perusahaan,* from VwReportSpB where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

		  order by NoBukti,Tanggal')

		  else

		  exec('select ''Gabungan'' Perusahaan,* from VwReportSpB where NoBukti  IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

		  order by NoBukti,Tanggal')

		 

		If @NeedOto=2

		 if @isiList='' 

		  exec('select ''Gabungan'' Perusahaan,* from VwReportSpB where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  order by NoBukti,Tanggal') 

		 else

		  exec('select ''Gabungan'' Perusahaan,* from VwReportSpB where  NoBukti  IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  order by NoBukti,Tanggal') 


	else If @Ordr='B'

		If @NeedOto=0 or @NeedOto=1

		 if  @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwReportSpB where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

		  order by KodeBrg')

		  else

		  exec('select ''Gabungan'' Perusahaan,* from VwReportSpB where KodeBrg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

		  order by KodeBrg')

		  

		If @NeedOto=2

		 if  @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwReportSpB where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  order by KodeBrg') 

		  else

		  exec('select ''Gabungan'' Perusahaan,* from VwReportSpB where KodeBrg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  order by KodeBrg')


	else If @Ordr='C'

		If @NeedOto=0 or @NeedOto=1

		 if  @isiList='' 

		  exec('select ''Gabungan'' Perusahaan,* from VwReportSpB where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

		  order by KodeCustSupp')

		  else

		  exec('select ''Gabungan'' Perusahaan,* from VwReportSpB where CustProject IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

		  order by KodeCustSupp')

		 

		 If @NeedOto=2

		  if @isiList='' 

		  exec('select ''Gabungan'' Perusahaan,* from VwReportSpB where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		  order by KodeCustSupp')

		  else

		  exec('select ''Gabungan'' Perusahaan,* from VwReportSpB where CustProject IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		  order by KodeCustSupp')


	  else If @Ordr='S'

		If @NeedOto=0 or @NeedOto=1

		 if @isiList='' 

		  exec('select ''Gabungan'' Perusahaan,* from VwReportSpB where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

		  order by NoPolKend,NoBukti,Tanggal')

		  else

		  exec('select ''Gabungan'' Perusahaan,* from VwReportSpB where NoPolKend  IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

		  order by NoPolKend,NoBukti,Tanggal')

		 

		If @NeedOto=2

		 if @isiList='' 

		  exec('select ''Gabungan'' Perusahaan,* from VwReportSpB where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  order by NoPolKend,NoBukti,Tanggal') 

		 else

		  exec('select ''Gabungan'' Perusahaan,* from VwReportSpB where  NoBukti  IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  order by NoPolKend,NoBukti,Tanggal') 


else

if @SReport='T'

If @Ordr='N'

		If @NeedOto=0 or @NeedOto=1

		 if @isiList='' 

		  exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSpB where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

		  and Devisi='''+@Devisi+''' 

		  order by NoBukti,Tanggal')

		  else

		  exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSpB where NoBukti  IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

		  and Devisi='''+@Devisi+''' 

		  order by NoBukti,Tanggal')

		 

		If @NeedOto=2

		 if @isiList='' 

		  exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSpB where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and Devisi='''+@Devisi+''' 

		  order by NoBukti,Tanggal') 

		 else

		  exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSpB where  NoBukti  IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and Devisi='''+@Devisi+''' 

		  order by NoBukti,Tanggal') 


	else If @Ordr='B'

		If @NeedOto=0 or @NeedOto=1

		 if  @isiList=''

		  exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSpB where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

		  and Devisi='''+@Devisi+''' 

		  order by KodeBrg')

		  else

		  exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSpB where KodeBrg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

		  and Devisi='''+@Devisi+''' 

		  order by KodeBrg')

		  

		If @NeedOto=2

		 if  @isiList=''

		  exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSpB where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and Devisi='''+@Devisi+''' 

		  order by KodeBrg') 

		  else

		  exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSpB where KodeBrg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and Devisi='''+@Devisi+''' 

		  order by KodeBrg')


	else If @Ordr='C'

		If @NeedOto=0 or @NeedOto=1

		 if  @isiList='' 

		  exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSpB where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

		  and Devisi='''+@Devisi+''' 

		  order by KodeCustSupp')

		  else

		  exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSpB where CustProject IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

		  and Devisi='''+@Devisi+''' 

		  order by KodeCustSupp')

		 

		 If @NeedOto=2

		  if @isiList='' 

		  exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSpB where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		  and Devisi='''+@Devisi+''' 

		  order by KodeCustSupp')

		  else

		  exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSpB where CustProject IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		  and Devisi='''+@Devisi+''' 

		  order by KodeCustSupp')


	  else If @Ordr='S'

		If @NeedOto=0 or @NeedOto=1

		 if @isiList='' 

		  exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSpB where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

		  and Devisi='''+@Devisi+''' 

		  order by NoPolKend,NoBukti,Tanggal')

		  else

		  exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSpB where NoPolKend  IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

		  and Devisi='''+@Devisi+''' 

		  order by NoPolKend,NoBukti,Tanggal')

		 

		If @NeedOto=2

		 if @isiList='' 

		  exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSpB where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and Devisi='''+@Devisi+''' 

		  order by NoPolKend,NoBukti,Tanggal') 

		 else

		  exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSpB where  NoPolKend  IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and Devisi='''+@Devisi+''' 

		  order by NoPolKend,NoBukti,Tanggal');

-- Sp_ReportSpbRek
CREATE PROCEDURE IF NOT EXISTS Sp_ReportSpbRek AS ---- DECLARE REMOVED,@Tgl1 Datetime,@tgl2 datetime

--select @Tgl1='01/01/2012',@tgl2='07/17/2013',@Choice='B'

select @Id=SUBSTRING(@Id,1,1)

if @Id=''

If @Choice='N'

If @NeedOto=0 or @NeedOto=1

	select 	'Gabungan' Perusahaan,B.NOBUKTI, A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,

        Sum(COALESCE(B.QNT,0)) Qnt, Sum(COALESCE(B.QNT2,0)) Qnt2, Sum(COALESCE(B.NetW,0)) NetW, Sum(COALESCE(B.GrossW,0)) GrosW

	from	dbSPBDet B

	left outer join dbBarang C on C.KodeBrg=B.KodeBrg

	Left Outer join dbSPB A on B.NoBukti = A.NoBukti

	Left Outer Join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

	where A.Tanggal between @Tgl1 and @Tgl2 and       

	Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

    Case when A.IsOtorisasi2=1 then 1 else 0 +

    Case when A.IsOtorisasi3=1 then 1 else 0 +

    Case when A.IsOtorisasi4=1 then 1 else 0 +

    Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

    else 1

     As INTEGER)= @Needoto

	Group By B.NOBUKTI, A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP

	Order by B.NOBUKTI, A.Tanggal

ELSE If @NeedOto=2

	select 'Gabungan' Perusahaan,	B.NOBUKTI, A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,

        Sum(COALESCE(B.QNT,0)) Qnt, Sum(COALESCE(B.QNT2,0)) Qnt2, Sum(COALESCE(B.NetW,0)) NetW, Sum(COALESCE(B.GrossW,0)) GrosW

	from	dbSPBDet B

	left outer join dbBarang C on C.KodeBrg=B.KodeBrg

	Left Outer join dbSPB A on B.NoBukti = A.NoBukti

	Left Outer Join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

	where A.Tanggal between @Tgl1 and @Tgl2 

	Group By B.NOBUKTI, A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP

	Order by B.NOBUKTI, A.Tanggal



If @Choice='B'

If @NeedOto=0 or @NeedOto=1

	select 	'Gabungan' Perusahaan,B.KodeBrg,E.NAMABRG ,A.Tanggal,

        Sum(COALESCE(B.QNT,0)) Qnt, Sum(COALESCE(B.QNT2,0)) Qnt2, Sum(COALESCE(B.NetW,0)) NetW, Sum(COALESCE(B.GrossW,0)) GrosW

	from	dbSPBDet B

	left outer join dbBarang C on C.KodeBrg=B.KodeBrg

	Left Outer join dbSPB A on B.NoBukti = A.NoBukti

	Left Outer Join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

	Left Outer join DBBARANG E on b.KodeBrg = E.KODEBRG

	where A.Tanggal between @Tgl1 and @Tgl2 and       

	Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

    Case when A.IsOtorisasi2=1 then 1 else 0 +

    Case when A.IsOtorisasi3=1 then 1 else 0 +

    Case when A.IsOtorisasi4=1 then 1 else 0 +

    Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

    else 1

     As INTEGER)= @Needoto

	Group By B.KodeBrg,E.NAMABRG ,A.Tanggal

	Order by B.KodeBrg,E.NAMABRG ,A.Tanggal

ELSE If @NeedOto=2

	select 	'Gabungan' Perusahaan,B.KodeBrg,E.NAMABRG ,A.Tanggal,

        Sum(COALESCE(B.QNT,0)) Qnt, Sum(COALESCE(B.QNT2,0)) Qnt2, Sum(COALESCE(B.NetW,0)) NetW, Sum(COALESCE(B.GrossW,0)) GrosW

	from	dbSPBDet B

	left outer join dbBarang C on C.KodeBrg=B.KodeBrg

	Left Outer join dbSPB A on B.NoBukti = A.NoBukti

	Left Outer Join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

	Left Outer join DBBARANG E on b.KodeBrg = E.KODEBRG

	where A.Tanggal between @Tgl1 and @Tgl2 

	Group By B.KodeBrg,E.NAMABRG ,A.Tanggal

	Order by B.KodeBrg,E.NAMABRG ,A.Tanggal



If @Choice='C'

If @NeedOto=0 or @NeedOto=1

	select 'Gabungan' Perusahaan,	A.KodeCustSupp,D.NAMACUSTSUPP ,A.Tanggal,

        Sum(COALESCE(B.QNT,0)) Qnt, Sum(COALESCE(B.QNT2,0)) Qnt2, Sum(COALESCE(B.NetW,0)) NetW, Sum(COALESCE(B.GrossW,0)) GrosW

	from	dbSPBDet B

	left outer join dbBarang C on C.KodeBrg=B.KodeBrg

	Left Outer join dbSPB A on B.NoBukti = A.NoBukti

	Left Outer Join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

	Left Outer join DBBARANG E on b.KodeBrg = E.NAMABRG

	where A.Tanggal between @Tgl1 and @Tgl2 and       

	Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

    Case when A.IsOtorisasi2=1 then 1 else 0 +

    Case when A.IsOtorisasi3=1 then 1 else 0 +

    Case when A.IsOtorisasi4=1 then 1 else 0 +

    Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

    else 1

     As INTEGER)= @Needoto

	Group By A.KodeCustSupp,D.NAMACUSTSUPP ,A.Tanggal

	Order by A.KodeCustSupp,D.NAMACUSTSUPP ,A.Tanggal

else If @NeedOto=2

	select 'Gabungan' Perusahaan,	A.KodeCustSupp,D.NAMACUSTSUPP ,A.Tanggal,

        Sum(COALESCE(B.QNT,0)) Qnt, Sum(COALESCE(B.QNT2,0)) Qnt2, Sum(COALESCE(B.NetW,0)) NetW, Sum(COALESCE(B.GrossW,0)) GrosW

	from	dbSPBDet B

	left outer join dbBarang C on C.KodeBrg=B.KodeBrg

	Left Outer join dbSPB A on B.NoBukti = A.NoBukti

	Left Outer Join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

	Left Outer join DBBARANG E on b.KodeBrg = E.NAMABRG

	where A.Tanggal between @Tgl1 and @Tgl2 

	Group By A.KodeCustSupp,D.NAMACUSTSUPP ,A.Tanggal

	Order by A.KodeCustSupp,D.NAMACUSTSUPP ,A.Tanggal



If @Choice='S'

If @NeedOto=0 or @NeedOto=1

	select 	'Gabungan' Perusahaan,B.NOBUKTI, A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,

        Sum(COALESCE(B.QNT,0)) Qnt, Sum(COALESCE(B.QNT2,0)) Qnt2, Sum(COALESCE(B.NetW,0)) NetW, Sum(COALESCE(B.GrossW,0)) GrosW,A.NoPolKend

	from	dbSPBDet B

	left outer join dbBarang C on C.KodeBrg=B.KodeBrg

	Left Outer join dbSPB A on B.NoBukti = A.NoBukti

	Left Outer Join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

	where A.Tanggal between @Tgl1 and @Tgl2 and       

	Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

    Case when A.IsOtorisasi2=1 then 1 else 0 +

    Case when A.IsOtorisasi3=1 then 1 else 0 +

    Case when A.IsOtorisasi4=1 then 1 else 0 +

    Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

    else 1

     As INTEGER)= @Needoto

	Group By A.NoPolKend,B.NOBUKTI, A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP

	Order by A.NoPolKend,B.NOBUKTI, A.Tanggal

ELSE If @NeedOto=2

	select 'Gabungan' Perusahaan,	B.NOBUKTI, A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,

        Sum(COALESCE(B.QNT,0)) Qnt, Sum(COALESCE(B.QNT2,0)) Qnt2, Sum(COALESCE(B.NetW,0)) NetW, Sum(COALESCE(B.GrossW,0)) GrosW,A.NoPolKend

	from	dbSPBDet B

	left outer join dbBarang C on C.KodeBrg=B.KodeBrg

	Left Outer join dbSPB A on B.NoBukti = A.NoBukti

	Left Outer Join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

	where A.Tanggal between @Tgl1 and @Tgl2 

	Group By A.NoPolKend,B.NOBUKTI, A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP

	Order by A.NoPolKend,B.NOBUKTI, A.Tanggal


else

If @Choice='N'

If @NeedOto=0 or @NeedOto=1

	select 	Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,B.NOBUKTI, A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,

        Sum(COALESCE(B.QNT,0)) Qnt, Sum(COALESCE(B.QNT2,0)) Qnt2, Sum(COALESCE(B.NetW,0)) NetW, Sum(COALESCE(B.GrossW,0)) GrosW

	from	dbSPBDet B

	left outer join dbBarang C on C.KodeBrg=B.KodeBrg

	Left Outer join dbSPB A on B.NoBukti = A.NoBukti

	Left Outer Join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

	where A.Tanggal between @Tgl1 and @Tgl2 and       

	Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

    Case when A.IsOtorisasi2=1 then 1 else 0 +

    Case when A.IsOtorisasi3=1 then 1 else 0 +

    Case when A.IsOtorisasi4=1 then 1 else 0 +

    Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

    else 1

     As INTEGER)= @Needoto

    and @Id= Left(a.NoBukti,1) 

	Group By B.NOBUKTI, A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP

	Order by B.NOBUKTI, A.Tanggal

ELSE If @NeedOto=2

	select 	Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,B.NOBUKTI, A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,

        Sum(COALESCE(B.QNT,0)) Qnt, Sum(COALESCE(B.QNT2,0)) Qnt2, Sum(COALESCE(B.NetW,0)) NetW, Sum(COALESCE(B.GrossW,0)) GrosW

	from	dbSPBDet B

	left outer join dbBarang C on C.KodeBrg=B.KodeBrg

	Left Outer join dbSPB A on B.NoBukti = A.NoBukti

	Left Outer Join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

	where A.Tanggal between @Tgl1 and @Tgl2 

	and @Id= Left(a.NoBukti,1) 

	Group By B.NOBUKTI, A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP

	Order by B.NOBUKTI, A.Tanggal



If @Choice='B'

If @NeedOto=0 or @NeedOto=1

	select 	Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,B.KodeBrg,E.NAMABRG ,A.Tanggal,

        Sum(COALESCE(B.QNT,0)) Qnt, Sum(COALESCE(B.QNT2,0)) Qnt2, Sum(COALESCE(B.NetW,0)) NetW, Sum(COALESCE(B.GrossW,0)) GrosW

	from	dbSPBDet B

	left outer join dbBarang C on C.KodeBrg=B.KodeBrg

	Left Outer join dbSPB A on B.NoBukti = A.NoBukti

	Left Outer Join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

	Left Outer join DBBARANG E on b.KodeBrg = E.KODEBRG

	where A.Tanggal between @Tgl1 and @Tgl2 and       

	Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

    Case when A.IsOtorisasi2=1 then 1 else 0 +

    Case when A.IsOtorisasi3=1 then 1 else 0 +

    Case when A.IsOtorisasi4=1 then 1 else 0 +

    Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

    else 1

     As INTEGER)= @Needoto

    and @Id= Left(a.NoBukti,1) 

	Group By B.KodeBrg,E.NAMABRG ,A.Tanggal

	Order by B.KodeBrg,E.NAMABRG ,A.Tanggal

ELSE If @NeedOto=2

	select 	Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,B.KodeBrg,E.NAMABRG ,A.Tanggal,

        Sum(COALESCE(B.QNT,0)) Qnt, Sum(COALESCE(B.QNT2,0)) Qnt2, Sum(COALESCE(B.NetW,0)) NetW, Sum(COALESCE(B.GrossW,0)) GrosW

	from	dbSPBDet B

	left outer join dbBarang C on C.KodeBrg=B.KodeBrg

	Left Outer join dbSPB A on B.NoBukti = A.NoBukti

	Left Outer Join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

	Left Outer join DBBARANG E on b.KodeBrg = E.KODEBRG

	where A.Tanggal between @Tgl1 and @Tgl2 

	and @Id= Left(a.NoBukti,1) 

	Group By B.KodeBrg,E.NAMABRG ,A.Tanggal

	Order by B.KodeBrg,E.NAMABRG ,A.Tanggal



If @Choice='C'

If @NeedOto=0 or @NeedOto=1

	select 	Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,A.KodeCustSupp,D.NAMACUSTSUPP ,A.Tanggal,

        Sum(COALESCE(B.QNT,0)) Qnt, Sum(COALESCE(B.QNT2,0)) Qnt2, Sum(COALESCE(B.NetW,0)) NetW, Sum(COALESCE(B.GrossW,0)) GrosW

	from	dbSPBDet B

	left outer join dbBarang C on C.KodeBrg=B.KodeBrg

	Left Outer join dbSPB A on B.NoBukti = A.NoBukti

	Left Outer Join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

	Left Outer join DBBARANG E on b.KodeBrg = E.NAMABRG

	where A.Tanggal between @Tgl1 and @Tgl2 and       

	Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

    Case when A.IsOtorisasi2=1 then 1 else 0 +

    Case when A.IsOtorisasi3=1 then 1 else 0 +

    Case when A.IsOtorisasi4=1 then 1 else 0 +

    Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

    else 1

     As INTEGER)= @Needoto

    and @Id= Left(a.NoBukti,1) 

	Group By A.KodeCustSupp,D.NAMACUSTSUPP ,A.Tanggal

	Order by A.KodeCustSupp,D.NAMACUSTSUPP ,A.Tanggal

else If @NeedOto=2

	select Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,	A.KodeCustSupp,D.NAMACUSTSUPP ,A.Tanggal,

        Sum(COALESCE(B.QNT,0)) Qnt, Sum(COALESCE(B.QNT2,0)) Qnt2, Sum(COALESCE(B.NetW,0)) NetW, Sum(COALESCE(B.GrossW,0)) GrosW

	from	dbSPBDet B

	left outer join dbBarang C on C.KodeBrg=B.KodeBrg

	Left Outer join dbSPB A on B.NoBukti = A.NoBukti

	Left Outer Join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

	Left Outer join DBBARANG E on b.KodeBrg = E.NAMABRG

	where A.Tanggal between @Tgl1 and @Tgl2 

	and @Id= Left(a.NoBukti,1) 

	Group By A.KodeCustSupp,D.NAMACUSTSUPP ,A.Tanggal

	Order by A.KodeCustSupp,D.NAMACUSTSUPP ,A.Tanggal


--select * from dbSPBDet;

-- Sp_ReportSPK
CREATE PROCEDURE IF NOT EXISTS Sp_ReportSPK AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 

if @Id=''

if @isiList='' 

		 exec('select ''Gabungan'' Perusahaan,* from VwreportSparePartTruck where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and KdDep=''MT-K''

		 order by Tanggal,NoBukti')

		 else

		 Exec('select ''Gabungan'' Perusahaan,* from VwreportSparePartTruck where NoBukti IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and KdDep=''MT-K''

         order by Tanggal,NoBukti')



else

if @isiList='' 

		 exec('select case when '''+@ID+'''=''BCA'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportSparePartTruck where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and KdDep=''MT-K''

		 and '''+@ID+'''=Case When Len('''+@ID+''')=3 Then Left(NoBukti,3) else Left(NoBukti,2) 

		 order by Tanggal,NoBukti')

		 else

		 Exec('select case when '''+@ID+'''=''BCA'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportSparePartTruck where NoBukti IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and KdDep=''MT-K''

         and '''+@ID+'''=Case When Len('''+@ID+''')=3 Then Left(NoBukti,3) else Left(NoBukti,2)

         order by Tanggal,NoBukti');

-- Sp_ReportSPPBDet
CREATE PROCEDURE IF NOT EXISTS Sp_ReportSPPBDet AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 



if @SReport='T'

If @Ordr='N'

		select * from VwReportSPpb where Tanggal between @tgl1 and @tgl2 order by NoBukti,Tanggal

		 

	else If @Ordr='B'

		select * from VwReportSPpb where Tanggal between @tgl1 and @tgl2 order by KodeBrg

		 

	else If @Ordr='C'

		select * from VwReportSpPb where Tanggal between @tgl1 and @tgl2 order by KodeCustSupp;

-- Sp_ReportSPPBRek
CREATE PROCEDURE IF NOT EXISTS Sp_ReportSPPBRek AS ---- DECLARE REMOVED,@Tgl1 DateTime,@Tgl2 Datetime

--Select @Choice='B',@Tgl1='01/01/2011',@Tgl2='01/01/2013'



If @Choice='N'

Select A.NoBukti,C.Tanggal,C.KodeCustSupp,D.NAMACUSTSUPP,

	 Sum(COALESCE(A.QNT,0))QNT,SUM(COALESCE(A.QNT2,0)) Qnt2,

	 Sum(COALESCE(A.NetW,0)) NetW,SUM(COALESCE(GrossW,0)) Grossw

	 from dbSPBDet A

     left outer join DBBARANG B on B.KODEBRG=A.Kodebrg

     Left Outer join dbSPB C on A.NoBukti = C.NoBukti

     Left Outer join DBCUSTSUPP D on c.KodeCustSupp = D.KODECUSTSUPP

     Group By A.NoBukti,C.Tanggal,C.KodeCustSupp,D.NAMACUSTSUPP

     order BY A.NoBukti,C.Tanggal

     

If @Choice='B'

Select A.KodeBrg,B.NAMABRG,C.Tanggal,Sum(COALESCE(A.QNT,0))QNT,SUM(COALESCE(A.QNT2,0)) Qnt2,

	 Sum(COALESCE(A.NetW,0)) NetW,SUM(COALESCE(GrossW,0)) Grossw

	 from dbSPBDet A

     left outer join DBBARANG B on B.KODEBRG=A.Kodebrg

     Left Outer join dbSPB C on A.NoBukti = C.NoBukti

     Left Outer join DBCUSTSUPP D on c.KodeCustSupp = D.KODECUSTSUPP

     Group By A.KodeBrg,B.NAMABRG,C.Tanggal

     order BY A.KodeBrg,B.NAMABRG,C.Tanggal

  

If @Choice='C'

Select C.KodeCustSupp,D.NAMACUSTSUPP,C.Tanggal,Sum(COALESCE(A.QNT,0))QNT,SUM(COALESCE(A.QNT2,0)) Qnt2,

	 Sum(COALESCE(A.NetW,0)) NetW,SUM(COALESCE(GrossW,0)) Grossw

	 from dbSPBDet A

     left outer join DBBARANG B on B.KODEBRG=A.Kodebrg

     Left Outer join dbSPB C on A.NoBukti = C.NoBukti

     Left Outer join DBCUSTSUPP D on c.KodeCustSupp = D.KODECUSTSUPP

     Group By C.KodeCustSupp,D.NAMACUSTSUPP,C.Tanggal

     order BY C.KodeCustSupp,D.NAMACUSTSUPP,C.Tanggal;

-- Sp_ReportSppDet
CREATE PROCEDURE IF NOT EXISTS Sp_ReportSppDet AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%'

select @Id=SUBSTRING(@Id,1,1)

if @Id=''

if @SReport='T'

If @Ordr='N'

		If @NeedOto=0 or @NeedOto=1

		if @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwReportSPP where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

		  order by NoBukti,Tanggal')

		else

		   exec('select ''Gabungan'' Perusahaan,* from VwReportSPP where NoBukti  IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

		  order by NoBukti,Tanggal')

		else If @NeedOto=2

		if @isiList=''

		  Exec('select ''Gabungan'' Perusahaan,* from VwReportSPP where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  order by NoBukti,Tanggal')

		 else

		  Exec('select ''Gabungan'' Perusahaan,* from VwReportSPP where NoBukti  IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  order by NoBukti,Tanggal')

	else If @Ordr='B'

		If @NeedOto=0 or @NeedOto=1

		if @isiList=''

		 Exec(' select ''Gabungan'' Perusahaan,* from VwReportSPP where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and NeedOtorisasi='+@NeedOto+'

		  order by KodeBrg,TglKirim')

		else

		 Exec(' select ''Gabungan'' Perusahaan,* from VwReportSPP where KodeBrg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and NeedOtorisasi='+@NeedOto+'

		  order by KodeBrg,TglKirim')

		else If @NeedOto=2

		if @isiList=''

		 Exec(' select ''Gabungan'' Perusahaan,* from VwReportSPP where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  order by KodeBrg,TglKirim')

		else

		  Exec(' select ''Gabungan'' Perusahaan,* from VwReportSPP where KodeBrg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  order by KodeBrg,TglKirim')

	else If @Ordr='C'

		If @NeedOto=0 or @NeedOto=1

		 if @isiList=''

		  Exec('select ''Gabungan'' Perusahaan,* from VwReportSPP where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

		  order by KodeCustSupp')

		 else

		   Exec('select ''Gabungan'' Perusahaan,* from VwReportSPP where KodeCustSupp IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

		  order by KodeCustSupp')

		If @NeedOto=2

		 if @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwReportSPP where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 
		  order by KodeCustSupp')

		 else

		   exec('select ''Gabungan'' Perusahaan,* from VwReportSPP where KodeCustSupp IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 
		  order by KodeCustSupp')

else

if @SReport='T'

If @Ordr='N'

		If @NeedOto=0 or @NeedOto=1

		if @isiList=''

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSPP where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by NoBukti,Tanggal')

		else

		   exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSPP where NoBukti  IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by NoBukti,Tanggal')

		else If @NeedOto=2

		if @isiList=''

		  Exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSPP where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by NoBukti,Tanggal')

		 else

		  Exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSPP where NoBukti  IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by NoBukti,Tanggal')

	else If @Ordr='B'

		If @NeedOto=0 or @NeedOto=1

		if @isiList=''

		 Exec(' select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSPP where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and NeedOtorisasi='+@NeedOto+'

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeBrg,TglKirim')

		else

		 Exec(' select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSPP where KodeBrg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and NeedOtorisasi='+@NeedOto+'

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeBrg,TglKirim')

		else If @NeedOto=2

		if @isiList=''

		 Exec(' select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSPP where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeBrg,TglKirim')

		else

		  Exec(' select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSPP where KodeBrg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeBrg,TglKirim')

	else If @Ordr='C'

		If @NeedOto=0 or @NeedOto=1

		 if @isiList=''

		  Exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSPP where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp')

		 else

		   Exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSPP where KodeCustSupp IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+'

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp')

		If @NeedOto=2

		 if @isiList=''

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSPP where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp')

		 else

		   exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportSPP where KodeCustSupp IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp');

-- Sp_ReportSppRek
CREATE PROCEDURE IF NOT EXISTS Sp_ReportSppRek AS ---- DECLARE REMOVED,@Tgl1 Datetime,@tgl2 datetime

--select @Tgl1='01/01/2012',@tgl2='07/17/2013',@Choice='B'

select @Id=SUBSTRING(@Id,1,1)

if @Id=''

If @Choice='N'

if @NeedOto=0 or @NeedOto=1

	select 	'Gabungan' Perusahaan,B.NOBUKTI,D.Tanggal,D.TglKirim,Sum(COALESCE(B.NetW,0)) NetW,SUM(COALESCE(B.GrossW,0)) GrosW,

        Sum(COALESCE(B.QNT,0)) Qnt, Sum(COALESCE(B.QNT2,0)) Qnt2,D.KodeCustSupp,E.NAMACUSTSUPP

	from	dbSPPDet B

	left outer join dbBarang C on C.KodeBrg=B.KodeBrg

	Left Outer join dbSPP D on B.NoBukti = D.NoBukti

	Left Outer join DBCUSTSUPP E on D.KodeCustSupp = E.KODECUSTSUPP

	where D.Tanggal between @Tgl1 and @Tgl2 and       

	Cast(Case when Case when D.IsOtorisasi1=1 then 1 else 0 +

    Case when D.IsOtorisasi2=1 then 1 else 0 +

    Case when D.IsOtorisasi3=1 then 1 else 0 +

    Case when D.IsOtorisasi4=1 then 1 else 0 +

    Case when D.IsOtorisasi5=1 then 1 else 0 =D.MaxOL then 0

    else 1

     As INTEGER)= @Needoto

	Group by  B.NOBUKTI,D.Tanggal,D.TglKirim,D.KodeCustSupp,E.NAMACUSTSUPP

	Order by B.NOBUKTI,D.Tanggal

else if @NeedOto=2

	select 	'Gabungan' Perusahaan,B.NOBUKTI,D.Tanggal,D.TglKirim,Sum(COALESCE(B.NetW,0)) NetW,SUM(COALESCE(B.GrossW,0)) GrosW,

        Sum(COALESCE(B.QNT,0)) Qnt, Sum(COALESCE(B.QNT2,0)) Qnt2,D.KodeCustSupp,E.NAMACUSTSUPP

	from	dbSPPDet B

	left outer join dbBarang C on C.KodeBrg=B.KodeBrg

	Left Outer join dbSPP D on B.NoBukti = D.NoBukti

	Left Outer join DBCUSTSUPP E on D.KodeCustSupp = E.KODECUSTSUPP

	where D.Tanggal between @Tgl1 and @Tgl2

	Group by  B.NOBUKTI,D.Tanggal,D.TglKirim,D.KodeCustSupp,E.NAMACUSTSUPP

	Order by B.NOBUKTI,D.Tanggal

 

else If @Choice='B'

If @NeedOto=0 or @NeedOto=1

	select 'Gabungan' Perusahaan,B.KodeBrg,C.NAMABRG,D.Tanggal,

        Sum(COALESCE(B.QNT,0)) Qnt, Sum(COALESCE(B.QNT2,0)) Qnt2

	from	dbSPPDet B

	left outer join dbBarang C on C.KodeBrg=B.KodeBrg

	Left Outer join dbSPP D on B.NoBukti = D.NoBukti

	Left Outer join DBCUSTSUPP E on D.KodeCustSupp = E.KODECUSTSUPP

	where D.Tanggal between @Tgl1 and @Tgl2 and       

	Cast(Case when Case when D.IsOtorisasi1=1 then 1 else 0 +

    Case when D.IsOtorisasi2=1 then 1 else 0 +

    Case when D.IsOtorisasi3=1 then 1 else 0 +

    Case when D.IsOtorisasi4=1 then 1 else 0 +

    Case when D.IsOtorisasi5=1 then 1 else 0 =D.MaxOL then 0

    else 1

     As INTEGER)= @Needoto

	Group by B.KodeBrg,C.NAMABRG,D.Tanggal

	Order by B.KodeBrg,C.NAMABRG,D.Tanggal

else If @NeedOto=2

	select 'Gabungan' Perusahaan,B.KodeBrg,C.NAMABRG,D.Tanggal,

        Sum(COALESCE(B.QNT,0)) Qnt, Sum(COALESCE(B.QNT2,0)) Qnt2

	from	dbSPPDet B

	left outer join dbBarang C on C.KodeBrg=B.KodeBrg

	Left Outer join dbSPP D on B.NoBukti = D.NoBukti

	Left Outer join DBCUSTSUPP E on D.KodeCustSupp = E.KODECUSTSUPP

	where D.Tanggal between @Tgl1 and @Tgl2 

	Group by B.KodeBrg,C.NAMABRG,D.Tanggal

	Order by B.KodeBrg,C.NAMABRG,D.Tanggal



else If @Choice='C'

If @NeedOto=0 or @NeedOto=1

	select 'Gabungan' Perusahaan,D.KodeCustSupp,E.NAMACUSTSUPP,D.Tanggal,

        Sum(COALESCE(B.QNT,0)) Qnt, Sum(COALESCE(B.QNT2,0)) Qnt2

	from	dbSPPDet B

	left outer join dbBarang C on C.KodeBrg=B.KodeBrg

	Left Outer join dbSPP D on B.NoBukti = D.NoBukti

	Left Outer join DBCUSTSUPP E on D.KodeCustSupp = E.KODECUSTSUPP

	where D.Tanggal between @Tgl1 and @Tgl2 and       

	Cast(Case when Case when D.IsOtorisasi1=1 then 1 else 0 +

    Case when D.IsOtorisasi2=1 then 1 else 0 +

    Case when D.IsOtorisasi3=1 then 1 else 0 +

    Case when D.IsOtorisasi4=1 then 1 else 0 +

    Case when D.IsOtorisasi5=1 then 1 else 0 =D.MaxOL then 0

    else 1

     As INTEGER)= @Needoto

	Group by D.KodeCustSupp,E.NAMACUSTSUPP,D.Tanggal

	Order by D.KodeCustSupp,E.NAMACUSTSUPP,D.Tanggal

else If @NeedOto=2

	select 'Gabungan' Perusahaan,D.KodeCustSupp,E.NAMACUSTSUPP,D.Tanggal,

        Sum(COALESCE(B.QNT,0)) Qnt, Sum(COALESCE(B.QNT2,0)) Qnt2

	from	dbSPPDet B

	left outer join dbBarang C on C.KodeBrg=B.KodeBrg

	Left Outer join dbSPP D on B.NoBukti = D.NoBukti

	Left Outer join DBCUSTSUPP E on D.KodeCustSupp = E.KODECUSTSUPP

	where D.Tanggal between @Tgl1 and @Tgl2 

	Group by D.KodeCustSupp,E.NAMACUSTSUPP,D.Tanggal

	Order by D.KodeCustSupp,E.NAMACUSTSUPP,D.Tanggal


else-----

If @Choice='N'

if @NeedOto=0 or @NeedOto=1

	select 	Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,B.NOBUKTI,D.Tanggal,D.TglKirim,Sum(COALESCE(B.NetW,0)) NetW,SUM(COALESCE(B.GrossW,0)) GrosW,

        Sum(COALESCE(B.QNT,0)) Qnt, Sum(COALESCE(B.QNT2,0)) Qnt2,D.KodeCustSupp,E.NAMACUSTSUPP

	from	dbSPPDet B

	left outer join dbBarang C on C.KodeBrg=B.KodeBrg

	Left Outer join dbSPP D on B.NoBukti = D.NoBukti

	Left Outer join DBCUSTSUPP E on D.KodeCustSupp = E.KODECUSTSUPP

	where D.Tanggal between @Tgl1 and @Tgl2 and       

	Cast(Case when Case when D.IsOtorisasi1=1 then 1 else 0 +

    Case when D.IsOtorisasi2=1 then 1 else 0 +

    Case when D.IsOtorisasi3=1 then 1 else 0 +

    Case when D.IsOtorisasi4=1 then 1 else 0 +

    Case when D.IsOtorisasi5=1 then 1 else 0 =D.MaxOL then 0

    else 1

     As INTEGER)= @Needoto

    and @Id= Left(B.NoBukti,1) 

	Group by  B.NOBUKTI,D.Tanggal,D.TglKirim,D.KodeCustSupp,E.NAMACUSTSUPP

	Order by B.NOBUKTI,D.Tanggal

else if @NeedOto=2

	select 	Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,B.NOBUKTI,D.Tanggal,D.TglKirim,Sum(COALESCE(B.NetW,0)) NetW,SUM(COALESCE(B.GrossW,0)) GrosW,

        Sum(COALESCE(B.QNT,0)) Qnt, Sum(COALESCE(B.QNT2,0)) Qnt2,D.KodeCustSupp,E.NAMACUSTSUPP

	from	dbSPPDet B

	left outer join dbBarang C on C.KodeBrg=B.KodeBrg

	Left Outer join dbSPP D on B.NoBukti = D.NoBukti

	Left Outer join DBCUSTSUPP E on D.KodeCustSupp = E.KODECUSTSUPP

	where D.Tanggal between @Tgl1 and @Tgl2

	and @Id= Left(B.NoBukti,1) 

	Group by  B.NOBUKTI,D.Tanggal,D.TglKirim,D.KodeCustSupp,E.NAMACUSTSUPP

	Order by B.NOBUKTI,D.Tanggal

 

else If @Choice='B'

If @NeedOto=0 or @NeedOto=1

	select Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,B.KodeBrg,C.NAMABRG,D.Tanggal,

        Sum(COALESCE(B.QNT,0)) Qnt, Sum(COALESCE(B.QNT2,0)) Qnt2

	from	dbSPPDet B

	left outer join dbBarang C on C.KodeBrg=B.KodeBrg

	Left Outer join dbSPP D on B.NoBukti = D.NoBukti

	Left Outer join DBCUSTSUPP E on D.KodeCustSupp = E.KODECUSTSUPP

	where D.Tanggal between @Tgl1 and @Tgl2 and       

	Cast(Case when Case when D.IsOtorisasi1=1 then 1 else 0 +

    Case when D.IsOtorisasi2=1 then 1 else 0 +

    Case when D.IsOtorisasi3=1 then 1 else 0 +

    Case when D.IsOtorisasi4=1 then 1 else 0 +

    Case when D.IsOtorisasi5=1 then 1 else 0 =D.MaxOL then 0

    else 1

     As INTEGER)= @Needoto

    and @Id= Left(B.NoBukti,1) 

	Group by B.KodeBrg,C.NAMABRG,D.Tanggal

	Order by B.KodeBrg,C.NAMABRG,D.Tanggal

else If @NeedOto=2

	select Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,B.KodeBrg,C.NAMABRG,D.Tanggal,

        Sum(COALESCE(B.QNT,0)) Qnt, Sum(COALESCE(B.QNT2,0)) Qnt2

	from	dbSPPDet B

	left outer join dbBarang C on C.KodeBrg=B.KodeBrg

	Left Outer join dbSPP D on B.NoBukti = D.NoBukti

	Left Outer join DBCUSTSUPP E on D.KodeCustSupp = E.KODECUSTSUPP

	where D.Tanggal between @Tgl1 and @Tgl2 

	and @Id= Left(B.NoBukti,1) 

	Group by B.KodeBrg,C.NAMABRG,D.Tanggal

	Order by B.KodeBrg,C.NAMABRG,D.Tanggal



else If @Choice='C'

If @NeedOto=0 or @NeedOto=1

	select Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,D.KodeCustSupp,E.NAMACUSTSUPP,D.Tanggal,

        Sum(COALESCE(B.QNT,0)) Qnt, Sum(COALESCE(B.QNT2,0)) Qnt2

	from	dbSPPDet B

	left outer join dbBarang C on C.KodeBrg=B.KodeBrg

	Left Outer join dbSPP D on B.NoBukti = D.NoBukti

	Left Outer join DBCUSTSUPP E on D.KodeCustSupp = E.KODECUSTSUPP

	where D.Tanggal between @Tgl1 and @Tgl2 and       

	Cast(Case when Case when D.IsOtorisasi1=1 then 1 else 0 +

    Case when D.IsOtorisasi2=1 then 1 else 0 +

    Case when D.IsOtorisasi3=1 then 1 else 0 +

    Case when D.IsOtorisasi4=1 then 1 else 0 +

    Case when D.IsOtorisasi5=1 then 1 else 0 =D.MaxOL then 0

    else 1

     As INTEGER)= @Needoto

    and @Id= Left(B.NoBukti,1) 

	Group by D.KodeCustSupp,E.NAMACUSTSUPP,D.Tanggal

	Order by D.KodeCustSupp,E.NAMACUSTSUPP,D.Tanggal

else If @NeedOto=2

	select Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,D.KodeCustSupp,E.NAMACUSTSUPP,D.Tanggal,

        Sum(COALESCE(B.QNT,0)) Qnt, Sum(COALESCE(B.QNT2,0)) Qnt2

	from	dbSPPDet B

	left outer join dbBarang C on C.KodeBrg=B.KodeBrg

	Left Outer join dbSPP D on B.NoBukti = D.NoBukti

	Left Outer join DBCUSTSUPP E on D.KodeCustSupp = E.KODECUSTSUPP

	where D.Tanggal between @Tgl1 and @Tgl2 

	and @Id= Left(B.NoBukti,1) 

	Group by D.KodeCustSupp,E.NAMACUSTSUPP,D.Tanggal

	Order by D.KodeCustSupp,E.NAMACUSTSUPP,D.Tanggal;

-- Sp_ReportSPPxDet
CREATE PROCEDURE IF NOT EXISTS Sp_ReportSPPxDet AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 



if @SReport='T'

If @Ordr='N'

		select * from VwReportSppx where Tanggal between @tgl1 and @tgl2 order by NoBukti,Tanggal

		 

	else If @Ordr='B'

		select * from VwReportSppx where Tanggal between @tgl1 and @tgl2 order by KodeBrg

		 

	else If @Ordr='C'

		select * from VwReportSppx where Tanggal between @tgl1 and @tgl2 order by KodeCustSupp;

-- Sp_ReportSppxRek
CREATE PROCEDURE IF NOT EXISTS Sp_ReportSppxRek AS ---- DECLARE REMOVED,@Tgl1 Datetime,@tgl2 datetime

--select @Tgl1='01/01/2012',@tgl2='07/17/2013',@Choice='B'



If @Choice='N'

Select   A.Nobukti, P.Tanggal,P.KodeCustSupp,x.NAMACUSTSUPP,P.TglKirim,

        Case when A.NoSat=1 then sum(COALESCE(A.Qnt,0))

             when A.NoSat=2 then sum(COALESCE(A.Qnt2,0))

             else 0

         Qnt, sum(COALESCE(A.Qnt2,0)) Qnt2,

        Case when A.NoSat=1 then sum(COALESCE(A.QntSPB,0))

             when A.NoSat=2 then sum(COALESCE(A.Qnt2SPB,0))

             else 0

         QntSPB,sum(COALESCE(A.Qnt2SPB,0)) Qnt2SPB,

        Case when A.NoSat=1 then sum(COALESCE(A.QntSisa,0))

             when A.NoSat=2 then sum(COALESCE(A.Qnt2Sisa,0))

             else 0

         QntSisa, sum(COALESCE(A.Qnt2Sisa,0)) Qnt2Sisa

		From    vwBrowsOutSPP A

		Left Outer Join dbSPP P on P.NoBukti=A.NoBukti

		left Outer join DBSO SO on SO.NOBUKTI=A.noso

		Left Outer Join vwBrowsCustomer S on S.KodeCust=P.KodeCustSupp and s.Sales=SO.KODESLS

		Left Outer Join dbBarang B on B.KodeBrg=A.KodeBrg

		Left Outer Join DBCUSTSUPP x on So.KODECUST=x.KODECUSTSUPP

		where A.isclose=0 

		Group by A.Nobukti, P.Tanggal,A.NoSat,P.KodeCustSupp,x.NAMACUSTSUPP,P.TglKirim

		Order By A.Nobukti, P.Tanggal



else If @Choice='B'

Select   A.KodeBrg,B.NAMABRG, P.Tanggal,

        Case when A.NoSat=1 then sum(COALESCE(A.Qnt,0))

             when A.NoSat=2 then sum(COALESCE(A.Qnt2,0))

             else 0

         Qnt, sum(COALESCE(A.Qnt2,0)) Qnt2,

        Case when A.NoSat=1 then sum(COALESCE(A.QntSPB,0))

             when A.NoSat=2 then sum(COALESCE(A.Qnt2SPB,0))

             else 0

         QntSPB,sum(COALESCE(A.Qnt2SPB,0)) Qnt2SPB,

        Case when A.NoSat=1 then sum(COALESCE(A.QntSisa,0))

             when A.NoSat=2 then sum(COALESCE(A.Qnt2Sisa,0))

             else 0

         QntSisa, sum(COALESCE(A.Qnt2Sisa,0)) Qnt2Sisa

		From    vwBrowsOutSPP A

		Left Outer Join dbSPP P on P.NoBukti=A.NoBukti

		left Outer join DBSO SO on SO.NOBUKTI=A.noso

		Left Outer Join vwBrowsCustomer S on S.KodeCust=P.KodeCustSupp and s.Sales=SO.KODESLS

		Left Outer Join dbBarang B on B.KodeBrg=A.KodeBrg

		where A.isclose=0 

		Group by  A.KodeBrg,B.NAMABRG, P.Tanggal,A.NoSat

		Order By  A.KodeBrg,B.NAMABRG, P.Tanggal



else If @Choice='C'

Select  P.KodeCustSupp,S.namaCust NamaCustSupp, P.Tanggal,

        Case when A.NoSat=1 then sum(COALESCE(A.Qnt,0))

             when A.NoSat=2 then sum(COALESCE(A.Qnt2,0))

             else 0

         Qnt, sum(COALESCE(A.Qnt2,0)) Qnt2,

        Case when A.NoSat=1 then sum(COALESCE(A.QntSPB,0))

             when A.NoSat=2 then sum(COALESCE(A.Qnt2SPB,0))

             else 0

         QntSPB,sum(COALESCE(A.Qnt2SPB,0)) Qnt2SPB,

        Case when A.NoSat=1 then sum(COALESCE(A.QntSisa,0))

             when A.NoSat=2 then sum(COALESCE(A.Qnt2Sisa,0))

             else 0

         QntSisa, sum(COALESCE(A.Qnt2Sisa,0)) Qnt2Sisa

		From    vwBrowsOutSPP A

		Left Outer Join dbSPP P on P.NoBukti=A.NoBukti

		left Outer join DBSO SO on SO.NOBUKTI=A.noso

		Left Outer Join vwBrowsCustomer S on S.KodeCust=P.KodeCustSupp and s.Sales=SO.KODESLS

		Left Outer Join dbBarang B on B.KodeBrg=A.KodeBrg

		where A.isclose=0 

		Group by  P.KodeCustSupp,S.namaCust, P.Tanggal,A.NoSat

		Order By  P.KodeCustSupp,S.namaCust, P.Tanggal;

-- Sp_ReportSPRK
CREATE PROCEDURE IF NOT EXISTS Sp_ReportSPRK AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 



if @SReport='T'

If @Ordr='N'

		if @NeedOto=0 or @NeedOto=1

		  select * from VwReportSpRk where Tanggal between @tgl1 and @tgl2 And NeeDOtoRisasi=@NeedOto

		  order by NoBukti,Tanggal

		else if @NeedOto=2

		  select * from VwReportSpRk where Tanggal between @tgl1 and @tgl2

		  order by NoBukti,Tanggal

		 

	else If @Ordr='B'

		if @NeedOto=0 or @NeedOto=1

		  select * from VwReportSpRk where Tanggal between @tgl1 and @tgl2 And NeeDOtoRisasi=@NeedOto

		  order by KodeBrg,NamaBrg

		else if @NeedOto=2

		  select * from VwReportSpRk where Tanggal between @tgl1 and @tgl2 

		  order by KodeBrg,NamaBrg;

-- Sp_reportSPRKRek
CREATE PROCEDURE IF NOT EXISTS Sp_reportSPRKRek AS ---- DECLARE REMOVED,@tgl1 Datetime,@Tgl2 DateTime

--select @Choice='B',@Tgl1='10/10/2011',@tgl2='01/29/2012'



If @Choice = 'N'

If @Needoto=0 or @Needoto=1

	Select 	A.Tanggal,B.NoBukti,B.SATUAN,B.KODEBRG,H.NAMABRG, 

	Sum(COALESCE(B.Qnt,0)) Qnt

	From dbSPKDet B 

	Left Outer Join DbSPK A on  B.nobukti = A.nobukti

	Left Outer join dbBarang H on H.KodeBrg=b.KodeBrg 

	Where a.Tanggal between @tgl1 and @tgl2 

	 And Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                      Case when A.IsOtorisasi2=1 then 1 else 0 +

                      Case when A.IsOtorisasi3=1 then 1 else 0 +

                      Case when A.IsOtorisasi4=1 then 1 else 0 +

                      Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                 else 1

             As INTEGER)=@Needoto

	Group By 	A.Tanggal,B.NoBukti,B.SATUAN,B.KODEBRG,H.NAMABRG

	Order By 	B.NoBukti,A.Tanggal,B.Satuan,B.KODEBRG,H.NAMABRG

else If @Needoto=2

	Select 	A.Tanggal,B.NoBukti,B.SATUAN,B.KODEBRG,H.NAMABRG, 

	Sum(COALESCE(B.Qnt,0)) Qnt

	From dbSPKDet B 

	Left Outer Join DbSPK A on  B.nobukti = A.nobukti

	Left Outer join dbBarang H on H.KodeBrg=b.KodeBrg 

	Where a.Tanggal between @tgl1 and @tgl2 

	Group By 	A.Tanggal,B.NoBukti,B.SATUAN,B.KODEBRG,H.NAMABRG

	Order By 	B.NoBukti,A.Tanggal,B.Satuan,B.KODEBRG,H.NAMABRG



else if  @Choice = 'B'

If @Needoto=0 or @Needoto=1

	Select 	A.Tanggal, B.KodeBrg, H.NamaBrg,B.SATUAN,

	Sum(COALESCE(B.Qnt,0)) Qnt

	From dbSPKDet B 

	Left Outer Join DbSPK A on  B.nobukti = A.nobukti

	Left Outer join dbBarang H on H.KodeBrg=b.KodeBrg 

	Where a.Tanggal between @tgl1 and @tgl2

	 And Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                      Case when A.IsOtorisasi2=1 then 1 else 0 +

                      Case when A.IsOtorisasi3=1 then 1 else 0 +

                      Case when A.IsOtorisasi4=1 then 1 else 0 +

                      Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                 else 1

             As INTEGER)=@Needoto

	Group By 	A.Tanggal, B.KodeBrg, H.NamaBrg,B.SATUAN

	Order By 	 B.KodeBrg, H.NamaBrg,A.Tanggal,B.SATUAN 

else If @Needoto=2

	Select 	A.Tanggal, B.KodeBrg, H.NamaBrg,B.SATUAN,

	Sum(COALESCE(B.Qnt,0)) Qnt

	From dbSPKDet B 

	Left Outer Join DbSPK A on  B.nobukti = A.nobukti

	Left Outer join dbBarang H on H.KodeBrg=b.KodeBrg 

	Where a.Tanggal between @tgl1 and @tgl2

	Group By 	A.Tanggal, B.KodeBrg, H.NamaBrg,B.SATUAN

	Order By 	 B.KodeBrg, H.NamaBrg,A.Tanggal,B.SATUAN;

-- Sp_ReportStock
CREATE PROCEDURE IF NOT EXISTS Sp_ReportStock AS --Select @bulan=1, @tahun=2011, @kodegdg='A', @nosat=1

-- SET REMOVEDCase when @kodegdg in ('','-') then '%' else @kodegdg 

Select a.bulan,a.tahun,a.kodegdg,a.kodebrg,       

       b.NAMABRG, c.NAMA Namagdg,

       b.KodeKelompok, d.Keterangan NamaKelompok, 

       b.KodeKategori, e.Keterangan NamaKategori, 

       b.KodeSubKategori, f.Keterangan NamaSubKategori, 

       b.KodeJnsBrg, g.Keterangan NamaJenis, 

       b.kodesubJnsBrg, h.Keterangan NamaSubjenis,

       Case when @nosat=1 then b.SAT1 else b.Sat2  Satuan,

       Case when @nosat=1 then a.QNTAWAL else a.QNT2AWAL  QntAwal,

       Case when @nosat=1 then a.QNTBPPB else a.QNT2BPPB  QntBPPB,

       Case when @nosat=1 then a.QNTBatalBPPB else a.QNT2BatalBPPB  QntBatalBPPB,

       Case when @nosat=1 then a.QNTBPB else a.QNT2BPB  QntBPB,

       Case when @nosat=1 then a.QNTRBPB else a.QNT2RBPB  QntRBPB,

       Case when @nosat=1 then a.QNTPPL else a.QNT2PPL  QntPPL,

       Case when @nosat=1 then a.QNTBPL else a.QNT2BPL  QntBPL,

       Case when @nosat=1 then a.QNTSPRK else a.QNT2SPRK  QntSPRK,

       Case when @nosat=1 then a.QNTBSPRK else a.QNT2BSPRK  QntBSPRK,

       Case when @nosat=1 then a.QNTSPAT else a.QNT2SPAT  QntSPAT,

       Case when @nosat=1 then a.QNTPO else a.QNT2PO  QntPO,

       Case when @nosat=1 then a.QNTBPO else a.QNT2BPO  QntBPO,

       Case when @nosat=1 then a.QNTPBL else a.QNT2PBL  QntPBL,

       Case when @nosat=1 then a.QNTINS else a.QNT2INS  QntINS,

       Case when @nosat=1 then a.QNTKNS else a.QNT2KNS  QntKNS,

       Case when @nosat=1 then a.QNTRPB else a.QNT2RPB  QntRPB,

       Case when @nosat=1 then a.QNTPNJ else a.QNT2PNJ  QntPNJ,

       Case when @nosat=1 then a.QNTRPJ else a.QNT2RPJ  QntRPJ,

       Case when @nosat=1 then a.QNTPRJ else a.QNT2PRJ  QntPRJ,

       Case when @nosat=1 then a.QNTADI else a.QNT2ADI  QntADI,

       Case when @nosat=1 then a.QNTADO else a.QNT2ADO  QntADO,

       Case when @nosat=1 then a.QNTUKI else a.QNT2UKI  QntUKI,

       Case when @nosat=1 then a.QNTUKO else a.QNT2UKO  QntUKO,

       Case when @nosat=1 then a.QNTTRI else a.QNT2TRO  QntTRO,

       Case when @nosat=1 then a.QNTBHNIn else a.QNT2BHNIn  QntBHNIn,

       Case when @nosat=1 then a.QNTBHNOut else a.QNT2BHNOut  QntBHNOut,

       Case when @nosat=1 then a.QNTBHNIn else a.QNT2BHNIn  QntBHNIn,

       Case when @nosat=1 then a.QNTIN else a.QNT2IN  QntIN,

       Case when @nosat=1 then a.QNTOUT else a.QNT2OUT  QntOUT,

       Case when @nosat=1 then a.SALDOQNT else a.SALDOQNT2  SaldoQnt,

       a.HRGAWAL,a.HRGBPPB,a.HRGBatalBPPB,a.HRGBPB,a.HRGRBPB,a.HRGPPL,a.HRGBPL,

       a.HRGSPRK,a.HRGBSPRK,a.HRGSPAT,a.HRGPO,a.HRGBPO,a.HRGPBL,a.HRGINS,a.HRGKNS,

       a.HRGRPB,a.HRGPNJ,a.HRGRPJ,a.HRGPRJ,a.HRGADI,a.HRGADO,a.HRGUKI,a.HRGUKO,

       a.HRGTRI,a.HRGTRO,a.HRGBHNIn,a.HRGBHNOut,a.HRGRATA,a.HRGPRO,

       a.SALDORP

from DBSTOCKBRG a

     left outer join DBBARANG b on b.KODEBRG=a.KODEBRG and b.Kodegdg=a.KODEGDG

     left outer join DBGUDANG c on c.KODEGDG=a.KODEGDG

     left outer join DBKELOMPOK d on d.KodeKelompok=b.KodeKelompok

     left outer join DBKATEGORI e on e.KodeKategori=b.KodeKategori

     left outer join DBSUBKATEGORI f on f.KodeSubKategori=b.KodeSubKategori and f.KodeKategori=b.KodeKategori

     left outer join DBJenis g on g.KodeJnsBrg=b.KodeJnsBrg

     left outer join DBSUBJENIS h on h.kodesubJnsBrg=b.kodesubJnsBrg and h.KodeJnsBrg=b.KodeJnsBrg

where a.BULAN=@bulan and a.TAHUN=@tahun and a.KODEGDG like @kodegdg

Order by b.KodeKelompok,b.KodeKategori,a.KODEBRG;

-- Sp_ReportStockAkhir
CREATE PROCEDURE IF NOT EXISTS Sp_ReportStockAkhir AS -- SET REMOVEDCase when @kodegdg in ('','-') then '%' else @kodegdg 

if @kodegdg In('G1','R1')

select A.KodeBrg, B.NamaBrg,HPP,

case when @Nosat=1 then B.Sat1 

	 when @nosat=2 then B.SAT2 

	 when @Nosat=3 then B.SAT3  Sat1, 

	 A.KodeGdg, C.Nama NamaGdg, 

 	 A.SALDOQNT/case when @Nosat=1 then B.ISI1 

				when @nosat=2 then B.ISI2 when 

				@Nosat=3 then B.ISI3  SALDOQNT,B.QntMin,A.SALDOQNT/case when @Nosat=1 then B.ISI1 

				when @nosat=2 then B.ISI2 when 

				@Nosat=3 then B.ISI3 -B.QntMin Sisa 

from 

(

select 	KodeBrg, KODEGDG,AVG(HPP)HPP, sum(SaldoQnt) SaldoQnt 

from 

(  

select        a.KODEBRG, KodeGdg,Case When (c.KodeBrg)IS Null Then B.Hrg1_2 else c.HPP  HPP, QntAwal SaldoQnt 

from 	dbStockBrg a

Left Outer Join DBBARANG b On b.KODEBRG=a.KODEBRG

Left Outer Join (select Kodebrg,AVG(HPP)HPP from HPPSO Group by KODEBRG) c On c.KodeBrg=a.KODEBRG 

where         Tahun=year(@Tanggal) and Bulan=MONTH(@tanggal)

and KodeGdg =@KOdegdg

and (b.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP=('FG')Group by KODEGRP)) 

union all 

/*

select 	KodeBrg, KodeGdg, 

	sum(case when Tipe in ('PBL','RPJ','ADI','TRI','UKI') then Qnt else 1*Qnt ) SaldoQnt 

from 	vwKartuStock 

where 	year(Tanggal)=2013 and Tanggal<=@tanggal

and KodeGdg like @kodegdg

group by KodeBrg, KodeGdg */

select 	KodeBrg, KodeGdg,AVG(HPP)HPP, 

	SUM(QntDb)-SUM(QntCr) SaldoQnt



from 	vwKartuStock 

where 	year(Tanggal)=year(@tanggal) and month(tanggal)=month(@tanggal) and Tanggal<=@tanggal

and KodeGdg = Kodegdg  and Tipe not in ('AWL')

group by KodeBrg, KodeGdg

) X 

group by KodeBrg, KodeGdg

) A

left outer join dbBarang B on B.KodeBrg=A.KodeBrg 

left outer join dbGudang C on C.KodeGdg=A.KodeGdg 

where A.SALDOQNT<>0 and A.KODEGDG=@KOdegdg

and (b.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP=('FG')Group by KODEGRP)) 

order by  A.KodeBrg, A.KodeGdg 



else if @Kodegdg not in('G1','R1') and @Kodegdg<>'%'

select A.KodeBrg, B.NamaBrg,HPP,

case when @Nosat=1 then B.Sat1 

	 when @nosat=2 then B.SAT2 

	 when @Nosat=3 then B.SAT3  Sat1, 

	 A.KodeGdg, C.Nama NamaGdg, 

 	 A.SALDOQNT/case when @Nosat=1 then B.ISI1 

				when @nosat=2 then B.ISI2 when 

				@Nosat=3 then B.ISI3  SALDOQNT,B.QntMin,A.SALDOQNT/case when @Nosat=1 then B.ISI1 

				when @nosat=2 then B.ISI2 when 

				@Nosat=3 then B.ISI3 -B.QntMin Sisa 

from 

(

select 	KodeBrg, KODEGDG,avg(HPP)HPP, sum(SaldoQnt) SaldoQnt 

from 

(  

select        a.KODEBRG, KodeGdg,Case When (c.KodeBrg)IS Null Then B.Hrg1_2 else c.HPP  HPP, QntAwal SaldoQnt 

from 	dbStockBrg a

Left Outer Join DBBARANG b On b.KODEBRG=a.KODEBRG

Left Outer Join (select Kodebrg,AVG(HPP)HPP from HPPSO Group by KODEBRG) c On c.KodeBrg=a.KODEBRG 

where         Tahun=year(@Tanggal) and Bulan=MONTH(@tanggal)

and KodeGdg =@KOdegdg

and (b.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('FG','SVC')Group by KODEGRP)) 



union all 

/*

select 	KodeBrg, KodeGdg, 

	sum(case when Tipe in ('PBL','RPJ','ADI','TRI','UKI') then Qnt else 1*Qnt ) SaldoQnt 

from 	vwKartuStock 

where 	year(Tanggal)=2013 and Tanggal<=@tanggal

and KodeGdg like @kodegdg

group by KodeBrg, KodeGdg */

select 	KodeBrg, KodeGdg,AVG(HPP)HPP, 

	SUM(QntDb)-SUM(QntCr) SaldoQnt



from 	vwKartuStock 

where 	year(Tanggal)=year(@tanggal) and month(tanggal)=month(@tanggal) and Tanggal<=@tanggal

and KodeGdg = Kodegdg  and Tipe not in ('AWL')

group by KodeBrg, KodeGdg

) X 

group by KodeBrg, KodeGdg

) A

left outer join dbBarang B on B.KodeBrg=A.KodeBrg 

left outer join dbGudang C on C.KodeGdg=A.KodeGdg 

where A.SALDOQNT<>0 and A.KODEGDG=@KOdegdg

and (b.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP Not in('FG','SVC')Group by KODEGRP)) 



order by  A.KodeBrg, A.KodeGdg 



else

select A.KodeBrg, B.NamaBrg,HPP,

case when @Nosat=1 then B.Sat1 

	 when @nosat=2 then B.SAT2 

	 when @Nosat=3 then B.SAT3  Sat1, 

	 A.KodeGdg, C.Nama NamaGdg, 

 	 A.SALDOQNT/case when @Nosat=1 then B.ISI1 

				when @nosat=2 then B.ISI2 when 

				@Nosat=3 then B.ISI3  SALDOQNT,B.QntMin,A.SALDOQNT/case when @Nosat=1 then B.ISI1 

				when @nosat=2 then B.ISI2 when 

				@Nosat=3 then B.ISI3 -B.QntMin Sisa 

from 

(

select 	KodeBrg, KODEGDG,AVG(HPP)HPP, sum(SaldoQnt) SaldoQnt 

from 

(  

select        a.KODEBRG, KodeGdg,Case When (c.KodeBrg)IS Null Then B.Hrg1_2 else c.HPP  HPP, QntAwal SaldoQnt 

from 	dbStockBrg a

Left Outer Join DBBARANG b On b.KODEBRG=a.KODEBRG

Left Outer Join (select Kodebrg,AVG(HPP)HPP from HPPSO Group by KODEBRG) c On c.KodeBrg=a.KODEBRG 

where         Tahun=year(@Tanggal) and Bulan=MONTH(@tanggal)

and KodeGdg =@KOdegdg



union all 

/*

select 	KodeBrg, KodeGdg, 

	sum(case when Tipe in ('PBL','RPJ','ADI','TRI','UKI') then Qnt else 1*Qnt ) SaldoQnt 

from 	vwKartuStock 

where 	year(Tanggal)=2013 and Tanggal<=@tanggal

and KodeGdg like @kodegdg

group by KodeBrg, KodeGdg */

select 	KodeBrg, KodeGdg,AVG(HPP)HPP, 

	SUM(QntDb)-SUM(QntCr) SaldoQnt



from 	vwKartuStock 

where 	year(Tanggal)=year(@tanggal) and month(tanggal)=month(@tanggal) and Tanggal<=@tanggal

and KodeGdg = Kodegdg  and Tipe not in ('AWL')

group by KodeBrg, KodeGdg

) X 

group by KodeBrg, KodeGdg

) A

left outer join dbBarang B on B.KodeBrg=A.KodeBrg 

left outer join dbGudang C on C.KodeGdg=A.KodeGdg 

where A.SALDOQNT<>0 and A.KODEGDG like @KOdegdg

and (b.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP Not in('SVC')Group by KODEGRP)) 



order by  A.KodeBrg, A.KodeGdg;

-- Sp_ReportStockBrg
CREATE PROCEDURE IF NOT EXISTS Sp_ReportStockBrg AS --Select @bulan=1, @tahun=2011, @kodegdg='A', @nosat=1

-- SET REMOVEDCase when @kodegdg in ('','-') then '%' else @kodegdg 

Select a.bulan,a.tahun,a.kodegdg,a.kodebrg,       

       b.NAMABRG, c.NAMA Namagdg,

       b.KodeKelompok, d.Keterangan NamaKelompok, 

       b.KodeKategori, e.Keterangan NamaKategori, 

       b.KodeSubKategori, f.Keterangan NamaSubKategori, 

       b.KodeJnsBrg, g.Keterangan NamaJenis, 

       b.kodesubJnsBrg, h.Keterangan NamaSubjenis,

       Case when @nosat=1 then b.SAT1 else b.Sat2  Satuan,

       Case when @nosat=1 then a.QNTAWAL else a.QNT2AWAL  QntAwal,

       Case when @nosat=1 then a.QNTBPPB else a.QNT2BPPB  QntBPPB,

       Case when @nosat=1 then a.QNTBatalBPPB else a.QNT2BatalBPPB  QntBatalBPPB,

       Case when @nosat=1 then a.QNTBPB else a.QNT2BPB  QntBPB,

       Case when @nosat=1 then a.QNTRBPB else a.QNT2RBPB  QntRBPB,

       Case when @nosat=1 then a.QNTPPL else a.QNT2PPL  QntPPL,

       Case when @nosat=1 then a.QNTBPL else a.QNT2BPL  QntBPL,

       Case when @nosat=1 then a.QNTSPRK else a.QNT2SPRK  QntSPRK,

       Case when @nosat=1 then a.QNTBSPRK else a.QNT2BSPRK  QntBSPRK,

       Case when @nosat=1 then a.QNTSPAT else a.QNT2SPAT  QntSPAT,

       Case when @nosat=1 then a.QNTPO else a.QNT2PO  QntPO,

       Case when @nosat=1 then a.QNTBPO else a.QNT2BPO  QntBPO,

       Case when @nosat=1 then a.QNTPBL else a.QNT2PBL  QntPBL,

       Case when @nosat=1 then a.QNTINS else a.QNT2INS  QntINS,

       Case when @nosat=1 then a.QNTKNS else a.QNT2KNS  QntKNS,

       Case when @nosat=1 then a.QNTRPB else a.QNT2RPB  QntRPB,

       Case when @nosat=1 then a.QNTPNJ else a.QNT2PNJ  QntPNJ,

       Case when @nosat=1 then a.QNTRPJ else a.QNT2RPJ  QntRPJ,

       Case when @nosat=1 then a.QNTPRJ else a.QNT2PRJ  QntPRJ,

       Case when @nosat=1 then a.QNTADI else a.QNT2ADI  QntADI,

       Case when @nosat=1 then a.QNTADO else a.QNT2ADO  QntADO,

       Case when @nosat=1 then a.QNTUKI else a.QNT2UKI  QntUKI,

       Case when @nosat=1 then a.QNTUKO else a.QNT2UKO  QntUKO,

       Case when @nosat=1 then a.QNTTRI else a.QNT2TRI  QntTRI,

       Case when @nosat=1 then a.QNTTRO else a.QNT2TRO  QntTRO,

       Case when @nosat=1 then a.QNTBHNIn else a.QNT2BHNIn  QntBHNIn,

       Case when @nosat=1 then a.QNTBHNOut else a.QNT2BHNOut  QntBHNOut,

       Case when @nosat=1 then a.QNTBHNIn else a.QNT2BHNIn  QntBHNIn,

       Case when @nosat=1 then a.QNTPRO else a.QNT2PRO  QntPRO,

       Case when @nosat=1 then a.QNTIN else a.QNT2IN  QntIN,

       Case when @nosat=1 then a.QNTOUT else a.QNT2OUT  QntOUT,

       Case when @nosat=1 then a.SALDOQNT else a.SALDOQNT2  SaldoQnt,

       a.HRGAWAL,a.HRGBPPB,a.HRGBatalBPPB,a.HRGBPB,a.HRGRBPB,a.HRGPPL,a.HRGBPL,

       a.HRGSPRK,a.HRGBSPRK,a.HRGSPAT,a.HRGPO,a.HRGBPO,a.HRGPBL,a.HRGINS,a.HRGKNS,

       a.HRGRPB,a.HRGPNJ,a.HRGRPJ,a.HRGPRJ,a.HRGADI,a.HRGADO,a.HRGUKI,a.HRGUKO,

       a.HRGTRI,a.HRGTRO,a.HRGBHNIn,a.HRGBHNOut,a.HRGRATA,a.HRGPRO,

       a.SALDORP

from DBSTOCKBRG a

     left outer join DBBARANG b on b.KODEBRG=a.KODEBRG and b.Kodegdg=a.KODEGDG

     left outer join DBGUDANG c on c.KODEGDG=a.KODEGDG

     left outer join DBKELOMPOK d on d.KodeKelompok=b.KodeKelompok

     left outer join DBKATEGORI e on e.KodeKategori=b.KodeKategori

     left outer join DBSUBKATEGORI f on f.KodeSubKategori=b.KodeSubKategori and f.KodeKategori=b.KodeKategori

     left outer join DBJenis g on g.KodeJnsBrg=b.KodeJnsBrg

     left outer join DBSUBJENIS h on h.kodesubJnsBrg=b.kodesubJnsBrg and h.KodeJnsBrg=b.KodeJnsBrg

where a.BULAN=@bulan and a.TAHUN=@tahun and a.KODEGDG like @kodegdg

Order by b.KodeKelompok,b.KodeKategori,a.KODEBRG



select * from DBSTOCKBRG;

-- Sp_ReportStockFisikGudang
CREATE PROCEDURE IF NOT EXISTS Sp_ReportStockFisikGudang AS -- SET REMOVEDCase when @kodegdg in ('','-') then '%' else @kodegdg 

if @KOdegdg in('G01','G02')

select A.KodeGdg, C.Nama NamaGdg, B.KodeSupp, B.KodeGrp, A.KodeBrg, B.NamaBrg, 

  B.Sat3, B.Isi3, Case When ISI2<1 Then B.SAT1 else B.SAT2  SAT2, B.Isi2, CASE When ISI2<1 Then B.SAT2 else B.SAT1  SAT1, B.Isi1 

 -- ,A.SALDOQNT, cast(A.SALDOQNT as int)/cast(COALESCE(B.Isi3,1) as int) SALDO3QNT, 

 -- (cast(A.SALDOQNT as int) % cast(B.Isi3 as int))/cast(B.Isi2 as int) SALDO2QNT, 

--(cast(A.SALDOQNT as int) % cast(B.Isi2 as int)) SALDO1QNT 

, A.SaldoQnt/Case When ISI2<1 Then ISI2 else 1   /*/B.ISI1*/ SALDO1QNT

, (A.SaldoQnt/Case When ISI2<1 Then ISI2 else 1 )/Case When ISI2<1 Then Case When ISI2=0 Then 1 else 1/ISI2  else ISI2  /*/case when COALESCE(B.ISI2,0)=0 then 1 else B.ISI2 */ SALDO2QNT

, A.SALDOQNT/case when COALESCE(B.ISI3,0)=0 then 1 else B.ISI3  SALDO3QNT  

from 

(

select 	KodeBrg, KodeGdg, sum(SaldoQnt) SaldoQnt, sum(Saldo2Qnt) Saldo2Qnt  

from 

(  

select        KodeBrg, KodeGdg, QntAwal SaldoQnt, QNT2AWAL Saldo2Qnt  

from 	dbStockBrg 

where         Tahun=YEAR(@tanggal)  and Bulan=MONTH(@tanggal)

and KodeGdg =@KOdegdg



union all 

/*

select 	KodeBrg, KodeGdg, 

	sum(case when Tipe in ('PBL','RPJ','ADI','TRI','UKI') then Qnt else -1*Qnt ) SaldoQnt 

from 	vwKartuStock 

where 	year(Tanggal)=@tanggal and Tanggal<=@tanggal and KODEGDG like @KOdegdg

group by KodeBrg, KodeGdg */

select 	KodeBrg, KodeGdg, SUM(COALESCE(QntDb,0))-SUM(COALESCE(QntCr,0)) SaldoQnt, SUM(COALESCE(Qnt2DB,0))-SUM(COALESCE(Qnt2Cr,0)) SaldoQnt


from 	vwKartuStock 

where 	year(Tanggal)=year(@tanggal) and month(tanggal)=month(@tanggal) and Tanggal<=@tanggal

and KodeGdg = Kodegdg  and Tipe not in ('AWL')

group by KodeBrg, KodeGdg

) X 

group by KodeBrg, KodeGdg 

) A

left outer join dbBarang B on B.KodeBrg=A.KodeBrg 

left outer join dbGudang C on C.KodeGdg=A.KodeGdg 

Left Outer JOin DbGroup D on b.kodegrp = d.kodegrp

where  A.KODEGDG=@KOdegdg

and (b.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP=('FG')Group by KODEGRP)) 

order by A.KodeGdg, B.KodeSupp, B.KodeGrp, A.KodeBrg



else if @Kodegdg not in('G01','G02') and @Kodegdg<>'%'

select A.KodeGdg, C.Nama NamaGdg, B.KodeSupp, B.KodeGrp, A.KodeBrg, B.NamaBrg, 

  B.Sat3, B.Isi3, B.Sat2, B.Isi2, B.Sat1, B.Isi1 

 -- ,A.SALDOQNT, cast(A.SALDOQNT as int)/cast(COALESCE(B.Isi3,1) as int) SALDO3QNT, 

 -- (cast(A.SALDOQNT as int) % cast(B.Isi3 as int))/cast(B.Isi2 as int) SALDO2QNT, 

--(cast(A.SALDOQNT as int) % cast(B.Isi2 as int)) SALDO1QNT 

, A.SALDOQNT/B.ISI1 SALDO1QNT

, A.SALDOQNT/case when COALESCE(B.ISI2,0)=0 then 1 else B.ISI2  SALDO2QNT

, A.SALDOQNT/case when COALESCE(B.ISI3,0)=0 then 1 else B.ISI3  SALDO3QNT  

from 

(

select 	KodeBrg, KodeGdg, sum(SaldoQnt) SaldoQnt 

from 

(  

select        KodeBrg, KodeGdg, QntAwal SaldoQnt 

from 	dbStockBrg 

where         Tahun=YEAR(@tanggal)  and Bulan=MONTH(@tanggal)

and KodeGdg =@KOdegdg



union all 

/*

select 	KodeBrg, KodeGdg, 

	sum(case when Tipe in ('PBL','RPJ','ADI','TRI','UKI') then Qnt else -1*Qnt ) SaldoQnt 

from 	vwKartuStock 

where 	year(Tanggal)=@tanggal and Tanggal<=@tanggal and KODEGDG like @KOdegdg

group by KodeBrg, KodeGdg */

select 	KodeBrg, KodeGdg, SUM(COALESCE(QntDb,0))-SUM(COALESCE(QntCr,0)) SaldoQnt


from 	vwKartuStock 

where 	year(Tanggal)=year(@tanggal) and month(tanggal)=month(@tanggal) and Tanggal<=@tanggal

and KodeGdg = Kodegdg  and Tipe not in ('AWL')

group by KodeBrg, KodeGdg

) X 

group by KodeBrg, KodeGdg 

) A

left outer join dbBarang B on B.KodeBrg=A.KodeBrg 

left outer join dbGudang C on C.KodeGdg=A.KodeGdg 

Left Outer JOin DbGroup D on b.kodegrp = d.kodegrp

where  A.KODEGDG Like @KOdegdg

and (b.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP Not in('FG','SVC')Group by KODEGRP)) 

order by A.KodeGdg, B.KodeSupp, B.KodeGrp, A.KodeBrg



else

select A.KodeGdg, C.Nama NamaGdg, B.KodeSupp, B.KodeGrp, A.KodeBrg, B.NamaBrg, 

  B.Sat3, B.Isi3, B.Sat2, B.Isi2, B.Sat1, B.Isi1 

 -- ,A.SALDOQNT, cast(A.SALDOQNT as int)/cast(COALESCE(B.Isi3,1) as int) SALDO3QNT, 

 -- (cast(A.SALDOQNT as int) % cast(B.Isi3 as int))/cast(B.Isi2 as int) SALDO2QNT, 

--(cast(A.SALDOQNT as int) % cast(B.Isi2 as int)) SALDO1QNT 

, A.SALDOQNT/B.ISI1 SALDO1QNT

, A.SALDOQNT/case when COALESCE(B.ISI2,0)=0 then 1 else B.ISI2  SALDO2QNT

, A.SALDOQNT/case when COALESCE(B.ISI3,0)=0 then 1 else B.ISI3  SALDO3QNT  

from 

(

select 	KodeBrg, KodeGdg, sum(SaldoQnt) SaldoQnt 

from 

(  

select        KodeBrg, KodeGdg, QntAwal SaldoQnt 

from 	dbStockBrg 

where         Tahun=YEAR(@tanggal)  and Bulan=MONTH(@tanggal)

and KodeGdg  Like @KOdegdg

union all 

/*

select 	KodeBrg, KodeGdg, 

	sum(case when Tipe in ('PBL','RPJ','ADI','TRI','UKI') then Qnt else -1*Qnt ) SaldoQnt 

from 	vwKartuStock 

where 	year(Tanggal)=@tanggal and Tanggal<=@tanggal and KODEGDG like @KOdegdg

group by KodeBrg, KodeGdg */

select 	KodeBrg, KodeGdg, SUM(COALESCE(QntDb,0))-SUM(COALESCE(QntCr,0)) SaldoQnt


from 	vwKartuStock 

where 	year(Tanggal)=year(@tanggal) and month(tanggal)=month(@tanggal) and Tanggal<=@tanggal

and KodeGdg = Kodegdg  and Tipe not in ('AWL')

group by KodeBrg, KodeGdg

) X 

group by KodeBrg, KodeGdg 

) A

left outer join dbBarang B on B.KodeBrg=A.KodeBrg 

left outer join dbGudang C on C.KodeGdg=A.KodeGdg 

Left Outer JOin DbGroup D on b.kodegrp = d.kodegrp

where  A.KODEGDG Like @KOdegdg

and (b.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP Not in('SVC')Group by KODEGRP)) 

order by A.KodeGdg, B.KodeSupp, B.KodeGrp, A.KodeBrg;

-- SP_ReportStockHarian
CREATE PROCEDURE IF NOT EXISTS SP_ReportStockHarian AS ---- DECLARE REMOVED,@akhir datetime,@gudang varchar(15),@nosat integer

--select @awal='07/01/2012',@akhir='07/31/2012',@nosat=1,@gudang='g001'

-- SET REMOVEDCase when @gudang in ('','-') then '%' else @gudang 

if @gudang in('G1','R1')

select A.KodeBrg, B.NamaBrg, Case when @nosat=1 Then B.Sat1 else B.SAT2  Sat1, A.KodeGdg, C.Nama NamaGdg, 

  A.QNTAWAL   QntAwal, 

  A.QNTPBL   QNTPBL, 

  A.QNTRPB   QNTRPB, 

  A.QNTPNJ   QNTPNJ, 

  A.QNTRPJ   QNTRPJ, 

  A.QNTADI   QNTADI, 

  A.QNTADO   QNTADO, 

  A.QNTUKI   QNTUKI, 

  A.QNTUKO   QNTUKO, 

  A.QNTTRI   QNTTRI, 

  A.QNTTRO   QNTTRO, 

  A.SALDOQNT   SALDOQNT, 

  (A.QNTAWAL  ) +

  (A.QNTPBL  ) -

  (A.QNTRPB  ) AS TOTALSTOCK,

  (A.QNTPNJ  ) - 

  (A.QNTRPJ  ) AS SELLOUTNET,

  ((A.QNTAWAL  ) + 

  (A.QNTPBL  ) - 

  (A.QNTRPB  )) - 

  ((A.QNTPNJ  ) - 

  (A.QNTRPJ  )) AS FINALSTOCK,

  HPP

from 

(

select 	KodeBrg,HPP, KodeGdg, sum(QntAwal) QntAwal, sum(QntPBL) QntPBL, sum(QntRBP) QntRBP, 

	sum(QntPNJ) QntPNJ, sum(QntRPJ) QntRPJ, sum(QntADI) QntADI, sum(QntADO) QntADO, 

	sum(QntTRI) QntTRI, sum(QntTRO) QntTRO, sum(QntUKI) QntUKI, sum(QntUKO) QntUKO,SUM(QntBPSBIN)QntBPSBIN,SUM(QntBPSBOUT)QntBPSBOUT,

	sum(QntPB)QntPB,Sum(QntRPB)QntRPB, sum(SaldoQnt) SaldoQnt 

from 

(  

/*select        KodeBrg, KodeGdg, QntAwal, 0 QntPBL, 0 QntRPB, 0 QntPNJ, 0 QntRPJ, 

	0 QntADI, 0 QntADO, 0 QntTRI, 0 QntTRO, 0 QntUKI, 0 QntUKO, QntAwal SaldoQnt 

from 	dbStockBrg 

where  Tahun=year(@awal) and Bulan=MONTH(@awal) and KodeGdg=@gudang



union all 

select 	KodeBrg, KodeGdg, 

	sum(case when Tipe in ('PBL','RPJ','ADI','TRI','UKI','HP','BPSB IN') then Qnt else -1*Qnt ) QntAwal, 

	0 QntPBL, 0 QntRPB, 0 QntPNJ, 0 QntRPJ, 

	0 QntADI, 0 QntADO, 0 QntTRI, 0 QntTRO, 0 QntUKI, 0 QntUKO, 

	sum(case when Tipe in ('PBL','RPJ','ADI','TRI','UKI','BPSB OUT') then Qnt else -1*Qnt ) SaldoQnt 

from 	vwKartuStock 

where 	year(Tanggal)=2012 and Tanggal<@akhir and KodeGdg=@gudang

group by KodeBrg, KodeGdg 



union all */

select 	KodeBrg,HPP, KodeGdg, sum(case when Tipe='AWL' then Case when @nosat=1 Then QntSaldo else Qnt2Saldo  else 0 ) QntAwal, 

	sum(case when Tipe='PBL' then Case when @Nosat=1 Then QntDB else Qnt2DB  else 0 ) QntPBL, 

	sum(case when Tipe='RBP' then Case when @Nosat=1 Then QntCr else Qnt2Cr  else 0 ) QntRBP, 

	sum(case when Tipe='PNJ' then Case when @Nosat=1 Then QntCr else Qnt2Cr  else 0 ) QntPNJ, 

	sum(case when Tipe='RPJ' then Case when @Nosat=1 Then QntDB else Qnt2DB  else 0 ) QntRPJ, 

	sum(case when Tipe='ADI' then Case when @Nosat=1 Then QntDB else Qnt2DB  else 0 ) QntADI, 

	sum(case when Tipe='ADO' then Case when @Nosat=1 Then QntCr else Qnt2Cr  else 0 ) QntADO, 

	sum(case when Tipe='TRI' then Case when @Nosat=1 Then QntDB else Qnt2DB  else 0 ) QntTRI, 

	sum(case when Tipe='TRO' then Case when @Nosat=1 Then QntCr else Qnt2Cr  else 0 ) QntTRO, 

	sum(case when Tipe='UKO' then Case when @Nosat=1 Then QntCr else Qnt2Cr  else 0 ) QntUKI, 

	sum(case when Tipe='UKI' then Case when @Nosat=1 Then QntDB else Qnt2DB  else 0 ) QntUKO,

	sum(case when Tipe='HP' then Case when @Nosat=1 Then QntDB else Qnt2DB  else 0 ) QntHP,

	sum(case when Tipe='BPSB IN' then Case when @Nosat=1 Then QntDB else Qnt2DB  else 0 ) QntBPSBIN, 

	sum(case when Tipe='BPSB Out' then Case when @Nosat=1 Then QntCr else Qnt2Cr  else 0 ) QntBPSBOUT,

	sum(case when Tipe='PB' then Case when @Nosat=1 Then QntCr else Qnt2Cr  else 0 ) QntPB,

	sum(case when Tipe='RPB' then Case when @Nosat=1 Then QntDB else Qnt2DB  else 0 ) QntRPB,

	sum(case when Tipe in ('AWL','PBL','RPJ','ADI','TRI','UKI','HP','BPSB IN','RPB') then Case when @Nosat=1 Then QntSaldo else Qnt2Saldo 

	         when Tipe in ('RBP','PNJ','ADO','TRO','UKO','BPSB Out','PB') Then  Case when @Nosat=1 Then QntSaldo else Qnt2Saldo  ) SaldoQnt 

from vwKartuStock  

where (Tanggal between @awal and @akhir) and KodeGdg like @gudang

group by KodeBrg, KodeGdg,HPP 

) X 

group by KodeBrg, KodeGdg,HPP 

) A

left outer join dbBarang B on B.KodeBrg=A.KodeBrg 

left outer join dbGudang C on C.KodeGdg=A.KodeGdg 

left outer join dbGroup D on D.KodeGrp=B.KodeGrp 

where (QNTAWAL<>0 or QNTPBL<>0 or QNTRPB<>0 or QNTPNJ<>0 or QNTRPJ<>0 or 

 QNTADI<>0 or QNTADO<>0 or QNTUKI<>0 or QNTUKO<>0 or QNTTRI<>0 or QNTTRO<>0 or SALDOQNT<>0 )

and (b.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP=('FG')Group by KODEGRP)) 

order by B.KodeGrp, A.KodeBrg, A.KodeGdg 



else if @gudang not in('G1','R1') and (@gudang<>'%')

select A.KodeBrg, B.NamaBrg, Case when @nosat=1 Then B.Sat1 else B.SAT2  Sat1, A.KodeGdg, C.Nama NamaGdg, 

  A.QNTAWAL   QntAwal, 

  A.QNTPBL   QNTPBL, 

  A.QNTRPB   QNTRPB, 

  A.QNTPNJ   QNTPNJ, 

  A.QNTRPJ   QNTRPJ, 

  A.QNTADI   QNTADI, 

  A.QNTADO   QNTADO, 

  A.QNTUKI   QNTUKI, 

  A.QNTUKO   QNTUKO, 

  A.QNTTRI   QNTTRI, 

  A.QNTTRO   QNTTRO, 

  A.SALDOQNT   SALDOQNT, 

  (A.QNTAWAL  ) +

  (A.QNTPBL  ) -

  (A.QNTRPB  ) AS TOTALSTOCK,

  (A.QNTPNJ  ) - 

  (A.QNTRPJ  ) AS SELLOUTNET,

  ((A.QNTAWAL  ) + 

  (A.QNTPBL  ) - 

  (A.QNTRPB  )) - 

  ((A.QNTPNJ  ) - 

  (A.QNTRPJ  )) AS FINALSTOCK,

  HPP

from 

(

select 	KodeBrg,HPP, KodeGdg, sum(QntAwal) QntAwal, sum(QntPBL) QntPBL, sum(QntRBP) QntRBP, 

	sum(QntPNJ) QntPNJ, sum(QntRPJ) QntRPJ, sum(QntADI) QntADI, sum(QntADO) QntADO, 

	sum(QntTRI) QntTRI, sum(QntTRO) QntTRO, sum(QntUKI) QntUKI, sum(QntUKO) QntUKO,SUM(QntBPSBIN)QntBPSBIN,SUM(QntBPSBOUT)QntBPSBOUT,

	sum(QntPB)QntPB,Sum(QntRPB)QntRPB, sum(SaldoQnt) SaldoQnt 

from 

(  

/*select        KodeBrg, KodeGdg, QntAwal, 0 QntPBL, 0 QntRPB, 0 QntPNJ, 0 QntRPJ, 

	0 QntADI, 0 QntADO, 0 QntTRI, 0 QntTRO, 0 QntUKI, 0 QntUKO, QntAwal SaldoQnt 

from 	dbStockBrg 

where  Tahun=year(@awal) and Bulan=MONTH(@awal) and KodeGdg=@gudang



union all 

select 	KodeBrg, KodeGdg, 

	sum(case when Tipe in ('PBL','RPJ','ADI','TRI','UKI','HP','BPSB IN') then Qnt else -1*Qnt ) QntAwal, 

	0 QntPBL, 0 QntRPB, 0 QntPNJ, 0 QntRPJ, 

	0 QntADI, 0 QntADO, 0 QntTRI, 0 QntTRO, 0 QntUKI, 0 QntUKO, 

	sum(case when Tipe in ('PBL','RPJ','ADI','TRI','UKI','BPSB OUT') then Qnt else -1*Qnt ) SaldoQnt 

from 	vwKartuStock 

where 	year(Tanggal)=2012 and Tanggal<@akhir and KodeGdg=@gudang

group by KodeBrg, KodeGdg 



union all */

select 	KodeBrg,HPP, KodeGdg, sum(case when Tipe='AWL' then Case when @nosat=1 Then QntSaldo else Qnt2Saldo  else 0 ) QntAwal, 

	sum(case when Tipe='PBL' then Case when @Nosat=1 Then QntDB else Qnt2DB  else 0 ) QntPBL, 

	sum(case when Tipe='RBP' then Case when @Nosat=1 Then QntCr else Qnt2Cr  else 0 ) QntRBP, 

	sum(case when Tipe='PNJ' then Case when @Nosat=1 Then QntCr else Qnt2Cr  else 0 ) QntPNJ, 

	sum(case when Tipe='RPJ' then Case when @Nosat=1 Then QntDB else Qnt2DB  else 0 ) QntRPJ, 

	sum(case when Tipe='ADI' then Case when @Nosat=1 Then QntDB else Qnt2DB  else 0 ) QntADI, 

	sum(case when Tipe='ADO' then Case when @Nosat=1 Then QntCr else Qnt2Cr  else 0 ) QntADO, 

	sum(case when Tipe='TRI' then Case when @Nosat=1 Then QntDB else Qnt2DB  else 0 ) QntTRI, 

	sum(case when Tipe='TRO' then Case when @Nosat=1 Then QntCr else Qnt2Cr  else 0 ) QntTRO, 

	sum(case when Tipe='UKO' then Case when @Nosat=1 Then QntCr else Qnt2Cr  else 0 ) QntUKI, 

	sum(case when Tipe='UKI' then Case when @Nosat=1 Then QntDB else Qnt2DB  else 0 ) QntUKO,

	sum(case when Tipe='HP' then Case when @Nosat=1 Then QntDB else Qnt2DB  else 0 ) QntHP,

	sum(case when Tipe='BPSB IN' then Case when @Nosat=1 Then QntDB else Qnt2DB  else 0 ) QntBPSBIN, 

	sum(case when Tipe='BPSB Out' then Case when @Nosat=1 Then QntCr else Qnt2Cr  else 0 ) QntBPSBOUT,

	sum(case when Tipe='PB' then Case when @Nosat=1 Then QntCr else Qnt2Cr  else 0 ) QntPB,

	sum(case when Tipe='RPB' then Case when @Nosat=1 Then QntDB else Qnt2DB  else 0 ) QntRPB,

	sum(case when Tipe in ('AWL','PBL','RPJ','ADI','TRI','UKI','HP','BPSB IN','RPB') then Case when @Nosat=1 Then QntSaldo else Qnt2Saldo 

	         when Tipe in ('RBP','PNJ','ADO','TRO','UKO','BPSB Out','PB') Then  Case when @Nosat=1 Then QntSaldo else Qnt2Saldo  ) SaldoQnt 

from vwKartuStock  

where (Tanggal between @awal and @akhir) and KodeGdg like @gudang

group by KodeBrg, KodeGdg,HPP 

) X 

group by KodeBrg, KodeGdg,HPP 

) A

left outer join dbBarang B on B.KodeBrg=A.KodeBrg 

left outer join dbGudang C on C.KodeGdg=A.KodeGdg 

left outer join dbGroup D on D.KodeGrp=B.KodeGrp 

where (QNTAWAL<>0 or QNTPBL<>0 or QNTRPB<>0 or QNTPNJ<>0 or QNTRPJ<>0 or 

 QNTADI<>0 or QNTADO<>0 or QNTUKI<>0 or QNTUKO<>0 or QNTTRI<>0 or QNTTRO<>0 or SALDOQNT<>0 )

and (b.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('FG','SVC')Group by KODEGRP)) 

order by B.KodeGrp, A.KodeBrg, A.KodeGdg 

 

else

select A.KodeBrg, B.NamaBrg, Case when @nosat=1 Then B.Sat1 else B.SAT2  Sat1, A.KodeGdg, C.Nama NamaGdg, 

  A.QNTAWAL   QntAwal, 

  A.QNTPBL   QNTPBL, 

  A.QNTRPB   QNTRPB, 

  A.QNTPNJ   QNTPNJ, 

  A.QNTRPJ   QNTRPJ, 

  A.QNTADI   QNTADI, 

  A.QNTADO   QNTADO, 

  A.QNTUKI   QNTUKI, 

  A.QNTUKO   QNTUKO, 

  A.QNTTRI   QNTTRI, 

  A.QNTTRO   QNTTRO, 

  A.SALDOQNT   SALDOQNT, 

  (A.QNTAWAL  ) +

  (A.QNTPBL  ) -

  (A.QNTRPB  ) AS TOTALSTOCK,

  (A.QNTPNJ  ) - 

  (A.QNTRPJ  ) AS SELLOUTNET,

  ((A.QNTAWAL  ) + 

  (A.QNTPBL  ) - 

  (A.QNTRPB  )) - 

  ((A.QNTPNJ  ) - 

  (A.QNTRPJ  )) AS FINALSTOCK,

  HPP

from 

(

select 	KodeBrg,HPP, KodeGdg, sum(QntAwal) QntAwal, sum(QntPBL) QntPBL, sum(QntRBP) QntRBP, 

	sum(QntPNJ) QntPNJ, sum(QntRPJ) QntRPJ, sum(QntADI) QntADI, sum(QntADO) QntADO, 

	sum(QntTRI) QntTRI, sum(QntTRO) QntTRO, sum(QntUKI) QntUKI, sum(QntUKO) QntUKO,SUM(QntBPSBIN)QntBPSBIN,SUM(QntBPSBOUT)QntBPSBOUT,

	sum(QntPB)QntPB,Sum(QntRPB)QntRPB, sum(SaldoQnt) SaldoQnt 

from 

(  

/*select        KodeBrg, KodeGdg, QntAwal, 0 QntPBL, 0 QntRPB, 0 QntPNJ, 0 QntRPJ, 

	0 QntADI, 0 QntADO, 0 QntTRI, 0 QntTRO, 0 QntUKI, 0 QntUKO, QntAwal SaldoQnt 

from 	dbStockBrg 

where  Tahun=year(@awal) and Bulan=MONTH(@awal) and KodeGdg=@gudang



union all 

select 	KodeBrg, KodeGdg, 

	sum(case when Tipe in ('PBL','RPJ','ADI','TRI','UKI','HP','BPSB IN') then Qnt else -1*Qnt ) QntAwal, 

	0 QntPBL, 0 QntRPB, 0 QntPNJ, 0 QntRPJ, 

	0 QntADI, 0 QntADO, 0 QntTRI, 0 QntTRO, 0 QntUKI, 0 QntUKO, 

	sum(case when Tipe in ('PBL','RPJ','ADI','TRI','UKI','BPSB OUT') then Qnt else -1*Qnt ) SaldoQnt 

from 	vwKartuStock 

where 	year(Tanggal)=2012 and Tanggal<@akhir and KodeGdg=@gudang

group by KodeBrg, KodeGdg 



union all */

select 	KodeBrg,HPP, KodeGdg, sum(case when Tipe='AWL' then Case when @nosat=1 Then QntSaldo else Qnt2Saldo  else 0 ) QntAwal, 

	sum(case when Tipe='PBL' then Case when @Nosat=1 Then QntDB else Qnt2DB  else 0 ) QntPBL, 

	sum(case when Tipe='RBP' then Case when @Nosat=1 Then QntCr else Qnt2Cr  else 0 ) QntRBP, 

	sum(case when Tipe='PNJ' then Case when @Nosat=1 Then QntCr else Qnt2Cr  else 0 ) QntPNJ, 

	sum(case when Tipe='RPJ' then Case when @Nosat=1 Then QntDB else Qnt2DB  else 0 ) QntRPJ, 

	sum(case when Tipe='ADI' then Case when @Nosat=1 Then QntDB else Qnt2DB  else 0 ) QntADI, 

	sum(case when Tipe='ADO' then Case when @Nosat=1 Then QntCr else Qnt2Cr  else 0 ) QntADO, 

	sum(case when Tipe='TRI' then Case when @Nosat=1 Then QntDB else Qnt2DB  else 0 ) QntTRI, 

	sum(case when Tipe='TRO' then Case when @Nosat=1 Then QntCr else Qnt2Cr  else 0 ) QntTRO, 

	sum(case when Tipe='UKO' then Case when @Nosat=1 Then QntCr else Qnt2Cr  else 0 ) QntUKI, 

	sum(case when Tipe='UKI' then Case when @Nosat=1 Then QntDB else Qnt2DB  else 0 ) QntUKO,

	sum(case when Tipe='HP' then Case when @Nosat=1 Then QntDB else Qnt2DB  else 0 ) QntHP,

	sum(case when Tipe='BPSB IN' then Case when @Nosat=1 Then QntDB else Qnt2DB  else 0 ) QntBPSBIN, 

	sum(case when Tipe='BPSB Out' then Case when @Nosat=1 Then QntCr else Qnt2Cr  else 0 ) QntBPSBOUT,

	sum(case when Tipe='PB' then Case when @Nosat=1 Then QntCr else Qnt2Cr  else 0 ) QntPB,

	sum(case when Tipe='RPB' then Case when @Nosat=1 Then QntDB else Qnt2DB  else 0 ) QntRPB,

	sum(case when Tipe in ('AWL','PBL','RPJ','ADI','TRI','UKI','HP','BPSB IN','RPB') then Case when @Nosat=1 Then QntSaldo else Qnt2Saldo 

	         when Tipe in ('RBP','PNJ','ADO','TRO','UKO','BPSB Out','PB') Then  Case when @Nosat=1 Then QntSaldo else Qnt2Saldo  ) SaldoQnt 

from vwKartuStock  

where (Tanggal between @awal and @akhir) and KodeGdg Like @gudang

group by KodeBrg, KodeGdg,HPP 

) X 

group by KodeBrg, KodeGdg,HPP 

) A

left outer join dbBarang B on B.KodeBrg=A.KodeBrg 

left outer join dbGudang C on C.KodeGdg=A.KodeGdg 

left outer join dbGroup D on D.KodeGrp=B.KodeGrp 

where (QNTAWAL<>0 or QNTPBL<>0 or QNTRPB<>0 or QNTPNJ<>0 or QNTRPJ<>0 or 

 QNTADI<>0 or QNTADO<>0 or QNTUKI<>0 or QNTUKO<>0 or QNTTRI<>0 or QNTTRO<>0 or SALDOQNT<>0 )

and (b.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('SVC')Group by KODEGRP))  

order by B.KodeGrp, A.KodeBrg, A.KodeGdg;

-- Sp_reportStockQtyPCS
CREATE PROCEDURE IF NOT EXISTS Sp_reportStockQtyPCS AS -- SET REMOVEDCase when @kodegdg in ('','-') then '%' else @kodegdg 


	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	'PCS' Satuan, 

	a.QNTAWAL QntAwal, 

	a.QNTPBL QNTPBL, 

	a.QntRPB QNTRBP, 

	a.QNTPMK QNTPMK,   

	a.QntRPK QNTRPK, 

	a.QNTRPB QNTRPB, 

	a.QNTPNJ QNTPNJ, 

	a.QNTRPJ QNTRPJ,

	a.QNTADI QNTADI, 

	a.QNTADO QNTADO, 

	a.QNTUKI QNTUKI,

	a.QNTUKO QNTUKO, 

	a.QNTTRI QNTTRI, 

	a.QNTTRO QNTTRO, 

	A.QntHPrd QntHPrd,

	a.QNTIN QNTIN,  

	a.QNTOUT QNTOUT, 

	a.SALDOQNT SALDOQNT 

	from [vwReportStockBrgPCS] a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg

	and a.KodeGrp like @KodeGrp+'%'

	and (a.QNTAWAL<>0 or QNTIN<>0 or  QNTOUT<>0)                  

	order by KODEGRP,KODESUBGRP,a.kodebrg,a.kodegdg;

-- Sp_reportStockQtyRp
CREATE PROCEDURE IF NOT EXISTS Sp_reportStockQtyRp AS -- SET REMOVEDCase when @kodegdg in ('','-') then '%' else @kodegdg 



If @Minus=0 and @MinusHpp=0

if @Pilih=0

 If @isi=1

	if @Kodegdg in('G1','R1')

    Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi1 QntAwal, a.HRGAWAL, 

	a.QNTPBL/a.Isi1 QNTPBL, a.HRGPBL,

	a.QntRPB/a.Isi1 QNTRBP, a.HRGRPB HRGRBP,

	a.QNTPMK/a.Isi1 QNTPMK,   a.HRGPMK,  

	a.QntRPK/a.Isi1 QNTRPK, a.HRGRPK, 

	a.QNTRPB/a.Isi1 QNTRPB, a.HRGRPB, 

	a.QNTPNJ/a.Isi1 QNTPNJ, a.HRGPNJ, 

	a.QNTRPJ/a.Isi1 QNTRPJ, a.HRGRPJ, 

	a.QNTADI/a.Isi1 QNTADI, a.HRGADI, 

	a.QNTADO/a.Isi1 QNTADO, a.HRGADO, 

	a.QNTUKI/a.Isi1 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi1 QNTUKO, a.HRGUKO, 

	a.QNTTRI/a.Isi1 QNTTRI, a.HRGTRI, 

	a.QNTTRO/a.Isi1 QNTTRO, a.HRGTRO,

	A.QntHPrd/a.ISI1 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi1 QNTIN, a.RPIN, 

	a.QNTOUT/a.Isi1 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi1 SALDOQNT, a.SALDORP,

	'1' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP=('FG')Group by KODEGRP))

	and (a.QNTAWAL<>0 or QNTIN<>0 or  QNTOUT<>0)                  

	--And a.SALDOQNT/a.Isi1 < 0

	order by KODEGRP,KODESUBGRP,a.kodebrg,a.kodegdg

	

	else if @Kodegdg not in('G1','R1') and @Kodegdg<>'%'

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi1 QntAwal, a.HRGAWAL, 

	a.QNTPBL/a.Isi1 QNTPBL, a.HRGPBL,

	a.QntRPB/a.Isi1 QNTRBP, a.HRGRPB HRGRBP,

	a.QNTPMK/a.Isi1 QNTPMK,   a.HRGPMK,  

	a.QntRPK/a.Isi1 QNTRPK, a.HRGRPK, 

	a.QNTRPB/a.Isi1 QNTRPB, a.HRGRPB, 

	a.QNTPNJ/a.Isi1 QNTPNJ, a.HRGPNJ, 

	a.QNTRPJ/a.Isi1 QNTRPJ, a.HRGRPJ, 

	a.QNTADI/a.Isi1 QNTADI, a.HRGADI, 

	a.QNTADO/a.Isi1 QNTADO, a.HRGADO, 

	a.QNTUKI/a.Isi1 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi1 QNTUKO, a.HRGUKO, 

	a.QNTTRI/a.Isi1 QNTTRI, a.HRGTRI, 

	a.QNTTRO/a.Isi1 QNTTRO, a.HRGTRO,

	A.QntHPrd/a.ISI1 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi1 QNTIN, a.RPIN, 

	a.QNTOUT/a.Isi1 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi1 SALDOQNT, a.SALDORP,

	'1' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	--and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('SVC')Group by KODEGRP))

	and (a.QNTAWAL<>0 or QNTIN<>0 or  QNTOUT<>0)                  

	--And a.SALDOQNT/a.Isi1 < 0

	order by KODEGRP,KODESUBGRP,a.kodebrg,a.kodegdg

	

	else

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi1 QntAwal, a.HRGAWAL, 

	a.QNTPBL/a.Isi1 QNTPBL, a.HRGPBL,

	a.QntRPB/a.Isi1 QNTRBP, a.HRGRPB HRGRBP,

	a.QNTPMK/a.Isi1 QNTPMK,   a.HRGPMK,  

	a.QntRPK/a.Isi1 QNTRPK, a.HRGRPK, 

	a.QNTRPB/a.Isi1 QNTRPB, a.HRGRPB, 

	a.QNTPNJ/a.Isi1 QNTPNJ, a.HRGPNJ, 

	a.QNTRPJ/a.Isi1 QNTRPJ, a.HRGRPJ, 

	a.QNTADI/a.Isi1 QNTADI, a.HRGADI, 

	a.QNTADO/a.Isi1 QNTADO, a.HRGADO, 

	a.QNTUKI/a.Isi1 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi1 QNTUKO, a.HRGUKO, 

	a.QNTTRI/a.Isi1 QNTTRI, a.HRGTRI, 

	a.QNTTRO/a.Isi1 QNTTRO, a.HRGTRO,

	A.QntHPrd/a.ISI1 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi1 QNTIN, a.RPIN, 

	a.QNTOUT/a.Isi1 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi1 SALDOQNT, a.SALDORP,

	'1' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	--and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('SVC')Group by KODEGRP))                 

	--And a.SALDOQNT/a.Isi1 < 0

	and (a.QNTAWAL<>0 or QNTIN<>0 or  QNTOUT<>0 or a.HRGAWAL<>0 or a.SALDORP<>0) 

	order by KODEGRP,KODESUBGRP,a.kodebrg,a.kodegdg

	

	 else 

  If @isi=2

	if @Kodegdg in('G1','R1')

    Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi2 QntAwal, a.HRGAWAL, 

	a.QNTPBL/a.Isi2 QNTPBL, a.HRGPBL,

	a.QntRPB/a.Isi2 QNTRBP, a.HRGRPB HRGRBP, 

	a.QNTPMK/a.Isi2 QNTPMK, a.HRGPMK, 

	a.QNTRPK/a.Isi2 QNTRPK, a.HRGRPK, 

	a.QNTPNJ/a.Isi2 QNTPNJ, a.HRGPNJ, 

	a.QNTRPJ/a.Isi2 QNTRPJ, a.HRGRPJ, 

	a.QNTADI/a.Isi2 QNTADI, a.HRGADI, 

	a.QNTADO/a.Isi2 QNTADO, a.HRGADO, 

	a.QNTUKI/a.Isi2 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi2 QNTUKO, a.HRGUKO, 

	a.QNTTRI/a.Isi2 QNTTRI, a.HRGTRI, 

	a.QNTTRO/a.Isi2 QNTTRO, a.HRGTRO,

	A.QntHPrd/a.ISI2 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi2 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi2 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi2 SALDOQNT, a.SALDORP,

	'2' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP=('FG')Group by KODEGRP))

	and (a.QNTAWAL<>0 or QNTIN<>0 or  QNTOUT<>0) 

	order by KODEGRP,KODESUBGRP,a.kodebrg,a.kodegdg

	

	else if @Kodegdg not in('G1','R1') and @Kodegdg<>'%'

	Select a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi2 QntAwal, a.HRGAWAL, 

	a.QNTPBL/a.Isi2 QNTPBL, a.HRGPBL,

	a.QntRPB/a.Isi2 QNTRBP, a.HRGRPB HRGRBP, 

	a.QNTPMK/a.Isi2 QNTPMK, a.HRGPMK, 

	a.QNTRPK/a.Isi2 QNTRPK, a.HRGRPK, 

	a.QNTPNJ/a.Isi2 QNTPNJ, a.HRGPNJ, 

	a.QNTRPJ/a.Isi2 QNTRPJ, a.HRGRPJ, 

	a.QNTADI/a.Isi2 QNTADI, a.HRGADI, 

	a.QNTADO/a.Isi2 QNTADO, a.HRGADO, 

	a.QNTUKI/a.Isi2 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi2 QNTUKO, a.HRGUKO, 

	a.QNTTRI/a.Isi2 QNTTRI, a.HRGTRI, 

	a.QNTTRO/a.Isi2 QNTTRO, a.HRGTRO,

	A.QntHPrd/a.ISI2 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi2 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi2 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi2 SALDOQNT, a.SALDORP,

	'2' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('SVC')Group by KODEGRP))

	and (a.QNTAWAL<>0 or QNTIN<>0 or  QNTOUT<>0) 

	--And a.SALDOQNT/a.Isi1 < 0

	order by KODEGRP,KODESUBGRP,a.kodebrg,a.kodegdg

	

	else

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi2 QntAwal, a.HRGAWAL, 

	a.QNTPBL/a.Isi2 QNTPBL, a.HRGPBL,

	a.QntRPB/a.Isi2 QNTRBP, a.HRGRPB HRGRBP, 

	a.QNTPMK/a.Isi2 QNTPMK, a.HRGPMK, 

	a.QNTRPK/a.Isi2 QNTRPK, a.HRGRPK, 

	a.QNTPNJ/a.Isi2 QNTPNJ, a.HRGPNJ, 

	a.QNTRPJ/a.Isi2 QNTRPJ, a.HRGRPJ, 

	a.QNTADI/a.Isi2 QNTADI, a.HRGADI, 

	a.QNTADO/a.Isi2 QNTADO, a.HRGADO, 

	a.QNTUKI/a.Isi2 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi2 QNTUKO, a.HRGUKO, 

	a.QNTTRI/a.Isi2 QNTTRI, a.HRGTRI, 

	a.QNTTRO/a.Isi2 QNTTRO, a.HRGTRO,

	A.QntHPrd/a.ISI2 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi2 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi2 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi2 SALDOQNT, a.SALDORP,

	'2' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('SVC')Group by KODEGRP))

	and (a.QNTAWAL<>0 or QNTIN<>0 or  QNTOUT<>0) 

	order by KODEGRP,KODESUBGRP,a.kodebrg,a.kodegdg

	

	 else 

	If @isi=3

	select 1


 else if @Pilih=1 --nonJasa

 If @isi=1

	if @Kodegdg in('G1','R1')

    Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi1 QntAwal, a.HRGAWAL, 

	a.QNTPBL/a.Isi1 QNTPBL, a.HRGPBL,

	a.QntRPB/a.Isi1 QNTRBP, a.HRGRPB HRGRBP,

	a.QNTPMK/a.Isi1 QNTPMK,   a.HRGPMK,  

	a.QntRPK/a.Isi1 QNTRPK, a.HRGRPK, 

	a.QNTRPB/a.Isi1 QNTRPB, a.HRGRPB, 

	a.QNTPNJ/a.Isi1 QNTPNJ, a.HRGPNJ, 

	a.QNTRPJ/a.Isi1 QNTRPJ, a.HRGRPJ, 

	a.QNTADI/a.Isi1 QNTADI, a.HRGADI, 

	a.QNTADO/a.Isi1 QNTADO, a.HRGADO, 

	a.QNTUKI/a.Isi1 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi1 QNTUKO, a.HRGUKO, 

	a.QNTTRI/a.Isi1 QNTTRI, a.HRGTRI, 

	a.QNTTRO/a.Isi1 QNTTRO, a.HRGTRO,

	A.QntHPrd/a.ISI1 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi1 QNTIN, a.RPIN, 

	a.QNTOUT/a.Isi1 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi1 SALDOQNT, a.SALDORP,

	'1' 

	from vwReportKartuBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP=('FG')Group by KODEGRP))

	and (a.QNTAWAL<>0 or QNTIN<>0 or  QNTOUT<>0)                     

	order by KODEGRP,KODESUBGRP,a.kodebrg,a.kodegdg

	

	else if @Kodegdg not in('G1','R1') and @Kodegdg<>'%'

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi1 QntAwal, a.HRGAWAL, 

	a.QNTPBL/a.Isi1 QNTPBL, a.HRGPBL,

	a.QntRPB/a.Isi1 QNTRBP, a.HRGRPB HRGRBP,

	a.QNTPMK/a.Isi1 QNTPMK,   a.HRGPMK,  

	a.QntRPK/a.Isi1 QNTRPK, a.HRGRPK, 

	a.QNTRPB/a.Isi1 QNTRPB, a.HRGRPB, 

	a.QNTPNJ/a.Isi1 QNTPNJ, a.HRGPNJ, 

	a.QNTRPJ/a.Isi1 QNTRPJ, a.HRGRPJ, 

	a.QNTADI/a.Isi1 QNTADI, a.HRGADI, 

	a.QNTADO/a.Isi1 QNTADO, a.HRGADO, 

	a.QNTUKI/a.Isi1 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi1 QNTUKO, a.HRGUKO, 

	a.QNTTRI/a.Isi1 QNTTRI, a.HRGTRI, 

	a.QNTTRO/a.Isi1 QNTTRO, a.HRGTRO,

	A.QntHPrd/a.ISI1 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi1 QNTIN, a.RPIN, 

	a.QNTOUT/a.Isi1 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi1 SALDOQNT, a.SALDORP,

	'1' 

	from vwReportKartuBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('SVC')Group by KODEGRP))

	and (a.QNTAWAL<>0 or QNTIN<>0 or  QNTOUT<>0)                  

	order by KODEGRP,KODESUBGRP,a.kodebrg,a.kodegdg

	

	else

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi1 QntAwal, a.HRGAWAL, 

	a.QNTPBL/a.Isi1 QNTPBL, a.HRGPBL,

	a.QntRPB/a.Isi1 QNTRBP, a.HRGRPB HRGRBP,

	a.QNTPMK/a.Isi1 QNTPMK,   a.HRGPMK,  

	a.QntRPK/a.Isi1 QNTRPK, a.HRGRPK, 

	a.QNTRPB/a.Isi1 QNTRPB, a.HRGRPB, 

	a.QNTPNJ/a.Isi1 QNTPNJ, a.HRGPNJ, 

	a.QNTRPJ/a.Isi1 QNTRPJ, a.HRGRPJ, 

	a.QNTADI/a.Isi1 QNTADI, a.HRGADI, 

	a.QNTADO/a.Isi1 QNTADO, a.HRGADO, 

	a.QNTUKI/a.Isi1 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi1 QNTUKO, a.HRGUKO, 

	a.QNTTRI/a.Isi1 QNTTRI, a.HRGTRI, 

	a.QNTTRO/a.Isi1 QNTTRO, a.HRGTRO,

	A.QntHPrd/a.ISI1 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi1 QNTIN, a.RPIN, 

	a.QNTOUT/a.Isi1 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi1 SALDOQNT, a.SALDORP,

	'1' 

	from vwReportKartuBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('SVC')Group by KODEGRP))                 

	and (a.QNTAWAL<>0 or QNTIN<>0 or  QNTOUT<>0) 

	---

	order by KODEGRP,KODESUBGRP,a.kodebrg,a.kodegdg

	

	 else 

  If @isi=2

	if @Kodegdg in('G1','R1')

    Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi2 QntAwal, a.HRGAWAL, 

	a.QNTPBL/a.Isi2 QNTPBL, a.HRGPBL,

	a.QntRPB/a.Isi2 QNTRBP, a.HRGRPB HRGRBP, 

	a.QNTPMK/a.Isi2 QNTPMK, a.HRGPMK, 

	a.QNTRPK/a.Isi2 QNTRPK, a.HRGRPK, 

	a.QNTPNJ/a.Isi2 QNTPNJ, a.HRGPNJ, 

	a.QNTRPJ/a.Isi2 QNTRPJ, a.HRGRPJ, 

	a.QNTADI/a.Isi2 QNTADI, a.HRGADI, 

	a.QNTADO/a.Isi2 QNTADO, a.HRGADO, 

	a.QNTUKI/a.Isi2 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi2 QNTUKO, a.HRGUKO, 

	a.QNTTRI/a.Isi2 QNTTRI, a.HRGTRI, 

	a.QNTTRO/a.Isi2 QNTTRO, a.HRGTRO,

	A.QntHPrd/a.ISI2 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi2 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi2 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi2 SALDOQNT, a.SALDORP,

	'2' 

	from vwReportKartuBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP=('FG')Group by KODEGRP))

	and (a.QNTAWAL<>0 or QNTIN<>0 or  QNTOUT<>0) 

	--

	order by KODEGRP,KODESUBGRP,a.kodebrg,a.kodegdg

	

	else if @Kodegdg not in('G1','R1') and @Kodegdg<>'%'

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi2 QntAwal, a.HRGAWAL, 

	a.QNTPBL/a.Isi2 QNTPBL, a.HRGPBL,

	a.QntRPB/a.Isi2 QNTRBP, a.HRGRPB HRGRBP, 

	a.QNTPMK/a.Isi2 QNTPMK, a.HRGPMK, 

	a.QNTRPK/a.Isi2 QNTRPK, a.HRGRPK, 

	a.QNTPNJ/a.Isi2 QNTPNJ, a.HRGPNJ, 

	a.QNTRPJ/a.Isi2 QNTRPJ, a.HRGRPJ, 

	a.QNTADI/a.Isi2 QNTADI, a.HRGADI, 

	a.QNTADO/a.Isi2 QNTADO, a.HRGADO, 

	a.QNTUKI/a.Isi2 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi2 QNTUKO, a.HRGUKO, 

	a.QNTTRI/a.Isi2 QNTTRI, a.HRGTRI, 

	a.QNTTRO/a.Isi2 QNTTRO, a.HRGTRO,

	A.QntHPrd/a.ISI2 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi2 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi2 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi2 SALDOQNT, a.SALDORP,

	'2' 

	from vwReportKartuBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('SVC')Group by KODEGRP))

	and (a.QNTAWAL<>0 or QNTIN<>0 or  QNTOUT<>0) 

	

	order by KODEGRP,KODESUBGRP,a.kodebrg,a.kodegdg

	

	else

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi2 QntAwal, a.HRGAWAL, 

	a.QNTPBL/a.Isi2 QNTPBL, a.HRGPBL,

	a.QntRPB/a.Isi2 QNTRBP, a.HRGRPB HRGRBP, 

	a.QNTPMK/a.Isi2 QNTPMK, a.HRGPMK, 

	a.QNTRPK/a.Isi2 QNTRPK, a.HRGRPK, 

	a.QNTPNJ/a.Isi2 QNTPNJ, a.HRGPNJ, 

	a.QNTRPJ/a.Isi2 QNTRPJ, a.HRGRPJ, 

	a.QNTADI/a.Isi2 QNTADI, a.HRGADI, 

	a.QNTADO/a.Isi2 QNTADO, a.HRGADO, 

	a.QNTUKI/a.Isi2 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi2 QNTUKO, a.HRGUKO, 

	a.QNTTRI/a.Isi2 QNTTRI, a.HRGTRI, 

	a.QNTTRO/a.Isi2 QNTTRO, a.HRGTRO,

	A.QntHPrd/a.ISI2 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi2 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi2 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi2 SALDOQNT, a.SALDORP,

	'2' 

	from vwReportKartuBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('SVC')Group by KODEGRP))

	--

	and (a.QNTAWAL<>0 or QNTIN<>0 or  QNTOUT<>0) 

	order by KODEGRP,KODESUBGRP,a.kodebrg,a.kodegdg

	

	 else 

	If @isi=3

	select 1


 else if @Pilih=2 --Jasa

 If @isi=1

	if @Kodegdg in('G1','R1')

    Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi1 QntAwal, a.HRGAWAL, 

	a.QNTPBL/a.Isi1 QNTPBL, a.HRGPBL,

	a.QntRPB/a.Isi1 QNTRBP, a.HRGRPB HRGRBP,

	a.QNTPMK/a.Isi1 QNTPMK,   a.HRGPMK,  

	a.QntRPK/a.Isi1 QNTRPK, a.HRGRPK, 

	a.QNTRPB/a.Isi1 QNTRPB, a.HRGRPB, 

	a.QNTPNJJ/a.Isi1 QNTPNJ, a.HRGPNJJ HRGPNJ, 

	a.QNTRPJJ/a.Isi1 QNTRPJ, a.HRGRPJJ HRGRPJ, 

	a.QNTADI/a.Isi1 QNTADI, a.HRGADI, 

	a.QNTADO/a.Isi1 QNTADO, a.HRGADO, 

	a.QNTUKI/a.Isi1 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi1 QNTUKO, a.HRGUKO, 

	a.QNTTRI/a.Isi1 QNTTRI, a.HRGTRI, 

	a.QNTTRO/a.Isi1 QNTTRO, a.HRGTRO,

	A.QntHPrd/a.ISI1 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi1 QNTIN, a.RPIN, 

	a.QNTOUT/a.Isi1 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi1 SALDOQNT, a.SALDORP,

	'1' 

	from vwReportKartuBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP=('FG')Group by KODEGRP))

	and (a.QNTAWAL<>0 or QNTIN<>0 or  QNTOUT<>0)                     

	order by KODEGRP,KODESUBGRP,a.kodebrg,a.kodegdg

	

	else if @Kodegdg not in('G1','R1') and @Kodegdg<>'%'

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi1 QntAwal, a.HRGAWAL, 

	a.QNTPBL/a.Isi1 QNTPBL, a.HRGPBL,

	a.QntRPB/a.Isi1 QNTRBP, a.HRGRPB HRGRBP,

	a.QNTPMK/a.Isi1 QNTPMK,   a.HRGPMK,  

	a.QntRPK/a.Isi1 QNTRPK, a.HRGRPK, 

	a.QNTRPB/a.Isi1 QNTRPB, a.HRGRPB, 

	a.QNTPNJJ/a.Isi1 QNTPNJ, a.HRGPNJJ HRGPNJ, 

	a.QNTRPJJ/a.Isi1 QNTRPJ, a.HRGRPJJ HRGRPJ, 

	a.QNTADI/a.Isi1 QNTADI, a.HRGADI, 

	a.QNTADO/a.Isi1 QNTADO, a.HRGADO, 

	a.QNTUKI/a.Isi1 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi1 QNTUKO, a.HRGUKO, 

	a.QNTTRI/a.Isi1 QNTTRI, a.HRGTRI, 

	a.QNTTRO/a.Isi1 QNTTRO, a.HRGTRO,

	A.QntHPrd/a.ISI1 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi1 QNTIN, a.RPIN, 

	a.QNTOUT/a.Isi1 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi1 SALDOQNT, a.SALDORP,

	'1' 

	from vwReportKartuBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('SVC')Group by KODEGRP))

	and (a.QNTAWAL<>0 or QNTIN<>0 or  QNTOUT<>0)                  

	order by KODEGRP,KODESUBGRP,a.kodebrg,a.kodegdg

	

	else

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi1 QntAwal, a.HRGAWAL, 

	a.QNTPBL/a.Isi1 QNTPBL, a.HRGPBL,

	a.QntRPB/a.Isi1 QNTRBP, a.HRGRPB HRGRBP,

	a.QNTPMK/a.Isi1 QNTPMK,   a.HRGPMK,  

	a.QntRPK/a.Isi1 QNTRPK, a.HRGRPK, 

	a.QNTRPB/a.Isi1 QNTRPB, a.HRGRPB, 

	a.QNTPNJJ/a.Isi1 QNTPNJ, a.HRGPNJJ HRGPNJ, 

	a.QNTRPJJ/a.Isi1 QNTRPJ, a.HRGRPJJ HRGRPJ, 

	a.QNTADI/a.Isi1 QNTADI, a.HRGADI, 

	a.QNTADO/a.Isi1 QNTADO, a.HRGADO, 

	a.QNTUKI/a.Isi1 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi1 QNTUKO, a.HRGUKO, 

	a.QNTTRI/a.Isi1 QNTTRI, a.HRGTRI, 

	a.QNTTRO/a.Isi1 QNTTRO, a.HRGTRO,

	A.QntHPrd/a.ISI1 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi1 QNTIN, a.RPIN, 

	a.QNTOUT/a.Isi1 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi1 SALDOQNT, a.SALDORP,

	'1' 

	from vwReportKartuBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('SVC')Group by KODEGRP))                 

	---

	and (a.QNTAWAL<>0 or QNTIN<>0 or  QNTOUT<>0) 

	order by KODEGRP,KODESUBGRP,a.kodebrg,a.kodegdg

	

	 else 

  If @isi=2

	if @Kodegdg in('G1','R1')

    Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi2 QntAwal, a.HRGAWAL, 

	a.QNTPBL/a.Isi2 QNTPBL, a.HRGPBL,

	a.QntRPB/a.Isi2 QNTRBP, a.HRGRPB HRGRBP, 

	a.QNTPMK/a.Isi2 QNTPMK, a.HRGPMK, 

	a.QNTRPK/a.Isi2 QNTRPK, a.HRGRPK, 

	a.QNTPNJJ/a.Isi2 QNTPNJ, a.HRGPNJJ HRGPNJ, 

	a.QNTRPJJ/a.Isi2 QNTRPJ, a.HRGRPJJ HRGRPJ, 

	a.QNTADI/a.Isi2 QNTADI, a.HRGADI, 

	a.QNTADO/a.Isi2 QNTADO, a.HRGADO, 

	a.QNTUKI/a.Isi2 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi2 QNTUKO, a.HRGUKO, 

	a.QNTTRI/a.Isi2 QNTTRI, a.HRGTRI, 

	a.QNTTRO/a.Isi2 QNTTRO, a.HRGTRO,

	A.QntHPrd/a.ISI2 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi2 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi2 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi2 SALDOQNT, a.SALDORP,

	'2' 

	from vwReportKartuBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP=('FG')Group by KODEGRP))

	and (a.QNTAWAL<>0 or QNTIN<>0 or  QNTOUT<>0) 

	--

	order by KODEGRP,KODESUBGRP,a.kodebrg,a.kodegdg

	

	else if @Kodegdg not in('G1','R1') and @Kodegdg<>'%'

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi2 QntAwal, a.HRGAWAL, 

	a.QNTPBL/a.Isi2 QNTPBL, a.HRGPBL,

	a.QntRPB/a.Isi2 QNTRBP, a.HRGRPB HRGRBP, 

	a.QNTPMK/a.Isi2 QNTPMK, a.HRGPMK, 

	a.QNTRPK/a.Isi2 QNTRPK, a.HRGRPK, 

	a.QNTPNJJ/a.Isi2 QNTPNJ, a.HRGPNJJ HRGPNJ, 

	a.QNTRPJJ/a.Isi2 QNTRPJ, a.HRGRPJJ HRGRPJ, 

	a.QNTADI/a.Isi2 QNTADI, a.HRGADI, 

	a.QNTADO/a.Isi2 QNTADO, a.HRGADO, 

	a.QNTUKI/a.Isi2 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi2 QNTUKO, a.HRGUKO, 

	a.QNTTRI/a.Isi2 QNTTRI, a.HRGTRI, 

	a.QNTTRO/a.Isi2 QNTTRO, a.HRGTRO,

	A.QntHPrd/a.ISI2 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi2 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi2 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi2 SALDOQNT, a.SALDORP,

	'2' 

	from vwReportKartuBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('SVC')Group by KODEGRP))

	and (a.QNTAWAL<>0 or QNTIN<>0 or  QNTOUT<>0) 

	--And a.SALDOQNT/a.Isi1 < 0

	order by KODEGRP,KODESUBGRP,a.kodebrg,a.kodegdg

	

	else

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi2 QntAwal, a.HRGAWAL, 

	a.QNTPBL/a.Isi2 QNTPBL, a.HRGPBL,

	a.QntRPB/a.Isi2 QNTRBP, a.HRGRPB HRGRBP, 

	a.QNTPMK/a.Isi2 QNTPMK, a.HRGPMK, 

	a.QNTRPK/a.Isi2 QNTRPK, a.HRGRPK, 

	a.QNTPNJJ/a.Isi2 QNTPNJ, a.HRGPNJJ HRGPNJ, 

	a.QNTRPJJ/a.Isi2 QNTRPJ, a.HRGRPJJ HRGRPJ, 

	a.QNTADI/a.Isi2 QNTADI, a.HRGADI, 

	a.QNTADO/a.Isi2 QNTADO, a.HRGADO, 

	a.QNTUKI/a.Isi2 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi2 QNTUKO, a.HRGUKO, 

	a.QNTTRI/a.Isi2 QNTTRI, a.HRGTRI, 

	a.QNTTRO/a.Isi2 QNTTRO, a.HRGTRO,

	A.QntHPrd/a.ISI2 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi2 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi2 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi2 SALDOQNT, a.SALDORP,

	'2' 

	from vwReportKartuBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('SVC')Group by KODEGRP))

	and (a.QNTAWAL<>0 or QNTIN<>0 or  QNTOUT<>0) 

	--

	order by KODEGRP,KODESUBGRP,a.kodebrg,a.kodegdg

	

	 else 

	If @isi=3

	select 1


If @Minus=1 and @MinusHpp=0

If @isi=1

	if @Kodegdg in('G1','R1')

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi1 QntAwal, a.HRGAWAL, 

	a.QNTPBL/a.Isi1 QNTPBL, a.HRGPBL,

	a.QntRPB/a.Isi1 QNTRBP, a.HRGRPB HRGRBP,

	a.QNTPMK/a.Isi1 QNTPMK,   a.HRGPMK,  

	a.QntRPK/a.Isi1 QNTRPK, a.HRGRPK, 

	a.QNTRPB/a.Isi1 QNTRPB, a.HRGRPB, 

	a.QNTPNJ/a.Isi1 QNTPNJ, a.HRGPNJ, 

	a.QNTRPJ/a.Isi1 QNTRPJ, a.HRGRPJ, 

	a.QNTADI/a.Isi1 QNTADI, a.HRGADI, 

	a.QNTADO/a.Isi1 QNTADO, a.HRGADO, 

	a.QNTUKI/a.Isi1 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi1 QNTUKO, a.HRGUKO, 

	a.QNTTRI/a.Isi1 QNTTRI, a.HRGTRI, 

	a.QNTTRO/a.Isi1 QNTTRO, a.HRGTRO,

	A.QntHPrd/a.ISI1 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi1 QNTIN, a.RPIN, 

	a.QNTOUT/a.Isi1 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi1 SALDOQNT, a.SALDORP,

	'1' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	And a.SALDOQNT/a.Isi1 < 0

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP=('FG')Group by KODEGRP))

	order by KODEGRP,KODESUBGRP,a.kodebrg,a.kodegdg

	

	else if @Kodegdg not in('G1','R1') and @Kodegdg<>'%'

	Select a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi1 QntAwal, a.HRGAWAL, 

	a.QNTPBL/a.Isi1 QNTPBL, a.HRGPBL,

	a.QntRPB/a.Isi1 QNTRBP, a.HRGRPB HRGRBP,

	a.QNTPMK/a.Isi1 QNTPMK,   a.HRGPMK,  

	a.QntRPK/a.Isi1 QNTRPK, a.HRGRPK, 

	a.QNTRPB/a.Isi1 QNTRPB, a.HRGRPB, 

	a.QNTPNJ/a.Isi1 QNTPNJ, a.HRGPNJ, 

	a.QNTRPJ/a.Isi1 QNTRPJ, a.HRGRPJ, 

	a.QNTADI/a.Isi1 QNTADI, a.HRGADI, 

	a.QNTADO/a.Isi1 QNTADO, a.HRGADO, 

	a.QNTUKI/a.Isi1 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi1 QNTUKO, a.HRGUKO, 

	a.QNTTRI/a.Isi1 QNTTRI, a.HRGTRI, 

	a.QNTTRO/a.Isi1 QNTTRO, a.HRGTRO,

	A.QntHPrd/a.ISI1 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi1 QNTIN, a.RPIN, 

	a.QNTOUT/a.Isi1 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi1 SALDOQNT, a.SALDORP,

	'1' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	And a.SALDOQNT/a.Isi1 < 0

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('SVC')Group by KODEGRP))

	order by KODEGRP,KODESUBGRP,a.kodebrg,a.kodegdg

	

	else

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi1 QntAwal, a.HRGAWAL, 

	a.QNTPBL/a.Isi1 QNTPBL, a.HRGPBL,

	a.QntRPB/a.Isi1 QNTRBP, a.HRGRPB HRGRBP,

	a.QNTPMK/a.Isi1 QNTPMK,   a.HRGPMK,  

	a.QntRPK/a.Isi1 QNTRPK, a.HRGRPK, 

	a.QNTRPB/a.Isi1 QNTRPB, a.HRGRPB, 

	a.QNTPNJ/a.Isi1 QNTPNJ, a.HRGPNJ, 

	a.QNTRPJ/a.Isi1 QNTRPJ, a.HRGRPJ, 

	a.QNTADI/a.Isi1 QNTADI, a.HRGADI, 

	a.QNTADO/a.Isi1 QNTADO, a.HRGADO, 

	a.QNTUKI/a.Isi1 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi1 QNTUKO, a.HRGUKO, 

	a.QNTTRI/a.Isi1 QNTTRI, a.HRGTRI, 

	a.QNTTRO/a.Isi1 QNTTRO, a.HRGTRO,

	A.QntHPrd/a.ISI1 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi1 QNTIN, a.RPIN, 

	a.QNTOUT/a.Isi1 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi1 SALDOQNT, a.SALDORP,

	'1' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	And a.SALDOQNT/a.Isi1 < 0

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('SVC')Group by KODEGRP))

	order by KODEGRP,KODESUBGRP,a.kodebrg,a.kodegdg

	

	 else 

  If @isi=2

	if @Kodegdg in('G1','R1') 

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi2 QntAwal, a.HRGAWAL, 

	a.QNTPBL/a.Isi2 QNTPBL, a.HRGPBL,

	a.QntRPB/a.Isi2 QNTRBP, a.HRGRPB HRGRBP, 

	a.QNTPMK/a.Isi2 QNTPMK, a.HRGPMK, 

	a.QNTRPK/a.Isi2 QNTRPK, a.HRGRPK, 

	a.QNTPNJ/a.Isi2 QNTPNJ, a.HRGPNJ, 

	a.QNTRPJ/a.Isi2 QNTRPJ, a.HRGRPJ, 

	a.QNTADI/a.Isi2 QNTADI, a.HRGADI, 

	a.QNTADO/a.Isi2 QNTADO, a.HRGADO, 

	a.QNTUKI/a.Isi2 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi2 QNTUKO, a.HRGUKO, 

	a.QNTTRI/a.Isi2 QNTTRI, a.HRGTRI, 

	a.QNTTRO/a.Isi2 QNTTRO, a.HRGTRO,

	A.QntHPrd/a.ISI2 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi2 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi2 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi2 SALDOQNT, a.SALDORP,

	'2' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	And a.SALDOQNT/a.Isi1 < 0

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP=('FG')Group by KODEGRP))

	order by KODEGRP,KODESUBGRP,a.kodebrg,a.kodegdg

	

	else if @Kodegdg not in('G1','R1') and @Kodegdg<>''

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi2 QntAwal, a.HRGAWAL, 

	a.QNTPBL/a.Isi2 QNTPBL, a.HRGPBL,

	a.QntRPB/a.Isi2 QNTRBP, a.HRGRPB HRGRBP, 

	a.QNTPMK/a.Isi2 QNTPMK, a.HRGPMK, 

	a.QNTRPK/a.Isi2 QNTRPK, a.HRGRPK, 

	a.QNTPNJ/a.Isi2 QNTPNJ, a.HRGPNJ, 

	a.QNTRPJ/a.Isi2 QNTRPJ, a.HRGRPJ, 

	a.QNTADI/a.Isi2 QNTADI, a.HRGADI, 

	a.QNTADO/a.Isi2 QNTADO, a.HRGADO, 

	a.QNTUKI/a.Isi2 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi2 QNTUKO, a.HRGUKO, 

	a.QNTTRI/a.Isi2 QNTTRI, a.HRGTRI, 

	a.QNTTRO/a.Isi2 QNTTRO, a.HRGTRO,

	A.QntHPrd/a.ISI2 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi2 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi2 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi2 SALDOQNT, a.SALDORP,

	'2' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	And a.SALDOQNT/a.Isi1 < 0

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('SVC')Group by KODEGRP))

	order by KODEGRP,KODESUBGRP,a.kodebrg,a.kodegdg

	

	else

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi2 QntAwal, a.HRGAWAL, 

	a.QNTPBL/a.Isi2 QNTPBL, a.HRGPBL,

	a.QntRPB/a.Isi2 QNTRBP, a.HRGRPB HRGRBP, 

	a.QNTPMK/a.Isi2 QNTPMK, a.HRGPMK, 

	a.QNTRPK/a.Isi2 QNTRPK, a.HRGRPK, 

	a.QNTPNJ/a.Isi2 QNTPNJ, a.HRGPNJ, 

	a.QNTRPJ/a.Isi2 QNTRPJ, a.HRGRPJ, 

	a.QNTADI/a.Isi2 QNTADI, a.HRGADI, 

	a.QNTADO/a.Isi2 QNTADO, a.HRGADO, 

	a.QNTUKI/a.Isi2 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi2 QNTUKO, a.HRGUKO, 

	a.QNTTRI/a.Isi2 QNTTRI, a.HRGTRI, 

	a.QNTTRO/a.Isi2 QNTTRO, a.HRGTRO,

	A.QntHPrd/a.ISI2 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi2 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi2 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi2 SALDOQNT, a.SALDORP,

	'2' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	And a.SALDOQNT/a.Isi1 < 0

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('SVC')Group by KODEGRP))

	order by KODEGRP,KODESUBGRP,a.kodebrg,a.kodegdg

	

	 else 

	If @isi=3

	select 1


If @MinusHpp=1

If @isi=1

	if @Kodegdg in('G1','R1')

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi1 QntAwal, a.HRGAWAL, 

	a.QNTPBL/a.Isi1 QNTPBL, a.HRGPBL,

	a.QntRPB/a.Isi1 QNTRBP, a.HRGRPB HRGRBP,

	a.QNTPMK/a.Isi1 QNTPMK,   a.HRGPMK,  

	a.QntRPK/a.Isi1 QNTRPK, a.HRGRPK, 

	a.QNTRPB/a.Isi1 QNTRPB, a.HRGRPB, 

	a.QNTPNJ/a.Isi1 QNTPNJ, a.HRGPNJ, 

	a.QNTRPJ/a.Isi1 QNTRPJ, a.HRGRPJ, 

	a.QNTADI/a.Isi1 QNTADI, a.HRGADI, 

	a.QNTADO/a.Isi1 QNTADO, a.HRGADO, 

	a.QNTUKI/a.Isi1 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi1 QNTUKO, a.HRGUKO, 

	a.QNTTRI/a.Isi1 QNTTRI, a.HRGTRI, 

	a.QNTTRO/a.Isi1 QNTTRO, a.HRGTRO,

	A.QntHPrd/a.ISI1 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi1 QNTIN, a.RPIN, 

	a.QNTOUT/a.Isi1 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi1 SALDOQNT, a.SALDORP,

	'1' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	And a.SALDORP < 0

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP=('FG')Group by KODEGRP))

	order by KODEGRP,KODESUBGRP,a.kodebrg,a.kodegdg

	

	else if @Kodegdg not in('G1','R1') and @Kodegdg<>'%'

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp, a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi1 QntAwal, a.HRGAWAL, 

	a.QNTPBL/a.Isi1 QNTPBL, a.HRGPBL,

	a.QntRPB/a.Isi1 QNTRBP, a.HRGRPB HRGRBP,

	a.QNTPMK/a.Isi1 QNTPMK,   a.HRGPMK,  

	a.QntRPK/a.Isi1 QNTRPK, a.HRGRPK, 

	a.QNTRPB/a.Isi1 QNTRPB, a.HRGRPB, 

	a.QNTPNJ/a.Isi1 QNTPNJ, a.HRGPNJ, 

	a.QNTRPJ/a.Isi1 QNTRPJ, a.HRGRPJ, 

	a.QNTADI/a.Isi1 QNTADI, a.HRGADI, 

	a.QNTADO/a.Isi1 QNTADO, a.HRGADO, 

	a.QNTUKI/a.Isi1 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi1 QNTUKO, a.HRGUKO, 

	a.QNTTRI/a.Isi1 QNTTRI, a.HRGTRI, 

	a.QNTTRO/a.Isi1 QNTTRO, a.HRGTRO,

	A.QntHPrd/a.ISI1 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi1 QNTIN, a.RPIN, 

	a.QNTOUT/a.Isi1 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi1 SALDOQNT, a.SALDORP,

	'1' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg

	and (a.KodeGrp like @KodeGrp+'%')

	and a.KODESUBGRP like @KodeSubGrp+'%'

	And a.SALDORP < 0

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('SVC')Group by KODEGRP))

	order by KODEGRP,KODESUBGRP,a.kodebrg,a.kodegdg

	

	else

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi1 QntAwal, a.HRGAWAL, 

	a.QNTPBL/a.Isi1 QNTPBL, a.HRGPBL,

	a.QntRPB/a.Isi1 QNTRBP, a.HRGRPB HRGRBP,

	a.QNTPMK/a.Isi1 QNTPMK,   a.HRGPMK,  

	a.QntRPK/a.Isi1 QNTRPK, a.HRGRPK, 

	a.QNTRPB/a.Isi1 QNTRPB, a.HRGRPB, 

	a.QNTPNJ/a.Isi1 QNTPNJ, a.HRGPNJ, 

	a.QNTRPJ/a.Isi1 QNTRPJ, a.HRGRPJ, 

	a.QNTADI/a.Isi1 QNTADI, a.HRGADI, 

	a.QNTADO/a.Isi1 QNTADO, a.HRGADO, 

	a.QNTUKI/a.Isi1 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi1 QNTUKO, a.HRGUKO, 

	a.QNTTRI/a.Isi1 QNTTRI, a.HRGTRI, 

	a.QNTTRO/a.Isi1 QNTTRO, a.HRGTRO,

	A.QntHPrd/a.ISI1 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi1 QNTIN, a.RPIN, 

	a.QNTOUT/a.Isi1 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi1 SALDOQNT, a.SALDORP,

	'1' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg

	and (a.KodeGrp like @KodeGrp+'%')

	and a.KODESUBGRP like @KodeSubGrp+'%'

	And a.SALDORP < 0

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('SVC')Group by KODEGRP))

	order by KODEGRP,KODESUBGRP,a.kodebrg,a.kodegdg

	

	 else 

  If @isi=2

	if @Kodegdg in('G1','R1') 

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi2 QntAwal, a.HRGAWAL, 

	a.QNTPBL/a.Isi2 QNTPBL, a.HRGPBL,

	a.QntRPB/a.Isi2 QNTRBP, a.HRGRPB HRGRBP, 

	a.QNTPMK/a.Isi2 QNTPMK, a.HRGPMK, 

	a.QNTRPK/a.Isi2 QNTRPK, a.HRGRPK, 

	a.QNTPNJ/a.Isi2 QNTPNJ, a.HRGPNJ, 

	a.QNTRPJ/a.Isi2 QNTRPJ, a.HRGRPJ, 

	a.QNTADI/a.Isi2 QNTADI, a.HRGADI, 

	a.QNTADO/a.Isi2 QNTADO, a.HRGADO, 

	a.QNTUKI/a.Isi2 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi2 QNTUKO, a.HRGUKO, 

	a.QNTTRI/a.Isi2 QNTTRI, a.HRGTRI, 

	a.QNTTRO/a.Isi2 QNTTRO, a.HRGTRO,

	A.QntHPrd/a.ISI2 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi2 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi2 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi2 SALDOQNT, a.SALDORP,

	'2' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg

	and (a.KodeGrp like @KodeGrp+'%')

	and a.KODESUBGRP like @KodeSubGrp+'%'

	And a.SALDORP < 0

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP=('FG')Group by KODEGRP))

	order by KODEGRP,KODESUBGRP,a.kodebrg,a.kodegdg

	

	else if @Kodegdg not in('G1','R1') and @Kodegdg<>''

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi2 QntAwal, a.HRGAWAL, 

	a.QNTPBL/a.Isi2 QNTPBL, a.HRGPBL,

	a.QntRPB/a.Isi2 QNTRBP, a.HRGRPB HRGRBP, 

	a.QNTPMK/a.Isi2 QNTPMK, a.HRGPMK, 

	a.QNTRPK/a.Isi2 QNTRPK, a.HRGRPK, 

	a.QNTPNJ/a.Isi2 QNTPNJ, a.HRGPNJ, 

	a.QNTRPJ/a.Isi2 QNTRPJ, a.HRGRPJ, 

	a.QNTADI/a.Isi2 QNTADI, a.HRGADI, 

	a.QNTADO/a.Isi2 QNTADO, a.HRGADO, 

	a.QNTUKI/a.Isi2 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi2 QNTUKO, a.HRGUKO, 

	a.QNTTRI/a.Isi2 QNTTRI, a.HRGTRI, 

	a.QNTTRO/a.Isi2 QNTTRO, a.HRGTRO,

	A.QntHPrd/a.ISI2 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi2 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi2 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi2 SALDOQNT, a.SALDORP,

	'2' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg

	and( a.KodeGrp like @KodeGrp+'%')

	and a.KODESUBGRP like @KodeSubGrp+'%'

	And a.SALDORP < 0

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('SVC')Group by KODEGRP))

	order by KODEGRP,KODESUBGRP,a.kodebrg,a.kodegdg

	

	else

	Select a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi2 QntAwal, a.HRGAWAL, 

	a.QNTPBL/a.Isi2 QNTPBL, a.HRGPBL,

	a.QntRPB/a.Isi2 QNTRBP, a.HRGRPB HRGRBP, 

	a.QNTPMK/a.Isi2 QNTPMK, a.HRGPMK, 

	a.QNTRPK/a.Isi2 QNTRPK, a.HRGRPK, 

	a.QNTPNJ/a.Isi2 QNTPNJ, a.HRGPNJ, 

	a.QNTRPJ/a.Isi2 QNTRPJ, a.HRGRPJ, 

	a.QNTADI/a.Isi2 QNTADI, a.HRGADI, 

	a.QNTADO/a.Isi2 QNTADO, a.HRGADO, 

	a.QNTUKI/a.Isi2 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi2 QNTUKO, a.HRGUKO, 

	a.QNTTRI/a.Isi2 QNTTRI, a.HRGTRI, 

	a.QNTTRO/a.Isi2 QNTTRO, a.HRGTRO,

	A.QntHPrd/a.ISI2 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi2 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi2 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi2 SALDOQNT, a.SALDORP,

	'2' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg

	and (a.KodeGrp like @KodeGrp+'%')

	and a.KODESUBGRP like @KodeSubGrp+'%'

	And a.SALDORP < 0

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('SVC')Group by KODEGRP))

	order by KODEGRP,KODESUBGRP,a.kodebrg,a.kodegdg

	

	 else 

	If @isi=3

	select 1


else if @Qty1=1 

If @isi=1

	if @Kodegdg in('G1','R1')

    Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi1 QntAwal, a.HRGAWAL, 

	a.QNTPBL/a.Isi1 QNTPBL, a.HRGPBL,

	a.QntRPB/a.Isi1 QNTRBP, a.HRGRPB HRGRBP,

	a.QNTPMK/a.Isi1 QNTPMK,   a.HRGPMK,  

	a.QntRPK/a.Isi1 QNTRPK, a.HRGRPK, 

	a.QNTRPB/a.Isi1 QNTRPB, a.HRGRPB, 

	a.QNTPNJ/a.Isi1 QNTPNJ, a.HRGPNJ, 

	a.QNTRPJ/a.Isi1 QNTRPJ, a.HRGRPJ, 

	a.QNTADI/a.Isi1 QNTADI, a.HRGADI, 

	a.QNTADO/a.Isi1 QNTADO, a.HRGADO, 

	a.QNTUKI/a.Isi1 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi1 QNTUKO, a.HRGUKO, 

	a.QNTTRI/a.Isi1 QNTTRI, a.HRGTRI, 

	a.QNTTRO/a.Isi1 QNTTRO, a.HRGTRO,

	A.QntHPrd/a.ISI1 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi1 QNTIN, a.RPIN, 

	a.QNTOUT/a.Isi1 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi1 SALDOQNT, a.SALDORP,

	'1' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP=('FG')Group by KODEGRP))

	and SALDOQNT/a.Isi1<>0   and  (SALDORP/(SALDOQNT/a.Isi1)) =0               

	--And a.SALDOQNT/a.Isi1 < 0

	order by KODEGRP,KODESUBGRP,a.kodebrg,a.kodegdg

	

	else if @Kodegdg not in('G1','R1') and @Kodegdg<>'%'

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi1 QntAwal, a.HRGAWAL, 

	a.QNTPBL/a.Isi1 QNTPBL, a.HRGPBL,

	a.QntRPB/a.Isi1 QNTRBP, a.HRGRPB HRGRBP,

	a.QNTPMK/a.Isi1 QNTPMK,   a.HRGPMK,  

	a.QntRPK/a.Isi1 QNTRPK, a.HRGRPK, 

	a.QNTRPB/a.Isi1 QNTRPB, a.HRGRPB, 

	a.QNTPNJ/a.Isi1 QNTPNJ, a.HRGPNJ, 

	a.QNTRPJ/a.Isi1 QNTRPJ, a.HRGRPJ, 

	a.QNTADI/a.Isi1 QNTADI, a.HRGADI, 

	a.QNTADO/a.Isi1 QNTADO, a.HRGADO, 

	a.QNTUKI/a.Isi1 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi1 QNTUKO, a.HRGUKO, 

	a.QNTTRI/a.Isi1 QNTTRI, a.HRGTRI, 

	a.QNTTRO/a.Isi1 QNTTRO, a.HRGTRO,

	A.QntHPrd/a.ISI1 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi1 QNTIN, a.RPIN, 

	a.QNTOUT/a.Isi1 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi1 SALDOQNT, a.SALDORP,

	'1' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('SVC')Group by KODEGRP))

	and SALDOQNT/a.Isi1<>0   and  (SALDORP/(SALDOQNT/a.Isi1)) =0                                

	--And a.SALDOQNT/a.Isi1 < 0

	order by KODEGRP,KODESUBGRP,a.kodebrg,a.kodegdg

	

	else

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp, a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi1 QntAwal, a.HRGAWAL, 

	a.QNTPBL/a.Isi1 QNTPBL, a.HRGPBL,

	a.QntRPB/a.Isi1 QNTRBP, a.HRGRPB HRGRBP,

	a.QNTPMK/a.Isi1 QNTPMK,   a.HRGPMK,  

	a.QntRPK/a.Isi1 QNTRPK, a.HRGRPK, 

	a.QNTRPB/a.Isi1 QNTRPB, a.HRGRPB, 

	a.QNTPNJ/a.Isi1 QNTPNJ, a.HRGPNJ, 

	a.QNTRPJ/a.Isi1 QNTRPJ, a.HRGRPJ, 

	a.QNTADI/a.Isi1 QNTADI, a.HRGADI, 

	a.QNTADO/a.Isi1 QNTADO, a.HRGADO, 

	a.QNTUKI/a.Isi1 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi1 QNTUKO, a.HRGUKO, 

	a.QNTTRI/a.Isi1 QNTTRI, a.HRGTRI, 

	a.QNTTRO/a.Isi1 QNTTRO, a.HRGTRO,

	A.QntHPrd/a.ISI1 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi1 QNTIN, a.RPIN, 

	a.QNTOUT/a.Isi1 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi1 SALDOQNT, a.SALDORP,

	'1' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('SVC')Group by KODEGRP))                 

	--And a.SALDOQNT/a.Isi1 < 0

	and SALDOQNT/a.Isi1<>0   and  (SALDORP/(SALDOQNT/a.Isi1)) =0               

	order by KODEGRP,KODESUBGRP,a.kodebrg,a.kodegdg

	

	 else 

  If @isi=2

	if @Kodegdg in('G1','R1')

    Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi2 QntAwal, a.HRGAWAL, 

	a.QNTPBL/a.Isi2 QNTPBL, a.HRGPBL,

	a.QntRPB/a.Isi2 QNTRBP, a.HRGRPB HRGRBP, 

	a.QNTPMK/a.Isi2 QNTPMK, a.HRGPMK, 

	a.QNTRPK/a.Isi2 QNTRPK, a.HRGRPK, 

	a.QNTPNJ/a.Isi2 QNTPNJ, a.HRGPNJ, 

	a.QNTRPJ/a.Isi2 QNTRPJ, a.HRGRPJ, 

	a.QNTADI/a.Isi2 QNTADI, a.HRGADI, 

	a.QNTADO/a.Isi2 QNTADO, a.HRGADO, 

	a.QNTUKI/a.Isi2 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi2 QNTUKO, a.HRGUKO, 

	a.QNTTRI/a.Isi2 QNTTRI, a.HRGTRI, 

	a.QNTTRO/a.Isi2 QNTTRO, a.HRGTRO,

	A.QntHPrd/a.ISI2 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi2 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi2 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi2 SALDOQNT, a.SALDORP,

	'2' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP=('FG')Group by KODEGRP))

	--And a.SALDOQNT/a.Isi1 < 0

	and SALDOQNT/a.Isi2<>0   and  (SALDORP/(SALDOQNT/a.Isi2)) =0               

	order by a.kodebrg,a.kodegdg

	

	else if @Kodegdg not in('G1','R1') and @Kodegdg<>'%'

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi2 QntAwal, a.HRGAWAL, 

	a.QNTPBL/a.Isi2 QNTPBL, a.HRGPBL,

	a.QntRPB/a.Isi2 QNTRBP, a.HRGRPB HRGRBP, 

	a.QNTPMK/a.Isi2 QNTPMK, a.HRGPMK, 

	a.QNTRPK/a.Isi2 QNTRPK, a.HRGRPK, 

	a.QNTPNJ/a.Isi2 QNTPNJ, a.HRGPNJ, 

	a.QNTRPJ/a.Isi2 QNTRPJ, a.HRGRPJ, 

	a.QNTADI/a.Isi2 QNTADI, a.HRGADI, 

	a.QNTADO/a.Isi2 QNTADO, a.HRGADO, 

	a.QNTUKI/a.Isi2 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi2 QNTUKO, a.HRGUKO, 

	a.QNTTRI/a.Isi2 QNTTRI, a.HRGTRI, 

	a.QNTTRO/a.Isi2 QNTTRO, a.HRGTRO,

	A.QntHPrd/a.ISI2 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi2 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi2 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi2 SALDOQNT, a.SALDORP,

	'2' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('SVC')Group by KODEGRP))

	and SALDOQNT/a.Isi2<>0   and  (SALDORP/(SALDOQNT/a.Isi2)) =0               

	--And a.SALDOQNT/a.Isi1 < 0

	order by KODEGRP,KODESUBGRP,a.kodebrg,a.kodegdg

	

	else

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi2 QntAwal, a.HRGAWAL, 

	a.QNTPBL/a.Isi2 QNTPBL, a.HRGPBL,

	a.QntRPB/a.Isi2 QNTRBP, a.HRGRPB HRGRBP, 

	a.QNTPMK/a.Isi2 QNTPMK, a.HRGPMK, 

	a.QNTRPK/a.Isi2 QNTRPK, a.HRGRPK, 

	a.QNTPNJ/a.Isi2 QNTPNJ, a.HRGPNJ, 

	a.QNTRPJ/a.Isi2 QNTRPJ, a.HRGRPJ, 

	a.QNTADI/a.Isi2 QNTADI, a.HRGADI, 

	a.QNTADO/a.Isi2 QNTADO, a.HRGADO, 

	a.QNTUKI/a.Isi2 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi2 QNTUKO, a.HRGUKO, 

	a.QNTTRI/a.Isi2 QNTTRI, a.HRGTRI, 

	a.QNTTRO/a.Isi2 QNTTRO, a.HRGTRO,

	A.QntHPrd/a.ISI2 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi2 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi2 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi2 SALDOQNT, a.SALDORP,

	'2' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('SVC')Group by KODEGRP))

	--And a.SALDOQNT/a.Isi1 < 0

	and SALDOQNT/a.Isi2<>0   and  (SALDORP/(SALDOQNT/a.Isi2)) =0               

	order by KODEGRP,KODESUBGRP,a.kodebrg,a.kodegdg

	

	 else 

	If @isi=3

	select 1


else if @Qty2=1

If @isi=1

	if @Kodegdg in('G1','R1')

    Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi1 QntAwal, a.HRGAWAL, 

	a.QNTPBL/a.Isi1 QNTPBL, a.HRGPBL,

	a.QntRPB/a.Isi1 QNTRBP, a.HRGRPB HRGRBP,

	a.QNTPMK/a.Isi1 QNTPMK,   a.HRGPMK,  

	a.QntRPK/a.Isi1 QNTRPK, a.HRGRPK, 

	a.QNTRPB/a.Isi1 QNTRPB, a.HRGRPB, 

	a.QNTPNJ/a.Isi1 QNTPNJ, a.HRGPNJ, 

	a.QNTRPJ/a.Isi1 QNTRPJ, a.HRGRPJ, 

	a.QNTADI/a.Isi1 QNTADI, a.HRGADI, 

	a.QNTADO/a.Isi1 QNTADO, a.HRGADO, 

	a.QNTUKI/a.Isi1 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi1 QNTUKO, a.HRGUKO, 

	a.QNTTRI/a.Isi1 QNTTRI, a.HRGTRI, 

	a.QNTTRO/a.Isi1 QNTTRO, a.HRGTRO,

	A.QntHPrd/a.ISI1 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi1 QNTIN, a.RPIN, 

	a.QNTOUT/a.Isi1 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi1 SALDOQNT, a.SALDORP,

	'1' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP=('FG')Group by KODEGRP))

	and SALDOQNT/a.Isi1=0   and  (SALDORP/case when(SALDOQNT/a.Isi1)=0 then 1 else (SALDOQNT/a.Isi1) ) <>0               

	--And a.SALDOQNT/a.Isi1 < 0

	order by KODEGRP,KODESUBGRP,a.kodebrg,a.kodegdg

	

	else if @Kodegdg not in('G1','R1') and @Kodegdg<>'%'

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi1 QntAwal, a.HRGAWAL, 

	a.QNTPBL/a.Isi1 QNTPBL, a.HRGPBL,

	a.QntRPB/a.Isi1 QNTRBP, a.HRGRPB HRGRBP,

	a.QNTPMK/a.Isi1 QNTPMK,   a.HRGPMK,  

	a.QntRPK/a.Isi1 QNTRPK, a.HRGRPK, 

	a.QNTRPB/a.Isi1 QNTRPB, a.HRGRPB, 

	a.QNTPNJ/a.Isi1 QNTPNJ, a.HRGPNJ, 

	a.QNTRPJ/a.Isi1 QNTRPJ, a.HRGRPJ, 

	a.QNTADI/a.Isi1 QNTADI, a.HRGADI, 

	a.QNTADO/a.Isi1 QNTADO, a.HRGADO, 

	a.QNTUKI/a.Isi1 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi1 QNTUKO, a.HRGUKO, 

	a.QNTTRI/a.Isi1 QNTTRI, a.HRGTRI, 

	a.QNTTRO/a.Isi1 QNTTRO, a.HRGTRO,

	A.QntHPrd/a.ISI1 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi1 QNTIN, a.RPIN, 

	a.QNTOUT/a.Isi1 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi1 SALDOQNT, a.SALDORP,

	'1' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('SVC')Group by KODEGRP))

	and SALDOQNT/a.Isi1=0   and  (SALDORP/case when(SALDOQNT/a.Isi1)=0 then 1 else (SALDOQNT/a.Isi1) ) <>0               

	--And a.SALDOQNT/a.Isi1 < 0

	order by KODEGRP,KODESUBGRP,a.kodebrg,a.kodegdg

	

	else

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi1 QntAwal, a.HRGAWAL, 

	a.QNTPBL/a.Isi1 QNTPBL, a.HRGPBL,

	a.QntRPB/a.Isi1 QNTRBP, a.HRGRPB HRGRBP,

	a.QNTPMK/a.Isi1 QNTPMK,   a.HRGPMK,  

	a.QntRPK/a.Isi1 QNTRPK, a.HRGRPK, 

	a.QNTRPB/a.Isi1 QNTRPB, a.HRGRPB, 

	a.QNTPNJ/a.Isi1 QNTPNJ, a.HRGPNJ, 

	a.QNTRPJ/a.Isi1 QNTRPJ, a.HRGRPJ, 

	a.QNTADI/a.Isi1 QNTADI, a.HRGADI, 

	a.QNTADO/a.Isi1 QNTADO, a.HRGADO, 

	a.QNTUKI/a.Isi1 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi1 QNTUKO, a.HRGUKO, 

	a.QNTTRI/a.Isi1 QNTTRI, a.HRGTRI, 

	a.QNTTRO/a.Isi1 QNTTRO, a.HRGTRO,

	A.QntHPrd/a.ISI1 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi1 QNTIN, a.RPIN, 

	a.QNTOUT/a.Isi1 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi1 SALDOQNT, a.SALDORP,

	'1' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('SVC')Group by KODEGRP))                 

	--And a.SALDOQNT/a.Isi1 < 0

	and SALDOQNT/a.Isi1=0   and  (SALDORP/case when(SALDOQNT/a.Isi1)=0 then 1 else (SALDOQNT/a.Isi1) ) <>0               

	order by KODEGRP,KODESUBGRP,a.kodebrg,a.kodegdg

	

	 else 

  If @isi=2

	if @Kodegdg in('G1','R1')

    Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi2 QntAwal, a.HRGAWAL, 

	a.QNTPBL/a.Isi2 QNTPBL, a.HRGPBL,

	a.QntRPB/a.Isi2 QNTRBP, a.HRGRPB HRGRBP, 

	a.QNTPMK/a.Isi2 QNTPMK, a.HRGPMK, 

	a.QNTRPK/a.Isi2 QNTRPK, a.HRGRPK, 

	a.QNTPNJ/a.Isi2 QNTPNJ, a.HRGPNJ, 

	a.QNTRPJ/a.Isi2 QNTRPJ, a.HRGRPJ, 

	a.QNTADI/a.Isi2 QNTADI, a.HRGADI, 

	a.QNTADO/a.Isi2 QNTADO, a.HRGADO, 

	a.QNTUKI/a.Isi2 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi2 QNTUKO, a.HRGUKO, 

	a.QNTTRI/a.Isi2 QNTTRI, a.HRGTRI, 

	a.QNTTRO/a.Isi2 QNTTRO, a.HRGTRO,

	A.QntHPrd/a.ISI2 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi2 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi2 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi2 SALDOQNT, a.SALDORP,

	'2' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP=('FG')Group by KODEGRP))

	--And a.SALDOQNT/a.Isi1 < 0

	and SALDOQNT/a.Isi2=0   and  (SALDORP/case when(SALDOQNT/a.Isi2)=0 then 1 else (SALDOQNT/a.Isi2) ) <>0               

	order by KODEGRP,KODESUBGRP,a.kodebrg,a.kodegdg

	

	else if @Kodegdg not in('G1','R1') and @Kodegdg<>'%'

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi2 QntAwal, a.HRGAWAL, 

	a.QNTPBL/a.Isi2 QNTPBL, a.HRGPBL,

	a.QntRPB/a.Isi2 QNTRBP, a.HRGRPB HRGRBP, 

	a.QNTPMK/a.Isi2 QNTPMK, a.HRGPMK, 

	a.QNTRPK/a.Isi2 QNTRPK, a.HRGRPK, 

	a.QNTPNJ/a.Isi2 QNTPNJ, a.HRGPNJ, 

	a.QNTRPJ/a.Isi2 QNTRPJ, a.HRGRPJ, 

	a.QNTADI/a.Isi2 QNTADI, a.HRGADI, 

	a.QNTADO/a.Isi2 QNTADO, a.HRGADO, 

	a.QNTUKI/a.Isi2 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi2 QNTUKO, a.HRGUKO, 

	a.QNTTRI/a.Isi2 QNTTRI, a.HRGTRI, 

	a.QNTTRO/a.Isi2 QNTTRO, a.HRGTRO,

	A.QntHPrd/a.ISI2 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi2 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi2 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi2 SALDOQNT, a.SALDORP,

	'2' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('SVC')Group by KODEGRP))

	and SALDOQNT/a.Isi2=0   and  (SALDORP/case when(SALDOQNT/a.Isi2)=0 then 1 else (SALDOQNT/a.Isi2) ) <>0               

	--And a.SALDOQNT/a.Isi1 < 0

	order by KODEGRP,KODESUBGRP,a.kodebrg,a.kodegdg

	

	else

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi2 QntAwal, a.HRGAWAL, 

	a.QNTPBL/a.Isi2 QNTPBL, a.HRGPBL,

	a.QntRPB/a.Isi2 QNTRBP, a.HRGRPB HRGRBP, 

	a.QNTPMK/a.Isi2 QNTPMK, a.HRGPMK, 

	a.QNTRPK/a.Isi2 QNTRPK, a.HRGRPK, 

	a.QNTPNJ/a.Isi2 QNTPNJ, a.HRGPNJ, 

	a.QNTRPJ/a.Isi2 QNTRPJ, a.HRGRPJ, 

	a.QNTADI/a.Isi2 QNTADI, a.HRGADI, 

	a.QNTADO/a.Isi2 QNTADO, a.HRGADO, 

	a.QNTUKI/a.Isi2 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi2 QNTUKO, a.HRGUKO, 

	a.QNTTRI/a.Isi2 QNTTRI, a.HRGTRI, 

	a.QNTTRO/a.Isi2 QNTTRO, a.HRGTRO,

	A.QntHPrd/a.ISI2 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi2 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi2 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi2 SALDOQNT, a.SALDORP,

	'2' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('SVC')Group by KODEGRP))

	--And a.SALDOQNT/a.Isi1 < 0

	and SALDOQNT/a.Isi2=0   and  (SALDORP/case when(SALDOQNT/a.Isi2)=0 then 1 else (SALDOQNT/a.Isi2) ) <>0               

	order by KODEGRP,KODESUBGRP,a.kodebrg,a.kodegdg

	

	 else 

	If @isi=3

	select 1;

-- sp_reportStockQtyRprek
CREATE PROCEDURE IF NOT EXISTS sp_reportStockQtyRprek AS -- SET REMOVEDCase when @kodegdg in ('','-') then '%' else @kodegdg 

if @minus=0

if @Pilih=0 

 If @isi=1

	if @Kodegdg In('G1','R1')

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi1 QntAwal, a.HRGAWAL, 

	(a.QNTPBL/a.Isi1)+(a.QNTRPJ/a.Isi1)+(a.QNTADI/a.Isi1)+(a.QNTTRI/a.Isi1)+(a.QNTRPK/a.Isi1) Qntmasuk,

	(a.HRGPBL + a.HRGRPJ +  a.HRGADI + a.HRGTRI + a.HRGRPK) HrgMasuk,

	(a.QNTPNJ/a.Isi1)+(a.QntRPB/a.Isi1)+(a.QNTADO/a.Isi1)+(a.QNTTRO/a.Isi1)+(a.QNTPMK/a.Isi1) QntKeluar, 

	(a.HRGPNJ+a.HRGRPB+a.HRGADO+a.HRGTRO+a.HRGPMK) HrgKeluar, 

	a.QNTUKI/a.Isi1 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi1 QNTUKO, a.HRGUKO, 

	A.QntHPrd/a.Isi1 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi1 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi1 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi1 SALDOQNT, a.SALDORP,

	'1' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg	

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP=('FG')Group by KODEGRP))

	order by KODEGRP,KODESUBGRP,a.kodebrg,A.KODEGDG

	

	else if @Kodegdg not in('G1','R1') and @Kodegdg<>'%'

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi1 QntAwal, a.HRGAWAL, 

	(a.QNTPBL/a.Isi1)+(a.QNTRPJ/a.Isi1)+(a.QNTADI/a.Isi1)+(a.QNTTRI/a.Isi1)+(a.QNTRPK/a.Isi1) Qntmasuk,

	(a.HRGPBL + a.HRGRPJ +  a.HRGADI + a.HRGTRI + a.HRGRPK) HrgMasuk,

	(a.QNTPNJ/a.Isi1)+(a.QntRPB/a.Isi1)+(a.QNTADO/a.Isi1)+(a.QNTTRO/a.Isi1)+(a.QNTPMK/a.Isi1) QntKeluar, 

	(a.HRGPNJ+a.HRGRPB+a.HRGADO+a.HRGTRO+a.HRGPMK) HrgKeluar, 

	a.QNTUKI/a.Isi1 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi1 QNTUKO, a.HRGUKO, 

	A.QntHPrd/a.Isi1 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi1 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi1 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi1 SALDOQNT, a.SALDORP,

	'1' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg	

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('FG','SVC')Group by KODEGRP))

	order by KODEGRP,KODESUBGRP,a.kodebrg,A.KODEGDG

	

	else

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi1 QntAwal, a.HRGAWAL, 

	(a.QNTPBL/a.Isi1)+(a.QNTRPJ/a.Isi1)+(a.QNTADI/a.Isi1)+(a.QNTTRI/a.Isi1)+(a.QNTRPK/a.Isi1) Qntmasuk,

	(a.HRGPBL + a.HRGRPJ +  a.HRGADI + a.HRGTRI + a.HRGRPK) HrgMasuk,

	(a.QNTPNJ/a.Isi1)+(a.QntRPB/a.Isi1)+(a.QNTADO/a.Isi1)+(a.QNTTRO/a.Isi1)+(a.QNTPMK/a.Isi1) QntKeluar, 

	(a.HRGPNJ+a.HRGRPB+a.HRGADO+a.HRGTRO+a.HRGPMK) HrgKeluar, 

	a.QNTUKI/a.Isi1 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi1 QNTUKO, a.HRGUKO, 

	A.QntHPrd/a.Isi1 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi1 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi1 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi1 SALDOQNT, a.SALDORP,

	'1' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg	

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('SVC')Group by KODEGRP))

	order by KODEGRP,KODESUBGRP,a.kodebrg,A.KODEGDG

	

	 else 

	If @isi=2

	if @Kodegdg In('G1','R1')

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi2 QntAwal, a.HRGAWAL, 

	(a.QNTPBL/a.Isi2)+(a.QNTRPJ/a.Isi2)+(a.QNTADI/a.Isi2)+(a.QNTTRI/a.Isi2)+(a.QNTRPK/a.Isi2) Qntmasuk,

	(a.HRGPBL + a.HRGRPJ +  a.HRGADI + a.HRGTRI + a.HRGRPK) HrgMasuk,

	(a.QNTPNJ/a.Isi2)+(a.QntRPB/a.Isi2)+(a.QNTADO/a.Isi2)+(a.QNTTRO/a.Isi2)+(a.QNTPMK/a.Isi2) QntKeluar, 

	(a.HRGPNJ+a.HRGRPB+a.HRGADO+a.HRGTRO+a.HRGPMK) HrgKeluar, 

	a.QNTUKI/a.Isi2 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi2 QNTUKO, a.HRGUKO, 

	A.QntHPrd/a.ISI2 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi2 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi2 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi2 SALDOQNT, a.SALDORP,

	'2' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg 

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP=('FG')Group by KODEGRP))

	order by KODEGRP,KODESUBGRP,a.kodebrg,A.KODEGDG

	

	else if  @Kodegdg not in('G1','R1') and @Kodegdg<>''

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi2 QntAwal, a.HRGAWAL, 

	(a.QNTPBL/a.Isi2)+(a.QNTRPJ/a.Isi2)+(a.QNTADI/a.Isi2)+(a.QNTTRI/a.Isi2)+(a.QNTRPK/a.Isi2) Qntmasuk,

	(a.HRGPBL + a.HRGRPJ +  a.HRGADI + a.HRGTRI + a.HRGRPK) HrgMasuk,

	(a.QNTPNJ/a.Isi2)+(a.QntRPB/a.Isi2)+(a.QNTADO/a.Isi2)+(a.QNTTRO/a.Isi2)+(a.QNTPMK/a.Isi2) QntKeluar, 

	(a.HRGPNJ+a.HRGRPB+a.HRGADO+a.HRGTRO+a.HRGPMK) HrgKeluar, 

	a.QNTUKI/a.Isi2 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi2 QNTUKO, a.HRGUKO, 

	A.QntHPrd/a.ISI2 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi2 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi2 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi2 SALDOQNT, a.SALDORP,

	'2' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg 

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('FG','SVC')Group by KODEGRP))

	order by KODEGRP,KODESUBGRP,a.kodebrg,A.KODEGDG

	

	else

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi2 QntAwal, a.HRGAWAL, 

	(a.QNTPBL/a.Isi2)+(a.QNTRPJ/a.Isi2)+(a.QNTADI/a.Isi2)+(a.QNTTRI/a.Isi2)+(a.QNTRPK/a.Isi2) Qntmasuk,

	(a.HRGPBL + a.HRGRPJ +  a.HRGADI + a.HRGTRI + a.HRGRPK) HrgMasuk,

	(a.QNTPNJ/a.Isi2)+(a.QntRPB/a.Isi2)+(a.QNTADO/a.Isi2)+(a.QNTTRO/a.Isi2)+(a.QNTPMK/a.Isi2) QntKeluar, 

	(a.HRGPNJ+a.HRGRPB+a.HRGADO+a.HRGTRO+a.HRGPMK) HrgKeluar, 

	a.QNTUKI/a.Isi2 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi2 QNTUKO, a.HRGUKO, 

	A.QntHPrd/a.ISI2 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi2 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi2 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi2 SALDOQNT, a.SALDORP,

	'2' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg 

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('SVC')Group by KODEGRP))

	order by KODEGRP,KODESUBGRP,a.kodebrg,A.KODEGDG

	

	 else 

	If @isi=3

	select 1


else if @Pilih=1 

 If @isi=1

	if @Kodegdg In('G1','R1')

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi1 QntAwal, a.HRGAWAL, 

	(a.QNTPBL/a.Isi1)+(a.QNTRPJ/a.Isi1)+(a.QNTADI/a.Isi1)+(a.QNTTRI/a.Isi1)+(a.QNTRPK/a.Isi1) Qntmasuk,

	(a.HRGPBL + a.HRGRPJ +  a.HRGADI + a.HRGTRI + a.HRGRPK) HrgMasuk,

	(a.QNTPNJ/a.Isi1)+(a.QntRPB/a.Isi1)+(a.QNTADO/a.Isi1)+(a.QNTTRO/a.Isi1)+(a.QNTPMK/a.Isi1) QntKeluar, 

	(a.HRGPNJ+a.HRGRPB+a.HRGADO+a.HRGTRO+a.HRGPMK) HrgKeluar, 

	a.QNTUKI/a.Isi1 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi1 QNTUKO, a.HRGUKO, 

	A.QntHPrd/a.Isi1 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi1 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi1 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi1 SALDOQNT, a.SALDORP,

	'1' 

	from vwReportKartuBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg	

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP=('FG')Group by KODEGRP))

	order by KODEGRP,KODESUBGRP,a.kodebrg,A.KODEGDG

	

	else if @Kodegdg not in('G1','R1') and @Kodegdg<>'%'

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi1 QntAwal, a.HRGAWAL, 

	(a.QNTPBL/a.Isi1)+(a.QNTRPJ/a.Isi1)+(a.QNTADI/a.Isi1)+(a.QNTTRI/a.Isi1)+(a.QNTRPK/a.Isi1) Qntmasuk,

	(a.HRGPBL + a.HRGRPJ +  a.HRGADI + a.HRGTRI + a.HRGRPK) HrgMasuk,

	(a.QNTPNJ/a.Isi1)+(a.QntRPB/a.Isi1)+(a.QNTADO/a.Isi1)+(a.QNTTRO/a.Isi1)+(a.QNTPMK/a.Isi1) QntKeluar, 

	(a.HRGPNJ+a.HRGRPB+a.HRGADO+a.HRGTRO+a.HRGPMK) HrgKeluar, 

	a.QNTUKI/a.Isi1 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi1 QNTUKO, a.HRGUKO, 

	A.QntHPrd/a.Isi1 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi1 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi1 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi1 SALDOQNT, a.SALDORP,

	'1' 

	from vwReportKartuBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg	

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('FG','SVC')Group by KODEGRP))

	order by KODEGRP,KODESUBGRP,a.kodebrg,A.KODEGDG

	

	else

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi1 QntAwal, a.HRGAWAL, 

	(a.QNTPBL/a.Isi1)+(a.QNTRPJ/a.Isi1)+(a.QNTADI/a.Isi1)+(a.QNTTRI/a.Isi1)+(a.QNTRPK/a.Isi1) Qntmasuk,

	(a.HRGPBL + a.HRGRPJ +  a.HRGADI + a.HRGTRI + a.HRGRPK) HrgMasuk,

	(a.QNTPNJ/a.Isi1)+(a.QntRPB/a.Isi1)+(a.QNTADO/a.Isi1)+(a.QNTTRO/a.Isi1)+(a.QNTPMK/a.Isi1) QntKeluar, 

	(a.HRGPNJ+a.HRGRPB+a.HRGADO+a.HRGTRO+a.HRGPMK) HrgKeluar, 

	a.QNTUKI/a.Isi1 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi1 QNTUKO, a.HRGUKO, 

	A.QntHPrd/a.Isi1 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi1 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi1 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi1 SALDOQNT, a.SALDORP,

	'1' 

	from vwReportKartuBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg	

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('SVC')Group by KODEGRP))

	order by KODEGRP,KODESUBGRP,a.kodebrg,A.KODEGDG

	

	 else 

	If @isi=2

	if @Kodegdg In('G1','R1')

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi2 QntAwal, a.HRGAWAL, 

	(a.QNTPBL/a.Isi2)+(a.QNTRPJ/a.Isi2)+(a.QNTADI/a.Isi2)+(a.QNTTRI/a.Isi2)+(a.QNTRPK/a.Isi2) Qntmasuk,

	(a.HRGPBL + a.HRGRPJ +  a.HRGADI + a.HRGTRI + a.HRGRPK) HrgMasuk,

	(a.QNTPNJ/a.Isi2)+(a.QntRPB/a.Isi2)+(a.QNTADO/a.Isi2)+(a.QNTTRO/a.Isi2)+(a.QNTPMK/a.Isi2) QntKeluar, 

	(a.HRGPNJ+a.HRGRPB+a.HRGADO+a.HRGTRO+a.HRGPMK) HrgKeluar, 

	a.QNTUKI/a.Isi2 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi2 QNTUKO, a.HRGUKO, 

	A.QntHPrd/a.ISI2 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi2 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi2 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi2 SALDOQNT, a.SALDORP,

	'2' 

	from vwReportKartuBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg 

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP=('FG')Group by KODEGRP))

	order by KODEGRP,KODESUBGRP,a.kodebrg,A.KODEGDG

	

	else if  @Kodegdg not in('G1','R1') and @Kodegdg<>''

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi2 QntAwal, a.HRGAWAL, 

	(a.QNTPBL/a.Isi2)+(a.QNTRPJ/a.Isi2)+(a.QNTADI/a.Isi2)+(a.QNTTRI/a.Isi2)+(a.QNTRPK/a.Isi2) Qntmasuk,

	(a.HRGPBL + a.HRGRPJ +  a.HRGADI + a.HRGTRI + a.HRGRPK) HrgMasuk,

	(a.QNTPNJ/a.Isi2)+(a.QntRPB/a.Isi2)+(a.QNTADO/a.Isi2)+(a.QNTTRO/a.Isi2)+(a.QNTPMK/a.Isi2) QntKeluar, 

	(a.HRGPNJ+a.HRGRPB+a.HRGADO+a.HRGTRO+a.HRGPMK) HrgKeluar, 

	a.QNTUKI/a.Isi2 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi2 QNTUKO, a.HRGUKO, 

	A.QntHPrd/a.ISI2 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi2 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi2 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi2 SALDOQNT, a.SALDORP,

	'2' 

	from vwReportKartuBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg 

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('FG','SVC')Group by KODEGRP))

	order by KODEGRP,KODESUBGRP,a.kodebrg,A.KODEGDG

	

	else

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi2 QntAwal, a.HRGAWAL, 

	(a.QNTPBL/a.Isi2)+(a.QNTRPJ/a.Isi2)+(a.QNTADI/a.Isi2)+(a.QNTTRI/a.Isi2)+(a.QNTRPK/a.Isi2) Qntmasuk,

	(a.HRGPBL + a.HRGRPJ +  a.HRGADI + a.HRGTRI + a.HRGRPK) HrgMasuk,

	(a.QNTPNJ/a.Isi2)+(a.QntRPB/a.Isi2)+(a.QNTADO/a.Isi2)+(a.QNTTRO/a.Isi2)+(a.QNTPMK/a.Isi2) QntKeluar, 

	(a.HRGPNJ+a.HRGRPB+a.HRGADO+a.HRGTRO+a.HRGPMK) HrgKeluar, 

	a.QNTUKI/a.Isi2 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi2 QNTUKO, a.HRGUKO, 

	A.QntHPrd/a.ISI2 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi2 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi2 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi2 SALDOQNT, a.SALDORP,

	'2' 

	from vwReportKartuBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg 

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('SVC')Group by KODEGRP))

	order by KODEGRP,KODESUBGRP,a.kodebrg,A.KODEGDG

	

	 else 

	If @isi=3

	select 1


else if @Pilih=2 

 If @isi=1

	if @Kodegdg In('G1','R1')

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi1 QntAwal, a.HRGAWAL, 

	(a.QNTPBL/a.Isi1)+(a.QNTRPJJ/a.Isi1)+(a.QNTADI/a.Isi1)+(a.QNTTRI/a.Isi1)+(a.QNTRPK/a.Isi1) Qntmasuk,

	(a.HRGPBL + a.HRGRPJJ +  a.HRGADI + a.HRGTRI + a.HRGRPK) HrgMasuk,

	(a.QNTPNJJ/a.Isi1)+(a.QntRPB/a.Isi1)+(a.QNTADO/a.Isi1)+(a.QNTTRO/a.Isi1)+(a.QNTPMK/a.Isi1) QntKeluar, 

	(a.HRGPNJJ+a.HRGRPB+a.HRGADO+a.HRGTRO+a.HRGPMK) HrgKeluar, 

	a.QNTUKI/a.Isi1 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi1 QNTUKO, a.HRGUKO, 

	A.QntHPrd/a.Isi1 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi1 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi1 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi1 SALDOQNT, a.SALDORP,

	'1' 

	from vwReportKartuBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg	

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP=('FG')Group by KODEGRP))

	order by KODEGRP,KODESUBGRP,a.kodebrg,A.KODEGDG

	

	else if @Kodegdg not in('G1','R1') and @Kodegdg<>'%'

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi1 QntAwal, a.HRGAWAL, 

	(a.QNTPBL/a.Isi1)+(a.QNTRPJJ/a.Isi1)+(a.QNTADI/a.Isi1)+(a.QNTTRI/a.Isi1)+(a.QNTRPK/a.Isi1) Qntmasuk,

	(a.HRGPBL + a.HRGRPJJ +  a.HRGADI + a.HRGTRI + a.HRGRPK) HrgMasuk,

	(a.QNTPNJJ/a.Isi1)+(a.QntRPB/a.Isi1)+(a.QNTADO/a.Isi1)+(a.QNTTRO/a.Isi1)+(a.QNTPMK/a.Isi1) QntKeluar, 

	(a.HRGPNJJ+a.HRGRPB+a.HRGADO+a.HRGTRO+a.HRGPMK) HrgKeluar, 

	a.QNTUKI/a.Isi1 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi1 QNTUKO, a.HRGUKO, 

	A.QntHPrd/a.Isi1 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi1 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi1 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi1 SALDOQNT, a.SALDORP,

	'1' 

	from vwReportKartuBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg	

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('FG','SVC')Group by KODEGRP))

	order by KODEGRP,KODESUBGRP,a.kodebrg,A.KODEGDG

	

	else

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi1 QntAwal, a.HRGAWAL, 

	(a.QNTPBL/a.Isi1)+(a.QNTRPJJ/a.Isi1)+(a.QNTADI/a.Isi1)+(a.QNTTRI/a.Isi1)+(a.QNTRPK/a.Isi1) Qntmasuk,

	(a.HRGPBL + a.HRGRPJJ +  a.HRGADI + a.HRGTRI + a.HRGRPK) HrgMasuk,

	(a.QNTPNJJ/a.Isi1)+(a.QntRPB/a.Isi1)+(a.QNTADO/a.Isi1)+(a.QNTTRO/a.Isi1)+(a.QNTPMK/a.Isi1) QntKeluar, 

	(a.HRGPNJJ+a.HRGRPB+a.HRGADO+a.HRGTRO+a.HRGPMK) HrgKeluar, 

	a.QNTUKI/a.Isi1 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi1 QNTUKO, a.HRGUKO, 

	A.QntHPrd/a.Isi1 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi1 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi1 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi1 SALDOQNT, a.SALDORP,

	'1' 

	from vwReportKartuBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg	

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('SVC')Group by KODEGRP))

	order by KODEGRP,KODESUBGRP,a.kodebrg,A.KODEGDG

	

	 else 

	If @isi=2

	if @Kodegdg In('G1','R1')

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi2 QntAwal, a.HRGAWAL, 

	(a.QNTPBL/a.Isi2)+(a.QNTRPJJ/a.Isi2)+(a.QNTADI/a.Isi2)+(a.QNTTRI/a.Isi2)+(a.QNTRPK/a.Isi2) Qntmasuk,

	(a.HRGPBL + a.HRGRPJJ +  a.HRGADI + a.HRGTRI + a.HRGRPK) HrgMasuk,

	(a.QNTPNJJ/a.Isi2)+(a.QntRPB/a.Isi2)+(a.QNTADO/a.Isi2)+(a.QNTTRO/a.Isi2)+(a.QNTPMK/a.Isi2) QntKeluar, 

	(a.HRGPNJJ+a.HRGRPB+a.HRGADO+a.HRGTRO+a.HRGPMK) HrgKeluar, 

	a.QNTUKI/a.Isi2 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi2 QNTUKO, a.HRGUKO, 

	A.QntHPrd/a.ISI2 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi2 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi2 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi2 SALDOQNT, a.SALDORP,

	'2' 

	from vwReportKartuBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg 

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP=('FG')Group by KODEGRP))

	order by KODEGRP,KODESUBGRP,a.kodebrg,A.KODEGDG

	

	else if  @Kodegdg not in('G1','R1') and @Kodegdg<>''

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi2 QntAwal, a.HRGAWAL, 

	(a.QNTPBL/a.Isi2)+(a.QNTRPJJ/a.Isi2)+(a.QNTADI/a.Isi2)+(a.QNTTRI/a.Isi2)+(a.QNTRPK/a.Isi2) Qntmasuk,

	(a.HRGPBL + a.HRGRPJJ +  a.HRGADI + a.HRGTRI + a.HRGRPK) HrgMasuk,

	(a.QNTPNJJ/a.Isi2)+(a.QntRPB/a.Isi2)+(a.QNTADO/a.Isi2)+(a.QNTTRO/a.Isi2)+(a.QNTPMK/a.Isi2) QntKeluar, 

	(a.HRGPNJJ+a.HRGRPB+a.HRGADO+a.HRGTRO+a.HRGPMK) HrgKeluar, 

	a.QNTUKI/a.Isi2 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi2 QNTUKO, a.HRGUKO, 

	A.QntHPrd/a.ISI2 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi2 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi2 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi2 SALDOQNT, a.SALDORP,

	'2' 

	from vwReportKartuBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg 

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('FG','SVC')Group by KODEGRP))

	order by KODEGRP,KODESUBGRP,a.kodebrg,A.KODEGDG

	

	else

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi2 QntAwal, a.HRGAWAL, 

	(a.QNTPBL/a.Isi2)+(a.QNTRPJJ/a.Isi2)+(a.QNTADI/a.Isi2)+(a.QNTTRI/a.Isi2)+(a.QNTRPK/a.Isi2) Qntmasuk,

	(a.HRGPBL + a.HRGRPJJ +  a.HRGADI + a.HRGTRI + a.HRGRPK) HrgMasuk,

	(a.QNTPNJJ/a.Isi2)+(a.QntRPB/a.Isi2)+(a.QNTADO/a.Isi2)+(a.QNTTRO/a.Isi2)+(a.QNTPMK/a.Isi2) QntKeluar, 

	(a.HRGPNJJ+a.HRGRPB+a.HRGADO+a.HRGTRO+a.HRGPMK) HrgKeluar, 

	a.QNTUKI/a.Isi2 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi2 QNTUKO, a.HRGUKO, 

	A.QntHPrd/a.ISI2 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi2 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi2 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi2 SALDOQNT, a.SALDORP,

	'2' 

	from vwReportKartuBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg 

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('SVC')Group by KODEGRP))

	order by KODEGRP,KODESUBGRP,a.kodebrg,A.KODEGDG

	

	 else 

	If @isi=3

	select 1


if @minus=1

If @isi=1

	if @Kodegdg In('G1','R1')

   Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi1 QntAwal, a.HRGAWAL, 

	(a.QNTPBL/a.Isi1)+(a.QNTRPJ/a.Isi1)+(a.QNTADI/a.Isi1)+(a.QNTTRI/a.Isi1)+(a.QNTRPK/a.Isi1) Qntmasuk,

	(a.HRGPBL + a.HRGRPJ +  a.HRGADI + a.HRGTRI + a.HRGRPK) HrgMasuk,

	(a.QNTPNJ/a.Isi1)+(a.QntRPB/a.Isi1)+(a.QNTADO/a.Isi1)+(a.QNTTRO/a.Isi1)+(a.QNTPMK/a.Isi1) QntKeluar, 

	(a.HRGPNJ+a.HRGRPB+a.HRGADO+a.HRGTRO+a.HRGPMK) HrgKeluar, 

	a.QNTUKI/a.Isi1 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi1 QNTUKO, a.HRGUKO, 

	A.QntHPrd/a.Isi1 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi1 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi1 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi1 SALDOQNT, a.SALDORP,

	'1' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg	

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	And a.SALDOQNT/a.Isi1 < 0

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP=('FG')Group by KODEGRP))

	

	order by KODEGRP,KODESUBGRP,a.kodebrg,A.KODEGDG

	

	else if @Kodegdg not in('G1','R1') and @Kodegdg<>'%'

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi1 QntAwal, a.HRGAWAL, 

	(a.QNTPBL/a.Isi1)+(a.QNTRPJ/a.Isi1)+(a.QNTADI/a.Isi1)+(a.QNTTRI/a.Isi1)+(a.QNTRPK/a.Isi1) Qntmasuk,

	(a.HRGPBL + a.HRGRPJ +  a.HRGADI + a.HRGTRI + a.HRGRPK) HrgMasuk,

	(a.QNTPNJ/a.Isi1)+(a.QntRPB/a.Isi1)+(a.QNTADO/a.Isi1)+(a.QNTTRO/a.Isi1)+(a.QNTPMK/a.Isi1) QntKeluar, 

	(a.HRGPNJ+a.HRGRPB+a.HRGADO+a.HRGTRO+a.HRGPMK) HrgKeluar, 

	a.QNTUKI/a.Isi1 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi1 QNTUKO, a.HRGUKO, 

	A.QntHPrd/a.Isi1 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi1 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi1 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi1 SALDOQNT, a.SALDORP,

	'1' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg	

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	And a.SALDOQNT/a.Isi1 < 0

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('FG','SVC')Group by KODEGRP))

	order by KODEGRP,KODESUBGRP,a.kodebrg,A.KODEGDG

	

	else

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi1 QntAwal, a.HRGAWAL, 

	(a.QNTPBL/a.Isi1)+(a.QNTRPJ/a.Isi1)+(a.QNTADI/a.Isi1)+(a.QNTTRI/a.Isi1)+(a.QNTRPK/a.Isi1) Qntmasuk,

	(a.HRGPBL + a.HRGRPJ +  a.HRGADI + a.HRGTRI + a.HRGRPK) HrgMasuk,

	(a.QNTPNJ/a.Isi1)+(a.QntRPB/a.Isi1)+(a.QNTADO/a.Isi1)+(a.QNTTRO/a.Isi1)+(a.QNTPMK/a.Isi1) QntKeluar, 

	(a.HRGPNJ+a.HRGRPB+a.HRGADO+a.HRGTRO+a.HRGPMK) HrgKeluar, 

	a.QNTUKI/a.Isi1 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi1 QNTUKO, a.HRGUKO, 

	A.QntHPrd/a.Isi1 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi1 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi1 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi1 SALDOQNT, a.SALDORP,

	'1' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg	

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	And a.SALDOQNT/a.Isi1 < 0

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('SVC')Group by KODEGRP))

	order by KODEGRP,KODESUBGRP,a.kodebrg,A.KODEGDG

	

	 else 

	If @isi=2

	if @Kodegdg In('G1','R1')

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi2 QntAwal, a.HRGAWAL, 

	(a.QNTPBL/a.Isi2)+(a.QNTRPJ/a.Isi2)+(a.QNTADI/a.Isi2)+(a.QNTTRI/a.Isi2)+(a.QNTRPK/a.Isi2) Qntmasuk,

	(a.HRGPBL + a.HRGRPJ +  a.HRGADI + a.HRGTRI + a.HRGRPK) HrgMasuk,

	(a.QNTPNJ/a.Isi2)+(a.QntRPB/a.Isi2)+(a.QNTADO/a.Isi2)+(a.QNTTRO/a.Isi2)+(a.QNTPMK/a.Isi2) QntKeluar, 

	(a.HRGPNJ+a.HRGRPB+a.HRGADO+a.HRGTRO+a.HRGPMK) HrgKeluar, 

	a.QNTUKI/a.Isi2 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi2 QNTUKO, a.HRGUKO, 

	A.QntHPrd/a.ISI2 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi2 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi2 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi2 SALDOQNT, a.SALDORP,

	'2' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg 

	and a.KodeGrp like @KodeGrp+'%'

	And a.SALDOQNT/a.Isi1 < 0

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP=('FG')Group by KODEGRP))

	order by KODEGRP,KODESUBGRP,a.kodebrg,A.KODEGDG

	

	else if @Kodegdg not in('G1','R1') and @Kodegdg<>'%'

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi2 QntAwal, a.HRGAWAL, 

	(a.QNTPBL/a.Isi2)+(a.QNTRPJ/a.Isi2)+(a.QNTADI/a.Isi2)+(a.QNTTRI/a.Isi2)+(a.QNTRPK/a.Isi2) Qntmasuk,

	(a.HRGPBL + a.HRGRPJ +  a.HRGADI + a.HRGTRI + a.HRGRPK) HrgMasuk,

	(a.QNTPNJ/a.Isi2)+(a.QntRPB/a.Isi2)+(a.QNTADO/a.Isi2)+(a.QNTTRO/a.Isi2)+(a.QNTPMK/a.Isi2) QntKeluar, 

	(a.HRGPNJ+a.HRGRPB+a.HRGADO+a.HRGTRO+a.HRGPMK) HrgKeluar, 

	a.QNTUKI/a.Isi2 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi2 QNTUKO, a.HRGUKO, 

	A.QntHPrd/a.ISI2 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi2 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi2 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi2 SALDOQNT, a.SALDORP,

	'2' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg 

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	And a.SALDOQNT/a.Isi1 < 0

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('FG','SVC')Group by KODEGRP))

	order by KODEGRP,KODESUBGRP,a.kodebrg,A.KODEGDG

	

	else

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi2 QntAwal, a.HRGAWAL, 

	(a.QNTPBL/a.Isi2)+(a.QNTRPJ/a.Isi2)+(a.QNTADI/a.Isi2)+(a.QNTTRI/a.Isi2)+(a.QNTRPK/a.Isi2) Qntmasuk,

	(a.HRGPBL + a.HRGRPJ +  a.HRGADI + a.HRGTRI + a.HRGRPK) HrgMasuk,

	(a.QNTPNJ/a.Isi2)+(a.QntRPB/a.Isi2)+(a.QNTADO/a.Isi2)+(a.QNTTRO/a.Isi2)+(a.QNTPMK/a.Isi2) QntKeluar, 

	(a.HRGPNJ+a.HRGRPB+a.HRGADO+a.HRGTRO+a.HRGPMK) HrgKeluar, 

	a.QNTUKI/a.Isi2 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi2 QNTUKO, a.HRGUKO, 

	A.QntHPrd/a.ISI2 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi2 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi2 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi2 SALDOQNT, a.SALDORP,

	'2' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg 

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	And a.SALDOQNT/a.Isi1 < 0

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('SVC')Group by KODEGRP))

	order by KODEGRP,KODESUBGRP,a.kodebrg,A.KODEGDG

	

	 else 

	If @isi=3

	select 1


if @MinusHPP=1

If @isi=1

	if @Kodegdg In('G1','R1')

   Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi1 QntAwal, a.HRGAWAL, 

	(a.QNTPBL/a.Isi1)+(a.QNTRPJ/a.Isi1)+(a.QNTADI/a.Isi1)+(a.QNTTRI/a.Isi1)+(a.QNTRPK/a.Isi1) Qntmasuk,

	(a.HRGPBL + a.HRGRPJ +  a.HRGADI + a.HRGTRI + a.HRGRPK) HrgMasuk,

	(a.QNTPNJ/a.Isi1)+(a.QntRPB/a.Isi1)+(a.QNTADO/a.Isi1)+(a.QNTTRO/a.Isi1)+(a.QNTPMK/a.Isi1) QntKeluar, 

	(a.HRGPNJ+a.HRGRPB+a.HRGADO+a.HRGTRO+a.HRGPMK) HrgKeluar, 

	a.QNTUKI/a.Isi1 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi1 QNTUKO, a.HRGUKO, 

	A.QntHPrd/a.Isi1 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi1 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi1 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi1 SALDOQNT, a.SALDORP,

	'1' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg	

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	And a.SALDOQNT/a.Isi1 < 0

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP=('FG')Group by KODEGRP))

	

	order by KODEGRP,KODESUBGRP,a.kodebrg,A.KODEGDG

	

	else if @Kodegdg not in('G1','R1') and @Kodegdg<>'%'

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi1 QntAwal, a.HRGAWAL, 

	(a.QNTPBL/a.Isi1)+(a.QNTRPJ/a.Isi1)+(a.QNTADI/a.Isi1)+(a.QNTTRI/a.Isi1)+(a.QNTRPK/a.Isi1) Qntmasuk,

	(a.HRGPBL + a.HRGRPJ +  a.HRGADI + a.HRGTRI + a.HRGRPK) HrgMasuk,

	(a.QNTPNJ/a.Isi1)+(a.QntRPB/a.Isi1)+(a.QNTADO/a.Isi1)+(a.QNTTRO/a.Isi1)+(a.QNTPMK/a.Isi1) QntKeluar, 

	(a.HRGPNJ+a.HRGRPB+a.HRGADO+a.HRGTRO+a.HRGPMK) HrgKeluar, 

	a.QNTUKI/a.Isi1 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi1 QNTUKO, a.HRGUKO, 

	A.QntHPrd/a.Isi1 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi1 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi1 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi1 SALDOQNT, a.SALDORP,

	'1' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg	

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	And a.SALDORP < 0

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('FG','SVC')Group by KODEGRP))

	order by KODEGRP,KODESUBGRP,a.kodebrg,A.KODEGDG

	

	else

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi1 QntAwal, a.HRGAWAL, 

	(a.QNTPBL/a.Isi1)+(a.QNTRPJ/a.Isi1)+(a.QNTADI/a.Isi1)+(a.QNTTRI/a.Isi1)+(a.QNTRPK/a.Isi1) Qntmasuk,

	(a.HRGPBL + a.HRGRPJ +  a.HRGADI + a.HRGTRI + a.HRGRPK) HrgMasuk,

	(a.QNTPNJ/a.Isi1)+(a.QntRPB/a.Isi1)+(a.QNTADO/a.Isi1)+(a.QNTTRO/a.Isi1)+(a.QNTPMK/a.Isi1) QntKeluar, 

	(a.HRGPNJ+a.HRGRPB+a.HRGADO+a.HRGTRO+a.HRGPMK) HrgKeluar, 

	a.QNTUKI/a.Isi1 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi1 QNTUKO, a.HRGUKO, 

	A.QntHPrd/a.Isi1 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi1 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi1 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi1 SALDOQNT, a.SALDORP,

	'1' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg	

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	And a.SALDOQNT/a.Isi1 < 0

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('SVC')Group by KODEGRP))

	order by KODEGRP,KODESUBGRP,a.kodebrg,A.KODEGDG

	

	 else 

	If @isi=2

	if @Kodegdg In('G1','R1')

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi2 QntAwal, a.HRGAWAL, 

	(a.QNTPBL/a.Isi2)+(a.QNTRPJ/a.Isi2)+(a.QNTADI/a.Isi2)+(a.QNTTRI/a.Isi2)+(a.QNTRPK/a.Isi2) Qntmasuk,

	(a.HRGPBL + a.HRGRPJ +  a.HRGADI + a.HRGTRI + a.HRGRPK) HrgMasuk,

	(a.QNTPNJ/a.Isi2)+(a.QntRPB/a.Isi2)+(a.QNTADO/a.Isi2)+(a.QNTTRO/a.Isi2)+(a.QNTPMK/a.Isi2) QntKeluar, 

	(a.HRGPNJ+a.HRGRPB+a.HRGADO+a.HRGTRO+a.HRGPMK) HrgKeluar, 

	a.QNTUKI/a.Isi2 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi2 QNTUKO, a.HRGUKO, 

	A.QntHPrd/a.ISI2 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi2 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi2 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi2 SALDOQNT, a.SALDORP,

	'2' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg 

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	And a.SALDORP < 0

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP=('FG')Group by KODEGRP))

	order by KODEGRP,KODESUBGRP,a.kodebrg,A.KODEGDG

	

	else if @Kodegdg not in('G1','R1') and @Kodegdg<>'%'

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi2 QntAwal, a.HRGAWAL, 

	(a.QNTPBL/a.Isi2)+(a.QNTRPJ/a.Isi2)+(a.QNTADI/a.Isi2)+(a.QNTTRI/a.Isi2)+(a.QNTRPK/a.Isi2) Qntmasuk,

	(a.HRGPBL + a.HRGRPJ +  a.HRGADI + a.HRGTRI + a.HRGRPK) HrgMasuk,

	(a.QNTPNJ/a.Isi2)+(a.QntRPB/a.Isi2)+(a.QNTADO/a.Isi2)+(a.QNTTRO/a.Isi2)+(a.QNTPMK/a.Isi2) QntKeluar, 

	(a.HRGPNJ+a.HRGRPB+a.HRGADO+a.HRGTRO+a.HRGPMK) HrgKeluar, 

	a.QNTUKI/a.Isi2 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi2 QNTUKO, a.HRGUKO, 

	A.QntHPrd/a.ISI2 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi2 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi2 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi2 SALDOQNT, a.SALDORP,

	'2' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg 

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	And a.SALDOQNT/a.Isi1 < 0

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('FG','SVC')Group by KODEGRP))

	order by KODEGRP,KODESUBGRP,a.kodebrg,A.KODEGDG

	

	else

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi2 QntAwal, a.HRGAWAL, 

	(a.QNTPBL/a.Isi2)+(a.QNTRPJ/a.Isi2)+(a.QNTADI/a.Isi2)+(a.QNTTRI/a.Isi2)+(a.QNTRPK/a.Isi2) Qntmasuk,

	(a.HRGPBL + a.HRGRPJ +  a.HRGADI + a.HRGTRI + a.HRGRPK) HrgMasuk,

	(a.QNTPNJ/a.Isi2)+(a.QntRPB/a.Isi2)+(a.QNTADO/a.Isi2)+(a.QNTTRO/a.Isi2)+(a.QNTPMK/a.Isi2) QntKeluar, 

	(a.HRGPNJ+a.HRGRPB+a.HRGADO+a.HRGTRO+a.HRGPMK) HrgKeluar, 

	a.QNTUKI/a.Isi2 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi2 QNTUKO, a.HRGUKO, 

	A.QntHPrd/a.ISI2 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi2 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi2 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi2 SALDOQNT, a.SALDORP,

	'2' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg 

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	And a.SALDORP < 0

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('SVC')Group by KODEGRP))

	order by KODEGRP,KODESUBGRP,a.kodebrg,A.KODEGDG

	

	 else 

	If @isi=3

	select 1


if @Qty1=1

If @isi=1

	if @Kodegdg In('G1','R1')

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi1 QntAwal, a.HRGAWAL, 

	(a.QNTPBL/a.Isi1)+(a.QNTRPJ/a.Isi1)+(a.QNTADI/a.Isi1)+(a.QNTTRI/a.Isi1)+(a.QNTRPK/a.Isi1) Qntmasuk,

	(a.HRGPBL + a.HRGRPJ +  a.HRGADI + a.HRGTRI + a.HRGRPK) HrgMasuk,

	(a.QNTPNJ/a.Isi1)+(a.QntRPB/a.Isi1)+(a.QNTADO/a.Isi1)+(a.QNTTRO/a.Isi1)+(a.QNTPMK/a.Isi1) QntKeluar, 

	(a.HRGPNJ+a.HRGRPB+a.HRGADO+a.HRGTRO+a.HRGPMK) HrgKeluar, 

	a.QNTUKI/a.Isi1 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi1 QNTUKO, a.HRGUKO, 

	A.QntHPrd/a.Isi1 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi1 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi1 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi1 SALDOQNT, a.SALDORP,

	'1' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg	

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP=('FG')Group by KODEGRP))

	and SALDOQNT/a.Isi1<>0   and  (SALDORP/(SALDOQNT/a.Isi1)) =0               

	order by KODEGRP,KODESUBGRP,a.kodebrg,A.KODEGDG

	

	else if @Kodegdg not in('G1','R1') and @Kodegdg<>'%'

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi1 QntAwal, a.HRGAWAL, 

	(a.QNTPBL/a.Isi1)+(a.QNTRPJ/a.Isi1)+(a.QNTADI/a.Isi1)+(a.QNTTRI/a.Isi1)+(a.QNTRPK/a.Isi1) Qntmasuk,

	(a.HRGPBL + a.HRGRPJ +  a.HRGADI + a.HRGTRI + a.HRGRPK) HrgMasuk,

	(a.QNTPNJ/a.Isi1)+(a.QntRPB/a.Isi1)+(a.QNTADO/a.Isi1)+(a.QNTTRO/a.Isi1)+(a.QNTPMK/a.Isi1) QntKeluar, 

	(a.HRGPNJ+a.HRGRPB+a.HRGADO+a.HRGTRO+a.HRGPMK) HrgKeluar, 

	a.QNTUKI/a.Isi1 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi1 QNTUKO, a.HRGUKO, 

	A.QntHPrd/a.Isi1 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi1 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi1 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi1 SALDOQNT, a.SALDORP,

	'1' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg	

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('FG','SVC')Group by KODEGRP))

	and SALDOQNT/a.Isi1<>0   and  (SALDORP/(SALDOQNT/a.Isi1)) =0               

	order by KODEGRP,KODESUBGRP,a.kodebrg,A.KODEGDG

	

	else

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi1 QntAwal, a.HRGAWAL, 

	(a.QNTPBL/a.Isi1)+(a.QNTRPJ/a.Isi1)+(a.QNTADI/a.Isi1)+(a.QNTTRI/a.Isi1)+(a.QNTRPK/a.Isi1) Qntmasuk,

	(a.HRGPBL + a.HRGRPJ +  a.HRGADI + a.HRGTRI + a.HRGRPK) HrgMasuk,

	(a.QNTPNJ/a.Isi1)+(a.QntRPB/a.Isi1)+(a.QNTADO/a.Isi1)+(a.QNTTRO/a.Isi1)+(a.QNTPMK/a.Isi1) QntKeluar, 

	(a.HRGPNJ+a.HRGRPB+a.HRGADO+a.HRGTRO+a.HRGPMK) HrgKeluar, 

	a.QNTUKI/a.Isi1 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi1 QNTUKO, a.HRGUKO, 

	A.QntHPrd/a.Isi1 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi1 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi1 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi1 SALDOQNT, a.SALDORP,

	'1' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg	

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('SVC')Group by KODEGRP))

	and SALDOQNT/a.Isi1<>0   and  (SALDORP/(SALDOQNT/a.Isi1)) =0               

	order by KODEGRP,KODESUBGRP,a.kodebrg,A.KODEGDG

	

	 else 

	If @isi=2

	if @Kodegdg In('G1','R1')

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi2 QntAwal, a.HRGAWAL, 

	(a.QNTPBL/a.Isi2)+(a.QNTRPJ/a.Isi2)+(a.QNTADI/a.Isi2)+(a.QNTTRI/a.Isi2)+(a.QNTRPK/a.Isi2) Qntmasuk,

	(a.HRGPBL + a.HRGRPJ +  a.HRGADI + a.HRGTRI + a.HRGRPK) HrgMasuk,

	(a.QNTPNJ/a.Isi2)+(a.QntRPB/a.Isi2)+(a.QNTADO/a.Isi2)+(a.QNTTRO/a.Isi2)+(a.QNTPMK/a.Isi2) QntKeluar, 

	(a.HRGPNJ+a.HRGRPB+a.HRGADO+a.HRGTRO+a.HRGPMK) HrgKeluar, 

	a.QNTUKI/a.Isi2 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi2 QNTUKO, a.HRGUKO, 

	A.QntHPrd/a.ISI2 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi2 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi2 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi2 SALDOQNT, a.SALDORP,

	'2' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg 

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP=('FG')Group by KODEGRP))

	and SALDOQNT/a.Isi2<>0   and  (SALDORP/(SALDOQNT/a.Isi2)) =0               

	order by KODEGRP,KODESUBGRP,a.kodebrg,A.KODEGDG

	

	else if  @Kodegdg not in('G1','R1') and @Kodegdg<>''

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi2 QntAwal, a.HRGAWAL, 

	(a.QNTPBL/a.Isi2)+(a.QNTRPJ/a.Isi2)+(a.QNTADI/a.Isi2)+(a.QNTTRI/a.Isi2)+(a.QNTRPK/a.Isi2) Qntmasuk,

	(a.HRGPBL + a.HRGRPJ +  a.HRGADI + a.HRGTRI + a.HRGRPK) HrgMasuk,

	(a.QNTPNJ/a.Isi2)+(a.QntRPB/a.Isi2)+(a.QNTADO/a.Isi2)+(a.QNTTRO/a.Isi2)+(a.QNTPMK/a.Isi2) QntKeluar, 

	(a.HRGPNJ+a.HRGRPB+a.HRGADO+a.HRGTRO+a.HRGPMK) HrgKeluar, 

	a.QNTUKI/a.Isi2 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi2 QNTUKO, a.HRGUKO, 

	A.QntHPrd/a.ISI2 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi2 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi2 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi2 SALDOQNT, a.SALDORP,

	'2' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg 

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('FG','SVC')Group by KODEGRP))

	and SALDOQNT/a.Isi2<>0   and  (SALDORP/(SALDOQNT/a.Isi2)) =0  

	order by KODEGRP,KODESUBGRP,a.kodebrg,A.KODEGDG

	

	else

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi2 QntAwal, a.HRGAWAL, 

	(a.QNTPBL/a.Isi2)+(a.QNTRPJ/a.Isi2)+(a.QNTADI/a.Isi2)+(a.QNTTRI/a.Isi2)+(a.QNTRPK/a.Isi2) Qntmasuk,

	(a.HRGPBL + a.HRGRPJ +  a.HRGADI + a.HRGTRI + a.HRGRPK) HrgMasuk,

	(a.QNTPNJ/a.Isi2)+(a.QntRPB/a.Isi2)+(a.QNTADO/a.Isi2)+(a.QNTTRO/a.Isi2)+(a.QNTPMK/a.Isi2) QntKeluar, 

	(a.HRGPNJ+a.HRGRPB+a.HRGADO+a.HRGTRO+a.HRGPMK) HrgKeluar, 

	a.QNTUKI/a.Isi2 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi2 QNTUKO, a.HRGUKO, 

	A.QntHPrd/a.ISI2 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi2 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi2 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi2 SALDOQNT, a.SALDORP,

	'2' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg 

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('SVC')Group by KODEGRP))

	and SALDOQNT/a.Isi2<>0   and  (SALDORP/(SALDOQNT/a.Isi2)) =0  

	order by KODEGRP,KODESUBGRP,a.kodebrg,A.KODEGDG

	

	 else 

	If @isi=3

	select 1


if @Qty2=1

If @isi=1

	if @Kodegdg In('G1','R1')

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi1 QntAwal, a.HRGAWAL, 

	(a.QNTPBL/a.Isi1)+(a.QNTRPJ/a.Isi1)+(a.QNTADI/a.Isi1)+(a.QNTTRI/a.Isi1)+(a.QNTRPK/a.Isi1) Qntmasuk,

	(a.HRGPBL + a.HRGRPJ +  a.HRGADI + a.HRGTRI + a.HRGRPK) HrgMasuk,

	(a.QNTPNJ/a.Isi1)+(a.QntRPB/a.Isi1)+(a.QNTADO/a.Isi1)+(a.QNTTRO/a.Isi1)+(a.QNTPMK/a.Isi1) QntKeluar, 

	(a.HRGPNJ+a.HRGRPB+a.HRGADO+a.HRGTRO+a.HRGPMK) HrgKeluar, 

	a.QNTUKI/a.Isi1 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi1 QNTUKO, a.HRGUKO, 

	A.QntHPrd/a.Isi1 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi1 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi1 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi1 SALDOQNT, a.SALDORP,

	'1' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg	

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP=('FG')Group by KODEGRP))

	and SALDOQNT/a.Isi1=0   and  (SALDORP/case when(SALDOQNT/a.Isi1)=0 then 1 else (SALDOQNT/a.Isi1) ) <>0               

	order by KODEGRP,KODESUBGRP,a.kodebrg,A.KODEGDG

	

	else if @Kodegdg not in('G1','R1') and @Kodegdg<>'%'

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi1 QntAwal, a.HRGAWAL, 

	(a.QNTPBL/a.Isi1)+(a.QNTRPJ/a.Isi1)+(a.QNTADI/a.Isi1)+(a.QNTTRI/a.Isi1)+(a.QNTRPK/a.Isi1) Qntmasuk,

	(a.HRGPBL + a.HRGRPJ +  a.HRGADI + a.HRGTRI + a.HRGRPK) HrgMasuk,

	(a.QNTPNJ/a.Isi1)+(a.QntRPB/a.Isi1)+(a.QNTADO/a.Isi1)+(a.QNTTRO/a.Isi1)+(a.QNTPMK/a.Isi1) QntKeluar, 

	(a.HRGPNJ+a.HRGRPB+a.HRGADO+a.HRGTRO+a.HRGPMK) HrgKeluar, 

	a.QNTUKI/a.Isi1 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi1 QNTUKO, a.HRGUKO, 

	A.QntHPrd/a.Isi1 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi1 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi1 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi1 SALDOQNT, a.SALDORP,

	'1' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg	

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('FG','SVC')Group by KODEGRP))

	and SALDOQNT/a.Isi1=0   and  (SALDORP/case when(SALDOQNT/a.Isi1)=0 then 1 else (SALDOQNT/a.Isi1) ) <>0               

	order by KODEGRP,KODESUBGRP,a.kodebrg,A.KODEGDG

	

	else

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi1 QntAwal, a.HRGAWAL, 

	(a.QNTPBL/a.Isi1)+(a.QNTRPJ/a.Isi1)+(a.QNTADI/a.Isi1)+(a.QNTTRI/a.Isi1)+(a.QNTRPK/a.Isi1) Qntmasuk,

	(a.HRGPBL + a.HRGRPJ +  a.HRGADI + a.HRGTRI + a.HRGRPK) HrgMasuk,

	(a.QNTPNJ/a.Isi1)+(a.QntRPB/a.Isi1)+(a.QNTADO/a.Isi1)+(a.QNTTRO/a.Isi1)+(a.QNTPMK/a.Isi1) QntKeluar, 

	(a.HRGPNJ+a.HRGRPB+a.HRGADO+a.HRGTRO+a.HRGPMK) HrgKeluar, 

	a.QNTUKI/a.Isi1 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi1 QNTUKO, a.HRGUKO, 

	A.QntHPrd/a.Isi1 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi1 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi1 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi1 SALDOQNT, a.SALDORP,

	'1' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg	

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('SVC')Group by KODEGRP))

	and SALDOQNT/a.Isi1=0   and  (SALDORP/case when(SALDOQNT/a.Isi1)=0 then 1 else (SALDOQNT/a.Isi1) ) <>0               

	order by KODEGRP,KODESUBGRP,a.kodebrg,A.KODEGDG

	

	 else 

	If @isi=2

	if @Kodegdg In('G1','R1')

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi2 QntAwal, a.HRGAWAL, 

	(a.QNTPBL/a.Isi2)+(a.QNTRPJ/a.Isi2)+(a.QNTADI/a.Isi2)+(a.QNTTRI/a.Isi2)+(a.QNTRPK/a.Isi2) Qntmasuk,

	(a.HRGPBL + a.HRGRPJ +  a.HRGADI + a.HRGTRI + a.HRGRPK) HrgMasuk,

	(a.QNTPNJ/a.Isi2)+(a.QntRPB/a.Isi2)+(a.QNTADO/a.Isi2)+(a.QNTTRO/a.Isi2)+(a.QNTPMK/a.Isi2) QntKeluar, 

	(a.HRGPNJ+a.HRGRPB+a.HRGADO+a.HRGTRO+a.HRGPMK) HrgKeluar, 

	a.QNTUKI/a.Isi2 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi2 QNTUKO, a.HRGUKO, 

	A.QntHPrd/a.ISI2 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi2 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi2 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi2 SALDOQNT, a.SALDORP,

	'2' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg 

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP=('FG')Group by KODEGRP))

	and SALDOQNT/a.Isi2=0   and  (SALDORP/case when(SALDOQNT/a.Isi2)=0 then 1 else (SALDOQNT/a.Isi2) ) <>0               

	order by KODEGRP,KODESUBGRP,a.kodebrg,A.KODEGDG

	

	else if  @Kodegdg not in('G1','R1') and @Kodegdg<>''

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi2 QntAwal, a.HRGAWAL, 

	(a.QNTPBL/a.Isi2)+(a.QNTRPJ/a.Isi2)+(a.QNTADI/a.Isi2)+(a.QNTTRI/a.Isi2)+(a.QNTRPK/a.Isi2) Qntmasuk,

	(a.HRGPBL + a.HRGRPJ +  a.HRGADI + a.HRGTRI + a.HRGRPK) HrgMasuk,

	(a.QNTPNJ/a.Isi2)+(a.QntRPB/a.Isi2)+(a.QNTADO/a.Isi2)+(a.QNTTRO/a.Isi2)+(a.QNTPMK/a.Isi2) QntKeluar, 

	(a.HRGPNJ+a.HRGRPB+a.HRGADO+a.HRGTRO+a.HRGPMK) HrgKeluar, 

	a.QNTUKI/a.Isi2 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi2 QNTUKO, a.HRGUKO, 

	A.QntHPrd/a.ISI2 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi2 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi2 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi2 SALDOQNT, a.SALDORP,

	'2' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg 

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('FG','SVC')Group by KODEGRP))

	and SALDOQNT/a.Isi2=0   and  (SALDORP/case when(SALDOQNT/a.Isi2)=0 then 1 else (SALDOQNT/a.Isi2) ) <>0               

	order by KODEGRP,KODESUBGRP,a.kodebrg,A.KODEGDG

	

	else

	Select KODEGRP,NamaGrp,KODESUBGRP,NamaSubGrp,a.KODEGDG,A.KODEBRG,A.NAMABRG,

	Case when @isi=1 then A.SAT1

       when @isi=2 then A.SAT2

       when @isi=3 then ''

       else ''

	 Satuan, 

	a.QNTAWAL/a.Isi2 QntAwal, a.HRGAWAL, 

	(a.QNTPBL/a.Isi2)+(a.QNTRPJ/a.Isi2)+(a.QNTADI/a.Isi2)+(a.QNTTRI/a.Isi2)+(a.QNTRPK/a.Isi2) Qntmasuk,

	(a.HRGPBL + a.HRGRPJ +  a.HRGADI + a.HRGTRI + a.HRGRPK) HrgMasuk,

	(a.QNTPNJ/a.Isi2)+(a.QntRPB/a.Isi2)+(a.QNTADO/a.Isi2)+(a.QNTTRO/a.Isi2)+(a.QNTPMK/a.Isi2) QntKeluar, 

	(a.HRGPNJ+a.HRGRPB+a.HRGADO+a.HRGTRO+a.HRGPMK) HrgKeluar, 

	a.QNTUKI/a.Isi2 QNTUKI, a.HRGUKI, 

	a.QNTUKO/a.Isi2 QNTUKO, a.HRGUKO, 

	A.QntHPrd/a.ISI2 QntHPrd, A.HRGHPrd, 

	a.HRGRATA, a.QNTIN/a.Isi2 QNTIN, a.RPIN,  

	a.QNTOUT/a.Isi2 QNTOUT, a.RPOUT, 

	a.SALDOQNT/a.Isi2 SALDOQNT, a.SALDORP,

	'2' 

	from vwReportStockBrg a

	Where a.Bulan=@Bulan and a.Tahun=@Tahun and A.KODEGDG Like @Kodegdg 

	and a.KodeGrp like @KodeGrp+'%'

	and a.KODESUBGRP like @KodeSubGrp+'%'

	and (a.KODEGRP in(select KODEGRP From DBBARANG where KODEGRP not in('SVC')Group by KODEGRP))

	and SALDOQNT/a.Isi2=0   and  (SALDORP/case when(SALDOQNT/a.Isi2)=0 then 1 else (SALDOQNT/a.Isi2) ) <>0               

	order by KODEGRP,KODESUBGRP,a.kodebrg,A.KODEGDG

	

	 else 

	If @isi=3

	select 1;

-- Sp_ReportTransferDet
CREATE PROCEDURE IF NOT EXISTS Sp_ReportTransferDet AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 

--select @Id=Case when @Id='CA' Then SUBSTRING(@Id,1,1) else SUBSTRING(@Id,1,2) 

-- DECLARE REMOVED

select @Devisi=Devisi from DBDEVISI where NamaDevisi=@Id

if @Id=''

if @SReport='T'

If @Ordr='N'

		If @NeedOto=0 or @NeedOto=1

		   if @isiList=''  

		    if @GM=0

			Exec('select ''Gabungan'' Perusahaan,''Laporan Surat Jalan Transfer ( Masuk ) per nomor bukti'' Judul,* from Vwreporttransfer where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			and NoBukti Like ''%-GM%'' and (GdgTujuan=''G01'' or GdgTujuan=''G01@CA'' or GDGTUJUAN=''G21'') order by NoPenyerahan,NoBukti,Tanggal')

			else if @GM=1

			Exec('select ''Gabungan'' Perusahaan,''Laporan Surat Jalan Transfer ( Keluar ) per nomor bukti'' Judul,* from Vwreporttransfer where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			and NoBukti Like ''%-GK%'' and (GdgAsal=''G01'' or GdgAsal=''G01@CA'' or GdgAsal=''G21'')  order by NoPenyerahan,NoBukti,Tanggal')

			

			else

			if @GM=0

			Exec('select ''Gabungan'' Perusahaan,''Laporan Surat Jalan Transfer ( Masuk ) per nomor bukti'' Judul,* from Vwreporttransfer where NoBukti IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			and NoBukti Like ''%-GM%'' and NoBukti Like ''%-GM%'' and (GdgTujuan=''G01'' or GdgTujuan=''G01@CA'' or GDGTUJUAN=''G21'') order by NoPenyerahan,NoBukti,Tanggal')

			else if @GM=1

			Exec('select ''Gabungan'' Perusahaan,''Laporan Surat Jalan Transfer ( Keluar ) per nomor bukti'' Judul,* from Vwreporttransfer where NoBukti IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			and NoBukti Like ''%-GK%'' and (GdgAsal=''G01'' or GdgAsal=''G01@CA'' or GdgAsal=''G21'') order by NoPenyerahan,NoBukti,Tanggal')


          else 	

		  If @NeedOto=2

		  if @isiList=''

		   if @GM=0

			Exec('select ''Gabungan'' Perusahaan,''Laporan Surat Jalan Transfer ( Masuk ) per nomor bukti'' Judul,* from Vwreporttransfer where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

			and NoBukti Like ''%-GM%'' and (GdgTujuan=''G01'' or GdgTujuan=''G01@CA'' or GDGTUJUAN=''G21'') order by NoPenyerahan,NoBukti,Tanggal')

			else if @GM=1

			Exec('select ''Gabungan'' Perusahaan,''Laporan Surat Jalan Transfer ( Keluar ) per nomor bukti'' Judul,* from Vwreporttransfer where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

			and NoBukti Like ''%-GK%'' and (GdgAsal=''G01'' or GdgAsal=''G01@CA'' or GdgAsal=''G21'') order by NoPenyerahan,NoBukti,Tanggal')			

			

		   else

		   if @GM=0

		    Exec('select ''Gabungan'' Perusahaan,''Laporan Surat Jalan Transfer ( Masuk ) per nomor bukti'' Judul,* from Vwreporttransfer where NoBukti IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

			and NoBukti Like ''%-GM%'' and (GdgTujuan=''G01'' or GdgTujuan=''G01@CA'' or GDGTUJUAN=''G21'') order by NoPenyerahan,NoBukti,Tanggal')

			else if @GM=1

		    Exec('select ''Gabungan'' Perusahaan,''Laporan Surat Jalan Transfer ( Keluar ) per nomor bukti'' Judul,* from Vwreporttransfer where NoBukti IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

			and NoBukti Like ''%-GK%''and (GdgAsal=''G01'' or GdgAsal=''G01@CA'' or GdgAsal=''G21'') order by NoPenyerahan,NoBukti,Tanggal')


	else If @Ordr='B'

		If @NeedOto=0 or @NeedOto=1

		  if @isiList='' 

           if @GM=0

			Exec('select ''Gabungan'' Perusahaan,* from Vwreporttransfer where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')   and Needotorisasi='+@NeedOto+'

			and NoBukti Like ''%-GM%'' order by KodeSubGrp,KodeBrg')

		   else  if @GM=1

			Exec('select ''Gabungan'' Perusahaan,* from Vwreporttransfer where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')   and Needotorisasi='+@NeedOto+'

			and NoBukti Like ''%-GK%'' order by KodeSubGrp,KodeBrg')


			else

		    if @GM=0

			Exec('select ''Gabungan'' Perusahaan,* from Vwreporttransfer where Kodebrg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')   and Needotorisasi='+@NeedOto+'

			and NoBukti Like ''%-GM%'' order by KodeSubGrp,KodeBrg')

			else  if @GM=1

			Exec('select ''Gabungan'' Perusahaan,* from Vwreporttransfer where Kodebrg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')   and Needotorisasi='+@NeedOto+'

			and NoBukti Like ''%-GK%'' order by KodeSubGrp,KodeBrg')


        else  

		If @NeedOto=2

		 if @isiList='' 

           if @GM=0

		   Exec('select ''Gabungan'' Perusahaan,* from Vwreporttransfer where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  

		   and NoBukti Like ''%-GM%''	 order by KodeSubGrp,KodeBrg')

		   else	 if @GM=1

		   Exec('select ''Gabungan'' Perusahaan,* from Vwreporttransfer where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  

	    	and NoBukti Like ''%-GK%''	 order by KodeSubGrp,KodeBrg')

		   	

		   else

		   if @GM=0

		   Exec('select ''Gabungan'' Perusahaan,* from Vwreporttransfer where Kodebrg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  

			and NoBukti Like ''%-GM%'' order by KodeSubGrp,KodeBrg')	

		   else  if @GM=1

		   Exec('select ''Gabungan'' Perusahaan,* from Vwreporttransfer where Kodebrg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  

			and NoBukti Like ''%-GK%'' order by KodeSubGrp,KodeBrg')	 	


else--------

if @Devisi<>'02'

if @SReport='T'

If @Ordr='N'

		If @NeedOto=0 or @NeedOto=1

		   if @isiList=''  

		    if @GM=0

			Exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,''Laporan Surat Jalan Transfer ( Masuk ) per nomor bukti'' Judul,* from Vwreporttransfer where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			and NoBukti Like ''%-GM%'' and (GdgTujuan=''G01'' or GdgTujuan=''G01@CA'' or GDGTUJUAN=''G21'' or GDGTUJUAN=''G116'' or GDGTUJUAN=''G112'') 

			

			and Devisi='''+@Devisi+''' 

			order by NoPenyerahan,NoBukti,Tanggal')

			

			else if @GM=1

			Exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,''Laporan Surat Jalan Transfer ( Keluar ) per nomor bukti'' Judul,* from Vwreporttransfer where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			and NoBukti Like ''%-GK%'' 

			 and Devisi='''+@Devisi+''' 

			and (GdgAsal=''G01'' or Gdgasal=''G01@CA'' or GdgAsal=''G21'' or GdgAsal=''G116'' or GdgAsal=''G112'')  order by NoPenyerahan,NoBukti,Tanggal')

			

			else

			if @GM=0

			Exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,''Laporan Surat Jalan Transfer ( Masuk ) per nomor bukti'' Judul,* from Vwreporttransfer where NoBukti IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			and NoBukti Like ''%-GM%'' 

			

			 and Devisi='''+@Devisi+''' 

			and (GdgTujuan=''G01'' or GdgTujuan=''G01@CA'' or GDGTUJUAN=''G21'' or GDGTUJUAN=''G116'' or GDGTUJUAN=''G112'') order by NoPenyerahan,,Tanggal')

			else if @GM=1

			Exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,''Laporan Surat Jalan Transfer ( Keluar ) per nomor bukti'' Judul,* from Vwreporttransfer where NoBukti IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			and NoBukti Like ''%-GK%''  and Devisi='''+@Devisi+''' 

			and (GdgAsal=''G01'' or GdgAsal=''G01@CA'' or GdgAsal=''G21'' or GdgAsal=''G116'' or GdgAsal=''G112'') order by NoPenyerahan,NoBukti,Tanggal')


          else 	

		  If @NeedOto=2

		  if @isiList=''

		   if @GM=0

			Exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,''Laporan Surat Jalan Transfer ( Masuk ) per nomor bukti'' Judul,* from Vwreporttransfer where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

			and NoBukti Like ''%-GM%'' 

			 and Devisi='''+@Devisi+''' 

			and (GdgTujuan=''G01'' or GdgTujuan=''G01@CA'' or GDGTUJUAN=''G21'' or GDGTUJUAN=''G116'' or GDGTUJUAN=''G112'' ) order by NoPenyerahan,NoBukti,Tanggal')

			else if @GM=1

			Exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,''Laporan Surat Jalan Transfer ( Keluar ) per nomor bukti'' Judul,* from Vwreporttransfer where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

			and NoBukti Like ''%-GK%''  and Devisi='''+@Devisi+''' 

			and (GdgAsal=''G01'' or GdgAsal=''G01@CA'' or GdgAsal=''G21'' or GdgAsal=''G116'' or GdgAsal=''G112'') order by NoPenyerahan,NoBukti,Tanggal')			

			

		   else

		   if @GM=0

		    Exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,''Laporan Surat Jalan Transfer ( Masuk ) per nomor bukti'' Judul,* from Vwreporttransfer where NoBukti IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

			and NoBukti Like ''%-GM%'' 

			 and Devisi='''+@Devisi+''' 

			and (GdgTujuan=''G01'' or GdgTujuan=''G01@CA'' or GDGTUJUAN=''G21'' or GDGTUJUAN=''G116'' or GDGTUJUAN=''G112'') order by NoBukti,Tanggal')

			else if @GM=1

		    Exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,''Laporan Surat Jalan Transfer ( Keluar ) per nomor bukti'' Judul,* from Vwreporttransfer where NoBukti IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

			and NoBukti Like ''%-GK%''  and Devisi='''+@Devisi+''' 

			and (GdgAsal=''G01'' or GdgAsal=''G01@CA'' or GdgAsal=''G21'' or GdgAsal=''G116'' or GdgAsal=''G112'') order by NoBukti,Tanggal')


	else If @Ordr='B'

		If @NeedOto=0 or @NeedOto=1

		  if @isiList='' 

           if @GM=0

			Exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from Vwreporttransfer where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')   and Needotorisasi='+@NeedOto+'

			and NoBukti Like ''%-GM%'' 

			 and Devisi='''+@Devisi+''' 

			and (GdgTujuan=''G01'' or GdgTujuan=''G01@CA'' or GDGTUJUAN=''G21'' or GDGTUJUAN=''G116'' or GDGTUJUAN=''G112'' ) 

			order by KodeSubGrp,KodeBrg')

		   else  if @GM=1

			Exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from Vwreporttransfer where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')   and Needotorisasi='+@NeedOto+'

			and NoBukti Like ''%-GK%'' 

			 and Devisi='''+@Devisi+''' 

			and (GdgAsal=''G01'' or GdgAsal=''G01@CA'' or GdgAsal=''G21'' or GdgAsal=''G116'' or GdgAsal=''G112'') 

			order by KodeSubGrp,KodeBrg')


			else

		    if @GM=0

			Exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from Vwreporttransfer where Kodebrg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')   and Needotorisasi='+@NeedOto+'

			and NoBukti Like ''%-GM%'' 

			 and Devisi='''+@Devisi+''' 

			and (GdgTujuan=''G01'' or GdgTujuan=''G01@CA'' or GDGTUJUAN=''G21'' or GDGTUJUAN=''G116'' or GDGTUJUAN=''G112'' ) 

			order by KodeSubGrp,KodeBrg')

			else  if @GM=1

			Exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from Vwreporttransfer where Kodebrg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')   and Needotorisasi='+@NeedOto+'

			and NoBukti Like ''%-GK%'' 

			 and Devisi='''+@Devisi+''' 

			and (GdgAsal=''G01'' or GdgAsal=''G01@CA'' or GdgAsal=''G21'' or GdgAsal=''G116'' or GdgAsal=''G112'') 

			order by KodeSubGrp,KodeBrg')


        else  

		If @NeedOto=2

		 if @isiList='' 

           if @GM=0

		   Exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from Vwreporttransfer where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  

			and NoBukti Like ''%-GM%'' 

			 and Devisi='''+@Devisi+''' 

			and (GdgTujuan=''G01'' or GdgTujuan=''G01@CA'' or GDGTUJUAN=''G21'' or GDGTUJUAN=''G116'' or GDGTUJUAN=''G112'' ) 

			 order by KodeSubGrp,KodeBrg')

		   else	 if @GM=1

		   Exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from Vwreporttransfer where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  

			and NoBukti Like ''%-GK%'' 

			 and Devisi='''+@Devisi+''' 

			and (GdgAsal=''G01'' or GdgAsal=''G01@CA'' or GdgAsal=''G21'' or GdgAsal=''G116'' or GdgAsal=''G112'') 

			 order by KodeSubGrp,KodeBrg')

		   	

		   else

		   if @GM=0

		   Exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from Vwreporttransfer where Kodebrg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  

			and NoBukti Like ''%-GM%'' 

			 and Devisi='''+@Devisi+''' 

			and (GdgTujuan=''G01'' or GdgTujuan=''G01@CA'' or GDGTUJUAN=''G21'' or GDGTUJUAN=''G116'' or GDGTUJUAN=''G112'' ) 

			 order by KodeSubGrp,KodeBrg')	

		   else  if @GM=1

		   Exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from Vwreporttransfer where Kodebrg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  

			and NoBukti Like ''%-GK%'' 

			 and Devisi='''+@Devisi+''' 

			and (GdgAsal=''G01'' or GdgAsal=''G01@CA'' or GdgAsal=''G21'' or GdgAsal=''G116'' or GdgAsal=''G112'') 

			 order by KodeSubGrp,KodeBrg')	 	


 else

if @SReport='T'

If @Ordr='N'

		If @NeedOto=0 or @NeedOto=1

		   if @isiList=''  

		    if @GM=0

			Exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,''Laporan Surat Jalan Transfer ( Masuk ) per nomor bukti'' Judul,* from Vwreporttransfer where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			and NoBukti Like ''%-GM%'' and (GdgTujuan=''G01@CA'') 

			 and Devisi='''+@Devisi+''' 

			order by NoPenyerahan,NoBukti,Tanggal')

			

			else if @GM=1

			Exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,''Laporan Surat Jalan Transfer ( Keluar ) per nomor bukti'' Judul,* from Vwreporttransfer where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			and NoBukti Like ''%-GK%'' 

			 and Devisi='''+@Devisi+''' 

			and (GdgAsal=''G01@CA'')  order by NoPenyerahan,NoBukti,Tanggal')

			

			else

			if @GM=0

			Exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,''Laporan Surat Jalan Transfer ( Masuk ) per nomor bukti'' Judul,* from Vwreporttransfer where NoBukti IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			and NoBukti Like ''%-GM%'' 

			 and Devisi='''+@Devisi+''' 

			and (GdgTujuan=''G01@CA'') order by NoPenyerahan,NoBukti,Tanggal')

			else if @GM=1

			Exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,''Laporan Surat Jalan Transfer ( Keluar ) per nomor bukti'' Judul,* from Vwreporttransfer where NoBukti IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			and NoBukti Like ''%-GK%'' 

			 and Devisi='''+@Devisi+''' 

			and (GdgAsal=''G01@CA'') order by NoPenyerahan,NoBukti,Tanggal')


          else 	

		  If @NeedOto=2

		  if @isiList=''

		   if @GM=0

			Exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,''Laporan Surat Jalan Transfer ( Masuk ) per nomor bukti'' Judul,* from Vwreporttransfer where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

			and NoBukti Like ''%-GM%'' 

			 and Devisi='''+@Devisi+''' 

			and (GdgTujuan=''G01@CA'') order by NoPenyerahan,NoBukti,Tanggal')

			else if @GM=1

			Exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,''Laporan Surat Jalan Transfer ( Keluar ) per nomor bukti'' Judul,* from Vwreporttransfer where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

			and NoBukti Like ''%-GK%''  and Devisi='''+@Devisi+''' 

			and (GdgAsal=''G01@CA'') order by NoPenyerahan,NoBukti,Tanggal')			

			

		   else

		   if @GM=0

		    Exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,''Laporan Surat Jalan Transfer ( Masuk ) per nomor bukti'' Judul,* from Vwreporttransfer where NoBukti IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

			and NoBukti Like ''%-GM%'' 

			 and Devisi='''+@Devisi+''' 

			and (GdgTujuan=''G01@CA'') order by NoPenyerahan,NoBukti,Tanggal')

			else if @GM=1

		    Exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,''Laporan Surat Jalan Transfer ( Keluar ) per nomor bukti'' Judul,* from Vwreporttransfer where NoBukti IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

			and NoBukti Like ''%-GK%''  and Devisi='''+@Devisi+''' 

			and (GdgAsal=''G01@CA'') order by NoPenyerahan,NoBukti,Tanggal')


	else If @Ordr='B'

		If @NeedOto=0 or @NeedOto=1

		  if @isiList='' 

           if @GM=0

			Exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from Vwreporttransfer where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')   and Needotorisasi='+@NeedOto+'

			and NoBukti Like ''%-GM%''  and Devisi='''+@Devisi+''' 

			order by KodeSubGrp,KodeBrg')

		   else  if @GM=1

			Exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from Vwreporttransfer where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')   and Needotorisasi='+@NeedOto+'

			and NoBukti Like ''%-GK%''  and Devisi='''+@Devisi+''' 

			order by KodeSubGrp,KodeBrg')


			else

		    if @GM=0

			Exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from Vwreporttransfer where Kodebrg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')   and Needotorisasi='+@NeedOto+'

			and NoBukti Like ''%-GM%''  and Devisi='''+@Devisi+''' 

			order by KodeSubGrp,KodeBrg')

			else  if @GM=1

			Exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from Vwreporttransfer where Kodebrg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')   and Needotorisasi='+@NeedOto+'

			and NoBukti Like ''%-GK%''  and Devisi='''+@Devisi+''' 

			order by KodeSubGrp,KodeBrg')


        else  

		If @NeedOto=2

		 if @isiList='' 

           if @GM=0

		   Exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from Vwreporttransfer where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  

			and NoBukti Like ''%-GM%''  and Devisi='''+@Devisi+''' 

			 order by KodeSubGrp,KodeBrg')

		   else	 if @GM=1

		   Exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from Vwreporttransfer where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  

			and NoBukti Like ''%-GK%''  and Devisi='''+@Devisi+''' 

			 order by KodeSubGrp,KodeBrg')

		   	

		   else

		   if @GM=0

		   Exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from Vwreporttransfer where Kodebrg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  

			and NoBukti Like ''%-GM%''  and Devisi='''+@Devisi+''' 

			 order by KodeSubGrp,KodeBrg')	

		   else  if @GM=1

		   Exec('select case when Devisi<>''02'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from Vwreporttransfer where Kodebrg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  

			and NoBukti Like ''%-GK%''  and Devisi='''+@Devisi+''' 

			 order by KodeSubGrp,KodeBrg');

-- Sp_ReportUASDET
CREATE PROCEDURE IF NOT EXISTS Sp_ReportUASDET AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 

select @Id=SUBSTRING(@Id,1,1)

if @Id=''

If @Ordr='N'

		if @IsiList=''

		exec('select ''Gabungan'' Perusahaan,* from VWREPORTUAS where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  

		order by NoBukti,TANGGAL')

		else

		exec('select ''Gabungan'' Perusahaan,* from VWREPORTUAS where  NoBukti  IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  

		order by NoBukti,TANGGAL')


	else If @Ordr='P'

		if @IsiList='' 

		  exec('select ''Gabungan'' Perusahaan,* from VWREPORTUAS where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		  order by Ket1,NOBUKTI')

		 else

		  exec('select ''Gabungan'' Perusahaan,* from VWREPORTUAS where Ket1  IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		  order by Ket1,NOBUKTI')

	      

   	else If @Ordr='J'

		if @IsiList='' 

		  exec('select ''Gabungan'' Perusahaan,* from VWREPORTUAS where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		  and COALESCE(NOSJ,'''')<>'''' order by NOSJ,NOBUKTI')

		 else

		  exec('select ''Gabungan'' Perusahaan,* from VWREPORTUAS where NOSJ  IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		  and COALESCE(NOSJ,'''')<>'''' order by NOSJ,NOBUKTI')


else

If @Ordr='N'

		if @IsiList=''

		exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VWREPORTUAS where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  

		and '''+@ID+'''= Left(NoBukti,1)

		order by NoBukti,TANGGAL')

		else

		exec('select * from VWREPORTUAS where  NoBukti  IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  

		and '''+@ID+'''= Left(NoBukti,1)

		order by NoBukti,TANGGAL')


	else If @Ordr='P'

		if @IsiList='' 

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VWREPORTUAS where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by Ket1,NOBUKTI')

		 else

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VWREPORTUAS where Ket1  IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by Ket1,NOBUKTI')

	      

   	else If @Ordr='J'

		if @IsiList='' 

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VWREPORTUAS where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		  and '''+@ID+'''= Left(NoBukti,1)

		  and COALESCE(NOSJ,'''')<>'''' order by NOSJ,NOBUKTI')

		 else

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VWREPORTUAS where NOSJ  IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		  and '''+@ID+'''= Left(NoBukti,1)

		  and COALESCE(NOSJ,'''')<>'''' order by NOSJ,NOBUKTI');

-- Sp_ReportUASRek
CREATE PROCEDURE IF NOT EXISTS Sp_ReportUASRek AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 

select @Id=SUBSTRING(@Id,1,1)



if @Id=''

If @Ordr='N'

		if @IsiList=''

		exec('select ''Gabungan'' Perusahaan,Tanggal,NoBukti,NoSJ,NamaKend,NamaProject,Sum(Qnt)Qnt,Sum(Total)Total from VWREPORTUAS where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  

		Group by Tanggal,NoBukti,NoSJ,NamaKend,NamaProject

		order by NoBukti,TANGGAL')

		else

		exec('select ''Gabungan'' Perusahaan,Tanggal,NoBukti,NoSJ,NamaKend,NamaProject,Sum(Qnt)Qnt,Sum(Total)Total from VWREPORTUAS where  NoBukti  IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  

		Group by Tanggal,NoBukti,NoSJ,NamaKend,NamaProject

		order by NoBukti,TANGGAL')


	else If @Ordr='P'

		if @IsiList='' 

		  exec('select ''Gabungan'' Perusahaan,Tanggal,NoBukti,NoSJ,NamaKend,Ket1,NamaProject,Sum(Qnt)Qnt,Sum(Total)Total from VWREPORTUAS where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		  Group by Tanggal,NoBukti,NoSJ,NamaKend,Ket1,NamaProject

		  order by Ket1,NOBUKTI')

		 else

		  exec('select ''Gabungan'' Perusahaan,Tanggal,NoBukti,NoSJ,NamaKend,Ket1,NamaProyek,Sum(Qnt)Qnt,Sum(Total)Total from VWREPORTUAS where Ket1  IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		  Group by Tanggal,NoBukti,NoSJ,NamaKend,Ket1,NamaProyek

		  order by Ket1,NOBUKTI')

	      

	else If @Ordr='J'

		if @IsiList='' 

		  exec('select ''Gabungan'' Perusahaan,Tanggal,NoBukti,NoSJ,NamaKend,Ket1,NamaProject,Sum(Qnt)Qnt,Sum(Total)Total from VWREPORTUAS where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		  and COALESCE(NOSJ,'''')<>'''' Group by Tanggal,NoBukti,NoSJ,NamaKend,Ket1,NamaProject

		  order by NOSJ,NOBUKTI')

		 else

		  exec('select ''Gabungan'' Perusahaan,Tanggal,NoBukti,NoSJ,NamaKend,Ket1,NamaProyek,Sum(Qnt)Qnt,Sum(Total)Total from VWREPORTUAS where NOSJ  IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		  and COALESCE(NOSJ,'''')<>'''' Group by Tanggal,NoBukti,NoSJ,NamaKend,Ket1,NamaProyek

		  order by NOSJ,NOBUKTI')


else

If @Ordr='N'

		if @IsiList=''

		exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,Tanggal,NoBukti,NoSJ,NamaKend,NamaProject,Sum(Qnt)Qnt,Sum(Total)Total from VWREPORTUAS where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  

		and '''+@ID+'''= Left(NoBukti,1)

		Group by Tanggal,NoBukti,NoSJ,NamaKend,NamaProject

		order by NoBukti,TANGGAL')

		else

		exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,Tanggal,NoBukti,NoSJ,NamaKend,NamaProject,Sum(Qnt)Qnt,Sum(Total)Total from VWREPORTUAS where  NoBukti  IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  

		and '''+@ID+'''= Left(NoBukti,1)

		Group by Tanggal,NoBukti,NoSJ,NamaKend,NamaProject

		order by NoBukti,TANGGAL')


	else If @Ordr='P'

		if @IsiList='' 

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,Tanggal,NoBukti,NoSJ,NamaKend,Ket1,NamaProject,Sum(Qnt)Qnt,Sum(Total)Total from VWREPORTUAS where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		  and '''+@ID+'''= Left(NoBukti,1)

		  Group by Tanggal,NoBukti,NoSJ,NamaKend,Ket1,NamaProject

		  order by Ket1,NOBUKTI')

		 else

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,Tanggal,NoBukti,NoSJ,NamaKend,Ket1,NamaProyek,Sum(Qnt)Qnt,Sum(Total)Total from VWREPORTUAS where Ket1  IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		  and '''+@ID+'''= Left(NoBukti,1)

		  Group by Tanggal,NoBukti,NoSJ,NamaKend,Ket1,NamaProyek

		  order by Ket1,NOBUKTI')

	      

	else If @Ordr='J'

		if @IsiList='' 

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,Tanggal,NoBukti,NoSJ,NamaKend,Ket1,NamaProject,Sum(Qnt)Qnt,Sum(Total)Total from VWREPORTUAS where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		  and '''+@ID+'''= Left(NoBukti,1)

		  and COALESCE(NOSJ,'''')<>'''' Group by Tanggal,NoBukti,NoSJ,NamaKend,Ket1,NamaProject

		  order by NOSJ,NOBUKTI')

		 else

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,Tanggal,NoBukti,NoSJ,NamaKend,Ket1,NamaProyek,Sum(Qnt)Qnt,Sum(Total)Total from VWREPORTUAS where NOSJ  IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		  and '''+@ID+'''= Left(NoBukti,1)

		  and COALESCE(NOSJ,'''')<>'''' Group by Tanggal,NoBukti,NoSJ,NamaKend,Ket1,NamaProyek

		  order by NOSJ,NOBUKTI');

-- Sp_reportUbahKemasanBahan
CREATE PROCEDURE IF NOT EXISTS Sp_reportUbahKemasanBahan AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 

if @Id=''

if @SReport='T'

If @Ordr='N'

		select 'Gabungan' Perusahaan,* from VwReportUbahKemasanBahan where Tanggal between @tgl1 and @tgl2 order by NoBukti,TANGGAL

		 

	else If @Ordr='B'

		select 'Gabungan' Perusahaan,* from VwReportUbahKemasanBahan where Tanggal between @tgl1 and @tgl2 order by KodeBrg


else

if @SReport='T'

If @Ordr='N'

		select Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwReportUbahKemasanBahan where Tanggal between @tgl1 and @tgl2 

		  and @Id=Case When Len(@ID)=3 Then Left(NoBukti,3) else Left(NoBukti,2) 

		  order by NoBukti,TANGGAL

		 

	else If @Ordr='B'

		select Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwReportUbahKemasanBahan where Tanggal between @tgl1 and @tgl2 

		  and @Id=Case When Len(@ID)=3 Then Left(NoBukti,3) else Left(NoBukti,2) 

		  order by KodeBrg;

-- Sp_ReportUbahKemasanRek
CREATE PROCEDURE IF NOT EXISTS Sp_ReportUbahKemasanRek AS ---- DECLARE REMOVED,@Tgl1 DateTime,@Tgl2 Datetime

--Select @Choice='N',@Tgl1='01/01/2011',@Tgl2='01/01/2013'

if @Id=''

If @Choice='N'

Select 'Gabungan' Perusahaan,Nobukti,tanggal,SUM(COALESCE(QntDB,0)) QntDB,SUM(COALESCE(QntCr,0)) QntCr,

  SUM(COALESCE(Harga,0)) Harga,SUM(COALESCE(Total,0)) Total,SUM(COALESCE(HrgAdi,0)) HrgADi,

  SUM(COALESCE(HrgADO,0)) HrgAdo,SUM(COALESCE(HPP,0)) HPP2,SUM(COALESCE(HPP2,0)) HPP

   from VwReportUbahKemasanBahan

   where tanggal between @Tgl1 and @Tgl2

   group by Nobukti,tanggal

   Order by Nobukti,tanggal



else if @Choice='B'

Select 'Gabungan' Perusahaan,kodebrg,namaBrg,tanggal,SUM(COALESCE(QntDB,0)) QntDB,SUM(COALESCE(QntCr,0)) QntCr,

  SUM(COALESCE(Harga,0)) Harga,SUM(COALESCE(Total,0)) Total,SUM(COALESCE(HrgAdi,0)) HrgADi,

  SUM(COALESCE(HrgADO,0)) HrgAdo,SUM(COALESCE(HPP,0)) HPP2,SUM(COALESCE(HPP2,0)) HPP

   from VwReportUbahKemasanBahan

   where tanggal between @Tgl1 and @Tgl2

   group by kodebrg,namaBrg,tanggal

   Order by kodebrg,namaBrg,tanggal


else

If @Choice='N'

Select Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,Nobukti,tanggal,SUM(COALESCE(QntDB,0)) QntDB,SUM(COALESCE(QntCr,0)) QntCr,

  SUM(COALESCE(Harga,0)) Harga,SUM(COALESCE(Total,0)) Total,SUM(COALESCE(HrgAdi,0)) HrgADi,

  SUM(COALESCE(HrgADO,0)) HrgAdo,SUM(COALESCE(HPP,0)) HPP2,SUM(COALESCE(HPP2,0)) HPP

   from VwReportUbahKemasanBahan

   where tanggal between @Tgl1 and @Tgl2

   and @Id=Case When Len(@ID)=3 Then Left(NoBukti,3) else Left(NoBukti,2) 

   group by Nobukti,tanggal

   Order by Nobukti,tanggal



else if @Choice='B'

Select Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,kodebrg,namaBrg,tanggal,SUM(COALESCE(QntDB,0)) QntDB,SUM(COALESCE(QntCr,0)) QntCr,

  SUM(COALESCE(Harga,0)) Harga,SUM(COALESCE(Total,0)) Total,SUM(COALESCE(HrgAdi,0)) HrgADi,

  SUM(COALESCE(HrgADO,0)) HrgAdo,SUM(COALESCE(HPP,0)) HPP2,SUM(COALESCE(HPP2,0)) HPP

   from VwReportUbahKemasanBahan

   where tanggal between @Tgl1 and @Tgl2

   and @Id=Case When Len(@ID)=3 Then Left(NoBukti,3) else Left(NoBukti,2) 

   group by kodebrg,namaBrg,tanggal

   Order by kodebrg,namaBrg,tanggal;

-- sp_ReportUmurHutang
CREATE PROCEDURE IF NOT EXISTS sp_ReportUmurHutang AS -- SET REMOVEDCase when @devisi in ('-','') then '%' else @devisi 

if @tipe=0 /*Piutang*/

select 	A.NoFaktur, A.KODECUSTSUPP as Kode, B.NAMACUSTSUPP as Nama, b.kota, min(A.Tanggal) as tanggal,

  		case when @KodeVls='IDR' then sum(COALESCE(A.Debet,0)) else sum(COALESCE(A.DebetD,0))  as debet, 

		case when @KodeVls='IDR' then sum(COALESCE(A.Kredit,0)) else  sum(COALESCE(A.KreditD,0))  as kredit,

         		case when @KodeVls='IDR' then sum(COALESCE(A.Kredit,0)-COALESCE(A.Debet,0)) else sum(COALESCE(A.KreditD,0)-COALESCE(A.DebetD,0))  as Saldo,

		datepart(dy,@tanggal-min(A.Tanggal)) As Umur,

         		case when (datepart(dy,@tanggal-min(A.Tanggal))> 0) and (datepart(dy,@tanggal-min(A.Tanggal))<= 30) then

  			case when @KodeVls='IDR' then sum(COALESCE(A.Kredit,0)-COALESCE(A.Debet,0)) else sum(COALESCE(A.KreditD,0)-COALESCE(A.DebetD,0)) 

         		else 0  as Saldo30,

         		case when (datepart(dy,@tanggal-min(A.Tanggal))> 30) and (datepart(dy,@tanggal-min(A.Tanggal))<= 60) then

  			case when @KodeVls='IDR' then sum(COALESCE(A.Kredit,0)-COALESCE(A.Debet,0)) else sum(COALESCE(A.KreditD,0)-COALESCE(A.DebetD,0)) 

         		else 0  as Saldo60,

         		case when (datepart(dy,@tanggal-min(A.Tanggal))> 60) and (datepart(dy,@tanggal-min(A.Tanggal))<= 90) then

  			case when @KodeVls='IDR' then sum(COALESCE(A.Kredit,0)-COALESCE(A.Debet,0)) else sum(COALESCE(A.KreditD,0)-COALESCE(A.DebetD,0)) 

         		else 0  as Saldo90,

         		case when (datepart(dy,@tanggal-min(A.Tanggal))> 90) and (datepart(dy,@tanggal-min(A.Tanggal))<= 120) then

  			case when @KodeVls='IDR' then sum(COALESCE(A.Kredit,0)-COALESCE(A.Debet,0)) else sum(COALESCE(A.KreditD,0)-COALESCE(A.DebetD,0)) 

         		else 0  as Saldo120,

         		case when (datepart(dy,@tanggal-min(A.Tanggal))> 120) then

  			case when @KodeVls='IDR' then sum(COALESCE(A.Kredit,0)-COALESCE(A.Debet,0)) else sum(COALESCE(A.KreditD,0)-COALESCE(A.DebetD,0)) 

         		else 0  as Saldo121

  	from vwHutPiut A

  	left outer join DBCUSTSUPP B on B.KODECUSTSUPP=A.KodeCustSupp

  	where A.Tanggal<=@Tanggal and A.KODECUSTSUPP>=@Awal and A.KODECUSTSUPP<=@Akhir and A.Perkiraan=@Perkiraan

	--	and ((@KodeVls='IDR' and (A.Valas='IDR' or A.TipeTrans='J')) or (@KodeVls<>'IDR' and A.Valas=@KodeVls))

	and (a.Devisi like @devisi) 	

  	group by A.NoFaktur, A.KODECUSTSUPP, B.NAMACUSTSUPP, B.Kota

  	having 	(sum(COALESCE(A.Kredit,0)-COALESCE(A.Debet,0)) <>0 and @KodeVls='IDR') or (sum(COALESCE(A.KreditD,0)-COALESCE(A.DebetD,0)) <>0 and @KodeVls<>'IDR')

  	order by A.KODECUSTSUPP, min(A.Tanggal), A.NoFaktur

 else 

if @tipe=1

select 	A.NoFaktur, A.KODECUSTSUPP as Kode, B.NAMACUSTSUPP as Nama, b.kota, min(A.Tanggal) as tanggal,

  		case when @KodeVls='IDR' then sum(COALESCE(A.Debet,0)) else sum(COALESCE(A.DebetD,0))  as debet, 

		case when @KodeVls='IDR' then sum(COALESCE(A.Kredit,0)) else  sum(COALESCE(A.KreditD,0))  as kredit,

         		case when @KodeVls='IDR' then sum(COALESCE(A.Kredit,0)-COALESCE(A.Debet,0)) else sum(COALESCE(A.KreditD,0)-COALESCE(A.DebetD,0))  as Saldo,

		datepart(dy,@tanggal-min(A.Tanggal)) As Umur,

         		case when (datepart(dy,@tanggal-min(A.Tanggal))> 0) and (datepart(dy,@tanggal-min(A.Tanggal))<= 30) then

  			case when @KodeVls='IDR' then sum(COALESCE(A.Kredit,0)-COALESCE(A.Debet,0)) else sum(COALESCE(A.KreditD,0)-COALESCE(A.DebetD,0)) 

         		else 0  as Saldo30,

         		case when (datepart(dy,@tanggal-min(A.Tanggal))> 30) and (datepart(dy,@tanggal-min(A.Tanggal))<= 60) then

  			case when @KodeVls='IDR' then sum(COALESCE(A.Kredit,0)-COALESCE(A.Debet,0)) else sum(COALESCE(A.KreditD,0)-COALESCE(A.DebetD,0)) 

         		else 0  as Saldo60,

         		case when (datepart(dy,@tanggal-min(A.Tanggal))> 60) and (datepart(dy,@tanggal-min(A.Tanggal))<= 90) then

  			case when @KodeVls='IDR' then sum(COALESCE(A.Kredit,0)-COALESCE(A.Debet,0)) else sum(COALESCE(A.KreditD,0)-COALESCE(A.DebetD,0)) 

         		else 0  as Saldo90,

         		case when (datepart(dy,@tanggal-min(A.Tanggal))> 90) and (datepart(dy,@tanggal-min(A.Tanggal))<= 120) then

  			case when @KodeVls='IDR' then sum(COALESCE(kredit,0)-COALESCE(A.Debet,0)) else sum(COALESCE(A.KreditD,0)-COALESCE(A.DebetD,0)) 

         		else 0  as Saldo120,

         		case when (datepart(dy,@tanggal-min(A.Tanggal))> 120) then

  			case when @KodeVls='IDR' then sum(COALESCE(A.Kredit,0)-COALESCE(A.Debet,0)) else sum(COALESCE(A.KreditD,0)-COALESCE(debetD,0)) 

         		else 0  as Saldo121

  	from vwHutpiut A

  	left outer join DBCUSTSUPP B on B.KODECUSTSUPP=A.KodeCustSupp

  	where A.Tanggal<=@tanggal and A.KODECUSTSUPP>=@awal and A.KODECUSTSUPP<=@akhir and A.perkiraan=@perkiraan

		--and ((@KodeVls='IDR' and (A.Valas='IDR' or A.TipeTrans='J')) or (@KodeVls<>'IDR' and A.Valas=@KodeVls))

	and (a.Devisi like @devisi) 	

  	group by A.Nofaktur, A.KODECUSTSUPP, B.NAMACUSTSUPP, b.kota

  	having 	(sum(COALESCE(A.Kredit,0)-COALESCE(A.Debet,0)) <>0 and @KodeVls='IDR') or (sum(COALESCE(A.KreditD,0)-COALESCE(A.DebetD,0)) <>0 and @KodeVls<>'IDR')

  	order by A.KODECUSTSUPP, A.NoFaktur, min(A.Tanggal);