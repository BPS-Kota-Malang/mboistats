import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';

class PendudukBlimbingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Penduduk Kecamatan Blimbing '),
      ),
      body: WebView(
        initialUrl: 'about:blank', // URL awal sementara
        javascriptMode: JavascriptMode.unrestricted, // Aktifkan JavaScript
        onWebViewCreated: (WebViewController webViewController) {
          // Muat konten HTML dan JavaScript
          webViewController.loadUrl(Uri.dataFromString(
            '''
          <!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Penduduk Blimbing</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style>
			.container {
				width: 100%;
				min-height: 200px;
			}
			.kotak{
				width: auto;
				height: auto;
				border: 2px solid #776308;
				border-radius: 10px 10px 10px 10px;
				margin: 1px 1px 1px 1px;
				background-color: #F3E39B;
			}

			@media only screen and (max-width: 600px) {
			/* For tablets: */
				.tbl {
					font-size: 10px;
					/* word-wrap:break-word; */
					width:95%;
				}

				.tbl td {
				    padding: 9px;
				}

			}
			@media only screen and (min-width: 768px) {
			/* For desktop: */
				.tbl {
					width: 400px;
					font-size: 12px;
				}
			}
    </style>
        <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
        <!-- <link href="path/to/css/style.css" rel='stylesheet' type='text/css' /> -->
        <!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js"></script> -->
        <!--        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">-->
    </head>
    <script>
			var data;
			url='https://webapi.bps.go.id/v1/api/list/model/data/domain/3573/var/55/key/9db89e91c3c142df678e65a78c4e547f';
			var xhr = new XMLHttpRequest();
			xhr.open('GET', url, false);
			xhr.onreadystatechange = function() {
			  // request completed?
			  if (xhr.readyState !== 4) return;
			  if (xhr.status === 200) {
				// request successful - show response
				data = JSON.parse(xhr.responseText);
			  }
			  else {
				// request error
				console.log('HTTP error', xhr.status, xhr.statusText);
			  }
			};
			xhr.send();

			const sumberA = data.var;
			const sumberB = sumberA.map(a => a.note);
			const satuanB = sumberA.map(a => a.unit);
			const kolomA = data.vervar;
            const kolomB = kolomA.map(b => b.label);
            const kolomC = data.turvar;
            const kolomD = kolomC.map(b => b.label);
			const labelVerVar = data.labelvervar;
			const thA = data.tahun;
			const thB = thA.map(c => c.label);
			var pjData = thB.length;
			//alert('Your query 3: ' + sumberB +" count= " + thB.length);

			const valData = Object.values(data.datacontent);
			//alert('Count: ' + val3573.length + " data: " + val3573);
	</script>

    <body style="background-image: url(file:///android_res/drawable/back_kependudukan.png); background-size: 100% 100%;">
        <div align ="center" class="container" >
            <script> 
				if(satuanB == ""){
					document.write('<p align= "center" style="color:rgb(5, 44, 75); font-size: 13px; font-weight: bold;">PENDUDUK '+ labelVerVar.toUpperCase() +' MENURUT<br>KELURAHAN DAN JENIS KELAMIN, TAHUN '+thB[pjData-1]+'</p>');
				}
				else{
					document.write('<p align= "center" style="color:rgb(5, 44, 75); font-size: 13px; font-weight: bold;">PENDUDUK '+ labelVerVar.toUpperCase() +' MENURUT<br>KELURAHAN DAN JENIS KELAMIN, TAHUN '+thB[pjData-1]+'<br>('+satuanB+') '+'</p>');
				}					
			</script>
            <table border = "0" align ="center" style="background-color:transparent;" cellpadding="10">
                <tr id="chart" align ="center" style="width:50%; text-align:center; height:15px;" >
                    <script>
						var options = {
						  series: [
						  {
							name: kolomD[0],
							data: [valData[(pjData*1)-1], valData[(pjData*4)-1], valData[(pjData*7)-1], valData[(pjData*10)-1], valData[(pjData*13)-1], valData[(pjData*16)-1], valData[(pjData*19)-1], valData[(pjData*22)-1], valData[(pjData*25)-1], valData[(pjData*28)-1], valData[(pjData*31)-1]]
						  },
						  {
							name: kolomD[1],
							data: [valData[(pjData*2)-1], valData[(pjData*5)-1], valData[(pjData*8)-1], valData[(pjData*11)-1], valData[(pjData*14)-1], valData[(pjData*17)-1], valData[(pjData*20)-1], valData[(pjData*23)-1], valData[(pjData*26)-1], valData[(pjData*29)-1], valData[(pjData*32)-1]]
						  }
						],
						  chart: {
						  height: 400,
						  width: 350,
						  type: 'bar',
						  stacked: true,
						  dropShadow: {
							enabled: true,
							color: '#000',
							top: 18,
							left: 7,
							blur: 5,
							opacity: 0.2
						  },
						  toolbar: {
							show: true,
							tools: {
								download: true,
								selection: false,
								zoom: false,
								zoomout: false,
								zoomin: false,
								pan: false,
								reset: false,
							},
						  }
						},
						colors: ['#375E97', '#FFBB00'],
						plotOptions: {
						bar: {
							horizontal: true,
						}
						},
						dataLabels: {
						  enabled: false,
						  style:{
							fontSize: '9px'
						  },
						  border:false
						},
						stroke: {
							width: 1,
							colors: ['#fff']
							},
						grid: {
						  borderColor: '#e7e7e7',
						  row: {
							colors: ['transparent', 'transparent'], // takes an array which will be repeated on columns
							opacity: 0.5
						  },
						},
						yaxis:{
						  show: true,
						  labels: {
							show: true,
							style:{
								fontSize: '9px',
								fontWeight: 600,
							}
						  },
						},
						xaxis: {
						  categories:[kolomB[0].toUpperCase(), kolomB[1].toUpperCase(), kolomB[2].toUpperCase(), kolomB[3].toUpperCase(), kolomB[4].toUpperCase(), kolomB[5].toUpperCase(), kolomB[6].toUpperCase(), kolomB[7].toUpperCase(), kolomB[8].toUpperCase(), kolomB[9].toUpperCase(), kolomB[10].toUpperCase()],
						  labels: {
							show: false,
							style:{
								fontSize: '9px',
								fontWeight: 600,
							 },
							 formatter: function(value){
								return new Intl.NumberFormat('ID',{ maximumFractionDigits: 0 }).format(value)
							 }
						  }		
						},
						tooltip: {
						  enabled: true,
						  y: {
							  formatter: function(value){
								return new Intl.NumberFormat('ID',{ maximumFractionDigits: 2 }).format(value) + ' ' +satuanB
							  }
						  }
						},
						legend: {
						  position: 'top',
						  fontSize: '9px',
						  fontWeight: 600,
						  horizontalAlign: 'center',
						  floating: true,
						  offsetY: 9,
						  offsetX: 28,
						  labels:{
						  }
						}
						};

						var chart = new ApexCharts(document.querySelector("#chart"), options);
						chart.render();  
					</script>
                </tr>
            </table><br>
            <!-- <div id="curve_chart" style="width: 100%; height: 300px"></div><br> -->
            <!-- <div id="canvas" style="height: 300px; width: 100%;"></div> -->
            <!-- <script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script><br><br> -->
            <!-- <canvas id="canvas" height="300" width="500"></canvas> -->
            <!-- <table border = "0" align ="center" style="width:auto; background-color:transparent;" cellpadding="10">
                <td>
                    <div class="kotak"><p style="font-size:12px;color:#2A3132;text-align:center;" align="center"><b>KEPENDUDUKAN</b><br>
                        <text style="color:#336B87; font-size:12px; text-align:center;" align="center">merupakan indikator untuk melihat ketimpangan <br> pendapatan/pengeluaran penduduk di suatu wilayah</text></p>
                    </div>
                </td>
            </table> -->
            <!-- <script> document.write('<p align= "center" style="color:rgb(5, 44, 75); font-weight: bold;">PENDUDUK MENURUT KECAMATAN (Jiwa) '+'</p>'); </script> -->
			<table border = "0" align ="center" style="width:380px;background-color:transparent; font-size:10px; color:rgb(5, 44, 75);"cellpadding="10">
                <tr align ="center" style="background-color:rgb(5, 44, 75); font-weight:bold; color: white; font-family: sans-serif;">
                    <td width = "38px">KELURAHAN</td>
                    <script>
						document.write('<th width = "114px">' + kolomD[0].toUpperCase() + '</th>');
						document.write('<th width = "114px">' + kolomD[1].toUpperCase() + '</th>');
                        document.write('<th width = "114px">' + kolomD[2].toUpperCase() + '</th>');
                   </script>
                </tr>
                <tr style="background-color:#adb7d6; font-weight:bold; ">
                    <script>
						document.write('<td>' + kolomB[0].toUpperCase() + '</td>');
                        document.write('<td align="center">' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjData*1)-1]) + '</td>');
                        document.write('<td align="center">' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjData*2)-1]) + '</td>');
                        document.write('<td align="center">' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjData*3)-1]) + '</td>');
					</script>
                </tr>
                <tr style="background-color:#d6d9e4; font-weight:bold;">
                    <script>
						document.write('<td>' + kolomB[1].toUpperCase() + '</td>');
                        document.write('<td align="center">' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjData*4)-1]) + '</td>');
                        document.write('<td align="center">' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjData*5)-1]) + '</td>');
                        document.write('<td align="center">' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjData*6)-1]) + '</td>');
					</script>
                </tr>
                <tr style="background-color:#adb7d6; font-weight:bold; ">
                    <script>
						document.write('<td>' + kolomB[2].toUpperCase() + '</td>');
						document.write('<td align="center">' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjData*7)-1]) + '</td>');
                        document.write('<td align="center">' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjData*8)-1]) + '</td>');
                        document.write('<td align="center">' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjData*9)-1]) + '</td>');
					</script>
                </tr>
                <tr style="background-color:#d6d9e4; font-weight:bold;">
                    <script>
						document.write('<td>' + kolomB[3].toUpperCase() + '</td>');
						document.write('<td align="center">' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjData*10)-1]) + '</td>');
                        document.write('<td align="center">' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjData*11)-1]) + '</td>');
                        document.write('<td align="center">' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjData*12)-1]) + '</td>');
					</script>
                </tr>
                <tr style="background-color:#adb7d6; font-weight:bold; ">
                    <script>
						document.write('<td>' + kolomB[4].toUpperCase() + '</td>');
						document.write('<td align="center">' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjData*13)-1]) + '</td>');
                        document.write('<td align="center">' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjData*14)-1]) + '</td>');
                        document.write('<td align="center">' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjData*15)-1]) + '</td>');
					</script>
                </tr>
                <tr style="background-color:#d6d9e4; font-weight:bold;">
                    <script>
						document.write('<td>' + kolomB[5].toUpperCase() + '</td>');
						document.write('<td align="center">' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjData*16)-1]) + '</td>');
                        document.write('<td align="center">' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjData*17)-1]) + '</td>');
                        document.write('<td align="center">' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjData*18)-1]) + '</td>');
					</script>
                </tr>
                <tr style="background-color:#adb7d6; font-weight:bold; ">
                    <script>
						document.write('<td>' + kolomB[6].toUpperCase() + '</td>');
						document.write('<td align="center">' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjData*19)-1]) + '</td>');
                        document.write('<td align="center">' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjData*20)-1]) + '</td>');
                        document.write('<td align="center">' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjData*21)-1]) + '</td>');
					</script>
                </tr>
                <tr style="background-color:#d6d9e4; font-weight:bold;">
                    <script>
						document.write('<td>' + kolomB[7].toUpperCase() + '</td>');
						document.write('<td align="center">' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjData*22)-1]) + '</td>');
                        document.write('<td align="center">' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjData*23)-1]) + '</td>');
                        document.write('<td align="center">' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjData*24)-1]) + '</td>');
					</script>
                </tr>
                <tr style="background-color:#adb7d6; font-weight:bold; ">
                    <script>
						document.write('<td>' + kolomB[8].toUpperCase() + '</td>');
						document.write('<td align="center">' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjData*25)-1]) + '</td>');
                        document.write('<td align="center">' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjData*26)-1]) + '</td>');
                        document.write('<td align="center">' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjData*27)-1]) + '</td>');
					</script>
                </tr>
                <tr style="background-color:#d6d9e4; font-weight:bold;">
                    <script>
						document.write('<td>' + kolomB[9].toUpperCase() + '</td>');
						document.write('<td align="center">' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjData*28)-1]) + '</td>');
                        document.write('<td align="center">' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjData*29)-1]) + '</td>');
                        document.write('<td align="center">' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjData*30)-1]) + '</td>');
					</script>
                </tr>
                <tr style="background-color:#adb7d6; font-weight:bold;">
                    <script>
						document.write('<td>' + kolomB[10].toUpperCase() + '</td>');
						document.write('<td align="center">' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjData*31)-1]) + '</td>');
                        document.write('<td align="center">' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjData*32)-1]) + '</td>');
                        document.write('<td align="center">' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjData*33)-1]) + '</td>');
					</script>
                </tr>
                <tr align ="left" style="background-color:transparent; line-height:auto;">
                    <script>
						document.write('<td colspan="4" style="#fab;height:auto;width:100px;word-wrap:break-word;"><strong style="font-size: 9px;">' + sumberB + '</strong></td>');
					</script>
                </tr>
                <tr align ="left" style="background-color:transparent; line-height:1px;">
                    <script>
						document.write('<td colspan="8" align = "right" style="font-weight:bold; color:#336B87; font-size:13px;">MBOIStatS</td>');
					</script>
                </tr>
            </table>
        </div>
    </body>
</html>


            ''',
            mimeType: 'text/html',
            encoding: Encoding.getByName('utf-8'),
          ).toString());
        },
      ),
    );
  }
}