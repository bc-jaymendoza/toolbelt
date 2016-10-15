$(function () {
    var seriesOptions = [],
        seriesCounter = 0,
        names = ['offered', 'handled'];

    /**
     * Create the chart when all data is loaded
     * @returns {undefined}
     */
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

        $.getJSON('/intervals/between?min_date=1476333005&max_date=1476419412&calls=' + name, function (data) {

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
