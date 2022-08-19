{% include 'baidu-push.swig' %}

{% include 'rating.swig' %}

{%- if theme.algolia_search.enable %}
  {% include 'search/algolia-search.swig' %}
{% elif theme.swiftype_key %}
  {% include 'search/swiftype.swig' %}
{% elif theme.local_search.enable %}
  {% include 'search/localsearch.swig' %}
{%- endif %}

{% include 'chat/chatra.swig' %}
{% include 'chat/tidio.swig' %}

{% include 'tags/pdf.swig' %}
{% include 'tags/mermaid.swig' %}


<script type="text/javascript">
var originalTitle = document.title;      // 1.
var crashSwitched = false;               // 2.
var titleTime;
document.addEventListener('visibilitychange', function () {
  if (document.hidden) {
    if (Math.random() < parseFloat({{ 0.25 }})) {         // 3.
      crashSwitched = true;              // 2.a.
      document.title = '{{ "╭(°A°`)╮ 页面崩溃啦~" }}' + originalTitle;     // 1.a.
      clearTimeout(titleTime);
    }
  } else {
    if (crashSwitched == true) {
      crashSwitched = false;             // 2.b.
      document.title = '{{ "(ฅ>ω<*ฅ) 咦，又好了~" }}' + originalTitle;   // 1.b.
      titleTime = setTimeout(function () {
        document.title = originalTitle;  // 1.c.
      }, 2000);
    }
  }
});
</script>