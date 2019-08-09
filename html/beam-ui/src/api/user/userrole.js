import http from '@/util/http'

export default {
    getData: params => {
        return http.get("/user/role/page/list", params)
    },
    add: params => {
        return http.post("/user/role/add", params)
    },
    batchDelete: ids =>{
        return http.post("/user/role/del", ids)
    },
    getRoleLevel: params =>{
        return http.get("/user/config/role/level", params)
    }
}
