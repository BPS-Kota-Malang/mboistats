import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';

class KependudukanMenurutJKPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Penduduk Menurut Jenis Kelamin'),
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
        <title>Penduduk Menurut Jenis Kelamin</title>
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

    </style>
        <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
        <!-- <link href="path/to/css/style.css" rel='stylesheet' type='text/css' /> -->
        <!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js"></script> -->
        <!--        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">-->
    </head>
    <script>
			var data;
			url='https://webapi.bps.go.id/v1/api/list/model/data/domain/3573/var/51/key/9db89e91c3c142df678e65a78c4e547f';
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
			const satuanB = satuanA.map(d => d.unit);
			const sumberA = data.var;
			const sumberB = sumberA.map(a => a.note);
			const kolomA = data.vervar;
            const kolomB = kolomA.map(b => b.label);
            const kolomC = data.turvar;
            const kolomD = kolomC.map(c => c.label);
			const thA = data.tahun;
			const thB = thA.map(c => c.label);
			var pjThData = thB.length;
			//alert('Your query 3: ' + sumberB +" count= " + thB.length);

			const valData = Object.values(data.datacontent);
            //alert('Count: ' + val3573.length + " data: " + val3573);

	</script>

    <body style="background-image: url(file:///android_res/drawable/back_kependudukan.png); background-size: 100% 100%;">
        <div class="container" >
            <script> 
				if(satuanB == ""){
					document.write('<p align= "center" style="color:rgb(5, 44, 75); font-weight: bold;">PIRAMIDA PENDUDUK KOTA MALANG<br>TAHUN ' + thB[thB.length-1] +'</p>');
				}
				else{
					document.write('<p align= "center" style="color:rgb(5, 44, 75); font-weight: bold;">PIRAMIDA PENDUDUK KOTA MALANG<br>TAHUN ' + thB[thB.length-1] +'<br>('+ satuanB +')</p>');
				}
			</script>
            <table border = "0" align ="center" style="background-color:transparent;" cellpadding="10">
                <tr id="chart" align ="center" style="width:50%; text-align:center; height:15px;" >
                    <script>
							 var options = {
							  series: [
							  {
								name: kolomD[kolomD.length-3],
                                data: [ -(valData[(pjThData*46)-1]), -(valData[(pjThData*43)-1]),-(valData[(pjThData*40)-1]),-(valData[(pjThData*37)-1]),-(valData[(pjThData*34)-1]),-(valData[(pjThData*31)-1]),-(valData[(pjThData*28)-1]),-(valData[(pjThData*25)-1]),-(valData[(pjThData*22)-1]),-(valData[(pjThData*19)-1]),-(valData[(pjThData*16)-1]),-(valData[(pjThData*13)-1]),-(valData[(pjThData*10)-1]),-(valData[(pjThData*7)-1]),-(valData[(pjThData*4)-1]),-(valData[(pjThData*1)-1])]
                                },
                                {
                                name: kolomD[kolomD.length-2],
                                data: [  valData[(pjThData*47)-1], valData[(pjThData*44)-1], valData[(pjThData*41)-1], valData[(pjThData*38)-1], valData[(pjThData*35)-1], valData[(pjThData*32)-1], valData[(pjThData*29)-1], valData[(pjThData*26)-1], valData[(pjThData*23)-1], valData[(pjThData*20)-1], valData[(pjThData*17)-1], valData[(pjThData*14)-1], valData[(pjThData*11)-1], valData[(pjThData*8)-1], valData[(pjThData*5)-1], valData[(pjThData*2)-1]]
                                },
                            ],
							chart: {
								height: 410,
								width: 330,
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
                                barHeight: '80%',
                            }
                            },
							dataLabels: {
							  enabled: false,
							},
                            stroke: {
                                width: 1,
                                colors: ['#fff']
                                },
							grid: {
                                xaxis: {
                                    lines: {
                                    show: false
                                    }
                                }
							},
							yaxis: {
                                showAlways: true,
								labels:{
									style:{
										fontWeight: 600,
									},
								},
                                title: {
                                    text: 'Kelompok Umur (Tahun)',
                                }
                            },
                         xaxis: {
                            categories: [kolomB[15].toUpperCase(),  kolomB[14].toUpperCase(),kolomB[13].toUpperCase(), kolomB[12].toUpperCase(), kolomB[11].toUpperCase(), kolomB[10].toUpperCase(),
                            kolomB[9].toUpperCase(), kolomB[8].toUpperCase(), kolomB[7].toUpperCase() , kolomB[6].toUpperCase(), kolomB[5].toUpperCase(), kolomB[4].toUpperCase() , kolomB[3].toUpperCase(), kolomB[2].toUpperCase(), kolomB[1].toUpperCase(),
                            kolomB[0].toUpperCase()
                            ],
                            title:{
                                text: satuanB
                            },
                            labels:{
								style:{
									fontWeight: 600,
								},
                                formatter: function (val) {
                                    return new Intl.NumberFormat('ID',{ maximumFractionDigits: 0 }).format(Math.abs(val))
                                }
                            // formatter: function(value){
                            //         return new Intl.NumberFormat('ID',{ maximumFractionDigits: 0 }).format(value/1000)
                            //       }
                            }
                         },
						tooltip: {
						  theme: 'light',
						  y: {

							  formatter: function(value){
								return new Intl.NumberFormat('ID',{ maximumFractionDigits: 0 }).format(Math.abs(value)) + ' ' + satuanB
							  }
						  },
						  x: {
							  formatter: function(value){
								return value + ' ' + satuanB
							  }
						  }
						},
						legend: {
						  position: 'top',
						  fontWeight: 600,
						  horizontalAlign: 'center',
						  floating: true,
						  offsetY: 10,
						  offsetX: 30,
						  labels: {

							}
						}
						};

						var chart = new ApexCharts(document.querySelector("#chart"), options);
						chart.render();
						</script>
                </tr>
            </table>
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
            <script> 
			if(satuanB == ""){
				document.write('<p align= "center" style="color:rgb(5, 44, 75); font-weight: bold;">PENDUDUK MENURUT JENIS KELAMIN<br>KOTA MALANG, TAHUN '+ thB[pjThData-10] +' - '+ thB[pjThData-1] +'</p>'); 
			}
			else{
				document.write('<p align= "center" style="color:rgb(5, 44, 75); font-weight: bold;">PENDUDUK MENURUT JENIS KELAMIN<br>KOTA MALANG, TAHUN '+ thB[pjThData-10] +' - '+ thB[pjThData-1] +' ('+ satuanB +')</p>'); 
			}
		</script>
   <!--         <table class = "tbl" border = "0" align ="center" style="background-color:transparent; color:rgb(5, 44, 75)">
                <tr align ="center" style="background-color:#4169E1; font-weight:bold; color: white; font-family: sans-serif;">
				-->
			<table border = "0" align ="center" style="background-color:transparent; font-size:12px; color:rgb(5, 44, 75);"cellpadding="10">
                <tr align ="center" style="background-color:rgb(5, 44, 75); font-weight:bold; color: white; font-family: sans-serif;">
                    <td width="22%">TAHUN</td>
                    <!-- <td>LAKI-LAKI</td>
                    <td>PEREMPUAN</td>
                    <td>TOTAL</td> -->
                    <script>
						document.write('<td width="22%">' + kolomD[0].toUpperCase() + '</td>');
						document.write('<td width="22%">' + kolomD[1].toUpperCase() + '</td>');
                        document.write('<td width="22%">' + kolomD[2].toUpperCase() + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#adb7d6; font-weight:bold; ">
                    <script>
						document.write('<td>' + thB[pjThData-10] + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*49)-10]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*50)-10]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*51)-10])+ '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#d6d9e4; font-weight:bold;">
                    <script>
						document.write('<td>' + thB[pjThData-9] + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*49)-9]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*50)-9]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*51)-9]) + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#adb7d6; font-weight:bold; ">
                    <script>
						document.write('<td>' + thB[pjThData-8] + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*49)-8]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*50)-8]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*51)-8]) + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#d6d9e4;font-weight:bold;">
                    <script>
						document.write('<td>' + thB[pjThData-7] + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*49)-7]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*50)-7]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*51)-7]) + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#adb7d6; font-weight:bold; ">
                    <script>
						document.write('<td>' + thB[pjThData-6] + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*49)-6]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*50)-6]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*51)-6]) + '</td>');
                        </script>
                </tr>
                <tr align ="center" style="background-color:#d6d9e4; font-weight:bold;">
                    <script>
						document.write('<td>' + thB[pjThData-5] + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*49)-5]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*50)-5]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*51)-5]) + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#adb7d6; font-weight:bold; ">
                    <script>
						document.write('<td>' + thB[pjThData-4] + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*49)-4]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*50)-4]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*51)-4]) + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#d6d9e4; font-weight:bold;">
                    <script>
						document.write('<td>' + thB[pjThData-3] + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*49)-3]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*50)-3]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*51)-3]) + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#adb7d6; font-weight:bold; ">
                    <script>
						document.write('<td>' + thB[pjThData-2] + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*49)-2]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*50)-2]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*51)-2]) + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#d6d9e4; font-weight:bold;">
                    <script>
						document.write('<td>' + thB[pjThData-1] + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*49)-1]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*50)-1]) + '</td>');
                        document.write('<td>' + new Intl.NumberFormat('ID',{ minimumSignificantDigits: 2 }).format(valData[(pjThData*51)-1]) + '</td>');
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