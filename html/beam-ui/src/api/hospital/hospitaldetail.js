import http from '@/util/http'

export default {
    getData: params => {
        return http.get("/hospital/detail/page/list", params)
    },
    export: (params) => {
        return http.downloadFile("/hospital/detail/export", params)
    },
    hospitalArea: params => {
        return http.get("/hospital/area/hospitalArea", params)
    },
    batchDelete: ids =>{
        return http.post("/hospital/detail/del", ids)
    },
    add: params => {
        return http.post("/hospital/detail/add", params)
    },
}
