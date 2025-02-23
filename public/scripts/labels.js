function checkAll(obj) {
    for (i = 0; i < obj.elements.length; i++)
        if (obj.elements[i].type == "checkbox")
            obj.elements[i].checked = true;
}

function uncheckAll(obj) {
    for (i = 0; i < obj.elements.length; i++)
        if (obj.elements[i].type == "checkbox")
            obj.elements[i].checked = false;
}
