import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';

class LuasLahanPadiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Luas Lahan Padi'),
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
        <title>Produksi Beras</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style>
			.container {
				width: 100%;
				min-height: 200px;
			}
			.kotak{
				width: 350px;
				height: auto;
				border: 2px solid #006600;
				border-radius: 10px 10px 10px 10px;
				margin: 1px 1px 1px 1px;
				background-color: #B7DFC3;
			}
    </style>
        <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
        <!-- <link href="path/to/css/style.css" rel='stylesheet' type='text/css' /> -->
        <!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js"></script> -->
        <!--        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">-->
    </head>
    <script>
			var data,i;
			url='https://webapi.bps.go.id/v1/api/list/model/data/domain/3573/var/496/key/9db89e91c3c142df678e65a78c4e547f';
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
			const bulanA = data.turtahun;
			const bulanB = bulanA.map(e => e.label);
			var pjData = thB.length;
			var tmpStr;
			
			for(i=0;i<bulanB.length;i++){
				if(bulanB[i].indexOf("-") >= 0)
					bulanB[i] = bulanB[i].slice(0,3) + bulanB[i].substring(bulanB[i].indexOf("-"),bulanB[i].indexOf("-")+4);
			}
			
			var dataAll = [];
			const keyData = Object.keys(data.datacontent);
			const thAwal = keyData[0].slice(5,8);
			const bulanAwal = keyData[0].slice(8,10);
			const valData = Object.values(data.datacontent);
			for(i=0;i<keyData.length;i++){
				if(valData[i] <= 0)
					valData[i] = null;
				dataAll.push([keyData[i],valData[i],bulanB[parseInt(keyData[i].slice(8,10))-bulanAwal],thB[parseInt(keyData[i].slice(5,8))-thAwal]]);
			}
			//console.log(dataAll);
			//dataAll.sort() 
			//alert('Your query : ' + bulanB +" count= ");
			//alert('Count: ' + valData.length + " data: " + valData + " keys: " + keyData.length);
	</script>

    <body style="background-image: url(file:///android_res/drawable/back_pertanian.png); background-size: 100% 100%;">
        <div class="container" align ="center" >
            <script> 
			if(satuanB == ""){
				document.write('<p align= "center" style="color:#006600; font-weight: bold;">PRODUKSI BERAS<br>'+ kolomB[0].toUpperCase() + ', ' + kolomB[1].toUpperCase() +', DAN ' + kolomB[2].toUpperCase()+'</p>'); 
			}
			else{
				document.write('<p align= "center" style="color:#006600; font-weight: bold;">PRODUKSI BERAS<br>'+ kolomB[0].toUpperCase() + ', ' + kolomB[1].toUpperCase() +', DAN ' + kolomB[2].toUpperCase()+'<br>('+ satuanB +')</p>'); 
			}
			</script>
            <table border = "0" align ="center" style="background-color:transparent;" cellpadding="10">
					<tr id="chart" align ="center" style="width:50%; text-align:center; height:15px;" >
						 <script>
							 var options = {
							  series: [
							  {
								name: kolomB[0],
								data: [dataAll[dataAll.length*(1/3)-8][1], dataAll[dataAll.length*(1/3)-7][1], dataAll[dataAll.length*(1/3)-6][1], dataAll[dataAll.length*(1/3)-4][1], dataAll[dataAll.length*(1/3)-3][1], dataAll[dataAll.length*(1/3)-2][1]]
							  },
							  {
								name: kolomB[1],
								data: [dataAll[dataAll.length*(2/3)-8][1], dataAll[dataAll.length*(2/3)-7][1], dataAll[dataAll.length*(2/3)-6][1], dataAll[dataAll.length*(2/3)-4][1], dataAll[dataAll.length*(2/3)-3][1], dataAll[dataAll.length*(2/3)-2][1]]
							  },
							  {
								name: kolomB[2],
								data: [dataAll[dataAll.length*(3/3)-8][1], dataAll[dataAll.length*(3/3)-7][1], dataAll[dataAll.length*(3/3)-6][1], dataAll[dataAll.length*(3/3)-4][1], dataAll[dataAll.length*(3/3)-3][1], dataAll[dataAll.length*(3/3)-2][1]]
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
							  logarithmic: false,
							  forceNiceScale: true,
							  labels: {
								show: true,
								style: {
									fontSize: '9px',
									fontWeight: 600,
								},
								formatter: (value) => { 
									return new Intl.NumberFormat('ID',{ maximumFractionDigits: 0 }).format(value) 
								},
							  }
							},
							xaxis: {	
							  categories: [dataAll[dataAll.length*(1/3)-8][2] + ' ' + dataAll[dataAll.length*(1/3)-8][3],dataAll[dataAll.length*(1/3)-7][2] + ' ' + dataAll[dataAll.length*(1/3)-7][3],dataAll[dataAll.length*(1/3)-6][2] + ' ' + dataAll[dataAll.length*(1/3)-6][3],dataAll[dataAll.length*(1/3)-4][2] + ' ' + dataAll[dataAll.length*(1/3)-4][3],dataAll[dataAll.length*(1/3)-3][2] + ' ' + dataAll[dataAll.length*(1/3)-3][3],dataAll[dataAll.length*(1/3)-2][2] + ' ' + dataAll[dataAll.length*(1/3)-2][3]],
							  labels: {
								  style: {
										fontSize: '9px',
										fontWeight: 600,
										colors: ['#006600','#006600','#006600','#006600','#006600','#006600','#006600','#006600']
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
										return new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(value) + ' ' + satuanB
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
					<div class="kotak"><p style="margin: 2px 2px 2px 2px;font-size:12px;color:#006600; text-align:center;" align="center"><b>PRODUKSI BERAS</b><br>
						<text style="color:#006600; font-size:12px; text-align:center;" align="center">dihitung dengan menggunakan angka konversi GKG ke beras berdasarkan Survei Konversi Gabah ke Beras 2018 (SKGB 2018) dan memperhitungkan proporsi gabah dan beras yang susut atau tercecer serta yang digunakan untuk penggunaan non pangan</text></p>
					</div>
				</td>
			</table>
            <table border = "0" align ="center" style="background-color:transparent; font-size:12px; color:#006600;"cellpadding="10">
                <tr align ="center" style="background-color:#006600; font-weight:bold; color: white; font-family: sans-serif;">
                    <td>PERIODE</td>
                    <script>
						document.write('<td width= "25%">' + kolomB[0].toUpperCase() + '</td>');
						document.write('<td width= "25%">' + kolomB[1].toUpperCase() + '</td>');
						document.write('<td width= "25%">' + kolomB[2].toUpperCase() + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#B7DFC3; font-weight:bold; ">
                    <script>
						document.write('<td>' + dataAll[dataAll.length*(1/3)-8][2] + ' ' + dataAll[dataAll.length*(1/3)-8][3] + '</td>');
						if(dataAll[dataAll.length*(1/3)-8][1] == null)
							document.write('<td>N.A.</td>');
						else
							document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(dataAll[dataAll.length*(1/3)-8][1]) + '</td>');
							
						if(dataAll[dataAll.length*(2/3)-8][1] == null)
							document.write('<td>N.A.</td>');
						else
							document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(dataAll[dataAll.length*(2/3)-8][1]) + '</td>');
							
						if(dataAll[dataAll.length*(3/3)-8][1] == null)
							document.write('<td>N.A.</td>');
						else
							document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(dataAll[dataAll.length*(3/3)-8][1]) + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#50D078; font-weight:bold;">
                    <script>
						document.write('<td>' + dataAll[dataAll.length*(1/3)-7][2] + ' ' + dataAll[dataAll.length*(1/3)-7][3] + '</td>');
						if(dataAll[dataAll.length*(1/3)-7][1] == null)
							document.write('<td>N.A.</td>');
						else
							document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(dataAll[dataAll.length*(1/3)-7][1]) + '</td>');
						
						if(dataAll[dataAll.length*(2/3)-7][1] == null)
							document.write('<td>N.A.</td>');
						else
							document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(dataAll[dataAll.length*(2/3)-7][1]) + '</td>');
						
						if(dataAll[dataAll.length*(3/3)-7][1] == null)
							document.write('<td>N.A.</td>');
						else
							document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(dataAll[dataAll.length*(3/3)-7][1]) + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#B7DFC3; font-weight:bold; ">
                    <script>
						document.write('<td>' + dataAll[dataAll.length*(1/3)-6][2] + ' ' + dataAll[dataAll.length*(1/3)-6][3] + '</td>');
						if(dataAll[dataAll.length*(1/3)-6][1] == null)
							document.write('<td>N.A.</td>');
						else
							document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(dataAll[dataAll.length*(1/3)-6][1]) + '</td>');
							
						if(dataAll[dataAll.length*(2/3)-6][1] == null)
							document.write('<td>N.A.</td>');
						else
							document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(dataAll[dataAll.length*(2/3)-6][1]) + '</td>');
							
						if(dataAll[dataAll.length*(3/3)-6][1] == null)
							document.write('<td>N.A.</td>');
						else
							document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(dataAll[dataAll.length*(3/3)-6][1]) + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#50D078; font-weight:bold;">
                    <script>
						document.write('<td>' + dataAll[dataAll.length*(1/3)-5][2] + ' ' + dataAll[dataAll.length*(1/3)-5][3] + '</td>');
						if(dataAll[dataAll.length*(1/3)-5][1] == null)
							document.write('<td>N.A.</td>');
						else
							document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(dataAll[dataAll.length*(1/3)-5][1]) + '</td>');
						
						if(dataAll[dataAll.length*(2/3)-5][1] == null)
							document.write('<td>N.A.</td>');
						else
							document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(dataAll[dataAll.length*(2/3)-5][1]) + '</td>');
						
						if(dataAll[dataAll.length*(3/3)-5][1] == null)
							document.write('<td>N.A.</td>');
						else
							document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(dataAll[dataAll.length*(3/3)-5][1]) + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#B7DFC3; font-weight:bold; ">
                    <script>
						document.write('<td>' + dataAll[dataAll.length*(1/3)-4][2] + ' ' + dataAll[dataAll.length*(1/3)-4][3] + '</td>');
						if(dataAll[dataAll.length*(1/3)-4][1] == null)
							document.write('<td>N.A.</td>');
						else
							document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(dataAll[dataAll.length*(1/3)-4][1]) + '</td>');
						
						if(dataAll[dataAll.length*(2/3)-4][1] == null)
							document.write('<td>N.A.</td>');
						else
							document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(dataAll[dataAll.length*(2/3)-4][1]) + '</td>');
						
						if(dataAll[dataAll.length*(3/3)-4][1] == null)
							document.write('<td>N.A.</td>');
						else
							document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(dataAll[dataAll.length*(3/3)-4][1]) + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#50D078; font-weight:bold;">
                    <script>
						document.write('<td>' + dataAll[dataAll.length*(1/3)-3][2] + ' ' + dataAll[dataAll.length*(1/3)-3][3] + '</td>');
						if(dataAll[dataAll.length*(1/3)-3][1] == null)
							document.write('<td>N.A.</td>');
						else
							document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(dataAll[dataAll.length*(1/3)-3][1]) + '</td>');
							
						if(dataAll[dataAll.length*(2/3)-3][1] == null)
							document.write('<td>N.A.</td>');
						else
							document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(dataAll[dataAll.length*(2/3)-3][1]) + '</td>');
						
						if(dataAll[dataAll.length*(3/3)-3][1] == null)
							document.write('<td>N.A.</td>');
						else
							document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(dataAll[dataAll.length*(3/3)-3][1]) + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#B7DFC3; font-weight:bold; ">
                    <script>
						document.write('<td>' + dataAll[dataAll.length*(1/3)-2][2] + ' ' + dataAll[dataAll.length*(1/3)-2][3] + '</td>');
						if(dataAll[dataAll.length*(1/3)-2][1] == null)
							document.write('<td>N.A.</td>');
						else
							document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(dataAll[dataAll.length*(1/3)-2][1]) + '</td>');
						
						if(dataAll[dataAll.length*(2/3)-2][1] == null)
							document.write('<td>N.A.</td>');
						else
							document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(dataAll[dataAll.length*(2/3)-2][1]) + '</td>');
						
						if(dataAll[dataAll.length*(3/3)-2][1] == null)
							document.write('<td>N.A.</td>');
						else
							document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(dataAll[dataAll.length*(3/3)-2][1]) + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#50D078; font-weight:bold;">
                    <script>
						document.write('<td>' + dataAll[dataAll.length*(1/3)-1][2] + ' ' + dataAll[dataAll.length*(1/3)-1][3] + '</td>');
						if(dataAll[dataAll.length*(1/3)-1][1] == null)
							document.write('<td>N.A.</td>');
						else
							document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(dataAll[dataAll.length*(1/3)-1][1]) + '</td>');
						
						if(dataAll[dataAll.length*(2/3)-1][1] == null)
							document.write('<td>N.A.</td>');
						else
							document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(dataAll[dataAll.length*(2/3)-1][1]) + '</td>');
						
						if(dataAll[dataAll.length*(3/3)-1][1] == null)
							document.write('<td>N.A.</td>');
						else
							document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(dataAll[dataAll.length*(3/3)-1][1]) + '</td>');
					</script>
                </tr>
                <tr align ="left" style="background-color:transparent; line-height:auto;">
                    <script>
						document.write('<td colspan="4" style="#fab;height:auto;width:100px;word-wrap:break-word;"><strong style="font-size: 9px;">' + sumberB + '</strong></td>');
					</script>
                </tr>
				<tr align ="left" style="background-color:transparent; line-height:1px;">
                    <script>
						document.write('<td colspan="4" align = "right" style="font-weight:bold; color:#006600; font-size:13px;">MBOIStatS</td>');
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