new Vue({
el: '#app',
data: function() {
return { visible: false, active: 0 }
},
methods: {
      next() {
        if (this.active++ > 2) this.active = 0;
      }
    }
})