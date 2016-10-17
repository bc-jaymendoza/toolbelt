$(function () {
    var seriesOptions = [],
        seriesCounter = 0,
        names = ['offered', 'handled'];

    //configuration
    function createChart() {
        $('#chart-container').highcharts('StockChart', {

			rangeSelector: {
				buttons: [{
					type: 'day',
					count: 1,
					text: '1D'
				}, {
					type: 'week',
					count: 1,
					text: '1W'
				}, {
					type: 'all',
					text: 'All'
				}],
				inputEnabled: false,
				selected: 0
			},

			title: {
				text: 'Calls Offered & Handled (15 minute interval)'
			},

			legend: {
				enabled: true,
				align: 'center',
				backgroundColor: '#FFFFFF',
				borderColor: 'black',
				borderWidth: 2,
				shadow: true
			},

            yAxis: {
                plotLines: [{
                    value: 0,
                    width: 2,
                    color: 'silver'
                }]
            },

            plotOptions: {
                series: {
					dataGrouping: {
						enabled: false
					},
                    showInNavigator: true
                }
            },

            tooltip: {
                pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b><br/>',
                valueDecimals: 1,
                split: true
            },

            series: seriesOptions
        });
    }

    //initial data load
    $.each(names, function (i, name) {
        $.getJSON('/intervals/all?calls=' + name, function (data) {

            seriesOptions[i] = {
                name: name,
                data: data 
            };

            seriesCounter += 1;

            if (seriesCounter === names.length) {
                createChart();
            }
        });
    });

    //update data on a recurring basis
    setInterval(function() {
		var chart = $('#chart-container').highcharts();
		series = chart.series[0];
		recentGraphedPoints = series.points.slice(series.points.length-1, series.points.length);

		//store 16 most recent intervals
		var lastApiPoint = $.parseJSON($.ajax({
			url:  '/intervals/last',
			dataType: "json", 
			async: false
		}).responseText);
		lastApiPoint.timestamp *= 1000;

		lastPointGraphed = series.points.slice(-1).pop();

		//updatedPointData.forEach(function(point) {
		//	console.log(point.timestamp);
		//});

		console.log('last point: ' + lastPointGraphed.x);
		console.log('updated point: ' + lastApiPoint.timestamp);

		if (lastPointGraphed.x != lastApiPoint.timestamp) {
			series.addPoint(lastApiPoint.timestamp, lastApiPoint.calls_offered)
			chart.redraw();
		}


		//recentGraphedPoints.forEach(function(recentGraphedPoint) {
		//	updatedPointData.forEach(function(updatedPoint) {
				//update existing points
		//		if (updatedPoint.timestamp === recentGraphedPoint.x) {
				//	console.log('updatedPoint: ' + updatedPoint.timestamp)
				//	console.log('recentGraphedPoint: ' + recentGraphedPoint.x)
				//	recentGraphedPoint.update(updatedPoint.calls_offered);
		//		} else {
				// mis-match, i.e. we have a new point
		//			series.addPoint(updatedPoint.timestamp, updatedPoint.calls_offered)
		//			chart.redraw();
		//			console.log('updatedPoint: ' + updatedPoint.timestamp)
		//			console.log('recentGraphedPoint: ' + recentGraphedPoint.x)
		//		}
		//	});
		//});
	}, 2000);
});
