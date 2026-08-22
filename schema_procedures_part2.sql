;

-- Sp_reportBeliAccDetx
CREATE PROCEDURE IF NOT EXISTS Sp_reportBeliAccDetx AS if @Perkiraan=0

If @Ordr='N'

		if @NeedOto=0 or @NeedOto=1

		  if @isiList='' 

		  if @TipeBayar=0 or @TipeBayar=1

 		  Exec('select * from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			and TIPEBAYAR='+@TipeBayar+'

			order by NoBukti,Tanggal')

		  else

		   Exec('select * from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			order by NoBukti,Tanggal')	

		  

		  else

		  if @TipeBayar=0 or @TipeBayar=1 

		  Exec('select * from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

		        and TIPEBAYAR='+@TipeBayar+'

		        and  NoBukti IN'+@isiList+ '

			    order by NoBukti,Tanggal')

	      else

	      Exec('select * from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

		        and  NoBukti IN'+@isiList+ '

			    order by NoBukti,Tanggal')		    

		  	    	

		if @NeedOto=2	

		if  @TipeBayar=0 or @TipeBayar=1 

		  Exec('select * from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

			and TIPEBAYAR='+@TipeBayar+'

			order by NoBukti,Tanggal')

		 else

		  Exec('select * from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

			order by NoBukti,Tanggal')

        

		  else

		 if  @TipeBayar=0 or @TipeBayar=1 

		  Exec('select * from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		        and TIPEBAYAR='+@TipeBayar+'

		        and  NoBukti IN'+@isiList+ '

			    order by NoBukti,Tanggal')

		  else

		  Exec('select * from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		        and  NoBukti IN'+@isiList+ '

			    order by NoBukti,Tanggal')	    	    


	else If @Ordr='B'

		if @NeedOto=0 or @NeedOto=1

         if @isiList=''	

		  if @TipeBayar=0 or @TipeBayar=1 

		    Exec('select * from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and TIPEBAYAR='+@TipeBayar+'

			order by KodeBrg')

		   else

		   	Exec('select * from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			order by KodeBrg')

		  	

		 else

		  if @TipeBayar=0 or @TipeBayar=1 

			Exec('select * from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and TIPEBAYAR='+@TipeBayar+'

			and  KodeBrg IN'+@isiList+ '

			order by KodeBrg')

		  else

		  Exec('select * from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and  KodeBrg IN'+@isiList+ '

			order by KodeBrg')	 


        if @NeedOto=2

		 if @isiList=''	

		 if @TipeBayar=0 or @TipeBayar=1 

		 Exec('select * from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and TIPEBAYAR='+@TipeBayar+'

			order by KodeBrg')

		 else 

			Exec('select * from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			order by KodeBrg')

		 

		 else

		  if @TipeBayar=0 or @TipeBayar=1 

		  Exec('select * from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and TIPEBAYAR='+@TipeBayar+'

			and  KodeBrg IN'+@isiList+ '

			order by KodeBrg')

		  else

			Exec('select * from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and  KodeBrg IN'+@isiList+ '

			order by KodeBrg')


	else If @Ordr='S'

		if @NeedOto=0 or @NeedOto=1

		     if @isiList=''	

		     if @TipeBayar=0 or @TipeBayar=1 

              Exec('select * from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			  and TIPEBAYAR='+@TipeBayar+'

			  order by KodeCustSupp')

              else 

			  Exec('select * from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			  order by KodeCustSupp')

		      

		     else

		     if @TipeBayar=0 or @TipeBayar=1

		     Exec('select * from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			 and TIPEBAYAR='+@TipeBayar+'

			 and  KodeCustSupp IN'+@isiList+ ' 

			 order by KodeCustSupp')

		     else

		     Exec('select * from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			 and  KodeCustSupp IN'+@isiList+ ' 

			 order by KodeCustSupp')

			 

          if @NeedOto=2

		     if @isiList=''	

		     if @TipeBayar=0 or @TipeBayar=1

		      Exec('select * from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			  and TIPEBAYAR='+@TipeBayar+'

			  order by KodeCustSupp')

		     else 

			 Exec('select * from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			 order by KodeCustSupp')

			 

		     else

		     if @TipeBayar=0 or @TipeBayar=1

		     Exec('select * from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			 and TIPEBAYAR='+@TipeBayar+'

			 and  KodeCustSupp IN'+@isiList+ ' 

			 order by KodeCustSupp')

		     else

		     Exec('select * from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			 and  KodeCustSupp IN'+@isiList+ ' 

			 order by KodeCustSupp')


else

If @Ordr='N'

		if @NeedOto=0 or @NeedOto=1

		  if @isiList='' 

		  if @TipeBayar=0 or @TipeBayar=1

 		  Exec('select * from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			and TIPEBAYAR='+@TipeBayar+' and Perkiraan not in('''',''-'')

			order by NoBukti,Tanggal')

		  else

		   Exec('select * from VwReportBeliGudang where  Perkiraan not in('''',''-'') and(Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			order by NoBukti,Tanggal')	

		  

		  else

		  if @TipeBayar=0 or @TipeBayar=1 

		  Exec('select * from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

		        and TIPEBAYAR='+@TipeBayar+'

		        and  NoBukti IN'+@isiList+ ' and Perkiraan not in('''',''-'')

			    order by NoBukti,Tanggal')

	      else

	      Exec('select * from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

		        and  NoBukti IN'+@isiList+ ' and Perkiraan not in('''',''-'')

			    order by NoBukti,Tanggal')		    

		  	    	

		if @NeedOto=2	

		if  @TipeBayar=0 or @TipeBayar=1 

		  Exec('select * from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

			and TIPEBAYAR='+@TipeBayar+' and Perkiraan not in('''',''-'')

			order by NoBukti,Tanggal')

		 else

		  Exec('select * from VwReportBeliGudang where  Perkiraan not in('''',''-'') and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

			order by NoBukti,Tanggal')

        

		  else

		 if  @TipeBayar=0 or @TipeBayar=1 

		  Exec('select * from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		        and TIPEBAYAR='+@TipeBayar+'

		        and  NoBukti IN'+@isiList+ ' and Perkiraan not in('''',''-'')

			    order by NoBukti,Tanggal')

		  else

		  Exec('select * from VwReportBeliGudang where  Perkiraan not in('''',''-'') and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		        and  NoBukti IN'+@isiList+ '

			    order by NoBukti,Tanggal')	    	    


	else If @Ordr='B'

		if @NeedOto=0 or @NeedOto=1

         if @isiList=''	

		  if @TipeBayar=0 or @TipeBayar=1 

		    Exec('select * from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and TIPEBAYAR='+@TipeBayar+' and Perkiraan not in('''',''-'')

			order by KodeBrg')

		   else

		   	Exec('select * from VwReportBeliGudang where  Perkiraan not in('''',''-'') and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			order by KodeBrg')

		  	

		 else

		  if @TipeBayar=0 or @TipeBayar=1 

			Exec('select * from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and TIPEBAYAR='+@TipeBayar+'

			and  KodeBrg IN'+@isiList+ ' and Perkiraan not in('''',''-'')

			order by KodeBrg')

		  else

		  Exec('select * from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and  KodeBrg IN'+@isiList+ ' and Perkiraan not in('''',''-'')

			order by KodeBrg')	 


        if @NeedOto=2

		 if @isiList=''	

		 if @TipeBayar=0 or @TipeBayar=1 

		 Exec('select * from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and TIPEBAYAR='+@TipeBayar+' and Perkiraan not in('''',''-'')

			order by KodeBrg')

		 else 

			Exec('select * from VwReportBeliGudang where  Perkiraan not in('''',''-'') and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			order by KodeBrg')

		 

		 else

		  if @TipeBayar=0 or @TipeBayar=1 

		  Exec('select * from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and TIPEBAYAR='+@TipeBayar+'

			and  KodeBrg IN'+@isiList+ ' and Perkiraan not in('''',''-'')

			order by KodeBrg')

		  else

			Exec('select * from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

			and  KodeBrg IN'+@isiList+ ' and Perkiraan not in('''',''-'')

			order by KodeBrg')


	else If @Ordr='S'

		if @NeedOto=0 or @NeedOto=1

		     if @isiList=''	

		     if @TipeBayar=0 or @TipeBayar=1 

              Exec('select * from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			  and TIPEBAYAR='+@TipeBayar+' and Perkiraan not in('''',''-'')

			  order by KodeCustSupp')

              else 

			  Exec('select * from VwReportBeliGudang where Perkiraan not in('''',''-'') and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			  order by KodeCustSupp')

		      

		     else

		     if @TipeBayar=0 or @TipeBayar=1

		     Exec('select * from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			 and TIPEBAYAR='+@TipeBayar+'

			 and  KodeCustSupp IN'+@isiList+ ' and Perkiraan not in('''',''-'')

			 order by KodeCustSupp')

		     else

		     Exec('select * from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			 and  KodeCustSupp IN'+@isiList+ ' and Perkiraan<>''''

			 order by KodeCustSupp')

			 

          if @NeedOto=2

		     if @isiList=''	

		     if @TipeBayar=0 or @TipeBayar=1

		      Exec('select * from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			  and TIPEBAYAR='+@TipeBayar+' and Perkiraan not in('''',''-'')

			  order by KodeCustSupp')

		     else 

			 Exec('select * from VwReportBeliGudang where Perkiraan not in('''',''-'') and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			 order by KodeCustSupp')

			 

		     else

		     if @TipeBayar=0 or @TipeBayar=1

		     Exec('select * from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			 and TIPEBAYAR='+@TipeBayar+'

			 and  KodeCustSupp IN'+@isiList+ '  and Perkiraan not in('''',''-'')

			 order by KodeCustSupp')

		     else

		     Exec('select * from VwReportBeliGudang where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi='+@NeedOto+'

			 and  KodeCustSupp IN'+@isiList+ ' and Perkiraan not in('''',''-'')

			 order by KodeCustSupp');

-- Sp_ReportBeliACCRek
CREATE PROCEDURE IF NOT EXISTS Sp_ReportBeliACCRek AS ---- DECLARE REMOVED,@Tgl1 Datetime,@tgl2 datetime

--select @Tgl1='01/01/2012',@tgl2='07/17/2013',@Choice='B'



if @Id='' 

If @Choice='N'

If @NeedOto=0 or @NeedOto=1

      if @TipeBayar=0 or @TipeBayar=1

		Select 	'Gabungan' Perusahaan,a.NoBukti,a.TANGGAL,a.KODESUPP,J.NAMACUSTSUPP,a.KODEVLS,a.KURS,

            sum(b.NDPP) as NDPP,sum(b.NDPPRp) as NDPPRP,sum(b.NPPNRp) as NPPNRp,sum(B.nnetrp) as NNETRP,

            a1.Nilai ByLainnya,case when COALESCE(a1.Nilai,0)=0 then sum(B.nnetrp) else sum(B.nnetrp)+a1.Nilai   GrandTotal

		From  dbBeli a 

		left outer join DBBELIDET B on b.NOBUKTI=a.NOBUKTI

		Left Outer Join DBCUSTSUPP J on a.KODESUPP = J.KODECUSTSUPP 

		Left Outer Join (select SUM(Nilai)Nilai,NoBuktiInv from DBPBIAYA Group By NoBuktiInv)A1 On A1.NoBuktiInv=A.NOBUKTI

		Where a.TANGGAL between @tgl1 and @tgl2 and TIPEBAYAR=@TipeBayar and

        Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                      Case when A.IsOtorisasi2=1 then 1 else 0 +

                      Case when A.IsOtorisasi3=1 then 1 else 0 +

                      Case when A.IsOtorisasi4=1 then 1 else 0 +

                      Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                 else 1

             As INTEGER)=@needOto

		group by a.NOBUKTI,a.TANGGAL,j.NAMACUSTSUPP,a.KODEVLS,a.KURS,a1.Nilai,a.KODESUPP

		order by  a.NOBUKTI

	  else

	  Select 	'Gabungan' Perusahaan,a.NoBukti,a.TANGGAL,a.KODESUPP,J.NAMACUSTSUPP,a.KODEVLS,a.KURS,

            sum(b.NDPP) as NDPP,sum(b.NDPPRp) as NDPPRP,sum(b.NPPNRp) as NPPNRp,sum(B.nnetrp) as NNETRP,

            a1.Nilai ByLainnya,case when COALESCE(a1.Nilai,0)=0 then sum(B.nnetrp) else sum(B.nnetrp)+a1.Nilai   GrandTotal

		From  dbBeli a 

		left outer join DBBELIDET B on b.NOBUKTI=a.NOBUKTI

		Left Outer Join DBCUSTSUPP J on a.KODESUPP = J.KODECUSTSUPP 

		Left Outer Join (select SUM(Nilai)Nilai,NoBuktiInv from DBPBIAYA Group By NoBuktiInv)A1 On A1.NoBuktiInv=A.NOBUKTI

		Where a.TANGGAL between @tgl1 and @tgl2 and 

        Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                      Case when A.IsOtorisasi2=1 then 1 else 0 +

                      Case when A.IsOtorisasi3=1 then 1 else 0 +

                      Case when A.IsOtorisasi4=1 then 1 else 0 +

                      Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                 else 1

             As INTEGER)=@needOto

		group by a.NOBUKTI,a.TANGGAL,j.NAMACUSTSUPP,a.KODEVLS,a.KURS,a1.Nilai,a.KODESUPP

		order by  a.NOBUKTI	

	  	

	 If @NeedOto=2

	  if @TipeBayar=0 or @TipeBayar=1

	  Select 	'Gabungan' Perusahaan,a.NoBukti,a.TANGGAL,a.KODESUPP,J.NAMACUSTSUPP,a.KODEVLS,a.KURS,

            sum(b.NDPP) as NDPP,sum(b.NDPPRp) as NDPPRP,sum(b.NPPNRp) as NPPNRp,sum(B.nnetrp) as NNETRP,a1.Nilai ByLainnya,

            a1.Nilai ByLainnya,case when COALESCE(a1.Nilai,0)=0 then sum(B.nnetrp) else sum(B.nnetrp)+a1.Nilai   GrandTotal

		From  dbBeli a 

		left outer join DBBELIDET B on b.NOBUKTI=a.NOBUKTI

		Left Outer Join DBCUSTSUPP J on a.KODESUPP = J.KODECUSTSUPP 

		Left Outer Join (select SUM(Nilai)Nilai,NoBuktiInv from DBPBIAYA Group By NoBuktiInv)A1 On A1.NoBuktiInv=A.NOBUKTI

		Where a.TANGGAL between @tgl1 and @tgl2 and TIPEBAYAR=@TipeBayar 

		group by a.NOBUKTI,a.TANGGAL,j.NAMACUSTSUPP,a.KODEVLS,a.KURS,a1.Nilai,a.KODESUPP

		order by  a.NOBUKTI

	  else

		Select 	'Gabungan' Perusahaan,a.NoBukti,a.TANGGAL,J.NAMACUSTSUPP,a.KODEVLS,a.KURS,

            sum(b.NDPP) as NDPP,sum(b.NDPPRp) as NDPPRP,sum(b.NPPNRp) as NPPNRp,sum(B.nnetrp) as NNETRP,a1.Nilai ByLainnya,

            a1.Nilai ByLainnya,case when COALESCE(a1.Nilai,0)=0 then sum(B.nnetrp) else sum(B.nnetrp)+a1.Nilai   GrandTotal

		From  dbBeli a 

		left outer join DBBELIDET B on b.NOBUKTI=a.NOBUKTI

		Left Outer Join DBCUSTSUPP J on a.KODESUPP = J.KODECUSTSUPP 

		Left Outer Join (select SUM(Nilai)Nilai,NoBuktiInv from DBPBIAYA Group By NoBuktiInv)A1 On A1.NoBuktiInv=A.NOBUKTI

		Where a.TANGGAL between @tgl1 and @tgl2

		group by a.NOBUKTI,a.TANGGAL,j.NAMACUSTSUPP,a.KODEVLS,a.KURS,a1.Nilai,a.KODESUPP

		order by  a.NOBUKTI


else if @Choice='S'

If @NeedOto=0 or @NeedOto=1

	  if @TipeBayar=0 or @TipeBayar=1

	  Select 	'Gabungan' Perusahaan,a.NoBukti,a.TANGGAL,a.KODESUPP,J.NAMACUSTSUPP,a.KODEVLS,a.KURS,

            sum(b.NDPP) as NDPP,sum(b.NDPPRp) as NDPPRP,sum(b.NPPNRp) as NPPNRp,sum(B.nnetrp) as NNETRP,a1.Nilai ByLainnya,

            a1.Nilai ByLainnya,case when COALESCE(a1.Nilai,0)=0 then sum(B.nnetrp) else sum(B.nnetrp)+a1.Nilai   GrandTotal

		From  dbBeli a 

		left outer join DBBELIDET B on b.NOBUKTI=a.NOBUKTI

		Left Outer Join DBCUSTSUPP J on a.KODESUPP = J.KODECUSTSUPP 

		Left Outer Join (select SUM(Nilai)Nilai,NoBuktiInv from DBPBIAYA Group By NoBuktiInv)A1 On A1.NoBuktiInv=A.NOBUKTI

		Where a.TANGGAL between @tgl1 and @tgl2 and TIPEBAYAR=@TipeBayar and

        Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                      Case when A.IsOtorisasi2=1 then 1 else 0 +

                      Case when A.IsOtorisasi3=1 then 1 else 0 +

                      Case when A.IsOtorisasi4=1 then 1 else 0 +

                      Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                 else 1

             As INTEGER)=@needOto

		group by a.NOBUKTI,a.TANGGAL,j.NAMACUSTSUPP,a.KODEVLS,a.KURS,a1.Nilai,a.KODESUPP

		order by  J.NAMACUSTSUPP,a.NOBUKTI

	  else 

		Select 	'Gabungan' Perusahaan,a.NoBukti,a.TANGGAL,a.KODESUPP,J.NAMACUSTSUPP,a.KODEVLS,a.KURS,

            sum(b.NDPP) as NDPP,sum(b.NDPPRp) as NDPPRP,sum(b.NPPNRp) as NPPNRp,sum(B.nnetrp) as NNETRP,a1.Nilai ByLainnya,

            a1.Nilai ByLainnya,case when COALESCE(a1.Nilai,0)=0 then sum(B.nnetrp) else sum(B.nnetrp)+a1.Nilai   GrandTotal

		From  dbBeli a 

		left outer join DBBELIDET B on b.NOBUKTI=a.NOBUKTI

		Left Outer Join DBCUSTSUPP J on a.KODESUPP = J.KODECUSTSUPP 

		Left Outer Join (select SUM(Nilai)Nilai,NoBuktiInv from DBPBIAYA Group By NoBuktiInv)A1 On A1.NoBuktiInv=A.NOBUKTI

		Where a.TANGGAL between @tgl1 and @tgl2 and

        Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                      Case when A.IsOtorisasi2=1 then 1 else 0 +

                      Case when A.IsOtorisasi3=1 then 1 else 0 +

                      Case when A.IsOtorisasi4=1 then 1 else 0 +

                      Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                 else 1

             As INTEGER)=@needOto

		group by a.NOBUKTI,a.TANGGAL,j.NAMACUSTSUPP,a.KODEVLS,a.KURS,a1.Nilai,a.KODESUPP

		order by  J.NAMACUSTSUPP,a.NOBUKTI

	 	

	  If @NeedOto=2

	  if @TipeBayar=0 or @TipeBayar=1

	  Select 	'Gabungan' Perusahaan,a.NoBukti,a.TANGGAL,a.KODESUPP,J.NAMACUSTSUPP,a.KODEVLS,a.KURS,

        sum(b.NDPP) as NDPP,sum(b.NDPPRp) as NDPPRP,sum(b.NPPNRp) as NPPNRp,sum(B.nnetrp) as NNETRP,a1.Nilai ByLainnya,

        a1.Nilai ByLainnya,case when COALESCE(a1.Nilai,0)=0 then sum(B.nnetrp) else sum(B.nnetrp)+a1.Nilai   GrandTotal

		From  dbBeli a 

		left outer join DBBELIDET B on b.NOBUKTI=a.NOBUKTI

		Left Outer Join DBCUSTSUPP J on a.KODESUPP = J.KODECUSTSUPP 

		Left Outer Join (select SUM(Nilai)Nilai,NoBuktiInv from DBPBIAYA Group By NoBuktiInv)A1 On A1.NoBuktiInv=A.NOBUKTI

		Where a.TANGGAL between @tgl1 and @tgl2 and TIPEBAYAR=@TipeBayar

		group by a.NOBUKTI,a.TANGGAL,j.NAMACUSTSUPP,a.KODEVLS,a.KURS,a1.Nilai,a.KODESUPP

		order by  J.NAMACUSTSUPP,a.NOBUKTI

	  else

		Select 	'Gabungan' Perusahaan,a.NoBukti,a.TANGGAL,J.NAMACUSTSUPP,a.KODEVLS,a.KURS,

        sum(b.NDPP) as NDPP,sum(b.NDPPRp) as NDPPRP,sum(b.NPPNRp) as NPPNRp,sum(B.nnetrp) as NNETRP,a1.Nilai ByLainnya,

        a1.Nilai ByLainnya,case when COALESCE(a1.Nilai,0)=0 then sum(B.nnetrp) else sum(B.nnetrp)+a1.Nilai   GrandTotal

		From  dbBeli a 

		left outer join DBBELIDET B on b.NOBUKTI=a.NOBUKTI

		Left Outer Join DBCUSTSUPP J on a.KODESUPP = J.KODECUSTSUPP 

		Left Outer Join (select SUM(Nilai)Nilai,NoBuktiInv from DBPBIAYA Group By NoBuktiInv)A1 On A1.NoBuktiInv=A.NOBUKTI

		Where a.TANGGAL between @tgl1 and @tgl2

		group by a.NOBUKTI,a.TANGGAL,j.NAMACUSTSUPP,a.KODEVLS,a.KURS,a1.Nilai,a.KODESUPP

		order by  J.NAMACUSTSUPP,a.NOBUKTI


else if @Choice='B'

if @NeedOto=0 or @NeedOto=1

	 if @TipeBayar=0 or @TipeBayar=1

	 Select 	'Gabungan' Perusahaan,Case when H.IsJasa=1 Then B.NamaBrg else h.NAMABRG  NamaBrg,a.NoBukti,a.TANGGAL,a.KODESUPP,J.NAMACUSTSUPP,a.KODEVLS,a.KURS,

            sum(b.NDPP) as NDPP,sum(b.NDPPRp) as NDPPRP,sum(b.NPPNRp) as NPPNRp,sum(B.nnetrp) as NNETRP,a1.Nilai ByLainnya,

            a1.Nilai ByLainnya,case when COALESCE(a1.Nilai,0)=0 then sum(B.nnetrp) else sum(B.nnetrp)+a1.Nilai   GrandTotal

		From  dbBeli a 

		left outer join DBBELIDET B on b.NOBUKTI=a.NOBUKTI

		Left Outer Join DBCUSTSUPP J on a.KODESUPP = J.KODECUSTSUPP 

		Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg

		Left Outer Join (select SUM(Nilai)Nilai,NoBuktiInv from DBPBIAYA Group By NoBuktiInv)A1 On A1.NoBuktiInv=A.NOBUKTI	

		Where a.TANGGAL between @tgl1 and @tgl2 and TIPEBAYAR=@TipeBayar and

        Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                      Case when A.IsOtorisasi2=1 then 1 else 0 +

                      Case when A.IsOtorisasi3=1 then 1 else 0 +

                      Case when A.IsOtorisasi4=1 then 1 else 0 +

                      Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                 else 1

             As INTEGER)=@needOto		

		group by h.NAMABRG,B.NamaBrg,H.IsJasa,a.NOBUKTI,a.TANGGAL,j.NAMACUSTSUPP,a.KODEVLS,a.KURS,a1.Nilai,a.KODESUPP

		order by h.namabrg

	 else

		Select 	'Gabungan' Perusahaan,Case when H.IsJasa=1 Then B.NamaBrg else h.NAMABRG  NamaBrg,a.NoBukti,a.TANGGAL,a.KODESUPP,J.NAMACUSTSUPP,a.KODEVLS,a.KURS,

            sum(b.NDPP) as NDPP,sum(b.NDPPRp) as NDPPRP,sum(b.NPPNRp) as NPPNRp,sum(B.nnetrp) as NNETRP,a1.Nilai ByLainnya,

            a1.Nilai ByLainnya,case when COALESCE(a1.Nilai,0)=0 then sum(B.nnetrp) else sum(B.nnetrp)+a1.Nilai   GrandTotal

		From  dbBeli a 

		left outer join DBBELIDET B on b.NOBUKTI=a.NOBUKTI

		Left Outer Join DBCUSTSUPP J on a.KODESUPP = J.KODECUSTSUPP 

		Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg

		Left Outer Join (select SUM(Nilai)Nilai,NoBuktiInv from DBPBIAYA Group By NoBuktiInv)A1 On A1.NoBuktiInv=A.NOBUKTI	

		Where a.TANGGAL between @tgl1 and @tgl2 and

        Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                      Case when A.IsOtorisasi2=1 then 1 else 0 +

                      Case when A.IsOtorisasi3=1 then 1 else 0 +

                      Case when A.IsOtorisasi4=1 then 1 else 0 +

                      Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                 else 1

             As INTEGER)=@needOto		

		group by h.NAMABRG,B.NamaBrg,H.IsJasa,a.NOBUKTI,a.TANGGAL,j.NAMACUSTSUPP,a.KODEVLS,a.KURS,a1.Nilai,a.KODESUPP

		order by h.namabrg

		

	if @NeedOto=2	

	 if @TipeBayar=0 or @TipeBayar=1

	  Select 	'Gabungan' Perusahaan,Case when H.IsJasa=1 Then B.NamaBrg else h.NAMABRG  NAMABRG,a.NoBukti,a.TANGGAL,a.KODESUPP,J.NAMACUSTSUPP,a.KODEVLS,a.KURS,

            sum(b.NDPP) as NDPP,sum(b.NDPPRp) as NDPPRP,sum(b.NPPNRp) as NPPNRp,sum(B.nnetrp) as NNETRP,a1.Nilai ByLainnya,

            a1.Nilai ByLainnya,case when COALESCE(a1.Nilai,0)=0 then sum(B.nnetrp) else sum(B.nnetrp)+a1.Nilai   GrandTotal

		From  dbBeli a 

		left outer join DBBELIDET B on b.NOBUKTI=a.NOBUKTI

		Left Outer Join DBCUSTSUPP J on a.KODESUPP = J.KODECUSTSUPP 

		Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg

		Left Outer Join (select SUM(Nilai)Nilai,NoBuktiInv from DBPBIAYA Group By NoBuktiInv)A1 On A1.NoBuktiInv=A.NOBUKTI	

		Where a.TANGGAL between @tgl1 and @tgl2 and TIPEBAYAR=@TipeBayar

		group by h.NAMABRG,B.NamaBrg,H.IsJasa,a.NOBUKTI,a.TANGGAL,j.NAMACUSTSUPP,a.KODEVLS,a.KURS,a1.Nilai,a.KODESUPP

		order by h.namabrg

	  else	

		Select 	'Gabungan' Perusahaan,Case when H.IsJasa=1 Then B.NamaBrg else h.NAMABRG  NAMABRG,a.NoBukti,a.TANGGAL,a.KODESUPP,J.NAMACUSTSUPP,a.KODEVLS,a.KURS,

            sum(b.NDPP) as NDPP,sum(b.NDPPRp) as NDPPRP,sum(b.NPPNRp) as NPPNRp,sum(B.nnetrp) as NNETRP,a1.Nilai ByLainnya,

            a1.Nilai ByLainnya,case when COALESCE(a1.Nilai,0)=0 then sum(B.nnetrp) else sum(B.nnetrp)+a1.Nilai   GrandTotal

		From  dbBeli a 

		left outer join DBBELIDET B on b.NOBUKTI=a.NOBUKTI

		Left Outer Join DBCUSTSUPP J on a.KODESUPP = J.KODECUSTSUPP 

		Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg

		Left Outer Join (select SUM(Nilai)Nilai,NoBuktiInv from DBPBIAYA Group By NoBuktiInv)A1 On A1.NoBuktiInv=A.NOBUKTI	

		Where a.TANGGAL between @tgl1 and @tgl2

		group by h.NAMABRG,B.NamaBrg,H.IsJasa,a.NOBUKTI,a.TANGGAL,j.NAMACUSTSUPP,a.KODEVLS,a.KURS,a1.Nilai,a.KODESUPP

		order by h.namabrg


---------------

else

If @Choice='N'

If @NeedOto=0 or @NeedOto=1

      if @TipeBayar=0 or @TipeBayar=1

		Select 	Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,a.NoBukti,a.TANGGAL,a.KODESUPP,J.NAMACUSTSUPP,a.KODEVLS,a.KURS,

            sum(b.NDPP) as NDPP,sum(b.NDPPRp) as NDPPRP,sum(b.NPPNRp) as NPPNRp,sum(B.nnetrp) as NNETRP,

            a1.Nilai ByLainnya,case when COALESCE(a1.Nilai,0)=0 then sum(B.nnetrp) else sum(B.nnetrp)+a1.Nilai   GrandTotal

		From  dbBeli a 

		left outer join DBBELIDET B on b.NOBUKTI=a.NOBUKTI

		Left Outer Join DBCUSTSUPP J on a.KODESUPP = J.KODECUSTSUPP 

		Left Outer Join (select SUM(Nilai)Nilai,NoBuktiInv from DBPBIAYA Group By NoBuktiInv)A1 On A1.NoBuktiInv=A.NOBUKTI

		Where a.TANGGAL between @tgl1 and @tgl2 and TIPEBAYAR=@TipeBayar and

        Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                      Case when A.IsOtorisasi2=1 then 1 else 0 +

                      Case when A.IsOtorisasi3=1 then 1 else 0 +

                      Case when A.IsOtorisasi4=1 then 1 else 0 +

                      Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                 else 1

             As INTEGER)=@needOto

        and @Id=Case When Len(@ID)=3 Then Left(b.NoBukti,3) else Left(b.NoBukti,2)    

		group by a.NOBUKTI,a.TANGGAL,j.NAMACUSTSUPP,a.KODEVLS,a.KURS,a1.Nilai,a.KODESUPP

		order by  a.NOBUKTI

	  else

	  Select 	Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,a.NoBukti,a.TANGGAL,a.KODESUPP,J.NAMACUSTSUPP,a.KODEVLS,a.KURS,

            sum(b.NDPP) as NDPP,sum(b.NDPPRp) as NDPPRP,sum(b.NPPNRp) as NPPNRp,sum(B.nnetrp) as NNETRP,

            a1.Nilai ByLainnya,case when COALESCE(a1.Nilai,0)=0 then sum(B.nnetrp) else sum(B.nnetrp)+a1.Nilai   GrandTotal

		From  dbBeli a 

		left outer join DBBELIDET B on b.NOBUKTI=a.NOBUKTI

		Left Outer Join DBCUSTSUPP J on a.KODESUPP = J.KODECUSTSUPP 

		Left Outer Join (select SUM(Nilai)Nilai,NoBuktiInv from DBPBIAYA Group By NoBuktiInv)A1 On A1.NoBuktiInv=A.NOBUKTI

		Where a.TANGGAL between @tgl1 and @tgl2 and 

        Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                      Case when A.IsOtorisasi2=1 then 1 else 0 +

                      Case when A.IsOtorisasi3=1 then 1 else 0 +

                      Case when A.IsOtorisasi4=1 then 1 else 0 +

                      Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                 else 1

             As INTEGER)=@needOto

        and @Id=Case When Len(@ID)=3 Then Left(b.NoBukti,3) else Left(b.NoBukti,2)    

		group by a.NOBUKTI,a.TANGGAL,j.NAMACUSTSUPP,a.KODEVLS,a.KURS,a1.Nilai,a.KODESUPP

		order by  a.NOBUKTI	

	  	

	 If @NeedOto=2

	  if @TipeBayar=0 or @TipeBayar=1

	  Select 	Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,a.NoBukti,a.TANGGAL,a.KODESUPP,J.NAMACUSTSUPP,a.KODEVLS,a.KURS,

            sum(b.NDPP) as NDPP,sum(b.NDPPRp) as NDPPRP,sum(b.NPPNRp) as NPPNRp,sum(B.nnetrp) as NNETRP,a1.Nilai ByLainnya,

            a1.Nilai ByLainnya,case when COALESCE(a1.Nilai,0)=0 then sum(B.nnetrp) else sum(B.nnetrp)+a1.Nilai   GrandTotal

		From  dbBeli a 

		left outer join DBBELIDET B on b.NOBUKTI=a.NOBUKTI

		Left Outer Join DBCUSTSUPP J on a.KODESUPP = J.KODECUSTSUPP 

		Left Outer Join (select SUM(Nilai)Nilai,NoBuktiInv from DBPBIAYA Group By NoBuktiInv)A1 On A1.NoBuktiInv=A.NOBUKTI

		Where a.TANGGAL between @tgl1 and @tgl2 and TIPEBAYAR=@TipeBayar 

		and @Id=Case When Len(@ID)=3 Then Left(b.NoBukti,3) else Left(b.NoBukti,2)

		group by a.NOBUKTI,a.TANGGAL,j.NAMACUSTSUPP,a.KODEVLS,a.KURS,a1.Nilai,a.KODESUPP

		order by  a.NOBUKTI

	  else

		Select 	Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,a.NoBukti,a.TANGGAL,J.NAMACUSTSUPP,a.KODEVLS,a.KURS,

            sum(b.NDPP) as NDPP,sum(b.NDPPRp) as NDPPRP,sum(b.NPPNRp) as NPPNRp,sum(B.nnetrp) as NNETRP,a1.Nilai ByLainnya,

            a1.Nilai ByLainnya,case when COALESCE(a1.Nilai,0)=0 then sum(B.nnetrp) else sum(B.nnetrp)+a1.Nilai   GrandTotal

		From  dbBeli a 

		left outer join DBBELIDET B on b.NOBUKTI=a.NOBUKTI

		Left Outer Join DBCUSTSUPP J on a.KODESUPP = J.KODECUSTSUPP 

		Left Outer Join (select SUM(Nilai)Nilai,NoBuktiInv from DBPBIAYA Group By NoBuktiInv)A1 On A1.NoBuktiInv=A.NOBUKTI

		Where a.TANGGAL between @tgl1 and @tgl2

		and @Id=Case When Len(@ID)=3 Then Left(b.NoBukti,3) else Left(b.NoBukti,2)

		group by a.NOBUKTI,a.TANGGAL,j.NAMACUSTSUPP,a.KODEVLS,a.KURS,a1.Nilai,a.KODESUPP

		order by  a.NOBUKTI


else if @Choice='S'

If @NeedOto=0 or @NeedOto=1

	  if @TipeBayar=0 or @TipeBayar=1

	  Select 	Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,a.NoBukti,a.TANGGAL,a.KODESUPP,J.NAMACUSTSUPP,a.KODEVLS,a.KURS,

            sum(b.NDPP) as NDPP,sum(b.NDPPRp) as NDPPRP,sum(b.NPPNRp) as NPPNRp,sum(B.nnetrp) as NNETRP,a1.Nilai ByLainnya,

            a1.Nilai ByLainnya,case when COALESCE(a1.Nilai,0)=0 then sum(B.nnetrp) else sum(B.nnetrp)+a1.Nilai   GrandTotal

		From  dbBeli a 

		left outer join DBBELIDET B on b.NOBUKTI=a.NOBUKTI

		Left Outer Join DBCUSTSUPP J on a.KODESUPP = J.KODECUSTSUPP 

		Left Outer Join (select SUM(Nilai)Nilai,NoBuktiInv from DBPBIAYA Group By NoBuktiInv)A1 On A1.NoBuktiInv=A.NOBUKTI

		Where a.TANGGAL between @tgl1 and @tgl2 and TIPEBAYAR=@TipeBayar and

        Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                      Case when A.IsOtorisasi2=1 then 1 else 0 +

                      Case when A.IsOtorisasi3=1 then 1 else 0 +

                      Case when A.IsOtorisasi4=1 then 1 else 0 +

                      Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                 else 1

             As INTEGER)=@needOto

            and @Id=Case When Len(@ID)=3 Then Left(b.NoBukti,3) else Left(b.NoBukti,2)

		group by a.NOBUKTI,a.TANGGAL,j.NAMACUSTSUPP,a.KODEVLS,a.KURS,a1.Nilai,a.KODESUPP

		order by  J.NAMACUSTSUPP,a.NOBUKTI

	  else 

		Select Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,	a.NoBukti,a.TANGGAL,a.KODESUPP,J.NAMACUSTSUPP,a.KODEVLS,a.KURS,

            sum(b.NDPP) as NDPP,sum(b.NDPPRp) as NDPPRP,sum(b.NPPNRp) as NPPNRp,sum(B.nnetrp) as NNETRP,a1.Nilai ByLainnya,

            a1.Nilai ByLainnya,case when COALESCE(a1.Nilai,0)=0 then sum(B.nnetrp) else sum(B.nnetrp)+a1.Nilai   GrandTotal

		From  dbBeli a 

		left outer join DBBELIDET B on b.NOBUKTI=a.NOBUKTI

		Left Outer Join DBCUSTSUPP J on a.KODESUPP = J.KODECUSTSUPP 

		Left Outer Join (select SUM(Nilai)Nilai,NoBuktiInv from DBPBIAYA Group By NoBuktiInv)A1 On A1.NoBuktiInv=A.NOBUKTI

		Where a.TANGGAL between @tgl1 and @tgl2 and

        Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                      Case when A.IsOtorisasi2=1 then 1 else 0 +

                      Case when A.IsOtorisasi3=1 then 1 else 0 +

                      Case when A.IsOtorisasi4=1 then 1 else 0 +

                      Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                 else 1

             As INTEGER)=@needOto

            and @Id=Case When Len(@ID)=3 Then Left(b.NoBukti,3) else Left(b.NoBukti,2)

		group by a.NOBUKTI,a.TANGGAL,j.NAMACUSTSUPP,a.KODEVLS,a.KURS,a1.Nilai,a.KODESUPP

		order by  J.NAMACUSTSUPP,a.NOBUKTI

	 	

	  If @NeedOto=2

	  if @TipeBayar=0 or @TipeBayar=1

	  Select 	Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,a.NoBukti,a.TANGGAL,a.KODESUPP,J.NAMACUSTSUPP,a.KODEVLS,a.KURS,

        sum(b.NDPP) as NDPP,sum(b.NDPPRp) as NDPPRP,sum(b.NPPNRp) as NPPNRp,sum(B.nnetrp) as NNETRP,a1.Nilai ByLainnya,

        a1.Nilai ByLainnya,case when COALESCE(a1.Nilai,0)=0 then sum(B.nnetrp) else sum(B.nnetrp)+a1.Nilai   GrandTotal

		From  dbBeli a 

		left outer join DBBELIDET B on b.NOBUKTI=a.NOBUKTI

		Left Outer Join DBCUSTSUPP J on a.KODESUPP = J.KODECUSTSUPP 

		Left Outer Join (select SUM(Nilai)Nilai,NoBuktiInv from DBPBIAYA Group By NoBuktiInv)A1 On A1.NoBuktiInv=A.NOBUKTI

		Where a.TANGGAL between @tgl1 and @tgl2 and TIPEBAYAR=@TipeBayar

		and @Id=Case When Len(@ID)=3 Then Left(b.NoBukti,3) else Left(b.NoBukti,2)

		group by a.NOBUKTI,a.TANGGAL,j.NAMACUSTSUPP,a.KODEVLS,a.KURS,a1.Nilai,a.KODESUPP

		order by  J.NAMACUSTSUPP,a.NOBUKTI

	  else

		Select Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,	a.NoBukti,a.TANGGAL,J.NAMACUSTSUPP,a.KODEVLS,a.KURS,

        sum(b.NDPP) as NDPP,sum(b.NDPPRp) as NDPPRP,sum(b.NPPNRp) as NPPNRp,sum(B.nnetrp) as NNETRP,a1.Nilai ByLainnya,

        a1.Nilai ByLainnya,case when COALESCE(a1.Nilai,0)=0 then sum(B.nnetrp) else sum(B.nnetrp)+a1.Nilai   GrandTotal

		From  dbBeli a 

		left outer join DBBELIDET B on b.NOBUKTI=a.NOBUKTI

		Left Outer Join DBCUSTSUPP J on a.KODESUPP = J.KODECUSTSUPP 

		Left Outer Join (select SUM(Nilai)Nilai,NoBuktiInv from DBPBIAYA Group By NoBuktiInv)A1 On A1.NoBuktiInv=A.NOBUKTI

		Where a.TANGGAL between @tgl1 and @tgl2

		and @Id=Case When Len(@ID)=3 Then Left(b.NoBukti,3) else Left(b.NoBukti,2)

		group by a.NOBUKTI,a.TANGGAL,j.NAMACUSTSUPP,a.KODEVLS,a.KURS,a1.Nilai,a.KODESUPP

		order by  J.NAMACUSTSUPP,a.NOBUKTI


else if @Choice='B'

if @NeedOto=0 or @NeedOto=1

	 if @TipeBayar=0 or @TipeBayar=1

	 Select 	Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,Case when H.IsJasa=1 Then B.NamaBrg else h.NAMABRG  NamaBrg,a.NoBukti,a.TANGGAL,a.KODESUPP,J.NAMACUSTSUPP,a.KODEVLS,a.KURS,

            sum(b.NDPP) as NDPP,sum(b.NDPPRp) as NDPPRP,sum(b.NPPNRp) as NPPNRp,sum(B.nnetrp) as NNETRP,a1.Nilai ByLainnya,

            a1.Nilai ByLainnya,case when COALESCE(a1.Nilai,0)=0 then sum(B.nnetrp) else sum(B.nnetrp)+a1.Nilai   GrandTotal

		From  dbBeli a 

		left outer join DBBELIDET B on b.NOBUKTI=a.NOBUKTI

		Left Outer Join DBCUSTSUPP J on a.KODESUPP = J.KODECUSTSUPP 

		Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg

		Left Outer Join (select SUM(Nilai)Nilai,NoBuktiInv from DBPBIAYA Group By NoBuktiInv)A1 On A1.NoBuktiInv=A.NOBUKTI	

		Where a.TANGGAL between @tgl1 and @tgl2 and TIPEBAYAR=@TipeBayar and

        Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                      Case when A.IsOtorisasi2=1 then 1 else 0 +

                      Case when A.IsOtorisasi3=1 then 1 else 0 +

                      Case when A.IsOtorisasi4=1 then 1 else 0 +

                      Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                 else 1

             As INTEGER)=@needOto

       and @Id=Case When Len(@ID)=3 Then Left(b.NoBukti,3) else Left(b.NoBukti,2)     		

		group by h.NAMABRG,B.NamaBrg,H.IsJasa,a.NOBUKTI,a.TANGGAL,j.NAMACUSTSUPP,a.KODEVLS,a.KURS,a1.Nilai,a.KODESUPP

		order by h.namabrg

	 else

		Select 	Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,Case when H.IsJasa=1 Then B.NamaBrg else h.NAMABRG  NamaBrg,a.NoBukti,a.TANGGAL,a.KODESUPP,J.NAMACUSTSUPP,a.KODEVLS,a.KURS,

            sum(b.NDPP) as NDPP,sum(b.NDPPRp) as NDPPRP,sum(b.NPPNRp) as NPPNRp,sum(B.nnetrp) as NNETRP,a1.Nilai ByLainnya,

            a1.Nilai ByLainnya,case when COALESCE(a1.Nilai,0)=0 then sum(B.nnetrp) else sum(B.nnetrp)+a1.Nilai   GrandTotal

		From  dbBeli a 

		left outer join DBBELIDET B on b.NOBUKTI=a.NOBUKTI

		Left Outer Join DBCUSTSUPP J on a.KODESUPP = J.KODECUSTSUPP 

		Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg

		Left Outer Join (select SUM(Nilai)Nilai,NoBuktiInv from DBPBIAYA Group By NoBuktiInv)A1 On A1.NoBuktiInv=A.NOBUKTI	

		Where a.TANGGAL between @tgl1 and @tgl2 and

        Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                      Case when A.IsOtorisasi2=1 then 1 else 0 +

                      Case when A.IsOtorisasi3=1 then 1 else 0 +

                      Case when A.IsOtorisasi4=1 then 1 else 0 +

                      Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                 else 1

             As INTEGER)=@needOto

       and @Id=Case When Len(@ID)=3 Then Left(b.NoBukti,3) else Left(b.NoBukti,2)     		

		group by h.NAMABRG,B.NamaBrg,H.IsJasa,a.NOBUKTI,a.TANGGAL,j.NAMACUSTSUPP,a.KODEVLS,a.KURS,a1.Nilai,a.KODESUPP

		order by h.namabrg

		

	if @NeedOto=2	

	 if @TipeBayar=0 or @TipeBayar=1

	  Select 	Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,Case when H.IsJasa=1 Then B.NamaBrg else h.NAMABRG  NAMABRG,a.NoBukti,a.TANGGAL,a.KODESUPP,J.NAMACUSTSUPP,a.KODEVLS,a.KURS,

            sum(b.NDPP) as NDPP,sum(b.NDPPRp) as NDPPRP,sum(b.NPPNRp) as NPPNRp,sum(B.nnetrp) as NNETRP,a1.Nilai ByLainnya,

            a1.Nilai ByLainnya,case when COALESCE(a1.Nilai,0)=0 then sum(B.nnetrp) else sum(B.nnetrp)+a1.Nilai   GrandTotal

		From  dbBeli a 

		left outer join DBBELIDET B on b.NOBUKTI=a.NOBUKTI

		Left Outer Join DBCUSTSUPP J on a.KODESUPP = J.KODECUSTSUPP 

		Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg

		Left Outer Join (select SUM(Nilai)Nilai,NoBuktiInv from DBPBIAYA Group By NoBuktiInv)A1 On A1.NoBuktiInv=A.NOBUKTI	

		Where a.TANGGAL between @tgl1 and @tgl2 and TIPEBAYAR=@TipeBayar

		and @Id=Case When Len(@ID)=3 Then Left(b.NoBukti,3) else Left(b.NoBukti,2)

		group by h.NAMABRG,B.NamaBrg,H.IsJasa,a.NOBUKTI,a.TANGGAL,j.NAMACUSTSUPP,a.KODEVLS,a.KURS,a1.Nilai,a.KODESUPP

		order by h.namabrg

	  else	

		Select 	Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,Case when H.IsJasa=1 Then B.NamaBrg else h.NAMABRG  NAMABRG,a.NoBukti,a.TANGGAL,a.KODESUPP,J.NAMACUSTSUPP,a.KODEVLS,a.KURS,

            sum(b.NDPP) as NDPP,sum(b.NDPPRp) as NDPPRP,sum(b.NPPNRp) as NPPNRp,sum(B.nnetrp) as NNETRP,a1.Nilai ByLainnya,

            a1.Nilai ByLainnya,case when COALESCE(a1.Nilai,0)=0 then sum(B.nnetrp) else sum(B.nnetrp)+a1.Nilai   GrandTotal

		From  dbBeli a 

		left outer join DBBELIDET B on b.NOBUKTI=a.NOBUKTI

		Left Outer Join DBCUSTSUPP J on a.KODESUPP = J.KODECUSTSUPP 

		Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg

		Left Outer Join (select SUM(Nilai)Nilai,NoBuktiInv from DBPBIAYA Group By NoBuktiInv)A1 On A1.NoBuktiInv=A.NOBUKTI	

		Where a.TANGGAL between @tgl1 and @tgl2

		and @Id=Case When Len(@ID)=3 Then Left(b.NoBukti,3) else Left(b.NoBukti,2)

		group by h.NAMABRG,B.NamaBrg,H.IsJasa,a.NOBUKTI,a.TANGGAL,j.NAMACUSTSUPP,a.KODEVLS,a.KURS,a1.Nilai,a.KODESUPP

		order by h.namabrg;

-- Sp_reportBeliGudangdet
CREATE PROCEDURE IF NOT EXISTS Sp_reportBeliGudangdet AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 

-- DECLARE REMOVED (10)

select @Devisi=Devisi from dbDevisi where NamaDevisi=@ID



if @Id=''

if @IsCustome=0

if @SReport='T'

If @Ordr='N'

		select 'Gabungan' Perusahaan,* from VwReportBeliGudang 

		  where Tanggal between @tgl1 and @tgl2 and qnt>0 

		  and NoBukti in(select KodeInputan from TempCustomizeReport where IDUser=@IDUser)

		  order by NoBukti,Tanggal

		 

	else If @Ordr='B'

		select 'Gabungan' Perusahaan,* from VwReportBeliGudang where (Tanggal between @tgl1 and @tgl2) and qnt>0  

		  and KodeBrg in(select KodeInputan from TempCustomizeReport where IDUser=@IDUser) 

		  order by KodeBrg

		 

	else If @Ordr='S'

		select 'Gabungan' Perusahaan,* from VwReportBeliGudang where (Tanggal between @tgl1 and @tgl2) and qnt>0  

		  and KodeCustSupp in(select KodeInputan from TempCustomizeReport where IDUser=@IDUser)

		  order by KodeCustSupp

		 

	else If @Ordr='G'

		select 'Gabungan' Perusahaan,* from VwReportBeliGudang where (Tanggal between @tgl1 and @tgl2) and qnt>0  order by KodeGDG


else

if @SReport='T'

If @Ordr='N'

		select 'Gabungan' Perusahaan,* from VwReportBeliGudang 

		  where Tanggal between @tgl1 and @tgl2 and qnt>0 order by NoBukti,Tanggal

		 

	else If @Ordr='B'

		select 'Gabungan' Perusahaan,* from VwReportBeliGudang where (Tanggal between @tgl1 and @tgl2) and qnt>0  order by KodeBrg

		 

	else If @Ordr='S'

		select 'Gabungan' Perusahaan,* from VwReportBeliGudang where (Tanggal between @tgl1 and @tgl2) and qnt>0  order by KodeCustSupp

		 

	else If @Ordr='G'

		select 'Gabungan' Perusahaan,* from VwReportBeliGudang where (Tanggal between @tgl1 and @tgl2) and qnt>0  order by KodeGDG


else

if @SReport='T'

if  @IsCustome=0

If @Ordr='N'

		select Case When @Devisi<>'02' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwReportBeliGudang 

		  where (Tanggal between @tgl1 and @tgl2) and qnt>0 

		  --and @Id=Case When Len(@ID)=3 Then Left(NoBukti,3) else Left(NoBukti,2)

		  and NoBukti in(select KodeInputan from TempCustomizeReport where IDUser=@IDUser)

		  and Devisi=@Devisi

		  order by NoBukti,Tanggal

		 

	else If @Ordr='B'

		select Case When  @Devisi<>'02' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwReportBeliGudang where (Tanggal between @tgl1 and @tgl2) and qnt>0  

		  and Devisi=@Devisi

		  and KodeBrg in(select KodeInputan from TempCustomizeReport where IDUser=@IDUser)

		  order by KodeBrg

		 

	else If @Ordr='S'

		select Case When  @Devisi<>'02' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwReportBeliGudang where (Tanggal between @tgl1 and @tgl2) and qnt>0  

		  and Devisi=@Devisi

		  and KodeCustSupp in(select KodeInputan from TempCustomizeReport where IDUser=@IDUser)

		  order by KodeCustSupp

		 

	else If @Ordr='G'

		select Case When  @Devisi<>'02' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwReportBeliGudang where (Tanggal between @tgl1 and @tgl2) and qnt>0 

		  and Devisi=@Devisi 

		  and KodeGdg in(select KodeInputan from TempCustomizeReport where IDUser=@IDUser)

		  order by KodeGDG


else

If @Ordr='N'

		select Case When @Devisi<>'02' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwReportBeliGudang 

		  where (Tanggal between @tgl1 and @tgl2) and qnt>0 

		  --and @Id=Case When Len(@ID)=3 Then Left(NoBukti,3) else Left(NoBukti,2)

		  and Devisi=@Devisi

		   

		  order by NoBukti,Tanggal

		 

	else If @Ordr='B'

		select Case When  @Devisi<>'02' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwReportBeliGudang where (Tanggal between @tgl1 and @tgl2) and qnt>0  

		  and Devisi=@Devisi

		  order by KodeBrg

		 

	else If @Ordr='S'

		select Case When  @Devisi<>'02' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwReportBeliGudang where (Tanggal between @tgl1 and @tgl2) and qnt>0  

		  and Devisi=@Devisi

		  order by KodeCustSupp

		 

	else If @Ordr='G'

		select Case When  @Devisi<>'02' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwReportBeliGudang where (Tanggal between @tgl1 and @tgl2) and qnt>0 

		  and Devisi=@Devisi 

		  order by KodeGDG;

-- Sp_ReportBeliGudangRek
CREATE PROCEDURE IF NOT EXISTS Sp_ReportBeliGudangRek AS ---- DECLARE REMOVED,@Tgl1 Datetime,@tgl2 datetime

--select @Tgl1='01/01/2012',@tgl2='07/17/2013',@Choice='B'

if @Id=''

If @Choice='N'

Select 	'Gabungan' Perusahaan,A.NoBukti,A.TANGGAL,A.KODESUPP KodeCustSupp,I.NAMACUSTSUPP,

	 Sum(COALESCE(B.Qnt,0)) Qnt,Sum(COALESCE(B.Harga,0))Harga, Sum(COALESCE(B.HrgNetto,0))HrgNetto,

        --Sum(COALESCE(B.DiscP,0)) DiscP1, Sum(COALESCE(B.DiscTot,0)) DiscRp1, Sum(COALESCE(B.DiscP2,0)) DiscP2,

        Sum(COALESCE(B.DiscP,0)) DiscP1, Sum(COALESCE(B.DiscTot,0)) DiscRp1, Sum(0) DiscP2,

        --Sum(COALESCE(B.DiscTot2,0)) DiscRp2,sum(COALESCE(B.DiscTot,0)) Disctot,

        Sum(0) DiscRp2,sum(COALESCE(B.DiscTot,0)) Disctot,

        Sum(COALESCE(B.SubTotal,0)) TotalUSD, Sum(COALESCE(B.SubTotal,0)) TotalIDR, Sum(COALESCE(B.NDPP,0)) NDPP,

        Sum(COALESCE(B.NPPN,0)) NPPN, Sum(COALESCE(B.BYAngkut,0)) Beban, Sum(COALESCE(B.SubTotal,0)) + Sum(COALESCE(B.BYAngkut,0)) Total

From dbBeliDet B 

Left Outer Join dbBeli A On A.NoBukti=b.NoBukti

Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg

Left Outer Join DBCUSTSUPP I on A.KODESUPP = I.KODECUSTSUPP

where A.tanggal between @tgl1 and @Tgl2

Group By A.NoBukti,A.TANGGAL,A.KODESUPP ,I.NAMACUSTSUPP

Order by A.NoBukti,A.TANGGAL,A.KODESUPP ,I.NAMACUSTSUPP


else if @Choice='S'

Select 'Gabungan' Perusahaan,A.KODESUPP KodeCustSupp,I.NAMACUSTSUPP,

	 Sum(COALESCE(B.Qnt,0)) Qnt,Sum(COALESCE(B.Harga,0))Harga, Sum(COALESCE(B.HrgNetto,0))HrgNetto,

        --Sum(COALESCE(B.DiscP,0)) DiscP1, Sum(COALESCE(B.DiscTot,0)) DiscRp1, Sum(COALESCE(B.DiscP2,0)) DiscP2,

        Sum(COALESCE(B.DiscP,0)) DiscP1, Sum(COALESCE(B.DiscTot,0)) DiscRp1, Sum(0) DiscP2,

        --Sum(COALESCE(B.DiscTot2,0)) DiscRp2,sum(COALESCE(B.DiscTot,0)) Disctot,

        Sum(0) DiscRp2,sum(COALESCE(B.DiscTot,0)) Disctot,

        Sum(COALESCE(B.SubTotal,0)) TotalUSD, Sum(COALESCE(B.SubTotal,0)) TotalIDR, Sum(COALESCE(B.NDPP,0)) NDPP,

        Sum(COALESCE(B.NPPN,0)) NPPN, Sum(COALESCE(B.BYAngkut,0)) Beban, Sum(COALESCE(B.SubTotal,0)) + Sum(COALESCE(B.BYAngkut,0)) Total

From dbBeliDet B 

Left Outer Join dbBeli A On A.NoBukti=b.NoBukti

Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg

Left Outer Join DBCUSTSUPP I on A.KODESUPP = I.KODECUSTSUPP

where A.tanggal between @tgl1 and @Tgl2

Group By A.TANGGAL,A.KODESUPP ,I.NAMACUSTSUPP

Order By I.NAMACUSTSUPP,A.KODESUPP ,A.TANGGAL



else if @Choice='B'

Select 'Gabungan' Perusahaan,B.KodeBrg,H.NAMABRG,A.TANGGAL,

	 Sum(COALESCE(B.Qnt,0)) Qnt,Sum(COALESCE(B.Harga,0))Harga, Sum(COALESCE(B.HrgNetto,0))HrgNetto,

        --Sum(COALESCE(B.DiscP,0)) DiscP1, Sum(COALESCE(B.DiscTot,0)) DiscRp1, Sum(COALESCE(B.DiscP2,0)) DiscP2,

        Sum(COALESCE(B.DiscP,0)) DiscP1, Sum(COALESCE(B.DiscTot,0)) DiscRp1, Sum(0) DiscP2,

        --Sum(COALESCE(B.DiscTot2,0)) DiscRp2,sum(COALESCE(B.DiscTot,0)) Disctot,

        Sum(0) DiscRp2,sum(COALESCE(B.DiscTot,0)) Disctot,

        Sum(COALESCE(B.SubTotal,0)) TotalUSD, Sum(COALESCE(B.SubTotal,0)) TotalIDR, Sum(COALESCE(B.NDPP,0)) NDPP,

        Sum(COALESCE(B.NPPN,0)) NPPN, Sum(COALESCE(B.BYAngkut,0)) Beban, Sum(COALESCE(B.SubTotal,0)) + Sum(COALESCE(B.BYAngkut,0)) Total

From dbBeliDet B 

Left Outer Join dbBeli A On A.NoBukti=b.NoBukti

Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg

Left Outer Join DBCUSTSUPP I on A.KODESUPP = I.KODECUSTSUPP

where A.tanggal between @tgl1 and @Tgl2

Group By B.KodeBrg,H.NAMABRG,A.TANGGAl

Order By B.KodeBrg,H.NAMABRG,A.TANGGAL


else

If @Choice='N'

Select 	Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,A.NoBukti,A.TANGGAL,A.KODESUPP KodeCustSupp,I.NAMACUSTSUPP,

	 Sum(COALESCE(B.Qnt,0)) Qnt,Sum(COALESCE(B.Harga,0))Harga, Sum(COALESCE(B.HrgNetto,0))HrgNetto,

        --Sum(COALESCE(B.DiscP,0)) DiscP1, Sum(COALESCE(B.DiscTot,0)) DiscRp1, Sum(COALESCE(B.DiscP2,0)) DiscP2,

        Sum(COALESCE(B.DiscP,0)) DiscP1, Sum(COALESCE(B.DiscTot,0)) DiscRp1, Sum(0) DiscP2,

        --Sum(COALESCE(B.DiscTot2,0)) DiscRp2,sum(COALESCE(B.DiscTot,0)) Disctot,

        Sum(0) DiscRp2,sum(COALESCE(B.DiscTot,0)) Disctot,

        Sum(COALESCE(B.SubTotal,0)) TotalUSD, Sum(COALESCE(B.SubTotal,0)) TotalIDR, Sum(COALESCE(B.NDPP,0)) NDPP,

        Sum(COALESCE(B.NPPN,0)) NPPN, Sum(COALESCE(B.BYAngkut,0)) Beban, Sum(COALESCE(B.SubTotal,0)) + Sum(COALESCE(B.BYAngkut,0)) Total

From dbBeliDet B 

Left Outer Join dbBeli A On A.NoBukti=b.NoBukti

Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg

Left Outer Join DBCUSTSUPP I on A.KODESUPP = I.KODECUSTSUPP

where A.tanggal between @tgl1 and @Tgl2

and @Id=Case When Len(@ID)=3 Then Left(b.NoBukti,3) else Left(b.NoBukti,2)

Group By A.NoBukti,A.TANGGAL,A.KODESUPP ,I.NAMACUSTSUPP

Order by A.NoBukti,A.TANGGAL,A.KODESUPP ,I.NAMACUSTSUPP


else if @Choice='S'

Select Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,A.KODESUPP KodeCustSupp,I.NAMACUSTSUPP,

	 Sum(COALESCE(B.Qnt,0)) Qnt,Sum(COALESCE(B.Harga,0))Harga, Sum(COALESCE(B.HrgNetto,0))HrgNetto,

        --Sum(COALESCE(B.DiscP,0)) DiscP1, Sum(COALESCE(B.DiscTot,0)) DiscRp1, Sum(COALESCE(B.DiscP2,0)) DiscP2,

        Sum(COALESCE(B.DiscP,0)) DiscP1, Sum(COALESCE(B.DiscTot,0)) DiscRp1, Sum(0) DiscP2,

        --Sum(COALESCE(B.DiscTot2,0)) DiscRp2,sum(COALESCE(B.DiscTot,0)) Disctot,

        Sum(0) DiscRp2,sum(COALESCE(B.DiscTot,0)) Disctot,

        Sum(COALESCE(B.SubTotal,0)) TotalUSD, Sum(COALESCE(B.SubTotal,0)) TotalIDR, Sum(COALESCE(B.NDPP,0)) NDPP,

        Sum(COALESCE(B.NPPN,0)) NPPN, Sum(COALESCE(B.BYAngkut,0)) Beban, Sum(COALESCE(B.SubTotal,0)) + Sum(COALESCE(B.BYAngkut,0)) Total

From dbBeliDet B 

Left Outer Join dbBeli A On A.NoBukti=b.NoBukti

Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg

Left Outer Join DBCUSTSUPP I on A.KODESUPP = I.KODECUSTSUPP

where A.tanggal between @tgl1 and @Tgl2

and @Id=Case When Len(@ID)=3 Then Left(b.NoBukti,3) else Left(b.NOBUKTI,2)

Group By A.TANGGAL,A.KODESUPP ,I.NAMACUSTSUPP

Order By I.NAMACUSTSUPP,A.KODESUPP ,A.TANGGAL



else if @Choice='B'

Select Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,B.KodeBrg,H.NAMABRG,A.TANGGAL,

	 Sum(COALESCE(B.Qnt,0)) Qnt,Sum(COALESCE(B.Harga,0))Harga, Sum(COALESCE(B.HrgNetto,0))HrgNetto,

        --Sum(COALESCE(B.DiscP,0)) DiscP1, Sum(COALESCE(B.DiscTot,0)) DiscRp1, Sum(COALESCE(B.DiscP2,0)) DiscP2,

        Sum(COALESCE(B.DiscP,0)) DiscP1, Sum(COALESCE(B.DiscTot,0)) DiscRp1, Sum(0) DiscP2,

        --Sum(COALESCE(B.DiscTot2,0)) DiscRp2,sum(COALESCE(B.DiscTot,0)) Disctot,

        Sum(0) DiscRp2,sum(COALESCE(B.DiscTot,0)) Disctot,

        Sum(COALESCE(B.SubTotal,0)) TotalUSD, Sum(COALESCE(B.SubTotal,0)) TotalIDR, Sum(COALESCE(B.NDPP,0)) NDPP,

        Sum(COALESCE(B.NPPN,0)) NPPN, Sum(COALESCE(B.BYAngkut,0)) Beban, Sum(COALESCE(B.SubTotal,0)) + Sum(COALESCE(B.BYAngkut,0)) Total

From dbBeliDet B 

Left Outer Join dbBeli A On A.NoBukti=b.NoBukti

Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg

Left Outer Join DBCUSTSUPP I on A.KODESUPP = I.KODECUSTSUPP

where A.tanggal between @tgl1 and @Tgl2

and @Id=Case When Len(@ID)=3 Then Left(b.NoBukti,3) else Left(b.NOBUKTI,2)

Group By B.KodeBrg,H.NAMABRG,A.TANGGAl

Order By B.KodeBrg,H.NAMABRG,A.TANGGAL;

-- Sp_reportbelirejectDet
CREATE PROCEDURE IF NOT EXISTS Sp_reportbelirejectDet AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 



if @SReport='T'

If @Ordr='N'

		select NoBukti,TANGGAL,NoPO,NAMACUSTSUPP,KodeBrg,NamaBrg,sum(qnt) qnt,satuan,sum(qnt2) qnt2,satuan2,sum(qntreject) qntreject,sum(qnt2reject) qnt2reject,

		  SUM(COALESCE(qnt,0)-COALESCE(qntreject,0)) sisa,SUM(COALESCE(qnt2,0)-COALESCE(qnt2reject,0)) sisa2

		  from VwReportBeliGudang where Tanggal between @tgl1 and @tgl2 

		  group by NoBukti,KodeBrg,TANGGAL,NoPO,NAMACUSTSUPP,KodeBrg,namabrg,satuan,satuan2	

		  order by NoBukti,Tanggal

		 

	else If @Ordr='B'

		select NoBukti,TANGGAL,NoPO,NAMACUSTSUPP,KodeBrg,NamaBrg,sum(qnt) qnt,satuan,sum(qnt2) qnt2,satuan2,sum(qntreject) qntreject,sum(qnt2reject) qnt2reject,

		  SUM(COALESCE(qnt,0)-COALESCE(qntreject,0)) sisa,SUM(COALESCE(qnt2,0)-COALESCE(qnt2reject,0)) sisa2

		  from VwReportBeliGudang where Tanggal between @tgl1 and @tgl2 

		  group by NoBukti,KodeBrg,TANGGAL,NoPO,NAMACUSTSUPP,KodeBrg,namabrg,satuan,satuan2	

		  order by KodeBrg

		 

	else If @Ordr='S'

		select kodecustsupp,NoBukti,TANGGAL,NoPO,NAMACUSTSUPP,KodeBrg,NamaBrg,sum(qnt) qnt,satuan,sum(qnt2) qnt2,satuan2,sum(qntreject) qntreject,sum(qnt2reject) qnt2reject,

		  SUM(COALESCE(qnt,0)-COALESCE(qntreject,0)) sisa,SUM(COALESCE(qnt2,0)-COALESCE(qnt2reject,0)) sisa2

		  from VwReportBeliGudang where Tanggal between @tgl1 and @tgl2 

		  group by KodeCustSupp,NoBukti,KodeBrg,TANGGAL,NoPO,NAMACUSTSUPP,KodeBrg,namabrg,satuan,satuan2	

		  order by KodeCustSupp

		 

	else If @Ordr='G'

		select kodegdg,NoBukti,TANGGAL,NoPO,NAMACUSTSUPP,KodeBrg,NamaBrg,sum(qnt) qnt,satuan,sum(qnt2) qnt2,satuan2,sum(qntreject) qntreject,sum(qnt2reject) qnt2reject,

		  SUM(COALESCE(qnt,0)-COALESCE(qntreject,0)) sisa,SUM(COALESCE(qnt2,0)-COALESCE(qnt2reject,0)) sisa2

		  from VwReportBeliGudang where Tanggal between @tgl1 and @tgl2 

		  group by kodegdg,NoBukti,KodeBrg,TANGGAL,NoPO,NAMACUSTSUPP,KodeBrg,namabrg,satuan,satuan2	

		  order by KodeGdg;

-- Sp_ReportBeliRejectRek
CREATE PROCEDURE IF NOT EXISTS Sp_ReportBeliRejectRek AS ---- DECLARE REMOVED,@Tgl1 Datetime,@tgl2 datetime

--select @Tgl1='01/01/2012',@tgl2='07/17/2013',@Choice='B'

if @Id=''

If @Choice='N'

Select 	'Gabungan' Perusahaan,A.NoBukti,A.TANGGAL,A.KODESUPP KodeCustSupp,I.NAMACUSTSUPP,

	Sum(COALESCE(B.Qnt,0)) Qnt,Sum(COALESCE(B.Harga,0))Harga, Sum(COALESCE(B.HrgNetto,0))HrgNetto,

        --Sum(COALESCE(B.DiscP,0)) DiscP1, Sum(COALESCE(B.DiscTot,0)) DiscRp1, Sum(COALESCE(B.DiscP2,0)) DiscP2,

        Sum(COALESCE(B.DiscP,0)) DiscP1, Sum(COALESCE(B.DiscTot,0)) DiscRp1, Sum(0) DiscP2,

        --Sum(COALESCE(B.DiscTot2,0)) DiscRp2,sum(COALESCE(B.DiscTot,0)) Disctot,

        Sum(0) DiscRp2,sum(COALESCE(B.DiscTot,0)) Disctot,

        Sum(COALESCE(B.SubTotal,0)) TotalUSD, Sum(COALESCE(B.SubTotal,0)) TotalIDR, Sum(COALESCE(B.NDPP,0)) NDPP,

        Sum(COALESCE(B.NPPN,0)) NPPN, Sum(COALESCE(B.BYAngkut,0)) Beban, Sum(COALESCE(B.SubTotal,0)) + Sum(COALESCE(B.BYAngkut,0)) Total

	From dbBeliDet B 

	Left Outer Join dbBeli A On A.NoBukti=b.NoBukti

	Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg

	Left Outer Join DBCUSTSUPP I on A.KODESUPP = I.KODECUSTSUPP

	where A.tanggal between @tgl1 and @Tgl2

	Group By A.NoBukti,A.TANGGAL,A.KODESUPP ,I.NAMACUSTSUPP

	Order by A.NoBukti,A.TANGGAL,A.KODESUPP ,I.NAMACUSTSUPP



else if @Choice='S'

Select 'Gabungan' Perusahaan,A.KODESUPP KodeCustSupp,I.NAMACUSTSUPP,

	 Sum(COALESCE(B.Qnt,0)) Qnt,Sum(COALESCE(B.Harga,0))Harga, Sum(COALESCE(B.HrgNetto,0))HrgNetto,

        --Sum(COALESCE(B.DiscP,0)) DiscP1, Sum(COALESCE(B.DiscTot,0)) DiscRp1, Sum(COALESCE(B.DiscP2,0)) DiscP2,

        Sum(COALESCE(B.DiscP,0)) DiscP1, Sum(COALESCE(B.DiscTot,0)) DiscRp1, Sum(0) DiscP2,

        --Sum(COALESCE(B.DiscTot2,0)) DiscRp2,sum(COALESCE(B.DiscTot,0)) Disctot,

        Sum(0) DiscRp2,sum(COALESCE(B.DiscTot,0)) Disctot,

        Sum(COALESCE(B.SubTotal,0)) TotalUSD, Sum(COALESCE(B.SubTotal,0)) TotalIDR, Sum(COALESCE(B.NDPP,0)) NDPP,

        Sum(COALESCE(B.NPPN,0)) NPPN, Sum(COALESCE(B.BYAngkut,0)) Beban, Sum(COALESCE(B.SubTotal,0)) + Sum(COALESCE(B.BYAngkut,0)) Total

	From dbBeliDet B 

	Left Outer Join dbBeli A On A.NoBukti=b.NoBukti

	Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg

	Left Outer Join DBCUSTSUPP I on A.KODESUPP = I.KODECUSTSUPP

	where A.tanggal between @tgl1 and @Tgl2

	Group By A.TANGGAL,A.KODESUPP ,I.NAMACUSTSUPP

	Order By I.NAMACUSTSUPP,A.KODESUPP ,A.TANGGAL



else if @Choice='B'

Select 'Gabungan' Perusahaan,B.KodeBrg,H.NAMABRG,A.TANGGAL,

	Sum(COALESCE(B.Qnt,0)) Qnt,Sum(COALESCE(B.Harga,0))Harga, Sum(COALESCE(B.HrgNetto,0))HrgNetto,

        --Sum(COALESCE(B.DiscP,0)) DiscP1, Sum(COALESCE(B.DiscTot,0)) DiscRp1, Sum(COALESCE(B.DiscP2,0)) DiscP2,

        Sum(COALESCE(B.DiscP,0)) DiscP1, Sum(COALESCE(B.DiscTot,0)) DiscRp1, Sum(0) DiscP2,

        --Sum(COALESCE(B.DiscTot2,0)) DiscRp2,sum(COALESCE(B.DiscTot,0)) Disctot,

        Sum(0) DiscRp2,sum(COALESCE(B.DiscTot,0)) Disctot,

        Sum(COALESCE(B.SubTotal,0)) TotalUSD, Sum(COALESCE(B.SubTotal,0)) TotalIDR, Sum(COALESCE(B.NDPP,0)) NDPP,

        Sum(COALESCE(B.NPPN,0)) NPPN, Sum(COALESCE(B.BYAngkut,0)) Beban, Sum(COALESCE(B.SubTotal,0)) + Sum(COALESCE(B.BYAngkut,0)) Total

	From dbBeliDet B 

	Left Outer Join dbBeli A On A.NoBukti=b.NoBukti

	Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg

	Left Outer Join DBCUSTSUPP I on A.KODESUPP = I.KODECUSTSUPP

	where A.tanggal between @tgl1 and @Tgl2

	Group By B.KodeBrg,H.NAMABRG,A.TANGGAl

	Order By B.KodeBrg,H.NAMABRG,A.TANGGAL


else-----------

If @Choice='N'

Select 	Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,A.NoBukti,A.TANGGAL,A.KODESUPP KodeCustSupp,I.NAMACUSTSUPP,

	Sum(COALESCE(B.Qnt,0)) Qnt,Sum(COALESCE(B.Harga,0))Harga, Sum(COALESCE(B.HrgNetto,0))HrgNetto,

        --Sum(COALESCE(B.DiscP,0)) DiscP1, Sum(COALESCE(B.DiscTot,0)) DiscRp1, Sum(COALESCE(B.DiscP2,0)) DiscP2,

        Sum(COALESCE(B.DiscP,0)) DiscP1, Sum(COALESCE(B.DiscTot,0)) DiscRp1, Sum(0) DiscP2,

        --Sum(COALESCE(B.DiscTot2,0)) DiscRp2,sum(COALESCE(B.DiscTot,0)) Disctot,

        Sum(0) DiscRp2,sum(COALESCE(B.DiscTot,0)) Disctot,

        Sum(COALESCE(B.SubTotal,0)) TotalUSD, Sum(COALESCE(B.SubTotal,0)) TotalIDR, Sum(COALESCE(B.NDPP,0)) NDPP,

        Sum(COALESCE(B.NPPN,0)) NPPN, Sum(COALESCE(B.BYAngkut,0)) Beban, Sum(COALESCE(B.SubTotal,0)) + Sum(COALESCE(B.BYAngkut,0)) Total

	From dbBeliDet B 

	Left Outer Join dbBeli A On A.NoBukti=b.NoBukti

	Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg

	Left Outer Join DBCUSTSUPP I on A.KODESUPP = I.KODECUSTSUPP

	where A.tanggal between @tgl1 and @Tgl2

	and @Id=Case When Len(@ID)=3 Then Left(a.NoBukti,3) else Left(a.NOBUKTI,2)

	Group By A.NoBukti,A.TANGGAL,A.KODESUPP ,I.NAMACUSTSUPP

	Order by A.NoBukti,A.TANGGAL,A.KODESUPP ,I.NAMACUSTSUPP



else if @Choice='S'

Select Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,A.KODESUPP KodeCustSupp,I.NAMACUSTSUPP,

	 Sum(COALESCE(B.Qnt,0)) Qnt,Sum(COALESCE(B.Harga,0))Harga, Sum(COALESCE(B.HrgNetto,0))HrgNetto,

        --Sum(COALESCE(B.DiscP,0)) DiscP1, Sum(COALESCE(B.DiscTot,0)) DiscRp1, Sum(COALESCE(B.DiscP2,0)) DiscP2,

        Sum(COALESCE(B.DiscP,0)) DiscP1, Sum(COALESCE(B.DiscTot,0)) DiscRp1, Sum(0) DiscP2,

        --Sum(COALESCE(B.DiscTot2,0)) DiscRp2,sum(COALESCE(B.DiscTot,0)) Disctot,

        Sum(0) DiscRp2,sum(COALESCE(B.DiscTot,0)) Disctot,

        Sum(COALESCE(B.SubTotal,0)) TotalUSD, Sum(COALESCE(B.SubTotal,0)) TotalIDR, Sum(COALESCE(B.NDPP,0)) NDPP,

        Sum(COALESCE(B.NPPN,0)) NPPN, Sum(COALESCE(B.BYAngkut,0)) Beban, Sum(COALESCE(B.SubTotal,0)) + Sum(COALESCE(B.BYAngkut,0)) Total

	From dbBeliDet B 

	Left Outer Join dbBeli A On A.NoBukti=b.NoBukti

	Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg

	Left Outer Join DBCUSTSUPP I on A.KODESUPP = I.KODECUSTSUPP

	where A.tanggal between @tgl1 and @Tgl2

	and @Id=Case When Len(@ID)=3 Then Left(a.NoBukti,3) else Left(a.NOBUKTI,2)

	Group By A.TANGGAL,A.KODESUPP ,I.NAMACUSTSUPP

	Order By I.NAMACUSTSUPP,A.KODESUPP ,A.TANGGAL



else if @Choice='B'

Select Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,B.KodeBrg,H.NAMABRG,A.TANGGAL,

	Sum(COALESCE(B.Qnt,0)) Qnt,Sum(COALESCE(B.Harga,0))Harga, Sum(COALESCE(B.HrgNetto,0))HrgNetto,

        --Sum(COALESCE(B.DiscP,0)) DiscP1, Sum(COALESCE(B.DiscTot,0)) DiscRp1, Sum(COALESCE(B.DiscP2,0)) DiscP2,

        Sum(COALESCE(B.DiscP,0)) DiscP1, Sum(COALESCE(B.DiscTot,0)) DiscRp1, Sum(0) DiscP2,

        --Sum(COALESCE(B.DiscTot2,0)) DiscRp2,sum(COALESCE(B.DiscTot,0)) Disctot,

        Sum(0) DiscRp2,sum(COALESCE(B.DiscTot,0)) Disctot,

        Sum(COALESCE(B.SubTotal,0)) TotalUSD, Sum(COALESCE(B.SubTotal,0)) TotalIDR, Sum(COALESCE(B.NDPP,0)) NDPP,

        Sum(COALESCE(B.NPPN,0)) NPPN, Sum(COALESCE(B.BYAngkut,0)) Beban, Sum(COALESCE(B.SubTotal,0)) + Sum(COALESCE(B.BYAngkut,0)) Total

	From dbBeliDet B 

	Left Outer Join dbBeli A On A.NoBukti=b.NoBukti

	Left Outer Join dbBarang H on H.KodeBrg=B.KodeBrg

	Left Outer Join DBCUSTSUPP I on A.KODESUPP = I.KODECUSTSUPP

	where A.tanggal between @tgl1 and @Tgl2

	and @Id=Case When Len(@ID)=3 Then Left(a.NoBukti,3) else Left(a.NOBUKTI,2)

	Group By B.KodeBrg,H.NAMABRG,A.TANGGAl

	Order By B.KodeBrg,H.NAMABRG,A.TANGGAL;

-- sp_ReportBon
CREATE PROCEDURE IF NOT EXISTS sp_ReportBon AS -- SET REMOVEDcase when @devisi in ('-','') then '%' else @devisi 

select a.nobukti,a.tanggal,a.penerima,a.keterangan,a.debet,

          (select sum(b.kredit) from dbbon b where b.devisi=a.devisi and b.perkiraan=a.perkiraan and b.nobukti=a.nobukti and b.tanggal between @tanggal and @Tanggal1) as kredit, 

          (a.debet-(select sum(b.kredit) from dbbon b 

                         where b.devisi=a.devisi and b.perkiraan=a.perkiraan and b.nobukti=a.nobukti and b.tanggal between @tanggal and @Tanggal1)) as sld

from dbbon a

where (Select sum(b.debet-b.kredit) 

            from dbbon b

            where a.devisi=b.devisi and a.nobukti = b.nobukti and a.perkiraan=b.perkiraan and (b.tanggal between @tanggal and @Tanggal1)

            group by b.nobukti) <> 0

           and (a.tanggal between @tanggal and @Tanggal1) and (a.perkiraan=@perkiraan) and (a.devisi like @devisi) and a.debet<>0 

group by a.devisi,a.perkiraan,a.nobukti,a.tanggal,a.penerima,a.keterangan,a.debet

order by a.devisi,a.perkiraan,a.nobukti;

-- Sp_reportBP
CREATE PROCEDURE IF NOT EXISTS Sp_reportBP AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 

if @Id=''

if @Ordr='N'

if @isiList=''

		exec(' 

		  select ''Gabungan'' Perusahaan,* from VwreportBP where Tanggal between'+ @tgl1+' and '+@tgl2+' 

		  order by NoBukti,Tanggal')

		

		else

		exec(' 

		  select ''Gabungan'' Perusahaan,* from VwreportBP where Tanggal between'+ @tgl1+' and '+@tgl2+'

		  and NoBukti in '+@isiList+'  

		  order by NoBukti,Tanggal')


else If @Ordr='B'

If @isiList=''

		exec(' select ''Gabungan'' Perusahaan,* from VwreportBP where Tanggal between '+@tgl1+' and '+@tgl2+' 

		   order by KodeGroup,KodeBrg')

	    

	    else

	    exec('select ''Gabungan'' Perusahaan,* from VwreportBP where Tanggal between '+@tgl1+' and '+@tgl2+' 

		   and KodeBrg in '+@isiList+'  

		   order by KodeGroup,KodeBrg')


else If @Ordr='D'

If @isiList=''

		exec(' select ''Gabungan'' Perusahaan,* from VwreportBP where Tanggal between '+@tgl1+' and '+@tgl2+' 

		   order by KdDep,NMDEP,nobukti')

	    

	    else

	    exec('select ''Gabungan'' Perusahaan,* from VwreportBP where Tanggal between '+@tgl1+' and '+@tgl2+' 

		   and KdDep in '+@isiList+'  

		   order by KdDep,NMDEP,nobukti')


else If @Ordr='P'

If @isiList=''

		exec(' select ''Gabungan'' Perusahaan,* from VwreportBP where Tanggal between '+@tgl1+' and '+@tgl2+' 

		   and COALESCE(NOPOL,'''')<>'''' and kdDep=''MT-K''

		   order by NoPOL,NMDEP')

	    

	    else

	    exec('select ''Gabungan'' Perusahaan,* from VwreportBP where Tanggal between '+@tgl1+' and '+@tgl2+' 

		   and COALESCE(NOPOL,'''')<>'''' and kdDep=''MT-K''

		   and NoPOL in '+@isiList+'  

		   order by NoPOL,NMDEP')


else If @Ordr='S'

If @isiList=''

		exec(' select ''Gabungan'' Perusahaan,* from VwreportBP where Tanggal between '+@tgl1+' and '+@tgl2+' 

		   and COALESCE(Supir,'''')<>'''' and kdDep=''MT-K''

		   order by Supir,NMDEP')

	    

	    else

	    exec('select ''Gabungan'' Perusahaan,* from VwreportBP where Tanggal between '+@tgl1+' and '+@tgl2+' 

		   and Supir in '+@isiList+' and kdDep=''MT-K'' 

		   order by Supir,NMDEP')


else----------

if @Ordr='N'

if @isiList=''

		exec(' 

		  select case when '''+@ID+'''=''BCA'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportBP where Tanggal between'+ @tgl1+' and '+@tgl2+' 

		  and '''+@ID+'''=Case When Len('''+@ID+''')=3 Then Left(NoBukti,3) else Left(NoBukti,2) 

		  order by NoBukti,Tanggal')

		

		else

		exec(' 

		  select case when '''+@ID+'''=''BCA'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportBP where Tanggal between'+ @tgl1+' and '+@tgl2+'

		  and NoBukti in '+@isiList+'  

		  and '''+@ID+'''=Case When Len('''+@ID+''')=3 Then Left(NoBukti,3) else Left(NoBukti,2) 

		  order by NoBukti,Tanggal')


else If @Ordr='B'

If @isiList=''

		exec(' select case when '''+@ID+'''=''BCA'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportBP where Tanggal between '+@tgl1+' and '+@tgl2+' 

		 and '''+@ID+'''=Case When Len('''+@ID+''')=3 Then Left(NoBukti,3) else Left(NoBukti,2) 

		   order by KodeGroup,KodeBrg')

	    

	    else

	    exec('select case when '''+@ID+'''=''BCA'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportBP where Tanggal between '+@tgl1+' and '+@tgl2+' 

		   and KodeBrg in '+@isiList+'  

		   and '''+@ID+'''=Case When Len('''+@ID+''')=3 Then Left(NoBukti,3) else Left(NoBukti,2) 

		   order by KodeGroup,KodeBrg')


else If @Ordr='D'

If @isiList=''

		exec(' select case when '''+@ID+'''=''BCA'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportBP where Tanggal between '+@tgl1+' and '+@tgl2+' 

		 and '''+@ID+'''=Case When Len('''+@ID+''')=3 Then Left(NoBukti,3) else Left(NoBukti,2) 

		   order by KdDep,NMDEP,nobukti')

	    

	    else

	    exec('select case when '''+@ID+'''=''BCA'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportBP where Tanggal between '+@tgl1+' and '+@tgl2+' 

		   and KdDep in '+@isiList+' 

		   and '''+@ID+'''=Case When Len('''+@ID+''')=3 Then Left(NoBukti,3) else Left(NoBukti,2)  

		   order by KdDep,NMDEP,nobukti')


else If @Ordr='P'

If @isiList=''

		exec(' select case when '''+@ID+'''=''BCA'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportBP where Tanggal between '+@tgl1+' and '+@tgl2+' 

		   and COALESCE(NOPOL,'''')<>'''' and kdDep=''MT-K''

		   and '''+@ID+'''=Case When Len('''+@ID+''')=3 Then Left(NoBukti,3) else Left(NoBukti,2) 

		   order by NoPOL,NMDEP')

	    

	    else

	    exec('select case when '''+@ID+'''=''BCA'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportBP where Tanggal between '+@tgl1+' and '+@tgl2+' 

		   and COALESCE(NOPOL,'''')<>'''' and kdDep=''MT-K''

		   and NoPOL in '+@isiList+'  

		   and '''+@ID+'''=Case When Len('''+@ID+''')=3 Then Left(NoBukti,3) else Left(NoBukti,2) 

		   order by NoPOL,NMDEP')


else If @Ordr='S'

If @isiList=''

		exec(' select case when '''+@ID+'''=''BCA'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportBP where Tanggal between '+@tgl1+' and '+@tgl2+' 

		   and COALESCE(Supir,'''')<>'''' and kdDep=''MT-K''

		   and '''+@ID+'''=Case When Len('''+@ID+''')=3 Then Left(NoBukti,3) else Left(NoBukti,2) 

		   order by Supir,NMDEP')

	    

	    else

	    exec('select case when '''+@ID+'''=''BCA'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportBP where Tanggal between '+@tgl1+' and '+@tgl2+' 

		   and Supir in '+@isiList+' and kdDep=''MT-K'' 

		   and '''+@ID+'''=Case When Len('''+@ID+''')=3 Then Left(NoBukti,3) else Left(NoBukti,2) 

		   order by Supir,NMDEP');

-- Sp_ReportBPPBKeluarRek
CREATE PROCEDURE IF NOT EXISTS Sp_ReportBPPBKeluarRek AS ---- DECLARE REMOVED,@Tgl1 DateTime,@Tgl2 Datetime

--Select @Choice='B',@Tgl1='01/01/2011',@Tgl2='01/01/2013'



If @Choice='N'

Select 	A.NoBukti, A.Tanggal,Sum(COALESCE(Qnt,0)) QMinta,Sum(COALESCE(Qnt2,0)) QKirim

	From dbBPPB A

	Left Outer Join dbBPPBdet B On A.NoBukti=B.NoBukti

	Left Outer Join dbBarang D On B.Kodebrg=D.Kodebrg

	Left Outer Join dbDEPART C on c.KdDEP=a.KdDEP

	where A.TANGGAL between @Tgl1 and @Tgl2

	Group By A.NoBukti, A.Tanggal

	Order by A.NoBukti, A.Tanggal



else if @Choice='B'

Select B.KodeBrg,D.NamaBrg, A.Tanggal,Sum(COALESCE(Qnt,0)) QMinta,Sum(COALESCE(Qnt2,0)) QKirim

	From dbBPPB A

	Left Outer Join dbBPPBdet B On A.NoBukti=B.NoBukti

	Left Outer Join dbBarang D On B.Kodebrg=D.Kodebrg

	Left Outer Join dbDEPART C on c.KdDEP=a.KdDEP

	where A.TANGGAL between @Tgl1 and @Tgl2

	Group By B.KodeBrg,D.NamaBrg,A.TANGGAL

	Order by B.KodeBrg,D.NamaBrg,A.TANGGAL;

-- Sp_reportBPrek
CREATE PROCEDURE IF NOT EXISTS Sp_reportBPrek AS ---- DECLARE REMOVED,@Bulan Int,@Tahun Int

--Select @Choice='B',@Bulan=1,@Tahun=2012

if @Id=''

If @Choice='N'

If @NeedOto=0 or @NeedOto=1

	Select 	'Gabungan' Perusahaan,A.NoBukti,B.Sat,B.kodebrg,H.NAMABRG,B1.Hrg,B1.Hrg*Sum(COALESCE(B.Qnt,0)) NilaiBeli,

	Sum(COALESCE(B.Qnt,0)) Qnt,B2.NMDEP,B1.Hrg*Sum(COALESCE(B.Qnt2,0)) NilaiBeli2,A.NoPOL,A.Supir

	From dbPenyerahanBhn A

	Left Outer join  dbPenyerahanBhnDet B on B.NoBukti=a.NoBukti

	Left Outer Join DBDEPART B2 On B2.KDDEP=A.KdDep

	Left Outer Join(Select Kodebrg,AVG(Hrg)Hrg From (

	                Select Kodebrg,AVG(Harga)Hrg from DBBELIDET Group by KODEBRG

	                Union All 

	                Select Kodebrg,AVG(Harga)Hrg from DBKOREKSIDET Group by KODEBRG)a Group by KODEBRG) B1 On B1.KODEBRG=B.kodebrg

	Left Outer join dbBarang H on H.KodeBrg=b.KodeBrg

	Where A.tanggal Between @Tgl1 And @Tgl2

	/*And Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                      Case when A.IsOtorisasi2=1 then 1 else 0 +

                      Case when A.IsOtorisasi3=1 then 1 else 0 +

                      Case when A.IsOtorisasi4=1 then 1 else 0 +

                      Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                 else 1

             As INTEGER)=@Needoto*/

	Group By A.Nobukti,B.Sat,B.kodebrg,H.NAMABRG,b1.Hrg,b2.NMDEP,A.NoPOL,A.Supir

	Order BY A.nobukti,B.Sat,B.kodebrg,H.NAMABRG

else If @NeedOto=2

	Select 	'Gabungan' Perusahaan,A.NoBukti,B.Sat,B.kodebrg,H.NAMABRG,B1.Hrg,B1.Hrg*Sum(COALESCE(B.Qnt,0)) NilaiBeli,

	Sum(COALESCE(B.Qnt,0)) Qnt,B2.NMDEP,B1.Hrg*Sum(COALESCE(B.Qnt2,0)) NilaiBeli2,A.NoPOL,A.Supir

	From dbPenyerahanBhn A

	Left Outer join  dbPenyerahanBhnDet B on B.NoBukti=a.NoBukti

	Left Outer Join DBDEPART B2 On B2.KDDEP=A.KdDep

	Left Outer Join(Select Kodebrg,AVG(Hrg)Hrg From (

	                Select Kodebrg,AVG(Harga)Hrg from DBBELIDET Group by KODEBRG

	                Union All 

	                Select Kodebrg,AVG(Harga)Hrg from DBKOREKSIDET Group by KODEBRG)a Group by KODEBRG) B1 On B1.KODEBRG=B.kodebrg

	Left Outer join dbBarang H on H.KodeBrg=b.KodeBrg

	Where A.tanggal Between @Tgl1 And @Tgl2

	Group By A.Nobukti,B.Sat,B.kodebrg,H.NAMABRG,B1.Hrg,B2.NMDEP,A.NoPOL,A.Supir

	Order BY A.nobukti,B.Sat,B.kodebrg,H.NAMABRG


If @Choice='B'

If @NeedOto=0 or @NeedOto=1

	Select 	'Gabungan' Perusahaan,B.KOdebrg,H.namaBrg,B.Sat,B1.Hrg,B1.Hrg*Sum(COALESCE(B.Qnt,0)) NilaiBeli, 

	Sum(COALESCE(B.Qnt,0)) Qnt,B2.NMDEP,B1.Hrg*Sum(COALESCE(B.Qnt2,0)) NilaiBeli2,A.NoPOL,A.Supir

	From dbPenyerahanBhn A

	Left Outer join  dbPenyerahanBhnDet B on B.NoBukti=a.NoBukti

	Left Outer Join DBDEPART B2 On B2.KDDEP=A.KdDep

	Left Outer Join(Select Kodebrg,AVG(Hrg)Hrg From (

	                Select Kodebrg,AVG(Harga)Hrg from DBBELIDET Group by KODEBRG

	                Union All 

	                Select Kodebrg,AVG(Harga)Hrg from DBKOREKSIDET Group by KODEBRG)a Group by KODEBRG) B1 On B1.KODEBRG=B.kodebrg

	Left Outer join dbBarang H on H.KodeBrg=b.KodeBrg

	Where A.tanggal Between @Tgl1 And @Tgl2

	And A.IsOtorisasi1 = @Needoto

	Group By B.kodebrg,H.namaBrg,B.Sat,B1.Hrg,b2.NmDEP,A.NoPOL,A.Supir

	Order BY B.kodebrg,B2.NMDEP,H.namaBrg,B.Sat

If @NeedOto=2

	Select 	'Gabungan' Perusahaan,B.KOdebrg,H.namaBrg,B.Sat,B1.Hrg,B1.Hrg*Sum(COALESCE(B.Qnt,0)) NilaiBeli,  

	Sum(COALESCE(B.Qnt,0)) Qnt,B2.NMDEP,B1.Hrg*Sum(COALESCE(B.Qnt2,0)) NilaiBeli2,A.NoPOL,A.Supir

	From dbPenyerahanBhn A

	Left Outer join  dbPenyerahanBhnDet B on B.NoBukti=a.NoBukti

	Left Outer Join DBDEPART B2 On B2.KDDEP=A.KdDep

	Left Outer Join(Select Kodebrg,AVG(Hrg)Hrg From (

	                Select Kodebrg,AVG(Harga)Hrg from DBBELIDET Group by KODEBRG

	                Union All 

	                Select Kodebrg,AVG(Harga)Hrg from DBKOREKSIDET Group by KODEBRG)a Group by KODEBRG) B1 On B1.KODEBRG=B.kodebrg

	Left Outer join dbBarang H on H.KodeBrg=b.KodeBrg

	Where A.tanggal Between @Tgl1 And @Tgl2

	Group By B.kodebrg,H.namaBrg,B.Sat,B1.Hrg,B2.NMDEP,A.NoPOL,A.Supir

	Order BY B.kodebrg,B2.NMDEP,H.namaBrg,B.Sat


else If @Choice='D'

If @NeedOto=0 or @NeedOto=1

	Select 	'Gabungan' Perusahaan,B.KOdebrg,H.namaBrg,B.Sat,B1.Hrg,B1.Hrg*Sum(COALESCE(B.Qnt,0)) NilaiBeli, 

	Sum(COALESCE(B.Qnt,0)) Qnt,B2.NMDEP,B1.Hrg*Sum(COALESCE(B.Qnt2,0)) NilaiBeli2,A.NoPOL,A.Supir

	From dbPenyerahanBhn A

	Left Outer join  dbPenyerahanBhnDet B on B.NoBukti=a.NoBukti

	Left Outer Join DBDEPART B2 On B2.KDDEP=A.KdDep

	Left Outer Join(Select Kodebrg,AVG(Hrg)Hrg From (

	                Select Kodebrg,AVG(Harga)Hrg from DBBELIDET Group by KODEBRG

	                Union All 

	                Select Kodebrg,AVG(Harga)Hrg from DBKOREKSIDET Group by KODEBRG)a Group by KODEBRG) B1 On B1.KODEBRG=B.kodebrg

	Left Outer join dbBarang H on H.KodeBrg=b.KodeBrg

	Where A.tanggal Between @Tgl1 And @Tgl2

	And A.IsOtorisasi1 = @Needoto

	Group By B.kodebrg,H.namaBrg,B.Sat,B1.Hrg,b2.NmDEP,A.NoPOL,A.Supir

	Order BY B2.NMDEP,H.namaBrg,B.Sat

If @NeedOto=2

	Select 	'Gabungan' Perusahaan,B.KOdebrg,H.namaBrg,B.Sat,B1.Hrg,B1.Hrg*Sum(COALESCE(B.Qnt,0)) NilaiBeli,  

	Sum(COALESCE(B.Qnt,0)) Qnt,B2.NMDEP,B1.Hrg*Sum(COALESCE(B.Qnt2,0)) NilaiBeli2,A.NoPOL,A.Supir

	From dbPenyerahanBhn A

	Left Outer join  dbPenyerahanBhnDet B on B.NoBukti=a.NoBukti

	Left Outer Join DBDEPART B2 On B2.KDDEP=A.KdDep

	Left Outer Join(Select Kodebrg,AVG(Hrg)Hrg From (

	                Select Kodebrg,AVG(Harga)Hrg from DBBELIDET Group by KODEBRG

	                Union All 

	                Select Kodebrg,AVG(Harga)Hrg from DBKOREKSIDET Group by KODEBRG)a Group by KODEBRG) B1 On B1.KODEBRG=B.kodebrg

	Left Outer join dbBarang H on H.KodeBrg=b.KodeBrg

	Where A.tanggal Between @Tgl1 And @Tgl2

	Group By B.kodebrg,H.namaBrg,B.Sat,B1.Hrg,B2.NMDEP,A.NoPOL,A.Supir

	Order BY B2.NMDEP,H.namaBrg,B.Sat


else If @Choice='P'

If @NeedOto=0 or @NeedOto=1

	Select 	'Gabungan' Perusahaan,B.KOdebrg,H.namaBrg,B.Sat,B1.Hrg,B1.Hrg*Sum(COALESCE(B.Qnt,0)) NilaiBeli, 

	Sum(COALESCE(B.Qnt,0)) Qnt,B2.NMDEP,B1.Hrg*Sum(COALESCE(B.Qnt2,0)) NilaiBeli2,A.NoPOL,A.Supir

	From dbPenyerahanBhn A

	Left Outer join  dbPenyerahanBhnDet B on B.NoBukti=a.NoBukti

	Left Outer Join DBDEPART B2 On B2.KDDEP=A.KdDep

	Left Outer Join(Select Kodebrg,AVG(Hrg)Hrg From (

	                Select Kodebrg,AVG(Harga)Hrg from DBBELIDET Group by KODEBRG

	                Union All 

	                Select Kodebrg,AVG(Harga)Hrg from DBKOREKSIDET Group by KODEBRG)a Group by KODEBRG) B1 On B1.KODEBRG=B.kodebrg

	Left Outer join dbBarang H on H.KodeBrg=b.KodeBrg

	Where A.tanggal Between @Tgl1 And @Tgl2 and COALESCE(A.NoPOL,'')<>''

	And A.IsOtorisasi1 = @Needoto

	Group By B.kodebrg,H.namaBrg,B.Sat,B1.Hrg,b2.NmDEP,A.NoPOL,A.Supir

	Order BY A.NoPOL,H.namaBrg,B.Sat

If @NeedOto=2

	Select 'Gabungan' Perusahaan,	B.KOdebrg,H.namaBrg,B.Sat,B1.Hrg,B1.Hrg*Sum(COALESCE(B.Qnt,0)) NilaiBeli,  

	Sum(COALESCE(B.Qnt,0)) Qnt,B2.NMDEP,B1.Hrg*Sum(COALESCE(B.Qnt2,0)) NilaiBeli2,A.NoPOL,A.Supir

	From dbPenyerahanBhn A

	Left Outer join  dbPenyerahanBhnDet B on B.NoBukti=a.NoBukti

	Left Outer Join DBDEPART B2 On B2.KDDEP=A.KdDep

	Left Outer Join(Select Kodebrg,AVG(Hrg)Hrg From (

	                Select Kodebrg,AVG(Harga)Hrg from DBBELIDET Group by KODEBRG

	                Union All 

	                Select Kodebrg,AVG(Harga)Hrg from DBKOREKSIDET Group by KODEBRG)a Group by KODEBRG) B1 On B1.KODEBRG=B.kodebrg

	Left Outer join dbBarang H on H.KodeBrg=b.KodeBrg

	Where A.tanggal Between @Tgl1 And @Tgl2 and COALESCE(A.NoPOL,'')<>''

	Group By B.kodebrg,H.namaBrg,B.Sat,B1.Hrg,B2.NMDEP,A.NoPOL,A.Supir

	Order BY A.NoPOL,H.namaBrg,B.Sat


else If @Choice='S'

If @NeedOto=0 or @NeedOto=1

	Select 'Gabungan' Perusahaan,	B.KOdebrg,H.namaBrg,B.Sat,B1.Hrg,B1.Hrg*Sum(COALESCE(B.Qnt,0)) NilaiBeli, 

	Sum(COALESCE(B.Qnt,0)) Qnt,B2.NMDEP,B1.Hrg*Sum(COALESCE(B.Qnt2,0)) NilaiBeli2,A.NoPOL,A.Supir

	From dbPenyerahanBhn A

	Left Outer join  dbPenyerahanBhnDet B on B.NoBukti=a.NoBukti

	Left Outer Join DBDEPART B2 On B2.KDDEP=A.KdDep

	Left Outer Join(Select Kodebrg,AVG(Hrg)Hrg From (

	                Select Kodebrg,AVG(Harga)Hrg from DBBELIDET Group by KODEBRG

	                Union All 

	                Select Kodebrg,AVG(Harga)Hrg from DBKOREKSIDET Group by KODEBRG)a Group by KODEBRG) B1 On B1.KODEBRG=B.kodebrg

	Left Outer join dbBarang H on H.KodeBrg=b.KodeBrg

	Where A.tanggal Between @Tgl1 And @Tgl2 and COALESCE(A.Supir,'')<>''

	And A.IsOtorisasi1 = @Needoto

	Group By B.kodebrg,H.namaBrg,B.Sat,B1.Hrg,b2.NmDEP,A.NoPOL,A.Supir

	Order BY A.Supir,H.namaBrg,B.Sat

If @NeedOto=2

	Select 'Gabungan' Perusahaan,	B.KOdebrg,H.namaBrg,B.Sat,B1.Hrg,B1.Hrg*Sum(COALESCE(B.Qnt,0)) NilaiBeli,  

	Sum(COALESCE(B.Qnt,0)) Qnt,B2.NMDEP,B1.Hrg*Sum(COALESCE(B.Qnt2,0)) NilaiBeli2,A.NoPOL,A.Supir

	From dbPenyerahanBhn A

	Left Outer join  dbPenyerahanBhnDet B on B.NoBukti=a.NoBukti

	Left Outer Join DBDEPART B2 On B2.KDDEP=A.KdDep

	Left Outer Join(Select Kodebrg,AVG(Hrg)Hrg From (

	                Select Kodebrg,AVG(Harga)Hrg from DBBELIDET Group by KODEBRG

	                Union All 

	                Select Kodebrg,AVG(Harga)Hrg from DBKOREKSIDET Group by KODEBRG)a Group by KODEBRG) B1 On B1.KODEBRG=B.kodebrg

	Left Outer join dbBarang H on H.KodeBrg=b.KodeBrg

	Where A.tanggal Between @Tgl1 And @Tgl2 and COALESCE(A.Supir,'')<>''

	Group By B.kodebrg,H.namaBrg,B.Sat,B1.Hrg,B2.NMDEP,A.NoPOL,A.Supir

	Order BY A.Supir,H.namaBrg,B.Sat


else--------

If @Choice='N'

If @NeedOto=0 or @NeedOto=1

	Select Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,	A.NoBukti,B.Sat,B.kodebrg,H.NAMABRG,B1.Hrg,B1.Hrg*Sum(COALESCE(B.Qnt,0)) NilaiBeli,

	Sum(COALESCE(B.Qnt,0)) Qnt,B2.NMDEP,B1.Hrg*Sum(COALESCE(B.Qnt2,0)) NilaiBeli2,A.NoPOL,A.Supir

	From dbPenyerahanBhn A

	Left Outer join  dbPenyerahanBhnDet B on B.NoBukti=a.NoBukti

	Left Outer Join DBDEPART B2 On B2.KDDEP=A.KdDep

	Left Outer Join(Select Kodebrg,AVG(Hrg)Hrg From (

	                Select Kodebrg,AVG(Harga)Hrg from DBBELIDET Group by KODEBRG

	                Union All 

	                Select Kodebrg,AVG(Harga)Hrg from DBKOREKSIDET Group by KODEBRG)a Group by KODEBRG) B1 On B1.KODEBRG=B.kodebrg

	Left Outer join dbBarang H on H.KodeBrg=b.KodeBrg

	Where A.tanggal Between @Tgl1 And @Tgl2

	/*And Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

                      Case when A.IsOtorisasi2=1 then 1 else 0 +

                      Case when A.IsOtorisasi3=1 then 1 else 0 +

                      Case when A.IsOtorisasi4=1 then 1 else 0 +

                      Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

                 else 1

             As INTEGER)=@Needoto*/

            and @Id=Case When Len(@ID)=3 Then Left(b.NoBukti,3) else Left(b.NoBukti,2)

	Group By A.Nobukti,B.Sat,B.kodebrg,H.NAMABRG,b1.Hrg,b2.NMDEP,A.NoPOL,A.Supir

	Order BY A.nobukti,B.Sat,B.kodebrg,H.NAMABRG

else If @NeedOto=2

	Select Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,	A.NoBukti,B.Sat,B.kodebrg,H.NAMABRG,B1.Hrg,B1.Hrg*Sum(COALESCE(B.Qnt,0)) NilaiBeli,

	Sum(COALESCE(B.Qnt,0)) Qnt,B2.NMDEP,B1.Hrg*Sum(COALESCE(B.Qnt2,0)) NilaiBeli2,A.NoPOL,A.Supir

	From dbPenyerahanBhn A

	Left Outer join  dbPenyerahanBhnDet B on B.NoBukti=a.NoBukti

	Left Outer Join DBDEPART B2 On B2.KDDEP=A.KdDep

	Left Outer Join(Select Kodebrg,AVG(Hrg)Hrg From (

	                Select Kodebrg,AVG(Harga)Hrg from DBBELIDET Group by KODEBRG

	                Union All 

	                Select Kodebrg,AVG(Harga)Hrg from DBKOREKSIDET Group by KODEBRG)a Group by KODEBRG) B1 On B1.KODEBRG=B.kodebrg

	Left Outer join dbBarang H on H.KodeBrg=b.KodeBrg

	Where A.tanggal Between @Tgl1 And @Tgl2

	and @Id=Case When Len(@ID)=3 Then Left(b.NoBukti,3) else Left(b.NoBukti,2)

	Group By A.Nobukti,B.Sat,B.kodebrg,H.NAMABRG,B1.Hrg,B2.NMDEP,A.NoPOL,A.Supir

	Order BY A.nobukti,B.Sat,B.kodebrg,H.NAMABRG


If @Choice='B'

If @NeedOto=0 or @NeedOto=1

	Select Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,	B.KOdebrg,H.namaBrg,B.Sat,B1.Hrg,B1.Hrg*Sum(COALESCE(B.Qnt,0)) NilaiBeli, 

	Sum(COALESCE(B.Qnt,0)) Qnt,B2.NMDEP,B1.Hrg*Sum(COALESCE(B.Qnt2,0)) NilaiBeli2,A.NoPOL,A.Supir

	From dbPenyerahanBhn A

	Left Outer join  dbPenyerahanBhnDet B on B.NoBukti=a.NoBukti

	Left Outer Join DBDEPART B2 On B2.KDDEP=A.KdDep

	Left Outer Join(Select Kodebrg,AVG(Hrg)Hrg From (

	                Select Kodebrg,AVG(Harga)Hrg from DBBELIDET Group by KODEBRG

	                Union All 

	                Select Kodebrg,AVG(Harga)Hrg from DBKOREKSIDET Group by KODEBRG)a Group by KODEBRG) B1 On B1.KODEBRG=B.kodebrg

	Left Outer join dbBarang H on H.KodeBrg=b.KodeBrg

	Where A.tanggal Between @Tgl1 And @Tgl2

	And A.IsOtorisasi1 = @Needoto

	and @Id=Case When Len(@ID)=3 Then Left(b.NoBukti,3) else Left(b.NoBukti,2)

	Group By B.kodebrg,H.namaBrg,B.Sat,B1.Hrg,b2.NmDEP,A.NoPOL,A.Supir

	Order BY B.kodebrg,B2.NMDEP,H.namaBrg,B.Sat

If @NeedOto=2

	Select Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,	B.KOdebrg,H.namaBrg,B.Sat,B1.Hrg,B1.Hrg*Sum(COALESCE(B.Qnt,0)) NilaiBeli,  

	Sum(COALESCE(B.Qnt,0)) Qnt,B2.NMDEP,B1.Hrg*Sum(COALESCE(B.Qnt2,0)) NilaiBeli2,A.NoPOL,A.Supir

	From dbPenyerahanBhn A

	Left Outer join  dbPenyerahanBhnDet B on B.NoBukti=a.NoBukti

	Left Outer Join DBDEPART B2 On B2.KDDEP=A.KdDep

	Left Outer Join(Select Kodebrg,AVG(Hrg)Hrg From (

	                Select Kodebrg,AVG(Harga)Hrg from DBBELIDET Group by KODEBRG

	                Union All 

	                Select Kodebrg,AVG(Harga)Hrg from DBKOREKSIDET Group by KODEBRG)a Group by KODEBRG) B1 On B1.KODEBRG=B.kodebrg

	Left Outer join dbBarang H on H.KodeBrg=b.KodeBrg

	Where A.tanggal Between @Tgl1 And @Tgl2

	and @Id=Case When Len(@ID)=3 Then Left(b.NoBukti,3) else Left(b.NoBukti,2)

	Group By B.kodebrg,H.namaBrg,B.Sat,B1.Hrg,B2.NMDEP,A.NoPOL,A.Supir

	Order BY B.kodebrg,B2.NMDEP,H.namaBrg,B.Sat


else If @Choice='D'

If @NeedOto=0 or @NeedOto=1

	Select Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,	B.KOdebrg,H.namaBrg,B.Sat,B1.Hrg,B1.Hrg*Sum(COALESCE(B.Qnt,0)) NilaiBeli, 

	Sum(COALESCE(B.Qnt,0)) Qnt,B2.NMDEP,B1.Hrg*Sum(COALESCE(B.Qnt2,0)) NilaiBeli2,A.NoPOL,A.Supir

	From dbPenyerahanBhn A

	Left Outer join  dbPenyerahanBhnDet B on B.NoBukti=a.NoBukti

	Left Outer Join DBDEPART B2 On B2.KDDEP=A.KdDep

	Left Outer Join(Select Kodebrg,AVG(Hrg)Hrg From (

	                Select Kodebrg,AVG(Harga)Hrg from DBBELIDET Group by KODEBRG

	                Union All 

	                Select Kodebrg,AVG(Harga)Hrg from DBKOREKSIDET Group by KODEBRG)a Group by KODEBRG) B1 On B1.KODEBRG=B.kodebrg

	Left Outer join dbBarang H on H.KodeBrg=b.KodeBrg

	Where A.tanggal Between @Tgl1 And @Tgl2

	And A.IsOtorisasi1 = @Needoto

	and @Id=Case When Len(@ID)=3 Then Left(b.NoBukti,3) else Left(b.NoBukti,2)

	Group By B.kodebrg,H.namaBrg,B.Sat,B1.Hrg,b2.NmDEP,A.NoPOL,A.Supir

	Order BY B2.NMDEP,H.namaBrg,B.Sat

If @NeedOto=2

	Select Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,	B.KOdebrg,H.namaBrg,B.Sat,B1.Hrg,B1.Hrg*Sum(COALESCE(B.Qnt,0)) NilaiBeli,  

	Sum(COALESCE(B.Qnt,0)) Qnt,B2.NMDEP,B1.Hrg*Sum(COALESCE(B.Qnt2,0)) NilaiBeli2,A.NoPOL,A.Supir

	From dbPenyerahanBhn A

	Left Outer join  dbPenyerahanBhnDet B on B.NoBukti=a.NoBukti

	Left Outer Join DBDEPART B2 On B2.KDDEP=A.KdDep

	Left Outer Join(Select Kodebrg,AVG(Hrg)Hrg From (

	                Select Kodebrg,AVG(Harga)Hrg from DBBELIDET Group by KODEBRG

	                Union All 

	                Select Kodebrg,AVG(Harga)Hrg from DBKOREKSIDET Group by KODEBRG)a Group by KODEBRG) B1 On B1.KODEBRG=B.kodebrg

	Left Outer join dbBarang H on H.KodeBrg=b.KodeBrg

	Where A.tanggal Between @Tgl1 And @Tgl2

	and @Id=Case When Len(@ID)=3 Then Left(b.NoBukti,3) else Left(b.NoBukti,2)

	Group By B.kodebrg,H.namaBrg,B.Sat,B1.Hrg,B2.NMDEP,A.NoPOL,A.Supir

	Order BY B2.NMDEP,H.namaBrg,B.Sat


else If @Choice='P'

If @NeedOto=0 or @NeedOto=1

	Select Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,	B.KOdebrg,H.namaBrg,B.Sat,B1.Hrg,B1.Hrg*Sum(COALESCE(B.Qnt,0)) NilaiBeli, 

	Sum(COALESCE(B.Qnt,0)) Qnt,B2.NMDEP,B1.Hrg*Sum(COALESCE(B.Qnt2,0)) NilaiBeli2,A.NoPOL,A.Supir

	From dbPenyerahanBhn A

	Left Outer join  dbPenyerahanBhnDet B on B.NoBukti=a.NoBukti

	Left Outer Join DBDEPART B2 On B2.KDDEP=A.KdDep

	Left Outer Join(Select Kodebrg,AVG(Hrg)Hrg From (

	                Select Kodebrg,AVG(Harga)Hrg from DBBELIDET Group by KODEBRG

	                Union All 

	                Select Kodebrg,AVG(Harga)Hrg from DBKOREKSIDET Group by KODEBRG)a Group by KODEBRG) B1 On B1.KODEBRG=B.kodebrg

	Left Outer join dbBarang H on H.KodeBrg=b.KodeBrg

	Where A.tanggal Between @Tgl1 And @Tgl2 and COALESCE(A.NoPOL,'')<>''

	And A.IsOtorisasi1 = @Needoto

	and @Id=Case When Len(@ID)=3 Then Left(b.NoBukti,3) else Left(b.NoBukti,2)

	Group By B.kodebrg,H.namaBrg,B.Sat,B1.Hrg,b2.NmDEP,A.NoPOL,A.Supir

	Order BY A.NoPOL,H.namaBrg,B.Sat

If @NeedOto=2

	Select Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,	B.KOdebrg,H.namaBrg,B.Sat,B1.Hrg,B1.Hrg*Sum(COALESCE(B.Qnt,0)) NilaiBeli,  

	Sum(COALESCE(B.Qnt,0)) Qnt,B2.NMDEP,B1.Hrg*Sum(COALESCE(B.Qnt2,0)) NilaiBeli2,A.NoPOL,A.Supir

	From dbPenyerahanBhn A

	Left Outer join  dbPenyerahanBhnDet B on B.NoBukti=a.NoBukti

	Left Outer Join DBDEPART B2 On B2.KDDEP=A.KdDep

	Left Outer Join(Select Kodebrg,AVG(Hrg)Hrg From (

	                Select Kodebrg,AVG(Harga)Hrg from DBBELIDET Group by KODEBRG

	                Union All 

	                Select Kodebrg,AVG(Harga)Hrg from DBKOREKSIDET Group by KODEBRG)a Group by KODEBRG) B1 On B1.KODEBRG=B.kodebrg

	Left Outer join dbBarang H on H.KodeBrg=b.KodeBrg

	Where A.tanggal Between @Tgl1 And @Tgl2 and COALESCE(A.NoPOL,'')<>''

	and @Id=Case When Len(@ID)=3 Then Left(b.NoBukti,3) else Left(b.NoBukti,2)

	Group By B.kodebrg,H.namaBrg,B.Sat,B1.Hrg,B2.NMDEP,A.NoPOL,A.Supir

	Order BY A.NoPOL,H.namaBrg,B.Sat


else If @Choice='S'

If @NeedOto=0 or @NeedOto=1

	Select Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,	B.KOdebrg,H.namaBrg,B.Sat,B1.Hrg,B1.Hrg*Sum(COALESCE(B.Qnt,0)) NilaiBeli, 

	Sum(COALESCE(B.Qnt,0)) Qnt,B2.NMDEP,B1.Hrg*Sum(COALESCE(B.Qnt2,0)) NilaiBeli2,A.NoPOL,A.Supir

	From dbPenyerahanBhn A

	Left Outer join  dbPenyerahanBhnDet B on B.NoBukti=a.NoBukti

	Left Outer Join DBDEPART B2 On B2.KDDEP=A.KdDep

	Left Outer Join(Select Kodebrg,AVG(Hrg)Hrg From (

	                Select Kodebrg,AVG(Harga)Hrg from DBBELIDET Group by KODEBRG

	                Union All 

	                Select Kodebrg,AVG(Harga)Hrg from DBKOREKSIDET Group by KODEBRG)a Group by KODEBRG) B1 On B1.KODEBRG=B.kodebrg

	Left Outer join dbBarang H on H.KodeBrg=b.KodeBrg

	Where A.tanggal Between @Tgl1 And @Tgl2 and COALESCE(A.Supir,'')<>''

	And A.IsOtorisasi1 = @Needoto

	and @Id=Case When Len(@ID)=3 Then Left(b.NoBukti,3) else Left(b.NoBukti,2)

	Group By B.kodebrg,H.namaBrg,B.Sat,B1.Hrg,b2.NmDEP,A.NoPOL,A.Supir

	Order BY A.Supir,H.namaBrg,B.Sat

If @NeedOto=2

	Select 	Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,B.KOdebrg,H.namaBrg,B.Sat,B1.Hrg,B1.Hrg*Sum(COALESCE(B.Qnt,0)) NilaiBeli,  

	Sum(COALESCE(B.Qnt,0)) Qnt,B2.NMDEP,B1.Hrg*Sum(COALESCE(B.Qnt2,0)) NilaiBeli2,A.NoPOL,A.Supir

	From dbPenyerahanBhn A

	Left Outer join  dbPenyerahanBhnDet B on B.NoBukti=a.NoBukti

	Left Outer Join DBDEPART B2 On B2.KDDEP=A.KdDep

	Left Outer Join(Select Kodebrg,AVG(Hrg)Hrg From (

	                Select Kodebrg,AVG(Harga)Hrg from DBBELIDET Group by KODEBRG

	                Union All 

	                Select Kodebrg,AVG(Harga)Hrg from DBKOREKSIDET Group by KODEBRG)a Group by KODEBRG) B1 On B1.KODEBRG=B.kodebrg

	Left Outer join dbBarang H on H.KodeBrg=b.KodeBrg

	Where A.tanggal Between @Tgl1 And @Tgl2 and COALESCE(A.Supir,'')<>''

	and @Id=Case When Len(@ID)=3 Then Left(b.NoBukti,3) else Left(b.NoBukti,2)

	Group By B.kodebrg,H.namaBrg,B.Sat,B1.Hrg,B2.NMDEP,A.NoPOL,A.Supir

	Order BY A.Supir,H.namaBrg,B.Sat;

-- Sp_ReportBukuTambahan
CREATE PROCEDURE IF NOT EXISTS Sp_ReportBukuTambahan AS -- SET REMOVEDCase when @devisi in ('-','') then '%' else @devisi 

-- DECLARE REMOVED

--Select @awal='111110001',@akhir='111120003',@tglawal='07-01-2011',@tglakhir='07-31-2011',@devisi='01',@IdUser='SA'

Select @Mulai=DATEADD(dd,-(DAY(@tglawal)-1),@tglawal);

With Transaksi (Nobukti,Tanggal, Note, Keterangan, Perkiraan, Lawan, DK, Debet, DebetRp, Valas, Kurs, Kredit, KreditRp, SaldoAkhir, SaldoAkhirD,

      Devisi, Nourut, NoACC, Nama, Urut) AS

(

Select 'SALDO AWAL' Nobukti,DATEADD(DD,-1,@tglawal) Tanggal,''Note, '' Keterangan, ''Perkiraan, '' Lawan, 

       A.DK, 0.00 Debet, 0.00 DebetRp, '', 1.00 Kurs, 0.00 Kredit, 0.00 KreditD,

       Case when B.DK=0 then A.AwalDRp 

            when B.DK=1 then A.AwalKRp

            else 0

        SaldoAkhir,

       Case when B.DK=0 then A.AwalD

            when B.DK=1 then A.AwalK

            else 0

        SaldoAkhirD, A.Devisi, '' NoUrut, B.Perkiraan NoACC, B.Keterangan Nama, 0 Urut

From DBNERACA A

     Left Outer Join DBPERKIRAAN B on B.Perkiraan=A.Perkiraan

where (A.Perkiraan between @awal and @akhir) and A.Devisi like @devisi and A.Bulan=MONTH(@tglawal) and A.Tahun=YEAR(@tglawal)

union All

Select 'SALDO AWAL' Nobukti, DATEADD(DD,-1,@tglawal) Tanggal,''Note, '' Keterangan,

       /*Case when B.PERKIRAAN=A.Perkiraan then B.PERKIRAAN

            when B.LAWAN=A.Perkiraan then B.LAWAN

            else ''

        */''Perkiraan,  '' Lawan,

       A.DK, 0.00 Debet, 0.00 DebetRp, '', 1.00 Kurs, 0.00 Kredit, 0.00 KreditD,

       SUM(Case when Datepart(DD,@tglawal)=1 then 0

                else

       Case when A.DK=0 and B.PERKIRAAN=A.Perkiraan then B.DEBETRP

            when A.DK=1 and B.PERKIRAAN=A.Perkiraan then -B.DEBETRP

            when A.DK=0 and B.LAWAN=A.Perkiraan then -B.DEBETRP

            when A.DK=1 and B.LAWAN=A.Perkiraan then B.DEBETRP

            else 0

        ) SaldoAkhir,

       SUM(Case when Datepart(DD,@tglawal)=1 then 0

                else

       /*Case when A.DK=0 and B.PERKIRAAN=A.Perkiraan then B.DEBET 

            when A.DK=1 and B.PERKIRAAN=A.Perkiraan then -B.DEBET 

            when A.DK=0 and B.LAWAN=A.Perkiraan then -B.DEBET 

            when A.DK=1 and B.LAWAN=A.Perkiraan then B.DEBET 

            else 0*/

        Case when A.DK=0 and B.PERKIRAAN=A.Perkiraan and b.VALAS<>'IDR' then B.DEBET 

            when A.DK=1 and B.PERKIRAAN=A.Perkiraan and b.VALAS<>'IDR' then -B.DEBET 

            when A.DK=0 and B.LAWAN=A.Perkiraan and b.VALAS<>'IDR' then -B.DEBET 

            when A.DK=1 and B.LAWAN=A.Perkiraan and b.VALAS<>'IDR' then B.DEBET 

            else 0     

        ) SaldoAkhirD, B.Devisi, '' NoUrut, A.Perkiraan NoACC, A.Keterangan Nama, 0 Urut

From DBPERKIRAAN A

     left Outer join VWTransaksiBB B on B.PERKIRAAN=A.Perkiraan or B.LAWAN=A.Perkiraan

where (B.Tanggal >=@Mulai and B.Tanggal<@tglawal) and B.Devisi like @devisi and (A.Perkiraan between @awal and @akhir) 

Group by A.Perkiraan, A.DK, B.DEVISI, A.Keterangan

union all

Select B.Nobukti, B.TANGGAL,B.NOTE, B.KETERANGAN,

       B.PERKIRAAN,  

       Case when B.PERKIRAAN=A.Perkiraan then B.LAWAN 

            when B.LAWAN=A.Perkiraan then B.PERKIRAAN

            else ''

        LAWAN,

       A.DK, 

       case when B.LAWAN='131' and (c.FlagSimbol='LB' or c.FlagSimbol='TG') then 

          Case when B.PERKIRAAN=A.Perkiraan then 0 

       else

          Case when B.PERKIRAAN=A.Perkiraan then B.DEBET else 0   Debet, 

       case when B.LAWAN='131' and (c.FlagSimbol='LB' or c.FlagSimbol='TG') then 

          Case when B.PERKIRAAN=A.Perkiraan then 0 

       else

          Case when B.PERKIRAAN=A.Perkiraan then B.DEBETRP else 0   DebetRp,

        

       B.VALAS, B.KURS, 

       Case when B.LAWAN=A.Perkiraan then B.DEBET when (B.PERKIRAAN=A.Perkiraan and B.LAWAN='131' and (c.FlagSimbol='LB' or c.FlagSimbol='TG')) then B.DEBET*-1 else 0  Kredit, 

       Case when B.LAWAN=A.Perkiraan then B.DEBETRP when (B.PERKIRAAN=A.Perkiraan and B.LAWAN='131' and (c.FlagSimbol='LB' or c.FlagSimbol='TG')) then B.DEBETRP*-1 else 0  KreditRp,

       

       (

       Case when A.DK=0 and B.PERKIRAAN=A.Perkiraan then B.DEBETRP

            when A.DK=1 and B.PERKIRAAN=A.Perkiraan then -B.DEBETRP

            when A.DK=0 and B.LAWAN=A.Perkiraan then -B.DEBETRP

            when A.DK=1 and B.LAWAN=A.Perkiraan then B.DEBETRP

            else 0

       ) SaldoAkhir,

       (

      /* Case when A.DK=0 and B.PERKIRAAN=A.Perkiraan then B.DEBET 

            when A.DK=1 and B.PERKIRAAN=A.Perkiraan then -B.DEBET 

            when A.DK=0 and B.LAWAN=A.Perkiraan then -B.DEBET 

            when A.DK=1 and B.LAWAN=A.Perkiraan then B.DEBET 

            else 0*/

       Case when A.DK=0 and B.PERKIRAAN=A.Perkiraan and b.VALAS<>'IDR' then B.DEBET 

            when A.DK=1 and B.PERKIRAAN=A.Perkiraan and b.VALAS<>'IDR'then -B.DEBET 

            when A.DK=0 and B.LAWAN=A.Perkiraan and b.VALAS<>'IDR' then -B.DEBET 

            when A.DK=1 and B.LAWAN=A.Perkiraan and b.VALAS<>'IDR' then B.DEBET 

            else 0     

       ) SaldoAkhirD, B.Devisi, B.NOURUT, A.Perkiraan NoACC, A.Keterangan Nama, B.Urut

From DBPERKIRAAN A

     left Outer join VWTransaksiBB B on B.PERKIRAAN=A.Perkiraan or B.LAWAN=A.Perkiraan

     left outer join dbtransaksi c on c.NoBukti=b.NOBUKTI and c.Urut=b.URUT

where (B.Tanggal between @tglawal and @tglakhir) and B.Devisi like @devisi and (A.Perkiraan between @awal and @akhir))



Select Nobukti,Tanggal, Note, Keterangan, Perkiraan, Lawan, DK, 

      Debet DebetD, DebetRp Debet, Valas, Kurs, Kredit KreditD, KreditRp Kredit, 

      Sum(SaldoAkhir) SaldoAkhir, Sum(SaldoAkhirD) SaldoAkhirD,

       Devisi, Nourut, NoACC, Nama, urut

From Transaksi A

where (A.NoACC between @awal and @akhir) and (A.Tanggal between DATEADD(DD,-1,@Mulai) and @tglakhir)

Group by Nobukti,Tanggal, Note, Keterangan, Perkiraan, Lawan, DK, Debet, DebetRp, Valas, Kurs, Kredit, KreditRp,

         Devisi, Nourut, NoACC, Nama, Urut 

Having Sum(SaldoAkhir)<>0 Or Sum(SaldoAkhirD) <>0

Order by NoACC, Tanggal,NoUrut,Nobukti, Urut;

-- Sp_ReportBukuTambahanold
CREATE PROCEDURE IF NOT EXISTS Sp_ReportBukuTambahanold AS -- DECLARE REMOVED

--Select @awal='111110001',@akhir='111120003',@tglawal='07-01-2011',@tglakhir='07-31-2011',@devisi='01',@IdUser='SA'

Select @Mulai=DATEADD(dd,-(DAY(@tglawal)-1),@tglawal);

With Transaksi (Nobukti,Tanggal, Note, Keterangan, Perkiraan, Lawan, DK, Debet, DebetRp, Valas, Kurs, Kredit, KreditRp, SaldoAkhir, SaldoAkhirD,

      Devisi, Nourut, NoACC, Nama, Urut) AS

(

Select 'SALDO AWAL' Nobukti,DATEADD(DD,-1,@tglawal) Tanggal,''Note, '' Keterangan, ''Perkiraan, '' Lawan, 

       A.DK, 0.00 Debet, 0.00 DebetRp, '', 1.00 Kurs, 0.00 Kredit, 0.00 KreditD,

       Case when B.DK=0 then A.AwalDRp 

            when B.DK=1 then A.AwalKRp

            else 0

        SaldoAkhir,

       Case when B.DK=0 then A.AwalD

            when B.DK=1 then A.AwalK

            else 0

        SaldoAkhirD, A.Devisi, '' NoUrut, B.Perkiraan NoACC, B.Keterangan Nama, 0 Urut

From DBNERACA A

     Left Outer Join DBPERKIRAAN B on B.Perkiraan=A.Perkiraan

where (A.Perkiraan between @awal and @akhir) and A.Devisi like @devisi and A.Bulan=MONTH(@tglawal) and A.Tahun=YEAR(@tglawal)

union All

Select 'SALDO AWAL' Nobukti, DATEADD(DD,-1,@tglawal) Tanggal,''Note, '' Keterangan,

       /*Case when B.PERKIRAAN=A.Perkiraan then B.PERKIRAAN

            when B.LAWAN=A.Perkiraan then B.LAWAN

            else ''

        */''Perkiraan,  '' Lawan,

       A.DK, 0.00 Debet, 0.00 DebetRp, '', 1.00 Kurs, 0.00 Kredit, 0.00 KreditD,

       SUM(Case when Datepart(DD,@tglawal)=1 then 0

                else

       Case when A.DK=0 and B.PERKIRAAN=A.Perkiraan then B.DEBETRP

            when A.DK=1 and B.PERKIRAAN=A.Perkiraan then -B.DEBETRP

            when A.DK=0 and B.LAWAN=A.Perkiraan then -B.DEBETRP

            when A.DK=1 and B.LAWAN=A.Perkiraan then B.DEBETRP

            else 0

        ) SaldoAkhir,

       SUM(Case when Datepart(DD,@tglawal)=1 then 0

                else

       /*Case when A.DK=0 and B.PERKIRAAN=A.Perkiraan then B.DEBET 

            when A.DK=1 and B.PERKIRAAN=A.Perkiraan then -B.DEBET 

            when A.DK=0 and B.LAWAN=A.Perkiraan then -B.DEBET 

            when A.DK=1 and B.LAWAN=A.Perkiraan then B.DEBET 

            else 0*/

        Case when A.DK=0 and B.PERKIRAAN=A.Perkiraan and b.VALAS<>'IDR' then B.DEBET 

            when A.DK=1 and B.PERKIRAAN=A.Perkiraan and b.VALAS<>'IDR' then -B.DEBET 

            when A.DK=0 and B.LAWAN=A.Perkiraan and b.VALAS<>'IDR' then -B.DEBET 

            when A.DK=1 and B.LAWAN=A.Perkiraan and b.VALAS<>'IDR' then B.DEBET 

            else 0     

        ) SaldoAkhirD, B.Devisi, '' NoUrut, A.Perkiraan NoACC, A.Keterangan Nama, 0 Urut

From DBPERKIRAAN A

     left Outer join vwTransaksi B on B.PERKIRAAN=A.Perkiraan or B.LAWAN=A.Perkiraan

where (B.Tanggal >=@Mulai and B.Tanggal<@tglawal) and B.Devisi like @devisi and (A.Perkiraan between @awal and @akhir) 

Group by A.Perkiraan, A.DK, B.DEVISI, A.Keterangan

union all

Select B.Nobukti, B.TANGGAL,B.NOTE, B.KETERANGAN,

       B.PERKIRAAN,  

       Case when B.PERKIRAAN=A.Perkiraan then B.LAWAN 

            when B.LAWAN=A.Perkiraan then B.PERKIRAAN

            else ''

        LAWAN,

       A.DK, 

       Case when B.PERKIRAAN=A.Perkiraan then B.DEBET  else 0  Debet, 

       Case when B.PERKIRAAN=A.Perkiraan then B.DEBETRP else 0  DebetRp,

        

       B.VALAS, B.KURS, 

       Case when B.LAWAN=A.Perkiraan then B.DEBET  else 0  Kredit, 

       Case when B.LAWAN=A.Perkiraan then B.DEBETRP else 0  KreditRp,

       

       (

       Case when A.DK=0 and B.PERKIRAAN=A.Perkiraan then B.DEBETRP

            when A.DK=1 and B.PERKIRAAN=A.Perkiraan then -B.DEBETRP

            when A.DK=0 and B.LAWAN=A.Perkiraan then -B.DEBETRP

            when A.DK=1 and B.LAWAN=A.Perkiraan then B.DEBETRP

            else 0

       ) SaldoAkhir,

       (

      /* Case when A.DK=0 and B.PERKIRAAN=A.Perkiraan then B.DEBET 

            when A.DK=1 and B.PERKIRAAN=A.Perkiraan then -B.DEBET 

            when A.DK=0 and B.LAWAN=A.Perkiraan then -B.DEBET 

            when A.DK=1 and B.LAWAN=A.Perkiraan then B.DEBET 

            else 0*/

       Case when A.DK=0 and B.PERKIRAAN=A.Perkiraan and b.VALAS<>'IDR' then B.DEBET 

            when A.DK=1 and B.PERKIRAAN=A.Perkiraan and b.VALAS<>'IDR'then -B.DEBET 

            when A.DK=0 and B.LAWAN=A.Perkiraan and b.VALAS<>'IDR' then -B.DEBET 

            when A.DK=1 and B.LAWAN=A.Perkiraan and b.VALAS<>'IDR' then B.DEBET 

            else 0     

       ) SaldoAkhirD, B.Devisi, B.NOURUT, A.Perkiraan NoACC, A.Keterangan Nama, B.Urut

From DBPERKIRAAN A

     left Outer join vwTransaksi B on B.PERKIRAAN=A.Perkiraan or B.LAWAN=A.Perkiraan

where (B.Tanggal between @tglawal and @tglakhir) and B.Devisi like @devisi and (A.Perkiraan between @awal and @akhir))



Select Nobukti,Tanggal, Note, Keterangan, Perkiraan, Lawan, DK, 

      Debet DebetD, DebetRp Debet, Valas, Kurs, Kredit KreditD, KreditRp Kredit, 

      Sum(SaldoAkhir) SaldoAkhir, Sum(SaldoAkhirD) SaldoAkhirD,

       Devisi, Nourut, NoACC, Nama, urut

From Transaksi A

where (A.NoACC between @awal and @akhir) and (A.Tanggal between DATEADD(DD,-1,@Mulai) and @tglakhir)

Group by Nobukti,Tanggal, Note, Keterangan, Perkiraan, Lawan, DK, Debet, DebetRp, Valas, Kurs, Kredit, KreditRp,

         Devisi, Nourut, NoACC, Nama, Urut 

Having Sum(SaldoAkhir)<>0 Or Sum(SaldoAkhirD) <>0

Order by NoACC, Tanggal,NoUrut,Nobukti, Urut;

-- Sp_ReportCashBack
CREATE PROCEDURE IF NOT EXISTS Sp_ReportCashBack AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 

select @Id=SUBSTRING(@Id,1,1)

if @Id=''

if @isiList=''

	 exec('select ''Gabungan'' Perusahaan,* from vwCashBack where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  

   order by KODECUST')

   else

     exec('select ''Gabungan'' Perusahaan,* from vwCashBack where KODECUST IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  

   order by KODECUST')



else

if @isiList=''

	 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from vwCashBack where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  

	 and '''+@ID+'''= Left(NoBukti,1)

   order by KODECUST')

   else

     exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from vwCashBack where KODECUST IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  

   and '''+@ID+'''= Left(NoBukti,1)

   order by KODECUST');

-- SP_ReportCashFlow
CREATE PROCEDURE IF NOT EXISTS SP_ReportCashFlow AS select a.gol, a.lawan, case when a.KodeCS='' then sum(COALESCE(a.kas,0)) else null  as Kas,

case when a.KodeCS='' then (case when (exists (select COALESCE(b.kas,0)

                    from dbcashflow b

                    where b.KodeCS='' and b.KodeCS=a.KodeCS and b.lawan=a.lawan and b.Userid=a.Userid and b.gol='PENERIMAAN'

		         group by b.Lawan, b.gol, b.userid, b.kas) and

            exists (select COALESCE(b.kas,0)

                    from dbcashflow b

                    where b.KodeCS='' and b.KodeCS=a.KodeCS and b.lawan=a.lawan and b.Userid=a.Userid and b.gol='PENGELUARAN'

		         group by b.Lawan, b.gol, b.userid, b.kas)) then

           (case when (select sum(COALESCE(b.kas,0)) from dbcashflow b

                       where b.KodeCS='' and b.KodeCS=a.KodeCS and b.lawan=a.lawan and b.Userid=a.Userid and b.gol='PENERIMAAN')>

                      (select sum(COALESCE(b.kas,0)) from dbcashflow b

                       where b.KodeCS='' and b.KodeCS=a.KodeCS and b.lawan=a.lawan and b.Userid=a.Userid and b.gol='PENGELUARAN') then

                      (select sum(COALESCE(b.kas,0)) from dbcashflow b

                       where b.KodeCS='' and b.KodeCS=a.KodeCS and b.lawan=a.lawan and b.Userid=a.Userid and b.gol='PENGELUARAN') else

                      (select sum(COALESCE(b.kas,0)) from dbcashflow b

                       where b.KodeCS='' and b.KodeCS=a.KodeCS and b.lawan=a.lawan and b.Userid=a.Userid and b.gol='PENERIMAAN')

            )

      else sum(0) ) else null  as Koreksi,

 case when a.KodeCS='' then (sum(COALESCE(a.kas,0))-

 (case when (exists (select COALESCE(b.kas,0)

                     from dbcashflow b

                     where b.KodeCS='' and b.KodeCS=a.KodeCS and b.lawan=a.lawan and b.Userid=a.Userid and b.gol='PENERIMAAN'

		          group by b.Lawan, b.gol, b.userid, b.kas) and

             exists (select COALESCE(b.kas,0)

                     from dbcashflow b

                     where b.KodeCS='' and b.KodeCS=a.KodeCS and b.lawan=a.lawan and b.Userid=a.Userid and b.gol='PENGELUARAN'

		          group by b.Lawan, b.gol, b.userid, b.kas)) then

           (case when (select sum(COALESCE(b.kas,0)) from dbcashflow b

                       where b.KodeCS='' and b.KodeCS=a.KodeCS and b.lawan=a.lawan and b.Userid=a.Userid and b.gol='PENERIMAAN')>

                      (select sum(COALESCE(b.kas,0)) from dbcashflow b

                       where b.KodeCS='' and b.KodeCS=a.KodeCS and b.lawan=a.lawan and b.Userid=a.Userid and b.gol='PENGELUARAN') then

                      (select sum(COALESCE(b.kas,0)) from dbcashflow b

                       where b.KodeCS='' and b.KodeCS=a.KodeCS and b.lawan=a.lawan and b.Userid=a.Userid and b.gol='PENGELUARAN') else

                      (select sum(COALESCE(b.kas,0)) from dbcashflow b

                       where b.KodeCS='' and b.KodeCS=a.KodeCS and b.lawan=a.lawan and b.Userid=a.Userid and b.gol='PENERIMAAN')

            )

  else 0 )) else null  as Jumlah, case when a.KodeCs='' then null else sum(a.Kas)  DetKas, a.keterangan, a.Urut, a.Devisi

from dbcashflow a

where Userid=@userid and Perkiraan in (select perkiraan from dbAksesPerkiraan where userid=@userid)

and lawan in (select perkiraan from dbAksesPerkiraan where userid=@userid)

Group by a.gol, a.lawan, a.Keterangan, a.userid, a.Urut, a.Devisi, a.KodeCS

order by a.devisi, a.Urut, a.Gol, a.lawan, a.KodeCS;

-- Sp_reportDebetnoteDet
CREATE PROCEDURE IF NOT EXISTS Sp_reportDebetnoteDet AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 



if @SReport='T'

If @Ordr='N'

		If @NeedOto=0 or @NeedOto=1

				select * from VwreportDebetNotte where Tanggal between @tgl1 and @tgl2 and NeedOtorisasi=@NeedOto

				order by NoBukti,Tanggal

			If @NeedOto=2

				select * from VwreportDebetNotte where Tanggal between @tgl1 and @tgl2

				order by NoBukti,Tanggal

		 

	else If @Ordr='B'

		If @NeedOto=0 or @NeedOto=1

				select * from VwreportDebetNotte where Tanggal between @tgl1 and @tgl2  and NeedOtorisasi=@NeedOto

				--order by KodeBrg

			If @NeedOto=2

				select * from VwreportDebetNotte where Tanggal between @tgl1 and @tgl2 

				--order by KodeBrg

		 

	else If @Ordr='S'

		If @NeedOto=0 or @NeedOto=1

				select * from VwreportDebetNotte where Tanggal between @tgl1 and @tgl2 and NeedOtorisasi=@NeedOto

				order by KodeCustSupp

			If @NeedOto=2

				select * from VwreportDebetNotte where Tanggal between @tgl1 and @tgl2 

				order by KodeCustSupp;

-- Sp_ReportFakturPenjualan
CREATE PROCEDURE IF NOT EXISTS Sp_ReportFakturPenjualan AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 

 select @Id=SUBSTRING(@Id,1,1) 

  if @Id=''

  if @isiList=''

	exec('select ''Gabungan'' Perusahaan,* from vwReportFakturPenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

	order by KodeCustSupp')

  else

   	exec('select ''Gabungan'' Perusahaan,* from vwReportFakturPenjualan where KodeCustSupp IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

	order by KodeCustSupp')

  

  else

  if @isiList=''

	exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from vwReportFakturPenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

	and '''+@ID+'''= Left(NOSJ,1)

	order by KodeCustSupp')

  else

   	exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from vwReportFakturPenjualan where KodeCustSupp IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

	and '''+@ID+'''= Left(NOSJ,1)

	order by KodeCustSupp');

-- Sp_ReportHasilPrd
CREATE PROCEDURE IF NOT EXISTS Sp_ReportHasilPrd AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 

if @Id=''

if @SReport='T'

If @Ordr='N'

		if @isiList='' 

		 exec('select ''Gabungan'' Perusahaan,* from Vw_HasilPrd where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		 order by NoBukti,Tanggal')

		 else

		 Exec('select ''Gabungan'' Perusahaan,* from Vw_HasilPrd where NoBukti IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

         order by NoBukti,Tanggal')

		 

	else If @Ordr='B'

		if @isiList=''

		 exec('select ''Gabungan'' Perusahaan,* from Vw_HasilPrd where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		 order by KodeSubGrp,KodeBrg')

		else

		 exec('select ''Gabungan'' Perusahaan,* from Vw_HasilPrd where KodeSubGrp IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		 order by KodeSubGrp,KodeBrg') 

		 

	else If @Ordr='C'

		if @isiList=''

		exec(' select ''Gabungan'' Perusahaan,* from Vw_HasilPrd where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		order by KodeCustSupp')

		else

		exec(' select ''Gabungan'' Perusahaan,* from Vw_HasilPrd where KodeCustSupp IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		order by KodeCustSupp')


else

If @Ordr='N'

		exec('select ''Gabungan'' Perusahaan,* from Vw_HasilPrd where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  order by NoBukti,Tanggal')

		

   else if 	@Ordr='B'

		exec('select ''Gabungan'' Perusahaan,KodeSubGrp,NamaSubGrp,KodeBrg,NamaBrg,Satuan,Sum(QntPro)QntPro,HPP,Sum(QntPro)*HPP Rupiah from Vw_HasilPrd where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  Group by KodeSubGrp,NamaSubGrp,KodeBrg,NamaBrg,Satuan,HPP

		  order by KodeSubGrp,KodeBrg')


else---------

if @SReport='T'

If @Ordr='N'

		if @isiList='' 

		 exec('select case when '''+@ID+'''=''BCA'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from Vw_HasilPrd where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		 and '''+@ID+'''=Case When Len('''+@ID+''')=3 Then Left(NoBukti,3) else Left(NoBukti,2) 

		 order by NoBukti,Tanggal')

		 else

		 Exec('select case when '''+@ID+'''=''BCA'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from Vw_HasilPrd where NoBukti IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

         and '''+@ID+'''=Case When Len('''+@ID+''')=3 Then Left(NoBukti,3) else Left(NoBukti,2) 

         order by NoBukti,Tanggal')

		 

	else If @Ordr='B'

		if @isiList=''

		 exec('select case when '''+@ID+'''=''BCA'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from Vw_HasilPrd where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		 and '''+@ID+'''=Case When Len('''+@ID+''')=3 Then Left(NoBukti,3) else Left(NoBukti,2) 

		 order by KodeSubGrp,KodeBrg')

		else

		 exec('select case when '''+@ID+'''=''BCA'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from Vw_HasilPrd where KodeSubGrp IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		 and '''+@ID+'''=Case When Len('''+@ID+''')=3 Then Left(NoBukti,3) else Left(NoBukti,2) 

		 order by KodeSubGrp,KodeBrg') 

		 

	else If @Ordr='C'

		if @isiList=''

		exec(' select case when '''+@ID+'''=''BCA'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from Vw_HasilPrd where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		and '''+@ID+'''=Case When Len('''+@ID+''')=3 Then Left(NoBukti,3) else Left(NoBukti,2) 

		order by KodeCustSupp')

		else

		exec(' select case when '''+@ID+'''=''BCA'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from Vw_HasilPrd where KodeCustSupp IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		and '''+@ID+'''=Case When Len('''+@ID+''')=3 Then Left(NoBukti,3) else Left(NoBukti,2) 

		order by KodeCustSupp')


else

If @Ordr='N'

		exec('select case when '''+@ID+'''=''BCA'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from Vw_HasilPrd where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and '''+@ID+'''=Case When Len('''+@ID+''')=3 Then Left(NoBukti,3) else Left(NoBukti,2) 

		  order by NoBukti,Tanggal')

		

   else if 	@Ordr='B'

		exec('select case when '''+@ID+'''=''BCA'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,KodeSubGrp,NamaSubGrp,KodeBrg,NamaBrg,Satuan,Sum(QntPro)QntPro,HPP,Sum(QntPro)*HPP Rupiah from Vw_HasilPrd where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and '''+@ID+'''=Case When Len('''+@ID+''')=3 Then Left(NoBukti,3) else Left(NoBukti,2) 

		  Group by KodeSubGrp,NamaSubGrp,KodeBrg,NamaBrg,Satuan,HPP

		  order by KodeSubGrp,KodeBrg');

-- Sp_reporthasilPRDACCDet
CREATE PROCEDURE IF NOT EXISTS Sp_reporthasilPRDACCDet AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 



if @SReport='T'

If @Ordr='N'

		If @NeedOto=0 or @NeedOto=1

			select * from VwreportHasilPrdACC where Tanggal between @tgl1 and @tgl2 and Needotorisasi=@NeedOto

			order by NoBukti,Tanggal

		  If @NeedOto=2

			select * from VwreportHasilPrdACC where Tanggal between @tgl1 and @tgl2 

			order by NoBukti,Tanggal

		 

	else If @Ordr='B'

		If @NeedOto=0 or @NeedOto=1

			select * from VwreportHasilPrdACC where Tanggal between @tgl1 and @tgl2  and Needotorisasi=@NeedOto

			order by KodeBrg

		If @NeedOto=2

			select * from VwreportHasilPrdACC where Tanggal between @tgl1 and @tgl2  

			order by KodeBrg;

-- Sp_reporthasilPRDDet
CREATE PROCEDURE IF NOT EXISTS Sp_reporthasilPRDDet AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 



if @SReport='T'

If @Ordr='N'

		If @NeedOto=0 or @NeedOto=1

		   if @isiList='' 

			Exec('select * from VwreportHasilPrd where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi= '+@NeedOto+' 

			order by NoBukti,Tanggal')

		   else

		    Exec('select * from VwreportHasilPrd where NoBukti IN'+@isiList+ '  and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and Needotorisasi= '+@NeedOto+' 

			order by NoBukti,Tanggal') 

			

		  else

		  

		  If @NeedOto=2

		   if @isiList='' 

			Exec('select * from VwreportHasilPrd where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

			order by NoBukti,Tanggal')

		   else

		    Exec('select * from VwreportHasilPrd where NoBukti IN'+@isiList+ '  and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

			order by NoBukti,Tanggal')	


	else If @Ordr='B'

		If @NeedOto=0 or @NeedOto=1

		   if @isiList='' 

		    Exec('select * from VwreportHasilPrd where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

		 	order by kodesubgrp,KodeBrg')

           else

            Exec('select * from VwreportHasilPrd where KodeBrg IN'+@isiList+ '  and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')  and Needotorisasi='+@NeedOto+'

		 	order by kodesubgrp,KodeBrg')

           

        else    

		If @NeedOto=2

		 if @isiList='' 

		  Exec('select * from VwreportHasilPrd where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')    

			order by kodesubgrp,KodeBrg')

	      else

	      Exec('select * from VwreportHasilPrd where KodeBrg IN'+@isiList+ '  and  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')    

			order by kodesubgrp,KodeBrg');

-- Sp_ReportHistoriKP
CREATE PROCEDURE IF NOT EXISTS Sp_ReportHistoriKP AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 

Select @Id=LEFT(@Id,1)

if @Id=''

if @isiList='' 

     exec('select ''Gabungan'' Perusahaan,* from [Vw_HistoryKP] where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

      order by KODECUST,KodePrj,NoBukti,KdbrgSJ')

	 

 else

     exec('select ''Gabungan'' Perusahaan,* from [Vw_HistoryKP] where Filter IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

      order by NoBukti,KdbrgSJ')


else

if @isiList='' 

     exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from [Vw_HistoryKP] where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

      and '''+@ID+'''= Left(NoBukti,1)

      order by KODECUST,KodePrj,NoBukti,KdbrgSJ')

	 

 else

     exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from [Vw_HistoryKP] where Filter IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

      and '''+@ID+'''= Left(NoBukti,1)

      order by NoBukti,KdbrgSJ');

-- Sp_reportInvoicedet
CREATE PROCEDURE IF NOT EXISTS Sp_reportInvoicedet AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 



if @SReport='T'

If @Ordr='N'

		If @NeedOto=0 or @NeedOto=1

			select * from VwreportINVoice where Tanggal between @tgl1 and @tgl2 and NeedOtorisasi=@NeedOto

			order by NoBukti,Tanggal

		If @NeedOto=2

			select * from VwreportINVoice where Tanggal between @tgl1 and @tgl2 

			order by NoBukti,Tanggal

		 

	else If @Ordr='B'

		If @NeedOto=0 or @NeedOto=1

			select * from VwreportINVoice where Tanggal between @tgl1 and @tgl2  and NeedOtorisasi=@NeedOto

			order by KodeBrg

		  If @NeedOto=2

			select * from VwreportINVoice where Tanggal between @tgl1 and @tgl2 

			order by KodeBrg

		 

	else If @Ordr='S'

		If @NeedOto=0 or @NeedOto=1

				select * from VwreportINVoice where Tanggal between @tgl1 and @tgl2  and NeedOtorisasi=@NeedOto

				order by KodeCustSupp

			If @NeedOto=2

				select * from VwreportINVoice where Tanggal between @tgl1 and @tgl2  

				order by KodeCustSupp;

-- Sp_ReportInvoicePenjualan_DP
CREATE PROCEDURE IF NOT EXISTS Sp_ReportInvoicePenjualan_DP AS ---- DECLARE REMOVED,@Tgl1 DateTime,@Tgl2 Datetime

select @Id=SUBSTRING(@Id,1,1)

if @id=''

Select @Choice='N',@Tgl1='06/01/2017',@Tgl2='06/30/2017'

If @Choice='N'

select 'Gabungan' Perusahaan,*,COALESCE(INV,0)-COALESCE(PiutSJ,0) Selisih from (

    select  A.*,'A' Prioritas,1 Urut,'Piutang Surat Jalan' Laporan,C.NoBukti,C.Tanggal,b.KodeBrg,b.NAMABRG,b.qntinv qnt,b.Satuan,b.HARGA,b.INV NDPPRp

    from PiutSjVsInv(@Tgl1,@Tgl2) A

    left outer join

      (Select  A.NoBukti+SUBSTR('00000'+cast(A.Urut as varchar(5)), LENGTH('00000'+cast(A.Urut as varchar(5)))-5+1) KeyNoBukti, A.Nobukti, F.Tanggal, F.KodeCustSupp, S.Namacust NamaCustSupp,F.NoResi,P.NAMAPROJECT,

          A.urut, A.kodebrg, B.NamaBrg, '' Jns_Kertas, '' Ukr_Kertas, A.Sat_1, A.Isi,A.Qnt qnt,a.qntinv qntinv,a.QntRetur, A.QntSisa qntsisa,

          A.SAT_1 Satuan, e.Tglkirim,e.NOBUKTI noso,e.tanggal tglso,e.NOSPB nopo,g.HARGA,COALESCE(g1.HPPBrg,0) HPP, (A.QntSisa *g.HARGA)-((A.QntSisa *g.HARGA)*g.DISC/100) dppnet, A.QntSisa *COALESCE(g1.HPPBrg,0) hppnet,A.Nosat,A.SAT_2,

          c.NoSPP,c.UrutSPP,A.Qnt*g.HARGA SJ,(a.qntinv*g.HARGA)-((a.qntinv*g.HARGA)*g.DISC/100) INV  

    From  vwPiutSJ_DPPINV(@Tgl1,@Tgl2) A

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

    where COALESCE(F.IsClose,0)=0 and A.Tanggal between @Tgl1 and @Tgl2 and e.NOBUKTI<>''

    ) B on B.KodeCustSupp=A.KodeCustSupp

    left outer join (select distinct a.NoSO,a.NoBukti,b.Tanggal from dbInvoicePLDet a left outer join DBInvoicePL b on b.NoBukti=a.NoBukti

                 where (b.Tanggal between @Tgl1 and @Tgl2)) C on C.NoSO=B.noso

    --where B.NoBukti is not null

   

    Union All



    select distinct A.*,'B' Prioritas,1 Urut,'Invoice' Laporan,NoBukti,Tanggal,KodeBrg,NamaBrg,qnt,satuan,HARGA,NDPPRp

    from PiutSjVsInv(@Tgl1,@Tgl2) A

    left join VwreportinvoicePenjualan R on R.KodeCustSupp=A.KodeCustSupp --and R.NoSPB=b.NoBukti  and  R.UrutSPB=B.Urut

    where R.Tanggal between @Tgl1 and @Tgl2 and R.Needotorisasi=0 and R.NoBukti is not null

    

    Union All

    

    select distinct A.*,'A' Prioritas,2 Urut,'Piutang Surat Jalan' Laporan,NoBukti,Tanggal,'','',0,'',0,0

    from PiutSjVsInv(@Tgl1,@Tgl2) A

    left join VwreportinvoicePenjualan R on R.KodeCustSupp=A.KodeCustSupp --and R.NoSPB=b.NoBukti  and  R.UrutSPB=B.Urut

    where R.Tanggal between @Tgl1 and @Tgl2 and R.Needotorisasi=0 and R.NoBukti is not null 

    

    Union All

    

        select distinct A.*,'B' Prioritas,2 Urut,'Invoice' Laporan,C.NoBukti,C.Tanggal,'','',0,'',0,0

    from PiutSjVsInv(@Tgl1,@Tgl2) A

    left outer join

      (Select  A.NoBukti+SUBSTR('00000'+cast(A.Urut as varchar(5)), LENGTH('00000'+cast(A.Urut as varchar(5)))-5+1) KeyNoBukti, A.Nobukti, F.Tanggal, F.KodeCustSupp, S.Namacust NamaCustSupp,F.NoResi,P.NAMAPROJECT,

          A.urut, A.kodebrg, B.NamaBrg, '' Jns_Kertas, '' Ukr_Kertas, A.Sat_1, A.Isi,A.Qnt qnt,a.qntinv qntinv,a.QntRetur, A.QntSisa qntsisa,

          A.SAT_1 Satuan, e.Tglkirim,e.NOBUKTI noso,e.tanggal tglso,e.NOSPB nopo,g.HARGA,COALESCE(g1.HPPBrg,0) HPP, (A.QntSisa *g.HARGA)-((A.QntSisa *g.HARGA)*g.DISC/100) dppnet, A.QntSisa *COALESCE(g1.HPPBrg,0) hppnet,A.Nosat,A.SAT_2,

          c.NoSPP,c.UrutSPP,A.Qnt*g.HARGA SJ,(a.qntinv*g.HARGA)-((a.qntinv*g.HARGA)*g.DISC/100) INV  

    From  vwPiutSJ_DPPINV(@Tgl1,@Tgl2) A

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

    where COALESCE(F.IsClose,0)=0 and A.Tanggal between @Tgl1 and @Tgl2 and e.NOBUKTI<>''

    ) B on B.KodeCustSupp=A.KodeCustSupp

    left outer join (select distinct a.NoSO,a.NoBukti,b.Tanggal from dbInvoicePLDet a left outer join DBInvoicePL b on b.NoBukti=a.NoBukti

                 where (b.Tanggal between @Tgl1 and @Tgl2)) C on C.NoSO=B.noso

    --where B.NoBukti is not null

    

  ) G where G.NoBukti is not null order by G.KodeCustSupp,G.NoBukti,G.Prioritas,G.Urut


Else If @Choice='B'

select 	'Gabungan' Perusahaan,B.KodeBrg,C.NAMABRG,b.SAT_1,b.SAT_2,

		SUM(b.qnt) QNT,SUM(b.qnt2)QNT2,

		SUM(b.ndpp) NDPP,SUM(B.ndpprp) NDPPRP, sum(b.Nppnrp)NPPNRP,SUM(B.nnetrp)NNETRP,SUM(A.DP)DP,DP.Total,(SUM(A.DP)/DP.Total)*100 PersenDP		

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		Left Outer Join (Select KodeCustSupp,KodeProject,Total from dbDP Group by KodeCustSupp,KodeProject,Total)DP On DP.KodeCustSupp=A.KodeCustSupp and DP.KodeProject=A.NoBL

		where A.Tanggal between @Tgl1 and @Tgl2 

		Group By B.KodeBrg,C.NAMABRG,b.SAT_1,b.SAT_2,DP.Total

		order By B.KodeBrg


Else If @Choice='C'

select 	'Gabungan' Perusahaan,B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		SUM(b.ndpp) NDPP,SUM(B.ndpprp) NDPPRP, sum(b.Nppnrp)NPPNRP,SUM(B.nnetrp)NNETRP,SUM(A.DP)DP,DP.Total,(SUM(A.DP)/DP.Total)*100 PersenDP

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		left outer join dbSPB X on B.NoSPB = X.NoBukti

		left outer join dbSPP y on y.NoBukti=x.NoSPP

		left outer join DBSO z on z.NOBUKTI=y.NoSHIP

		left outer join dbKaryawan p on p.KeyNIK=z.KODESLS

		Left Outer Join (Select KodeCustSupp,KodeProject,Total from dbDP Group by KodeCustSupp,KodeProject,Total)DP On DP.KodeCustSupp=A.KodeCustSupp and DP.KodeProject=A.NoBL

		where A.Tanggal between @Tgl1 and @Tgl2 

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,DP.Total

		order By D.NAMACUSTSUPP,A.Tanggal


Else If @Choice='S'

select 	'Gabungan' Perusahaan,B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		SUM(b.ndpp) NDPP,SUM(B.ndpprp) NDPPRP, sum(b.Nppnrp)NPPNRP,SUM(B.nnetrp)NNETRP,SUM(A.DP)DP,DP.Total,(SUM(A.DP)/DP.Total)*100 PersenDP

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		left outer join dbSPB X on B.NoSPB = X.NoBukti

		left outer join dbSPP y on y.NoBukti=x.NoSPP

		left outer join DBSO z on z.NOBUKTI=y.NoSHIP

		left outer join dbKaryawan p on p.KeyNIK=z.KODESLS

		Left Outer Join (Select KodeCustSupp,KodeProject,Total from dbDP Group by KodeCustSupp,KodeProject,Total)DP On DP.KodeCustSupp=A.KodeCustSupp and DP.KodeProject=A.NoBL

		where A.Tanggal between @Tgl1 and @Tgl2

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,DP.Total

		order By p.Nama,d.NAMACUSTSUPP,b.NoBukti


else-----

Select @Choice='N',@Tgl1='06/01/2017',@Tgl2='06/30/2017'

If @Choice='N'

select Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,*,COALESCE(INV,0)-COALESCE(PiutSJ,0) Selisih from (

    select  A.*,'A' Prioritas,1 Urut,'Piutang Surat Jalan' Laporan,C.NoBukti,C.Tanggal,b.KodeBrg,b.NAMABRG,b.qntinv qnt,b.Satuan,b.HARGA,b.INV NDPPRp

    from PiutSjVsInv(@Tgl1,@Tgl2) A

    left outer join

      (Select  A.NoBukti+SUBSTR('00000'+cast(A.Urut as varchar(5)), LENGTH('00000'+cast(A.Urut as varchar(5)))-5+1) KeyNoBukti, A.Nobukti, F.Tanggal, F.KodeCustSupp, S.Namacust NamaCustSupp,F.NoResi,P.NAMAPROJECT,

          A.urut, A.kodebrg, B.NamaBrg, '' Jns_Kertas, '' Ukr_Kertas, A.Sat_1, A.Isi,A.Qnt qnt,a.qntinv qntinv,a.QntRetur, A.QntSisa qntsisa,

          A.SAT_1 Satuan, e.Tglkirim,e.NOBUKTI noso,e.tanggal tglso,e.NOSPB nopo,g.HARGA,COALESCE(g1.HPPBrg,0) HPP, (A.QntSisa *g.HARGA)-((A.QntSisa *g.HARGA)*g.DISC/100) dppnet, A.QntSisa *COALESCE(g1.HPPBrg,0) hppnet,A.Nosat,A.SAT_2,

          c.NoSPP,c.UrutSPP,A.Qnt*g.HARGA SJ,(a.qntinv*g.HARGA)-((a.qntinv*g.HARGA)*g.DISC/100) INV  

    From  vwPiutSJ_DPPINV(@Tgl1,@Tgl2) A

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

    where COALESCE(F.IsClose,0)=0 and A.Tanggal between @Tgl1 and @Tgl2 and e.NOBUKTI<>''

    ) B on B.KodeCustSupp=A.KodeCustSupp

    left outer join (select distinct a.NoSO,a.NoBukti,b.Tanggal from dbInvoicePLDet a left outer join DBInvoicePL b on b.NoBukti=a.NoBukti

                 where (b.Tanggal between @Tgl1 and @Tgl2)) C on C.NoSO=B.noso

    --where B.NoBukti is not null

    where @Id=LEFT(B.NoBukti,1)

    Union All



    select distinct A.*,'B' Prioritas,1 Urut,'Invoice' Laporan,NoBukti,Tanggal,KodeBrg,NamaBrg,qnt,satuan,HARGA,NDPPRp

    from PiutSjVsInv(@Tgl1,@Tgl2) A

    left join VwreportinvoicePenjualan R on R.KodeCustSupp=A.KodeCustSupp --and R.NoSPB=b.NoBukti  and  R.UrutSPB=B.Urut

    where R.Tanggal between @Tgl1 and @Tgl2 and R.Needotorisasi=0 and R.NoBukti is not null

    and @Id=LEFT(R.NoBukti,1)

    Union All

    

    select distinct A.*,'A' Prioritas,2 Urut,'Piutang Surat Jalan' Laporan,NoBukti,Tanggal,'','',0,'',0,0

    from PiutSjVsInv(@Tgl1,@Tgl2) A

    left join VwreportinvoicePenjualan R on R.KodeCustSupp=A.KodeCustSupp --and R.NoSPB=b.NoBukti  and  R.UrutSPB=B.Urut

    where R.Tanggal between @Tgl1 and @Tgl2 and R.Needotorisasi=0 and R.NoBukti is not null 

    and @Id=LEFT(R.NoBukti,1)

    Union All

    

        select distinct A.*,'B' Prioritas,2 Urut,'Invoice' Laporan,C.NoBukti,C.Tanggal,'','',0,'',0,0

    from PiutSjVsInv(@Tgl1,@Tgl2) A

    left outer join

      (Select  A.NoBukti+SUBSTR('00000'+cast(A.Urut as varchar(5)), LENGTH('00000'+cast(A.Urut as varchar(5)))-5+1) KeyNoBukti, A.Nobukti, F.Tanggal, F.KodeCustSupp, S.Namacust NamaCustSupp,F.NoResi,P.NAMAPROJECT,

          A.urut, A.kodebrg, B.NamaBrg, '' Jns_Kertas, '' Ukr_Kertas, A.Sat_1, A.Isi,A.Qnt qnt,a.qntinv qntinv,a.QntRetur, A.QntSisa qntsisa,

          A.SAT_1 Satuan, e.Tglkirim,e.NOBUKTI noso,e.tanggal tglso,e.NOSPB nopo,g.HARGA,COALESCE(g1.HPPBrg,0) HPP, (A.QntSisa *g.HARGA)-((A.QntSisa *g.HARGA)*g.DISC/100) dppnet, A.QntSisa *COALESCE(g1.HPPBrg,0) hppnet,A.Nosat,A.SAT_2,

          c.NoSPP,c.UrutSPP,A.Qnt*g.HARGA SJ,(a.qntinv*g.HARGA)-((a.qntinv*g.HARGA)*g.DISC/100) INV  

    From  vwPiutSJ_DPPINV(@Tgl1,@Tgl2) A

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

    where COALESCE(F.IsClose,0)=0 and A.Tanggal between @Tgl1 and @Tgl2 and e.NOBUKTI<>''

    ) B on B.KodeCustSupp=A.KodeCustSupp

    left outer join (select distinct a.NoSO,a.NoBukti,b.Tanggal from dbInvoicePLDet a left outer join DBInvoicePL b on b.NoBukti=a.NoBukti

                 where (b.Tanggal between @Tgl1 and @Tgl2)) C on C.NoSO=B.noso

    --where B.NoBukti is not null

    and @Id=LEFT(B.NoBukti,1)

  ) G where G.NoBukti is not null order by G.KodeCustSupp,G.NoBukti,G.Prioritas,G.Urut


Else If @Choice='B'

select 	Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,B.KodeBrg,C.NAMABRG,b.SAT_1,b.SAT_2,

		SUM(b.qnt) QNT,SUM(b.qnt2)QNT2,

		SUM(b.ndpp) NDPP,SUM(B.ndpprp) NDPPRP, sum(b.Nppnrp)NPPNRP,SUM(B.nnetrp)NNETRP,SUM(A.DP)DP,DP.Total,(SUM(A.DP)/DP.Total)*100 PersenDP		

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		Left Outer Join (Select KodeCustSupp,KodeProject,Total from dbDP Group by KodeCustSupp,KodeProject,Total)DP On DP.KodeCustSupp=A.KodeCustSupp and DP.KodeProject=A.NoBL

		where A.Tanggal between @Tgl1 and @Tgl2 

		and @Id=LEFT(B.NoBukti,1)

		Group By B.KodeBrg,C.NAMABRG,b.SAT_1,b.SAT_2,DP.Total

		order By B.KodeBrg


Else If @Choice='C'

select 	Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		SUM(b.ndpp) NDPP,SUM(B.ndpprp) NDPPRP, sum(b.Nppnrp)NPPNRP,SUM(B.nnetrp)NNETRP,SUM(A.DP)DP,DP.Total,(SUM(A.DP)/DP.Total)*100 PersenDP

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		left outer join dbSPB X on B.NoSPB = X.NoBukti

		left outer join dbSPP y on y.NoBukti=x.NoSPP

		left outer join DBSO z on z.NOBUKTI=y.NoSHIP

		left outer join dbKaryawan p on p.KeyNIK=z.KODESLS

		Left Outer Join (Select KodeCustSupp,KodeProject,Total from dbDP Group by KodeCustSupp,KodeProject,Total)DP On DP.KodeCustSupp=A.KodeCustSupp and DP.KodeProject=A.NoBL

		where A.Tanggal between @Tgl1 and @Tgl2 

		and @Id=LEFT(B.NoBukti,1)

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,DP.Total

		order By D.NAMACUSTSUPP,A.Tanggal


Else If @Choice='S'

select 	Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		SUM(b.ndpp) NDPP,SUM(B.ndpprp) NDPPRP, sum(b.Nppnrp)NPPNRP,SUM(B.nnetrp)NNETRP,SUM(A.DP)DP,DP.Total,(SUM(A.DP)/DP.Total)*100 PersenDP

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		left outer join dbSPB X on B.NoSPB = X.NoBukti

		left outer join dbSPP y on y.NoBukti=x.NoSPP

		left outer join DBSO z on z.NOBUKTI=y.NoSHIP

		left outer join dbKaryawan p on p.KeyNIK=z.KODESLS

		Left Outer Join (Select KodeCustSupp,KodeProject,Total from dbDP Group by KodeCustSupp,KodeProject,Total)DP On DP.KodeCustSupp=A.KodeCustSupp and DP.KodeProject=A.NoBL

		where A.Tanggal between @Tgl1 and @Tgl2

		and @Id=LEFT(B.NoBukti,1)

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,DP.Total

		order By p.Nama,d.NAMACUSTSUPP,b.NoBukti;

-- Sp_ReportInvoicePenjualanDet
CREATE PROCEDURE IF NOT EXISTS Sp_ReportInvoicePenjualanDet AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 

select @Id=SUBSTRING(@Id,1,1)

if @Id=''

If @Ordr='N'

	if @NeedOto=0 or @NeedOto=1

		if @isKP =0

		  if @PPN=0 

		  if @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'' )  and PPN in(1,2)

		  order by NoBukti,Tanggal')

		  else

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and PPN in(1,2) and  NoBukti  IN'+@isiList+ ' 

		  order by NoBukti,Tanggal')

		  

		  else if @PPN=1 

		  if @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and PPN in(0)

		  order by NoBukti,Tanggal')

		  else

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  NoBukti  IN'+@isiList+ ' and PPN in(0)

		  order by NoBukti,Tanggal')

		  

		  else if @PPN=2 

		  if @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') 

		  order by NoBukti,Tanggal')

		  else

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  NoBukti  IN'+@isiList+ ' 

		  order by NoBukti,Tanggal')


		 else if @isKP =1

		 if @PPN=0 

		 if  @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'' ) and PPN in(1,2)

		  order by NoBukti,Tanggal')

		 else

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  NoBukti  IN'+@isiList+ ' and PPN in(1,2)

		  order by NoBukti,Tanggal') 

		  

		  else if @PPN=1 

		  if  @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and PPN in(0)

		  order by NoBukti,Tanggal')

	     else

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  NoBukti  IN'+@isiList+ ' and PPN in(0)

		  order by NoBukti,Tanggal') 

		  

		  else if @PPN=2 

		  if  @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') 

		  order by NoBukti,Tanggal')

	     else

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  NoBukti  IN'+@isiList+ ' 

		  order by NoBukti,Tanggal') 


		 else

		  if @PPN=0 

		  if @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(1,2) 

		  order by NoBukti,Tanggal')

		  else

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(1,2) 

		  and NoBukti  IN'+@isiList+ ' 

		  order by NoBukti,Tanggal')

		  

		  else if @PPN=1 

		  if @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(0) 

		  order by NoBukti,Tanggal')

		  else

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(0) 

		  and NoBukti  IN'+@isiList+ ' 

		  order by NoBukti,Tanggal')

		  

		  else if @PPN=2 

		  if @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  order by NoBukti,Tanggal')

		  else

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and NoBukti  IN'+@isiList+ ' 

		  order by NoBukti,Tanggal')


		else if @NeedOto=2

		if  @isKP =0

		if @PPN=0 

		if @isiList ='' 

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(1,2)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'')   

		  order by NoBukti,Tanggal')

		else

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(1,2)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  NoBukti  IN'+@isiList+ '  

		  order by NoBukti,Tanggal') 

		 

		 else  if @PPN=1

		if @isiList ='' 

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(0)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'')   

		  order by NoBukti,Tanggal')

		else

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(0)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  NoBukti  IN'+@isiList+ '  

		  order by NoBukti,Tanggal') 

		 

		 else  if @PPN=2

		if @isiList ='' 

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'')  

		  order by NoBukti,Tanggal')

		else

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  NoBukti  IN'+@isiList+ '  

		  order by NoBukti,Tanggal') 


		else if @isKP =1

		If @ppn=0

		if @isiList ='' 

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(1,2)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'')   

		  order by NoBukti,Tanggal')

		else

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(1,2)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  NoBukti  IN'+@isiList+ '  

		  order by NoBukti,Tanggal') 

		  

		else If @ppn=1

		if @isiList ='' 

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(0)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'')  

		  order by NoBukti,Tanggal')

		else

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(0)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  NoBukti  IN'+@isiList+ '  

		  order by NoBukti,Tanggal') 

		  

		 else

		 If @ppn=2

		if @isiList ='' 

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'')   

		  order by NoBukti,Tanggal')

		else

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  NoBukti  IN'+@isiList+ '  

		  order by NoBukti,Tanggal') 


		else

		if @PPN=0 

		if @isiList ='' 

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		     and PPN in(1,2)

		     order by NoBukti,Tanggal')

		 

		else if @PPN=1 

		if @isiList ='' 

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		     and PPN in(0)

		     order by NoBukti,Tanggal')

		

		else if @PPN=2 

		if @isiList ='' 

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		      order by NoBukti,Tanggal')

		    

		else

		 if @PPN=0 

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(1,2)

		  and  NoBukti  IN'+@isiList+ '  

		  order by NoBukti,Tanggal') 

		  

		 else if @PPN=1 

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(0)

		  and  NoBukti  IN'+@isiList+ '  

		  order by NoBukti,Tanggal') 

		  

		  else if @PPN=2 

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and  NoBukti  IN'+@isiList+ '  

		  order by NoBukti,Tanggal') 


else If @Ordr='B'

		if @NeedOto=0 or @NeedOto=1

		if @isKP =0

		  if @PPN=0

		  if @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(1,2)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'')  

		  order by Kodebrg')

		  

		  else if @PPN=1

		  if @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(0)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'')  

		  order by Kodebrg')

		  

		  else if @PPN=2

		  if @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'')  

		  order by Kodebrg')

		  

		  else

		  if @PPN=0 

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in (1,2)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  Kodebrg  IN'+@isiList+ ' 

		  order by Kodebrg')

		  

		  else  if @PPN=1 

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in (0)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  Kodebrg  IN'+@isiList+ ' 

		  order by Kodebrg')

		  

		  else  if @PPN=2 

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  Kodebrg  IN'+@isiList+ ' 

		  order by Kodebrg')


		 else if @isKP =1

		 if @PPN=0

		 if  @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(1,2)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') 

		  order by Kodebrg')

		  

		 else if @PPN=1

		 if  @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(0)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'')

		  order by Kodebrg')

		  

		 else if @PPN=2

		 if  @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'')

		  order by Kodebrg')

		  

		 else

		 if @PPN=0

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(1,2)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  Kodebrg  IN'+@isiList+ ' 

		  order by Kodebrg ') 

		  

		 else  if @PPN=1

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(0)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  Kodebrg  IN'+@isiList+ ' 

		  order by Kodebrg ') 

		 

		 else  if @PPN=2

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  Kodebrg  IN'+@isiList+ ' 

		  order by Kodebrg ') 


		 else

		  if @PPN=0

		  if @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(1,2)

		  order by Kodebrg ')

		  

		  else  if @PPN=1

		  if @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(0)

		  order by Kodebrg ')

		  

		  else  if @PPN=2

		  if @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  order by Kodebrg ')

		  

		  else

		  if @PPN=0

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in (1,2)

		  and Kodebrg  IN'+@isiList+ ' 

		  order by Kodebrg')

		  

		  else if @PPN=1

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in (0)

		  and Kodebrg  IN'+@isiList+ ' 

		  order by Kodebrg')

		  

		  else if @PPN=2

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and Kodebrg  IN'+@isiList+ ' 

		  order by Kodebrg')


		else if @NeedOto=2

		if  @isKP =0

		if @PPN=0 

		if @isiList ='' 

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'')   

		  and PPN in(1,2)

		  order by Kodebrg')

		

		else if @PPN=1 

		if @isiList ='' 

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'')   

		  and PPN in(0)

		  order by Kodebrg')

		 

		else if @PPN=2 

		if @isiList ='' 

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'')   

		  order by Kodebrg')

		     

		else

		if @PPN=0

		exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  Kodebrg  IN'+@isiList+ '  

		  and PPN in(1,2)

		  order by Kodebrg') 

		

		else if @PPN=1

		exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  Kodebrg  IN'+@isiList+ '  

		  and PPN in(0)

		  order by Kodebrg') 

		

		else if @PPN=2

		exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  Kodebrg  IN'+@isiList+ '  

		  order by Kodebrg') 


		else if @isKP =1

		if @PPN=0 

		if @isiList ='' 

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(1,2)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'')   

		  order by Kodebrg')

		 if @PPN=1 

		if @isiList ='' 

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(0)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'')   

		  order by Kodebrg')

		 

		else if @PPN=2 

		if @isiList ='' 

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'')   

		  order by Kodebrg')

		 

		else

		 if @PPN=0

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(1,2)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  Kodebrg  IN'+@isiList+ '  

		  order by Kodebrg') 

		 

		 else if @PPN=1

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(0)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  Kodebrg  IN'+@isiList+ '  

		  order by Kodebrg') 

		 

		 else if @PPN=2

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  Kodebrg  IN'+@isiList+ '  

		  order by Kodebrg') 


		else

		if @PPN=0

		if @isiList ='''' 

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		     and PPN in(1,2)

		     order by Kodebrg')

		

		else if @PPN=1

		if @isiList ='''' 

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		     and PPN in(0)

		     order by Kodebrg')

		

        else if @PPN=2

		if @isiList ='''' 

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		       order by Kodebrg')

		

		else

		 if @PPN=0 

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(1,2)

		  and  Kodebrg  IN'+@isiList+ '  

		  order by Kodebrg') 

		 

		 else  if @PPN=1 

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(0)

		  and  Kodebrg  IN'+@isiList+ '  

		  order by Kodebrg') 

		   

		 else  if @PPN=2 

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and  Kodebrg  IN'+@isiList+ '  

		  order by Kodebrg') 


else If @Ordr='C'

		if @NeedOto=0 or @NeedOto=1

		if @isKP =0

		  if @PPN=0 

		  if @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(1,2)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'')  

		  order by KodeCustSupp')

		  

		  else if @PPN=1 

		  if @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(0)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'')  

		  order by KodeCustSupp')

		  

		  else if @PPN=2 

		  if @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'')  

		  order by KodeCustSupp')

		  

		  else

		  if @PPN=0 

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(1,2)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  KodeCustSupp  IN'+@isiList+ ' 

		  order by KodeCustSupp')

		  

		  else if @PPN=1

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(0)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  KodeCustSupp  IN'+@isiList+ ' 

		  order by KodeCustSupp')

		  

		  else if @PPN=2 

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  KodeCustSupp  IN'+@isiList+ ' 

		  order by KodeCustSupp')


		 else if @isKP =1

		 if @PPN=0

		 if  @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(1,2)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') 

		  order by KodeCustSupp')

		 

		 else if @PPN=1

		 if  @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(0)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') 

		  order by KodeCustSupp')

		 

		 else if @PPN=2

		 if  @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'')

		  order by KodeCustSupp')

		 

		 else

		 if @PPN=0

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(1,2)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  KodeCustSupp  IN'+@isiList+ ' 

		  order by KodeCustSupp ') 

		  

		 else if @PPN=1

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(0)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  KodeCustSupp  IN'+@isiList+ ' 

		  order by KodeCustSupp ') 

		 

		 else if @PPN=2

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  KodeCustSupp  IN'+@isiList+ ' 

		  order by KodeCustSupp ') 


		 else

		  if @PPN=0

		  if @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(1,2)

		  order by KodeCustSupp ')

		  

		  else if @PPN=1

		  if @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(0)

		  order by KodeCustSupp ')

		  

		  else if @PPN=2

		  if @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  order by KodeCustSupp ')

		  

		  else

		   if @PPN=0

            exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		   and PPN in(1,2)

		   and KodeCustSupp  IN'+@isiList+ ' 

		   order by KodeCustSupp')

		   

		   else  if @PPN=1

            exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		   and PPN in(0)

		   and KodeCustSupp  IN'+@isiList+ ' 

		   order by KodeCustSupp')

		   

		   else  if @PPN=2

            exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		   and KodeCustSupp  IN'+@isiList+ ' 

		   order by KodeCustSupp')


		else if @NeedOto=2

		if  @isKP =0

		If @PPN=0

		if @isiList ='' 

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in (1,2)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'')   

		  order by KodeCustSupp')

		 

		else If @PPN=1

		if @isiList ='' 

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in (0)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'')   

		  order by KodeCustSupp')

		   

		else If @PPN=2

		if @isiList ='' 

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'')   

		  order by KodeCustSupp')

		  

		else

		if @PPN=0

		exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPn in(1,2)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  KodeCustSupp  IN'+@isiList+ '  

		  order by KodeCustSupp')

		  

		else if @PPN=1

		exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPn in(0)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  KodeCustSupp  IN'+@isiList+ '  

		  order by KodeCustSupp')

		

		else if @PPN=2

		exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  KodeCustSupp  IN'+@isiList+ '  

		  order by KodeCustSupp')


		else if @isKP =1

		if @PPN=0

		if @isiList ='' 

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPn in(1,2)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'')   

		  order by KodeCustSupp')

		  

		else if @PPN=1

		if @isiList ='' 

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPn in(0)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'')  

		  order by KodeCustSupp')

		

		else if @PPN=2

		if @isiList ='' 

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'')   

		  order by KodeCustSupp')

		    

		else

		if @PPN=0

		exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(1,2)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  KodeCustSupp  IN'+@isiList+ '  

		  order by KodeCustSupp') 

		  

		else if @PPN=1

		exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(0)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  KodeCustSupp  IN'+@isiList+ '  

		  order by KodeCustSupp') 

		

		else if @PPN=2

		exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  KodeCustSupp  IN'+@isiList+ '  

		  order by KodeCustSupp') 


		else

		if @PPN=0

		if @isiList ='' 

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		     and PPN in(1,2)

		     order by KodeCustSupp')

		  

		else if @PPN=1

		if @isiList ='' 

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		     and PPN in(0)

		     order by KodeCustSupp')

		

		else if @PPN=2

		if @isiList ='' 

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		       order by KodeCustSupp')

		else

		

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		        and  KodeCustSupp  IN'+@isiList+ '  

		       order by KodeCustSupp')       

		             

		else

		if @PPN=0 

		exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(1,2)

		  and  Kodebrg  IN'+@isiList+ '  

		  order by KodeCustSupp') 

		

		else if @PPN=1 

		exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(0)

		  and  Kodebrg  IN'+@isiList+ '  

		  order by KodeCustSupp') 

		 

		else if @PPN=2 

		exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and  Kodebrg  IN'+@isiList+ '  

		  order by KodeCustSupp') 


else If @Ordr='S'

		if @NeedOto=0 or @NeedOto=1

		if @isKP =0

		  if @PPN=0

		  if @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPn in(1,2)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'')  

		  order by KodeCustSupp')

		  

		  else  if @PPN=1

		  if @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPn in(0)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'')  

		  order by KodeCustSupp')

		  

		  else  if @PPN=2

		  if @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'')  

		  order by KodeCustSupp')

		  

		  else

		  if @PPN =0

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(1,2)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  Kodebrg  IN'+@isiList+ ' 

		  order by KodeCustSupp')

		  

		  else if @PPN =1

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(0)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  Kodebrg  IN'+@isiList+ ' 

		  order by KodeCustSupp')

		  

		  else if @PPN =2

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  Kodebrg  IN'+@isiList+ ' 

		  order by KodeCustSupp')


		 else if @isKP =1

		 if @PPN=0

		 if  @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(1,2)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') 

		  order by KodeCustSupp')

		  

		  else if @PPN=1

		 if  @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(0)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') 

		  order by KodeCustSupp')

		  

		 else if @PPN=2

		 if  @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') 

		  order by KodeCustSupp')

		   

		 else

		 if @PPN=0

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(1,2)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  Kodebrg  IN'+@isiList+ ' 

		  order by KodeCustSupp ') 

		 

		 else if @PPN=1

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(0)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  Kodebrg  IN'+@isiList+ ' 

		  order by KodeCustSupp ') 

		 

		 else if @PPN=2

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  Kodebrg  IN'+@isiList+ ' 

		  order by KodeCustSupp ') 


		 else

		  if @PPN=0

		  if @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(1,2)

		  order by KodeCustSupp ')

		  

		  else if @PPN=1

		  if @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(0)

		  order by KodeCustSupp ')

		  

		  else if @PPN=2

		  if @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  order by KodeCustSupp ')

		  

		  else

          if @PPN=0 

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(1,2)

		  and Kodebrg  IN'+@isiList+ ' 

		  order by KodeCustSupp')

		  

		  else if @PPN=1 

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(0)

		  and Kodebrg  IN'+@isiList+ ' 

		  order by KodeCustSupp')

		  

		  else if @PPN=2 

		  exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and Kodebrg  IN'+@isiList+ ' 

		  order by KodeCustSupp')


		else if @NeedOto=2

		if  @isKP =0

		if @PPN=0

		if @isiList ='' 

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(1,2)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'')   

		  order by KodeCustSupp')

		

		else if @PPN=1

		if @isiList ='' 

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(0)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'')   

		  order by KodeCustSupp')

		  

		else if @PPN=2

		if @isiList ='' 

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'')   

		  order by KodeCustSupp')

		

		else

		if @PPN=0

         exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPn in(1,2)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  KodeCustSupp  IN'+@isiList+ '  

		  order by KodeCustSupp') 

		  

		 else  if @PPN=1

         exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPn in(0)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  KodeCustSupp  IN'+@isiList+ '  

		  order by KodeCustSupp') 

		 

		 else  if @PPN=2

         exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  KodeCustSupp  IN'+@isiList+ '  

		  order by KodeCustSupp') 


		else if @isKP =1

		if @PPN=0

		 if @isiList ='' 

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(1,2)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'')   

		  order by KodeCustSupp')

		  

		 else if @PPN=1

		 if @isiList ='' 

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(0)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'')   

		  order by KodeCustSupp')

		 

		else if @PPN=2

		 if @isiList ='' 

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'')   

		  order by KodeCustSupp')

		    

		else

		 if @PPN=0

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(1,2)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  KodeCustSupp  IN'+@isiList+ '  

		  order by KodeCustSupp') 

		  

		  else if @PPN=1

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(0)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  KodeCustSupp  IN'+@isiList+ '  

		  order by KodeCustSupp') 

		  

		  else if @PPN=2

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  KodeCustSupp  IN'+@isiList+ '  

		  order by KodeCustSupp') 


		else

		if @PPN=0

		if @isiList ='' 

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		     and PPn in(1,2)

		     order by KodeCustSupp')

		  

		else if @PPN=1

		if @isiList ='' 

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		     and PPn in(0)

		     order by KodeCustSupp')

		 

		else if @PPN=2

		if @isiList ='' 

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		      order by KodeCustSupp')

		      

		else

		 if @PPN=0 

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPn in(1,2)

		  and  KodeCustSupp  IN'+@isiList+ '  

		  order by KodeCustSupp') 

		  

		  else if @PPN=1 

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPn in(0)

		  and  KodeCustSupp  IN'+@isiList+ '  

		  order by KodeCustSupp') 

		  

		  else if @PPN=2

		 exec('select ''Gabungan'' Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and  KodeCustSupp  IN'+@isiList+ '  

		  order by KodeCustSupp') 


else -------------------

If @Ordr='N'

	if @NeedOto=0 or @NeedOto=1

		if @isKP =0

		  if @PPN=0 

		  if @isiList=''

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and PPN in(1,2)

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by NoBukti,Tanggal')

		  else

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and PPN in(1,2) and  NoBukti  IN'+@isiList+ ' 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by NoBukti,Tanggal')

		  

		  else if @PPN=1 

		  if @isiList=''

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and PPN in(0)

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by NoBukti,Tanggal')

		  else

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  NoBukti  IN'+@isiList+ ' and PPN in(0)

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by NoBukti,Tanggal')

		  

		  else if @PPN=2 

		  if @isiList=''

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by NoBukti,Tanggal')

		  else

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  NoBukti  IN'+@isiList+ ' 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by NoBukti,Tanggal')


		 else if @isKP =1

		 if @PPN=0 

		 if  @isiList=''

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and PPN in(1,2)

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by NoBukti,Tanggal')

		 else

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  NoBukti  IN'+@isiList+ ' and PPN in(1,2)

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by NoBukti,Tanggal') 

		  

		  else if @PPN=1 

		  if  @isiList=''

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and PPN in(0)

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by NoBukti,Tanggal')

	     else

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  NoBukti  IN'+@isiList+ ' and PPN in(0)

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by NoBukti,Tanggal') 

		  

		  else if @PPN=2 

		  if  @isiList=''

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by NoBukti,Tanggal')

	     else

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  NoBukti  IN'+@isiList+ ' 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by NoBukti,Tanggal') 


		 else

		  if @PPN=0 

		  if @isiList=''

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(1,2) 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by NoBukti,Tanggal')

		  else

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(1,2) 

		  and NoBukti  IN'+@isiList+ ' 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by NoBukti,Tanggal')

		  

		  else if @PPN=1 

		  if @isiList=''

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(0) 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by NoBukti,Tanggal')

		  else

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(0) 

		  and NoBukti  IN'+@isiList+ ' 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by NoBukti,Tanggal')

		  

		  else if @PPN=2 

		  if @isiList=''

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by NoBukti,Tanggal')

		  else

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and NoBukti  IN'+@isiList+ ' 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by NoBukti,Tanggal')


		else if @NeedOto=2

		if  @isKP =0

		if @PPN=0 

		if @isiList ='' 

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(1,2)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'')   

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by NoBukti,Tanggal')

		else

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(1,2)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  NoBukti  IN'+@isiList+ '  

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by NoBukti,Tanggal') 

		 

		 else  if @PPN=1

		if @isiList ='' 

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(0)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'')   

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by NoBukti,Tanggal')

		else

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(0)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  NoBukti  IN'+@isiList+ '  

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by NoBukti,Tanggal') 

		 

		 else  if @PPN=2

		if @isiList ='' 

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'')   

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by NoBukti,Tanggal')

		else

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  NoBukti  IN'+@isiList+ '  

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by NoBukti,Tanggal') 


		else if @isKP =1

		If @ppn=0

		if @isiList ='' 

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(1,2)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'')   

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by NoBukti,Tanggal')

		else

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(1,2)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  NoBukti  IN'+@isiList+ '  

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by NoBukti,Tanggal') 

		  

		else If @ppn=1

		if @isiList ='' 

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(0)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'')   

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by NoBukti,Tanggal')

		else

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(0)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  NoBukti  IN'+@isiList+ '  

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by NoBukti,Tanggal') 

		  

		 else

		 If @ppn=2

		if @isiList ='' 

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'')   

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by NoBukti,Tanggal')

		else

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  NoBukti  IN'+@isiList+ '  

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by NoBukti,Tanggal') 


		else

		if @PPN=0 

		if @isiList ='' 

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		     and PPN in(1,2)

		     and '''+@ID+'''= Left(NoBukti,1)

		     order by NoBukti,Tanggal')

		 

		else if @PPN=1 

		if @isiList ='' 

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		     and PPN in(0)

		     and '''+@ID+'''= Left(NoBukti,1)

		     order by NoBukti,Tanggal')

		

		else if @PPN=2 

		if @isiList ='' 

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		      and '''+@ID+'''= Left(NoBukti,1)

		      order by NoBukti,Tanggal')

		    

		else

		 if @PPN=0 

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(1,2)

		  and  NoBukti  IN'+@isiList+ ' 

		  and '''+@ID+'''= Left(NoBukti,1) 

		  order by NoBukti,Tanggal') 

		  

		 else if @PPN=1 

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(0)

		  and  NoBukti  IN'+@isiList+ '  

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by NoBukti,Tanggal') 

		  

		  else if @PPN=2 

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and  NoBukti  IN'+@isiList+ ' 

		  and '''+@ID+'''= Left(NoBukti,1) 

		  order by NoBukti,Tanggal') 


else If @Ordr='B'

		if @NeedOto=0 or @NeedOto=1

		if @isKP =0

		  if @PPN=0

		  if @isiList=''

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(1,2)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'')  

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by Kodebrg')

		  

		  else if @PPN=1

		  if @isiList=''

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(0)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'')  

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by Kodebrg')

		  

		  else if @PPN=2

		  if @isiList=''

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'')  

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by Kodebrg')

		  

		  else

		  if @PPN=0 

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in (1,2)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  Kodebrg  IN'+@isiList+ ' 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by Kodebrg')

		  

		  else  if @PPN=1 

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in (0)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  Kodebrg  IN'+@isiList+ ' 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by Kodebrg')

		  

		  else  if @PPN=2 

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  Kodebrg  IN'+@isiList+ ' 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by Kodebrg')


		 else if @isKP =1

		 if @PPN=0

		 if  @isiList=''

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(1,2)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by Kodebrg')

		  

		 else if @PPN=1

		 if  @isiList=''

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(0)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by Kodebrg')

		  

		 else if @PPN=2

		 if  @isiList=''

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by Kodebrg')

		  

		 else

		 if @PPN=0

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(1,2)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  Kodebrg  IN'+@isiList+ ' 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by Kodebrg ') 

		  

		 else  if @PPN=1

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(0)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  Kodebrg  IN'+@isiList+ ' 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by Kodebrg ') 

		 

		 else  if @PPN=2

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  Kodebrg  IN'+@isiList+ ' 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by Kodebrg ') 


		 else

		  if @PPN=0

		  if @isiList=''

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(1,2)

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by Kodebrg ')

		  

		  else  if @PPN=1

		  if @isiList=''

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(0)

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by Kodebrg ')

		  

		  else  if @PPN=2

		  if @isiList=''

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by Kodebrg ')

		  

		  else

		  if @PPN=0

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in (1,2)

		  and Kodebrg  IN'+@isiList+ ' 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by Kodebrg')

		  

		  else if @PPN=1

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in (0)

		  and Kodebrg  IN'+@isiList+ ' 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by Kodebrg')

		  

		  else if @PPN=2

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and Kodebrg  IN'+@isiList+ ' 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by Kodebrg')


		else if @NeedOto=2

		if  @isKP =0

		if @PPN=0 

		if @isiList ='' 

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'')   

		  and PPN in(1,2)

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by Kodebrg')

		

		else if @PPN=1 

		if @isiList ='' 

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'')   

		  and PPN in(0)

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by Kodebrg')

		 

		else if @PPN=2 

		if @isiList ='' 

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'')  

		  and '''+@ID+'''= Left(NoBukti,1) 

		  order by Kodebrg')

		     

		else

		if @PPN=0

		exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  Kodebrg  IN'+@isiList+ '  

		  and PPN in(1,2)

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by Kodebrg') 

		

		else if @PPN=1

		exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  Kodebrg  IN'+@isiList+ '  

		  and PPN in(0)

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by Kodebrg') 

		

		else if @PPN=2

		exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  Kodebrg  IN'+@isiList+ '  

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by Kodebrg') 


		else if @isKP =1

		if @PPN=0 

		if @isiList ='' 

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(1,2)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'')   

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by Kodebrg')

		 if @PPN=1 

		if @isiList ='' 

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(0)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'')   

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by Kodebrg')

		 

		else if @PPN=2 

		if @isiList ='' 

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'')  

		  and '''+@ID+'''= Left(NoBukti,1) 

		  order by Kodebrg')

		 

		else

		 if @PPN=0

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(1,2)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  Kodebrg  IN'+@isiList+ '  

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by Kodebrg') 

		 

		 else if @PPN=1

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(0)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  Kodebrg  IN'+@isiList+ '  

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by Kodebrg') 

		 

		 else if @PPN=2

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  Kodebrg  IN'+@isiList+ '  

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by Kodebrg') 


		else

		if @PPN=0

		if @isiList ='''' 

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		     and PPN in(1,2)

		     and '''+@ID+'''= Left(NoBukti,1)

		     order by Kodebrg')

		

		else if @PPN=1

		if @isiList ='''' 

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		     and PPN in(0)

		     and '''+@ID+'''= Left(NoBukti,1)

		     order by Kodebrg')

		

        else if @PPN=2

		if @isiList ='''' 

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		       and '''+@ID+'''= Left(NoBukti,1)

		       order by Kodebrg')

		

		else

		 if @PPN=0 

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(1,2)

		  and  Kodebrg  IN'+@isiList+ '

		  and '''+@ID+'''= Left(NoBukti,1)  

		  order by Kodebrg') 

		 

		 else  if @PPN=1 

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(0)

		  and  Kodebrg  IN'+@isiList+ '  

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by Kodebrg') 

		   

		 else  if @PPN=2 

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and  Kodebrg  IN'+@isiList+ '  

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by Kodebrg') 


else If @Ordr='C'

		if @NeedOto=0 or @NeedOto=1

		if @isKP =0

		  if @PPN=0 

		  if @isiList=''

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(1,2)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'')  

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp')

		  

		  else if @PPN=1 

		  if @isiList=''

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(0)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'')  

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp')

		  

		  else if @PPN=2 

		  if @isiList=''

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'')  

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp')

		  

		  else

		  if @PPN=0 

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(1,2)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  KodeCustSupp  IN'+@isiList+ ' 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp')

		  

		  else if @PPN=1

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(0)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  KodeCustSupp  IN'+@isiList+ ' 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp')

		  

		  else if @PPN=2 

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  KodeCustSupp  IN'+@isiList+ ' 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp')


		 else if @isKP =1

		 if @PPN=0

		 if  @isiList=''

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(1,2)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp')

		 

		 else if @PPN=1

		 if  @isiList=''

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(0)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp')

		 

		 else if @PPN=2

		 if  @isiList=''

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp')

		 

		 else

		 if @PPN=0

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(1,2)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  KodeCustSupp  IN'+@isiList+ ' 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp ') 

		  

		 else if @PPN=1

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(0)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  KodeCustSupp  IN'+@isiList+ ' 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp ') 

		 

		 else if @PPN=2

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  KodeCustSupp  IN'+@isiList+ ' 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp ') 


		 else

		  if @PPN=0

		  if @isiList=''

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(1,2)

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp ')

		  

		  else if @PPN=1

		  if @isiList=''

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(0)

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp ')

		  

		  else if @PPN=2

		  if @isiList=''

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp ')

		  

		  else

		   if @PPN=0

            exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		   and PPN in(1,2)

		   and KodeCustSupp  IN'+@isiList+ ' 

		   and '''+@ID+'''= Left(NoBukti,1)

		   order by KodeCustSupp')

		   

		   else  if @PPN=1

            exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		   and PPN in(0)

		   and KodeCustSupp  IN'+@isiList+ ' 

		   and '''+@ID+'''= Left(NoBukti,1)

		   order by KodeCustSupp')

		   

		   else  if @PPN=2

            exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		   and KodeCustSupp  IN'+@isiList+ ' 

		   and '''+@ID+'''= Left(NoBukti,1)

		   order by KodeCustSupp')


		else if @NeedOto=2

		if  @isKP =0

		If @PPN=0

		if @isiList ='' 

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in (1,2)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'')   

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp')

		 

		else If @PPN=1

		if @isiList ='' 

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in (0)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'')  

		  and '''+@ID+'''= Left(NoBukti,1) 

		  order by KodeCustSupp')

		   

		else If @PPN=2

		if @isiList ='' 

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'')   

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp')

		 else

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'')   

		  and  KodeCustSupp  IN'+@isiList+ '

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp') 

		  

		else

		if @PPN=0

		exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPn in(1,2)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  KodeCustSupp  IN'+@isiList+ '  

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp')

		  

		else if @PPN=1

		exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPn in(0)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  KodeCustSupp  IN'+@isiList+ ' 

		  and '''+@ID+'''= Left(NoBukti,1) 

		  order by KodeCustSupp')

		

		else if @PPN=2

		if @isiList='' 

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  KodeCustSupp  IN'+@isiList+ '  

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp')

		else

		   exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  KodeCustSupp  IN'+@isiList+ '  

		   and  KodeCustSupp  IN'+@isiList+ '

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp')


		else if @isKP =1

		if @PPN=0

		if @isiList ='' 

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPn in(1,2)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'')   

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp')

		  

		else if @PPN=1

		if @isiList ='' 

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPn in(0)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'')   

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp')

		

		else if @PPN=2

		if @isiList ='' 

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'')   

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp')

		else

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'')   

		    and  KodeCustSupp  IN'+@isiList+ '

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp')  

		    

		else

		if @PPN=0

		exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(1,2)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  KodeCustSupp  IN'+@isiList+ '  

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp') 

		  

		else if @PPN=1

		exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(0)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  KodeCustSupp  IN'+@isiList+ '  

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp') 

		

		else if @PPN=2

		if @isiList=''

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  KodeCustSupp  IN'+@isiList+ '  

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp') 

		else

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  KodeCustSupp  IN'+@isiList+ '  

		   and  KodeCustSupp  IN'+@isiList+ '

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp')  


		else

		if @PPN=0

		if @isiList ='' 

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		     and PPN in(1,2)

		     and '''+@ID+'''= Left(NoBukti,1)

		     order by KodeCustSupp')

		  

		else if @PPN=1

		if @isiList ='' 

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		     and PPN in(0)

		     and '''+@ID+'''= Left(NoBukti,1)

		     order by KodeCustSupp')

		

		else if @PPN=2

		if @isiList ='' 

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		       and '''+@ID+'''= Left(NoBukti,1)

		       order by KodeCustSupp')

		else

		

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		       and '''+@ID+'''= Left(NoBukti,1)

		          and  KodeCustSupp  IN'+@isiList+ '

		       order by KodeCustSupp')       

		             

		else

		if @PPN=0 

		exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(1,2)

		  and  Kodebrg  IN'+@isiList+ ' 

		  and '''+@ID+'''= Left(NoBukti,1) 

		  order by KodeCustSupp') 

		

		else if @PPN=1 

		exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(0)

		  and  Kodebrg  IN'+@isiList+ '  

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp') 

		 

		else if @PPN=2 

		exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and  Kodebrg  IN'+@isiList+ ' 

		  and '''+@ID+'''= Left(NoBukti,1) 

		  order by KodeCustSupp') 


else If @Ordr='S'

		if @NeedOto=0 or @NeedOto=1

		if @isKP =0

		  if @PPN=0

		  if @isiList=''

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPn in(1,2)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'')  

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp')

		  

		  else  if @PPN=1

		  if @isiList=''

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPn in(0)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'')  

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp')

		  

		  else  if @PPN=2

		  if @isiList=''

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'')  

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp')

		  

		  else

		  if @PPN =0

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(1,2)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  Kodebrg  IN'+@isiList+ ' 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp')

		  

		  else if @PPN =1

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(0)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  Kodebrg  IN'+@isiList+ ' 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp')

		  

		  else if @PPN =2

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  Kodebrg  IN'+@isiList+ ' 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp')


		 else if @isKP =1

		 if @PPN=0

		 if  @isiList=''

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(1,2)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp')

		  

		  else if @PPN=1

		 if  @isiList=''

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(0)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp')

		  

		 else if @PPN=2

		 if  @isiList=''

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp')

		   

		 else

		 if @PPN=0

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(1,2)

		  and '''+@ID+'''= Left(NoBukti,1)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  Kodebrg  IN'+@isiList+ ' 

		  order by KodeCustSupp ') 

		 

		 else if @PPN=1

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(0)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  Kodebrg  IN'+@isiList+ ' 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp ') 

		 

		 else if @PPN=2

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  Kodebrg  IN'+@isiList+ ' 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp ') 


		 else

		  if @PPN=0

		  if @isiList=''

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(1,2)

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp ')

		  

		  else if @PPN=1

		  if @isiList=''

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(0)

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp ')

		  

		  else if @PPN=2

		  if @isiList=''

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp ')

		  

		  else

          if @PPN=0 

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(1,2)

		  and Kodebrg  IN'+@isiList+ ' 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp')

		  

		  else if @PPN=1 

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and PPN in(0)

		  and Kodebrg  IN'+@isiList+ '

		  and '''+@ID+'''= Left(NoBukti,1) 

		  order by KodeCustSupp')

		  

		  else if @PPN=2 

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and Kodebrg  IN'+@isiList+ ' 

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp')


		else if @NeedOto=2

		if  @isKP =0

		if @PPN=0

		if @isiList ='' 

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(1,2)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'')   

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp')

		

		else if @PPN=1

		if @isiList ='' 

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(0)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'')   

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp')

		  

		else if @PPN=2

		if @isiList ='' 

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'')   

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp')

		

		else

		if @PPN=0

         exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPn in(1,2)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  KodeCustSupp  IN'+@isiList+ '  

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp') 

		  

		 else  if @PPN=1

         exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPn in(0)

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  KodeCustSupp  IN'+@isiList+ '  

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp') 

		 

		 else  if @PPN=2

         exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and ( NoSPB Not Like ''%SJB%'' and NoSPB not like ''%SPBB%'' and Namabrg not like ''%Jasa%'') and  KodeCustSupp  IN'+@isiList+ '  

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp') 


		else if @isKP =1

		if @PPN=0

		 if @isiList ='' 

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(1,2)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'')   

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp')

		  

		 else if @PPN=1

		 if @isiList ='' 

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(0)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'')   

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp')

		 

		else if @PPN=2

		 if @isiList ='' 

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'')   

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp')

		    

		else

		 if @PPN=0

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(1,2)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  KodeCustSupp  IN'+@isiList+ '  

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp') 

		  

		  else if @PPN=1

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPN in(0)

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  KodeCustSupp  IN'+@isiList+ '  

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp') 

		  

		  else if @PPN=2

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and ( NoSPB Like ''%SJB%'' or NoSPB like ''%SPBB%'' or Namabrg like ''%Jasa%'') and  KodeCustSupp  IN'+@isiList+ '  

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp') 


		else

		if @PPN=0

		if @isiList ='' 

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		     and PPn in(1,2)

		     and '''+@ID+'''= Left(NoBukti,1)

		     order by KodeCustSupp')

		  

		else if @PPN=1

		if @isiList ='' 

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		     and PPn in(0)

		     and '''+@ID+'''= Left(NoBukti,1)

		     order by KodeCustSupp')

		 

		else if @PPN=2

		if @isiList ='' 

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		      and '''+@ID+'''= Left(NoBukti,1)

		      order by KodeCustSupp')

		      

		else

		 if @PPN=0 

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPn in(1,2)

		  and  KodeCustSupp  IN'+@isiList+ '  

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp') 

		  

		  else if @PPN=1 

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and PPn in(0)

		  and  KodeCustSupp  IN'+@isiList+ '  

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp') 

		  

		  else if @PPN=2

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and  KodeCustSupp  IN'+@isiList+ '  

		  and '''+@ID+'''= Left(NoBukti,1)

		  order by KodeCustSupp');

-- Sp_ReportInvoicePenjualanDetold
CREATE PROCEDURE IF NOT EXISTS Sp_ReportInvoicePenjualanDetold AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 


If @Ordr='N'

	if @NeedOto=0 or @NeedOto=1

		if @isKP =0

		  if @isiList=''

		  exec('select * from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and Noso<>''''  

		  order by NoBukti,Tanggal')

		  else

		  exec('select * from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and Noso<>'''' and  NoBukti  IN'+@isiList+ ' 

		  order by NoBukti,Tanggal')

		  

		 else if @isKP =1

		 if  @isiList=''

		  exec('select * from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and Noso='''' 

		  order by NoBukti,Tanggal')

		 else

		  exec('select * from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and Noso='''' and  NoBukti  IN'+@isiList+ ' 

		  order by NoBukti,Tanggal') 

		  

		 else

		  if @isiList=''

		  exec('select * from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  order by NoBukti,Tanggal')

		  else

		  exec('select * from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and NoBukti  IN'+@isiList+ ' 

		  order by NoBukti,Tanggal')


		else if @NeedOto=2

		if  @isKP =0

		if @isiList ='' 

		 exec('select * from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and Noso<>''''   

		  order by NoBukti,Tanggal')

		else

		 exec('select * from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and Noso<>'''' and  NoBukti  IN'+@isiList+ '  

		  order by NoBukti,Tanggal') 

		

		else if @isKP =1

		if @isiList ='' 

		 exec('select * from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and Noso=''''   

		  order by NoBukti,Tanggal')

		else

		 exec('select * from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and Noso='''' and  NoBukti  IN'+@isiList+ '  

		  order by NoBukti,Tanggal') 

		

		else

		if @isiList ='' 

		 exec('select * from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		     order by NoBukti,Tanggal')

		else

		 exec('select * from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and  NoBukti  IN'+@isiList+ '  

		  order by NoBukti,Tanggal') 


else If @Ordr='B'

		if @NeedOto=0 or @NeedOto=1

		if @isKP =0

		  if @isiList=''

		  exec('select * from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and Noso<>''''  

		  order by Kodebrg')

		  else

		  exec('select * from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and Noso<>'''' and  Kodebrg  IN'+@isiList+ ' 

		  order by Kodebrg')

		  

		 else if @isKP =1

		 if  @isiList=''

		  exec('select * from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and Noso='''' 

		  order by Kodebrg')

		 else

		  exec('select * from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and Noso='''' and  Kodebrg  IN'+@isiList+ ' 

		  order by Kodebrg ') 

		  

		 else

		  if @isiList=''

		  exec('select * from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  order by Kodebrg ')

		  else

		  exec('select * from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and Kodebrg  IN'+@isiList+ ' 

		  order by Kodebrg')


		else if @NeedOto=2

		if  @isKP =0

		if @isiList ='' 

		 exec('select * from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and Noso<>''''   

		  order by Kodebrg')

		else

		 exec('select * from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and Noso<>'''' and  Kodebrg  IN'+@isiList+ '  

		  order by Kodebrg') 

		

		else if @isKP =1

		if @isiList ='' 

		 exec('select * from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and Noso=''''   

		  order by Kodebrg')

		else

		 exec('select * from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and Noso='''' and  Kodebrg  IN'+@isiList+ '  

		  order by Kodebrg') 

		

		else

		if @isiList ='''' 

		 exec('select * from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		     order by Kodebrg')

		else

		 exec('select * from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and  Kodebrg  IN'+@isiList+ '  

		  order by Kodebrg') 


else If @Ordr='C'

		if @NeedOto=0 or @NeedOto=1

		if @isKP =0

		  if @isiList=''

		  exec('select * from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and Noso<>''''  

		  order by KodeCustSupp')

		  else

		  exec('select * from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and Noso<>'''' and  KodeCustSupp  IN'+@isiList+ ' 

		  order by KodeCustSupp')

		  

		 else if @isKP =1

		 if  @isiList=''

		  exec('select * from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and Noso='''' 

		  order by KodeCustSupp')

		 else

		  exec('select * from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and Noso='''' and  KodeCustSupp  IN'+@isiList+ ' 

		  order by KodeCustSupp ') 

		  

		 else

		  if @isiList=''

		  exec('select * from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  order by KodeCustSupp ')

		  else

		  exec('select * from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and KodeCustSupp  IN'+@isiList+ ' 

		  order by KodeCustSupp')


		else if @NeedOto=2

		if  @isKP =0

		if @isiList ='' 

		 exec('select * from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and Noso<>''''   

		  order by KodeCustSupp')

		else

		 exec('select * from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and Noso<>'''' and  KodeCustSupp  IN'+@isiList+ '  

		  order by KodeCustSupp') 

		

		else if @isKP =1

		if @isiList ='' 

		 exec('select * from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and Noso=''''   

		  order by KodeCustSupp')

		else

		 exec('select * from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and Noso='''' and  KodeCustSupp  IN'+@isiList+ '  

		  order by KodeCustSupp') 

		

		else

		if @isiList ='' 

		 exec('select * from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		     order by KodeCustSupp')

		else

		 exec('select * from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and  Kodebrg  IN'+@isiList+ '  

		  order by KodeCustSupp') 


else If @Ordr='S'

		if @NeedOto=0 or @NeedOto=1

		if @isKP =0

		  if @isiList=''

		  exec('select * from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and Noso<>''''  

		  order by KodeCustSupp')

		  else

		  exec('select * from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and Noso<>'''' and  Kodebrg  IN'+@isiList+ ' 

		  order by KodeCustSupp')

		  

		 else if @isKP =1

		 if  @isiList=''

		  exec('select * from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and Noso='''' 

		  order by KodeCustSupp')

		 else

		  exec('select * from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and Noso='''' and  Kodebrg  IN'+@isiList+ ' 

		  order by KodeCustSupp ') 

		  

		 else

		  if @isiList=''

		  exec('select * from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  order by KodeCustSupp ')

		  else

		  exec('select * from VwreportinvoicePenjualan where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') and NeedOtorisasi='+@NeedOto+' 

		  and Kodebrg  IN'+@isiList+ ' 

		  order by KodeCustSupp')


		else if @NeedOto=2

		if  @isKP =0

		if @isiList ='' 

		 exec('select * from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and Noso<>''''   

		  order by KodeCustSupp')

		else

		 exec('select * from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and Noso<>'''' and  KodeCustSupp  IN'+@isiList+ '  

		  order by KodeCustSupp') 

		

		else if @isKP =1

		if @isiList ='' 

		 exec('select * from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and Noso=''''   

		  order by KodeCustSupp')

		else

		 exec('select * from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and Noso='''' and  KodeCustSupp  IN'+@isiList+ '  

		  order by KodeCustSupp') 

		

		else

		if @isiList ='' 

		 exec('select * from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		     order by KodeCustSupp')

		else

		 exec('select * from VwreportinvoicePenjualan where  (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and  KodeCustSupp  IN'+@isiList+ '  

		  order by KodeCustSupp');

-- Sp_ReportInvoicePenjualanRek
CREATE PROCEDURE IF NOT EXISTS Sp_ReportInvoicePenjualanRek AS ---- DECLARE REMOVED,@Tgl1 DateTime,@Tgl2 Datetime

--Select @Choice='B',@Tgl1='01/01/2011',@Tgl2='01/01/2013'

select @Id=SUBSTRING(@Id,1,1)

if @Id='' 

If @Choice='N'

if @NeedOto=0 or @NeedOto=1

 if @PPN=0 

   select 	'Gabungan' Perusahaan,B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(E.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti               

		left outer join dbSPB X on B.NoSPB = X.NoBukti

		left outer join dbSPP y on y.NoBukti=x.NoSPP

		left outer join DBSO z on z.NOBUKTI=y.NoSHIP

		Left Outer Join dbo.vwBrowsCust E on E.KODECUSTSUPP=A.KodeCustSupp		

		left outer join dbKaryawan p on p.KeyNIK=z.KODESLS

		where A.Tanggal between @Tgl1 and @Tgl2 and       

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER)= @Needoto

		and B.PPN in(1,2)

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		rpInv.TotNet,SO.PPHDPP

		Order by B.NoBukti

	

	else  if @PPN=1 

   select 	'Gabungan' Perusahaan,B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(E.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti               

		left outer join dbSPB X on B.NoSPB = X.NoBukti

		left outer join dbSPP y on y.NoBukti=x.NoSPP

		left outer join DBSO z on z.NOBUKTI=y.NoSHIP

		Left Outer Join dbo.vwBrowsCust E on E.KODECUSTSUPP=A.KodeCustSupp		

		left outer join dbKaryawan p on p.KeyNIK=z.KODESLS

		where A.Tanggal between @Tgl1 and @Tgl2 and       

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER)= @Needoto

		and B.PPN in(0)

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		rpInv.TotNet,SO.PPHDPP

		Order by B.NoBukti

	

	else if @PPN=2 

   select 	'Gabungan' Perusahaan,B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(E.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti               

		left outer join dbSPB X on B.NoSPB = X.NoBukti

		left outer join dbSPP y on y.NoBukti=x.NoSPP

		left outer join DBSO z on z.NOBUKTI=y.NoSHIP

		Left Outer Join dbo.vwBrowsCust E on E.KODECUSTSUPP=A.KodeCustSupp		

		left outer join dbKaryawan p on p.KeyNIK=z.KODESLS

		where A.Tanggal between @Tgl1 and @Tgl2 and       

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER)= @Needoto

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		rpInv.TotNet,SO.PPHDPP

		Order by B.NoBukti


	else if @NeedOto=2

	 if @PPN=0 

	  select 	'Gabungan' Perusahaan,B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti 

		left outer join dbSPB X on B.NoSPB = X.NoBukti

		left outer join dbSPP y on y.NoBukti=x.NoSPP

		left outer join DBSO z on z.NOBUKTI=y.NoSHIP

		left outer join dbKaryawan p on p.KeyNIK=z.KODESLS

		where A.Tanggal between @Tgl1 and @Tgl2 

		and b.PPN in(1,2)

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas

		Order by B.NoBukti

	  

	 else if @PPN=1 

	  select 	'Gabungan' Perusahaan,B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti 

		left outer join dbSPB X on B.NoSPB = X.NoBukti

		left outer join dbSPP y on y.NoBukti=x.NoSPP

		left outer join DBSO z on z.NOBUKTI=y.NoSHIP

		left outer join dbKaryawan p on p.KeyNIK=z.KODESLS

		where A.Tanggal between @Tgl1 and @Tgl2 

		and b.PPN in(0)

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas

		Order by B.NoBukti


	 else if @PPN=2 

	  select 	'Gabungan' Perusahaan,B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti 

		left outer join dbSPB X on B.NoSPB = X.NoBukti

		left outer join dbSPP y on y.NoBukti=x.NoSPP

		left outer join DBSO z on z.NOBUKTI=y.NoSHIP

		left outer join dbKaryawan p on p.KeyNIK=z.KODESLS

		where A.Tanggal between @Tgl1 and @Tgl2 

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas

		Order by B.NoBukti


Else If @Choice='B'

if @NeedOto=0 or @NeedOto=1

	 if @PPN=0

	   select 	'Gabungan' Perusahaan,B.KodeBrg,C.NAMABRG,b.SAT_1,b.SAT_2,

		SUM(b.qnt) QNT,SUM(b.qnt2)QNT2,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP		

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti 

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		where A.Tanggal between @Tgl1 and @Tgl2 and       

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER)= @Needoto

	    and b.PPN in(1,2)

		Group By B.KodeBrg,C.NAMABRG,b.SAT_1,b.SAT_2

		order By B.KodeBrg

	   

	else if   @PPN=1

	    select 	'Gabungan' Perusahaan,B.KodeBrg,C.NAMABRG,b.SAT_1,b.SAT_2,

		SUM(b.qnt) QNT,SUM(b.qnt2)QNT2,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP		

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti 

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		where A.Tanggal between @Tgl1 and @Tgl2 and       

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER)= @Needoto

		and b.PPN in(0)

		Group By B.KodeBrg,C.NAMABRG,b.SAT_1,b.SAT_2

		order By B.KodeBrg

			

	else if @PPN=2

	 select 	'Gabungan' Perusahaan,B.KodeBrg,C.NAMABRG,b.SAT_1,b.SAT_2,

		SUM(b.qnt) QNT,SUM(b.qnt2)QNT2,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP		

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti 

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		where A.Tanggal between @Tgl1 and @Tgl2 and       

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER)= @Needoto

		Group By B.KodeBrg,C.NAMABRG,b.SAT_1,b.SAT_2

		order By B.KodeBrg


else if @NeedOto=2

	 if @PPN=0 

	  select 	'Gabungan' Perusahaan,B.KodeBrg,C.NAMABRG,b.SAT_1,b.SAT_2,

		SUM(b.qnt) QNT,SUM(b.qnt2)QNT2,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP		

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti 

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		where A.Tanggal between @Tgl1 and @Tgl2 

		and b.PPN in(1,2)

		Group By B.KodeBrg,C.NAMABRG,b.SAT_1,b.SAT_2

		order By B.KodeBrg

	  

	else  if @PPN=1 

	  select 	'Gabungan' Perusahaan,B.KodeBrg,C.NAMABRG,b.SAT_1,b.SAT_2,

		SUM(b.qnt) QNT,SUM(b.qnt2)QNT2,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP		

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti 

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		where A.Tanggal between @Tgl1 and @Tgl2 

		and b.PPN in(0)

		Group By B.KodeBrg,C.NAMABRG,b.SAT_1,b.SAT_2

		order By B.KodeBrg

	  	

 else  if @PPN=2 

	  select 'Gabungan' Perusahaan,	B.KodeBrg,C.NAMABRG,b.SAT_1,b.SAT_2,

		SUM(b.qnt) QNT,SUM(b.qnt2)QNT2,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP		

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti 

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		where A.Tanggal between @Tgl1 and @Tgl2 

		Group By B.KodeBrg,C.NAMABRG,b.SAT_1,b.SAT_2

		order By B.KodeBrg


Else If @Choice='C'

if @NeedOto=0 or @NeedOto=1

	if @PPN=0

	   select 	'Gabungan' Perusahaan,B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti 

		left outer join dbSPB X on B.NoSPB = X.NoBukti

		left outer join dbSPP y on y.NoBukti=x.NoSPP

		left outer join DBSO z on z.NOBUKTI=y.NoSHIP

		left outer join dbKaryawan p on p.KeyNIK=z.KODESLS

		where A.Tanggal between @Tgl1 and @Tgl2 and       

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER)= @Needoto

		and b.PPN in(1,2)

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas

		order By D.NAMACUSTSUPP,A.Tanggal

	   

	 else if @PPN=1

	   select 'Gabungan' Perusahaan,	B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti 

		left outer join dbSPB X on B.NoSPB = X.NoBukti

		left outer join dbSPP y on y.NoBukti=x.NoSPP

		left outer join DBSO z on z.NOBUKTI=y.NoSHIP

		left outer join dbKaryawan p on p.KeyNIK=z.KODESLS

		where A.Tanggal between @Tgl1 and @Tgl2 and       

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER)= @Needoto

		and b.PPN in(0)

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas

		order By D.NAMACUSTSUPP,A.Tanggal

	   

	 else if @PPN=2

	   select 	'Gabungan' Perusahaan,B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti 

		left outer join dbSPB X on B.NoSPB = X.NoBukti

		left outer join dbSPP y on y.NoBukti=x.NoSPP

		left outer join DBSO z on z.NOBUKTI=y.NoSHIP

		left outer join dbKaryawan p on p.KeyNIK=z.KODESLS

		where A.Tanggal between @Tgl1 and @Tgl2 and       

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER)= @Needoto

		

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas

		order By D.NAMACUSTSUPP,A.Tanggal


	else if @NeedOto=2

	 if @PPN=0

	  select 'Gabungan' Perusahaan,	B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti 

		left outer join dbSPB X on B.NoSPB = X.NoBukti

		left outer join dbSPP y on y.NoBukti=x.NoSPP

		left outer join DBSO z on z.NOBUKTI=y.NoSHIP

		left outer join dbKaryawan p on p.KeyNIK=z.KODESLS

		where A.Tanggal between @Tgl1 and @Tgl2 

		and b.PPN in(1,2)

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas

		order By D.NAMACUSTSUPP,A.Tanggal

	  

     else if @PPN=1

	  select 'Gabungan' Perusahaan,	B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti 

		left outer join dbSPB X on B.NoSPB = X.NoBukti

		left outer join dbSPP y on y.NoBukti=x.NoSPP

		left outer join DBSO z on z.NOBUKTI=y.NoSHIP

		left outer join dbKaryawan p on p.KeyNIK=z.KODESLS

		where A.Tanggal between @Tgl1 and @Tgl2 

		and b.PPN in(0)

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas

		order By D.NAMACUSTSUPP,A.Tanggal

	   

     else if @PPN=2

	  select 'Gabungan' Perusahaan,	B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti 

		left outer join dbSPB X on B.NoSPB = X.NoBukti

		left outer join dbSPP y on y.NoBukti=x.NoSPP

		left outer join DBSO z on z.NOBUKTI=y.NoSHIP

		left outer join dbKaryawan p on p.KeyNIK=z.KODESLS

		where A.Tanggal between @Tgl1 and @Tgl2 

		

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas

		order By D.NAMACUSTSUPP,A.Tanggal


Else If @Choice='S'

if @NeedOto=0 or @NeedOto=1

	 if @PPN=0

	   select 'Gabungan' Perusahaan,	B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti 

		left outer join dbSPB X on B.NoSPB = X.NoBukti

		left outer join dbSPP y on y.NoBukti=x.NoSPP

		left outer join DBSO z on z.NOBUKTI=y.NoSHIP

		left outer join dbKaryawan p on p.KeyNIK=z.KODESLS

		where A.Tanggal between @Tgl1 and @Tgl2 and       

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER)= @Needoto

		and b.PPN in (1,2)

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas

		order By p.Nama,d.NAMACUSTSUPP,b.NoBukti

	   

	 else if @PPN=1

	   select 	'Gabungan' Perusahaan,B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti 

		left outer join dbSPB X on B.NoSPB = X.NoBukti

		left outer join dbSPP y on y.NoBukti=x.NoSPP

		left outer join DBSO z on z.NOBUKTI=y.NoSHIP

		left outer join dbKaryawan p on p.KeyNIK=z.KODESLS

		where A.Tanggal between @Tgl1 and @Tgl2 and       

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER)= @Needoto

		and b.PPN in (0)

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas

		order By p.Nama,d.NAMACUSTSUPP,b.NoBukti

	   

	 else if @PPN=2

	   select 	'Gabungan' Perusahaan,B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti 

		left outer join dbSPB X on B.NoSPB = X.NoBukti

		left outer join dbSPP y on y.NoBukti=x.NoSPP

		left outer join DBSO z on z.NOBUKTI=y.NoSHIP

		left outer join dbKaryawan p on p.KeyNIK=z.KODESLS

		where A.Tanggal between @Tgl1 and @Tgl2 and       

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER)= @Needoto

	

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas

		order By p.Nama,d.NAMACUSTSUPP,b.NoBukti


else if @NeedOto=2

   if @PPN=0

     select 	'Gabungan' Perusahaan,B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti 

		left outer join dbSPB X on B.NoSPB = X.NoBukti

		left outer join dbSPP y on y.NoBukti=x.NoSPP

		left outer join DBSO z on z.NOBUKTI=y.NoSHIP

		left outer join dbKaryawan p on p.KeyNIK=z.KODESLS

		where A.Tanggal between @Tgl1 and @Tgl2

		and b.PPN in(1,2)

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas

		order By p.Nama,d.NAMACUSTSUPP,b.NoBukti

	 	

   else if @PPN=1

     select 	'Gabungan' Perusahaan,B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti 

		left outer join dbSPB X on B.NoSPB = X.NoBukti

		left outer join dbSPP y on y.NoBukti=x.NoSPP

		left outer join DBSO z on z.NOBUKTI=y.NoSHIP

		left outer join dbKaryawan p on p.KeyNIK=z.KODESLS

		where A.Tanggal between @Tgl1 and @Tgl2

		and b.PPN in(0)

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas

		order By p.Nama,d.NAMACUSTSUPP,b.NoBukti

	 	

   else if @PPN=2

     select 'Gabungan' Perusahaan,	B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti 

		left outer join dbSPB X on B.NoSPB = X.NoBukti

		left outer join dbSPP y on y.NoBukti=x.NoSPP

		left outer join DBSO z on z.NOBUKTI=y.NoSHIP

		left outer join dbKaryawan p on p.KeyNIK=z.KODESLS

		where A.Tanggal between @Tgl1 and @Tgl2

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas

		order By p.Nama,d.NAMACUSTSUPP,b.NoBukti


 else

 If @Choice='N'

if @NeedOto=0 or @NeedOto=1

 if @PPN=0 

   select 	Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(E.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti               

		left outer join dbSPB X on B.NoSPB = X.NoBukti

		left outer join dbSPP y on y.NoBukti=x.NoSPP

		left outer join DBSO z on z.NOBUKTI=y.NoSHIP

		Left Outer Join dbo.vwBrowsCust E on E.KODECUSTSUPP=A.KodeCustSupp		

		left outer join dbKaryawan p on p.KeyNIK=z.KODESLS

		where A.Tanggal between @Tgl1 and @Tgl2 and       

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER)= @Needoto

		and B.PPN in(1,2)

		and  @Id= Left(B.NoBukti,1)

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		rpInv.TotNet,SO.PPHDPP

		Order by B.NoBukti

	

	else  if @PPN=1 

   select 	Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(E.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti               

		left outer join dbSPB X on B.NoSPB = X.NoBukti

		left outer join dbSPP y on y.NoBukti=x.NoSPP

		left outer join DBSO z on z.NOBUKTI=y.NoSHIP

		Left Outer Join dbo.vwBrowsCust E on E.KODECUSTSUPP=A.KodeCustSupp		

		left outer join dbKaryawan p on p.KeyNIK=z.KODESLS

		where A.Tanggal between @Tgl1 and @Tgl2 and       

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER)= @Needoto

		and B.PPN in(0)

		and  @Id= Left(B.NoBukti,1)

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		rpInv.TotNet,SO.PPHDPP

		Order by B.NoBukti

	

	else if @PPN=2 

   select 	Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(E.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti               

		left outer join dbSPB X on B.NoSPB = X.NoBukti

		left outer join dbSPP y on y.NoBukti=x.NoSPP

		left outer join DBSO z on z.NOBUKTI=y.NoSHIP

		Left Outer Join dbo.vwBrowsCust E on E.KODECUSTSUPP=A.KodeCustSupp		

		left outer join dbKaryawan p on p.KeyNIK=z.KODESLS

		where A.Tanggal between @Tgl1 and @Tgl2 and       

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER)= @Needoto

		and  @Id= Left(B.NoBukti,1)

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		rpInv.TotNet,SO.PPHDPP

		Order by B.NoBukti


	else if @NeedOto=2

	 if @PPN=0 

	  select 	Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti 

		left outer join dbSPB X on B.NoSPB = X.NoBukti

		left outer join dbSPP y on y.NoBukti=x.NoSPP

		left outer join DBSO z on z.NOBUKTI=y.NoSHIP

		left outer join dbKaryawan p on p.KeyNIK=z.KODESLS

		where A.Tanggal between @Tgl1 and @Tgl2 

		and b.PPN in(1,2)

		and  @Id= Left(B.NoBukti,1)

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas

		Order by B.NoBukti

	  

	 else if @PPN=1 

	  select 	Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti 

		left outer join dbSPB X on B.NoSPB = X.NoBukti

		left outer join dbSPP y on y.NoBukti=x.NoSPP

		left outer join DBSO z on z.NOBUKTI=y.NoSHIP

		left outer join dbKaryawan p on p.KeyNIK=z.KODESLS

		where A.Tanggal between @Tgl1 and @Tgl2 

		and b.PPN in(0)

		and  @Id= Left(B.NoBukti,1)

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas

		Order by B.NoBukti


	 else if @PPN=2 

	  select Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,	B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti 

		left outer join dbSPB X on B.NoSPB = X.NoBukti

		left outer join dbSPP y on y.NoBukti=x.NoSPP

		left outer join DBSO z on z.NOBUKTI=y.NoSHIP

		left outer join dbKaryawan p on p.KeyNIK=z.KODESLS

		where A.Tanggal between @Tgl1 and @Tgl2 

		and  @Id= Left(B.NoBukti,1)

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas

		Order by B.NoBukti


Else If @Choice='B'

if @NeedOto=0 or @NeedOto=1

	 if @PPN=0

	   select 	Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,B.KodeBrg,C.NAMABRG,b.SAT_1,b.SAT_2,

		SUM(b.qnt) QNT,SUM(b.qnt2)QNT2,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP		

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti 

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		where A.Tanggal between @Tgl1 and @Tgl2 and       

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER)= @Needoto

	    and b.PPN in(1,2)

	    and  @Id= Left(B.NoBukti,1)

		Group By B.KodeBrg,C.NAMABRG,b.SAT_1,b.SAT_2

		order By B.KodeBrg

	   

	else if   @PPN=1

	    select Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,	B.KodeBrg,C.NAMABRG,b.SAT_1,b.SAT_2,

		SUM(b.qnt) QNT,SUM(b.qnt2)QNT2,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP		

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti 

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		where A.Tanggal between @Tgl1 and @Tgl2 and       

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER)= @Needoto

		and b.PPN in(0)

		and  @Id= Left(B.NoBukti,1)

		Group By B.KodeBrg,C.NAMABRG,b.SAT_1,b.SAT_2

		order By B.KodeBrg

			

	else if @PPN=2

	 select Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,	B.KodeBrg,C.NAMABRG,b.SAT_1,b.SAT_2,

		SUM(b.qnt) QNT,SUM(b.qnt2)QNT2,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP		

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti 

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		where A.Tanggal between @Tgl1 and @Tgl2 and       

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER)= @Needoto

		and  @Id= Left(B.NoBukti,1)

		Group By B.KodeBrg,C.NAMABRG,b.SAT_1,b.SAT_2

		order By B.KodeBrg


else if @NeedOto=2

	 if @PPN=0 

	  select Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,	B.KodeBrg,C.NAMABRG,b.SAT_1,b.SAT_2,

		SUM(b.qnt) QNT,SUM(b.qnt2)QNT2,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP		

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti 

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		where A.Tanggal between @Tgl1 and @Tgl2 

		and b.PPN in(1,2)

		and  @Id= Left(B.NoBukti,1)

		Group By B.KodeBrg,C.NAMABRG,b.SAT_1,b.SAT_2

		order By B.KodeBrg

	  

	else  if @PPN=1 

	  select Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,	B.KodeBrg,C.NAMABRG,b.SAT_1,b.SAT_2,

		SUM(b.qnt) QNT,SUM(b.qnt2)QNT2,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP		

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti 

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		where A.Tanggal between @Tgl1 and @Tgl2 

		and b.PPN in(0)

		and  @Id= Left(B.NoBukti,1)

		Group By B.KodeBrg,C.NAMABRG,b.SAT_1,b.SAT_2

		order By B.KodeBrg

	  	

 else  if @PPN=2 

	  select 	Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,B.KodeBrg,C.NAMABRG,b.SAT_1,b.SAT_2,

		SUM(b.qnt) QNT,SUM(b.qnt2)QNT2,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP		

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti 

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		where A.Tanggal between @Tgl1 and @Tgl2 

		and  @Id= Left(B.NoBukti,1)

		Group By B.KodeBrg,C.NAMABRG,b.SAT_1,b.SAT_2

		order By B.KodeBrg


Else If @Choice='C'

if @NeedOto=0 or @NeedOto=1

	if @PPN=0

	   select 	Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti 

		left outer join dbSPB X on B.NoSPB = X.NoBukti

		left outer join dbSPP y on y.NoBukti=x.NoSPP

		left outer join DBSO z on z.NOBUKTI=y.NoSHIP

		left outer join dbKaryawan p on p.KeyNIK=z.KODESLS

		where A.Tanggal between @Tgl1 and @Tgl2 and       

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER)= @Needoto

		and b.PPN in(1,2)

		and  @Id= Left(B.NoBukti,1)

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas

		order By D.NAMACUSTSUPP,A.Tanggal

	   

	 else if @PPN=1

	   select 	Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti 

		left outer join dbSPB X on B.NoSPB = X.NoBukti

		left outer join dbSPP y on y.NoBukti=x.NoSPP

		left outer join DBSO z on z.NOBUKTI=y.NoSHIP

		left outer join dbKaryawan p on p.KeyNIK=z.KODESLS

		where A.Tanggal between @Tgl1 and @Tgl2 and       

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER)= @Needoto

		and b.PPN in(0)

		and  @Id= Left(B.NoBukti,1)

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas

		order By D.NAMACUSTSUPP,A.Tanggal

	   

	 else if @PPN=2

	   select Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,	B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti 

		left outer join dbSPB X on B.NoSPB = X.NoBukti

		left outer join dbSPP y on y.NoBukti=x.NoSPP

		left outer join DBSO z on z.NOBUKTI=y.NoSHIP

		left outer join dbKaryawan p on p.KeyNIK=z.KODESLS

		where A.Tanggal between @Tgl1 and @Tgl2 and       

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER)= @Needoto

		and  @Id= Left(B.NoBukti,1)

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas

		order By D.NAMACUSTSUPP,A.Tanggal


	else if @NeedOto=2

	 if @PPN=0

	  select Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,	B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti 

		left outer join dbSPB X on B.NoSPB = X.NoBukti

		left outer join dbSPP y on y.NoBukti=x.NoSPP

		left outer join DBSO z on z.NOBUKTI=y.NoSHIP

		left outer join dbKaryawan p on p.KeyNIK=z.KODESLS

		where A.Tanggal between @Tgl1 and @Tgl2 

		and b.PPN in(1,2)

		and  @Id= Left(B.NoBukti,1)

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas

		order By D.NAMACUSTSUPP,A.Tanggal

	  

     else if @PPN=1

	  select Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,	B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti 

		left outer join dbSPB X on B.NoSPB = X.NoBukti

		left outer join dbSPP y on y.NoBukti=x.NoSPP

		left outer join DBSO z on z.NOBUKTI=y.NoSHIP

		left outer join dbKaryawan p on p.KeyNIK=z.KODESLS

		where A.Tanggal between @Tgl1 and @Tgl2 

		and b.PPN in(0)

		and  @Id= Left(B.NoBukti,1)

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas

		order By D.NAMACUSTSUPP,A.Tanggal

	   

     else if @PPN=2

	  select Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,	B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti 

		left outer join dbSPB X on B.NoSPB = X.NoBukti

		left outer join dbSPP y on y.NoBukti=x.NoSPP

		left outer join DBSO z on z.NOBUKTI=y.NoSHIP

		left outer join dbKaryawan p on p.KeyNIK=z.KODESLS

		where A.Tanggal between @Tgl1 and @Tgl2 

		and  @Id= Left(B.NoBukti,1)

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas

		order By D.NAMACUSTSUPP,A.Tanggal


Else If @Choice='S'

if @NeedOto=0 or @NeedOto=1

	 if @PPN=0

	   select Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,	B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti 

		left outer join dbSPB X on B.NoSPB = X.NoBukti

		left outer join dbSPP y on y.NoBukti=x.NoSPP

		left outer join DBSO z on z.NOBUKTI=y.NoSHIP

		left outer join dbKaryawan p on p.KeyNIK=z.KODESLS

		where A.Tanggal between @Tgl1 and @Tgl2 and       

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER)= @Needoto

		and b.PPN in (1,2)

		and  @Id= Left(B.NoBukti,1)

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas

		order By p.Nama,d.NAMACUSTSUPP,b.NoBukti

	   

	 else if @PPN=1

	   select Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,	B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti 

		left outer join dbSPB X on B.NoSPB = X.NoBukti

		left outer join dbSPP y on y.NoBukti=x.NoSPP

		left outer join DBSO z on z.NOBUKTI=y.NoSHIP

		left outer join dbKaryawan p on p.KeyNIK=z.KODESLS

		where A.Tanggal between @Tgl1 and @Tgl2 and       

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER)= @Needoto

		and b.PPN in (0)

		and  @Id= Left(B.NoBukti,1)

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas

		order By p.Nama,d.NAMACUSTSUPP,b.NoBukti

	   

	 else if @PPN=2

	   select Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,	B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti 

		left outer join dbSPB X on B.NoSPB = X.NoBukti

		left outer join dbSPP y on y.NoBukti=x.NoSPP

		left outer join DBSO z on z.NOBUKTI=y.NoSHIP

		left outer join dbKaryawan p on p.KeyNIK=z.KODESLS

		where A.Tanggal between @Tgl1 and @Tgl2 and       

		Cast(Case when Case when A.IsOtorisasi1=1 then 1 else 0 +

		Case when A.IsOtorisasi2=1 then 1 else 0 +

		Case when A.IsOtorisasi3=1 then 1 else 0 +

		Case when A.IsOtorisasi4=1 then 1 else 0 +

		Case when A.IsOtorisasi5=1 then 1 else 0 =A.MaxOL then 0

		else 1

		 As INTEGER)= @Needoto   

	    and  @Id= Left(B.NoBukti,1)

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas

		order By p.Nama,d.NAMACUSTSUPP,b.NoBukti


else if @NeedOto=2

   if @PPN=0

     select Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,	B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti 

		left outer join dbSPB X on B.NoSPB = X.NoBukti

		left outer join dbSPP y on y.NoBukti=x.NoSPP

		left outer join DBSO z on z.NOBUKTI=y.NoSHIP

		left outer join dbKaryawan p on p.KeyNIK=z.KODESLS

		where A.Tanggal between @Tgl1 and @Tgl2

		and b.PPN in(1,2)

		and  @Id= Left(B.NoBukti,1)

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas

		order By p.Nama,d.NAMACUSTSUPP,b.NoBukti

	 	

   else if @PPN=1

     select Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,	B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti 

		left outer join dbSPB X on B.NoSPB = X.NoBukti

		left outer join dbSPP y on y.NoBukti=x.NoSPP

		left outer join DBSO z on z.NOBUKTI=y.NoSHIP

		left outer join dbKaryawan p on p.KeyNIK=z.KODESLS

		where A.Tanggal between @Tgl1 and @Tgl2

		and b.PPN in(0)

		and  @Id= Left(B.NoBukti,1)

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas

		order By p.Nama,d.NAMACUSTSUPP,b.NoBukti

	 	

   else if @PPN=2

     select 	Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas,

		SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

       ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPP ) NDPP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then 

        (B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00))

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        ((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1

        else B.NDPPRp ) NDPPRP, sum(case when COALESCE(SO.PPH22,0)<>0 Then

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 

        when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

        (((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*0.1

        else

        B.NPPNRp )NPPNRP,SUM(case when COALESCE(SO.PPH22,0)<>0 Then  

        ((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))+(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )-

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*(SO.PPH22/100))+

		Case When rpInv.TotNet<=SO.PPHDPP Then

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )

		else

		(((B.NDPP)-(B.NDPP*(CAST(SO.Retensi AS Float)/100.00)))*Case WHen A.PPN=0 Then 0 when A.PPN=1 Then 0.1 else 1.1 )*-1

		 

/**/	when COALESCE(A.PPh21,0)<>0 and (COALESCE(D.IsPPH21,0)=1)Then

		((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))-((((Round(B.NNet,0))- (COALESCE(A.NTotal,0)*(COALESCE(FRetensi,0))/100))/1.1)*(COALESCE(A.PPh21,0)/100))

		else B.NNETRp )NNETRP

		from	dbInvoicePLDet B

		left outer join dbBarang C on C.KodeBrg=B.KodeBrg

		left outer join DBInvoicePL A on B.NoBukti = A.NoBukti

		Left outer join DBCUSTSUPP D on A.KodeCustSupp = D.KODECUSTSUPP

		Left Outer join (select NoBukti,TERM1P Retensi,TERM2P PPH22,TERM3P PPHDPP from DBSO) so on so.NOBUKTI=B.NoSO  

		left Outer join [vwRpDetInvoicePL] rpInv on rpInv.NoBukti=a.NoBukti 

		left outer join dbSPB X on B.NoSPB = X.NoBukti

		left outer join dbSPP y on y.NoBukti=x.NoSPP

		left outer join DBSO z on z.NOBUKTI=y.NoSHIP

		left outer join dbKaryawan p on p.KeyNIK=z.KODESLS

		where A.Tanggal between @Tgl1 and @Tgl2

		and  @Id= Left(B.NoBukti,1)

		Group By B.NoBukti,A.Tanggal,A.KodeCustSupp,D.NAMACUSTSUPP,P.Nama,a.Kurs,a.Valas

		order By p.Nama,d.NAMACUSTSUPP,b.NoBukti;

-- Sp_ReportInvoiceRek
CREATE PROCEDURE IF NOT EXISTS Sp_ReportInvoiceRek AS ---- DECLARE REMOVED,@Tgl1 Datetime,@tgl2 datetime

--select @Tgl1='01/01/2012',@tgl2='07/17/2013',@Choice='N'

if @Choice='N'

if @NeedOto=0 or @NeedOto=1

		Select  C.NoBukti ,C.TANGGAL,d.NAMACUSTSUPP,c.kurs,c.KodeVls,Sum(COALESCE(NDPPvls,0)) NDPPVLS,Sum(COALESCE(NDPP,0)) NDPP,Sum(COALESCE(NPPN,0)) NPPN,Sum(COALESCE(NNET,0)) NNET   

		From  dbInvoiceDet a

		Left Outer Join (select a.NoBukti,Sum(b.NDPP)NDPPvls,Sum(b.NDPPrp)NDPP,Sum(b.NPPNrp)NPPN,Sum(b.NNETrp)NNET from dbBeli a Left Outer Join dbBeliDet b On a.NoBukti=b.noBukti Group by a.NoBukti)b On a.NoBeli=b.NoBukti

		Left Outer join DBInvoice C on A.NOBUKTI = C.NOBUKTI 

		Left Outer Join dbCustSupp D On C.KodeSupp=D.KodeCustSupp

		where C.TANGGAL between @Tgl1 and @Tgl2 and

        Cast(Case when Case when c.IsOtorisasi1=1 then 1 else 0 +

                      Case when c.IsOtorisasi2=1 then 1 else 0 +

                      Case when c.IsOtorisasi3=1 then 1 else 0 +

                      Case when c.IsOtorisasi4=1 then 1 else 0 +

                      Case when c.IsOtorisasi5=1 then 1 else 0 =c.MaxOL then 0

                 else 1

             As INTEGER) =@NeedOto

		Group By C.NoBukti,C.TANGGAL,c.Kurs,c.KodeVls,d.NAMACUSTSUPP

		Order By Nobukti

	if @NeedOto=2

		Select  C.NoBukti ,C.TANGGAL,d.NAMACUSTSUPP,c.kurs,c.KodeVls,Sum(COALESCE(NDPPvls,0)) NDPPVLS,Sum(COALESCE(NDPP,0)) NDPP,Sum(COALESCE(NPPN,0)) NPPN,Sum(COALESCE(NNET,0)) NNET   

		From  dbInvoiceDet a

		Left Outer Join (select a.NoBukti,Sum(b.NDPP)NDPPvls,Sum(b.NDPPrp)NDPP,Sum(b.NPPNrp)NPPN,Sum(b.NNETrp)NNET from dbBeli a Left Outer Join dbBeliDet b On a.NoBukti=b.noBukti Group by a.NoBukti)b On a.NoBeli=b.NoBukti

		Left Outer join DBInvoice C on A.NOBUKTI = C.NOBUKTI 

		Left Outer Join dbCustSupp D On C.KodeSupp=D.KodeCustSupp

		where C.TANGGAL between @Tgl1 and @Tgl2 

		Group By C.NoBukti,C.TANGGAL,c.Kurs,c.KodeVls,d.NAMACUSTSUPP

		Order By Nobukti



else if @Choice='S'

if @NeedOto=0 or @NeedOto=1

		Select  c.kodesupp,C.NoBukti ,C.TANGGAL,d.NAMACUSTSUPP,c.kurs,c.KodeVls,Sum(COALESCE(NDPPvls,0)) NDPPVLS,Sum(COALESCE(NDPP,0)) NDPP,Sum(COALESCE(NPPN,0)) NPPN,Sum(COALESCE(NNET,0)) NNET   

		From  dbInvoiceDet a

		Left Outer Join (select a.NoBukti,Sum(b.NDPP)NDPPvls,Sum(b.NDPPrp)NDPP,Sum(b.NPPNrp)NPPN,Sum(b.NNETrp)NNET from dbBeli a Left Outer Join dbBeliDet b On a.NoBukti=b.noBukti Group by a.NoBukti)b On a.NoBeli=b.NoBukti

		Left Outer join DBInvoice C on A.NOBUKTI = C.NOBUKTI 

		Left Outer Join dbCustSupp D On C.KodeSupp=D.KodeCustSupp

		where C.TANGGAL between @Tgl1 and @Tgl2 and

        Cast(Case when Case when c.IsOtorisasi1=1 then 1 else 0 +

                      Case when c.IsOtorisasi2=1 then 1 else 0 +

                      Case when c.IsOtorisasi3=1 then 1 else 0 +

                      Case when c.IsOtorisasi4=1 then 1 else 0 +

                      Case when c.IsOtorisasi5=1 then 1 else 0 =c.MaxOL then 0

                 else 1

             As INTEGER) =@NeedOto

		Group By C.NoBukti,C.TANGGAL,c.Kurs,c.KodeVls,d.NAMACUSTSUPP,c.KodeSupp

		Order By C.KodeSupp

	if @NeedOto=2

		Select  c.kodesupp,C.NoBukti ,C.TANGGAL,d.NAMACUSTSUPP,c.kurs,c.KodeVls,Sum(COALESCE(NDPPvls,0)) NDPPVLS,Sum(COALESCE(NDPP,0)) NDPP,Sum(COALESCE(NPPN,0)) NPPN,Sum(COALESCE(NNET,0)) NNET   

		From  dbInvoiceDet a

		Left Outer Join (select a.NoBukti,Sum(b.NDPP)NDPPvls,Sum(b.NDPPrp)NDPP,Sum(b.NPPNrp)NPPN,Sum(b.NNETrp)NNET from dbBeli a Left Outer Join dbBeliDet b On a.NoBukti=b.noBukti Group by a.NoBukti)b On a.NoBeli=b.NoBukti

		Left Outer join DBInvoice C on A.NOBUKTI = C.NOBUKTI 

		Left Outer Join dbCustSupp D On C.KodeSupp=D.KodeCustSupp

		where C.TANGGAL between @Tgl1 and @Tgl2 

		Group By C.NoBukti,C.TANGGAL,c.Kurs,c.KodeVls,d.NAMACUSTSUPP,c.KodeSupp

		Order By C.KodeSupp;

-- Sp_ReportKartuHutang
CREATE PROCEDURE IF NOT EXISTS Sp_ReportKartuHutang AS -- SET REMOVEDCase when @devisi in ('-','') then '%' else @devisi 

if @Rekap=0

if @urut=0

Select 	

 	   Dateadd(dd,-1,@Awal) Tanggal,'Saldo Awal' NoFaktur,''NoBukti,

		0 as kredit1,

		0 as debet1, 

		0 as kreditd1, 0 as debetd1,

		H.KODECUSTSUPP as kode, S.NAMACUSTSUPP as nama, S.Alamat1 Alamat,S.kota,

  		Sum(case when H.Kredit <> 0 then H.kredit

       	      when H.Debet <> 0 then H.debet*-1

  		) as SaldoRp,

  		Sum(case	when H.KreditD <> 0 then H.KreditD

       			when H.DebetD <> 0 then H.DebetD*-1

  		) as SaldoD,

		0 as Awal, 0 as AwalD,'' NoRetur,0 urut,0 as totBayar,''P, 1 as xurut,0 kurs,

		Sum(case when H.TipeTrans='J' then H.Kredit-H.Debet 

		         else 0 

		    ) SelisihKurs,'' NoPO

 	from vwHutpiut H

 	left outer join  DBCUSTSUPP S on S.KODECUSTSUPP=H.KodeCustSupp

 	--Left Outer Join DBBELIDET M on H.NoFaktur = M.NOBUKTI and H.Urut = M.URUT

 	where H.KodeCustSupp>=@kodesupp and H.KodeCustSupp<=@kodesupp1 

 	and H.Tanggal<@awal and H.perkiraan=@perkiraan

 	and ((H.Valas=@KodeVls and @KodeVls<>'IDR') or (H.Valas like '%' and @KodeVls='IDR'))

 	and (H.Devisi like @devisi) 

	Group by H.KODECUSTSUPP ,S.NAMACUSTSUPP, s.Alamat1, S.kota

 	union all

 	Select H.Tanggal,H.NoFaktur,H.NoBukti,

 		--case when H.TipeTrans='J' then 0 else H.Debet  as kredit1,

		case when H.TipeTrans='J' then 0 else case when H.NoRetur='' then H.Debet else 0   as kredit1,

		case when H.TipeTrans='J' then 0 else case when H.NoRetur='' then H.Kredit else -H.Debet   as debet1, 

		--DebetD as kreditd1,

        --H.KreditD as debetd1,

        case when H.NoRetur='' then DebetD else 0  as kreditd1,

        case when H.NoRetur='' then H.KreditD else -H.DebetD  debetd1, 

        H.KODECUSTSUPP as kode,S.NAMACUSTSUPP as nama, '' Alamat, S.kota,

  		case when H.Kredit <> 0 then H.kredit

       			when H.Debet <> 0 then H.debet*-1  as SaldoRp,

  		case when H.KreditD <> 0 then H.KreditD

       			when H.DebetD <> 0 then H.DebetD*-1  as SaldoD,

		H.Kredit as Awal, 0 as AwalD, NoRetur, h.urut, debet as totBayar,

		SUBSTR(h.nofaktur, LENGTH(h.nofaktur)-7+1),3 as xurut, h.kurs,

		case when H.TipeTrans='J' then H.Kredit-H.Debet else 0  SelisihKurs,M.NoPO

 	from vwHutpiut H

 	left outer join DBCUSTSUPP S on S.KODECUSTSUPP=H.KODECUSTSUPP 

 	Left Outer Join DBBELIDET M on H.NoFaktur = M.NOBUKTI and H.Urut = M.URUT

 	where H.KODECUSTSUPP>=@kodesupp and H.KODECUSTSUPP<=@kodesupp1 

 	and (H.Tanggal>=@awal and H.Tanggal<=@Akhir) and H.perkiraan=@perkiraan 

 	and ((H.Valas=@KodeVls and @KodeVls<>'IDR') or (H.Valas like '%' and @KodeVls='IDR'))

 	and (H.Devisi like @devisi) 

 	order by H.KODECUSTSUPP,xurut,tanggal,urut,NoFaktur,NoRetur,NoPO



else if @urut=1

Select Dateadd(dd,-1,@Awal) Tanggal,'Saldo Awal' NoFaktur,''NoBukti,

		0 as kredit1,

		0 as debet1, 

		0 as kreditd1, 0 as debetd1,

		H.KODECUSTSUPP as kode,S.NAMACUSTSUPP as nama, S.Alamat1 Alamat,S.kota,

  		Sum(case when H.Kredit <> 0 then H.kredit

       	      when H.Debet <> 0 then H.debet*-1

  		) as SaldoRp,

  		Sum(case	when H.KreditD <> 0 then H.KreditD

       			when H.DebetD <> 0 then H.DebetD*-1

  		) as SaldoD,

		0 as Awal, 0 as AwalD,'' NoRetur,0 urut,0 as totBayar,''P, 1 as xurut,''H,0 kurs,

		Sum(case when H.TipeTrans='J' then H.Kredit-H.Debet 

		         else 0 

		    ) SelisihKurs

		    ,'' NoPO

    from vwHutpiut H

 	left outer join  DBCUSTSUPP S on S.KODECUSTSUPP=H.KodeCustSupp

 	--Left Outer Join DBBELIDET M on H.NoFaktur = M.NOBUKTI and H.Urut = M.URUT

 	where H.KodeCustSupp>=@kodesupp and H.KodeCustSupp<=@kodesupp1 

 	and H.Tanggal<@awal and H.perkiraan=@perkiraan

 	and ((H.Valas=@KodeVls and @KodeVls<>'IDR') or (H.Valas like '%' and @KodeVls='IDR'))

 	and (H.Devisi like @devisi) 

	Group by H.KODECUSTSUPP , S.NAMACUSTSUPP, s.Alamat1,S.kota

 	union all

 	Select H.Tanggal,H.NoFaktur,H.NoBukti,

		--case when H.TipeTrans='J' then 0 else H.Debet  as kredit1,

		--case when H.TipeTrans='J' then 0 else H.Kredit  as debet1,

		case when H.TipeTrans='J' then 0 else case when H.NoRetur='' then H.Debet else 0   as kredit1,

		case when H.TipeTrans='J' then 0 else case when H.NoRetur='' then H.Kredit else -H.Debet   as debet1,  

		--H.DebetD as kreditd1,

        --H.KreditD as debetd1, 

        case when H.NoRetur='' then DebetD else 0  as kreditd1,

        case when H.NoRetur='' then H.KreditD else -H.DebetD  debetd1,

        H.KODECUSTSUPP as kode,S.NAMACUSTSUPP as nama, s.ALAMAT1 Alamat,S.kota,

  		case when H.Kredit <> 0 then H.kredit

       			when H.Debet <> 0 then H.debet*-1  as SaldoRp,

  		case when H.KreditD <> 0 then H.kreditD

       			when H.DebetD <> 0 then H.debetD*-1

  		 as SaldoD,

		H.Kredit as Awal,0 as AwalD,NoRetur,h.urut,debet as totBayar,

		SUBSTR(h.nofaktur, LENGTH(h.nofaktur)-7+1)P,3 as xurut,SUBSTR(h.nofaktur, LENGTH(h.nofaktur)-4+1)H, h.Kurs,

		case when H.TipeTrans='J' then H.Kredit-H.Debet else 0  SelisihKurs

		,M.NoPO

 	from vwHutpiut H

 	left outer join  DBCUSTSUPP S on S.KODECUSTSUPP=H.KodeCustSupp 

 	Left Outer Join DBBELIDET M on H.NoFaktur = M.NOBUKTI and H.Urut = M.URUT

 	where H.KODECUSTSUPP>=@kodesupp and H.KODECUSTSUPP<=@kodesupp1 

 	and (H.Tanggal>=@awal and H.Tanggal<=@Akhir) 

 	and H.perkiraan=@perkiraan

 	and ((H.Valas=@KodeVls and @KodeVls<>'IDR') or (H.Valas like '%' and @KodeVls='IDR'))

 	and (H.Devisi like @devisi) 

 	order by H.KODECUSTSUPP,xurut,H,P,NoFaktur,tanggal,urut,NoPO


else

if @urut=0

Select Dateadd(dd,-1,@Awal) as tanggal,'Saldo Awal' as NoFaktur,'AWL' as NoBukti,0 as kredit1,0 as debet1,0 as kreditd1,

        		0 as debetd1, H.KODECUSTSUPP as kode,S.NAMACUSTSUPP as nama,'' alamat,S.kota,

  		sum(case when H.Kredit <> 0 then H.kredit

       		when H.Debet <> 0 then H.debet*-1

  		) as saldoRp,

		sum(case when H.KreditD <> 0 then H.kreditD

       		when H.DebetD <> 0 then H.debetD*-1

  		) as saldoD,0 as Awal,0 as AwalD,'' NoRetur,9999 as urut,0 as totBayar,'',2 as xurut, null kurs, null SelisihKurs

  		,'' NoPO

 	from vwHutpiut H

 	left outer join  DBCUSTSUPP S on S.KODECUSTSUPP=H.KodeCustSupp

 	--Left Outer Join DBBELIDET M on H.NoFaktur = M.NOBUKTI and H.Urut = M.URUT

 	where H.KodeCustSupp>=@kodesupp and H.KodeCustSupp<=@kodesupp1 

 	and H.Tanggal<@awal and H.perkiraan=@perkiraan

 	and ((H.Valas=@KodeVls and @KodeVls<>'IDR') or (H.Valas like '%' and @KodeVls='IDR'))

 	and (H.Devisi like @devisi) 

 	group by H.KODECUSTSUPP, s.NAMACUSTSUPP, S.kota

 	union all

 	Select H.Tanggal,H.NoFaktur,H.NoBukti,

		--case when H.TipeTrans='J' then 0 else H.Debet  as kredit1,

		--case when H.TipeTrans='J' then 0 else H.Kredit  as debet1,

		case when H.TipeTrans='J' then 0 else case when H.NoRetur='' then H.Debet else 0   as kredit1,

		case when H.TipeTrans='J' then 0 else case when H.NoRetur='' then H.Kredit else -H.Debet   as debet1,  

		--H.DebetD as kreditd1,

        --H.KreditD as debetd1, 

        case when H.NoRetur='' then DebetD else 0  as kreditd1,

        case when H.NoRetur='' then H.KreditD else -H.DebetD  debetd1,

        H.KODECUSTSUPP as kode,S.NAMACUSTSUPP as nama,'' alamat,S.kota,

  		case when H.Kredit <> 0 then H.kredit

       			when H.Debet <> 0 then H.debet*-1

  		 as SaldoRp,

  		case when H.KreditD <> 0 then H.kreditD

       		when H.DebetD <> 0 then H.debetD*-1

  		 as SaldoD,H.Kredit as Awal, H.KreditD as AwalD,NoRetur,h.urut,debet as totBayar,

		SUBSTR(h.nofaktur, LENGTH(h.nofaktur)-7+1),3 as xurut, h.kurs,

		case when H.TipeTrans='J' then H.Kredit-H.Debet else 0  SelisihKurs

		,M.NoPO

 	from vwHutpiut H

 	left outer join  DBCUSTSUPP S on S.KODECUSTSUPP=H.KodeCustSupp

 	Left Outer Join DBBELIDET M on H.NoFaktur = M.NOBUKTI and H.Urut = M.URUT

 	where H.KODECUSTSUPP>=@kodesupp and H.KODECUSTSUPP<=@kodesupp1 

 	and (H.Tanggal>=@awal and H.Tanggal<=@Akhir) and H.perkiraan=@perkiraan

 	and ((H.Valas=@KodeVls and @KodeVls<>'IDR') or (H.Valas like '%' and @KodeVls='IDR'))

 	and (H.Devisi like @devisi) 

 	order by H.KODECUSTSUPP,xurut,tanggal,urut,NoFaktur,NoRetur,NoPO



else if @urut=1

Select null as tanggal,'Saldo Awal' as NoFaktur,'AWL' as NoBukti,0 as kredit1,0 as debet1,0 as kreditd1,

        		0 as debetd1,H.KODECUSTSUPP as kode,S.NAMACUSTSUPP as nama,'' alamat,S.kota,

  		sum(case when H.Kredit <> 0 then H.kredit

       		when H.Debet <> 0 then H.debet*-1

  		) as saldoRp,

		sum(case when H.KreditD <> 0 then H.kreditD

       			when H.DebetD <> 0 then H.debetD*-1

  		) as saldoD,0 as Awal,0 as AwalD,''NoRetur,9999 as urut,0 as totBayar,'',2 as xurut,'', null kurs, null SelisihKurs

  		,'' NoPO

	from vwHutpiut H

 	left outer join  DBCUSTSUPP S on S.KODECUSTSUPP=H.KodeCustSupp

 	--Left Outer Join DBBELIDET M on H.NoFaktur = M.NOBUKTI and H.Urut = M.URUT

	where H.KODECUSTSUPP>=@kodesupp and H.KODECUSTSUPP<=@kodesupp1 

	and H.perkiraan=@perkiraan and H.Tanggal<=@Awal

	and ((H.Valas=@KodeVls and @KodeVls<>'IDR') or (H.Valas like '%' and @KodeVls='IDR'))

	and (H.Devisi like @devisi) 

	group by H.KODECUSTSUPP,s.NAMACUSTSUPP, S.kota

	having sum(kredit)-sum(debet)<>0



 	union all

 	Select H.Tanggal,H.NoFaktur Nofaktur,H.NoBukti,

		--case when H.TipeTrans='J' then 0 else H.Debet  as kredit1,

		--case when H.TipeTrans='J' then 0 else H.Kredit  as debet1,

		case when H.TipeTrans='J' then 0 else case when H.NoRetur='' then H.Debet else 0   as kredit1,

		case when H.TipeTrans='J' then 0 else case when H.NoRetur='' then H.Kredit else -H.Debet   as debet1,  

		--H.DebetD as kreditd1,

        --H.KreditD as debetd1,

        case when H.NoRetur='' then DebetD else 0  as kreditd1,

        case when H.NoRetur='' then H.KreditD else -H.DebetD  debetd1, 

        H.KODECUSTSUPP as kode,S.NAMACUSTSUPP as nama,'' alamat,S.kota,

  case when H.Kredit <> 0 then H.kredit

       when H.Debet <> 0 then H.debet*-1

   as SaldoRp,

  case when H.KreditD <> 0 then H.kreditD

       when H.DebetD <> 0 then H.debetD*-1

   as SaldoD,H.Kredit as Awal, H.KreditD as AwalD,NoRetur,h.urut,debet as totBayar,SUBSTR(h.nofaktur, LENGTH(h.nofaktur)-7+1),3 as xurut,SUBSTR(h.nofaktur, LENGTH(h.nofaktur)-4+1), h.kurs,

	case when H.TipeTrans='J' then H.Kredit-H.Debet else 0  SelisihKurs

	,M.NoPO

 from vwHutpiut H

 left outer join  DBCUSTSUPP S on S.KODECUSTSUPP=H.KodeCustSupp

 Left Outer Join DBBELIDET M on H.NoFaktur = M.NOBUKTI and H.Urut = M.URUT

 where H.KODECUSTSUPP>=@kodesupp and H.KODECUSTSUPP<=@kodesupp1 

 and (H.Tanggal>=@awal and H.Tanggal<=@Akhir)

 and H.perkiraan=@perkiraan

 and ((H.Valas=@KodeVls and @KodeVls<>'IDR') or (H.Valas like '%' and @KodeVls='IDR'))

 and (H.Devisi like @devisi) 

 order by H.KODECUSTSUPP,xurut,nofaktur,tanggal,urut, NoPO;

-- Sp_ReportKartuPiutang
CREATE PROCEDURE IF NOT EXISTS Sp_ReportKartuPiutang AS -- SET REMOVEDCase when @devisi in ('-','') then '%' else @devisi 

if @Rekap=0

if @urut=0

Select Dateadd(dd,-1,@Awal) Tanggal,'Saldo Awal'NoFaktur,''NoBukti,

		0 as kredit1,

		0 as debet1, 

		0 as kreditd1, 0 as debetd1,

		H.KODECUSTSUPP as kode,S.NAMACUSTSUPP as nama, S.Alamat1 Alamat ,S.kota,

  		Sum(case 	when H.Debet <> 0 then H.Debet

       			when H.Kredit <> 0 then H.Kredit*-1

  		) as SaldoRp,

  		Sum(case 	when H.DebetD <> 0 then H.DebetD

       			when H.KreditD <> 0 then H.KreditD*-1

  		) as SaldoD,

		0 as Awal, 0 as AwalD,''NoRetur,0urut,0 as totBayar,''P, 1 as xurut,0 kurs,

		Sum(case when H.TipeTrans='J' then H.Kredit-H.Debet else 0 ) SelisihKurs,Prj.KODEPROJECT,Prj.NAMAPROJECT

 	from vwHutpiut H

 	left outer join DBCUSTSUPP S on S.KODECUSTSUPP=H.KodeCustSupp 

 	Left Outer Join DBPROJECT Prj on Prj.KODEPROJECT=Case When H.TipeTrans='AWL' Then H.KodeSales else '' 

 	where H.KodeCustSupp>=@kodesupp and H.KodeCustSupp<=@kodesupp1

 	and H.Tanggal<@awal and H.perkiraan=@perkiraan

 	and ((H.Valas=@KodeVls and @KodeVls<>'IDR') or (H.Valas like '%' and @KodeVls='IDR'))

 	and (H.Devisi like @devisi) 

 	Group by H.KODECUSTSUPP ,S.NAMACUSTSUPP , S.Alamat1, S.kota,Prj.KODEPROJECT,Prj.NAMAPROJECT

 	union all

 	Select H.Tanggal,H.NoFaktur,Case When TipeTrans='T' Then H.NoPajak else H.NoBukti  NoBukti,

		case when H.TipeTrans='J' then 0 else case when H.NoRetur='' then H.Kredit else 0   as kredit1,

		case when H.TipeTrans='J' then 0 else case when H.NoRetur='' then H.Debet else -H.Kredit   as debet1, 

		case when H.NoRetur='' then H.KreditD else 0  as kreditd1,

        case when H.NoRetur='' then H.DebetD else -H.KreditD  debetd1, 

        H.KODECUSTSUPP as kode,S.NAMACUSTSUPP as nama, s.Alamat1 Alamat, S.kota,

  		case when H.Debet <> 0 then H.Debet

       			when H.Kredit <> 0 then H.Kredit*-1  as SaldoRp,

  		case when H.DebetD <> 0 then H.DebetD

       			when H.KreditD <> 0 then H.KreditD*-1  as SaldoD,

		H.Kredit as Awal, 0 as AwalD, NoRetur, h.urut, H.Kredit as totBayar,

		SUBSTR(h.nofaktur, LENGTH(h.nofaktur)-7+1),3 as xurut, h.kurs,

		case when H.TipeTrans='J' then H.Kredit-H.Debet else 0  SelisihKurs,Prj.KODEPROJECT,Prj.NAMAPROJECT

 	from vwHutpiut H

 	Left Outer Join dbInvoicePL Inv On Inv.NoBukti=case when H.FlagSimbol='TL' then REPLACE(H.NoFaktur,SUBSTR(H.Nofaktur, LENGTH(H.Nofaktur)-2+1),'') else H.NoFaktur 

 	left outer join DBCUSTSUPP S on S.KODECUSTSUPP=H.KODECUSTSUPP

 	Left Outer Join DBPROJECT Prj on Prj.KODEPROJECT=Case When H.TipeTrans='AWL' Then H.KodeSales else Inv.NoBL 

 	where H.KODECUSTSUPP>=@kodesupp and H.KODECUSTSUPP<=@kodesupp1 

 	 and (H.Tanggal>=@awal and H.Tanggal<=@Akhir)

 	 and H.perkiraan=@perkiraan

 	 and ((H.Valas=@KodeVls and @KodeVls<>'IDR') or (H.Valas like '%' and @KodeVls='IDR'))

 	 and (H.Devisi like @devisi) 

 	order by H.KODECUSTSUPP,Prj.KODEPROJECT, xurut, tanggal,NoFaktur,NoRetur,urut



else if @urut=1

Select 	Dateadd(dd,-1,@Awal) Tanggal,'Saldo Awal' NoFaktur,'' NoBukti, 

		0 as kredit1,

		0 as debet1, 

		0 as kreditd1,

      0 as debetd1, H.KODECUSTSUPP as kode,S.NAMACUSTSUPP as nama, S.ALAMAT1 Alamat,S.kota,

  		Sum(case when H.Debet <> 0 then H.Debet

       			when H.Kredit <> 0 then H.Kredit*-1 ) as SaldoRp,

  		Sum(case when H.DebetD <> 0 then H.DebetD

       			when H.KreditD <> 0 then H.KreditD*-1 ) as SaldoD,

		0 as Awal,0 as AwalD,''NoRetur,0urut,0 as totBayar,

		''P, 1 as xurut,'' H, 0 kurs,

		Sum(case when H.TipeTrans='J' then H.Kredit-H.Debet else 0 ) SelisihKurs,Prj.KODEPROJECT ,Prj.NAMAPROJECT

 	from 	vwHutpiut H

 	Left outer join DBCUSTSUPP S on S.KODECUSTSUPP=H.KODECUSTSUPP 

 	Left Outer Join DBPROJECT Prj on Prj.KODEPROJECT=Case When H.TipeTrans='AWL' Then H.KodeSales else '' 

 	Where H.Tanggal<@awal and H.KODECUSTSUPP>=@kodesupp and H.KODECUSTSUPP<=@kodesupp1 

 	and H.perkiraan=@perkiraan

 	and ((H.Valas=@KodeVls and @KodeVls<>'IDR') or (H.Valas like '%' and @KodeVls='IDR'))

 	and (H.Devisi like @devisi) 

 	Group by H.KODECUSTSUPP ,S.NAMACUSTSUPP , S.Alamat1, S.kota,Prj.KODEPROJECT ,Prj.NAMAPROJECT

 	union all

 	Select H.Tanggal, H.NoFaktur, Case When TipeTrans='T' Then H.NoPajak else H.NoBukti  NoBukti,

		--case when H.TipeTrans='J' then 0 else H.Kredit  as kredit1,

		--case when H.TipeTrans='J' then 0 else H.Debet  as debet1,

		case when H.TipeTrans='J' then 0 else case when H.NoRetur='' then H.Kredit else 0   as kredit1,

		case when H.TipeTrans='J' then 0 else case when H.NoRetur='' then H.Debet else -H.Kredit   as debet1,  

		--H.KreditD as kreditd1,

        --H.DebetD as debetd1,

        case when H.NoRetur='' then H.KreditD else 0  as kreditd1,

        case when H.NoRetur='' then H.DebetD else -H.KreditD  debetd1,  

        H.KODECUSTSUPP as kode, S.NAMACUSTSUPP nama, s.ALAMAT1 Alamat,S.kota,

  		case when H.Debet <> 0 then H.Debet

       			when H.Kredit <> 0 then H.Kredit*-1  as SaldoRp,

  		case when H.DebetD <> 0 then H.DebetD

       			when H.KreditD <> 0 then H.KreditD*-1

  		 as SaldoD,

		H.Debet as Awal, 0 as AwalD, NoRetur,h.urut, H.Kredit as totBayar,

		SUBSTR(h.nofaktur, LENGTH(h.nofaktur)-7+1),3 as xurut,SUBSTR(h.nofaktur, LENGTH(h.nofaktur)-4+1), h.Kurs,

		case when H.TipeTrans='J' then H.Kredit-H.Debet else 0  SelisihKurs,Prj.KODEPROJECT,Prj.NAMAPROJECT

 	from vwHutpiut H

 	Left Outer Join dbInvoicePL Inv On Inv.NoBukti=case when H.FlagSimbol='TL' then REPLACE(H.NoFaktur,SUBSTR(H.Nofaktur, LENGTH(H.Nofaktur)-2+1),'') else H.NoFaktur 

 	left outer join DBCUSTSUPP S on (S.KODECUSTSUPP=H.KODECUSTSUPP) 

 	Left Outer Join DBPROJECT Prj on Prj.KODEPROJECT=Case When H.TipeTrans='AWL' Then H.KodeSales else Inv.NoBL 

 	where H.KODECUSTSUPP>=@kodesupp and H.KODECUSTSUPP<=@kodesupp1 

 	and (H.Tanggal>=@awal and H.Tanggal<=@Akhir)

 	and H.perkiraan=@perkiraan

 	and ((H.Valas=@KodeVls and @KodeVls<>'IDR') or (H.Valas like '%' and @KodeVls='IDR'))

 	and (H.Devisi like @devisi) 

 	order by h.KODECUSTSUPP,prj.KODEPROJECT,xurut,H,P,NoFaktur,tanggal,urut


else

if @urut=0

Select 	null as tanggal,'Saldo Awal' as NoFaktur,'AWL' as NoBukti,0 as kredit1,0 as debet1,0 as kreditd1,

        		0 as debetd1, H.KODECUSTSUPP Kode, S.NAMACUSTSUPP nama,'' alamat,S.kota,

  		sum(case when H.Debet <> 0 then H.Debet

       		when H.Kredit <> 0 then H.Kredit*-1

  		) as saldoRp,

		sum(case when H.DebetD <> 0 then H.DebetD

       		when H.KreditD <> 0 then H.KreditD*-1

  		) as saldoD,0 as Awal,0 as AwalD,'' NoRetur,9999 as urut,0 as totBayar,'',2 as xurut, null kurs, null SelisihKurs,Prj.KODEPROJECT,Prj.NAMAPROJECT

 	from vwHutpiut  H

 	left outer join DBCUSTSUPP S on S.KODECUSTSUPP=H.KODECUSTSUPP

 	Left Outer Join DBPROJECT Prj on Prj.KODEPROJECT=Case When H.TipeTrans='AWL' Then H.KodeSales else '' 

 	where H.KODECUSTSUPP>=@kodesupp and H.KODECUSTSUPP<=@kodesupp1 

 	and H.perkiraan=@perkiraan and h.Tanggal<@Awal

 	and ((H.Valas=@KodeVls and @KodeVls<>'IDR') or (H.Valas like '%' and @KodeVls='IDR'))

 	and (H.Devisi like @devisi) 

 	group by H.KODECUSTSUPP,s.NAMACUSTSUPP, S.kota,Prj.KODEPROJECT,Prj.NAMAPROJECT

 	union all

 	Select H.Tanggal,H.NoFaktur,Case When TipeTrans='T' Then H.NoPajak else H.NoBukti  NoBukti,

		--case when H.TipeTrans='J' then 0 else H.Kredit  as kredit1,

		--case when H.TipeTrans='J' then 0 else H.Debet  as debet1,

		case when H.TipeTrans='J' then 0 else case when H.NoRetur='' then H.Kredit else 0   as kredit1,

		case when H.TipeTrans='J' then 0 else case when H.NoRetur='' then H.Debet else -H.Kredit   as debet1,  

		--H.KreditD as kreditd1,

        --H.DebetD as debetd1, 

        case when H.NoRetur='' then H.KreditD else 0  as kreditd1,

        case when H.NoRetur='' then H.DebetD else -H.KreditD  debetd1, 

        H.KODECUSTSUPP as kode,S.NAMACUSTSUPP as nama,'' alamat,S.kota,

  		case when H.Debet <> 0 then H.Debet

       			when H.Kredit <> 0 then H.Kredit*-1

  		 as SaldoRp,

  		case when H.DebetD <> 0 then H.DebetD

       		when H.KreditD <> 0 then H.KreditD*-1

  		 as SaldoD, H.Debet as Awal, H.DebetD as AwalD, NoRetur,h.urut, H.Kredit as totBayar,

		SUBSTR(h.nofaktur, LENGTH(h.nofaktur)-7+1),3 as xurut, h.kurs,

		case when H.TipeTrans='J' then H.Kredit-H.Debet else 0  SelisihKurs,Prj.KODEPROJECT,Prj.NAMAPROJECT

 	from vwHutpiut H

 	Left Outer Join dbInvoicePL Inv On Inv.NoBukti=case when H.FlagSimbol='TL' then REPLACE(H.NoFaktur,SUBSTR(H.Nofaktur, LENGTH(H.Nofaktur)-2+1),'') else H.NoFaktur 

 	left outer join DBCUSTSUPP S on S.KODECUSTSUPP=H.KODECUSTSUPP 

 	Left Outer Join DBPROJECT Prj on Prj.KODEPROJECT=Case When H.TipeTrans='AWL' Then H.KodeSales else Inv.NoBL 

 	where H.KODECUSTSUPP>=@kodesupp and H.KODECUSTSUPP<=@kodesupp1 

 	and (H.Tanggal>=@awal and H.Tanggal<=@Akhir)

 	and H.perkiraan=@perkiraan

 	and ((H.Valas=@KodeVls and @KodeVls<>'IDR') or (H.Valas like '%' and @KodeVls='IDR'))

 	and (H.Devisi like @devisi) 

 	order by H.KODECUSTSUPP,Prj.KODEPROJECT,xurut,tanggal,NoFaktur,NoRetur,urut



else if @urut=1

Select null as tanggal,'Saldo Awal' as NoFaktur,'AWL' as NoBukti,0 as kredit1,0 as debet1,0 as kreditd1,

        		0 as debetd1, H.KODECUSTSUPP as kode,S.NAMACUSTSUPP as nama,'' alamat,S.kota,

  		sum(case when H.Debet <> 0 then H.Debet

       		when H.Kredit <> 0 then H.Kredit*-1

  		) as saldoRp,

		sum(case when H.DebetD <> 0 then H.DebetD

       			when H.KreditD <> 0 then H.KreditD*-1

  		) as saldoD,0 as Awal,0 as AwalD,''NoRetur,9999 as urut,0 as totBayar,'',2 as xurut,'', null kurs, null SelisihKurs,Prj.KODEPROJECT,Prj.NAMAPROJECT

	from vwHutpiut H

	left outer join DBCUSTSUPP S on S.KODECUSTSUPP=H.KODECUSTSUPP

	Left Outer Join DBPROJECT Prj on Prj.KODEPROJECT=Case When H.TipeTrans='AWL' Then H.KodeSales else '' 

	where H.KODECUSTSUPP>=@kodesupp and H.KODECUSTSUPP<=@kodesupp1 

	and H.perkiraan=@perkiraan and H.Tanggal<=@Awal

	and ((H.Valas=@KodeVls and @KodeVls<>'IDR') or (H.Valas like '%' and @KodeVls='IDR'))

	and (H.Devisi like @devisi) 

	group by H.KODECUSTSUPP,s.NAMACUSTSUPP, S.kota,Prj.KODEPROJECT,Prj.NAMAPROJECT

	having sum(kredit)-sum(debet)<>0



 	union all

 	Select H.Tanggal,H.NoFaktur Nofaktur,Case When TipeTrans='T' Then H.NoPajak else H.NoBukti  NoBukti,

		--case when H.TipeTrans='J' then 0 else H.Kredit  as kredit1,

		--case when H.TipeTrans='J' then 0 else H.Debet  as debet1,

		case when H.TipeTrans='J' then 0 else case when H.NoRetur='' then H.Kredit else 0   as kredit1,

		case when H.TipeTrans='J' then 0 else case when H.NoRetur='' then H.Debet else -H.Kredit   as debet1,  

		--H.KreditD as kreditd1,

        --H.DebetD as debetd1, 

        case when H.NoRetur='' then H.KreditD else 0  as kreditd1,

        case when H.NoRetur='' then H.DebetD else -H.KreditD  debetd1, 

        H.KODECUSTSUPP as kode,S.NAMACUSTSUPP as nama,'' alamat,S.kota,

  case when H.Debet <> 0 then H.Debet

       when H.Kredit <> 0 then H.Kredit*-1

   as SaldoRp,

  case when H.DebetD <> 0 then H.DebetD

       when H.KreditD <> 0 then H.KreditD*-1

   as SaldoD,H.Debet as Awal, H.DebetD as AwalD,NoRetur,h.urut,H.Kredit as totBayar,SUBSTR(h.nofaktur, LENGTH(h.nofaktur)-7+1),3 as xurut,SUBSTR(h.nofaktur, LENGTH(h.nofaktur)-4+1), h.kurs,

	case when H.TipeTrans='J' then H.Kredit-H.Debet else 0  SelisihKurs,Prj.KODEPROJECT,Prj.NAMAPROJECT

 from vwHUTPIUT H

 Left Outer Join dbInvoicePL Inv On Inv.NoBukti=case when H.FlagSimbol='TL' then REPLACE(H.NoFaktur,SUBSTR(H.Nofaktur, LENGTH(H.Nofaktur)-2+1),'') else H.NoFaktur 

 left outer join DBCUSTSUPP S on S.KODECUSTSUPP=H.KODECUSTSUPP

 Left Outer Join DBPROJECT Prj on Prj.KODEPROJECT=Case When H.TipeTrans='AWL' Then H.KodeSales else Inv.NoBL 

 where H.KODECUSTSUPP>=@kodesupp and H.KODECUSTSUPP<=@kodesupp1 

	 and (H.Tanggal>=@awal and H.Tanggal<=@Akhir)

	 and H.perkiraan=@perkiraan

	 and ((H.Valas=@KodeVls and @KodeVls<>'IDR') or (H.Valas like '%' and @KodeVls='IDR'))

	 and (H.Devisi like @devisi) 

 order by H.KODECUSTSUPP,Prj.KODEPROJECT,xurut,nofaktur,tanggal,urut;

-- Sp_ReportKartuPiutangAll
CREATE PROCEDURE IF NOT EXISTS Sp_ReportKartuPiutangAll AS -- SET REMOVEDCase when @devisi in ('-','') then '%' else @devisi 

 Select Dateadd(dd,-1,'12-31-2015') Tanggal,'Saldo Awal'NoFaktur,''NoBukti,

		0 as kredit1,

		0 as debet1, 

		0 as kreditd1, 0 as debetd1,

		H.KODECUSTSUPP as kode,S.NAMACUSTSUPP as nama, S.Alamat1 Alamat ,S.kota,

  		Sum(case 	when H.Debet <> 0 then H.Debet

       			when H.Kredit <> 0 then H.Kredit*-1

  		) as SaldoRp,

  		Sum(case 	when H.DebetD <> 0 then H.DebetD

       			when H.KreditD <> 0 then H.KreditD*-1

  		) as SaldoD,

		0 as Awal, 0 as AwalD,''NoRetur,0urut,0 as totBayar,''P, 1 as xurut,0 kurs,

		Sum(case when H.TipeTrans='J' then H.Kredit-H.Debet else 0 ) SelisihKurs,Prj.KODEPROJECT,Prj.NAMAPROJECT

 	from vwHutpiut H

 	left outer join DBCUSTSUPP S on S.KODECUSTSUPP=H.KodeCustSupp 

 	Left Outer Join DBPROJECT Prj on Prj.KODEPROJECT=Case When H.TipeTrans='AWL' Then H.KodeSales else '' 

 	where H.KodeCustSupp=@kodesupp --and H.KodeCustSupp<=@kodesupp1

 	and H.Tanggal<='12-31-2015' and H.perkiraan='131' and (H.Devisi like @devisi) 

 	--and ((H.Valas=@KodeVls and @KodeVls<>'IDR') or (H.Valas like '%' and @KodeVls='IDR'))

 	Group by H.KODECUSTSUPP ,S.NAMACUSTSUPP , S.Alamat1, S.kota,Prj.KODEPROJECT,Prj.NAMAPROJECT

 	union all

 	Select H.Tanggal,H.NoFaktur,H.NoBukti,

		case when H.TipeTrans='J' then 0 else case when H.NoRetur='' then H.Kredit else 0   as kredit1,

		case when H.TipeTrans='J' then 0 else case when H.NoRetur='' then H.Debet else -H.Kredit   as debet1, 

		case when H.NoRetur='' then H.KreditD else 0  as kreditd1,

        case when H.NoRetur='' then H.DebetD else -H.KreditD  debetd1, 

        H.KODECUSTSUPP as kode,S.NAMACUSTSUPP as nama, s.Alamat1 Alamat, S.kota,

  		case when H.Debet <> 0 then H.Debet

       			when H.Kredit <> 0 then H.Kredit*-1  as SaldoRp,

  		case when H.DebetD <> 0 then H.DebetD

       			when H.KreditD <> 0 then H.KreditD*-1  as SaldoD,

		H.Kredit as Awal, 0 as AwalD, NoRetur, h.urut, H.Kredit as totBayar,

		SUBSTR(h.nofaktur, LENGTH(h.nofaktur)-7+1),3 as xurut, h.kurs,

		case when H.TipeTrans='J' then H.Kredit-H.Debet else 0  SelisihKurs,Prj.KODEPROJECT,Prj.NAMAPROJECT

 	from vwHutpiut H

 	Left Outer Join dbInvoicePL Inv On Inv.NoBukti=H.NoFaktur

 	left outer join DBCUSTSUPP S on S.KODECUSTSUPP=H.KODECUSTSUPP

 	Left Outer Join DBPROJECT Prj on Prj.KODEPROJECT=Case When H.TipeTrans='AWL' Then H.KodeSales else Inv.NoBL 

 	where H.KODECUSTSUPP=@kodesupp --and H.KODECUSTSUPP<=@kodesupp1 

 	 and (H.Tanggal>'12-31-2015' and H.Tanggal<=CAST(datetime('now') AS INT)))

 	 and H.perkiraan='131' and (H.Devisi like @devisi) 

 	 --and ((H.Valas=@KodeVls and @KodeVls<>'IDR') or (H.Valas like '%' and @KodeVls='IDR'))

 	order by H.KODECUSTSUPP,Prj.KODEPROJECT, xurut, tanggal,urut,NoFaktur,NoRetur;

-- Sp_ReportKartuProyek
CREATE PROCEDURE IF NOT EXISTS Sp_ReportKartuProyek AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 

Select @Id=LEFT(@Id,1)

if @Id=''

if @isiList='' 

     exec('select ''Gabungan'' Perusahaan,* from [Vw_KartuProyek] where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

      order by KODECUST,KodePrj,NoBukti,KdbrgSJ')

	 

 else

     exec('select ''Gabungan'' Perusahaan,* from [Vw_KartuProyek] where Filter IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

      order by NoBukti,KdbrgSJ')


else

if @isiList='' 

     exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from [Vw_KartuProyek] where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

      and '''+@ID+'''= Left(NoBukti,1)

      order by KODECUST,KodePrj,NoBukti,KdbrgSJ')

	 

 else

     exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from [Vw_KartuProyek] where Filter IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

      and '''+@ID+'''= Left(NoBukti,1)

      order by NoBukti,KdbrgSJ');

-- Sp_ReportKartuProyekBarang
CREATE PROCEDURE IF NOT EXISTS Sp_ReportKartuProyekBarang AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 

Select @Id=LEFT(@Id,1)

if @Id=''

if @isiList='' 

     exec('select ''Gabungan'' Perusahaan,a.*,Case When NOSAT=1 Then QntSaldo else Qnt2Saldo  Stok,bx.Qnt TotQntSO from [Vw_KartuProyekBarang] a

      Left Outer Join(select KodeBrg,SUM(QntSaldo)QntSaldo,SUM(Qnt2Saldo)Qnt2Saldo from vwKartuStock where Kodegdg in(''G01'' , ''G01@CA'')and ((Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+' and Tipe<>''AWL'')or(Bulan=MONTH('+@Tgl1+')and Tahun=Year('+@Tgl1+') and Tipe=''AWL'')) group by KodeBrg) vw on vw.Kodebrg=a.kdbrgSO

      Left Outer Join (select KODEBRG,SUM(Case WHen b.NOSAT=2 Then b.QNT2 when b.NOSAT=1 Then b.QNT )Qnt from DBSODET b left Outer Join DBSO a on a.NOBUKTI=b.NOBUKTI where Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+'  group by KODEBRG)bx On  bx.KODEBRG=a.kdbrgSO 

      where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

      order by kdbrgSO,KodePrj')

	 

 else

     exec('select ''Gabungan'' Perusahaan,a.*,Case When NOSAT=1 Then QntSaldo else Qnt2Saldo  Stok,bx.Qnt TotQntSO from [Vw_KartuProyekBarang] a

      Left Outer Join(select KodeBrg,SUM(QntSaldo)QntSaldo,SUM(Qnt2Saldo)Qnt2Saldo from vwKartuStock where Kodegdg in(''G01'' , ''G01@CA'')and ((Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+' and Tipe<>''AWL'')or(Bulan=MONTH('+@Tgl1+')and Tahun=Year('+@Tgl1+') and Tipe=''AWL'')) group by KodeBrg) vw on vw.Kodebrg=a.kdbrgSO

      Left Outer Join (select KODEBRG,SUM(Case WHen b.NOSAT=2 Then b.QNT2 when b.NOSAT=1 Then b.QNT )Qnt from DBSODET b left Outer Join DBSO a on a.NOBUKTI=b.NOBUKTI where Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+'  group by KODEBRG)bx On  bx.KODEBRG=a.kdbrgSO 

      where Filter IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

      order by kdbrgSO,KodePrj')


else

if @isiList='' 

     exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,a.*,Case When NOSAT=1 Then QntSaldo else Qnt2Saldo  Stok,bx.Qnt TotQntSO 

      from [Vw_KartuProyekBarang] a

      Left Outer Join(select KodeBrg,SUM(QntSaldo)QntSaldo,SUM(Qnt2Saldo)Qnt2Saldo from vwKartuStock where Kodegdg in(''G01'' , ''G01@CA'')and ((Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+' and Tipe<>''AWL'')or(Bulan=MONTH('+@Tgl1+')and Tahun=Year('+@Tgl1+') and Tipe=''AWL'')) group by KodeBrg) vw on vw.Kodebrg=a.kdbrgSO

      Left Outer Join (select KODEBRG,SUM(Case WHen b.NOSAT=2 Then b.QNT2 when b.NOSAT=1 Then b.QNT )Qnt from DBSODET b left Outer Join DBSO a on a.NOBUKTI=b.NOBUKTI where Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+' and '''+@ID+'''= Left(a.NoBukti,1) group by KODEBRG)bx On  bx.KODEBRG=a.kdbrgSO 

      where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

      and '''+@ID+'''= Left(NoBukti,1)

      order by kdbrgSO,KodePrj')

	 

 else

     exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,a.*,Case When NOSAT=1 Then QntSaldo else Qnt2Saldo  Stok,bx.Qnt TotQntSO 

      from [Vw_KartuProyekBarang] a

      Left Outer Join(select KodeBrg,SUM(QntSaldo)QntSaldo,SUM(Qnt2Saldo)Qnt2Saldo from vwKartuStock where Kodegdg in(''G01'' , ''G01@CA'')and ((Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+' and Tipe<>''AWL'')or(Bulan=MONTH('+@Tgl1+')and Tahun=Year('+@Tgl1+') and Tipe=''AWL'')) group by KodeBrg) vw on vw.Kodebrg=a.kdbrgSO

      Left Outer Join (select KODEBRG,SUM(Case WHen b.NOSAT=2 Then b.QNT2 when b.NOSAT=1 Then b.QNT )Qnt from DBSODET b left Outer Join DBSO a on a.NOBUKTI=b.NOBUKTI where Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+' and '''+@ID+'''= Left(a.NoBukti,1) group by KODEBRG)bx On  bx.KODEBRG=a.kdbrgSO 

      where Filter IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

      and '''+@ID+'''= Left(NoBukti,1)

      order by kdbrgSO,KodePrj');

-- Sp_reportkartuStock
CREATE PROCEDURE IF NOT EXISTS Sp_reportkartuStock AS /*

		select @kodegdg ='G003',

@Kodebrg ='EXCG 001',

@bulan1 =1,

@bulan2 =1,

@tahun1=2013,

@tahun2 =2013,

@periode1 ='201301',

@periode2 ='201301',

@Nosat =2



		-- DECLARE REMOVED,@Kodebrg varchar(15),@bulan1 int,@bulan2 int,@tahun1 int,@tahun2 int,

        @periode1 varchar(6),@periode2 varchar(6)

		Select @KodeGdg='G01' ,@KodeBrg='A-10109'

		select @Bulan1=10 ,@Tahun1=2012

		select @Bulan2=10 ,@Tahun2=2012

		Select @Periode1='201210'

		Select @Periode2='201210' */


/*Select 'AWL' Tipe, 'A0' Prioritas, X.KodeBrg, X.KodeGdg, sum(X.Qnt) Qnt, 

      sum(X.NilaiDPP) NilaiDPP, sum(X.NilaiPPN) NilaiPPN, sum(X.JumlahNetto) JumlahNetto, 

      0 QntDB, 0 HrgDebet, 0 QntCR, 0 HrgKredit, sum(X.QntSaldo) QntSaldo, 

      sum(HrgSaldo) HrgSaldo, max(X.Tanggal) Tanggal, @Bulan1 Bulan, @Tahun1 Tahun, 

      'Saldo Awal' NoBukti, '' Keterangan, 

      case when sum(X.QntSaldo)=0 then 0 else sum(X.HrgSaldo)/sum(X.QntSaldo)  * C.Isi1  HPP, C.NamaBrg

from 

(

select 'AWL' Tipe, 'A0' Prioritas, B.KodeBrg, B.KodeGdg, 

       B.QntAwal Qnt, B.HrgAwal NilaiDPP, 0 NilaiPPN, B.HrgAwal JumlahNetto,

       0 QntDB, 0 HrgDebet,

       0 QntCR, 0 HrgKredit,

       B.QntAwal QntSaldo,

       B.HrgAwal HrgSaldo,

       cast(@Periode1+'01' as Datetime) Tanggal,

       B.Bulan, B.Tahun, 'Saldo Awal' NoBukti, '' Keterangan,

       0 HPP

from dbStockBrg B Left Outer Join dbBarang C On c.KodeBrg=b.KodeBrg

Where B.Bulan=@bulan1 and B.Tahun=@Tahun1 and B.KodeGdg=@KodeGdg and B.KodeBrg=@KodeBrg*/


/*union all

Select A.Tipe, A.Prioritas, A.KodeBrg, A.KodeGdg, A.Qnt, A.NilaiDPP, A.NilaiPPN, A.JumlahNetto, 

      A.QntDB, A.HrgDebet, A.QntCR, A.HrgKredit, A.QntSaldo, A.HrgSaldo, A.Tanggal, A.Bulan, A.Tahun, 

      A.NoBukti, A.Keterangan, Case When '1'=1 Then A.HPP*B.Isi1 

When '1'=2 Then A.HPP*B.Isi2 

When '1'=3 Then A.HPP*B.Isi3  HPP 

from  vwKartuStock A Left Outer Join dbBarang B On A.KodeBrg=B.KodeBrg

where A.Tahun=@Tahun1 and A.Bulan<@Bulan1 

      and A.KodeGdg=@KodeGdg and A.KodeBrg=@KodeBrg 

) X 

left outer join dbBarang C on C.KodeBrg=X.KodeBrg 

group by X.KodeBrg, X.KodeGdg, C.NamaBrg,C.Isi1 

union all*/

if @Nosat=1

Select A.Tipe, A.Prioritas, A.KodeBrg, A.KodeGdg, A.Qnt Qnt, A.NilaiDPP, A.NilaiPPN, A.JumlahNetto, 

      case when A.Tipe='AWL' then 0 else A.QntDB  QntDB, case when A.Tipe='AWL' then 0 else A.HrgDebet  HrgDebet, 

      A.QntCR QntCR, A.HrgKredit, 

      A.QntSaldo QntSaldo, A.HrgSaldo, A.Tanggal, A.Bulan, A.Tahun, 

      A.NoBukti, A.Keterangan, Case When @Nosat=1 Then A.HPP*c.Isi1 

	When @Nosat=2 Then A.HPP*c.Isi2 

	When @Nosat=3 Then A.HPP*c.Isi3  HPP 

	, C.NamaBrg,c.SAT1 Satuan 

	from  vwKartuStock A left Outer join dbBarang C on C.KodeBrg=A.KodeBrg

	left outer join dbgroup D on c.kodegrp = d.kodegrp

	where (Cast(year(A.Tanggal) as varchar(4))+SUBSTR('0'+Cast(month(A.tanggal) as varchar(2)), LENGTH('0'+Cast(month(A.tanggal) as varchar(2)))-2+1) between @Periode1 and @Periode2)

	and (A.Tipe<>'AWL' or (A.Tipe='AWL' and A.Bulan=@bulan1 and A.Tahun=@tahun1))

      and A.KodeGdg=@KodeGdg and A.KodeBrg=@KodeBrg 

	Order by A.Tanggal, A.Prioritas, A.Nobukti, A.Urut


if @Nosat=2

Select A.Tipe, A.Prioritas, A.KodeBrg, A.KodeGdg, A.Qnt Qnt, A.NilaiDPP, A.NilaiPPN, A.JumlahNetto, 

      A.Qnt2DB QntDB, A.HrgDebet, 

      A.Qnt2Cr QntCR, A.HrgKredit, 

      A.Qnt2Saldo QntSaldo, A.HrgSaldo, A.Tanggal, A.Bulan, A.Tahun, 

      A.NoBukti, A.Keterangan, Case When @Nosat=1 Then A.HPP*c.Isi1 

	When @Nosat=2 Then A.HPP*c.Isi2 

	When @Nosat=3 Then A.HPP*c.Isi3  HPP 

	, C.NamaBrg,c.SAT2 Satuan 

	from  vwKartuStock A left Outer join dbBarang C on C.KodeBrg=A.KodeBrg

	left outer join dbgroup D on c.kodegrp = d.kodegrp

	where (Cast(year(A.Tanggal) as varchar(4))+SUBSTR('0'+Cast(month(A.tanggal) as varchar(2)), LENGTH('0'+Cast(month(A.tanggal) as varchar(2)))-2+1) between @Periode1 and @Periode2)

	and (A.Tipe<>'AWL' or (A.Tipe='AWL' and A.Bulan=@bulan1 and A.Tahun=@tahun1))

      and A.KodeGdg=@KodeGdg and A.KodeBrg=@KodeBrg 

    --and (A.Qnt2DB<>0 or A.QntDB<>0)  

	Order by A.Tanggal, A.Prioritas, A.Nobukti, A.Urut;

-- sp_ReportKomisiSales
CREATE PROCEDURE IF NOT EXISTS sp_ReportKomisiSales AS if @tipe=0 /*Piutang*/

select 	A.NoFaktur, A.KODECUSTSUPP as Kode, B.NAMACUSTSUPP as Nama, b.kota, min(A.Tanggal) as tanggal,

  		case when A.Valas='IDR' then sum(COALESCE(A.Debet,0)) else sum(COALESCE(A.DebetD,0))  as debet, 

		case when A.Valas='IDR' then sum(COALESCE(A.Kredit,0)) else  sum(COALESCE(A.KreditD,0))  as kredit,

         		case when A.Valas='IDR' then sum(COALESCE(A.Debet,0)-COALESCE(A.Kredit,0)) else sum(COALESCE(A.DebetD,0)-COALESCE(A.KreditD,0))  as Saldo,

		datepart(dy,@tanggal-min(A.Tanggal)) As Umur,

         		case when (datepart(dy,@tanggal-min(A.Tanggal))> 0) and (datepart(dy,@tanggal-min(A.Tanggal))<= 30) then

  			case when A.Valas='IDR' then sum(COALESCE(A.Kredit,0)) else  sum(COALESCE(A.KreditD,0)) 

         		else 0  as Saldo30,

         		case when (datepart(dy,@tanggal-min(A.Tanggal))> 0) and (datepart(dy,@tanggal-min(A.Tanggal))<= 30) and 

         	case when A.Valas='IDR' then sum(COALESCE(A.Debet,0)-COALESCE(A.Kredit,0)) else sum(COALESCE(A.DebetD,0)-COALESCE(A.KreditD,0))  =0 	and 

         	case when A.Valas='IDR' then sum(COALESCE(A.Debet,0)) else sum(COALESCE(A.DebetD,0))  <>0 then

         		1 else 0  Persentase1,

         		case when (datepart(dy,@tanggal-min(A.Tanggal))> 30) and (datepart(dy,@tanggal-min(A.Tanggal))<= 90) then

  		    	case when A.Valas='IDR' then sum(COALESCE(A.Kredit,0)) else  sum(COALESCE(A.KreditD,0)) 

         		else 0  as Saldo90,

         		case when (datepart(dy,@tanggal-min(A.Tanggal))> 30) and (datepart(dy,@tanggal-min(A.Tanggal))<= 90) and

         	case when A.Valas='IDR' then sum(COALESCE(A.Debet,0)-COALESCE(A.Kredit,0)) else sum(COALESCE(A.DebetD,0)-COALESCE(A.KreditD,0))  =0 

         	and case when A.Valas='IDR' then sum(COALESCE(A.Debet,0)) else sum(COALESCE(A.DebetD,0))  <>0 then

         		0.5 else 0  Persentase2,

         		case when (datepart(dy,@tanggal-min(A.Tanggal))> 90) Then

         	case when A.Valas='IDR' then sum(COALESCE(A.Kredit,0)) else  sum(COALESCE(A.KreditD,0)) 

         		else 0  as Saldo120,	

         		case when (datepart(dy,@tanggal-min(A.Tanggal))> 90) Then 0  Persentase3 

         		

  	from vwHutpiut A

  	left outer join DBCUSTSUPP B on B.KODECUSTSUPP=A.KodeCustSupp

  	where A.Tanggal<=@tanggal and A.KODECUSTSUPP>=@awal and A.KODECUSTSUPP<=@akhir and A.perkiraan=@perkiraan

		--and ((A.Valas='IDR' and ('11030100'='IDR' or A.TipeTrans='J')) or (A.Valas<>'IDR' and '11030100'=A.Valas))

  	group by A.NoFaktur, A.KODECUSTSUPP, B.NAMACUSTSUPP, b.kota,A.Valas

  	having 	(sum(COALESCE(A.Debet,0)-COALESCE(A.Kredit,0)) =0 and A.Valas='IDR') 

  	or (sum(COALESCE(A.DebetD,0)-COALESCE(A.KreditD,0)) =0 and A.Valas<>'IDR')

  	order by A.KODECUSTSUPP, min(A.Tanggal), A.NoFaktur

 else 

if @tipe=1

select 	A.NoFaktur, A.KODECUSTSUPP as Kode, B.NAMACUSTSUPP as Nama, b.kota, min(A.Tanggal) as tanggal,

  		case when A.Valas='IDR' then sum(COALESCE(A.Debet,0)) else sum(COALESCE(A.DebetD,0))  as debet, 

		case when A.Valas='IDR' then sum(COALESCE(A.Kredit,0)) else  sum(COALESCE(A.KreditD,0))  as kredit,

         		case when A.Valas='IDR' then sum(COALESCE(A.Debet,0)-COALESCE(A.Kredit,0)) else sum(COALESCE(A.DebetD,0)-COALESCE(A.KreditD,0))  as Saldo,

		datepart(dy,@tanggal-min(A.Tanggal)) As Umur,

         		case when (datepart(dy,@tanggal-min(A.Tanggal))> 0) and (datepart(dy,@tanggal-min(A.Tanggal))<= 30) then

  			case when A.Valas='IDR' then sum(COALESCE(A.Debet,0)-COALESCE(A.Kredit,0)) else sum(COALESCE(A.DebetD,0)-COALESCE(A.KreditD,0)) 

         		else 0  as Saldo30,

         		case when (datepart(dy,@tanggal-min(A.Tanggal))> 30) and (datepart(dy,@tanggal-min(A.Tanggal))<= 60) then

  			case when A.Valas='IDR' then sum(COALESCE(A.Debet,0)-COALESCE(A.Kredit,0)) else sum(COALESCE(A.DebetD,0)-COALESCE(A.KreditD,0)) 

         		else 0  as Saldo60,

         		case when (datepart(dy,@tanggal-min(A.Tanggal))> 60) and (datepart(dy,@tanggal-min(A.Tanggal))<= 90) then

  			case when A.Valas='IDR' then sum(COALESCE(A.Debet,0)-COALESCE(A.Kredit,0)) else sum(COALESCE(A.DebetD,0)-COALESCE(A.KreditD,0)) 

         		else 0  as Saldo90,

         		case when (datepart(dy,@tanggal-min(A.Tanggal))> 90) and (datepart(dy,@tanggal-min(A.Tanggal))<= 120) then

  			case when A.Valas='IDR' then sum(COALESCE(A.Debet,0)-COALESCE(A.Kredit,0)) else sum(COALESCE(A.DebetD,0)-COALESCE(A.KreditD,0)) 

         		else 0  as Saldo120,

         		case when (datepart(dy,@tanggal-min(A.Tanggal))> 120) then

  			case when A.Valas='IDR' then sum(COALESCE(A.Debet,0)-COALESCE(A.Kredit,0)) else sum(COALESCE(A.DebetD,0)-COALESCE(A.KreditD,0)) 

         		else 0  as Saldo121

  	from vwHutpiut A

  	left outer join DBCUSTSUPP B on B.KODECUSTSUPP=A.KodeCustSupp

  	where A.Tanggal<=@tanggal and A.KODECUSTSUPP>=@awal and A.KODECUSTSUPP<=@akhir and A.perkiraan=@perkiraan

		--and ((A.Valas='IDR' and ('11030100'='IDR' or A.TipeTrans='J')) or (A.Valas<>'IDR' and '11030100'=A.Valas))

  	group by A.Nofaktur, A.KODECUSTSUPP, B.NAMACUSTSUPP, b.kota,A.Valas

  	having 	(sum(COALESCE(A.Debet,0)-COALESCE(A.Kredit,0)) <>0 and A.Valas='IDR') or (sum(COALESCE(A.DebetD,0)-COALESCE(A.KreditD,0)) <>0 and A.Valas<>'IDR')

  	order by A.KODECUSTSUPP, A.NoFaktur, min(A.Tanggal);

-- Sp_ReportKontrakVsSJ
CREATE PROCEDURE IF NOT EXISTS Sp_ReportKontrakVsSJ AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 

select @Id=SUBSTRING(@Id,1,1)

if @Id=''

if @isiList='' 

     exec('select ''Gabungan'' Perusahaan,* from vwKontrakVsSJ where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

      order by KodeCustSupp,Kodeproject')

	 

 else

     exec('select ''Gabungan'' Perusahaan,* from vwKontrakVsSJ where KodeCustSupp IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

      order by Kodeproject,NOSO,KodeBrg')


else

if @isiList='' 

     exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from vwKontrakVsSJ where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

      and '''+@ID+'''= Left(NOSO,1)

      order by KodeCustSupp,Kodeproject')

	 

 else

     exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from vwKontrakVsSJ where KodeCustSupp IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

      and '''+@ID+'''= Left(NOSO,1)

      order by Kodeproject,NOSO,KodeBrg');

-- Sp_ReportKPVSSJ
CREATE PROCEDURE IF NOT EXISTS Sp_ReportKPVSSJ AS select @Id=SUBSTRING(@Id,1,1)

if @Id=''

if @KodeProject='-' 

 -- SET REMOVED''

 

Select 'Gabungan' Perusahaan,KodeProject,Lokasi,NAMAPROJECT,

KODESLS,Marketing,KodeCustSupp,NAMACUSTSUPP,

KodeBrg,NAMABRG,SUM(QntKirim)QntKirim,

QntSO,Satuan

from vwReportKPVSSJ

where KodeProject Like '%'+@KodeProject+'%'

and KODESLS=@KodeSls 

and Tanggal between @tglAwl and @TglAkhir

Group By KodeProject,Lokasi,NAMAPROJECT,

KODESLS,Marketing,KodeCustSupp,NAMACUSTSUPP,

KodeBrg,NAMABRG,QntSO,Satuan

Order by KodeProject,NAMACUSTSUPP



else

if @KodeProject='-' 

 -- SET REMOVED''

 

Select Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,KodeProject,Lokasi,NAMAPROJECT,

KODESLS,Marketing,KodeCustSupp,NAMACUSTSUPP,

KodeBrg,NAMABRG,SUM(QntKirim)QntKirim,

QntSO,Satuan

from vwReportKPVSSJ a

where KodeProject Like '%'+@KodeProject+'%'

and KODESLS=@KodeSls 

and  @Id=Left(a.NoBukti,1)

and Tanggal between @tglAwl and @TglAkhir

Group By KodeProject,Lokasi,NAMAPROJECT,

KODESLS,Marketing,KodeCustSupp,NAMACUSTSUPP,

KodeBrg,NAMABRG,QntSO,Satuan

Order by KodeProject,NAMACUSTSUPP;

-- Sp_ReportLabaKotor
CREATE PROCEDURE IF NOT EXISTS Sp_ReportLabaKotor AS -- DECLARE REMOVED (10)

select @Devisi=Devisi from dbDevisi where NamaDevisi=@ID

if @Id=''

if @SubGrp=''

select * from (

  select 'GABUNGAN' Perusahaan,NOBUKTI,NAMACUSTSUPP,KODEBRG,NAMABRG,case when NOBUKTI like '%SR%' then QntRetur else Qnt  Qnt,SAT_1 satuan,SAT_1,

  Harga,DISCTOT,dpp NDPPRp,HPP,dpphpp hpprp,Laba,Laba/case when COALESCE(dpp,0)=0 then 1 else dpp *100 Prs,KODESUBGRP from VwreportSPBPlusReturACC

  where Tanggal between @Awal and @Akhir --and HPP=0

  union all 

  select 'GABUNGAN' Perusahaan,NOBUKTI,NAMACUSTSUPP,KODEBRG,NAMABRG,QNT,SAT_1,SAT_1 satuan,HARGA,DISCTOT,NDPP*-1 NDPPRp,Hpp,DppHpp*-1 hpprp,Laba*-1 Laba,

  Laba/case when COALESCE(NDPP,0)=0 then 1 else NDPP *100 Prs,KODESUBGRP from VwReportRInvoicePenjualan 

  where Tanggal between @Awal and @Akhir --and HPP=0

  ) A order by KODESUBGRP,KODEBRG,Prs desc

 

else

 select * from (

  select 'GABUNGAN' Perusahaan,NOBUKTI,NAMACUSTSUPP,KODEBRG,NAMABRG,case when NOBUKTI like '%SR%' then QntRetur else Qnt  Qnt,SAT_1 satuan,SAT_1,

  Harga,DISCTOT,dpp NDPPRp,HPP,dpphpp hpprp,Laba,Laba/case when COALESCE(dpp,0)=0 then 1 else dpp *100 Prs,KODESUBGRP from VwreportSPBPlusReturACC

  where Tanggal between @Awal and @Akhir --and HPP=0

  and KODESUBGRP=@SubGrp

  union all 

  select 'GABUNGAN' Perusahaan,NOBUKTI,NAMACUSTSUPP,KODEBRG,NAMABRG,QNT,SAT_1,SAT_1 satuan,HARGA,DISCTOT,NDPP*-1 NDPPRp,Hpp,DppHpp*-1 hpprp,Laba*-1 Laba,

  Laba/case when COALESCE(NDPP,0)=0 then 1 else NDPP *100 Prs,KODESUBGRP from VwReportRInvoicePenjualan 

  where Tanggal between @Awal and @Akhir --and HPP=0

  and KODESUBGRP=@SubGrp

  ) A order by KODESUBGRP,KODEBRG,Prs desc


else

if @SubGrp=''

select * from (

  select Case When Devisi<>'02'  Then 'PT. BETON CITRA ABADI' else 'PT. CALVARY ABADI'  Perusahaan,NOBUKTI,NAMACUSTSUPP,KODEBRG,NAMABRG,case when NOBUKTI like '%SR%' then QntRetur else Qnt  Qnt,SAT_1 satuan,SAT_1,

  Harga,DISCTOT,dpp NDPPRp,HPP,dpphpp hpprp,Laba,Laba/case when COALESCE(dpp,0)=0 then 1 else dpp *100 Prs,KODESUBGRP from VwreportSPBPlusReturACC

  where Tanggal between @Awal and @Akhir and Devisi=@Devisi

  union all 

  select Case When Devisi<>'02'  Then 'PT. BETON CITRA ABADI' else 'PT. CALVARY ABADI'  Perusahaan,NOBUKTI,NAMACUSTSUPP,KODEBRG,NAMABRG,QNT,SAT_1,SAT_1 satuan,HARGA,DISCTOT,NDPP*-1 NDPPRp,Hpp,DppHpp*-1 hpprp,Laba*-1 Laba,

  Laba/case when COALESCE(NDPP,0)=0 then 1 else NDPP *100 Prs,KODESUBGRP from VwReportRInvoicePenjualan 

  where Tanggal between @Awal and @Akhir  and Devisi=@Devisi

  ) A order by KODESUBGRP,KODEBRG,Prs desc



else

  select * from (

  select Case When Devisi<>'02'  Then 'PT. BETON CITRA ABADI' else 'PT. CALVARY ABADI'  Perusahaan,NOBUKTI,NAMACUSTSUPP,KODEBRG,NAMABRG,case when NOBUKTI like '%SR%' then QntRetur else Qnt  Qnt,SAT_1 satuan,SAT_1,

  Harga,DISCTOT,dpp NDPPRp,HPP,dpphpp hpprp,Laba,Laba/case when COALESCE(dpp,0)=0 then 1 else dpp *100 Prs,KODESUBGRP from VwreportSPBPlusReturACC

  where Tanggal between @Awal and @Akhir and Devisi=@Devisi

  and KODESUBGRP=@SubGrp

  union all 

  select Case When Devisi<>'02'  Then 'PT. BETON CITRA ABADI' else 'PT. CALVARY ABADI'  Perusahaan,NOBUKTI,NAMACUSTSUPP,KODEBRG,NAMABRG,QNT,SAT_1,SAT_1 satuan,HARGA,DISCTOT,NDPP*-1 NDPPRp,Hpp,DppHpp*-1 hpprp,Laba*-1 Laba,

  Laba/case when COALESCE(NDPP,0)=0 then 1 else NDPP *100 Prs,KODESUBGRP from VwReportRInvoicePenjualan 

  where Tanggal between @Awal and @Akhir  and Devisi=@Devisi

  and KODESUBGRP=@SubGrp

  ) A order by KODESUBGRP,KODEBRG,Prs desc;

-- Sp_ReportLabaRugi
CREATE PROCEDURE IF NOT EXISTS Sp_ReportLabaRugi AS if @devisi in ('-','')

select @jumlahA=sum(TotalA),@jumlahB=sum(TotalB),@jumlahC=sum(TotalC) from DBLRHPP

   where bulan=@Bulan and tahun=@tahun and tampil='Y' and IsLRHPP=@prosesRlHpp and Persen='A'

   group by Nomor,Keterangan,jumlah,tipe,tanda,Persen,IsLRHPP,Bulan,Tahun,Perkiraan

   having COALESCE(sum(totala)+sum(TotalB)+sum(TotalC),0) <> case when Perkiraan='' and Jumlah='' then -1 else 0 


-- SET REMOVED Case when @devisi in ('-','') then '%' else @devisi 



   select case when Jumlah<>'' then '    '+Keterangan else Keterangan  keterangan,

   jumlah,sum(TotalA) TotalA,sum(TotalB) TotalB,sum(TotalC) TotalC,tipe,tanda,Persen,

        case when sum(TotalA)>=0 then sum(case when @jumlahA<>0 then (abs(TotalA/@jumlahA))*100 else 0 ) 

                  else (sum(case when @jumlahA<>0 then (abs(TotalA/@jumlahA))*100 else 0 ))*-1   P1,

        case when sum(TotalB)>=0 then sum(case when @jumlahB<>0 then (abs(TotalB/@jumlahB))*100 else 0 )

                  else (sum(case when @jumlahB<>0 then (abs(TotalB/@jumlahB))*100 else 0 ))*-1   P2,

        case when sum(TotalC)>=0 then sum(case when @jumlahC<>0 then (abs(TotalC/@jumlahC))*100 else 0 )

                  else (sum(case when @jumlahC<>0 then (abs(TotalC/@jumlahC))*100 else 0 ))*-1   P3,

        IsLRHPP,@devisi Devisi,Bulan,Tahun,Perkiraan

   from DBLRHPP

   where bulan=@Bulan and tahun=@tahun and devisi Like @devisi and tampil='Y' and IsLRHPP=@prosesRlHpp 

   group by Nomor,Keterangan,jumlah,tipe,tanda,Persen,IsLRHPP,Bulan,Tahun,Perkiraan

   having COALESCE(sum(totala)+sum(TotalB)+sum(TotalC),0) <> case when Perkiraan='' and Jumlah='' then -1 else 0 

   order by Nomor;

-- Sp_ReportLaporanStock
CREATE PROCEDURE IF NOT EXISTS Sp_ReportLaporanStock AS --Select @bulan=1, @tahun=2011, @kodegdg='A', @nosat=1

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

-- sp_ReportMonitoringPiutang
CREATE PROCEDURE IF NOT EXISTS sp_ReportMonitoringPiutang AS select * from (

	Select 	@tanggal tglakhir,Dateadd(dd,-1,'12-31-2000') Tanggal, null TglBayar,'Saldo Awal' NoFaktur,'' NoBukti, 

		0 as kredit1,

		0 as debet1, 

		0 as kreditd1,

      0 as debetd1, H.KODECUSTSUPP as kode,S.NAMACUSTSUPP as nama, S.ALAMAT1 Alamat,S.kota,

  		Sum(case when H.Debet <> 0 then H.Debet

       			when H.Kredit <> 0 then H.Kredit*-1 ) as SaldoRp,

  		Sum(case when H.DebetD <> 0 then H.DebetD

       			when H.KreditD <> 0 then H.KreditD*-1 ) as SaldoD,

		0 as Awal,0 as AwalD,''NoRetur,0urut,0 as totBayar,

		''P, 1 as xurut,'' H, 0 kurs,

		Sum(case when H.TipeTrans='J' then H.Kredit-H.Debet else 0 ) SelisihKurs,Prj.KODEPROJECT ,Prj.NAMAPROJECT,

		null TglKolektor,null TglTFaktur,null TglJTempo

 	from 	vwHutpiut H

 	Left outer join DBCUSTSUPP S on S.KODECUSTSUPP=H.KODECUSTSUPP 

 	Left Outer Join DBPROJECT Prj on Prj.KODEPROJECT=Case When H.TipeTrans='AWL' Then H.KodeSales else '' 

 	Where H.Tanggal<='12-31-2000' and H.KODECUSTSUPP>=@awal and H.KODECUSTSUPP<=@akhir

 	and H.perkiraan=@perkiraan

 	--and ((H.Valas=@KodeVls and @KodeVls<>'IDR') or (H.Valas like '%' and @KodeVls='IDR'))

 	Group by H.KODECUSTSUPP ,S.NAMACUSTSUPP , S.Alamat1, S.kota,Prj.KODEPROJECT ,Prj.NAMAPROJECT

 	union all

 	Select @tanggal tglakhir, case when H.TipeTrans='T' OR H.TipeTrans='AWL' then H.Tanggal else null  Tanggal,

 	case when H.TipeTrans='L' then H.Tanggal else null  TglBayar, 

 	case when H.TipeTrans='T' OR H.TipeTrans='AWL' OR left(H.NoFaktur,1)='U' OR H.NoFaktur='Lebih Bayar'   then H.NoFaktur else ''  NoFaktur, 

 	case when H.TipeTrans='L' then H.NoBukti else ''  NoBukti,

		--case when H.TipeTrans='J' then 0 else H.Kredit  as kredit1,

		--case when H.TipeTrans='J' then 0 else H.Debet  as debet1,

		case when H.TipeTrans='J' then 0 else case when H.NoRetur='' then H.Kredit else 0   as kredit1,

		case when H.TipeTrans='J' then 0 else case when H.NoRetur='' then H.Debet else -H.Kredit   as debet1,  

		--H.KreditD as kreditd1,

        --H.DebetD as debetd1,

        case when H.NoRetur='' then H.KreditD else 0  as kreditd1,

        case when H.NoRetur='' then H.DebetD else -H.KreditD  debetd1,  

        H.KODECUSTSUPP as kode, S.NAMACUSTSUPP nama, s.ALAMAT1 Alamat,S.kota,

  		case when H.Debet <> 0 then H.Debet

       			when H.Kredit <> 0 then H.Kredit*-1  as SaldoRp,

  		case when H.DebetD <> 0 then H.DebetD

       			when H.KreditD <> 0 then H.KreditD*-1

  		 as SaldoD,

		H.Debet as Awal, 0 as AwalD, NoRetur,h.urut, H.Kredit as totBayar,

		SUBSTR(h.nofaktur, LENGTH(h.nofaktur)-7+1),3 as xurut,SUBSTR(h.nofaktur, LENGTH(h.nofaktur)-4+1), h.Kurs,

		case when H.TipeTrans='J' then H.Kredit-H.Debet else 0  SelisihKurs,Prj.KODEPROJECT,Prj.NAMAPROJECT,

		Inv.StuffingDate TglKolektor,Inv.ShipOnBoardDate TglTFaktur,case when H.TipeTrans='T' OR H.TipeTrans='AWL' then H.Tanggal+30 else null  TglJTempo

 	from vwHutpiut H

 	Left Outer Join dbInvoicePL Inv On Inv.NoBukti=case when H.FlagSimbol='TL' then REPLACE(H.NoFaktur,SUBSTR(H.Nofaktur, LENGTH(H.Nofaktur)-2+1),'') else H.NoFaktur 

 	left outer join DBCUSTSUPP S on (S.KODECUSTSUPP=H.KODECUSTSUPP) 

 	Left Outer Join DBPROJECT Prj on Prj.KODEPROJECT=Case When H.TipeTrans='AWL' Then H.KodeSales else Inv.NoBL 

 	where H.KODECUSTSUPP>=@awal and H.KODECUSTSUPP<=@akhir

 	and (H.Tanggal>'12-31-2000' and H.Tanggal<=@tanggal)

 	and H.perkiraan=@perkiraan

 	and H.KodeCustSupp in (select a.KodeCustSupp KodeCust from vwHutpiut a

 	                                                                         left outer join DBCUSTSUPP b on(a.KodeCustSupp=b.KodeCustSupp)

 	                                                                         where  a.tanggal<=@tanggal

  		                                                                      and a.perkiraan=@perkiraan 

		                                                                      and (a.KodeCustSupp between @awal and @akhir)	

 	                                                                         group by a.KodeCustSupp

 	                                                                         having (sum(a.Debet)-sum(a.Kredit)) >0)

 	--and ((H.Valas=@KodeVls and @KodeVls<>'IDR') or (H.Valas like '%' and @KodeVls='IDR'))

 	) A

 	order by A.kode,A.KODEPROJECT,A.xurut,A.H,A.P,case when A.NoFaktur like '%INVC%' then 0 else 1 ,A.Tanggal,A.urut;

-- Sp_ReportMutasi
CREATE PROCEDURE IF NOT EXISTS Sp_ReportMutasi AS Select A.Perkiraan, A.Keterangan,B.MDRp MD,B.MKRp MK,  B.AkhirDRp SaldoDAkhir,

       B.JPD, B.JPDRp, B.JPK, B.JPKRp,

       B.AkhirKRp SaldoKAkhir, 

       Case when A.DK=0 then B.AwalDRp-B.AwalKRp 

            when A.DK=1 then B.AwalKRp-B.AwalDRp

            else 0

         SaldoAwal

from DBPERKIRAAN A

     Left Outer join DBNERACA B on B.Perkiraan=A.Perkiraan

where B.Bulan=@bulan and B.Tahun=@tahun and B.Devisi like Case when @devisi='-' then '%' else @devisi 

Order by A.Perkiraan;

-- sp_ReportNeracaAktiva
CREATE PROCEDURE IF NOT EXISTS sp_ReportNeracaAktiva AS -- SET REMOVEDCase when @devisi in ('-','') then '%' else @devisi 

select @devisi Divisi,(select P.keterangan from dbperkiraan P where P.perkiraan=C.perkiraan) as keterangan, substring(C.neraca,1,1) as grupAP1,

          substring(C.neraca,1,2) as grupAP2,

          COALESCE((select SUM((a.AwalDRp-a.AwalKRp)+(a.MDRp-a.MKRp)+(a.JPDRp-a.JPKRp)+(a.RLDRp-a.RLKRp))

          from dbneraca A,dbperkiraan B

          where A.bulan=@bulan and A.tahun=@tahun and A.perkiraan=B.perkiraan and substring(B.neraca,1,5)=substring(C.Neraca,1,5)

          and (a.Devisi like @devisi) ),0)  as jumlah1,

        

          COALESCE((select SUM((a.AwalDRp-a.AwalKRp)+(a.MDRp-a.MKRp)+(a.JPDRp-a.JPKRp)+(a.RLDRp-a.RLKRp))

          from dbneraca A,dbperkiraan B

          where A.bulan=@bulan-1 and A.tahun=@tahun and A.perkiraan=B.perkiraan and substring(B.neraca,1,5)=substring(C.Neraca,1,5)

          and (a.Devisi like @devisi) ),0)  as jumlah2

	

from dbperkiraan C

where len(C.neraca)=6 and substring(C.neraca,1,1)='A'  

order by C.neraca;

-- sp_ReportNeracaPasiva
CREATE PROCEDURE IF NOT EXISTS sp_ReportNeracaPasiva AS -- SET REMOVEDCase when @devisi in ('-','') then '%' else @devisi 

select @devisi Divisi,(select P.keterangan from dbperkiraan P where P.perkiraan=C.perkiraan) as keterangan, substring(C.neraca,1,1) as grupAP1,

          substring(C.neraca,1,2) as grupAP2,

          COALESCE((select SUM((a.AwalKRp-A.AwalDRp)+(a.MKRp-A.MDRp)+(a.JPKRp-A.JPDRp)+(a.RLKRp-A.RLDRp))

          from dbneraca A,dbperkiraan B

          where A.bulan=@bulan and A.tahun=@tahun and A.perkiraan=B.perkiraan and substring(B.neraca,1,5)=substring(C.Neraca,1,5) 

          and (a.Devisi like @devisi) ),0)  as jumlah1,

          

          COALESCE((select SUM((a.AwalKRp-A.AwalDRp)+(a.MKRp-A.MDRp)+(a.JPKRp-A.JPDRp)+(a.RLKRp-A.RLDRp))

          from dbneraca A,dbperkiraan B

          where A.bulan=@bulan-1 and A.tahun=@tahun and A.perkiraan=B.perkiraan and substring(B.neraca,1,5)=substring(C.Neraca,1,5) 

          and (a.Devisi like @devisi) ),0)  as jumlah2

		   

from dbperkiraan C

where len(C.neraca)=6 and substring(C.neraca,1,1)='P'  

order by C.neraca;

-- Sp_ReportOpnamebahan
CREATE PROCEDURE IF NOT EXISTS Sp_ReportOpnamebahan AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' if @Id=''

if @Id=''

if @SReport='T'

If @Ordr='N'

		If @Needoto=0 or @Needoto=1

		  select 'Gabungan' Perusahaan,* from VwreportOpnameBahan where Tanggal between @tgl1 and @tgl2 And NeedOtoRisasi=@Needoto

		   order by NoBukti,TANGGAL

		If @Needoto=2

		  select 'Gabungan' Perusahaan,* from VwreportOpnameBahan where Tanggal between @tgl1 and @tgl2 

		   order by NoBukti,TANGGAL

		 

	else If @Ordr='B'

		If @Needoto=0 or @Needoto=1

		  select 'Gabungan' Perusahaan,* from VwreportOpnameBahan where Tanggal between @tgl1 and @tgl2 And NeedOtoRisasi=@Needoto

		  order by KodeBrg

		If @Needoto=2

		  select 'Gabungan' Perusahaan,* from VwreportOpnameBahan where Tanggal between @tgl1 and @tgl2

		  order by KodeBrg


else

if @SReport='T'

If @Ordr='N'

		If @Needoto=0 or @Needoto=1

		  select Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwreportOpnameBahan where Tanggal between @tgl1 and @tgl2 And NeedOtoRisasi=@Needoto

		  and @Id=Case When Len(@ID)=3 Then Left(NoBukti,3) else Left(NoBukti,2)

		   order by NoBukti,TANGGAL

		If @Needoto=2

		  select Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwreportOpnameBahan where Tanggal between @tgl1 and @tgl2 

		  and @Id=Case When Len(@ID)=3 Then Left(NoBukti,3) else Left(NoBukti,2)

		   order by NoBukti,TANGGAL

		 

	else If @Ordr='B'

		If @Needoto=0 or @Needoto=1

		  select Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwreportOpnameBahan where Tanggal between @tgl1 and @tgl2 And NeedOtoRisasi=@Needoto

		  and @Id=Case When Len(@ID)=3 Then Left(NoBukti,3) else Left(NoBukti,2)

		  order by KodeBrg

		If @Needoto=2

		  select Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwreportOpnameBahan where Tanggal between @tgl1 and @tgl2

		  and @Id=Case When Len(@ID)=3 Then Left(NoBukti,3) else Left(NoBukti,2)

		  order by KodeBrg;

-- Sp_ReportOpnameBarang
CREATE PROCEDURE IF NOT EXISTS Sp_ReportOpnameBarang AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 

if @Id=''

if @SReport='T'

If @Ordr='N'

		If @NeeDoto=0 Or @NeeDoto=1

		  select 'Gabungan' Perusahaan,* from VwreportOPnamebarang where Tanggal between @tgl1 and @tgl2 and NeedOtorisasi=@NeeDoto

		  order by NoBukti,TANGGAL

		 If @NeeDoto=2

		  select * from VwreportOPnamebarang where Tanggal between @tgl1 and @tgl2 

		  order by NoBukti,TANGGAL

		 

	else If @Ordr='B'

		If @NeeDoto=0 Or @NeeDoto=1

		  select 'Gabungan' Perusahaan,* from VwreportOPnamebarang where Tanggal between @tgl1 and @tgl2 and NeedOtorisasi=@NeeDoto

		  order by KodeBrg

		If @NeeDoto=2

		  select * from VwreportOPnamebarang where Tanggal between @tgl1 and @tgl2 and NeedOtorisasi=@NeeDoto

		  order by KodeBrg


else

if @SReport='T'

If @Ordr='N'

		If @NeeDoto=0 Or @NeeDoto=1

		  select Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwreportOPnamebarang where Tanggal between @tgl1 and @tgl2 and NeedOtorisasi=@NeeDoto

		  and @Id=Case When Len(@ID)=3 Then Left(NoBukti,3) else Left(NoBukti,2)

		  order by NoBukti,TANGGAL

		 If @NeeDoto=2

		  select Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwreportOPnamebarang where Tanggal between @tgl1 and @tgl2 

		  and @Id=Case When Len(@ID)=3 Then Left(NoBukti,3) else Left(NoBukti,2)

		  order by NoBukti,TANGGAL

		 

	else If @Ordr='B'

		If @NeeDoto=0 Or @NeeDoto=1

		  select Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwreportOPnamebarang where Tanggal between @tgl1 and @tgl2 and NeedOtorisasi=@NeeDoto

		  and @Id=Case When Len(@ID)=3 Then Left(NoBukti,3) else Left(NoBukti,2)

		  order by KodeBrg

		If @NeeDoto=2

		  select Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwreportOPnamebarang where Tanggal between @tgl1 and @tgl2 and NeedOtorisasi=@NeeDoto

		  and @Id=Case When Len(@ID)=3 Then Left(NoBukti,3) else Left(NoBukti,2)

		  order by KodeBrg;

-- Sp_ReportOutSODet
CREATE PROCEDURE IF NOT EXISTS Sp_ReportOutSODet AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 

select @Id=SUBSTRING(@Id,1,1)

if @Id='' 

if @SReport='T'

If @Ordr='N'

		if @isiList='' 

		 exec('select ''Gabungan'' Perusahaan,* from vwreportoutSO where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		 order by NoBukti,Tanggal')

		 else

		 Exec('select ''Gabungan'' Perusahaan,* from vwreportoutSO where NoBukti IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

         order by NoBukti,Tanggal')

		 

	else If @Ordr='B'

		if @isiList=''

		 exec('select ''Gabungan'' Perusahaan,* from vwreportoutSO where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		 order by KodeBrg')

		else

		 exec('select ''Gabungan'' Perusahaan,* from vwreportoutSO where Kodebrg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		 order by KodeBrg') 

		 

	else If @Ordr='C'

		if @isiList=''

		exec(' select ''Gabungan'' Perusahaan,* from vwreportoutSO where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		order by KodeCustSupp')

		else

		exec(' select ''Gabungan'' Perusahaan,* from vwreportoutSO where KodeCustSupp IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		order by KodeCustSupp')


else

if @SReport='T'

If @Ordr='N'

		if @isiList='' 

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from vwreportoutSO where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		 and '''+@ID+'''= Left(NoBukti,1)

		 order by NoBukti,Tanggal')

		 else

		 Exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from vwreportoutSO where NoBukti IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

         and '''+@ID+'''= Left(NoBukti,1)

         order by NoBukti,Tanggal')

		 

	else If @Ordr='B'

		if @isiList=''

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from vwreportoutSO where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		 and '''+@ID+'''= Left(NoBukti,1)

		 order by KodeBrg')

		else

		 exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from vwreportoutSO where Kodebrg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+') 

		 and '''+@ID+'''= Left(NoBukti,1)

		 order by KodeBrg') 

		 

	else If @Ordr='C'

		if @isiList=''

		exec(' select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from vwreportoutSO where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		and '''+@ID+'''= Left(NoBukti,1)

		order by KodeCustSupp')

		else

		exec(' select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from vwreportoutSO where KodeCustSupp IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		and '''+@ID+'''= Left(NoBukti,1)

		order by KodeCustSupp');

-- Sp_ReportOutSORek
CREATE PROCEDURE IF NOT EXISTS Sp_ReportOutSORek AS ---- DECLARE REMOVED,@Tgl1 Datetime,@tgl2 datetime

--select @Tgl1='01/01/2012',@tgl2='07/17/2013',@Choice='B'

select @Id=SUBSTRING(@Id,1,1)

if @Id=''

If @Choice='N'

Select  'Gabungan' Perusahaan,A.Nobukti, P.Tanggal,P.KODECUST,C.NAMACUSTSUPP,P.NoPesanan,P.TGLJATUHTEMPO,P.TglKirim,

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

Select 'Gabungan' Perusahaan, A.KodeBrg,B.NAMABRG, P.Tanggal, 

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

Select 'Gabungan' Perusahaan, p.KODECUST,C.NAMACUSTSUPP, P.Tanggal,

        sum(COALESCE(A.Qnt,0)) Qnt, sum(COALESCE(A.Qnt2,0)) Qnt2, sum(COALESCE(A.QntSPP,0))QntSpp, 

        sum(COALESCE(A.Qnt2SPP,0)) Qnt2Spp, sum(COALESCE(A.QntSisa,0)) QntSisa,  sum(COALESCE(A.Qnt2Sisa,0)) Qnt2Sisa

	From    vwBrowsOutSO_SPP A

	Left Outer Join DBSO P on P.NoBukti=A.NoBukti

	Left Outer Join vwBrowsCustomer S on S.KodeCust=P.KodeCust and S.Sales=P.KODESLS

	Left Outer Join dbBarang B on B.KodeBrg=A.KodeBrg

	Left Outer join DBCUSTSUPP C on p.KODECUST = C.KODECUSTSUPP

	where A.islengkap=0 

	Group by  p.KODECUST,C.NAMACUSTSUPP, P.Tanggal

	order by  p.KODECUST,C.NAMACUSTSUPP, P.Tanggal



If @Choice='N'

Select  'Gabungan' Perusahaan,A.Nobukti, P.Tanggal,P.KODECUST,C.NAMACUSTSUPP,P.NoPesanan,P.TGLJATUHTEMPO,P.TglKirim,

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

Select  'Gabungan' Perusahaan,A.KodeBrg,B.NAMABRG, P.Tanggal, 

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

Select 'Gabungan' Perusahaan, p.KODECUST,C.NAMACUSTSUPP, P.Tanggal,

        sum(COALESCE(A.Qnt,0)) Qnt, sum(COALESCE(A.Qnt2,0)) Qnt2, sum(COALESCE(A.QntSPP,0))QntSpp, 

        sum(COALESCE(A.Qnt2SPP,0)) Qnt2Spp, sum(COALESCE(A.QntSisa,0)) QntSisa,  sum(COALESCE(A.Qnt2Sisa,0)) Qnt2Sisa

	From    vwBrowsOutSO_SPP A

	Left Outer Join DBSO P on P.NoBukti=A.NoBukti

	Left Outer Join vwBrowsCustomer S on S.KodeCust=P.KodeCust and S.Sales=P.KODESLS

	Left Outer Join dbBarang B on B.KodeBrg=A.KodeBrg

	Left Outer join DBCUSTSUPP C on p.KODECUST = C.KODECUSTSUPP

	where A.islengkap=0 

	Group by  p.KODECUST,C.NAMACUSTSUPP, P.Tanggal

	order by  p.KODECUST,C.NAMACUSTSUPP, P.Tanggal


else---------

If @Choice='N'

Select  Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,A.Nobukti, P.Tanggal,P.KODECUST,C.NAMACUSTSUPP,P.NoPesanan,P.TGLJATUHTEMPO,P.TglKirim,

        sum(COALESCE(A.Qnt,0)) Qnt, sum(COALESCE(A.Qnt2,0)) Qnt2, sum(COALESCE(A.QntSPP,0))QntSpp, 

        sum(COALESCE(A.Qnt2SPP,0)) Qnt2Spp, sum(COALESCE(A.QntSisa,0)) QntSisa,  sum(COALESCE(A.Qnt2Sisa,0)) Qnt2Sisa

	From    vwBrowsOutSO_SPP A

	Left Outer Join DBSO P on P.NoBukti=A.NoBukti

	Left Outer Join vwBrowsCustomer S on S.KodeCust=P.KodeCust and S.Sales=P.KODESLS

	Left Outer Join dbBarang B on B.KodeBrg=A.KodeBrg

	Left outer join DBCUSTSUPP C on p.KODECUST = C.KODECUSTSUPP

	where A.islengkap=0 

	and @Id= Left(a.NoBukti,1) 

	Group By A.nobukti,p.TANGGAL,P.KODECUST,C.NAMACUSTSUPP,P.NoPesanan,P.TGLJATUHTEMPO,P.TglKirim 

	order by A.NoBukti,p.TANGGAL,P.KODECUST,C.NAMACUSTSUPP 

 

else if @Choice='B'

Select   Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,A.KodeBrg,B.NAMABRG, P.Tanggal, 

        sum(COALESCE(A.Qnt,0)) Qnt, sum(COALESCE(A.Qnt2,0)) Qnt2, sum(COALESCE(A.QntSPP,0))QntSpp, 

        sum(COALESCE(A.Qnt2SPP,0)) Qnt2Spp, sum(COALESCE(A.QntSisa,0)) QntSisa,  sum(COALESCE(A.Qnt2Sisa,0)) Qnt2Sisa

	From    vwBrowsOutSO_SPP A

	Left Outer Join DBSO P on P.NoBukti=A.NoBukti

	Left Outer Join vwBrowsCustomer S on S.KodeCust=P.KodeCust and S.Sales=P.KODESLS

	Left Outer Join dbBarang B on B.KodeBrg=A.KodeBrg

	where A.islengkap=0 

	and @Id= Left(a.NoBukti,1) 

	Group by A.KodeBrg,B.NAMABRG,P.TANGGAL

	order by A.KodeBrg,B.NAMABRG,P.TANGGAL



else if @Choice='C'

Select   Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,p.KODECUST,C.NAMACUSTSUPP, P.Tanggal,

        sum(COALESCE(A.Qnt,0)) Qnt, sum(COALESCE(A.Qnt2,0)) Qnt2, sum(COALESCE(A.QntSPP,0))QntSpp, 

        sum(COALESCE(A.Qnt2SPP,0)) Qnt2Spp, sum(COALESCE(A.QntSisa,0)) QntSisa,  sum(COALESCE(A.Qnt2Sisa,0)) Qnt2Sisa

	From    vwBrowsOutSO_SPP A

	Left Outer Join DBSO P on P.NoBukti=A.NoBukti

	Left Outer Join vwBrowsCustomer S on S.KodeCust=P.KodeCust and S.Sales=P.KODESLS

	Left Outer Join dbBarang B on B.KodeBrg=A.KodeBrg

	Left Outer join DBCUSTSUPP C on p.KODECUST = C.KODECUSTSUPP

	where A.islengkap=0 

	and @Id= Left(a.NoBukti,1) 

	Group by  p.KODECUST,C.NAMACUSTSUPP, P.Tanggal

	order by  p.KODECUST,C.NAMACUSTSUPP, P.Tanggal



If @Choice='N'

Select   Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,A.Nobukti, P.Tanggal,P.KODECUST,C.NAMACUSTSUPP,P.NoPesanan,P.TGLJATUHTEMPO,P.TglKirim,

        sum(COALESCE(A.Qnt,0)) Qnt, sum(COALESCE(A.Qnt2,0)) Qnt2, sum(COALESCE(A.QntSPP,0))QntSpp, 

        sum(COALESCE(A.Qnt2SPP,0)) Qnt2Spp, sum(COALESCE(A.QntSisa,0)) QntSisa,  sum(COALESCE(A.Qnt2Sisa,0)) Qnt2Sisa

	From    vwBrowsOutSO_SPP A

	Left Outer Join DBSO P on P.NoBukti=A.NoBukti

	Left Outer Join vwBrowsCustomer S on S.KodeCust=P.KodeCust and S.Sales=P.KODESLS

	Left Outer Join dbBarang B on B.KodeBrg=A.KodeBrg

	Left outer join DBCUSTSUPP C on p.KODECUST = C.KODECUSTSUPP

	where A.islengkap=0 

	and @Id= Left(a.NoBukti,1) 

	Group By A.nobukti,p.TANGGAL,P.KODECUST,C.NAMACUSTSUPP,P.NoPesanan,P.TGLJATUHTEMPO,P.TglKirim 

	order by A.NoBukti,p.TANGGAL,P.KODECUST,C.NAMACUSTSUPP 

 

else if @Choice='B'

Select   Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,A.KodeBrg,B.NAMABRG, P.Tanggal, 

        sum(COALESCE(A.Qnt,0)) Qnt, sum(COALESCE(A.Qnt2,0)) Qnt2, sum(COALESCE(A.QntSPP,0))QntSpp, 

        sum(COALESCE(A.Qnt2SPP,0)) Qnt2Spp, sum(COALESCE(A.QntSisa,0)) QntSisa,  sum(COALESCE(A.Qnt2Sisa,0)) Qnt2Sisa

	From    vwBrowsOutSO_SPP A

	Left Outer Join DBSO P on P.NoBukti=A.NoBukti

	Left Outer Join vwBrowsCustomer S on S.KodeCust=P.KodeCust and S.Sales=P.KODESLS

	Left Outer Join dbBarang B on B.KodeBrg=A.KodeBrg

	where A.islengkap=0 

	and @Id= Left(a.NoBukti,1) 

	Group by A.KodeBrg,B.NAMABRG,P.TANGGAL

	order by A.KodeBrg,B.NAMABRG,P.TANGGAL



else if @Choice='C'

Select  Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan, p.KODECUST,C.NAMACUSTSUPP, P.Tanggal,

        sum(COALESCE(A.Qnt,0)) Qnt, sum(COALESCE(A.Qnt2,0)) Qnt2, sum(COALESCE(A.QntSPP,0))QntSpp, 

        sum(COALESCE(A.Qnt2SPP,0)) Qnt2Spp, sum(COALESCE(A.QntSisa,0)) QntSisa,  sum(COALESCE(A.Qnt2Sisa,0)) Qnt2Sisa

	From    vwBrowsOutSO_SPP A

	Left Outer Join DBSO P on P.NoBukti=A.NoBukti

	Left Outer Join vwBrowsCustomer S on S.KodeCust=P.KodeCust and S.Sales=P.KODESLS

	Left Outer Join dbBarang B on B.KodeBrg=A.KodeBrg

	Left Outer join DBCUSTSUPP C on p.KODECUST = C.KODECUSTSUPP

	where A.islengkap=0 

	and @Id= Left(a.NoBukti,1) 

	Group by  p.KODECUST,C.NAMACUSTSUPP, P.Tanggal

	order by  p.KODECUST,C.NAMACUSTSUPP, P.Tanggal;

-- Sp_ReportOUtSPBDet
CREATE PROCEDURE IF NOT EXISTS Sp_ReportOUtSPBDet AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 

select @Id=SUBSTRING(@Id,1,1)

if @Id='' 

if @SReport='T'

If @Ordr='N'

		select 'Gabungan' Perusahaan,* from VwreportOutSPBN(@tgl1,@tgl2) where Tanggal between @tgl1 and @tgl2 and noso<>'' order by NoBukti,Tanggal


	else If @Ordr='B'

		select 'Gabungan' Perusahaan,* from VwreportOutSPBN(@tgl1,@tgl2) where Tanggal between @tgl1 and @tgl2 and noso<>'' order by KodeBrg

		 

	else If @Ordr='C'

		select 'Gabungan' Perusahaan,* from VwreportOutSPBN(@tgl1,@tgl2) where Tanggal between @tgl1 and @tgl2 and noso<>'' order by KodeCustSupp,Nobukti


else

if @SReport='T'

If @Ordr='N'

		select Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwreportOutSPBN(@tgl1,@tgl2) where Tanggal between @tgl1 and @tgl2 and noso<>'' 

		  and  @Id= Left(NoBukti,1)

		  order by NoBukti,Tanggal


	else If @Ordr='B'

		select Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwreportOutSPBN(@tgl1,@tgl2) where Tanggal between @tgl1 and @tgl2 and noso<>'' 

		   and  @Id= Left(NoBukti,1)

		  order by KodeBrg

		 

	else If @Ordr='C'

		select Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwreportOutSPBN(@tgl1,@tgl2) where Tanggal between @tgl1 and @tgl2 and noso<>'' 

		   and  @Id= Left(NoBukti,1)

		  order by KodeCustSupp,Nobukti;

-- Sp_ReportOUtSPBRek
CREATE PROCEDURE IF NOT EXISTS Sp_ReportOUtSPBRek AS ---- DECLARE REMOVED,@Tgl1 DateTime,@Tgl2 Datetime

--Select @Choice='B',@Tgl1='01/01/2011',@Tgl2='01/01/2013'

select @Id=SUBSTRING(@Id,1,1)

if @Id='' 

If @Choice='N'

Select 'Gabungan' Perusahaan,A.NoBukti,C.Tanggal,C.KodeCustSupp,D.NAMACUSTSUPP,

	 Sum(COALESCE(A.QNT,0))QNT,SUM(COALESCE(A.QNT2,0)) Qnt2,

	 Sum(COALESCE(A.NetW,0)) NetW,SUM(COALESCE(GrossW,0)) Grossw

	 from dbSPBDet A

     left outer join DBBARANG B on B.KODEBRG=A.Kodebrg

     Left Outer join dbSPB C on A.NoBukti = C.NoBukti

     Left Outer join DBCUSTSUPP D on c.KodeCustSupp = D.KODECUSTSUPP

     Group By A.NoBukti,C.Tanggal,C.KodeCustSupp,D.NAMACUSTSUPP

     order BY A.NoBukti,C.Tanggal

     

If @Choice='B'

Select 'Gabungan' Perusahaan,A.KodeBrg,B.NAMABRG,C.Tanggal,Sum(COALESCE(A.QNT,0))QNT,SUM(COALESCE(A.QNT2,0)) Qnt2,

	 Sum(COALESCE(A.NetW,0)) NetW,SUM(COALESCE(GrossW,0)) Grossw

	 from dbSPBDet A

     left outer join DBBARANG B on B.KODEBRG=A.Kodebrg

     Left Outer join dbSPB C on A.NoBukti = C.NoBukti

     Left Outer join DBCUSTSUPP D on c.KodeCustSupp = D.KODECUSTSUPP

     Group By A.KodeBrg,B.NAMABRG,C.Tanggal

     order BY A.KodeBrg,B.NAMABRG,C.Tanggal

  

If @Choice='C'

Select 'Gabungan' Perusahaan,C.KodeCustSupp,D.NAMACUSTSUPP,C.Tanggal,Sum(COALESCE(A.QNT,0))QNT,SUM(COALESCE(A.QNT2,0)) Qnt2,

	 Sum(COALESCE(A.NetW,0)) NetW,SUM(COALESCE(GrossW,0)) Grossw

	 from dbSPBDet A

     left outer join DBBARANG B on B.KODEBRG=A.Kodebrg

     Left Outer join dbSPB C on A.NoBukti = C.NoBukti

     Left Outer join DBCUSTSUPP D on c.KodeCustSupp = D.KODECUSTSUPP

     Group By C.KodeCustSupp,D.NAMACUSTSUPP,C.Tanggal

     order BY C.KodeCustSupp,D.NAMACUSTSUPP,C.Tanggal


else

If @Choice='N'

Select Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,A.NoBukti,C.Tanggal,C.KodeCustSupp,D.NAMACUSTSUPP,

	 Sum(COALESCE(A.QNT,0))QNT,SUM(COALESCE(A.QNT2,0)) Qnt2,

	 Sum(COALESCE(A.NetW,0)) NetW,SUM(COALESCE(GrossW,0)) Grossw

	 from dbSPBDet A

     left outer join DBBARANG B on B.KODEBRG=A.Kodebrg

     Left Outer join dbSPB C on A.NoBukti = C.NoBukti

     Left Outer join DBCUSTSUPP D on c.KodeCustSupp = D.KODECUSTSUPP

     where  @Id= Left(a.NoBukti,1)

     Group By A.NoBukti,C.Tanggal,C.KodeCustSupp,D.NAMACUSTSUPP

     order BY A.NoBukti,C.Tanggal

     

If @Choice='B'

Select Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,A.KodeBrg,B.NAMABRG,C.Tanggal,Sum(COALESCE(A.QNT,0))QNT,SUM(COALESCE(A.QNT2,0)) Qnt2,

	 Sum(COALESCE(A.NetW,0)) NetW,SUM(COALESCE(GrossW,0)) Grossw

	 from dbSPBDet A

     left outer join DBBARANG B on B.KODEBRG=A.Kodebrg

     Left Outer join dbSPB C on A.NoBukti = C.NoBukti

     Left Outer join DBCUSTSUPP D on c.KodeCustSupp = D.KODECUSTSUPP

      where  @Id= Left(a.NoBukti,1)

     Group By A.KodeBrg,B.NAMABRG,C.Tanggal

     order BY A.KodeBrg,B.NAMABRG,C.Tanggal

  

If @Choice='C'

Select Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,C.KodeCustSupp,D.NAMACUSTSUPP,C.Tanggal,Sum(COALESCE(A.QNT,0))QNT,SUM(COALESCE(A.QNT2,0)) Qnt2,

	 Sum(COALESCE(A.NetW,0)) NetW,SUM(COALESCE(GrossW,0)) Grossw

	 from dbSPBDet A

     left outer join DBBARANG B on B.KODEBRG=A.Kodebrg

     Left Outer join dbSPB C on A.NoBukti = C.NoBukti

     Left Outer join DBCUSTSUPP D on c.KodeCustSupp = D.KODECUSTSUPP

      where  @Id= Left(a.NoBukti,1)

     Group By C.KodeCustSupp,D.NAMACUSTSUPP,C.Tanggal

     order BY C.KodeCustSupp,D.NAMACUSTSUPP,C.Tanggal;

-- Sp_ReportOutSpk
CREATE PROCEDURE IF NOT EXISTS Sp_ReportOutSpk AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 



if @SReport='T'

If @Ordr='N'

		select * from VwreportOUtSPK where Tanggal between @tgl1 and @tgl2 order by NoBukti,TANGGAL

		 

	else If @Ordr='B'

		select * from VwreportOUtSPK where Tanggal between @tgl1 and @tgl2 order by KodeBrg;

-- Sp_ReportOutSPPdet
CREATE PROCEDURE IF NOT EXISTS Sp_ReportOutSPPdet AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 

select @Id=SUBSTRING(@Id,1,1)

if @Id=''

if @SReport='T'

If @Ordr='N'

		select 'Gabungan' Perusahaan,* from VwReportOutSPP where Tanggal between @tgl1 and @tgl2 order by NoBukti,Tanggal

		 

	else If @Ordr='B'

		select 'Gabungan' Perusahaan,* from VwReportOutSPP where Tanggal between @tgl1 and @tgl2 order by KodeBrg

		 

	else If @Ordr='C'

		select 'Gabungan' Perusahaan,* from VwReportOutSPP where Tanggal between @tgl1 and @tgl2 order by KodeCustSupp


else

if @SReport='T'

If @Ordr='N'

		select Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwReportOutSPP where Tanggal between @tgl1 and @tgl2 

		  and @Id= Left(NoBukti,1) 

		  order by NoBukti,Tanggal

		 

	else If @Ordr='B'

		select Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwReportOutSPP where Tanggal between @tgl1 and @tgl2 

		  and @Id= Left(NoBukti,1)  

		  order by KodeBrg

		 

	else If @Ordr='C'

		select Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwReportOutSPP where Tanggal between @tgl1 and @tgl2 

		  and @Id= Left(NoBukti,1)  

		  order by KodeCustSupp;

-- Sp_ReportOutSppRek
CREATE PROCEDURE IF NOT EXISTS Sp_ReportOutSppRek AS ---- DECLARE REMOVED,@Tgl1 Datetime,@tgl2 datetime

--select @Tgl1='01/01/2012',@tgl2='07/17/2013',@Choice='B'

select @Id=SUBSTRING(@Id,1,1)

if @Id=''

If @Choice='N'

Select   'Gabungan' Perusahaan,A.Nobukti, P.Tanggal,P.KodeCustSupp,x.NAMACUSTSUPP,P.TglKirim,

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

Select   'Gabungan' Perusahaan,A.KodeBrg,B.NAMABRG, P.Tanggal,

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

Select  'Gabungan' Perusahaan,P.KodeCustSupp,S.namaCust NamaCustSupp, P.Tanggal,

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

		Order By  P.KodeCustSupp,S.namaCust, P.Tanggal


else

If @Choice='N'

Select   Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,A.Nobukti, P.Tanggal,P.KodeCustSupp,x.NAMACUSTSUPP,P.TglKirim,

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

		and @Id= Left(a.NoBukti,1) 

		Group by A.Nobukti, P.Tanggal,A.NoSat,P.KodeCustSupp,x.NAMACUSTSUPP,P.TglKirim

		Order By A.Nobukti, P.Tanggal



else If @Choice='B'

Select   Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,A.KodeBrg,B.NAMABRG, P.Tanggal,

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

		and @Id= Left(a.NoBukti,1) 

		Group by  A.KodeBrg,B.NAMABRG, P.Tanggal,A.NoSat

		Order By  A.KodeBrg,B.NAMABRG, P.Tanggal



else If @Choice='C'

Select Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan, P.KodeCustSupp,S.namaCust NamaCustSupp, P.Tanggal,

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

		and @Id= Left(a.NoBukti,1) 

		Group by  P.KodeCustSupp,S.namaCust, P.Tanggal,A.NoSat

		Order By  P.KodeCustSupp,S.namaCust, P.Tanggal;

-- Sp_reportOutStandingBPPBRek
CREATE PROCEDURE IF NOT EXISTS Sp_reportOutStandingBPPBRek AS ---- DECLARE REMOVED (1),@tgl1 datetime,@tgl2 DateTime

--Select @Choice='N',@tgl1='10/10/2010',@tgl2='10/10/2013'  



if @Choice='N'

Select a.NoBukti,Tanggal,Sum(COALESCE(Qnt,0)) Qnt,Sum(COALESCE(Qnt2,0)) Qnt2

	From dbBPPB a Left Outer Join dbBPPBDet b On a.NoBukti=b.NoBukti

	left Outer Join dbBarang c On c.KodeBrg=b.KodeBrg

	where Qnt<>Qnt2 and TANGGAL between @tgl1 and @tgl2

	Group By a.NoBukti,Tanggal

	order By a.NoBukti,Tanggal



if @Choice='B'

Select b.KodeBrg,c.NamaBrg,Sum(COALESCE(Qnt,0)) Qnt,Sum(COALESCE(Qnt2,0)) Qnt2

	From dbBPPB a Left Outer Join dbBPPBDet b On a.NoBukti=b.NoBukti

	left Outer Join dbBarang c On c.KodeBrg=b.KodeBrg

	where Qnt<>Qnt2 and TANGGAL between @tgl1 and @tgl2

	Group By b.KodeBrg,c.NamaBrg

	order By b.KodeBrg,c.NamaBrg;

-- Sp_reportoutStandingPOdet
CREATE PROCEDURE IF NOT EXISTS Sp_reportoutStandingPOdet AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 



if @Id=''

if @SReport='T'

If @Ordr='N'

		select 'Gabungan' Perusahaan,* from VwReportOutStandingPO where (Tanggal between @tgl1 and @tgl2) /*and COALESCE(TglSlshKrm,0)>@Sls*/ order by NoBukti,Tanggal

		 

	else If @Ordr='B'

		select 'Gabungan' Perusahaan,* from VwReportOutStandingPO where (Tanggal between @tgl1 and @tgl2) /*and COALESCE(TglSlshKrm,0)>@Sls*/ order by KodeBrg

		 

	else If @Ordr='S'

		select 'Gabungan' Perusahaan,* from VwReportOutStandingPO where (Tanggal between @tgl1 and @tgl2) /*and COALESCE(TglSlshKrm,0)>@Sls*/ order by KodeCustSupp


else

if @SReport='T'

If @Ordr='N'

		select Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwReportOutStandingPO where (Tanggal between @tgl1 and @tgl2) 

		  and @Id=Case When Len(@ID)=3 Then Left(NoBukti,3) else Left(NoBukti,2)

		  /*and COALESCE(TglSlshKrm,0)>@Sls*/ order by NoBukti,Tanggal

		 

	else If @Ordr='B'

		select Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwReportOutStandingPO where (Tanggal between @tgl1 and @tgl2)

		  and @Id=Case When Len(@ID)=3 Then Left(NoBukti,3) else Left(NoBukti,2)

		   /*and COALESCE(TglSlshKrm,0)>@Sls*/ order by KodeBrg

		 

	else If @Ordr='S'

		select Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from VwReportOutStandingPO where (Tanggal between @tgl1 and @tgl2) 

		  and @Id=Case When Len(@ID)=3 Then Left(NoBukti,3) else Left(NoBukti,2)

		  /*and COALESCE(TglSlshKrm,0)>@Sls*/ order by KodeCustSupp;

-- Sp_ReportOutStandingPORek
CREATE PROCEDURE IF NOT EXISTS Sp_ReportOutStandingPORek AS ---- DECLARE REMOVED,@Tgl1 Datetime,@tgl2 datetime

--select @Tgl1='01/01/2012',@tgl2='07/17/2013',@Choice='B'



if @Id=''

If @Choice='N'

Select 	'Gabungan' Perusahaan,A.NoBukti,I.TANGGAL,I.KODESUPP KOdeCustSupp,J.NAMACUSTSUPP,SUM(COALESCE(A.QntPO,0)) QntPO,

	SUM(COALESCE(A.QNTOS,0)) QNTOS,SUM(COALESCE(A.QntBeliSat1,0)) QNTBeliSat1

	From vwOutstandingPO A

	Left Outer Join dbBarang H on H.KodeBrg=A.KodeBrg

	Left Outer Join DBPO I on A.NoBukti = I.NOBUKTI

	left Outer Join DBCUSTSUPP J on I.KODESUPP = J.KODECUSTSUPP

	where I.TANGGAL between @Tgl1 and @tgl2

	Group BY A.NoBukti,I.TANGGAL,I.KODESUPP,J.NAMACUSTSUPP

	Order By A.NoBukti,I.TANGGAL



else IF @Choice='S'

Select 	'Gabungan' Perusahaan,I.TANGGAL,I.KODESUPP KOdeCustSupp,J.NAMACUSTSUPP,SUM(COALESCE(A.QntPO,0)) QntPO,

	SUM(COALESCE(A.QNTOS,0)) QNTOS,SUM(COALESCE(A.QntBeliSat1,0)) QNTBeliSat1

	From vwOutstandingPO A

	Left Outer Join dbBarang H on H.KodeBrg=A.KodeBrg

	Left Outer Join DBPO I on A.NoBukti = I.NOBUKTI

	left Outer Join DBCUSTSUPP J on I.KODESUPP = J.KODECUSTSUPP

	where I.TANGGAL between @Tgl1 and @tgl2

	Group BY I.TANGGAL,I.KODESUPP,J.NAMACUSTSUPP

	Order By I.KODESUPP,I.TANGGAL



else IF @Choice='B'

Select 	'Gabungan' Perusahaan,A.KodeBrg,H.NAMABRG,I.TANGGAL,SUM(COALESCE(A.QntPO,0)) QntPO,

	SUM(COALESCE(A.QNTOS,0)) QNTOS,SUM(COALESCE(A.QntBeliSat1,0)) QNTBeliSat1

	From vwOutstandingPO A

	Left Outer Join dbBarang H on H.KodeBrg=A.KodeBrg

	Left Outer Join DBPO I on A.NoBukti = I.NOBUKTI

	left Outer Join DBCUSTSUPP J on I.KODESUPP = J.KODECUSTSUPP

	where I.TANGGAL between @Tgl1 and @tgl2

	Group BY A.KodeBrg,H.NAMABRG,I.TANGGAL

	Order By A.KodeBrg,H.NAMABRG,I.TANGGAL



------------

else

If @Choice='N'

Select 	Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,A.NoBukti,I.TANGGAL,I.KODESUPP KOdeCustSupp,J.NAMACUSTSUPP,SUM(COALESCE(A.QntPO,0)) QntPO,

	SUM(COALESCE(A.QNTOS,0)) QNTOS,SUM(COALESCE(A.QntBeliSat1,0)) QNTBeliSat1

	From vwOutstandingPO A

	Left Outer Join dbBarang H on H.KodeBrg=A.KodeBrg

	Left Outer Join DBPO I on A.NoBukti = I.NOBUKTI

	left Outer Join DBCUSTSUPP J on I.KODESUPP = J.KODECUSTSUPP

	where I.TANGGAL between @Tgl1 and @tgl2

	and @Id=Case When Len(@ID)=3 Then Left(a.NoBukti,3) else Left(a.NOBUKTI,2)

	Group BY A.NoBukti,I.TANGGAL,I.KODESUPP,J.NAMACUSTSUPP

	Order By A.NoBukti,I.TANGGAL



else IF @Choice='S'

Select 	Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,I.TANGGAL,I.KODESUPP KOdeCustSupp,J.NAMACUSTSUPP,SUM(COALESCE(A.QntPO,0)) QntPO,

	SUM(COALESCE(A.QNTOS,0)) QNTOS,SUM(COALESCE(A.QntBeliSat1,0)) QNTBeliSat1

	From vwOutstandingPO A

	Left Outer Join dbBarang H on H.KodeBrg=A.KodeBrg

	Left Outer Join DBPO I on A.NoBukti = I.NOBUKTI

	left Outer Join DBCUSTSUPP J on I.KODESUPP = J.KODECUSTSUPP

	where I.TANGGAL between @Tgl1 and @tgl2

	and @Id=Case When Len(@ID)=3 Then Left(a.NoBukti,3) else Left(a.NOBUKTI,2)

	Group BY I.TANGGAL,I.KODESUPP,J.NAMACUSTSUPP

	Order By I.KODESUPP,I.TANGGAL



else IF @Choice='B'

Select 	Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,A.KodeBrg,H.NAMABRG,I.TANGGAL,SUM(COALESCE(A.QntPO,0)) QntPO,

	SUM(COALESCE(A.QNTOS,0)) QNTOS,SUM(COALESCE(A.QntBeliSat1,0)) QNTBeliSat1

	From vwOutstandingPO A

	Left Outer Join dbBarang H on H.KodeBrg=A.KodeBrg

	Left Outer Join DBPO I on A.NoBukti = I.NOBUKTI

	left Outer Join DBCUSTSUPP J on I.KODESUPP = J.KODECUSTSUPP

	where I.TANGGAL between @Tgl1 and @tgl2

	and @Id=Case When Len(@ID)=3 Then Left(a.NoBukti,3) else Left(a.NOBUKTI,2)

	Group BY A.KodeBrg,H.NAMABRG,I.TANGGAL

	Order By A.KodeBrg,H.NAMABRG,I.TANGGAL;

-- Sp_reportoutStandingPR
CREATE PROCEDURE IF NOT EXISTS Sp_reportoutStandingPR AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 

if @Id=''

if @SReport='T'

If @Ordr='N'

		select 'Gabungan' Perusahaan,* from [vwOutPPL] 

		  order by NoBukti,Tanggal

		 

	else If @Ordr='B'

		select 'Gabungan' Perusahaan,* from [vwOutPPL] order by KodeBrg


else

if @SReport='T'

If @Ordr='N'

		select Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from [vwOutPPL] 

		  where  @Id=Case When Len(@ID)=3 Then Left(NoBukti,3) else Left(NoBukti,2)

		  order by NoBukti,Tanggal

		 

	else If @Ordr='B'

		select Case When @Id='BCA' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,* from [vwOutPPL] 

		  where  @Id=Case When Len(@ID)=3 Then Left(NoBukti,3) else Left(NoBukti,2)

		  order by KodeBrg;

-- Sp_ReportOutStandingSoDet
CREATE PROCEDURE IF NOT EXISTS Sp_ReportOutStandingSoDet AS ---- DECLARE REMOVED,@Ordr varchar(1),@tgl1 datetime,@tgl2 Datetime,@isiList varchar(200)

--select @SReport='T',@Ordr='S', @tgl1='01/01/2011',@tgl2='01/01/2013',@isiList='%%' 

select @Id=SUBSTRING(@Id,1,1)

if @Id=''

if @SReport='T'

If @Ordr='N'

		if @isiList='' 

		  exec('select ''Gabungan'' Perusahaan,* from VwReportOutStandingSO where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		   order by NoBukti,Tanggal')

		 else

		  exec('select ''Gabungan'' Perusahaan,* from VwReportOutStandingSO where NoBukti IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		   order by NoBukti,Tanggal')  

		 

	else If @Ordr='B'

		if @isiList=''

		  exec('select ''Gabungan'' Perusahaan,* from VwReportOutStandingSO where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		   order by KodeBrg')

		 else

		  exec('select * from VwReportOutStandingSO where Kodebrg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		   order by KodeBrg') 

		 

	else If @Ordr='C'

		if @isiList=''

		  Exec('select ''Gabungan'' Perusahaan,* from VwReportOutStandingSO where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		   order by KodeCustSupp')

		 else

		  Exec('select ''Gabungan'' Perusahaan,* from VwReportOutStandingSO where KodeCustSupp IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		   order by KodeCustSupp')  


else

if @SReport='T'

If @Ordr='N'

		if @isiList='' 

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportOutStandingSO where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and '''+@ID+'''= Left(NoBukti,1)

		   order by NoBukti,Tanggal')

		 else

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportOutStandingSO where NoBukti IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		  and '''+@ID+'''= Left(NoBukti,1)

		   order by NoBukti,Tanggal')  

		 

	else If @Ordr='B'

		if @isiList=''

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportOutStandingSO where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		   and '''+@ID+'''= Left(NoBukti,1)

		   order by KodeBrg')

		 else

		  exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportOutStandingSO where Kodebrg IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		   and '''+@ID+'''= Left(NoBukti,1)

		   order by KodeBrg') 

		 

	else If @Ordr='C'

		if @isiList=''

		  Exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportOutStandingSO where (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		   and '''+@ID+'''= Left(NoBukti,1)

		   order by KodeCustSupp')

		 else

		  Exec('select case when '''+@ID+'''=''B'' Then ''PT. Beton Citra Abadi'' else ''PT. Calvary Abadi''  Perusahaan,* from VwReportOutStandingSO where KodeCustSupp IN'+@isiList+ ' and (Tanggal Between '+@Tgl1+''+' and '+''+@Tgl2+')

		   and '''+@ID+'''= Left(NoBukti,1)

		   order by KodeCustSupp');

-- Sp_reportOutStandingSORek
CREATE PROCEDURE IF NOT EXISTS Sp_reportOutStandingSORek AS ---- DECLARE REMOVED,@tgl1 Datetime,@Tgl2 DateTime

--select @Choice='n',@Tgl1='10/10/2011',@tgl2='01/29/2013'

select @Id=SUBSTRING(@Id,1,1)

if @Id=''

IF @Choice='N'

select  'Gabungan' Perusahaan,NoBukti,Tanggal, Sum(COALESCE(QNT,0))Qnt, Sum(COALESCE(QNT2,0)) Qnt2, Sum(COALESCE(QntSJ,0))QntSj, 

	Sum(COALESCE(Qnt2SJ,0)) Qnt2SJ, Sum(COALESCE(QNT,0))-Sum(COALESCE(QntSJ,0)) QntSisa, 

	Sum(COALESCE(QNT2,0))-Sum(COALESCE(QNT2SJ,0)) Qnt2Sisa

	from    vwSOBelumSuratJlnDet

	Where Tanggal between @tgl1 and @tgl2

	Group By NoBukti,tanggal

	Order By NoBukti,tanggal



else if @Choice ='S'

select 'Gabungan' Perusahaan, B.KOdeCust,C.NamaCustSupp,A.Tanggal, Sum(COALESCE(A.QNT,0))Qnt, Sum(COALESCE(A.QNT2,0)) Qnt2, Sum(COALESCE(A.QntSJ,0))QntSj, 

	Sum(COALESCE(A.Qnt2SJ,0)) Qnt2SJ, Sum(COALESCE(A.QNT,0))-Sum(COALESCE(A.QntSJ,0)) QntSisa, 

	Sum(COALESCE(A.QNT2,0))-Sum(COALESCE(A.QNT2SJ,0)) Qnt2Sisa

	from    vwSOBelumSuratJlnDet A 

	left outer join DbSO B on A.nobukti = B.nobukti

	Left Outer join DBCustSupp C on B.KodeCust=C.kodeCustSupp

	Where A.Tanggal between @tgl1 and @tgl2

	Group By  B.KOdeCust,C.NamaCustSupp,A.Tanggal

	Order By  B.KOdeCust,C.NamaCustSupp,A.Tanggal



else if @Choice='B'

select  'Gabungan' Perusahaan,A.kodebrg,A.NamaBrg,A.tanggal, Sum(COALESCE(A.QNT,0))Qnt, Sum(COALESCE(A.QNT2,0)) Qnt2, Sum(COALESCE(A.QntSJ,0))QntSj, 

	Sum(COALESCE(A.Qnt2SJ,0)) Qnt2SJ, Sum(COALESCE(A.QNT,0))-Sum(COALESCE(A.QntSJ,0)) QntSisa, 

	Sum(COALESCE(A.QNT2,0))-Sum(COALESCE(A.QNT2SJ,0)) Qnt2Sisa

	from    vwSOBelumSuratJlnDet A

	Where A.Tanggal between @tgl1 and @tgl2

	Group By  A.kodebrg,A.NamaBrg,A.tanggal

	Order By  A.kodebrg,A.NamaBrg,A.tanggal



--select * from dbSo

--select * from vwSatuanbrg

--Select * From vwSOBelumSuratJlnDet



else

IF @Choice='N'

select  Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,NoBukti,Tanggal, Sum(COALESCE(QNT,0))Qnt, Sum(COALESCE(QNT2,0)) Qnt2, Sum(COALESCE(QntSJ,0))QntSj, 

	Sum(COALESCE(Qnt2SJ,0)) Qnt2SJ, Sum(COALESCE(QNT,0))-Sum(COALESCE(QntSJ,0)) QntSisa, 

	Sum(COALESCE(QNT2,0))-Sum(COALESCE(QNT2SJ,0)) Qnt2Sisa

	from    vwSOBelumSuratJlnDet

	Where Tanggal between @tgl1 and @tgl2

	and @Id= Left(NoBukti,1)

	Group By NoBukti,tanggal

	Order By NoBukti,tanggal



else if @Choice ='S'

select  Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,B.KOdeCust,C.NamaCustSupp,A.Tanggal, Sum(COALESCE(A.QNT,0))Qnt, Sum(COALESCE(A.QNT2,0)) Qnt2, Sum(COALESCE(A.QntSJ,0))QntSj, 

	Sum(COALESCE(A.Qnt2SJ,0)) Qnt2SJ, Sum(COALESCE(A.QNT,0))-Sum(COALESCE(A.QntSJ,0)) QntSisa, 

	Sum(COALESCE(A.QNT2,0))-Sum(COALESCE(A.QNT2SJ,0)) Qnt2Sisa

	from    vwSOBelumSuratJlnDet A 

	left outer join DbSO B on A.nobukti = B.nobukti

	Left Outer join DBCustSupp C on B.KodeCust=C.kodeCustSupp

	Where A.Tanggal between @tgl1 and @tgl2

	and @Id= Left(a.NoBukti,1)

	Group By  B.KOdeCust,C.NamaCustSupp,A.Tanggal

	Order By  B.KOdeCust,C.NamaCustSupp,A.Tanggal



else if @Choice='B'

select  Case When @Id='B' Then 'PT. Beton Citra Abadi' else 'PT. Calvary Abadi'  Perusahaan,A.kodebrg,A.NamaBrg,A.tanggal, Sum(COALESCE(A.QNT,0))Qnt, Sum(COALESCE(A.QNT2,0)) Qnt2, Sum(COALESCE(A.QntSJ,0))QntSj, 

	Sum(COALESCE(A.Qnt2SJ,0)) Qnt2SJ, Sum(COALESCE(A.QNT,0))-Sum(COALESCE(A.QntSJ,0)) QntSisa, 

	Sum(COALESCE(A.QNT2,0))-Sum(COALESCE(A.QNT2SJ,0)) Qnt2Sisa

	from    vwSOBelumSuratJlnDet A

	Where A.Tanggal between @tgl1 and @tgl2

	and @Id= Left(NoBukti,1)

	Group By  A.kodebrg,A.NamaBrg,A.tanggal

	Order By  A.kodebrg,A.NamaBrg,A.tanggal



--select * from dbSo

--select * from vwSatuanbrg

--Select * From vwSOBelumSuratJlnDet;