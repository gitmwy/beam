import Vue from 'vue';
import Router from 'vue-router';

Vue.use(Router);

export default new Router({
    mode: 'history',
    routes: [
        {
            path: '/',
            redirect: '/dashboard',
        },
        {
            path: '/',
            component: resolve => require(['../components/page/Home.vue'], resolve),
            meta: {title: '系统管理', requireAuth: true},
            children: [
                {
                    path: '/dashboard',
                    component: resolve => require(['../components/page/Dashboard.vue'], resolve),
                    meta: {title: '系统首页', permission: false, perms: "sys:dashboard:info"},
                },
                {
                    path: '/permission',
                    component: resolve => require(['../components/common/Permission.vue'], resolve),
                    meta: {title: '权限测试', permission: true}
                },
                {
                    path: '/404',
                    component: resolve => require(['../components/common/404.vue'], resolve),
                    meta: {title: '404'}
                },
                {
                    path: '/403',
                    component: resolve => require(['../components/common/403.vue'], resolve),
                    meta: {title: '403'}
                },
//系统管理=============================================================================
                {
                    path: '/sysuser',
                    component: resolve => require(['../components/sys/sysuser.vue'], resolve),
                    meta: {title: '用户管理', permission: true, perms: "sys:user:list"}
                },
                {
                    path: '/sysrole',
                    component: resolve => require(['../components/sys/sysrole.vue'], resolve),
                    meta: {title: '角色管理', permission: true, perms: "sys:role:list"}
                },
                {
                    path: '/sysmenu',
                    component: resolve => require(['../components/sys/sysmenu.vue'], resolve),
                    meta: {title: '菜单管理', permission: true, perms: "sys:menu:list"}
                },
                {
                    path: '/sysdept',
                    component: resolve => require(['../components/sys/sysdept.vue'], resolve),
                    meta: {title: '企业管理', permission: true, perms: "sys:dept:list"}
                },
                {
                    path: '/sysschedule',
                    component: resolve => require(['../components/sys/sysschedule.vue'], resolve),
                    meta: {title: '定时任务管理', permission: true, perms: "sys:schedule:list"}
                },
                {
                    path: '/sysdict',
                    component: resolve => require(['../components/sys/sysdict.vue'], resolve),
                    meta: {title: '字典管理', permission: true, perms: "sys:dict:list"}
                },
                {
                    path: '/sysloginlog',
                    component: resolve => require(['../components/sys/sysloginlog.vue'], resolve),
                    meta: {title: '登陆日志', permission: true, perms: "sys:loginLog:list"}
                },
                {
                    path: '/sysoperationlog',
                    component: resolve => require(['../components/sys/sysoperationlog.vue'], resolve),
                    meta: {title: '操作日志', permission: true, perms: "sys:operationLog:list"}
                },
//会议管理=============================================================================
                {
                    path: '/meetingdetail',
                    component: resolve => require(['../components/meeting/meetingdetail.vue'], resolve),
                    meta: { title: '会议列表',permission: true, perms: "meeting:detail:list"}
                },
                {
                    path: '/meetingcourse',
                    component: resolve => require(['../components/meeting/meetingcourse.vue'], resolve),
                    meta: { title: '会议课件',permission: true, perms: "meeting:course:list"}
                },
                {
                    path: '/meetingquestion',
                    component: resolve => require(['../components/meeting/meetingquestion.vue'], resolve),
                    meta: { title: '会议问卷',permission: true, perms: "meeting:question:list"}
                },
//用户管理=============================================================================
                {
                    path: '/userdetail',
                    component: resolve => require(['../components/user/userdetail.vue'], resolve),
                    meta: { title: '用户列表',permission: true, perms: "user:detail:list"}
                },
                {
                    path: '/userarea',
                    component: resolve => require(['../components/user/userarea.vue'], resolve),
                    meta: { title: '区域管理',permission: true, perms: "user:area:list"}
                },
                {
                    path: '/userrole',
                    component: resolve => require(['../components/user/userrole.vue'], resolve),
                    meta: { title: '角色管理',permission: true, perms: "user:role:list"}
                },
//医生管理=============================================================================
                {
                    path: '/hospitaldetail',
                    component: resolve => require(['../components/hospital/hospitaldetail.vue'], resolve),
                    meta: { title: '医院列表',permission: true, perms: "hospital:detail:list"}
                },
                {
                    path: '/hospitaldoctor',
                    component: resolve => require(['../components/hospital/hospitaldoctor.vue'], resolve),
                    meta: { title: '医生列表',permission: true, perms: "hospital:doctor:list"}
                },
                {
                    path: '/hospitalarea',
                    component: resolve => require(['../components/hospital/hospitalarea.vue'], resolve),
                    meta: { title: '区域管理',permission: true, perms: "hospital:area:list"}
                }
            ]
        },
        {
            path: '/login',
            component: resolve => require(['../components/page/Login.vue'], resolve)
        },
        {
            path: '*',
            redirect: '/404'
        }
    ]
})
