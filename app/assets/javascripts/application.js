// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require twitter/bootstrap
//= require select2
//= require best_in_place
//= require bootstrap.datepicker
//= require_tree .

// Application specific behaviour
function addAlternateTableBehaviour() {
  $("table.list tr:odd").addClass("odd");
}

// Dirty Form
function makeEditForm(form) {
  var buttons = form.find("fieldset.buttons");
  buttons.animate({opacity: 1}, 1000);
}

function addDirtyForm() {
  $(".form-view form").dirty_form()
    .dirty(function(event, data){
      makeEditForm($(this));
    })

  $(".form-view").focusin(function() {makeEditForm($(this))});
}

function addNestedFormBehaviour() {
  $('body').on('click', '.delete-nested-form-item', function(event) {
    var item = $(this).parents('.nested-form-item');
    // Hide item
    item.hide();
    // Mark as ready to delete
    item.find("input[name$='[_destroy]']").val("1");
    item.addClass('delete');
    // Drop input fields to prevent browser validation problems
    item.find(":input").not("[name$='[_destroy]'], [name$='[id]']").remove();

    // TODO: should be callbacks
    //updatePositions($(this).parents('.nested-form-container'));
    //updateLineItems();

    // Don't follow link
    event.preventDefault();
  });
}

// Currency helpers
function currencyRound(value) {
  if (isNaN(value)) {
    return 0.0;
  };

  rounded = Math.round(value * 20) / 20;

  return rounded.toFixed(2);
}

// Line Item calculation
function updateLineItemPrice(lineItem) {
  var list = lineItem.parent();
  var reference_code = lineItem.find(":input[name$='[reference_code]']").val();
  var quantity = lineItem.find(":input[name$='[quantity]']").val();
  if (quantity == '%' || quantity == 'saldo_of') {
    var included_items;
    if (reference_code == '') {
      included_items = lineItem.prevAll('.line_item');
    } else {
      // Should match using ~= but acts_as_taggable_adds_colons between tags
      included_items = list.find(":input[name$='[code]'][value='" + reference_code + "']").parents('.line_item, .saldo_line_item');
      if (included_items.length == 0) {
        // Should match using ~= but acts_as_taggable_adds_colons between tags
        included_items = list.find(":input[name$='[include_in_saldo_list]'][value*='" + reference_code + "']").parents('.line_item, .saldo_line_item');
      }
    }
    var price_input = lineItem.find(":input[name$='[price]']");
    price_input.val(calculateTotalAmount(included_items));
  }
}

function updateAllLineItemPrices() {
  $('.line_item, .saldo_line_item').each(function() {
    updateLineItemPrice($(this));
  });
}

function calculateLineItemTotalAmount(lineItem) {
  var times_input = lineItem.find(":input[name$='[times]']");
  var times = accounting.parse(times_input.val());
  if (isNaN(times)) {
    times = 1;
  };

  var quantity_input = lineItem.find(":input[name$='[quantity]']");
  var price_input = lineItem.find(":input[name$='[price]']");
  var price = accounting.parse(price_input.val());

  // For 'saldo_of' items, we don't take accounts into account
  if (quantity_input.val() == "saldo_of") {
    return currencyRound(price);
  };

  var direct_account_id = $('#line_items').data('direct-account-id');
  var direct_account_factor = $('#line_items').data('direct-account-factor');

  var factor = 0;
  if (lineItem.find(":input[name$='[credit_account_id]']").val() == direct_account_id) {
    factor = 1;
  };
  if (lineItem.find(":input[name$='[debit_account_id]']").val() == direct_account_id) {
    factor = -1;
  };

  if (quantity_input.val() == '%') {
    times = times / 100;
  };

  return currencyRound(times * price * factor * direct_account_factor);
}

function updateLineItemTotalAmount(lineItem) {
  var total_amount_input = lineItem.find(".total_amount");
  var total_amount = accounting.formatNumber(calculateLineItemTotalAmount(lineItem));

  // Update Element
  total_amount_input.text(total_amount);
}

function calculateTotalAmount(lineItems) {
  var total_amount = 0;
  $(lineItems).each(function() {
    total_amount += accounting.parse($(this).find(".total_amount").text());
  });

  return currencyRound(total_amount);
}

function updateLineItems() {
  if ($('#customer_shippings').length > 0) {
    $('.customer_shipping').each(function() {
      updateLineItemPrice($(this));
      updateLineItemTotalAmount($(this));
    });
  };
}

// Recalculate after every key stroke
function handleLineItemChange(event) {
  // If character is <return>
  if(event.keyCode == 13) {
    // ...trigger form action
    $(event.currentTarget).submit();
  } else if(event.keyCode == 32) {
    // ...trigger form action
    $(event.currentTarget).submit();
  } else {
    updateLineItems();
  }
}

function addCalculateTotalAmountBehaviour() {
  $("#line_items").find(":input[name$='[times]'], :input[name$='[quantity]'], :input[name$='[price]'], input[name$='[reference_code]']").on('keyup', handleLineItemChange);
  $("#line_items").bind("sortstop", handleLineItemChange);
}

// Sorting
function updatePositions(collection) {
  var items = collection.find('.nested-form-item').not('.delete');
  items.each(function(index, element) {
    $(this).find("input[id$='_position']").val(index + 1)
  });
}

// Override generic version in cyt.js
function addSortableBehaviour() {
  $(".sortable").sortable({
    placeholder: "ui-state-highlight",
    forcePlaceholderSize: true,
    stop:        function(event, ui) {
      updatePositions($(this));
    }
  });

  $('.sortable').each(function() {
    updatePositions($(this));
  });
}

// Combobox                                                                         
function addComboboxBehaviour() {
  $("select.combobox").select2({
    allowClear: true
  });
}

// Autofocus element having attribute data-autofocus                                
function addAutofocusBehaviour() {
  $('*[data-autofocus=true]')
    .filter(function() {return $(this).parents('.form-view').length < 1})
    .first().focus();
};

// Add datepicker
function addDatePickerBehaviour() {
  $('.date-picker').each(function(){
    if ($(this).hasClass('date')) {
      $(this).data('date', new Date().toISOString());
    }
    $(this).datepicker({ format: 'yyyy-mm-dd' });
    $(this).width($(this).width() - 27);
  });
};

//
function addSortableBehaviour() {
  $(".sortable").sortable({
    placeholder: 'ui-state-highlight'
  });
  $(".sortable").disableSelection();
};


// Linkify containers having attribute data-href-container
function addLinkifyContainersBehaviour() {
  var elements = $('*[data-href-container]');
  elements.each(function() {
    var element = $(this);
    var container = element.closest(element.data('href-container'));
    container.css('cursor', "pointer");
    container.addClass('linkified_container')
    var href = element.attr('href');
    element.addClass('linkified_element')

    container.delegate('*', 'click', {href: href}, function(event) {
      // Don't override original link behaviour
      if (event.target.nodeName != 'A' && $(event.target).parents('a').length == 0) {
        document.location.href = href;
      };
    });
  });
};

// Autogrow
function addAutogrowBehaviour() {
  $(".autogrow").elastic();
};

// Add tooltips for overview
function addTooltipBehaviour() {
  $(".tooltip-title[title]").each(function() {
    if ( $(this).attr('title') != '' ) {
      $(this).tooltip({
        position: 'top center',
        predelay: 500,
        effect: 'fade'
      });
    }
  });
};

// Add tooltips for overview
function addOverviewTooltipBehaviour() {
  $('.overview-list li a[title]').tooltip({
    position: 'center right',
    predelay: 500,
    effect: 'fade'
  });
};

// Add icon action tooltips
function addIconTooltipBehaviour() {
  $('a.icon-tooltip[title]').tooltip({
    tipClass: 'icon-tooltip-popup',
    effect: 'fade',
    fadeOutSpeed: 100
  });
};

// Modal dialog support
function setupSubmitButtons() {
  $("body").on('click', '.modal-footer .submit-button', function() {
    var form = $(this).parents('.modal').find('.modal-body form');
    form.submit();
  });
}

// Cancel button support
function setupCancelButtons() {
  // Key handler
  $(document).keydown(function(e) {
    var cancel_button = $('.cancel-button:visible')
    // No action if no visible cancel button present
    if (cancel_button.length == 0) {
      return;
    }

    if (e.which == 27) {
      cancel_button.click();
    }
  })
}

function addModalBehaviour() {
  setupSubmitButtons();
  setupCancelButtons();
}

// Initialize behaviours
function initializeBehaviours() {
  addComboboxBehaviour();
  addAutofocusBehaviour();
  addDatePickerBehaviour();
  addSortableBehaviour();
  addLinkifyContainersBehaviour();
  addIconTooltipBehaviour();
  addModalBehaviour();

  // application
  addAlternateTableBehaviour();
  addDirtyForm();
  addNestedFormBehaviour();

  addCalculateTotalAmountBehaviour();

  updateLineItems();

  // twitter bootstrap
  $(function () {
    $('.tabs').tabs();
    $(".alert").alert();
    $("*[rel=popover]").popover({
      offset: 10
    });
    $('.small-tooltip').tooltip({
      placement: 'right'
    });
  })

  // select2
  $('.select2').select2({
      allowClear: true
  });
  $('.select2-tags').each(function(index, element) {
    var tags = $(element).data('tags') || '';

    $(element).select2({
      tags: tags,
      tokenSeparators: [","]
    })
  })

  // best_in_place
  $(".best_in_place").best_in_place();
}

// Loads functions after DOM is ready
$(document).ready(initializeBehaviours);
