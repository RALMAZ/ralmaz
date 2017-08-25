import Vue from 'vue'
import VueRouter from 'vue-router'
import App from './App.vue'
import Rote from './Rote.vue'

Vue.use(VueRouter)

new Vue({
  el: '#app',
  render: h => h(App)
})

const routes = {
  '/': App,
  '/rote': Rote
}