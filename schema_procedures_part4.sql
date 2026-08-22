;

-- sp_ReportUmurPiutang
CREATE PROCEDURE IF NOT EXISTS sp_ReportUmurPiutang AS -- SET REMOVEDCase when @devisi in ('-','') then '%' else @devisi 

if @tipe=0 /*Piutang*/

select 	A.NoFaktur, A.KODECUSTSUPP as Kode, B.NAMACUSTSUPP as Nama, b.kota, min(A.Tanggal) as tanggal,

  		case when @KodeVls='IDR' then sum(COALESCE(A.Debet,0)) else sum(COALESCE(A.DebetD,0))  as debet, 

		case when @KodeVls='IDR' then sum(COALESCE(A.Kredit,0)) else  sum(COALESCE(A.KreditD,0))  as kredit,

         		case when @KodeVls='IDR' then sum(COALESCE(A.Debet,0)-COALESCE(A.Kredit,0)) else sum(COALESCE(A.DebetD,0)-COALESCE(A.KreditD,0))  as Saldo,

		datepart(dy,@tanggal-min(A.Tanggal)) As Umur,

         		case when (datepart(dy,@tanggal-min(A.Tanggal))> 0) and (datepart(dy,@tanggal-min(A.Tanggal))<= 30) then

  			case when @KodeVls='IDR' then sum(COALESCE(A.Debet,0)-COALESCE(A.Kredit,0)) else sum(COALESCE(A.DebetD,0)-COALESCE(A.KreditD,0)) 

         		else 0  as Saldo30,

         		case when (datepart(dy,@tanggal-min(A.Tanggal))> 30) and (datepart(dy,@tanggal-min(A.Tanggal))<= 60) then

  			case when @KodeVls='IDR' then sum(COALESCE(A.Debet,0)-COALESCE(A.Kredit,0)) else sum(COALESCE(A.DebetD,0)-COALESCE(A.KreditD,0)) 

         		else 0  as Saldo60,

         		case when (datepart(dy,@tanggal-min(A.Tanggal))> 60) and (datepart(dy,@tanggal-min(A.Tanggal))<= 90) then

  			case when @KodeVls='IDR' then sum(COALESCE(A.Debet,0)-COALESCE(A.Kredit,0)) else sum(COALESCE(A.DebetD,0)-COALESCE(A.KreditD,0)) 

         		else 0  as Saldo90,

         		case when (datepart(dy,@tanggal-min(A.Tanggal))> 90) and (datepart(dy,@tanggal-min(A.Tanggal))<= 120) then

  			case when @KodeVls='IDR' then sum(COALESCE(A.Debet,0)-COALESCE(A.Kredit,0)) else sum(COALESCE(A.DebetD,0)-COALESCE(A.KreditD,0)) 

         		else 0  as Saldo120,

         		case when (datepart(dy,@tanggal-min(A.Tanggal))> 120) then

  			case when @KodeVls='IDR' then sum(COALESCE(A.Debet,0)-COALESCE(A.Kredit,0)) else sum(COALESCE(A.DebetD,0)-COALESCE(A.KreditD,0)) 

         		else 0  as Saldo121

  	from vwHutpiut A

  	left outer join DBCUSTSUPP B on B.KODECUSTSUPP=A.KodeCustSupp

  	where A.Tanggal<=@tanggal and A.KODECUSTSUPP>=@awal and A.KODECUSTSUPP<=@akhir and A.perkiraan=@perkiraan

		--and ((@KodeVls='IDR' and (A.Valas='IDR' or A.TipeTrans='J')) or (@KodeVls<>'IDR' and A.Valas=@KodeVls))

	and (a.Devisi like @devisi) 	

  	group by A.NoFaktur, A.KODECUSTSUPP, B.NAMACUSTSUPP, b.kota

  	having 	(sum(COALESCE(A.Debet,0)-COALESCE(A.Kredit,0)) <>0 and @KodeVls='IDR') or (sum(COALESCE(A.DebetD,0)-COALESCE(A.KreditD,0)) <>0 and @KodeVls<>'IDR')

  	order by A.KODECUSTSUPP, min(A.Tanggal), A.NoFaktur

 else 

if @tipe=1

select 	A.NoFaktur, A.KODECUSTSUPP as Kode, B.NAMACUSTSUPP as Nama, b.kota, min(A.Tanggal) as tanggal,

  		case when @KodeVls='IDR' then sum(COALESCE(A.Debet,0)) else sum(COALESCE(A.DebetD,0))  as debet, 

		case when @KodeVls='IDR' then sum(COALESCE(A.Kredit,0)) else  sum(COALESCE(A.KreditD,0))  as kredit,

         		case when @KodeVls='IDR' then sum(COALESCE(A.Debet,0)-COALESCE(A.Kredit,0)) else sum(COALESCE(A.DebetD,0)-COALESCE(A.KreditD,0))  as Saldo,

		datepart(dy,@tanggal-min(A.Tanggal)) As Umur,

         		case when (datepart(dy,@tanggal-min(A.Tanggal))> 0) and (datepart(dy,@tanggal-min(A.Tanggal))<= 30) then

  			case when @KodeVls='IDR' then sum(COALESCE(A.Debet,0)-COALESCE(A.Kredit,0)) else sum(COALESCE(A.DebetD,0)-COALESCE(A.KreditD,0)) 

         		else 0  as Saldo30,

         		case when (datepart(dy,@tanggal-min(A.Tanggal))> 30) and (datepart(dy,@tanggal-min(A.Tanggal))<= 60) then

  			case when @KodeVls='IDR' then sum(COALESCE(A.Debet,0)-COALESCE(A.Kredit,0)) else sum(COALESCE(A.DebetD,0)-COALESCE(A.KreditD,0)) 

         		else 0  as Saldo60,

         		case when (datepart(dy,@tanggal-min(A.Tanggal))> 60) and (datepart(dy,@tanggal-min(A.Tanggal))<= 90) then

  			case when @KodeVls='IDR' then sum(COALESCE(A.Debet,0)-COALESCE(A.Kredit,0)) else sum(COALESCE(A.DebetD,0)-COALESCE(A.KreditD,0)) 

         		else 0  as Saldo90,

         		case when (datepart(dy,@tanggal-min(A.Tanggal))> 90) and (datepart(dy,@tanggal-min(A.Tanggal))<= 120) then

  			case when @KodeVls='IDR' then sum(COALESCE(A.Debet,0)-COALESCE(A.Kredit,0)) else sum(COALESCE(A.DebetD,0)-COALESCE(A.KreditD,0)) 

         		else 0  as Saldo120,

         		case when (datepart(dy,@tanggal-min(A.Tanggal))> 120) then

  			case when @KodeVls='IDR' then sum(COALESCE(A.Debet,0)-COALESCE(A.Kredit,0)) else sum(COALESCE(A.DebetD,0)-COALESCE(A.KreditD,0)) 

         		else 0  as Saldo121

  	from vwHutpiut A

  	left outer join DBCUSTSUPP B on B.KODECUSTSUPP=A.KodeCustSupp

  	where A.Tanggal<=@tanggal and A.KODECUSTSUPP>=@awal and A.KODECUSTSUPP<=@akhir and A.perkiraan=@perkiraan

		--and ((@KodeVls='IDR' and (A.Valas='IDR' or A.TipeTrans='J')) or (@KodeVls<>'IDR' and A.Valas=@KodeVls))

	and (a.Devisi like @devisi) 	

  	group by A.Nofaktur, A.KODECUSTSUPP, B.NAMACUSTSUPP, b.kota

  	having 	(sum(COALESCE(A.Debet,0)-COALESCE(A.Kredit,0)) <>0 and @KodeVls='IDR') or (sum(COALESCE(A.DebetD,0)-COALESCE(A.KreditD,0)) <>0 and @KodeVls<>'IDR')

  	order by A.KODECUSTSUPP, A.NoFaktur, min(A.Tanggal);

-- Sp_ReturPenyerahan
CREATE PROCEDURE IF NOT EXISTS Sp_ReturPenyerahan AS tran

if @choice='I'

select @urut=COALESCE(max(urut),0)+1 from DBRPenyerahanBrgDET   Where NoBukti=@NoBukti

  	select @Urut=COALESCE(@Urut,1) 

	if @IsEmpty=0

  	insert into DBRPenyerahanBrg  (Nobukti, Nourut, Tanggal, NoPenyerahan, Kodebag, kodeBiaya, SOP, KodeMesin, 

    		                               KodeJnsPakai, JnsKertas, IDUser, Flagmenu, JnsPakai, Perk_Investasi, Kodegdg)

    		values (@Nobukti, @Nourut, @Tanggal, @NoPenyerahan, @Kodebag, @kodeBiaya, @SOP, @KodeMesin, 

    		        @KodeJnsPakai, @JnsKertas, @IDUser, @flagmenu, @JnsPakai, @Perk_Investasi, @kodegdg)

		if @@error<>0  goto jikasalah

  	

  	insert into DBRPenyerahanBrgDET  (Nobukti, urut, kodebrg, Sat_1, Sat_2, Isi, Qnt, Qnt2, TglTiba, NoPenyerahan, UrutPenyerahan, IsInspeksi, Nosat, KetDet)

  	values(@Nobukti, @urut, @kodebrg, @Sat_1, @Sat_2, @Isi, @Qnt, @Qnt2, @TglTiba, @NoPenyerahan, @UrutPenyerahan, @IsInspeksi, @Nosat, @Ketdet)

	if @@error<>0  goto jikasalah



if @choice='U'

update DBRPenyerahanBrgDET  set kodebrg=@kodebrg, Sat_1=@Sat_1, Sat_2=@Sat_2, Isi=@Isi, Qnt=@Qnt, Qnt2=@Qnt2, TglTiba=@TglTiba,

		NoPenyerahan=@NoPenyerahan, UrutPenyerahan=@UrutPenyerahan, IsInspeksi=@IsInspeksi, Nosat=@Nosat,

		KetDet=@KetDet

  	where Nobukti=@Nobukti and urut=@urut

	if @@error<>0  goto jikasalah



if @choice='D'

delete DBRPenyerahanBrgDET  where nobukti=@nobukti and  urut=@urut

	if @@error<>0  goto jikasalah 

  	if not exists( select nobukti from DBRPenyerahanBrgDET  where nobukti=@nobukti)

  	delete DBRPenyerahanBrg   where nobukti=@nobukti

		if @@error<>0  goto jikasalah


if @@error<>0  goto jikasalah

Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- Sp_RevisiPO
CREATE PROCEDURE IF NOT EXISTS Sp_RevisiPO AS tran



-- DECLARE REMOVED

-- DECLARE REMOVED, @NoBuktiRev varchar(30)



select @NoUrut=NoUrut from DBPO where NOBUKTI=@NoBukti



select @RevisiKe=COALESCE(max(COALESCE(RevisiKe,0)),0) from DBRevPO Where NoBuktiLama=@NoBukti

select @RevisiKe=COALESCE(@RevisiKe,0)



if @RevisiKe=0

select @NoBuktiRev=@NoBukti

 else

select @NoBuktiRev=REPLACE(@NoBukti,@NoUrut,@NoUrut+'.R'+CAST(@RevisiKe as varchar(4)))


insert into DBRevPO (NOBUKTI, NOURUT, TANGGAL, TglJatuhTempo, KODECUSTSUPP, RefInt, RefVen, 

  KODEVLS, KURS, PPN, TIPEBAYAR, HARI, TIPEDISC, DISC, DISCRP, 

  NILAIPOT, NILAIDPP, NILAIPPN, NILAINET, NILAIPOTRp, NILAIDPPRp, NILAIPPNRp, NILAINETRp, 

  ISCETAK, Tipe, IsLengkap, PPH, NOPO, Freight, Lain2, IDUser, NoBuktiLama, RevisiKe)

select @NoBuktiRev, NOURUT, TANGGAL, TglJatuhTempo, KODECUSTSUPP, RefInt, RefVen, 

  KODEVLS, KURS, PPN, TIPEBAYAR, HARI, TIPEDISC, DISC, DISCRP, 

  NILAIPOT, NILAIDPP, NILAIPPN, NILAINET, NILAIPOTRp, NILAIDPPRp, NILAIPPNRp, NILAINETRp, 

  ISCETAK, Tipe, IsLengkap, PPH, NOPO, Freight, Lain2, IDUser, NoBukti, @RevisiKe+1

from DBPO

where NOBUKTI=@NoBukti



if @@error<>0  goto jikasalah



insert into DBRevPODET (NOBUKTI, URUT, NoPPL, UrutPPL, KODEBRG, PPN, DISC, DISCRP, KURS, 

  QNT, QNT2, SAT_1, SAT_2, Nosat, ISI, Toleransi, HARGA, 

  DiscP1, DiscRp1, DiscP2, DiscRp2, DiscP3, DiscRp3, DiscP4, DiscRp4, DISCTOT, 

  NOPO, Catatan, UrutTrans)

select @NoBuktiRev, URUT, NoPPL, UrutPPL, KODEBRG, PPN, DISC, DISCRP, KURS, 

  QNT, QNT2, SAT_1, SAT_2, Nosat, ISI, Toleransi, HARGA, 

  DiscP1, DiscRp1, DiscP2, DiscRp2, DiscP3, DiscRp3, DiscP4, DiscRp4, DISCTOT, 

  NOPO, Catatan, UrutTrans

from DBPODET

where NOBUKTI=@NoBukti



if @@error<>0  goto jikasalah



insert into DBBIAYARevPO (NoBukti, Urut, Kodebiaya, KODECUSTSUPP, Qnt, Harga, Valas, kurs, PPn)

select @NoBuktiRev, Urut, Kodebiaya, KODECUSTSUPP, Qnt, Harga, Valas, kurs, PPn

from DBBIAYAPO

where NoBukti=@NoBukti



if @@error<>0  goto jikasalah



insert into DBNOTERevPO (NOBUKTI, SyaratPembayaran, PORT, SyaratPengiriman, Country, TglKirim, Catatan)

select @NoBuktiRev, SyaratPembayaran, PORT, SyaratPengiriman, Country, TglKirim, Catatan

from DBNOTEPO

where NOBUKTI=@NoBukti



if @@error<>0  goto jikasalah



update DBPO set RevisiKe=@RevisiKe+1, TanggalPO=datetime('now') where NOBUKTI=@NoBukti



if @@error<>0  goto jikasalah



Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- sp_RInvKW
CREATE PROCEDURE IF NOT EXISTS sp_RInvKW AS /*select Left(A.NOBUKTI,4)+'RINV'+SUBSTR(A.NOBUKTI, LENGTH(A.NOBUKTI)-11+1) NoBukti,Left(A.NOBUKTI,4)+'RINV'+SUBSTR(A.NOBUKTI, LENGTH(A.NOBUKTI)-11+1) NoInv, A.Tanggal, A.KodeCustSupp,c.telpon,

	     Case when C.USAHA<>'' then C.USAHA+'. ' else '' + +C.NAMACUSTSUPP NamaCustSupp, H.ALAMATPROJECT ALAMAT,A.PPN, 

		0 Urut, 0 UrutTrans, '' NoSPB, 0 UrutSPB,  Sum(case when b.Nosat=1 then B.QNT else B.QNT2 )  Qnt, --S.QNT1, S.QNT2, 

		Sum(B.SUBTOTAL+COALESCE(SO.BYANGKUT,0)) SUBTOTAL, Round(Sum(B.NDPP+COALESCE(SO.BYANGKUT,0)),1)NDPP, Round(Sum(B.NDPP+COALESCE(SO.BYANGKUT,0)),1)DPP, Sum(B.NPPN)NPPN, Sum(B.NNET+COALESCE(SO.BYANGKUT,0))NNET, 

		Sum(B.SUBTOTALRp+COALESCE(SO.BYANGKUT,0))SUBTOTALRp, Sum(B.NDPPRp+COALESCE(SO.BYANGKUT,0))NDPPRp, Sum(B.NPPNRp)NPPNRp, Sum(B.NNETRp+COALESCE(SO.BYANGKUT,0))NNETRp,

		P.NAMA NamaPersh, P.KOTA KotaPersh,Bk.NAMABANK,Bk.KODEBANK,Bk.Nama,COALESCE(A1.DP,0) DP,case when COALESCE(isTTD,0)=0 Then 'ALAM MONANDAR' else 'ALAM MONANDAR'  NamaTTD,

		case when COALESCE(IsTTD,0)=0 Then 'KA. Admin' else 'Direktur'  Jabatan,SO.Hari ,

		SUM(B.NDPPRp)+Case when A.PPN=0 Then 0 else (SUM(B.NDPPRp))*0.1  TotalRp,

		dbo.Terbilang(SUM(B.NDPPRp)+Case when A.PPN=0 Then 0 else (SUM(B.NDPPRp))*0.1 )MyTerbilang,

		A.Tanggal+SO.HARI JatuhTempo,h.ALAMATPROJECT,'' UntukPembayaran, Bk.NAMABANK NamaBank,Bk.NAMA Pemilik, A1.KodeBank NoBank

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

	where A.NoBukti = @NoBukti

	Group by Left(A.NOBUKTI,4)+'RINV'+SUBSTR(A.NOBUKTI, LENGTH(A.NOBUKTI)-11+1) ,Left(A.NOBUKTI,4)+'RINV'+SUBSTR(A.NOBUKTI, LENGTH(A.NOBUKTI)-11+1) , A.Tanggal, A.KodeCustSupp,c.telpon,

	     Case when C.USAHA<>'' then C.USAHA+'. ' else '' + C.NAMACUSTSUPP, H.ALAMATPROJECT,A.PPN, 

		P.NAMA, P.KOTA ,Bk.NAMABANK,Bk.KODEBANK,Bk.Nama,case when COALESCE(isTTD,0)=0 Then 'ALAM MONANDAR' else 'ALAM MONANDAR' ,

		case when COALESCE(IsTTD,0)=0 Then 'KA. Admin' else 'Direktur'  ,SO.Hari ,

		A.Tanggal+SO.HARI ,h.ALAMATPROJECT, Bk.NAMABANK,Bk.NAMA, A1.KodeBank

		*/

select /*Left(A.NOBUKTI,4)+'RINV'+SUBSTR(A.NOBUKTI, LENGTH(A.NOBUKTI)-11+1) NoBukti,COALESCE(A1.Noinv,'')NoInv, A.Tanggal, A.KodeCustSupp,c.telpon,

	     Case when C.USAHA<>'' then C.USAHA+'. ' else '' + C.NAMACUSTSUPP NamaCustSupp, C.ALAMAT,A.PPN, 

		0 Urut, 0 UrutTrans, '' NoSPB, 0 UrutSPB, B.KodeBrg, D.NamaBrg, case when b.Nosat=1 then Sum(B.QNT) else Sum(B.QNT2)  Qnt, --S.QNT1, S.QNT2, 

		case when b.Nosat=1 then B.SAT_1 else b.SAT_2  SATUAN, D.SAT1, D.SAT2,

		B.NOSAT, B.ISI, B.NetW, B.GrossW, B.HARGA, 

		B.DISCTOT, B.HrgNetto, 

		B.NDISKON, Sum(B.SUBTOTAL+COALESCE(SO.BYANGKUT,0)) SUBTOTAL, Round(Sum(B.NDPP+COALESCE(SO.BYANGKUT,0)),1) NDPP, Sum(B.NDPP+COALESCE(SO.BYANGKUT,0))DPP, Sum(B.NPPN)NPPN, Sum(B.NNET+COALESCE(SO.BYANGKUT,0))NNET, 

		Sum(B.SUBTOTALRp+COALESCE(SO.BYANGKUT,0))SUBTOTALRp, Sum(B.NDPPRp+COALESCE(SO.BYANGKUT,0))NDPPRp, Sum(B.NPPNRp)NPPNRp, Sum(B.NNETRp+COALESCE(SO.BYANGKUT,0))NNETRp,

		P.NAMA NamaPersh, P.KOTA KotaPersh,Bk.NAMABANK,Bk.KODEBANK,Bk.Nama,COALESCE(A1.DP,0)DP,case when COALESCE(isTTD,0)=0 Then 'ALAM MONANDAR' else 'HENDRIK RAO'  NamaTTD,

		case when COALESCE(IsTTD,0)=0 Then 'KA. Admin' else 'Direktur'  Jabatan,SO.Hari ,

		SUM(B.NDPPRp)-(COALESCE(A1.DP,0))+Case when A.PPN=0 Then 0 else (SUM(B.NDPPRp)-(COALESCE(A1.DP,0)))*B.NilaiPPN  TotalRp,

		dbo.Terbilang(SUM(B.NDPPRp)-(COALESCE(A1.DP,0))+Case when A.PPN=0 Then 0 else (SUM(B.NDPPRp)-(COALESCE(A1.DP,0)))*0.1 )MyTerbilang,

		A.Tanggal+SO.HARI JatuhTempo,h.ALAMATPROJECT,'' UntukPembayaran, Bk.NAMABANK NamaBank,Bk.NAMA Pemilik, A1.KodeBank NoBank

		,

       Case When A.Devisi='01' Then 'PT. BETON CITRA ABADI' else 'PT. CALVARY ABADI'  NamaDevisi*/

       /*Left(A.NOBUKTI,4)+'RINV'+SUBSTR(A.NOBUKTI, LENGTH(A.NOBUKTI)-11+1)*/ A.Nobukti NoBukti,/*COALESCE(A1.Noinv,'')*/A.Nobukti NoInv, A.Tanggal, A.KodeCustSupp,c.telpon,

	     Case when C.USAHA<>'' then C.USAHA+'. ' else '' + C.NAMACUSTSUPP NamaCustSupp, H.NamaProject ALAMAT,A.PPN, 

		0 Urut, 0 UrutTrans, '' NoSPB, 0 UrutSPB,  Sum(case when b.Nosat=1 then B.QNT else (B.QNT2) )  Qnt, --S.QNT1, S.QNT2, 

		Sum(B.SUBTOTAL+COALESCE(SO.BYANGKUT,0)) SUBTOTAL, Round(Sum(Case When COALESCE(A.FRetensi,0)<>0 Then B.NDPPRRp else B.NDPP +COALESCE(SO.BYANGKUT,0)),1) NDPP, Sum(Case When COALESCE(A.FRetensi,0)<>0 Then B.NDPPRRp else B.NDPP +COALESCE(SO.BYANGKUT,0))DPP, Sum(B.NPPN)NPPN, Sum(B.NNET+COALESCE(SO.BYANGKUT,0))NNET, 

		Sum(B.SUBTOTALRp+COALESCE(SO.BYANGKUT,0))SUBTOTALRp, Sum(B.NDPPRp+COALESCE(SO.BYANGKUT,0))NDPPRp, Sum(B.NPPNRp)NPPNRp, Sum(B.NNETRp+COALESCE(SO.BYANGKUT,0))NNETRp,

		P.NAMA NamaPersh, P.KOTA KotaPersh,Bk.NAMABANK,Bk.KODEBANK,Bk.Nama,COALESCE(A.RDP,0)DP,case when COALESCE(isLokal,0)=0 Then 'ALAM MONANDAR' else 'HENDRIK RAO'  NamaTTD,

		case when COALESCE(IsLokal,0)=0 Then 'Direktur' else 'Direktur'  Jabatan,SO.Hari ,

		SUM(B.NDPPRp)-(COALESCE(A.RDP,0))+Case when A.PPN=0 Then 0 else (SUM(B.NDPPRp)-(COALESCE(A.RDP,0)))*B.NilaiPPN  TotalRp,

		dbo.Terbilang(SUM(B.NDPPRp)-(COALESCE(A.RDP,0))+Case when A.PPN=0 Then 0 else (SUM(B.NDPPRp)-(COALESCE(A.RDP,0)))*B.NilaiPPN )MyTerbilang,

		A.Tanggal+SO.HARI JatuhTempo,h.ALAMATPROJECT,'' UntukPembayaran, Bk.NAMABANK NamaBank,Bk.NAMA Pemilik, A1.KodeBank NoBank

		,

       Case When A.Devisi='01' Then 'PT. BETON CITRA ABADI' else 'PT. CALVARY ABADI'  NamaDevisi

        ,b.NilaiPPN,CAST(CAST(b.NilaiPPN*100 AS TINYINT AS TEXT))+'%' pajak 

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

	/*Group by A.Devisi,A.NoBukti, A.Tanggal, A.KodeCustSupp, C.NAMACUSTSUPP, C.ALAMAT,A.PPN,  B.KodeBrg, D.NamaBrg,c.telpon,h.ALAMATPROJECT,

	B.SAT_1 , D.SAT1, D.SAT2,

		B.NOSAT, B.ISI, B.NetW, B.GrossW,  B.HARGA,  

		B.DISCTOT, B.HrgNetto, 

		B.NDISKON, 

		P.NAMA , P.KOTA,Bk.NAMABANK,Bk.KODEBANK,A1.DP,IsTTD,Bk.Nama,A1.Noinv,SO.HARI,c.USAHA,b.SAT_2,A1.KodeBank

	*/

	Group by A.Devisi,A.NoBukti, A.Tanggal, A.KodeCustSupp, C.NAMACUSTSUPP, H.NamaProject,A.PPN,c.telpon,h.ALAMATPROJECT,

			P.NAMA , P.KOTA,Bk.NAMABANK,Bk.KODEBANK,A.RDP,COALESCE(IsLokal,0),Bk.Nama,A1.Noinv,SO.HARI,c.USAHA,A1.KodeBank,b.NilaiPPN

	order by Max(B.Urut);

-- Sp_RInvoicePL
CREATE PROCEDURE IF NOT EXISTS Sp_RInvoicePL AS tran

   if @Choice='I'

   select @Urut=COALESCE(max(urut),0)+1 from DBRInvoicePLDET Where NoBukti=@NoBukti

  	   if not exists(select * from DBRInvoicePL Where NoBukti=@NoBukti) 

  	   Insert into DBRInvoicePL (Devisi,NOBUKTI, NOURUT, TANGGAL, TglJatuhTempo, NoInvoice, TglInvoice, NOSO, TglSO, NoSPP, TglSPP, NOSPB, TGLSPB,

						    KODECUSTSUPP, KODEVLS, KURS, PPN, IDUser, IsLokal, IsFLag, NOLKP, TGLLKP, DISC, DISCRP,RDP)

	   Values( @Devisi,@NOBUKTI, @NoUrut, @TANGGAL, @Tanggal, @Noinvoice, @TglInvoice, @NOSC, @TGLSC, @NoSPP, @TGLSPP, @NOSPB, @TGLSPB , @KODECUSTSUPP, 

				  @Valas, @Kurs, @PPn,  @IDUser, @IsLokal, @Flagmenu, @NOLKP, @TglLKP, @Disc, @DiscRp,@DP)

		if @@error<>0  goto jikasalah			

  	   

	   INSERT INTO DBRINVOICEPLDET (NOBUKTI, URUT, NOINVOICE, URUTINVOICE, PPN, KURS, KODEBRG, NAMABRG, QNT, QNT2, NOSAT, SAT_1,SAT_2, ISI, 

							  KETERANGAN, HARGA, QNTTUKAR, QNT2TUKAR, NetW, GrossW, NetWTukar, GrossWTukar, Mesurement, MesurementTukar,

							  NoSPB, DiscP1, DiscRp1, DISC, DISCTOT)

	   VALUES(@NOBUKTI, @URUT, @NOINVOICE, @URUTINVOICE, @PPN, @KURS, @KODEBRG, @NAMABRG, @QNT, @QNT2, @NOSAT, @SAT_1, @SAT_2, @ISI,

			@KETERANGAN, @HARGA, @QNTTUKAR, @QNT2TUKAR, @NetW, @GrossW, @NetWTukar, @GrossWTukar, @Mesurement, @MesurementTukar,

			@NOSPB, @DiscP1, @DiscRp1, @Disc, @DiscTot)

	   IF @@ERROR<>0  GOTO JIKASALAH

   

   if @Choice='U'

   update DBRInvoicePLDET set NoInvoice=@Noinvoice, UrutInvoice=@URUTInvoice, 

		   KodeBrg=@KODEBRG, NamaBrg=@Namabrg, Qnt=@QNT, QNT2=@QNT2, NoSat=@NoSat, Sat_1=@Sat_1, Sat_2=@Sat_2, Isi=@Isi,

		   Keterangan=@Keterangan, QNTTukar=@QntTukar, QNT2Tukar=@Qnt2Tukar,

		   NetW=@NetW, GrossW=@GrossW, NetWTukar=@NetWTukar, GrossWTukar=@GrossWTukar, mesurement=@Mesurement, 

		   MesurementTukar=@MesurementTukar, Nospb=@NOSPB, harga=@Harga,

             DiscP1=@DiscP1, DiscRp1=@DiscRp1, DISC=@Disc, DISCTOT=@DiscTot

  	   where NoBukti=@NoBukti and Urut=@Urut

	   if @@error<>0  goto jikasalah

   

   if @Choice='D'

   delete DBRInvoicePLDET where NoBukti=@NoBukti and Urut=@Urut 

	   if @@error<>0  goto jikasalah

  	   if (not exists( select NoBukti from DBRInvoicePLDET where NoBukti=@NoBukti)) 

  	   delete DBRInvoicePL where NoBukti=@NoBukti

		   if @@error<>0  goto jikasalah


if @Choice in('I','U')

exec [sp_UpdateTransaksiPPN] 'DBRInvoicePLDET','DBRInvoicePL',@NoBukti


Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- Sp_RInvoiceRetensi
CREATE PROCEDURE IF NOT EXISTS Sp_RInvoiceRetensi AS tran

if @Choice='I'

if not exists(select * from [dbRInvoicePLRetensi] Where NoBukti=@NoBukti) 

  insert into [dbRInvoicePLRetensi] (NOBUKTI,NoUrut, TANGGAL, KETERANGAN,NoInvoice)

    values (@NOBUKTI,@NoUrut, @TANGGAL, @KETERANGAN,@NoBeli)

  

 Update [dbRInvoicePLRetensi] set SubTotal=SUBTOTALRp*FRetensi/100,TDPP=NDPPRp*FRetensi/100,TNPPN=NPPNRp*FRetensi/100,TNNET=NNETRRp*FRetensi/100 from [dbRInvoicePLRetensi] a

 Left Outer Join (select NoBukti,SUM(SUBTOTALRp)SUBTOTALRp,SUM(NDPPRp)NDPPRp,SUM(NPPNRp)NPPNRp,SUM(NNETRRp)NNETRRp,FRetensi

 from dbRInvoicePLDet where NoBukti=@NoBeli

 Group By NoBukti,FRetensi) b on a.NoInvoice=b.NoBukti

 where a.NoBukti=@NoBukti

 ----------------

 if Not exists(Select NOBUKTI from DBJurnalOto where NOBUKTI=@NoBukti)

   Insert into DBO.dbJurnalOTO(NoBukti, Tanggal, Devisi, Note, Lampiran, IsOtorisasi1, OtoUser1, TglOto1, Urut, Perkiraan, Lawan, Keterangan, Keterangan2, Debet, Kredit, Valas, Kurs, DebetRp, KreditRp, TipeTrans, TPHC, 

                                CustSuppP, CustSuppL, KodeP, KodeL, NoAktivaP, NoAktivaL, StatusAktivaP, StatusAktivaL, Nobon, KodeBag, StatusGiro,  Jenis, NOURUT)

    Select  NOBUKTI, TANGGAL, DEVISI, NOTE, LAMPIRAN, 1, 'SA', datetime('now'), 

            CAST(ROW_NUMBER() Over(PARTITION BY NoBukti Order by NoBukti) As int) URUT, 

            PERKIRAAN, LAWAN, KETERANGAN, KETERANGAN2, DEBET, KREDIT, VALAS, 

            KURS, DEBETRP, KREDITRP, TIPETRANS, TPHC, CUSTSUPPP, CUSTSUPPL, KODEP, KODEL, NOAKTIVAP, NOAKTIVAL, STATUSAKTIVAP, STATUSAKTIVAL, NOBON, 

            KODEBAG, STATUSGIRO,  JENIS, NOURUT

    From [fnc_JurnalRPenjualanRetensi](@nobukti)  


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

    from Dbo.fnc_PostRPenjualanRetensi(@nobukti)    

  

 ----------------



if @Choice='U'

update [dbRInvoicePLRetensi] set KETERANGAN=@Keterangan,Tanggal=@Tanggal

  where NoBukti=@NoBukti 

  -----------

  if Not exists(Select NOBUKTI from DBJurnalOto where NOBUKTI=@NoBukti)

   Insert into DBO.dbJurnalOTO(NoBukti, Tanggal, Devisi, Note, Lampiran, IsOtorisasi1, OtoUser1, TglOto1, Urut, Perkiraan, Lawan, Keterangan, Keterangan2, Debet, Kredit, Valas, Kurs, DebetRp, KreditRp, TipeTrans, TPHC, 

                                CustSuppP, CustSuppL, KodeP, KodeL, NoAktivaP, NoAktivaL, StatusAktivaP, StatusAktivaL, Nobon, KodeBag, StatusGiro,  Jenis, NOURUT)

    Select  NOBUKTI, TANGGAL, DEVISI, NOTE, LAMPIRAN, 1, 'SA', datetime('now'), 

            CAST(ROW_NUMBER() Over(PARTITION BY NoBukti Order by NoBukti) As int) URUT, 

            PERKIRAAN, LAWAN, KETERANGAN, KETERANGAN2, DEBET, KREDIT, VALAS, 

            KURS, DEBETRP, KREDITRP, TIPETRANS, TPHC, CUSTSUPPP, CUSTSUPPL, KODEP, KODEL, NOAKTIVAP, NOAKTIVAL, STATUSAKTIVAP, STATUSAKTIVAL, NOBON, 

            KODEBAG, STATUSGIRO,  JENIS, NOURUT

    From [fnc_JurnalRPenjualanRetensi](@nobukti)  


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

    from Dbo.fnc_PostRPenjualanRetensi(@nobukti)    

  

 ----------------


if @Choice='D'

delete [dbRInvoicePLRetensi] where NoBukti=@NoBukti

     delete DBJurnalOto where NoBukti=@NoBukti

     delete DBHUTPIUT where NoFaktur=@NoBukti and TipeTrans='T' 



if @@error<>0  goto jikasalah

Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- Sp_RJUAL
CREATE PROCEDURE IF NOT EXISTS Sp_RJUAL AS tran

if @Choice='I'

select @Urut=COALESCE(max(urut),0)+1 from DBRJUALDET Where NoBukti=@NoBukti

  	if not exists(select * from DBRJUAL Where NoBukti=@NoBukti) 

  	if @NOPNJ='-'

		insert into dbRJUAL (NOBUKTI, NOURUT, TANGGAL, TglJatuhTempo, NOPNJ, NOSO, KODECUSTSUPP, 

			KODEGDG, KODEVLS, KURS, PPN, TIPEBAYAR, HARI, TipeDisc, DISC, DiscRp, NOSPB , TGLSPB, IDUser)

    			values (@NOBUKTI, @NoUrut, @TANGGAL, @Tanggal, @NOPNJ, @NOSO, @KODECUSTSUPP, 

			@KODEGDG, 'IDR', 1, 0, 1, 0, 0, 0, 0, @NOSPB, @TGLSPB, @IDUser)

			if @@error<>0  goto jikasalah

		 else

		insert into dbRJUAL (NOBUKTI, NOURUT, TANGGAL, TglJatuhTempo, NOPNJ, NOSO, KODECUSTSUPP, 

			KODEGDG, KODEVLS, KURS, PPN, TIPEBAYAR, HARI, TipeDisc, DISC, DiscRp, NOSPB , TGLSPB, IDUser)

    			select @NOBUKTI, @NoUrut, @TANGGAL, @Tanggal, @NOPNJ, @NOSO, @KODECUSTSUPP, 

			@KODEGDG, KodeVls, Kurs, PPN, TipeBayar, Hari, TipeDisc, Disc, DiscRp, @NOSPB, @TGLSPB, @IDUser

			from DBRJUAL

			where NoBukti=@NOPNJ

			if @@error<>0  goto jikasalah


	if @NOPNJ='-'

	insert into dbRJUALDET (NOBUKTI, URUT,  NOSO, UrutSO, NoPNJ, URUTPNJ, PPN, Disc, Kurs, KODEBRG, QNT, QNT2, Sat_1,Sat_2, Isi, Nosat, Keterangan, QNTTukar, QNT2Tukar)

  		select 	@NOBUKTI, @URUT, @NoSO, @UrutSO, @NOPNJ, @UrutPnj, PPN, Disc, Kurs, @KODEBRG, @Qnt, @QNT2, @Sat_1,@Sat_2, @Isi, @NoSat,@Keterangan, @QntTukar, @Qnt2Tukar

		from	DBRJUAL

		where	NoBukti=@NoBukti

		if @@error<>0  goto jikasalah

	 else

	insert into dbRJUALDETDET (NOBUKTI, URUT,  NOSO, UrutSO, NoPNJ, UrutPNJ, PPN, Disc, Kurs, KODEBRG, QNT, QNT2, NoSat, Sat_1,Sat_2, Isi, Keterangan,

			Harga, DiscP1, DiscRp1, DiscTot, QntTukar, Qnt2Tukar)

  		select 	@NOBUKTI, @URUT, @NOSO, @UrutSO, @NOPNJ, @URUTPNJ, A.PPN, A.Disc, A.Kurs, @KODEBRG, @Qnt, @QNT2, @NoSat, @Sat_1,@Sat_2, @Isi, @Keterangan,

			B.Harga, B.DiscP1, B.DiscRp1, B.DiscTot, @QntTukar, @Qnt2Tukar

		from	dbRJUAL A

		left outer join DBRJUALDET B on B.NoBukti=A.NOPNJ and B.NoBukti=@NOPNJ and B.Urut=@URUTPNJ

		where	A.NoBukti=@NoBukti

		if @@error<>0  goto jikasalah


if @Choice='U'

update DBRJUALDET set NOSO=@NOSO, URUTSO=@UrutSO, NOPNJ=@NOPNJ, URUTPNJ=@URUTPNJ, 

		KodeBrg=@KODEBRG, Qnt=@QNT, QNT2=@QNT2, NoSat=@NoSat, Sat_1=@Sat_1, Sat_2=@Sat_2, Isi=@Isi,

		Keterangan=@Keterangan, QNTTukar=@QntTukar, QNT2Tukar=@Qnt2Tukar

  	where NoBukti=@NoBukti and Urut=@Urut

	if @@error<>0  goto jikasalah



if @Choice='D'

delete DBRJUALDET where NoBukti=@NoBukti and Urut=@Urut 

	if @@error<>0  goto jikasalah

  	if (not exists( select NoBukti from DBRJUALDET where NoBukti=@NoBukti)) 

  	delete DBRJUAL where NoBukti=@NoBukti

		if @@error<>0  goto jikasalah


Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- sp_RPembelian
CREATE PROCEDURE IF NOT EXISTS sp_RPembelian AS tran



if @Choice='I'

insert into DBRPembelian(NoBukti,Urut,Tanggal,JatuhTempo,KodeCustSupp,PPn,

		KodeTipe,KodeSubTipe,Qnt,Harga,NDPP,NPPN,NNet,

		KodeVls, Kurs, NDPPD, NPPND, NNetD,

		AccPersediaan,AccPPN,AccHutPiut,IsExcel, NoBukti_)

	Values(@NoBukti,@Urut,@Tanggal,@JatuhTempo,@KodeCustSupp,@PPn,

		@KodeTipe,@KodeSubTipe,@Qnt,@Harga,@NDPP,@NPPN,@NNET,

		@KodeVls, @Kurs, @NDPPD, @NPPND, @NNetD,

		@AccPersediaan,@AccPPN,@AccHutPiut,@IsExcel, @NoBukti_)

	if @@error<>0  goto jikasalah



if @Choice='U'

update DBRPembelian set Tanggal=@Tanggal, JatuhTempo=@JatuhTempo, KodeCustSupp=@KodeCustSupp,

	PPn=@PPn, KodeTipe=@KodeTipe, KodeSubTipe=@KodeSubTipe, Qnt=@Qnt, Harga=@Harga,

	NDPP=@NDPP, NPPN=@NPPN, NNET=@NNET, KodeVls=@KodeVls, Kurs=@Kurs, 

	NDPPD=@NDPPD, NPPND=@NPPND, NNetD=@NNetD,

	AccPersediaan=@AccPersediaan, AccPPN=@AccPPN, AccHutPiut=@AccHutPiut,

	NoBukti_=@NoBukti_

	where NoBukti=@NoBukti and Urut=@Urut

	if @@error<>0  goto jikasalah



else if @Choice='D'

Delete DBRPembelian where NoBukti=@Nobukti and Urut=@Urut

	if @@error<>0  goto jikasalah



Commit Tran

Return

JikaSalah: RollBack Tran

           Return;

-- Sp_RPenerimaanBrgJadi
CREATE PROCEDURE IF NOT EXISTS Sp_RPenerimaanBrgJadi AS Tran

If @Choice='I'

Select @Urut=MAX(Urut) from dbRPenerimaanBrgJadidet where nobukti=@NoBukti

  -- SET REMOVEDISNULL(@urut,0)+1

  If not Exists(Select 'True' From dbRPenerimaanBrgJadi where nobukti=@NoBukti)

  Insert into dbRPenerimaanBrgJadi(Nobukti,Nourut,Tanggal,Keterangan)

    Values(@NoBukti, @Nourut, @Tanggal, @Keterangan)

  

  Insert into dbRPenerimaanBrgJadidet (Nobukti, Urut, kodebrg, Qnt, Qnt2, Sat_1, Sat_2, Nosat, Isi, Kodegdg, NoTerima, UrutTerima)

  Values(@NoBukti, @Urut, @Kodebrg, @Qnt, @Qnt2, @Sat_1, @Sat_2, @Nosat, @Isi, @Kodegdg, @NoTerima, @UrutTerima)



else if @Choice='U'

update dbRPenerimaanBrgJadidet set Kodebrg=@Kodebrg, Qnt=@Qnt, Qnt2=@Qnt2, Sat_1=@Sat_1, Sat_2=@Sat_2, 

                                    Nosat=@Nosat, Isi=@Isi, Kodegdg=@Kodegdg, NoTerima=@NoTerima, UrutTerima=@UrutTerima

  where nobukti=@NoBukti and Urut=@Urut

 else if @Choice='D'

delete dbRPenerimaanBrgJadidet 

  where nobukti=@NoBukti and Urut=@Urut

  If not Exists(Select 'True' From dbRPenerimaanBrgJadidet where nobukti=@NoBukti)

  delete dbRPenerimaanBrgJadi

  where nobukti=@NoBukti 



if @@error<>0 Goto JikaSalah

Commit Tran

Return

JikaSalah: Rollback Tran

           Return;

-- sp_RPenjualan
CREATE PROCEDURE IF NOT EXISTS sp_RPenjualan AS tran



if @Choice='I'

insert into DBRPenjualan(NoBukti,Urut,Tanggal,JatuhTempo,KodeCustSupp,PPn,

		KodeTipe,KodeSubTipe,Qnt,Harga,NDPP,NPPN,NNet,

		KodeVls, Kurs, NDPPD, NPPND, NNetD,

		AccPersediaan,AccPPN,AccHutPiut,IsExcel, NoBukti_)

	Values(@NoBukti,@Urut,@Tanggal,@JatuhTempo,@KodeCustSupp,@PPn,

		@KodeTipe,@KodeSubTipe,@Qnt,@Harga,@NDPP,@NPPN,@NNET,

		@KodeVls, @Kurs, @NDPPD, @NPPND, @NNetD,

		@AccPersediaan,@AccPPN,@AccHutPiut,@IsExcel, @NoBukti_)

	if @@error<>0  goto jikasalah



if @Choice='U'

update DBRPenjualan set Tanggal=@Tanggal, JatuhTempo=@JatuhTempo, KodeCustSupp=@KodeCustSupp,

	PPn=@PPn, KodeTipe=@KodeTipe, KodeSubTipe=@KodeSubTipe, Qnt=@Qnt, Harga=@Harga,

	NDPP=@NDPP, NPPN=@NPPN, NNET=@NNET, KodeVls=@KodeVls, Kurs=@Kurs, 

	NDPPD=@NDPPD, NPPND=@NPPND, NNetD=@NNetD,

	AccPersediaan=@AccPersediaan, AccPPN=@AccPPN, AccHutPiut=@AccHutPiut,

	NoBukti_=@NoBukti_

	where NoBukti=@NoBukti and Urut=@Urut

	if @@error<>0  goto jikasalah



else if @Choice='D'

Delete DBRPenjualan where NoBukti=@Nobukti and Urut=@Urut

	if @@error<>0  goto jikasalah



Commit Tran

Return

JikaSalah: RollBack Tran

           Return;

-- Sp_RPenyerahanBhn
CREATE PROCEDURE IF NOT EXISTS Sp_RPenyerahanBhn AS tran

if @Choice='I'

select @Urut=COALESCE(max(urut),0)+1 from dbRPenyerahanBhndet Where NoBukti=@NoBukti

  if not exists(select * from dbRPenyerahanBhn Where NoBukti=@NoBukti) 

  insert into dbRPenyerahanBhn (NOBUKTI, NOURUT, TANGGAL,KODEGDG,NoPenyerahanBhn, IsSampel)

    values (@NOBUKTI, @NOURUT, @TANGGAL,@KODEGDG,@NoPenyerahanBhn, @IsSampel)

  

  insert into dbRPenyerahanBhnDET (NOBUKTI, URUT, KODEBRG, QNT, NOSAT, ISI, SAT,Qnt2, NoPenyerahanBhn, UrutPenyerahanBHN)

  values(@NOBUKTI, @URUT, @KODEBRG, @Qnt, @NoSat, @Isi, @Sat,@Qnt2, @NoPenyerahanBhn, @UrutPenyerahanBHN)



if @Choice='U'

update dbRPenyerahanBhnDET set KodeBrg=@KODEBRG, Qnt=@QNT, NOSAT=@NoSat, ISI=@ISI, SAT=@Sat,Qnt2=@Qnt2, NoPenyerahanBHN=@NoPenyerahanBhn, UrutPenyerahanBHN=@UrutPenyerahanBHN

  where NoBukti=@NoBukti and Urut=@Urut



if @Choice='D'

delete dbRPenyerahanBhnDET where NoBukti=@NoBukti and Urut=@Urut 

  if not exists( select NoBukti from dbRPenyerahanBhnDET where NoBukti=@NoBukti)

  delete dbRPenyerahanBhn where NoBukti=@NoBukti


if @@error<>0  goto jikasalah

Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- sp_RRekapKirim
CREATE PROCEDURE IF NOT EXISTS sp_RRekapKirim AS -- DECLARE REMOVED,@kodeCustSupp Varchar(20)

select @Tanggal=Tanggal,@kodeCustSupp=KodeCustSupp from DBRInvoicePL where NoBukti=@NoBukti



Select @Tanggal TglINV,'' Jabatan,'' dibuat

 ,'ADMIN.INVOICE' JabBuat, 'ALAM MONANDAR'  NamaTTD

 ,b.USAHA,b.Kota,Urut,a.Tanggal,a.NoBukti,NoPOLkend,a.KodeBrg,a.NAMABRG,QntSisa ,Qnt2Sisa ,SAT_1,SAT_2,a.KodeCustSupp,a.NAMACUSTSUPP

 ,NAMAPROJECT,a.LM,

 Case When D.ISI2>D.ISI1 Then D.SAT1 when D.ISI2=D.ISI1 Then D.SAT1 else D.SAT2  SA_1,Case When D.ISI2<D.ISI1 Then D.SAT1 WHEN D.ISI2=D.ISI1 Then D.SAT2 else D.SAT2  SA_2,

 COALESCE((Select Sum(QntSisa) QntLalu

 from vwReportRekapKirim 

 where NoBukti in(Select a.NoSPB from dbInvoicePLDet a 

                  Left Outer Join DBRInvoicePLDET b on a.NoBukti=b.NoInvoice and a.Urut=b.UrutInvoice

                  Left Outer Join DBRInvoicePL c on c.NOBUKTI=b.NOBUKTI

                  where  C.Tanggal<@Tanggal and a.NoSO in(a2.NoSO)  and c.KODECUSTSUPP=@kodeCustSupp

                  Group By a.NoSPB)),0) QntLalu

 from vwReportRekapKirim a

 Left Outer Join DBBARANG D on d.KODEBRG=a.KodeBrg

 Left Outer Join dbRInvoicePL a1 On a1.NoBukti=@NoBukti

 Left Outer Join(Select NoBukti,NOSO from dbInvoicePLDet group by NoBukti,NoSO)a2 On a2.NoBukti=a1.NoBukti 

 Left Outer Join dbCustSupp b on a.KodeCustSupp=b.KODECUSTSUPP

 where a.NoBukti in(Select a.NoSPB from dbInvoicePLDet a 

                  Left Outer Join DBRInvoicePLDET b on a.NoBukti=b.NoInvoice and a.Urut=b.UrutInvoice

                  Left Outer Join DBRInvoicePL c on c.NOBUKTI=b.NOBUKTI

                  where b.NOBUKTI=@NoBukti

                  Group By a.NoSPB)

 order by NAMABRG;

-- sp_RSPB
CREATE PROCEDURE IF NOT EXISTS sp_RSPB AS tran



if @Choice='I'

select @Urut=COALESCE(max(urut),0)+1 from dbRSPBDet Where NoBukti=@NoBukti

   if @IsEmpty=0 

   insert into dbRSPB (Devisi,NoBukti, NoUrut, Tanggal, NoSPB, KodeCustSupp, NoPolKend, 

	    Container, NoContainer, NoSeal,Catatan, IDUser, IsFlag,TipeRetur,KodeGdg,IsTukarBrg)

   values (@Devisi,@NoBukti, @NoUrut, @Tanggal, @NoSPP, @KodeCustSupp, @NoPolKend, 

	    @Container, @NoContainer, @NoSeal, @Catatan, @IDUser, @Flagmenu,@TipeRetur,@Kodegdg,@IsTukarBrg)

   if @@error<>0  goto jikasalah


   insert into dbRSPBDet (NoBukti, Urut, NoSPB, UrutSPB, KodeBrg, QNT, QNT2, SAT_1, SAT_2, NOSAT, ISI, NetW, GrossW, Namabrg)

   values (@NoBukti, @Urut, @NoSPP, @UrutSPP, @KodeBrg,  @QNT, @QNT2, @SAT_1, @SAT_2, @NOSAT, @ISI, @NetW, @GrossW, @Namabrg)

   

   --------------

   

   exec KoreksiReturSPB @Choice,@NOBUKTI,@NoUrut,@NoSPP,@TANGGAL,@KODEBRG,@QNT,@QNT2

   

   if @@error<>0  goto jikasalah



if @Choice='U'

update dbRSPBDET set KodeBrg=@KodeBrg, QNT=@QNT, QNT2=@QNT2, SAT_1=@SAT_1, SAT_2=@SAT_2, NOSAT=@NOSAT, ISI=@ISI, Namabrg=@Namabrg,

				   NetW=@NetW, GrossW=@GrossW

   where NoBukti=@NoBukti and Urut=@Urut

   exec KoreksiReturSPB @Choice,@NOBUKTI,@NoUrut,@NoSPP,@TANGGAL,@KODEBRG,@QNT,@QNT2

   if @@error<>0  goto jikasalah



if @Choice='D'

delete dbRSPBDET where NoBukti=@NoBukti and Urut=@Urut 

   if @@error<>0  goto jikasalah

   if not exists (select NoBukti from dbRSPBDET where NoBukti=@NoBukti)

   delete dbRSPB where NoBukti=@NoBukti

     if @@error<>0  goto jikasalah

   

   exec KoreksiReturSPB @Choice,@NOBUKTI,@NoUrut,@NoSPP,@TANGGAL,@KODEBRG,@QNT,@QNT2



--Update dbRSPB set KodeGdg=(select Kodegdg from dbSPBDet where NoBukti=@NoSPP)where NoBukti=@NoBukti

Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- sp_RTandaTerima
CREATE PROCEDURE IF NOT EXISTS sp_RTandaTerima AS select  Case when C.USAHA<>'' then C.USAHA+'. ' else '' +C.NAMACUSTSUPP NamaCustSupp, C.ALAMAT ALAMATCUSTSUPP,C.TELPON,C.FAX,  

	case when a.PPN<>0 then a.NoInvoice else 	Left(A.NoBukti,6)+SUBSTR(A.Nobukti, LENGTH(A.Nobukti)-11+1)  NoTandaTerima,

		P.NAMAPROJECT,

		Left(A.NoBukti,6)+SUBSTR(A.Nobukti, LENGTH(A.Nobukti)-11+1) NoInvoice,COALESCE(a.NoInvoice,'')NoInv, A.Tanggal TglInvoice,

		SUM(B.NDPPRp)+Case when A.PPN=0 Then 0 else (SUM(B.NDPPRp))*0.1  NilaiKwitansi, A.Tanggal TglKwitansi,

		/*a.noseri+'.'+A.NoPajak*/'' nopajak, NUll TglFPJ,A.PPN,

		'' Inputan4, 

		'' Inputan5,

		'' Inputan6,

		'' Inputan7,

		'' Inputan8,

		Case When SO.HARI=0 Then '' else 'Term  '+CAST(SO.Hari AS TEXT)+' Hari'  Catatan,

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

		

		RpKwt,'' NoBAP,'' NoBASTB,'' noSPBarang,

		Null TglBAP,Null TglBASTB,Null  TglSPBarang  

	from DBRInvoicePL A

	left outer join DBRInvoicePLDET B on B.NoBukti = A.NoBukti

	left Outer join [vwRpDetRInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti

	left outer join vwCUSTSUPP C on C.KODECUSTSUPP = A.KodeCustSupp

	Left Outer Join(Select NOSO,a.NoBukti,Urut,b.NoBL from dbInvoicePLDet a

	                Left Outer Join dbInvoicePL b on a.NoBukti=b.NoBukti

	                Group By NOSO,a.NoBukti,Urut,b.NoBL)X on X.NoBukti=B.NoInvoice and X.Urut=B.UrutInvoice

	left outer join DBPROJECT P on P.KODEPROJECT=X.NoBL

	LEFT Outer Join (select a.NOBUKTI,b.HARI,SUM(COALESCE(BYANGKUT,0))BYANGKUT,COALESCE(TERM1P,0)Retensi,COALESCE(TERM2P,0)PPH22,COALESCE(TERM3P,0)PPHDPP from DBSODET a Left Outer Join dbSO b on a.NoBukti=b.NoBukti Group by a.NOBUKTI,b.HARI,COALESCE(a.IsUbahNama,0),COALESCE(b.TERM1P,0),COALESCE(b.TERM2P,0),COALESCE(b.TERM3P,0))SO on SO.NOBUKTI=X.NoSO

	where A.NoBukti = @NoBukti

	group by A.NoBukti, A.Tanggal, C.NAMACUSTSUPP,

		 C.ALAMAT, P.NAMAPROJECT,A.PPN,A.NoInvoice,c.USAHA,SO.HARI,C.TELPON,C.FAX

	,SO.Retensi,SO.PPH22,SO.PPHDPP,rpInv.TotNet;

-- Sp_RTransRute
CREATE PROCEDURE IF NOT EXISTS Sp_RTransRute AS if @Mode='I' 

Insert Into dbRRuteTrans (Devisi,[NOBUKTI] ,

	[NOURUT],

	[TANGGAL] ,

	[KODEKEND],

	[SUPIR] ,

	[RUTE] ,

	[Ket1] ,

	[Ket2],NoRute 

	)

select	@Devisi,@NoBukti ,

	[NOURUT],

	@TANGGAL ,

	[KODEKEND],

	[SUPIR] ,

	[RUTE] ,

	[Ket1] ,

	[Ket2],@NoRute from DBRUTETRANS where NOBUKTI=@NoRute

Insert Into dbRRuteTransDet(NOBUKTI ,

	[URUT] ,

	[BIAYA] ,

	[TARIF] ,

	[QNT] ,

	[TOTAL] ,

	[ISP])

select @NoBukti ,

	[URUT] ,

	[BIAYA] ,

	[TARIF] ,

	[QNT] ,

	[TOTAL] ,

	[ISP]	from DBRUTETRANSDET where NOBUKTI=@NoRute


else if @Mode='U' select 1 

else if @Mode='D' 

delete DBRRUTETRANSDet where NOBUKTI=@NOBUKTI and Urut=@Urut

 if Not Exists (select NoBukti from DBRRUTETRANSDet where NOBUKTI=@NOBUKTI)

 delete DBRRUTETRANS where NOBUKTI=@NOBUKTI;

-- Sp_RUTE
CREATE PROCEDURE IF NOT EXISTS Sp_RUTE AS tran

if @choice='I'

insert into DBRUTE (KODERUTE, NAMARUTE)

	values (@KODERUTE, @NAMARUTE)

	if @@error <> 0 goto jikasalah



if @choice='U'

update DBRUTE set NAMARUTE=@NAMARUTE

             where KODERUTE=@KODERUTE

	if @@error <> 0 goto jikasalah



if @choice='D'

delete  DBRUTE where KODERUTE=@KODERUTE

	if @@error <> 0 goto jikasalah



commit tran

return

jikasalah:

	rollback tran

	raiserror('Proses Input Data Gagal',16,1)

	return;

-- SP_RUTETRANS
CREATE PROCEDURE IF NOT EXISTS SP_RUTETRANS AS --SELECT @KODEKEND='TGS 360 50533241483321',@KODERUTE='0909'

-- SET REMOVED(SELECT KODEJENISKEND FROM DBKENDARAAN WHERE KODEKEND=@KODEKEND)



if @CHOICE='I'

if not exists(select * from DBRUTETRANS Where NOBUKTI=@NOBUKTI) 

	INSERT INTO DBRUTETRANS (Devisi,NOBUKTI,NOURUT,TANGGAL,KODEKEND,SUPIR,RUTE,Ket1,Ket2)

	VALUES (@Devisi,@NOBUKTI,@NOURUT,@TANGGAL,@KODEKEND,@SUPIR,@RUTE,@Ket1,@Ket2)

		

	if @Type=0

	Declare mydata Cursor For  

			SELECT @NOBUKTI NOBUKTI,@URUT, 'SOLAR' BIAYA,A.SOLAR TARIF,0 QNT,0 TOTAL 

			FROM DBTARIFRUTE A

			where A.KODEJENISKEND=@KODEJENIS AND A.KODERUTE=@RUTE

			UNION ALL

			SELECT @NOBUKTI NOBUKTI,@URUT,'SUPIR' BIAYA,A.SUPIR TARIF,0 QNT,0 TOTAL 

			FROM DBTARIFRUTE A

			where A.KODEJENISKEND=@KODEJENIS AND A.KODERUTE=@RUTE

			UNION ALL

			SELECT @NOBUKTI NOBUKTI,@URUT,'CRANE' BIAYA,A.SOLARCRANE TARIF,0 QNT,0 TOTAL 

			FROM DBTARIFRUTE A

			where A.KODEJENISKEND=@KODEJENIS AND A.KODERUTE=@RUTE

			UNION ALL

			SELECT @NOBUKTI NOBUKTI,@URUT,'OPRCRANE' BIAYA,A.OPCRANE TARIF,0 QNT,0 TOTAL 

			FROM DBTARIFRUTE A

			where A.KODEJENISKEND=@KODEJENIS AND A.KODERUTE=@RUTE

			UNION ALL

			SELECT @NOBUKTI NOBUKTI,@URUT,'KULI' BIAYA,A.KULI TARIF,0 QNT,0 TOTAL 

			FROM DBTARIFRUTE A

			where A.KODEJENISKEND=@KODEJENIS AND A.KODERUTE=@RUTE

			UNION ALL

			SELECT @NOBUKTI NOBUKTI,@URUT,'TIMBANG' BIAYA,A.TIMBANG TARIF,0 QNT,0 TOTAL 

			FROM DBTARIFRUTE A

			where A.KODEJENISKEND=@KODEJENIS AND A.KODERUTE=@RUTE

			UNION ALL

			SELECT @NOBUKTI NOBUKTI,@URUT,'ALL IN' BIAYA,A.ALL_IN TARIF,0 QNT,0 TOTAL 

			FROM DBTARIFRUTE A

			where A.KODEJENISKEND=@KODEJENIS AND A.KODERUTE=@RUTE

			UNION ALL

			SELECT @NOBUKTI NOBUKTI,@URUT,'UANG MAKAN ' BIAYA,A.UANGMAKAN TARIF,0 QNT,0 TOTAL 

			FROM DBTARIFRUTE A

			where A.KODEJENISKEND=@KODEJENIS AND A.KODERUTE=@RUTE

		open mydata 

		Fetch Next From mydata Into @NOBUKTI,@URUT,@BIAYA,@TARIF,@QNT,@TOTAL

		while @@FETCH_STATUS=0

		SELECT @Urut=COALESCE(max(urut),0)+1 from DBRUTETRANSDET Where NoBukti=@NoBukti

			INSERT INTO DBRUTETRANSDET(NOBUKTI,URUT,BIAYA,TARIF,QNT,TOTAL,ISP)

			VALUES(@NOBUKTI,@URUT,@BIAYA,@TARIF,@QNT,@QNT*@TARIF,@ISP)	

			Fetch Next From mydata Into @NOBUKTI,@URUT,@BIAYA,@TARIF,@QNT,@TOTAL

			 

		close mydata

		Deallocate mydata

	

	if @Type=1

	SELECT @Urut=COALESCE(max(urut),0)+1 from DBRUTETRANSDET Where NoBukti=@NoBukti

	INSERT INTO DBRUTETRANSDET(NOBUKTI,URUT,BIAYA,TARIF,QNT,TOTAL)

	VALUES(@NOBUKTI,@URUT,@BIAYA,@TARIF,@QNT,@TOTAL)


if @CHOICE='U'  

Update DBRUTETRANSDET set BIAYA=@BIAYA,TARIF=@TARIF,QNT=@QNT,TOTAL=@QNT*@TARIF

   WHERE NOBUKTI=@NOBUKTI AND URUT=@URUT



IF @CHOICE='D'

DELETE DBRUTETRANSDET

	WHERE NOBUKTI=@NOBUKTI AND URUT=@URUT

	if not exists(select NoBukti from DBRUTETRANSDET Where NOBUKTI=@NOBUKTI) 

	DELETE DBRUTETRANS WHERE NOBUKTI=@NOBUKTI

	DELETE DBSJRUTETRANS WHERE NoSaku=@NOBUKTI;

-- SP_SaldoPiutangDetail
CREATE PROCEDURE IF NOT EXISTS SP_SaldoPiutangDetail AS --declare 

--Select @Bulan=1, @Tahun=2015,@Perkiraan='11030100',@Awal='1308000014',@Akhir='1308000014',@Devisi='01'

/*select XURUT,NoFaktur,Kode,Nama,JatuhTempo,case when XUrut>1 Then 0 else Jumlah  Jumlah,TglBayar,NoRef,Pelunas,case when XUrut>1 Then 0 else SaldoAkhir  SaldoAkhir,b.DP from(

select a.NoFaktur,a.Kode,a.Nama+'  ('+a.Kode+')' Nama,a.JatuhTempo,Case when COALESCE(a.Jumlah,0)=0 Then a.SaldoAkhir else a.Jumlah  Jumlah,b.Tanggal TglBayar,b.NoBukti NoRef,b.Kredit Pelunas,a.SaldoAkhir

,CAST(ROW_NUMBER() Over(PARTITION BY Kode,a.NoFaktur Order by Kode,a.NoFaktur) As int) XURUT

from (

Select 	H.NoFaktur,H.KodeCustSupp Kode, COALESCE(S.NAMACUSTSUPP,'') Nama,H.JatuhTempo, COALESCE(S.Kota,'') Kota,--Min(Urut)Urut,

		SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )<CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) Then COALESCE(H.Debet,0)-COALESCE(H.Kredit,0) else 0  ) Awal,

		SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) Then COALESCE(H.Debet,0) else 0  ) Jumlah,

		SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) and H.NoRetur='' then COALESCE(H.Kredit,0) else 0  ) Pelunasan,

		SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) and H.NoRetur<>'' then COALESCE(H.Kredit,0) else 0  ) Retur,

		sum(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )<=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) Then COALESCE(Debet,0)-COALESCE(Kredit,0)else 0  ) SaldoAkhir,

		SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )<CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) then COALESCE(DebetD,0)-COALESCE(KreditD,0) else 0  ) AwalD,

		SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) then COALESCE(H.DebetD,0) else 0  ) JumlahD,

		SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) and H.NoRetur='' then COALESCE(H.KreditD,0) else 0  ) PelunasanD,

		SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) and H.NoRetur<>'' then COALESCE(H.KreditD,0) else 0  ) ReturD,

		sum(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )<=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) Then COALESCE(Debetd,0)-COALESCE(Kreditd,0)else 0  ) SaldoAkhirD

 	from vwHutpiut H

 	left outer join DBCUSTSUPP S on S.KODECUSTSUPP=H.KodeCustSupp

 	where (CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )<=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) )

 	and H.KodeCustSupp>=@awal and H.KodeCustSupp<=@akhir and H.perkiraan=@perkiraan and H.Tipe='PT'

 	group by H.NoFaktur,H.KodeCustSupp, S.NAMACUSTSUPP, S.Kota,H.JatuhTempo

 	Having SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )<CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) Then COALESCE(H.Debet,0)-COALESCE(H.Kredit,0) else 0  ) <>0 or

		SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) Then COALESCE(H.Debet,0) else 0  ) <>0 or

		SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) and H.NoRetur='' then COALESCE(H.Kredit,0) else 0  ) <>0 or

		SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) and H.NoRetur<>'' then COALESCE(H.Kredit,0) else 0  ) <>0 or

		sum(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )<=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) Then COALESCE(Debet,0)-COALESCE(Kredit,0)else 0 ) <>0 or

		SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )<CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) then COALESCE(DebetD,0)-COALESCE(KreditD,0) else 0  ) <>0 or

		SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) then COALESCE(H.DebetD,0) else 0  ) <>0 or

		SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) and H.NoRetur='' then COALESCE(H.KreditD,0) else 0  ) <>0 or

		SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) and H.NoRetur<>'' then COALESCE(H.KreditD,0) else 0  ) <>0 or

		sum(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )<=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) Then COALESCE(Debetd,0)-COALESCE(Kreditd,0)else 0  )<>0

 		)a

		Left Outer Join(select NoFaktur,KodeCustSupp,Tanggal,NoBukti,Kredit from vwHutPiut H

		where 

		CAST(,YEAR(Tanggal))+CAST(MONTH(tanggal AS TEXT)))=CAST(,@Tahun)+ CAST(@Bulan AS TEXT))

 	    and H.KodeCustSupp>=@awal and H.KodeCustSupp<=@akhir and H.perkiraan=@perkiraan and H.Tipe='PT' and TipeTrans='L'

 	    Group by NoFaktur,KodeCustSupp,Tanggal,NoBukti,Kredit)b on a.NoFaktur=b.NoFaktur and a.Kode=b.KodeCustSupp 

 	    where  (SaldoAkhir<>0 or  (MONTH(Tanggal)=@Bulan and YEAR(Tanggal)=@Tahun)) 

 	    )a

 	    Left Outer Join (select NoBukti,SUM(DP+Case when Left(NoBukti,2)='CB' Then 0 else (DP*0.1 )) DP from dbInvoicePL Group by NoBukti) b on a.NoFaktur=b.NoBukti

 	    order By Kode,NoFaktur,XURUT

*/

select XURUT,NoFaktur,Kode,USAHA,Nama,JatuhTempo,Awal,case when XUrut>1 and Simbol='P' Then 0 else Jumlah+Awal/*-Case When (COALESCE(Pelunasan,0)-COALESCE(Pelunas,0))=COALESCE(b.DP,0) Then COALESCE(b.DP,0)else 0 */  Jumlah,TglBayar,NoRef,Pelunas,case when XUrut>1 and Simbol='P' Then 0 else SaldoAkhir  SaldoAkhir,b.DP from(

select a.Simbol,a.NoFaktur,a.Kode,a.USAHA,a.Nama+'  ('+a.Kode+')' Nama,a.JatuhTempo,a.Awal-COALESCE(H2.Kredit1,0)Awal,a.Jumlah,a.Pelunasan,b.Tanggal TglBayar,b.NoBukti NoRef,b.Kredit Pelunas,a.SaldoAkhir-COALESCE(H2.Kredit1,0)SaldoAkhir

,CAST(ROW_NUMBER() Over(PARTITION BY Kode,a.NoFaktur Order by Kode,a.NoFaktur) As int) XURUT

from (

Select 	H.Simbol,H.NoFaktur,H.KodeCustSupp Kode, COALESCE(S.NAMACUSTSUPP,'') Nama,H1.Tanggal  JatuhTempo, COALESCE(S.Kota,'') Kota,--Min(Urut)Urut,

		SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )<CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) Then COALESCE(H.Debet,0)-COALESCE(H.Kredit,0) else 0  ) Awal,

		SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) Then COALESCE(H.Debet,0)-Case When TipeTrans='T' Then COALESCE(H.Kredit,0)else 0  else 0  ) Jumlah,

		SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) and H.NoRetur='' then COALESCE(H.Kredit,0) else 0  ) Pelunasan,

		SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) and H.NoRetur<>'' then COALESCE(H.Kredit,0) else 0  ) Retur,

		sum(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )<=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) Then COALESCE(Debet,0)-COALESCE(Kredit,0)else 0  ) SaldoAkhir,

		SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )<CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) then COALESCE(DebetD,0)-COALESCE(KreditD,0) else 0  ) AwalD,

		SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) then COALESCE(H.DebetD,0) else 0  ) JumlahD,

		SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) and H.NoRetur='' then COALESCE(H.KreditD,0) else 0  ) PelunasanD,

		SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) and H.NoRetur<>'' then COALESCE(H.KreditD,0) else 0  ) ReturD,

		sum(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )<=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) Then COALESCE(Debetd,0)-COALESCE(Kreditd,0)else 0  ) SaldoAkhirD

 	,S.USAHA

 	from vwHutpiut H

 	Left Outer Join (Select NoBukti,Tanggal from dbInvoicePL Group By NoBukti,Tanggal)H1 On H1.NoBukti=H.NoFaktur

 	left outer join DBCUSTSUPP S on S.KODECUSTSUPP=H.KodeCustSupp

 	where (CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )<=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) )

 	and H.KodeCustSupp>=@awal and H.KodeCustSupp<=@akhir and H.perkiraan=@perkiraan and H.Tipe='PT' and NoRetur=''

 	group by H.Simbol,H.NoFaktur,H.KodeCustSupp, S.NAMACUSTSUPP, S.Kota,H1.Tanggal,S.USAHA

 	Having SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )<CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) Then COALESCE(H.Debet,0)-COALESCE(H.Kredit,0) else 0  ) <>0 or

		SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) Then COALESCE(H.Debet,0)-Case When TipeTrans='T' Then COALESCE(H.Kredit,0)else 0  else 0  ) <>0 or

		SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) and H.NoRetur='' then COALESCE(H.Kredit,0) else 0  ) <>0 or

		SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) and H.NoRetur<>'' then COALESCE(H.Kredit,0) else 0  ) <>0 or

		sum(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )<=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) Then COALESCE(Debet,0)-COALESCE(Kredit,0)else 0 ) <>0 or

		SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )<CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) then COALESCE(DebetD,0)-COALESCE(KreditD,0) else 0  ) <>0 or

		SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) then COALESCE(H.DebetD,0) else 0  ) <>0 or

		SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) and H.NoRetur='' then COALESCE(H.KreditD,0) else 0  ) <>0 or

		SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) and H.NoRetur<>'' then COALESCE(H.KreditD,0) else 0  ) <>0 or

		sum(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )<=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) Then COALESCE(Debetd,0)-COALESCE(Kreditd,0)else 0  )<>0

 		

 		)a

		Left Outer Join(select NoFaktur,KodeCustSupp,Tanggal,NoBukti,Kredit from vwHutPiut H

		where 

		CAST(,YEAR(Tanggal))+CAST(MONTH(tanggal AS TEXT)))=CAST(,@Tahun)+ CAST(@Bulan AS TEXT))

 	    and H.KodeCustSupp>=@awal and H.KodeCustSupp<=@akhir and H.perkiraan=@perkiraan and H.Tipe='PT' and TipeTrans='L'

 	    )b on a.NoFaktur=b.NoFaktur and a.Kode=b.KodeCustSupp

 	    Left Outer Join(Select NoFaktur,NoRetur,Sum(Kredit)Kredit1,Sum(KreditD)KreditD1 from DBHUTPIUT where NoRetur<>''Group By NoFaktur,NoRetur)H2 On H2.NoFaktur=a.NoFaktur

 	    where  (SaldoAkhir<>0 or  (MONTH(Tanggal)=@Bulan and YEAR(Tanggal)=@Tahun)) 

 	    )a

 	    Left Outer Join (select NoBukti,SUM(DP+Case when Left(NoBukti,2)='CB' Then 0 else (DP*0.1 )) DP from dbInvoicePL Group by NoBukti) b on a.NoFaktur=b.NoBukti

 	    where Kode not in(select Kode from (

Select 	H.Simbol,H.NoFaktur,H.KodeCustSupp Kode, COALESCE(S.NAMACUSTSUPP,'') Nama,H.JatuhTempo, COALESCE(S.Kota,'') Kota,--Min(Urut)Urut,

		SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )<CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) Then COALESCE(H.Debet,0)-COALESCE(H.Kredit,0) else 0  ) Awal,

		SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) Then COALESCE(H.Debet,0)-Case When TipeTrans='T' Then COALESCE(H.Kredit,0)else 0  else 0  ) Jumlah,

		SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) and H.NoRetur='' then COALESCE(H.Kredit,0) else 0  ) Pelunasan,

		SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) and H.NoRetur<>'' then COALESCE(H.Kredit,0) else 0  ) Retur,

		sum(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )<=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) Then COALESCE(Debet,0)-COALESCE(Kredit,0)else 0  ) SaldoAkhir,

		SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )<CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) then COALESCE(DebetD,0)-COALESCE(KreditD,0) else 0  ) AwalD,

		SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) then COALESCE(H.DebetD,0) else 0  ) JumlahD,

		SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) and H.NoRetur='' then COALESCE(H.KreditD,0) else 0  ) PelunasanD,

		SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) and H.NoRetur<>'' then COALESCE(H.KreditD,0) else 0  ) ReturD,

		sum(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )<=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) Then COALESCE(Debetd,0)-COALESCE(Kreditd,0)else 0  ) SaldoAkhirD

 	from vwHutpiut H

 	left outer join DBCUSTSUPP S on S.KODECUSTSUPP=H.KodeCustSupp

 	where (CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )<=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) )

 	and H.KodeCustSupp>=@awal and H.KodeCustSupp<=@akhir and H.perkiraan=@perkiraan and H.Tipe='PT' and NoRetur=''

 	group by H.Simbol,H.NoFaktur,H.KodeCustSupp, S.NAMACUSTSUPP, S.Kota,H.JatuhTempo

 	Having SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )<CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) Then COALESCE(H.Debet,0)-COALESCE(H.Kredit,0) else 0  ) <>0 or

		SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) Then COALESCE(H.Debet,0)-Case When TipeTrans='T' Then COALESCE(H.Kredit,0)else 0  else 0  ) <>0 or

		SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) and H.NoRetur='' then COALESCE(H.Kredit,0) else 0  ) <>0 or

		SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) and H.NoRetur<>'' then COALESCE(H.Kredit,0) else 0  ) <>0 or

		sum(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )<=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) Then COALESCE(Debet,0)-COALESCE(Kredit,0)else 0 ) <>0 or

		SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )<CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) then COALESCE(DebetD,0)-COALESCE(KreditD,0) else 0  ) <>0 or

		SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) then COALESCE(H.DebetD,0) else 0  ) <>0 or

		SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) and H.NoRetur='' then COALESCE(H.KreditD,0) else 0  ) <>0 or

		SUM(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) and H.NoRetur<>'' then COALESCE(H.KreditD,0) else 0  ) <>0 or

		sum(case when CAST(,Case when YEAR(H.Tanggal)=1899 Then @Tahun else YEAR(H.Tanggal))+case when YEAR(H.Tanggal)=1899 and @Bulan<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )when MONTH(H.Tanggal)<10 Then '0'+CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )else CAST(case when YEAR(H.Tanggal AS TEXT)=1899 Then @Bulan else MONTH(H.Tanggal)  )  )<=CAST(,@Tahun)+ case when @Bulan<10 Then '0'+CAST(@Bulan AS TEXT)else CAST(@Bulan AS TEXT)) Then COALESCE(Debetd,0)-COALESCE(Kreditd,0)else 0  )<>0

       

)a

--where 

Group by Kode

having SUM(saldoAkhir)=0 and SUM(Pelunasan)=0



) 

 	    order By Kode--,CAST(,YEAR(JatuhTempo))+CAST(Substring(NoFaktur,9,2 AS TEXT))),SUBSTR(NoFaktur, LENGTH(NoFaktur)-5+1),XURUT;

-- Sp_Set
CREATE PROCEDURE IF NOT EXISTS Sp_Set AS tran

if @Choice='I'

select @Urut=COALESCE(max(Urut),0)+1 from dbSetDet Where KodeSet=@KodeSet

  if not exists(select * from dbSet Where KodeSet=@KodeSet) 

  insert into dbSet (KodeSet)

    values (@KodeSet)

  

  insert into dbSetDet (KodeSet, Urut, KodeBrg, Qnt, Qnt2)

  values(@KodeSet, @Urut, @KodeBrg, @Qnt, @Qnt2)



if @Choice='U'

update dbSetDet set Qnt=@Qnt,KodeBrg=@KodeBrg, qnt2=@Qnt2

  where KodeSet=@KodeSet /*and KodeBrg=@KodeBrg*/ and Urut=@Urut



if @Choice='D'

delete dbSetDet where KodeSet=@KodeSet /*and KodeBrg=@KodeBrg*/ and Urut=@Urut

  if not exists( select KodeSet from dbSetDet where KodeSet=@KodeSet)

  delete dbSet where KodeSet=@KodeSet


if @@error<>0  goto jikasalah

Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- Sp_SetSaldoAwal
CREATE PROCEDURE IF NOT EXISTS Sp_SetSaldoAwal AS tran

 update dbNeraca set AwalDRp=@debetRp,AwalKRp=@KreditRp,AwalD=@DebetD,AwalK=@KreditD,

                     valas=@Valas,kurs=@Kurs

 where Perkiraan=@Perkiraan And Bulan=@Bulan and Tahun=@Tahun and Devisi=@Devisi

 if @@error <> 0 goto jikasalah

commit tran

return

jikasalah:

 rollback tran

 raiserror('Proses Input Data Gagal',16,1)

 return;

-- Sp_SJTransRute
CREATE PROCEDURE IF NOT EXISTS Sp_SJTransRute AS tran

if @Choice='I'

insert into DBSJRUTETRANS (NoSaku, NoSJ, KodeKend, NoPOL, Sopir)

    values (@NoSaku, @NoSJ, @KodeKend, @NoPOL, @Sopir)

  

if @Choice='D'

delete DBSJRUTETRANS where NoSJ=@NoSJ  


if @@error<>0  goto jikasalah

Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- sp_SORev
CREATE PROCEDURE IF NOT EXISTS sp_SORev AS tran  --SELECT * FROM DBSOREV

 if @Urutan =1 

 select @RevisiKe=COALESCE(max(RevisiKe),0)+1 from dbSORev Where NoBukti=@NoBukti

    insert into dbSORev (NOBUKTI, NOURUT, TANGGAL, TglJatuhTempo, KODECUST, Handling, KodeExp, KETERANGAN, 

	FakturCUST, KODEVLS, KURS, PPN, TIPEBAYAR, HARI, TipeDisc, DISC, DiscRp,IsClose,RevisiKe,TanggalRev)

    Select NOBUKTI, NOURUT, TANGGAL, TglJatuhTempo, KODECUST, COALESCE(Handling,0), KodeExp, KETERANGAN,

	'', KODEVLS, KURS, PPN, TIPEBAYAR, HARI, TipeDisc, DISC, DISCRP,0 ISCLOSE,@RevisiKe,datetime('now')

	from dbSO where NOBUKTI=@NoBukti

  

    insert into dbSORevDET (NOBUKTI, URUT,  PPN, Disc, KODEBRG, QNT, NOSAT, ISI, SATUAN, HARGA, DISCP, DISCTOT,NoPPL,IsClose,Catatan,RevisiKe)

    select NOBUKTI, URUT, PPN, Disc, KODEBRG, Qnt, NOSAT, ISI, SATUAN, Harga,0 DISCP, DISCTOT,''NoPPL,0 IsClose,@Catatan,@RevisiKe 

    from DBSODET where NOBUKTI=@NoBukti and URUT=@urut

 

else

 select @RevisiKe=COALESCE(max(RevisiKe),0)+1 from dbSORev Where NoBukti=@NoBukti

    insert into dbSORev (NOBUKTI, NOURUT, TANGGAL, TglJatuhTempo, KODECUST,HANDLING, KodeExp, KETERANGAN, 

	FakturCUST, KODEVLS, KURS, PPN, TIPEBAYAR, HARI, TipeDisc, DISC, DiscRp,IsClose,RevisiKe,TanggalRev)

    Select NOBUKTI, NOURUT, TANGGAL, TglJatuhTempo, KODECUST,  COALESCE(Handling,0), KodeExp, KETERANGAN,

	'', KODEVLS, KURS, PPN, TIPEBAYAR, HARI, TipeDisc, DISC, DISCRP,0 IsClose,@RevisiKe,datetime('now')

	from dbSO where NOBUKTI=@NoBukti

	-------

	insert into dbSORevDET (NOBUKTI, URUT,  PPN, Disc, KODEBRG, QNT, NOSAT, ISI, SATUAN, HARGA, DISCP, DISCTOT,NoPPL,IsClose,Catatan,RevisiKe)

    select NOBUKTI, URUT, PPN, Disc, KODEBRG, Qnt, NOSAT, ISI, SATUAN, Harga,0 DISCP, DISCTOT,''NoPPL,0 IsClose,@Catatan,@RevisiKe 

    from DBSODET where NOBUKTI=@NoBukti


exec [sp_UpdateTransaksiPPN] 'dbSORevDET','dbSORev',@NoBukti

 

if @@error<>0  goto jikasalah

Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- Sp_SPBLampiran
CREATE PROCEDURE IF NOT EXISTS Sp_SPBLampiran AS tran

if @Choice='I'

Select @urut=MAX(urut) from DBSPBLampiran where NoSPB=@NoEnquiryDet and UrutSPB=@UrutEnq

  -- SET REMOVEDISNULL(@urut,0)+1

  Insert into DBSPBLampiran (urut, NoSPB, UrutSPB, NOLOT, NOPALLET, NOROLL, NetW, GrossW, Sat_1, Sat_2, Qnt, Qnt2, Nosat, Isi, Keterangan)

  values (@urut,@NoEnquiryDet,@UrutEnq,@noLot, @noPallet, @NoRoll,@NetW, @GrossW, @Sat_1, @Sat_2, @Qnt, @qnt2, @Nosat, @Isi, @Keterangan)



else if @Choice='U'

update DBSPBLampiran set NOLOT=@noLot, NOPALLET=@noPallet, NOROLL=@NoRoll, NetW=@NetW, GrossW=@GrossW, 

                           Qnt=@qnt, qnt2=@qnt2, Sat_1=@Sat_1, Sat_2=@Sat_2, 

                           Nosat=@Nosat, isi=@isi, Keterangan=@Keterangan

  where urut=@urut and NoSPB=@NoEnquiryDet and UrutSPB=@UrutEnq



else if @Choice='D'

delete DBSPBLampiran where urut=@urut and NoSPB=@NoEnquiryDet and UrutSPB=@UrutEnq



if @@ERROR<>0 goto JikaSalah

Commit Tran

Return

JikaSalah: Rollback Tran

           Return;

-- Sp_SPBRJUAL
CREATE PROCEDURE IF NOT EXISTS Sp_SPBRJUAL AS tran

   if @Choice='I'

   select @Urut=COALESCE(max(urut),0)+1 from dbSPBRJUALDet Where NoBukti=@NoBukti

  	   if @IsEmpty=0 

  	   insert into dbSPBRJUAL (Devisi,NoBukti, NoUrut, Tanggal, NoRPJ, KodeCustSupp, NoPolKend, 

    		    Container, NoContainer, NoSeal,Catatan, IDUser, Sopir, ISFlag)

		   values (@Devisi,@NoBukti, @NoUrut, @Tanggal, @NoRPJ, @KodeCustSupp, @NoPolKend, 

    		    @Container, @NoContainer, @NoSeal, @Catatan, @IDUser, @Sopir, @Flagmenu)

		--   if @@error<>0  goto jikasalah


  	   insert into dbSPBRJUALDet (NoBukti, Urut, NoRPJ, UrutRPJ, KodeBrg, QNT, QNT2, SAT_1, SAT_2, NOSAT, ISI, NetW, GrossW, Namabrg, KodeGdg)

	   values (@NoBukti, @Urut, @NoRPJ, @UrutRPJ, @KodeBrg,  @QNT, @QNT2, @SAT_1, @SAT_2, @NOSAT, @ISI, @NetW, @GrossW, @Namabrg, @kodegdg)

	   --if @@error<>0  goto jikasalah

   

   if @Choice='U'

   update dbSPBRJUALDET set KodeBrg=@KodeBrg, QNT=@QNT, QNT2=@QNT2, SAT_1=@SAT_1, SAT_2=@SAT_2, NOSAT=@NOSAT, ISI=@ISI, Namabrg=@Namabrg,

  					   NetW=@NetW, GrossW=@GrossW, KodeGdg=@kodegdg

  	   where NoBukti=@NoBukti and Urut=@Urut

	   if @@error<>0  goto jikasalah

   

   if @Choice='D'

   delete dbSPBRJUALDET where NoBukti=@NoBukti and Urut=@Urut 

	   if @@error<>0  goto jikasalah

  	   if not exists (select NoBukti from dbSPBRJUALDET where NoBukti=@NoBukti)

  	   delete dbSPBRJUAL where NoBukti=@NoBukti

             if @@error<>0  goto jikasalah


Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- Sp_SPK
CREATE PROCEDURE IF NOT EXISTS Sp_SPK AS -- DECLARE REMOVED

tran

if @choice='I'

select @UrutMM=COALESCE(max(urut),0)+1 from DBSPKMDET   Where NoBukti=@NoBukti

  	select @UrutMM=COALESCE(@UrutMM,1)

  	select @urut=COALESCE(max(urut),0)+1 from dbSPKDet   Where NoBukti=@NoBukti

  	select @Urut=COALESCE(@Urut,1)

	if not exists(select * from dbSPK Where NoBukti=@NoBukti) 

  	insert into dbSPK (Devisi,NoBukti, NoUrut, Tanggal, KodeBrg, Qnt, NoSat, Isi, Satuan, IsCLose, NoBatch, TglExpired,NOSO)

		values (@devisi,@NoBukti, @NoUrut, @Tanggal, @KodeBrgJ, @QntJ, @NoSatJ, @IsiJ, @SatJ, 0, @NoBatch, @TglExpired,@NOSO)

		if @@error<>0  goto jikasalah

  	

  	if @Tipe='M' 

  	insert into dbSPKMDet (NoBukti, Urut, KodeBrg, SATUAN, Isi, Qnt, nosat)

	values (@NoBukti, @UrutMM, @KodeBrg, @Satuan, @Isi, @Qnt,  @Nosat)

  	

  	else if @Tipe='D'

  	insert into dbSPKDet (NoBukti, Urut, KodeBrg, SATUAN, Isi, Qnt, nosat,UrutM)

	values (@NoBukti, @Urut, @KodeBrg, @Satuan, @Isi, @Qnt,  @Nosat,@UrutM)

	

	if @@error<>0  goto jikasalah



if @choice='U'

if @Tipe='M' 

  	update 	dbSPKDet 

 	set	KodeBrg=@KodeBrg, Satuan=@Satuan, Isi=@Isi, Qnt=@Qnt, 

	    nosat=@Nosat

  	where 	NoBukti=@NoBukti and Urut=@Urut

      

  	else

   --if @Tipe='D'

   update 	dbSPKDet 

	set	KodeBrg=@KodeBrg, Satuan=@Satuan, Isi=@Isi, Qnt=@Qnt, 

	    nosat=@Nosat,URUTM=@UrutM

  	where 	NoBukti=@NoBukti and Urut=@Urut

   

	if @@error<>0  goto jikasalah



if @choice='D'

if @Tipe='M'

   delete dbSPKMDet where nobukti=@nobukti and  urut=@UrutM

   

   else

   if @Tipe='D'

   delete dbSPKDet where nobukti=@nobukti and  urut=@urut and urutM=@UrutM

   

	if @@error<>0  goto jikasalah 

  	if not exists( select nobukti from DBSPKMDET where nobukti=@nobukti)

  	delete dbSPK where nobukti=@nobukti

		if @@error<>0  goto jikasalah


if @@error<>0  goto jikasalah

Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- Sp_SPKBatal
CREATE PROCEDURE IF NOT EXISTS Sp_SPKBatal AS tran

if @choice='U'

update 	DBSPKMDET set	QntBatal=@Qnt

  	where 	NoBukti=@NoBukti and Urut=@Urut


if @@error<>0  goto jikasalah

Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- Sp_SubJnsBarang
CREATE PROCEDURE IF NOT EXISTS Sp_SubJnsBarang AS tran

if @choice='I'

insert into dbSubJenis (KodeSubJnsBrg, Keterangan,KodeJnsBrg)

	values (@KodeSubJnsBrg, @Keterangan,@KodeJnsBrg)

	if @@error <> 0 goto jikasalah



if @choice='U'

update dbSubJenis set Keterangan=@Keterangan ,KodeJnsBrg=@KodeJnsbrg,KodeSubJnsBrg=@KodeSubJnsBrg

             where KodeSubJnsBrg=@OldKode

	if @@error <> 0 goto jikasalah



if @choice='D'

delete  dbSubJenis where KodeSubJnsBrg=@OldKode

	if @@error <> 0 goto jikasalah



commit tran

return

jikasalah:

	rollback tran

	raiserror('Proses Input Data Gagal',16,1)

	return;

-- SP_Supplier
CREATE PROCEDURE IF NOT EXISTS SP_Supplier AS tran

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

                           KodeDealer,IsPelanggan,IsPPH21,Tf,Do)

  	values(@KodeCustSupp, @NamaCustSupp, @Usaha, @Alamat1, @Alamat2, @KodeKota, @KodePos, @Negara, 

		   @Telpon, @Fax, @Email, @NPWP, @Tanggal, @Plafon, @Hari, @Berikat, @Jenis,

           @NamaPKP, @AlamatPkp1, @Alamatpkp2, @KotaPkp, @Sales,@kodevls,@Perkiraan, @KodeTipe, 0,@Kind,@HariHutPiut,

           @ContactP,@Alamat1ContP,@Alamat2ContP,@KotaContP,@NegaraContP,@TelpContP,@FaxContP,@EmailContP,

           @KODEPOSContP,@HPContP,@SyaratPenerimaan,@SyaratPembayaran,@Agent,@Alamat1A,@Alamat2A,@KotaA,@NegaraA,

           @ContactA,@TelpA,@FaxA,@EmailA,@KODEPOSA,@HPA,@EmailContA,@IsAktif,

           @PortOfLoading, @CountryOfOrigin,@IsKontrak,datetime('now'),@PPN, @HargaKe,@Att,@Bank,@NoACC,

           @KodeJenis,@KodeBank,@Kodedealer,@IsPelanggan,@IsPPh21,0,@Mode)

    --if not exists (Select * from DBALAMATCUST where KODECUSTSUPP=@KodeCustSupp)

    ----   insert into DBALAMATCUST(Nomor,KODECUSTSUPP,Nama,Alamat,Telp,Fax)

    --   Values(0,@KodeCustSupp,@NamaCustSupp,@AlamatCust, @Telpon, @Fax)

    --



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

  						  ISpelanggan=@IsPelanggan,IsPPh21=@IsPPh21,Tf=0,Do=@Mode

  	where KodeCustSupp=@KodeCustSupp

  	--if not exists (Select * from DBALAMATCUST where KODECUSTSUPP=@KodeCustSupp)

    ----   insert into DBALAMATCUST(Nomor,KODECUSTSUPP,Nama,Alamat,Telp,Fax)

    --   Values(0,@KodeCustSupp,@NamaCustSupp,@AlamatCust, @Telpon, @Fax)

    --

    --else

    ---- update DBALAMATCUST set Nama=@NamaCustSupp, Alamat=@AlamatCust, Telp=@Telpon, Fax=@Fax

    -- where KODECUSTSUPP=@OldKode and Nomor=0

    --



if @Mode='D'

Delete dbCustSupp 

    	where KodeCustSupp=@OldKode and Kind=@kind

     insert TempDelData

     select @OldKode,'dbGudang'



if @@error <> 0 goto JikaSalah

commit tran

return

JikaSalah:  rollback tran

            return;

-- sp_SyaratSO
CREATE PROCEDURE IF NOT EXISTS sp_SyaratSO AS Tran

If @Choice='I'

Insert Into dbSyaratSO(NoBukti,Ket1,Ket2,Ket3,Ket4,Ket5,Ket6,ket7,Ket8,Ket9,Ket10,Ket11,Ket12,Ket13,

	IsCek11,

	IsCek12,

	IsCek13,

	Bank11,

	DP,

	Sisa,

	Bank12,

	Ket14,

	RpOperator,

	RpHelper,

	Mob,

	RpSewa,

	RpOV,

	PPH,

	RpOSAlat,

	NamaAlat,

	IcCek1,

	IcCek2,

	IcCek3,

	IcCek4,

	IcCek5,

	IcCek6,

	IcCek7,

	IcCek8,

	IcCek9,

	IcCek10,

	IcCek11,

	IcCek13,

	IsCek51,IsCek52,IsCek53,IcCek14)

 Values(@NoBukti,@Ket1,@Ket2,@Ket3,@Ket4,@Ket5,@Ket6,@ket7,@Ket8,@Ket9,@Ket10,@Ket11,@Ket12,@Ket13,

	@IsCek12,

	@IsCek12,

	@IsCek13,

	@Bank11,

	@DP,

	@Sisa,

	@Bank12,

	@Ket14,

	@RpOperator,

	@RpHelper,

	@Mob,

	@RpSewa,

	@RpOV,

	@PPH,

	@RpOSAlat,

	@NamaAlat,

	@IcCek1,

	@IcCek2,

	@IcCek3,

	@IcCek4,

	@IcCek5,

	@IcCek6,

	@IcCek7,

	@IcCek8,

	@IcCek9,

	@IcCek10,

	@IcCek11,

	@IcCek13,@IsCek51,@IsCek52,@IsCek53,@IcCek14)



else if @Choice='U'

Update dbSyaratSO set Ket1=@Ket1,Ket2=@Ket2,Ket3=@Ket3,Ket4=@Ket4,Ket5=@Ket5,Ket6=@Ket6,ket7=@ket7,Ket8=@Ket8,Ket9=@Ket9,Ket10=@Ket10,Ket11=@Ket11,Ket12=@Ket12,Ket13=@Ket13,

	IsCek11=@IsCek11,

	IsCek12=@IsCek12,

	IsCek13=@IsCek13,

	Bank11=@Bank11,

	DP=@DP,

	Sisa=@Sisa,

	Bank12=@Bank12,

	Ket14=@Ket14,

	RpOperator=@RpOperator,

	RpHelper=@RpHelper,

	Mob=@Mob,

	RpSewa=@RpSewa,

	RpOV=@RpOV,

	PPH=@PPH,

	RpOSAlat=@RpOSAlat,

	NamaAlat=@NamaAlat,

	IcCek1=@IcCek1,

	IcCek2=@IcCek2,

	IcCek3=@IcCek3,

	IcCek4=@IcCek4,

	IcCek5=@IcCek5,

	IcCek6=@IcCek6,

	IcCek7=@IcCek7,

	IcCek8=@IcCek8,

	IcCek9=@IcCek9,

	IcCek10=@IcCek10,

	IcCek11=@IcCek11,

	IcCek13=@IcCek13,

	IsCek51=@IsCek51,IsCek52=@IsCek52,IsCek53=@IsCek53,IcCek14=@IcCek14

where NoBukti=@NoBukti


if @@error<>0  goto jikasalah

Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- sp_TarifJenisKend
CREATE PROCEDURE IF NOT EXISTS sp_TarifJenisKend AS tran

if @choice='I'

insert into dbTarifJenisKend (KODEJENISKEND, Urut, UrutTrans, NamaTarif, RpTarif)

	values (@KODEJENISKEND, @Urut, @UrutTrans, @NAMATarif, @RpTarif)

	if @@error <> 0 goto jikasalah



if @choice='U'

update dbTarifJenisKend set UrutTrans=@UrutTrans, NamaTarif=@NAMATarif, RpTarif=@RpTarif

    where KODEJENISKEND=@KODEJENISKEND and Urut=@Urut

	if @@error <> 0 goto jikasalah



if @choice='D'

delete  dbTarifJenisKend where KODEJENISKEND=@KODEJENISKEND and Urut=@Urut

	if @@error <> 0 goto jikasalah



commit tran

return

jikasalah:

	rollback tran

	raiserror('Proses Input Data Gagal',16,1)

	return;

-- Sp_TARIFRUTE
CREATE PROCEDURE IF NOT EXISTS Sp_TARIFRUTE AS tran

if @choice='I'

insert into DBTARIFRUTE (KODERUTE, KODEJENISKEND,SOLAR,SUPIR,SOLARCRANE,OPCRANE,KULI,TIMBANG,ALL_IN,UANGMAKAN)

	values (@KODERUTE, @KODEJENISKEND,@SOLAR,@SUPIR,@SOLARCRANE,@OPCRANE,@KULI,@TIMBANG,@AllIN,@UANGMAKAN)

	if @@error <> 0 goto jikasalah



if @choice='U'

update DBTARIFRUTE set SOLAR=@SOLAR,SUPIR=@SUPIR,SOLARCRANE=@SOLARCRANE,OPCRANE=@OPCRANE,KULI=@KULI,TIMBANG=@TIMBANG

	,ALL_IN=@AllIN,UANGMAKAN=@UANGMAKAN

             where KODERUTE=@KODERUTE AND KODEJENISKEND=@KODEJENISKEND

	if @@error <> 0 goto jikasalah



if @choice='D'

delete  DBTARIFRUTE where KODERUTE=@KODERUTE AND KODEJENISKEND=@KODEJENISKEND

	if @@error <> 0 goto jikasalah



commit tran

return

jikasalah:

	rollback tran

	raiserror('Proses Input Data Gagal',16,1)

	return;

-- sp_TarifSubKota
CREATE PROCEDURE IF NOT EXISTS sp_TarifSubKota AS tran

if @choice='I'

insert into dbTarifSubKota (KodeSubKota, NamaSubKota, KodeKota, RpTarif)

	values (@KodeSubKota, @NamaSubKota, @KodeKota, @RpTarif)

	if @@error <> 0 goto jikasalah



if @choice='U'

update dbTarifSubKota set NamaSubKota=@NamaSubKota, KodeKota=@KodeKota, RpTarif=@RpTarif

    where KodeSubKota=@KODESubKota

	if @@error <> 0 goto jikasalah



if @choice='D'

delete  dbTarifSubKota where KodeSubKota=@KODESubKota

	if @@error <> 0 goto jikasalah



commit tran

return

jikasalah:

	rollback tran

	raiserror('Proses Input Data Gagal',16,1)

	return;

-- sp_TempHutPiut
CREATE PROCEDURE IF NOT EXISTS sp_TempHutPiut AS tran

if @Choice='I'

select @Urut=Max(Urut) 

	from DBTempHUTPIUT 

	where KodeCustSupp=@KodeCustSupp and NoFaktur=@NoFaktur 

	-- SET REMOVEDisnull(@Urut,0)+1

	insert into DBTempHUTPIUT (NoFaktur, NoRetur, TipeTrans, KodeCustSupp, 

	NoBukti, NoMsk, Urut, 

	Tanggal, JatuhTempo, Debet, Kredit, Valas, Kurs, DebetD, KreditD, 

	KodeSales, Tipe, Perkiraan, Catatan, IDUser, StatusUID, TipeDK,

	NoInvoice, Valas_, Kurs_, KursBayar,FlagSimbol)

	values (@NoFaktur, @NoRetur, @TipeTrans, @KodeCustSupp, 

	@NoBukti, @NoMsk, @Urut, 

	@Tanggal, @JatuhTempo, @Debet*@Kurs, @Kredit*@Kurs, @Valas, @Kurs, 

	case when @Valas='IDR' then @DebetD else @Debet , 

	case when @Valas='IDR' then @KreditD else @Kredit , 

	@KodeSales, @Tipe, @Perkiraan, @Catatan, @IDUser, 'I', @TipeDK,

	@NoInvoice, @Valas_, @Kurs_, @KursBayar,@FlagSimbol)

	if @@error<>0  goto jikasalah



if @choice='U'

update DBTempHUTPIUT 

	set Tanggal=@Tanggal, JatuhTempo=@JatuhTempo, Debet=@Debet*@Kurs, Kredit=@Kredit*@Kurs, Valas=@Valas, Kurs=@Kurs, 

	DebetD=case when @Valas='IDR' then 0 else @Debet , KreditD=case when @Valas='IDR' then 0 else @Kredit , 

	KodeSales=@KodeSales, Tipe=@Tipe, Catatan=@Catatan, StatusUID='U'  

	where NoFaktur=@NoFaktur and NoRetur=@NoRetur and TipeTrans=@TipeTrans and KodeCustSupp=@KodeCustSupp and NoBukti=@NoBukti

	and Perkiraan=@Perkiraan and IDUser=@IDUser and NoMsk=@NoMsk and Urut=@Urut 



if @choice='D'

update DBTempHUTPIUT 

	set StatusUID='D'  

	where NoFaktur=@NoFaktur and NoRetur=@NoRetur and TipeTrans=@TipeTrans and KodeCustSupp=@KodeCustSupp and NoBukti=@NoBukti

	and Perkiraan=@Perkiraan and IDUser=@IDUser and NoMsk=@NoMsk and Urut=@Urut


if @@error<>0  goto jikasalah



Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- sp_TempSOTerpasang
CREATE PROCEDURE IF NOT EXISTS sp_TempSOTerpasang AS Delete TempSOTerpasang where UserId=@UserID

Insert Into TempSOTerpasang

select NOBUKTI,@UserID from DBSODET 

Group By NOBUKTI

Having MAX(COALESCE(KodeBrgM,''))<>'';

-- sp_TFMaster
CREATE PROCEDURE IF NOT EXISTS sp_TFMaster AS -- Batch submitted through debugger: SQLQuery1.sql|7|0|C:\Users\Administrator\AppData\Local\Temp\1\~vs7418.sql

/* INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[DBNOMORPK]

           ([Tipe]

           ,[NOURUT]

           ,[NOBUKTI]

           ,[USERID]

           ,[Bulan]

           ,[Tahun])

  select [Tipe]

           ,[NOURUT]

           ,[NOBUKTI]

           ,[USERID]

           ,[Bulan]

           ,[Tahun]

           from DBNOMORPK

           where NOBUKTI not in (select NOBUKTI from [36.64.152.3].[DBBCAGROUP].[dbo].[DBNOMORPK])

  INSERT INTO [DBNOMORPK]

           ([Tipe]

           ,[NOURUT]

           ,[NOBUKTI]

           ,[USERID]

           ,[Bulan]

           ,[Tahun])

  select [Tipe]

           ,[NOURUT]

           ,[NOBUKTI]

           ,[USERID]

           ,[Bulan]

           ,[Tahun]

           from [36.64.152.3].[DBBCAGROUP].[dbo].DBNOMORPK

           where NOBUKTI not in (select NOBUKTI from [DBNOMORPK])*/

  --kunci periode

  insert [36.64.152.3].dbbcagroup.dbo.dbLockPeriode

  select * from DBLOCKPERIODE where cast(BULAN as varchar(2))+cast(TAHUN as varchar(4)) not in (select cast(BULAN as varchar(2))+cast(TAHUN as varchar(4)) from [36.64.152.3].dbbcagroup.dbo.DBLOCKPERIODE )

  delete [36.64.152.3].dbbcagroup.dbo.dbLockPeriode where cast(BULAN as varchar(2))+cast(TAHUN as varchar(4)) in

   (select cast(BULAN as varchar(2))+cast(TAHUN as varchar(4)) from [36.64.152.3].dbbcagroup.dbo.DBLOCKPERIODE where cast(BULAN as varchar(2))+cast(TAHUN as varchar(4)) not in 

      (select cast(BULAN as varchar(2))+cast(TAHUN as varchar(4)) from dbbcagroup.dbo.DBLOCKPERIODE))

 

 --set pemakai

 -- DECLARE REMOVED,@Do char(1),@Urut int

 --master supplier

Declare MySikron Cursor for

   select KodeCustSupp,Do from dbCustSupp where COALESCE(tf,0)=0 and KodeCustSupp not in (select KodeCustSupp from [36.64.152.3].[DBBCAGROUP].[dbo].[dbCustSupp])

   union all

   select Nobukti,'D' from TempDelData where tabel='dbCustSupp'

 Open MySikron

 Fetch Next from MySikron into @Nobukti, @Do

 While @@fetch_Status=0

 if @Do='I'

   INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[dbCustSupp]

    ([KODECUSTSUPP]

           ,[NAMACUSTSUPP]

           ,[ALAMAT1]

           ,[ALAMAT2]

           ,[Kota]

           ,[TELPON]

           ,[FAX]

           ,[EMAIL]

           ,[KODEPOS]

           ,[NEGARA]

           ,[NPWP]

           ,[Tanggal]

           ,[PLAFON]

           ,[HARI]

           ,[HARIHUTPIUT]

           ,[BERIKAT]

           ,[USAHA]

           ,[PERKIRAAN]

           ,[JENIS]

           ,[NAMAPKP]

           ,[ALAMATPKP1]

           ,[ALAMATPKP2]

           ,[KOTAPKP]

           ,[Sales]

           ,[KodeVls]

           ,[KodeExp]

           ,[KodeTipe]

           ,[IsPpn]

           ,[IsAktif]

           ,[Kind]

           ,[ContactP]

           ,[Alamat1ContP]

           ,[Alamat2ContP]

           ,[KotaContP]

           ,[NegaraContP]

           ,[TelpContP]

           ,[FaxContP]

           ,[EmailContP]

           ,[KODEPOSContP]

           ,[HPContP]

           ,[SyaratPenerimaan]

           ,[SyaratPembayaran]

           ,[Agent]

           ,[Alamat1A]

           ,[Alamat2A]

           ,[KotaA]

           ,[NegaraA]

           ,[ContactA]

           ,[TelpA]

           ,[FaxA]

           ,[EmailA]

           ,[KODEPOSA]

           ,[HPA]

           ,[EmailContA]

           ,[PortOfLoading]

           ,[CountryOfOrigin]

           ,[TglInput]

           ,[iskontrak]

           ,[PPN]

           ,[HargaKe]

           ,[Att]

           ,[bank]

           ,[NoAcc]

           ,[KodeJenis]

           ,[KodeBank]

           ,[komisi]

           ,[IsPelanggan]

           ,[KodeDealer]

           ,[IsPPH21])

     select [KODECUSTSUPP]

           ,[NAMACUSTSUPP]

           ,[ALAMAT1]

           ,[ALAMAT2]

           ,[Kota]

           ,[TELPON]

           ,[FAX]

           ,[EMAIL]

           ,[KODEPOS]

           ,[NEGARA]

           ,[NPWP]

           ,[Tanggal]

           ,[PLAFON]

           ,[HARI]

           ,[HARIHUTPIUT]

           ,[BERIKAT]

           ,[USAHA]

           ,[PERKIRAAN]

           ,[JENIS]

           ,[NAMAPKP]

           ,[ALAMATPKP1]

           ,[ALAMATPKP2]

           ,[KOTAPKP]

           ,[Sales]

           ,[KodeVls]

           ,[KodeExp]

           ,[KodeTipe]

           ,[IsPpn]

           ,[IsAktif]

           ,[Kind]

           ,[ContactP]

           ,[Alamat1ContP]

           ,[Alamat2ContP]

           ,[KotaContP]

           ,[NegaraContP]

           ,[TelpContP]

           ,[FaxContP]

           ,[EmailContP]

           ,[KODEPOSContP]

           ,[HPContP]

           ,[SyaratPenerimaan]

           ,[SyaratPembayaran]

           ,[Agent]

           ,[Alamat1A]

           ,[Alamat2A]

           ,[KotaA]

           ,[NegaraA]

           ,[ContactA]

           ,[TelpA]

           ,[FaxA]

           ,[EmailA]

           ,[KODEPOSA]

           ,[HPA]

           ,[EmailContA]

           ,[PortOfLoading]

           ,[CountryOfOrigin]

           ,[TglInput]

           ,[iskontrak]

           ,[PPN]

           ,[HargaKe]

           ,[Att]

           ,[bank]

           ,[NoAcc]

           ,[KodeJenis]

           ,[KodeBank]

           ,[komisi]

           ,[IsPelanggan]

           ,[KodeDealer]

           ,[IsPPH21] from dbCustSupp where KodeCustSupp=@Nobukti

     update DBCUSTSUPP set Tf=1 where KodeCustSupp in (select KodeCustSupp from [36.64.152.3].[DBBCAGROUP].[dbo].[dbCustSupp] where KodeCustSupp=@Nobukti) 

    else

   if @Do='U'

   Update [36.64.152.3].[DBBCAGROUP].[dbo].[dbCustSupp] set 

           [NAMACUSTSUPP]=b.[NAMACUSTSUPP]

           ,[ALAMAT1]=b.[ALAMAT1]

           ,[ALAMAT2]=b.[ALAMAT2]

           ,[Kota]=b.[Kota]

           ,[TELPON]=b.[TELPON]

           ,[FAX]=b.[FAX]

           ,[EMAIL]=b.[EMAIL]

           ,[KODEPOS]=b.[KODEPOS]

           ,[NEGARA]=b.[NEGARA]

           ,[NPWP]=b.[NPWP]

           ,[Tanggal]=b.[Tanggal]

           ,[PLAFON]=b.[PLAFON]

           ,[HARI]=b.[HARI]

           ,[HARIHUTPIUT]=b.[HARIHUTPIUT]

           ,[BERIKAT]=b.[BERIKAT]

           ,[USAHA]=b.[USAHA]

           ,[PERKIRAAN]=b.[PERKIRAAN]

           ,[JENIS]=b.[JENIS]

           ,[NAMAPKP]=b.[NAMAPKP]

           ,[ALAMATPKP1]=b.[ALAMATPKP1]

           ,[ALAMATPKP2]=b.[ALAMATPKP2]

           ,[KOTAPKP]=b.[KOTAPKP]

           ,[Sales]=b.[Sales]

           ,[KodeVls]=b.[KodeVls]

           ,[KodeExp]=b.[KodeExp]

           ,[KodeTipe]=b.[KodeTipe]

           ,[IsPpn]=b.[IsPpn]

           ,[IsAktif]=b.[IsAktif]

           ,[Kind]=b.[Kind]

           ,[ContactP]=b.[ContactP]

           ,[Alamat1ContP]=b.[Alamat1ContP]

           ,[Alamat2ContP]=b.[Alamat2ContP]

           ,[KotaContP]=b.[KotaContP]

           ,[NegaraContP]=b.[NegaraContP]

           ,[TelpContP]=b.[TelpContP]

           ,[FaxContP]=b.[FaxContP]

           ,[EmailContP]=b.[EmailContP]

           ,[KODEPOSContP]=b.[KODEPOSContP]

           ,[HPContP]=b.[HPContP]

           ,[SyaratPenerimaan]=b.[SyaratPenerimaan]

           ,[SyaratPembayaran]=b.[SyaratPembayaran]

           ,[Agent]=b.[Agent]

           ,[Alamat1A]=b.[Alamat1A]

           ,[Alamat2A]=b.[Alamat2A]

           ,[KotaA]=b.[KotaA]

           ,[NegaraA]=b.[NegaraA]

           ,[ContactA]=b.[ContactA]

           ,[TelpA]=b.[TelpA]

           ,[FaxA]=b.[FaxA]

           ,[EmailA]=b.[EmailA]

           ,[KODEPOSA]=b.[KODEPOSA]

           ,[HPA]=b.[HPA]

           ,[EmailContA]=b.[EmailContA]

           ,[PortOfLoading]=b.[PortOfLoading]

           ,[CountryOfOrigin]=b.[CountryOfOrigin]

           ,[TglInput]=b.[TglInput]

           ,[iskontrak]=b.[iskontrak]

           ,[PPN]=b.[PPN]

           ,[HargaKe]=b.[HargaKe]

           ,[Att]=b.[Att]

           ,[bank]=b.[bank]

           ,[NoAcc]=b.[NoAcc]

           ,[KodeJenis]=b.[KodeJenis]

           ,[KodeBank]=b.[KodeBank]

           ,[komisi]=b.[komisi]

           ,[IsPelanggan]=b.[IsPelanggan]

           ,[KodeDealer]=b.[KodeDealer]

           ,[IsPPH21]=b.[IsPPH21]

      from [36.64.152.3].[DBBCAGROUP].[dbo].[dbCustSupp] a

      left outer join 

        (select [KODECUSTSUPP]

           ,[NAMACUSTSUPP]

           ,[ALAMAT1]

           ,[ALAMAT2]

           ,[Kota]

           ,[TELPON]

           ,[FAX]

           ,[EMAIL]

           ,[KODEPOS]

           ,[NEGARA]

           ,[NPWP]

           ,[Tanggal]

           ,[PLAFON]

           ,[HARI]

           ,[HARIHUTPIUT]

           ,[BERIKAT]

           ,[USAHA]

           ,[PERKIRAAN]

           ,[JENIS]

           ,[NAMAPKP]

           ,[ALAMATPKP1]

           ,[ALAMATPKP2]

           ,[KOTAPKP]

           ,[Sales]

           ,[KodeVls]

           ,[KodeExp]

           ,[KodeTipe]

           ,[IsPpn]

           ,[IsAktif]

           ,[Kind]

           ,[ContactP]

           ,[Alamat1ContP]

           ,[Alamat2ContP]

           ,[KotaContP]

           ,[NegaraContP]

           ,[TelpContP]

           ,[FaxContP]

           ,[EmailContP]

           ,[KODEPOSContP]

           ,[HPContP]

           ,[SyaratPenerimaan]

           ,[SyaratPembayaran]

           ,[Agent]

           ,[Alamat1A]

           ,[Alamat2A]

           ,[KotaA]

           ,[NegaraA]

           ,[ContactA]

           ,[TelpA]

           ,[FaxA]

           ,[EmailA]

           ,[KODEPOSA]

           ,[HPA]

           ,[EmailContA]

           ,[PortOfLoading]

           ,[CountryOfOrigin]

           ,[TglInput]

           ,[iskontrak]

           ,[PPN]

           ,[HargaKe]

           ,[Att]

           ,[bank]

           ,[NoAcc]

           ,[KodeJenis]

           ,[KodeBank]

           ,[komisi]

           ,[IsPelanggan]

           ,[KodeDealer]

           ,[IsPPH21]

     from dbCustSupp where KodeCustSupp=@Nobukti ) B on b.KodeCustSupp=a.KodeCustSupp where a.KodeCustSupp=@Nobukti

      

      if not exists(select KodeCustSupp from [36.64.152.3].[DBBCAGROUP].[dbo].[dbCustSupp] where KodeCustSupp=@Nobukti) 

      INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[dbCustSupp]

    ([KODECUSTSUPP]

           ,[NAMACUSTSUPP]

           ,[ALAMAT1]

           ,[ALAMAT2]

           ,[Kota]

           ,[TELPON]

           ,[FAX]

           ,[EMAIL]

           ,[KODEPOS]

           ,[NEGARA]

           ,[NPWP]

           ,[Tanggal]

           ,[PLAFON]

           ,[HARI]

           ,[HARIHUTPIUT]

           ,[BERIKAT]

           ,[USAHA]

           ,[PERKIRAAN]

           ,[JENIS]

           ,[NAMAPKP]

           ,[ALAMATPKP1]

           ,[ALAMATPKP2]

           ,[KOTAPKP]

           ,[Sales]

           ,[KodeVls]

           ,[KodeExp]

           ,[KodeTipe]

           ,[IsPpn]

           ,[IsAktif]

           ,[Kind]

           ,[ContactP]

           ,[Alamat1ContP]

           ,[Alamat2ContP]

           ,[KotaContP]

           ,[NegaraContP]

           ,[TelpContP]

           ,[FaxContP]

           ,[EmailContP]

           ,[KODEPOSContP]

           ,[HPContP]

           ,[SyaratPenerimaan]

           ,[SyaratPembayaran]

           ,[Agent]

           ,[Alamat1A]

           ,[Alamat2A]

           ,[KotaA]

           ,[NegaraA]

           ,[ContactA]

           ,[TelpA]

           ,[FaxA]

           ,[EmailA]

           ,[KODEPOSA]

           ,[HPA]

           ,[EmailContA]

           ,[PortOfLoading]

           ,[CountryOfOrigin]

           ,[TglInput]

           ,[iskontrak]

           ,[PPN]

           ,[HargaKe]

           ,[Att]

           ,[bank]

           ,[NoAcc]

           ,[KodeJenis]

           ,[KodeBank]

           ,[komisi]

           ,[IsPelanggan]

           ,[KodeDealer]

           ,[IsPPH21])

     select [KODECUSTSUPP]

           ,[NAMACUSTSUPP]

           ,[ALAMAT1]

           ,[ALAMAT2]

           ,[Kota]

           ,[TELPON]

           ,[FAX]

           ,[EMAIL]

           ,[KODEPOS]

           ,[NEGARA]

           ,[NPWP]

           ,[Tanggal]

           ,[PLAFON]

           ,[HARI]

           ,[HARIHUTPIUT]

           ,[BERIKAT]

           ,[USAHA]

           ,[PERKIRAAN]

           ,[JENIS]

           ,[NAMAPKP]

           ,[ALAMATPKP1]

           ,[ALAMATPKP2]

           ,[KOTAPKP]

           ,[Sales]

           ,[KodeVls]

           ,[KodeExp]

           ,[KodeTipe]

           ,[IsPpn]

           ,[IsAktif]

           ,[Kind]

           ,[ContactP]

           ,[Alamat1ContP]

           ,[Alamat2ContP]

           ,[KotaContP]

           ,[NegaraContP]

           ,[TelpContP]

           ,[FaxContP]

           ,[EmailContP]

           ,[KODEPOSContP]

           ,[HPContP]

           ,[SyaratPenerimaan]

           ,[SyaratPembayaran]

           ,[Agent]

           ,[Alamat1A]

           ,[Alamat2A]

           ,[KotaA]

           ,[NegaraA]

           ,[ContactA]

           ,[TelpA]

           ,[FaxA]

           ,[EmailA]

           ,[KODEPOSA]

           ,[HPA]

           ,[EmailContA]

           ,[PortOfLoading]

           ,[CountryOfOrigin]

           ,[TglInput]

           ,[iskontrak]

           ,[PPN]

           ,[HargaKe]

           ,[Att]

           ,[bank]

           ,[NoAcc]

           ,[KodeJenis]

           ,[KodeBank]

           ,[komisi]

           ,[IsPelanggan]

           ,[KodeDealer]

           ,[IsPPH21] from dbCustSupp where KodeCustSupp=@Nobukti

            

      update dbCustSupp set Tf=1 where KodeCustSupp in (select KodeCustSupp from [36.64.152.3].[DBBCAGROUP].[dbo].[dbCustSupp] where KodeCustSupp=@Nobukti) 

    else

   if @Do='D'

   delete [36.64.152.3].[DBBCAGROUP].[dbo].[dbCustSupp] where KodeCustSupp=@Nobukti

     delete TempDelData where nobukti=@Nobukti and tabel='dbCustSupp'


 Fetch Next from MySikron into @Nobukti, @Do

 

     Close MySikron

     Deallocate MySikron

 

--master perkcustsupp

delete [36.64.152.3].[DBBCAGROUP].[dbo].DBPERKCUSTSUPP where KodeCustSupp in (select KodeCustSupp from DBPERKCUSTSUPP where COALESCE(tf,0)=0 ) 

INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[DBPERKCUSTSUPP]

           ([KodeCustSupp]

           ,[Urut]

           ,[Perkiraan])

select    [KodeCustSupp]

           ,[Urut]

           ,[Perkiraan]

           from DBPERKCUSTSUPP where COALESCE(tf,0)=0 

update DBPERKCUSTSUPP set tf=1 where COALESCE(tf,0)=0 



--master custretensi

delete [36.64.152.3].[DBBCAGROUP].[dbo].dbCustRetensi where KodeCustSupp in (select KodeCustSupp from dbCustRetensi where COALESCE(tf,0)=0 ) 

INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[dbCustRetensi]

           ([KodeCustSupp]

           ,[PRet]

           ,[PPPH22]

           ,[NPPH22])

select   [KodeCustSupp]

           ,[PRet]

           ,[PPPH22]

           ,[NPPH22]

           from dbCustRetensi where COALESCE(tf,0)=0 

update dbCustRetensi set tf=1 where COALESCE(tf,0)=0 


 Declare MySikron Cursor for

   select USERID,Do from dbflpass where COALESCE(tf,0)=0

   union all

   select Nobukti,'D' from TempDelData where tabel='dbFlpass'

 Open MySikron

 Fetch Next from MySikron into @Nobukti, @Do

 While @@fetch_Status=0

 if @Do='I'

   INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[DBFLPASS]

           ([USERID],[UID],[FullName],[TINGKAT],[STATUS],[HOSTID],[IPAddres],[kodeBag],[KodeJab])

     select [USERID],[UID],[FullName],[TINGKAT],[STATUS],[HOSTID],[IPAddres],[kodeBag],[KodeJab]

     from DBFLPASS where USERID=@Nobukti

     update DBFLPASS set Tf=1 where USERID in (select USERID from [36.64.152.3].[DBBCAGROUP].[dbo].[DBFLPASS] where USERID=@Nobukti) 

    else

   if @Do='U'

   Update [36.64.152.3].[DBBCAGROUP].[dbo].[DBFLPASS] set 

      [UID]=b.[UID],[FullName]=b.FullName,[TINGKAT]=b.TINGKAT,[STATUS]=b.[STATUS],[HOSTID]=b.HOSTID,

      [IPAddres]=b.IPAddres,[kodeBag]=b.kodeBag,[KodeJab]=b.KodeJab

      from [36.64.152.3].[DBBCAGROUP].[dbo].[DBFLPASS] a

      left outer join 

        (select [USERID],[UID],[FullName],[TINGKAT],[STATUS],[HOSTID],[IPAddres],[kodeBag],[KodeJab]

              from DBFLPASS where USERID=@Nobukti ) B on b.USERID=a.USERID where a.USERID=@Nobukti

      

      if not exists(select USERID from [36.64.152.3].[DBBCAGROUP].[dbo].[DBFLPASS] where USERID=@Nobukti) 

      INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[DBFLPASS]

           ([USERID],[UID],[FullName],[TINGKAT],[STATUS],[HOSTID],[IPAddres],[kodeBag],[KodeJab])

        select [USERID],[UID],[FullName],[TINGKAT],[STATUS],[HOSTID],[IPAddres],[kodeBag],[KodeJab]

        from DBFLPASS where USERID=@Nobukti      

      

      update DBFLPASS set Tf=1 where USERID in (select USERID from [36.64.152.3].[DBBCAGROUP].[dbo].[DBFLPASS] where USERID=@Nobukti) 

    else

   if @Do='D'

   delete [36.64.152.3].[DBBCAGROUP].[dbo].[DBFLPASS] where USERID=@Nobukti

     delete TempDelData where nobukti=@Nobukti and tabel='dbFlpass'


 Fetch Next from MySikron into @Nobukti, @Do

 

     Close MySikron

     Deallocate MySikron



/*delete [36.64.152.3].[DBBCAGROUP].[dbo].dbflmenu where USERID in (select USERID from DBFLMENU where COALESCE(tf,0)=0 group by USERID ) 

INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[DBFLMENU]

           ([USERID]

           ,[L1]

           ,[HASACCESS]

           ,[ISTAMBAH]

           ,[ISKOREKSI]

           ,[ISHAPUS]

           ,[ISCETAK]

           ,[ISEXPORT]

           ,[IsOtorisasi1]

           ,[IsOtorisasi2]

           ,[IsOtorisasi3]

           ,[IsOtorisasi4]

           ,[IsOtorisasi5]

           ,[TIPE]

           ,[IsBatal]

           ,[pembatalan]

           )

select     [USERID]

           ,[L1]

           ,[HASACCESS]

           ,[ISTAMBAH]

           ,[ISKOREKSI]

           ,[ISHAPUS]

           ,[ISCETAK]

           ,[ISEXPORT]

           ,[IsOtorisasi1]

           ,[IsOtorisasi2]

           ,[IsOtorisasi3]

           ,[IsOtorisasi4]

           ,[IsOtorisasi5]

           ,[TIPE]

           ,[IsBatal]

           ,[pembatalan]

           from DBFLMENU where COALESCE(tf,0)=0 

update DBFLMENU set tf=1  where COALESCE(tf,0)=0        

           

delete [36.64.152.3].[DBBCAGROUP].[dbo].dbflmenureport where USERID in (select USERID from dbflmenureport where COALESCE(tf,0)=0 group by USERID ) 



INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[DBFLMENUREPORT]

           ([UserID]

           ,[L1]

           ,[Access]

           ,[IsDesign]

           ,[Isexport])

select [UserID]

           ,[L1]

           ,[Access]

           ,[IsDesign]

           ,[Isexport]

           from DBFLMENUREPORT where COALESCE(tf,0)=0  

update DBFLMENUREPORT set Tf=1 where COALESCE(tf,0)=0 



delete [36.64.152.3].[DBBCAGROUP].[dbo].dbPemakaigdg where USERID in (select USERID from dbPemakaigdg where COALESCE(tf,0)=0 group by USERID ) 



INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[dbPemakaigdg]

select [UserID],[kodegdg] from dbPemakaigdg where COALESCE(tf,0)=0

update DBPemakaiGdg set tf=1 where COALESCE(tf,0)=0  

           

delete [36.64.152.3].[DBBCAGROUP].[dbo].dbaksesperkiraan where USERID in (select USERID from dbaksesperkiraan where COALESCE(tf,0)=0 group by USERID ) 



INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[dbaksesperkiraan]

select [UserID],[perkiraan] from dbaksesperkiraan where COALESCE(tf,0)=0

update dbaksesperkiraan set tf=1 where COALESCE(tf,0)=0              

*/           

 --Master Perkiraan

 Declare MySikron Cursor for

   select Perkiraan,Do from dbPerkiraan where COALESCE(tf,0)=0

   union all

   select Nobukti,'D' from TempDelData where tabel='dbPerkiraan'

 Open MySikron

 Fetch Next from MySikron into @Nobukti, @Do

 While @@fetch_Status=0

 if @Do='I'

   INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[DBPERKIRAAN]

           ([Perkiraan]

           ,[Keterangan]

           ,[Kelompok]

           ,[Tipe]

           ,[Valas]

           ,[DK]

           ,[Neraca]

           ,[FlagCashFlow]

           ,[Simbol]

           ,[IsPPN]

           ,[GroupPerkiraan]

           ,[Lokasi])

     select [Perkiraan]

           ,[Keterangan]

           ,[Kelompok]

           ,[Tipe]

           ,[Valas]

           ,[DK]

           ,[Neraca]

           ,[FlagCashFlow]

           ,[Simbol]

           ,[IsPPN]

           ,[GroupPerkiraan]

           ,[Lokasi]

     from DBPERKIRAAN where Perkiraan=@Nobukti

     update DBPERKIRAAN set Tf=1 where Perkiraan in (select Perkiraan from [36.64.152.3].[DBBCAGROUP].[dbo].[dbperkiraan] where Perkiraan=@Nobukti) 

    else

   if @Do='U'

   Update [36.64.152.3].[DBBCAGROUP].[dbo].[DBperkiraan] set 

       [Keterangan]=b.Keterangan

           ,[Kelompok]=b.Kelompok

           ,[Tipe]=b.Tipe

           ,[Valas]=b.Valas

           ,[DK]=b.DK

           ,[Neraca]=b.Neraca

           ,[FlagCashFlow]=b.FlagCashFlow

           ,[Simbol]=b.Simbol

           ,[IsPPN]=b.IsPPN

           ,[GroupPerkiraan]=b.GroupPerkiraan

           ,[Lokasi]=b.Lokasi

      from [36.64.152.3].[DBBCAGROUP].[dbo].[DBperkiraan] a

      left outer join 

        (select [Perkiraan]

           ,[Keterangan]

           ,[Kelompok]

           ,[Tipe]

           ,[Valas]

           ,[DK]

           ,[Neraca]

           ,[FlagCashFlow]

           ,[Simbol]

           ,[IsPPN]

           ,[GroupPerkiraan]

           ,[Lokasi]

     from DBPERKIRAAN where Perkiraan=@Nobukti ) B on b.Perkiraan=a.Perkiraan where a.Perkiraan=@Nobukti

      

      if not exists(select USERID from [36.64.152.3].[DBBCAGROUP].[dbo].[DBFLPASS] where USERID=@Nobukti) 

      INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[DBPERKIRAAN]

           ([Perkiraan]

           ,[Keterangan]

           ,[Kelompok]

           ,[Tipe]

           ,[Valas]

           ,[DK]

           ,[Neraca]

           ,[FlagCashFlow]

           ,[Simbol]

           ,[IsPPN]

           ,[GroupPerkiraan]

           ,[Lokasi])

        select [Perkiraan]

           ,[Keterangan]

           ,[Kelompok]

           ,[Tipe]

           ,[Valas]

           ,[DK]

           ,[Neraca]

           ,[FlagCashFlow]

           ,[Simbol]

           ,[IsPPN]

           ,[GroupPerkiraan]

           ,[Lokasi]

        from DBPERKIRAAN where Perkiraan=@Nobukti

      

      update DBPERKIRAAN set Tf=1 where Perkiraan in (select Perkiraan from [36.64.152.3].[DBBCAGROUP].[dbo].[dbperkiraan] where Perkiraan=@Nobukti) 

    else

   if @Do='D'

   delete [36.64.152.3].[DBBCAGROUP].[dbo].[DBPerkiraan] where Perkiraan=@Nobukti

     delete TempDelData where nobukti=@Nobukti and tabel='DBPerkiraan'


 Fetch Next from MySikron into @Nobukti, @Do

 

     Close MySikron

     Deallocate MySikron 



--Master Gudang

Declare MySikron Cursor for

   select KodeGdg,Do from dbGudang where COALESCE(tf,0)=0

   union all

   select Nobukti,'D' from TempDelData where tabel='dbGudang'

 Open MySikron

 Fetch Next from MySikron into @Nobukti, @Do

 While @@fetch_Status=0

 if @Do='I'

   INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[DBGUDANG]

           ([KODEGDG]

           ,[NAMA]

           ,[IsRusak]

           ,[Alamat]

           ,[IsCust]

           ,[FlagMenu]

           ,[IsProduksi]

           ,[IsTransfer]

           ,[CONNSTR])

     select [KODEGDG]

           ,[NAMA]

           ,[IsRusak]

           ,[Alamat]

           ,[IsCust]

           ,[FlagMenu]

           ,[IsProduksi]

           ,[IsTransfer]

           ,[CONNSTR] from DBGUDANG where KODEGDG=@Nobukti

     update DBGUDANG set Tf=1 where KODEGDG in (select KODEGDG from [36.64.152.3].[DBBCAGROUP].[dbo].[dbGUDANG] where KODEGDG=@Nobukti) 

    else

   if @Do='U'

   Update [36.64.152.3].[DBBCAGROUP].[dbo].[DBGUDANG] set 

           [NAMA]=B.[NAMA]

           ,[IsRusak]=B.[IsRusak]

           ,[Alamat]=B.[Alamat]

           ,[IsCust]=B.[IsCust]

           ,[FlagMenu]=B.[FlagMenu]

           ,[IsProduksi]=B.[IsProduksi]

           ,[IsTransfer]=B.[IsTransfer]

           ,[CONNSTR]=B.[CONNSTR]

      from [36.64.152.3].[DBBCAGROUP].[dbo].[DBGUDANG] a

      left outer join 

        (select [KODEGDG]

           ,[NAMA]

           ,[IsRusak]

           ,[Alamat]

           ,[IsCust]

           ,[FlagMenu]

           ,[IsProduksi]

           ,[IsTransfer]

           ,[CONNSTR]

     from DBGUDANG where KODEGDG=@Nobukti ) B on b.KODEGDG=a.KODEGDG where a.KODEGDG=@Nobukti

      

      if not exists(select KODEGDG from [36.64.152.3].[DBBCAGROUP].[dbo].[DBGUDANG] where KODEGDG=@Nobukti) 

      INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[DBGUDANG]

           ([KODEGDG]

           ,[NAMA]

           ,[IsRusak]

           ,[Alamat]

           ,[IsCust]

           ,[FlagMenu]

           ,[IsProduksi]

           ,[IsTransfer]

           ,[CONNSTR])

     select [KODEGDG]

           ,[NAMA]

           ,[IsRusak]

           ,[Alamat]

           ,[IsCust]

           ,[FlagMenu]

           ,[IsProduksi]

           ,[IsTransfer]

           ,[CONNSTR] from DBGUDANG where KODEGDG=@Nobukti

      

      update DBGUDANG set Tf=1 where KODEGDG in (select KODEGDG from [36.64.152.3].[DBBCAGROUP].[dbo].[DBGUDANG] where KODEGDG=@Nobukti) 

    else

   if @Do='D'

   delete [36.64.152.3].[DBBCAGROUP].[dbo].[DBGUDANG] where KODEGDG=@Nobukti

     delete TempDelData where nobukti=@Nobukti and tabel='DBGUDANG'


 Fetch Next from MySikron into @Nobukti, @Do

 

     Close MySikron

     Deallocate MySikron



--master barang/bahan/jasa

Declare MySikron Cursor for

   select KodeBrg,Do from dbBarang where COALESCE(tf,0)=0

   union all

   select Nobukti,'D' from TempDelData where tabel='dbBarang'

 Open MySikron

 Fetch Next from MySikron into @Nobukti, @Do

 While @@fetch_Status=0

 if @Do='I'

   INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[DBbarang]

           ([KODEBRG]

           ,[NAMABRG]

           ,[NamaBrg2]

           ,[KODEGRP]

           ,[GrpBarang]

           ,[KODESUBGRP]

           ,[KODESUPP]

           ,[IsBarang]

           ,[SAT1]

           ,[ISI1]

           ,[SAT2]

           ,[ISI2]

           ,[SAT3]

           ,[ISI3]

           ,[NFix]

           ,[Hrg1_1]

           ,[Hrg2_1]

           ,[Hrg3_1]

           ,[Hrg1_2]

           ,[Hrg2_2]

           ,[Hrg3_2]

           ,[Hrg1_3]

           ,[Hrg2_3]

           ,[Hrg3_3]

           ,[QntMin]

           ,[QntMax]

           ,[ISAKTIF]

           ,[Keterangan]

           ,[Tolerate]

           ,[DimW]

           ,[DimH]

           ,[DimT1A]

           ,[DimT1B]

           ,[DimT2]

           ,[DimL]

           ,[Ukuran]

           ,[TONASE]

           ,[IsJasa])

     select [KODEBRG]

           ,[NAMABRG]

           ,[NamaBrg2]

           ,[KODEGRP]

           ,[GrpBarang]

           ,[KODESUBGRP]

           ,[KODESUPP]

           ,[IsBarang]

           ,[SAT1]

           ,[ISI1]

           ,[SAT2]

           ,[ISI2]

           ,[SAT3]

           ,[ISI3]

           ,[NFix]

           ,[Hrg1_1]

           ,[Hrg2_1]

           ,[Hrg3_1]

           ,[Hrg1_2]

           ,[Hrg2_2]

           ,[Hrg3_2]

           ,[Hrg1_3]

           ,[Hrg2_3]

           ,[Hrg3_3]

           ,[QntMin]

           ,[QntMax]

           ,[ISAKTIF]

           ,[Keterangan]

           ,[Tolerate]

           ,[DimW]

           ,[DimH]

           ,[DimT1A]

           ,[DimT1B]

           ,[DimT2]

           ,[DimL]

           ,[Ukuran]

           ,[TONASE]

           ,[IsJasa] from DBBARANG where KODEBRG=@Nobukti

     update DBBARANG set Tf=1 where KODEBRG in (select KODEBRG from [36.64.152.3].[DBBCAGROUP].[dbo].[dbbarang] where KODEBRG=@Nobukti) 

    else

   if @Do='U'

   Update [36.64.152.3].[DBBCAGROUP].[dbo].[DBbarang] set 

           [NAMABRG]=b.NAMABRG

           ,[NamaBrg2]=b.NamaBrg2

           ,[KODEGRP]=b.KODEGRP

           ,[GrpBarang]=b.GrpBarang

           ,[KODESUBGRP]=b.KODESUBGRP

           ,[KODESUPP]=b.KODESUPP

           ,[IsBarang]=b.IsBarang

           ,[SAT1]=b.SAT1

           ,[ISI1]=b.ISI1

           ,[SAT2]=b.SAT2

           ,[ISI2]=b.ISI2

           ,[SAT3]=b.SAT3

           ,[ISI3]=b.ISI3

           ,[NFix]=b.NFix

           ,[Hrg1_1]=b.Hrg1_1

           ,[Hrg2_1]=b.Hrg2_1

           ,[Hrg3_1]=b.Hrg3_1

           ,[Hrg1_2]=b.Hrg1_2

           ,[Hrg2_2]=b.Hrg2_2

           ,[Hrg3_2]=b.Hrg3_2

           ,[Hrg1_3]=b.Hrg1_3

           ,[Hrg2_3]=b.Hrg2_3

           ,[Hrg3_3]=b.Hrg3_3

           ,[QntMin]=b.QntMin

           ,[QntMax]=b.QntMax

           ,[ISAKTIF]=b.ISAKTIF

           ,[Keterangan]=b.Keterangan

           ,[Tolerate]=b.Tolerate

           ,[DimW]=b.DimW

           ,[DimH]=b.DimH

           ,[DimT1A]=b.DimT1A

           ,[DimT1B]=b.DimT1B

           ,[DimT2]=b.DimT2

           ,[DimL]=b.DimL

           ,[Ukuran]=b.Ukuran

           ,[TONASE]=b.TONASE

           ,[IsJasa]=b.IsJasa

      from [36.64.152.3].[DBBCAGROUP].[dbo].[DBbarang] a

      left outer join 

        (select [KODEBRG]

           ,[NAMABRG]

           ,[NamaBrg2]

           ,[KODEGRP]

           ,[GrpBarang]

           ,[KODESUBGRP]

           ,[KODESUPP]

           ,[IsBarang]

           ,[SAT1]

           ,[ISI1]

           ,[SAT2]

           ,[ISI2]

           ,[SAT3]

           ,[ISI3]

           ,[NFix]

           ,[Hrg1_1]

           ,[Hrg2_1]

           ,[Hrg3_1]

           ,[Hrg1_2]

           ,[Hrg2_2]

           ,[Hrg3_2]

           ,[Hrg1_3]

           ,[Hrg2_3]

           ,[Hrg3_3]

           ,[QntMin]

           ,[QntMax]

           ,[ISAKTIF]

           ,[Keterangan]

           ,[Tolerate]

           ,[DimW]

           ,[DimH]

           ,[DimT1A]

           ,[DimT1B]

           ,[DimT2]

           ,[DimL]

           ,[Ukuran]

           ,[TONASE]

           ,[IsJasa]

     from DBBARANG where KODEBRG=@Nobukti ) B on b.KODEBRG=a.KODEBRG where a.KODEBRG=@Nobukti

      

      if not exists(select KODEBRG from [36.64.152.3].[DBBCAGROUP].[dbo].[DBbarang] where KODEBRG=@Nobukti) 

      INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[DBbarang]

           ([KODEBRG]

           ,[NAMABRG]

           ,[NamaBrg2]

           ,[KODEGRP]

           ,[GrpBarang]

           ,[KODESUBGRP]

           ,[KODESUPP]

           ,[IsBarang]

           ,[SAT1]

           ,[ISI1]

           ,[SAT2]

           ,[ISI2]

           ,[SAT3]

           ,[ISI3]

           ,[NFix]

           ,[Hrg1_1]

           ,[Hrg2_1]

           ,[Hrg3_1]

           ,[Hrg1_2]

           ,[Hrg2_2]

           ,[Hrg3_2]

           ,[Hrg1_3]

           ,[Hrg2_3]

           ,[Hrg3_3]

           ,[QntMin]

           ,[QntMax]

           ,[ISAKTIF]

           ,[Keterangan]

           ,[Tolerate]

           ,[DimW]

           ,[DimH]

           ,[DimT1A]

           ,[DimT1B]

           ,[DimT2]

           ,[DimL]

           ,[Ukuran]

           ,[TONASE]

           ,[IsJasa])

     select [KODEBRG]

           ,[NAMABRG]

           ,[NamaBrg2]

           ,[KODEGRP]

           ,[GrpBarang]

           ,[KODESUBGRP]

           ,[KODESUPP]

           ,[IsBarang]

           ,[SAT1]

           ,[ISI1]

           ,[SAT2]

           ,[ISI2]

           ,[SAT3]

           ,[ISI3]

           ,[NFix]

           ,[Hrg1_1]

           ,[Hrg2_1]

           ,[Hrg3_1]

           ,[Hrg1_2]

           ,[Hrg2_2]

           ,[Hrg3_2]

           ,[Hrg1_3]

           ,[Hrg2_3]

           ,[Hrg3_3]

           ,[QntMin]

           ,[QntMax]

           ,[ISAKTIF]

           ,[Keterangan]

           ,[Tolerate]

           ,[DimW]

           ,[DimH]

           ,[DimT1A]

           ,[DimT1B]

           ,[DimT2]

           ,[DimL]

           ,[Ukuran]

           ,[TONASE]

           ,[IsJasa] from DBBARANG where KODEBRG=@Nobukti

      

      update DBBARANG set Tf=1 where KODEBRG in (select KODEBRG from [36.64.152.3].[DBBCAGROUP].[dbo].[DBbarang] where KODEBRG=@Nobukti) 

    else

   if @Do='D'

   delete [36.64.152.3].[DBBCAGROUP].[dbo].[DBbarang] where KODEBRG=@Nobukti

     delete TempDelData where nobukti=@Nobukti and tabel='DBbarang'


 Fetch Next from MySikron into @Nobukti, @Do

 

     Close MySikron

     Deallocate MySikron



--master jenis kendaraan

Declare MySikron Cursor for

   select KODEJENISKEND,Do from DBJENISKEND where COALESCE(tf,0)=0

   union all

   select Nobukti,'D' from TempDelData where tabel='DBJENISKEND'

 Open MySikron

 Fetch Next from MySikron into @Nobukti, @Do

 While @@fetch_Status=0

 if @Do='I'

   INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[DBJENISKEND]

           ([KODEJENISKEND]

           ,[NAMAJENISKEND])

     select [KODEJENISKEND]

           ,[NAMAJENISKEND] from DBJENISKEND where KODEJENISKEND=@Nobukti

     update DBJENISKEND set Tf=1 where KODEJENISKEND in (select KODEJENISKEND from [36.64.152.3].[DBBCAGROUP].[dbo].[DBJENISKEND] where KODEJENISKEND=@Nobukti) 

    else

   if @Do='U'

   Update [36.64.152.3].[DBBCAGROUP].[dbo].[DBJENISKEND] set 

           [NAMAJENISKEND]=b.[NAMAJENISKEND]

      from [36.64.152.3].[DBBCAGROUP].[dbo].[DBJENISKEND] a

      left outer join 

        (select [KODEJENISKEND]

           ,[NAMAJENISKEND]

     from DBJENISKEND where KODEJENISKEND=@Nobukti ) B on b.KODEJENISKEND=a.KODEJENISKEND where a.KODEJENISKEND=@Nobukti

      

      if not exists(select KODEJENISKEND from [36.64.152.3].[DBBCAGROUP].[dbo].[DBJENISKEND] where KODEJENISKEND=@Nobukti) 

      INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[DBJENISKEND]

           ([KODEJENISKEND]

           ,[NAMAJENISKEND])

     select [KODEJENISKEND]

           ,[NAMAJENISKEND] from DBJENISKEND where KODEJENISKEND=@Nobukti

      

      update DBJENISKEND set Tf=1 where KODEJENISKEND in (select KODEJENISKEND from [36.64.152.3].[DBBCAGROUP].[dbo].[DBJENISKEND] where KODEJENISKEND=@Nobukti) 

    else

   if @Do='D'

   delete [36.64.152.3].[DBBCAGROUP].[dbo].[DBJENISKEND] where KODEJENISKEND=@Nobukti

     delete TempDelData where nobukti=@Nobukti and tabel='DBJENISKEND'


 Fetch Next from MySikron into @Nobukti, @Do

 

     Close MySikron

     Deallocate MySikron



--master kendaraan

Declare MySikron Cursor for

   select KODEKEND,Do from DBKENDARAAN where COALESCE(tf,0)=0

   union all

   select Nobukti,'D' from TempDelData where tabel='DBKENDARAAN'

 Open MySikron

 Fetch Next from MySikron into @Nobukti, @Do

 While @@fetch_Status=0

 if @Do='I'

   INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[DBKENDARAAN]

           ([KODEKEND]

           ,[KODEJENISKEND]

           ,[NAMAKEND]

           ,[NOCHASIS]

           ,[MERKKEND])

     select [KODEKEND]

           ,[KODEJENISKEND]

           ,[NAMAKEND]

           ,[NOCHASIS]

           ,[MERKKEND] from DBKENDARAAN where KODEKEND=@Nobukti

     update DBKENDARAAN set Tf=1 where KODEKEND in (select KODEKEND from [36.64.152.3].[DBBCAGROUP].[dbo].[DBKENDARAAN] where KODEKEND=@Nobukti) 

    else

   if @Do='U'

   Update [36.64.152.3].[DBBCAGROUP].[dbo].[DBKENDARAAN] set 

          [KODEKEND]=b.KODEKEND

           ,[KODEJENISKEND]=b.KODEJENISKEND

           ,[NAMAKEND]=b.NAMAKEND

           ,[NOCHASIS]=b.NOCHASIS

           ,[MERKKEND]=b.MERKKEND

      from [36.64.152.3].[DBBCAGROUP].[dbo].[DBKENDARAAN] a

      left outer join 

        (select [KODEKEND]

           ,[KODEJENISKEND]

           ,[NAMAKEND]

           ,[NOCHASIS]

           ,[MERKKEND]

     from DBKENDARAAN where KODEJENISKEND=@Nobukti ) B on b.KODEKEND=a.KODEKEND where a.KODEKEND=@Nobukti

      

      if not exists(select KODEKEND from [36.64.152.3].[DBBCAGROUP].[dbo].[DBKENDARAAN] where KODEKEND=@Nobukti) 

      INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[DBKENDARAAN]

           ([KODEKEND]

           ,[KODEJENISKEND]

           ,[NAMAKEND]

           ,[NOCHASIS]

           ,[MERKKEND])

     select [KODEKEND]

           ,[KODEJENISKEND]

           ,[NAMAKEND]

           ,[NOCHASIS]

           ,[MERKKEND] from DBKENDARAAN where KODEKEND=@Nobukti

      

      update DBKENDARAAN set Tf=1 where KODEKEND in (select KODEKEND from [36.64.152.3].[DBBCAGROUP].[dbo].[DBKENDARAAN] where KODEKEND=@Nobukti) 

    else

   if @Do='D'

   delete [36.64.152.3].[DBBCAGROUP].[dbo].[DBKENDARAAN] where KODEKEND=@Nobukti

     delete TempDelData where nobukti=@Nobukti and tabel='DBKENDARAAN'


 Fetch Next from MySikron into @Nobukti, @Do

 

     Close MySikron

     Deallocate MySikron



--master alat berat

Declare MySikron Cursor for

   select KODEALAT,Do from dbAlatBerat where COALESCE(tf,0)=0

   union all

   select Nobukti,'D' from TempDelData where tabel='dbAlatBerat'

 Open MySikron

 Fetch Next from MySikron into @Nobukti, @Do

 While @@fetch_Status=0

 if @Do='I'

   INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[dbAlatBerat]

       ([KodeAlat]

           ,[NamaAlat]

           ,[Tipe]

           ,[Keterangan]

           ,[NamaOpe])

     select [KodeAlat]

           ,[NamaAlat]

           ,[Tipe]

           ,[Keterangan]

           ,[NamaOpe] from dbAlatBerat where KodeAlat=@Nobukti

     update dbAlatBerat set Tf=1 where KodeAlat in (select KodeAlat from [36.64.152.3].[DBBCAGROUP].[dbo].[dbAlatBerat] where KodeAlat=@Nobukti) 

    else

   if @Do='U'

   Update [36.64.152.3].[DBBCAGROUP].[dbo].[dbAlatBerat] set 

          [KodeAlat]=b.KodeAlat

           ,[NamaAlat]=b.NamaAlat

           ,[Tipe]=b.Tipe

           ,[Keterangan]=b.Tipe

           ,[NamaOpe]=b.NamaOpe

      from [36.64.152.3].[DBBCAGROUP].[dbo].[dbAlatBerat] a

      left outer join 

        (select [KodeAlat]

           ,[NamaAlat]

           ,[Tipe]

           ,[Keterangan]

           ,[NamaOpe]

     from dbAlatBerat where KodeAlat=@Nobukti ) B on b.KodeAlat=a.KodeAlat where a.KodeAlat=@Nobukti

      

      if not exists(select KodeAlat from [36.64.152.3].[DBBCAGROUP].[dbo].[dbAlatBerat] where KodeAlat=@Nobukti) 

      INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[dbAlatBerat]

       ([KodeAlat]

           ,[NamaAlat]

           ,[Tipe]

           ,[Keterangan]

           ,[NamaOpe])

     select [KodeAlat]

           ,[NamaAlat]

           ,[Tipe]

           ,[Keterangan]

           ,[NamaOpe] from dbAlatBerat where KodeAlat=@Nobukti

      

      update dbAlatBerat set Tf=1 where KodeAlat in (select KodeAlat from [36.64.152.3].[DBBCAGROUP].[dbo].[dbAlatBerat] where KodeAlat=@Nobukti) 

    else

   if @Do='D'

   delete [36.64.152.3].[DBBCAGROUP].[dbo].[dbAlatBerat] where KodeAlat=@Nobukti

     delete TempDelData where nobukti=@Nobukti and tabel='dbAlatBerat'


 Fetch Next from MySikron into @Nobukti, @Do

 

     Close MySikron

     Deallocate MySikron

     

--master Dep

Declare MySikron Cursor for

   select KdDep,Do from dbDepart where COALESCE(tf,0)=0

   union all

   select Nobukti,'D' from TempDelData where tabel='dbDepart'

 Open MySikron

 Fetch Next from MySikron into @Nobukti, @Do

 While @@fetch_Status=0

 if @Do='I'

   INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[dbDepart]

       ([KDDEP]

           ,[NMDEP]

           ,[PerkBiaya]

           ,[isSetPass])

     select [KDDEP]

           ,[NMDEP]

           ,[PerkBiaya]

           ,[isSetPass] from dbDepart where KdDep=@Nobukti

     update dbDepart set Tf=1 where KdDep in (select KdDep from [36.64.152.3].[DBBCAGROUP].[dbo].[dbDepart] where KdDep=@Nobukti) 

    else

   if @Do='U'

   Update [36.64.152.3].[DBBCAGROUP].[dbo].[dbDepart] set 

            [NMDEP]=b.[NMDEP]

           ,[PerkBiaya]=b.[PerkBiaya]

           ,[isSetPass]=b.[isSetPass]

      from [36.64.152.3].[DBBCAGROUP].[dbo].[dbDepart] a

      left outer join 

        (select [KDDEP]

           ,[NMDEP]

           ,[PerkBiaya]

           ,[isSetPass]

     from dbDepart where KDDEP=@Nobukti ) B on b.KdDep=a.KdDep where a.KdDep=@Nobukti

      

      if not exists(select KdDep from [36.64.152.3].[DBBCAGROUP].[dbo].[dbDepart] where KdDep=@Nobukti) 

      INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[dbDepart]

       ([KDDEP]

           ,[NMDEP]

           ,[PerkBiaya]

           ,[isSetPass])

     select [KDDEP]

           ,[NMDEP]

           ,[PerkBiaya]

           ,[isSetPass] from dbDepart where KdDep=@Nobukti

      

      update dbDepart set Tf=1 where KdDep in (select KdDep from [36.64.152.3].[DBBCAGROUP].[dbo].[dbDepart] where KdDep=@Nobukti) 

    else

   if @Do='D'

   delete [36.64.152.3].[DBBCAGROUP].[dbo].[dbDepart] where KdDep=@Nobukti

     delete TempDelData where nobukti=@Nobukti and tabel='dbDepart'


 Fetch Next from MySikron into @Nobukti, @Do

 

     Close MySikron

     Deallocate MySikron



--master Kota

Declare MySikron Cursor for

   select kodeKota,Do from dbkota where COALESCE(tf,0)=0

   union all

   select Nobukti,'D' from TempDelData where tabel='dbkota'

 Open MySikron

 Fetch Next from MySikron into @Nobukti, @Do

 While @@fetch_Status=0

 if @Do='I'

   INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[dbkota]

       ([KodeKota]

           ,[NamaKota]

           ,[KodeArea])

     select [KodeKota]

           ,[NamaKota]

           ,[KodeArea] from dbkota where kodeKota=@Nobukti

     update dbkota set Tf=1 where kodeKota in (select KodeKota from [36.64.152.3].[DBBCAGROUP].[dbo].[dbkota] where kodeKota=@Nobukti) 

    else

   if @Do='U'

   Update [36.64.152.3].[DBBCAGROUP].[dbo].[dbkota] set 

            [NamaKota]=b.[NamaKota]

           ,[KodeArea]=b.[KodeArea]

      from [36.64.152.3].[DBBCAGROUP].[dbo].[dbkota] a

      left outer join 

        (select [KodeKota]

           ,[NamaKota]

           ,[KodeArea]

     from dbkota where kodeKota=@Nobukti ) B on b.kodeKota=a.kodeKota where a.kodeKota=@Nobukti

      

      if not exists(select kodeKota from [36.64.152.3].[DBBCAGROUP].[dbo].[dbkota] where kodeKota=@Nobukti) 

      INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[dbkota]

            ([KodeKota]

           ,[NamaKota]

           ,[KodeArea])

             select [KodeKota]

           ,[NamaKota]

           ,[KodeArea] from dbkota where kodeKota=@Nobukti

      

      update dbkota set Tf=1 where kodeKota in (select kodeKota from [36.64.152.3].[DBBCAGROUP].[dbo].[dbkota] where kodeKota=@Nobukti) 

    else

   if @Do='D'

   delete [36.64.152.3].[DBBCAGROUP].[dbo].[dbkota] where kodeKota=@Nobukti

     delete TempDelData where nobukti=@Nobukti and tabel='dbkota'


 Fetch Next from MySikron into @Nobukti, @Do

 

     Close MySikron

     Deallocate MySikron

      

--master karyawan

delete [36.64.152.3].[DBBCAGROUP].[dbo].dbkaryawan where KeyNIK in (select KeyNIK from dbKaryawan where COALESCE(tf,0)=0 ) 

INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[dbkaryawan]

           ([KeyNIK]

           ,[TipeTrans]

           ,[NoBukti]

           ,[NIK]

           ,[Nama]

           ,[NamaPanggilan]

           ,[Kelamin]

           ,[TmpLahir]

           ,[TglLahir]

           ,[Agama]

           ,[Tinggi]

           ,[Berat]

           ,[BerkacaMata]

           ,[Darah]

           ,[NomorKTP]

           ,[AlamatKTP]

           ,[KecamatanKTP]

           ,[KabupatenKTP]

           ,[PropinsiKTP]

           ,[KodePosKTP]

           ,[AlamatRmh]

           ,[KecamatanRmh]

           ,[KabupatenRmh]

           ,[PropinsiRmh]

           ,[KodePosRmh]

           ,[TeleponHP]

           ,[KodePendAkhir]

           ,[KetPendAkhir]

           ,[StatusTempTinggal]

           ,[Hubungan]

           ,[Referensi]

           ,[Rekomendasi]

           ,[NamaR]

           ,[JabatanR]

           ,[NamaInstR]

           ,[AlamatR]

           ,[TglMasuk]

           ,[TglKeluar]

           ,[BankAccount]

           ,[NomorAstek]

           ,[TglAstek]

           ,[KodeShf]

           ,[KodeJab]

           ,[KodeDept]

           ,[KodeESL]

           ,[KodeGrade]

           ,[GajiPokok]

           ,[TnjJabatan]

           ,[TnjKehadiran]

           ,[TnjTransport]

           ,[TnjMakan]

           ,[TnjLain2]

           ,[TnjHaid]

           ,[JKK]

           ,[JHT]

           ,[JPK]

           ,[JKM]

           ,[Prima]

           ,[TnjPajak]

           ,[StsPJK]

           ,[StsAST]

           ,[Tanggung]

           ,[NPWP]

           ,[Aktif]

           ,[LamaKontrak]

           ,[TglAkhirKontrak]

           ,[IDUserInput]

           ,[TglInput])

select     [KeyNIK]

           ,[TipeTrans]

           ,[NoBukti]

           ,[NIK]

           ,[Nama]

           ,[NamaPanggilan]

           ,[Kelamin]

           ,[TmpLahir]

           ,[TglLahir]

           ,[Agama]

           ,[Tinggi]

           ,[Berat]

           ,[BerkacaMata]

           ,[Darah]

           ,[NomorKTP]

           ,[AlamatKTP]

           ,[KecamatanKTP]

           ,[KabupatenKTP]

           ,[PropinsiKTP]

           ,[KodePosKTP]

           ,[AlamatRmh]

           ,[KecamatanRmh]

           ,[KabupatenRmh]

           ,[PropinsiRmh]

           ,[KodePosRmh]

           ,[TeleponHP]

           ,[KodePendAkhir]

           ,[KetPendAkhir]

           ,[StatusTempTinggal]

           ,[Hubungan]

           ,[Referensi]

           ,[Rekomendasi]

           ,[NamaR]

           ,[JabatanR]

           ,[NamaInstR]

           ,[AlamatR]

           ,[TglMasuk]

           ,[TglKeluar]

           ,[BankAccount]

           ,[NomorAstek]

           ,[TglAstek]

           ,[KodeShf]

           ,[KodeJab]

           ,[KodeDept]

           ,[KodeESL]

           ,[KodeGrade]

           ,[GajiPokok]

           ,[TnjJabatan]

           ,[TnjKehadiran]

           ,[TnjTransport]

           ,[TnjMakan]

           ,[TnjLain2]

           ,[TnjHaid]

           ,[JKK]

           ,[JHT]

           ,[JPK]

           ,[JKM]

           ,[Prima]

           ,[TnjPajak]

           ,[StsPJK]

           ,[StsAST]

           ,[Tanggung]

           ,[NPWP]

           ,[Aktif]

           ,[LamaKontrak]

           ,[TglAkhirKontrak]

           ,[IDUserInput]

           ,[TglInput]

           from dbKaryawan where COALESCE(tf,0)=0 

update dbKaryawan set tf=1 where COALESCE(tf,0)=0;

-- sp_TFTransIn
CREATE PROCEDURE IF NOT EXISTS sp_TFTransIn AS -- DECLARE REMOVED,@Do char(1),@Urut int



--dbSPP 

Declare MySikron Cursor for

   select nobukti,Do from [36.64.152.3].[DBBCAGROUP].[dbo].dbSPP  where COALESCE(tf,0)=0 and devisi in ('03','04') and IsOtorisasi2=1 

   and ((Do<>'I' and 1=1) or (Do='I' and nobukti not in (select nobukti from [dbspp])))

   union all

   select Nobukti,'D' from [36.64.152.3].[DBBCAGROUP].[dbo].TempDelData where tabel='dbSPP'

 Open MySikron

 Fetch Next from MySikron into @Nobukti, @Do

 While @@fetch_Status=0

 if (@Do='I' or COALESCE(@Do,'')='')

   INSERT INTO [dbSPP]

        ([NoBukti]

           ,[NoUrut]

           ,[Tanggal]

           ,[NoSHIP]

           ,[NoPesan]

           ,[KodeCustSupp]

           ,[TglKirim]

           ,[NoLC]

           ,[NamaKirim]

           ,[AlamatKirim]

           ,[Packing]

           ,[Catatan]

           ,[IsCetak]

           ,[IDUser]

           ,[IsClose]

           ,[FlagTipe]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoAlamatKirim]

           ,[isCetakKitir]

           ,[cetakke]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[IsBatal]

           ,[UserBatal]

           ,[TglBatal]

           ,[Devisi])

     select [NoBukti]

           ,[NoUrut]

           ,[Tanggal]

           ,[NoSHIP]

           ,[NoPesan]

           ,[KodeCustSupp]

           ,[TglKirim]

           ,[NoLC]

           ,[NamaKirim]

           ,[AlamatKirim]

           ,[Packing]

           ,[Catatan]

           ,[IsCetak]

           ,[IDUser]

           ,[IsClose]

           ,[FlagTipe]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoAlamatKirim]

           ,[isCetakKitir]

           ,[cetakke]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[IsBatal]

           ,[UserBatal]

           ,[TglBatal]

           ,[Devisi] from [36.64.152.3].[DBBCAGROUP].[dbo].dbSPP where NoBukti=@Nobukti

     update [36.64.152.3].[DBBCAGROUP].[dbo].dbSPP set Tf=1 where NoBukti in (select NoBukti from [dbSPP] where NoBukti=@Nobukti) 

    else

   if @Do='U'

   Update dbSPP set 

           [Tanggal]=b.[Tanggal]

           ,[NoSHIP]=b.[NoSHIP]

           ,[NoPesan]=b.[NoPesan]

           ,[KodeCustSupp]=b.[KodeCustSupp]

           ,[TglKirim]=b.[TglKirim]

           ,[NoLC]=b.[NoLC]

           ,[NamaKirim]=b.[NamaKirim]

           ,[AlamatKirim]=b.[AlamatKirim]

           ,[Packing]=b.[Packing]

           ,[Catatan]=b.[Catatan]

           ,[IsCetak]=b.[IsCetak]

           ,[IDUser]=b.[IDUser]

           ,[IsClose]=b.[IsClose]

           ,[FlagTipe]=b.[FlagTipe]

           ,[IsOtorisasi1]=b.[IsOtorisasi1]

           ,[OtoUser1]=b.[OtoUser1]

           ,[TglOto1]=b.[TglOto1]

           ,[IsOtorisasi2]=b.[IsOtorisasi2]

           ,[OtoUser2]=b.[OtoUser2]

           ,[TglOto2]=b.[TglOto2]

           ,[IsOtorisasi3]=b.[IsOtorisasi3]

           ,[OtoUser3]=b.[OtoUser3]

           ,[TglOto3]=b.[TglOto3]

           ,[IsOtorisasi4]=b.[IsOtorisasi4]

           ,[OtoUser4]=b.[OtoUser4]

           ,[TglOto4]=b.[TglOto4]

           ,[IsOtorisasi5]=b.[IsOtorisasi5]

           ,[OtoUser5]=b.[OtoUser5]

           ,[TglOto5]=b.[TglOto5]

           ,[NoAlamatKirim]=b.[NoAlamatKirim]

           ,[isCetakKitir]=b.[isCetakKitir]

           ,[cetakke]=b.[cetakke]

           ,[NoJurnal]=b.[NoJurnal]

           ,[NoUrutJurnal]=b.[NoUrutJurnal]

           ,[TglJurnal]=b.[TglJurnal]

           ,[MaxOL]=b.[MaxOL]

           ,[IsBatal]=b.[IsBatal]

           ,[UserBatal]=b.[UserBatal]

           ,[TglBatal]=b.[TglBatal]

           ,[Devisi]=b.[Devisi]

      from [dbSPP] a

      left outer join 

        (select [NoBukti]

           ,[NoUrut]

           ,[Tanggal]

           ,[NoSHIP]

           ,[NoPesan]

           ,[KodeCustSupp]

           ,[TglKirim]

           ,[NoLC]

           ,[NamaKirim]

           ,[AlamatKirim]

           ,[Packing]

           ,[Catatan]

           ,[IsCetak]

           ,[IDUser]

           ,[IsClose]

           ,[FlagTipe]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoAlamatKirim]

           ,[isCetakKitir]

           ,[cetakke]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[IsBatal]

           ,[UserBatal]

           ,[TglBatal]

           ,[Devisi]

     from [36.64.152.3].[DBBCAGROUP].[dbo].dbSPP where NoBukti=@Nobukti ) B on b.NoBukti=a.NoBukti where a.NoBukti=@Nobukti

      

      if not exists(select NoBukti from [dbSPP] where NoBukti=@Nobukti) 

      INSERT INTO [dbSPP]

        ([NoBukti]

           ,[NoUrut]

           ,[Tanggal]

           ,[NoSHIP]

           ,[NoPesan]

           ,[KodeCustSupp]

           ,[TglKirim]

           ,[NoLC]

           ,[NamaKirim]

           ,[AlamatKirim]

           ,[Packing]

           ,[Catatan]

           ,[IsCetak]

           ,[IDUser]

           ,[IsClose]

           ,[FlagTipe]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoAlamatKirim]

           ,[isCetakKitir]

           ,[cetakke]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[IsBatal]

           ,[UserBatal]

           ,[TglBatal]

           ,[Devisi])

     select [NoBukti]

           ,[NoUrut]

           ,[Tanggal]

           ,[NoSHIP]

           ,[NoPesan]

           ,[KodeCustSupp]

           ,[TglKirim]

           ,[NoLC]

           ,[NamaKirim]

           ,[AlamatKirim]

           ,[Packing]

           ,[Catatan]

           ,[IsCetak]

           ,[IDUser]

           ,[IsClose]

           ,[FlagTipe]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoAlamatKirim]

           ,[isCetakKitir]

           ,[cetakke]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[IsBatal]

           ,[UserBatal]

           ,[TglBatal]

           ,[Devisi] from [36.64.152.3].[DBBCAGROUP].[dbo].dbSPP where NoBukti=@Nobukti

      

     update [36.64.152.3].[DBBCAGROUP].[dbo].dbSPP set Tf=1 where NoBukti in (select NoBukti from dbSPP where NoBukti=@Nobukti) 

    else

   if @Do='D'

   delete dbSPP where NoBukti=@Nobukti

     delete [36.64.152.3].[DBBCAGROUP].[dbo].TempDelData where nobukti=@Nobukti and tabel='dbSPP'


 Fetch Next from MySikron into @Nobukti, @Do

 

     Close MySikron

     Deallocate MySikron

     

--dbSPPDet

Declare MySinkronDet Cursor for

   select nobukti,urut,Do from [36.64.152.3].[DBBCAGROUP].[dbo].dbSPPDet where COALESCE(tf,0)=0 and nobukti in (select nobukti from dbSPP where devisi in ('03','04') and IsOtorisasi2=1) 

   and ((Do<>'I' and 1=1) or (Do='I' and nobukti+Cast(urut as varchar(4)) not in (select nobukti+Cast(urut as varchar(4)) from [dbsppdet])))

   union all

   select Nobukti,urut,'D' from [36.64.152.3].[DBBCAGROUP].[dbo].TempDelDataDet where tabel='dbSPPDet'

 Open MySinkronDet

 Fetch Next from MySinkronDet into @Nobukti,@Urut,@Do

 While @@fetch_Status=0

 if (@Do='I' or COALESCE(@Do,'')='')

   INSERT INTO [dbSPPDet]

        ([NoBukti]

           ,[Urut]

           ,[NoSO]

           ,[UrutSO]

           ,[KodeBrg]

           ,[NamaBrg]

           ,[QNT]

           ,[QNT2]

           ,[SAT_1]

           ,[SAT_2]

           ,[NOSAT]

           ,[ISI]

           ,[NetW]

           ,[GrossW]

           ,[Mesurement]

           ,[KetDetail]

           ,[ShippingMark]

           ,[HPP]

           ,[Kodegdg]

           ,[isCetakKitir]

           ,[QntMax]

           ,[QntBatal]

           ,[KetBatal])

     select [NoBukti]

           ,[Urut]

           ,[NoSO]

           ,[UrutSO]

           ,[KodeBrg]

           ,[NamaBrg]

           ,[QNT]

           ,[QNT2]

           ,[SAT_1]

           ,[SAT_2]

           ,[NOSAT]

           ,[ISI]

           ,[NetW]

           ,[GrossW]

           ,[Mesurement]

           ,[KetDetail]

           ,[ShippingMark]

           ,[HPP]

           ,[Kodegdg]

           ,[isCetakKitir]

           ,[QntMax]

           ,[QntBatal]

           ,[KetBatal] from [36.64.152.3].[DBBCAGROUP].[dbo].dbSPPDet where NoBukti=@Nobukti and Urut=@Urut

     update [36.64.152.3].[DBBCAGROUP].[dbo].dbSPPDet set Tf=1 where NoBukti+CAST(Urut as varchar(3)) in 

         (select +CAST(Urut as varchar(3)) from [dbSPPDet] where NoBukti=@Nobukti and Urut=@Urut) 

    else

   if @Do='U'

   Update [dbSPPDet] set 

           [NoBukti]=b.[NoBukti]

           ,[Urut]=b.[Urut]

           ,[NoSO]=b.[NoSO]

           ,[UrutSO]=b.[UrutSO]

           ,[KodeBrg]=b.[KodeBrg]

           ,[NamaBrg]=b.[NamaBrg]

           ,[QNT]=b.[QNT]

           ,[QNT2]=b.[QNT2]

           ,[SAT_1]=b.[SAT_1]

           ,[SAT_2]=b.[SAT_2]

           ,[NOSAT]=b.[NOSAT]

           ,[ISI]=b.[ISI]

           ,[NetW]=b.[NetW]

           ,[GrossW]=b.[GrossW]

           ,[Mesurement]=b.[Mesurement]

           ,[KetDetail]=b.[KetDetail]

           ,[ShippingMark]=b.[ShippingMark]

           ,[HPP]=b.[HPP]

           ,[Kodegdg]=b.[Kodegdg]

           ,[isCetakKitir]=b.[isCetakKitir]

           ,[QntMax]=b.[QntMax]

           ,[QntBatal]=b.[QntBatal]

           ,[KetBatal]=b.[KetBatal]

      from [dbSPPDet] a

      left outer join 

        (select [NoBukti]

           ,[Urut]

           ,[NoSO]

           ,[UrutSO]

           ,[KodeBrg]

           ,[NamaBrg]

           ,[QNT]

           ,[QNT2]

           ,[SAT_1]

           ,[SAT_2]

           ,[NOSAT]

           ,[ISI]

           ,[NetW]

           ,[GrossW]

           ,[Mesurement]

           ,[KetDetail]

           ,[ShippingMark]

           ,[HPP]

           ,[Kodegdg]

           ,[isCetakKitir]

           ,[QntMax]

           ,[QntBatal]

           ,[KetBatal]

     from [36.64.152.3].[DBBCAGROUP].[dbo].dbSPPDet where NoBukti=@Nobukti and Urut=@Urut ) B on b.NoBukti=a.NoBukti and b.Urut=a.Urut where a.NoBukti=@Nobukti and a.Urut=@Urut

      

      if not exists(select NoBukti from dbSPPDet where NoBukti=@Nobukti and Urut=@Urut) 

      INSERT INTO [dbSPPDet]

        ([NoBukti]

           ,[Urut]

           ,[NoSO]

           ,[UrutSO]

           ,[KodeBrg]

           ,[NamaBrg]

           ,[QNT]

           ,[QNT2]

           ,[SAT_1]

           ,[SAT_2]

           ,[NOSAT]

           ,[ISI]

           ,[NetW]

           ,[GrossW]

           ,[Mesurement]

           ,[KetDetail]

           ,[ShippingMark]

           ,[HPP]

           ,[Kodegdg]

           ,[isCetakKitir]

           ,[QntMax]

           ,[QntBatal]

           ,[KetBatal])

     select [NoBukti]

           ,[Urut]

           ,[NoSO]

           ,[UrutSO]

           ,[KodeBrg]

           ,[NamaBrg]

           ,[QNT]

           ,[QNT2]

           ,[SAT_1]

           ,[SAT_2]

           ,[NOSAT]

           ,[ISI]

           ,[NetW]

           ,[GrossW]

           ,[Mesurement]

           ,[KetDetail]

           ,[ShippingMark]

           ,[HPP]

           ,[Kodegdg]

           ,[isCetakKitir]

           ,[QntMax]

           ,[QntBatal]

           ,[KetBatal] from [36.64.152.3].[DBBCAGROUP].[dbo].dbSPPDet where NoBukti=@Nobukti and Urut=@Urut      

     update [36.64.152.3].[DBBCAGROUP].[dbo].dbSPPDet set Tf=1 where NoBukti+CAST(Urut as varchar(3)) in 

         (select +CAST(Urut as varchar(3)) from [dbSPPDet] where NoBukti=@Nobukti and Urut=@Urut) 

    else

   if @Do='D'

   delete [dbSPPDet] where NoBukti=@Nobukti and Urut=@Urut

     delete [36.64.152.3].[DBBCAGROUP].[dbo].TempDelDataDet where nobukti=@Nobukti and urut=@Urut and tabel='dbSPPDet'


 Fetch Next from MySinkronDet into @Nobukti,@Urut,@Do

 

     Close MySinkronDet

     Deallocate MySinkronDet 



--dbSPB 

Declare MySikron Cursor for

   select nobukti,Do from [36.64.152.3].[DBBCAGROUP].[dbo].dbSPB  where COALESCE(tf,0)=0 and devisi in ('03','04') and IsOtorisasi1=1 

   and ((Do<>'I' and 1=1) or (Do='I' and nobukti not in (select nobukti from [dbspb])))



   union all

   select Nobukti,'D' from [36.64.152.3].[DBBCAGROUP].[dbo].TempDelData where tabel='dbSPB'

 Open MySikron

 Fetch Next from MySikron into @Nobukti, @Do

 While @@fetch_Status=0

 if (@Do='I' or COALESCE(@Do,'')='')

   INSERT INTO [dbSPB]

        ([NoBukti]

           ,[NoUrut]

           ,[Tanggal]

           ,[NoSPP]

           ,[KodeCustSupp]

           ,[NoPolKend]

           ,[Container]

           ,[NoContainer]

           ,[NoSeal]

           ,[Sopir]

           ,[Catatan]

           ,[IsCetak]

           ,[CetakKe]

           ,[IDUser]

           ,[IsClose]

           ,[FlagTipe]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[KodeExp]

           ,[NoResi]

           ,[JumlahTagihan]

           ,[IsBatal]

           ,[UserBatal]

           ,[TglBatal]

           ,[NoTarif]

           ,[NoRetur]

           ,[IsOS]

           ,[Devisi]

           ,[IsOsInv])

     select [NoBukti]

           ,[NoUrut]

           ,[Tanggal]

           ,[NoSPP]

           ,[KodeCustSupp]

           ,[NoPolKend]

           ,[Container]

           ,[NoContainer]

           ,[NoSeal]

           ,[Sopir]

           ,[Catatan]

           ,[IsCetak]

           ,[CetakKe]

           ,[IDUser]

           ,[IsClose]

           ,[FlagTipe]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[KodeExp]

           ,[NoResi]

           ,[JumlahTagihan]

           ,[IsBatal]

           ,[UserBatal]

           ,[TglBatal]

           ,[NoTarif]

           ,[NoRetur]

           ,[IsOS]

           ,[Devisi]

           ,[IsOsInv] from [36.64.152.3].[DBBCAGROUP].[dbo].dbSPB where NoBukti=@Nobukti

     update [36.64.152.3].[DBBCAGROUP].[dbo].dbSPB set Tf=1 where NoBukti in (select NoBukti from [dbSPB] where NoBukti=@Nobukti) 

    else

   if @Do='U'

   Update dbSPB set 

           [Tanggal]=b.[Tanggal]

           ,[NoSPP]=b.[NoSPP]

           ,[KodeCustSupp]=b.[KodeCustSupp]

           ,[NoPolKend]=b.[NoPolKend]

           ,[Container]=b.[Container]

           ,[NoContainer]=b.[NoContainer]

           ,[NoSeal]=b.[NoSeal]

           ,[Sopir]=b.[Sopir]

           ,[Catatan]=b.[Catatan]

           ,[IsCetak]=b.[IsCetak]

           ,[CetakKe]=b.[CetakKe]

           ,[IDUser]=b.[IDUser]

           ,[IsClose]=b.[IsClose]

           ,[FlagTipe]=b.[FlagTipe]

           ,[IsOtorisasi1]=b.[IsOtorisasi1]

           ,[OtoUser1]=b.[OtoUser1]

           ,[TglOto1]=b.[TglOto1]

           ,[IsOtorisasi2]=b.[IsOtorisasi2]

           ,[OtoUser2]=b.[OtoUser2]

           ,[TglOto2]=b.[TglOto2]

           ,[IsOtorisasi3]=b.[IsOtorisasi3]

           ,[OtoUser3]=b.[OtoUser3]

           ,[TglOto3]=b.[TglOto3]

           ,[IsOtorisasi4]=b.[IsOtorisasi4]

           ,[OtoUser4]=b.[OtoUser4]

           ,[TglOto4]=b.[TglOto4]

           ,[IsOtorisasi5]=b.[IsOtorisasi5]

           ,[OtoUser5]=b.[OtoUser5]

           ,[TglOto5]=b.[TglOto5]

           ,[NoJurnal]=b.[NoJurnal]

           ,[NoUrutJurnal]=b.[NoUrutJurnal]

           ,[TglJurnal]=b.[TglJurnal]

           ,[MaxOL]=b.[MaxOL]

           ,[KodeExp]=b.[KodeExp]

           ,[NoResi]=b.[NoResi]

           ,[JumlahTagihan]=b.[JumlahTagihan]

           ,[IsBatal]=b.[IsBatal]

           ,[UserBatal]=b.[UserBatal]

           ,[TglBatal]=b.[TglBatal]

           ,[NoTarif]=b.[NoTarif]

           ,[NoRetur]=b.[NoRetur]

           ,[IsOS]=b.[IsOS]

           ,[Devisi]=b.[Devisi]

           ,[IsOsInv]=b.[IsOsInv]

      from [dbSPB] a

      left outer join 

        (select [NoBukti]

           ,[NoUrut]

           ,[Tanggal]

           ,[NoSPP]

           ,[KodeCustSupp]

           ,[NoPolKend]

           ,[Container]

           ,[NoContainer]

           ,[NoSeal]

           ,[Sopir]

           ,[Catatan]

           ,[IsCetak]

           ,[CetakKe]

           ,[IDUser]

           ,[IsClose]

           ,[FlagTipe]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[KodeExp]

           ,[NoResi]

           ,[JumlahTagihan]

           ,[IsBatal]

           ,[UserBatal]

           ,[TglBatal]

           ,[NoTarif]

           ,[NoRetur]

           ,[IsOS]

           ,[Devisi]

           ,[IsOsInv]

     from [36.64.152.3].[DBBCAGROUP].[dbo].dbSPB where NoBukti=@Nobukti ) B on b.NoBukti=a.NoBukti where a.NoBukti=@Nobukti

      

      if not exists(select NoBukti from [dbSPB] where NoBukti=@Nobukti) 

      INSERT INTO [dbSPB]

        ([NoBukti]

           ,[NoUrut]

           ,[Tanggal]

           ,[NoSPP]

           ,[KodeCustSupp]

           ,[NoPolKend]

           ,[Container]

           ,[NoContainer]

           ,[NoSeal]

           ,[Sopir]

           ,[Catatan]

           ,[IsCetak]

           ,[CetakKe]

           ,[IDUser]

           ,[IsClose]

           ,[FlagTipe]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[KodeExp]

           ,[NoResi]

           ,[JumlahTagihan]

           ,[IsBatal]

           ,[UserBatal]

           ,[TglBatal]

           ,[NoTarif]

           ,[NoRetur]

           ,[IsOS]

           ,[Devisi]

           ,[IsOsInv])

     select [NoBukti]

           ,[NoUrut]

           ,[Tanggal]

           ,[NoSPP]

           ,[KodeCustSupp]

           ,[NoPolKend]

           ,[Container]

           ,[NoContainer]

           ,[NoSeal]

           ,[Sopir]

           ,[Catatan]

           ,[IsCetak]

           ,[CetakKe]

           ,[IDUser]

           ,[IsClose]

           ,[FlagTipe]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[KodeExp]

           ,[NoResi]

           ,[JumlahTagihan]

           ,[IsBatal]

           ,[UserBatal]

           ,[TglBatal]

           ,[NoTarif]

           ,[NoRetur]

           ,[IsOS]

           ,[Devisi]

           ,[IsOsInv] from [36.64.152.3].[DBBCAGROUP].[dbo].dbSPB where NoBukti=@Nobukti

      

     update [36.64.152.3].[DBBCAGROUP].[dbo].dbSPB set Tf=1 where NoBukti in (select NoBukti from dbSPB where NoBukti=@Nobukti) 

    else

   if @Do='D'

   delete dbSPB where NoBukti=@Nobukti

     delete [36.64.152.3].[DBBCAGROUP].[dbo].TempDelData where nobukti=@Nobukti and tabel='dbSPB'


 Fetch Next from MySikron into @Nobukti, @Do

 

     Close MySikron

     Deallocate MySikron

     

--dbSPBDet

Declare MySinkronDet Cursor for

   select nobukti,urut,Do from [36.64.152.3].[DBBCAGROUP].[dbo].dbSPBDet where COALESCE(tf,0)=0 and nobukti in (select nobukti from dbSPB where devisi in ('03','04') and IsOtorisasi1=1) 

   and ((Do<>'I' and 1=1) or (Do='I' and nobukti+Cast(urut as varchar(4)) not in (select nobukti+Cast(urut as varchar(4)) from [dbspbdet])))

   union all

   select Nobukti,urut,'D' from [36.64.152.3].[DBBCAGROUP].[dbo].TempDelDataDet where tabel='dbSPBDet'

 Open MySinkronDet

 Fetch Next from MySinkronDet into @Nobukti,@Urut,@Do

 While @@fetch_Status=0

 if (@Do='I' or COALESCE(@Do,'')='')

   INSERT INTO [dbSPBDet]

        ([NoBukti]

           ,[Urut]

           ,[NoSPP]

           ,[UrutSPP]

           ,[KodeBrg]

           ,[Namabrg]

           ,[QNT]

           ,[QNT2]

           ,[SAT_1]

           ,[SAT_2]

           ,[NOSAT]

           ,[ISI]

           ,[NetW]

           ,[GrossW]

           ,[HPP]

           ,[KodeGdg]

           ,[isCetakKitir]

           ,[isDO]

           ,[KodeBrgA])

     select [NoBukti]

           ,[Urut]

           ,[NoSPP]

           ,[UrutSPP]

           ,[KodeBrg]

           ,[Namabrg]

           ,[QNT]

           ,[QNT2]

           ,[SAT_1]

           ,[SAT_2]

           ,[NOSAT]

           ,[ISI]

           ,[NetW]

           ,[GrossW]

           ,[HPP]

           ,[KodeGdg]

           ,[isCetakKitir]

           ,[isDO]

           ,[KodeBrgA] from [36.64.152.3].[DBBCAGROUP].[dbo].dbSPBDet where NoBukti=@Nobukti and Urut=@Urut

     update [36.64.152.3].[DBBCAGROUP].[dbo].dbSPBDet set Tf=1 where NoBukti+CAST(Urut as varchar(3)) in 

         (select +CAST(Urut as varchar(3)) from [dbSPBDet] where NoBukti=@Nobukti and Urut=@Urut) 

    else

   if @Do='U'

   Update [dbSPBDet] set 

           [NoBukti]=b.[NoBukti]

           ,[Urut]=b.[Urut]

           ,[NoSPP]=b.[NoSPP]

           ,[UrutSPP]=b.[UrutSPP]

           ,[KodeBrg]=b.[KodeBrg]

           ,[Namabrg]=b.[Namabrg]

           ,[QNT]=b.[QNT]

           ,[QNT2]=b.[QNT2]

           ,[SAT_1]=b.[SAT_1]

           ,[SAT_2]=b.[SAT_2]

           ,[NOSAT]=b.[NOSAT]

           ,[ISI]=b.[ISI]

           ,[NetW]=b.[NetW]

           ,[GrossW]=b.[GrossW]

           ,[HPP]=b.[HPP]

           ,[KodeGdg]=b.[KodeGdg]

           ,[isCetakKitir]=b.[isCetakKitir]

           ,[isDO]=b.[isDO]

           ,[KodeBrgA]=b.[KodeBrgA]

      from [dbSPBDet] a

      left outer join 

        (select [NoBukti]

           ,[Urut]

           ,[NoSPP]

           ,[UrutSPP]

           ,[KodeBrg]

           ,[Namabrg]

           ,[QNT]

           ,[QNT2]

           ,[SAT_1]

           ,[SAT_2]

           ,[NOSAT]

           ,[ISI]

           ,[NetW]

           ,[GrossW]

           ,[HPP]

           ,[KodeGdg]

           ,[isCetakKitir]

           ,[isDO]

           ,[KodeBrgA]

     from [36.64.152.3].[DBBCAGROUP].[dbo].dbSPBDet where NoBukti=@Nobukti and Urut=@Urut ) B on b.NoBukti=a.NoBukti and b.Urut=a.Urut where a.NoBukti=@Nobukti and a.Urut=@Urut

      

      if not exists(select NoBukti from dbSPBDet where NoBukti=@Nobukti and Urut=@Urut) 

      INSERT INTO [dbSPBDet]

        ([NoBukti]

           ,[Urut]

           ,[NoSPP]

           ,[UrutSPP]

           ,[KodeBrg]

           ,[Namabrg]

           ,[QNT]

           ,[QNT2]

           ,[SAT_1]

           ,[SAT_2]

           ,[NOSAT]

           ,[ISI]

           ,[NetW]

           ,[GrossW]

           ,[HPP]

           ,[KodeGdg]

           ,[isCetakKitir]

           ,[isDO]

           ,[KodeBrgA])

     select [NoBukti]

           ,[Urut]

           ,[NoSPP]

           ,[UrutSPP]

           ,[KodeBrg]

           ,[Namabrg]

           ,[QNT]

           ,[QNT2]

           ,[SAT_1]

           ,[SAT_2]

           ,[NOSAT]

           ,[ISI]

           ,[NetW]

           ,[GrossW]

           ,[HPP]

           ,[KodeGdg]

           ,[isCetakKitir]

           ,[isDO]

           ,[KodeBrgA] from [36.64.152.3].[DBBCAGROUP].[dbo].dbSPBDet where NoBukti=@Nobukti and Urut=@Urut 

     

     update [36.64.152.3].[DBBCAGROUP].[dbo].dbSPBDet set Tf=1 where NoBukti+CAST(Urut as varchar(3)) in 

         (select +CAST(Urut as varchar(3)) from [dbSPBDet] where NoBukti=@Nobukti and Urut=@Urut) 

    else

   if @Do='D'

   delete [dbSPBDet] where NoBukti=@Nobukti and Urut=@Urut

     delete [36.64.152.3].[DBBCAGROUP].[dbo].TempDelDataDet where nobukti=@Nobukti and urut=@Urut and tabel='dbSPBDet'


 Fetch Next from MySinkronDet into @Nobukti,@Urut,@Do

 

     Close MySinkronDet

     Deallocate MySinkronDet



--dbRSPB 

Declare MySikron Cursor for

   select nobukti,Do from [36.64.152.3].[DBBCAGROUP].[dbo].dbRSPB  where COALESCE(tf,0)=0 and devisi in ('03','04') and IsOtorisasi1=1 

   and ((Do<>'I' and 1=1) or (Do='I' and nobukti not in (select nobukti from [dbrspb])))

   union all

   select Nobukti,'D' from [36.64.152.3].[DBBCAGROUP].[dbo].TempDelData where tabel='dbRSPB'

 Open MySikron

 Fetch Next from MySikron into @Nobukti, @Do

 While @@fetch_Status=0

 if (@Do='I' or COALESCE(@Do,'')='')

   INSERT INTO [dbRSPB]

        ([NoBukti]

           ,[NoUrut]

           ,[Tanggal]

           ,[NoSPB]

           ,[KodeCustSupp]

           ,[NoPolKend]

           ,[Container]

           ,[NoContainer]

           ,[NoSeal]

           ,[Catatan]

           ,[IsCetak]

           ,[IDUser]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[IsEkstern]

           ,[CustAngkutan]

           ,[IsFlag]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[KodeGdg]

           ,[MaxOL]

           ,[CetakKe]

           ,[TipeRetur]

           ,[IsTukarBrg]

           ,[Devisi])

     select [NoBukti]

           ,[NoUrut]

           ,[Tanggal]

           ,[NoSPB]

           ,[KodeCustSupp]

           ,[NoPolKend]

           ,[Container]

           ,[NoContainer]

           ,[NoSeal]

           ,[Catatan]

           ,[IsCetak]

           ,[IDUser]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[IsEkstern]

           ,[CustAngkutan]

           ,[IsFlag]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[KodeGdg]

           ,[MaxOL]

           ,[CetakKe]

           ,[TipeRetur]

           ,[IsTukarBrg]

           ,[Devisi] from [36.64.152.3].[DBBCAGROUP].[dbo].dbRSPB where NoBukti=@Nobukti

     update [36.64.152.3].[DBBCAGROUP].[dbo].dbRSPB set Tf=1 where NoBukti in (select NoBukti from [dbRSPB] where NoBukti=@Nobukti) 

    else

   if @Do='U'

   Update dbRSPB set 

           [Tanggal]=b.[Tanggal]

           ,[NoSPB]=b.[NoSPB]

           ,[KodeCustSupp]=b.[KodeCustSupp]

           ,[NoPolKend]=b.[NoPolKend]

           ,[Container]=b.[Container]

           ,[NoContainer]=b.[NoContainer]

           ,[NoSeal]=b.[NoSeal]

           ,[Catatan]=b.[Catatan]

           ,[IsCetak]=b.[IsCetak]

           ,[IDUser]=b.[IDUser]

           ,[IsOtorisasi1]=b.[IsOtorisasi1]

           ,[OtoUser1]=b.[OtoUser1]

           ,[TglOto1]=b.[TglOto1]

           ,[IsOtorisasi2]=b.[IsOtorisasi2]

           ,[OtoUser2]=b.[OtoUser2]

           ,[TglOto2]=b.[TglOto2]

           ,[IsOtorisasi3]=b.[IsOtorisasi3]

           ,[OtoUser3]=b.[OtoUser3]

           ,[TglOto3]=b.[TglOto3]

           ,[IsOtorisasi4]=b.[IsOtorisasi4]

           ,[OtoUser4]=b.[OtoUser4]

           ,[TglOto4]=b.[TglOto4]

           ,[IsOtorisasi5]=b.[IsOtorisasi5]

           ,[OtoUser5]=b.[OtoUser5]

           ,[TglOto5]=b.[TglOto5]

           ,[IsEkstern]=b.[IsEkstern]

           ,[CustAngkutan]=b.[CustAngkutan]

           ,[IsFlag]=b.[IsFlag]

           ,[NoJurnal]=b.[NoJurnal]

           ,[NoUrutJurnal]=b.[NoUrutJurnal]

           ,[TglJurnal]=b.[TglJurnal]

           ,[KodeGdg]=b.[KodeGdg]

           ,[MaxOL]=b.[MaxOL]

           ,[CetakKe]=b.[MaxOL]

           ,[TipeRetur]=b.[TipeRetur]

           ,[IsTukarBrg]=b.[IsTukarBrg]

           ,[Devisi]=b.[Devisi]

      from [dbRSPB] a

      left outer join 

        (select [NoBukti]

           ,[NoUrut]

           ,[Tanggal]

           ,[NoSPB]

           ,[KodeCustSupp]

           ,[NoPolKend]

           ,[Container]

           ,[NoContainer]

           ,[NoSeal]

           ,[Catatan]

           ,[IsCetak]

           ,[IDUser]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[IsEkstern]

           ,[CustAngkutan]

           ,[IsFlag]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[KodeGdg]

           ,[MaxOL]

           ,[CetakKe]

           ,[TipeRetur]

           ,[IsTukarBrg]

           ,[Devisi]

     from [36.64.152.3].[DBBCAGROUP].[dbo].dbRSPB where NoBukti=@Nobukti ) B on b.NoBukti=a.NoBukti where a.NoBukti=@Nobukti

      

      if not exists(select NoBukti from [dbRSPB] where NoBukti=@Nobukti) 

      INSERT INTO [dbRSPB]

        ([NoBukti]

           ,[NoUrut]

           ,[Tanggal]

           ,[NoSPB]

           ,[KodeCustSupp]

           ,[NoPolKend]

           ,[Container]

           ,[NoContainer]

           ,[NoSeal]

           ,[Catatan]

           ,[IsCetak]

           ,[IDUser]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[IsEkstern]

           ,[CustAngkutan]

           ,[IsFlag]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[KodeGdg]

           ,[MaxOL]

           ,[CetakKe]

           ,[TipeRetur]

           ,[IsTukarBrg]

           ,[Devisi])

     select [NoBukti]

           ,[NoUrut]

           ,[Tanggal]

           ,[NoSPB]

           ,[KodeCustSupp]

           ,[NoPolKend]

           ,[Container]

           ,[NoContainer]

           ,[NoSeal]

           ,[Catatan]

           ,[IsCetak]

           ,[IDUser]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[IsEkstern]

           ,[CustAngkutan]

           ,[IsFlag]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[KodeGdg]

           ,[MaxOL]

           ,[CetakKe]

           ,[TipeRetur]

           ,[IsTukarBrg]

           ,[Devisi] from [36.64.152.3].[DBBCAGROUP].[dbo].dbRSPB where NoBukti=@Nobukti

      

     update [36.64.152.3].[DBBCAGROUP].[dbo].dbRSPB set Tf=1 where NoBukti in (select NoBukti from dbRSPB where NoBukti=@Nobukti) 

    else

   if @Do='D'

   delete dbRSPB where NoBukti=@Nobukti

     delete [36.64.152.3].[DBBCAGROUP].[dbo].TempDelData where nobukti=@Nobukti and tabel='dbRSPB'


 Fetch Next from MySikron into @Nobukti, @Do

 

     Close MySikron

     Deallocate MySikron

     

--dbRSPBDet

Declare MySinkronDet Cursor for

   select nobukti,urut,Do from [36.64.152.3].[DBBCAGROUP].[dbo].dbRSPBDet where COALESCE(tf,0)=0 and nobukti in (select nobukti from dbRSPB where devisi in ('03','04') and IsOtorisasi1=1) 

   and ((Do<>'I' and 1=1) or (Do='I' and nobukti+Cast(urut as varchar(4)) not in (select nobukti+Cast(urut as varchar(4)) from [dbrspbdet])))

   union all

   select Nobukti,urut,'D' from [36.64.152.3].[DBBCAGROUP].[dbo].TempDelDataDet where tabel='dbRSPBDet'

 Open MySinkronDet

 Fetch Next from MySinkronDet into @Nobukti,@Urut,@Do

 While @@fetch_Status=0

 if (@Do='I' or COALESCE(@Do,'')='')

   INSERT INTO [dbRSPBDet]

        ([NoBukti]

           ,[Urut]

           ,[NoSPB]

           ,[UrutSPB]

           ,[KodeBrg]

           ,[Namabrg]

           ,[QNT]

           ,[QNT2]

           ,[SAT_1]

           ,[SAT_2]

           ,[NOSAT]

           ,[ISI]

           ,[NetW]

           ,[GrossW]

           ,[HPP])

     select [NoBukti]

           ,[Urut]

           ,[NoSPB]

           ,[UrutSPB]

           ,[KodeBrg]

           ,[Namabrg]

           ,[QNT]

           ,[QNT2]

           ,[SAT_1]

           ,[SAT_2]

           ,[NOSAT]

           ,[ISI]

           ,[NetW]

           ,[GrossW]

           ,[HPP] from [36.64.152.3].[DBBCAGROUP].[dbo].dbRSPBDet where NoBukti=@Nobukti and Urut=@Urut

     update [36.64.152.3].[DBBCAGROUP].[dbo].dbRSPBDet set Tf=1 where NoBukti+CAST(Urut as varchar(3)) in 

         (select +CAST(Urut as varchar(3)) from [dbRSPBDet] where NoBukti=@Nobukti and Urut=@Urut) 

    else

   if @Do='U'

   Update [dbRSPBDet] set 

           [NoSPB]=b.[NoSPB]

           ,[UrutSPB]=b.[NoSPB]

           ,[KodeBrg]=b.[KodeBrg]

           ,[Namabrg]=b.[Namabrg]

           ,[QNT]=b.[QNT]

           ,[QNT2]=b.[QNT2]

           ,[SAT_1]=b.[SAT_1]

           ,[SAT_2]=b.[SAT_2]

           ,[NOSAT]=b.[NOSAT]

           ,[ISI]=b.[ISI]

           ,[NetW]=b.[NetW]

           ,[GrossW]=b.[GrossW]

           ,[HPP]=b.[HPP]

      from [dbRSPBDet] a

      left outer join 

        (select [NoBukti]

           ,[Urut]

           ,[NoSPB]

           ,[UrutSPB]

           ,[KodeBrg]

           ,[Namabrg]

           ,[QNT]

           ,[QNT2]

           ,[SAT_1]

           ,[SAT_2]

           ,[NOSAT]

           ,[ISI]

           ,[NetW]

           ,[GrossW]

           ,[HPP]

     from [36.64.152.3].[DBBCAGROUP].[dbo].dbRSPBDet where NoBukti=@Nobukti and Urut=@Urut ) B on b.NoBukti=a.NoBukti and b.Urut=a.Urut where a.NoBukti=@Nobukti and a.Urut=@Urut

      

      if not exists(select NoBukti from dbRSPBDet where NoBukti=@Nobukti and Urut=@Urut) 

      INSERT INTO [dbRSPBDet]

        ([NoBukti]

           ,[Urut]

           ,[NoSPB]

           ,[UrutSPB]

           ,[KodeBrg]

           ,[Namabrg]

           ,[QNT]

           ,[QNT2]

           ,[SAT_1]

           ,[SAT_2]

           ,[NOSAT]

           ,[ISI]

           ,[NetW]

           ,[GrossW]

           ,[HPP])

     select [NoBukti]

           ,[Urut]

           ,[NoSPB]

           ,[UrutSPB]

           ,[KodeBrg]

           ,[Namabrg]

           ,[QNT]

           ,[QNT2]

           ,[SAT_1]

           ,[SAT_2]

           ,[NOSAT]

           ,[ISI]

           ,[NetW]

           ,[GrossW]

           ,[HPP] from [36.64.152.3].[DBBCAGROUP].[dbo].dbRSPBDet where NoBukti=@Nobukti and Urut=@Urut

     

     update [36.64.152.3].[DBBCAGROUP].[dbo].dbRSPBDet set Tf=1 where NoBukti+CAST(Urut as varchar(3)) in 

         (select +CAST(Urut as varchar(3)) from [dbRSPBDet] where NoBukti=@Nobukti and Urut=@Urut) 

    else

   if @Do='D'

   delete [dbRSPBDet] where NoBukti=@Nobukti and Urut=@Urut

     delete [36.64.152.3].[DBBCAGROUP].[dbo].TempDelDataDet where nobukti=@Nobukti and urut=@Urut and tabel='dbRSPBDet'


 Fetch Next from MySinkronDet into @Nobukti,@Urut,@Do

 

     Close MySinkronDet

     Deallocate MySinkronDet  

   

--dbPPl

Declare MySikron Cursor for

   select nobukti,Do from [36.64.152.3].[DBBCAGROUP].[dbo].dbPPL where COALESCE(tf,0)=0 and devisi in ('03','04') and IsOtorisasi1=1 

    and ((Do<>'I' and 1=1) or (Do='I' and nobukti not in (select nobukti from [dbppl])))

   union all

   select Nobukti,'D' from [36.64.152.3].[DBBCAGROUP].[dbo].TempDelData where tabel='dbPPL'

 Open MySikron

 Fetch Next from MySikron into @Nobukti, @Do

 While @@fetch_Status=0

 if (@Do='I' or COALESCE(@Do,'')='')

   INSERT INTO [dbPPL]

      ([Nobukti]

           ,[Nourut]

           ,[Tanggal]

           ,[IsClose]

           ,[KDDep]

           ,[cetakke]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[IsBatal]

           ,[UserBatal]

           ,[TglBatal]

           ,[Devisi])

     select [Nobukti]

           ,[Nourut]

           ,[Tanggal]

           ,[IsClose]

           ,[KDDep]

           ,[cetakke]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[IsBatal]

           ,[UserBatal]

           ,[TglBatal]

           ,[Devisi] from [36.64.152.3].[DBBCAGROUP].[dbo].dbPPL where NoBukti=@Nobukti

     update [36.64.152.3].[DBBCAGROUP].[dbo].dbPPL set Tf=1 where NoBukti in (select NoBukti from [dbPPL] where NoBukti=@Nobukti) 

    else

   if @Do='U'

   Update [dbPPL] set 

           [Tanggal]=b.[Tanggal]

           ,[IsClose]=b.[IsClose]

           ,[KDDep]=b.[KDDep]

           ,[cetakke]=b.[cetakke]

           ,[IsOtorisasi1]=b.[IsOtorisasi1]

           ,[OtoUser1]=b.[OtoUser1]

           ,[TglOto1]=b.[TglOto1]

           ,[IsOtorisasi2]=b.[IsOtorisasi2]

           ,[OtoUser2]=b.[OtoUser2]

           ,[TglOto2]=b.[TglOto2]

           ,[IsOtorisasi3]=b.[IsOtorisasi3]

           ,[OtoUser3]=b.[OtoUser3]

           ,[TglOto3]=b.[TglOto3]

           ,[IsOtorisasi4]=b.[IsOtorisasi4]

           ,[OtoUser4]=b.[OtoUser4]

           ,[TglOto4]=b.[TglOto4]

           ,[IsOtorisasi5]=b.[IsOtorisasi5]

           ,[OtoUser5]=b.[OtoUser5]

           ,[TglOto5]=b.[TglOto5]

           ,[NoJurnal]=b.[NoJurnal]

           ,[NoUrutJurnal]=b.[NoUrutJurnal]

           ,[TglJurnal]=b.[TglJurnal]

           ,[MaxOL]=b.[MaxOL]

           ,[IsBatal]=b.[IsBatal]

           ,[UserBatal]=b.[UserBatal]

           ,[TglBatal]=b.[TglBatal]

           ,[Devisi]=b.[Devisi]

      from [dbPPL] a

      left outer join 

        (select [Nobukti]

           ,[Nourut]

           ,[Tanggal]

           ,[IsClose]

           ,[KDDep]

           ,[cetakke]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[IsBatal]

           ,[UserBatal]

           ,[TglBatal]

           ,[Devisi]

     from [36.64.152.3].[DBBCAGROUP].[dbo].dbPPL where NoBukti=@Nobukti ) B on b.NoBukti=a.NoBukti where a.NoBukti=@Nobukti

      

      if not exists(select NoBukti from [dbPPL] where NoBukti=@Nobukti) 

      INSERT INTO [dbPPL]

      ([Nobukti]

           ,[Nourut]

           ,[Tanggal]

           ,[IsClose]

           ,[KDDep]

           ,[cetakke]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[IsBatal]

           ,[UserBatal]

           ,[TglBatal]

           ,[Devisi])

     select [Nobukti]

           ,[Nourut]

           ,[Tanggal]

           ,[IsClose]

           ,[KDDep]

           ,[cetakke]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[IsBatal]

           ,[UserBatal]

           ,[TglBatal]

           ,[Devisi] from [36.64.152.3].[DBBCAGROUP].[dbo].dbPPL where NoBukti=@Nobukti

      

      update [36.64.152.3].[DBBCAGROUP].[dbo].dbPPL set Tf=1 where NoBukti in (select NoBukti from [dbPPL] where NoBukti=@Nobukti) 

    else

   if @Do='D'

   delete [dbPPL] where NoBukti=@Nobukti

     delete [36.64.152.3].[DBBCAGROUP].[dbo].TempDelData where nobukti=@Nobukti and tabel='dbPPL'


 Fetch Next from MySikron into @Nobukti, @Do

 

     Close MySikron

     Deallocate MySikron

     

--dbppldet

Declare MySinkronDet Cursor for

   select nobukti,urut,Do from [36.64.152.3].[DBBCAGROUP].[dbo].dbppldet where COALESCE(tf,0)=0 and nobukti in ( select nobukti from dbppl where devisi in ('03','04') and IsOtorisasi1=1)

   and ((Do<>'I' and 1=1) or (Do='I' and nobukti+Cast(urut as varchar(4)) not in (select nobukti+Cast(urut as varchar(4)) from [dbppldet])))



   union all

   select Nobukti,urut,'D' from [36.64.152.3].[DBBCAGROUP].[dbo].TempDelDataDet where tabel='dbppldet'

 Open MySinkronDet

 Fetch Next from MySinkronDet into @Nobukti,@Urut,@Do

 While @@fetch_Status=0

 if (@Do='I' or COALESCE(@Do,'')='')

   INSERT INTO [dbppldet]

        ([Nobukti]

           ,[urut]

           ,[kodebrg]

           ,[Sat]

           ,[Nosat]

           ,[Isi]

           ,[Qnt]

           ,[QntPO]

           ,[Keterangan]

           ,[IsClose]

           ,[NoSPK]

           ,[UrutSPK]

           ,[NosatSPK]

           ,[Isbatal]

           ,[Tglbatal]

           ,[UserBatal]

           ,[Qntbatal]

           ,[TglKirim]

           ,[NamaBrg]

           ,[Alasan])

     select [Nobukti]

           ,[urut]

           ,[kodebrg]

           ,[Sat]

           ,[Nosat]

           ,[Isi]

           ,[Qnt]

           ,[QntPO]

           ,[Keterangan]

           ,[IsClose]

           ,[NoSPK]

           ,[UrutSPK]

           ,[NosatSPK]

           ,[Isbatal]

           ,[Tglbatal]

           ,[UserBatal]

           ,[Qntbatal]

           ,[TglKirim]

           ,[NamaBrg]

           ,[Alasan] from [36.64.152.3].[DBBCAGROUP].[dbo].dbppldet where NoBukti=@Nobukti and Urut=@Urut

     update [36.64.152.3].[DBBCAGROUP].[dbo].dbppldet set Tf=1 where NoBukti+CAST(Urut as varchar(3)) in 

         (select +CAST(Urut as varchar(3)) from [dbppldet] where NoBukti=@Nobukti and Urut=@Urut) 

    else

   if @Do='U'

   Update [dbppldet] set 

           [kodebrg]=B.[kodebrg]

           ,[Sat]=b.[Sat]

           ,[Nosat]=b.[Nosat]

           ,[Isi]=b.[Isi]

           ,[Qnt]=b.[Qnt]

           ,[QntPO]=b.[QntPO]

           ,[Keterangan]=b.[Keterangan]

           ,[IsClose]=b.[IsClose]

           ,[NoSPK]=b.[NoSPK]

           ,[UrutSPK]=b.[UrutSPK]

           ,[NosatSPK]=b.[NosatSPK]

           ,[Isbatal]=b.[Isbatal]

           ,[Tglbatal]=b.[Tglbatal]

           ,[UserBatal]=b.[UserBatal]

           ,[Qntbatal]=b.[Qntbatal]

           ,[TglKirim]=b.[TglKirim]

           ,[NamaBrg]=b.[NamaBrg]

           ,[Alasan]=b.[Alasan]

      from [dbppldet] a

      left outer join 

        (select [Nobukti]

           ,[urut]

           ,[kodebrg]

           ,[Sat]

           ,[Nosat]

           ,[Isi]

           ,[Qnt]

           ,[QntPO]

           ,[Keterangan]

           ,[IsClose]

           ,[NoSPK]

           ,[UrutSPK]

           ,[NosatSPK]

           ,[Isbatal]

           ,[Tglbatal]

           ,[UserBatal]

           ,[Qntbatal]

           ,[TglKirim]

           ,[NamaBrg]

           ,[Alasan]

     from [36.64.152.3].[DBBCAGROUP].[dbo].dbppldet where NoBukti=@Nobukti and Urut=@Urut ) B on b.NoBukti=a.NoBukti and b.Urut=a.Urut where a.NoBukti=@Nobukti and a.Urut=@Urut

      

      if not exists(select NoBukti from [dbppldet] where NoBukti=@Nobukti and Urut=@Urut) 

      INSERT INTO [dbppldet]

        ([Nobukti]

           ,[urut]

           ,[kodebrg]

           ,[Sat]

           ,[Nosat]

           ,[Isi]

           ,[Qnt]

           ,[QntPO]

           ,[Keterangan]

           ,[IsClose]

           ,[NoSPK]

           ,[UrutSPK]

           ,[NosatSPK]

           ,[Isbatal]

           ,[Tglbatal]

           ,[UserBatal]

           ,[Qntbatal]

           ,[TglKirim]

           ,[NamaBrg]

           ,[Alasan])

     select [Nobukti]

           ,[urut]

           ,[kodebrg]

           ,[Sat]

           ,[Nosat]

           ,[Isi]

           ,[Qnt]

           ,[QntPO]

           ,[Keterangan]

           ,[IsClose]

           ,[NoSPK]

           ,[UrutSPK]

           ,[NosatSPK]

           ,[Isbatal]

           ,[Tglbatal]

           ,[UserBatal]

           ,[Qntbatal]

           ,[TglKirim]

           ,[NamaBrg]

           ,[Alasan] from [36.64.152.3].[DBBCAGROUP].[dbo].dbppldet where NoBukti=@Nobukti and Urut=@Urut

      

     update [36.64.152.3].[DBBCAGROUP].[dbo].dbppldet set Tf=1 where NoBukti+CAST(Urut as varchar(3)) in 

         (select +CAST(Urut as varchar(3)) from [dbppldet] where NoBukti=@Nobukti and Urut=@Urut) 

    else

   if @Do='D'

   delete [dbppldet] where NoBukti=@Nobukti and Urut=@Urut

     delete [36.64.152.3].[DBBCAGROUP].[dbo].TempDelDataDet where nobukti=@Nobukti and urut=@Urut and tabel='dbppldet'


 Fetch Next from MySinkronDet into @Nobukti,@Urut,@Do

 

     Close MySinkronDet

     Deallocate MySinkronDet



--dbPO

Declare MySikron Cursor for

   select nobukti,Do from [36.64.152.3].[DBBCAGROUP].[dbo].dbPO where COALESCE(tf,0)=0 and devisi in ('03','04') and IsOtorisasi1=1 

   and ((Do<>'I' and 1=1) or (Do='I' and nobukti not in (select nobukti from [dbpo])))

   union all

   select Nobukti,'D' from [36.64.152.3].[DBBCAGROUP].[dbo].TempDelData where tabel='dbPO'

 Open MySikron

 Fetch Next from MySikron into @Nobukti, @Do

 While @@fetch_Status=0

 if (@Do='I' or COALESCE(@Do,'')='')

   INSERT INTO [dbPO]

      ([NOBUKTI]

           ,[NOURUT]

           ,[TANGGAL]

           ,[TglJatuhTempo]

           ,[KODESUPP]

           ,[HANDLING]

           ,[KODEEXP]

           ,[KETERANGAN]

           ,[FAKTURSUPP]

           ,[KODEVLS]

           ,[KURS]

           ,[PPN]

           ,[TIPEBAYAR]

           ,[HARI]

           ,[TipeDisc]

           ,[DISC]

           ,[DISCRP]

           ,[ISCETAK]

           ,[NilaiCetak]

           ,[IsBatal]

           ,[UserBatal]

           ,[IsClose]

           ,[IsExp]

           ,[isAut]

           ,[KodeGDG]

           ,[cetakke]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[TglBatal]

           ,[Syarat]

           ,[TglBatas]

           ,[Devisi])

     select [NOBUKTI]

           ,[NOURUT]

           ,[TANGGAL]

           ,[TglJatuhTempo]

           ,[KODESUPP]

           ,[HANDLING]

           ,[KODEEXP]

           ,[KETERANGAN]

           ,[FAKTURSUPP]

           ,[KODEVLS]

           ,[KURS]

           ,[PPN]

           ,[TIPEBAYAR]

           ,[HARI]

           ,[TipeDisc]

           ,[DISC]

           ,[DISCRP]

           ,[ISCETAK]

           ,[NilaiCetak]

           ,[IsBatal]

           ,[UserBatal]

           ,[IsClose]

           ,[IsExp]

           ,[isAut]

           ,[KodeGDG]

           ,[cetakke]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[TglBatal]

           ,[Syarat]

           ,[TglBatas]

           ,[Devisi] from [36.64.152.3].[DBBCAGROUP].[dbo].DBPO where NoBukti=@Nobukti

     update [36.64.152.3].[DBBCAGROUP].[dbo].DBPO set Tf=1 where NoBukti in (select NoBukti from [dbPO] where NoBukti=@Nobukti) 

    else

   if @Do='U'

   Update [dbPO] set 

            [TANGGAL]=b.[TANGGAL]

           ,[TglJatuhTempo]=b.[TglJatuhTempo]

           ,[KODESUPP]=b. [KODESUPP]

           ,[HANDLING] =b.[HANDLING]

           ,[KODEEXP] =b.[KODEEXP]

           ,[KETERANGAN] =b.[KETERANGAN]

           ,[FAKTURSUPP] =b.[FAKTURSUPP]

           ,[KODEVLS] =b.[KODEVLS]

           ,[KURS] =b.[KURS]

           ,[PPN] =b.[PPN]

           ,[TIPEBAYAR] =b.[TIPEBAYAR]

           ,[HARI] =b.[HARI]

           ,[TipeDisc] =b.[TipeDisc]

           ,[DISC] =b.[DISC]

           ,[DISCRP] =b.[DISCRP]

           ,[ISCETAK] =b.[ISCETAK]

           ,[NilaiCetak] =b.[NilaiCetak]

           ,[IsBatal] =b.[IsBatal]

           ,[UserBatal] =b.[UserBatal]

           ,[IsClose] =b.[IsClose]

           ,[IsExp] =b.[IsExp]

           ,[isAut] =b.[isAut]

           ,[KodeGDG] =b.[KodeGDG]

           ,[cetakke] =b.[cetakke]

           ,[IsOtorisasi1] =b.[IsOtorisasi1]

           ,[OtoUser1] =b.[OtoUser1]

           ,[TglOto1] =b.[TglOto1]

           ,[IsOtorisasi2] =b.[IsOtorisasi2]

           ,[OtoUser2] =b.[OtoUser2]

           ,[TglOto2] =b.[TglOto2]

           ,[IsOtorisasi3] =b.[IsOtorisasi3]

           ,[OtoUser3] =b.[OtoUser3]

           ,[TglOto3] =b.[TglOto3]

           ,[IsOtorisasi4] =b.[IsOtorisasi4]

           ,[OtoUser4] =b.[OtoUser4]

           ,[TglOto4] =b.[TglOto4]

           ,[IsOtorisasi5] =b.[IsOtorisasi5]

           ,[OtoUser5] =b.[OtoUser5]

           ,[TglOto5] =b.[TglOto5]

           ,[NoJurnal] =b.[NoJurnal]

           ,[NoUrutJurnal] =b.[NoUrutJurnal]

           ,[TglJurnal] =b.[TglJurnal]

           ,[MaxOL] =b.[MaxOL]

           ,[TglBatal] =b.[TglBatal]

           ,[Syarat] =b.[Syarat]

           ,[TglBatas] =b.[TglBatas]

           ,[Devisi] =b.[Devisi]

      from [dbPO] a

      left outer join 

        (select [NOBUKTI]

           ,[NOURUT]

           ,[TANGGAL]

           ,[TglJatuhTempo]

           ,[KODESUPP]

           ,[HANDLING]

           ,[KODEEXP]

           ,[KETERANGAN]

           ,[FAKTURSUPP]

           ,[KODEVLS]

           ,[KURS]

           ,[PPN]

           ,[TIPEBAYAR]

           ,[HARI]

           ,[TipeDisc]

           ,[DISC]

           ,[DISCRP]

           ,[ISCETAK]

           ,[NilaiCetak]

           ,[IsBatal]

           ,[UserBatal]

           ,[IsClose]

           ,[IsExp]

           ,[isAut]

           ,[KodeGDG]

           ,[cetakke]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[TglBatal]

           ,[Syarat]

           ,[TglBatas]

           ,[Devisi]

     from [36.64.152.3].[DBBCAGROUP].[dbo].DBPO where NoBukti=@Nobukti ) B on b.NoBukti=a.NoBukti where a.NoBukti=@Nobukti

      

      if not exists(select NoBukti from [dbPO] where NoBukti=@Nobukti) 

      INSERT INTO [dbPO]

      ([NOBUKTI]

           ,[NOURUT]

           ,[TANGGAL]

           ,[TglJatuhTempo]

           ,[KODESUPP]

           ,[HANDLING]

           ,[KODEEXP]

           ,[KETERANGAN]

           ,[FAKTURSUPP]

           ,[KODEVLS]

           ,[KURS]

           ,[PPN]

           ,[TIPEBAYAR]

           ,[HARI]

           ,[TipeDisc]

           ,[DISC]

           ,[DISCRP]

           ,[ISCETAK]

           ,[NilaiCetak]

           ,[IsBatal]

           ,[UserBatal]

           ,[IsClose]

           ,[IsExp]

           ,[isAut]

           ,[KodeGDG]

           ,[cetakke]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[TglBatal]

           ,[Syarat]

           ,[TglBatas]

           ,[Devisi])

     select [NOBUKTI]

           ,[NOURUT]

           ,[TANGGAL]

           ,[TglJatuhTempo]

           ,[KODESUPP]

           ,[HANDLING]

           ,[KODEEXP]

           ,[KETERANGAN]

           ,[FAKTURSUPP]

           ,[KODEVLS]

           ,[KURS]

           ,[PPN]

           ,[TIPEBAYAR]

           ,[HARI]

           ,[TipeDisc]

           ,[DISC]

           ,[DISCRP]

           ,[ISCETAK]

           ,[NilaiCetak]

           ,[IsBatal]

           ,[UserBatal]

           ,[IsClose]

           ,[IsExp]

           ,[isAut]

           ,[KodeGDG]

           ,[cetakke]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[TglBatal]

           ,[Syarat]

           ,[TglBatas]

           ,[Devisi] from [36.64.152.3].[DBBCAGROUP].[dbo].DBPO where NoBukti=@Nobukti

      

      update [36.64.152.3].[DBBCAGROUP].[dbo].dbPO set Tf=1 where NoBukti in (select NoBukti from [dbPO] where NoBukti=@Nobukti) 

    else

   if @Do='D'

   delete [dbPO] where NoBukti=@Nobukti

     delete [36.64.152.3].[DBBCAGROUP].[dbo].TempDelData where nobukti=@Nobukti and tabel='dbPO'


 Fetch Next from MySikron into @Nobukti, @Do

 

     Close MySikron

     Deallocate MySikron

     

--dbpodet

Declare MySinkronDet Cursor for

   select nobukti,urut,Do from [36.64.152.3].[DBBCAGROUP].[dbo].dbpodet where COALESCE(tf,0)=0 and nobukti in (select nobukti from [36.64.152.3].[DBBCAGROUP].[dbo].dbpo where devisi in ('03','04') and IsOtorisasi1=1) 

      and ((Do<>'I' and 1=1) or (Do='I' and nobukti+Cast(urut as varchar(4)) not in (select nobukti+Cast(urut as varchar(4)) from [dbpodet]))) 

   union all

   select Nobukti,urut,'D' from [36.64.152.3].[DBBCAGROUP].[dbo].TempDelDataDet where tabel='dbpodet'

 Open MySinkronDet

 Fetch Next from MySinkronDet into @Nobukti,@Urut,@Do

 While @@fetch_Status=0

 if (@Do='I' or COALESCE(@Do,'')='')

   INSERT INTO [dbpodet]

        ([NOBUKTI]

           ,[URUT]

           ,[KODEBRG]

           ,[PPN]

           ,[KURS]

           ,[DISC]

           ,[QNT]

           ,[QntBatal]

           ,[TglBatal]

           ,[NOSAT]

           ,[SATUAN]

           ,[ISI]

           ,[HARGA]

           ,[DISCP]

           ,[DISCTOT]

           ,[BYANGKUT]

           ,[NoPPL]

           ,[UrutPPL]

           ,[IsClose]

           ,[Tolerate]

           ,[Isbatal]

           ,[UserBatal]

           ,[KetBrg]

           ,[NamaBrg]

           ,[alasan]

           ,[NilaiPPN])

     select [NOBUKTI]

           ,[URUT]

           ,[KODEBRG]

           ,[PPN]

           ,[KURS]

           ,[DISC]

           ,[QNT]

           ,[QntBatal]

           ,[TglBatal]

           ,[NOSAT]

           ,[SATUAN]

           ,[ISI]

           ,[HARGA]

           ,[DISCP]

           ,[DISCTOT]

           ,[BYANGKUT]

           ,[NoPPL]

           ,[UrutPPL]

           ,[IsClose]

           ,[Tolerate]

           ,[Isbatal]

           ,[UserBatal]

           ,[KetBrg]

           ,[NamaBrg]

           ,[alasan]

           ,[NilaiPPN] from [36.64.152.3].[DBBCAGROUP].[dbo].DBPODET where NoBukti=@Nobukti and Urut=@Urut

     update [36.64.152.3].[DBBCAGROUP].[dbo].DBPODET set Tf=1 where NoBukti+CAST(Urut as varchar(3)) in 

         (select +CAST(Urut as varchar(3)) from [dbpodet] where NoBukti=@Nobukti and Urut=@Urut) 

    else

   if @Do='U'

   Update [dbpodet] set 

           [KODEBRG]=b.[KODEBRG]

           ,[PPN]=b.[PPN]

           ,[KURS]=b.[KURS]

           ,[DISC]=b.[DISC]

           ,[QNT]=b.[QNT]

           ,[QntBatal]=b.[QntBatal]

           ,[TglBatal]=b.[TglBatal]

           ,[NOSAT]=b.[NOSAT]

           ,[SATUAN]=b.[SATUAN]

           ,[ISI]=b.[ISI]

           ,[HARGA]=b.[HARGA]

           ,[DISCP]=b.[DISCP]

           ,[DISCTOT]=b.[DISCTOT]

           ,[BYANGKUT]=b.[BYANGKUT]

           ,[NoPPL]=b.[NoPPL]

           ,[UrutPPL]=b.[UrutPPL]

           ,[IsClose]=b.[IsClose]

           ,[Tolerate]=b.[Tolerate]

           ,[Isbatal]=b.[Isbatal]

           ,[UserBatal]=b.[UserBatal]

           ,[KetBrg]=b.[KetBrg]

           ,[NamaBrg]=b.[NamaBrg]

           ,[alasan]=b.[alasan]

           ,[NilaiPPN]=b.[NilaiPPN]

      from [dbpodet] a

      left outer join 

        (select [NOBUKTI]

           ,[URUT]

           ,[KODEBRG]

           ,[PPN]

           ,[KURS]

           ,[DISC]

           ,[QNT]

           ,[QntBatal]

           ,[TglBatal]

           ,[NOSAT]

           ,[SATUAN]

           ,[ISI]

           ,[HARGA]

           ,[DISCP]

           ,[DISCTOT]

           ,[BYANGKUT]

           ,[NoPPL]

           ,[UrutPPL]

           ,[IsClose]

           ,[Tolerate]

           ,[Isbatal]

           ,[UserBatal]

           ,[KetBrg]

           ,[NamaBrg]

           ,[alasan]

           ,[NilaiPPN]

     from [36.64.152.3].[DBBCAGROUP].[dbo].DBPODET where NoBukti=@Nobukti and Urut=@Urut ) B on b.NoBukti=a.NoBukti and b.Urut=a.Urut where a.NoBukti=@Nobukti and a.Urut=@Urut

      

      if not exists(select NoBukti from [dbpodet] where NoBukti=@Nobukti and Urut=@Urut) 

      INSERT INTO [dbpodet]

        ([NOBUKTI]

           ,[URUT]

           ,[KODEBRG]

           ,[PPN]

           ,[KURS]

           ,[DISC]

           ,[QNT]

           ,[QntBatal]

           ,[TglBatal]

           ,[NOSAT]

           ,[SATUAN]

           ,[ISI]

           ,[HARGA]

           ,[DISCP]

           ,[DISCTOT]

           ,[BYANGKUT]

           ,[NoPPL]

           ,[UrutPPL]

           ,[IsClose]

           ,[Tolerate]

           ,[Isbatal]

           ,[UserBatal]

           ,[KetBrg]

           ,[NamaBrg]

           ,[alasan]

           ,[NilaiPPN])

     select [NOBUKTI]

           ,[URUT]

           ,[KODEBRG]

           ,[PPN]

           ,[KURS]

           ,[DISC]

           ,[QNT]

           ,[QntBatal]

           ,[TglBatal]

           ,[NOSAT]

           ,[SATUAN]

           ,[ISI]

           ,[HARGA]

           ,[DISCP]

           ,[DISCTOT]

           ,[BYANGKUT]

           ,[NoPPL]

           ,[UrutPPL]

           ,[IsClose]

           ,[Tolerate]

           ,[Isbatal]

           ,[UserBatal]

           ,[KetBrg]

           ,[NamaBrg]

           ,[alasan]

           ,[NilaiPPN] from [36.64.152.3].[DBBCAGROUP].[dbo].DBPODET where NoBukti=@Nobukti and Urut=@Urut

      

     update [36.64.152.3].[DBBCAGROUP].[dbo].DBPODET set Tf=1 where NoBukti+CAST(Urut as varchar(3)) in 

         (select +CAST(Urut as varchar(3)) from [dbpodet] where NoBukti=@Nobukti and Urut=@Urut) 

    else

   if @Do='D'

   delete [dbpodet] where NoBukti=@Nobukti and Urut=@Urut

     delete [36.64.152.3].[DBBCAGROUP].[dbo].TempDelDataDet where nobukti=@Nobukti and urut=@Urut and tabel='dbpodet'


 Fetch Next from MySinkronDet into @Nobukti,@Urut,@Do

 

     Close MySinkronDet

     Deallocate MySinkronDet

     

--dbkirimdet

INSERT INTO [DBKirimDET]

           ([NoBukti]

           ,[KodeBrg]

           ,[NoSat]

           ,[Urut]

           ,[Tanggal]

           ,[Qnt])

 select [NoBukti]

           ,[KodeBrg]

           ,[NoSat]

           ,[Urut]

           ,[Tanggal]

           ,[Qnt]

           from  [36.64.152.3].[DBBCAGROUP].[dbo].[DBKirimDET]

           where NoBukti+CAST(urut as varchar(4)) not in (

           select NoBukti+CAST(urut as varchar(4)) from [DBKirimDET] )



--dbBeli

Declare MySikron Cursor for

   select nobukti,Do from [36.64.152.3].[DBBCAGROUP].[dbo].dbBeli where COALESCE(tf,0)=0 and devisi in ('03','04') --and isotorisasi1=1 

   and ((Do<>'I' and 1=1) or (Do='I' and nobukti not in (select nobukti from [dbbeli])))

   union all

   select Nobukti,'D' from [36.64.152.3].[DBBCAGROUP].[dbo].TempDelData where tabel='dbBeli'

 Open MySikron

 Fetch Next from MySikron into @Nobukti, @Do

 While @@fetch_Status=0

 if (@Do='I' or COALESCE(@Do,'')='')

   INSERT INTO [dbBeli]

        ([NOBUKTI]

           ,[NOURUT]

           ,[TANGGAL]

           ,[TglJatuhTempo]

           ,[KODESUPP]

           ,[NoPOHd]

           ,[KodeGdgHd]

           ,[HANDLING]

           ,[KETERANGAN]

           ,[FAKTURSUPP]

           ,[KODEVLS]

           ,[KURS]

           ,[PPN]

           ,[TIPEBAYAR]

           ,[HARI]

           ,[TipeDisc]

           ,[DISC]

           ,[DISCRP]

           ,[NILAIPOT]

           ,[NILAIDPP]

           ,[NILAIPPN]

           ,[NILAINET]

           ,[ISCETAK]

           ,[NilaiCetak]

           ,[IsBatal]

           ,[UserBatal]

           ,[KodeExp]

           ,[cetakke]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[TglBatal]

           ,[Devisi])

     select [NOBUKTI]

           ,[NOURUT]

           ,[TANGGAL]

           ,[TglJatuhTempo]

           ,[KODESUPP]

           ,[NoPOHd]

           ,[KodeGdgHd]

           ,[HANDLING]

           ,[KETERANGAN]

           ,[FAKTURSUPP]

           ,[KODEVLS]

           ,[KURS]

           ,[PPN]

           ,[TIPEBAYAR]

           ,[HARI]

           ,[TipeDisc]

           ,[DISC]

           ,[DISCRP]

           ,[NILAIPOT]

           ,[NILAIDPP]

           ,[NILAIPPN]

           ,[NILAINET]

           ,[ISCETAK]

           ,[NilaiCetak]

           ,[IsBatal]

           ,[UserBatal]

           ,[KodeExp]

           ,[cetakke]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[TglBatal]

           ,[Devisi] from [36.64.152.3].[DBBCAGROUP].[dbo].dbBeli where NoBukti=@Nobukti

     update [36.64.152.3].[DBBCAGROUP].[dbo].dbBeli set Tf=1 where NoBukti in (select NoBukti from [dbBeli] where NoBukti=@Nobukti) 

    else

   if @Do='U'

   Update [dbBeli] set 

           [TANGGAL]=b.[TANGGAL]

           ,[TglJatuhTempo]=b.[TglJatuhTempo]

           ,[KODESUPP]=b.[KODESUPP]

           ,[NoPOHd]=b.[NoPOHd]

           ,[KodeGdgHd]=b.[KodeGdgHd]

           ,[HANDLING]=b.[HANDLING]

           ,[KETERANGAN]=b.[KETERANGAN]

           ,[FAKTURSUPP]=b.[FAKTURSUPP]

           ,[KODEVLS]=b.[KODEVLS]

           ,[KURS]=b.[KURS]

           ,[PPN]=b.[PPN]

           ,[TIPEBAYAR]=b.[TIPEBAYAR]

           ,[HARI]=b.[HARI]

           ,[TipeDisc]=b.[TipeDisc]

           ,[DISC]=b.[DISC]

           ,[DISCRP]=b.[DISCRP]

           ,[NILAIPOT]=b.[NILAIPOT]

           ,[NILAIDPP]=b.[NILAIDPP]

           ,[NILAIPPN]=b.[NILAIPPN]

           ,[NILAINET]=b.[NILAINET]

           ,[ISCETAK]=b.[ISCETAK]

           ,[NilaiCetak]=b.[NilaiCetak]

           ,[IsBatal]=b.[IsBatal]

           ,[UserBatal]=b.[UserBatal]

           ,[KodeExp]=b.[KodeExp]

           ,[cetakke]=b.[cetakke]

           ,[IsOtorisasi1]=b.[IsOtorisasi1]

           ,[OtoUser1]=b.[OtoUser1]

           ,[TglOto1]=b.[TglOto1]

           ,[IsOtorisasi2]=b.[IsOtorisasi2]

           ,[OtoUser2]=b.[OtoUser2]

           ,[TglOto2]=b.[TglOto2]

           ,[IsOtorisasi3]=b.[IsOtorisasi3]

           ,[OtoUser3]=b.[OtoUser3]

           ,[TglOto3]=b.[TglOto3]

           ,[IsOtorisasi4]=b.[IsOtorisasi4]

           ,[OtoUser4]=b.[OtoUser4]

           ,[TglOto4]=b.[TglOto4]

           ,[IsOtorisasi5]=b.[IsOtorisasi5]

           ,[OtoUser5]=b.[OtoUser5]

           ,[TglOto5]=b.[TglOto5]

           ,[NoJurnal]=b.[NoJurnal]

           ,[NoUrutJurnal]=b.[NoUrutJurnal]

           ,[TglJurnal]=b.[TglJurnal]

           ,[MaxOL]=b.[MaxOL]

           ,[TglBatal]=b.[TglBatal]

           ,[Devisi]=b.[Devisi]

      from [dbBeli] a

      left outer join 

        (select [NOBUKTI]

           ,[NOURUT]

           ,[TANGGAL]

           ,[TglJatuhTempo]

           ,[KODESUPP]

           ,[NoPOHd]

           ,[KodeGdgHd]

           ,[HANDLING]

           ,[KETERANGAN]

           ,[FAKTURSUPP]

           ,[KODEVLS]

           ,[KURS]

           ,[PPN]

           ,[TIPEBAYAR]

           ,[HARI]

           ,[TipeDisc]

           ,[DISC]

           ,[DISCRP]

           ,[NILAIPOT]

           ,[NILAIDPP]

           ,[NILAIPPN]

           ,[NILAINET]

           ,[ISCETAK]

           ,[NilaiCetak]

           ,[IsBatal]

           ,[UserBatal]

           ,[KodeExp]

           ,[cetakke]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[TglBatal]

           ,[Devisi]

     from [36.64.152.3].[DBBCAGROUP].[dbo].dbBeli where NoBukti=@Nobukti ) B on b.NoBukti=a.NoBukti where a.NoBukti=@Nobukti

      

      if not exists(select NoBukti from [dbBeli] where NoBukti=@Nobukti) 

      INSERT INTO [dbBeli]

        ([NOBUKTI]

           ,[NOURUT]

           ,[TANGGAL]

           ,[TglJatuhTempo]

           ,[KODESUPP]

           ,[NoPOHd]

           ,[KodeGdgHd]

           ,[HANDLING]

           ,[KETERANGAN]

           ,[FAKTURSUPP]

           ,[KODEVLS]

           ,[KURS]

           ,[PPN]

           ,[TIPEBAYAR]

           ,[HARI]

           ,[TipeDisc]

           ,[DISC]

           ,[DISCRP]

           ,[NILAIPOT]

           ,[NILAIDPP]

           ,[NILAIPPN]

           ,[NILAINET]

           ,[ISCETAK]

           ,[NilaiCetak]

           ,[IsBatal]

           ,[UserBatal]

           ,[KodeExp]

           ,[cetakke]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[TglBatal]

           ,[Devisi])

     select [NOBUKTI]

           ,[NOURUT]

           ,[TANGGAL]

           ,[TglJatuhTempo]

           ,[KODESUPP]

           ,[NoPOHd]

           ,[KodeGdgHd]

           ,[HANDLING]

           ,[KETERANGAN]

           ,[FAKTURSUPP]

           ,[KODEVLS]

           ,[KURS]

           ,[PPN]

           ,[TIPEBAYAR]

           ,[HARI]

           ,[TipeDisc]

           ,[DISC]

           ,[DISCRP]

           ,[NILAIPOT]

           ,[NILAIDPP]

           ,[NILAIPPN]

           ,[NILAINET]

           ,[ISCETAK]

           ,[NilaiCetak]

           ,[IsBatal]

           ,[UserBatal]

           ,[KodeExp]

           ,[cetakke]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[TglBatal]

           ,[Devisi] from [36.64.152.3].[DBBCAGROUP].[dbo].dbBeli where NoBukti=@Nobukti

      

      update [36.64.152.3].[DBBCAGROUP].[dbo].dbBeli set Tf=1 where NoBukti in (select NoBukti from [dbBeli] where NoBukti=@Nobukti) 

    else

   if @Do='D'

   delete [dbBeli] where NoBukti=@Nobukti

     delete [36.64.152.3].[DBBCAGROUP].[dbo].TempDelData where nobukti=@Nobukti and tabel='dbBeli'


 Fetch Next from MySikron into @Nobukti, @Do

 

     Close MySikron

     Deallocate MySikron

     

--dbbelidet

Declare MySinkronDet Cursor for

   select nobukti,urut,Do from [36.64.152.3].[DBBCAGROUP].[dbo].dbbelidet where COALESCE(tf,0)=0 and nobukti in (select nobukti from [36.64.152.3].[DBBCAGROUP].[dbo].dbbeli where devisi in ('03','04') --and isotorisasi1=1 

   ) 

   and ((Do<>'I' and 1=1) or (Do='I' and nobukti+Cast(urut as varchar(4)) not in (select nobukti+Cast(urut as varchar(4)) from [dbbelidet])))

   union all

   select Nobukti,urut,'D' from [36.64.152.3].[DBBCAGROUP].[dbo].TempDelDataDet where tabel='dbbelidet'

 Open MySinkronDet

 Fetch Next from MySinkronDet into @Nobukti,@Urut,@Do

 While @@fetch_Status=0

 if (@Do='I' or COALESCE(@Do,'')='')

   INSERT INTO [dbbelidet]

        ([NOBUKTI]

           ,[URUT]

           ,[KODEBRG]

           ,[KodeGdg]

           ,[PPN]

           ,[KURS]

           ,[DISC]

           ,[QNT]

           ,[NOSAT]

           ,[SATUAN]

           ,[ISI]

           ,[HARGA]

           ,[DISCP]

           ,[DISCTOT]

           ,[BYANGKUT]

           ,[NoPO]

           ,[UrutPO]

           ,[HPP]

           ,[QntTerima]

           ,[Qnt1Terima]

           ,[Qnt2Terima]

           ,[QntReject]

           ,[Qnt1Reject]

           ,[Qnt2Reject]

           ,[UrutBeli]

           ,[KetReject]

           ,[QntTerima_]

           ,[Qnt1Terima_]

           ,[Qnt2Terima_]

           ,[NamaBrg]

           ,[Perkiraan]

           ,[NilaiPPN])

     select [NOBUKTI]

           ,[URUT]

           ,[KODEBRG]

           ,[KodeGdg]

           ,[PPN]

           ,[KURS]

           ,[DISC]

           ,[QNT]

           ,[NOSAT]

           ,[SATUAN]

           ,[ISI]

           ,[HARGA]

           ,[DISCP]

           ,[DISCTOT]

           ,[BYANGKUT]

           ,[NoPO]

           ,[UrutPO]

           ,[HPP]

           ,[QntTerima]

           ,[Qnt1Terima]

           ,[Qnt2Terima]

           ,[QntReject]

           ,[Qnt1Reject]

           ,[Qnt2Reject]

           ,[UrutBeli]

           ,[KetReject]

           ,[QntTerima_]

           ,[Qnt1Terima_]

           ,[Qnt2Terima_]

           ,[NamaBrg]

           ,[Perkiraan]

           ,[NilaiPPN] from [36.64.152.3].[DBBCAGROUP].[dbo].dbbelidet where NoBukti=@Nobukti and Urut=@Urut

     update [36.64.152.3].[DBBCAGROUP].[dbo].dbbelidet set Tf=1 where NoBukti+CAST(Urut as varchar(3)) in 

         (select +CAST(Urut as varchar(3)) from [dbbelidet] where NoBukti=@Nobukti and Urut=@Urut) 

    else

   if @Do='U'

   Update [dbbelidet] set 

            [KODEBRG]=b.[KODEBRG]

           ,[KodeGdg]=b.[KodeGdg]

           ,[PPN]=b.[PPN]

           ,[KURS]=b.[KURS]

           ,[DISC]=b.[DISC]

           ,[QNT]=b.[QNT]

           ,[NOSAT]=b.[NOSAT]

           ,[SATUAN]=b.[SATUAN]

           ,[ISI]=b.[ISI]

           ,[HARGA]=b.[HARGA]

           ,[DISCP]=b.[DISCP]

           ,[DISCTOT]=b.[DISCTOT]

           ,[BYANGKUT]=b.[BYANGKUT]

           ,[NoPO]=b.[NoPO]

           ,[UrutPO]=b.[UrutPO]

           ,[HPP]=b.[HPP]

           ,[QntTerima]=b.[QntTerima]

           ,[Qnt1Terima]=b.[Qnt1Terima]

           ,[Qnt2Terima]=b.[Qnt2Terima]

           ,[QntReject]=b.[QntReject]

           ,[Qnt1Reject]=b.[Qnt1Reject]

           ,[Qnt2Reject]=b.[Qnt2Reject]

           ,[UrutBeli]=b.[UrutBeli]

           ,[KetReject]=b.[KetReject]

           ,[QntTerima_]=b.[QntTerima_]

           ,[Qnt1Terima_]=b.[Qnt1Terima_]

           ,[Qnt2Terima_]=b.[Qnt2Terima_]

           ,[NamaBrg]=b.[NamaBrg]

           ,[Perkiraan]=b.[Perkiraan]

           ,[NilaiPPN]=b.[NilaiPPN]

      from [dbbelidet] a

      left outer join 

        (select [NOBUKTI]

           ,[URUT]

           ,[KODEBRG]

           ,[KodeGdg]

           ,[PPN]

           ,[KURS]

           ,[DISC]

           ,[QNT]

           ,[NOSAT]

           ,[SATUAN]

           ,[ISI]

           ,[HARGA]

           ,[DISCP]

           ,[DISCTOT]

           ,[BYANGKUT]

           ,[NoPO]

           ,[UrutPO]

           ,[HPP]

           ,[QntTerima]

           ,[Qnt1Terima]

           ,[Qnt2Terima]

           ,[QntReject]

           ,[Qnt1Reject]

           ,[Qnt2Reject]

           ,[UrutBeli]

           ,[KetReject]

           ,[QntTerima_]

           ,[Qnt1Terima_]

           ,[Qnt2Terima_]

           ,[NamaBrg]

           ,[Perkiraan]

           ,[NilaiPPN]

     from [36.64.152.3].[DBBCAGROUP].[dbo].dbbelidet where NoBukti=@Nobukti and Urut=@Urut ) B on b.NoBukti=a.NoBukti and b.Urut=a.Urut where a.NoBukti=@Nobukti and a.Urut=@Urut

      

      if not exists(select NoBukti from [dbbelidet] where NoBukti=@Nobukti and Urut=@Urut) 

      INSERT INTO [dbbelidet]

        ([NOBUKTI]

           ,[URUT]

           ,[KODEBRG]

           ,[KodeGdg]

           ,[PPN]

           ,[KURS]

           ,[DISC]

           ,[QNT]

           ,[NOSAT]

           ,[SATUAN]

           ,[ISI]

           ,[HARGA]

           ,[DISCP]

           ,[DISCTOT]

           ,[BYANGKUT]

           ,[NoPO]

           ,[UrutPO]

           ,[HPP]

           ,[QntTerima]

           ,[Qnt1Terima]

           ,[Qnt2Terima]

           ,[QntReject]

           ,[Qnt1Reject]

           ,[Qnt2Reject]

           ,[UrutBeli]

           ,[KetReject]

           ,[QntTerima_]

           ,[Qnt1Terima_]

           ,[Qnt2Terima_]

           ,[NamaBrg]

           ,[Perkiraan]

           ,[NilaiPPN])

     select [NOBUKTI]

           ,[URUT]

           ,[KODEBRG]

           ,[KodeGdg]

           ,[PPN]

           ,[KURS]

           ,[DISC]

           ,[QNT]

           ,[NOSAT]

           ,[SATUAN]

           ,[ISI]

           ,[HARGA]

           ,[DISCP]

           ,[DISCTOT]

           ,[BYANGKUT]

           ,[NoPO]

           ,[UrutPO]

           ,[HPP]

           ,[QntTerima]

           ,[Qnt1Terima]

           ,[Qnt2Terima]

           ,[QntReject]

           ,[Qnt1Reject]

           ,[Qnt2Reject]

           ,[UrutBeli]

           ,[KetReject]

           ,[QntTerima_]

           ,[Qnt1Terima_]

           ,[Qnt2Terima_]

           ,[NamaBrg]

           ,[Perkiraan]

           ,[NilaiPPN] from [36.64.152.3].[DBBCAGROUP].[dbo].dbbelidet where NoBukti=@Nobukti and Urut=@Urut

      

     update [36.64.152.3].[DBBCAGROUP].[dbo].dbbelidet set Tf=1 where NoBukti+CAST(Urut as varchar(3)) in 

         (select +CAST(Urut as varchar(3)) from [dbbelidet] where NoBukti=@Nobukti and Urut=@Urut) 

    else

   if @Do='D'

   delete [dbbelidet] where NoBukti=@Nobukti and Urut=@Urut

     delete [36.64.152.3].[DBBCAGROUP].[dbo].TempDelDataDet where nobukti=@Nobukti and urut=@Urut and tabel='dbbelidet'


 Fetch Next from MySinkronDet into @Nobukti,@Urut,@Do

 

     Close MySinkronDet

     Deallocate MySinkronDet



--dbRBeli

Declare MySikron Cursor for

   select nobukti,Do from [36.64.152.3].[DBBCAGROUP].[dbo].dbRBeli where COALESCE(tf,0)=0 and devisi in ('03','04') and IsOtorisasi1=1 

   and ((Do<>'I' and 1=1) or (Do='I' and nobukti not in (select nobukti from [dbrbeli])))

   union all

   select Nobukti,'D' from [36.64.152.3].[DBBCAGROUP].[dbo].TempDelData where tabel='dbRBeli'

 Open MySikron

 Fetch Next from MySikron into @Nobukti, @Do

 While @@fetch_Status=0

 if (@Do='I' or COALESCE(@Do,'')='')

   INSERT INTO [dbRBeli]

        ([NOBUKTI]

           ,[NOURUT]

           ,[TANGGAL]

           ,[TGLJATUHTEMPO]

           ,[KODESUPP]

           ,[NOBELI]

           ,[KodeGdg]

           ,[KODEEXP]

           ,[HANDLING]

           ,[KETERANGAN]

           ,[FAKTURSUPP]

           ,[KODEVLS]

           ,[KURS]

           ,[PPN]

           ,[TIPEBAYAR]

           ,[HARI]

           ,[TipeDisc]

           ,[DISC]

           ,[DISCRP]

           ,[NILAIPOT]

           ,[NILAIDPP]

           ,[NILAIPPN]

           ,[NILAINET]

           ,[ISCETAK]

           ,[NilaiCetak]

           ,[Nopajak]

           ,[TglFPJ]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[IsBatal]

           ,[UserBatal]

           ,[TglBatal]

           ,[Devisi])

     select [NOBUKTI]

           ,[NOURUT]

           ,[TANGGAL]

           ,[TGLJATUHTEMPO]

           ,[KODESUPP]

           ,[NOBELI]

           ,[KodeGdg]

           ,[KODEEXP]

           ,[HANDLING]

           ,[KETERANGAN]

           ,[FAKTURSUPP]

           ,[KODEVLS]

           ,[KURS]

           ,[PPN]

           ,[TIPEBAYAR]

           ,[HARI]

           ,[TipeDisc]

           ,[DISC]

           ,[DISCRP]

           ,[NILAIPOT]

           ,[NILAIDPP]

           ,[NILAIPPN]

           ,[NILAINET]

           ,[ISCETAK]

           ,[NilaiCetak]

           ,[Nopajak]

           ,[TglFPJ]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[IsBatal]

           ,[UserBatal]

           ,[TglBatal]

           ,[Devisi] from [36.64.152.3].[DBBCAGROUP].[dbo].dbRBeli where NoBukti=@Nobukti

     update [36.64.152.3].[DBBCAGROUP].[dbo].dbRBeli set Tf=1 where NoBukti in (select NoBukti from [dbRBeli] where NoBukti=@Nobukti) 

    else

   if @Do='U'

   Update [dbRBeli] set 

            [TANGGAL]=b.[TANGGAL]

           ,[TGLJATUHTEMPO]=b.[TGLJATUHTEMPO]

           ,[KODESUPP]=b.[KODESUPP]

           ,[NOBELI]=b.[NOBELI]

           ,[KodeGdg]=b.[KodeGdg]

           ,[KODEEXP]=b.[KODEEXP]

           ,[HANDLING]=b.[HANDLING]

           ,[KETERANGAN]=b.[KETERANGAN]

           ,[FAKTURSUPP]=b.[FAKTURSUPP]

           ,[KODEVLS]=b.[KODEVLS]

           ,[KURS]=b.[KURS]

           ,[PPN]=b.[PPN]

           ,[TIPEBAYAR]=b.[TIPEBAYAR]

           ,[HARI]=b.[HARI]

           ,[TipeDisc]=b.[TipeDisc]

           ,[DISC]=b.[DISC]

           ,[DISCRP]=b.[DISCRP]

           ,[NILAIPOT]=b.[NILAIPOT]

           ,[NILAIDPP]=b.[NILAIDPP]

           ,[NILAIPPN]=b.[NILAIPPN]

           ,[NILAINET]=b.[NILAINET]

           ,[ISCETAK]=b.[ISCETAK]

           ,[NilaiCetak]=b.[NilaiCetak]

           ,[Nopajak]=b.[Nopajak]

           ,[TglFPJ]=b.[TglFPJ]

           ,[IsOtorisasi1]=b.[IsOtorisasi1]

           ,[OtoUser1]=b.[OtoUser1]

           ,[TglOto1]=b.[TglOto1]

           ,[IsOtorisasi2]=b.[IsOtorisasi2]

           ,[OtoUser2]=b.[OtoUser2]

           ,[TglOto2]=b.[TglOto2]

           ,[IsOtorisasi3]=b.[IsOtorisasi3]

           ,[OtoUser3]=b.[OtoUser3]

           ,[TglOto3]=b.[TglOto3]

           ,[IsOtorisasi4]=b.[IsOtorisasi4]

           ,[OtoUser4]=b.[OtoUser4]

           ,[TglOto4]=b.[TglOto4]

           ,[IsOtorisasi5]=b.[IsOtorisasi5]

           ,[OtoUser5]=b.[OtoUser5]

           ,[TglOto5]=b.[TglOto5]

           ,[NoJurnal]=b.[NoJurnal]

           ,[NoUrutJurnal]=b.[NoUrutJurnal]

           ,[TglJurnal]=b.[TglJurnal]

           ,[MaxOL]=b.[MaxOL]

           ,[IsBatal]=b.[IsBatal]

           ,[UserBatal]=b.[UserBatal]

           ,[TglBatal]=b.[TglBatal]

           ,[Devisi]=b.[Devisi]

      from [dbRBeli] a

      left outer join 

        (select [NOBUKTI]

           ,[NOURUT]

           ,[TANGGAL]

           ,[TGLJATUHTEMPO]

           ,[KODESUPP]

           ,[NOBELI]

           ,[KodeGdg]

           ,[KODEEXP]

           ,[HANDLING]

           ,[KETERANGAN]

           ,[FAKTURSUPP]

           ,[KODEVLS]

           ,[KURS]

           ,[PPN]

           ,[TIPEBAYAR]

           ,[HARI]

           ,[TipeDisc]

           ,[DISC]

           ,[DISCRP]

           ,[NILAIPOT]

           ,[NILAIDPP]

           ,[NILAIPPN]

           ,[NILAINET]

           ,[ISCETAK]

           ,[NilaiCetak]

           ,[Nopajak]

           ,[TglFPJ]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[IsBatal]

           ,[UserBatal]

           ,[TglBatal]

           ,[Devisi]

     from [36.64.152.3].[DBBCAGROUP].[dbo].dbRBeli where NoBukti=@Nobukti ) B on b.NoBukti=a.NoBukti where a.NoBukti=@Nobukti

      

      if not exists(select NoBukti from [dbRBeli] where NoBukti=@Nobukti) 

      INSERT INTO [dbRBeli]

        ([NOBUKTI]

           ,[NOURUT]

           ,[TANGGAL]

           ,[TGLJATUHTEMPO]

           ,[KODESUPP]

           ,[NOBELI]

           ,[KodeGdg]

           ,[KODEEXP]

           ,[HANDLING]

           ,[KETERANGAN]

           ,[FAKTURSUPP]

           ,[KODEVLS]

           ,[KURS]

           ,[PPN]

           ,[TIPEBAYAR]

           ,[HARI]

           ,[TipeDisc]

           ,[DISC]

           ,[DISCRP]

           ,[NILAIPOT]

           ,[NILAIDPP]

           ,[NILAIPPN]

           ,[NILAINET]

           ,[ISCETAK]

           ,[NilaiCetak]

           ,[Nopajak]

           ,[TglFPJ]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[IsBatal]

           ,[UserBatal]

           ,[TglBatal]

           ,[Devisi])

     select [NOBUKTI]

           ,[NOURUT]

           ,[TANGGAL]

           ,[TGLJATUHTEMPO]

           ,[KODESUPP]

           ,[NOBELI]

           ,[KodeGdg]

           ,[KODEEXP]

           ,[HANDLING]

           ,[KETERANGAN]

           ,[FAKTURSUPP]

           ,[KODEVLS]

           ,[KURS]

           ,[PPN]

           ,[TIPEBAYAR]

           ,[HARI]

           ,[TipeDisc]

           ,[DISC]

           ,[DISCRP]

           ,[NILAIPOT]

           ,[NILAIDPP]

           ,[NILAIPPN]

           ,[NILAINET]

           ,[ISCETAK]

           ,[NilaiCetak]

           ,[Nopajak]

           ,[TglFPJ]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[IsBatal]

           ,[UserBatal]

           ,[TglBatal]

           ,[Devisi] from [36.64.152.3].[DBBCAGROUP].[dbo].dbRBeli where NoBukti=@Nobukti

      

     update [36.64.152.3].[DBBCAGROUP].[dbo].dbRBeli set Tf=1 where NoBukti in (select NoBukti from [dbRBeli] where NoBukti=@Nobukti) 

    else

   if @Do='D'

   delete [dbRBeli] where NoBukti=@Nobukti

     delete [36.64.152.3].[DBBCAGROUP].[dbo].TempDelData where nobukti=@Nobukti and tabel='dbRBeli'


 Fetch Next from MySikron into @Nobukti, @Do

 

     Close MySikron

     Deallocate MySikron

     

--dbRbelidet

Declare MySinkronDet Cursor for

   select nobukti,urut,Do from [36.64.152.3].[DBBCAGROUP].[dbo].dbRbelidet where COALESCE(tf,0)=0 and nobukti in (select nobukti from dbRbeli where devisi in ('03','04') and IsOtorisasi1=1) 

   and ((Do<>'I' and 1=1) or (Do='I' and nobukti+Cast(urut as varchar(4)) not in (select nobukti+Cast(urut as varchar(4)) from [dbrbelidet])))

   union all

   select Nobukti,urut,'D' from [36.64.152.3].[DBBCAGROUP].[dbo].TempDelDataDet where tabel='dbRbelidet'

 Open MySinkronDet

 Fetch Next from MySinkronDet into @Nobukti,@Urut,@Do

 While @@fetch_Status=0

 if (@Do='I' or COALESCE(@Do,'')='')

   INSERT INTO [dbRbelidet]

        ([NOBUKTI]

           ,[URUT]

           ,[KODEBRG]

           ,[PPN]

           ,[KURS]

           ,[DISC]

           ,[QNT]

           ,[NOSAT]

           ,[SATUAN]

           ,[ISI]

           ,[HARGA]

           ,[DISCP]

           ,[DISCTOT]

           ,[BYANGKUT]

           ,[NOPBL]

           ,[URUTPBL]

           ,[Qnt2]

           ,[Qnt1]

           ,[HPP]

           ,[NamaBrg]

           ,[NilaiPPN])

     select [NOBUKTI]

           ,[URUT]

           ,[KODEBRG]

           ,[PPN]

           ,[KURS]

           ,[DISC]

           ,[QNT]

           ,[NOSAT]

           ,[SATUAN]

           ,[ISI]

           ,[HARGA]

           ,[DISCP]

           ,[DISCTOT]

           ,[BYANGKUT]

           ,[NOPBL]

           ,[URUTPBL]

           ,[Qnt2]

           ,[Qnt1]

           ,[HPP]

           ,[NamaBrg]

           ,[NilaiPPN] from [36.64.152.3].[DBBCAGROUP].[dbo].dbRbelidet where NoBukti=@Nobukti and Urut=@Urut

     update [36.64.152.3].[DBBCAGROUP].[dbo].dbRbelidet set Tf=1 where NoBukti+CAST(Urut as varchar(3)) in 

         (select +CAST(Urut as varchar(3)) from [dbRbelidet] where NoBukti=@Nobukti and Urut=@Urut) 

    else

   if @Do='U'

   Update [dbRbelidet] set 

           [KODEBRG]=b.[KODEBRG]

           ,[PPN]=b.[PPN]

           ,[KURS]=b.[KURS]

           ,[DISC]=b.[DISC]

           ,[QNT]=b.[QNT]

           ,[NOSAT]=b.[NOSAT]

           ,[SATUAN]=b.[SATUAN]

           ,[ISI]=b.[ISI]

           ,[HARGA]=b.[HARGA]

           ,[DISCP]=b.[DISCP]

           ,[DISCTOT]=b.[DISCTOT]

           ,[BYANGKUT]=b.[BYANGKUT]

           ,[NOPBL]=b.[NOPBL]

           ,[URUTPBL]=b.[URUTPBL]

           ,[Qnt2]=b.[Qnt2]

           ,[Qnt1]=b.[Qnt1]

           ,[HPP]=b.[HPP]

           ,[NamaBrg]=b.[NamaBrg]

           ,[NilaiPPN]=b.[NilaiPPN]

      from [dbRbelidet] a

      left outer join 

        (select [NOBUKTI]

           ,[URUT]

           ,[KODEBRG]

           ,[PPN]

           ,[KURS]

           ,[DISC]

           ,[QNT]

           ,[NOSAT]

           ,[SATUAN]

           ,[ISI]

           ,[HARGA]

           ,[DISCP]

           ,[DISCTOT]

           ,[BYANGKUT]

           ,[NOPBL]

           ,[URUTPBL]

           ,[Qnt2]

           ,[Qnt1]

           ,[HPP]

           ,[NamaBrg]

           ,[NilaiPPN]

     from [36.64.152.3].[DBBCAGROUP].[dbo].dbRbelidet where NoBukti=@Nobukti and Urut=@Urut ) B on b.NoBukti=a.NoBukti and b.Urut=a.Urut where a.NoBukti=@Nobukti and a.Urut=@Urut

      

      if not exists(select NoBukti from [dbRbelidet] where NoBukti=@Nobukti and Urut=@Urut) 

      INSERT INTO [dbRbelidet]

        ([NOBUKTI]

           ,[URUT]

           ,[KODEBRG]

           ,[PPN]

           ,[KURS]

           ,[DISC]

           ,[QNT]

           ,[NOSAT]

           ,[SATUAN]

           ,[ISI]

           ,[HARGA]

           ,[DISCP]

           ,[DISCTOT]

           ,[BYANGKUT]

           ,[NOPBL]

           ,[URUTPBL]

           ,[Qnt2]

           ,[Qnt1]

           ,[HPP]

           ,[NamaBrg]

           ,[NilaiPPN])

     select [NOBUKTI]

           ,[URUT]

           ,[KODEBRG]

           ,[PPN]

           ,[KURS]

           ,[DISC]

           ,[QNT]

           ,[NOSAT]

           ,[SATUAN]

           ,[ISI]

           ,[HARGA]

           ,[DISCP]

           ,[DISCTOT]

           ,[BYANGKUT]

           ,[NOPBL]

           ,[URUTPBL]

           ,[Qnt2]

           ,[Qnt1]

           ,[HPP]

           ,[NamaBrg]

           ,[NilaiPPN] from [36.64.152.3].[DBBCAGROUP].[dbo].dbRbelidet where NoBukti=@Nobukti and Urut=@Urut

      

     update [36.64.152.3].[DBBCAGROUP].[dbo].dbRbelidet set Tf=1 where NoBukti+CAST(Urut as varchar(3)) in 

         (select +CAST(Urut as varchar(3)) from [dbRbelidet] where NoBukti=@Nobukti and Urut=@Urut) 

    else

   if @Do='D'

   delete [dbRbelidet] where NoBukti=@Nobukti and Urut=@Urut

     delete [36.64.152.3].[DBBCAGROUP].[dbo].TempDelDataDet where nobukti=@Nobukti and urut=@Urut and tabel='dbRbelidet'


 Fetch Next from MySinkronDet into @Nobukti,@Urut,@Do

 

     Close MySinkronDet

     Deallocate MySinkronDet

     

--dbPenyerahanBhn 

Declare MySikron Cursor for

   select nobukti,Do from [36.64.152.3].[DBBCAGROUP].[dbo].dbPenyerahanBhn  where COALESCE(tf,0)=0 and devisi in ('03','04') 

   and ((Do<>'I' and 1=1) or (Do='I' and nobukti not in (select nobukti from [dbPenyerahanBhn])))

   union all

   select Nobukti,'D' from [36.64.152.3].[DBBCAGROUP].[dbo].TempDelData where tabel='dbPenyerahanBhn'

 Open MySikron

 Fetch Next from MySikron into @Nobukti, @Do

 While @@fetch_Status=0

 if (@Do='I' or COALESCE(@Do,'')='')

   INSERT INTO [dbPenyerahanBhn]

        ([Nobukti]

           ,[Nourut]

           ,[Tanggal]

           ,[Kodegdg]

           ,[NoBPPB]

           ,[cetakke]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[IsSampel]

           ,[KdDep]

           ,[NoPOL]

           ,[Supir]

           ,[Devisi]

           ,[ID]

           ,[TGLJAM])

     select [Nobukti]

           ,[Nourut]

           ,[Tanggal]

           ,[Kodegdg]

           ,[NoBPPB]

           ,[cetakke]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[IsSampel]

           ,[KdDep]

           ,[NoPOL]

           ,[Supir]

           ,[Devisi]

           ,[ID]

           ,[TGLJAM] from [36.64.152.3].[DBBCAGROUP].[dbo].dbPenyerahanBhn where NoBukti=@Nobukti

     update [36.64.152.3].[DBBCAGROUP].[dbo].dbPenyerahanBhn set Tf=1 where NoBukti in (select NoBukti from [dbPenyerahanBhn] where NoBukti=@Nobukti) 

    else

   if @Do='U'

   Update [dbPenyerahanBhn] set 

           [Tanggal]=b.[Tanggal]

           ,[Kodegdg]=b.[Kodegdg]

           ,[NoBPPB]=b.[NoBPPB]

           ,[cetakke]=b.[cetakke]

           ,[IsOtorisasi1]=b.[IsOtorisasi1]

           ,[OtoUser1]=b.[OtoUser1]

           ,[TglOto1]=b.[TglOto1]

           ,[IsOtorisasi2]=b.[IsOtorisasi2]

           ,[OtoUser2]=b.[OtoUser2]

           ,[TglOto2]=b.[TglOto2]

           ,[IsOtorisasi3]=b.[IsOtorisasi3]

           ,[OtoUser3]=B.[OtoUser3]

           ,[TglOto3]=B.[TglOto3]

           ,[IsOtorisasi4]=b.[IsOtorisasi4]

           ,[OtoUser4]=b.[OtoUser4]

           ,[TglOto4]=b.[TglOto4]

           ,[IsOtorisasi5]=b.[IsOtorisasi5]

           ,[OtoUser5]=b.[OtoUser5]

           ,[TglOto5]=b.[TglOto5]

           ,[NoJurnal]=b.[NoJurnal]

           ,[NoUrutJurnal]=b.[NoUrutJurnal]

           ,[TglJurnal]=b.[TglJurnal]

           ,[MaxOL]=b.[MaxOL]

           ,[IsSampel]=b.[IsSampel]

           ,[KdDep]=b.[KdDep]

           ,[NoPOL]=b.[NoPOL]

           ,[Supir]=b.[Supir]

           ,[Devisi]=b.[Devisi]

           ,[ID]=b.[ID]

           ,[TGLJAM]=b.[TGLJAM]

      from [dbPenyerahanBhn] a

      left outer join 

        (select [Nobukti]

           ,[Nourut]

           ,[Tanggal]

           ,[Kodegdg]

           ,[NoBPPB]

           ,[cetakke]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[IsSampel]

           ,[KdDep]

           ,[NoPOL]

           ,[Supir]

           ,[Devisi]

           ,[ID]

           ,[TGLJAM]

     from [36.64.152.3].[DBBCAGROUP].[dbo].dbPenyerahanBhn where NoBukti=@Nobukti ) B on b.NoBukti=a.NoBukti where a.NoBukti=@Nobukti

      

      if not exists(select NoBukti from [dbPenyerahanBhn] where NoBukti=@Nobukti) 

      INSERT INTO [dbPenyerahanBhn]

        ([Nobukti]

           ,[Nourut]

           ,[Tanggal]

           ,[Kodegdg]

           ,[NoBPPB]

           ,[cetakke]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[IsSampel]

           ,[KdDep]

           ,[NoPOL]

           ,[Supir]

           ,[Devisi]

           ,[ID]

           ,[TGLJAM])

     select [Nobukti]

           ,[Nourut]

           ,[Tanggal]

           ,[Kodegdg]

           ,[NoBPPB]

           ,[cetakke]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[IsSampel]

           ,[KdDep]

           ,[NoPOL]

           ,[Supir]

           ,[Devisi]

           ,[ID]

           ,[TGLJAM] from [36.64.152.3].[DBBCAGROUP].[dbo].dbPenyerahanBhn where NoBukti=@Nobukti

      

     update [36.64.152.3].[DBBCAGROUP].[dbo].dbPenyerahanBhn set Tf=1 where NoBukti in (select NoBukti from [dbPenyerahanBhn] where NoBukti=@Nobukti) 

    else

   if @Do='D'

   delete [dbPenyerahanBhn] where NoBukti=@Nobukti

     delete [36.64.152.3].[DBBCAGROUP].[dbo].TempDelData where nobukti=@Nobukti and tabel='dbPenyerahanBhn'


 Fetch Next from MySikron into @Nobukti, @Do

 

     Close MySikron

     Deallocate MySikron

     

--dbPenyerahanBhnDet

Declare MySinkronDet Cursor for

   select nobukti,urut,Do from [36.64.152.3].[DBBCAGROUP].[dbo].dbPenyerahanBhnDet where COALESCE(tf,0)=0 and nobukti in (select nobukti from dbPenyerahanBhn where devisi in ('03','04') ) 

   and ((Do<>'I' and 1=1) or (Do='I' and nobukti+Cast(urut as varchar(4)) not in (select nobukti+Cast(urut as varchar(4)) from [dbo].[dbPenyerahanBhnDet])))

   union all

   select Nobukti,urut,'D' from [36.64.152.3].[DBBCAGROUP].[dbo].TempDelDataDet where tabel='dbPenyerahanBhnDet'

 Open MySinkronDet

 Fetch Next from MySinkronDet into @Nobukti,@Urut,@Do

 While @@fetch_Status=0

 if (@Do='I' or COALESCE(@Do,'')='')

   INSERT INTO [dbPenyerahanBhnDet]

        ([Nobukti]

           ,[urut]

           ,[NoSPK]

           ,[UrutSPK]

           ,[NoSatSPK]

           ,[kodebrg]

           ,[Sat]

           ,[Nosat]

           ,[Isi]

           ,[Qnt]

           ,[Qnt2]

           ,[HPP]

           ,[KetBrg]

           ,[Harga])

     select [Nobukti]

           ,[urut]

           ,[NoSPK]

           ,[UrutSPK]

           ,[NoSatSPK]

           ,[kodebrg]

           ,[Sat]

           ,[Nosat]

           ,[Isi]

           ,[Qnt]

           ,[Qnt2]

           ,[HPP]

           ,[KetBrg]

           ,[Harga] from [36.64.152.3].[DBBCAGROUP].[dbo].dbPenyerahanBhnDet where NoBukti=@Nobukti and Urut=@Urut

     update [36.64.152.3].[DBBCAGROUP].[dbo].dbPenyerahanBhnDet set Tf=1 where NoBukti+CAST(Urut as varchar(3)) in 

         (select +CAST(Urut as varchar(3)) from [dbPenyerahanBhnDet] where NoBukti=@Nobukti and Urut=@Urut) 

    else

   if @Do='U'

   Update [dbPenyerahanBhnDet] set 

           [NoSPK]=b.[NoSPK]

           ,[UrutSPK]=b.[UrutSPK]

           ,[NoSatSPK]=b.[NoSatSPK]

           ,[kodebrg]=b.[NoSatSPK]

           ,[Sat]=b.[Sat]

           ,[Nosat]=b.[Nosat]

           ,[Isi]=b.[Isi]

           ,[Qnt]=b.[Qnt]

           ,[Qnt2]=b.[Qnt2]

           ,[HPP]=b.[HPP]

           ,[KetBrg]=b.[KetBrg]

           ,[Harga]=b.[Harga]

      from [dbPenyerahanBhnDet] a

      left outer join 

        (select [Nobukti]

           ,[urut]

           ,[NoSPK]

           ,[UrutSPK]

           ,[NoSatSPK]

           ,[kodebrg]

           ,[Sat]

           ,[Nosat]

           ,[Isi]

           ,[Qnt]

           ,[Qnt2]

           ,[HPP]

           ,[KetBrg]

           ,[Harga]

     from [36.64.152.3].[DBBCAGROUP].[dbo].dbPenyerahanBhnDet where NoBukti=@Nobukti and Urut=@Urut ) B on b.NoBukti=a.NoBukti and b.Urut=a.Urut where a.NoBukti=@Nobukti and a.Urut=@Urut

      

      if not exists(select NoBukti from [dbPenyerahanBhnDet] where NoBukti=@Nobukti and Urut=@Urut) 

      INSERT INTO [dbPenyerahanBhnDet]

        ([Nobukti]

           ,[urut]

           ,[NoSPK]

           ,[UrutSPK]

           ,[NoSatSPK]

           ,[kodebrg]

           ,[Sat]

           ,[Nosat]

           ,[Isi]

           ,[Qnt]

           ,[Qnt2]

           ,[HPP]

           ,[KetBrg]

           ,[Harga])

     select [Nobukti]

           ,[urut]

           ,[NoSPK]

           ,[UrutSPK]

           ,[NoSatSPK]

           ,[kodebrg]

           ,[Sat]

           ,[Nosat]

           ,[Isi]

           ,[Qnt]

           ,[Qnt2]

           ,[HPP]

           ,[KetBrg]

           ,[Harga] from [36.64.152.3].[DBBCAGROUP].[dbo].dbPenyerahanBhnDet where NoBukti=@Nobukti and Urut=@Urut

      

     update [36.64.152.3].[DBBCAGROUP].[dbo].dbPenyerahanBhnDet set Tf=1 where NoBukti+CAST(Urut as varchar(3)) in 

         (select +CAST(Urut as varchar(3)) from [dbPenyerahanBhnDet] where NoBukti=@Nobukti and Urut=@Urut) 

    else

   if @Do='D'

   delete [dbPenyerahanBhnDet] where NoBukti=@Nobukti and Urut=@Urut

     delete [36.64.152.3].[DBBCAGROUP].[dbo].TempDelDataDet where nobukti=@Nobukti and urut=@Urut and tabel='dbPenyerahanBhnDet'


 Fetch Next from MySinkronDet into @Nobukti,@Urut,@Do

 

     Close MySinkronDet

     Deallocate MySinkronDet


     --dbtrans

Declare MySikron Cursor for

   select nobukti,Do from [36.64.152.3].[DBBCAGROUP].[dbo].dbtrans where COALESCE(tf,0)=0 and nobukti in (select nobukti from [36.64.152.3].[DBBCAGROUP].[dbo].dbtransaksi where devisi in ('03','04') group by nobukti)

   and ((Do<>'I' and 1=1) or (Do='I' and nobukti not in (select nobukti from [dbtrans])))

   union all

   select Nobukti,'D' from [36.64.152.3].[DBBCAGROUP].[dbo].TempDelData where tabel='dbtrans'

 Open MySikron

 Fetch Next from MySikron into @Nobukti, @Do

 While @@fetch_Status=0

 if @Do='I'

   INSERT INTO [dbtrans]

       ([NoBukti]

           ,[NOURUT]

           ,[Tanggal]

           ,[Note]

           ,[Lampiran]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[Simbol]

           ,[TipeTransHd]

           ,[PerkiraanHd]

           ,[FlagSimbol]

           ,[MaxOL])

     select [NoBukti]

           ,[NOURUT]

           ,[Tanggal]

           ,[Note]

           ,[Lampiran]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[Simbol]

           ,[TipeTransHd]

           ,[PerkiraanHd]

           ,[FlagSimbol]

           ,[MaxOL] from [36.64.152.3].[DBBCAGROUP].[dbo].dbtrans where NoBukti=@Nobukti

     update [36.64.152.3].[DBBCAGROUP].[dbo].dbtrans set Tf=1 where NoBukti in (select NoBukti from [dbtrans] where NoBukti=@Nobukti) 

    else

   if @Do='U'

   Update [dbtrans] set 

            [Tanggal]=b.[Tanggal]

           ,[Note]=b.[Note]

           ,[Lampiran]=b.[Lampiran]

           ,[IsOtorisasi1]=b.[IsOtorisasi1]

           ,[OtoUser1]=b.[OtoUser1]

           ,[TglOto1]=b.[TglOto1]

           ,[IsOtorisasi2]=b.[IsOtorisasi2]

           ,[OtoUser2]=b.[OtoUser2]

           ,[TglOto2]=b.[TglOto2]

           ,[IsOtorisasi3]=b.[IsOtorisasi3]

           ,[OtoUser3]=b.[OtoUser3]

           ,[TglOto3]=b.[TglOto3]

           ,[IsOtorisasi4]=b.[IsOtorisasi4]

           ,[OtoUser4]=b.[OtoUser4]

           ,[TglOto4]=b.[TglOto4]

           ,[IsOtorisasi5]=b.[IsOtorisasi5]

           ,[OtoUser5]=b.[OtoUser5]

           ,[TglOto5]=b.[TglOto5]

           ,[Simbol]=b.[Simbol]

           ,[TipeTransHd]=b.[TipeTransHd]

           ,[PerkiraanHd]=b.[PerkiraanHd]

           ,[FlagSimbol]=b.[FlagSimbol]

           ,[MaxOL]=b.[MaxOL]

      from [dbtrans] a

      left outer join 

        (select [NoBukti]

           ,[NOURUT]

           ,[Tanggal]

           ,[Note]

           ,[Lampiran]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[Simbol]

           ,[TipeTransHd]

           ,[PerkiraanHd]

           ,[FlagSimbol]

           ,[MaxOL]

     from [36.64.152.3].[DBBCAGROUP].[dbo].dbtrans where NoBukti=@Nobukti ) B on b.NoBukti=a.NoBukti where a.NoBukti=@Nobukti

      

      if not exists(select NoBukti from [dbtrans] where NoBukti=@Nobukti) 

      INSERT INTO [dbtrans]

       ([NoBukti]

           ,[NOURUT]

           ,[Tanggal]

           ,[Note]

           ,[Lampiran]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[Simbol]

           ,[TipeTransHd]

           ,[PerkiraanHd]

           ,[FlagSimbol]

           ,[MaxOL])

     select [NoBukti]

           ,[NOURUT]

           ,[Tanggal]

           ,[Note]

           ,[Lampiran]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[Simbol]

           ,[TipeTransHd]

           ,[PerkiraanHd]

           ,[FlagSimbol]

           ,[MaxOL] from [36.64.152.3].[DBBCAGROUP].[dbo].dbtrans where NoBukti=@Nobukti

      

      update [36.64.152.3].[DBBCAGROUP].[dbo].dbtrans set Tf=1 where NoBukti in (select NoBukti from [dbtrans] where NoBukti=@Nobukti) 

    else

   if @Do='D'

   delete [dbtrans] where NoBukti=@Nobukti

     delete [36.64.152.3].[DBBCAGROUP].[dbo].TempDelData where nobukti=@Nobukti and tabel='dbtrans'


 Fetch Next from MySikron into @Nobukti, @Do

 

     Close MySikron

     Deallocate MySikron

     

--dbtransaksi

Declare MySinkronDet Cursor for

   select nobukti,urut,Do from [36.64.152.3].[DBBCAGROUP].[dbo].dbtransaksi where COALESCE(tf,0)=0 and devisi in ('03','04') 

   and ((Do<>'I' and 1=1) or (Do='I' and nobukti+Cast(urut as varchar(4)) not in (select nobukti+Cast(urut as varchar(4)) from [dbtransaksi])))

   union all

   select Nobukti,urut,'D' from [36.64.152.3].[DBBCAGROUP].[dbo].TempDelDataDet where tabel='dbtransaksi'

 Open MySinkronDet

 Fetch Next from MySinkronDet into @Nobukti,@Urut,@Do

 While @@fetch_Status=0

 if @Do='I'

   INSERT INTO [dbtransaksi]

        ([NoBukti]

           ,[Tanggal]

           ,[Devisi]

           ,[Note]

           ,[Lampiran]

           ,[Perkiraan]

           ,[Lawan]

           ,[Keterangan]

           ,[Keterangan2]

           ,[Debet]

           ,[Kredit]

           ,[Valas]

           ,[Kurs]

           ,[DebetRp]

           ,[KreditRp]

           ,[TipeTrans]

           ,[TPHC]

           ,[CustSuppP]

           ,[CustSuppL]

           ,[Urut]

           ,[KodeP]

           ,[KodeL]

           ,[NoAktivaP]

           ,[NoAktivaL]

           ,[StatusAktivaP]

           ,[StatusAktivaL]

           ,[Nobon]

           ,[KodeBag]

           ,[StatusGiro]

           ,[FlagSimbol]

           ,[UserID]

           ,[NoBuktiAsl]

           ,[UrutAsl])

     select [NoBukti]

           ,[Tanggal]

           ,[Devisi]

           ,[Note]

           ,[Lampiran]

           ,[Perkiraan]

           ,[Lawan]

           ,[Keterangan]

           ,[Keterangan2]

           ,[Debet]

           ,[Kredit]

           ,[Valas]

           ,[Kurs]

           ,[DebetRp]

           ,[KreditRp]

           ,[TipeTrans]

           ,[TPHC]

           ,[CustSuppP]

           ,[CustSuppL]

           ,[Urut]

           ,[KodeP]

           ,[KodeL]

           ,[NoAktivaP]

           ,[NoAktivaL]

           ,[StatusAktivaP]

           ,[StatusAktivaL]

           ,[Nobon]

           ,[KodeBag]

           ,[StatusGiro]

           ,[FlagSimbol]

           ,[UserID]

           ,[NoBuktiAsl]

           ,[UrutAsl] from [36.64.152.3].[DBBCAGROUP].[dbo].dbtransaksi where NoBukti=@Nobukti and Urut=@Urut

     update [36.64.152.3].[DBBCAGROUP].[dbo].dbtransaksi set Tf=1 where NoBukti+CAST(Urut as varchar(3)) in 

         (select +CAST(Urut as varchar(3)) from [dbtransaksi] where NoBukti=@Nobukti and Urut=@Urut) 

    else

   if @Do='U'

   Update [dbtransaksi] set 

           [Tanggal]=b.[Tanggal]

           ,[Devisi]=b.[Devisi]

           ,[Note]=b.[Note]

           ,[Lampiran]=b.[Lampiran]

           ,[Perkiraan]=b.[Perkiraan]

           ,[Lawan]=b.[Lawan]

           ,[Keterangan]=b.[Keterangan]

           ,[Keterangan2]=b.[Keterangan2]

           ,[Debet]=b.[Debet]

           ,[Kredit]=b.[Kredit]

           ,[Valas]=b.[Valas]

           ,[Kurs]=b.[Kurs]

           ,[DebetRp]=b.[DebetRp]

           ,[KreditRp]=b.[KreditRp]

           ,[TipeTrans]=b.[TipeTrans]

           ,[TPHC]=b.[TPHC]

           ,[CustSuppP]=b.[CustSuppP]

           ,[CustSuppL]=b.[CustSuppL]

           ,[KodeP]=b.[KodeP]

           ,[KodeL]=b.[KodeL]

           ,[NoAktivaP]=b.[NoAktivaP]

           ,[NoAktivaL]=b.[NoAktivaL]

           ,[StatusAktivaP]=b.[StatusAktivaP]

           ,[StatusAktivaL]=b.[StatusAktivaL]

           ,[Nobon]=b.[Nobon]

           ,[KodeBag]=b.[KodeBag]

           ,[StatusGiro]=b.[StatusGiro]

           ,[FlagSimbol]=b.[FlagSimbol]

           ,[UserID]=b.[UserID]

           ,[NoBuktiAsl]=b.[NoBuktiAsl]

           ,[UrutAsl]=b.[UrutAsl]

      from [dbtransaksi] a

      left outer join 

        (select [NoBukti]

           ,[Tanggal]

           ,[Devisi]

           ,[Note]

           ,[Lampiran]

           ,[Perkiraan]

           ,[Lawan]

           ,[Keterangan]

           ,[Keterangan2]

           ,[Debet]

           ,[Kredit]

           ,[Valas]

           ,[Kurs]

           ,[DebetRp]

           ,[KreditRp]

           ,[TipeTrans]

           ,[TPHC]

           ,[CustSuppP]

           ,[CustSuppL]

           ,[Urut]

           ,[KodeP]

           ,[KodeL]

           ,[NoAktivaP]

           ,[NoAktivaL]

           ,[StatusAktivaP]

           ,[StatusAktivaL]

           ,[Nobon]

           ,[KodeBag]

           ,[StatusGiro]

           ,[FlagSimbol]

           ,[UserID]

           ,[NoBuktiAsl]

           ,[UrutAsl]

     from [36.64.152.3].[DBBCAGROUP].[dbo].dbtransaksi where NoBukti=@Nobukti and Urut=@Urut ) B on b.NoBukti=a.NoBukti and b.Urut=a.Urut where a.NoBukti=@Nobukti and a.Urut=@Urut

      

      if not exists(select NoBukti from [dbtransaksi] where NoBukti=@Nobukti and Urut=@Urut) 

      INSERT INTO [dbtransaksi]

        ([NoBukti]

           ,[Tanggal]

           ,[Devisi]

           ,[Note]

           ,[Lampiran]

           ,[Perkiraan]

           ,[Lawan]

           ,[Keterangan]

           ,[Keterangan2]

           ,[Debet]

           ,[Kredit]

           ,[Valas]

           ,[Kurs]

           ,[DebetRp]

           ,[KreditRp]

           ,[TipeTrans]

           ,[TPHC]

           ,[CustSuppP]

           ,[CustSuppL]

           ,[Urut]

           ,[KodeP]

           ,[KodeL]

           ,[NoAktivaP]

           ,[NoAktivaL]

           ,[StatusAktivaP]

           ,[StatusAktivaL]

           ,[Nobon]

           ,[KodeBag]

           ,[StatusGiro]

           ,[FlagSimbol]

           ,[UserID]

           ,[NoBuktiAsl]

           ,[UrutAsl])

     select [NoBukti]

           ,[Tanggal]

           ,[Devisi]

           ,[Note]

           ,[Lampiran]

           ,[Perkiraan]

           ,[Lawan]

           ,[Keterangan]

           ,[Keterangan2]

           ,[Debet]

           ,[Kredit]

           ,[Valas]

           ,[Kurs]

           ,[DebetRp]

           ,[KreditRp]

           ,[TipeTrans]

           ,[TPHC]

           ,[CustSuppP]

           ,[CustSuppL]

           ,[Urut]

           ,[KodeP]

           ,[KodeL]

           ,[NoAktivaP]

           ,[NoAktivaL]

           ,[StatusAktivaP]

           ,[StatusAktivaL]

           ,[Nobon]

           ,[KodeBag]

           ,[StatusGiro]

           ,[FlagSimbol]

           ,[UserID]

           ,[NoBuktiAsl]

           ,[UrutAsl] from [36.64.152.3].[DBBCAGROUP].[dbo].dbtransaksi where NoBukti=@Nobukti and Urut=@Urut

      

     update [36.64.152.3].[DBBCAGROUP].[dbo].dbtransaksi set Tf=1 where NoBukti+CAST(Urut as varchar(3)) in 

         (select +CAST(Urut as varchar(3)) from [dbtransaksi] where NoBukti=@Nobukti and Urut=@Urut) 

    else

   if @Do='D'

   delete [dbtransaksi] where NoBukti=@Nobukti and Urut=@Urut

     delete [36.64.152.3].[DBBCAGROUP].[dbo].TempDelDataDet where nobukti=@Nobukti and urut=@Urut and tabel='dbtransaksi'


 Fetch Next from MySinkronDet into @Nobukti,@Urut,@Do

 

     Close MySinkronDet

     Deallocate MySinkronDet



--dbhutpiut

Declare MySinkronDet Cursor for

   select nobukti,nomsk,Do from [36.64.152.3].[DBBCAGROUP].[dbo].dbhutpiut where COALESCE(tf,0)=0 and devisi in ('03','04') 

   and ((Do<>'I' and 1=1) or (Do='I' and nobukti+Cast(nomsk as varchar(4)) not in (select nobukti+Cast(nomsk as varchar(4)) from [dbhutpiut])))

   union all

   select Nobukti,urut,'D' from [36.64.152.3].[DBBCAGROUP].[dbo].TempDelDataDet where tabel='dbhutpiut'

 Open MySinkronDet

 Fetch Next from MySinkronDet into @Nobukti,@Urut,@Do

 While @@fetch_Status=0

 if @Do='I'

   INSERT INTO [dbhutpiut]

        ([NoFaktur]

           ,[NoRetur]

           ,[TipeTrans]

           ,[KodeCustSupp]

           ,[NoBukti]

           ,[NoMsk]

           ,[Urut]

           ,[Tanggal]

           ,[JatuhTempo]

           ,[Debet]

           ,[Kredit]

           ,[Valas]

           ,[Kurs]

           ,[DebetD]

           ,[KreditD]

           ,[KodeSales]

           ,[Tipe]

           ,[Perkiraan]

           ,[Catatan]

           ,[NOINVOICE]

           ,[TGLINVOICE]

           ,[NOPAJAK]

           ,[TGLFPJ]

           ,[KodeVls_]

           ,[Kurs_]

           ,[KursBayar]

           ,[FlagSimbol]

           ,[TipeBayar]

           ,[NoPelunasan]

           ,[PerkiraanKas]

           ,[TglButuh]

           ,[PerkiraanTBayar]

           ,[KBLB]

           ,[Devisi])

     select [NoFaktur]

           ,[NoRetur]

           ,[TipeTrans]

           ,[KodeCustSupp]

           ,[NoBukti]

           ,[NoMsk]

           ,[Urut]

           ,[Tanggal]

           ,[JatuhTempo]

           ,[Debet]

           ,[Kredit]

           ,[Valas]

           ,[Kurs]

           ,[DebetD]

           ,[KreditD]

           ,[KodeSales]

           ,[Tipe]

           ,[Perkiraan]

           ,[Catatan]

           ,[NOINVOICE]

           ,[TGLINVOICE]

           ,[NOPAJAK]

           ,[TGLFPJ]

           ,[KodeVls_]

           ,[Kurs_]

           ,[KursBayar]

           ,[FlagSimbol]

           ,[TipeBayar]

           ,[NoPelunasan]

           ,[PerkiraanKas]

           ,[TglButuh]

           ,[PerkiraanTBayar]

           ,[KBLB]

           ,[Devisi] from [36.64.152.3].[DBBCAGROUP].[dbo].dbhutpiut where NoBukti=@Nobukti and NoMsk=@Urut

     update [36.64.152.3].[DBBCAGROUP].[dbo].dbhutpiut set Tf=1 where NoBukti+CAST(NoMsk as varchar(3)) in 

         (select +CAST(NoMsk as varchar(3)) from [dbhutpiut] where NoBukti=@Nobukti and NoMsk=@Urut) 

    else

   if @Do='U'

   Update [dbhutpiut] set 

            [NoFaktur]=b.[NoFaktur]

           ,[NoRetur]=b.[NoRetur]

           ,[TipeTrans]=b.[TipeTrans]

           ,[KodeCustSupp]=b.[KodeCustSupp]

           ,[NoBukti]=b.[NoBukti]

           ,[NoMsk]=b.[NoMsk]

           ,[Urut]=b.[Urut]

           ,[Tanggal]=b.[Tanggal]

           ,[JatuhTempo]=b.[JatuhTempo]

           ,[Debet]=b.[Debet]

           ,[Kredit]=b.[Kredit]

           ,[Valas]=b.[Valas]

           ,[Kurs]=b.[Kurs]

           ,[DebetD]=b.[DebetD]

           ,[KreditD]=b.[KreditD]

           ,[KodeSales]=b.[KodeSales]

           ,[Tipe]=b.[Tipe]

           ,[Perkiraan]=b.[Perkiraan]

           ,[Catatan]=b.[Catatan]

           ,[NOINVOICE]=b.[NOINVOICE]

           ,[TGLINVOICE]=b.[TGLINVOICE]

           ,[NOPAJAK]=b.[TGLINVOICE]

           ,[TGLFPJ]=b.[TGLFPJ]

           ,[KodeVls_]=b.[KodeVls_]

           ,[Kurs_]=b.[Kurs_]

           ,[KursBayar]=b.[KursBayar]

           ,[FlagSimbol]=b.[FlagSimbol]

           ,[TipeBayar]=b.[TipeBayar]

           ,[NoPelunasan]=b.[NoPelunasan]

           ,[PerkiraanKas]=b.[PerkiraanKas]

           ,[TglButuh]=b.[TglButuh]

           ,[PerkiraanTBayar]=b.[PerkiraanTBayar]

           ,[KBLB]=b.[KBLB]

           ,[Devisi]=b.[Devisi]

      from [dbhutpiut] a

      left outer join 

        (select [NoFaktur]

           ,[NoRetur]

           ,[TipeTrans]

           ,[KodeCustSupp]

           ,[NoBukti]

           ,[NoMsk]

           ,[Urut]

           ,[Tanggal]

           ,[JatuhTempo]

           ,[Debet]

           ,[Kredit]

           ,[Valas]

           ,[Kurs]

           ,[DebetD]

           ,[KreditD]

           ,[KodeSales]

           ,[Tipe]

           ,[Perkiraan]

           ,[Catatan]

           ,[NOINVOICE]

           ,[TGLINVOICE]

           ,[NOPAJAK]

           ,[TGLFPJ]

           ,[KodeVls_]

           ,[Kurs_]

           ,[KursBayar]

           ,[FlagSimbol]

           ,[TipeBayar]

           ,[NoPelunasan]

           ,[PerkiraanKas]

           ,[TglButuh]

           ,[PerkiraanTBayar]

           ,[KBLB]

           ,[Devisi]

     from [36.64.152.3].[DBBCAGROUP].[dbo].dbhutpiut where NoBukti=@Nobukti and NoMsk=@Urut ) B on b.NoBukti=a.NoBukti and b.Nomsk=a.Nomsk where a.NoBukti=@Nobukti and a.Nomsk=@Urut

      

      if not exists(select NoBukti from [dbhutpiut] where NoBukti=@Nobukti and NoMsk=@Urut) 

      INSERT INTO [dbhutpiut]

        ([NoFaktur]

           ,[NoRetur]

           ,[TipeTrans]

           ,[KodeCustSupp]

           ,[NoBukti]

           ,[NoMsk]

           ,[Urut]

           ,[Tanggal]

           ,[JatuhTempo]

           ,[Debet]

           ,[Kredit]

           ,[Valas]

           ,[Kurs]

           ,[DebetD]

           ,[KreditD]

           ,[KodeSales]

           ,[Tipe]

           ,[Perkiraan]

           ,[Catatan]

           ,[NOINVOICE]

           ,[TGLINVOICE]

           ,[NOPAJAK]

           ,[TGLFPJ]

           ,[KodeVls_]

           ,[Kurs_]

           ,[KursBayar]

           ,[FlagSimbol]

           ,[TipeBayar]

           ,[NoPelunasan]

           ,[PerkiraanKas]

           ,[TglButuh]

           ,[PerkiraanTBayar]

           ,[KBLB]

           ,[Devisi])

     select [NoFaktur]

           ,[NoRetur]

           ,[TipeTrans]

           ,[KodeCustSupp]

           ,[NoBukti]

           ,[NoMsk]

           ,[Urut]

           ,[Tanggal]

           ,[JatuhTempo]

           ,[Debet]

           ,[Kredit]

           ,[Valas]

           ,[Kurs]

           ,[DebetD]

           ,[KreditD]

           ,[KodeSales]

           ,[Tipe]

           ,[Perkiraan]

           ,[Catatan]

           ,[NOINVOICE]

           ,[TGLINVOICE]

           ,[NOPAJAK]

           ,[TGLFPJ]

           ,[KodeVls_]

           ,[Kurs_]

           ,[KursBayar]

           ,[FlagSimbol]

           ,[TipeBayar]

           ,[NoPelunasan]

           ,[PerkiraanKas]

           ,[TglButuh]

           ,[PerkiraanTBayar]

           ,[KBLB]

           ,[Devisi] from [36.64.152.3].[DBBCAGROUP].[dbo].dbhutpiut where NoBukti=@Nobukti and NoMsk=@Urut

      

     update [36.64.152.3].[DBBCAGROUP].[dbo].dbhutpiut set Tf=1 where NoBukti+CAST(NoMsk as varchar(3)) in 

         (select +CAST(NoMsk as varchar(3)) from [dbhutpiut] where NoBukti=@Nobukti and NoMsk=@Urut) 

    else

   if @Do='D'

   delete [dbhutpiut] where NoBukti=@Nobukti and NoMsk=@Urut

     delete [36.64.152.3].[DBBCAGROUP].[dbo].TempDelDataDet where nobukti=@Nobukti and urut=@Urut and tabel='dbhutpiut'


 Fetch Next from MySinkronDet into @Nobukti,@Urut,@Do

 

     Close MySinkronDet

     Deallocate MySinkronDet;

-- sp_TFTransOut
CREATE PROCEDURE IF NOT EXISTS sp_TFTransOut AS -- Batch submitted through debugger: SQLQuery4.sql|7|0|C:\Users\Administrator\AppData\Local\Temp\1\~vs7315.sql

-- DECLARE REMOVED,@Do char(1),@Urut int   



--dbso

Declare MySikron Cursor for

   select nobukti,Do from dbso where COALESCE(tf,0)=0 and devisi in ('03','04') and IsOtorisasi1=1 

   and ((Do<>'I' and 1=1) or (Do='I' and nobukti not in (select nobukti from [36.64.152.3].[DBBCAGROUP].[dbo].[dbso])))

   union all

   select Nobukti,'D' from TempDelData where tabel='dbso'

 Open MySikron

 Fetch Next from MySikron into @Nobukti, @Do

 While @@fetch_Status=0

 if (@Do='I' or COALESCE(@Do,'')='')

   INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[dbso]

        ([NOBUKTI]

           ,[NOURUT]

           ,[TANGGAL]

           ,[TGLJATUHTEMPO]

           ,[KODECUST]

           ,[NOSPB]

           ,[NoAlamatKirim]

           ,[AlamatKirim]

           ,[HANDLING]

           ,[KODESLS]

           ,[KETERANGAN]

           ,[KODEVLS]

           ,[KURS]

           ,[PPN]

           ,[TIPEBAYAR]

           ,[HARI]

           ,[CATATAN]

           ,[TIPEDISC]

           ,[DISC]

           ,[DISCRP]

           ,[NILAIPOT]

           ,[NILAIDPP]

           ,[NILAIPPN]

           ,[NILAINET]

           ,[ISCETAK]

           ,[ISBATAL]

           ,[USERBATAL]

           ,[KODEGDG]

           ,[KodeExp]

           ,[INSGdg]

           ,[INSBrg]

           ,[Jam]

           ,[NewNo]

           ,[FLAGTIPE]

           ,[NOPI]

           ,[TIPESC]

           ,[TERM1P]

           ,[TERM1VLS]

           ,[TERM1KURS]

           ,[TERM1KET]

           ,[TERM2P]

           ,[TERM2VLS]

           ,[TERM2KURS]

           ,[TERM2KET]

           ,[TERM3P]

           ,[TERM3VLS]

           ,[TERM3KURS]

           ,[TERM3KET]

           ,[TERM4P]

           ,[TERM4VLS]

           ,[TERM4KURS]

           ,[TERM4KET]

           ,[TERM5P]

           ,[TERM5VLS]

           ,[TERM5KURS]

           ,[TERM5KET]

           ,[KetTipeEkspor]

           ,[IsLengkap]

           ,[userid]

           ,[TglInput]

           ,[NoPesanan]

           ,[TglKirim]

           ,[MasaBerlaku]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[cetakke]

           ,[MAXOL]

           ,[TglBatal]

           ,[NamaTtd]

           ,[JabatanTtd]

           ,[IsCetakP]

           ,[Devisi])

     select [NOBUKTI]

           ,[NOURUT]

           ,[TANGGAL]

           ,[TGLJATUHTEMPO]

           ,[KODECUST]

           ,[NOSPB]

           ,[NoAlamatKirim]

           ,[AlamatKirim]

           ,[HANDLING]

           ,[KODESLS]

           ,[KETERANGAN]

           ,[KODEVLS]

           ,[KURS]

           ,[PPN]

           ,[TIPEBAYAR]

           ,[HARI]

           ,[CATATAN]

           ,[TIPEDISC]

           ,[DISC]

           ,[DISCRP]

           ,[NILAIPOT]

           ,[NILAIDPP]

           ,[NILAIPPN]

           ,[NILAINET]

           ,[ISCETAK]

           ,[ISBATAL]

           ,[USERBATAL]

           ,[KODEGDG]

           ,[KodeExp]

           ,[INSGdg]

           ,[INSBrg]

           ,[Jam]

           ,[NewNo]

           ,[FLAGTIPE]

           ,[NOPI]

           ,[TIPESC]

           ,[TERM1P]

           ,[TERM1VLS]

           ,[TERM1KURS]

           ,[TERM1KET]

           ,[TERM2P]

           ,[TERM2VLS]

           ,[TERM2KURS]

           ,[TERM2KET]

           ,[TERM3P]

           ,[TERM3VLS]

           ,[TERM3KURS]

           ,[TERM3KET]

           ,[TERM4P]

           ,[TERM4VLS]

           ,[TERM4KURS]

           ,[TERM4KET]

           ,[TERM5P]

           ,[TERM5VLS]

           ,[TERM5KURS]

           ,[TERM5KET]

           ,[KetTipeEkspor]

           ,[IsLengkap]

           ,[userid]

           ,[TglInput]

           ,[NoPesanan]

           ,[TglKirim]

           ,[MasaBerlaku]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[cetakke]

           ,[MAXOL]

           ,[TglBatal]

           ,[NamaTtd]

           ,[JabatanTtd]

           ,[IsCetakP]

           ,[Devisi] from dbso where NoBukti=@Nobukti

     update dbso set Tf=1 where NoBukti in (select NoBukti from [36.64.152.3].[DBBCAGROUP].[dbo].[dbso] where NoBukti=@Nobukti) 

    else

   if @Do='U'

   Update [36.64.152.3].[DBBCAGROUP].[dbo].[dbso] set 

            [TANGGAL]=b.[TANGGAL]

           ,[TGLJATUHTEMPO]=b.[TGLJATUHTEMPO]

           ,[KODECUST]=b.[KODECUST]

           ,[NOSPB]=b.[NOSPB]

           ,[NoAlamatKirim]=b.[NoAlamatKirim]

           ,[AlamatKirim]=b.[AlamatKirim]

           ,[HANDLING]=b.[HANDLING]

           ,[KODESLS]=b.[KODESLS]

           ,[KETERANGAN]=b.[KETERANGAN]

           ,[KODEVLS]=b.[KODEVLS]

           ,[KURS]=b.[KURS]

           ,[PPN]=b.[PPN]

           ,[TIPEBAYAR]=b.[TIPEBAYAR]

           ,[HARI]=b.[HARI]

           ,[CATATAN]=b.[CATATAN]

           ,[TIPEDISC]=b.[TIPEDISC]

           ,[DISC]=b.[DISC]

           ,[DISCRP]=b.[DISCRP]

           ,[NILAIPOT]=b.[NILAIPOT]

           ,[NILAIDPP]=b.[NILAIDPP]

           ,[NILAIPPN]=b.[NILAIPPN]

           ,[NILAINET]=b.[NILAINET]

           ,[ISCETAK]=b.[ISCETAK]

           ,[ISBATAL]=b.[ISBATAL]

           ,[USERBATAL]=b.[USERBATAL]

           ,[KODEGDG]=b.[KODEGDG]

           ,[KodeExp]=b.[KodeExp]

           ,[INSGdg]=b.[INSGdg]

           ,[INSBrg]=b.[INSBrg]

           ,[Jam]=b.[Jam]

           ,[NewNo]=b.[NewNo]

           ,[FLAGTIPE]=b.[FLAGTIPE]

           ,[NOPI]=b.[NOPI]

           ,[TIPESC]=b.[TIPESC]

           ,[TERM1P]=b.[TERM1P]

           ,[TERM1VLS]=b.[TERM1VLS]

           ,[TERM1KURS]=b.[TERM1KURS]

           ,[TERM1KET]=b.[TERM1KET]

           ,[TERM2P]=b.[TERM2P]

           ,[TERM2VLS]=b.[TERM2VLS]

           ,[TERM2KURS]=b.[TERM2KURS]

           ,[TERM2KET]=b.[TERM2KET]

           ,[TERM3P]=b.[TERM3P]

           ,[TERM3VLS]=b.[TERM3VLS]

           ,[TERM3KURS]=b.[TERM3KURS]

           ,[TERM3KET]=b.[TERM3KET]

           ,[TERM4P]=b.[TERM4P]

           ,[TERM4VLS]=b.[TERM4VLS]

           ,[TERM4KURS]=b.[TERM4KURS]

           ,[TERM4KET]=b.[TERM4KET]

           ,[TERM5P]=b.[TERM5P]

           ,[TERM5VLS]=b.[TERM5VLS]

           ,[TERM5KURS]=b.[TERM5KURS]

           ,[TERM5KET]=b.[TERM5KET]

           ,[KetTipeEkspor]=b.[KetTipeEkspor]

           ,[IsLengkap]=b.[IsLengkap]

           ,[userid]=b.[userid]

           ,[TglInput]=b.[TglInput]

           ,[NoPesanan]=b.[NoPesanan]

           ,[TglKirim]=b.[TglKirim]

           ,[MasaBerlaku]=b.[MasaBerlaku]

           ,[IsOtorisasi1]=b.[IsOtorisasi1]

           ,[OtoUser1]=b.[OtoUser1]

           ,[TglOto1]=b.[TglOto1]

           ,[IsOtorisasi2]=b.[IsOtorisasi2]

           ,[OtoUser2]=b.[OtoUser2]

           ,[TglOto2]=b.[TglOto2]

           ,[IsOtorisasi3]=b.[IsOtorisasi3]

           ,[OtoUser3]=b.[OtoUser3]

           ,[TglOto3]=b.[TglOto3]

           ,[IsOtorisasi4]=b.[IsOtorisasi4]

           ,[OtoUser4]=b.[OtoUser4]

           ,[TglOto4]=b.[TglOto4]

           ,[IsOtorisasi5]=b.[IsOtorisasi5]

           ,[OtoUser5]=b.[OtoUser5]

           ,[TglOto5]=b.[TglOto5]

           ,[NoJurnal]=b.[NoJurnal]

           ,[NoUrutJurnal]=b.[NoUrutJurnal]

           ,[TglJurnal]=b.[TglJurnal]

           ,[cetakke]=b.[cetakke]

           ,[MAXOL]=b.[MAXOL]

           ,[TglBatal]=b.[TglBatal]

           ,[NamaTtd]=b.[NamaTtd]

           ,[JabatanTtd]=b.[JabatanTtd]

           ,[IsCetakP]=b.[IsCetakP]

           ,[Devisi]=b.[Devisi]

      from [36.64.152.3].[DBBCAGROUP].[dbo].[dbso] a

      left outer join 

        (select [NOBUKTI]

           ,[NOURUT]

           ,[TANGGAL]

           ,[TGLJATUHTEMPO]

           ,[KODECUST]

           ,[NOSPB]

           ,[NoAlamatKirim]

           ,[AlamatKirim]

           ,[HANDLING]

           ,[KODESLS]

           ,[KETERANGAN]

           ,[KODEVLS]

           ,[KURS]

           ,[PPN]

           ,[TIPEBAYAR]

           ,[HARI]

           ,[CATATAN]

           ,[TIPEDISC]

           ,[DISC]

           ,[DISCRP]

           ,[NILAIPOT]

           ,[NILAIDPP]

           ,[NILAIPPN]

           ,[NILAINET]

           ,[ISCETAK]

           ,[ISBATAL]

           ,[USERBATAL]

           ,[KODEGDG]

           ,[KodeExp]

           ,[INSGdg]

           ,[INSBrg]

           ,[Jam]

           ,[NewNo]

           ,[FLAGTIPE]

           ,[NOPI]

           ,[TIPESC]

           ,[TERM1P]

           ,[TERM1VLS]

           ,[TERM1KURS]

           ,[TERM1KET]

           ,[TERM2P]

           ,[TERM2VLS]

           ,[TERM2KURS]

           ,[TERM2KET]

           ,[TERM3P]

           ,[TERM3VLS]

           ,[TERM3KURS]

           ,[TERM3KET]

           ,[TERM4P]

           ,[TERM4VLS]

           ,[TERM4KURS]

           ,[TERM4KET]

           ,[TERM5P]

           ,[TERM5VLS]

           ,[TERM5KURS]

           ,[TERM5KET]

           ,[KetTipeEkspor]

           ,[IsLengkap]

           ,[userid]

           ,[TglInput]

           ,[NoPesanan]

           ,[TglKirim]

           ,[MasaBerlaku]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[cetakke]

           ,[MAXOL]

           ,[TglBatal]

           ,[NamaTtd]

           ,[JabatanTtd]

           ,[IsCetakP]

           ,[Devisi]

     from dbso where NoBukti=@Nobukti ) B on b.NoBukti=a.NoBukti where a.NoBukti=@Nobukti

      

      if not exists(select NoBukti from [36.64.152.3].[DBBCAGROUP].[dbo].[dbso] where NoBukti=@Nobukti) 

      INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[dbso]

        ([NOBUKTI]

           ,[NOURUT]

           ,[TANGGAL]

           ,[TGLJATUHTEMPO]

           ,[KODECUST]

           ,[NOSPB]

           ,[NoAlamatKirim]

           ,[AlamatKirim]

           ,[HANDLING]

           ,[KODESLS]

           ,[KETERANGAN]

           ,[KODEVLS]

           ,[KURS]

           ,[PPN]

           ,[TIPEBAYAR]

           ,[HARI]

           ,[CATATAN]

           ,[TIPEDISC]

           ,[DISC]

           ,[DISCRP]

           ,[NILAIPOT]

           ,[NILAIDPP]

           ,[NILAIPPN]

           ,[NILAINET]

           ,[ISCETAK]

           ,[ISBATAL]

           ,[USERBATAL]

           ,[KODEGDG]

           ,[KodeExp]

           ,[INSGdg]

           ,[INSBrg]

           ,[Jam]

           ,[NewNo]

           ,[FLAGTIPE]

           ,[NOPI]

           ,[TIPESC]

           ,[TERM1P]

           ,[TERM1VLS]

           ,[TERM1KURS]

           ,[TERM1KET]

           ,[TERM2P]

           ,[TERM2VLS]

           ,[TERM2KURS]

           ,[TERM2KET]

           ,[TERM3P]

           ,[TERM3VLS]

           ,[TERM3KURS]

           ,[TERM3KET]

           ,[TERM4P]

           ,[TERM4VLS]

           ,[TERM4KURS]

           ,[TERM4KET]

           ,[TERM5P]

           ,[TERM5VLS]

           ,[TERM5KURS]

           ,[TERM5KET]

           ,[KetTipeEkspor]

           ,[IsLengkap]

           ,[userid]

           ,[TglInput]

           ,[NoPesanan]

           ,[TglKirim]

           ,[MasaBerlaku]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[cetakke]

           ,[MAXOL]

           ,[TglBatal]

           ,[NamaTtd]

           ,[JabatanTtd]

           ,[IsCetakP]

           ,[Devisi])

     select [NOBUKTI]

           ,[NOURUT]

           ,[TANGGAL]

           ,[TGLJATUHTEMPO]

           ,[KODECUST]

           ,[NOSPB]

           ,[NoAlamatKirim]

           ,[AlamatKirim]

           ,[HANDLING]

           ,[KODESLS]

           ,[KETERANGAN]

           ,[KODEVLS]

           ,[KURS]

           ,[PPN]

           ,[TIPEBAYAR]

           ,[HARI]

           ,[CATATAN]

           ,[TIPEDISC]

           ,[DISC]

           ,[DISCRP]

           ,[NILAIPOT]

           ,[NILAIDPP]

           ,[NILAIPPN]

           ,[NILAINET]

           ,[ISCETAK]

           ,[ISBATAL]

           ,[USERBATAL]

           ,[KODEGDG]

           ,[KodeExp]

           ,[INSGdg]

           ,[INSBrg]

           ,[Jam]

           ,[NewNo]

           ,[FLAGTIPE]

           ,[NOPI]

           ,[TIPESC]

           ,[TERM1P]

           ,[TERM1VLS]

           ,[TERM1KURS]

           ,[TERM1KET]

           ,[TERM2P]

           ,[TERM2VLS]

           ,[TERM2KURS]

           ,[TERM2KET]

           ,[TERM3P]

           ,[TERM3VLS]

           ,[TERM3KURS]

           ,[TERM3KET]

           ,[TERM4P]

           ,[TERM4VLS]

           ,[TERM4KURS]

           ,[TERM4KET]

           ,[TERM5P]

           ,[TERM5VLS]

           ,[TERM5KURS]

           ,[TERM5KET]

           ,[KetTipeEkspor]

           ,[IsLengkap]

           ,[userid]

           ,[TglInput]

           ,[NoPesanan]

           ,[TglKirim]

           ,[MasaBerlaku]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[cetakke]

           ,[MAXOL]

           ,[TglBatal]

           ,[NamaTtd]

           ,[JabatanTtd]

           ,[IsCetakP]

           ,[Devisi] from dbso where NoBukti=@Nobukti


      update dbso set Tf=1 where NoBukti in (select NoBukti from [36.64.152.3].[DBBCAGROUP].[dbo].[dbso] where NoBukti=@Nobukti) 

    else

   if @Do='D'

   delete [36.64.152.3].[DBBCAGROUP].[dbo].[dbso] where NoBukti=@Nobukti

     delete TempDelData where nobukti=@Nobukti and tabel='dbso'


 Fetch Next from MySikron into @Nobukti, @Do

 

     Close MySikron

     Deallocate MySikron

     

--dbsodet

Declare MySinkronDet Cursor for

   select nobukti,urut,Do from dbsodet where COALESCE(tf,0)=0 and nobukti in (select nobukti from dbso where devisi in ('03','04') and IsOtorisasi1=1) 

  and ((Do<>'I' and 1=1) or (Do='I' and nobukti+Cast(urut as varchar(4)) not in (select nobukti+Cast(urut as varchar(4)) from [36.64.152.3].[DBBCAGROUP].[dbo].[dbsodet])))  

   union all

   select Nobukti,urut,'D' from TempDelDataDet where tabel='dbsodet'

 Open MySinkronDet

 Fetch Next from MySinkronDet into @Nobukti,@Urut,@Do

 While @@fetch_Status=0

 if (@Do='I' or COALESCE(@Do,'')='')

   INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[dbsodet]

        ([NOBUKTI]

           ,[URUT]

           ,[KODEBRG]

           ,[TGLKIRIM]

           ,[PPN]

           ,[DISC]

           ,[KURS]

           ,[QNT]

           ,[QNT2]

           ,[QNTBATAL]

           ,[TGLBATAL]

           ,[NOSAT]

           ,[SATUAN]

           ,[ISI]

           ,[HARGA]

           ,[HPP]

           ,[DISCP1]

           ,[DISCRP1]

           ,[DISCTOT]

           ,[BYANGKUT]

           ,[NOSPB]

           ,[UrutSPB]

           ,[Qnt3]

           ,[QntSisaSO]

           ,[Qnt2SisaSO]

           ,[QntSJln]

           ,[Qnt2SJln]

           ,[IsCetakKitir]

           ,[Isclose]

           ,[UserClose]

           ,[TglClose]

           ,[Ketbatal]

           ,[NamaBrg]

           ,[HPPMaterial]

           ,[HPPLabour]

           ,[HPPOH]

           ,[IsUbahNama]

           ,[KodeBrgM]

           ,[PPH]

           ,[KetBatal1]

           ,[NilaiPPN])

     select [NOBUKTI]

           ,[URUT]

           ,[KODEBRG]

           ,[TGLKIRIM]

           ,[PPN]

           ,[DISC]

           ,[KURS]

           ,[QNT]

           ,[QNT2]

           ,[QNTBATAL]

           ,[TGLBATAL]

           ,[NOSAT]

           ,[SATUAN]

           ,[ISI]

           ,[HARGA]

           ,[HPP]

           ,[DISCP1]

           ,[DISCRP1]

           ,[DISCTOT]

           ,[BYANGKUT]

           ,[NOSPB]

           ,[UrutSPB]

           ,[Qnt3]

           ,[QntSisaSO]

           ,[Qnt2SisaSO]

           ,[QntSJln]

           ,[Qnt2SJln]

           ,[IsCetakKitir]

           ,[Isclose]

           ,[UserClose]

           ,[TglClose]

           ,[Ketbatal]

           ,[NamaBrg]

           ,[HPPMaterial]

           ,[HPPLabour]

           ,[HPPOH]

           ,[IsUbahNama]

           ,[KodeBrgM]

           ,[PPH]

           ,[KetBatal1]

           ,[NilaiPPN] from dbsodet where NoBukti=@Nobukti and Urut=@Urut

     update dbsodet set Tf=1 where NoBukti+CAST(Urut as varchar(3)) in 

         (select +CAST(Urut as varchar(3)) from [36.64.152.3].[DBBCAGROUP].[dbo].[dbsodet] where NoBukti=@Nobukti and Urut=@Urut) 

    else

   if @Do='U'

   Update [36.64.152.3].[DBBCAGROUP].[dbo].[dbsodet] set 

           [KODEBRG]=b.[KODEBRG]

           ,[TGLKIRIM]=b.[TGLKIRIM]

           ,[PPN]=b.[PPN]

           ,[DISC]=b.[DISC]

           ,[KURS]=b.[KURS]

           ,[QNT]=b.[QNT]

           ,[QNT2]=b.[QNT2]

           ,[QNTBATAL]=b.[QNTBATAL]

           ,[TGLBATAL]=b.[TGLBATAL]

           ,[NOSAT]=b.[NOSAT]

           ,[SATUAN]=b.[SATUAN]

           ,[ISI]=b.[ISI]

           ,[HARGA]=b.[HARGA]

           ,[HPP]=b.[HPP]

           ,[DISCP1]=b.[DISCP1]

           ,[DISCRP1]=b.[DISCRP1]

           ,[DISCTOT]=b.[DISCTOT]

           ,[BYANGKUT]=b.[BYANGKUT]

           ,[NOSPB]=b.[NOSPB]

           ,[UrutSPB]=b.[UrutSPB]

           ,[Qnt3]=b.[Qnt3]

           ,[QntSisaSO]=b.[QntSisaSO]

           ,[Qnt2SisaSO]=b.[Qnt2SisaSO]

           ,[QntSJln]=b.[QntSJln]

           ,[Qnt2SJln]=b.[Qnt2SJln]

           ,[IsCetakKitir]=b.[IsCetakKitir]

           ,[Isclose]=b.[Isclose]

           ,[UserClose]=b.[UserClose]

           ,[TglClose]=b.[TglClose]

           ,[Ketbatal]=b.[Ketbatal]

           ,[NamaBrg]=b.[NamaBrg]

           ,[HPPMaterial]=b.[HPPMaterial]

           ,[HPPLabour]=b.[HPPLabour]

           ,[HPPOH]=b.[HPPOH]

           ,[IsUbahNama]=b.[IsUbahNama]

           ,[KodeBrgM]=b.[KodeBrgM]

           ,[PPH]=b.[PPH]

           ,[KetBatal1]=b.[KetBatal1]

           ,[NilaiPPN]=b.[NilaiPPN]

      from [36.64.152.3].[DBBCAGROUP].[dbo].[dbsodet] a

      left outer join 

        (select [NOBUKTI]

           ,[URUT]

           ,[KODEBRG]

           ,[TGLKIRIM]

           ,[PPN]

           ,[DISC]

           ,[KURS]

           ,[QNT]

           ,[QNT2]

           ,[QNTBATAL]

           ,[TGLBATAL]

           ,[NOSAT]

           ,[SATUAN]

           ,[ISI]

           ,[HARGA]

           ,[HPP]

           ,[DISCP1]

           ,[DISCRP1]

           ,[DISCTOT]

           ,[BYANGKUT]

           ,[NOSPB]

           ,[UrutSPB]

           ,[Qnt3]

           ,[QntSisaSO]

           ,[Qnt2SisaSO]

           ,[QntSJln]

           ,[Qnt2SJln]

           ,[IsCetakKitir]

           ,[Isclose]

           ,[UserClose]

           ,[TglClose]

           ,[Ketbatal]

           ,[NamaBrg]

           ,[HPPMaterial]

           ,[HPPLabour]

           ,[HPPOH]

           ,[IsUbahNama]

           ,[KodeBrgM]

           ,[PPH]

           ,[KetBatal1]

           ,[NilaiPPN]

     from dbsodet where NoBukti=@Nobukti and Urut=@Urut ) B on b.NoBukti=a.NoBukti and b.Urut=a.Urut where a.NoBukti=@Nobukti and a.Urut=@Urut

      

      if not exists(select NoBukti from [36.64.152.3].[DBBCAGROUP].[dbo].[dbsodet] where NoBukti=@Nobukti and Urut=@Urut) 

      INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[dbsodet]

        ([NOBUKTI]

           ,[URUT]

           ,[KODEBRG]

           ,[TGLKIRIM]

           ,[PPN]

           ,[DISC]

           ,[KURS]

           ,[QNT]

           ,[QNT2]

           ,[QNTBATAL]

           ,[TGLBATAL]

           ,[NOSAT]

           ,[SATUAN]

           ,[ISI]

           ,[HARGA]

           ,[HPP]

           ,[DISCP1]

           ,[DISCRP1]

           ,[DISCTOT]

           ,[BYANGKUT]

           ,[NOSPB]

           ,[UrutSPB]

           ,[Qnt3]

           ,[QntSisaSO]

           ,[Qnt2SisaSO]

           ,[QntSJln]

           ,[Qnt2SJln]

           ,[IsCetakKitir]

           ,[Isclose]

           ,[UserClose]

           ,[TglClose]

           ,[Ketbatal]

           ,[NamaBrg]

           ,[HPPMaterial]

           ,[HPPLabour]

           ,[HPPOH]

           ,[IsUbahNama]

           ,[KodeBrgM]

           ,[PPH]

           ,[KetBatal1]

           ,[NilaiPPN])

     select [NOBUKTI]

           ,[URUT]

           ,[KODEBRG]

           ,[TGLKIRIM]

           ,[PPN]

           ,[DISC]

           ,[KURS]

           ,[QNT]

           ,[QNT2]

           ,[QNTBATAL]

           ,[TGLBATAL]

           ,[NOSAT]

           ,[SATUAN]

           ,[ISI]

           ,[HARGA]

           ,[HPP]

           ,[DISCP1]

           ,[DISCRP1]

           ,[DISCTOT]

           ,[BYANGKUT]

           ,[NOSPB]

           ,[UrutSPB]

           ,[Qnt3]

           ,[QntSisaSO]

           ,[Qnt2SisaSO]

           ,[QntSJln]

           ,[Qnt2SJln]

           ,[IsCetakKitir]

           ,[Isclose]

           ,[UserClose]

           ,[TglClose]

           ,[Ketbatal]

           ,[NamaBrg]

           ,[HPPMaterial]

           ,[HPPLabour]

           ,[HPPOH]

           ,[IsUbahNama]

           ,[KodeBrgM]

           ,[PPH]

           ,[KetBatal1]

           ,[NilaiPPN] from dbsodet where NoBukti=@Nobukti and Urut=@Urut

      

     update dbsodet set Tf=1 where NoBukti+CAST(Urut as varchar(3)) in 

         (select +CAST(Urut as varchar(3)) from [36.64.152.3].[DBBCAGROUP].[dbo].[dbsodet] where NoBukti=@Nobukti and Urut=@Urut) 

    else

   if @Do='D'

   delete [36.64.152.3].[DBBCAGROUP].[dbo].[dbsodet] where NoBukti=@Nobukti and Urut=@Urut

     delete TempDelDataDet where nobukti=@Nobukti and urut=@Urut and tabel='dbsodet'


 Fetch Next from MySinkronDet into @Nobukti,@Urut,@Do

 

     Close MySinkronDet

     Deallocate MySinkronDet 

    

--dbPPl

Declare MySikron Cursor for

   select nobukti,Do from dbPPL where COALESCE(tf,0)=0 and devisi in ('03','04') and isotorisasi1=1  

   and ((Do<>'I' and 1=1) or (Do='I' and nobukti not in (select nobukti from [36.64.152.3].[DBBCAGROUP].[dbo].[dbppl])))



   union all

   select Nobukti,'D' from TempDelData where tabel='dbPPL'

 Open MySikron

 Fetch Next from MySikron into @Nobukti, @Do

 While @@fetch_Status=0

 if (@Do='I' or COALESCE(@Do,'')='')

   INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[dbPPL]

      ([Nobukti]

           ,[Nourut]

           ,[Tanggal]

           ,[IsClose]

           ,[KDDep]

           ,[cetakke]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[IsBatal]

           ,[UserBatal]

           ,[TglBatal]

           ,[Devisi])

     select [Nobukti]

           ,[Nourut]

           ,[Tanggal]

           ,[IsClose]

           ,[KDDep]

           ,[cetakke]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[IsBatal]

           ,[UserBatal]

           ,[TglBatal]

           ,[Devisi] from dbPPL where NoBukti=@Nobukti

     update dbPPL set Tf=1 where NoBukti in (select NoBukti from [36.64.152.3].[DBBCAGROUP].[dbo].[dbPPL] where NoBukti=@Nobukti) 

    else

   if @Do='U'

   Update [36.64.152.3].[DBBCAGROUP].[dbo].[dbPPL] set 

           [Tanggal]=b.[Tanggal]

           ,[IsClose]=b.[IsClose]

           ,[KDDep]=b.[KDDep]

           ,[cetakke]=b.[cetakke]

           ,[IsOtorisasi1]=b.[IsOtorisasi1]

           ,[OtoUser1]=b.[OtoUser1]

           ,[TglOto1]=b.[TglOto1]

           ,[IsOtorisasi2]=b.[IsOtorisasi2]

           ,[OtoUser2]=b.[OtoUser2]

           ,[TglOto2]=b.[TglOto2]

           ,[IsOtorisasi3]=b.[IsOtorisasi3]

           ,[OtoUser3]=b.[OtoUser3]

           ,[TglOto3]=b.[TglOto3]

           ,[IsOtorisasi4]=b.[IsOtorisasi4]

           ,[OtoUser4]=b.[OtoUser4]

           ,[TglOto4]=b.[TglOto4]

           ,[IsOtorisasi5]=b.[IsOtorisasi5]

           ,[OtoUser5]=b.[OtoUser5]

           ,[TglOto5]=b.[TglOto5]

           ,[NoJurnal]=b.[NoJurnal]

           ,[NoUrutJurnal]=b.[NoUrutJurnal]

           ,[TglJurnal]=b.[TglJurnal]

           ,[MaxOL]=b.[MaxOL]

           ,[IsBatal]=b.[IsBatal]

           ,[UserBatal]=b.[UserBatal]

           ,[TglBatal]=b.[TglBatal]

           ,[Devisi]=b.[Devisi]

      from [36.64.152.3].[DBBCAGROUP].[dbo].[dbPPL] a

      left outer join 

        (select [Nobukti]

           ,[Nourut]

           ,[Tanggal]

           ,[IsClose]

           ,[KDDep]

           ,[cetakke]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[IsBatal]

           ,[UserBatal]

           ,[TglBatal]

           ,[Devisi]

     from dbPPL where NoBukti=@Nobukti ) B on b.NoBukti=a.NoBukti where a.NoBukti=@Nobukti

      

      if not exists(select NoBukti from [36.64.152.3].[DBBCAGROUP].[dbo].[dbPPL] where NoBukti=@Nobukti) 

      INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[dbPPL]

      ([Nobukti]

           ,[Nourut]

           ,[Tanggal]

           ,[IsClose]

           ,[KDDep]

           ,[cetakke]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[IsBatal]

           ,[UserBatal]

           ,[TglBatal]

           ,[Devisi])

     select [Nobukti]

           ,[Nourut]

           ,[Tanggal]

           ,[IsClose]

           ,[KDDep]

           ,[cetakke]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[IsBatal]

           ,[UserBatal]

           ,[TglBatal]

           ,[Devisi] from dbPPL where NoBukti=@Nobukti

      

      update dbPPL set Tf=1 where NoBukti in (select NoBukti from [36.64.152.3].[DBBCAGROUP].[dbo].[dbPPL] where NoBukti=@Nobukti) 

    else

   if @Do='D'

   delete [36.64.152.3].[DBBCAGROUP].[dbo].[dbPPL] where NoBukti=@Nobukti

     delete TempDelData where nobukti=@Nobukti and tabel='dbPPL'


 Fetch Next from MySikron into @Nobukti, @Do

 

     Close MySikron

     Deallocate MySikron

     

--dbppldet

Declare MySinkronDet Cursor for

   select nobukti,urut,Do from dbppldet where COALESCE(tf,0)=0 and nobukti in ( select nobukti from dbppl where devisi in ('03','04') and isotorisasi1=1 )

   and ((Do<>'I' and 1=1) or (Do='I' and nobukti+Cast(urut as varchar(4)) not in (select nobukti+Cast(urut as varchar(4)) from [36.64.152.3].[DBBCAGROUP].[dbo].[dbppldet])))



   union all

   select Nobukti,urut,'D' from TempDelDataDet where tabel='dbppldet'

 Open MySinkronDet

 Fetch Next from MySinkronDet into @Nobukti,@Urut,@Do

 While @@fetch_Status=0

 if (@Do='I' or COALESCE(@Do,'')='')

   INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[dbppldet]

        ([Nobukti]

           ,[urut]

           ,[kodebrg]

           ,[Sat]

           ,[Nosat]

           ,[Isi]

           ,[Qnt]

           ,[QntPO]

           ,[Keterangan]

           ,[IsClose]

           ,[NoSPK]

           ,[UrutSPK]

           ,[NosatSPK]

           ,[Isbatal]

           ,[Tglbatal]

           ,[UserBatal]

           ,[Qntbatal]

           ,[TglKirim]

           ,[NamaBrg]

           ,[Alasan])

     select [Nobukti]

           ,[urut]

           ,[kodebrg]

           ,[Sat]

           ,[Nosat]

           ,[Isi]

           ,[Qnt]

           ,[QntPO]

           ,[Keterangan]

           ,[IsClose]

           ,[NoSPK]

           ,[UrutSPK]

           ,[NosatSPK]

           ,[Isbatal]

           ,[Tglbatal]

           ,[UserBatal]

           ,[Qntbatal]

           ,[TglKirim]

           ,[NamaBrg]

           ,[Alasan] from dbppldet where NoBukti=@Nobukti and Urut=@Urut

     update dbppldet set Tf=1 where NoBukti+CAST(Urut as varchar(3)) in 

         (select +CAST(Urut as varchar(3)) from [36.64.152.3].[DBBCAGROUP].[dbo].[dbppldet] where NoBukti=@Nobukti and Urut=@Urut) 

    else

   if @Do='U'

   Update [36.64.152.3].[DBBCAGROUP].[dbo].[dbppldet] set 

           [kodebrg]=B.[kodebrg]

           ,[Sat]=b.[Sat]

           ,[Nosat]=b.[Nosat]

           ,[Isi]=b.[Isi]

           ,[Qnt]=b.[Qnt]

           ,[QntPO]=b.[QntPO]

           ,[Keterangan]=b.[Keterangan]

           ,[IsClose]=b.[IsClose]

           ,[NoSPK]=b.[NoSPK]

           ,[UrutSPK]=b.[UrutSPK]

           ,[NosatSPK]=b.[NosatSPK]

           ,[Isbatal]=b.[Isbatal]

           ,[Tglbatal]=b.[Tglbatal]

           ,[UserBatal]=b.[UserBatal]

           ,[Qntbatal]=b.[Qntbatal]

           ,[TglKirim]=b.[TglKirim]

           ,[NamaBrg]=b.[NamaBrg]

           ,[Alasan]=b.[Alasan]

      from [36.64.152.3].[DBBCAGROUP].[dbo].[dbppldet] a

      left outer join 

        (select [Nobukti]

           ,[urut]

           ,[kodebrg]

           ,[Sat]

           ,[Nosat]

           ,[Isi]

           ,[Qnt]

           ,[QntPO]

           ,[Keterangan]

           ,[IsClose]

           ,[NoSPK]

           ,[UrutSPK]

           ,[NosatSPK]

           ,[Isbatal]

           ,[Tglbatal]

           ,[UserBatal]

           ,[Qntbatal]

           ,[TglKirim]

           ,[NamaBrg]

           ,[Alasan]

     from dbppldet where NoBukti=@Nobukti and Urut=@Urut ) B on b.NoBukti=a.NoBukti and b.Urut=a.Urut where a.NoBukti=@Nobukti and a.Urut=@Urut

      

      if not exists(select NoBukti from [36.64.152.3].[DBBCAGROUP].[dbo].[dbppldet] where NoBukti=@Nobukti and Urut=@Urut) 

      INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[dbppldet]

        ([Nobukti]

           ,[urut]

           ,[kodebrg]

           ,[Sat]

           ,[Nosat]

           ,[Isi]

           ,[Qnt]

           ,[QntPO]

           ,[Keterangan]

           ,[IsClose]

           ,[NoSPK]

           ,[UrutSPK]

           ,[NosatSPK]

           ,[Isbatal]

           ,[Tglbatal]

           ,[UserBatal]

           ,[Qntbatal]

           ,[TglKirim]

           ,[NamaBrg]

           ,[Alasan])

     select [Nobukti]

           ,[urut]

           ,[kodebrg]

           ,[Sat]

           ,[Nosat]

           ,[Isi]

           ,[Qnt]

           ,[QntPO]

           ,[Keterangan]

           ,[IsClose]

           ,[NoSPK]

           ,[UrutSPK]

           ,[NosatSPK]

           ,[Isbatal]

           ,[Tglbatal]

           ,[UserBatal]

           ,[Qntbatal]

           ,[TglKirim]

           ,[NamaBrg]

           ,[Alasan] from dbppldet where NoBukti=@Nobukti and Urut=@Urut

      

     update dbppldet set Tf=1 where NoBukti+CAST(Urut as varchar(3)) in 

         (select +CAST(Urut as varchar(3)) from [36.64.152.3].[DBBCAGROUP].[dbo].[dbppldet] where NoBukti=@Nobukti and Urut=@Urut) 

    else

   if @Do='D'

   delete [36.64.152.3].[DBBCAGROUP].[dbo].[dbppldet] where NoBukti=@Nobukti and Urut=@Urut

     delete TempDelDataDet where nobukti=@Nobukti and urut=@Urut and tabel='dbppldet'


 Fetch Next from MySinkronDet into @Nobukti,@Urut,@Do

 

     Close MySinkronDet

     Deallocate MySinkronDet



--dbPO

Declare MySikron Cursor for

   select nobukti,Do from dbPO where COALESCE(tf,0)=0 and devisi in ('03','04') and isotorisasi1=1 

   and ((Do<>'I' and 1=1) or (Do='I' and nobukti not in (select nobukti from [36.64.152.3].[DBBCAGROUP].[dbo].[dbpo])))



   union all

   select Nobukti,'D' from TempDelData where tabel='dbPO'

 Open MySikron

 Fetch Next from MySikron into @Nobukti, @Do

 While @@fetch_Status=0

 if (@Do='I' or COALESCE(@Do,'')='')

   INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[dbPO]

      ([NOBUKTI]

           ,[NOURUT]

           ,[TANGGAL]

           ,[TglJatuhTempo]

           ,[KODESUPP]

           ,[HANDLING]

           ,[KODEEXP]

           ,[KETERANGAN]

           ,[FAKTURSUPP]

           ,[KODEVLS]

           ,[KURS]

           ,[PPN]

           ,[TIPEBAYAR]

           ,[HARI]

           ,[TipeDisc]

           ,[DISC]

           ,[DISCRP]

           ,[ISCETAK]

           ,[NilaiCetak]

           ,[IsBatal]

           ,[UserBatal]

           ,[IsClose]

           ,[IsExp]

           ,[isAut]

           ,[KodeGDG]

           ,[cetakke]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[TglBatal]

           ,[Syarat]

           ,[TglBatas]

           ,[Devisi])

     select [NOBUKTI]

           ,[NOURUT]

           ,[TANGGAL]

           ,[TglJatuhTempo]

           ,[KODESUPP]

           ,[HANDLING]

           ,[KODEEXP]

           ,[KETERANGAN]

           ,[FAKTURSUPP]

           ,[KODEVLS]

           ,[KURS]

           ,[PPN]

           ,[TIPEBAYAR]

           ,[HARI]

           ,[TipeDisc]

           ,[DISC]

           ,[DISCRP]

           ,[ISCETAK]

           ,[NilaiCetak]

           ,[IsBatal]

           ,[UserBatal]

           ,[IsClose]

           ,[IsExp]

           ,[isAut]

           ,[KodeGDG]

           ,[cetakke]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[TglBatal]

           ,[Syarat]

           ,[TglBatas]

           ,[Devisi] from DBPO where NoBukti=@Nobukti

     update DBPO set Tf=1 where NoBukti in (select NoBukti from [36.64.152.3].[DBBCAGROUP].[dbo].[dbPO] where NoBukti=@Nobukti) 

    else

   if @Do='U'

   Update [36.64.152.3].[DBBCAGROUP].[dbo].[dbPO] set 

            [TANGGAL]=b.[TANGGAL]

           ,[TglJatuhTempo]=b.[TglJatuhTempo]

           ,[KODESUPP]=b. [KODESUPP]

           ,[HANDLING] =b.[HANDLING]

           ,[KODEEXP] =b.[KODEEXP]

           ,[KETERANGAN] =b.[KETERANGAN]

           ,[FAKTURSUPP] =b.[FAKTURSUPP]

           ,[KODEVLS] =b.[KODEVLS]

           ,[KURS] =b.[KURS]

           ,[PPN] =b.[PPN]

           ,[TIPEBAYAR] =b.[TIPEBAYAR]

           ,[HARI] =b.[HARI]

           ,[TipeDisc] =b.[TipeDisc]

           ,[DISC] =b.[DISC]

           ,[DISCRP] =b.[DISCRP]

           ,[ISCETAK] =b.[ISCETAK]

           ,[NilaiCetak] =b.[NilaiCetak]

           ,[IsBatal] =b.[IsBatal]

           ,[UserBatal] =b.[UserBatal]

           ,[IsClose] =b.[IsClose]

           ,[IsExp] =b.[IsExp]

           ,[isAut] =b.[isAut]

           ,[KodeGDG] =b.[KodeGDG]

           ,[cetakke] =b.[cetakke]

           ,[IsOtorisasi1] =b.[IsOtorisasi1]

           ,[OtoUser1] =b.[OtoUser1]

           ,[TglOto1] =b.[TglOto1]

           ,[IsOtorisasi2] =b.[IsOtorisasi2]

           ,[OtoUser2] =b.[OtoUser2]

           ,[TglOto2] =b.[TglOto2]

           ,[IsOtorisasi3] =b.[IsOtorisasi3]

           ,[OtoUser3] =b.[OtoUser3]

           ,[TglOto3] =b.[TglOto3]

           ,[IsOtorisasi4] =b.[IsOtorisasi4]

           ,[OtoUser4] =b.[OtoUser4]

           ,[TglOto4] =b.[TglOto4]

           ,[IsOtorisasi5] =b.[IsOtorisasi5]

           ,[OtoUser5] =b.[OtoUser5]

           ,[TglOto5] =b.[TglOto5]

           ,[NoJurnal] =b.[NoJurnal]

           ,[NoUrutJurnal] =b.[NoUrutJurnal]

           ,[TglJurnal] =b.[TglJurnal]

           ,[MaxOL] =b.[MaxOL]

           ,[TglBatal] =b.[TglBatal]

           ,[Syarat] =b.[Syarat]

           ,[TglBatas] =b.[TglBatas]

           ,[Devisi] =b.[Devisi]

      from [36.64.152.3].[DBBCAGROUP].[dbo].[dbPO] a

      left outer join 

        (select [NOBUKTI]

           ,[NOURUT]

           ,[TANGGAL]

           ,[TglJatuhTempo]

           ,[KODESUPP]

           ,[HANDLING]

           ,[KODEEXP]

           ,[KETERANGAN]

           ,[FAKTURSUPP]

           ,[KODEVLS]

           ,[KURS]

           ,[PPN]

           ,[TIPEBAYAR]

           ,[HARI]

           ,[TipeDisc]

           ,[DISC]

           ,[DISCRP]

           ,[ISCETAK]

           ,[NilaiCetak]

           ,[IsBatal]

           ,[UserBatal]

           ,[IsClose]

           ,[IsExp]

           ,[isAut]

           ,[KodeGDG]

           ,[cetakke]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[TglBatal]

           ,[Syarat]

           ,[TglBatas]

           ,[Devisi]

     from DBPO where NoBukti=@Nobukti ) B on b.NoBukti=a.NoBukti where a.NoBukti=@Nobukti

      

      if not exists(select NoBukti from [36.64.152.3].[DBBCAGROUP].[dbo].[dbPO] where NoBukti=@Nobukti) 

      INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[dbPO]

      ([NOBUKTI]

           ,[NOURUT]

           ,[TANGGAL]

           ,[TglJatuhTempo]

           ,[KODESUPP]

           ,[HANDLING]

           ,[KODEEXP]

           ,[KETERANGAN]

           ,[FAKTURSUPP]

           ,[KODEVLS]

           ,[KURS]

           ,[PPN]

           ,[TIPEBAYAR]

           ,[HARI]

           ,[TipeDisc]

           ,[DISC]

           ,[DISCRP]

           ,[ISCETAK]

           ,[NilaiCetak]

           ,[IsBatal]

           ,[UserBatal]

           ,[IsClose]

           ,[IsExp]

           ,[isAut]

           ,[KodeGDG]

           ,[cetakke]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[TglBatal]

           ,[Syarat]

           ,[TglBatas]

           ,[Devisi])

     select [NOBUKTI]

           ,[NOURUT]

           ,[TANGGAL]

           ,[TglJatuhTempo]

           ,[KODESUPP]

           ,[HANDLING]

           ,[KODEEXP]

           ,[KETERANGAN]

           ,[FAKTURSUPP]

           ,[KODEVLS]

           ,[KURS]

           ,[PPN]

           ,[TIPEBAYAR]

           ,[HARI]

           ,[TipeDisc]

           ,[DISC]

           ,[DISCRP]

           ,[ISCETAK]

           ,[NilaiCetak]

           ,[IsBatal]

           ,[UserBatal]

           ,[IsClose]

           ,[IsExp]

           ,[isAut]

           ,[KodeGDG]

           ,[cetakke]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[TglBatal]

           ,[Syarat]

           ,[TglBatas]

           ,[Devisi] from DBPO where NoBukti=@Nobukti

      

      update dbPO set Tf=1 where NoBukti in (select NoBukti from [36.64.152.3].[DBBCAGROUP].[dbo].[dbPO] where NoBukti=@Nobukti) 

    else

   if @Do='D'

   delete [36.64.152.3].[DBBCAGROUP].[dbo].[dbPO] where NoBukti=@Nobukti

     delete TempDelData where nobukti=@Nobukti and tabel='dbPO'


 Fetch Next from MySikron into @Nobukti, @Do

 

     Close MySikron

     Deallocate MySikron

     

--dbpodet

Declare MySinkronDet Cursor for

   select nobukti,urut,Do from dbpodet where COALESCE(tf,0)=0 and nobukti in (select nobukti from dbpo where devisi in ('03','04') and isotorisasi1=1 ) 

   and ((Do<>'I' and 1=1) or (Do='I' and nobukti+Cast(urut as varchar(4)) not in (select nobukti+Cast(urut as varchar(4)) from [36.64.152.3].[DBBCAGROUP].[dbo].[dbpodet])))



   union all

   select Nobukti,urut,'D' from TempDelDataDet where tabel='dbpodet'

 Open MySinkronDet

 Fetch Next from MySinkronDet into @Nobukti,@Urut,@Do

 While @@fetch_Status=0

 if (@Do='I' or COALESCE(@Do,'')='')

   INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[dbpodet]

        ([NOBUKTI]

           ,[URUT]

           ,[KODEBRG]

           ,[PPN]

           ,[KURS]

           ,[DISC]

           ,[QNT]

           ,[QntBatal]

           ,[TglBatal]

           ,[NOSAT]

           ,[SATUAN]

           ,[ISI]

           ,[HARGA]

           ,[DISCP]

           ,[DISCTOT]

           ,[BYANGKUT]

           ,[NoPPL]

           ,[UrutPPL]

           ,[IsClose]

           ,[Tolerate]

           ,[Isbatal]

           ,[UserBatal]

           ,[KetBrg]

           ,[NamaBrg]

           ,[alasan]

           ,[NilaiPPN])

     select [NOBUKTI]

           ,[URUT]

           ,[KODEBRG]

           ,[PPN]

           ,[KURS]

           ,[DISC]

           ,[QNT]

           ,[QntBatal]

           ,[TglBatal]

           ,[NOSAT]

           ,[SATUAN]

           ,[ISI]

           ,[HARGA]

           ,[DISCP]

           ,[DISCTOT]

           ,[BYANGKUT]

           ,[NoPPL]

           ,[UrutPPL]

           ,[IsClose]

           ,[Tolerate]

           ,[Isbatal]

           ,[UserBatal]

           ,[KetBrg]

           ,[NamaBrg]

           ,[alasan]

           ,[NilaiPPN] from DBPODET where NoBukti=@Nobukti and Urut=@Urut

     update DBPODET set Tf=1 where NoBukti+CAST(Urut as varchar(3)) in 

         (select +CAST(Urut as varchar(3)) from [36.64.152.3].[DBBCAGROUP].[dbo].[dbpodet] where NoBukti=@Nobukti and Urut=@Urut) 

    else

   if @Do='U'

   Update [36.64.152.3].[DBBCAGROUP].[dbo].[dbpodet] set 

           [KODEBRG]=b.[KODEBRG]

           ,[PPN]=b.[PPN]

           ,[KURS]=b.[KURS]

           ,[DISC]=b.[DISC]

           ,[QNT]=b.[QNT]

           ,[QntBatal]=b.[QntBatal]

           ,[TglBatal]=b.[TglBatal]

           ,[NOSAT]=b.[NOSAT]

           ,[SATUAN]=b.[SATUAN]

           ,[ISI]=b.[ISI]

           ,[HARGA]=b.[HARGA]

           ,[DISCP]=b.[DISCP]

           ,[DISCTOT]=b.[DISCTOT]

           ,[BYANGKUT]=b.[BYANGKUT]

           ,[NoPPL]=b.[NoPPL]

           ,[UrutPPL]=b.[UrutPPL]

           ,[IsClose]=b.[IsClose]

           ,[Tolerate]=b.[Tolerate]

           ,[Isbatal]=b.[Isbatal]

           ,[UserBatal]=b.[UserBatal]

           ,[KetBrg]=b.[KetBrg]

           ,[NamaBrg]=b.[NamaBrg]

           ,[alasan]=b.[alasan]

           ,[NilaiPPN]=b.[NilaiPPN]

      from [36.64.152.3].[DBBCAGROUP].[dbo].[dbpodet] a

      left outer join 

        (select [NOBUKTI]

           ,[URUT]

           ,[KODEBRG]

           ,[PPN]

           ,[KURS]

           ,[DISC]

           ,[QNT]

           ,[QntBatal]

           ,[TglBatal]

           ,[NOSAT]

           ,[SATUAN]

           ,[ISI]

           ,[HARGA]

           ,[DISCP]

           ,[DISCTOT]

           ,[BYANGKUT]

           ,[NoPPL]

           ,[UrutPPL]

           ,[IsClose]

           ,[Tolerate]

           ,[Isbatal]

           ,[UserBatal]

           ,[KetBrg]

           ,[NamaBrg]

           ,[alasan]

           ,[NilaiPPN]

     from DBPODET where NoBukti=@Nobukti and Urut=@Urut ) B on b.NoBukti=a.NoBukti and b.Urut=a.Urut where a.NoBukti=@Nobukti and a.Urut=@Urut

      

      if not exists(select NoBukti from [36.64.152.3].[DBBCAGROUP].[dbo].[dbpodet] where NoBukti=@Nobukti and Urut=@Urut) 

      INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[dbpodet]

        ([NOBUKTI]

           ,[URUT]

           ,[KODEBRG]

           ,[PPN]

           ,[KURS]

           ,[DISC]

           ,[QNT]

           ,[QntBatal]

           ,[TglBatal]

           ,[NOSAT]

           ,[SATUAN]

           ,[ISI]

           ,[HARGA]

           ,[DISCP]

           ,[DISCTOT]

           ,[BYANGKUT]

           ,[NoPPL]

           ,[UrutPPL]

           ,[IsClose]

           ,[Tolerate]

           ,[Isbatal]

           ,[UserBatal]

           ,[KetBrg]

           ,[NamaBrg]

           ,[alasan]

           ,[NilaiPPN])

     select [NOBUKTI]

           ,[URUT]

           ,[KODEBRG]

           ,[PPN]

           ,[KURS]

           ,[DISC]

           ,[QNT]

           ,[QntBatal]

           ,[TglBatal]

           ,[NOSAT]

           ,[SATUAN]

           ,[ISI]

           ,[HARGA]

           ,[DISCP]

           ,[DISCTOT]

           ,[BYANGKUT]

           ,[NoPPL]

           ,[UrutPPL]

           ,[IsClose]

           ,[Tolerate]

           ,[Isbatal]

           ,[UserBatal]

           ,[KetBrg]

           ,[NamaBrg]

           ,[alasan]

           ,[NilaiPPN] from DBPODET where NoBukti=@Nobukti and Urut=@Urut

      

     update DBPODET set Tf=1 where NoBukti+CAST(Urut as varchar(3)) in 

         (select +CAST(Urut as varchar(3)) from [36.64.152.3].[DBBCAGROUP].[dbo].[dbpodet] where NoBukti=@Nobukti and Urut=@Urut) 

    else

   if @Do='D'

   delete [36.64.152.3].[DBBCAGROUP].[dbo].[dbpodet] where NoBukti=@Nobukti and Urut=@Urut

     delete TempDelDataDet where nobukti=@Nobukti and urut=@Urut and tabel='dbpodet'


 Fetch Next from MySinkronDet into @Nobukti,@Urut,@Do

 

     Close MySinkronDet

     Deallocate MySinkronDet

     

 --dbkirimdet

INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[DBKirimDET]

           ([NoBukti]

           ,[KodeBrg]

           ,[NoSat]

           ,[Urut]

           ,[Tanggal]

           ,[Qnt])

 select [NoBukti]

           ,[KodeBrg]

           ,[NoSat]

           ,[Urut]

           ,[Tanggal]

           ,[Qnt]

           from  [DBKirimDET]

           where NoBukti+CAST(urut as varchar(4)) not in (

           select NoBukti+CAST(urut as varchar(4)) from [36.64.152.3].[DBBCAGROUP].[dbo].[DBKirimDET] )  

           and NoBukti in (select NoBukti from [36.64.152.3].[DBBCAGROUP].[dbo].[DBpo])

     

--dbBeli

Declare MySikron Cursor for

   select nobukti,Do from dbBeli where COALESCE(tf,0)=0 and devisi in ('03','04') and isotorisasi1=1 

   and ((Do<>'I' and 1=1) or (Do='I' and nobukti not in (select nobukti from [36.64.152.3].[DBBCAGROUP].[dbo].[dbbeli])))



   union all

   select Nobukti,'D' from TempDelData where tabel='dbBeli'

 Open MySikron

 Fetch Next from MySikron into @Nobukti, @Do

 While @@fetch_Status=0

 if (@Do='I' or COALESCE(@Do,'')='')

   INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[dbBeli]

        ([NOBUKTI]

           ,[NOURUT]

           ,[TANGGAL]

           ,[TglJatuhTempo]

           ,[KODESUPP]

           ,[NoPOHd]

           ,[KodeGdgHd]

           ,[HANDLING]

           ,[KETERANGAN]

           ,[FAKTURSUPP]

           ,[KODEVLS]

           ,[KURS]

           ,[PPN]

           ,[TIPEBAYAR]

           ,[HARI]

           ,[TipeDisc]

           ,[DISC]

           ,[DISCRP]

           ,[NILAIPOT]

           ,[NILAIDPP]

           ,[NILAIPPN]

           ,[NILAINET]

           ,[ISCETAK]

           ,[NilaiCetak]

           ,[IsBatal]

           ,[UserBatal]

           ,[KodeExp]

           ,[cetakke]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[TglBatal]

           ,[Devisi])

     select [NOBUKTI]

           ,[NOURUT]

           ,[TANGGAL]

           ,[TglJatuhTempo]

           ,[KODESUPP]

           ,[NoPOHd]

           ,[KodeGdgHd]

           ,[HANDLING]

           ,[KETERANGAN]

           ,[FAKTURSUPP]

           ,[KODEVLS]

           ,[KURS]

           ,[PPN]

           ,[TIPEBAYAR]

           ,[HARI]

           ,[TipeDisc]

           ,[DISC]

           ,[DISCRP]

           ,[NILAIPOT]

           ,[NILAIDPP]

           ,[NILAIPPN]

           ,[NILAINET]

           ,[ISCETAK]

           ,[NilaiCetak]

           ,[IsBatal]

           ,[UserBatal]

           ,[KodeExp]

           ,[cetakke]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[TglBatal]

           ,[Devisi] from dbBeli where NoBukti=@Nobukti

     update dbBeli set Tf=1 where NoBukti in (select NoBukti from [36.64.152.3].[DBBCAGROUP].[dbo].[dbBeli] where NoBukti=@Nobukti) 

    else

   if @Do='U'

   Update [36.64.152.3].[DBBCAGROUP].[dbo].[dbBeli] set 

           [TANGGAL]=b.[TANGGAL]

           ,[TglJatuhTempo]=b.[TglJatuhTempo]

           ,[KODESUPP]=b.[KODESUPP]

           ,[NoPOHd]=b.[NoPOHd]

           ,[KodeGdgHd]=b.[KodeGdgHd]

           ,[HANDLING]=b.[HANDLING]

           ,[KETERANGAN]=b.[KETERANGAN]

           ,[FAKTURSUPP]=b.[FAKTURSUPP]

           ,[KODEVLS]=b.[KODEVLS]

           ,[KURS]=b.[KURS]

           ,[PPN]=b.[PPN]

           ,[TIPEBAYAR]=b.[TIPEBAYAR]

           ,[HARI]=b.[HARI]

           ,[TipeDisc]=b.[TipeDisc]

           ,[DISC]=b.[DISC]

           ,[DISCRP]=b.[DISCRP]

           ,[NILAIPOT]=b.[NILAIPOT]

           ,[NILAIDPP]=b.[NILAIDPP]

           ,[NILAIPPN]=b.[NILAIPPN]

           ,[NILAINET]=b.[NILAINET]

           ,[ISCETAK]=b.[ISCETAK]

           ,[NilaiCetak]=b.[NilaiCetak]

           ,[IsBatal]=b.[IsBatal]

           ,[UserBatal]=b.[UserBatal]

           ,[KodeExp]=b.[KodeExp]

           ,[cetakke]=b.[cetakke]

           ,[IsOtorisasi1]=b.[IsOtorisasi1]

           ,[OtoUser1]=b.[OtoUser1]

           ,[TglOto1]=b.[TglOto1]

           ,[IsOtorisasi2]=b.[IsOtorisasi2]

           ,[OtoUser2]=b.[OtoUser2]

           ,[TglOto2]=b.[TglOto2]

           ,[IsOtorisasi3]=b.[IsOtorisasi3]

           ,[OtoUser3]=b.[OtoUser3]

           ,[TglOto3]=b.[TglOto3]

           ,[IsOtorisasi4]=b.[IsOtorisasi4]

           ,[OtoUser4]=b.[OtoUser4]

           ,[TglOto4]=b.[TglOto4]

           ,[IsOtorisasi5]=b.[IsOtorisasi5]

           ,[OtoUser5]=b.[OtoUser5]

           ,[TglOto5]=b.[TglOto5]

           ,[NoJurnal]=b.[NoJurnal]

           ,[NoUrutJurnal]=b.[NoUrutJurnal]

           ,[TglJurnal]=b.[TglJurnal]

           ,[MaxOL]=b.[MaxOL]

           ,[TglBatal]=b.[TglBatal]

           ,[Devisi]=b.[Devisi]

      from [36.64.152.3].[DBBCAGROUP].[dbo].[dbBeli] a

      left outer join 

        (select [NOBUKTI]

           ,[NOURUT]

           ,[TANGGAL]

           ,[TglJatuhTempo]

           ,[KODESUPP]

           ,[NoPOHd]

           ,[KodeGdgHd]

           ,[HANDLING]

           ,[KETERANGAN]

           ,[FAKTURSUPP]

           ,[KODEVLS]

           ,[KURS]

           ,[PPN]

           ,[TIPEBAYAR]

           ,[HARI]

           ,[TipeDisc]

           ,[DISC]

           ,[DISCRP]

           ,[NILAIPOT]

           ,[NILAIDPP]

           ,[NILAIPPN]

           ,[NILAINET]

           ,[ISCETAK]

           ,[NilaiCetak]

           ,[IsBatal]

           ,[UserBatal]

           ,[KodeExp]

           ,[cetakke]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[TglBatal]

           ,[Devisi]

     from dbBeli where NoBukti=@Nobukti ) B on b.NoBukti=a.NoBukti where a.NoBukti=@Nobukti

      

      if not exists(select NoBukti from [36.64.152.3].[DBBCAGROUP].[dbo].[dbBeli] where NoBukti=@Nobukti) 

      INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[dbBeli]

        ([NOBUKTI]

           ,[NOURUT]

           ,[TANGGAL]

           ,[TglJatuhTempo]

           ,[KODESUPP]

           ,[NoPOHd]

           ,[KodeGdgHd]

           ,[HANDLING]

           ,[KETERANGAN]

           ,[FAKTURSUPP]

           ,[KODEVLS]

           ,[KURS]

           ,[PPN]

           ,[TIPEBAYAR]

           ,[HARI]

           ,[TipeDisc]

           ,[DISC]

           ,[DISCRP]

           ,[NILAIPOT]

           ,[NILAIDPP]

           ,[NILAIPPN]

           ,[NILAINET]

           ,[ISCETAK]

           ,[NilaiCetak]

           ,[IsBatal]

           ,[UserBatal]

           ,[KodeExp]

           ,[cetakke]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[TglBatal]

           ,[Devisi])

     select [NOBUKTI]

           ,[NOURUT]

           ,[TANGGAL]

           ,[TglJatuhTempo]

           ,[KODESUPP]

           ,[NoPOHd]

           ,[KodeGdgHd]

           ,[HANDLING]

           ,[KETERANGAN]

           ,[FAKTURSUPP]

           ,[KODEVLS]

           ,[KURS]

           ,[PPN]

           ,[TIPEBAYAR]

           ,[HARI]

           ,[TipeDisc]

           ,[DISC]

           ,[DISCRP]

           ,[NILAIPOT]

           ,[NILAIDPP]

           ,[NILAIPPN]

           ,[NILAINET]

           ,[ISCETAK]

           ,[NilaiCetak]

           ,[IsBatal]

           ,[UserBatal]

           ,[KodeExp]

           ,[cetakke]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[NoJurnal]

           ,[NoUrutJurnal]

           ,[TglJurnal]

           ,[MaxOL]

           ,[TglBatal]

           ,[Devisi] from dbBeli where NoBukti=@Nobukti

      

      update dbBeli set Tf=1 where NoBukti in (select NoBukti from [36.64.152.3].[DBBCAGROUP].[dbo].[dbBeli] where NoBukti=@Nobukti) 

    else

   if @Do='D'

   delete [36.64.152.3].[DBBCAGROUP].[dbo].[dbBeli] where NoBukti=@Nobukti

     delete TempDelData where nobukti=@Nobukti and tabel='dbBeli'


 Fetch Next from MySikron into @Nobukti, @Do

 

     Close MySikron

     Deallocate MySikron

     

--dbbelidet

Declare MySinkronDet Cursor for

   select nobukti,urut,Do from dbbelidet where COALESCE(tf,0)=0 and nobukti in (select nobukti from dbbeli where devisi in ('03','04') and isotorisasi1=1 ) 

      and ((Do<>'I' and 1=1) or (Do='I' and nobukti+Cast(urut as varchar(4)) not in (select nobukti+Cast(urut as varchar(4)) from [36.64.152.3].[DBBCAGROUP].[dbo].[dbbelidet])))



   union all

   select Nobukti,urut,'D' from TempDelDataDet where tabel='dbbelidet'

 Open MySinkronDet

 Fetch Next from MySinkronDet into @Nobukti,@Urut,@Do

 While @@fetch_Status=0

 if (@Do='I' or COALESCE(@Do,'')='')

   INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[dbbelidet]

        ([NOBUKTI]

           ,[URUT]

           ,[KODEBRG]

           ,[KodeGdg]

           ,[PPN]

           ,[KURS]

           ,[DISC]

           ,[QNT]

           ,[NOSAT]

           ,[SATUAN]

           ,[ISI]

           ,[HARGA]

           ,[DISCP]

           ,[DISCTOT]

           ,[BYANGKUT]

           ,[NoPO]

           ,[UrutPO]

           ,[HPP]

           ,[QntTerima]

           ,[Qnt1Terima]

           ,[Qnt2Terima]

           ,[QntReject]

           ,[Qnt1Reject]

           ,[Qnt2Reject]

           ,[UrutBeli]

           ,[KetReject]

           ,[QntTerima_]

           ,[Qnt1Terima_]

           ,[Qnt2Terima_]

           ,[NamaBrg]

           ,[Perkiraan]

           ,[NilaiPPN])

     select [NOBUKTI]

           ,[URUT]

           ,[KODEBRG]

           ,[KodeGdg]

           ,[PPN]

           ,[KURS]

           ,[DISC]

           ,[QNT]

           ,[NOSAT]

           ,[SATUAN]

           ,[ISI]

           ,[HARGA]

           ,[DISCP]

           ,[DISCTOT]

           ,[BYANGKUT]

           ,[NoPO]

           ,[UrutPO]

           ,[HPP]

           ,[QntTerima]

           ,[Qnt1Terima]

           ,[Qnt2Terima]

           ,[QntReject]

           ,[Qnt1Reject]

           ,[Qnt2Reject]

           ,[UrutBeli]

           ,[KetReject]

           ,[QntTerima_]

           ,[Qnt1Terima_]

           ,[Qnt2Terima_]

           ,[NamaBrg]

           ,[Perkiraan]

           ,[NilaiPPN] from dbbelidet where NoBukti=@Nobukti and Urut=@Urut

     update dbbelidet set Tf=1 where NoBukti+CAST(Urut as varchar(3)) in 

         (select +CAST(Urut as varchar(3)) from [36.64.152.3].[DBBCAGROUP].[dbo].[dbbelidet] where NoBukti=@Nobukti and Urut=@Urut) 

    else

   if @Do='U'

   Update [36.64.152.3].[DBBCAGROUP].[dbo].[dbbelidet] set 

            [KODEBRG]=b.[KODEBRG]

           ,[KodeGdg]=b.[KodeGdg]

           ,[PPN]=b.[PPN]

           ,[KURS]=b.[KURS]

           ,[DISC]=b.[DISC]

           ,[QNT]=b.[QNT]

           ,[NOSAT]=b.[NOSAT]

           ,[SATUAN]=b.[SATUAN]

           ,[ISI]=b.[ISI]

           ,[HARGA]=b.[HARGA]

           ,[DISCP]=b.[DISCP]

           ,[DISCTOT]=b.[DISCTOT]

           ,[BYANGKUT]=b.[BYANGKUT]

           ,[NoPO]=b.[NoPO]

           ,[UrutPO]=b.[UrutPO]

           ,[HPP]=b.[HPP]

           ,[QntTerima]=b.[QntTerima]

           ,[Qnt1Terima]=b.[Qnt1Terima]

           ,[Qnt2Terima]=b.[Qnt2Terima]

           ,[QntReject]=b.[QntReject]

           ,[Qnt1Reject]=b.[Qnt1Reject]

           ,[Qnt2Reject]=b.[Qnt2Reject]

           ,[UrutBeli]=b.[UrutBeli]

           ,[KetReject]=b.[KetReject]

           ,[QntTerima_]=b.[QntTerima_]

           ,[Qnt1Terima_]=b.[Qnt1Terima_]

           ,[Qnt2Terima_]=b.[Qnt2Terima_]

           ,[NamaBrg]=b.[NamaBrg]

           ,[Perkiraan]=b.[Perkiraan]

           ,[NilaiPPN]=b.[NilaiPPN]

      from [36.64.152.3].[DBBCAGROUP].[dbo].[dbbelidet] a

      left outer join 

        (select [NOBUKTI]

           ,[URUT]

           ,[KODEBRG]

           ,[KodeGdg]

           ,[PPN]

           ,[KURS]

           ,[DISC]

           ,[QNT]

           ,[NOSAT]

           ,[SATUAN]

           ,[ISI]

           ,[HARGA]

           ,[DISCP]

           ,[DISCTOT]

           ,[BYANGKUT]

           ,[NoPO]

           ,[UrutPO]

           ,[HPP]

           ,[QntTerima]

           ,[Qnt1Terima]

           ,[Qnt2Terima]

           ,[QntReject]

           ,[Qnt1Reject]

           ,[Qnt2Reject]

           ,[UrutBeli]

           ,[KetReject]

           ,[QntTerima_]

           ,[Qnt1Terima_]

           ,[Qnt2Terima_]

           ,[NamaBrg]

           ,[Perkiraan]

           ,[NilaiPPN]

     from dbbelidet where NoBukti=@Nobukti and Urut=@Urut ) B on b.NoBukti=a.NoBukti and b.Urut=a.Urut where a.NoBukti=@Nobukti and a.Urut=@Urut

      

      if not exists(select NoBukti from [36.64.152.3].[DBBCAGROUP].[dbo].[dbbelidet] where NoBukti=@Nobukti and Urut=@Urut) 

      INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[dbbelidet]

        ([NOBUKTI]

           ,[URUT]

           ,[KODEBRG]

           ,[KodeGdg]

           ,[PPN]

           ,[KURS]

           ,[DISC]

           ,[QNT]

           ,[NOSAT]

           ,[SATUAN]

           ,[ISI]

           ,[HARGA]

           ,[DISCP]

           ,[DISCTOT]

           ,[BYANGKUT]

           ,[NoPO]

           ,[UrutPO]

           ,[HPP]

           ,[QntTerima]

           ,[Qnt1Terima]

           ,[Qnt2Terima]

           ,[QntReject]

           ,[Qnt1Reject]

           ,[Qnt2Reject]

           ,[UrutBeli]

           ,[KetReject]

           ,[QntTerima_]

           ,[Qnt1Terima_]

           ,[Qnt2Terima_]

           ,[NamaBrg]

           ,[Perkiraan]

           ,[NilaiPPN])

     select [NOBUKTI]

           ,[URUT]

           ,[KODEBRG]

           ,[KodeGdg]

           ,[PPN]

           ,[KURS]

           ,[DISC]

           ,[QNT]

           ,[NOSAT]

           ,[SATUAN]

           ,[ISI]

           ,[HARGA]

           ,[DISCP]

           ,[DISCTOT]

           ,[BYANGKUT]

           ,[NoPO]

           ,[UrutPO]

           ,[HPP]

           ,[QntTerima]

           ,[Qnt1Terima]

           ,[Qnt2Terima]

           ,[QntReject]

           ,[Qnt1Reject]

           ,[Qnt2Reject]

           ,[UrutBeli]

           ,[KetReject]

           ,[QntTerima_]

           ,[Qnt1Terima_]

           ,[Qnt2Terima_]

           ,[NamaBrg]

           ,[Perkiraan]

           ,[NilaiPPN] from dbbelidet where NoBukti=@Nobukti and Urut=@Urut

      

     update dbbelidet set Tf=1 where NoBukti+CAST(Urut as varchar(3)) in 

         (select +CAST(Urut as varchar(3)) from [36.64.152.3].[DBBCAGROUP].[dbo].[dbbelidet] where NoBukti=@Nobukti and Urut=@Urut) 

    else

   if @Do='D'

   delete [36.64.152.3].[DBBCAGROUP].[dbo].[dbbelidet] where NoBukti=@Nobukti and Urut=@Urut

     delete TempDelDataDet where nobukti=@Nobukti and urut=@Urut and tabel='dbbelidet'


 Fetch Next from MySinkronDet into @Nobukti,@Urut,@Do

 

     Close MySinkronDet

     Deallocate MySinkronDet

 

--dbProject

Declare MySikron Cursor for

   select KODEPROJECT,Do from dbProject where COALESCE(tf,0)=0 and devisi in ('03','04') 

   union all

   select Nobukti,'D' from TempDelData where tabel='dbProject'

 Open MySikron

 Fetch Next from MySikron into @Nobukti, @Do

 While @@fetch_Status=0

 if (@Do='I' or COALESCE(@Do,'')='')

   INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[dbProject]

        ([KODEPROJECT]

           ,[NAMAPROJECT]

           ,[KODECUST]

           ,[ALAMATPROJECT]

           ,[Pelaksana]

           ,[KodeSubKota]

           ,[ContactP]

           ,[TelpHP]

           ,[Fax]

           ,[Email]

           ,[KodeRute]

           ,[Devisi])

     select [KODEPROJECT]

           ,[NAMAPROJECT]

           ,[KODECUST]

           ,[ALAMATPROJECT]

           ,[Pelaksana]

           ,[KodeSubKota]

           ,[ContactP]

           ,[TelpHP]

           ,[Fax]

           ,[Email]

           ,[KodeRute]

           ,[Devisi] from dbProject where KODEPROJECT=@Nobukti

     update dbProject set Tf=1 where KODEPROJECT in (select KODEPROJECT from [36.64.152.3].[DBBCAGROUP].[dbo].[dbProject] where KODEPROJECT=@Nobukti) 

    else

   if @Do='U'

   Update [36.64.152.3].[DBBCAGROUP].[dbo].[dbProject] set 

            [NAMAPROJECT]=b.[NAMAPROJECT]

           ,[KODECUST]=b.[KODECUST]

           ,[ALAMATPROJECT]=b.[ALAMATPROJECT]

           ,[Pelaksana]=b.[Pelaksana]

           ,[KodeSubKota]=b.[KodeSubKota]

           ,[ContactP]=b.[ContactP]

           ,[TelpHP]=b.[TelpHP]

           ,[Fax]=b.[Fax]

           ,[Email]=b.[Email]

           ,[KodeRute]=b.[KodeRute]

           ,[Devisi]=b.[Devisi]

      from [36.64.152.3].[DBBCAGROUP].[dbo].[dbProject] a

      left outer join 

        (select [KODEPROJECT]

           ,[NAMAPROJECT]

           ,[KODECUST]

           ,[ALAMATPROJECT]

           ,[Pelaksana]

           ,[KodeSubKota]

           ,[ContactP]

           ,[TelpHP]

           ,[Fax]

           ,[Email]

           ,[KodeRute]

           ,[Devisi] from dbProject where KODEPROJECT=@Nobukti ) B on b.KODEPROJECT=a.KODEPROJECT where a.KODEPROJECT=@Nobukti

      

      if not exists(select KODEPROJECT from [36.64.152.3].[DBBCAGROUP].[dbo].[dbProject] where KODEPROJECT=@Nobukti) 

      INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[dbProject]

        ([KODEPROJECT]

           ,[NAMAPROJECT]

           ,[KODECUST]

           ,[ALAMATPROJECT]

           ,[Pelaksana]

           ,[KodeSubKota]

           ,[ContactP]

           ,[TelpHP]

           ,[Fax]

           ,[Email]

           ,[KodeRute]

           ,[Devisi])

     select [KODEPROJECT]

           ,[NAMAPROJECT]

           ,[KODECUST]

           ,[ALAMATPROJECT]

           ,[Pelaksana]

           ,[KodeSubKota]

           ,[ContactP]

           ,[TelpHP]

           ,[Fax]

           ,[Email]

           ,[KodeRute]

           ,[Devisi] from dbProject where KODEPROJECT=@Nobukti   

        

      update dbProject set Tf=1 where KODEPROJECT in (select KODEPROJECT from [36.64.152.3].[DBBCAGROUP].[dbo].[dbProject] where KODEPROJECT=@Nobukti) 

    else

   if @Do='D'

   delete [36.64.152.3].[DBBCAGROUP].[dbo].[dbProject] where KODEPROJECT=@Nobukti

     delete TempDelData where nobukti=@Nobukti and tabel='dbBeli'


 Fetch Next from MySikron into @Nobukti, @Do

 

     Close MySikron

     Deallocate MySikron 


--dbtrans

Declare MySikron Cursor for

   select nobukti,Do from dbtrans where COALESCE(tf,0)=0 and nobukti in (select nobukti from dbtransaksi where devisi in ('03','04')  group by nobukti)

   and ((Do<>'I' and 1=1) or (Do='I' and nobukti not in (select nobukti from [36.64.152.3].[DBBCAGROUP].[dbo].[dbtrans])))

   union all

   select Nobukti,'D' from TempDelData where tabel='dbtrans'

 Open MySikron

 Fetch Next from MySikron into @Nobukti, @Do

 While @@fetch_Status=0

 if @Do='I'

   INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[dbtrans]

       ([NoBukti]

           ,[NOURUT]

           ,[Tanggal]

           ,[Note]

           ,[Lampiran]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[Simbol]

           ,[TipeTransHd]

           ,[PerkiraanHd]

           ,[FlagSimbol]

           ,[MaxOL])

     select [NoBukti]

           ,[NOURUT]

           ,[Tanggal]

           ,[Note]

           ,[Lampiran]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[Simbol]

           ,[TipeTransHd]

           ,[PerkiraanHd]

           ,[FlagSimbol]

           ,[MaxOL] from dbtrans where NoBukti=@Nobukti

     update dbtrans set Tf=1 where NoBukti in (select NoBukti from [36.64.152.3].[DBBCAGROUP].[dbo].[dbtrans] where NoBukti=@Nobukti) 

    else

   if @Do='U'

   Update [36.64.152.3].[DBBCAGROUP].[dbo].[dbtrans] set 

            [Tanggal]=b.[Tanggal]

           ,[Note]=b.[Note]

           ,[Lampiran]=b.[Lampiran]

           ,[IsOtorisasi1]=b.[IsOtorisasi1]

           ,[OtoUser1]=b.[OtoUser1]

           ,[TglOto1]=b.[TglOto1]

           ,[IsOtorisasi2]=b.[IsOtorisasi2]

           ,[OtoUser2]=b.[OtoUser2]

           ,[TglOto2]=b.[TglOto2]

           ,[IsOtorisasi3]=b.[IsOtorisasi3]

           ,[OtoUser3]=b.[OtoUser3]

           ,[TglOto3]=b.[TglOto3]

           ,[IsOtorisasi4]=b.[IsOtorisasi4]

           ,[OtoUser4]=b.[OtoUser4]

           ,[TglOto4]=b.[TglOto4]

           ,[IsOtorisasi5]=b.[IsOtorisasi5]

           ,[OtoUser5]=b.[OtoUser5]

           ,[TglOto5]=b.[TglOto5]

           ,[Simbol]=b.[Simbol]

           ,[TipeTransHd]=b.[TipeTransHd]

           ,[PerkiraanHd]=b.[PerkiraanHd]

           ,[FlagSimbol]=b.[FlagSimbol]

           ,[MaxOL]=b.[MaxOL]

      from [36.64.152.3].[DBBCAGROUP].[dbo].[dbtrans] a

      left outer join 

        (select [NoBukti]

           ,[NOURUT]

           ,[Tanggal]

           ,[Note]

           ,[Lampiran]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[Simbol]

           ,[TipeTransHd]

           ,[PerkiraanHd]

           ,[FlagSimbol]

           ,[MaxOL]

     from dbtrans where NoBukti=@Nobukti ) B on b.NoBukti=a.NoBukti where a.NoBukti=@Nobukti

      

      if not exists(select NoBukti from [36.64.152.3].[DBBCAGROUP].[dbo].[dbtrans] where NoBukti=@Nobukti) 

      INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[dbtrans]

       ([NoBukti]

           ,[NOURUT]

           ,[Tanggal]

           ,[Note]

           ,[Lampiran]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[Simbol]

           ,[TipeTransHd]

           ,[PerkiraanHd]

           ,[FlagSimbol]

           ,[MaxOL])

     select [NoBukti]

           ,[NOURUT]

           ,[Tanggal]

           ,[Note]

           ,[Lampiran]

           ,[IsOtorisasi1]

           ,[OtoUser1]

           ,[TglOto1]

           ,[IsOtorisasi2]

           ,[OtoUser2]

           ,[TglOto2]

           ,[IsOtorisasi3]

           ,[OtoUser3]

           ,[TglOto3]

           ,[IsOtorisasi4]

           ,[OtoUser4]

           ,[TglOto4]

           ,[IsOtorisasi5]

           ,[OtoUser5]

           ,[TglOto5]

           ,[Simbol]

           ,[TipeTransHd]

           ,[PerkiraanHd]

           ,[FlagSimbol]

           ,[MaxOL] from dbtrans where NoBukti=@Nobukti

      

      update dbtrans set Tf=1 where NoBukti in (select NoBukti from [36.64.152.3].[DBBCAGROUP].[dbo].[dbtrans] where NoBukti=@Nobukti) 

    else

   if @Do='D'

   delete [36.64.152.3].[DBBCAGROUP].[dbo].[dbtrans] where NoBukti=@Nobukti

     delete TempDelData where nobukti=@Nobukti and tabel='dbtrans'


 Fetch Next from MySikron into @Nobukti, @Do

 

     Close MySikron

     Deallocate MySikron

     

--dbtransaksi

Declare MySinkronDet Cursor for

   select nobukti,urut,Do from dbtransaksi where COALESCE(tf,0)=0 and devisi in ('03','04') 

   and ((Do<>'I' and 1=1) or (Do='I' and nobukti+Cast(urut as varchar(4)) not in (select nobukti+Cast(urut as varchar(4)) from [36.64.152.3].[DBBCAGROUP].[dbo].[dbtransaksi])))

   union all

   select Nobukti,urut,'D' from TempDelDataDet where tabel='dbtransaksi'

 Open MySinkronDet

 Fetch Next from MySinkronDet into @Nobukti,@Urut,@Do

 While @@fetch_Status=0

 if @Do='I'

   INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[dbtransaksi]

        ([NoBukti]

           ,[Tanggal]

           ,[Devisi]

           ,[Note]

           ,[Lampiran]

           ,[Perkiraan]

           ,[Lawan]

           ,[Keterangan]

           ,[Keterangan2]

           ,[Debet]

           ,[Kredit]

           ,[Valas]

           ,[Kurs]

           ,[DebetRp]

           ,[KreditRp]

           ,[TipeTrans]

           ,[TPHC]

           ,[CustSuppP]

           ,[CustSuppL]

           ,[Urut]

           ,[KodeP]

           ,[KodeL]

           ,[NoAktivaP]

           ,[NoAktivaL]

           ,[StatusAktivaP]

           ,[StatusAktivaL]

           ,[Nobon]

           ,[KodeBag]

           ,[StatusGiro]

           ,[FlagSimbol]

           ,[UserID]

           ,[NoBuktiAsl]

           ,[UrutAsl])

     select [NoBukti]

           ,[Tanggal]

           ,[Devisi]

           ,[Note]

           ,[Lampiran]

           ,[Perkiraan]

           ,[Lawan]

           ,[Keterangan]

           ,[Keterangan2]

           ,[Debet]

           ,[Kredit]

           ,[Valas]

           ,[Kurs]

           ,[DebetRp]

           ,[KreditRp]

           ,[TipeTrans]

           ,[TPHC]

           ,[CustSuppP]

           ,[CustSuppL]

           ,[Urut]

           ,[KodeP]

           ,[KodeL]

           ,[NoAktivaP]

           ,[NoAktivaL]

           ,[StatusAktivaP]

           ,[StatusAktivaL]

           ,[Nobon]

           ,[KodeBag]

           ,[StatusGiro]

           ,[FlagSimbol]

           ,[UserID]

           ,[NoBuktiAsl]

           ,[UrutAsl] from dbtransaksi where NoBukti=@Nobukti and Urut=@Urut

     update dbtransaksi set Tf=1 where NoBukti+CAST(Urut as varchar(3)) in 

         (select +CAST(Urut as varchar(3)) from [36.64.152.3].[DBBCAGROUP].[dbo].[dbtransaksi] where NoBukti=@Nobukti and Urut=@Urut) 

    else

   if @Do='U'

   Update [36.64.152.3].[DBBCAGROUP].[dbo].[dbtransaksi] set 

           [Tanggal]=b.[Tanggal]

           ,[Devisi]=b.[Devisi]

           ,[Note]=b.[Note]

           ,[Lampiran]=b.[Lampiran]

           ,[Perkiraan]=b.[Perkiraan]

           ,[Lawan]=b.[Lawan]

           ,[Keterangan]=b.[Keterangan]

           ,[Keterangan2]=b.[Keterangan2]

           ,[Debet]=b.[Debet]

           ,[Kredit]=b.[Kredit]

           ,[Valas]=b.[Valas]

           ,[Kurs]=b.[Kurs]

           ,[DebetRp]=b.[DebetRp]

           ,[KreditRp]=b.[KreditRp]

           ,[TipeTrans]=b.[TipeTrans]

           ,[TPHC]=b.[TPHC]

           ,[CustSuppP]=b.[CustSuppP]

           ,[CustSuppL]=b.[CustSuppL]

           ,[KodeP]=b.[KodeP]

           ,[KodeL]=b.[KodeL]

           ,[NoAktivaP]=b.[NoAktivaP]

           ,[NoAktivaL]=b.[NoAktivaL]

           ,[StatusAktivaP]=b.[StatusAktivaP]

           ,[StatusAktivaL]=b.[StatusAktivaL]

           ,[Nobon]=b.[Nobon]

           ,[KodeBag]=b.[KodeBag]

           ,[StatusGiro]=b.[StatusGiro]

           ,[FlagSimbol]=b.[FlagSimbol]

           ,[UserID]=b.[UserID]

           ,[NoBuktiAsl]=b.[NoBuktiAsl]

           ,[UrutAsl]=b.[UrutAsl]

      from [36.64.152.3].[DBBCAGROUP].[dbo].[dbtransaksi] a

      left outer join 

        (select [NoBukti]

           ,[Tanggal]

           ,[Devisi]

           ,[Note]

           ,[Lampiran]

           ,[Perkiraan]

           ,[Lawan]

           ,[Keterangan]

           ,[Keterangan2]

           ,[Debet]

           ,[Kredit]

           ,[Valas]

           ,[Kurs]

           ,[DebetRp]

           ,[KreditRp]

           ,[TipeTrans]

           ,[TPHC]

           ,[CustSuppP]

           ,[CustSuppL]

           ,[Urut]

           ,[KodeP]

           ,[KodeL]

           ,[NoAktivaP]

           ,[NoAktivaL]

           ,[StatusAktivaP]

           ,[StatusAktivaL]

           ,[Nobon]

           ,[KodeBag]

           ,[StatusGiro]

           ,[FlagSimbol]

           ,[UserID]

           ,[NoBuktiAsl]

           ,[UrutAsl]

     from dbtransaksi where NoBukti=@Nobukti and Urut=@Urut ) B on b.NoBukti=a.NoBukti and b.Urut=a.Urut where a.NoBukti=@Nobukti and a.Urut=@Urut

      

      if not exists(select NoBukti from [36.64.152.3].[DBBCAGROUP].[dbo].[dbtransaksi] where NoBukti=@Nobukti and Urut=@Urut) 

      INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[dbtransaksi]

        ([NoBukti]

           ,[Tanggal]

           ,[Devisi]

           ,[Note]

           ,[Lampiran]

           ,[Perkiraan]

           ,[Lawan]

           ,[Keterangan]

           ,[Keterangan2]

           ,[Debet]

           ,[Kredit]

           ,[Valas]

           ,[Kurs]

           ,[DebetRp]

           ,[KreditRp]

           ,[TipeTrans]

           ,[TPHC]

           ,[CustSuppP]

           ,[CustSuppL]

           ,[Urut]

           ,[KodeP]

           ,[KodeL]

           ,[NoAktivaP]

           ,[NoAktivaL]

           ,[StatusAktivaP]

           ,[StatusAktivaL]

           ,[Nobon]

           ,[KodeBag]

           ,[StatusGiro]

           ,[FlagSimbol]

           ,[UserID]

           ,[NoBuktiAsl]

           ,[UrutAsl])

     select [NoBukti]

           ,[Tanggal]

           ,[Devisi]

           ,[Note]

           ,[Lampiran]

           ,[Perkiraan]

           ,[Lawan]

           ,[Keterangan]

           ,[Keterangan2]

           ,[Debet]

           ,[Kredit]

           ,[Valas]

           ,[Kurs]

           ,[DebetRp]

           ,[KreditRp]

           ,[TipeTrans]

           ,[TPHC]

           ,[CustSuppP]

           ,[CustSuppL]

           ,[Urut]

           ,[KodeP]

           ,[KodeL]

           ,[NoAktivaP]

           ,[NoAktivaL]

           ,[StatusAktivaP]

           ,[StatusAktivaL]

           ,[Nobon]

           ,[KodeBag]

           ,[StatusGiro]

           ,[FlagSimbol]

           ,[UserID]

           ,[NoBuktiAsl]

           ,[UrutAsl] from dbtransaksi where NoBukti=@Nobukti and Urut=@Urut

      

     update dbtransaksi set Tf=1 where NoBukti+CAST(Urut as varchar(3)) in 

         (select +CAST(Urut as varchar(3)) from [36.64.152.3].[DBBCAGROUP].[dbo].[dbtransaksi] where NoBukti=@Nobukti and Urut=@Urut) 

    else

   if @Do='D'

   delete [36.64.152.3].[DBBCAGROUP].[dbo].[dbtransaksi] where NoBukti=@Nobukti and Urut=@Urut

     delete TempDelDataDet where nobukti=@Nobukti and urut=@Urut and tabel='dbtransaksi'


 Fetch Next from MySinkronDet into @Nobukti,@Urut,@Do

 

     Close MySinkronDet

     Deallocate MySinkronDet



--dbhutpiut

Declare MySinkronDet Cursor for

   select nobukti,nomsk,Do from dbhutpiut where COALESCE(tf,0)=0 and devisi in ('03','04') 

   and ((Do<>'I' and 1=1) or (Do='I' and nobukti+Cast(nomsk as varchar(4)) not in (select nobukti+Cast(nomsk as varchar(4)) from [36.64.152.3].[DBBCAGROUP].[dbo].[dbhutpiut])))

   union all

   select Nobukti,urut,'D' from TempDelDataDet where tabel='dbhutpiut'

 Open MySinkronDet

 Fetch Next from MySinkronDet into @Nobukti,@Urut,@Do

 While @@fetch_Status=0

 if @Do='I'

   INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[dbhutpiut]

        ([NoFaktur]

           ,[NoRetur]

           ,[TipeTrans]

           ,[KodeCustSupp]

           ,[NoBukti]

           ,[NoMsk]

           ,[Urut]

           ,[Tanggal]

           ,[JatuhTempo]

           ,[Debet]

           ,[Kredit]

           ,[Valas]

           ,[Kurs]

           ,[DebetD]

           ,[KreditD]

           ,[KodeSales]

           ,[Tipe]

           ,[Perkiraan]

           ,[Catatan]

           ,[NOINVOICE]

           ,[TGLINVOICE]

           ,[NOPAJAK]

           ,[TGLFPJ]

           ,[KodeVls_]

           ,[Kurs_]

           ,[KursBayar]

           ,[FlagSimbol]

           ,[TipeBayar]

           ,[NoPelunasan]

           ,[PerkiraanKas]

           ,[TglButuh]

           ,[PerkiraanTBayar]

           ,[KBLB]

           ,[Devisi])

     select [NoFaktur]

           ,[NoRetur]

           ,[TipeTrans]

           ,[KodeCustSupp]

           ,[NoBukti]

           ,[NoMsk]

           ,[Urut]

           ,[Tanggal]

           ,[JatuhTempo]

           ,[Debet]

           ,[Kredit]

           ,[Valas]

           ,[Kurs]

           ,[DebetD]

           ,[KreditD]

           ,[KodeSales]

           ,[Tipe]

           ,[Perkiraan]

           ,[Catatan]

           ,[NOINVOICE]

           ,[TGLINVOICE]

           ,[NOPAJAK]

           ,[TGLFPJ]

           ,[KodeVls_]

           ,[Kurs_]

           ,[KursBayar]

           ,[FlagSimbol]

           ,[TipeBayar]

           ,[NoPelunasan]

           ,[PerkiraanKas]

           ,[TglButuh]

           ,[PerkiraanTBayar]

           ,[KBLB]

           ,[Devisi] from dbhutpiut where NoBukti=@Nobukti and NoMsk=@Urut

     update dbhutpiut set Tf=1 where NoBukti+CAST(NoMsk as varchar(3)) in 

         (select +CAST(NoMsk as varchar(3)) from [36.64.152.3].[DBBCAGROUP].[dbo].[dbhutpiut] where NoBukti=@Nobukti and NoMsk=@Urut) 

    else

   if @Do='U'

   Update [36.64.152.3].[DBBCAGROUP].[dbo].[dbhutpiut] set 

            [NoFaktur]=b.[NoFaktur]

           ,[NoRetur]=b.[NoRetur]

           ,[TipeTrans]=b.[TipeTrans]

           ,[KodeCustSupp]=b.[KodeCustSupp]

           ,[NoBukti]=b.[NoBukti]

           ,[NoMsk]=b.[NoMsk]

           ,[Urut]=b.[Urut]

           ,[Tanggal]=b.[Tanggal]

           ,[JatuhTempo]=b.[JatuhTempo]

           ,[Debet]=b.[Debet]

           ,[Kredit]=b.[Kredit]

           ,[Valas]=b.[Valas]

           ,[Kurs]=b.[Kurs]

           ,[DebetD]=b.[DebetD]

           ,[KreditD]=b.[KreditD]

           ,[KodeSales]=b.[KodeSales]

           ,[Tipe]=b.[Tipe]

           ,[Perkiraan]=b.[Perkiraan]

           ,[Catatan]=b.[Catatan]

           ,[NOINVOICE]=b.[NOINVOICE]

           ,[TGLINVOICE]=b.[TGLINVOICE]

           ,[NOPAJAK]=b.[TGLINVOICE]

           ,[TGLFPJ]=b.[TGLFPJ]

           ,[KodeVls_]=b.[KodeVls_]

           ,[Kurs_]=b.[Kurs_]

           ,[KursBayar]=b.[KursBayar]

           ,[FlagSimbol]=b.[FlagSimbol]

           ,[TipeBayar]=b.[TipeBayar]

           ,[NoPelunasan]=b.[NoPelunasan]

           ,[PerkiraanKas]=b.[PerkiraanKas]

           ,[TglButuh]=b.[TglButuh]

           ,[PerkiraanTBayar]=b.[PerkiraanTBayar]

           ,[KBLB]=b.[KBLB]

           ,[Devisi]=b.[Devisi]

      from [36.64.152.3].[DBBCAGROUP].[dbo].[dbhutpiut] a

      left outer join 

        (select [NoFaktur]

           ,[NoRetur]

           ,[TipeTrans]

           ,[KodeCustSupp]

           ,[NoBukti]

           ,[NoMsk]

           ,[Urut]

           ,[Tanggal]

           ,[JatuhTempo]

           ,[Debet]

           ,[Kredit]

           ,[Valas]

           ,[Kurs]

           ,[DebetD]

           ,[KreditD]

           ,[KodeSales]

           ,[Tipe]

           ,[Perkiraan]

           ,[Catatan]

           ,[NOINVOICE]

           ,[TGLINVOICE]

           ,[NOPAJAK]

           ,[TGLFPJ]

           ,[KodeVls_]

           ,[Kurs_]

           ,[KursBayar]

           ,[FlagSimbol]

           ,[TipeBayar]

           ,[NoPelunasan]

           ,[PerkiraanKas]

           ,[TglButuh]

           ,[PerkiraanTBayar]

           ,[KBLB]

           ,[Devisi]

     from dbhutpiut where NoBukti=@Nobukti and NoMsk=@Urut ) B on b.NoBukti=a.NoBukti and b.Nomsk=a.Nomsk where a.NoBukti=@Nobukti and a.Nomsk=@Urut

      

      if not exists(select NoBukti from [36.64.152.3].[DBBCAGROUP].[dbo].[dbhutpiut] where NoBukti=@Nobukti and NoMsk=@Urut) 

      INSERT INTO [36.64.152.3].[DBBCAGROUP].[dbo].[dbhutpiut]

        ([NoFaktur]

           ,[NoRetur]

           ,[TipeTrans]

           ,[KodeCustSupp]

           ,[NoBukti]

           ,[NoMsk]

           ,[Urut]

           ,[Tanggal]

           ,[JatuhTempo]

           ,[Debet]

           ,[Kredit]

           ,[Valas]

           ,[Kurs]

           ,[DebetD]

           ,[KreditD]

           ,[KodeSales]

           ,[Tipe]

           ,[Perkiraan]

           ,[Catatan]

           ,[NOINVOICE]

           ,[TGLINVOICE]

           ,[NOPAJAK]

           ,[TGLFPJ]

           ,[KodeVls_]

           ,[Kurs_]

           ,[KursBayar]

           ,[FlagSimbol]

           ,[TipeBayar]

           ,[NoPelunasan]

           ,[PerkiraanKas]

           ,[TglButuh]

           ,[PerkiraanTBayar]

           ,[KBLB]

           ,[Devisi])

     select [NoFaktur]

           ,[NoRetur]

           ,[TipeTrans]

           ,[KodeCustSupp]

           ,[NoBukti]

           ,[NoMsk]

           ,[Urut]

           ,[Tanggal]

           ,[JatuhTempo]

           ,[Debet]

           ,[Kredit]

           ,[Valas]

           ,[Kurs]

           ,[DebetD]

           ,[KreditD]

           ,[KodeSales]

           ,[Tipe]

           ,[Perkiraan]

           ,[Catatan]

           ,[NOINVOICE]

           ,[TGLINVOICE]

           ,[NOPAJAK]

           ,[TGLFPJ]

           ,[KodeVls_]

           ,[Kurs_]

           ,[KursBayar]

           ,[FlagSimbol]

           ,[TipeBayar]

           ,[NoPelunasan]

           ,[PerkiraanKas]

           ,[TglButuh]

           ,[PerkiraanTBayar]

           ,[KBLB]

           ,[Devisi] from dbhutpiut where NoBukti=@Nobukti and NoMsk=@Urut

      

     update dbhutpiut set Tf=1 where NoBukti+CAST(NoMsk as varchar(3)) in 

         (select +CAST(NoMsk as varchar(3)) from [36.64.152.3].[DBBCAGROUP].[dbo].[dbhutpiut] where NoBukti=@Nobukti and NoMsk=@Urut) 

    else

   if @Do='D'

   delete [36.64.152.3].[DBBCAGROUP].[dbo].[dbhutpiut] where NoBukti=@Nobukti and NoMsk=@Urut

     delete TempDelDataDet where nobukti=@Nobukti and urut=@Urut and tabel='dbhutpiut'


 Fetch Next from MySinkronDet into @Nobukti,@Urut,@Do

 

     Close MySinkronDet

     Deallocate MySinkronDet;

-- Sp_TIPETRANS
CREATE PROCEDURE IF NOT EXISTS Sp_TIPETRANS AS tran

if @choice='I'

insert into dbTipeTrans (KodeTipe, Nama, IsJasaBeliJual)

	values (@KodeTipe, @Keterangan, @Tipe)

	if @@error <> 0 goto jikasalah



if @choice='U'

update dbTipeTrans set Nama=@Keterangan ,KodeTipe=@KodeTipe, IsJasaBeliJual=@Tipe

   where KodeTipe=@OldKode

	if @@error <> 0 goto jikasalah



if @choice='D'

delete  dbTipeTrans where KodeTipe=@OldKode

	if @@error <> 0 goto jikasalah



commit tran

return

jikasalah:

	rollback tran

	raiserror('Proses Input Data Gagal',16,1)

	return;

-- Sp_Tolakan
CREATE PROCEDURE IF NOT EXISTS Sp_Tolakan AS -- DECLARE REMOVED,@NofakturTL varchar(30), @TanggalTL Datetime, 

        @JatuhtempoTL Datetime, @NobuktiTL varchar(30),@debetTL Numeric(18,2),@FSTL varchar(2),@Urut Int,

        @Nobukti varchar(30), @Tanggal Datetime, @DebetRp Numeric(18,2),@NoBM varchar(30),@UrutBM int

 -- IF EXISTS REMOVED
,1,1)='a' and NOPAJAK<>'')

 Declare myTL Cursor for

     select  a.Nofaktur,REPLACE(a.NoFaktur,Substring(SUBSTR(a.NoFaktur, LENGTH(a.NoFaktur)-2+1),1,1),'T'),b.Tanggal,b.Tanggal,a.NOPAJAK,COALESCE(c.kredit,0),'TL',b.Urut

     from DBHUTPIUT a

     left outer join dbTransaksi b on b.NoBukti=a.NOPAJAK 

     left outer join DBHUTPIUT c on c.NoBukti=b.Keterangan2 and c.NoFaktur=REPLACE(a.NoFaktur,SUBSTR(a.nofaktur, LENGTH(a.nofaktur)-2+1),'') and c.TipeTrans='L' and c.kredit<=b.debetrp

     where  Substring(SUBSTR(a.NoFaktur, LENGTH(a.NoFaktur)-2+1),1,1)='a' and a.NOPAJAK<>'' and b.TipeTrans='BBK' and b.FlagSimbol='TL' order by b.Nobukti,b.Urut,a.Nofaktur



   Open myTL

   Fetch Next from myTL into @Nofaktur, @NofakturTL, @TanggalTL, @JatuhtempoTL, @NobuktiTL,@debetTL,@FSTL,@Urut

   While @@fetch_Status=0

   -- IF EXISTS REMOVED
select @NofakturTL=REPLACE(NoFaktur,SUBSTR(NoFaktur, LENGTH(NoFaktur)-2+1),'')+'T'+cast(max(cast(Substring(SUBSTR(NoFaktur, LENGTH(NoFaktur)-1+1),1,1)as int))+1 as varchar(2)) 

                          from DBHUTPIUT where FlagSimbol='TL' and REPLACE(NoFaktur,SUBSTR(NoFaktur, LENGTH(NoFaktur)-2+1),'')=REPLACE(@NofakturTL,SUBSTR(@NofakturTL, LENGTH(@NofakturTL)-2+1),'') 

                          group by NoFaktur

     

     Update DBHUTPIUT set NoFaktur=@NofakturTL,Tanggal=@TanggalTL,JatuhTempo=@JatuhtempoTL,NoBukti=@NobuktiTL,Debet=@debetTL,FlagSimbol=@FSTL

     where NoFaktur=@Nofaktur and NOPAJAK in (select NoBukti from dbTransaksi where NoBukti=@NobuktiTL and Urut=@urut and TipeTrans='BBK' and FlagSimbol='TL')

      

     Fetch Next from myTL into @Nofaktur, @NofakturTL, @TanggalTL, @JatuhtempoTL, @NobuktiTL,@debetTL,@FSTL,@Urut

   

   Close myTL

   Deallocate myTL


   Declare myTLUM Cursor for

    select 'UM'+d.KodeCustSupp+'T1'NofakturTL,a.NoBukti,a.Tanggal,a.Urut,a.DebetRp,c.NoBukti NoBM,c.Urut UrutBM from dbTransaksi a

    left outer join DBHUTPIUT b on b.NoBukti=a.NoBukti and b.NoMsk=a.Urut

    left outer join dbTransaksi c on c.NoBukti=a.Keterangan2 and c.DebetRp=a.DebetRp

    left outer join DBHUTPIUT d on d.NoBukti=c.NoBukti and d.NoMsk=c.Urut

    where a.TipeTrans='BBK' and a.FlagSimbol='TL' and a.keterangan2<>'' and b.NoBukti is null and d.NoFaktur='Uang Muka'

    and a.NoBukti not in ('BCB/BBK/1016/00030B2','BCB/BBK/1116/00008B2','BCB/BBK/1116/00020B2','BCB/BBK/1116/00026B2')



   Open myTLUM

   Fetch Next from myTLUM into @NofakturTL, @Nobukti, @Tanggal, @Urut,@DebetRp,@NoBM,@UrutBM

   While @@fetch_Status=0

   -- IF EXISTS REMOVED
select @NofakturTL=REPLACE(NoFaktur,SUBSTR(NoFaktur, LENGTH(NoFaktur)-2+1),'')+'T'+cast(max(cast(Substring(SUBSTR(NoFaktur, LENGTH(NoFaktur)-1+1),1,1)as int))+1 as varchar(2)) 

                          from DBHUTPIUT where FlagSimbol='TL' and REPLACE(NoFaktur,SUBSTR(NoFaktur, LENGTH(NoFaktur)-2+1),'')=REPLACE(@NofakturTL,SUBSTR(@NofakturTL, LENGTH(@NofakturTL)-2+1),'') 

                          group by NoFaktur

     

   INSERT INTO [DBHUTPIUT]

           ([NoFaktur]

           ,[NoRetur]

           ,[TipeTrans]

           ,[KodeCustSupp]

           ,[NoBukti]

           ,[NoMsk]

           ,[Urut]

           ,[Tanggal]

           ,[JatuhTempo]

           ,[Debet]

           ,[Kredit]

           ,[Valas]

           ,[Kurs]

           ,[DebetD]

           ,[KreditD]

           ,[KodeSales]

           ,[Tipe]

           ,[Perkiraan]

           ,[Catatan]

           ,[NOINVOICE]

           ,[TGLINVOICE]

           ,[NOPAJAK]

           ,[TGLFPJ]

           ,[KodeVls_]

           ,[Kurs_]

           ,[KursBayar]

           ,[FlagSimbol]

           ,[TipeBayar]

           ,[NoPelunasan]

           ,[PerkiraanKas]

           ,[TglButuh]

           ,[PerkiraanTBayar]

           ,[KBLB])

  select @NofakturTL

           ,[NoRetur]

           ,'T'

           ,[KodeCustSupp]

           ,@Nobukti

           ,@Urut

           ,1

           ,@Tanggal

           ,@Tanggal

           ,@DebetRp

           ,0

           ,[Valas]

           ,[Kurs]

           ,[DebetD]

           ,[KreditD]

           ,[KodeSales]

           ,[Tipe]

           ,[Perkiraan]

           ,[Catatan]

           ,[NOINVOICE]

           ,[TGLINVOICE]

           ,@Nobukti

           ,[TGLFPJ]

           ,[KodeVls_]

           ,[Kurs_]

           ,[KursBayar]

           ,'TL'

           ,[TipeBayar]

           ,[NoPelunasan]

           ,[PerkiraanKas]

           ,[TglButuh]

           ,[PerkiraanTBayar]

           ,[KBLB] from DBHUTPIUT where nobukti=@NoBM and NoMsk=@UrutBM and NoBukti is not null

      

     Fetch Next from myTLUM into @NofakturTL, @Nobukti, @Tanggal, @Urut,@DebetRp,@NoBM,@UrutBM

   

   Close myTLUM

   Deallocate myTLUM;

-- sp_Transaksi
CREATE PROCEDURE IF NOT EXISTS sp_Transaksi AS Tran

-- DECLARE REMOVED,@NoFaktur Varchar(30)

Select @NoFaktur=NoFaktur from DBTempHUTPIUT where NoBukti=@Nobukti 

if @choice='I'

Select @Urut=MAX(urut) from dbTransaksi where NoBukti=@Nobukti and FlagSimbol<>'KB'

	-- SET REMOVEDISNULL(@urut,0)+1

	---

	Select @UrutKB=MAX(urut) from dbTransaksi where NoBukti=@Nobukti and FlagSimbol='KB'

	-- SET REMOVEDISNULL(@UrutKB,0)+1  

   	if not exists(select * from dbtrans Where NoBukti=@NoBukti) 

   	insert into dbTrans(NoBukti,NoUrut,tanggal,Note,Simbol, TipeTransHd,Tf,Do)

     	  values (@NoBukti, @NoUrut, @tanggal,@Note,@Simbol,@TipeTrans,0,@choice)

     	  --if @@Error<>0 Goto JikaSalah


 	insert into dbtransaksi (NoBukti, Tanggal, Devisi, Note, Lampiran, Perkiraan, Lawan, 

 	                         Keterangan, Keterangan2, Debet, Kredit, Valas, Kurs, DebetRp, 

 	                         KreditRp, TipeTrans, TPHC, CustSuppP, CustSuppL, Urut, 

 	                         NoAktivaP, NoAktivaL, StatusAktivaP, StatusAktivaL, Nobon, 

 	                         KodeBag, KodeP, kodeL,StatusGiro,FlagSimbol,Tf,Do)

 	values (@NoBukti, @Tanggal, @Devisi, @Note, @Lampiran, @Perkiraan, @Lawan, 

 	        COALESCE(@NoFaktur,'')+' '+@Keterangan, @Keterangan2, @Debet, @Kredit, @Valas, @Kurs, @DebetRp, 

 	        @KreditRp, @TipeTrans, @TPHC, @CustSuppP, @CustSuppL, @Urut, @NoAktivaP, 

 	        @NoAktivaL, @StatusAktivaP, @StatusAktivaL, @Nobon, @KodeBag, @KodeP, @kodeL,@Statusgiro,@FlagSimbol,0,@choice)


 	--if @@Error<>0 Goto JikaSalah


 	if @perkiraan<>'131' --and (@Perkiraan='331' or @Lawan='331')

 	insert into DBHUTPIUT (NoFaktur, NoRetur, TipeTrans, KodeCustSupp, NoBukti, NoMsk, Urut, Tanggal, JatuhTempo, Debet, Kredit, Valas, Kurs, DebetD, KreditD, KodeSales, Tipe, Perkiraan, Catatan,Devisi,Tf,Do)

	  select NoFaktur, NoRetur, TipeTrans, KodeCustSupp, NoBukti, NoMsk, Urut, Tanggal, JatuhTempo, Debet, Kredit, Valas, Kurs, DebetD, KreditD, KodeSales, Tipe, Perkiraan, Catatan,@Devisi,0,@choice

	  from DBTempHUTPIUT

	  where NoBukti=@Nobukti and NoMsk=case when @FlagSimbol='KB' Then @UrutKB else @Urut    and StatusUID in ('I','U')

	  --if @@Error<>0 Goto JikaSalah

 	  insert into DBHUTPIUT (NoFaktur, NoRetur, TipeTrans, KodeCustSupp, 

 		NoBukti, NoMsk, Urut, Tanggal, JatuhTempo, Debet, Kredit, Valas, Kurs, 

 		DebetD, KreditD, KodeSales, Tipe, Perkiraan, Catatan, NOINVOICE, KodeVls_, Kurs_,FlagSimbol,Devisi,Tf,Do)

	  select case when FlagSimbol='LB' then 'Lebih Bayar' else 'Tolakan Giro' , '', 'L', CustSuppP, 

		NoBukti, Urut, 1, Tanggal, Tanggal, 0,-1*Debet, Valas, Kurs, 

		0, -1*Debet, '','PT', '131', Keterangan, CustSuppP, Valas, Kurs,FlagSimbol,@Devisi,0,@choice

	  from dbTransaksi

	  where NoBukti=@Nobukti and Urut=@Urut and FlagSimbol in ('LB','TG') and CustSuppP in (select KODECUSTSUPP from DBCUSTSUPP where JENIS=1)

	 else

	insert into DBHUTPIUT (NoFaktur, NoRetur, TipeTrans, KodeCustSupp, NoBukti, NoMsk, Urut, Tanggal, JatuhTempo, Debet, Kredit, Valas, Kurs, DebetD, KreditD, KodeSales, Tipe, Perkiraan, Catatan, Devisi,Tf,Do)

	  select NoFaktur, NoRetur, TipeTrans, KodeCustSupp, NoBukti, NoMsk, Urut, Tanggal, JatuhTempo, 0, -1*Debet, Valas, Kurs, 0, -1*DebetD, KodeSales, Tipe, Perkiraan, Catatan, @Devisi,0,@choice

	  from DBTempHUTPIUT

	  where NoBukti=@Nobukti and NoMsk=case when @FlagSimbol='KB' Then @UrutKB else @Urut    and StatusUID in ('I','U')

	  --if @@Error<>0 Goto JikaSalah

 	  insert into DBHUTPIUT (NoFaktur, NoRetur, TipeTrans, KodeCustSupp, 

 		NoBukti, NoMsk, Urut, Tanggal, JatuhTempo, Debet, Kredit, Valas, Kurs, 

 		DebetD, KreditD, KodeSales, Tipe, Perkiraan, Catatan, NOINVOICE, KodeVls_, Kurs_,FlagSimbol,Devisi,Tf,Do)

	  select case when FlagSimbol='LB' then 'Lebih Bayar' else 'Tolakan Giro' , '', 'L', CustSuppP, 

		NoBukti, Urut, 1, Tanggal, Tanggal, 0,-1*Debet, Valas, Kurs, 

		0, -1*Debet, '','PT', '131', Keterangan, CustSuppP, Valas, Kurs,FlagSimbol,@Devisi,0,@choice

	  from dbTransaksi

	  where NoBukti=@Nobukti and Urut=@Urut and FlagSimbol in ('LB','TG') and CustSuppP in (select KODECUSTSUPP from DBCUSTSUPP where JENIS=1) 


	if @Lawan<>'331'

 	insert into DBHUTPIUT (NoFaktur, NoRetur, TipeTrans, KodeCustSupp, NoBukti, NoMsk, Urut, Tanggal, JatuhTempo, Debet, Kredit, Valas, Kurs, DebetD, KreditD, KodeSales, Tipe, Perkiraan, Catatan, Devisi,Tf,Do)

	  select NoFaktur, NoRetur, TipeTrans, KodeCustSupp, NoBukti, NoMsk, Urut, Tanggal, JatuhTempo, Debet, Kredit, Valas, Kurs, DebetD, KreditD, KodeSales, Tipe, Perkiraan, Catatan,@Devisi,0,@choice

	  from DBTempHUTPIUT

	  where NoBukti=@Nobukti and NoMsk=case when @FlagSimbol='KB' Then @UrutKB else @Urut    and StatusUID in ('I','U')

	  --if @@Error<>0 Goto JikaSalah

 	  insert into DBHUTPIUT (NoFaktur, NoRetur, TipeTrans, KodeCustSupp, 

 		NoBukti, NoMsk, Urut, Tanggal, JatuhTempo, Debet, Kredit, Valas, Kurs, 

 		DebetD, KreditD, KodeSales, Tipe, Perkiraan, Catatan, NOINVOICE, KodeVls_, Kurs_,FlagSimbol,Devisi,Tf,Do)

	  select case when FlagSimbol='LB' then 'Lebih Bayar' else 'Tolakan Giro' , '', 'L', CustSuppP, 

		NoBukti, Urut, 1, Tanggal, Tanggal, -1*Debet,0, Valas, Kurs, 

		-1*Debet, 0, '','HT', '331', Keterangan, CustSuppP, Valas, Kurs,FlagSimbol,@Devisi,0,@choice

	  from dbTransaksi

	  where NoBukti=@Nobukti and Urut=@Urut and FlagSimbol in ('LB','TG')  and CustSuppP in (select KODECUSTSUPP from DBCUSTSUPP where JENIS=0)

	 else

	insert into DBHUTPIUT (NoFaktur, NoRetur, TipeTrans, KodeCustSupp, NoBukti, NoMsk, Urut, Tanggal, JatuhTempo, Debet, Kredit, Valas, Kurs, DebetD, KreditD, KodeSales, Tipe, Perkiraan, Catatan,Devisi,Tf,Do)

	  select NoFaktur, NoRetur, TipeTrans, KodeCustSupp, NoBukti, NoMsk, Urut, Tanggal, JatuhTempo, 0, -1*Debet, Valas, Kurs, 0, -1*DebetD, KodeSales, Tipe, Perkiraan, Catatan,@Devisi,0,@choice

	  from DBTempHUTPIUT

	  where NoBukti=@Nobukti and NoMsk=case when @FlagSimbol='KB' Then @UrutKB else @Urut    and StatusUID in ('I','U')

	  --if @@Error<>0 Goto JikaSalah

 	  insert into DBHUTPIUT (NoFaktur, NoRetur, TipeTrans, KodeCustSupp, 

 		NoBukti, NoMsk, Urut, Tanggal, JatuhTempo, Debet, Kredit, Valas, Kurs, 

 		DebetD, KreditD, KodeSales, Tipe, Perkiraan, Catatan, NOINVOICE, KodeVls_, Kurs_,FlagSimbol, Devisi,Tf,Do)

	  select case when FlagSimbol='LB' then 'Lebih Bayar' else 'Tolakan Giro' , '', 'L', CustSuppP, 

		NoBukti, Urut, 1, Tanggal, Tanggal, -1*Debet,0, Valas, Kurs, 

		-1*Debet, 0, '','HT', '331', Keterangan, CustSuppP, Valas, Kurs,FlagSimbol,@Devisi,0,@choice

	  from dbTransaksi

	  where NoBukti=@Nobukti and Urut=@Urut and FlagSimbol in ('LB','TG')  and CustSuppP in (select KODECUSTSUPP from DBCUSTSUPP where JENIS=0)


if @choice='U'

Update dbtransaksi set Tanggal=@Tanggal, Devisi=@Devisi, Note=@Note, 

 	                       Lampiran=@Lampiran, Perkiraan=@Perkiraan, Lawan=@Lawan, 

 	                       Keterangan=COALESCE(@NoFaktur,'')+' '+@Keterangan, Keterangan2=@Keterangan2, 

 	                       Debet=@Debet, Kredit=@Kredit, Valas=@Valas, 

 	                       Kurs=@Kurs, DebetRp=@DebetRp, KreditRp=@KreditRp, 

 	                       TipeTrans=@TipeTrans, TPHC=@TPHC, CustSuppP=@CustSuppP, 

 	                       CustSuppL=@CustSuppL, Urut=@Urut, NoAktivaP=@NoAktivaP, 

 	                       NoAktivaL=@NoAktivaL, StatusAktivaP=@StatusAktivaP, 

 	                       StatusAktivaL=@StatusAktivaL, Nobon=@Nobon, Kodebag=@KodeBag,

 	                       KodeP=@KodeP, KodeL=@KodeL, StatusGiro=@Statusgiro,Tf=0,Do=@Choice 

 	where nobukti=@nobukti  and urut=@urut

 	--if @@Error<>0 Goto JikaSalah

 	delete DBHUTPIUT

 	from DBHUTPIUT A

 	left outer join DBTempHUTPIUT B on B.NoFaktur=A.NoFaktur and B.KodeCustSupp=A.KodeCustSupp and B.Perkiraan=A.Perkiraan

 		and B.NoBukti=A.NoBukti and B.NoMsk=A.NoMsk and B.Urut=A.Urut

 	where	B.NoBukti=@Nobukti and B.NoMsk=@Urut and B.StatusUID in ('D','U')

 	insert TempDelDataDet

    select @Nobukti,@Urut,'DBHUTPIUT'

 	--if @@Error<>0 Goto JikaSalah

 	if @perkiraan<>'131'

 	insert into DBHUTPIUT (NoFaktur, NoRetur, TipeTrans, KodeCustSupp, NoBukti, NoMsk, Urut, Tanggal, JatuhTempo, Debet, Kredit, Valas, Kurs, DebetD, KreditD, KodeSales, Tipe, Perkiraan, Catatan,Devisi,Tf,Do)

	  select NoFaktur, NoRetur, TipeTrans, KodeCustSupp, NoBukti, NoMsk, Urut, Tanggal, JatuhTempo, Debet, Kredit, Valas, Kurs, DebetD, KreditD, KodeSales, Tipe, Perkiraan, Catatan,@Devisi,0,@choice

	  from DBTempHUTPIUT

	  where NoBukti=@Nobukti and NoMsk=@Urut and StatusUID in ('I','U')

	

	else

	insert into DBHUTPIUT (NoFaktur, NoRetur, TipeTrans, KodeCustSupp, NoBukti, NoMsk, Urut, Tanggal, JatuhTempo, Debet, Kredit, Valas, Kurs, DebetD, KreditD, KodeSales, Tipe, Perkiraan, Catatan, Devisi,Tf,Do)

	  select NoFaktur, NoRetur, TipeTrans, KodeCustSupp, NoBukti, NoMsk, Urut, Tanggal, JatuhTempo, 0, -1*Debet, Valas, Kurs, 0, -1*DebetD, KodeSales, Tipe, Perkiraan, Catatan,@Devisi,0,@choice

	  from DBTempHUTPIUT

	  where NoBukti=@Nobukti and NoMsk=@Urut and StatusUID in ('I','U')

	

	--if @@Error<>0 Goto JikaSalah



if @choice='D'

delete dbtransaksi where nobukti=@nobukti and --Urut=@Urut 

   ((urut=@urut and NoBukti not like '%HJS%') or (Devisi=@Devisi and NoBukti like '%HJS%')) 

 	and FlagSimbol=@FlagSimbol

 	insert TempDelDataDet

    select @Nobukti,@Urut,'dbtransaksi'	

 	if @@Error<>0 Goto JikaSalah

 	delete DBHUTPIUT where NoBukti=@Nobukti and NoMsk=@Urut and FlagSimbol=@FlagSimbol

 	insert TempDelDataDet

    select @Nobukti,@Urut,'DBHUTPIUT'

 	if @@Error<>0 Goto JikaSalah

 	if not exists( select nobukti from dbtransaksi where nobukti=@nobukti)

 	delete dbTrans where nobukti=@nobukti

  		insert TempDelData

        select @Nobukti,'DBTRANS'

  		if @@Error<>0 Goto JikaSalah 


Commit Tran

Return

JikaSalah: RollBack Tran

           Return;

-- sp_TransaksiKasBank
CREATE PROCEDURE IF NOT EXISTS sp_TransaksiKasBank AS Tran

-- DECLARE REMOVED,@NoUrutKG Varchar(5),@prd varchar(8),@NoBuktiKG Varchar(30)

if @choice='I'

Select @Urut=MAX(urut) from dbTransaksi where NoBukti=@Nobukti and FlagSimbol<>'KB'

	-- SET REMOVEDISNULL(@urut,0)+1  

	---

	Select @UrutKB=MAX(urut) from dbTransaksi where NoBukti=@Nobukti and FlagSimbol='KB'

	-- SET REMOVEDISNULL(@UrutKB,0)+1  

   	if not exists(select * from dbtrans Where NoBukti=@NoBukti) 

   	insert into dbTrans(NoBukti,NoUrut,tanggal,Note,Simbol, TipeTransHd, PerkiraanHd,Lampiran,Tf,Do)

     	  values (@NoBukti, @NoUrut, @tanggal,@Note,@Simbol,@TipeTrans,@PerkiraanHd,@Lampiran,0,@choice)

     	  if @@Error<>0 Goto JikaSalah

   	

 	insert into dbtransaksi (NoBukti, Tanggal, Devisi, Note, Lampiran, Perkiraan, Lawan, 

 	                         Keterangan, Keterangan2, Debet, Kredit, Valas, Kurs, DebetRp, 

 	                         KreditRp, TipeTrans, TPHC, CustSuppP, CustSuppL, Urut, 

 	                         NoAktivaP, NoAktivaL, StatusAktivaP, StatusAktivaL, Nobon, 

 	                         KodeBag, KodeP, kodeL,StatusGiro,FlagSimbol,UserID,Tf,Do)

 	values (@NoBukti, @Tanggal, @Devisi, @Note, @Lampiran, @Perkiraan, @Lawan, 

 	        @Keterangan, @Keterangan2, @Debet, @Kredit, @Valas, @Kurs, @DebetRp, 

 	        @KreditRp, @TipeTrans, @TPHC, @CustSuppP, @CustSuppL, case when @FlagSimbol='KB' Then @UrutKB else @Urut  , @NoAktivaP, 

 	        @NoAktivaL, @StatusAktivaP, @StatusAktivaL, @Nobon, @KodeBag, @KodeP, @kodeL,@Statusgiro,@FlagSimbol,@UserID,0,@choice)

 	if @@Error<>0 Goto JikaSalah


 	insert into DBHUTPIUT (NoFaktur, NoRetur, TipeTrans, KodeCustSupp, 

 		NoBukti, NoMsk, Urut, Tanggal, JatuhTempo, Debet, Kredit, Valas, Kurs, 

 		DebetD, KreditD, KodeSales, Tipe, Perkiraan, Catatan, NOINVOICE, KodeVls_, Kurs_,FlagSimbol,Devisi,Tf,Do)

	select NoFaktur, NoRetur, TipeTrans, KodeCustSupp, 

		NoBukti, NoMsk, Urut, Tanggal, JatuhTempo, Debet, Kredit, Valas, Kurs, 

		DebetD, KreditD, KodeSales, Tipe, Perkiraan, Catatan, NoInvoice, Valas_, Kurs_,FlagSimbol,@Devisi,0,@choice

	from DBTempHUTPIUT

	where NoBukti=@Nobukti and NoMsk=case when @FlagSimbol='KB' Then @UrutKB else @Urut    and StatusUID in ('I','U')

	

	update dbTransaksi set Perkiraan=b.PerkiraanHd,Tf=0,Do=@Choice from dbTransaksi a

    left outer join DBTRANS b on b.NoBukti=a.NoBukti where a.NoBukti=@Nobukti and a.urut=@urut and a.FlagSimbol='LB' and a.Perkiraan='807'

    update dbTransaksi set Lawan=b.PerkiraanHd,Tf=0,Do=@Choice from dbTransaksi a

    left outer join DBTRANS b on b.NoBukti=a.NoBukti where a.NoBukti=@nobukti and a.urut=@urut and a.FlagSimbol='LB' and a.Lawan='807'

    

 	insert into DBHUTPIUT (NoFaktur, NoRetur, TipeTrans, KodeCustSupp, 

 		NoBukti, NoMsk, Urut, Tanggal, JatuhTempo, Debet, Kredit, Valas, Kurs, 

 		DebetD, KreditD, KodeSales, Tipe, Perkiraan, Catatan, NOINVOICE, KodeVls_, Kurs_,FlagSimbol,devisi,Tf,Do)

	select 'Lebih Bayar', '', 'L', CustSuppP, 

		NoBukti, Urut, 1, Tanggal, Tanggal, 0,-1*Debet, Valas, Kurs, 

		0, -1*Debet, '','PT', '131', Keterangan, CustSuppP, Valas, Kurs,FlagSimbol,@Devisi,0,@choice

	from dbTransaksi

	where NoBukti=@Nobukti and Urut=@Urut and FlagSimbol in ('LB')

	

	update dbTransaksi set FlagSimbol='TL',Tf=0,Do=@Choice from dbTransaksi where NoBukti=@Nobukti and Urut=@Urut and TipeTrans='BBK' and Keterangan2 like '%/BBM/%'

	

	-- IF EXISTS REMOVED
select @NoUrutKG=case when (NOURUT+1) between 0 and 9 then '0000'+Cast((NOURUT+1) as varchar(3))

   	         when (NOURUT+1) between 10 and 99 then '000'+Cast((NOURUT+1) as varchar(3))

   	         when (NOURUT+1) between 100 and 999 then '00'+Cast((NOURUT+1) as varchar(3))

   	         when (NOURUT+1) between 1000 and 9999 then '0'+Cast((NOURUT+1) as varchar(3)) else Cast((NOURUT+1) as varchar(3))   

   	  from (

	    select COALESCE(MAX(NoUrut),0) NoUrut from dbTrans where month(Tanggal)=MONTH(@Tanggal) and year(Tanggal)=year(@Tanggal) 

	    and TipeTransHD in ('BKK','BKM') and Simbol='KG' ) A

    

      if MONTH(@Tanggal)<10 

        select @prd='/0'+cast(MONTH(@Tanggal) as varchar(1))+SUBSTR(cast(year(@Tanggal) as varchar(4)), LENGTH(cast(year(@Tanggal) as varchar(4)))-2+1)

        else

        select @prd='/'+cast(MONTH(@Tanggal) as varchar(2))+SUBSTR(cast(year(@Tanggal) as varchar(4)), LENGTH(cast(year(@Tanggal) as varchar(4)))-2+1)

    

      if @Devisi='01'

        select @NoBuktiKG='BCA/BKK'+@prd+'/'+@NoUrutKG+'KG'

        else

        select @NoBuktiKG='CA/BKK'+@prd+'/'+@NoUrutKG+'KG'

       

      insert into dbTrans(NoBukti,NoUrut,tanggal,Note,Simbol, TipeTransHd, PerkiraanHd,Lampiran,Tf,Do)

      select @NoBuktiKG,@NoUrutKG,a.tanggal,a.Note,'KG','BKK','102',a.Lampiran,0,@choice

      from DBTRANS a

      left outer join dbTransaksi b on b.NoBukti=a.NoBukti

      where b.NoBukti=@Nobukti and b.Urut=@Urut and b.TipeTrans='BBK' and b.FlagSimbol='TL' and b.Keterangan2 like '%/BBM/%'

       

	  insert into dbtransaksi (NoBukti, Tanggal, Devisi, Note, Lampiran, Perkiraan, Lawan, 

 	                         Keterangan, Keterangan2, Debet, Kredit, Valas, Kurs, DebetRp, 

 	                         KreditRp, TipeTrans, TPHC, CustSuppP, CustSuppL, Urut, 

 	                         NoAktivaP, NoAktivaL, StatusAktivaP, StatusAktivaL, Nobon, 

 	                         KodeBag, KodeP, kodeL,StatusGiro,FlagSimbol,UserID,NoBuktiAsl,UrutAsl,Tf,Do)

 	  select @NoBuktiKG, Tanggal, Devisi, Note, Lampiran, '131', '102', 

 	                         Keterangan, '' Keterangan2, Debet, Kredit, Valas, Kurs, DebetRp, 

 	                         KreditRp, 'BKK', TPHC, CustSuppP, CustSuppL, 1, 

 	                         NoAktivaP, NoAktivaL, StatusAktivaP, StatusAktivaL, Nobon, 

 	                         KodeBag, KodeP, kodeL,StatusGiro,'',UserID,@NoBukti,@Urut,0,@choice

      from dbtransaksi where NoBukti=@Nobukti and Urut=@Urut and TipeTrans='BBK' and FlagSimbol='TL' and Keterangan2 like '%/BBM/%'                         


    -- IF EXISTS REMOVED
) in 

               (select NoBukti+CAST(NoMsk as varchar(3)) from DBHUTPIUT where Tipe='PT' and TipeTrans='L' and left(SUBSTR(NoFaktur, LENGTH(NoFaktur)-2+1),1)='T'  )) 

   	select @NoUrutKG=case when (NOURUT+1) between 0 and 9 then '0000'+Cast((NOURUT+1) as varchar(3))

   	         when (NOURUT+1) between 10 and 99 then '000'+Cast((NOURUT+1) as varchar(3))

   	         when (NOURUT+1) between 100 and 999 then '00'+Cast((NOURUT+1) as varchar(3))

   	         when (NOURUT+1) between 1000 and 9999 then '0'+Cast((NOURUT+1) as varchar(3)) else Cast((NOURUT+1) as varchar(3))   

   	  from (

	    select COALESCE(MAX(NoUrut),0) NoUrut from dbTrans where month(Tanggal)=MONTH(@Tanggal) and year(Tanggal)=year(@Tanggal) 

	    and TipeTransHD in ('BKK','BKM') and Simbol='KG') A

    

      if MONTH(@Tanggal)<10 

        select @prd='/0'+cast(MONTH(@Tanggal) as varchar(1))+SUBSTR(cast(year(@Tanggal) as varchar(4)), LENGTH(cast(year(@Tanggal) as varchar(4)))-2+1)

        else

        select @prd='/'+cast(MONTH(@Tanggal) as varchar(2))+SUBSTR(cast(year(@Tanggal) as varchar(4)), LENGTH(cast(year(@Tanggal) as varchar(4)))-2+1)

    

      if @Devisi='01'

        select @NoBuktiKG='BCA/BKM'+@prd+'/'+@NoUrutKG+'KG'

        else

        select @NoBuktiKG='CA/BKM'+@prd+'/'+@NoUrutKG+'KG'

       

      insert into dbTrans(NoBukti,NoUrut,tanggal,Note,Simbol, TipeTransHd, PerkiraanHd,Lampiran,Tf,Do)

      select @NoBuktiKG,@NoUrutKG,a.tanggal,a.Note,'KG','BKM','102',a.Lampiran,0,@choice

      from DBTRANS a

      left outer join dbTransaksi b on b.NoBukti=a.NoBukti

      where b.NoBukti=@Nobukti and b.Urut=@Urut and b.TipeTrans='BBM' and b.NoBukti+CAST(b.Urut as varchar(3)) in 

               (select NoBukti+CAST(NoMsk as varchar(3)) from DBHUTPIUT where Tipe='PT' and TipeTrans='L' and left(SUBSTR(NoFaktur, LENGTH(NoFaktur)-2+1),1)='T'  )

       

	  insert into dbtransaksi (NoBukti, Tanggal, Devisi, Note, Lampiran, Perkiraan, Lawan, 

 	                         Keterangan, Keterangan2, Debet, Kredit, Valas, Kurs, DebetRp, 

 	                         KreditRp, TipeTrans, TPHC, CustSuppP, CustSuppL, Urut, 

 	                         NoAktivaP, NoAktivaL, StatusAktivaP, StatusAktivaL, Nobon, 

 	                         KodeBag, KodeP, kodeL,StatusGiro,FlagSimbol,UserID,NoBuktiAsl,UrutAsl,Tf,Do)

 	  select @NoBuktiKG, Tanggal, Devisi, Note, Lampiran, '102', '135', 

 	                         Keterangan, '' Keterangan2, Debet, Kredit, Valas, Kurs, DebetRp, 

 	                         KreditRp, 'BKM', TPHC, CustSuppP, '', 1, 

 	                         NoAktivaP, NoAktivaL, StatusAktivaP, '', Nobon, 

 	                         KodeBag, KodeP, '',StatusGiro,'',UserID,@NoBukti,@Urut,0,@choice

      from dbtransaksi where NoBukti=@Nobukti and Urut=@Urut and TipeTrans='BBM' and NoBukti+CAST(Urut as varchar(3)) in 

               (select NoBukti+CAST(NoMsk as varchar(3)) from DBHUTPIUT where Tipe='PT' and TipeTrans='L' and left(SUBSTR(NoFaktur, LENGTH(NoFaktur)-2+1),1)='T'  )


	if @@Error<>0 Goto JikaSalah



if @choice='U'

Update dbTrans Set Lampiran=@Lampiran,Tf=0,Do=@Choice where NoBukti=@Nobukti

 	Update dbtransaksi set Tanggal=@Tanggal, Devisi=@Devisi, Note=@Note, 

 	                       Lampiran=@Lampiran, Perkiraan=@Perkiraan, Lawan=@Lawan, 

 	                       Keterangan=@Keterangan, Keterangan2=@Keterangan2, 

 	                       Debet=@Debet, Kredit=@Kredit, Valas=@Valas, 

 	                       Kurs=@Kurs, DebetRp=@DebetRp, KreditRp=@KreditRp, 

 	                       TipeTrans=@TipeTrans, TPHC=@TPHC, CustSuppP=@CustSuppP, 

 	                       CustSuppL=@CustSuppL, Urut=@Urut, NoAktivaP=@NoAktivaP, 

 	                       NoAktivaL=@NoAktivaL, StatusAktivaP=@StatusAktivaP, 

 	                       StatusAktivaL=@StatusAktivaL, Nobon=@Nobon, Kodebag=@KodeBag,

 	                       KodeP=@KodeP, KodeL=@KodeL, StatusGiro=@Statusgiro,FlagSimbol=@FlagSimbol,Tf=0,Do=@Choice--,

 	                       --UserID=@UserID 

 	where nobukti=@nobukti  and urut=case when @FlagSimbol='KB' Then @UrutKB else @urut 

 	if @@Error<>0 Goto JikaSalah

 	delete DBHUTPIUT

 	from DBHUTPIUT A

 	left outer join DBTempHUTPIUT B on B.NoFaktur=A.NoFaktur and B.KodeCustSupp=A.KodeCustSupp and B.Perkiraan=A.Perkiraan

 		and B.NoBukti=A.NoBukti and B.NoMsk=A.NoMsk and B.Urut=A.Urut

 	where	B.NoBukti=@Nobukti and B.NoMsk=@Urut and B.StatusUID in ('D','U')

 	insert TempDelDataDet

    select @Nobukti,@Urut,'DBHUTPIUT'

 	if @@Error<>0 Goto JikaSalah

 	insert into DBHUTPIUT (NoFaktur, NoRetur, TipeTrans, KodeCustSupp, 

 		NoBukti, NoMsk, Urut, Tanggal, JatuhTempo, Debet, Kredit, Valas, Kurs, 

 		DebetD, KreditD, KodeSales, Tipe, Perkiraan, Catatan, NOINVOICE, KodeVls_, Kurs_,Devisi,Tf,Do)

	select NoFaktur, NoRetur, TipeTrans, KodeCustSupp, 

		NoBukti, NoMsk, Urut, Tanggal, JatuhTempo, Debet, Kredit, Valas, Kurs, 

		DebetD, KreditD, KodeSales, Tipe, Perkiraan, Catatan, NoInvoice, Valas_, Kurs_,@Devisi,0,@choice

	from DBTempHUTPIUT

	where NoBukti=@Nobukti and NoMsk=@Urut and StatusUID in ('I','U')

	if @@Error<>0 Goto JikaSalah

	

	-- IF EXISTS REMOVED
delete DBTRANS where NoBukti in (select NoBukti from dbTransaksi where NoBuktiasl=@NoBukti and Urutasl=@Urut)

   	  insert TempDelData

      select @Nobukti,'DBTRANS'

   	  select @NoUrutKG=case when (NOURUT+1) between 0 and 9 then '0000'+Cast((NOURUT+1) as varchar(3))

   	         when (NOURUT+1) between 10 and 99 then '000'+Cast((NOURUT+1) as varchar(3))

   	         when (NOURUT+1) between 100 and 999 then '00'+Cast((NOURUT+1) as varchar(3))

   	         when (NOURUT+1) between 1000 and 9999 then '0'+Cast((NOURUT+1) as varchar(3)) else Cast((NOURUT+1) as varchar(3))   

   	  from (

	    select COALESCE(MAX(NoUrut),0) NoUrut from dbTrans where month(Tanggal)=MONTH(@Tanggal) and year(Tanggal)=year(@Tanggal) 

	    and TipeTransHD in ('BKK','BKM') and Simbol='KG' ) A

    

      if MONTH(@Tanggal)<10 

        select @prd='/0'+cast(MONTH(@Tanggal) as varchar(1))+SUBSTR(cast(year(@Tanggal) as varchar(4)), LENGTH(cast(year(@Tanggal) as varchar(4)))-2+1)

        else

        select @prd='/'+cast(MONTH(@Tanggal) as varchar(2))+SUBSTR(cast(year(@Tanggal) as varchar(4)), LENGTH(cast(year(@Tanggal) as varchar(4)))-2+1)

    

      if @Devisi='01'

        select @NoBuktiKG='BCA/BKK'+@prd+'/'+@NoUrutKG+'KG'

        else

        select @NoBuktiKG='CA/BKK'+@prd+'/'+@NoUrutKG+'KG'

       

      insert into dbTrans(NoBukti,NoUrut,tanggal,Note,Simbol, TipeTransHd, PerkiraanHd,Lampiran,Tf,Do)

      select @NoBuktiKG,@NoUrutKG,a.tanggal,a.Note,'KG','BKK','102',a.Lampiran,0,@choice

      from DBTRANS a

      left outer join dbTransaksi b on b.NoBukti=a.NoBukti

      where b.NoBukti=@Nobukti and b.Urut=@Urut and b.TipeTrans='BBK' and b.FlagSimbol='TL' and b.Keterangan2 like '%/BBM/%'

       

	  insert into dbtransaksi (NoBukti, Tanggal, Devisi, Note, Lampiran, Perkiraan, Lawan, 

 	                         Keterangan, Keterangan2, Debet, Kredit, Valas, Kurs, DebetRp, 

 	                         KreditRp, TipeTrans, TPHC, CustSuppP, CustSuppL, Urut, 

 	                         NoAktivaP, NoAktivaL, StatusAktivaP, StatusAktivaL, Nobon, 

 	                         KodeBag, KodeP, kodeL,StatusGiro,FlagSimbol,UserID,NoBuktiAsl,UrutAsl,Tf,Do)

 	  select @NoBuktiKG, Tanggal, Devisi, Note, Lampiran, '131', '102', 

 	                         Keterangan, '' Keterangan2, Debet, Kredit, Valas, Kurs, DebetRp, 

 	                         KreditRp, 'BKK', TPHC, CustSuppP, CustSuppL, 1, 

 	                         NoAktivaP, NoAktivaL, StatusAktivaP, StatusAktivaL, Nobon, 

 	                         KodeBag, KodeP, kodeL,StatusGiro,'',UserID,@NoBukti,@Urut,0,@choice

      from dbtransaksi where NoBukti=@Nobukti and Urut=@Urut and TipeTrans='BBK' and FlagSimbol='TL' and Keterangan2 like '%/BBM/%'                         


    -- IF EXISTS REMOVED
) in 

               (select NoBukti+CAST(NoMsk as varchar(3)) from DBHUTPIUT where Tipe='PT' and TipeTrans='L' and left(SUBSTR(NoFaktur, LENGTH(NoFaktur)-2+1),1)='T'  )) 

   	delete DBTRANS where NoBukti in (select NoBukti from dbTransaksi where NoBuktiasl=@NoBukti and Urutasl=@Urut)

   	  insert TempDelData

      select @Nobukti,'DBTRANS'

   	  select @NoUrutKG=case when (NOURUT+1) between 0 and 9 then '0000'+Cast((NOURUT+1) as varchar(3))

   	         when (NOURUT+1) between 10 and 99 then '000'+Cast((NOURUT+1) as varchar(3))

   	         when (NOURUT+1) between 100 and 999 then '00'+Cast((NOURUT+1) as varchar(3))

   	         when (NOURUT+1) between 1000 and 9999 then '0'+Cast((NOURUT+1) as varchar(3)) else Cast((NOURUT+1) as varchar(3))   

   	  from (

	    select COALESCE(MAX(NoUrut),0) NoUrut from dbTrans where month(Tanggal)=MONTH(@Tanggal) and year(Tanggal)=year(@Tanggal) 

	    and TipeTransHD in ('BKK','BKM') and Simbol='KG') A

    

      if MONTH(@Tanggal)<10 

        select @prd='/0'+cast(MONTH(@Tanggal) as varchar(1))+SUBSTR(cast(year(@Tanggal) as varchar(4)), LENGTH(cast(year(@Tanggal) as varchar(4)))-2+1)

        else

        select @prd='/'+cast(MONTH(@Tanggal) as varchar(2))+SUBSTR(cast(year(@Tanggal) as varchar(4)), LENGTH(cast(year(@Tanggal) as varchar(4)))-2+1)

    

      if @Devisi='01'

        select @NoBuktiKG='BCA/BKM'+@prd+'/'+@NoUrutKG+'KG'

        else

        select @NoBuktiKG='CA/BKM'+@prd+'/'+@NoUrutKG+'KG'

       

      insert into dbTrans(NoBukti,NoUrut,tanggal,Note,Simbol, TipeTransHd, PerkiraanHd,Lampiran,Tf,Do)

      select @NoBuktiKG,@NoUrutKG,a.tanggal,a.Note,'KG','BKM','102',a.Lampiran,0,@choice

      from DBTRANS a

      left outer join dbTransaksi b on b.NoBukti=a.NoBukti

      where b.NoBukti=@Nobukti and b.Urut=@Urut and b.TipeTrans='BBM' and b.NoBukti+CAST(b.Urut as varchar(3)) in 

               (select NoBukti+CAST(NoMsk as varchar(3)) from DBHUTPIUT where Tipe='PT' and TipeTrans='L' and left(SUBSTR(NoFaktur, LENGTH(NoFaktur)-2+1),1)='T'  )

       

	  insert into dbtransaksi (NoBukti, Tanggal, Devisi, Note, Lampiran, Perkiraan, Lawan, 

 	                         Keterangan, Keterangan2, Debet, Kredit, Valas, Kurs, DebetRp, 

 	                         KreditRp, TipeTrans, TPHC, CustSuppP, CustSuppL, Urut, 

 	                         NoAktivaP, NoAktivaL, StatusAktivaP, StatusAktivaL, Nobon, 

 	                         KodeBag, KodeP, kodeL,StatusGiro,FlagSimbol,UserID,NoBuktiAsl,UrutAsl,Tf,Do)

 	  select @NoBuktiKG, Tanggal, Devisi, Note, Lampiran, '102', '135', 

 	                         Keterangan, '' Keterangan2, Debet, Kredit, Valas, Kurs, DebetRp, 

 	                         KreditRp, 'BKM', TPHC, CustSuppP, '', 1, 

 	                         NoAktivaP, NoAktivaL, StatusAktivaP, '', Nobon, 

 	                         KodeBag, KodeP, '',StatusGiro,'',UserID,@NoBukti,@Urut,0,@choice

      from dbtransaksi where NoBukti=@Nobukti and Urut=@Urut and TipeTrans='BBM' and NoBukti+CAST(Urut as varchar(3)) in 

               (select NoBukti+CAST(NoMsk as varchar(3)) from DBHUTPIUT where Tipe='PT' and TipeTrans='L' and left(SUBSTR(NoFaktur, LENGTH(NoFaktur)-2+1),1)='T'  )

   	

    if @@Error<>0 Goto JikaSalah



if @choice='D'

delete DBTRANS where NoBukti in (select NoBukti from dbTransaksi where NoBuktiasl=@NoBukti and Urutasl=@Urut)

    insert TempDelData

    select @Nobukti,'DBTRANS'

 	delete dbtransaksi where nobukti=@nobukti and urut=@urut and FlagSimbol=@FlagSimbol

  	insert TempDelDataDet

    select @Nobukti,@Urut,'dbtransaksi'	

 	if @@Error<>0 Goto JikaSalah

 	delete DBHUTPIUT where NoBukti=@Nobukti and NoMsk=@Urut and FlagSimbol=@FlagSimbol

 	insert TempDelDataDet

    select @Nobukti,@Urut,'DBHUTPIUT'

 	if @@Error<>0 Goto JikaSalah

 	if not exists( select nobukti from dbtransaksi where nobukti=@nobukti)

 	delete dbTrans where nobukti=@nobukti

  		insert TempDelData

        select @Nobukti,'DBTRANS'

  		if @@Error<>0 Goto JikaSalah 


Commit Tran

Return

JikaSalah: RollBack Tran

           Return;

-- sp_TransaksiKasBankOld
CREATE PROCEDURE IF NOT EXISTS sp_TransaksiKasBankOld AS Tran

-- DECLARE REMOVED,@NoFaktur Varchar(30)

Select @NoFaktur=NoFaktur from DBTempHUTPIUT where NoBukti=@Nobukti 

if @choice='I'

Select @Urut=MAX(urut) from dbTransaksi where NoBukti=@Nobukti and FlagSimbol<>'KB'

	-- SET REMOVEDISNULL(@urut,0)+1  

	---

	Select @UrutKB=MAX(urut) from dbTransaksi where NoBukti=@Nobukti and FlagSimbol='KB'

	-- SET REMOVEDISNULL(@UrutKB,0)+1  

   	if not exists(select * from dbtrans Where NoBukti=@NoBukti) 

   	insert into dbTrans(NoBukti,NoUrut,tanggal,Note,Simbol, TipeTransHd, PerkiraanHd)

     	  values (@NoBukti, @NoUrut, @tanggal,@Note,@Simbol,@TipeTrans,@PerkiraanHd)

     	  if @@Error<>0 Goto JikaSalah

   	

 	insert into dbtransaksi (NoBukti, Tanggal, Devisi, Note, Lampiran, Perkiraan, Lawan, 

 	                         Keterangan, Keterangan2, Debet, Kredit, Valas, Kurs, DebetRp, 

 	                         KreditRp, TipeTrans, TPHC, CustSuppP, CustSuppL, Urut, 

 	                         NoAktivaP, NoAktivaL, StatusAktivaP, StatusAktivaL, Nobon, 

 	                         KodeBag, KodeP, kodeL,StatusGiro,FlagSimbol)

 	values (@NoBukti, @Tanggal, @Devisi, @Note, @Lampiran, @Perkiraan, @Lawan, 

 	        @NoFaktur+' '+@Keterangan, @Keterangan2, @Debet, @Kredit, @Valas, @Kurs, @DebetRp, 

 	        @KreditRp, @TipeTrans, @TPHC, @CustSuppP, @CustSuppL, case when @FlagSimbol='KB' Then @UrutKB else @Urut  , @NoAktivaP, 

 	        @NoAktivaL, @StatusAktivaP, @StatusAktivaL, @Nobon, @KodeBag, @KodeP, @kodeL,@Statusgiro,@FlagSimbol)

 	if @@Error<>0 Goto JikaSalah


 	insert into DBHUTPIUT (NoFaktur, NoRetur, TipeTrans, KodeCustSupp, 

 		NoBukti, NoMsk, Urut, Tanggal, JatuhTempo, Debet, Kredit, Valas, Kurs, 

 		DebetD, KreditD, KodeSales, Tipe, Perkiraan, Catatan, NOINVOICE, KodeVls_, Kurs_,FlagSimbol)

	select NoFaktur, NoRetur, TipeTrans, KodeCustSupp, 

		NoBukti, NoMsk, Urut, Tanggal, JatuhTempo, Debet, Kredit, Valas, Kurs, 

		DebetD, KreditD, KodeSales, Tipe, Perkiraan, Catatan, NoInvoice, Valas_, Kurs_,FlagSimbol

	from DBTempHUTPIUT

	where NoBukti=@Nobukti and NoMsk=case when @FlagSimbol='KB' Then @UrutKB else @Urut    and StatusUID in ('I','U')

	

	if @@Error<>0 Goto JikaSalah



if @choice='U'

Update dbtransaksi set Tanggal=@Tanggal, Devisi=@Devisi, Note=@Note, 

 	                       Lampiran=@Lampiran, Perkiraan=@Perkiraan, Lawan=@Lawan, 

 	                       Keterangan=@NoFaktur+' '+@Keterangan, Keterangan2=@Keterangan2, 

 	                       Debet=@Debet, Kredit=@Kredit, Valas=@Valas, 

 	                       Kurs=@Kurs, DebetRp=@DebetRp, KreditRp=@KreditRp, 

 	                       TipeTrans=@TipeTrans, TPHC=@TPHC, CustSuppP=@CustSuppP, 

 	                       CustSuppL=@CustSuppL, Urut=@Urut, NoAktivaP=@NoAktivaP, 

 	                       NoAktivaL=@NoAktivaL, StatusAktivaP=@StatusAktivaP, 

 	                       StatusAktivaL=@StatusAktivaL, Nobon=@Nobon, Kodebag=@KodeBag,

 	                       KodeP=@KodeP, KodeL=@KodeL, StatusGiro=@Statusgiro,FlagSimbol=@FlagSimbol 

 	where nobukti=@nobukti  and urut=case when @FlagSimbol='KB' Then @UrutKB else @urut 

 	if @@Error<>0 Goto JikaSalah

 	delete DBHUTPIUT

 	from DBHUTPIUT A

 	left outer join DBTempHUTPIUT B on B.NoFaktur=A.NoFaktur and B.KodeCustSupp=A.KodeCustSupp and B.Perkiraan=A.Perkiraan

 		and B.NoBukti=A.NoBukti and B.NoMsk=A.NoMsk and B.Urut=A.Urut

 	where	B.NoBukti=@Nobukti and B.NoMsk=@Urut and B.StatusUID in ('D','U')

 	if @@Error<>0 Goto JikaSalah

 	insert into DBHUTPIUT (NoFaktur, NoRetur, TipeTrans, KodeCustSupp, 

 		NoBukti, NoMsk, Urut, Tanggal, JatuhTempo, Debet, Kredit, Valas, Kurs, 

 		DebetD, KreditD, KodeSales, Tipe, Perkiraan, Catatan, NOINVOICE, KodeVls_, Kurs_)

	select NoFaktur, NoRetur, TipeTrans, KodeCustSupp, 

		NoBukti, NoMsk, Urut, Tanggal, JatuhTempo, Debet, Kredit, Valas, Kurs, 

		DebetD, KreditD, KodeSales, Tipe, Perkiraan, Catatan, NoInvoice, Valas_, Kurs_

	from DBTempHUTPIUT

	where NoBukti=@Nobukti and NoMsk=@Urut and StatusUID in ('I','U')

	if @@Error<>0 Goto JikaSalah



if @choice='D'

delete dbtransaksi where nobukti=@nobukti and urut=@urut and FlagSimbol=@FlagSimbol

 	if @@Error<>0 Goto JikaSalah

 	delete DBHUTPIUT where NoBukti=@Nobukti and NoMsk=@Urut and FlagSimbol=@FlagSimbol

 	if @@Error<>0 Goto JikaSalah

 	if not exists( select nobukti from dbtransaksi where nobukti=@nobukti)

 	delete dbTrans where nobukti=@nobukti

  		if @@Error<>0 Goto JikaSalah 


Commit Tran

Return

JikaSalah: RollBack Tran

           Return;

-- SP_TRANSFER
CREATE PROCEDURE IF NOT EXISTS SP_TRANSFER AS tran

if @choice='I'

select @urut=COALESCE(max(urut),0)+1 from DBTRANSFERdet Where NoBukti=@NoBukti

  If @urut is null -- SET REMOVED1

  if not exists(select * from DBTRANSFER Where NoBukti=@NoBukti) 

  insert into DBTRANSFER (Devisi,NOBUKTI,KdM, NOURUT, TANGGAL, NOTE, IDUSER, NoPenyerahan,Nopol,Sopir)

    values (@Devisi,@NOBUKTI,@KdM,  @NOURUT, @TANGGAL, @NOTE, @IDUSER, @NoPenyerahan,@Nopol,@Sopir)


  insert into DBTRANSFERDET (NOBUKTI,URUT,KODEBRG,GdgAsal, GdgTujuan,Sat_1, Sat_2, QNT,QNT2, NOSAT, ISI,TglProduksi)

  values(@NOBUKTI,@URUT,@KODEBRG,@GdgAsal, @GdgTujuan, @Sat_1, @Sat_2, @QNT, @QNT2, @NOSAT, @ISI,@TglProduksi)



if @choice='U'

update DBTRANSFERDET set Kodebrg=@KODEBRG,

                           Qnt=@QNT, QNT2=@QNT2, NOSAT=@NOSAT, ISI=@ISI,

                           GdgAsal=@GdgAsal, gdgTujuan= @GdgTujuan,sat_1= @Sat_1,Sat_2= @Sat_2,TglProduksi=@TglProduksi 

  where nobukti=@nobukti and urut=@urut



if @choice='D'

delete DBTRANSFERDET where nobukti=@nobukti and  urut=@urut 

  if not exists( select nobukti from DBTRANSFERDET where nobukti=@nobukti)

  delete DBTRANSFER where nobukti=@nobukti


if @@error<>0  goto jikasalah

Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- SP_TRANSFERBRGJADI
CREATE PROCEDURE IF NOT EXISTS SP_TRANSFERBRGJADI AS tran

if @choice='I'

select @urut=COALESCE(max(urut),0)+1 from DBTRANSFERBRGJADIdet Where NoBukti=@NoBukti

  If @urut is null -- SET REMOVED1

  if not exists(select * from DBTRANSFERBRGJADI Where NoBukti=@NoBukti) 

  insert into DBTRANSFERBRGJADI (NOBUKTI, NOURUT, TANGGAL, NOTE)

    values (@NOBUKTI,  @NOURUT, @TANGGAL, @NOTE)


  insert into DBTRANSFERBRGJADIDET (NOBUKTI,URUT,KODEBRG,GdgAsal, GdgTujuan,Sat_1, Sat_2, QNT,QNT2, NOSAT, ISI)

  values(@NOBUKTI,@URUT,@KODEBRG,@GdgAsal, @GdgTujuan, @Sat_1, @Sat_2, @QNT, @QNT2, @NOSAT, @ISI)



if @choice='U'

update DBTRANSFERBRGJADIDET set Kodebrg=@KODEBRG,

                           Qnt=@QNT, QNT2=@QNT2, NOSAT=@NOSAT, ISI=@ISI,

                           GdgAsal=@GdgAsal, gdgTujuan= @GdgTujuan,sat_1= @Sat_1,Sat_2= @Sat_2 

  where nobukti=@nobukti and urut=@urut



if @choice='D'

delete DBTRANSFERBRGJADIDET where nobukti=@nobukti and  urut=@urut 

  if not exists( select nobukti from DBTRANSFERBRGJADIDET where nobukti=@nobukti)

  delete DBTRANSFERBRGJADI where nobukti=@nobukti


if @@error<>0  goto jikasalah

Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- sp_TransInvoiceBebas
CREATE PROCEDURE IF NOT EXISTS sp_TransInvoiceBebas AS Tran

if @Choice='I'

Select @urut=Max(Urut) from dbInvoicePLDet where nobukti=@nobukti

  -- SET REMOVEDISNULL(@urut,0)+1

  if not Exists(Select 'true' from dbInvoicePL where NoBukti=@nobukti)

  insert into dbInvoicePL(NoBukti,NoUrut,Tanggal,NoSPP,KodeCustSupp,Consignee,NotifyParty,ContractNo,PONo,

                            PaymentTerm,DocCreditNo,PoL,PoD,NameOfVessel,ShipOnBoardDate,Packing,Others,IDUser, 

                            Valas,Kurs,PPN,FlagTipe, NoBL, NoteBeneficiary1, NoteBeneficiary2, NoteBeneficiary3,

                            ShipmentAdvice1, ShipmentAdvice2, ETADestination,ToShipmentAdvice2, IssuingBank,KodeBank) 

    Values (@nobukti,@nourut,@Tanggal,@NoSpp,@KodeCustSupp,@Consignee,@notifyParty,@ContractNo,@PoNo,

            @PaymentTerm,@DocCreditNo,@PoL,@PoD,@NameOfVessel,@ShipOnBoardDate,@Packing,@Others,@IDUser, 

            @Valas,@Kurs,@PPN,@FlagTipe, @NoBL, @NoteBeneficiary1, @NoteBeneficiary2, @NoteBeneficiary3,

            @ShipmentAdvice1, @ShipmentAdvice2, @ETADestination,@ToShipmentAdvice2, @IssuingBank,@KodeBank)

  

  if @@ERROR<>0 goto JikaSalah

  Insert into dbInvoicePLDet(NoBukti, Urut, NoSPB, UrutSPB, KodeBrg, Namabrg, PPN, DISC, KURS, QNT, QNT2, SAT_1, SAT_2, 

                             NOSAT, ISI, NetW, GrossW, HARGA, DiscP, DiscRp, DISCTOT, KetDetail, ShippingMark, Meas,

                             Nospp, Tglspp, NoSO, TglSO, Pono,QntKoreksi)

  Values (@nobukti, @Urut, @NoSPB, @UrutSPB, @KodeBrg, '', @Ppn, @Disc, @Kurs, @Qnt, @Qnt2, @Sat_1, @Sat_2, @NoSat, @isi, @NetW, @GrossW, @harga,

          @DiscP, @DiscRp, @DISCTOT,@ketDetail, '', @meas, '', @Tglspp, '', @TglSO, @PoNo,@meas)                                      

  if @@ERROR<>0 goto JikaSalah



if @Choice='U'

update dbInvoicePLDet set NoSPB=@NoSPB, UrutSPB=@UrutSPB, KodeBrg=@KodeBrg, PPN=@Ppn, DISC=@Disc, KURS=@Kurs, 

                           QNT=@Qnt, QNT2=@Qnt2, SAT_1=@Sat_1, SAT_2=@Sat_2, 

                           NOSAT=@NoSat, ISI=@isi, NetW=@NetW, GrossW=@GrossW, 

                           HARGA=@harga, DiscP=@DiscP, DiscRp=@DiscRp, DISCTOT=@DiscTot,KetDetail=@ketDetail, ShippingMark=@ShippingMark,

                           Meas=@meas,QntKoreksi=@meas, Namabrg=@Namabrg,Nospp=@NoSpp, Tglspp=@TglSPP, NoSO=@NoSO, TglSO=@TglSO, Pono=@PoNo

 where NoBukti=@nobukti and Urut=@Urut



if @Choice='D'

delete dbInvoicePLDet where NoBukti=@nobukti and Urut=@Urut

  if not exists(select 'True' from dbInvoicePLDet where NoBukti=@nobukti)

     delete dbInvoicePL where NoBukti=@nobukti 

  -------------

  -----------------

  /*delete dbSPBDet where NoBukti=@NoSPB and Urut=@UrutSPB

  if not exists(select 'True' from dbSPBDet where NoBukti=@NoSPB )

  delete dbSPB where NoBukti=@NoSPB*/       



---

if @Choice in('I','U')

exec [sp_UpdateTransaksiPPN] 'dbInvoicePLDet','dbInvoicePL',@NoBukti


---

if @@ERROR<>0 goto JikaSalah

Commit Tran

Return

JikaSalah: Rollback Tran

           Return;

-- sp_TransInvoiceBeliJadi
CREATE PROCEDURE IF NOT EXISTS sp_TransInvoiceBeliJadi AS Tran

if @Choice='I'

Select @urut=Max(Urut) from dbInvoicePLDet where nobukti=@nobukti

  -- SET REMOVEDISNULL(@urut,0)+1

  if not Exists(Select 'true' from dbInvoicePL where NoBukti=@nobukti)

  insert into dbInvoicePL(Devisi,NoBukti,NoUrut,Tanggal,NoSPP,KodeCustSupp,Consignee,NotifyParty,ContractNo,PONo,

                            PaymentTerm,DocCreditNo,PoL,PoD,NameOfVessel,ShipOnBoardDate,Packing,Others,IDUser, 

                            Valas,Kurs,PPN,FlagTipe, NoBL, NoteBeneficiary1, NoteBeneficiary2, NoteBeneficiary3,

                            ShipmentAdvice1, ShipmentAdvice2, ETADestination,ToShipmentAdvice2, IssuingBank,KodeBank) 

    Values (@Devisi,@nobukti,@nourut,@Tanggal,@NoSpp,@KodeCustSupp,@Consignee,@notifyParty,@ContractNo,@PoNo,

            @PaymentTerm,@DocCreditNo,@PoL,@PoD,@NameOfVessel,@ShipOnBoardDate,@Packing,@Others,@IDUser, 

            @Valas,@Kurs,@PPN,@FlagTipe, @NoBL, @NoteBeneficiary1, @NoteBeneficiary2, @NoteBeneficiary3,

            @ShipmentAdvice1, @ShipmentAdvice2, @ETADestination,@ToShipmentAdvice2, @IssuingBank,@KodeBank)

  

 Insert into dbInvoicePLDet(NoBukti, Urut, NoSPB, UrutSPB, KodeBrg, Namabrg, PPN, DISC, KURS, QNT, QNT2, SAT_1, SAT_2, 

                             NOSAT, ISI, NetW, GrossW, HARGA, DiscP, DiscRp, DISCTOT, KetDetail, ShippingMark, Meas,

                             Nospp, Tglspp, NoSO, TglSO, Pono)

  Values (@nobukti, @Urut, REPLACE(@nobukti,'INTR' ,'SJB'), @Urut, @KodeBrg, '', @Ppn, @Disc, @Kurs, @Qnt, @Qnt2, @Sat_1, @Sat_2, @NoSat, @isi, @NetW, @GrossW, @harga,

          @DiscP, @DiscRp, @DISCTOT,@ketDetail, '', @meas, '', @Tglspp, '', @TglSO, @PoNo)                                      


else if @Choice='U'

update dbInvoicePLDet set NoSPB=REPLACE(@nobukti,'INTR' ,'SJB'), UrutSPB=@Urut, KodeBrg=@KodeBrg, PPN=@Ppn, DISC=@Disc, KURS=@Kurs, 

                           QNT=@Qnt, QNT2=@Qnt2, SAT_1=@Sat_1, SAT_2=@Sat_2, 

                           NOSAT=@NoSat, ISI=@isi, NetW=@NetW, GrossW=@GrossW, 

                           HARGA=@harga, DiscP=@DiscP, DiscRp=@DiscRp, DISCTOT=@DiscTot,KetDetail=@ketDetail, ShippingMark=@ShippingMark,

                           Meas=@meas, Namabrg=@Namabrg,Nospp=@NoSpp, Tglspp=@TglSPP, NoSO=@NoSO, TglSO=@TglSO, Pono=@PoNo

 where NoBukti=@nobukti and Urut=@Urut



else if @Choice='D'

delete dbInvoicePLDet where NoBukti=@nobukti and Urut=@Urut

  if not exists(select 'True' from dbInvoicePLDet where NoBukti=@nobukti)

     delete dbInvoicePL where NoBukti=@nobukti 

  -------------

  -----------------

  delete dbSPBDet where NoBukti=REPLACE(@nobukti,'INTR' ,'SJB') and Urut=@Urut

  if not exists(select 'True' from dbSPBDet where NoBukti=REPLACE(@nobukti,'INTR' ,'SJB') )

  delete dbSPB where NoBukti=REPLACE(@nobukti,'INTR' ,'SJB')       



---

if @Choice in('I','U')

exec [sp_UpdateTransaksiPPN] 'dbInvoicePLDet','dbInvoicePL',@NoBukti


if @Choice='I' 

 if not Exists(Select 'true' from dbSPB where NoBukti=@NoSPB)

 Insert Into dbSPB(NoBukti,NoUrut,Tanggal,KodeCustSupp)

  Values(REPLACE(@nobukti,'INTR' ,'SJB'),@nourut,@Tanggal,@kodecustSupp)

  

  Insert Into dbSPBDet(NoBukti,NoSPP,UrutSPP,Urut,KodeBrg,Namabrg,QNT,QNT2,SAT_1,SAT_2,ISI,KodeGdg)

  Values(REPLACE(@nobukti,'INTR' ,'SJB'),'',0,@Urut,@KodeBrg,'',@Qnt,@Qnt2,@Sat_1,@Sat_2,@isi,@Kodegdg)

 

else if @Choice='U' 

 Update dbSPBDet Set  KodeBrg=@KodeBrg,QNT=@Qnt, QNT2=@Qnt2, SAT_1=@Sat_1, SAT_2=@Sat_2, 

                        NOSAT=@NoSat, ISI=@isi

  where NoBukti=REPLACE(@nobukti,'INTR' ,'SJB') and Urut=@Urut                      

 

else

 delete dbSPB where NoBukti =REPLACE(@nobukti,'INTR' ,'SJB')

---

if @@ERROR<>0 goto JikaSalah

Commit Tran

Return

JikaSalah: Rollback Tran

           Return;

-- sp_TransInvoiceHasilPro
CREATE PROCEDURE IF NOT EXISTS sp_TransInvoiceHasilPro AS Tran

if @Choice='I'

Select @urut=Max(Urut) from dbInvoicePLDet where nobukti=@nobukti

  -- SET REMOVEDISNULL(@urut,0)+1

  if not Exists(Select 'true' from dbInvoicePL where NoBukti=@nobukti)

  insert into dbInvoicePL(Devisi,NoBukti,NoUrut,Tanggal,NoSPP,KodeCustSupp,Consignee,NotifyParty,ContractNo,PONo,

                            PaymentTerm,DocCreditNo,PoL,PoD,NameOfVessel,ShipOnBoardDate,Packing,Others,IDUser, 

                            Valas,Kurs,PPN,FlagTipe, NoBL, NoteBeneficiary1, NoteBeneficiary2, NoteBeneficiary3,

                            ShipmentAdvice1, ShipmentAdvice2, ETADestination,ToShipmentAdvice2, IssuingBank,KodeBank) 

    Values (@Devisi,@nobukti,@nourut,@Tanggal,@NoSpp,@KodeCustSupp,@Consignee,@notifyParty,@ContractNo,@PoNo,

            @PaymentTerm,@DocCreditNo,@PoL,@PoD,@NameOfVessel,@ShipOnBoardDate,@Packing,@Others,@IDUser, 

            @Valas,@Kurs,@PPN,@FlagTipe, @NoBL, @NoteBeneficiary1, @NoteBeneficiary2, @NoteBeneficiary3,

            @ShipmentAdvice1, @ShipmentAdvice2, @ETADestination,@ToShipmentAdvice2, @IssuingBank,@KodeBank)

  

  Insert into dbInvoicePLDet(NoBukti, Urut, NoSPB, UrutSPB, KodeBrg, Namabrg, PPN, DISC, KURS, QNT, QNT2, SAT_1, SAT_2, 

                             NOSAT, ISI, NetW, GrossW, HARGA, DiscP, DiscRp, DISCTOT, KetDetail, ShippingMark, Meas,

                             Nospp, Tglspp, NoSO, TglSO, Pono)

  Values (@nobukti, @Urut, REPLACE(@nobukti,'INTR' ,'SHP'), @Urut, @KodeBrg, '', @Ppn, @Disc, @Kurs, @Qnt, @Qnt2, @Sat_1, @Sat_2, @NoSat, @isi, @NetW, @GrossW, @harga,

          @DiscP, @DiscRp, @DISCTOT,@ketDetail, '', @meas, '', @Tglspp, '', @TglSO, @PoNo)                                      


else if @Choice='U'

update dbInvoicePLDet set NoSPB=REPLACE(@nobukti,'INTR' ,'SHP'), UrutSPB=@Urut, KodeBrg=@KodeBrg, PPN=@Ppn, DISC=@Disc, KURS=@Kurs, 

                           QNT=@Qnt, QNT2=@Qnt2, SAT_1=@Sat_1, SAT_2=@Sat_2, 

                           NOSAT=@NoSat, ISI=@isi, NetW=@NetW, GrossW=@GrossW, 

                           HARGA=@harga, DiscP=@DiscP, DiscRp=@DiscRp, DISCTOT=@DiscTot,KetDetail=@ketDetail, ShippingMark=@ShippingMark,

                           Meas=@meas, Namabrg=@Namabrg,Nospp=@NoSpp, Tglspp=@TglSPP, NoSO=@NoSO, TglSO=@TglSO, Pono=@PoNo

 where NoBukti=@nobukti and Urut=@Urut



else if @Choice='D'

delete dbInvoicePLDet where NoBukti=@nobukti and Urut=@Urut

  if not exists(select 'True' from dbInvoicePLDet where NoBukti=@nobukti)

     delete dbInvoicePL where NoBukti=@nobukti 

  -------------

  -----------------

  delete dbSPBDet where NoBukti=REPLACE(@nobukti,'INTR' ,'SHP') and Urut=@Urut

  if not exists(select 'True' from dbSPBDet where NoBukti=REPLACE(@nobukti,'INTR' ,'SHP') )

  delete dbSPB where NoBukti=REPLACE(@nobukti,'INTR' ,'SHP')       



---

if @Choice in('I','U')

exec [sp_UpdateTransaksiPPN] 'dbInvoicePLDet','dbInvoicePL',@NoBukti


if @Choice='I' 

 if not Exists(Select 'true' from dbSPB where NoBukti=@NoSPB)

 Insert Into dbSPB(NoBukti,NoUrut,Tanggal,KodeCustSupp)

  Values(REPLACE(@nobukti,'INTR' ,'SHP'),@nourut,@Tanggal,@kodecustSupp)

  

  Insert Into dbSPBDet(NoBukti,NoSPP,UrutSPP,Urut,KodeBrg,Namabrg,QNT,QNT2,SAT_1,SAT_2,ISI,KodeGdg)

  Values(REPLACE(@nobukti,'INTR' ,'SHP'),'',0,@Urut,@KodeBrg,'',@Qnt,@Qnt2,@Sat_1,@Sat_2,@isi,@Kodegdg)

 

else if @Choice='U' 

 Update dbSPBDet Set  KodeBrg=@KodeBrg,QNT=@Qnt, QNT2=@Qnt2, SAT_1=@Sat_1, SAT_2=@Sat_2, 

                        NOSAT=@NoSat, ISI=@isi

  where NoBukti=REPLACE(@nobukti,'INTR' ,'SHP') and Urut=@Urut                      


---

if @@ERROR<>0 goto JikaSalah

Commit Tran

Return

JikaSalah: Rollback Tran

           Return;

-- sp_TransInvoiceIntern
CREATE PROCEDURE IF NOT EXISTS sp_TransInvoiceIntern AS Tran

if @Choice='I'

Select @urut=Max(Urut) from dbInvoicePLDet where nobukti=@nobukti

  -- SET REMOVEDISNULL(@urut,0)+1

  if not Exists(Select 'true' from dbInvoicePL where NoBukti=@nobukti)

  insert into dbInvoicePL(Devisi,NoBukti,NoUrut,Tanggal,NoSPP,KodeCustSupp,Consignee,NotifyParty,ContractNo,PONo,

                            PaymentTerm,DocCreditNo,PoL,PoD,NameOfVessel,ShipOnBoardDate,Packing,Others,IDUser, 

                            Valas,Kurs,PPN,FlagTipe, NoBL, NoteBeneficiary1, NoteBeneficiary2, NoteBeneficiary3,

                            ShipmentAdvice1, ShipmentAdvice2, ETADestination,ToShipmentAdvice2, IssuingBank,KodeBank) 

    Values (@Devisi,@nobukti,@nourut,@Tanggal,@NoSpp,@KodeCustSupp,@Consignee,@notifyParty,@ContractNo,@PoNo,

            @PaymentTerm,@DocCreditNo,@PoL,@PoD,@NameOfVessel,@ShipOnBoardDate,@Packing,@Others,@IDUser, 

            @Valas,@Kurs,@PPN,@FlagTipe, @NoBL, @NoteBeneficiary1, @NoteBeneficiary2, @NoteBeneficiary3,

            @ShipmentAdvice1, @ShipmentAdvice2, @ETADestination,@ToShipmentAdvice2, @IssuingBank,@KodeBank)

  

  if @@ERROR<>0 goto JikaSalah

  Insert into dbInvoicePLDet(NoBukti, Urut, NoSPB, UrutSPB, KodeBrg, Namabrg, PPN, DISC, KURS, QNT, QNT2, SAT_1, SAT_2, 

                             NOSAT, ISI, NetW, GrossW, HARGA, DiscP, DiscRp, DISCTOT, KetDetail, ShippingMark, Meas,

                             Nospp, Tglspp, NoSO, TglSO, Pono)

  Values (@nobukti, @Urut, @NoSPB, @UrutSPB, @KodeBrg, '', @Ppn, @Disc, @Kurs, @Qnt, @Qnt2, @Sat_1, @Sat_2, @NoSat, @isi, @NetW, @GrossW, @harga,

          @DiscP, @DiscRp, @DISCTOT,@ketDetail, '', @meas, '', @Tglspp, '', @TglSO, @PoNo)                                      

  if @@ERROR<>0 goto JikaSalah



if @Choice='U'

update dbInvoicePLDet set NoSPB=@NoSPB, UrutSPB=@UrutSPB, KodeBrg=@KodeBrg, PPN=@Ppn, DISC=@Disc, KURS=@Kurs, 

                           QNT=@Qnt, QNT2=@Qnt2, SAT_1=@Sat_1, SAT_2=@Sat_2, 

                           NOSAT=@NoSat, ISI=@isi, NetW=@NetW, GrossW=@GrossW, 

                           HARGA=@harga, DiscP=@DiscP, DiscRp=@DiscRp, DISCTOT=@DiscTot,KetDetail=@ketDetail, ShippingMark=@ShippingMark,

                           Meas=@meas, Namabrg=@Namabrg,Nospp=@NoSpp, Tglspp=@TglSPP, NoSO=@NoSO, TglSO=@TglSO, Pono=@PoNo

 where NoBukti=@nobukti and Urut=@Urut



if @Choice='D'

delete dbInvoicePLDet where NoBukti=@nobukti and Urut=@Urut

  if not exists(select 'True' from dbInvoicePLDet where NoBukti=@nobukti)

     delete dbInvoicePL where NoBukti=@nobukti 

  -------------

  -----------------

  delete dbSPBDet where NoBukti=@NoSPB and Urut=@UrutSPB

  if not exists(select 'True' from dbSPBDet where NoBukti=@NoSPB )

  delete dbSPB where NoBukti=@NoSPB       



---



if @Choice in('I','U')

exec [sp_UpdateTransaksiPPN] 'dbInvoicePLDet','dbInvoicePL',@NoBukti


if @Choice='I' 

 if not Exists(Select 'true' from dbSPB where NoBukti=@NoSPB)

 Insert Into dbSPB(NoBukti,NoUrut,Tanggal,KodeCustSupp)

  Values(@NoSPB,@nourut,@Tanggal,@kodecustSupp)

  

 if not Exists(Select 'true' from dbSPBDet where NoBukti=@NoSPB and Urut=@UrutSPB)

 Insert Into dbSPBDet(NoBukti,NoSPP,UrutSPP,Urut,KodeBrg,Namabrg,QNT,QNT2,SAT_1,SAT_2,ISI,KodeGdg)

  Values(@NoSPB,'',0,@UrutSPB,@KodeBrg,'',@Qnt,@Qnt2,@Sat_1,@Sat_2,@isi,@Kodegdg)


else if @Choice='U' 

 Update dbSPBDet Set  KodeBrg=@KodeBrg,QNT=@Qnt, QNT2=@Qnt2, SAT_1=@Sat_1, SAT_2=@Sat_2, 

                        NOSAT=@NoSat, ISI=@isi

  where NoBukti=@NoSPB and Urut=@UrutSPB                      


---

if @@ERROR<>0 goto JikaSalah

Commit Tran

Return

JikaSalah: Rollback Tran

           Return;

-- sp_TransInvoiceKJP
CREATE PROCEDURE IF NOT EXISTS sp_TransInvoiceKJP AS Tran

if @Choice='I'

Select @urut=Max(Urut) from dbInvoicePLDet where nobukti=@nobukti

  -- SET REMOVEDISNULL(@urut,0)+1

  if not Exists(Select 'true' from dbInvoicePL where NoBukti=@nobukti)

  insert into dbInvoicePL(NoBukti,NoUrut,Tanggal,NoSPP,KodeCustSupp,Consignee,NotifyParty,ContractNo,PONo,

                            PaymentTerm,DocCreditNo,PoL,PoD,NameOfVessel,ShipOnBoardDate,Packing,Others,IDUser, 

                            Valas,Kurs,PPN,FlagTipe, NoBL, NoteBeneficiary1, NoteBeneficiary2, NoteBeneficiary3,

                            ShipmentAdvice1, ShipmentAdvice2, ETADestination,ToShipmentAdvice2, IssuingBank) 

    Values (@nobukti,@nourut,@Tanggal,@NoSpp,@KodeCustSupp,@Consignee,@notifyParty,@ContractNo,@PoNo,

            @PaymentTerm,@DocCreditNo,@PoL,@PoD,@NameOfVessel,@ShipOnBoardDate,@Packing,@Others,@IDUser, 

            @Valas,@Kurs,@PPN,@FlagTipe, @NoBL, @NoteBeneficiary1, @NoteBeneficiary2, @NoteBeneficiary3,

            @ShipmentAdvice1, @ShipmentAdvice2, @ETADestination,@ToShipmentAdvice2, @IssuingBank)

  

  Insert into dbInvoicePLDet(NoBukti, Urut, NoSPB, UrutSPB, KodeBrg, Namabrg, PPN, DISC, KURS, QNT, QNT2, SAT_1, SAT_2, 

                             NOSAT, ISI, NetW, GrossW, HARGA, DiscP, DiscRp, DISCTOT, KetDetail, ShippingMark, Meas,

                             Nospp, Tglspp, NoSO, TglSO, Pono)

  Values (@nobukti, @Urut, @NoSPB, @UrutSPB, @KodeBrg, @Namabrg, @Ppn, @Disc, @Kurs, @Qnt, @Qnt2, @Sat_1, @Sat_2, @NoSat, @isi, @NetW, @GrossW, @harga,

          @DiscP, @DiscRp, @DISCTOT,@ketDetail, @ShippingMark, @meas, @Nospp, @Tglspp, @NoSO, @TglSO, @PoNo)                                      



else if @Choice='U'

update dbInvoicePLDet set NoSPB=@NoSPB, UrutSPB=@UrutSPB, KodeBrg=@KodeBrg, PPN=@Ppn, DISC=@Disc, KURS=@Kurs, 

                           QNT=@Qnt, QNT2=@Qnt2, SAT_1=@Sat_1, SAT_2=@Sat_2, 

                           NOSAT=@NoSat, ISI=@isi, NetW=@NetW, GrossW=@GrossW, 

                           HARGA=@harga, DiscP=@DiscP, DiscRp=@DiscRp, DISCTOT=@DiscTot,KetDetail=@ketDetail, ShippingMark=@ShippingMark,

                           Meas=@meas, Namabrg=@Namabrg,Nospp=@NoSpp, Tglspp=@TglSPP, NoSO=@NoSO, TglSO=@TglSO, Pono=@PoNo

 where NoBukti=@nobukti and Urut=@Urut



else if @Choice='D'

delete dbInvoicePLDet where NoBukti=@nobukti and Urut=@Urut

  if not exists(select 'True' from dbInvoicePLDet where NoBukti=@nobukti)

     delete dbInvoicePL where NoBukti=@nobukti 



if @Choice in('I','U')

exec [sp_UpdateTransaksiPPN] 'dbInvoicePLDet','dbInvoicePL',@NoBukti


if @@ERROR<>0 goto JikaSalah

Commit Tran

Return

JikaSalah: Rollback Tran

           Return;

-- sp_TransInvoiceKP
CREATE PROCEDURE IF NOT EXISTS sp_TransInvoiceKP AS Tran

if @Choice='I'

Select @urut=Max(Urut) from dbInvoicePLDet where nobukti=@nobukti

  -- SET REMOVEDISNULL(@urut,0)+1

  if not Exists(Select 'true' from dbInvoicePL where NoBukti=@nobukti)

  insert into dbInvoicePL(Devisi,NoBukti,NoUrut,Tanggal,NoSPP,KodeCustSupp,Consignee,NotifyParty,ContractNo,PONo,

                            PaymentTerm,DocCreditNo,PoL,PoD,NameOfVessel,ShipOnBoardDate,Packing,Others,IDUser, 

                            Valas,Kurs,PPN,FlagTipe, NoBL, NoteBeneficiary1, NoteBeneficiary2, NoteBeneficiary3,

                            ShipmentAdvice1, ShipmentAdvice2, ETADestination,ToShipmentAdvice2, IssuingBank,KodeBank,NoInv,DISC) 

    Values (@Devisi,@nobukti,@nourut,@Tanggal,@NoSpp,@KodeCustSupp,@Consignee,@notifyParty,@ContractNo,@PoNo,

            @PaymentTerm,@DocCreditNo,@PoL,@PoD,@NameOfVessel,@ShipOnBoardDate,@Packing,@Others,@IDUser, 

            @Valas,@Kurs,@PPN,@FlagTipe, @NoBL, @NoteBeneficiary1, @NoteBeneficiary2, @NoteBeneficiary3,

            @ShipmentAdvice1, @ShipmentAdvice2, @ETADestination,@ToShipmentAdvice2, @IssuingBank,@KodeBank,@nobukti,@Disc)

  

  Insert into dbInvoicePLDet(NoBukti, Urut, NoSPB, UrutSPB, KodeBrg, Namabrg, PPN, DISC, KURS, QNT, QNT2, SAT_1, SAT_2, 

                             NOSAT, ISI, NetW, GrossW, HARGA, DiscP, DiscRp, DISCTOT, KetDetail, ShippingMark, Meas,

                             Nospp, Tglspp, NoSO, TglSO, Pono,QntKoreksi,IsAngkutJasa,PPH)

  Values (@nobukti, @Urut, @NoSPB, @UrutSPB, @KodeBrg, @Namabrg, @Ppn, @Disc, @Kurs, @Qnt, @Qnt2, @Sat_1, @Sat_2, @NoSat, @isi, @NetW, @GrossW, @harga,

          @DiscP, @DiscRp, @DISCTOT,@ketDetail, @ShippingMark, @meas, @Nospp, @Tglspp, @NoSO, @TglSO, @PoNo,@QntKoreksi,@IsJasa,@PPH)                                      



else if @Choice='U'

Update DBInvoicePL set NoInv=@nobukti where NoBukti=@nobukti

 update dbInvoicePLDet set NoSPB=@NoSPB, UrutSPB=@UrutSPB, KodeBrg=@KodeBrg, PPN=@Ppn, DISC=@Disc, KURS=@Kurs, 

                           QNT=@Qnt, QNT2=@Qnt2, SAT_1=@Sat_1, SAT_2=@Sat_2,QntKoreksi=@QntKoreksi,PPH=@PPH, 

                           NOSAT=@NoSat, ISI=@isi, NetW=@NetW, GrossW=@GrossW, 

                           HARGA=@harga, DiscP=@DiscP, DiscRp=@DiscRp, DISCTOT=@DiscTot,KetDetail=@ketDetail, ShippingMark=@ShippingMark,

                           Meas=@meas, Namabrg=@Namabrg,Nospp=@NoSpp, Tglspp=@TglSPP, NoSO=@NoSO, TglSO=@TglSO, Pono=@PoNo,IsAngkutJasa=@IsJasa

 where NoBukti=@nobukti and Urut=@Urut



else if @Choice='D'

delete dbInvoicePLDet where NoBukti=@nobukti and Urut=@Urut

  if not exists(select 'True' from dbInvoicePLDet where NoBukti=@nobukti)

     delete dbInvoicePL where NoBukti=@nobukti 



if @Choice in('I','U')

exec [sp_UpdateTransaksiPPN] 'dbInvoicePLDet','dbInvoicePL',@NoBukti


if @@ERROR<>0 goto JikaSalah

Commit Tran

Return

JikaSalah: Rollback Tran

           Return;

-- sp_TransPNW
CREATE PROCEDURE IF NOT EXISTS sp_TransPNW AS tran

---- DECLARE REMOVED

--  -- SET REMOVEDGetdate()

if @choice='I'

select @urut=COALESCE(max(urut),0)+1 from DBPNWdet Where NoBukti=@NoBukti

  If @urut is null -- SET REMOVED1

  if not exists(select * from DBPNW Where NoBukti=@NoBukti) 

  insert into DBPNW (Devisi,NOBUKTI, NOURUT, TANGGAL, TglJatuhTempo, KODECUST, NOSPB, NoAlamatKirim, ALAMATKIRIM, KodeSls, 

	KETERANGAN, KODEVLS, KURS, PPN, TIPEBAYAR, HARI, TIPEDISC, DISC, DISCRP, CATATAN, KODEGDG,KodeExp, 

	INSBrg,Jam, FLAGTIPE, IsLengkap, Userid, TglInput, NoPesanan, TglKirim, Masaberlaku,TERM1P,TERM2P,TERM3P,INSGdg)

    values (@Devisi,@NOBUKTI, @NOURUT, @TANGGAL, @TglJatuhTempo, @KODECust, @NOSPB, @NoAlamatKirim, @ALAMATKIRIM, @KodeSls, 

	@KETERANGAN, @KODEVLS, @KURS, @PPN, @TIPEBAYAR, @HARI, @TIPEDISC, @DISC, @DISCRP, @CATATAN, @KODEGDG,@KodeExp,

	@INSBrg, @TglMinta, @FlagTipe, 0, @Userid, datetime('now'),@NoPesanan, @TglKirim, @MasaBerlaku,@Retensi,@PPH22,@NPPH22,@NmPrj)

	if @@error<>0  goto jikasalah		

  

  insert into DBPNWdet (NOBUKTI, URUT, UrutSPB, PPN, Disc, Kurs, KODEBRG, QNT, QNT2, QNT3, BYANGKUT, NOSAT, ISI, HARGA, DISCP1, DISCRP1, DISCTOT, SATUAN, IsCetakKitir, Qnt2SisaSO,HPP,NamaBrg,Ketbatal,IsUbahNama,KodebrgM,PPH)

  values(@NOBUKTI,@URUT, @UrutSPB, @PPN, @Disc, @Kurs, @KODEBRG, @QNT, @QNT2, 0, @Qnt3, @NOSAT, @ISI, @HARGA, @DiscP1, @DiscTot, @DiscTot,@Satuan, @IsLengkap, @Qnt2SisaSO,@HPP,@NamaBrg,@Keterang1,@IsUbahNama,@KodebrgM,@PPH)

  if @@error<>0  goto jikasalah



if @choice='U'

--update DBPNW set Catatan=@Catatan where nobukti=@nobukti

  update DBPNWdet set kodebrg=@KODEBRG, UrutSPB=@UrutSPB, Qnt=@QNT, QNT2=@QNT2, BYANGKUT=@QNT3, NOSAT=@NOSAT, Isi=@Isi,

	Harga=@HARGA, DiscP1=@DiscP1, DiscRP1=@DiscTot, DiscTot=@DiscTot, SATUAN=@Satuan,

	IsCetakKitir=@IsLengkap, Qnt2SisaSO=@Qnt2SisaSO,HPP=@HPP,NamaBrg=@NamaBrg,HPPMaterial=@HPPMaterial,HPPLabour=@HPPLabour,HPPOH=@HPPOH,Ketbatal=@Keterang1,IsUbahNama=@IsUbahNama,KodebrgM=@KodebrgM,PPH=@PPH

  where nobukti=@nobukti and urut=@urut

  if @@error<>0  goto jikasalah



if @choice='D'

delete DBPNWdet where nobukti=@nobukti and  urut=@urut

  if @@error<>0  goto jikasalah 

  if not exists( select nobukti from DBPNWdet where nobukti=@nobukti)

  delete DBPNW where nobukti=@nobukti

    if @@error<>0  goto jikasalah

    delete dbSpesifikasiSO where nobukti=@nobukti

    if @@error<>0  goto jikasalah


if @Choice in('I','U')

exec [sp_UpdateTransaksiPPN] 'DBPNWdet','DBPNW',@NoBukti


--exec sp_RefreshOutSO @NoBukti


Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- SP_TransRute
CREATE PROCEDURE IF NOT EXISTS SP_TransRute AS select A.NOBUKTI,A.NOURUT,A.TANGGAL,A.KODEKEND,A.SUPIR,A.RUTE,

B.URUT,B.BIAYA,B.TARIF,B.QNT,B.TOTAL,C.NAMAKEND,C.KODEJENISKEND,

D.NAMAJENISKEND,E.NAMARUTE,B.ISP,Ket1,Ket2,Pro.NAMAPROJECT,Cust.NAMACUSTSUPP

from DBRUTETRANS A

LEFT OUTER JOIN DBRUTETRANSDET B ON A.NOBUKTI=B.NOBUKTI

Left Outer Join DBCUSTSUPP Cust On Cust.KODECUSTSUPP=A.Ket2

Left Outer Join DBPROJECT Pro On Pro.KODEPROJECT=A.Ket1

LEFT OUTER JOIN DBKENDARAAN C ON A.KODEKEND=C.KODEKEND

LEFT OUTER JOIN DBJENISKEND D ON C.KODEJENISKEND=D.KODEJENISKEND

LEFT OUTER JOIN DBRUTE E ON A.RUTE=E.KODERUTE

WHERE A.NOBUKTI=@NOBUKTI;

-- SP_TransRuteTanggal
CREATE PROCEDURE IF NOT EXISTS SP_TransRuteTanggal AS select A.NOBUKTI,A.NOURUT,A.TANGGAL,A1.KODEKEND,A1.Sopir SUPIR,A.RUTE,

B.URUT,B.BIAYA,B.TARIF,B.QNT,B.TOTAL,C.NAMAKEND,C.KODEJENISKEND,

D.NAMAJENISKEND,E.NAMARUTE,B.ISP,Ket1,Ket2,Pro.NAMAPROJECT,Cust.NAMACUSTSUPP,

[dbo].[fnc_NamaSJ](A.NOBUKTI)NoSJ

from DBRUTETRANS A

Left Outer Join(select MAX(Sopir)Sopir,MAX(KODEKEND)KODEKEND,MAX(NoPOL)NoPOL,NoSaku from DBSJRUTETRANS Group By NoSaku)A1 On A1.NoSaku=A.NOBUKTI

LEFT OUTER JOIN DBRUTETRANSDET B ON A.NOBUKTI=B.NOBUKTI

Left Outer Join DBCUSTSUPP Cust On Cust.KODECUSTSUPP=A.Ket2

Left Outer Join DBPROJECT Pro On Pro.KODEPROJECT=A.Ket1

LEFT OUTER JOIN DBKENDARAAN C ON A1.KODEKEND=C.KODEKEND

LEFT OUTER JOIN DBJENISKEND D ON C.KODEJENISKEND=D.KODEJENISKEND

LEFT OUTER JOIN DBRUTE E ON A.RUTE=E.KODERUTE

WHERE A.NOBUKTI=@NOBUKTI

--and 

--A.TANGGAL Between @Tanggal1 and @Tanggal2+1;

-- sp_TransSO
CREATE PROCEDURE IF NOT EXISTS sp_TransSO AS tran

---- DECLARE REMOVED

--  -- SET REMOVEDGetdate()

if @choice='I'

select @urut=COALESCE(max(urut),0)+1 from DBSOdet Where NoBukti=@NoBukti

  If @urut is null -- SET REMOVED1

  if not exists(select * from DBSO Where NoBukti=@NoBukti) 

  insert into DBSO (Devisi,NOBUKTI, NOURUT, TANGGAL, TglJatuhTempo, KODECUST, NOSPB, NoAlamatKirim, ALAMATKIRIM, KodeSls, 

	KETERANGAN, KODEVLS, KURS, PPN, TIPEBAYAR, HARI, TIPEDISC, DISC, DISCRP, CATATAN, KODEGDG,KodeExp, 

	INSGdg, INSBrg,Jam, FLAGTIPE, IsLengkap, Userid, TglInput, NoPesanan, TglKirim, Masaberlaku,TERM1P,TERM2P,TERM3P,NOPI,Tf,Do)

    values (@Devisi,@NOBUKTI, @NOURUT, @TANGGAL, @TglJatuhTempo, @KODECust, @NOSPB, @NoAlamatKirim, @ALAMATKIRIM, @KodeSls, 

	@KETERANGAN, @KODEVLS, @KURS, @PPN, @TIPEBAYAR, @HARI, @TIPEDISC, @DISC, @DISCRP, @CATATAN, @KODEGDG,@KodeExp,

	'', @INSBrg, @TglMinta, @FlagTipe, 0, @Userid, datetime('now'),@NoPesanan, @TglKirim, @MasaBerlaku,@Retensi,@PPH22,@NPPH22,@noPNW,0,@Choice)

	if @@error<>0  goto jikasalah		

  

  insert into DBSODET (NOBUKTI, URUT, UrutSPB, PPN, Disc, Kurs, KODEBRG, QNT, QNT2, QNT3, BYANGKUT, NOSAT, ISI, HARGA, DISCP1, DISCRP1, DISCTOT, SATUAN, IsCetakKitir, Qnt2SisaSO,HPP,NamaBrg,Ketbatal,IsUbahNama,KodebrgM,PPH,Ketbatal1,Tf,Do)

  values(@NOBUKTI,@URUT, @UrutSPB, @PPN, @Disc, @Kurs, @KODEBRG, @QNT, @QNT2, 0, @Qnt3, @NOSAT, @ISI, @HARGA, @DiscP1, @DiscTot, @DiscTot,@Satuan, @IsLengkap, @Qnt2SisaSO,@HPP,@NamaBrg,CAST(@Keterang1 AS TEXT),@IsUbahNama,@KodebrgM,@PPH,@Keterang1,0,@Choice)

  if @@error<>0  goto jikasalah



if @choice='U'

--update DBSO set Catatan=@Catatan where nobukti=@nobukti

  update DBSODET set kodebrg=@KODEBRG, UrutSPB=@UrutSPB, Qnt=@QNT, QNT2=@QNT2, BYANGKUT=@QNT3, NOSAT=@NOSAT, Isi=@Isi, KetBatal1=@Keterang1,

	Harga=@HARGA, DiscP1=@DiscP1, DiscRP1=@DiscTot, DiscTot=@DiscTot, SATUAN=@Satuan,

	IsCetakKitir=@IsLengkap, Qnt2SisaSO=@Qnt2SisaSO,HPP=@HPP,NamaBrg=@NamaBrg,HPPMaterial=@HPPMaterial,HPPLabour=@HPPLabour,HPPOH=@HPPOH,Ketbatal=CAST(@Keterang1 AS TEXT),IsUbahNama=@IsUbahNama,KodebrgM=@KodebrgM,PPH=@PPH,Tf=0,Do=@Choice 

  where nobukti=@nobukti and urut=@urut

  if @@error<>0  goto jikasalah



if @choice='D'

if @IsRev=1 

  delete DBSORevDET where nobukti=@nobukti and  urut=@urut and revisike=@RevKe

   if not exists( select nobukti from DBSORevDET where nobukti=@nobukti and revisike=@RevKe)

     delete DBSORev where nobukti=@nobukti


  else

  delete DBSODET where nobukti=@nobukti and  urut=@urut

  insert TempDelDataDet

  select @Nobukti,@Urut,'DBSODET'	

  if @@error<>0  goto jikasalah 

  if not exists( select nobukti from DBSODET where nobukti=@nobukti)

  delete DBSO where nobukti=@nobukti

     insert TempDelData

    select @Nobukti,'DBSO'

    if @@error<>0  goto jikasalah

    delete dbSpesifikasiSO where nobukti=@nobukti

    if @@error<>0  goto jikasalah


if @Choice in('I','U')

exec [sp_UpdateTransaksiPPN] 'DBSODET','DBSO',@NoBukti



--exec sp_RefreshOutSO @NoBukti


Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- sp_TransSOJ
CREATE PROCEDURE IF NOT EXISTS sp_TransSOJ AS tran

---- DECLARE REMOVED

--  -- SET REMOVEDGetdate()

if @choice='I'

select @urut=COALESCE(max(urut),0)+1 from DBSOdet Where NoBukti=@NoBukti

  If @urut is null -- SET REMOVED1

  if not exists(select * from DBSO Where NoBukti=@NoBukti) 

  insert into DBSO (Devisi,NOBUKTI, NOURUT, TANGGAL, TglJatuhTempo, KODECUST, NOSPB, NoAlamatKirim, ALAMATKIRIM, KodeSls, 

	KETERANGAN, KODEVLS, KURS, PPN, TIPEBAYAR, HARI, TIPEDISC, DISC, DISCRP, CATATAN, KODEGDG,KodeExp, 

	INSGdg, INSBrg,Jam, FLAGTIPE, IsLengkap, Userid, TglInput, NoPesanan, TglKirim, Masaberlaku)

    values (@Devisi,@NOBUKTI, @NOURUT, @TANGGAL, @TglJatuhTempo, @KODECust, @NOSPB, @NoAlamatKirim, @ALAMATKIRIM, @KodeSls, 

	@KETERANGAN, @KODEVLS, @KURS, @PPN, @TIPEBAYAR, @HARI, @TIPEDISC, @DISC, @DISCRP, @CATATAN, @KODEGDG,@KodeExp,

	'', @INSBrg, @TglMinta, @FlagTipe, 0, @Userid, datetime('now'),@NoPesanan, @TglKirim, @MasaBerlaku)		

  

  insert into DBSODET (NOBUKTI, URUT, UrutSPB, PPN, Disc, Kurs, KODEBRG, QNT, QNT2, QNT3, BYANGKUT, NOSAT, ISI, HARGA, DISCP1, DISCRP1, DISCTOT, SATUAN, IsCetakKitir, Qnt2SisaSO,NamaBrg,Ketbatal)

  values(@NOBUKTI,@URUT, @UrutSPB, @PPN, @Disc, @Kurs, @KODEBRG, @QNT, @QNT2, 0, @Qnt3, @NOSAT, @ISI, @HARGA, @DiscP1, @DiscTot, @DiscTot,@Satuan, @IsLengkap, @Qnt2SisaSO,@NamaBrg,@Ket)



if @choice='U'

--update DBSO set Catatan=@Catatan where nobukti=@nobukti

  update DBSODET set kodebrg=@KODEBRG, UrutSPB=@UrutSPB, Qnt=@QNT, QNT2=@QNT2, BYANGKUT=@QNT3, NOSAT=@NOSAT, Isi=@Isi, 

	Harga=@HARGA, DiscP1=@DiscP1, DiscRP1=@DiscTot, DiscTot=@DiscTot, SATUAN=@Satuan,

	IsCetakKitir=@IsLengkap, Qnt2SisaSO=@Qnt2SisaSO,NamaBrg=@NamaBrg,Ketbatal=@Ket

  where nobukti=@nobukti and urut=@urut



if @choice='D'

delete DBSODET where nobukti=@nobukti and  urut=@urut 

  if not exists( select nobukti from DBSODET where nobukti=@nobukti)

  delete DBSO where nobukti=@nobukti


if @Choice in('I','U')

exec [sp_UpdateTransaksiPPN] 'DBSODET','DBSO',@NoBukti



--exec sp_RefreshOutSO @NoBukti



if @@error<>0  goto jikasalah

Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- sp_TransSOold
CREATE PROCEDURE IF NOT EXISTS sp_TransSOold AS tran

---- DECLARE REMOVED

--  -- SET REMOVEDGetdate()

if @choice='I'

select @urut=COALESCE(max(urut),0)+1 from DBSOdet Where NoBukti=@NoBukti

  If @urut is null -- SET REMOVED1

  if not exists(select * from DBSO Where NoBukti=@NoBukti) 

  insert into DBSO (NOBUKTI, NOURUT, TANGGAL, TglJatuhTempo, KODECUST, NOSPB, NoAlamatKirim, ALAMATKIRIM, KodeSls, 

	KETERANGAN, KODEVLS, KURS, PPN, TIPEBAYAR, HARI, TIPEDISC, DISC, DISCRP, CATATAN, KODEGDG,KodeExp, 

	INSGdg, INSBrg,Jam, FLAGTIPE, IsLengkap, Userid, TglInput, NoPesanan, TglKirim, Masaberlaku,TERM1P,TERM2P,TERM3P)

    values (@NOBUKTI, @NOURUT, @TANGGAL, @TglJatuhTempo, @KODECust, @NOSPB, @NoAlamatKirim, @ALAMATKIRIM, @KodeSls, 

	@KETERANGAN, @KODEVLS, @KURS, @PPN, @TIPEBAYAR, @HARI, @TIPEDISC, @DISC, @DISCRP, @CATATAN, @KODEGDG,@KodeExp,

	'', @INSBrg, @TglMinta, @FlagTipe, 0, @Userid, datetime('now'),@NoPesanan, @TglKirim, @MasaBerlaku,@Retensi,@PPH22,@NPPH22)

	if @@error<>0  goto jikasalah		

  

  insert into DBSODET (NOBUKTI, URUT, UrutSPB, PPN, Disc, Kurs, KODEBRG, QNT, QNT2, QNT3, BYANGKUT, NOSAT, ISI, HARGA, DISCP1, DISCRP1, DISCTOT, SATUAN, IsCetakKitir, Qnt2SisaSO,HPP,NamaBrg,Ketbatal,IsUbahNama,KodebrgM,PPH)

  values(@NOBUKTI,@URUT, @UrutSPB, @PPN, @Disc, @Kurs, @KODEBRG, @QNT, @QNT2, 0, @Qnt3, @NOSAT, @ISI, @HARGA, @DiscP1, @DiscTot, @DiscTot,@Satuan, @IsLengkap, @Qnt2SisaSO,@HPP,@NamaBrg,@Keterang1,@IsUbahNama,@KodebrgM,@PPH)

  if @@error<>0  goto jikasalah



if @choice='U'

--update DBSO set Catatan=@Catatan where nobukti=@nobukti

  update DBSODET set kodebrg=@KODEBRG, UrutSPB=@UrutSPB, Qnt=@QNT, QNT2=@QNT2, BYANGKUT=@QNT3, NOSAT=@NOSAT, Isi=@Isi, 

	Harga=@HARGA, DiscP1=@DiscP1, DiscRP1=@DiscTot, DiscTot=@DiscTot, SATUAN=@Satuan,

	IsCetakKitir=@IsLengkap, Qnt2SisaSO=@Qnt2SisaSO,HPP=@HPP,NamaBrg=@NamaBrg,HPPMaterial=@HPPMaterial,HPPLabour=@HPPLabour,HPPOH=@HPPOH,Ketbatal=@Keterang1,IsUbahNama=@IsUbahNama,KodebrgM=@KodebrgM,PPH=@PPH

  where nobukti=@nobukti and urut=@urut

  if @@error<>0  goto jikasalah



if @choice='D'

if @IsRev=1 

  delete DBSORevDET where nobukti=@nobukti and  urut=@urut and revisike=@RevKe

   if not exists( select nobukti from DBSORevDET where nobukti=@nobukti and revisike=@RevKe)

     delete DBSORev where nobukti=@nobukti


  else

  delete DBSODET where nobukti=@nobukti and  urut=@urut

  if @@error<>0  goto jikasalah 

  if not exists( select nobukti from DBSODET where nobukti=@nobukti)

  delete DBSO where nobukti=@nobukti

    if @@error<>0  goto jikasalah

    delete dbSpesifikasiSO where nobukti=@nobukti

    if @@error<>0  goto jikasalah


--exec sp_RefreshOutSO @NoBukti


Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- sp_TransSPB
CREATE PROCEDURE IF NOT EXISTS sp_TransSPB AS -- DECLARE REMOVED,@KodeSupplier Varchar(15)



tran



--Select Harga=@Harga from DBSODET where KODEBRG in(Select KODEBRG from dbSPPDet where NoBukti=@NoSPP and KodeBrg=@KODEBRG)

--and NOBUKTI in(Select NoSO from dbSPPDet where NoBukti=@NoSPP and KodeBrg=@KODEBRG)

select @Harga=b.HARGA from dbSPPDet a 

                  Left Outer Join DBSODET b on a.NoSO=b.NOBUKTI and a.UrutSO=b.URUT

where a.NoBukti=@NoSPP and b.KodeBrg=@KODEBRG and a.NoSO=b.NOBUKTI and a.UrutSO=b.URUT   

Group by b.HARGA              

if @Namaserver='DBBCA' 

-- SET REMOVED'CS000007'



else

-- SET REMOVED'BS0000011'



   if @Choice='I'

   select @Urut=COALESCE(max(urut),0)+1 from dbSPBDet Where NoBukti=@NoBukti

  	   if not exists(Select nobukti from dbSPB where NoBukti=@NOBUKTI)

  	   insert into dbSPB (Devisi,NoBukti, NoUrut, Tanggal, NoSPP, KodeCustSupp, NoPolKend, 

    		    Container, NoContainer, NoSeal,Catatan, IDUser, Sopir, KodeExp, NoResi, JumlahTagihan, FlagTipe)

		   values (@Devisi,@NoBukti, @NoUrut, @Tanggal, @NoSPP, @KodeCustSupp, @NoPolKend, 

    		    @Container, @NoContainer, @NoSeal, @Catatan, @IDUser, @Sopir, @KodeExp, @NoResi, @JumlahTagihan, @FlagTipe)

		   if @@error<>0  goto jikasalah


  	   insert into dbSPBDet (NoBukti, Urut, NoSPP, UrutSPP, KodeBrg, QNT, QNT2, SAT_1, SAT_2, NOSAT, ISI, NetW, GrossW, Namabrg, KodeGdg,isCetakKitir,IsDO)

	   values (@NoBukti, @Urut, @NoSPP, @UrutSPP, @KodeBrg,  @QNT, @QNT2, @SAT_1, @SAT_2, @NOSAT, @ISI, @NetW, @GrossW, @Namabrg, @Kodegdg,@IsBedaNama,@IsDO)

	   if @@error<>0  goto jikasalah

	   ----

	   if @IsDO=1 

	   exec [Sp_Beli] 'I',@NOBUKTI,@NoUrut,@TANGGAL,@TANGGAL,@KodeSupplier,'G01',0,'','','IDR',1,

	    0,1,0,0 ,0,0,@Urut,@KodeBrg,@Qnt,@Nosat,@SAT_1,@Isi,@Harga,0,0,'-',0,0,0,'',@Qnt2,0,0,'' 

	   

	   else

	   exec [Sp_Beli] 'D',@NOBUKTI,@NoUrut,@TANGGAL,@TANGGAL,@KodeSupplier,'G01',0,'','','IDR',1,

	    0,0,0,0 ,0,0,@Urut,@KodeBrg,@Qnt,@Nosat,@SAT_1,@Isi,@Harga,0,0,'-',0,0,0,'',@Qnt2,0,0,'' 


   if @Choice='U'

   update dbSPBDET set KodeBrg=@KodeBrg, QNT=@QNT, QNT2=@QNT2, SAT_1=@SAT_1, SAT_2=@SAT_2, NOSAT=@NOSAT, ISI=@ISI, Namabrg=@Namabrg,

  					   NetW=@NetW, GrossW=@GrossW, KodeGdg=@Kodegdg,isCetakKitir=@IsBedaNama,IsDO=@IsDO,KodeBrgA=@KodeBrgA

  	   where NoBukti=@NoBukti and Urut=@Urut

	   if @@error<>0  goto jikasalah

	   -------

	   exec sp_koreksipersj @NoBukti,@Urut

	   ----

	   if @IsDO=1 

	   exec [Sp_Beli] 'I',@NOBUKTI,@NoUrut,@TANGGAL,@TANGGAL,@KodeSupplier,'G01',0,'','','IDR',1,

	    0,1,0,0 ,0,0,@Urut,@KodeBrg,@Qnt,@Nosat,@SAT_1,@Isi,@Harga,0,0,'-',0,0,0,'',@Qnt2,0,0,'' 

	   

	   else

	   exec [Sp_Beli] 'D',@NOBUKTI,@NoUrut,@TANGGAL,@TANGGAL,@KodeSupplier,'G01',0,'','','IDR',1,

	    0,0,0,0 ,0,0,@Urut,@KodeBrg,@Qnt,@Nosat,@SAT_1,@Isi,@Harga,0,0,'-',0,0,0,'',@Qnt2,0,0,'' 


   if @Choice='D'

   delete dbSPBDET where NoBukti=@NoBukti and Urut=@Urut 

	   if @@error<>0  goto jikasalah

  	   if not exists (select NoBukti from dbSPBDET where NoBukti=@NoBukti)

  	   delete dbSPB where NoBukti=@NoBukti

		   if @@error<>0  goto jikasalah

		    exec [Sp_Beli] 'D',@NOBUKTI,@NoUrut,@TANGGAL,@TANGGAL,@KodeSupplier,'G01',0,'','','IDR',1,

	    0,0,0,0 ,0,0,@Urut,@KodeBrg,@Qnt,@Nosat,@SAT_1,@Isi,@Harga,0,0,'-',0,0,0,'',@Qnt2,0,0,''


Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- sp_TransSPP
CREATE PROCEDURE IF NOT EXISTS sp_TransSPP AS tran

   if @Choice='I'

   select @Urut=COALESCE(max(urut),0)+1 from dbSPPDet Where NoBukti=@NoBukti

  	   if not Exists(Select Nobukti from dbSPP where NoBukti=@NOBUKTI)

  	   insert into dbSPP (Devisi,NoBukti, NoUrut, Tanggal, NoSHIP, NoPesan, KodeCustSupp, TglKirim, NoLC, Catatan, IDUser, NoAlamatKirim, NamaKirim, AlamatKirim, FlagTipe,Tf,Do)

		   values (@Devisi,@NoBukti, @NoUrut, @Tanggal, @NoSHIP, @NoPesan, @KodeCustSupp, @TglKirim, @NoLC, @Catatan, @IDUser, @noAlamatKirim, @NamaKirim, @Alamatkirim, @FlagTipe,0,@Choice)

		   if @@error<>0  goto jikasalah


  	   insert into dbSPPDet (NoBukti, Urut, NoSO, UrutSO, KodeBrg, QNT, QNT2, SAT_1, SAT_2, NOSAT, ISI, NetW, GrossW, KetDetail, NamaBrg,Mesurement, ShippingMark, kodegdg,Tf,Do)

	   values (@NoBukti, @Urut, @NoSHIP, @UrutSHIP, @KodeBrg, @QNT, @QNT2, @SAT_1, @SAT_2, @NOSAT, @ISI, @NetW, @GrossW, @KetDetail, @Namabrg, @Mesurement, @ShippingMark, @Kodegdg,0,@Choice)

	   if @@error<>0  goto jikasalah

    else

   if @Choice='U'

   update dbSPPDET set UrutSO=@UrutSHIP, KodeBrg=@KodeBrg, QNT=@QNT, QNT2=@QNT2, SAT_1=@SAT_1, SAT_2=@SAT_2, NOSAT=@NOSAT, ISI=@ISI, 

  		   NetW=@NetW, GrossW=@GrossW, KetDetail=@KetDetail, NamaBrg=@Namabrg, NoSO=@NoSHIP,Mesurement=@Mesurement, ShippingMark=@ShippingMark,

             kodegdg=@Kodegdg,QntBatal=@QntBatal,KetBatal=@KetBatal,Tf=0,Do=@Choice 

  	   where NoBukti=@NoBukti and Urut=@Urut

	   if @@error<>0  goto jikasalah

    else

   if @Choice='D'

   delete dbSPPDET where NoBukti=@NoBukti and Urut=@Urut 

       insert TempDelDataDet

       select @Nobukti,@Urut,'dbSPPDET'

	   if @@error<>0  goto jikasalah

  	   if not exists (select NoBukti from dbSPPDET where NoBukti=@NoBukti)

  	   delete dbSPP where NoBukti=@NoBukti

    	        insert TempDelData

               select @Nobukti,'DBSPP'

		   if @@error<>0  goto jikasalah


Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- sp_TransTarifSPB
CREATE PROCEDURE IF NOT EXISTS sp_TransTarifSPB AS tran



if @choice='I'

select @Urut=COALESCE(max(Urut),0)+1 from dbTarifSPB Where NoBukti=@NoBukti

	If @Urut is null -- SET REMOVED1

	

	insert into dbTarifSPB (NoBukti, Urut, NamaTarif, Satuan, Qty, RpTarif, RpTotalTarif)

	values (@NoBukti, @Urut, @NamaTarif, @Satuan, @Qty, @RpTarif, @RpTotalTarif)

	if @@error<>0 goto jikasalah


if @Choice='U'

update dbTarifSPB 

	set NamaTarif=@NamaTarif, Satuan=@Satuan, Qty=@Qty, RpTarif=@RpTarif, RpTotalTarif=@RpTotalTarif

	where NoBukti=@NoBukti and Urut=@Urut

	if @@error<>0  goto jikasalah

	if @@error<>0  goto jikasalah	



if @Choice='D'

delete dbTarifSPB where NoBukti=@NoBukti and Urut=@Urut

	if @@error<>0  goto jikasalah	 

	if not exists 

	  (select NoBukti from dbSPBDet where NoBukti=@NoBukti

	  union all select NoBukti from dbTarifSPB where NoBukti=@NoBukti)

	delete dbSPB where NoBukti=@NoBukti

		if @@error<>0  goto jikasalah	


Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- SP_UBAHKEMASAN
CREATE PROCEDURE IF NOT EXISTS SP_UBAHKEMASAN AS tran

if @choice='I'

select @urut=COALESCE(max(urut),0)+1 from DBUBAHKEMASANdet Where NoBukti=@NoBukti

  If @urut is null -- SET REMOVED1

  if not exists(select * from DBUBAHKEMASAN Where NoBukti=@NoBukti) 

  insert into DBUBAHKEMASAN (Devisi,NOBUKTI,NOURUT,TANGGAL,NOTE)

    values (@devisi,@NOBUKTI,@noURUT,@TANGGAL,@NOTE)


  insert into DBUBAHKEMASANDET (NOBUKTI,URUT,KODEBRG,Kodegdg,SATUAN,NOSAT,ISI,QNTDB,QNTCR,HARGA)

  values(@NOBUKTI,@URUT,@KODEBRG,@Kodegdg,@SATUAN,@NOSAT,@ISI,@QNTDB,@QNTCR,@HARGA)

  --values('SJY/KMBJ/0413/0001',1,'AE2.B008','G001','ML',1,1,0,100,10)



if @choice='U'

update DBUBAHKEMASANDET set Kodebrg=@KODEBRG,Kodegdg=@Kodegdg,Satuan=@SATUAN,Nosat=@NOSAT,Isi=@ISI,QntDb=@QNTDB,QntCR=@QNTCR,Harga=@HARGA

  where nobukti=@nobukti and urut=@urut



if @choice='D'

delete DBUBAHKEMASANDET where nobukti=@nobukti and  urut=@urut 

  if not exists( select nobukti from DBUBAHKEMASANDET where nobukti=@nobukti)

  delete DBUBAHKEMASAN where nobukti=@nobukti


--if @@error<>0  goto jikasalah

Commit tran

Return

JikaSalah: Rollback tran

           Return;

-- Sp_UpdateBeli
CREATE PROCEDURE IF NOT EXISTS Sp_UpdateBeli AS ALTER TABLE dbBeliDet DISABLE TRIGGER All

update dbBeliDet set PPN=B.PPN, Disc=B.Disc, Kurs=B.Kurs, ByAngkut=0

from dbBeli B 

where  B.NoBukti=DBBELIDET.NoBukti and B.NoBukti=@NOBUKTI



ALTER TABLE dbBeliDet ENABLE TRIGGER All;

-- Sp_UpdateInvoicePL
CREATE PROCEDURE IF NOT EXISTS Sp_UpdateInvoicePL AS ALTER TABLE dbinvoicePLDet DISABLE TRIGGER All



update dbInvoicePLDet set PPN=B.PPN, Kurs=B.Kurs,FRetensi=COALESCE(B.FRetensi,0)

from	dbInvoicePLDet A

left outer join dbInvoicePL B on B.NoBukti=A.NoBukti

/*left outer join

	(

	Select 	X.NoBukti, Y.Urut, Y.KodeBrg,

		case when COALESCE(Z.TotSubTotal,0)=0 then 0 else round((Y.SubTotal)/Z.TotSubTotal,2)  Beban

	From dbInvoicePL X

	Left Outer join dbInvoicePLDet Y on Y.NoBukti=X.NoBukti

	Left Outer Join vwRpDetInvoicePL Z on Z.NoBukti=X.NoBukti

	where	X.NoBukti=@NoBukti

	) C on C.NoBukti=A.NoBukti and C.Urut=A.Urut*/

where A.NoBukti=@NOBUKTI



ALTER TABLE dbInvoicePLDet ENABLE TRIGGER All;

-- sp_updateMenu
CREATE PROCEDURE IF NOT EXISTS sp_updateMenu AS insert into dbflmenu(userid,L1,HASACCESS,isTambah,isHapus,iskoreksi,IsCetak,isExport,TIPE)

	select @userid,L1,0,0,0,0,0,0,TIPE

	from dbflmenu

	where userid='SA' and l1 not in (select l1 from dbflmenu where userid=@userid);

-- sp_updateMenuReport
CREATE PROCEDURE IF NOT EXISTS sp_updateMenuReport AS insert into dbflmenureport (userid,L1,Access)

	select @userid,L1,0

	from dbflmenureport

	where userid='SA' and l1 not in (select l1 from dbflmenureport where userid=@userid);

-- sp_UpdateNilaiBeli
CREATE PROCEDURE IF NOT EXISTS sp_UpdateNilaiBeli AS update DBBELI 

set		NILAIPOT=B.TotDiskon, NILAIDPP=B.TotDPP, NILAIPPN=B.TotPPN, NILAINET=B.TotNet,

		NILAIPOTRp=B.TotDiskonRp, NILAIDPPRp=B.TotDPPRp, NILAIPPNRp=B.TotPPNRp, NILAINETRp=B.TotNetRp

from DBBELI A

left outer join vwRpDetBeli B on B.NoBukti=A.NOBUKTI

where A.NOBUKTI=@NoBukti;

-- Sp_UpdatePNW
CREATE PROCEDURE IF NOT EXISTS Sp_UpdatePNW AS update dbPNWDet set PPN=B.PPN, Disc=B.Disc, Kurs=B.Kurs, BYANGKUT=COALESCE(C.Beban,0)

from	dbPNWDet A

left outer join dbPNW B on B.NoBukti=A.NoBukti

left outer join

	(

	Select 	X.NoBukti, Y.Urut, Y.KodeBrg,

		case when COALESCE(Z.TotSubTotal,0)=0 then 0 else round((Y.SubTotal*X.Handling)/Z.TotSubTotal,2)  Beban

	From dbPNW X

	Left Outer join dbPNWDet Y on Y.NoBukti=X.NoBukti

	Left Outer Join vwRpDetPNW Z on Z.NoBukti=X.NoBukti

	where	X.NoBukti=@NoBukti

	) C on C.NoBukti=A.NoBukti and C.Urut=A.Urut

where A.NoBukti=@NOBUKTI



-- agar total biaya angkut di detail sama dengan di header

-- DECLARE REMOVED, @TotByANgkut numeric(18,2), @TotByAngkut_ numeric(18,2)

select @UrutMax=max(Urut) from dbPNWDet where NoBukti=@NoBukti



select @TotByAngkut=COALESCE((select Handling from dbPNW where NoBukti=@NoBukti),0)

select @TotByAngkut_=COALESCE((select sum(BYANGKUT) from dbPNWDet where NoBukti=@NoBukti and Urut<>@UrutMax),0)



if @TotByAngkut<>0

update dbPNWDet set BYAngkut=@TotByAngkut-@TotByAngkut_ where NoBukti=@NoBukti and Urut=@UrutMax;

-- Sp_UpdatePO
CREATE PROCEDURE IF NOT EXISTS Sp_UpdatePO AS ALTER TABLE DBPODet DISABLE TRIGGER All



update DBPODet set PPN=B.PPN, Disc=B.Disc, Kurs=B.Kurs, BYANGKUT=COALESCE(C.Beban,0)

from	DBPODet A

left outer join DBPO B on B.NoBukti=A.NoBukti

left outer join

	(

	Select 	X.NoBukti, Y.Urut, Y.KodeBrg,

		case when COALESCE(Z.TotSubTotal,0)=0 then 0 else round((Y.SubTotal*X.Handling)/Z.TotSubTotal,2)  Beban

	From DBPO X

	Left Outer join DBPODet Y on Y.NoBukti=X.NoBukti

	Left Outer Join vwRpDetSO Z on Z.NoBukti=X.NoBukti

	where	X.NoBukti=@NoBukti

	) C on C.NoBukti=A.NoBukti and C.Urut=A.Urut

where A.NoBukti=@NOBUKTI



-- agar total biaya angkut di detail sama dengan di header

-- DECLARE REMOVED, @TotByANgkut numeric(18,2), @TotByAngkut_ numeric(18,2)

select @UrutMax=max(Urut) from DBPODet where NoBukti=@NoBukti



select @TotByAngkut=COALESCE((select Handling from DBPO where NoBukti=@NoBukti),0)

select @TotByAngkut_=COALESCE((select sum(BYANGKUT) from DBPODet where NoBukti=@NoBukti and Urut<>@UrutMax),0)



if @TotByAngkut<>0

update DBPODet set BYAngkut=@TotByAngkut-@TotByAngkut_ where NoBukti=@NoBukti and Urut=@UrutMax


-- IF EXISTS REMOVED
B on b.NOBUKTI=a.NOBUKTI

            where b.NoPO=@NOBUKTI and (b.TIPEBAYAR<>a.TIPEBAYAR or b.HARI<>a.HARI or b.PPN<>a.PPN)) 

 update DBBELI set TIPEBAYAR=b.TIPEBAYAR,HARI=b.HARI,PPN=b.PPN

   from DBBELI a

   left outer join 

   ( select a.NOBUKTI,b.NoPO,c.TIPEBAYAR,c.HARI,c.PPN from  DBBELI a

     left outer join DBBELIDET b on b.NOBUKTI=a.NOBUKTI

     left outer join DBPO c on c.NOBUKTI=b.NoPO

     where b.NoPO=@NOBUKTI

     group by a.NOBUKTI,c.TIPEBAYAR,c.HARI,b.NoPO,c.PPN

   ) B on b.NOBUKTI=a.NOBUKTI

   where b.NoPO=@NOBUKTI


-- IF EXISTS REMOVED
)

update DBBELIDET set HARGA=b.HARGA,PPN=b.PPN from DBBELIDET a

  left outer join DBPODET b on b.NOBUKTI=a.NoPO and b.URUT=a.UrutPO

  where b.NOBUKTI=@NOBUKTI


-- IF EXISTS REMOVED
B on b.NOBUKTI=a.NOBUKTI

            where b.NoPO=@NOBUKTI and (b.TIPEBAYAR<>a.TIPEBAYAR or b.HARI<>a.HARI)) 

   Or

   Exists (select a.NOBUKTI from DBBELIDET a

   left outer join DBPODET b on b.NOBUKTI=a.NoPO and b.URUT=a.UrutPO

   where b.NOBUKTI=@NOBUKTI and (b.HARGA<>a.HARGA or b.PPN<>a.PPN))

   delete dbjurnaloto where NoBukti in (select case when a.NOBUKTI like 'BC%' then STUFF(a.NOBUKTI,5,0,'BMM-') else STUFF(a.NOBUKTI,4,0,'BMM-') 

                                     from DBBELIDET a left outer join DBPO b on b.NOBUKTI=a.NoPO where a.NoPO=@NOBUKTI  group by a.NOBUKTI,a.NoPO)

                       and TipeTrans='PBL'

delete DBHUTPIUT where NoFaktur in (select a.NOBUKTI

                                     from DBBELIDET a left outer join DBPO b on b.NOBUKTI=a.NoPO where a.NoPO=@NOBUKTI  group by a.NOBUKTI,a.NoPO) 

                       and Tipe='HT' and TipeTrans='T'



-- DECLARE REMOVED, @NoJurnal varchar(30)

Declare mydata cursor for

  select a.NOBUKTI

  from DBBELIDET a 

  left outer join dbbeli a1 on a1.nobukti=a.nobukti

  left outer join DBPO b on b.NOBUKTI=a.NoPO  

  where a.NoPO=@NOBUKTI and a1.IsOtorisasi1=1 group by a.Nobukti,a.nopo



open mydata

fetch next from mydata into @nobukti

while @@FETCH_STATUS=0

update DBBELI set NoJurnal=case when NOBUKTI like 'BC%' then STUFF(NOBUKTI,5,0,'BMM-') else STUFF(NOBUKTI,4,0,'BMM-') ,

  NoUrutJurnal=NOURUT,TglJurnal=TANGGAL from DBBELI 

  where NOBUKTI=@nobukti and IsOtorisasi1=1 and (NoJurnal='' or NoJurnal is null)

  

  Select @nobukti=Nobukti, 

         @isOto=Cast(Case when Case when IsOtorisasi1=1 then 1 else 0 +

		           Case when IsOtorisasi2=1 then 1 else 0 +

		           Case when IsOtorisasi3=1 then 1 else 0 +

	  	           Case when IsOtorisasi4=1 then 1 else 0 +

		           Case when IsOtorisasi5=1 then 1 else 0 =MaxOL then 0

	                else 1

                      As INTEGER), @NoJurnal=NoJurnal 

  from DBBELI 

  where NOBUKTI=@nobukti and NoJurnal<>''



  Delete from dbo.dbJurnalOto where Nobukti=@NoJurnal

  Delete From dbo.DBHUTPIUT where NoBukti=@NoJurnal and TipeTrans='T'



  if @isOto=0

  Insert into DBO.dbJurnalOTO(NoBukti, Tanggal, Devisi, Note, Lampiran, IsOtorisasi1, OtoUser1, TglOto1, IsOtorisasi2, OtoUser2, TglOto2, IsOtorisasi3, OtoUser3, TglOto3, IsOtorisasi4, OtoUser4, 

                                TglOto4, IsOtorisasi5, OtoUser5, TglOto5, Urut, Perkiraan, Lawan, Keterangan, Keterangan2, Debet, Kredit, Valas, Kurs, DebetRp, KreditRp, TipeTrans, TPHC, 

                                CustSuppP, CustSuppL, KodeP, KodeL, NoAktivaP, NoAktivaL, StatusAktivaP, StatusAktivaL, Nobon, KodeBag, StatusGiro,  Jenis, NOURUT)

    Select  NOBUKTI, TANGGAL, DEVISI, NOTE, LAMPIRAN, IsOtorisasi1, OTOUSER1, TGLOTO1, ISOTORISASI2, OTOUSER2, TGLOTO2, ISOTORISASI3, OTOUSER3, TGLOTO3, 

            ISOTORISASI4, OTOUSER4, TGLOTO4, ISOTORISASI5, OTOUSER5, TGLOTO5,CAST(ROW_NUMBER() Over(PARTITION BY Nobukti Order by Nobukti) As int) URUT, PERKIRAAN, LAWAN, KETERANGAN, KETERANGAN2, DEBET, KREDIT, VALAS, 

            KURS, DEBETRP, KREDITRP, TIPETRANS, TPHC, CUSTSUPPP, CUSTSUPPL, KODEP, KODEL, NOAKTIVAP, NOAKTIVAL, STATUSAKTIVAP, STATUSAKTIVAL, NOBON, 

            KODEBAG, STATUSGIRO,  JENIS, NOURUT

    From Dbo.fnc_JurnalBP(@nobukti)



    Insert into dbo.DBHUTPIUT(NoFaktur, NoRetur, TipeTrans, KodeCustSupp, NoBukti, NoMsk, Urut, Tanggal, JatuhTempo, 

                              Debet, Kredit,  Valas, Kurs,DebetD, KreditD, 

  

                              KodeSales, Tipe, Perkiraan, Catatan, NOINVOICE,  KodeVls_, Kurs_)

    Select  NoFaktur, NoRetur, Tipetrans, KODECUSTSUPP, Nobukti, NoMsk, urut, TANGGAL, JatuhTempo, 

            Debet, Kredit,  Valas, KURS, 

            Case when Valas='IDR' then 0.00 else DebetD  DebetD,  

            Case when Valas='IDR' then 0.00 else KreditD  KreditD, 

                      KodeSales, Tipe, PERKIRAAN, Catatan, NoInvoice, KodeVls_, Kurs_

    from Dbo.fnc_PostPembelian(@nobukti)    


fetch next from mydata into @nobukti


close mydata

deallocate mydata


ALTER TABLE DBPODet ENABLE TRIGGER All;

-- Sp_UpdateRBeli
CREATE PROCEDURE IF NOT EXISTS Sp_UpdateRBeli AS ALTER TABLE dbRBeliDet DISABLE TRIGGER All



update dbRBeliDet set PPN=B.PPN, Disc=B.Disc, Kurs=B.Kurs, ByAngkut=COALESCE(C.Beban,0)

from	dbRBeliDet A

left outer join dbRBeli B on B.NoBukti=A.NoBukti

left outer join

	(

	Select 	X.NoBukti, Y.Urut, Y.KodeBrg,

		0.00 Beban

	From dbRBeli X

	Left Outer join dbRBeliDet Y on Y.NoBukti=X.NoBukti

	Left Outer Join vwRpDetRBeli Z on Z.NoBukti=X.NoBukti

	where	X.NoBukti=@NoBukti

	) C on C.NoBukti=A.NoBukti and C.Urut=A.Urut

where A.NoBukti=@NOBUKTI



ALTER TABLE dbRBeliDet ENABLE TRIGGER All;

-- Sp_UpdateRInvoicePL
CREATE PROCEDURE IF NOT EXISTS Sp_UpdateRInvoicePL AS update dbRInvoicePLDet set PPN=B.PPN, Kurs=B.Kurs,FRetensi=COALESCE(B.FRetensi,0)

from	dbRInvoicePLDet A

left outer join dbRInvoicePL B on B.NoBukti=A.NoBukti

/*left outer join

	(

	Select 	X.NoBukti, Y.Urut, Y.KodeBrg,

		case when COALESCE(Z.TotSubTotal,0)=0 then 0 else round((Y.SubTotal)/Z.TotSubTotal,2)  Beban

	From dbInvoicePL X

	Left Outer join dbInvoicePLDet Y on Y.NoBukti=X.NoBukti

	Left Outer Join vwRpDetInvoicePL Z on Z.NoBukti=X.NoBukti

	where	X.NoBukti=@NoBukti

	) C on C.NoBukti=A.NoBukti and C.Urut=A.Urut*/

where A.NoBukti=@NOBUKTI;

-- Sp_UpdateSO
CREATE PROCEDURE IF NOT EXISTS Sp_UpdateSO AS ALTER TABLE dbSODet DISABLE TRIGGER All



update dbSODet set PPN=B.PPN, Disc=case when COALESCE(A.KodeBrgM,'')='' Then B.Disc else 0 , Kurs=B.Kurs, BYANGKUT=COALESCE(C.Beban,0)

from	dbSODet A

left outer join dbSO B on B.NoBukti=A.NoBukti

left outer join

	(

	Select 	X.NoBukti, Y.Urut, Y.KodeBrg,

		case when COALESCE(Z.TotSubTotal,0)=0 then 0 else round((Y.SubTotal*X.Handling)/Z.TotSubTotal,2)  Beban

	From dbSO X

	Left Outer join dbSODet Y on Y.NoBukti=X.NoBukti

	Left Outer Join vwRpDetSO Z on Z.NoBukti=X.NoBukti

	where	X.NoBukti=@NoBukti

	) C on C.NoBukti=A.NoBukti and C.Urut=A.Urut

where A.NoBukti=@NOBUKTI 



-- agar total biaya angkut di detail sama dengan di header

-- DECLARE REMOVED, @TotByANgkut numeric(18,2), @TotByAngkut_ numeric(18,2)

select @UrutMax=max(Urut) from dbSODet where NoBukti=@NoBukti



select @TotByAngkut=COALESCE((select Handling from dbSO where NoBukti=@NoBukti),0)

select @TotByAngkut_=COALESCE((select sum(BYANGKUT) from dbSODet where NoBukti=@NoBukti and Urut<>@UrutMax),0)



if @TotByAngkut<>0

update dbSODet set BYAngkut=@TotByAngkut-@TotByAngkut_ where NoBukti=@NoBukti and Urut=@UrutMax


ALTER TABLE dbSODet ENABLE TRIGGER All;

-- sp_UpdateTransaksiPPN
CREATE PROCEDURE IF NOT EXISTS sp_UpdateTransaksiPPN AS Exec ('Update '+@NamaTable+' set NilaiPPN=b.NilaiPPN from '+@NamaTable+' a

Left Outer Join '+@NamaTable2+' c on c.NOBUKTI=a.NOBUKTI

Left Outer Join dbPPN b on  c.TANGGAL between b.tglawal and b.tglakhir

where c.TANGGAL between b.tglawal and b.tglakhir and a.NOBUKTI='''+@NoBukti+'''

');

-- sp_upgraddiagrams
CREATE PROCEDURE IF NOT EXISTS sp_upgraddiagrams AS IF OBJECT_ID(N'dbo.sysdiagrams') IS NOT NULL

			return 0;

	

		CREATE TABLE dbo.sysdiagrams

		(

			name sysname NOT NULL,

			principal_id int NOT NULL,	-- we may change it to varbinary(85)

			diagram_id int PRIMARY KEY IDENTITY,

			version int,

	

			definition varbinary(max)

			CONSTRAINT UK_principal_name UNIQUE

			(

				principal_id,

				name

			)

		);


		/* Add this if we need to have some form of extended properties for diagrams */

		/*

		IF OBJECT_ID(N'dbo.sysdiagram_properties') IS NULL

		CREATE TABLE dbo.sysdiagram_properties

			(

				diagram_id int,

				name sysname,

				value varbinary(max) NOT NULL

			)

		

		*/



		IF OBJECT_ID(N'dbo.dtproperties') IS NOT NULL

		insert into dbo.sysdiagrams

			(

				[name],

				[principal_id],

				[version],

				[definition]

			)

			select	 

				CAST(dgnm.[uvalue] AS sysname),

				DATABASE_PRINCIPAL_ID(N'dbo'),			-- will change to the sid of sa

				0,							-- zero for old format, dgdef.[version],

				dgdef.[lvalue]

			from dbo.[dtproperties] dgnm

				inner join dbo.[dtproperties] dggd on dggd.[property] = 'DtgSchemaGUID' and dggd.[objectid] = dgnm.[objectid]	

				inner join dbo.[dtproperties] dgdef on dgdef.[property] = 'DtgSchemaDATA' and dgdef.[objectid] = dgnm.[objectid]

				

			where dgnm.[property] = 'DtgSchemaNAME' and dggd.[uvalue] like N'_EA3E6268-D998-11CE-9454-00AA00A3F36E_' 

			return 2;

		

		return 1;

-- SP_VALAS
CREATE PROCEDURE IF NOT EXISTS SP_VALAS AS tran

if @choice='I'

insert into dbValas (KodeVls, NamaVls, Kurs, Simbol )

  values (@KodeVls, @NamaVls, @Kurs, @Simbol)



if @choice='U'

update dbValas set kodeVls=@kodeVls, NamaVls=@NamaVls, Kurs=@Kurs, Simbol=@Simbol

  where KodeVls=@OldKode



if @choice='D'

delete dbValas where (KodeVls=@OldKode and KodeVls<>'IDR')	



if @@error <> 0 goto jikasalah

commit tran

return

jikasalah:

	rollback tran

	raiserror('Proses Input Data Gagal',16,1)

	return;

-- sp_viewBarang
CREATE PROCEDURE IF NOT EXISTS sp_viewBarang AS -- IF EXISTS REMOVED
Select A.KODEBRG, A.NAMABRG, A.SAT1 Sat_1, A.Sat2 Sat_2, A.Isi2 Isi,b.QntG01BCA,b.Qnt2G01BCA,b.QntG01CA,b.Qnt2G01CA 

            from dbBarang A 

             left Outer Join (select Kodebrg,

                     Sum(Case when Kodegdg='G01' Then QntSaldo else 0 )QntG01BCA,Sum(Case when Kodegdg='G01' Then Qnt2Saldo else 0 )Qnt2G01BCA, 

                     Sum(Case when Kodegdg='G01@CA' Then QntSaldo else 0 )QntG01CA,Sum(Case when Kodegdg='G01@CA' Then Qnt2Saldo else 0 )Qnt2G01CA 

                     from vwKartuStock a 

                     where  Bulan=MONTH(@Tanggal) and Tahun=YEAR(@Tanggal) and Tanggal<=@Tanggal and a.Kodebrg = @Pilihan

                     group by kodebrg)b on a.KODEBRG=b.Kodebrg  

            where a.KODEBRG = @Pilihan 

            order by A.KodeBrg



else

Select A.KODEBRG, A.NAMABRG, A.SAT1 Sat_1, A.Sat2 Sat_2, A.Isi2 Isi,b.QntG01BCA,b.Qnt2G01BCA,b.QntG01CA,b.Qnt2G01CA 

            from dbBarang A 

             left Outer Join (select Kodebrg,

                     Sum(Case when Kodegdg='G01' Then QntSaldo else 0 )QntG01BCA,Sum(Case when Kodegdg='G01' Then Qnt2Saldo else 0 )Qnt2G01BCA, 

                     Sum(Case when Kodegdg='G01@CA' Then QntSaldo else 0 )QntG01CA,Sum(Case when Kodegdg='G01@CA' Then Qnt2Saldo else 0 )Qnt2G01CA 

                     from vwKartuStock a 

                     where  Bulan=MONTH(@Tanggal) and Tahun=YEAR(@Tanggal) and Tanggal<=@Tanggal and a.NamaBrg like @Pilihan+'%'

                     group by kodebrg)b on a.KODEBRG=b.Kodebrg  

            where a.NamaBrg like @Pilihan+'%'  

            order by A.KodeBrg;

-- sp_ViewReportBukuTambahan
CREATE PROCEDURE IF NOT EXISTS sp_ViewReportBukuTambahan AS -- DECLARE REMOVED

select @mtgl=cast(month(@tglawal) as varchar(2))+'/01/'+cast(year(@tglawal) as varchar(4))

-- SET REMOVEDcase when @devisi in ('-','') then '%' else @Devisi 



 select b.keterangan as Nama, a.noAcc as perkiraan, '' as transaksi, '' as namaacc, 

 max(tanggal)as tanggal, ' Saldo Awal' as NoBukti, '' as keterangan,

           ''as lawan, 0 as saldoawal, 0 as debet, 0 as kredit,

 sum((case when a.transaksi='D' then Debet-kredit

           when a.transaksi='K' then Kredit-Debet 

           else Saldoawal )) as saldoakhir, max(a.urut) as urut,

 0 as debetd, 0 as kreditd,

 sum((case when a.transaksi='D' then Debetd-kreditd

           when a.transaksi='K' then KreditD-Debetd 

           else Saldoawald )) as saldoakhird, '' NoUrut

from dbtempbkbesar a,dbperkiraan b

where a.noacc=b.perkiraan and a.noacc>=@awal and a.noacc<=@akhir and tanggal<@tglawal and bulan=month(@tglawal) and

           tahun=year(@tglawal) and (a.devisi Like @devisi)

	and a.noacc in (select perkiraan from dbAksesPerkiraan where userid=@IdUser) 

group by a.noacc,b.keterangan

union

select b.keterangan as Nama, a.noacc as perkiraan, a.transaksi, b.keterangan as namaacc, a.tanggal, a.nobukti, 

a.keterangan,

  (case when a.perkiraan=a.NoACC then a.Lawan

		       when a.lawan=a.NoACC then a.Perkiraan

		  ) lawan, a.saldoawal,

          a.debet, a.kredit,

 (case when a.transaksi='D' then Debet-kredit

       when a.transaksi='K' then kredit-Debet 

       else Saldoawal ) as saldoakhir,a.urut,

          a.debetd, a.kreditd,

 (case when a.transaksi='D' then Debetd-kreditd

       when a.transaksi='K' then kreditD-Debetd 

       else Saldoawald ) as saldoakhird, substring(a.NoBukti,10,5) NoUrut

from dbtempbkbesar a,dbPerkiraan b

where a.noacc=b.perkiraan and a.noacc>=@awal and a.noacc<=@akhir and a.tanggal>=@tglawal and tanggal<=@tglakhir  and (a.devisi Like @devisi)

	and a.noacc in (select perkiraan from dbAksesPerkiraan where userid=@IdUser) 

order by a.noacc,a.tanggal,NoUrut,a.nobukti,a.urut;

-- sp_viewSO
CREATE PROCEDURE IF NOT EXISTS sp_viewSO AS -- IF EXISTS REMOVED
select a.KodeBrg, a.NamaBrg, a.Sat1, a.Hrg1_1,Hrg1_2 HPP,COALESCE(IsJasa,0)IsJasa,COALESCE(nFix,0)nFix,b.QntG01BCA,b.Qnt2G01BCA,b.QntG01CA,b.Qnt2G01CA

from vwBarang a

left Outer Join (select Kodebrg,

                 Sum(Case when Kodegdg='G01' Then QntSaldo else 0 )QntG01BCA,Sum(Case when Kodegdg='G01' Then Qnt2Saldo else 0 )Qnt2G01BCA, 

                 Sum(Case when Kodegdg='G01@CA' Then QntSaldo else 0 )QntG01CA,Sum(Case when Kodegdg='G01@CA' Then Qnt2Saldo else 0 )Qnt2G01CA 

                 from vwKartuStock a 

                 where  Bulan=MONTH(@Tanggal) and Tahun=YEAR(@Tanggal) and Tanggal<=@Tanggal and a.Kodebrg = @Pilihan

                 group by kodebrg)b on a.KODEBRG=b.Kodebrg 

where a.IsAktif=1 and (a.KodeGrp='FG' or a.KodeGrp='SVC' or COALESCE(IsJasa,0)=1 or COALESCE(IsBarang,0)=1) 

and (a.KODEBRG = @Pilihan) 

Order By a.NAMABRG


else

select a.KodeBrg, a.NamaBrg, a.Sat1, a.Hrg1_1,Hrg1_2 HPP,COALESCE(IsJasa,0)IsJasa,COALESCE(nFix,0)nFix,b.QntG01BCA,b.Qnt2G01BCA,b.QntG01CA,b.Qnt2G01CA

from vwBarang a

left Outer Join (select Kodebrg,

                 Sum(Case when Kodegdg='G01' Then QntSaldo else 0 )QntG01BCA,Sum(Case when Kodegdg='G01' Then Qnt2Saldo else 0 )Qnt2G01BCA, 

                 Sum(Case when Kodegdg='G01@CA' Then QntSaldo else 0 )QntG01CA,Sum(Case when Kodegdg='G01@CA' Then Qnt2Saldo else 0 )Qnt2G01CA 

                 from vwKartuStock a 

                 where  Bulan=MONTH(@Tanggal) and Tahun=YEAR(@Tanggal) and Tanggal<=@Tanggal and a.NamaBrg like @Pilihan+'%'

                 group by kodebrg)b on a.KODEBRG=b.Kodebrg 

where a.IsAktif=1 and (a.KodeGrp='FG' or a.KodeGrp='SVC' or COALESCE(IsJasa,0)=1 or COALESCE(IsBarang,0)=1) 

and (/*a.KodeBrg like @Pilihan+'%' or*/ a.NamaBrg like @Pilihan+'%') 

Order By a.NAMABRG;

-- sp_viewSPBBebas
CREATE PROCEDURE IF NOT EXISTS sp_viewSPBBebas AS -- IF EXISTS REMOVED
Select 0 Urut, A.KODEBRG, A.NAMABRG, 0 Qnt2Sisa, A.Sat2, 0 QntSisa, A.Sat1, A.Isi2, 

                     A.Nfix Konversi,b.QntG01BCA,b.Qnt2G01BCA,b.QntG01CA,b.Qnt2G01CA 

                     from  dbBarang A  

                     left Outer Join (select Kodebrg,

                     Sum(Case when Kodegdg='G01' Then QntSaldo else 0 )QntG01BCA,Sum(Case when Kodegdg='G01' Then Qnt2Saldo else 0 )Qnt2G01BCA, 

                     Sum(Case when Kodegdg='G01@CA' Then QntSaldo else 0 )QntG01CA,Sum(Case when Kodegdg='G01@CA' Then Qnt2Saldo else 0 )Qnt2G01CA 

                     from vwKartuStock a 

                     where  Bulan=MONTH(@Tanggal) and Tahun=YEAR(@Tanggal) and Tanggal<=@Tanggal and A.Kodebrg = @Pilihan

                     group by kodebrg)b on a.KODEBRG=b.Kodebrg 

                     where COALESCE(IsJasa,0)=0 and (A.KODEBRG = @Pilihan ) 

                     order by A.KodeBrg



else

Select 0 Urut, A.KODEBRG, A.NAMABRG, 0 Qnt2Sisa, A.Sat2, 0 QntSisa, A.Sat1, A.Isi2, 

                     A.Nfix Konversi,b.QntG01BCA,b.Qnt2G01BCA,b.QntG01CA,b.Qnt2G01CA 

                     from  dbBarang A  

                     left Outer Join (select Kodebrg,

                     Sum(Case when Kodegdg='G01' Then QntSaldo else 0 )QntG01BCA,Sum(Case when Kodegdg='G01' Then Qnt2Saldo else 0 )Qnt2G01BCA, 

                     Sum(Case when Kodegdg='G01@CA' Then QntSaldo else 0 )QntG01CA,Sum(Case when Kodegdg='G01@CA' Then Qnt2Saldo else 0 )Qnt2G01CA 

                     from vwKartuStock a 

                     where  Bulan=MONTH(@Tanggal) and Tahun=YEAR(@Tanggal) and Tanggal<=@Tanggal and A.NAMABRG like @Pilihan+'%'

                     group by kodebrg)b on a.KODEBRG=b.Kodebrg 

                     where COALESCE(IsJasa,0)=0 and (A.NAMABRG like @Pilihan+'%' ) 

                     order by A.KodeBrg;

-- sp_viewTransfer
CREATE PROCEDURE IF NOT EXISTS sp_viewTransfer AS -- IF EXISTS REMOVED
Select a.Kodebrg,a.namaBrg, a.SAT1 Sat_1, a.Isi1 Isi,0 Awal,0 QntR,0 Qnt,0 Qnt2,b.QntG01BCA,b.Qnt2G01BCA,b.QntG01CA,b.Qnt2G01CA     

          from dbBarang a

          left Outer Join (select Kodebrg,

                     Sum(Case when Kodegdg='G01' Then QntSaldo else 0 )QntG01BCA,Sum(Case when Kodegdg='G01' Then Qnt2Saldo else 0 )Qnt2G01BCA, 

                     Sum(Case when Kodegdg='G01@CA' Then QntSaldo else 0 )QntG01CA,Sum(Case when Kodegdg='G01@CA' Then Qnt2Saldo else 0 )Qnt2G01CA 

                     from vwKartuStock a 

                     where  Bulan=MONTH(@Tanggal) and Tahun=YEAR(@Tanggal) and Tanggal<=@Tanggal and a.Kodebrg = @Pilihan

                     group by kodebrg)b on a.KODEBRG=b.Kodebrg 

          where a.KODEBRG = @Pilihan

          Order By a.KodeBrg     



else

Select a.Kodebrg,a.namaBrg, a.SAT1 Sat_1, a.Isi1 Isi,0 Awal,0 QntR,0 Qnt,0 Qnt2,b.QntG01BCA,b.Qnt2G01BCA,b.QntG01CA,b.Qnt2G01CA     

          from dbBarang a

          left Outer Join (select Kodebrg,

                     Sum(Case when Kodegdg='G01' Then QntSaldo else 0 )QntG01BCA,Sum(Case when Kodegdg='G01' Then Qnt2Saldo else 0 )Qnt2G01BCA, 

                     Sum(Case when Kodegdg='G01@CA' Then QntSaldo else 0 )QntG01CA,Sum(Case when Kodegdg='G01@CA' Then Qnt2Saldo else 0 )Qnt2G01CA 

                     from vwKartuStock a 

                     where  Bulan=MONTH(@Tanggal) and Tahun=YEAR(@Tanggal) and Tanggal<=@Tanggal and a.NamaBrg like @Pilihan+'%'

                     group by kodebrg)b on a.KODEBRG=b.Kodebrg 

          where a.NamaBrg like @Pilihan+'%'

          Order By a.KodeBrg;

-- sp_viewTransferN
CREATE PROCEDURE IF NOT EXISTS sp_viewTransferN AS -- IF EXISTS REMOVED
Select a.Kodebrg,a.namaBrg, a.SAT1 Sat_1, a.Isi1 Isi,0 Awal,0 QntR,0 Qnt,0 Qnt2,b.QntGdgAsal,b.Qnt2GdgAsal,b.QntG01BCA,b.Qnt2G01BCA,b.QntG01CA,b.Qnt2G01CA     

          from dbBarang a

          left Outer Join (select Kodebrg,

                     Sum(Case when Kodegdg='G01' Then QntSaldo else 0 )QntG01BCA,Sum(Case when Kodegdg='G01' Then Qnt2Saldo else 0 )Qnt2G01BCA, 

                     Sum(Case when Kodegdg='G01@CA' Then QntSaldo else 0 )QntG01CA,Sum(Case when Kodegdg='G01@CA' Then Qnt2Saldo else 0 )Qnt2G01CA,

                     Sum(Case when Kodegdg=@GdgAsal Then QntSaldo else 0 )QntGdgAsal,

                     Sum(Case when Kodegdg=@GdgAsal Then Qnt2Saldo else 0 )Qnt2GdgAsal    

                     from vwKartuStock a 

                     where  Bulan=MONTH(@Tanggal) and Tahun=YEAR(@Tanggal) and Tanggal<=@Tanggal and a.Kodebrg = @Pilihan

                     group by kodebrg)b on a.KODEBRG=b.Kodebrg 

          where a.KODEBRG = @Pilihan

          Order By a.KodeBrg     



else

Select a.Kodebrg,a.namaBrg, a.SAT1 Sat_1, a.Isi1 Isi,0 Awal,0 QntR,0 Qnt,0 Qnt2,b.QntGdgAsal,b.Qnt2GdgAsal,b.QntG01BCA,b.Qnt2G01BCA,b.QntG01CA,b.Qnt2G01CA     

          from dbBarang a

          left Outer Join (select Kodebrg,

                     Sum(Case when Kodegdg='G01' Then QntSaldo else 0 )QntG01BCA,Sum(Case when Kodegdg='G01' Then Qnt2Saldo else 0 )Qnt2G01BCA, 

                     Sum(Case when Kodegdg='G01@CA' Then QntSaldo else 0 )QntG01CA,Sum(Case when Kodegdg='G01@CA' Then Qnt2Saldo else 0 )Qnt2G01CA, 

                     Sum(Case when Kodegdg=@GdgAsal Then QntSaldo else 0 )QntGdgAsal,

                     Sum(Case when Kodegdg=@GdgAsal Then Qnt2Saldo else 0 )Qnt2GdgAsal

                     from vwKartuStock a 

                     where  Bulan=MONTH(@Tanggal) and Tahun=YEAR(@Tanggal) and Tanggal<=@Tanggal and a.NamaBrg like @Pilihan+'%'

                     group by kodebrg)b on a.KODEBRG=b.Kodebrg 

          where a.NamaBrg like @Pilihan+'%'

          Order By a.KodeBrg;

-- sp_viewUBJ
CREATE PROCEDURE IF NOT EXISTS sp_viewUBJ AS -- IF EXISTS REMOVED
Select COALESCE(NFix,0)Nfix,Isi2,A.KodeBrg,A.Sat1,A.Sat2, A.NamaBrg, 0 QntSaldo, 0 Qnt2Saldo,0 HPP ,b.QntG01BCA,b.Qnt2G01BCA,b.QntG01CA,b.Qnt2G01CA

                      from dbBarang A

                      left Outer Join (select Kodebrg,

                     Sum(Case when Kodegdg='G01' Then QntSaldo else 0 )QntG01BCA,Sum(Case when Kodegdg='G01' Then Qnt2Saldo else 0 )Qnt2G01BCA, 

                     Sum(Case when Kodegdg='G01@CA' Then QntSaldo else 0 )QntG01CA,Sum(Case when Kodegdg='G01@CA' Then Qnt2Saldo else 0 )Qnt2G01CA 

                     from vwKartuStock a 

                     where  Bulan=MONTH(@Tanggal) and Tahun=YEAR(@Tanggal) and Tanggal<=@Tanggal and a.Kodebrg = @Pilihan 

                     group by kodebrg)b on a.KODEBRG=b.Kodebrg 

          where a.KODEBRG = @Pilihan and A.KodeGrp='FG'

          Order By a.KodeBrg



else

Select COALESCE(NFix,0)Nfix,Isi2,A.KodeBrg,A.Sat1,A.Sat2, A.NamaBrg, 0 QntSaldo, 0 Qnt2Saldo,0 HPP ,b.QntG01BCA,b.Qnt2G01BCA,b.QntG01CA,b.Qnt2G01CA

                      from dbBarang A

                      left Outer Join (select Kodebrg,

                     Sum(Case when Kodegdg='G01' Then QntSaldo else 0 )QntG01BCA,Sum(Case when Kodegdg='G01' Then Qnt2Saldo else 0 )Qnt2G01BCA, 

                     Sum(Case when Kodegdg='G01@CA' Then QntSaldo else 0 )QntG01CA,Sum(Case when Kodegdg='G01@CA' Then Qnt2Saldo else 0 )Qnt2G01CA 

                     from vwKartuStock a 

                     where  Bulan=MONTH(@Tanggal) and Tahun=YEAR(@Tanggal) and Tanggal<=@Tanggal and a.NamaBrg like @Pilihan+'%' 

                     group by kodebrg)b on a.KODEBRG=b.Kodebrg 

          where a.NamaBrg like @Pilihan+'%' and A.KodeGrp='FG'

          Order By a.KodeBrg;

-- sp_vwCustJT
CREATE PROCEDURE IF NOT EXISTS sp_vwCustJT AS if @urut>1 

select NoFaktur,Urut from(

select 0 Urut,a.NoFaktur from vwHutPiutBelumlunas a

Left Outer Join vwHutPiut b on a.KodeCustSupp=b.KodeCustSupp and a.NoFaktur=b.NoFaktur

where (b.Tanggal Between datetime('now')-365 and (datetime('now'))or b.JatuhTempo<datetime('now') )and a.KodeCustSupp=@KodeCustSupp

Group by a.NoFaktur

HAVING (SUM(Case when b.Tipe='PT' then Debet-Kredit

            else 0

            )<> 0)

Union all

Select 1 Urut,b.NoFaktur from vwHutPiut a 

Left Outer Join (select NoFaktur,KodeCustSupp from vwHutPiut where TipeTrans='L' and Tipe='PT' and Tanggal>JatuhTempo)b On a.NoFaktur=b.NoFaktur  

where Tanggal Between datetime('now')-365 and (datetime('now')) and b.KodeCustSupp=@KodeCustSupp

Group by b.NoFaktur 

HAVING (SUM(Case when Tipe='PT' then Debet-Kredit

            else 0

            ) = 0)

Union all

Select '1'Urut,b.NoFaktur from vwHutPiut a 

Left Outer Join (select NoFaktur,KodeCustSupp from vwHutPiut where TipeTrans='L' and Tipe='PT' and Tanggal<=JatuhTempo)b On a.NoFaktur=b.NoFaktur  

where Tanggal Between datetime('now')-365 and (datetime('now')) and b.KodeCustSupp=@KodeCustSupp

Group by b.NoFaktur

HAVING (SUM(Case when Tipe='PT' then Debet-Kredit

            else 0

            ) = 0))a

group by NoFaktur,Urut

       

order by Urut,NoFaktur 


else

select NoFaktur,Urut from(

select 0 Urut,a.NoFaktur from vwHutPiutBelumlunas a

Left Outer Join vwHutPiut b on a.KodeCustSupp=b.KodeCustSupp and a.NoFaktur=b.NoFaktur

where (b.Tanggal Between datetime('now')-365 and (datetime('now'))or b.JatuhTempo<datetime('now') )and a.KodeCustSupp=@KodeCustSupp

Group by a.NoFaktur

HAVING (SUM(Case when b.Tipe='PT' then Debet-Kredit

            else 0

            )<> 0)

Union all

Select 1 Urut,b.NoFaktur from vwHutPiut a 

Left Outer Join (select NoFaktur,KodeCustSupp from vwHutPiut where TipeTrans='L' and Tipe='PT' and Tanggal>JatuhTempo)b On a.NoFaktur=b.NoFaktur  

where Tanggal Between datetime('now')-365 and (datetime('now')) and b.KodeCustSupp=@KodeCustSupp

Group by b.NoFaktur 

HAVING (SUM(Case when Tipe='PT' then Debet-Kredit

            else 0

            ) = 0)

Union all

Select '1'Urut,b.NoFaktur from vwHutPiut a 

Left Outer Join (select NoFaktur,KodeCustSupp from vwHutPiut where TipeTrans='L' and Tipe='PT' and Tanggal<=JatuhTempo)b On a.NoFaktur=b.NoFaktur  

where Tanggal Between datetime('now')-365 and (datetime('now')) and b.KodeCustSupp=@KodeCustSupp

Group by b.NoFaktur

HAVING (SUM(Case when Tipe='PT' then Debet-Kredit

            else 0

            ) = 0))a

where Urut=@urut   

group by NoFaktur,Urut

       

order by Urut,NoFaktur;

-- SP_vwPemakaian
CREATE PROCEDURE IF NOT EXISTS SP_vwPemakaian AS select a.kodebrg,c.NamaBrg,Qnt,Qnt2,a.Sat,b.Nobukti,b.Tanggal from DBPenyerahanBhnDET a

Left Outer Join DBPenyerahanBhn b on a.Nobukti=b.Nobukti

Left Outer Join DBBARANG c on c.KODEBRG=a.kodebrg

where CAST([TGLJAM] AS Date) >=@TglAwal and CAST([TGLJAM] AS Date) <=@TglAkh

Order by a.Nobukti;

-- sp_vwPiutangJT
CREATE PROCEDURE IF NOT EXISTS sp_vwPiutangJT AS Select NoFaktur,(sum(Debet)-sum(Kredit)) as Sisa

from [DBHUTPIUT]  

where KodeCustSupp=@KodeCustSupp and JatuhTempo<=datetime('now')

Group by NoFaktur

Having (sum(Debet)-sum(Kredit))<>0;

-- sp_vwPlafon
CREATE PROCEDURE IF NOT EXISTS sp_vwPlafon AS select 	PLAFON from DBCUSTSUPP where  KodeCustSupp =@KodeCustSupp;

-- sp_vwSisaPiutang
CREATE PROCEDURE IF NOT EXISTS sp_vwSisaPiutang AS --select 	b.PLAFON,b.PLAFON-(sum(a.Debet)-sum(a.Kredit)) as sisaP,sum(a.Debet)-sum(a.Kredit) as sisa,

--		sum(a.DebetD)-sum(a.KreditD) as sisaD  

-- 	from vwHutpiut a

-- 	left outer join DBCUSTSUPP b on(a.KodeCustSupp=b.KodeCustSupp)

-- 	where  a.tanggal<=@tanggal	and a.KodeCustSupp =@KodeCustSupp 

-- 	Group By b.PLAFON	

-- 	HAVING (SUM(Case when a.Tipe='PT' then Debet-Kredit

--            else 0

--            )<> 0)

select 	b.PLAFON, b.PLAFON-(sum(a.Debet)-sum(a.Kredit)) as sisaP,sum(a.Debet)-sum(a.Kredit) as sisa,

		sum(a.DebetD)-sum(a.KreditD) as sisaD  

 	from DBCUSTSUPP b

 	left outer join vwHutpiut a on(a.KodeCustSupp=b.KodeCustSupp) and a.tanggal<=@tanggal and a.Tipe='PT'

 	where b.KodeCustSupp =@KodeCustSupp 

 	Group By b.PLAFON;
