var items = [];

$(document).ready(function () {
    $("#btnAdd").on("click", function () {
        var item = $("#txtItem").val();
        var date;
        if ($("#dtItem").val()) {
            date = new Date($("#dtItem").val());
        }
        addItem({"item": item, "deadline": date});
    });
    
    $("#mobAdd").on("click", function () {
        $("#mobile").append("Arnaud is gay <br />");
    });
    
});



function addItem(item) {
    items.push(item);

    var div = $("<div class=\"panel panel-default col-md-2 col-md-3\">");
    var panel = $("<div class=\"panel-body\">");
    var h3 = $("<h3>");
    var p = $("<p>");

    if (item.deadline !== undefined) {
        p.text(item.deadline.getDate() + "/" + item.deadline.getMonth() + "/" + item.deadline.getFullYear());
    }
    h3.text(item.item);

    panel.append(h3);
    panel.append(p);
    div.append(panel);

    $("#items").append(div);
}
