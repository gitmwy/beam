import http from '@/util/http'

export default {
    getAreaLevel: params =>{
        return http.get("/user/config/area/level", params)
    },
    getRoleLevel: params =>{
        return http.get("/user/config/role/level", params)
    }
}
