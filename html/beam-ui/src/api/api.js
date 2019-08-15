/*
 * 接口统一集成模块
 */
import AccountApi from './page/account'
import DashboardApi from './page/dashboard'
import LoginApi from './page/login'
//======================系统管理===============
import SysDeptApi from './sys/sysdept'
import SysDictApi from './sys/sysdict'
import SysLoginLogApi from './sys/sysloginlog'
import SysMenuApi from './sys/sysmenu'
import SysOperationLogApi from './sys/sysoperationlog'
import SysRoleApi from './sys/sysrole'
import SysScheduleApi from './sys/sysschedule'
import SysUserApi from './sys/sysuser'
//======================会议管理===============
import MeetingCourseApi from './meeting/meetingcourse'
import MeetingDetailApi from './meeting/meetingdetail'
import MeetingInfoApi from './meeting/meetinginfo'
import MeetingPlaceApi from './meeting/meetingplace'
import MeetingQuestionApi from './meeting/meetingquestion'
//======================用户管理===============
import UserRoleApi from './user/userrole'
import UserDetailApi from './user/userdetail'
import UserAreaApi from './user/userarea'

// 默认全部导出
export default {
    AccountApi,
    DashboardApi,
    LoginApi,
    SysDeptApi,
    SysDictApi,
    SysLoginLogApi,
    SysMenuApi,
    SysOperationLogApi,
    SysRoleApi,
    SysScheduleApi,
    SysUserApi,
    MeetingCourseApi,
    MeetingDetailApi,
    MeetingInfoApi,
    MeetingPlaceApi,
    MeetingQuestionApi,
    UserRoleApi,
    UserDetailApi,
    UserAreaApi,
}
