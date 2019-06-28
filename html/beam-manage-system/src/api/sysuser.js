import http from '@/util/http'

export default {
    // 登录
    getData: params => {
        return http.get("/sys/user/page/list", params);
    },
    // 新增
    add: params => {
        return http.post("/sys/user/add", params)
    },
    // 删除
    batchDelete: ids => {
        return http.post("/sys/user/del", ids)
    },
    // 批量更改状态
    changeStatus: (userId, flag) => {
        return http.post("/sys/user/change/status/" + flag, userId)
    },
    resetPassword: ids => {
        return http.post("/sys/user/reset/password", ids)
    },
    getRoleList: params => {
        return http.get("/sys/role/list", params);
    },
    //编辑
    edit: params => {
        return http.get("/sys/user/edit", params);
    }
}
