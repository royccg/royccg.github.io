<!DOCTYPE html>
<html lang="{{ config.language }}">
<head>
  {{ partial('_partials/head/head.swig', {}, {cache: theme.cache.enable}) }}
  {% include '_partials/head/head-unique.swig' %}
  {{- next_inject('head') }}
  <title>{% block title %}{% endblock %}</title>
  {{ partial('_third-party/analytics/index.swig', {}, {cache: theme.cache.enable}) }}
  {{ partial('_scripts/noscript.swig', {}, {cache: theme.cache.enable}) }}


</head>

<body itemscope itemtype="http://schema.org/WebPage">
    

  <!-- APlayer start -->

  <!-- Native Mode
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/aplayer@1.10.1/dist/APlayer.min.css">
  <div id="aplayer"></div>
  <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/aplayer@1.10.1/dist/APlayer.min.js"></script>
  <script type="text/javascript" src="/js/music.js"></script>

  -->

  <!--MetingJS Mode-->
 <!--  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/aplayer@1.10.1/dist/APlayer.min.css">
  
  <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/aplayer@1.10.1/dist/APlayer.min.js"></script>
  <div class="aplayer" 
  data-id="123539059" 
  data-server="netease" 
  data-type="playlist" 
  data-fixed="true" 
  data-autoplay="true" 
  data-order="random" 
  data-volume="0.55" 
  data-theme="#cc543a" 
  data-preload="auto" >
  </div>
  <script src="https://cdn.jsdelivr.net/npm/meting@1.2.0/dist/Meting.min.js"></script>
  <meting-js
    server="netease"
    type="playlist"
    id="123539059">
  </meting-js> -->

  <!---->

  <!-- APlayer end -->

<!-- <script>
  (function(d) {
    var config = {
      kitId: 'tzu7ura',
      scriptTimeout: 3000,
      async: true
    },
    h=d.documentElement,t=setTimeout(function(){h.className=h.className.replace(/\bwf-loading\b/g,"")+" wf-inactive";},config.scriptTimeout),tk=d.createElement("script"),f=false,s=d.getElementsByTagName("script")[0],a;h.className+=" wf-loading";tk.src='https://use.typekit.net/'+config.kitId+'.js';tk.async=true;tk.onload=tk.onreadystatechange=function(){a=this.readyState;if(f||a&&a!="complete"&&a!="loaded")return;f=true;clearTimeout(t);try{Typekit.load(config)}catch(e){}};s.parentNode.insertBefore(tk,s)
  })(document);
</script>
 -->


  <!-- 引用依赖 -->
  <link rel="stylesheet" 
    href="https://cdn.jsdelivr.net/npm/aplayer@1.10.1/dist/APlayer.min.css">
  <script src="https://cdn.jsdelivr.net/npm/aplayer@1.10.1/dist/APlayer.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/meting@1.2.0/dist/Meting.min.js"></script>

  <!-- 我使用的APlayer本体 -->
  <div class="aplayer" 
    data-id="123539059" 
    data-server="netease" 
    data-type="playlist" 
    data-fixed="true" 
    data-autoplay="true" 
    data-order="random" 
    data-volume="0.55" 
    data-theme="#cc543a" 
    data-preload="auto" >
    </div>
  <!--如果将本体放在body里面导致页面加载出现问题，请尝试放到body体后面-->

  <div class="container{%- if theme.motion.enable %} use-motion{%- endif %}">
    <div class="headband"></div>

    <header class="header" itemscope itemtype="http://schema.org/WPHeader">
      <div class="header-inner">{% include '_partials/header/index.swig' %}</div>
    </header>

    {{ partial('_partials/widgets.swig', {}, {cache: theme.cache.enable}) }}

    <main class="main">
      <div class="main-inner">
        <div class="content-wrap">
          {% include '_partials/header/sub-menu.swig' %}
          <div class="content {% block class %}{% endblock %}">
            {% block content %}{% endblock %}
          </div>
          {% include '_partials/comments.swig' %}
        </div>
        {%- if theme.sidebar.display !== 'remove' %}
          {% block sidebar %}{% endblock %}
        {%- endif %}
      </div>
    </main>

    <footer class="footer">
      <div class="footer-inner">
        {% include '_partials/languages.swig' %}
        {{ partial('_partials/footer.swig', {}, {cache: theme.cache.enable}) }}
        {{ partial('_third-party/statistics/index.swig', {}, {cache: theme.cache.enable}) }}
      </div>
    </footer>
  </div>

  {{ partial('_scripts/index.swig', {}, {cache: theme.cache.enable}) }}
  {{ partial('_third-party/index.swig', {}, {cache: theme.cache.enable}) }}

  {%- if theme.pjax %}
    <div id="pjax">
  {%- endif %}
  {% include '_third-party/math/index.swig' %}
  {% include '_third-party/quicklink.swig' %}

  {{- next_inject('bodyEnd') }}
  {%- if theme.pjax %}
    </div>
  {%- endif %}
</body>

<!-- <div id="contentleft">
  <div class="aplayer" 
  data-fixed="true" 
  data-autoplay="true" 
  data-order="random" 
  data-volume="0.55" 
  data-theme="#cc543a" 
  data-preload="auto" 
  ></div>
</div> -->



</html>



