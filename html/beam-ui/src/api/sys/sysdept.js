import http from '@/util/http'

export default {
    getTreeData: params => {
        return http.get("/sys/dept/tree/dept", params);
    },
    // 新增
    add: params => {
        return http.post("/sys/dept/add", params)
    },
    // 编辑
    edit: params => {
        return http.get("/sys/dept/edit", params)
    },
    // 批量删除
    batchDelete: ids => {
        return http.post("/sys/dept/del", ids)
    },
}
