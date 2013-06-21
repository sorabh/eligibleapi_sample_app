#= require lib/underscore
#= require lib/jquery
#= require jquery_ujs
#= require lib/bootstrap-alert
#= require lib/jquery.tools.min
#= require lib/jquery-ui-1.9.2.custom
#= require lib/jquery.validate
#= require lib/jquery.cycle.lite
#= require lib/jquery.form
#= require lib/prettify
#= require lib/quicksearch
#= require main
#= require_self

$(document).ready ->
  # Quick search
  $("#q").quicksearch("#posts li").focus()  if $("#q").size() > 0
  $("#faq_q").quicksearch("#faq_list li").focus()  if $("#faq_q").size() > 0
  $("#errors_q").quicksearch("#error_list .error_item").focus()  if $("#errors_q").size() > 0

