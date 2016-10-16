$(function () {
    var seriesOptions = [],
        seriesCounter = 0,
        names = ['offered', 'handled'];

    function createChart() {

        $('#container').highcharts('StockChart', {

            rangeSelector: {
                selected: 2
            },

            yAxis: {
                labels: {
                    formatter: function () {
                        return (this.value > 0 ? ' + ' : '') + this.value + '%';
                    }
                },
                plotLines: [{
                    value: 0,
                    width: 2,
                    color: 'silver'
                }]
            },

            plotOptions: {
                series: {
                    showInNavigator: true
                }
            },

            tooltip: {
                pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b> ({point.change}%)<br/>',
                valueDecimals: 2,
                split: true
            },

            series: seriesOptions
        });
    }

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
});

// setInterval(function() { series.addPoint([startTime,startPoint], false, true); startPoint += 2; startTime += 900000; }, 1000);
