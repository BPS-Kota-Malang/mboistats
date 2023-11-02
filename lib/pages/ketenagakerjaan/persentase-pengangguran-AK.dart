import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';

class PersentasePengangguranMenurutPendidikanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Persentase Pengangguran Menurut Pendidikan'),
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
        <title>TPT</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style>
			.container {
				width: 100%;
				min-height: 200px;
			}
			.kotak{
				width: 350px;
				height: auto;
				border: 2px solid #2F5597;
				border-radius: 10px 10px 10px 10px;
				margin: 1px 1px 1px 1px;
				background-color: #B1B5C9;
			}
    </style>
        <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
        <!-- <link href="path/to/css/style.css" rel='stylesheet' type='text/css' /> -->
        <!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js"></script> -->
        <!--        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">-->
    </head>
    <script>
			var data,i;
			url='https://webapi.bps.go.id/v1/api/list/model/data/domain/3573/var/441/key/9db89e91c3c142df678e65a78c4e547f';
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
			const kolomA = data.vervar;
			const kolomB = kolomA.map(c => c.label);
			const thA = data.tahun;
			const thB = thA.map(d => d.label);
			var pjData = thB.length;
			//alert('Your query 3: ' + sumberB +" count= " + thB.length);

			const valData = Object.values(data.datacontent);
			//alert('Count: ' + val3573.length + " data: " + val3573);
			
			for(i=0;i<valData.length;i++){
				if(valData[i] == 0){
					valData[i] = null;
				}
			}
			
	</script>

    <body style="background-image: url(file:///android_res/drawable/back_ketenagakerjaan.png); background-size: 100% 100%;">
        <div class="container" >
            <script> 
			if(satuanB == ""){
				document.write('<p align= "center" style="color:#2F5597; font-weight: bold;">TINGKAT PENGANGGURAN TERBUKA (TPT)<br>'+ kolomB[0].toUpperCase() + ', ' + kolomB[1].toUpperCase() +', DAN ' + kolomB[2].toUpperCase()+'</p>'); 
			}
			else{
				document.write('<p align= "center" style="color:#2F5597; font-weight: bold;">TINGKAT PENGANGGURAN TERBUKA (TPT)<br>'+ kolomB[0].toUpperCase() + ', ' + kolomB[1].toUpperCase() +', DAN ' + kolomB[2].toUpperCase()+'<br>('+ satuanB +')</p>'); 
			}
			</script>
            <table border = "0" align ="center" style="background-color:transparent;" cellpadding="10">
					<tr id="chart" align ="center" style="width:50%; text-align:center; height:15px;" >
						 <script>
							 var options = {
							  series: [
							  {
								name: kolomB[0],
								data: [valData[(pjData*1)-10], valData[(pjData*1)-9], valData[(pjData*1)-8], valData[(pjData*1)-7], valData[(pjData*1)-6], valData[(pjData*1)-5], valData[(pjData*1)-4], valData[(pjData*1)-3], valData[(pjData*1)-2], valData[(pjData*1)-1]]
							  },
							  {
								name: kolomB[1],
								data: [valData[(pjData*2)-10], valData[(pjData*2)-9], valData[(pjData*2)-8], valData[(pjData*2)-7], valData[(pjData*2)-6], valData[(pjData*2)-5], valData[(pjData*2)-4], valData[(pjData*2)-3], valData[(pjData*2)-2], valData[(pjData*2)-1]]
							  },
							  {
								name: kolomB[2],
								data: [valData[(pjData*3)-10], valData[(pjData*3)-9], valData[(pjData*3)-8], valData[(pjData*3)-7], valData[(pjData*3)-6], valData[(pjData*3)-5], valData[(pjData*3)-4], valData[(pjData*3)-3], valData[(pjData*3)-2], valData[(pjData*3)-1]]
							  }
							],
							  chart: {
								  height: 250,
								  width: 360,
								  type: 'line',
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
								  }/*,
								  events: {
								  dataPointSelection: function(event, chartContext, config) {
										// The last parameter config contains additional information like `seriesIndex` and `dataPointIndex` for cartesian charts.
										console.log(chartContext, config);
								    }
								 }*/
							  },
							colors: ['#4472C4', '#ED7D31', '#A5A5A5'],
							dataLabels: {
							  enabled: false,
							  enabledOnSeries: [0],
							  style:{
								fontSize: '9px'
							  },
							  formatter: function (val, opt) {
								return new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(val)
							  },
							  border:false
							},
							stroke: {
							  curve: 'smooth'
							},
							grid: {
							  borderColor: '#e7e7e7',
							  row: {
								colors: ['transparent', 'transparent'], // takes an array which will be repeated on columns
								opacity: 0.5
							  },
							},
							markers: {
							  size: 4
							},
							yaxis:{
							  show: true,
						      showForNullSeries: false,
							  labels: {
								show: true,
								style: {
									fontSize: '9px',
									fontWeight: 600,
								},
								formatter: (value) => {
									return new Intl.NumberFormat('ID',{ maximumFractionDigits: 2 }).format(value) 
								},
							  }
							},
							xaxis: {
							  categories: [thB[pjData-10],thB[pjData-9],thB[pjData-8],thB[pjData-7],thB[pjData-6],thB[pjData-5],thB[pjData-4],thB[pjData-3],thB[pjData-2],thB[pjData-1]],
							  labels: {
								  style: {
										fontSize: '9px',
										fontWeight: 600,
										colors: ['#2F5597','#2F5597','#2F5597','#2F5597','#2F5597','#2F5597','#2F5597','#2F5597','#2F5597','#2F5597']
									}
							  },
							  title: {
								text: ''
							  }
							},
							tooltip: {
							  theme: 'dark',
							  enabled: true,
							  y: {
								  formatter: function(value){
								    if(value == null)
										return 'N.A.'
									else
										return new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(value) + '%'
								  }
							  }
							},
							legend: {
							  position: 'top',
							  fontSize: '9px',
							  fontWeight: 600,
							  horizontalAlign: 'center',
							  floating: true,
							  labels:{
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
			<table border = "0" align ="center" style="width:auto; background-color:transparent;" cellpadding="10">
				<td>
					<div class="kotak"><p style="margin: 2px 2px 2px 2px;font-size:12px;color:#2F5597; text-align:center;" align="center"><b>TINGKAT PENGANGGURAN TERBUKA (TPT)</b><br>
						<text style="color:#2F5597; font-size:12px; text-align:center;" align="center">merupakan persentase penduduk menganggur terhadap penduduk angkatan kerja</text></p>
					</div>
				</td>
			</table>
            <table border = "0" align ="center" style="background-color:transparent; font-size:12px; color:#2F5597;"cellpadding="10">
                <tr align ="center" style="background-color:#3A62A7; font-weight:bold; color: white; font-family: sans-serif;">
                    <td>TAHUN</td>
                    <script>
						document.write('<td>' + kolomB[0].toUpperCase() + '</td>');
						document.write('<td>' + kolomB[1].toUpperCase() + '</td>');
						document.write('<td>' + kolomB[2].toUpperCase() + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#B1B5C9; font-weight:bold; ">
                    <script>
						document.write('<td>' + thB[pjData-10] + '</td>');
						if(valData[(pjData*1)-10] == null){
							document.write('<td>N.A.</td>');
						}
						else
							document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(valData[(pjData*1)-10]) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(valData[(pjData*2)-10]) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(valData[(pjData*3)-10]) + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#C7C9D1; font-weight:bold;">
                    <script>
						document.write('<td>' + thB[pjData-9] + '</td>');
						if(valData[(pjData*1)-9] == null){
							document.write('<td>N.A.</td>');
						}
						else
							document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(valData[(pjData*1)-9]) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(valData[(pjData*2)-9]) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(valData[(pjData*3)-9]) + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#B1B5C9; font-weight:bold; ">
                    <script>
						document.write('<td>' + thB[pjData-8] + '</td>');
						if(valData[(pjData*1)-8] == null){
							document.write('<td>N.A.</td>');
						}
						else
							document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(valData[(pjData*1)-8]) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(valData[(pjData*2)-8]) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(valData[(pjData*3)-8]) + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#C7C9D1; font-weight:bold;">
                    <script>
						document.write('<td>' + thB[pjData-7] + '</td>');
						if(valData[(pjData*1)-7] == null){
							document.write('<td>N.A.</td>');
						}
						else
							document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(valData[(pjData*1)-7]) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(valData[(pjData*2)-7]) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(valData[(pjData*3)-7]) + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#B1B5C9; font-weight:bold; ">
                    <script>
						document.write('<td>' + thB[pjData-6] + '</td>');
						if(valData[(pjData*1)-6] == null){
							document.write('<td>N.A.</td>');
						}
						else
							document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(valData[(pjData*1)-6]) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(valData[(pjData*2)-6]) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(valData[(pjData*3)-6]) + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#C7C9D1; font-weight:bold;">
                    <script>
						document.write('<td>' + thB[pjData-5] + '</td>');
						if(valData[(pjData*1)-5] == null){
							document.write('<td>N.A.</td>');
						}
						else
							document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(valData[(pjData*1)-5]) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(valData[(pjData*2)-5]) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(valData[(pjData*3)-5]) + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#B1B5C9; font-weight:bold; ">
                    <script>
						document.write('<td>' + thB[pjData-4] + '</td>');
						if(valData[(pjData*1)-4] == null){
							document.write('<td>N.A.</td>');
						}
						else
							document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(valData[(pjData*1)-4]) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(valData[(pjData*2)-4]) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(valData[(pjData*3)-4]) + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#C7C9D1; font-weight:bold;">
                    <script>
						document.write('<td>' + thB[pjData-3] + '</td>');
						if(valData[(pjData*1)-3] == null){
							document.write('<td>N.A.</td>');
						}
						else
							document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(valData[(pjData*1)-3]) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(valData[(pjData*2)-3]) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(valData[(pjData*3)-3]) + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#B1B5C9; font-weight:bold; ">
                    <script>
						document.write('<td>' + thB[pjData-2] + '</td>');
						if(valData[(pjData*1)-2] == null){
							document.write('<td>N.A.</td>');
						}
						else
							document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(valData[(pjData*1)-2]) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(valData[(pjData*2)-2]) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(valData[(pjData*3)-2]) + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#C7C9D1; font-weight:bold;">
                    <script>
						document.write('<td>' + thB[pjData-1] + '</td>');
						if(valData[(pjData*1)-1] == null){
							document.write('<td>N.A.</td>');
						}
						else
							document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(valData[(pjData*1)-1]) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(valData[(pjData*2)-1]) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(valData[(pjData*3)-1]) + '</td>');
					</script>
                </tr>
                <tr align ="left" style="background-color:transparent; line-height:auto;">
                    <script>
						document.write('<td colspan="4" style="#fab;height:auto;width:100px;word-wrap:break-word;"><strong style="font-size: 9px;">' + sumberB + '</strong></td>');
					</script>
                </tr>
				<tr align ="left" style="background-color:transparent; line-height:1px;">
                    <script>
						document.write('<td colspan="4" align = "right" style="font-weight:bold; color:#336B87; font-size:13px;">MBOIStatS</td>');
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