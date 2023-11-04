import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';

class KependudukanMenurutKecamatanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Penduduk Menurut Kecamatan'),
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/left-arrow.png',
            height: 18,
          ),
          onPressed: () {
            Navigator.of(context)
                .pop(); // Menavigasi kembali ke halaman sebelumnya
          },
        ),
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
        <title>Penduduk Menurut Kecamatan</title>
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
					font-size: 9px;
					/* word-wrap:break-word; */
				}

				.tbl td {
				    padding: 8px;
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
			url='https://webapi.bps.go.id/v1/api/list/model/data/domain/3573/var/48/key/9db89e91c3c142df678e65a78c4e547f';
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

			const satuanA = data.var;
			const satuanB = satuanA.map(a => a.unit);
			const sumberA = data.var;
			const sumberB = sumberA.map(b => b.note);
			const kolomA = data.turvar;
			const kolomB = kolomA.map(c => c.label);
			const barisA = data.vervar;
			const barisB = barisA.map(e => e.label);
			const thA = data.tahun;
			const thB = thA.map(d => d.label);
			var pjThData = thB.length;
			//alert('Your query 3: ' + sumberB +" count= " + thB.length);

			const valData = Object.values(data.datacontent);
			//alert('Count: ' + val3573.length + " data: " + val3573);
	</script>

    <body style="background-image: url(file:///android_res/drawable/back_kependudukan.png); background-size: 100% 100%;">
        <div class="container" >
            <script> 
				if(satuanB == ""){
					document.write('<p align= "center" style="color:rgb(5, 44, 75); font-weight: bold;">PENDUDUK MENURUT KECAMATAN DAN<br>JENIS KELAMIN KOTA MALANG'+ barisB[barisB.length-1].toUpperCase().replace("<STRONG>KOTA MALANG</STRONG>","KOTA MALANG") +', '+ thB[pjThData-1] +'</p>'); 
				}
				else{
					document.write('<p align= "center" style="color:rgb(5, 44, 75); font-weight: bold;">PENDUDUK MENURUT KECAMATAN DAN<br>JENIS KELAMIN KOTA MALANG'+', '+ thB[pjThData-1] +'<br>('+ satuanB +')</p>'); 
				}
			</script>
            <table border = "0" align ="center" style="background-color:transparent;" cellpadding="10">
                <tr id="chart" align ="center" style="width:50%; text-align:center; height:15px;" >
                    <script>
							 var options = {
							  series: [
							  {
								name: kolomB[kolomB.length-3],
                                data: [valData[(pjThData*1)-1], valData[(pjThData*4)-1], valData[(pjThData*7)-1], valData[(pjThData*10)-1], valData[(pjThData*13)-1]]
							  },
							  {
								name: kolomB[kolomB.length-2],
                                data: [valData[(pjThData*2)-1], valData[(pjThData*5)-1], valData[(pjThData*8)-1], valData[(pjThData*11)-1], valData[(pjThData*14)-1]]
							  }
							],
							  chart: {
							  height: 240,
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
							colors: ['#2F496E', '#ED8C72'],
                            plotOptions: {
                             bar: {
                                horizontal: true,
                             }
                            },
							dataLabels: {
							  enabled: true,
							//   enabledOnSeries: [0],
							  background: {
								enabled: true,
								foreColor: '#fff',
							  },
							  style:{
								fontSize: '9px',
								colors: ['#000']
							  },
							  formatter: function (val, opt) {
								return new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(val)
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
									fontWeight: 600,
								 },
							  }
							},
							xaxis: {
                            categories:[barisB[0].toUpperCase(), barisB[1].toUpperCase(), barisB[2].toUpperCase(), barisB[3].toUpperCase(), barisB[4].toUpperCase()],
							  labels: {
								show: false
							  }
							},
							tooltip: {
							  theme: 'light',	
						//	  marker: false,
							  enabled: true,
							  y: {
								  formatter: function(value){
									return new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(value) + ' ' + satuanB
								  }
							  }
							},
							fill: {
							  opacity: 1,
							  type: 'solid',
						/*	  pattern: {
								style: ['slantedLines', 'slantedLines'], // string or array of strings
							
							  }*/
							},
							legend: {
							  position: 'top',
							  fontWeight: 600,
							  horizontalAlign: 'center',
							  floating: true,
							  offsetY: 10,
							  offsetX: 30,
							  labels:{
							  }
							}
							};

							var chart = new ApexCharts(document.querySelector("#chart"), options);
							chart.render();
						</script>
                </tr>
            </table>
            
            <script> 
				document.write('<p align= "center" style="color:rgb(5, 44, 75); font-weight: bold;">PENDUDUK MENURUT KECAMATAN ('+ satuanB +')</p>'); 
			</script>
            <table border = "0" align ="center" style="width:300px;background-color:transparent; font-size:11px; color:rgb(5, 44, 75);"cellpadding="10">
                <tr align ="center" style="background-color:rgb(5, 44, 75); font-weight:bold; color: white; font-family: sans-serif;">
                    <td >TAHUN</td>
                    <td width= "17%">KEDUNG<BR>KANDANG</td>
                    <td width= "17%">SUKUN</td>
                    <td width= "17%">KLOJEN</td>
                    <td width= "17%">BLIMBING</td>
                    <td width= "17%">LOWOK<BR>WARU</td>
					
					<script>
			/*		   document.write('<td width= "10px" style= "table-layout:fixed;word-wrap:break-word;">' + barisB[0].toUpperCase() + '</td>');
					   document.write('<td width= "70px" style= "word-wrap:break-word;">' + barisB[1].toUpperCase() + '</td>');
					   document.write('<td width= "70px" style= "word-wrap:break-word;">' + barisB[2].toUpperCase() + '</td>');
					   document.write('<td width= "70px" style= "word-wrap:break-word;">' + barisB[3].toUpperCase() + '</td>');
					   document.write('<td width= "70px" style= "word-wrap:break-word;">' + barisB[4].toUpperCase() + '</td>');*/
					</script>
                </tr>
                <tr align ="center" style="background-color:#adb7d6; font-weight:bold; ">
                    <script>
						document.write('<td>' + thB[pjThData-10] + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*3)-10]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*6)-10]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*9)-10]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*12)-10]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*15)-10]) + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#d6d9e4; font-weight:bold;">
                    <script>
						document.write('<td>' + thB[pjThData-9] + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*3)-9]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*6)-9]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*9)-9]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*12)-9]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*15)-9]) + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#adb7d6; font-weight:bold; ">
                    <script>
						document.write('<td>' + thB[pjThData-8] + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*3)-8]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*6)-8]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*9)-8]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*12)-8]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*15)-8]) + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#d6d9e4; font-weight:bold;">
                    <script>
						document.write('<td>' + thB[pjThData-7] + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*3)-7]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*6)-7]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*9)-7]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*12)-7]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*15)-7]) + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#adb7d6; font-weight:bold; ">
                    <script>
						document.write('<td>' + thB[pjThData-6] + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*3)-6]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*6)-6]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*9)-6]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*12)-6]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*15)-6]) + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#d6d9e4; font-weight:bold;">
                    <script>
						document.write('<td>' + thB[pjThData-5] + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*3)-5]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*6)-5]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*9)-5]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*12)-5]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*15)-5]) + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#adb7d6; font-weight:bold; ">
                    <script>
						document.write('<td>' + thB[pjThData-4] + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*3)-4]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*6)-4]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*9)-4]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*12)-4]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*15)-4]) + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#d6d9e4; font-weight:bold;">
                    <script>
						document.write('<td>' + thB[pjThData-3] + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*3)-3]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*6)-3]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*9)-3]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*12)-3]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*15)-3]) + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#adb7d6; font-weight:bold; ">
                    <script>
						document.write('<td>' + thB[pjThData-2] + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*3)-2]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*6)-2]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*9)-2]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*12)-2]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*15)-2]) + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#d6d9e4; font-weight:bold;">
                    <script>
						document.write('<td>' + thB[pjThData-1] + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*3)-1]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*6)-1]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*9)-1]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*12)-1]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*15)-1]) + '</td>');
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