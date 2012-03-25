Raphael.fn.pieChart = function (cx, cy, r, values, labels, stroke) {
    var paper = this,
        rad = Math.PI / 180,
covers = this.set(),
        chart = this.set();
    function sector(cx, cy, r, startAngle, endAngle, params) {
        console.log(params.fill);
        var x1 = cx + r * Math.cos(-startAngle * rad),
            x2 = cx + r * Math.cos(-endAngle * rad),
            y1 = cy + r * Math.sin(-startAngle * rad),
            y2 = cy + r * Math.sin(-endAngle * rad);
        return paper.path(["M", cx, cy, "L", x1, y1, "A", r, r, 0, +(endAngle - startAngle > 180), 0, x2, y2, "z"]).attr(params);
    }
    var angle = 0,
        total = 0,
        start = 0,
        process = function (j) {
            var value = values[j],
                angleplus = 360 * value / total,
                popangle = angle + (angleplus / 2),
                color = Raphael.hsb(start, .75, 1),
                ms = 500,
                delta = 30,
                bcolor = Raphael.hsb(start, 1, 1),
                p = sector(cx, cy, r, angle, angle + angleplus, {fill: "90-" + bcolor + "-" + color, stroke: stroke, "stroke-width": 3}),
                txt = paper.text(cx + (r + delta + 55) * Math.cos(-popangle * rad), cy + (r + delta + 25) * Math.sin(-popangle * rad), labels[j]).attr({fill: bcolor, stroke: "none", opacity: 0, "font-size": 20});
            p.mouseover(function () {
                p.stop().animate({transform: "s1.1 1.1 " + cx + " " + cy}, ms, "elastic");
                txt.stop().animate({opacity: 1}, ms, "elastic");
            }).mouseout(function () {
                p.stop().animate({transform: ""}, ms, "elastic");
                txt.stop().animate({opacity: 0}, ms);
            });
            angle += angleplus;
            chart.push(p);
            chart.push(txt);
            start += .1;
	// 
	// 
	//         var x = cx + r + r / 5,
	//             y = cy,
	//             h = y + 10;
	//         dir = "east";
	//         mark = "disc";
	//         chart.labelz = paper.set();
	//             var clr = bcolor,
	//                 txt;
	//             //labels[j] = graph.labelise(labels[j], values[i], total);
	//             chart.labelz.push(paper.set());
	//             //chart.labels[i].push(graph[mark](x + 5, h, 5).attr({fill: clr, stroke: "none"}));
	// //txt = paper.text(x + 20, h, labels[j] || values[j]).attr(graph.txtattr).attr({fill: opts.legendcolor || "#000", "text-anchor": "start"})
	//   //          chart.labelz.push(txt = paper.text(cx + (r + delta + 55) * Math.cos(-popangle * rad), cy + (r + delta + 25) * Math.sin(-popangle * rad), labels[j]).attr({fill: bcolor, stroke: 1, opacity: 1, "font-size": 20}));
	//             chart.labelz.push(txt = paper.text(x + 20, h, labels[j]).attr({fill: bcolor, stroke: 1, opacity: 1, "font-size": 20}));
	//             //covers[j].label = chart.labels[i];
	//             h += txt.getBBox().height * 1.2;
	//         var bb = chart.labelz.getBBox(),
	//             tr = {
	//                 east: [0, -bb.height / 2],
	//                 west: [-bb.width - 2 * r - 20, -bb.height / 2],
	//                 north: [-r - bb.width / 2, -r - bb.height - 10],
	//                 south: [-r - bb.width / 2, r + 10]
	//             }[dir];
	//         chart.labelz.translate.apply(chart.labelz, tr);
	//         chart.push(chart.labelz);
        };
    for (var i = 0, ii = values.length; i < ii; i++) {
        total += values[i];
    }
    for (i = 0; i < ii; i++) {
        process(i);
    }
    return chart;
};
jQuery.noConflict();
jQuery(function () {
    var values = [],
        labels = [];
    jQuery(".piepieces").each(function () {
        values.push(parseInt(jQuery("td", this).text(), 10));
        labels.push(jQuery("th", this).text());
    });
    jQuery("#piechart").hide();
    Raphael("holder", 700, 700).pieChart(350, 350, 200, values, labels, "#efefef");

    var values2 = [],
        labels2 = [];
    jQuery(".piepieces2").each(function () {
        values2.push(parseInt(jQuery("td", this).text(), 10));
        labels2.push(jQuery("th", this).text());
    });
    jQuery("#piehart").hide();
    Raphael("damnthing", 700, 700).pieChart(350, 350, 200, values2, labels2, "#efefef");
});
