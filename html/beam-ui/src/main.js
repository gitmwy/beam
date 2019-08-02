import Vue from 'vue';
import App from './App';
import router from './router';
import axios from 'axios';
import cookie from 'vue-cookie';
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
import '../static/css/icon/el-icon-lx/lx-iconfont.css';
import '../static/css/icon/el-icon-my/iconfont.css';
import "babel-polyfill";
// import '../static/css/theme/pink/index.css';
// import '../static/css/theme/green/index.css';

Vue.use(ElementUI, {size: 'small'});
Vue.use(cookie);
Vue.prototype.$axios = axios;
Vue.prototype.getPerms = function () {
    let buttonItems = cookie.get("buttonItems");
    if (buttonItems) {
        return buttonItems;
    } else {
        return [];
    }
};

//使用钩子函数对路由进行权限跳转
router.beforeEach((to, from, next) => {
    let sysuser = cookie.get("sysuser");
    let buttonItems = cookie.get("buttonItems");
    if(!sysuser && to.path !== '/login'){
        next('/login');
    }else if (to.meta.permission && buttonItems) {
        buttonItems.indexOf(to.meta.perms) !== -1 ? next() : next('/403');
    } else {
        // 简单的判断IE10及以下不进入富文本编辑器，该组件不兼容
        if (navigator.userAgent.indexOf('MSIE') > -1 && to.path === '/editor') {
            Vue.prototype.$alert('vue-quill-editor组件不兼容IE10及以下浏览器，请使用更高版本的浏览器查看', '浏览器不兼容通知', {
                confirmButtonText: '确定'
            });
        } else {
            next();
        }
    }
});

new Vue({
    router,
    render: h => h(App)
}).$mount('#app');
