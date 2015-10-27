$(function() {
    $.ui.autocomplete.prototype._renderItem = function (ul, item) {
        var searched_term = extractLast(this.term);
        label = item.name.replace(new RegExp("(?![^&;]+;)(?!<[^<>]*)(" +
                                    $.ui.autocomplete.escapeRegex(searched_term) +
                                    ")(?![^<>]*>)(?![^&;]+;)", "gi"), "<strong>$1</strong>");
        return $("<li></li>")
                .append(label)
                .appendTo(ul);
    };

    function split(val) {
        return val.split(/,\s*/);
    }

    function extractLast(term) {
        return split(term).pop();
    }

    $("input#tags_autocomplete")
    // don't navigate away from the field on tab when selecting an item
    .bind("keydown", function(event) {
        if (event.keyCode === $.ui.keyCode.TAB && $(this).autocomplete("instance").menu.active) {
            event.preventDefault();
        }
    })
    .autocomplete({
        minLength: 0,
        source: function(request, response) {
            $.getJSON("/tags_autocomplete", { q: extractLast(request.term) }, response);
        },
        focus: function() {
            // prevent value inserted on focus
            return false;
        },
        select: function(event, ui) {
            var terms = split(this.value);
            // remove the current input
            terms.pop();
            // add the selected item
            terms.push(ui.item.name);
            // add placeholder to get the comma-and-space at the end
            terms.push("");
            $(this).val(terms.join(", "));
            return false;
        }
    });
});