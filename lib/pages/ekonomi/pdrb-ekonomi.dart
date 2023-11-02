import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';

class PDRB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDRB'),
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
        <title>PDRB Lapangan Usaha</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style>
			.container {
				width: 100%;
				min-height: 200px;
			}
			.kotak{
				width: 350px;
				height: auto;
				border: 2px solid #7F6000;
				border-radius: 10px 10px 10px 10px;
				margin: 1px 1px 1px 1px;
				background-color: #DBCFAF;
			}
    </style>
        <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
        <!-- <link href="path/to/css/style.css" rel='stylesheet' type='text/css' /> -->
        <!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js"></script> -->
        <!--        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">-->
    </head>
    <script>
			var data;
			url='https://webapi.bps.go.id/v1/api/list/model/data/domain/3573/var/436/key/9db89e91c3c142df678e65a78c4e547f';
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
			const barisA = data.vervar;
			const barisB = barisA.map(c => c.label);
			const kolomA = data.turvar;
			const kolomB = kolomA.map(d => d.label);
			var pjKolom = kolomB.length;
			const thA = data.tahun;
			const thB = thA.map(e => e.label);
			var pjThData = thB.length;
			//alert('Your query 3: ' + sumberB +" count= " + thB.length);

			const valData = Object.values(data.datacontent);
			var pjData = valData.length;
			//alert('Count: ' + valData.length + " data: " + pjThData+ " data: " + barisB[0].substr(0, barisB[0].indexOf(' ')));
	</script>

    <body style="background-image: url(file:///android_res/drawable/back_perekonomian.png); background-size: 100% 100%;">
        <div class="container" align ="center" >
            <script> 
			if(satuanB == ""){
				document.write('<p align= "center" style="color:#7F6000; font-weight: bold;#fab;width:370px;word-wrap:break-word;">PDRB ATAS DASAR HARGA BERLAKU DI KOTA MALANG MENURUT LAPANGAN USAHA<br>TAHUN '+ thB[pjThData-1]+'</p>'); 
			}
			else{
				document.write('<p align= "center" style="color:#7F6000; font-weight: bold;#fab;width:370px;word-wrap:break-word;">PDRB ATAS DASAR HARGA BERLAKU DI KOTA MALANG MENURUT LAPANGAN USAHA<br>TAHUN '+ thB[pjThData-1]+'</p>'); 
			}
			</script>
            <table border = "0" align ="center" style="background-color:transparent;" cellpadding="10">
				<div id="chart" align ="center" style="width:370px; text-align:center; height:25px;" >
					 <script>
						var options = {
						  series: [{
						  data: [valData[1*pjThData-1], valData[4*pjThData-1], valData[7*pjThData-1], valData[10*pjThData-1], valData[13*pjThData-1], valData[16*pjThData-1], valData[19*pjThData-1], valData[22*pjThData-1], valData[25*pjThData-1], valData[28*pjThData-1], valData[31*pjThData-1], valData[34*pjThData-1], valData[37*pjThData-1], valData[40*pjThData-1], valData[43*pjThData-1], valData[46*pjThData-1], valData[49*pjThData-1]]
						}],
						  chart: {
						  type: 'bar',
						  height: 380,
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
						plotOptions: {
						  bar: {
							barHeight: '100%',
							distributed: true,
							horizontal: true,
							dataLabels: {
							  position: 'bottom'
							},
						  }
						},
						colors: ['#33b2df', '#546E7A', '#d4526e', '#13d8aa', '#A5978B', '#2b908f', '#f9a3a4', '#90ee7e',
						  '#f48024', '#69d2e7','#33b2df', '#546E7A', '#d4526e', '#13d8aa', '#A5978B', '#2b908f', '#f9a3a4'
						],
						dataLabels: {
						  enabled: true,
						  textAnchor: 'start',
						  style: {
							fontSize: '8px',
							colors: ['#000']
						  },
						  formatter: function (val, opt) {
							return opt.w.globals.labels[opt.dataPointIndex].substring(0,3) + " : Rp " + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(val).toFixed(2)) + ' milyar'
						  },
						  offsetX: 0,
						  dropShadow: {
							enabled: true
						  }
						},
						stroke: {
						  width: 1,
						  colors: ['#fff']
						},
						xaxis: {
						  categories: [barisB[0], barisB[1], barisB[2], barisB[3], barisB[4], barisB[5], barisB[6],
							barisB[7], barisB[8], barisB[9], barisB[10], barisB[11], barisB[12], barisB[13], barisB[14], barisB[15], barisB[16]
						  ],
						  labels: {
							show: true,
							style: {
								fontSize: '12px',
								fontWeight: 600,
							},
							formatter: (value) => { 
								return new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(value).toFixed(2)) 
							},
						  }
						},
						yaxis: {
						  show: false,
						  labels: {
							show: false
						  }
						},
						legend: {
							 show: false
						},
						tooltip: {
						  theme: 'dark',
						  style: {
							fontSize: '9px'
						  },
						  x: {
							show: true,
						  },
						  y: {
							formatter: function(value){
								return 'Rp ' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(value).toFixed(2)) + ' milyar'
							},
							title: {
							  formatter: function () {
								return ''
							  }
							}
						  }
						}
						};

						var chart = new ApexCharts(document.querySelector("#chart"), options);
						chart.render();
					</script>
				</div>
			</table>
            <!-- <div id="curve_chart" style="width: 100%; height: 300px"></div><br> -->
            <!-- <div id="canvas" style="height: 300px; width: 100%;"></div> -->
            <!-- <script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script><br><br> -->
            <!-- <canvas id="canvas" height="300" width="500"></canvas> -->
			<table border = "0" align ="center" style="width:auto; background-color:transparent;" cellpadding="10">
				<td>
					<script> 
					if(satuanB == ""){
						document.write('<p align= "center" style="color:#7F6000; font-weight: bold;">DISTRIBUSI PDRB ADHB<br>'+kolomB[0].toUpperCase()+', '+kolomB[1].toUpperCase()+', DAN '+kolomB[2].toUpperCase()+'<br>MENURUT LAPANGAN USAHA, TAHUN '+ thB[pjThData-1]+'</p>'); 
					}
					else{
						document.write('<p align= "center" style="color:#7F6000; font-weight: bold;">DISTRIBUSI PDRB ADHB<br> '+kolomB[0].toUpperCase()+', '+kolomB[1].toUpperCase()+', DAN '+kolomB[2].toUpperCase()+'<br>MENURUT LAPANGAN USAHA, TAHUN '+ thB[pjThData-1]+'<br>(Persen)</p>'); 
					}
					</script>
				</td>
			</table>
            <table border = "0" align ="center" style="background-color:transparent; font-size:12px; color:#7F6000;"cellpadding="10">
                <tr align ="center" style="background-color:#7F6000; font-weight:bold; color: white; font-family: sans-serif;">
                    <td>LAPANGAN USAHA</td>
                    <script>
						document.write('<td>'+kolomB[0].toUpperCase()+'</td>');
						document.write('<td>'+kolomB[1].toUpperCase()+'</td>');
						document.write('<td>'+kolomB[2].toUpperCase()+'</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#DBB958; font-weight:bold; ">
                    <script>
						document.write('<td style="font-size:9px;text-align:left;#fab;width:130px;word-wrap:break-word;">' + barisB[0] + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[1*pjThData-1]/valData[52*pjThData-1]*100).toFixed(2)) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[2*pjThData-1]/valData[53*pjThData-1]*100).toFixed(2)) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[3*pjThData-1]/valData[54*pjThData-1]*100).toFixed(2)) + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#DBCFAF; font-weight:bold;">
                    <script>
						document.write('<td style="font-size:9px;text-align:left;#fab;width:130px;word-wrap:break-word;">' + barisB[1] + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[4*pjThData-1]/valData[52*pjThData-1]*100).toFixed(2)) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[5*pjThData-1]/valData[53*pjThData-1]*100).toFixed(2)) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[6*pjThData-1]/valData[54*pjThData-1]*100).toFixed(2)) + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#DBB958; font-weight:bold; ">
                    <script>
						document.write('<td style="font-size:9px;text-align:left;#fab;width:130px;word-wrap:break-word;">' + barisB[2] + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[7*pjThData-1]/valData[52*pjThData-1]*100).toFixed(2)) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[8*pjThData-1]/valData[53*pjThData-1]*100).toFixed(2)) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[9*pjThData-1]/valData[54*pjThData-1]*100).toFixed(2)) + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#DBCFAF; font-weight:bold;">
                    <script>
						document.write('<td style="font-size:9px;text-align:left;#fab;width:130px;word-wrap:break-word;">' + barisB[3] + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[10*pjThData-1]/valData[52*pjThData-1]*100).toFixed(2)) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[11*pjThData-1]/valData[53*pjThData-1]*100).toFixed(2)) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[12*pjThData-1]/valData[54*pjThData-1]*100).toFixed(2)) + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#DBB958; font-weight:bold; ">
                    <script>
						document.write('<td style="font-size:9px;text-align:left;#fab;width:130px;word-wrap:break-word;">' + barisB[4] + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[13*pjThData-1]/valData[52*pjThData-1]*100).toFixed(2)) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[14*pjThData-1]/valData[53*pjThData-1]*100).toFixed(2)) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[15*pjThData-1]/valData[54*pjThData-1]*100).toFixed(2)) + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#DBCFAF; font-weight:bold;">
                    <script>
						document.write('<td style="font-size:9px;text-align:left;#fab;width:130px;word-wrap:break-word;">' + barisB[5] + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[16*pjThData-1]/valData[52*pjThData-1]*100).toFixed(2)) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[17*pjThData-1]/valData[53*pjThData-1]*100).toFixed(2)) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[18*pjThData-1]/valData[54*pjThData-1]*100).toFixed(2)) + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#DBB958; font-weight:bold; ">
                    <script>
						document.write('<td style="font-size:9px;text-align:left;#fab;width:130px;word-wrap:break-word;">' + barisB[6] + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[19*pjThData-1]/valData[52*pjThData-1]*100).toFixed(2)) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[20*pjThData-1]/valData[53*pjThData-1]*100).toFixed(2)) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[21*pjThData-1]/valData[54*pjThData-1]*100).toFixed(2)) + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#DBCFAF; font-weight:bold;">
                    <script>
						document.write('<td style="font-size:9px;text-align:left;#fab;width:130px;word-wrap:break-word;">' + barisB[7] + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[22*pjThData-1]/valData[52*pjThData-1]*100).toFixed(2)) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[23*pjThData-1]/valData[53*pjThData-1]*100).toFixed(2)) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[24*pjThData-1]/valData[54*pjThData-1]*100).toFixed(2)) + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#DBB958; font-weight:bold; ">
                    <script>
						document.write('<td style="font-size:9px;text-align:left;#fab;width:130px;word-wrap:break-word;">' + barisB[8] + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[25*pjThData-1]/valData[52*pjThData-1]*100).toFixed(2)) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[26*pjThData-1]/valData[53*pjThData-1]*100).toFixed(2)) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[27*pjThData-1]/valData[54*pjThData-1]*100).toFixed(2)) + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#DBCFAF; font-weight:bold;">
                    <script>
						document.write('<td style="font-size:9px;text-align:left;#fab;width:130px;word-wrap:break-word;">' + barisB[9] + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[28*pjThData-1]/valData[52*pjThData-1]*100).toFixed(2)) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[29*pjThData-1]/valData[53*pjThData-1]*100).toFixed(2)) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[30*pjThData-1]/valData[54*pjThData-1]*100).toFixed(2)) + '</td>');
					</script>
                </tr>
				<tr align ="center" style="background-color:#DBB958; font-weight:bold; ">
                    <script>
						document.write('<td style="font-size:9px;text-align:left;#fab;width:130px;word-wrap:break-word;">' + barisB[10] + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[31*pjThData-1]/valData[52*pjThData-1]*100).toFixed(2)) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[32*pjThData-1]/valData[53*pjThData-1]*100).toFixed(2)) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[33*pjThData-1]/valData[54*pjThData-1]*100).toFixed(2)) + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#DBCFAF; font-weight:bold;">
                    <script>
						document.write('<td style="font-size:9px;text-align:left;#fab;width:130px;word-wrap:break-word;">' + barisB[11] + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[34*pjThData-1]/valData[52*pjThData-1]*100).toFixed(2)) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[35*pjThData-1]/valData[53*pjThData-1]*100).toFixed(2)) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[36*pjThData-1]/valData[54*pjThData-1]*100).toFixed(2)) + '</td>');
					</script>
                </tr>
				<tr align ="center" style="background-color:#DBB958; font-weight:bold; ">
                    <script>
						document.write('<td style="font-size:9px;text-align:left;#fab;width:130px;word-wrap:break-word;">' + barisB[12] + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[37*pjThData-1]/valData[52*pjThData-1]*100).toFixed(2)) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[38*pjThData-1]/valData[53*pjThData-1]*100).toFixed(2)) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[39*pjThData-1]/valData[54*pjThData-1]*100).toFixed(2)) + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#DBCFAF; font-weight:bold;">
                    <script>
						document.write('<td style="font-size:9px;text-align:left;#fab;width:130px;word-wrap:break-word;">' + barisB[13] + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[40*pjThData-1]/valData[52*pjThData-1]*100).toFixed(2)) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[41*pjThData-1]/valData[53*pjThData-1]*100).toFixed(2)) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[42*pjThData-1]/valData[54*pjThData-1]*100).toFixed(2)) + '</td>');
					</script>
                </tr>
				<tr align ="center" style="background-color:#DBB958; font-weight:bold; ">
                    <script>
						document.write('<td style="font-size:9px;text-align:left;#fab;width:130px;word-wrap:break-word;">' + barisB[14] + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[43*pjThData-1]/valData[52*pjThData-1]*100).toFixed(2)) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[44*pjThData-1]/valData[53*pjThData-1]*100).toFixed(2)) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[45*pjThData-1]/valData[54*pjThData-1]*100).toFixed(2)) + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#DBCFAF; font-weight:bold;">
                    <script>
						document.write('<td style="font-size:9px;text-align:left;#fab;width:130px;word-wrap:break-word;">' + barisB[15] + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[46*pjThData-1]/valData[52*pjThData-1]*100).toFixed(2)) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[47*pjThData-1]/valData[53*pjThData-1]*100).toFixed(2)) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[48*pjThData-1]/valData[54*pjThData-1]*100).toFixed(2)) + '</td>');
					</script>
                </tr>
				<tr align ="center" style="background-color:#DBB958; font-weight:bold; ">
                    <script>
						document.write('<td style="font-size:9px;text-align:left;#fab;width:130px;word-wrap:break-word;">' + barisB[16] + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[49*pjThData-1]/valData[52*pjThData-1]*100).toFixed(2)) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[50*pjThData-1]/valData[53*pjThData-1]*100).toFixed(2)) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[51*pjThData-1]/valData[54*pjThData-1]*100).toFixed(2)) + '</td>');
					</script>
                </tr>
                <tr align ="center" style="background-color:#DBCFAF; font-weight:bold;">
                    <script>
						document.write('<td style="font-size:9px;text-align:left;#fab;width:130px;word-wrap:break-word;">' + barisB[17] + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[52*pjThData-1]/valData[52*pjThData-1]*100).toFixed(2)) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[53*pjThData-1]/valData[53*pjThData-1]*100).toFixed(2)) + '</td>');
						document.write('<td>' + new Intl.NumberFormat('ID',{ minimumFractionDigits: 2 }).format(Number(valData[54*pjThData-1]/valData[54*pjThData-1]*100).toFixed(2)) + '</td>');
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