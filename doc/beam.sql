/*
 Navicat Premium Data Transfer

 Source Server         : root
 Source Server Type    : MySQL
 Source Server Version : 80016
 Source Host           : localhost:3306
 Source Schema         : beam

 Target Server Type    : MySQL
 Target Server Version : 80016
 File Encoding         : 65001

 Date: 22/11/2019 14:16:17
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for hospital_area
-- ----------------------------
DROP TABLE IF EXISTS `hospital_area`;
CREATE TABLE `hospital_area`  (
  `id` bigint(32) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(32) NULL DEFAULT NULL COMMENT '父ID',
  `area_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '区域名称',
  `level` int(4) NULL DEFAULT NULL COMMENT '级别',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `level_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '级别名称',
  `option_areas` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '关联区域',
  `option_status` int(4) NULL DEFAULT NULL COMMENT '关联区域标识（0：该区域的最顶级无关联，属于游离，1：有关联，在使用）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 61 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hospital_area
-- ----------------------------
INSERT INTO `hospital_area` VALUES (38, 0, '美国', 1, '2019-08-14 09:44:48', '2019-08-14 09:44:48', '一级', NULL, 1);
INSERT INTO `hospital_area` VALUES (41, NULL, '大兴区', 3, '2019-08-16 09:01:30', '2019-08-16 18:17:20', '三级', '无关联区域', 0);
INSERT INTO `hospital_area` VALUES (42, 38, '华盛顿', 2, '2019-08-16 10:25:46', '2019-08-16 10:25:46', '二级', '美国', 1);
INSERT INTO `hospital_area` VALUES (45, 41, '兴涛社区', 4, '2019-08-16 15:03:54', '2019-08-16 18:17:20', '四级', '大兴区', 0);
INSERT INTO `hospital_area` VALUES (59, 0, '全国', 1, '2019-08-16 18:33:24', '2019-08-16 18:33:24', '一级', NULL, 1);
INSERT INTO `hospital_area` VALUES (60, 59, '北京', 2, '2019-08-21 17:44:28', '2019-08-21 17:44:28', '二级', '全国', 1);
INSERT INTO `hospital_area` VALUES (61, 60, '朝阳区', 3, '2019-08-21 17:44:46', '2019-08-21 17:44:46', '三级', '全国/北京', 1);

-- ----------------------------
-- Table structure for hospital_detail
-- ----------------------------
DROP TABLE IF EXISTS `hospital_detail`;
CREATE TABLE `hospital_detail`  (
  `id` bigint(32) NOT NULL AUTO_INCREMENT,
  `code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '医院编号',
  `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '医院名称',
  `province_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '所在省',
  `city_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '所在市',
  `managers_id` bigint(32) NOT NULL COMMENT '负责人',
  `county_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '所在区/县',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `province_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '所在省行政编号',
  `city_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '所在市行政编号',
  `county_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '所在区/县行政编号',
  `address` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '所在地址',
  `level` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '医院级别',
  `area_id` bigint(32) NULL DEFAULT NULL COMMENT '区域ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hospital_detail
-- ----------------------------
INSERT INTO `hospital_detail` VALUES (1, 'H201910290001', '协和', '北京', '市辖区', 1, NULL, '2019-09-25 10:47:08', '2019-09-25 10:47:11', '110000', '110100', NULL, '北京市辖区', '三甲', 59);
INSERT INTO `hospital_detail` VALUES (2, 'H201910290002', '华佗在世', '北京', '市辖区', 2, NULL, '2019-10-29 10:33:12', '2019-10-29 10:33:15', '110000', '110100', NULL, '北京市辖区', '二甲', 59);

-- ----------------------------
-- Table structure for hospital_doctor
-- ----------------------------
DROP TABLE IF EXISTS `hospital_doctor`;
CREATE TABLE `hospital_doctor`  (
  `id` bigint(32) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '医生姓名',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '手机号',
  `hospital_id` bigint(32) NULL DEFAULT NULL COMMENT '医院ID',
  `department` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '科室',
  `position` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '职位',
  `title` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '职称',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建日期',
  `flag` int(4) NULL DEFAULT 1 COMMENT '讲者标志（1：是，0：否）',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `sex` int(2) NULL DEFAULT NULL COMMENT '性别（1：男 2：女）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hospital_doctor
-- ----------------------------
INSERT INTO `hospital_doctor` VALUES (1, '李时珍', '13412341234', 2, '妇产科', '科长', '主治', '2019-09-25 10:48:15', 1, '2019-09-25 10:48:21', 1);
INSERT INTO `hospital_doctor` VALUES (2, '华佗', '13412341234', 1, '脑科', '科长', '主治', '2019-09-25 10:48:15', 1, '2019-09-25 10:48:21', 1);
INSERT INTO `hospital_doctor` VALUES (3, '扁鹊', '13412341234', 1, '牙科', '副科长', '主治', '2019-11-22 09:33:35', 1, '2019-11-22 09:33:35', 1);

-- ----------------------------
-- Table structure for m_area
-- ----------------------------
DROP TABLE IF EXISTS `m_area`;
CREATE TABLE `m_area`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `rid` int(11) NOT NULL DEFAULT 0 COMMENT '上级id',
  `areaid` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '区号',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `class` int(1) NULL DEFAULT NULL COMMENT '1省2市3县',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3523 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of m_area
-- ----------------------------
INSERT INTO `m_area` VALUES (1, 0, '110000', '北京市', 1);
INSERT INTO `m_area` VALUES (2, 1, '110100', '市辖区', 2);
INSERT INTO `m_area` VALUES (3, 2, '110101', '东城区', 3);
INSERT INTO `m_area` VALUES (4, 2, '110102', '西城区', 3);
INSERT INTO `m_area` VALUES (5, 2, '110103', '崇文区', 3);
INSERT INTO `m_area` VALUES (6, 2, '110104', '宣武区', 3);
INSERT INTO `m_area` VALUES (7, 2, '110105', '朝阳区', 3);
INSERT INTO `m_area` VALUES (8, 2, '110106', '丰台区', 3);
INSERT INTO `m_area` VALUES (9, 2, '110107', '石景山区', 3);
INSERT INTO `m_area` VALUES (10, 2, '110108', '海淀区', 3);
INSERT INTO `m_area` VALUES (11, 2, '110109', '门头沟区', 3);
INSERT INTO `m_area` VALUES (12, 2, '110111', '房山区', 3);
INSERT INTO `m_area` VALUES (13, 2, '110112', '通州区', 3);
INSERT INTO `m_area` VALUES (14, 2, '110113', '顺义区', 3);
INSERT INTO `m_area` VALUES (15, 2, '110114', '昌平区', 3);
INSERT INTO `m_area` VALUES (16, 2, '110115', '大兴区', 3);
INSERT INTO `m_area` VALUES (17, 2, '110116', '怀柔区', 3);
INSERT INTO `m_area` VALUES (18, 2, '110117', '平谷区', 3);
INSERT INTO `m_area` VALUES (19, 1, '110200', '县', 2);
INSERT INTO `m_area` VALUES (20, 19, '110228', '密云县', 3);
INSERT INTO `m_area` VALUES (21, 19, '110229', '延庆县', 3);
INSERT INTO `m_area` VALUES (22, 0, '120000', '天津市', 1);
INSERT INTO `m_area` VALUES (23, 22, '120100', '市辖区', 2);
INSERT INTO `m_area` VALUES (24, 23, '120101', '和平区', 3);
INSERT INTO `m_area` VALUES (25, 23, '120102', '河东区', 3);
INSERT INTO `m_area` VALUES (26, 23, '120103', '河西区', 3);
INSERT INTO `m_area` VALUES (27, 23, '120104', '南开区', 3);
INSERT INTO `m_area` VALUES (28, 23, '120105', '河北区', 3);
INSERT INTO `m_area` VALUES (29, 23, '120106', '红桥区', 3);
INSERT INTO `m_area` VALUES (30, 23, '120107', '塘沽区', 3);
INSERT INTO `m_area` VALUES (31, 23, '120108', '汉沽区', 3);
INSERT INTO `m_area` VALUES (32, 23, '120109', '大港区', 3);
INSERT INTO `m_area` VALUES (33, 23, '120110', '东丽区', 3);
INSERT INTO `m_area` VALUES (34, 23, '120111', '西青区', 3);
INSERT INTO `m_area` VALUES (35, 23, '120112', '津南区', 3);
INSERT INTO `m_area` VALUES (36, 23, '120113', '北辰区', 3);
INSERT INTO `m_area` VALUES (37, 23, '120114', '武清区', 3);
INSERT INTO `m_area` VALUES (38, 23, '120115', '宝坻区', 3);
INSERT INTO `m_area` VALUES (39, 22, '120200', '县', 2);
INSERT INTO `m_area` VALUES (40, 39, '120221', '宁河县', 3);
INSERT INTO `m_area` VALUES (41, 39, '120223', '静海县', 3);
INSERT INTO `m_area` VALUES (42, 39, '120225', '蓟　县', 3);
INSERT INTO `m_area` VALUES (43, 0, '130000', '河北省', 1);
INSERT INTO `m_area` VALUES (44, 43, '130100', '石家庄市', 2);
INSERT INTO `m_area` VALUES (45, 44, '130101', '市辖区', 3);
INSERT INTO `m_area` VALUES (46, 44, '130102', '长安区', 3);
INSERT INTO `m_area` VALUES (47, 44, '130103', '桥东区', 3);
INSERT INTO `m_area` VALUES (48, 44, '130104', '桥西区', 3);
INSERT INTO `m_area` VALUES (49, 44, '130105', '新华区', 3);
INSERT INTO `m_area` VALUES (50, 44, '130107', '井陉矿区', 3);
INSERT INTO `m_area` VALUES (51, 44, '130108', '裕华区', 3);
INSERT INTO `m_area` VALUES (52, 44, '130121', '井陉县', 3);
INSERT INTO `m_area` VALUES (53, 44, '130123', '正定县', 3);
INSERT INTO `m_area` VALUES (54, 44, '130124', '栾城县', 3);
INSERT INTO `m_area` VALUES (55, 44, '130125', '行唐县', 3);
INSERT INTO `m_area` VALUES (56, 44, '130126', '灵寿县', 3);
INSERT INTO `m_area` VALUES (57, 44, '130127', '高邑县', 3);
INSERT INTO `m_area` VALUES (58, 44, '130128', '深泽县', 3);
INSERT INTO `m_area` VALUES (59, 44, '130129', '赞皇县', 3);
INSERT INTO `m_area` VALUES (60, 44, '130130', '无极县', 3);
INSERT INTO `m_area` VALUES (61, 44, '130131', '平山县', 3);
INSERT INTO `m_area` VALUES (62, 44, '130132', '元氏县', 3);
INSERT INTO `m_area` VALUES (63, 44, '130133', '赵　县', 3);
INSERT INTO `m_area` VALUES (64, 44, '130181', '辛集市', 3);
INSERT INTO `m_area` VALUES (65, 44, '130182', '藁城市', 3);
INSERT INTO `m_area` VALUES (66, 44, '130183', '晋州市', 3);
INSERT INTO `m_area` VALUES (67, 44, '130184', '新乐市', 3);
INSERT INTO `m_area` VALUES (68, 44, '130185', '鹿泉市', 3);
INSERT INTO `m_area` VALUES (69, 43, '130200', '唐山市', 2);
INSERT INTO `m_area` VALUES (70, 69, '130201', '市辖区', 3);
INSERT INTO `m_area` VALUES (71, 69, '130202', '路南区', 3);
INSERT INTO `m_area` VALUES (72, 69, '130203', '路北区', 3);
INSERT INTO `m_area` VALUES (73, 69, '130204', '古冶区', 3);
INSERT INTO `m_area` VALUES (74, 69, '130205', '开平区', 3);
INSERT INTO `m_area` VALUES (75, 69, '130207', '丰南区', 3);
INSERT INTO `m_area` VALUES (76, 69, '130208', '丰润区', 3);
INSERT INTO `m_area` VALUES (77, 69, '130223', '滦　县', 3);
INSERT INTO `m_area` VALUES (78, 69, '130224', '滦南县', 3);
INSERT INTO `m_area` VALUES (79, 69, '130225', '乐亭县', 3);
INSERT INTO `m_area` VALUES (80, 69, '130227', '迁西县', 3);
INSERT INTO `m_area` VALUES (81, 69, '130229', '玉田县', 3);
INSERT INTO `m_area` VALUES (82, 69, '130230', '唐海县', 3);
INSERT INTO `m_area` VALUES (83, 69, '130281', '遵化市', 3);
INSERT INTO `m_area` VALUES (84, 69, '130283', '迁安市', 3);
INSERT INTO `m_area` VALUES (85, 43, '130300', '秦皇岛市', 2);
INSERT INTO `m_area` VALUES (86, 85, '130301', '市辖区', 3);
INSERT INTO `m_area` VALUES (87, 85, '130302', '海港区', 3);
INSERT INTO `m_area` VALUES (88, 85, '130303', '山海关区', 3);
INSERT INTO `m_area` VALUES (89, 85, '130304', '北戴河区', 3);
INSERT INTO `m_area` VALUES (90, 85, '130321', '青龙满族自治县', 3);
INSERT INTO `m_area` VALUES (91, 85, '130322', '昌黎县', 3);
INSERT INTO `m_area` VALUES (92, 85, '130323', '抚宁县', 3);
INSERT INTO `m_area` VALUES (93, 85, '130324', '卢龙县', 3);
INSERT INTO `m_area` VALUES (94, 43, '130400', '邯郸市', 2);
INSERT INTO `m_area` VALUES (95, 94, '130401', '市辖区', 3);
INSERT INTO `m_area` VALUES (96, 94, '130402', '邯山区', 3);
INSERT INTO `m_area` VALUES (97, 94, '130403', '丛台区', 3);
INSERT INTO `m_area` VALUES (98, 94, '130404', '复兴区', 3);
INSERT INTO `m_area` VALUES (99, 94, '130406', '峰峰矿区', 3);
INSERT INTO `m_area` VALUES (100, 94, '130421', '邯郸县', 3);
INSERT INTO `m_area` VALUES (101, 94, '130423', '临漳县', 3);
INSERT INTO `m_area` VALUES (102, 94, '130424', '成安县', 3);
INSERT INTO `m_area` VALUES (103, 94, '130425', '大名县', 3);
INSERT INTO `m_area` VALUES (104, 94, '130426', '涉　县', 3);
INSERT INTO `m_area` VALUES (105, 94, '130427', '磁　县', 3);
INSERT INTO `m_area` VALUES (106, 94, '130428', '肥乡县', 3);
INSERT INTO `m_area` VALUES (107, 94, '130429', '永年县', 3);
INSERT INTO `m_area` VALUES (108, 94, '130430', '邱　县', 3);
INSERT INTO `m_area` VALUES (109, 94, '130431', '鸡泽县', 3);
INSERT INTO `m_area` VALUES (110, 94, '130432', '广平县', 3);
INSERT INTO `m_area` VALUES (111, 94, '130433', '馆陶县', 3);
INSERT INTO `m_area` VALUES (112, 94, '130434', '魏　县', 3);
INSERT INTO `m_area` VALUES (113, 94, '130435', '曲周县', 3);
INSERT INTO `m_area` VALUES (114, 94, '130481', '武安市', 3);
INSERT INTO `m_area` VALUES (115, 43, '130500', '邢台市', 2);
INSERT INTO `m_area` VALUES (116, 115, '130501', '市辖区', 3);
INSERT INTO `m_area` VALUES (117, 115, '130502', '桥东区', 3);
INSERT INTO `m_area` VALUES (118, 115, '130503', '桥西区', 3);
INSERT INTO `m_area` VALUES (119, 115, '130521', '邢台县', 3);
INSERT INTO `m_area` VALUES (120, 115, '130522', '临城县', 3);
INSERT INTO `m_area` VALUES (121, 115, '130523', '内丘县', 3);
INSERT INTO `m_area` VALUES (122, 115, '130524', '柏乡县', 3);
INSERT INTO `m_area` VALUES (123, 115, '130525', '隆尧县', 3);
INSERT INTO `m_area` VALUES (124, 115, '130526', '任　县', 3);
INSERT INTO `m_area` VALUES (125, 115, '130527', '南和县', 3);
INSERT INTO `m_area` VALUES (126, 115, '130528', '宁晋县', 3);
INSERT INTO `m_area` VALUES (127, 115, '130529', '巨鹿县', 3);
INSERT INTO `m_area` VALUES (128, 115, '130530', '新河县', 3);
INSERT INTO `m_area` VALUES (129, 115, '130531', '广宗县', 3);
INSERT INTO `m_area` VALUES (130, 115, '130532', '平乡县', 3);
INSERT INTO `m_area` VALUES (131, 115, '130533', '威　县', 3);
INSERT INTO `m_area` VALUES (132, 115, '130534', '清河县', 3);
INSERT INTO `m_area` VALUES (133, 115, '130535', '临西县', 3);
INSERT INTO `m_area` VALUES (134, 115, '130581', '南宫市', 3);
INSERT INTO `m_area` VALUES (135, 115, '130582', '沙河市', 3);
INSERT INTO `m_area` VALUES (136, 43, '130600', '保定市', 2);
INSERT INTO `m_area` VALUES (137, 136, '130601', '市辖区', 3);
INSERT INTO `m_area` VALUES (138, 136, '130602', '新市区', 3);
INSERT INTO `m_area` VALUES (139, 136, '130603', '北市区', 3);
INSERT INTO `m_area` VALUES (140, 136, '130604', '南市区', 3);
INSERT INTO `m_area` VALUES (141, 136, '130621', '满城县', 3);
INSERT INTO `m_area` VALUES (142, 136, '130622', '清苑县', 3);
INSERT INTO `m_area` VALUES (143, 136, '130623', '涞水县', 3);
INSERT INTO `m_area` VALUES (144, 136, '130624', '阜平县', 3);
INSERT INTO `m_area` VALUES (145, 136, '130625', '徐水县', 3);
INSERT INTO `m_area` VALUES (146, 136, '130626', '定兴县', 3);
INSERT INTO `m_area` VALUES (147, 136, '130627', '唐　县', 3);
INSERT INTO `m_area` VALUES (148, 136, '130628', '高阳县', 3);
INSERT INTO `m_area` VALUES (149, 136, '130629', '容城县', 3);
INSERT INTO `m_area` VALUES (150, 136, '130630', '涞源县', 3);
INSERT INTO `m_area` VALUES (151, 136, '130631', '望都县', 3);
INSERT INTO `m_area` VALUES (152, 136, '130632', '安新县', 3);
INSERT INTO `m_area` VALUES (153, 136, '130633', '易　县', 3);
INSERT INTO `m_area` VALUES (154, 136, '130634', '曲阳县', 3);
INSERT INTO `m_area` VALUES (155, 136, '130635', '蠡　县', 3);
INSERT INTO `m_area` VALUES (156, 136, '130636', '顺平县', 3);
INSERT INTO `m_area` VALUES (157, 136, '130637', '博野县', 3);
INSERT INTO `m_area` VALUES (158, 136, '130638', '雄　县', 3);
INSERT INTO `m_area` VALUES (159, 136, '130681', '涿州市', 3);
INSERT INTO `m_area` VALUES (160, 136, '130682', '定州市', 3);
INSERT INTO `m_area` VALUES (161, 136, '130683', '安国市', 3);
INSERT INTO `m_area` VALUES (162, 136, '130684', '高碑店市', 3);
INSERT INTO `m_area` VALUES (163, 43, '130700', '张家口市', 2);
INSERT INTO `m_area` VALUES (164, 163, '130701', '市辖区', 3);
INSERT INTO `m_area` VALUES (165, 163, '130702', '桥东区', 3);
INSERT INTO `m_area` VALUES (166, 163, '130703', '桥西区', 3);
INSERT INTO `m_area` VALUES (167, 163, '130705', '宣化区', 3);
INSERT INTO `m_area` VALUES (168, 163, '130706', '下花园区', 3);
INSERT INTO `m_area` VALUES (169, 163, '130721', '宣化县', 3);
INSERT INTO `m_area` VALUES (170, 163, '130722', '张北县', 3);
INSERT INTO `m_area` VALUES (171, 163, '130723', '康保县', 3);
INSERT INTO `m_area` VALUES (172, 163, '130724', '沽源县', 3);
INSERT INTO `m_area` VALUES (173, 163, '130725', '尚义县', 3);
INSERT INTO `m_area` VALUES (174, 163, '130726', '蔚　县', 3);
INSERT INTO `m_area` VALUES (175, 163, '130727', '阳原县', 3);
INSERT INTO `m_area` VALUES (176, 163, '130728', '怀安县', 3);
INSERT INTO `m_area` VALUES (177, 163, '130729', '万全县', 3);
INSERT INTO `m_area` VALUES (178, 163, '130730', '怀来县', 3);
INSERT INTO `m_area` VALUES (179, 163, '130731', '涿鹿县', 3);
INSERT INTO `m_area` VALUES (180, 163, '130732', '赤城县', 3);
INSERT INTO `m_area` VALUES (181, 163, '130733', '崇礼县', 3);
INSERT INTO `m_area` VALUES (182, 43, '130800', '承德市', 2);
INSERT INTO `m_area` VALUES (183, 182, '130801', '市辖区', 3);
INSERT INTO `m_area` VALUES (184, 182, '130802', '双桥区', 3);
INSERT INTO `m_area` VALUES (185, 182, '130803', '双滦区', 3);
INSERT INTO `m_area` VALUES (186, 182, '130804', '鹰手营子矿区', 3);
INSERT INTO `m_area` VALUES (187, 182, '130821', '承德县', 3);
INSERT INTO `m_area` VALUES (188, 182, '130822', '兴隆县', 3);
INSERT INTO `m_area` VALUES (189, 182, '130823', '平泉县', 3);
INSERT INTO `m_area` VALUES (190, 182, '130824', '滦平县', 3);
INSERT INTO `m_area` VALUES (191, 182, '130825', '隆化县', 3);
INSERT INTO `m_area` VALUES (192, 182, '130826', '丰宁满族自治县', 3);
INSERT INTO `m_area` VALUES (193, 182, '130827', '宽城满族自治县', 3);
INSERT INTO `m_area` VALUES (194, 182, '130828', '围场满族蒙古族自治县', 3);
INSERT INTO `m_area` VALUES (195, 43, '130900', '沧州市', 2);
INSERT INTO `m_area` VALUES (196, 195, '130901', '市辖区', 3);
INSERT INTO `m_area` VALUES (197, 195, '130902', '新华区', 3);
INSERT INTO `m_area` VALUES (198, 195, '130903', '运河区', 3);
INSERT INTO `m_area` VALUES (199, 195, '130921', '沧　县', 3);
INSERT INTO `m_area` VALUES (200, 195, '130922', '青　县', 3);
INSERT INTO `m_area` VALUES (201, 195, '130923', '东光县', 3);
INSERT INTO `m_area` VALUES (202, 195, '130924', '海兴县', 3);
INSERT INTO `m_area` VALUES (203, 195, '130925', '盐山县', 3);
INSERT INTO `m_area` VALUES (204, 195, '130926', '肃宁县', 3);
INSERT INTO `m_area` VALUES (205, 195, '130927', '南皮县', 3);
INSERT INTO `m_area` VALUES (206, 195, '130928', '吴桥县', 3);
INSERT INTO `m_area` VALUES (207, 195, '130929', '献　县', 3);
INSERT INTO `m_area` VALUES (208, 195, '130930', '孟村回族自治县', 3);
INSERT INTO `m_area` VALUES (209, 195, '130981', '泊头市', 3);
INSERT INTO `m_area` VALUES (210, 195, '130982', '任丘市', 3);
INSERT INTO `m_area` VALUES (211, 195, '130983', '黄骅市', 3);
INSERT INTO `m_area` VALUES (212, 195, '130984', '河间市', 3);
INSERT INTO `m_area` VALUES (213, 43, '131000', '廊坊市', 2);
INSERT INTO `m_area` VALUES (214, 213, '131001', '市辖区', 3);
INSERT INTO `m_area` VALUES (215, 213, '131002', '安次区', 3);
INSERT INTO `m_area` VALUES (216, 213, '131003', '广阳区', 3);
INSERT INTO `m_area` VALUES (217, 213, '131022', '固安县', 3);
INSERT INTO `m_area` VALUES (218, 213, '131023', '永清县', 3);
INSERT INTO `m_area` VALUES (219, 213, '131024', '香河县', 3);
INSERT INTO `m_area` VALUES (220, 213, '131025', '大城县', 3);
INSERT INTO `m_area` VALUES (221, 213, '131026', '文安县', 3);
INSERT INTO `m_area` VALUES (222, 213, '131028', '大厂回族自治县', 3);
INSERT INTO `m_area` VALUES (223, 213, '131081', '霸州市', 3);
INSERT INTO `m_area` VALUES (224, 213, '131082', '三河市', 3);
INSERT INTO `m_area` VALUES (225, 43, '131100', '衡水市', 2);
INSERT INTO `m_area` VALUES (226, 225, '131101', '市辖区', 3);
INSERT INTO `m_area` VALUES (227, 225, '131102', '桃城区', 3);
INSERT INTO `m_area` VALUES (228, 225, '131121', '枣强县', 3);
INSERT INTO `m_area` VALUES (229, 225, '131122', '武邑县', 3);
INSERT INTO `m_area` VALUES (230, 225, '131123', '武强县', 3);
INSERT INTO `m_area` VALUES (231, 225, '131124', '饶阳县', 3);
INSERT INTO `m_area` VALUES (232, 225, '131125', '安平县', 3);
INSERT INTO `m_area` VALUES (233, 225, '131126', '故城县', 3);
INSERT INTO `m_area` VALUES (234, 225, '131127', '景　县', 3);
INSERT INTO `m_area` VALUES (235, 225, '131128', '阜城县', 3);
INSERT INTO `m_area` VALUES (236, 225, '131181', '冀州市', 3);
INSERT INTO `m_area` VALUES (237, 225, '131182', '深州市', 3);
INSERT INTO `m_area` VALUES (238, 0, '140000', '山西省', 1);
INSERT INTO `m_area` VALUES (239, 238, '140100', '太原市', 2);
INSERT INTO `m_area` VALUES (240, 239, '140101', '市辖区', 3);
INSERT INTO `m_area` VALUES (241, 239, '140105', '小店区', 3);
INSERT INTO `m_area` VALUES (242, 239, '140106', '迎泽区', 3);
INSERT INTO `m_area` VALUES (243, 239, '140107', '杏花岭区', 3);
INSERT INTO `m_area` VALUES (244, 239, '140108', '尖草坪区', 3);
INSERT INTO `m_area` VALUES (245, 239, '140109', '万柏林区', 3);
INSERT INTO `m_area` VALUES (246, 239, '140110', '晋源区', 3);
INSERT INTO `m_area` VALUES (247, 239, '140121', '清徐县', 3);
INSERT INTO `m_area` VALUES (248, 239, '140122', '阳曲县', 3);
INSERT INTO `m_area` VALUES (249, 239, '140123', '娄烦县', 3);
INSERT INTO `m_area` VALUES (250, 239, '140181', '古交市', 3);
INSERT INTO `m_area` VALUES (251, 238, '140200', '大同市', 2);
INSERT INTO `m_area` VALUES (252, 251, '140201', '市辖区', 3);
INSERT INTO `m_area` VALUES (253, 251, '140202', '城　区', 3);
INSERT INTO `m_area` VALUES (254, 251, '140203', '矿　区', 3);
INSERT INTO `m_area` VALUES (255, 251, '140211', '南郊区', 3);
INSERT INTO `m_area` VALUES (256, 251, '140212', '新荣区', 3);
INSERT INTO `m_area` VALUES (257, 251, '140221', '阳高县', 3);
INSERT INTO `m_area` VALUES (258, 251, '140222', '天镇县', 3);
INSERT INTO `m_area` VALUES (259, 251, '140223', '广灵县', 3);
INSERT INTO `m_area` VALUES (260, 251, '140224', '灵丘县', 3);
INSERT INTO `m_area` VALUES (261, 251, '140225', '浑源县', 3);
INSERT INTO `m_area` VALUES (262, 251, '140226', '左云县', 3);
INSERT INTO `m_area` VALUES (263, 251, '140227', '大同县', 3);
INSERT INTO `m_area` VALUES (264, 238, '140300', '阳泉市', 2);
INSERT INTO `m_area` VALUES (265, 264, '140301', '市辖区', 3);
INSERT INTO `m_area` VALUES (266, 264, '140302', '城　区', 3);
INSERT INTO `m_area` VALUES (267, 264, '140303', '矿　区', 3);
INSERT INTO `m_area` VALUES (268, 264, '140311', '郊　区', 3);
INSERT INTO `m_area` VALUES (269, 264, '140321', '平定县', 3);
INSERT INTO `m_area` VALUES (270, 264, '140322', '盂　县', 3);
INSERT INTO `m_area` VALUES (271, 238, '140400', '长治市', 2);
INSERT INTO `m_area` VALUES (272, 271, '140401', '市辖区', 3);
INSERT INTO `m_area` VALUES (273, 271, '140402', '城　区', 3);
INSERT INTO `m_area` VALUES (274, 271, '140411', '郊　区', 3);
INSERT INTO `m_area` VALUES (275, 271, '140421', '长治县', 3);
INSERT INTO `m_area` VALUES (276, 271, '140423', '襄垣县', 3);
INSERT INTO `m_area` VALUES (277, 271, '140424', '屯留县', 3);
INSERT INTO `m_area` VALUES (278, 271, '140425', '平顺县', 3);
INSERT INTO `m_area` VALUES (279, 271, '140426', '黎城县', 3);
INSERT INTO `m_area` VALUES (280, 271, '140427', '壶关县', 3);
INSERT INTO `m_area` VALUES (281, 271, '140428', '长子县', 3);
INSERT INTO `m_area` VALUES (282, 271, '140429', '武乡县', 3);
INSERT INTO `m_area` VALUES (283, 271, '140430', '沁　县', 3);
INSERT INTO `m_area` VALUES (284, 271, '140431', '沁源县', 3);
INSERT INTO `m_area` VALUES (285, 271, '140481', '潞城市', 3);
INSERT INTO `m_area` VALUES (286, 238, '140500', '晋城市', 2);
INSERT INTO `m_area` VALUES (287, 286, '140501', '市辖区', 3);
INSERT INTO `m_area` VALUES (288, 286, '140502', '城　区', 3);
INSERT INTO `m_area` VALUES (289, 286, '140521', '沁水县', 3);
INSERT INTO `m_area` VALUES (290, 286, '140522', '阳城县', 3);
INSERT INTO `m_area` VALUES (291, 286, '140524', '陵川县', 3);
INSERT INTO `m_area` VALUES (292, 286, '140525', '泽州县', 3);
INSERT INTO `m_area` VALUES (293, 286, '140581', '高平市', 3);
INSERT INTO `m_area` VALUES (294, 238, '140600', '朔州市', 2);
INSERT INTO `m_area` VALUES (295, 294, '140601', '市辖区', 3);
INSERT INTO `m_area` VALUES (296, 294, '140602', '朔城区', 3);
INSERT INTO `m_area` VALUES (297, 294, '140603', '平鲁区', 3);
INSERT INTO `m_area` VALUES (298, 294, '140621', '山阴县', 3);
INSERT INTO `m_area` VALUES (299, 294, '140622', '应　县', 3);
INSERT INTO `m_area` VALUES (300, 294, '140623', '右玉县', 3);
INSERT INTO `m_area` VALUES (301, 294, '140624', '怀仁县', 3);
INSERT INTO `m_area` VALUES (302, 238, '140700', '晋中市', 2);
INSERT INTO `m_area` VALUES (303, 302, '140701', '市辖区', 3);
INSERT INTO `m_area` VALUES (304, 302, '140702', '榆次区', 3);
INSERT INTO `m_area` VALUES (305, 302, '140721', '榆社县', 3);
INSERT INTO `m_area` VALUES (306, 302, '140722', '左权县', 3);
INSERT INTO `m_area` VALUES (307, 302, '140723', '和顺县', 3);
INSERT INTO `m_area` VALUES (308, 302, '140724', '昔阳县', 3);
INSERT INTO `m_area` VALUES (309, 302, '140725', '寿阳县', 3);
INSERT INTO `m_area` VALUES (310, 302, '140726', '太谷县', 3);
INSERT INTO `m_area` VALUES (311, 302, '140727', '祁　县', 3);
INSERT INTO `m_area` VALUES (312, 302, '140728', '平遥县', 3);
INSERT INTO `m_area` VALUES (313, 302, '140729', '灵石县', 3);
INSERT INTO `m_area` VALUES (314, 302, '140781', '介休市', 3);
INSERT INTO `m_area` VALUES (315, 238, '140800', '运城市', 2);
INSERT INTO `m_area` VALUES (316, 315, '140801', '市辖区', 3);
INSERT INTO `m_area` VALUES (317, 315, '140802', '盐湖区', 3);
INSERT INTO `m_area` VALUES (318, 315, '140821', '临猗县', 3);
INSERT INTO `m_area` VALUES (319, 315, '140822', '万荣县', 3);
INSERT INTO `m_area` VALUES (320, 315, '140823', '闻喜县', 3);
INSERT INTO `m_area` VALUES (321, 315, '140824', '稷山县', 3);
INSERT INTO `m_area` VALUES (322, 315, '140825', '新绛县', 3);
INSERT INTO `m_area` VALUES (323, 315, '140826', '绛　县', 3);
INSERT INTO `m_area` VALUES (324, 315, '140827', '垣曲县', 3);
INSERT INTO `m_area` VALUES (325, 315, '140828', '夏　县', 3);
INSERT INTO `m_area` VALUES (326, 315, '140829', '平陆县', 3);
INSERT INTO `m_area` VALUES (327, 315, '140830', '芮城县', 3);
INSERT INTO `m_area` VALUES (328, 315, '140881', '永济市', 3);
INSERT INTO `m_area` VALUES (329, 315, '140882', '河津市', 3);
INSERT INTO `m_area` VALUES (330, 238, '140900', '忻州市', 2);
INSERT INTO `m_area` VALUES (331, 330, '140901', '市辖区', 3);
INSERT INTO `m_area` VALUES (332, 330, '140902', '忻府区', 3);
INSERT INTO `m_area` VALUES (333, 330, '140921', '定襄县', 3);
INSERT INTO `m_area` VALUES (334, 330, '140922', '五台县', 3);
INSERT INTO `m_area` VALUES (335, 330, '140923', '代　县', 3);
INSERT INTO `m_area` VALUES (336, 330, '140924', '繁峙县', 3);
INSERT INTO `m_area` VALUES (337, 330, '140925', '宁武县', 3);
INSERT INTO `m_area` VALUES (338, 330, '140926', '静乐县', 3);
INSERT INTO `m_area` VALUES (339, 330, '140927', '神池县', 3);
INSERT INTO `m_area` VALUES (340, 330, '140928', '五寨县', 3);
INSERT INTO `m_area` VALUES (341, 330, '140929', '岢岚县', 3);
INSERT INTO `m_area` VALUES (342, 330, '140930', '河曲县', 3);
INSERT INTO `m_area` VALUES (343, 330, '140931', '保德县', 3);
INSERT INTO `m_area` VALUES (344, 330, '140932', '偏关县', 3);
INSERT INTO `m_area` VALUES (345, 330, '140981', '原平市', 3);
INSERT INTO `m_area` VALUES (346, 238, '141000', '临汾市', 2);
INSERT INTO `m_area` VALUES (347, 346, '141001', '市辖区', 3);
INSERT INTO `m_area` VALUES (348, 346, '141002', '尧都区', 3);
INSERT INTO `m_area` VALUES (349, 346, '141021', '曲沃县', 3);
INSERT INTO `m_area` VALUES (350, 346, '141022', '翼城县', 3);
INSERT INTO `m_area` VALUES (351, 346, '141023', '襄汾县', 3);
INSERT INTO `m_area` VALUES (352, 346, '141024', '洪洞县', 3);
INSERT INTO `m_area` VALUES (353, 346, '141025', '古　县', 3);
INSERT INTO `m_area` VALUES (354, 346, '141026', '安泽县', 3);
INSERT INTO `m_area` VALUES (355, 346, '141027', '浮山县', 3);
INSERT INTO `m_area` VALUES (356, 346, '141028', '吉　县', 3);
INSERT INTO `m_area` VALUES (357, 346, '141029', '乡宁县', 3);
INSERT INTO `m_area` VALUES (358, 346, '141030', '大宁县', 3);
INSERT INTO `m_area` VALUES (359, 346, '141031', '隰　县', 3);
INSERT INTO `m_area` VALUES (360, 346, '141032', '永和县', 3);
INSERT INTO `m_area` VALUES (361, 346, '141033', '蒲　县', 3);
INSERT INTO `m_area` VALUES (362, 346, '141034', '汾西县', 3);
INSERT INTO `m_area` VALUES (363, 346, '141081', '侯马市', 3);
INSERT INTO `m_area` VALUES (364, 346, '141082', '霍州市', 3);
INSERT INTO `m_area` VALUES (365, 238, '141100', '吕梁市', 2);
INSERT INTO `m_area` VALUES (366, 365, '141101', '市辖区', 3);
INSERT INTO `m_area` VALUES (367, 365, '141102', '离石区', 3);
INSERT INTO `m_area` VALUES (368, 365, '141121', '文水县', 3);
INSERT INTO `m_area` VALUES (369, 365, '141122', '交城县', 3);
INSERT INTO `m_area` VALUES (370, 365, '141123', '兴　县', 3);
INSERT INTO `m_area` VALUES (371, 365, '141124', '临　县', 3);
INSERT INTO `m_area` VALUES (372, 365, '141125', '柳林县', 3);
INSERT INTO `m_area` VALUES (373, 365, '141126', '石楼县', 3);
INSERT INTO `m_area` VALUES (374, 365, '141127', '岚　县', 3);
INSERT INTO `m_area` VALUES (375, 365, '141128', '方山县', 3);
INSERT INTO `m_area` VALUES (376, 365, '141129', '中阳县', 3);
INSERT INTO `m_area` VALUES (377, 365, '141130', '交口县', 3);
INSERT INTO `m_area` VALUES (378, 365, '141181', '孝义市', 3);
INSERT INTO `m_area` VALUES (379, 365, '141182', '汾阳市', 3);
INSERT INTO `m_area` VALUES (380, 0, '150000', '内蒙古自治区', 1);
INSERT INTO `m_area` VALUES (381, 380, '150100', '呼和浩特市', 2);
INSERT INTO `m_area` VALUES (382, 381, '150101', '市辖区', 3);
INSERT INTO `m_area` VALUES (383, 381, '150102', '新城区', 3);
INSERT INTO `m_area` VALUES (384, 381, '150103', '回民区', 3);
INSERT INTO `m_area` VALUES (385, 381, '150104', '玉泉区', 3);
INSERT INTO `m_area` VALUES (386, 381, '150105', '赛罕区', 3);
INSERT INTO `m_area` VALUES (387, 381, '150121', '土默特左旗', 3);
INSERT INTO `m_area` VALUES (388, 381, '150122', '托克托县', 3);
INSERT INTO `m_area` VALUES (389, 381, '150123', '和林格尔县', 3);
INSERT INTO `m_area` VALUES (390, 381, '150124', '清水河县', 3);
INSERT INTO `m_area` VALUES (391, 381, '150125', '武川县', 3);
INSERT INTO `m_area` VALUES (392, 380, '150200', '包头市', 2);
INSERT INTO `m_area` VALUES (393, 392, '150201', '市辖区', 3);
INSERT INTO `m_area` VALUES (394, 392, '150202', '东河区', 3);
INSERT INTO `m_area` VALUES (395, 392, '150203', '昆都仑区', 3);
INSERT INTO `m_area` VALUES (396, 392, '150204', '青山区', 3);
INSERT INTO `m_area` VALUES (397, 392, '150205', '石拐区', 3);
INSERT INTO `m_area` VALUES (398, 392, '150206', '白云矿区', 3);
INSERT INTO `m_area` VALUES (399, 392, '150207', '九原区', 3);
INSERT INTO `m_area` VALUES (400, 392, '150221', '土默特右旗', 3);
INSERT INTO `m_area` VALUES (401, 392, '150222', '固阳县', 3);
INSERT INTO `m_area` VALUES (402, 392, '150223', '达尔罕茂明安联合旗', 3);
INSERT INTO `m_area` VALUES (403, 380, '150300', '乌海市', 2);
INSERT INTO `m_area` VALUES (404, 403, '150301', '市辖区', 3);
INSERT INTO `m_area` VALUES (405, 403, '150302', '海勃湾区', 3);
INSERT INTO `m_area` VALUES (406, 403, '150303', '海南区', 3);
INSERT INTO `m_area` VALUES (407, 403, '150304', '乌达区', 3);
INSERT INTO `m_area` VALUES (408, 380, '150400', '赤峰市', 2);
INSERT INTO `m_area` VALUES (409, 408, '150401', '市辖区', 3);
INSERT INTO `m_area` VALUES (410, 408, '150402', '红山区', 3);
INSERT INTO `m_area` VALUES (411, 408, '150403', '元宝山区', 3);
INSERT INTO `m_area` VALUES (412, 408, '150404', '松山区', 3);
INSERT INTO `m_area` VALUES (413, 408, '150421', '阿鲁科尔沁旗', 3);
INSERT INTO `m_area` VALUES (414, 408, '150422', '巴林左旗', 3);
INSERT INTO `m_area` VALUES (415, 408, '150423', '巴林右旗', 3);
INSERT INTO `m_area` VALUES (416, 408, '150424', '林西县', 3);
INSERT INTO `m_area` VALUES (417, 408, '150425', '克什克腾旗', 3);
INSERT INTO `m_area` VALUES (418, 408, '150426', '翁牛特旗', 3);
INSERT INTO `m_area` VALUES (419, 408, '150428', '喀喇沁旗', 3);
INSERT INTO `m_area` VALUES (420, 408, '150429', '宁城县', 3);
INSERT INTO `m_area` VALUES (421, 408, '150430', '敖汉旗', 3);
INSERT INTO `m_area` VALUES (422, 380, '150500', '通辽市', 2);
INSERT INTO `m_area` VALUES (423, 422, '150501', '市辖区', 3);
INSERT INTO `m_area` VALUES (424, 422, '150502', '科尔沁区', 3);
INSERT INTO `m_area` VALUES (425, 422, '150521', '科尔沁左翼中旗', 3);
INSERT INTO `m_area` VALUES (426, 422, '150522', '科尔沁左翼后旗', 3);
INSERT INTO `m_area` VALUES (427, 422, '150523', '开鲁县', 3);
INSERT INTO `m_area` VALUES (428, 422, '150524', '库伦旗', 3);
INSERT INTO `m_area` VALUES (429, 422, '150525', '奈曼旗', 3);
INSERT INTO `m_area` VALUES (430, 422, '150526', '扎鲁特旗', 3);
INSERT INTO `m_area` VALUES (431, 422, '150581', '霍林郭勒市', 3);
INSERT INTO `m_area` VALUES (432, 380, '150600', '鄂尔多斯市', 2);
INSERT INTO `m_area` VALUES (433, 432, '150602', '东胜区', 3);
INSERT INTO `m_area` VALUES (434, 432, '150621', '达拉特旗', 3);
INSERT INTO `m_area` VALUES (435, 432, '150622', '准格尔旗', 3);
INSERT INTO `m_area` VALUES (436, 432, '150623', '鄂托克前旗', 3);
INSERT INTO `m_area` VALUES (437, 432, '150624', '鄂托克旗', 3);
INSERT INTO `m_area` VALUES (438, 432, '150625', '杭锦旗', 3);
INSERT INTO `m_area` VALUES (439, 432, '150626', '乌审旗', 3);
INSERT INTO `m_area` VALUES (440, 432, '150627', '伊金霍洛旗', 3);
INSERT INTO `m_area` VALUES (441, 380, '150700', '呼伦贝尔市', 2);
INSERT INTO `m_area` VALUES (442, 441, '150701', '市辖区', 3);
INSERT INTO `m_area` VALUES (443, 441, '150702', '海拉尔区', 3);
INSERT INTO `m_area` VALUES (444, 441, '150721', '阿荣旗', 3);
INSERT INTO `m_area` VALUES (445, 441, '150722', '莫力达瓦达斡尔族自治旗', 3);
INSERT INTO `m_area` VALUES (446, 441, '150723', '鄂伦春自治旗', 3);
INSERT INTO `m_area` VALUES (447, 441, '150724', '鄂温克族自治旗', 3);
INSERT INTO `m_area` VALUES (448, 441, '150725', '陈巴尔虎旗', 3);
INSERT INTO `m_area` VALUES (449, 441, '150726', '新巴尔虎左旗', 3);
INSERT INTO `m_area` VALUES (450, 441, '150727', '新巴尔虎右旗', 3);
INSERT INTO `m_area` VALUES (451, 441, '150781', '满洲里市', 3);
INSERT INTO `m_area` VALUES (452, 441, '150782', '牙克石市', 3);
INSERT INTO `m_area` VALUES (453, 441, '150783', '扎兰屯市', 3);
INSERT INTO `m_area` VALUES (454, 441, '150784', '额尔古纳市', 3);
INSERT INTO `m_area` VALUES (455, 441, '150785', '根河市', 3);
INSERT INTO `m_area` VALUES (456, 380, '150800', '巴彦淖尔市', 2);
INSERT INTO `m_area` VALUES (457, 456, '150801', '市辖区', 3);
INSERT INTO `m_area` VALUES (458, 456, '150802', '临河区', 3);
INSERT INTO `m_area` VALUES (459, 456, '150821', '五原县', 3);
INSERT INTO `m_area` VALUES (460, 456, '150822', '磴口县', 3);
INSERT INTO `m_area` VALUES (461, 456, '150823', '乌拉特前旗', 3);
INSERT INTO `m_area` VALUES (462, 456, '150824', '乌拉特中旗', 3);
INSERT INTO `m_area` VALUES (463, 456, '150825', '乌拉特后旗', 3);
INSERT INTO `m_area` VALUES (464, 456, '150826', '杭锦后旗', 3);
INSERT INTO `m_area` VALUES (465, 380, '150900', '乌兰察布市', 2);
INSERT INTO `m_area` VALUES (466, 465, '150901', '市辖区', 3);
INSERT INTO `m_area` VALUES (467, 465, '150902', '集宁区', 3);
INSERT INTO `m_area` VALUES (468, 465, '150921', '卓资县', 3);
INSERT INTO `m_area` VALUES (469, 465, '150922', '化德县', 3);
INSERT INTO `m_area` VALUES (470, 465, '150923', '商都县', 3);
INSERT INTO `m_area` VALUES (471, 465, '150924', '兴和县', 3);
INSERT INTO `m_area` VALUES (472, 465, '150925', '凉城县', 3);
INSERT INTO `m_area` VALUES (473, 465, '150926', '察哈尔右翼前旗', 3);
INSERT INTO `m_area` VALUES (474, 465, '150927', '察哈尔右翼中旗', 3);
INSERT INTO `m_area` VALUES (475, 465, '150928', '察哈尔右翼后旗', 3);
INSERT INTO `m_area` VALUES (476, 465, '150929', '四子王旗', 3);
INSERT INTO `m_area` VALUES (477, 465, '150981', '丰镇市', 3);
INSERT INTO `m_area` VALUES (478, 380, '152200', '兴安盟', 2);
INSERT INTO `m_area` VALUES (479, 478, '152201', '乌兰浩特市', 3);
INSERT INTO `m_area` VALUES (480, 478, '152202', '阿尔山市', 3);
INSERT INTO `m_area` VALUES (481, 478, '152221', '科尔沁右翼前旗', 3);
INSERT INTO `m_area` VALUES (482, 478, '152222', '科尔沁右翼中旗', 3);
INSERT INTO `m_area` VALUES (483, 478, '152223', '扎赉特旗', 3);
INSERT INTO `m_area` VALUES (484, 478, '152224', '突泉县', 3);
INSERT INTO `m_area` VALUES (485, 380, '152500', '锡林郭勒盟', 2);
INSERT INTO `m_area` VALUES (486, 485, '152501', '二连浩特市', 3);
INSERT INTO `m_area` VALUES (487, 485, '152502', '锡林浩特市', 3);
INSERT INTO `m_area` VALUES (488, 485, '152522', '阿巴嘎旗', 3);
INSERT INTO `m_area` VALUES (489, 485, '152523', '苏尼特左旗', 3);
INSERT INTO `m_area` VALUES (490, 485, '152524', '苏尼特右旗', 3);
INSERT INTO `m_area` VALUES (491, 485, '152525', '东乌珠穆沁旗', 3);
INSERT INTO `m_area` VALUES (492, 485, '152526', '西乌珠穆沁旗', 3);
INSERT INTO `m_area` VALUES (493, 485, '152527', '太仆寺旗', 3);
INSERT INTO `m_area` VALUES (494, 485, '152528', '镶黄旗', 3);
INSERT INTO `m_area` VALUES (495, 485, '152529', '正镶白旗', 3);
INSERT INTO `m_area` VALUES (496, 485, '152530', '正蓝旗', 3);
INSERT INTO `m_area` VALUES (497, 485, '152531', '多伦县', 3);
INSERT INTO `m_area` VALUES (498, 380, '152900', '阿拉善盟', 2);
INSERT INTO `m_area` VALUES (499, 498, '152921', '阿拉善左旗', 3);
INSERT INTO `m_area` VALUES (500, 498, '152922', '阿拉善右旗', 3);
INSERT INTO `m_area` VALUES (501, 498, '152923', '额济纳旗', 3);
INSERT INTO `m_area` VALUES (502, 0, '210000', '辽宁省', 1);
INSERT INTO `m_area` VALUES (503, 502, '210100', '沈阳市', 2);
INSERT INTO `m_area` VALUES (504, 503, '210101', '市辖区', 3);
INSERT INTO `m_area` VALUES (505, 503, '210102', '和平区', 3);
INSERT INTO `m_area` VALUES (506, 503, '210103', '沈河区', 3);
INSERT INTO `m_area` VALUES (507, 503, '210104', '大东区', 3);
INSERT INTO `m_area` VALUES (508, 503, '210105', '皇姑区', 3);
INSERT INTO `m_area` VALUES (509, 503, '210106', '铁西区', 3);
INSERT INTO `m_area` VALUES (510, 503, '210111', '苏家屯区', 3);
INSERT INTO `m_area` VALUES (511, 503, '210112', '东陵区', 3);
INSERT INTO `m_area` VALUES (512, 503, '210113', '新城子区', 3);
INSERT INTO `m_area` VALUES (513, 503, '210114', '于洪区', 3);
INSERT INTO `m_area` VALUES (514, 503, '210122', '辽中县', 3);
INSERT INTO `m_area` VALUES (515, 503, '210123', '康平县', 3);
INSERT INTO `m_area` VALUES (516, 503, '210124', '法库县', 3);
INSERT INTO `m_area` VALUES (517, 503, '210181', '新民市', 3);
INSERT INTO `m_area` VALUES (518, 502, '210200', '大连市', 2);
INSERT INTO `m_area` VALUES (519, 518, '210201', '市辖区', 3);
INSERT INTO `m_area` VALUES (520, 518, '210202', '中山区', 3);
INSERT INTO `m_area` VALUES (521, 518, '210203', '西岗区', 3);
INSERT INTO `m_area` VALUES (522, 518, '210204', '沙河口区', 3);
INSERT INTO `m_area` VALUES (523, 518, '210211', '甘井子区', 3);
INSERT INTO `m_area` VALUES (524, 518, '210212', '旅顺口区', 3);
INSERT INTO `m_area` VALUES (525, 518, '210213', '金州区', 3);
INSERT INTO `m_area` VALUES (526, 518, '210224', '长海县', 3);
INSERT INTO `m_area` VALUES (527, 518, '210281', '瓦房店市', 3);
INSERT INTO `m_area` VALUES (528, 518, '210282', '普兰店市', 3);
INSERT INTO `m_area` VALUES (529, 518, '210283', '庄河市', 3);
INSERT INTO `m_area` VALUES (530, 502, '210300', '鞍山市', 2);
INSERT INTO `m_area` VALUES (531, 530, '210301', '市辖区', 3);
INSERT INTO `m_area` VALUES (532, 530, '210302', '铁东区', 3);
INSERT INTO `m_area` VALUES (533, 530, '210303', '铁西区', 3);
INSERT INTO `m_area` VALUES (534, 530, '210304', '立山区', 3);
INSERT INTO `m_area` VALUES (535, 530, '210311', '千山区', 3);
INSERT INTO `m_area` VALUES (536, 530, '210321', '台安县', 3);
INSERT INTO `m_area` VALUES (537, 530, '210323', '岫岩满族自治县', 3);
INSERT INTO `m_area` VALUES (538, 530, '210381', '海城市', 3);
INSERT INTO `m_area` VALUES (539, 502, '210400', '抚顺市', 2);
INSERT INTO `m_area` VALUES (540, 539, '210401', '市辖区', 3);
INSERT INTO `m_area` VALUES (541, 539, '210402', '新抚区', 3);
INSERT INTO `m_area` VALUES (542, 539, '210403', '东洲区', 3);
INSERT INTO `m_area` VALUES (543, 539, '210404', '望花区', 3);
INSERT INTO `m_area` VALUES (544, 539, '210411', '顺城区', 3);
INSERT INTO `m_area` VALUES (545, 539, '210421', '抚顺县', 3);
INSERT INTO `m_area` VALUES (546, 539, '210422', '新宾满族自治县', 3);
INSERT INTO `m_area` VALUES (547, 539, '210423', '清原满族自治县', 3);
INSERT INTO `m_area` VALUES (548, 502, '210500', '本溪市', 2);
INSERT INTO `m_area` VALUES (549, 548, '210501', '市辖区', 3);
INSERT INTO `m_area` VALUES (550, 548, '210502', '平山区', 3);
INSERT INTO `m_area` VALUES (551, 548, '210503', '溪湖区', 3);
INSERT INTO `m_area` VALUES (552, 548, '210504', '明山区', 3);
INSERT INTO `m_area` VALUES (553, 548, '210505', '南芬区', 3);
INSERT INTO `m_area` VALUES (554, 548, '210521', '本溪满族自治县', 3);
INSERT INTO `m_area` VALUES (555, 548, '210522', '桓仁满族自治县', 3);
INSERT INTO `m_area` VALUES (556, 502, '210600', '丹东市', 2);
INSERT INTO `m_area` VALUES (557, 556, '210601', '市辖区', 3);
INSERT INTO `m_area` VALUES (558, 556, '210602', '元宝区', 3);
INSERT INTO `m_area` VALUES (559, 556, '210603', '振兴区', 3);
INSERT INTO `m_area` VALUES (560, 556, '210604', '振安区', 3);
INSERT INTO `m_area` VALUES (561, 556, '210624', '宽甸满族自治县', 3);
INSERT INTO `m_area` VALUES (562, 556, '210681', '东港市', 3);
INSERT INTO `m_area` VALUES (563, 556, '210682', '凤城市', 3);
INSERT INTO `m_area` VALUES (564, 502, '210700', '锦州市', 2);
INSERT INTO `m_area` VALUES (565, 564, '210701', '市辖区', 3);
INSERT INTO `m_area` VALUES (566, 564, '210702', '古塔区', 3);
INSERT INTO `m_area` VALUES (567, 564, '210703', '凌河区', 3);
INSERT INTO `m_area` VALUES (568, 564, '210711', '太和区', 3);
INSERT INTO `m_area` VALUES (569, 564, '210726', '黑山县', 3);
INSERT INTO `m_area` VALUES (570, 564, '210727', '义　县', 3);
INSERT INTO `m_area` VALUES (571, 564, '210781', '凌海市', 3);
INSERT INTO `m_area` VALUES (572, 564, '210782', '北宁市', 3);
INSERT INTO `m_area` VALUES (573, 502, '210800', '营口市', 2);
INSERT INTO `m_area` VALUES (574, 573, '210801', '市辖区', 3);
INSERT INTO `m_area` VALUES (575, 573, '210802', '站前区', 3);
INSERT INTO `m_area` VALUES (576, 573, '210803', '西市区', 3);
INSERT INTO `m_area` VALUES (577, 573, '210804', '鲅鱼圈区', 3);
INSERT INTO `m_area` VALUES (578, 573, '210811', '老边区', 3);
INSERT INTO `m_area` VALUES (579, 573, '210881', '盖州市', 3);
INSERT INTO `m_area` VALUES (580, 573, '210882', '大石桥市', 3);
INSERT INTO `m_area` VALUES (581, 502, '210900', '阜新市', 2);
INSERT INTO `m_area` VALUES (582, 581, '210901', '市辖区', 3);
INSERT INTO `m_area` VALUES (583, 581, '210902', '海州区', 3);
INSERT INTO `m_area` VALUES (584, 581, '210903', '新邱区', 3);
INSERT INTO `m_area` VALUES (585, 581, '210904', '太平区', 3);
INSERT INTO `m_area` VALUES (586, 581, '210905', '清河门区', 3);
INSERT INTO `m_area` VALUES (587, 581, '210911', '细河区', 3);
INSERT INTO `m_area` VALUES (588, 581, '210921', '阜新蒙古族自治县', 3);
INSERT INTO `m_area` VALUES (589, 581, '210922', '彰武县', 3);
INSERT INTO `m_area` VALUES (590, 502, '211000', '辽阳市', 2);
INSERT INTO `m_area` VALUES (591, 590, '211001', '市辖区', 3);
INSERT INTO `m_area` VALUES (592, 590, '211002', '白塔区', 3);
INSERT INTO `m_area` VALUES (593, 590, '211003', '文圣区', 3);
INSERT INTO `m_area` VALUES (594, 590, '211004', '宏伟区', 3);
INSERT INTO `m_area` VALUES (595, 590, '211005', '弓长岭区', 3);
INSERT INTO `m_area` VALUES (596, 590, '211011', '太子河区', 3);
INSERT INTO `m_area` VALUES (597, 590, '211021', '辽阳县', 3);
INSERT INTO `m_area` VALUES (598, 590, '211081', '灯塔市', 3);
INSERT INTO `m_area` VALUES (599, 502, '211100', '盘锦市', 2);
INSERT INTO `m_area` VALUES (600, 599, '211101', '市辖区', 3);
INSERT INTO `m_area` VALUES (601, 599, '211102', '双台子区', 3);
INSERT INTO `m_area` VALUES (602, 599, '211103', '兴隆台区', 3);
INSERT INTO `m_area` VALUES (603, 599, '211121', '大洼县', 3);
INSERT INTO `m_area` VALUES (604, 599, '211122', '盘山县', 3);
INSERT INTO `m_area` VALUES (605, 502, '211200', '铁岭市', 2);
INSERT INTO `m_area` VALUES (606, 605, '211201', '市辖区', 3);
INSERT INTO `m_area` VALUES (607, 605, '211202', '银州区', 3);
INSERT INTO `m_area` VALUES (608, 605, '211204', '清河区', 3);
INSERT INTO `m_area` VALUES (609, 605, '211221', '铁岭县', 3);
INSERT INTO `m_area` VALUES (610, 605, '211223', '西丰县', 3);
INSERT INTO `m_area` VALUES (611, 605, '211224', '昌图县', 3);
INSERT INTO `m_area` VALUES (612, 605, '211281', '调兵山市', 3);
INSERT INTO `m_area` VALUES (613, 605, '211282', '开原市', 3);
INSERT INTO `m_area` VALUES (614, 502, '211300', '朝阳市', 2);
INSERT INTO `m_area` VALUES (615, 614, '211301', '市辖区', 3);
INSERT INTO `m_area` VALUES (616, 614, '211302', '双塔区', 3);
INSERT INTO `m_area` VALUES (617, 614, '211303', '龙城区', 3);
INSERT INTO `m_area` VALUES (618, 614, '211321', '朝阳县', 3);
INSERT INTO `m_area` VALUES (619, 614, '211322', '建平县', 3);
INSERT INTO `m_area` VALUES (620, 614, '211324', '喀喇沁左翼蒙古族自治县', 3);
INSERT INTO `m_area` VALUES (621, 614, '211381', '北票市', 3);
INSERT INTO `m_area` VALUES (622, 614, '211382', '凌源市', 3);
INSERT INTO `m_area` VALUES (623, 502, '211400', '葫芦岛市', 2);
INSERT INTO `m_area` VALUES (624, 623, '211401', '市辖区', 3);
INSERT INTO `m_area` VALUES (625, 623, '211402', '连山区', 3);
INSERT INTO `m_area` VALUES (626, 623, '211403', '龙港区', 3);
INSERT INTO `m_area` VALUES (627, 623, '211404', '南票区', 3);
INSERT INTO `m_area` VALUES (628, 623, '211421', '绥中县', 3);
INSERT INTO `m_area` VALUES (629, 623, '211422', '建昌县', 3);
INSERT INTO `m_area` VALUES (630, 623, '211481', '兴城市', 3);
INSERT INTO `m_area` VALUES (631, 0, '220000', '吉林省', 1);
INSERT INTO `m_area` VALUES (632, 631, '220100', '长春市', 2);
INSERT INTO `m_area` VALUES (633, 632, '220101', '市辖区', 3);
INSERT INTO `m_area` VALUES (634, 632, '220102', '南关区', 3);
INSERT INTO `m_area` VALUES (635, 632, '220103', '宽城区', 3);
INSERT INTO `m_area` VALUES (636, 632, '220104', '朝阳区', 3);
INSERT INTO `m_area` VALUES (637, 632, '220105', '二道区', 3);
INSERT INTO `m_area` VALUES (638, 632, '220106', '绿园区', 3);
INSERT INTO `m_area` VALUES (639, 632, '220112', '双阳区', 3);
INSERT INTO `m_area` VALUES (640, 632, '220122', '农安县', 3);
INSERT INTO `m_area` VALUES (641, 632, '220181', '九台市', 3);
INSERT INTO `m_area` VALUES (642, 632, '220182', '榆树市', 3);
INSERT INTO `m_area` VALUES (643, 632, '220183', '德惠市', 3);
INSERT INTO `m_area` VALUES (644, 631, '220200', '吉林市', 2);
INSERT INTO `m_area` VALUES (645, 644, '220201', '市辖区', 3);
INSERT INTO `m_area` VALUES (646, 644, '220202', '昌邑区', 3);
INSERT INTO `m_area` VALUES (647, 644, '220203', '龙潭区', 3);
INSERT INTO `m_area` VALUES (648, 644, '220204', '船营区', 3);
INSERT INTO `m_area` VALUES (649, 644, '220211', '丰满区', 3);
INSERT INTO `m_area` VALUES (650, 644, '220221', '永吉县', 3);
INSERT INTO `m_area` VALUES (651, 644, '220281', '蛟河市', 3);
INSERT INTO `m_area` VALUES (652, 644, '220282', '桦甸市', 3);
INSERT INTO `m_area` VALUES (653, 644, '220283', '舒兰市', 3);
INSERT INTO `m_area` VALUES (654, 644, '220284', '磐石市', 3);
INSERT INTO `m_area` VALUES (655, 631, '220300', '四平市', 2);
INSERT INTO `m_area` VALUES (656, 655, '220301', '市辖区', 3);
INSERT INTO `m_area` VALUES (657, 655, '220302', '铁西区', 3);
INSERT INTO `m_area` VALUES (658, 655, '220303', '铁东区', 3);
INSERT INTO `m_area` VALUES (659, 655, '220322', '梨树县', 3);
INSERT INTO `m_area` VALUES (660, 655, '220323', '伊通满族自治县', 3);
INSERT INTO `m_area` VALUES (661, 655, '220381', '公主岭市', 3);
INSERT INTO `m_area` VALUES (662, 655, '220382', '双辽市', 3);
INSERT INTO `m_area` VALUES (663, 631, '220400', '辽源市', 2);
INSERT INTO `m_area` VALUES (664, 663, '220401', '市辖区', 3);
INSERT INTO `m_area` VALUES (665, 663, '220402', '龙山区', 3);
INSERT INTO `m_area` VALUES (666, 663, '220403', '西安区', 3);
INSERT INTO `m_area` VALUES (667, 663, '220421', '东丰县', 3);
INSERT INTO `m_area` VALUES (668, 663, '220422', '东辽县', 3);
INSERT INTO `m_area` VALUES (669, 631, '220500', '通化市', 2);
INSERT INTO `m_area` VALUES (670, 669, '220501', '市辖区', 3);
INSERT INTO `m_area` VALUES (671, 669, '220502', '东昌区', 3);
INSERT INTO `m_area` VALUES (672, 669, '220503', '二道江区', 3);
INSERT INTO `m_area` VALUES (673, 669, '220521', '通化县', 3);
INSERT INTO `m_area` VALUES (674, 669, '220523', '辉南县', 3);
INSERT INTO `m_area` VALUES (675, 669, '220524', '柳河县', 3);
INSERT INTO `m_area` VALUES (676, 669, '220581', '梅河口市', 3);
INSERT INTO `m_area` VALUES (677, 669, '220582', '集安市', 3);
INSERT INTO `m_area` VALUES (678, 631, '220600', '白山市', 2);
INSERT INTO `m_area` VALUES (679, 678, '220601', '市辖区', 3);
INSERT INTO `m_area` VALUES (680, 678, '220602', '八道江区', 3);
INSERT INTO `m_area` VALUES (681, 678, '220621', '抚松县', 3);
INSERT INTO `m_area` VALUES (682, 678, '220622', '靖宇县', 3);
INSERT INTO `m_area` VALUES (683, 678, '220623', '长白朝鲜族自治县', 3);
INSERT INTO `m_area` VALUES (684, 678, '220625', '江源县', 3);
INSERT INTO `m_area` VALUES (685, 678, '220681', '临江市', 3);
INSERT INTO `m_area` VALUES (686, 631, '220700', '松原市', 2);
INSERT INTO `m_area` VALUES (687, 686, '220701', '市辖区', 3);
INSERT INTO `m_area` VALUES (688, 686, '220702', '宁江区', 3);
INSERT INTO `m_area` VALUES (689, 686, '220721', '前郭尔罗斯蒙古族自治县', 3);
INSERT INTO `m_area` VALUES (690, 686, '220722', '长岭县', 3);
INSERT INTO `m_area` VALUES (691, 686, '220723', '乾安县', 3);
INSERT INTO `m_area` VALUES (692, 686, '220724', '扶余县', 3);
INSERT INTO `m_area` VALUES (693, 631, '220800', '白城市', 2);
INSERT INTO `m_area` VALUES (694, 693, '220801', '市辖区', 3);
INSERT INTO `m_area` VALUES (695, 693, '220802', '洮北区', 3);
INSERT INTO `m_area` VALUES (696, 693, '220821', '镇赉县', 3);
INSERT INTO `m_area` VALUES (697, 693, '220822', '通榆县', 3);
INSERT INTO `m_area` VALUES (698, 693, '220881', '洮南市', 3);
INSERT INTO `m_area` VALUES (699, 693, '220882', '大安市', 3);
INSERT INTO `m_area` VALUES (700, 631, '222400', '延边朝鲜族自治州', 2);
INSERT INTO `m_area` VALUES (701, 700, '222401', '延吉市', 3);
INSERT INTO `m_area` VALUES (702, 700, '222402', '图们市', 3);
INSERT INTO `m_area` VALUES (703, 700, '222403', '敦化市', 3);
INSERT INTO `m_area` VALUES (704, 700, '222404', '珲春市', 3);
INSERT INTO `m_area` VALUES (705, 700, '222405', '龙井市', 3);
INSERT INTO `m_area` VALUES (706, 700, '222406', '和龙市', 3);
INSERT INTO `m_area` VALUES (707, 700, '222424', '汪清县', 3);
INSERT INTO `m_area` VALUES (708, 700, '222426', '安图县', 3);
INSERT INTO `m_area` VALUES (709, 0, '230000', '黑龙江省', 1);
INSERT INTO `m_area` VALUES (710, 709, '230100', '哈尔滨市', 2);
INSERT INTO `m_area` VALUES (711, 710, '230101', '市辖区', 3);
INSERT INTO `m_area` VALUES (712, 710, '230102', '道里区', 3);
INSERT INTO `m_area` VALUES (713, 710, '230103', '南岗区', 3);
INSERT INTO `m_area` VALUES (714, 710, '230104', '道外区', 3);
INSERT INTO `m_area` VALUES (715, 710, '230106', '香坊区', 3);
INSERT INTO `m_area` VALUES (716, 710, '230107', '动力区', 3);
INSERT INTO `m_area` VALUES (717, 710, '230108', '平房区', 3);
INSERT INTO `m_area` VALUES (718, 710, '230109', '松北区', 3);
INSERT INTO `m_area` VALUES (719, 710, '230111', '呼兰区', 3);
INSERT INTO `m_area` VALUES (720, 710, '230123', '依兰县', 3);
INSERT INTO `m_area` VALUES (721, 710, '230124', '方正县', 3);
INSERT INTO `m_area` VALUES (722, 710, '230125', '宾　县', 3);
INSERT INTO `m_area` VALUES (723, 710, '230126', '巴彦县', 3);
INSERT INTO `m_area` VALUES (724, 710, '230127', '木兰县', 3);
INSERT INTO `m_area` VALUES (725, 710, '230128', '通河县', 3);
INSERT INTO `m_area` VALUES (726, 710, '230129', '延寿县', 3);
INSERT INTO `m_area` VALUES (727, 710, '230181', '阿城市', 3);
INSERT INTO `m_area` VALUES (728, 710, '230182', '双城市', 3);
INSERT INTO `m_area` VALUES (729, 710, '230183', '尚志市', 3);
INSERT INTO `m_area` VALUES (730, 710, '230184', '五常市', 3);
INSERT INTO `m_area` VALUES (731, 709, '230200', '齐齐哈尔市', 2);
INSERT INTO `m_area` VALUES (732, 731, '230201', '市辖区', 3);
INSERT INTO `m_area` VALUES (733, 731, '230202', '龙沙区', 3);
INSERT INTO `m_area` VALUES (734, 731, '230203', '建华区', 3);
INSERT INTO `m_area` VALUES (735, 731, '230204', '铁锋区', 3);
INSERT INTO `m_area` VALUES (736, 731, '230205', '昂昂溪区', 3);
INSERT INTO `m_area` VALUES (737, 731, '230206', '富拉尔基区', 3);
INSERT INTO `m_area` VALUES (738, 731, '230207', '碾子山区', 3);
INSERT INTO `m_area` VALUES (739, 731, '230208', '梅里斯达斡尔族区', 3);
INSERT INTO `m_area` VALUES (740, 731, '230221', '龙江县', 3);
INSERT INTO `m_area` VALUES (741, 731, '230223', '依安县', 3);
INSERT INTO `m_area` VALUES (742, 731, '230224', '泰来县', 3);
INSERT INTO `m_area` VALUES (743, 731, '230225', '甘南县', 3);
INSERT INTO `m_area` VALUES (744, 731, '230227', '富裕县', 3);
INSERT INTO `m_area` VALUES (745, 731, '230229', '克山县', 3);
INSERT INTO `m_area` VALUES (746, 731, '230230', '克东县', 3);
INSERT INTO `m_area` VALUES (747, 731, '230231', '拜泉县', 3);
INSERT INTO `m_area` VALUES (748, 731, '230281', '讷河市', 3);
INSERT INTO `m_area` VALUES (749, 709, '230300', '鸡西市', 2);
INSERT INTO `m_area` VALUES (750, 749, '230301', '市辖区', 3);
INSERT INTO `m_area` VALUES (751, 749, '230302', '鸡冠区', 3);
INSERT INTO `m_area` VALUES (752, 749, '230303', '恒山区', 3);
INSERT INTO `m_area` VALUES (753, 749, '230304', '滴道区', 3);
INSERT INTO `m_area` VALUES (754, 749, '230305', '梨树区', 3);
INSERT INTO `m_area` VALUES (755, 749, '230306', '城子河区', 3);
INSERT INTO `m_area` VALUES (756, 749, '230307', '麻山区', 3);
INSERT INTO `m_area` VALUES (757, 749, '230321', '鸡东县', 3);
INSERT INTO `m_area` VALUES (758, 749, '230381', '虎林市', 3);
INSERT INTO `m_area` VALUES (759, 749, '230382', '密山市', 3);
INSERT INTO `m_area` VALUES (760, 709, '230400', '鹤岗市', 2);
INSERT INTO `m_area` VALUES (761, 760, '230401', '市辖区', 3);
INSERT INTO `m_area` VALUES (762, 760, '230402', '向阳区', 3);
INSERT INTO `m_area` VALUES (763, 760, '230403', '工农区', 3);
INSERT INTO `m_area` VALUES (764, 760, '230404', '南山区', 3);
INSERT INTO `m_area` VALUES (765, 760, '230405', '兴安区', 3);
INSERT INTO `m_area` VALUES (766, 760, '230406', '东山区', 3);
INSERT INTO `m_area` VALUES (767, 760, '230407', '兴山区', 3);
INSERT INTO `m_area` VALUES (768, 760, '230421', '萝北县', 3);
INSERT INTO `m_area` VALUES (769, 760, '230422', '绥滨县', 3);
INSERT INTO `m_area` VALUES (770, 709, '230500', '双鸭山市', 2);
INSERT INTO `m_area` VALUES (771, 770, '230501', '市辖区', 3);
INSERT INTO `m_area` VALUES (772, 770, '230502', '尖山区', 3);
INSERT INTO `m_area` VALUES (773, 770, '230503', '岭东区', 3);
INSERT INTO `m_area` VALUES (774, 770, '230505', '四方台区', 3);
INSERT INTO `m_area` VALUES (775, 770, '230506', '宝山区', 3);
INSERT INTO `m_area` VALUES (776, 770, '230521', '集贤县', 3);
INSERT INTO `m_area` VALUES (777, 770, '230522', '友谊县', 3);
INSERT INTO `m_area` VALUES (778, 770, '230523', '宝清县', 3);
INSERT INTO `m_area` VALUES (779, 770, '230524', '饶河县', 3);
INSERT INTO `m_area` VALUES (780, 709, '230600', '大庆市', 2);
INSERT INTO `m_area` VALUES (781, 780, '230601', '市辖区', 3);
INSERT INTO `m_area` VALUES (782, 780, '230602', '萨尔图区', 3);
INSERT INTO `m_area` VALUES (783, 780, '230603', '龙凤区', 3);
INSERT INTO `m_area` VALUES (784, 780, '230604', '让胡路区', 3);
INSERT INTO `m_area` VALUES (785, 780, '230605', '红岗区', 3);
INSERT INTO `m_area` VALUES (786, 780, '230606', '大同区', 3);
INSERT INTO `m_area` VALUES (787, 780, '230621', '肇州县', 3);
INSERT INTO `m_area` VALUES (788, 780, '230622', '肇源县', 3);
INSERT INTO `m_area` VALUES (789, 780, '230623', '林甸县', 3);
INSERT INTO `m_area` VALUES (790, 780, '230624', '杜尔伯特蒙古族自治县', 3);
INSERT INTO `m_area` VALUES (791, 709, '230700', '伊春市', 2);
INSERT INTO `m_area` VALUES (792, 791, '230701', '市辖区', 3);
INSERT INTO `m_area` VALUES (793, 791, '230702', '伊春区', 3);
INSERT INTO `m_area` VALUES (794, 791, '230703', '南岔区', 3);
INSERT INTO `m_area` VALUES (795, 791, '230704', '友好区', 3);
INSERT INTO `m_area` VALUES (796, 791, '230705', '西林区', 3);
INSERT INTO `m_area` VALUES (797, 791, '230706', '翠峦区', 3);
INSERT INTO `m_area` VALUES (798, 791, '230707', '新青区', 3);
INSERT INTO `m_area` VALUES (799, 791, '230708', '美溪区', 3);
INSERT INTO `m_area` VALUES (800, 791, '230709', '金山屯区', 3);
INSERT INTO `m_area` VALUES (801, 791, '230710', '五营区', 3);
INSERT INTO `m_area` VALUES (802, 791, '230711', '乌马河区', 3);
INSERT INTO `m_area` VALUES (803, 791, '230712', '汤旺河区', 3);
INSERT INTO `m_area` VALUES (804, 791, '230713', '带岭区', 3);
INSERT INTO `m_area` VALUES (805, 791, '230714', '乌伊岭区', 3);
INSERT INTO `m_area` VALUES (806, 791, '230715', '红星区', 3);
INSERT INTO `m_area` VALUES (807, 791, '230716', '上甘岭区', 3);
INSERT INTO `m_area` VALUES (808, 791, '230722', '嘉荫县', 3);
INSERT INTO `m_area` VALUES (809, 791, '230781', '铁力市', 3);
INSERT INTO `m_area` VALUES (810, 709, '230800', '佳木斯市', 2);
INSERT INTO `m_area` VALUES (811, 810, '230801', '市辖区', 3);
INSERT INTO `m_area` VALUES (812, 810, '230802', '永红区', 3);
INSERT INTO `m_area` VALUES (813, 810, '230803', '向阳区', 3);
INSERT INTO `m_area` VALUES (814, 810, '230804', '前进区', 3);
INSERT INTO `m_area` VALUES (815, 810, '230805', '东风区', 3);
INSERT INTO `m_area` VALUES (816, 810, '230811', '郊　区', 3);
INSERT INTO `m_area` VALUES (817, 810, '230822', '桦南县', 3);
INSERT INTO `m_area` VALUES (818, 810, '230826', '桦川县', 3);
INSERT INTO `m_area` VALUES (819, 810, '230828', '汤原县', 3);
INSERT INTO `m_area` VALUES (820, 810, '230833', '抚远县', 3);
INSERT INTO `m_area` VALUES (821, 810, '230881', '同江市', 3);
INSERT INTO `m_area` VALUES (822, 810, '230882', '富锦市', 3);
INSERT INTO `m_area` VALUES (823, 709, '230900', '七台河市', 2);
INSERT INTO `m_area` VALUES (824, 823, '230901', '市辖区', 3);
INSERT INTO `m_area` VALUES (825, 823, '230902', '新兴区', 3);
INSERT INTO `m_area` VALUES (826, 823, '230903', '桃山区', 3);
INSERT INTO `m_area` VALUES (827, 823, '230904', '茄子河区', 3);
INSERT INTO `m_area` VALUES (828, 823, '230921', '勃利县', 3);
INSERT INTO `m_area` VALUES (829, 709, '231000', '牡丹江市', 2);
INSERT INTO `m_area` VALUES (830, 829, '231001', '市辖区', 3);
INSERT INTO `m_area` VALUES (831, 829, '231002', '东安区', 3);
INSERT INTO `m_area` VALUES (832, 829, '231003', '阳明区', 3);
INSERT INTO `m_area` VALUES (833, 829, '231004', '爱民区', 3);
INSERT INTO `m_area` VALUES (834, 829, '231005', '西安区', 3);
INSERT INTO `m_area` VALUES (835, 829, '231024', '东宁县', 3);
INSERT INTO `m_area` VALUES (836, 829, '231025', '林口县', 3);
INSERT INTO `m_area` VALUES (837, 829, '231081', '绥芬河市', 3);
INSERT INTO `m_area` VALUES (838, 829, '231083', '海林市', 3);
INSERT INTO `m_area` VALUES (839, 829, '231084', '宁安市', 3);
INSERT INTO `m_area` VALUES (840, 829, '231085', '穆棱市', 3);
INSERT INTO `m_area` VALUES (841, 709, '231100', '黑河市', 2);
INSERT INTO `m_area` VALUES (842, 841, '231101', '市辖区', 3);
INSERT INTO `m_area` VALUES (843, 841, '231102', '爱辉区', 3);
INSERT INTO `m_area` VALUES (844, 841, '231121', '嫩江县', 3);
INSERT INTO `m_area` VALUES (845, 841, '231123', '逊克县', 3);
INSERT INTO `m_area` VALUES (846, 841, '231124', '孙吴县', 3);
INSERT INTO `m_area` VALUES (847, 841, '231181', '北安市', 3);
INSERT INTO `m_area` VALUES (848, 841, '231182', '五大连池市', 3);
INSERT INTO `m_area` VALUES (849, 709, '231200', '绥化市', 2);
INSERT INTO `m_area` VALUES (850, 849, '231201', '市辖区', 3);
INSERT INTO `m_area` VALUES (851, 849, '231202', '北林区', 3);
INSERT INTO `m_area` VALUES (852, 849, '231221', '望奎县', 3);
INSERT INTO `m_area` VALUES (853, 849, '231222', '兰西县', 3);
INSERT INTO `m_area` VALUES (854, 849, '231223', '青冈县', 3);
INSERT INTO `m_area` VALUES (855, 849, '231224', '庆安县', 3);
INSERT INTO `m_area` VALUES (856, 849, '231225', '明水县', 3);
INSERT INTO `m_area` VALUES (857, 849, '231226', '绥棱县', 3);
INSERT INTO `m_area` VALUES (858, 849, '231281', '安达市', 3);
INSERT INTO `m_area` VALUES (859, 849, '231282', '肇东市', 3);
INSERT INTO `m_area` VALUES (860, 849, '231283', '海伦市', 3);
INSERT INTO `m_area` VALUES (861, 709, '232700', '大兴安岭地区', 2);
INSERT INTO `m_area` VALUES (862, 861, '232721', '呼玛县', 3);
INSERT INTO `m_area` VALUES (863, 861, '232722', '塔河县', 3);
INSERT INTO `m_area` VALUES (864, 861, '232723', '漠河县', 3);
INSERT INTO `m_area` VALUES (865, 0, '310000', '上海市', 1);
INSERT INTO `m_area` VALUES (866, 865, '310100', '市辖区', 2);
INSERT INTO `m_area` VALUES (867, 866, '310101', '黄浦区', 3);
INSERT INTO `m_area` VALUES (868, 866, '310103', '卢湾区', 3);
INSERT INTO `m_area` VALUES (869, 866, '310104', '徐汇区', 3);
INSERT INTO `m_area` VALUES (870, 866, '310105', '长宁区', 3);
INSERT INTO `m_area` VALUES (871, 866, '310106', '静安区', 3);
INSERT INTO `m_area` VALUES (872, 866, '310107', '普陀区', 3);
INSERT INTO `m_area` VALUES (873, 866, '310108', '闸北区', 3);
INSERT INTO `m_area` VALUES (874, 866, '310109', '虹口区', 3);
INSERT INTO `m_area` VALUES (875, 866, '310110', '杨浦区', 3);
INSERT INTO `m_area` VALUES (876, 866, '310112', '闵行区', 3);
INSERT INTO `m_area` VALUES (877, 866, '310113', '宝山区', 3);
INSERT INTO `m_area` VALUES (878, 866, '310114', '嘉定区', 3);
INSERT INTO `m_area` VALUES (879, 866, '310115', '浦东新区', 3);
INSERT INTO `m_area` VALUES (880, 866, '310116', '金山区', 3);
INSERT INTO `m_area` VALUES (881, 866, '310117', '松江区', 3);
INSERT INTO `m_area` VALUES (882, 866, '310118', '青浦区', 3);
INSERT INTO `m_area` VALUES (883, 866, '310119', '南汇区', 3);
INSERT INTO `m_area` VALUES (884, 866, '310120', '奉贤区', 3);
INSERT INTO `m_area` VALUES (885, 865, '310200', '县', 2);
INSERT INTO `m_area` VALUES (886, 885, '310230', '崇明县', 3);
INSERT INTO `m_area` VALUES (887, 0, '320000', '江苏省', 1);
INSERT INTO `m_area` VALUES (888, 887, '320100', '南京市', 2);
INSERT INTO `m_area` VALUES (889, 888, '320101', '市辖区', 3);
INSERT INTO `m_area` VALUES (890, 888, '320102', '玄武区', 3);
INSERT INTO `m_area` VALUES (891, 888, '320103', '白下区', 3);
INSERT INTO `m_area` VALUES (892, 888, '320104', '秦淮区', 3);
INSERT INTO `m_area` VALUES (893, 888, '320105', '建邺区', 3);
INSERT INTO `m_area` VALUES (894, 888, '320106', '鼓楼区', 3);
INSERT INTO `m_area` VALUES (895, 888, '320107', '下关区', 3);
INSERT INTO `m_area` VALUES (896, 888, '320111', '浦口区', 3);
INSERT INTO `m_area` VALUES (897, 888, '320113', '栖霞区', 3);
INSERT INTO `m_area` VALUES (898, 888, '320114', '雨花台区', 3);
INSERT INTO `m_area` VALUES (899, 888, '320115', '江宁区', 3);
INSERT INTO `m_area` VALUES (900, 888, '320116', '六合区', 3);
INSERT INTO `m_area` VALUES (901, 888, '320124', '溧水县', 3);
INSERT INTO `m_area` VALUES (902, 888, '320125', '高淳县', 3);
INSERT INTO `m_area` VALUES (903, 887, '320200', '无锡市', 2);
INSERT INTO `m_area` VALUES (904, 903, '320201', '市辖区', 3);
INSERT INTO `m_area` VALUES (905, 903, '320202', '崇安区', 3);
INSERT INTO `m_area` VALUES (906, 903, '320203', '南长区', 3);
INSERT INTO `m_area` VALUES (907, 903, '320204', '北塘区', 3);
INSERT INTO `m_area` VALUES (908, 903, '320205', '锡山区', 3);
INSERT INTO `m_area` VALUES (909, 903, '320206', '惠山区', 3);
INSERT INTO `m_area` VALUES (910, 903, '320211', '滨湖区', 3);
INSERT INTO `m_area` VALUES (911, 903, '320281', '江阴市', 3);
INSERT INTO `m_area` VALUES (912, 903, '320282', '宜兴市', 3);
INSERT INTO `m_area` VALUES (913, 887, '320300', '徐州市', 2);
INSERT INTO `m_area` VALUES (914, 913, '320301', '市辖区', 3);
INSERT INTO `m_area` VALUES (915, 913, '320302', '鼓楼区', 3);
INSERT INTO `m_area` VALUES (916, 913, '320303', '云龙区', 3);
INSERT INTO `m_area` VALUES (917, 913, '320304', '九里区', 3);
INSERT INTO `m_area` VALUES (918, 913, '320305', '贾汪区', 3);
INSERT INTO `m_area` VALUES (919, 913, '320311', '泉山区', 3);
INSERT INTO `m_area` VALUES (920, 913, '320321', '丰　县', 3);
INSERT INTO `m_area` VALUES (921, 913, '320322', '沛　县', 3);
INSERT INTO `m_area` VALUES (922, 913, '320323', '铜山县', 3);
INSERT INTO `m_area` VALUES (923, 913, '320324', '睢宁县', 3);
INSERT INTO `m_area` VALUES (924, 913, '320381', '新沂市', 3);
INSERT INTO `m_area` VALUES (925, 913, '320382', '邳州市', 3);
INSERT INTO `m_area` VALUES (926, 887, '320400', '常州市', 2);
INSERT INTO `m_area` VALUES (927, 926, '320401', '市辖区', 3);
INSERT INTO `m_area` VALUES (928, 926, '320402', '天宁区', 3);
INSERT INTO `m_area` VALUES (929, 926, '320404', '钟楼区', 3);
INSERT INTO `m_area` VALUES (930, 926, '320405', '戚墅堰区', 3);
INSERT INTO `m_area` VALUES (931, 926, '320411', '新北区', 3);
INSERT INTO `m_area` VALUES (932, 926, '320412', '武进区', 3);
INSERT INTO `m_area` VALUES (933, 926, '320481', '溧阳市', 3);
INSERT INTO `m_area` VALUES (934, 926, '320482', '金坛市', 3);
INSERT INTO `m_area` VALUES (935, 887, '320500', '苏州市', 2);
INSERT INTO `m_area` VALUES (936, 935, '320501', '市辖区', 3);
INSERT INTO `m_area` VALUES (937, 935, '320502', '沧浪区', 3);
INSERT INTO `m_area` VALUES (938, 935, '320503', '平江区', 3);
INSERT INTO `m_area` VALUES (939, 935, '320504', '金阊区', 3);
INSERT INTO `m_area` VALUES (940, 935, '320505', '虎丘区', 3);
INSERT INTO `m_area` VALUES (941, 935, '320506', '吴中区', 3);
INSERT INTO `m_area` VALUES (942, 935, '320507', '相城区', 3);
INSERT INTO `m_area` VALUES (943, 935, '320581', '常熟市', 3);
INSERT INTO `m_area` VALUES (944, 935, '320582', '张家港市', 3);
INSERT INTO `m_area` VALUES (945, 935, '320583', '昆山市', 3);
INSERT INTO `m_area` VALUES (946, 935, '320584', '吴江市', 3);
INSERT INTO `m_area` VALUES (947, 935, '320585', '太仓市', 3);
INSERT INTO `m_area` VALUES (948, 887, '320600', '南通市', 2);
INSERT INTO `m_area` VALUES (949, 948, '320601', '市辖区', 3);
INSERT INTO `m_area` VALUES (950, 948, '320602', '崇川区', 3);
INSERT INTO `m_area` VALUES (951, 948, '320611', '港闸区', 3);
INSERT INTO `m_area` VALUES (952, 948, '320621', '海安县', 3);
INSERT INTO `m_area` VALUES (953, 948, '320623', '如东县', 3);
INSERT INTO `m_area` VALUES (954, 948, '320681', '启东市', 3);
INSERT INTO `m_area` VALUES (955, 948, '320682', '如皋市', 3);
INSERT INTO `m_area` VALUES (956, 948, '320683', '通州市', 3);
INSERT INTO `m_area` VALUES (957, 948, '320684', '海门市', 3);
INSERT INTO `m_area` VALUES (958, 887, '320700', '连云港市', 2);
INSERT INTO `m_area` VALUES (959, 958, '320701', '市辖区', 3);
INSERT INTO `m_area` VALUES (960, 958, '320703', '连云区', 3);
INSERT INTO `m_area` VALUES (961, 958, '320705', '新浦区', 3);
INSERT INTO `m_area` VALUES (962, 958, '320706', '海州区', 3);
INSERT INTO `m_area` VALUES (963, 958, '320721', '赣榆县', 3);
INSERT INTO `m_area` VALUES (964, 958, '320722', '东海县', 3);
INSERT INTO `m_area` VALUES (965, 958, '320723', '灌云县', 3);
INSERT INTO `m_area` VALUES (966, 958, '320724', '灌南县', 3);
INSERT INTO `m_area` VALUES (967, 887, '320800', '淮安市', 2);
INSERT INTO `m_area` VALUES (968, 967, '320801', '市辖区', 3);
INSERT INTO `m_area` VALUES (969, 967, '320802', '清河区', 3);
INSERT INTO `m_area` VALUES (970, 967, '320803', '楚州区', 3);
INSERT INTO `m_area` VALUES (971, 967, '320804', '淮阴区', 3);
INSERT INTO `m_area` VALUES (972, 967, '320811', '清浦区', 3);
INSERT INTO `m_area` VALUES (973, 967, '320826', '涟水县', 3);
INSERT INTO `m_area` VALUES (974, 967, '320829', '洪泽县', 3);
INSERT INTO `m_area` VALUES (975, 967, '320830', '盱眙县', 3);
INSERT INTO `m_area` VALUES (976, 967, '320831', '金湖县', 3);
INSERT INTO `m_area` VALUES (977, 887, '320900', '盐城市', 2);
INSERT INTO `m_area` VALUES (978, 977, '320901', '市辖区', 3);
INSERT INTO `m_area` VALUES (979, 977, '320902', '亭湖区', 3);
INSERT INTO `m_area` VALUES (980, 977, '320903', '盐都区', 3);
INSERT INTO `m_area` VALUES (981, 977, '320921', '响水县', 3);
INSERT INTO `m_area` VALUES (982, 977, '320922', '滨海县', 3);
INSERT INTO `m_area` VALUES (983, 977, '320923', '阜宁县', 3);
INSERT INTO `m_area` VALUES (984, 977, '320924', '射阳县', 3);
INSERT INTO `m_area` VALUES (985, 977, '320925', '建湖县', 3);
INSERT INTO `m_area` VALUES (986, 977, '320981', '东台市', 3);
INSERT INTO `m_area` VALUES (987, 977, '320982', '大丰市', 3);
INSERT INTO `m_area` VALUES (988, 887, '321000', '扬州市', 2);
INSERT INTO `m_area` VALUES (989, 988, '321001', '市辖区', 3);
INSERT INTO `m_area` VALUES (990, 988, '321002', '广陵区', 3);
INSERT INTO `m_area` VALUES (991, 988, '321003', '邗江区', 3);
INSERT INTO `m_area` VALUES (992, 988, '321011', '郊　区', 3);
INSERT INTO `m_area` VALUES (993, 988, '321023', '宝应县', 3);
INSERT INTO `m_area` VALUES (994, 988, '321081', '仪征市', 3);
INSERT INTO `m_area` VALUES (995, 988, '321084', '高邮市', 3);
INSERT INTO `m_area` VALUES (996, 988, '321088', '江都市', 3);
INSERT INTO `m_area` VALUES (997, 887, '321100', '镇江市', 2);
INSERT INTO `m_area` VALUES (998, 997, '321101', '市辖区', 3);
INSERT INTO `m_area` VALUES (999, 997, '321102', '京口区', 3);
INSERT INTO `m_area` VALUES (1000, 997, '321111', '润州区', 3);
INSERT INTO `m_area` VALUES (1001, 997, '321112', '丹徒区', 3);
INSERT INTO `m_area` VALUES (1002, 997, '321181', '丹阳市', 3);
INSERT INTO `m_area` VALUES (1003, 997, '321182', '扬中市', 3);
INSERT INTO `m_area` VALUES (1004, 997, '321183', '句容市', 3);
INSERT INTO `m_area` VALUES (1005, 887, '321200', '泰州市', 2);
INSERT INTO `m_area` VALUES (1006, 1005, '321201', '市辖区', 3);
INSERT INTO `m_area` VALUES (1007, 1005, '321202', '海陵区', 3);
INSERT INTO `m_area` VALUES (1008, 1005, '321203', '高港区', 3);
INSERT INTO `m_area` VALUES (1009, 1005, '321281', '兴化市', 3);
INSERT INTO `m_area` VALUES (1010, 1005, '321282', '靖江市', 3);
INSERT INTO `m_area` VALUES (1011, 1005, '321283', '泰兴市', 3);
INSERT INTO `m_area` VALUES (1012, 1005, '321284', '姜堰市', 3);
INSERT INTO `m_area` VALUES (1013, 887, '321300', '宿迁市', 2);
INSERT INTO `m_area` VALUES (1014, 1013, '321301', '市辖区', 3);
INSERT INTO `m_area` VALUES (1015, 1013, '321302', '宿城区', 3);
INSERT INTO `m_area` VALUES (1016, 1013, '321311', '宿豫区', 3);
INSERT INTO `m_area` VALUES (1017, 1013, '321322', '沭阳县', 3);
INSERT INTO `m_area` VALUES (1018, 1013, '321323', '泗阳县', 3);
INSERT INTO `m_area` VALUES (1019, 1013, '321324', '泗洪县', 3);
INSERT INTO `m_area` VALUES (1020, 0, '330000', '浙江省', 1);
INSERT INTO `m_area` VALUES (1021, 1020, '330100', '杭州市', 2);
INSERT INTO `m_area` VALUES (1022, 1021, '330101', '市辖区', 3);
INSERT INTO `m_area` VALUES (1023, 1021, '330102', '上城区', 3);
INSERT INTO `m_area` VALUES (1024, 1021, '330103', '下城区', 3);
INSERT INTO `m_area` VALUES (1025, 1021, '330104', '江干区', 3);
INSERT INTO `m_area` VALUES (1026, 1021, '330105', '拱墅区', 3);
INSERT INTO `m_area` VALUES (1027, 1021, '330106', '西湖区', 3);
INSERT INTO `m_area` VALUES (1028, 1021, '330108', '滨江区', 3);
INSERT INTO `m_area` VALUES (1029, 1021, '330109', '萧山区', 3);
INSERT INTO `m_area` VALUES (1030, 1021, '330110', '余杭区', 3);
INSERT INTO `m_area` VALUES (1031, 1021, '330122', '桐庐县', 3);
INSERT INTO `m_area` VALUES (1032, 1021, '330127', '淳安县', 3);
INSERT INTO `m_area` VALUES (1033, 1021, '330182', '建德市', 3);
INSERT INTO `m_area` VALUES (1034, 1021, '330183', '富阳市', 3);
INSERT INTO `m_area` VALUES (1035, 1021, '330185', '临安市', 3);
INSERT INTO `m_area` VALUES (1036, 1020, '330200', '宁波市', 2);
INSERT INTO `m_area` VALUES (1037, 1036, '330201', '市辖区', 3);
INSERT INTO `m_area` VALUES (1038, 1036, '330203', '海曙区', 3);
INSERT INTO `m_area` VALUES (1039, 1036, '330204', '江东区', 3);
INSERT INTO `m_area` VALUES (1040, 1036, '330205', '江北区', 3);
INSERT INTO `m_area` VALUES (1041, 1036, '330206', '北仑区', 3);
INSERT INTO `m_area` VALUES (1042, 1036, '330211', '镇海区', 3);
INSERT INTO `m_area` VALUES (1043, 1036, '330212', '鄞州区', 3);
INSERT INTO `m_area` VALUES (1044, 1036, '330225', '象山县', 3);
INSERT INTO `m_area` VALUES (1045, 1036, '330226', '宁海县', 3);
INSERT INTO `m_area` VALUES (1046, 1036, '330281', '余姚市', 3);
INSERT INTO `m_area` VALUES (1047, 1036, '330282', '慈溪市', 3);
INSERT INTO `m_area` VALUES (1048, 1036, '330283', '奉化市', 3);
INSERT INTO `m_area` VALUES (1049, 1020, '330300', '温州市', 2);
INSERT INTO `m_area` VALUES (1050, 1049, '330301', '市辖区', 3);
INSERT INTO `m_area` VALUES (1051, 1049, '330302', '鹿城区', 3);
INSERT INTO `m_area` VALUES (1052, 1049, '330303', '龙湾区', 3);
INSERT INTO `m_area` VALUES (1053, 1049, '330304', '瓯海区', 3);
INSERT INTO `m_area` VALUES (1054, 1049, '330322', '洞头县', 3);
INSERT INTO `m_area` VALUES (1055, 1049, '330324', '永嘉县', 3);
INSERT INTO `m_area` VALUES (1056, 1049, '330326', '平阳县', 3);
INSERT INTO `m_area` VALUES (1057, 1049, '330327', '苍南县', 3);
INSERT INTO `m_area` VALUES (1058, 1049, '330328', '文成县', 3);
INSERT INTO `m_area` VALUES (1059, 1049, '330329', '泰顺县', 3);
INSERT INTO `m_area` VALUES (1060, 1049, '330381', '瑞安市', 3);
INSERT INTO `m_area` VALUES (1061, 1049, '330382', '乐清市', 3);
INSERT INTO `m_area` VALUES (1062, 1020, '330400', '嘉兴市', 2);
INSERT INTO `m_area` VALUES (1063, 1062, '330401', '市辖区', 3);
INSERT INTO `m_area` VALUES (1064, 1062, '330402', '秀城区', 3);
INSERT INTO `m_area` VALUES (1065, 1062, '330411', '秀洲区', 3);
INSERT INTO `m_area` VALUES (1066, 1062, '330421', '嘉善县', 3);
INSERT INTO `m_area` VALUES (1067, 1062, '330424', '海盐县', 3);
INSERT INTO `m_area` VALUES (1068, 1062, '330481', '海宁市', 3);
INSERT INTO `m_area` VALUES (1069, 1062, '330482', '平湖市', 3);
INSERT INTO `m_area` VALUES (1070, 1062, '330483', '桐乡市', 3);
INSERT INTO `m_area` VALUES (1071, 1020, '330500', '湖州市', 2);
INSERT INTO `m_area` VALUES (1072, 1071, '330501', '市辖区', 3);
INSERT INTO `m_area` VALUES (1073, 1071, '330502', '吴兴区', 3);
INSERT INTO `m_area` VALUES (1074, 1071, '330503', '南浔区', 3);
INSERT INTO `m_area` VALUES (1075, 1071, '330521', '德清县', 3);
INSERT INTO `m_area` VALUES (1076, 1071, '330522', '长兴县', 3);
INSERT INTO `m_area` VALUES (1077, 1071, '330523', '安吉县', 3);
INSERT INTO `m_area` VALUES (1078, 1020, '330600', '绍兴市', 2);
INSERT INTO `m_area` VALUES (1079, 1078, '330601', '市辖区', 3);
INSERT INTO `m_area` VALUES (1080, 1078, '330602', '越城区', 3);
INSERT INTO `m_area` VALUES (1081, 1078, '330621', '绍兴县', 3);
INSERT INTO `m_area` VALUES (1082, 1078, '330624', '新昌县', 3);
INSERT INTO `m_area` VALUES (1083, 1078, '330681', '诸暨市', 3);
INSERT INTO `m_area` VALUES (1084, 1078, '330682', '上虞市', 3);
INSERT INTO `m_area` VALUES (1085, 1078, '330683', '嵊州市', 3);
INSERT INTO `m_area` VALUES (1086, 1020, '330700', '金华市', 2);
INSERT INTO `m_area` VALUES (1087, 1086, '330701', '市辖区', 3);
INSERT INTO `m_area` VALUES (1088, 1086, '330702', '婺城区', 3);
INSERT INTO `m_area` VALUES (1089, 1086, '330703', '金东区', 3);
INSERT INTO `m_area` VALUES (1090, 1086, '330723', '武义县', 3);
INSERT INTO `m_area` VALUES (1091, 1086, '330726', '浦江县', 3);
INSERT INTO `m_area` VALUES (1092, 1086, '330727', '磐安县', 3);
INSERT INTO `m_area` VALUES (1093, 1086, '330781', '兰溪市', 3);
INSERT INTO `m_area` VALUES (1094, 1086, '330782', '义乌市', 3);
INSERT INTO `m_area` VALUES (1095, 1086, '330783', '东阳市', 3);
INSERT INTO `m_area` VALUES (1096, 1086, '330784', '永康市', 3);
INSERT INTO `m_area` VALUES (1097, 1020, '330800', '衢州市', 2);
INSERT INTO `m_area` VALUES (1098, 1097, '330801', '市辖区', 3);
INSERT INTO `m_area` VALUES (1099, 1097, '330802', '柯城区', 3);
INSERT INTO `m_area` VALUES (1100, 1097, '330803', '衢江区', 3);
INSERT INTO `m_area` VALUES (1101, 1097, '330822', '常山县', 3);
INSERT INTO `m_area` VALUES (1102, 1097, '330824', '开化县', 3);
INSERT INTO `m_area` VALUES (1103, 1097, '330825', '龙游县', 3);
INSERT INTO `m_area` VALUES (1104, 1097, '330881', '江山市', 3);
INSERT INTO `m_area` VALUES (1105, 1020, '330900', '舟山市', 2);
INSERT INTO `m_area` VALUES (1106, 1105, '330901', '市辖区', 3);
INSERT INTO `m_area` VALUES (1107, 1105, '330902', '定海区', 3);
INSERT INTO `m_area` VALUES (1108, 1105, '330903', '普陀区', 3);
INSERT INTO `m_area` VALUES (1109, 1105, '330921', '岱山县', 3);
INSERT INTO `m_area` VALUES (1110, 1105, '330922', '嵊泗县', 3);
INSERT INTO `m_area` VALUES (1111, 1020, '331000', '台州市', 2);
INSERT INTO `m_area` VALUES (1112, 1111, '331001', '市辖区', 3);
INSERT INTO `m_area` VALUES (1113, 1111, '331002', '椒江区', 3);
INSERT INTO `m_area` VALUES (1114, 1111, '331003', '黄岩区', 3);
INSERT INTO `m_area` VALUES (1115, 1111, '331004', '路桥区', 3);
INSERT INTO `m_area` VALUES (1116, 1111, '331021', '玉环县', 3);
INSERT INTO `m_area` VALUES (1117, 1111, '331022', '三门县', 3);
INSERT INTO `m_area` VALUES (1118, 1111, '331023', '天台县', 3);
INSERT INTO `m_area` VALUES (1119, 1111, '331024', '仙居县', 3);
INSERT INTO `m_area` VALUES (1120, 1111, '331081', '温岭市', 3);
INSERT INTO `m_area` VALUES (1121, 1111, '331082', '临海市', 3);
INSERT INTO `m_area` VALUES (1122, 1020, '331100', '丽水市', 2);
INSERT INTO `m_area` VALUES (1123, 1122, '331101', '市辖区', 3);
INSERT INTO `m_area` VALUES (1124, 1122, '331102', '莲都区', 3);
INSERT INTO `m_area` VALUES (1125, 1122, '331121', '青田县', 3);
INSERT INTO `m_area` VALUES (1126, 1122, '331122', '缙云县', 3);
INSERT INTO `m_area` VALUES (1127, 1122, '331123', '遂昌县', 3);
INSERT INTO `m_area` VALUES (1128, 1122, '331124', '松阳县', 3);
INSERT INTO `m_area` VALUES (1129, 1122, '331125', '云和县', 3);
INSERT INTO `m_area` VALUES (1130, 1122, '331126', '庆元县', 3);
INSERT INTO `m_area` VALUES (1131, 1122, '331127', '景宁畲族自治县', 3);
INSERT INTO `m_area` VALUES (1132, 1122, '331181', '龙泉市', 3);
INSERT INTO `m_area` VALUES (1133, 0, '340000', '安徽省', 1);
INSERT INTO `m_area` VALUES (1134, 1133, '340100', '合肥市', 2);
INSERT INTO `m_area` VALUES (1135, 1134, '340101', '市辖区', 3);
INSERT INTO `m_area` VALUES (1136, 1134, '340102', '瑶海区', 3);
INSERT INTO `m_area` VALUES (1137, 1134, '340103', '庐阳区', 3);
INSERT INTO `m_area` VALUES (1138, 1134, '340104', '蜀山区', 3);
INSERT INTO `m_area` VALUES (1139, 1134, '340111', '包河区', 3);
INSERT INTO `m_area` VALUES (1140, 1134, '340121', '长丰县', 3);
INSERT INTO `m_area` VALUES (1141, 1134, '340122', '肥东县', 3);
INSERT INTO `m_area` VALUES (1142, 1134, '340123', '肥西县', 3);
INSERT INTO `m_area` VALUES (1143, 1133, '340200', '芜湖市', 2);
INSERT INTO `m_area` VALUES (1144, 1143, '340201', '市辖区', 3);
INSERT INTO `m_area` VALUES (1145, 1143, '340202', '镜湖区', 3);
INSERT INTO `m_area` VALUES (1146, 1143, '340203', '马塘区', 3);
INSERT INTO `m_area` VALUES (1147, 1143, '340204', '新芜区', 3);
INSERT INTO `m_area` VALUES (1148, 1143, '340207', '鸠江区', 3);
INSERT INTO `m_area` VALUES (1149, 1143, '340221', '芜湖县', 3);
INSERT INTO `m_area` VALUES (1150, 1143, '340222', '繁昌县', 3);
INSERT INTO `m_area` VALUES (1151, 1143, '340223', '南陵县', 3);
INSERT INTO `m_area` VALUES (1152, 1133, '340300', '蚌埠市', 2);
INSERT INTO `m_area` VALUES (1153, 1152, '340301', '市辖区', 3);
INSERT INTO `m_area` VALUES (1154, 1152, '340302', '龙子湖区', 3);
INSERT INTO `m_area` VALUES (1155, 1152, '340303', '蚌山区', 3);
INSERT INTO `m_area` VALUES (1156, 1152, '340304', '禹会区', 3);
INSERT INTO `m_area` VALUES (1157, 1152, '340311', '淮上区', 3);
INSERT INTO `m_area` VALUES (1158, 1152, '340321', '怀远县', 3);
INSERT INTO `m_area` VALUES (1159, 1152, '340322', '五河县', 3);
INSERT INTO `m_area` VALUES (1160, 1152, '340323', '固镇县', 3);
INSERT INTO `m_area` VALUES (1161, 1133, '340400', '淮南市', 2);
INSERT INTO `m_area` VALUES (1162, 1161, '340401', '市辖区', 3);
INSERT INTO `m_area` VALUES (1163, 1161, '340402', '大通区', 3);
INSERT INTO `m_area` VALUES (1164, 1161, '340403', '田家庵区', 3);
INSERT INTO `m_area` VALUES (1165, 1161, '340404', '谢家集区', 3);
INSERT INTO `m_area` VALUES (1166, 1161, '340405', '八公山区', 3);
INSERT INTO `m_area` VALUES (1167, 1161, '340406', '潘集区', 3);
INSERT INTO `m_area` VALUES (1168, 1161, '340421', '凤台县', 3);
INSERT INTO `m_area` VALUES (1169, 1133, '340500', '马鞍山市', 2);
INSERT INTO `m_area` VALUES (1170, 1169, '340501', '市辖区', 3);
INSERT INTO `m_area` VALUES (1171, 1169, '340502', '金家庄区', 3);
INSERT INTO `m_area` VALUES (1172, 1169, '340503', '花山区', 3);
INSERT INTO `m_area` VALUES (1173, 1169, '340504', '雨山区', 3);
INSERT INTO `m_area` VALUES (1174, 1169, '340521', '当涂县', 3);
INSERT INTO `m_area` VALUES (1175, 1133, '340600', '淮北市', 2);
INSERT INTO `m_area` VALUES (1176, 1175, '340601', '市辖区', 3);
INSERT INTO `m_area` VALUES (1177, 1175, '340602', '杜集区', 3);
INSERT INTO `m_area` VALUES (1178, 1175, '340603', '相山区', 3);
INSERT INTO `m_area` VALUES (1179, 1175, '340604', '烈山区', 3);
INSERT INTO `m_area` VALUES (1180, 1175, '340621', '濉溪县', 3);
INSERT INTO `m_area` VALUES (1181, 1133, '340700', '铜陵市', 2);
INSERT INTO `m_area` VALUES (1182, 1181, '340701', '市辖区', 3);
INSERT INTO `m_area` VALUES (1183, 1181, '340702', '铜官山区', 3);
INSERT INTO `m_area` VALUES (1184, 1181, '340703', '狮子山区', 3);
INSERT INTO `m_area` VALUES (1185, 1181, '340711', '郊　区', 3);
INSERT INTO `m_area` VALUES (1186, 1181, '340721', '铜陵县', 3);
INSERT INTO `m_area` VALUES (1187, 1133, '340800', '安庆市', 2);
INSERT INTO `m_area` VALUES (1188, 1187, '340801', '市辖区', 3);
INSERT INTO `m_area` VALUES (1189, 1187, '340802', '迎江区', 3);
INSERT INTO `m_area` VALUES (1190, 1187, '340803', '大观区', 3);
INSERT INTO `m_area` VALUES (1191, 1187, '340811', '郊　区', 3);
INSERT INTO `m_area` VALUES (1192, 1187, '340822', '怀宁县', 3);
INSERT INTO `m_area` VALUES (1193, 1187, '340823', '枞阳县', 3);
INSERT INTO `m_area` VALUES (1194, 1187, '340824', '潜山县', 3);
INSERT INTO `m_area` VALUES (1195, 1187, '340825', '太湖县', 3);
INSERT INTO `m_area` VALUES (1196, 1187, '340826', '宿松县', 3);
INSERT INTO `m_area` VALUES (1197, 1187, '340827', '望江县', 3);
INSERT INTO `m_area` VALUES (1198, 1187, '340828', '岳西县', 3);
INSERT INTO `m_area` VALUES (1199, 1187, '340881', '桐城市', 3);
INSERT INTO `m_area` VALUES (1200, 1133, '341000', '黄山市', 2);
INSERT INTO `m_area` VALUES (1201, 1200, '341001', '市辖区', 3);
INSERT INTO `m_area` VALUES (1202, 1200, '341002', '屯溪区', 3);
INSERT INTO `m_area` VALUES (1203, 1200, '341003', '黄山区', 3);
INSERT INTO `m_area` VALUES (1204, 1200, '341004', '徽州区', 3);
INSERT INTO `m_area` VALUES (1205, 1200, '341021', '歙　县', 3);
INSERT INTO `m_area` VALUES (1206, 1200, '341022', '休宁县', 3);
INSERT INTO `m_area` VALUES (1207, 1200, '341023', '黟　县', 3);
INSERT INTO `m_area` VALUES (1208, 1200, '341024', '祁门县', 3);
INSERT INTO `m_area` VALUES (1209, 1133, '341100', '滁州市', 2);
INSERT INTO `m_area` VALUES (1210, 1209, '341101', '市辖区', 3);
INSERT INTO `m_area` VALUES (1211, 1209, '341102', '琅琊区', 3);
INSERT INTO `m_area` VALUES (1212, 1209, '341103', '南谯区', 3);
INSERT INTO `m_area` VALUES (1213, 1209, '341122', '来安县', 3);
INSERT INTO `m_area` VALUES (1214, 1209, '341124', '全椒县', 3);
INSERT INTO `m_area` VALUES (1215, 1209, '341125', '定远县', 3);
INSERT INTO `m_area` VALUES (1216, 1209, '341126', '凤阳县', 3);
INSERT INTO `m_area` VALUES (1217, 1209, '341181', '天长市', 3);
INSERT INTO `m_area` VALUES (1218, 1209, '341182', '明光市', 3);
INSERT INTO `m_area` VALUES (1219, 1133, '341200', '阜阳市', 2);
INSERT INTO `m_area` VALUES (1220, 1219, '341201', '市辖区', 3);
INSERT INTO `m_area` VALUES (1221, 1219, '341202', '颍州区', 3);
INSERT INTO `m_area` VALUES (1222, 1219, '341203', '颍东区', 3);
INSERT INTO `m_area` VALUES (1223, 1219, '341204', '颍泉区', 3);
INSERT INTO `m_area` VALUES (1224, 1219, '341221', '临泉县', 3);
INSERT INTO `m_area` VALUES (1225, 1219, '341222', '太和县', 3);
INSERT INTO `m_area` VALUES (1226, 1219, '341225', '阜南县', 3);
INSERT INTO `m_area` VALUES (1227, 1219, '341226', '颍上县', 3);
INSERT INTO `m_area` VALUES (1228, 1219, '341282', '界首市', 3);
INSERT INTO `m_area` VALUES (1229, 1133, '341300', '宿州市', 2);
INSERT INTO `m_area` VALUES (1230, 1229, '341301', '市辖区', 3);
INSERT INTO `m_area` VALUES (1231, 1229, '341302', '墉桥区', 3);
INSERT INTO `m_area` VALUES (1232, 1229, '341321', '砀山县', 3);
INSERT INTO `m_area` VALUES (1233, 1229, '341322', '萧　县', 3);
INSERT INTO `m_area` VALUES (1234, 1229, '341323', '灵璧县', 3);
INSERT INTO `m_area` VALUES (1235, 1229, '341324', '泗　县', 3);
INSERT INTO `m_area` VALUES (1236, 1133, '341400', '巢湖市', 2);
INSERT INTO `m_area` VALUES (1237, 1236, '341401', '市辖区', 3);
INSERT INTO `m_area` VALUES (1238, 1236, '341402', '居巢区', 3);
INSERT INTO `m_area` VALUES (1239, 1236, '341421', '庐江县', 3);
INSERT INTO `m_area` VALUES (1240, 1236, '341422', '无为县', 3);
INSERT INTO `m_area` VALUES (1241, 1236, '341423', '含山县', 3);
INSERT INTO `m_area` VALUES (1242, 1236, '341424', '和　县', 3);
INSERT INTO `m_area` VALUES (1243, 1133, '341500', '六安市', 2);
INSERT INTO `m_area` VALUES (1244, 1243, '341501', '市辖区', 3);
INSERT INTO `m_area` VALUES (1245, 1243, '341502', '金安区', 3);
INSERT INTO `m_area` VALUES (1246, 1243, '341503', '裕安区', 3);
INSERT INTO `m_area` VALUES (1247, 1243, '341521', '寿　县', 3);
INSERT INTO `m_area` VALUES (1248, 1243, '341522', '霍邱县', 3);
INSERT INTO `m_area` VALUES (1249, 1243, '341523', '舒城县', 3);
INSERT INTO `m_area` VALUES (1250, 1243, '341524', '金寨县', 3);
INSERT INTO `m_area` VALUES (1251, 1243, '341525', '霍山县', 3);
INSERT INTO `m_area` VALUES (1252, 1133, '341600', '亳州市', 2);
INSERT INTO `m_area` VALUES (1253, 1252, '341601', '市辖区', 3);
INSERT INTO `m_area` VALUES (1254, 1252, '341602', '谯城区', 3);
INSERT INTO `m_area` VALUES (1255, 1252, '341621', '涡阳县', 3);
INSERT INTO `m_area` VALUES (1256, 1252, '341622', '蒙城县', 3);
INSERT INTO `m_area` VALUES (1257, 1252, '341623', '利辛县', 3);
INSERT INTO `m_area` VALUES (1258, 1133, '341700', '池州市', 2);
INSERT INTO `m_area` VALUES (1259, 1258, '341701', '市辖区', 3);
INSERT INTO `m_area` VALUES (1260, 1258, '341702', '贵池区', 3);
INSERT INTO `m_area` VALUES (1261, 1258, '341721', '东至县', 3);
INSERT INTO `m_area` VALUES (1262, 1258, '341722', '石台县', 3);
INSERT INTO `m_area` VALUES (1263, 1258, '341723', '青阳县', 3);
INSERT INTO `m_area` VALUES (1264, 1133, '341800', '宣城市', 2);
INSERT INTO `m_area` VALUES (1265, 1264, '341801', '市辖区', 3);
INSERT INTO `m_area` VALUES (1266, 1264, '341802', '宣州区', 3);
INSERT INTO `m_area` VALUES (1267, 1264, '341821', '郎溪县', 3);
INSERT INTO `m_area` VALUES (1268, 1264, '341822', '广德县', 3);
INSERT INTO `m_area` VALUES (1269, 1264, '341823', '泾　县', 3);
INSERT INTO `m_area` VALUES (1270, 1264, '341824', '绩溪县', 3);
INSERT INTO `m_area` VALUES (1271, 1264, '341825', '旌德县', 3);
INSERT INTO `m_area` VALUES (1272, 1264, '341881', '宁国市', 3);
INSERT INTO `m_area` VALUES (1273, 0, '350000', '福建省', 1);
INSERT INTO `m_area` VALUES (1274, 1273, '350100', '福州市', 2);
INSERT INTO `m_area` VALUES (1275, 1274, '350101', '市辖区', 3);
INSERT INTO `m_area` VALUES (1276, 1274, '350102', '鼓楼区', 3);
INSERT INTO `m_area` VALUES (1277, 1274, '350103', '台江区', 3);
INSERT INTO `m_area` VALUES (1278, 1274, '350104', '仓山区', 3);
INSERT INTO `m_area` VALUES (1279, 1274, '350105', '马尾区', 3);
INSERT INTO `m_area` VALUES (1280, 1274, '350111', '晋安区', 3);
INSERT INTO `m_area` VALUES (1281, 1274, '350121', '闽侯县', 3);
INSERT INTO `m_area` VALUES (1282, 1274, '350122', '连江县', 3);
INSERT INTO `m_area` VALUES (1283, 1274, '350123', '罗源县', 3);
INSERT INTO `m_area` VALUES (1284, 1274, '350124', '闽清县', 3);
INSERT INTO `m_area` VALUES (1285, 1274, '350125', '永泰县', 3);
INSERT INTO `m_area` VALUES (1286, 1274, '350128', '平潭县', 3);
INSERT INTO `m_area` VALUES (1287, 1274, '350181', '福清市', 3);
INSERT INTO `m_area` VALUES (1288, 1274, '350182', '长乐市', 3);
INSERT INTO `m_area` VALUES (1289, 1273, '350200', '厦门市', 2);
INSERT INTO `m_area` VALUES (1290, 1289, '350201', '市辖区', 3);
INSERT INTO `m_area` VALUES (1291, 1289, '350203', '思明区', 3);
INSERT INTO `m_area` VALUES (1292, 1289, '350205', '海沧区', 3);
INSERT INTO `m_area` VALUES (1293, 1289, '350206', '湖里区', 3);
INSERT INTO `m_area` VALUES (1294, 1289, '350211', '集美区', 3);
INSERT INTO `m_area` VALUES (1295, 1289, '350212', '同安区', 3);
INSERT INTO `m_area` VALUES (1296, 1289, '350213', '翔安区', 3);
INSERT INTO `m_area` VALUES (1297, 1273, '350300', '莆田市', 2);
INSERT INTO `m_area` VALUES (1298, 1297, '350301', '市辖区', 3);
INSERT INTO `m_area` VALUES (1299, 1297, '350302', '城厢区', 3);
INSERT INTO `m_area` VALUES (1300, 1297, '350303', '涵江区', 3);
INSERT INTO `m_area` VALUES (1301, 1297, '350304', '荔城区', 3);
INSERT INTO `m_area` VALUES (1302, 1297, '350305', '秀屿区', 3);
INSERT INTO `m_area` VALUES (1303, 1297, '350322', '仙游县', 3);
INSERT INTO `m_area` VALUES (1304, 1273, '350400', '三明市', 2);
INSERT INTO `m_area` VALUES (1305, 1304, '350401', '市辖区', 3);
INSERT INTO `m_area` VALUES (1306, 1304, '350402', '梅列区', 3);
INSERT INTO `m_area` VALUES (1307, 1304, '350403', '三元区', 3);
INSERT INTO `m_area` VALUES (1308, 1304, '350421', '明溪县', 3);
INSERT INTO `m_area` VALUES (1309, 1304, '350423', '清流县', 3);
INSERT INTO `m_area` VALUES (1310, 1304, '350424', '宁化县', 3);
INSERT INTO `m_area` VALUES (1311, 1304, '350425', '大田县', 3);
INSERT INTO `m_area` VALUES (1312, 1304, '350426', '尤溪县', 3);
INSERT INTO `m_area` VALUES (1313, 1304, '350427', '沙　县', 3);
INSERT INTO `m_area` VALUES (1314, 1304, '350428', '将乐县', 3);
INSERT INTO `m_area` VALUES (1315, 1304, '350429', '泰宁县', 3);
INSERT INTO `m_area` VALUES (1316, 1304, '350430', '建宁县', 3);
INSERT INTO `m_area` VALUES (1317, 1304, '350481', '永安市', 3);
INSERT INTO `m_area` VALUES (1318, 1273, '350500', '泉州市', 2);
INSERT INTO `m_area` VALUES (1319, 1318, '350501', '市辖区', 3);
INSERT INTO `m_area` VALUES (1320, 1318, '350502', '鲤城区', 3);
INSERT INTO `m_area` VALUES (1321, 1318, '350503', '丰泽区', 3);
INSERT INTO `m_area` VALUES (1322, 1318, '350504', '洛江区', 3);
INSERT INTO `m_area` VALUES (1323, 1318, '350505', '泉港区', 3);
INSERT INTO `m_area` VALUES (1324, 1318, '350521', '惠安县', 3);
INSERT INTO `m_area` VALUES (1325, 1318, '350524', '安溪县', 3);
INSERT INTO `m_area` VALUES (1326, 1318, '350525', '永春县', 3);
INSERT INTO `m_area` VALUES (1327, 1318, '350526', '德化县', 3);
INSERT INTO `m_area` VALUES (1328, 1318, '350527', '金门县', 3);
INSERT INTO `m_area` VALUES (1329, 1318, '350581', '石狮市', 3);
INSERT INTO `m_area` VALUES (1330, 1318, '350582', '晋江市', 3);
INSERT INTO `m_area` VALUES (1331, 1318, '350583', '南安市', 3);
INSERT INTO `m_area` VALUES (1332, 1273, '350600', '漳州市', 2);
INSERT INTO `m_area` VALUES (1333, 1332, '350601', '市辖区', 3);
INSERT INTO `m_area` VALUES (1334, 1332, '350602', '芗城区', 3);
INSERT INTO `m_area` VALUES (1335, 1332, '350603', '龙文区', 3);
INSERT INTO `m_area` VALUES (1336, 1332, '350622', '云霄县', 3);
INSERT INTO `m_area` VALUES (1337, 1332, '350623', '漳浦县', 3);
INSERT INTO `m_area` VALUES (1338, 1332, '350624', '诏安县', 3);
INSERT INTO `m_area` VALUES (1339, 1332, '350625', '长泰县', 3);
INSERT INTO `m_area` VALUES (1340, 1332, '350626', '东山县', 3);
INSERT INTO `m_area` VALUES (1341, 1332, '350627', '南靖县', 3);
INSERT INTO `m_area` VALUES (1342, 1332, '350628', '平和县', 3);
INSERT INTO `m_area` VALUES (1343, 1332, '350629', '华安县', 3);
INSERT INTO `m_area` VALUES (1344, 1332, '350681', '龙海市', 3);
INSERT INTO `m_area` VALUES (1345, 1273, '350700', '南平市', 2);
INSERT INTO `m_area` VALUES (1346, 1345, '350701', '市辖区', 3);
INSERT INTO `m_area` VALUES (1347, 1345, '350702', '延平区', 3);
INSERT INTO `m_area` VALUES (1348, 1345, '350721', '顺昌县', 3);
INSERT INTO `m_area` VALUES (1349, 1345, '350722', '浦城县', 3);
INSERT INTO `m_area` VALUES (1350, 1345, '350723', '光泽县', 3);
INSERT INTO `m_area` VALUES (1351, 1345, '350724', '松溪县', 3);
INSERT INTO `m_area` VALUES (1352, 1345, '350725', '政和县', 3);
INSERT INTO `m_area` VALUES (1353, 1345, '350781', '邵武市', 3);
INSERT INTO `m_area` VALUES (1354, 1345, '350782', '武夷山市', 3);
INSERT INTO `m_area` VALUES (1355, 1345, '350783', '建瓯市', 3);
INSERT INTO `m_area` VALUES (1356, 1345, '350784', '建阳市', 3);
INSERT INTO `m_area` VALUES (1357, 1273, '350800', '龙岩市', 2);
INSERT INTO `m_area` VALUES (1358, 1357, '350801', '市辖区', 3);
INSERT INTO `m_area` VALUES (1359, 1357, '350802', '新罗区', 3);
INSERT INTO `m_area` VALUES (1360, 1357, '350821', '长汀县', 3);
INSERT INTO `m_area` VALUES (1361, 1357, '350822', '永定县', 3);
INSERT INTO `m_area` VALUES (1362, 1357, '350823', '上杭县', 3);
INSERT INTO `m_area` VALUES (1363, 1357, '350824', '武平县', 3);
INSERT INTO `m_area` VALUES (1364, 1357, '350825', '连城县', 3);
INSERT INTO `m_area` VALUES (1365, 1357, '350881', '漳平市', 3);
INSERT INTO `m_area` VALUES (1366, 1273, '350900', '宁德市', 2);
INSERT INTO `m_area` VALUES (1367, 1366, '350901', '市辖区', 3);
INSERT INTO `m_area` VALUES (1368, 1366, '350902', '蕉城区', 3);
INSERT INTO `m_area` VALUES (1369, 1366, '350921', '霞浦县', 3);
INSERT INTO `m_area` VALUES (1370, 1366, '350922', '古田县', 3);
INSERT INTO `m_area` VALUES (1371, 1366, '350923', '屏南县', 3);
INSERT INTO `m_area` VALUES (1372, 1366, '350924', '寿宁县', 3);
INSERT INTO `m_area` VALUES (1373, 1366, '350925', '周宁县', 3);
INSERT INTO `m_area` VALUES (1374, 1366, '350926', '柘荣县', 3);
INSERT INTO `m_area` VALUES (1375, 1366, '350981', '福安市', 3);
INSERT INTO `m_area` VALUES (1376, 1366, '350982', '福鼎市', 3);
INSERT INTO `m_area` VALUES (1377, 0, '360000', '江西省', 1);
INSERT INTO `m_area` VALUES (1378, 1377, '360100', '南昌市', 2);
INSERT INTO `m_area` VALUES (1379, 1378, '360101', '市辖区', 3);
INSERT INTO `m_area` VALUES (1380, 1378, '360102', '东湖区', 3);
INSERT INTO `m_area` VALUES (1381, 1378, '360103', '西湖区', 3);
INSERT INTO `m_area` VALUES (1382, 1378, '360104', '青云谱区', 3);
INSERT INTO `m_area` VALUES (1383, 1378, '360105', '湾里区', 3);
INSERT INTO `m_area` VALUES (1384, 1378, '360111', '青山湖区', 3);
INSERT INTO `m_area` VALUES (1385, 1378, '360121', '南昌县', 3);
INSERT INTO `m_area` VALUES (1386, 1378, '360122', '新建县', 3);
INSERT INTO `m_area` VALUES (1387, 1378, '360123', '安义县', 3);
INSERT INTO `m_area` VALUES (1388, 1378, '360124', '进贤县', 3);
INSERT INTO `m_area` VALUES (1389, 1377, '360200', '景德镇市', 2);
INSERT INTO `m_area` VALUES (1390, 1389, '360201', '市辖区', 3);
INSERT INTO `m_area` VALUES (1391, 1389, '360202', '昌江区', 3);
INSERT INTO `m_area` VALUES (1392, 1389, '360203', '珠山区', 3);
INSERT INTO `m_area` VALUES (1393, 1389, '360222', '浮梁县', 3);
INSERT INTO `m_area` VALUES (1394, 1389, '360281', '乐平市', 3);
INSERT INTO `m_area` VALUES (1395, 1377, '360300', '萍乡市', 2);
INSERT INTO `m_area` VALUES (1396, 1395, '360301', '市辖区', 3);
INSERT INTO `m_area` VALUES (1397, 1395, '360302', '安源区', 3);
INSERT INTO `m_area` VALUES (1398, 1395, '360313', '湘东区', 3);
INSERT INTO `m_area` VALUES (1399, 1395, '360321', '莲花县', 3);
INSERT INTO `m_area` VALUES (1400, 1395, '360322', '上栗县', 3);
INSERT INTO `m_area` VALUES (1401, 1395, '360323', '芦溪县', 3);
INSERT INTO `m_area` VALUES (1402, 1377, '360400', '九江市', 2);
INSERT INTO `m_area` VALUES (1403, 1402, '360401', '市辖区', 3);
INSERT INTO `m_area` VALUES (1404, 1402, '360402', '庐山区', 3);
INSERT INTO `m_area` VALUES (1405, 1402, '360403', '浔阳区', 3);
INSERT INTO `m_area` VALUES (1406, 1402, '360421', '九江县', 3);
INSERT INTO `m_area` VALUES (1407, 1402, '360423', '武宁县', 3);
INSERT INTO `m_area` VALUES (1408, 1402, '360424', '修水县', 3);
INSERT INTO `m_area` VALUES (1409, 1402, '360425', '永修县', 3);
INSERT INTO `m_area` VALUES (1410, 1402, '360426', '德安县', 3);
INSERT INTO `m_area` VALUES (1411, 1402, '360427', '星子县', 3);
INSERT INTO `m_area` VALUES (1412, 1402, '360428', '都昌县', 3);
INSERT INTO `m_area` VALUES (1413, 1402, '360429', '湖口县', 3);
INSERT INTO `m_area` VALUES (1414, 1402, '360430', '彭泽县', 3);
INSERT INTO `m_area` VALUES (1415, 1402, '360481', '瑞昌市', 3);
INSERT INTO `m_area` VALUES (1416, 1377, '360500', '新余市', 2);
INSERT INTO `m_area` VALUES (1417, 1416, '360501', '市辖区', 3);
INSERT INTO `m_area` VALUES (1418, 1416, '360502', '渝水区', 3);
INSERT INTO `m_area` VALUES (1419, 1416, '360521', '分宜县', 3);
INSERT INTO `m_area` VALUES (1420, 1377, '360600', '鹰潭市', 2);
INSERT INTO `m_area` VALUES (1421, 1420, '360601', '市辖区', 3);
INSERT INTO `m_area` VALUES (1422, 1420, '360602', '月湖区', 3);
INSERT INTO `m_area` VALUES (1423, 1420, '360622', '余江县', 3);
INSERT INTO `m_area` VALUES (1424, 1420, '360681', '贵溪市', 3);
INSERT INTO `m_area` VALUES (1425, 1377, '360700', '赣州市', 2);
INSERT INTO `m_area` VALUES (1426, 1425, '360701', '市辖区', 3);
INSERT INTO `m_area` VALUES (1427, 1425, '360702', '章贡区', 3);
INSERT INTO `m_area` VALUES (1428, 1425, '360721', '赣　县', 3);
INSERT INTO `m_area` VALUES (1429, 1425, '360722', '信丰县', 3);
INSERT INTO `m_area` VALUES (1430, 1425, '360723', '大余县', 3);
INSERT INTO `m_area` VALUES (1431, 1425, '360724', '上犹县', 3);
INSERT INTO `m_area` VALUES (1432, 1425, '360725', '崇义县', 3);
INSERT INTO `m_area` VALUES (1433, 1425, '360726', '安远县', 3);
INSERT INTO `m_area` VALUES (1434, 1425, '360727', '龙南县', 3);
INSERT INTO `m_area` VALUES (1435, 1425, '360728', '定南县', 3);
INSERT INTO `m_area` VALUES (1436, 1425, '360729', '全南县', 3);
INSERT INTO `m_area` VALUES (1437, 1425, '360730', '宁都县', 3);
INSERT INTO `m_area` VALUES (1438, 1425, '360731', '于都县', 3);
INSERT INTO `m_area` VALUES (1439, 1425, '360732', '兴国县', 3);
INSERT INTO `m_area` VALUES (1440, 1425, '360733', '会昌县', 3);
INSERT INTO `m_area` VALUES (1441, 1425, '360734', '寻乌县', 3);
INSERT INTO `m_area` VALUES (1442, 1425, '360735', '石城县', 3);
INSERT INTO `m_area` VALUES (1443, 1425, '360781', '瑞金市', 3);
INSERT INTO `m_area` VALUES (1444, 1425, '360782', '南康市', 3);
INSERT INTO `m_area` VALUES (1445, 1377, '360800', '吉安市', 2);
INSERT INTO `m_area` VALUES (1446, 1445, '360801', '市辖区', 3);
INSERT INTO `m_area` VALUES (1447, 1445, '360802', '吉州区', 3);
INSERT INTO `m_area` VALUES (1448, 1445, '360803', '青原区', 3);
INSERT INTO `m_area` VALUES (1449, 1445, '360821', '吉安县', 3);
INSERT INTO `m_area` VALUES (1450, 1445, '360822', '吉水县', 3);
INSERT INTO `m_area` VALUES (1451, 1445, '360823', '峡江县', 3);
INSERT INTO `m_area` VALUES (1452, 1445, '360824', '新干县', 3);
INSERT INTO `m_area` VALUES (1453, 1445, '360825', '永丰县', 3);
INSERT INTO `m_area` VALUES (1454, 1445, '360826', '泰和县', 3);
INSERT INTO `m_area` VALUES (1455, 1445, '360827', '遂川县', 3);
INSERT INTO `m_area` VALUES (1456, 1445, '360828', '万安县', 3);
INSERT INTO `m_area` VALUES (1457, 1445, '360829', '安福县', 3);
INSERT INTO `m_area` VALUES (1458, 1445, '360830', '永新县', 3);
INSERT INTO `m_area` VALUES (1459, 1445, '360881', '井冈山市', 3);
INSERT INTO `m_area` VALUES (1460, 1377, '360900', '宜春市', 2);
INSERT INTO `m_area` VALUES (1461, 1460, '360901', '市辖区', 3);
INSERT INTO `m_area` VALUES (1462, 1460, '360902', '袁州区', 3);
INSERT INTO `m_area` VALUES (1463, 1460, '360921', '奉新县', 3);
INSERT INTO `m_area` VALUES (1464, 1460, '360922', '万载县', 3);
INSERT INTO `m_area` VALUES (1465, 1460, '360923', '上高县', 3);
INSERT INTO `m_area` VALUES (1466, 1460, '360924', '宜丰县', 3);
INSERT INTO `m_area` VALUES (1467, 1460, '360925', '靖安县', 3);
INSERT INTO `m_area` VALUES (1468, 1460, '360926', '铜鼓县', 3);
INSERT INTO `m_area` VALUES (1469, 1460, '360981', '丰城市', 3);
INSERT INTO `m_area` VALUES (1470, 1460, '360982', '樟树市', 3);
INSERT INTO `m_area` VALUES (1471, 1460, '360983', '高安市', 3);
INSERT INTO `m_area` VALUES (1472, 1377, '361000', '抚州市', 2);
INSERT INTO `m_area` VALUES (1473, 1472, '361001', '市辖区', 3);
INSERT INTO `m_area` VALUES (1474, 1472, '361002', '临川区', 3);
INSERT INTO `m_area` VALUES (1475, 1472, '361021', '南城县', 3);
INSERT INTO `m_area` VALUES (1476, 1472, '361022', '黎川县', 3);
INSERT INTO `m_area` VALUES (1477, 1472, '361023', '南丰县', 3);
INSERT INTO `m_area` VALUES (1478, 1472, '361024', '崇仁县', 3);
INSERT INTO `m_area` VALUES (1479, 1472, '361025', '乐安县', 3);
INSERT INTO `m_area` VALUES (1480, 1472, '361026', '宜黄县', 3);
INSERT INTO `m_area` VALUES (1481, 1472, '361027', '金溪县', 3);
INSERT INTO `m_area` VALUES (1482, 1472, '361028', '资溪县', 3);
INSERT INTO `m_area` VALUES (1483, 1472, '361029', '东乡县', 3);
INSERT INTO `m_area` VALUES (1484, 1472, '361030', '广昌县', 3);
INSERT INTO `m_area` VALUES (1485, 1377, '361100', '上饶市', 2);
INSERT INTO `m_area` VALUES (1486, 1485, '361101', '市辖区', 3);
INSERT INTO `m_area` VALUES (1487, 1485, '361102', '信州区', 3);
INSERT INTO `m_area` VALUES (1488, 1485, '361121', '上饶县', 3);
INSERT INTO `m_area` VALUES (1489, 1485, '361122', '广丰县', 3);
INSERT INTO `m_area` VALUES (1490, 1485, '361123', '玉山县', 3);
INSERT INTO `m_area` VALUES (1491, 1485, '361124', '铅山县', 3);
INSERT INTO `m_area` VALUES (1492, 1485, '361125', '横峰县', 3);
INSERT INTO `m_area` VALUES (1493, 1485, '361126', '弋阳县', 3);
INSERT INTO `m_area` VALUES (1494, 1485, '361127', '余干县', 3);
INSERT INTO `m_area` VALUES (1495, 1485, '361128', '鄱阳县', 3);
INSERT INTO `m_area` VALUES (1496, 1485, '361129', '万年县', 3);
INSERT INTO `m_area` VALUES (1497, 1485, '361130', '婺源县', 3);
INSERT INTO `m_area` VALUES (1498, 1485, '361181', '德兴市', 3);
INSERT INTO `m_area` VALUES (1499, 0, '370000', '山东省', 1);
INSERT INTO `m_area` VALUES (1500, 1499, '370100', '济南市', 2);
INSERT INTO `m_area` VALUES (1501, 1500, '370101', '市辖区', 3);
INSERT INTO `m_area` VALUES (1502, 1500, '370102', '历下区', 3);
INSERT INTO `m_area` VALUES (1503, 1500, '370103', '市中区', 3);
INSERT INTO `m_area` VALUES (1504, 1500, '370104', '槐荫区', 3);
INSERT INTO `m_area` VALUES (1505, 1500, '370105', '天桥区', 3);
INSERT INTO `m_area` VALUES (1506, 1500, '370112', '历城区', 3);
INSERT INTO `m_area` VALUES (1507, 1500, '370113', '长清区', 3);
INSERT INTO `m_area` VALUES (1508, 1500, '370124', '平阴县', 3);
INSERT INTO `m_area` VALUES (1509, 1500, '370125', '济阳县', 3);
INSERT INTO `m_area` VALUES (1510, 1500, '370126', '商河县', 3);
INSERT INTO `m_area` VALUES (1511, 1500, '370181', '章丘市', 3);
INSERT INTO `m_area` VALUES (1512, 1499, '370200', '青岛市', 2);
INSERT INTO `m_area` VALUES (1513, 1512, '370201', '市辖区', 3);
INSERT INTO `m_area` VALUES (1514, 1512, '370202', '市南区', 3);
INSERT INTO `m_area` VALUES (1515, 1512, '370203', '市北区', 3);
INSERT INTO `m_area` VALUES (1516, 1512, '370205', '四方区', 3);
INSERT INTO `m_area` VALUES (1517, 1512, '370211', '黄岛区', 3);
INSERT INTO `m_area` VALUES (1518, 1512, '370212', '崂山区', 3);
INSERT INTO `m_area` VALUES (1519, 1512, '370213', '李沧区', 3);
INSERT INTO `m_area` VALUES (1520, 1512, '370214', '城阳区', 3);
INSERT INTO `m_area` VALUES (1521, 1512, '370281', '胶州市', 3);
INSERT INTO `m_area` VALUES (1522, 1512, '370282', '即墨市', 3);
INSERT INTO `m_area` VALUES (1523, 1512, '370283', '平度市', 3);
INSERT INTO `m_area` VALUES (1524, 1512, '370284', '胶南市', 3);
INSERT INTO `m_area` VALUES (1525, 1512, '370285', '莱西市', 3);
INSERT INTO `m_area` VALUES (1526, 1499, '370300', '淄博市', 2);
INSERT INTO `m_area` VALUES (1527, 1526, '370301', '市辖区', 3);
INSERT INTO `m_area` VALUES (1528, 1526, '370302', '淄川区', 3);
INSERT INTO `m_area` VALUES (1529, 1526, '370303', '张店区', 3);
INSERT INTO `m_area` VALUES (1530, 1526, '370304', '博山区', 3);
INSERT INTO `m_area` VALUES (1531, 1526, '370305', '临淄区', 3);
INSERT INTO `m_area` VALUES (1532, 1526, '370306', '周村区', 3);
INSERT INTO `m_area` VALUES (1533, 1526, '370321', '桓台县', 3);
INSERT INTO `m_area` VALUES (1534, 1526, '370322', '高青县', 3);
INSERT INTO `m_area` VALUES (1535, 1526, '370323', '沂源县', 3);
INSERT INTO `m_area` VALUES (1536, 1499, '370400', '枣庄市', 2);
INSERT INTO `m_area` VALUES (1537, 1536, '370401', '市辖区', 3);
INSERT INTO `m_area` VALUES (1538, 1536, '370402', '市中区', 3);
INSERT INTO `m_area` VALUES (1539, 1536, '370403', '薛城区', 3);
INSERT INTO `m_area` VALUES (1540, 1536, '370404', '峄城区', 3);
INSERT INTO `m_area` VALUES (1541, 1536, '370405', '台儿庄区', 3);
INSERT INTO `m_area` VALUES (1542, 1536, '370406', '山亭区', 3);
INSERT INTO `m_area` VALUES (1543, 1536, '370481', '滕州市', 3);
INSERT INTO `m_area` VALUES (1544, 1499, '370500', '东营市', 2);
INSERT INTO `m_area` VALUES (1545, 1544, '370501', '市辖区', 3);
INSERT INTO `m_area` VALUES (1546, 1544, '370502', '东营区', 3);
INSERT INTO `m_area` VALUES (1547, 1544, '370503', '河口区', 3);
INSERT INTO `m_area` VALUES (1548, 1544, '370521', '垦利县', 3);
INSERT INTO `m_area` VALUES (1549, 1544, '370522', '利津县', 3);
INSERT INTO `m_area` VALUES (1550, 1544, '370523', '广饶县', 3);
INSERT INTO `m_area` VALUES (1551, 1499, '370600', '烟台市', 2);
INSERT INTO `m_area` VALUES (1552, 1551, '370601', '市辖区', 3);
INSERT INTO `m_area` VALUES (1553, 1551, '370602', '芝罘区', 3);
INSERT INTO `m_area` VALUES (1554, 1551, '370611', '福山区', 3);
INSERT INTO `m_area` VALUES (1555, 1551, '370612', '牟平区', 3);
INSERT INTO `m_area` VALUES (1556, 1551, '370613', '莱山区', 3);
INSERT INTO `m_area` VALUES (1557, 1551, '370634', '长岛县', 3);
INSERT INTO `m_area` VALUES (1558, 1551, '370681', '龙口市', 3);
INSERT INTO `m_area` VALUES (1559, 1551, '370682', '莱阳市', 3);
INSERT INTO `m_area` VALUES (1560, 1551, '370683', '莱州市', 3);
INSERT INTO `m_area` VALUES (1561, 1551, '370684', '蓬莱市', 3);
INSERT INTO `m_area` VALUES (1562, 1551, '370685', '招远市', 3);
INSERT INTO `m_area` VALUES (1563, 1551, '370686', '栖霞市', 3);
INSERT INTO `m_area` VALUES (1564, 1551, '370687', '海阳市', 3);
INSERT INTO `m_area` VALUES (1565, 1499, '370700', '潍坊市', 2);
INSERT INTO `m_area` VALUES (1566, 1565, '370701', '市辖区', 3);
INSERT INTO `m_area` VALUES (1567, 1565, '370702', '潍城区', 3);
INSERT INTO `m_area` VALUES (1568, 1565, '370703', '寒亭区', 3);
INSERT INTO `m_area` VALUES (1569, 1565, '370704', '坊子区', 3);
INSERT INTO `m_area` VALUES (1570, 1565, '370705', '奎文区', 3);
INSERT INTO `m_area` VALUES (1571, 1565, '370724', '临朐县', 3);
INSERT INTO `m_area` VALUES (1572, 1565, '370725', '昌乐县', 3);
INSERT INTO `m_area` VALUES (1573, 1565, '370781', '青州市', 3);
INSERT INTO `m_area` VALUES (1574, 1565, '370782', '诸城市', 3);
INSERT INTO `m_area` VALUES (1575, 1565, '370783', '寿光市', 3);
INSERT INTO `m_area` VALUES (1576, 1565, '370784', '安丘市', 3);
INSERT INTO `m_area` VALUES (1577, 1565, '370785', '高密市', 3);
INSERT INTO `m_area` VALUES (1578, 1565, '370786', '昌邑市', 3);
INSERT INTO `m_area` VALUES (1579, 1499, '370800', '济宁市', 2);
INSERT INTO `m_area` VALUES (1580, 1579, '370801', '市辖区', 3);
INSERT INTO `m_area` VALUES (1581, 1579, '370802', '市中区', 3);
INSERT INTO `m_area` VALUES (1582, 1579, '370811', '任城区', 3);
INSERT INTO `m_area` VALUES (1583, 1579, '370826', '微山县', 3);
INSERT INTO `m_area` VALUES (1584, 1579, '370827', '鱼台县', 3);
INSERT INTO `m_area` VALUES (1585, 1579, '370828', '金乡县', 3);
INSERT INTO `m_area` VALUES (1586, 1579, '370829', '嘉祥县', 3);
INSERT INTO `m_area` VALUES (1587, 1579, '370830', '汶上县', 3);
INSERT INTO `m_area` VALUES (1588, 1579, '370831', '泗水县', 3);
INSERT INTO `m_area` VALUES (1589, 1579, '370832', '梁山县', 3);
INSERT INTO `m_area` VALUES (1590, 1579, '370881', '曲阜市', 3);
INSERT INTO `m_area` VALUES (1591, 1579, '370882', '兖州市', 3);
INSERT INTO `m_area` VALUES (1592, 1579, '370883', '邹城市', 3);
INSERT INTO `m_area` VALUES (1593, 1499, '370900', '泰安市', 2);
INSERT INTO `m_area` VALUES (1594, 1593, '370901', '市辖区', 3);
INSERT INTO `m_area` VALUES (1595, 1593, '370902', '泰山区', 3);
INSERT INTO `m_area` VALUES (1596, 1593, '370903', '岱岳区', 3);
INSERT INTO `m_area` VALUES (1597, 1593, '370921', '宁阳县', 3);
INSERT INTO `m_area` VALUES (1598, 1593, '370923', '东平县', 3);
INSERT INTO `m_area` VALUES (1599, 1593, '370982', '新泰市', 3);
INSERT INTO `m_area` VALUES (1600, 1593, '370983', '肥城市', 3);
INSERT INTO `m_area` VALUES (1601, 1499, '371000', '威海市', 2);
INSERT INTO `m_area` VALUES (1602, 1601, '371001', '市辖区', 3);
INSERT INTO `m_area` VALUES (1603, 1601, '371002', '环翠区', 3);
INSERT INTO `m_area` VALUES (1604, 1601, '371081', '文登市', 3);
INSERT INTO `m_area` VALUES (1605, 1601, '371082', '荣成市', 3);
INSERT INTO `m_area` VALUES (1606, 1601, '371083', '乳山市', 3);
INSERT INTO `m_area` VALUES (1607, 1499, '371100', '日照市', 2);
INSERT INTO `m_area` VALUES (1608, 1607, '371101', '市辖区', 3);
INSERT INTO `m_area` VALUES (1609, 1607, '371102', '东港区', 3);
INSERT INTO `m_area` VALUES (1610, 1607, '371103', '岚山区', 3);
INSERT INTO `m_area` VALUES (1611, 1607, '371121', '五莲县', 3);
INSERT INTO `m_area` VALUES (1612, 1607, '371122', '莒　县', 3);
INSERT INTO `m_area` VALUES (1613, 1499, '371200', '莱芜市', 2);
INSERT INTO `m_area` VALUES (1614, 1613, '371201', '市辖区', 3);
INSERT INTO `m_area` VALUES (1615, 1613, '371202', '莱城区', 3);
INSERT INTO `m_area` VALUES (1616, 1613, '371203', '钢城区', 3);
INSERT INTO `m_area` VALUES (1617, 1499, '371300', '临沂市', 2);
INSERT INTO `m_area` VALUES (1618, 1617, '371301', '市辖区', 3);
INSERT INTO `m_area` VALUES (1619, 1617, '371302', '兰山区', 3);
INSERT INTO `m_area` VALUES (1620, 1617, '371311', '罗庄区', 3);
INSERT INTO `m_area` VALUES (1621, 1617, '371312', '河东区', 3);
INSERT INTO `m_area` VALUES (1622, 1617, '371321', '沂南县', 3);
INSERT INTO `m_area` VALUES (1623, 1617, '371322', '郯城县', 3);
INSERT INTO `m_area` VALUES (1624, 1617, '371323', '沂水县', 3);
INSERT INTO `m_area` VALUES (1625, 1617, '371324', '苍山县', 3);
INSERT INTO `m_area` VALUES (1626, 1617, '371325', '费　县', 3);
INSERT INTO `m_area` VALUES (1627, 1617, '371326', '平邑县', 3);
INSERT INTO `m_area` VALUES (1628, 1617, '371327', '莒南县', 3);
INSERT INTO `m_area` VALUES (1629, 1617, '371328', '蒙阴县', 3);
INSERT INTO `m_area` VALUES (1630, 1617, '371329', '临沭县', 3);
INSERT INTO `m_area` VALUES (1631, 1499, '371400', '德州市', 2);
INSERT INTO `m_area` VALUES (1632, 1631, '371401', '市辖区', 3);
INSERT INTO `m_area` VALUES (1633, 1631, '371402', '德城区', 3);
INSERT INTO `m_area` VALUES (1634, 1631, '371421', '陵　县', 3);
INSERT INTO `m_area` VALUES (1635, 1631, '371422', '宁津县', 3);
INSERT INTO `m_area` VALUES (1636, 1631, '371423', '庆云县', 3);
INSERT INTO `m_area` VALUES (1637, 1631, '371424', '临邑县', 3);
INSERT INTO `m_area` VALUES (1638, 1631, '371425', '齐河县', 3);
INSERT INTO `m_area` VALUES (1639, 1631, '371426', '平原县', 3);
INSERT INTO `m_area` VALUES (1640, 1631, '371427', '夏津县', 3);
INSERT INTO `m_area` VALUES (1641, 1631, '371428', '武城县', 3);
INSERT INTO `m_area` VALUES (1642, 1631, '371481', '乐陵市', 3);
INSERT INTO `m_area` VALUES (1643, 1631, '371482', '禹城市', 3);
INSERT INTO `m_area` VALUES (1644, 1499, '371500', '聊城市', 2);
INSERT INTO `m_area` VALUES (1645, 1644, '371501', '市辖区', 3);
INSERT INTO `m_area` VALUES (1646, 1644, '371502', '东昌府区', 3);
INSERT INTO `m_area` VALUES (1647, 1644, '371521', '阳谷县', 3);
INSERT INTO `m_area` VALUES (1648, 1644, '371522', '莘　县', 3);
INSERT INTO `m_area` VALUES (1649, 1644, '371523', '茌平县', 3);
INSERT INTO `m_area` VALUES (1650, 1644, '371524', '东阿县', 3);
INSERT INTO `m_area` VALUES (1651, 1644, '371525', '冠　县', 3);
INSERT INTO `m_area` VALUES (1652, 1644, '371526', '高唐县', 3);
INSERT INTO `m_area` VALUES (1653, 1644, '371581', '临清市', 3);
INSERT INTO `m_area` VALUES (1654, 1499, '371600', '滨州市', 2);
INSERT INTO `m_area` VALUES (1655, 1654, '371601', '市辖区', 3);
INSERT INTO `m_area` VALUES (1656, 1654, '371602', '滨城区', 3);
INSERT INTO `m_area` VALUES (1657, 1654, '371621', '惠民县', 3);
INSERT INTO `m_area` VALUES (1658, 1654, '371622', '阳信县', 3);
INSERT INTO `m_area` VALUES (1659, 1654, '371623', '无棣县', 3);
INSERT INTO `m_area` VALUES (1660, 1654, '371624', '沾化县', 3);
INSERT INTO `m_area` VALUES (1661, 1654, '371625', '博兴县', 3);
INSERT INTO `m_area` VALUES (1662, 1654, '371626', '邹平县', 3);
INSERT INTO `m_area` VALUES (1663, 1499, '371700', '荷泽市', 2);
INSERT INTO `m_area` VALUES (1664, 1663, '371701', '市辖区', 3);
INSERT INTO `m_area` VALUES (1665, 1663, '371702', '牡丹区', 3);
INSERT INTO `m_area` VALUES (1666, 1663, '371721', '曹　县', 3);
INSERT INTO `m_area` VALUES (1667, 1663, '371722', '单　县', 3);
INSERT INTO `m_area` VALUES (1668, 1663, '371723', '成武县', 3);
INSERT INTO `m_area` VALUES (1669, 1663, '371724', '巨野县', 3);
INSERT INTO `m_area` VALUES (1670, 1663, '371725', '郓城县', 3);
INSERT INTO `m_area` VALUES (1671, 1663, '371726', '鄄城县', 3);
INSERT INTO `m_area` VALUES (1672, 1663, '371727', '定陶县', 3);
INSERT INTO `m_area` VALUES (1673, 1663, '371728', '东明县', 3);
INSERT INTO `m_area` VALUES (1674, 0, '410000', '河南省', 1);
INSERT INTO `m_area` VALUES (1675, 1674, '410100', '郑州市', 2);
INSERT INTO `m_area` VALUES (1676, 1675, '410101', '市辖区', 3);
INSERT INTO `m_area` VALUES (1677, 1675, '410102', '中原区', 3);
INSERT INTO `m_area` VALUES (1678, 1675, '410103', '二七区', 3);
INSERT INTO `m_area` VALUES (1679, 1675, '410104', '管城回族区', 3);
INSERT INTO `m_area` VALUES (1680, 1675, '410105', '金水区', 3);
INSERT INTO `m_area` VALUES (1681, 1675, '410106', '上街区', 3);
INSERT INTO `m_area` VALUES (1682, 1675, '410108', '邙山区', 3);
INSERT INTO `m_area` VALUES (1683, 1675, '410122', '中牟县', 3);
INSERT INTO `m_area` VALUES (1684, 1675, '410181', '巩义市', 3);
INSERT INTO `m_area` VALUES (1685, 1675, '410182', '荥阳市', 3);
INSERT INTO `m_area` VALUES (1686, 1675, '410183', '新密市', 3);
INSERT INTO `m_area` VALUES (1687, 1675, '410184', '新郑市', 3);
INSERT INTO `m_area` VALUES (1688, 1675, '410185', '登封市', 3);
INSERT INTO `m_area` VALUES (1689, 1674, '410200', '开封市', 2);
INSERT INTO `m_area` VALUES (1690, 1689, '410201', '市辖区', 3);
INSERT INTO `m_area` VALUES (1691, 1689, '410202', '龙亭区', 3);
INSERT INTO `m_area` VALUES (1692, 1689, '410203', '顺河回族区', 3);
INSERT INTO `m_area` VALUES (1693, 1689, '410204', '鼓楼区', 3);
INSERT INTO `m_area` VALUES (1694, 1689, '410205', '南关区', 3);
INSERT INTO `m_area` VALUES (1695, 1689, '410211', '郊　区', 3);
INSERT INTO `m_area` VALUES (1696, 1689, '410221', '杞　县', 3);
INSERT INTO `m_area` VALUES (1697, 1689, '410222', '通许县', 3);
INSERT INTO `m_area` VALUES (1698, 1689, '410223', '尉氏县', 3);
INSERT INTO `m_area` VALUES (1699, 1689, '410224', '开封县', 3);
INSERT INTO `m_area` VALUES (1700, 1689, '410225', '兰考县', 3);
INSERT INTO `m_area` VALUES (1701, 1674, '410300', '洛阳市', 2);
INSERT INTO `m_area` VALUES (1702, 1701, '410301', '市辖区', 3);
INSERT INTO `m_area` VALUES (1703, 1701, '410302', '老城区', 3);
INSERT INTO `m_area` VALUES (1704, 1701, '410303', '西工区', 3);
INSERT INTO `m_area` VALUES (1705, 1701, '410304', '廛河回族区', 3);
INSERT INTO `m_area` VALUES (1706, 1701, '410305', '涧西区', 3);
INSERT INTO `m_area` VALUES (1707, 1701, '410306', '吉利区', 3);
INSERT INTO `m_area` VALUES (1708, 1701, '410307', '洛龙区', 3);
INSERT INTO `m_area` VALUES (1709, 1701, '410322', '孟津县', 3);
INSERT INTO `m_area` VALUES (1710, 1701, '410323', '新安县', 3);
INSERT INTO `m_area` VALUES (1711, 1701, '410324', '栾川县', 3);
INSERT INTO `m_area` VALUES (1712, 1701, '410325', '嵩　县', 3);
INSERT INTO `m_area` VALUES (1713, 1701, '410326', '汝阳县', 3);
INSERT INTO `m_area` VALUES (1714, 1701, '410327', '宜阳县', 3);
INSERT INTO `m_area` VALUES (1715, 1701, '410328', '洛宁县', 3);
INSERT INTO `m_area` VALUES (1716, 1701, '410329', '伊川县', 3);
INSERT INTO `m_area` VALUES (1717, 1701, '410381', '偃师市', 3);
INSERT INTO `m_area` VALUES (1718, 1674, '410400', '平顶山市', 2);
INSERT INTO `m_area` VALUES (1719, 1718, '410401', '市辖区', 3);
INSERT INTO `m_area` VALUES (1720, 1718, '410402', '新华区', 3);
INSERT INTO `m_area` VALUES (1721, 1718, '410403', '卫东区', 3);
INSERT INTO `m_area` VALUES (1722, 1718, '410404', '石龙区', 3);
INSERT INTO `m_area` VALUES (1723, 1718, '410411', '湛河区', 3);
INSERT INTO `m_area` VALUES (1724, 1718, '410421', '宝丰县', 3);
INSERT INTO `m_area` VALUES (1725, 1718, '410422', '叶　县', 3);
INSERT INTO `m_area` VALUES (1726, 1718, '410423', '鲁山县', 3);
INSERT INTO `m_area` VALUES (1727, 1718, '410425', '郏　县', 3);
INSERT INTO `m_area` VALUES (1728, 1718, '410481', '舞钢市', 3);
INSERT INTO `m_area` VALUES (1729, 1718, '410482', '汝州市', 3);
INSERT INTO `m_area` VALUES (1730, 1674, '410500', '安阳市', 2);
INSERT INTO `m_area` VALUES (1731, 1730, '410501', '市辖区', 3);
INSERT INTO `m_area` VALUES (1732, 1730, '410502', '文峰区', 3);
INSERT INTO `m_area` VALUES (1733, 1730, '410503', '北关区', 3);
INSERT INTO `m_area` VALUES (1734, 1730, '410505', '殷都区', 3);
INSERT INTO `m_area` VALUES (1735, 1730, '410506', '龙安区', 3);
INSERT INTO `m_area` VALUES (1736, 1730, '410522', '安阳县', 3);
INSERT INTO `m_area` VALUES (1737, 1730, '410523', '汤阴县', 3);
INSERT INTO `m_area` VALUES (1738, 1730, '410526', '滑　县', 3);
INSERT INTO `m_area` VALUES (1739, 1730, '410527', '内黄县', 3);
INSERT INTO `m_area` VALUES (1740, 1730, '410581', '林州市', 3);
INSERT INTO `m_area` VALUES (1741, 1674, '410600', '鹤壁市', 2);
INSERT INTO `m_area` VALUES (1742, 1741, '410601', '市辖区', 3);
INSERT INTO `m_area` VALUES (1743, 1741, '410602', '鹤山区', 3);
INSERT INTO `m_area` VALUES (1744, 1741, '410603', '山城区', 3);
INSERT INTO `m_area` VALUES (1745, 1741, '410611', '淇滨区', 3);
INSERT INTO `m_area` VALUES (1746, 1741, '410621', '浚　县', 3);
INSERT INTO `m_area` VALUES (1747, 1741, '410622', '淇　县', 3);
INSERT INTO `m_area` VALUES (1748, 1674, '410700', '新乡市', 2);
INSERT INTO `m_area` VALUES (1749, 1748, '410701', '市辖区', 3);
INSERT INTO `m_area` VALUES (1750, 1748, '410702', '红旗区', 3);
INSERT INTO `m_area` VALUES (1751, 1748, '410703', '卫滨区', 3);
INSERT INTO `m_area` VALUES (1752, 1748, '410704', '凤泉区', 3);
INSERT INTO `m_area` VALUES (1753, 1748, '410711', '牧野区', 3);
INSERT INTO `m_area` VALUES (1754, 1748, '410721', '新乡县', 3);
INSERT INTO `m_area` VALUES (1755, 1748, '410724', '获嘉县', 3);
INSERT INTO `m_area` VALUES (1756, 1748, '410725', '原阳县', 3);
INSERT INTO `m_area` VALUES (1757, 1748, '410726', '延津县', 3);
INSERT INTO `m_area` VALUES (1758, 1748, '410727', '封丘县', 3);
INSERT INTO `m_area` VALUES (1759, 1748, '410728', '长垣县', 3);
INSERT INTO `m_area` VALUES (1760, 1748, '410781', '卫辉市', 3);
INSERT INTO `m_area` VALUES (1761, 1748, '410782', '辉县市', 3);
INSERT INTO `m_area` VALUES (1762, 1674, '410800', '焦作市', 2);
INSERT INTO `m_area` VALUES (1763, 1762, '410801', '市辖区', 3);
INSERT INTO `m_area` VALUES (1764, 1762, '410802', '解放区', 3);
INSERT INTO `m_area` VALUES (1765, 1762, '410803', '中站区', 3);
INSERT INTO `m_area` VALUES (1766, 1762, '410804', '马村区', 3);
INSERT INTO `m_area` VALUES (1767, 1762, '410811', '山阳区', 3);
INSERT INTO `m_area` VALUES (1768, 1762, '410821', '修武县', 3);
INSERT INTO `m_area` VALUES (1769, 1762, '410822', '博爱县', 3);
INSERT INTO `m_area` VALUES (1770, 1762, '410823', '武陟县', 3);
INSERT INTO `m_area` VALUES (1771, 1762, '410825', '温　县', 3);
INSERT INTO `m_area` VALUES (1772, 1762, '410881', '济源市', 3);
INSERT INTO `m_area` VALUES (1773, 1762, '410882', '沁阳市', 3);
INSERT INTO `m_area` VALUES (1774, 1762, '410883', '孟州市', 3);
INSERT INTO `m_area` VALUES (1775, 1674, '410900', '濮阳市', 2);
INSERT INTO `m_area` VALUES (1776, 1775, '410901', '市辖区', 3);
INSERT INTO `m_area` VALUES (1777, 1775, '410902', '华龙区', 3);
INSERT INTO `m_area` VALUES (1778, 1775, '410922', '清丰县', 3);
INSERT INTO `m_area` VALUES (1779, 1775, '410923', '南乐县', 3);
INSERT INTO `m_area` VALUES (1780, 1775, '410926', '范　县', 3);
INSERT INTO `m_area` VALUES (1781, 1775, '410927', '台前县', 3);
INSERT INTO `m_area` VALUES (1782, 1775, '410928', '濮阳县', 3);
INSERT INTO `m_area` VALUES (1783, 1674, '411000', '许昌市', 2);
INSERT INTO `m_area` VALUES (1784, 1783, '411001', '市辖区', 3);
INSERT INTO `m_area` VALUES (1785, 1783, '411002', '魏都区', 3);
INSERT INTO `m_area` VALUES (1786, 1783, '411023', '许昌县', 3);
INSERT INTO `m_area` VALUES (1787, 1783, '411024', '鄢陵县', 3);
INSERT INTO `m_area` VALUES (1788, 1783, '411025', '襄城县', 3);
INSERT INTO `m_area` VALUES (1789, 1783, '411081', '禹州市', 3);
INSERT INTO `m_area` VALUES (1790, 1783, '411082', '长葛市', 3);
INSERT INTO `m_area` VALUES (1791, 1674, '411100', '漯河市', 2);
INSERT INTO `m_area` VALUES (1792, 1791, '411101', '市辖区', 3);
INSERT INTO `m_area` VALUES (1793, 1791, '411102', '源汇区', 3);
INSERT INTO `m_area` VALUES (1794, 1791, '411103', '郾城区', 3);
INSERT INTO `m_area` VALUES (1795, 1791, '411104', '召陵区', 3);
INSERT INTO `m_area` VALUES (1796, 1791, '411121', '舞阳县', 3);
INSERT INTO `m_area` VALUES (1797, 1791, '411122', '临颍县', 3);
INSERT INTO `m_area` VALUES (1798, 1674, '411200', '三门峡市', 2);
INSERT INTO `m_area` VALUES (1799, 1798, '411201', '市辖区', 3);
INSERT INTO `m_area` VALUES (1800, 1798, '411202', '湖滨区', 3);
INSERT INTO `m_area` VALUES (1801, 1798, '411221', '渑池县', 3);
INSERT INTO `m_area` VALUES (1802, 1798, '411222', '陕　县', 3);
INSERT INTO `m_area` VALUES (1803, 1798, '411224', '卢氏县', 3);
INSERT INTO `m_area` VALUES (1804, 1798, '411281', '义马市', 3);
INSERT INTO `m_area` VALUES (1805, 1798, '411282', '灵宝市', 3);
INSERT INTO `m_area` VALUES (1806, 1674, '411300', '南阳市', 2);
INSERT INTO `m_area` VALUES (1807, 1806, '411301', '市辖区', 3);
INSERT INTO `m_area` VALUES (1808, 1806, '411302', '宛城区', 3);
INSERT INTO `m_area` VALUES (1809, 1806, '411303', '卧龙区', 3);
INSERT INTO `m_area` VALUES (1810, 1806, '411321', '南召县', 3);
INSERT INTO `m_area` VALUES (1811, 1806, '411322', '方城县', 3);
INSERT INTO `m_area` VALUES (1812, 1806, '411323', '西峡县', 3);
INSERT INTO `m_area` VALUES (1813, 1806, '411324', '镇平县', 3);
INSERT INTO `m_area` VALUES (1814, 1806, '411325', '内乡县', 3);
INSERT INTO `m_area` VALUES (1815, 1806, '411326', '淅川县', 3);
INSERT INTO `m_area` VALUES (1816, 1806, '411327', '社旗县', 3);
INSERT INTO `m_area` VALUES (1817, 1806, '411328', '唐河县', 3);
INSERT INTO `m_area` VALUES (1818, 1806, '411329', '新野县', 3);
INSERT INTO `m_area` VALUES (1819, 1806, '411330', '桐柏县', 3);
INSERT INTO `m_area` VALUES (1820, 1806, '411381', '邓州市', 3);
INSERT INTO `m_area` VALUES (1821, 1674, '411400', '商丘市', 2);
INSERT INTO `m_area` VALUES (1822, 1821, '411401', '市辖区', 3);
INSERT INTO `m_area` VALUES (1823, 1821, '411402', '梁园区', 3);
INSERT INTO `m_area` VALUES (1824, 1821, '411403', '睢阳区', 3);
INSERT INTO `m_area` VALUES (1825, 1821, '411421', '民权县', 3);
INSERT INTO `m_area` VALUES (1826, 1821, '411422', '睢　县', 3);
INSERT INTO `m_area` VALUES (1827, 1821, '411423', '宁陵县', 3);
INSERT INTO `m_area` VALUES (1828, 1821, '411424', '柘城县', 3);
INSERT INTO `m_area` VALUES (1829, 1821, '411425', '虞城县', 3);
INSERT INTO `m_area` VALUES (1830, 1821, '411426', '夏邑县', 3);
INSERT INTO `m_area` VALUES (1831, 1821, '411481', '永城市', 3);
INSERT INTO `m_area` VALUES (1832, 1674, '411500', '信阳市', 2);
INSERT INTO `m_area` VALUES (1833, 1832, '411501', '市辖区', 3);
INSERT INTO `m_area` VALUES (1834, 1832, '411502', '师河区', 3);
INSERT INTO `m_area` VALUES (1835, 1832, '411503', '平桥区', 3);
INSERT INTO `m_area` VALUES (1836, 1832, '411521', '罗山县', 3);
INSERT INTO `m_area` VALUES (1837, 1832, '411522', '光山县', 3);
INSERT INTO `m_area` VALUES (1838, 1832, '411523', '新　县', 3);
INSERT INTO `m_area` VALUES (1839, 1832, '411524', '商城县', 3);
INSERT INTO `m_area` VALUES (1840, 1832, '411525', '固始县', 3);
INSERT INTO `m_area` VALUES (1841, 1832, '411526', '潢川县', 3);
INSERT INTO `m_area` VALUES (1842, 1832, '411527', '淮滨县', 3);
INSERT INTO `m_area` VALUES (1843, 1832, '411528', '息　县', 3);
INSERT INTO `m_area` VALUES (1844, 1674, '411600', '周口市', 2);
INSERT INTO `m_area` VALUES (1845, 1844, '411601', '市辖区', 3);
INSERT INTO `m_area` VALUES (1846, 1844, '411602', '川汇区', 3);
INSERT INTO `m_area` VALUES (1847, 1844, '411621', '扶沟县', 3);
INSERT INTO `m_area` VALUES (1848, 1844, '411622', '西华县', 3);
INSERT INTO `m_area` VALUES (1849, 1844, '411623', '商水县', 3);
INSERT INTO `m_area` VALUES (1850, 1844, '411624', '沈丘县', 3);
INSERT INTO `m_area` VALUES (1851, 1844, '411625', '郸城县', 3);
INSERT INTO `m_area` VALUES (1852, 1844, '411626', '淮阳县', 3);
INSERT INTO `m_area` VALUES (1853, 1844, '411627', '太康县', 3);
INSERT INTO `m_area` VALUES (1854, 1844, '411628', '鹿邑县', 3);
INSERT INTO `m_area` VALUES (1855, 1844, '411681', '项城市', 3);
INSERT INTO `m_area` VALUES (1856, 1674, '411700', '驻马店市', 2);
INSERT INTO `m_area` VALUES (1857, 1856, '411701', '市辖区', 3);
INSERT INTO `m_area` VALUES (1858, 1856, '411702', '驿城区', 3);
INSERT INTO `m_area` VALUES (1859, 1856, '411721', '西平县', 3);
INSERT INTO `m_area` VALUES (1860, 1856, '411722', '上蔡县', 3);
INSERT INTO `m_area` VALUES (1861, 1856, '411723', '平舆县', 3);
INSERT INTO `m_area` VALUES (1862, 1856, '411724', '正阳县', 3);
INSERT INTO `m_area` VALUES (1863, 1856, '411725', '确山县', 3);
INSERT INTO `m_area` VALUES (1864, 1856, '411726', '泌阳县', 3);
INSERT INTO `m_area` VALUES (1865, 1856, '411727', '汝南县', 3);
INSERT INTO `m_area` VALUES (1866, 1856, '411728', '遂平县', 3);
INSERT INTO `m_area` VALUES (1867, 1856, '411729', '新蔡县', 3);
INSERT INTO `m_area` VALUES (1868, 0, '420000', '湖北省', 1);
INSERT INTO `m_area` VALUES (1869, 1868, '420100', '武汉市', 2);
INSERT INTO `m_area` VALUES (1870, 1869, '420101', '市辖区', 3);
INSERT INTO `m_area` VALUES (1871, 1869, '420102', '江岸区', 3);
INSERT INTO `m_area` VALUES (1872, 1869, '420103', '江汉区', 3);
INSERT INTO `m_area` VALUES (1873, 1869, '420104', '乔口区', 3);
INSERT INTO `m_area` VALUES (1874, 1869, '420105', '汉阳区', 3);
INSERT INTO `m_area` VALUES (1875, 1869, '420106', '武昌区', 3);
INSERT INTO `m_area` VALUES (1876, 1869, '420107', '青山区', 3);
INSERT INTO `m_area` VALUES (1877, 1869, '420111', '洪山区', 3);
INSERT INTO `m_area` VALUES (1878, 1869, '420112', '东西湖区', 3);
INSERT INTO `m_area` VALUES (1879, 1869, '420113', '汉南区', 3);
INSERT INTO `m_area` VALUES (1880, 1869, '420114', '蔡甸区', 3);
INSERT INTO `m_area` VALUES (1881, 1869, '420115', '江夏区', 3);
INSERT INTO `m_area` VALUES (1882, 1869, '420116', '黄陂区', 3);
INSERT INTO `m_area` VALUES (1883, 1869, '420117', '新洲区', 3);
INSERT INTO `m_area` VALUES (1884, 1868, '420200', '黄石市', 2);
INSERT INTO `m_area` VALUES (1885, 1884, '420201', '市辖区', 3);
INSERT INTO `m_area` VALUES (1886, 1884, '420202', '黄石港区', 3);
INSERT INTO `m_area` VALUES (1887, 1884, '420203', '西塞山区', 3);
INSERT INTO `m_area` VALUES (1888, 1884, '420204', '下陆区', 3);
INSERT INTO `m_area` VALUES (1889, 1884, '420205', '铁山区', 3);
INSERT INTO `m_area` VALUES (1890, 1884, '420222', '阳新县', 3);
INSERT INTO `m_area` VALUES (1891, 1884, '420281', '大冶市', 3);
INSERT INTO `m_area` VALUES (1892, 1868, '420300', '十堰市', 2);
INSERT INTO `m_area` VALUES (1893, 1892, '420301', '市辖区', 3);
INSERT INTO `m_area` VALUES (1894, 1892, '420302', '茅箭区', 3);
INSERT INTO `m_area` VALUES (1895, 1892, '420303', '张湾区', 3);
INSERT INTO `m_area` VALUES (1896, 1892, '420321', '郧　县', 3);
INSERT INTO `m_area` VALUES (1897, 1892, '420322', '郧西县', 3);
INSERT INTO `m_area` VALUES (1898, 1892, '420323', '竹山县', 3);
INSERT INTO `m_area` VALUES (1899, 1892, '420324', '竹溪县', 3);
INSERT INTO `m_area` VALUES (1900, 1892, '420325', '房　县', 3);
INSERT INTO `m_area` VALUES (1901, 1892, '420381', '丹江口市', 3);
INSERT INTO `m_area` VALUES (1902, 1868, '420500', '宜昌市', 2);
INSERT INTO `m_area` VALUES (1903, 1902, '420501', '市辖区', 3);
INSERT INTO `m_area` VALUES (1904, 1902, '420502', '西陵区', 3);
INSERT INTO `m_area` VALUES (1905, 1902, '420503', '伍家岗区', 3);
INSERT INTO `m_area` VALUES (1906, 1902, '420504', '点军区', 3);
INSERT INTO `m_area` VALUES (1907, 1902, '420505', '猇亭区', 3);
INSERT INTO `m_area` VALUES (1908, 1902, '420506', '夷陵区', 3);
INSERT INTO `m_area` VALUES (1909, 1902, '420525', '远安县', 3);
INSERT INTO `m_area` VALUES (1910, 1902, '420526', '兴山县', 3);
INSERT INTO `m_area` VALUES (1911, 1902, '420527', '秭归县', 3);
INSERT INTO `m_area` VALUES (1912, 1902, '420528', '长阳土家族自治县', 3);
INSERT INTO `m_area` VALUES (1913, 1902, '420529', '五峰土家族自治县', 3);
INSERT INTO `m_area` VALUES (1914, 1902, '420581', '宜都市', 3);
INSERT INTO `m_area` VALUES (1915, 1902, '420582', '当阳市', 3);
INSERT INTO `m_area` VALUES (1916, 1902, '420583', '枝江市', 3);
INSERT INTO `m_area` VALUES (1917, 1868, '420600', '襄樊市', 2);
INSERT INTO `m_area` VALUES (1918, 1917, '420601', '市辖区', 3);
INSERT INTO `m_area` VALUES (1919, 1917, '420602', '襄城区', 3);
INSERT INTO `m_area` VALUES (1920, 1917, '420606', '樊城区', 3);
INSERT INTO `m_area` VALUES (1921, 1917, '420607', '襄阳区', 3);
INSERT INTO `m_area` VALUES (1922, 1917, '420624', '南漳县', 3);
INSERT INTO `m_area` VALUES (1923, 1917, '420625', '谷城县', 3);
INSERT INTO `m_area` VALUES (1924, 1917, '420626', '保康县', 3);
INSERT INTO `m_area` VALUES (1925, 1917, '420682', '老河口市', 3);
INSERT INTO `m_area` VALUES (1926, 1917, '420683', '枣阳市', 3);
INSERT INTO `m_area` VALUES (1927, 1917, '420684', '宜城市', 3);
INSERT INTO `m_area` VALUES (1928, 1868, '420700', '鄂州市', 2);
INSERT INTO `m_area` VALUES (1929, 1928, '420701', '市辖区', 3);
INSERT INTO `m_area` VALUES (1930, 1928, '420702', '梁子湖区', 3);
INSERT INTO `m_area` VALUES (1931, 1928, '420703', '华容区', 3);
INSERT INTO `m_area` VALUES (1932, 1928, '420704', '鄂城区', 3);
INSERT INTO `m_area` VALUES (1933, 1868, '420800', '荆门市', 2);
INSERT INTO `m_area` VALUES (1934, 1933, '420801', '市辖区', 3);
INSERT INTO `m_area` VALUES (1935, 1933, '420802', '东宝区', 3);
INSERT INTO `m_area` VALUES (1936, 1933, '420804', '掇刀区', 3);
INSERT INTO `m_area` VALUES (1937, 1933, '420821', '京山县', 3);
INSERT INTO `m_area` VALUES (1938, 1933, '420822', '沙洋县', 3);
INSERT INTO `m_area` VALUES (1939, 1933, '420881', '钟祥市', 3);
INSERT INTO `m_area` VALUES (1940, 1868, '420900', '孝感市', 2);
INSERT INTO `m_area` VALUES (1941, 1940, '420901', '市辖区', 3);
INSERT INTO `m_area` VALUES (1942, 1940, '420902', '孝南区', 3);
INSERT INTO `m_area` VALUES (1943, 1940, '420921', '孝昌县', 3);
INSERT INTO `m_area` VALUES (1944, 1940, '420922', '大悟县', 3);
INSERT INTO `m_area` VALUES (1945, 1940, '420923', '云梦县', 3);
INSERT INTO `m_area` VALUES (1946, 1940, '420981', '应城市', 3);
INSERT INTO `m_area` VALUES (1947, 1940, '420982', '安陆市', 3);
INSERT INTO `m_area` VALUES (1948, 1940, '420984', '汉川市', 3);
INSERT INTO `m_area` VALUES (1949, 1868, '421000', '荆州市', 2);
INSERT INTO `m_area` VALUES (1950, 1949, '421001', '市辖区', 3);
INSERT INTO `m_area` VALUES (1951, 1949, '421002', '沙市区', 3);
INSERT INTO `m_area` VALUES (1952, 1949, '421003', '荆州区', 3);
INSERT INTO `m_area` VALUES (1953, 1949, '421022', '公安县', 3);
INSERT INTO `m_area` VALUES (1954, 1949, '421023', '监利县', 3);
INSERT INTO `m_area` VALUES (1955, 1949, '421024', '江陵县', 3);
INSERT INTO `m_area` VALUES (1956, 1949, '421081', '石首市', 3);
INSERT INTO `m_area` VALUES (1957, 1949, '421083', '洪湖市', 3);
INSERT INTO `m_area` VALUES (1958, 1949, '421087', '松滋市', 3);
INSERT INTO `m_area` VALUES (1959, 1868, '421100', '黄冈市', 2);
INSERT INTO `m_area` VALUES (1960, 1959, '421101', '市辖区', 3);
INSERT INTO `m_area` VALUES (1961, 1959, '421102', '黄州区', 3);
INSERT INTO `m_area` VALUES (1962, 1959, '421121', '团风县', 3);
INSERT INTO `m_area` VALUES (1963, 1959, '421122', '红安县', 3);
INSERT INTO `m_area` VALUES (1964, 1959, '421123', '罗田县', 3);
INSERT INTO `m_area` VALUES (1965, 1959, '421124', '英山县', 3);
INSERT INTO `m_area` VALUES (1966, 1959, '421125', '浠水县', 3);
INSERT INTO `m_area` VALUES (1967, 1959, '421126', '蕲春县', 3);
INSERT INTO `m_area` VALUES (1968, 1959, '421127', '黄梅县', 3);
INSERT INTO `m_area` VALUES (1969, 1959, '421181', '麻城市', 3);
INSERT INTO `m_area` VALUES (1970, 1959, '421182', '武穴市', 3);
INSERT INTO `m_area` VALUES (1971, 1868, '421200', '咸宁市', 2);
INSERT INTO `m_area` VALUES (1972, 1971, '421201', '市辖区', 3);
INSERT INTO `m_area` VALUES (1973, 1971, '421202', '咸安区', 3);
INSERT INTO `m_area` VALUES (1974, 1971, '421221', '嘉鱼县', 3);
INSERT INTO `m_area` VALUES (1975, 1971, '421222', '通城县', 3);
INSERT INTO `m_area` VALUES (1976, 1971, '421223', '崇阳县', 3);
INSERT INTO `m_area` VALUES (1977, 1971, '421224', '通山县', 3);
INSERT INTO `m_area` VALUES (1978, 1971, '421281', '赤壁市', 3);
INSERT INTO `m_area` VALUES (1979, 1868, '421300', '随州市', 2);
INSERT INTO `m_area` VALUES (1980, 1979, '421301', '市辖区', 3);
INSERT INTO `m_area` VALUES (1981, 1979, '421302', '曾都区', 3);
INSERT INTO `m_area` VALUES (1982, 1979, '421381', '广水市', 3);
INSERT INTO `m_area` VALUES (1983, 1868, '422800', '恩施土家族苗族自治州', 2);
INSERT INTO `m_area` VALUES (1984, 1983, '422801', '恩施市', 3);
INSERT INTO `m_area` VALUES (1985, 1983, '422802', '利川市', 3);
INSERT INTO `m_area` VALUES (1986, 1983, '422822', '建始县', 3);
INSERT INTO `m_area` VALUES (1987, 1983, '422823', '巴东县', 3);
INSERT INTO `m_area` VALUES (1988, 1983, '422825', '宣恩县', 3);
INSERT INTO `m_area` VALUES (1989, 1983, '422826', '咸丰县', 3);
INSERT INTO `m_area` VALUES (1990, 1983, '422827', '来凤县', 3);
INSERT INTO `m_area` VALUES (1991, 1983, '422828', '鹤峰县', 3);
INSERT INTO `m_area` VALUES (1992, 1868, '429000', '省直辖行政单位', 2);
INSERT INTO `m_area` VALUES (1993, 1992, '429004', '仙桃市', 3);
INSERT INTO `m_area` VALUES (1994, 1992, '429005', '潜江市', 3);
INSERT INTO `m_area` VALUES (1995, 1992, '429006', '天门市', 3);
INSERT INTO `m_area` VALUES (1996, 1992, '429021', '神农架林区', 3);
INSERT INTO `m_area` VALUES (1997, 0, '430000', '湖南省', 1);
INSERT INTO `m_area` VALUES (1998, 1997, '430100', '长沙市', 2);
INSERT INTO `m_area` VALUES (1999, 1998, '430101', '市辖区', 3);
INSERT INTO `m_area` VALUES (2000, 1998, '430102', '芙蓉区', 3);
INSERT INTO `m_area` VALUES (2001, 1998, '430103', '天心区', 3);
INSERT INTO `m_area` VALUES (2002, 1998, '430104', '岳麓区', 3);
INSERT INTO `m_area` VALUES (2003, 1998, '430105', '开福区', 3);
INSERT INTO `m_area` VALUES (2004, 1998, '430111', '雨花区', 3);
INSERT INTO `m_area` VALUES (2005, 1998, '430121', '长沙县', 3);
INSERT INTO `m_area` VALUES (2006, 1998, '430122', '望城县', 3);
INSERT INTO `m_area` VALUES (2007, 1998, '430124', '宁乡县', 3);
INSERT INTO `m_area` VALUES (2008, 1998, '430181', '浏阳市', 3);
INSERT INTO `m_area` VALUES (2009, 1997, '430200', '株洲市', 2);
INSERT INTO `m_area` VALUES (2010, 2009, '430201', '市辖区', 3);
INSERT INTO `m_area` VALUES (2011, 2009, '430202', '荷塘区', 3);
INSERT INTO `m_area` VALUES (2012, 2009, '430203', '芦淞区', 3);
INSERT INTO `m_area` VALUES (2013, 2009, '430204', '石峰区', 3);
INSERT INTO `m_area` VALUES (2014, 2009, '430211', '天元区', 3);
INSERT INTO `m_area` VALUES (2015, 2009, '430221', '株洲县', 3);
INSERT INTO `m_area` VALUES (2016, 2009, '430223', '攸　县', 3);
INSERT INTO `m_area` VALUES (2017, 2009, '430224', '茶陵县', 3);
INSERT INTO `m_area` VALUES (2018, 2009, '430225', '炎陵县', 3);
INSERT INTO `m_area` VALUES (2019, 2009, '430281', '醴陵市', 3);
INSERT INTO `m_area` VALUES (2020, 1997, '430300', '湘潭市', 2);
INSERT INTO `m_area` VALUES (2021, 2020, '430301', '市辖区', 3);
INSERT INTO `m_area` VALUES (2022, 2020, '430302', '雨湖区', 3);
INSERT INTO `m_area` VALUES (2023, 2020, '430304', '岳塘区', 3);
INSERT INTO `m_area` VALUES (2024, 2020, '430321', '湘潭县', 3);
INSERT INTO `m_area` VALUES (2025, 2020, '430381', '湘乡市', 3);
INSERT INTO `m_area` VALUES (2026, 2020, '430382', '韶山市', 3);
INSERT INTO `m_area` VALUES (2027, 1997, '430400', '衡阳市', 2);
INSERT INTO `m_area` VALUES (2028, 2027, '430401', '市辖区', 3);
INSERT INTO `m_area` VALUES (2029, 2027, '430405', '珠晖区', 3);
INSERT INTO `m_area` VALUES (2030, 2027, '430406', '雁峰区', 3);
INSERT INTO `m_area` VALUES (2031, 2027, '430407', '石鼓区', 3);
INSERT INTO `m_area` VALUES (2032, 2027, '430408', '蒸湘区', 3);
INSERT INTO `m_area` VALUES (2033, 2027, '430412', '南岳区', 3);
INSERT INTO `m_area` VALUES (2034, 2027, '430421', '衡阳县', 3);
INSERT INTO `m_area` VALUES (2035, 2027, '430422', '衡南县', 3);
INSERT INTO `m_area` VALUES (2036, 2027, '430423', '衡山县', 3);
INSERT INTO `m_area` VALUES (2037, 2027, '430424', '衡东县', 3);
INSERT INTO `m_area` VALUES (2038, 2027, '430426', '祁东县', 3);
INSERT INTO `m_area` VALUES (2039, 2027, '430481', '耒阳市', 3);
INSERT INTO `m_area` VALUES (2040, 2027, '430482', '常宁市', 3);
INSERT INTO `m_area` VALUES (2041, 1997, '430500', '邵阳市', 2);
INSERT INTO `m_area` VALUES (2042, 2041, '430501', '市辖区', 3);
INSERT INTO `m_area` VALUES (2043, 2041, '430502', '双清区', 3);
INSERT INTO `m_area` VALUES (2044, 2041, '430503', '大祥区', 3);
INSERT INTO `m_area` VALUES (2045, 2041, '430511', '北塔区', 3);
INSERT INTO `m_area` VALUES (2046, 2041, '430521', '邵东县', 3);
INSERT INTO `m_area` VALUES (2047, 2041, '430522', '新邵县', 3);
INSERT INTO `m_area` VALUES (2048, 2041, '430523', '邵阳县', 3);
INSERT INTO `m_area` VALUES (2049, 2041, '430524', '隆回县', 3);
INSERT INTO `m_area` VALUES (2050, 2041, '430525', '洞口县', 3);
INSERT INTO `m_area` VALUES (2051, 2041, '430527', '绥宁县', 3);
INSERT INTO `m_area` VALUES (2052, 2041, '430528', '新宁县', 3);
INSERT INTO `m_area` VALUES (2053, 2041, '430529', '城步苗族自治县', 3);
INSERT INTO `m_area` VALUES (2054, 2041, '430581', '武冈市', 3);
INSERT INTO `m_area` VALUES (2055, 1997, '430600', '岳阳市', 2);
INSERT INTO `m_area` VALUES (2056, 2055, '430601', '市辖区', 3);
INSERT INTO `m_area` VALUES (2057, 2055, '430602', '岳阳楼区', 3);
INSERT INTO `m_area` VALUES (2058, 2055, '430603', '云溪区', 3);
INSERT INTO `m_area` VALUES (2059, 2055, '430611', '君山区', 3);
INSERT INTO `m_area` VALUES (2060, 2055, '430621', '岳阳县', 3);
INSERT INTO `m_area` VALUES (2061, 2055, '430623', '华容县', 3);
INSERT INTO `m_area` VALUES (2062, 2055, '430624', '湘阴县', 3);
INSERT INTO `m_area` VALUES (2063, 2055, '430626', '平江县', 3);
INSERT INTO `m_area` VALUES (2064, 2055, '430681', '汨罗市', 3);
INSERT INTO `m_area` VALUES (2065, 2055, '430682', '临湘市', 3);
INSERT INTO `m_area` VALUES (2066, 1997, '430700', '常德市', 2);
INSERT INTO `m_area` VALUES (2067, 2066, '430701', '市辖区', 3);
INSERT INTO `m_area` VALUES (2068, 2066, '430702', '武陵区', 3);
INSERT INTO `m_area` VALUES (2069, 2066, '430703', '鼎城区', 3);
INSERT INTO `m_area` VALUES (2070, 2066, '430721', '安乡县', 3);
INSERT INTO `m_area` VALUES (2071, 2066, '430722', '汉寿县', 3);
INSERT INTO `m_area` VALUES (2072, 2066, '430723', '澧　县', 3);
INSERT INTO `m_area` VALUES (2073, 2066, '430724', '临澧县', 3);
INSERT INTO `m_area` VALUES (2074, 2066, '430725', '桃源县', 3);
INSERT INTO `m_area` VALUES (2075, 2066, '430726', '石门县', 3);
INSERT INTO `m_area` VALUES (2076, 2066, '430781', '津市市', 3);
INSERT INTO `m_area` VALUES (2077, 1997, '430800', '张家界市', 2);
INSERT INTO `m_area` VALUES (2078, 2077, '430801', '市辖区', 3);
INSERT INTO `m_area` VALUES (2079, 2077, '430802', '永定区', 3);
INSERT INTO `m_area` VALUES (2080, 2077, '430811', '武陵源区', 3);
INSERT INTO `m_area` VALUES (2081, 2077, '430821', '慈利县', 3);
INSERT INTO `m_area` VALUES (2082, 2077, '430822', '桑植县', 3);
INSERT INTO `m_area` VALUES (2083, 1997, '430900', '益阳市', 2);
INSERT INTO `m_area` VALUES (2084, 2083, '430901', '市辖区', 3);
INSERT INTO `m_area` VALUES (2085, 2083, '430902', '资阳区', 3);
INSERT INTO `m_area` VALUES (2086, 2083, '430903', '赫山区', 3);
INSERT INTO `m_area` VALUES (2087, 2083, '430921', '南　县', 3);
INSERT INTO `m_area` VALUES (2088, 2083, '430922', '桃江县', 3);
INSERT INTO `m_area` VALUES (2089, 2083, '430923', '安化县', 3);
INSERT INTO `m_area` VALUES (2090, 2083, '430981', '沅江市', 3);
INSERT INTO `m_area` VALUES (2091, 1997, '431000', '郴州市', 2);
INSERT INTO `m_area` VALUES (2092, 2091, '431001', '市辖区', 3);
INSERT INTO `m_area` VALUES (2093, 2091, '431002', '北湖区', 3);
INSERT INTO `m_area` VALUES (2094, 2091, '431003', '苏仙区', 3);
INSERT INTO `m_area` VALUES (2095, 2091, '431021', '桂阳县', 3);
INSERT INTO `m_area` VALUES (2096, 2091, '431022', '宜章县', 3);
INSERT INTO `m_area` VALUES (2097, 2091, '431023', '永兴县', 3);
INSERT INTO `m_area` VALUES (2098, 2091, '431024', '嘉禾县', 3);
INSERT INTO `m_area` VALUES (2099, 2091, '431025', '临武县', 3);
INSERT INTO `m_area` VALUES (2100, 2091, '431026', '汝城县', 3);
INSERT INTO `m_area` VALUES (2101, 2091, '431027', '桂东县', 3);
INSERT INTO `m_area` VALUES (2102, 2091, '431028', '安仁县', 3);
INSERT INTO `m_area` VALUES (2103, 2091, '431081', '资兴市', 3);
INSERT INTO `m_area` VALUES (2104, 1997, '431100', '永州市', 2);
INSERT INTO `m_area` VALUES (2105, 2104, '431101', '市辖区', 3);
INSERT INTO `m_area` VALUES (2106, 2104, '431102', '芝山区', 3);
INSERT INTO `m_area` VALUES (2107, 2104, '431103', '冷水滩区', 3);
INSERT INTO `m_area` VALUES (2108, 2104, '431121', '祁阳县', 3);
INSERT INTO `m_area` VALUES (2109, 2104, '431122', '东安县', 3);
INSERT INTO `m_area` VALUES (2110, 2104, '431123', '双牌县', 3);
INSERT INTO `m_area` VALUES (2111, 2104, '431124', '道　县', 3);
INSERT INTO `m_area` VALUES (2112, 2104, '431125', '江永县', 3);
INSERT INTO `m_area` VALUES (2113, 2104, '431126', '宁远县', 3);
INSERT INTO `m_area` VALUES (2114, 2104, '431127', '蓝山县', 3);
INSERT INTO `m_area` VALUES (2115, 2104, '431128', '新田县', 3);
INSERT INTO `m_area` VALUES (2116, 2104, '431129', '江华瑶族自治县', 3);
INSERT INTO `m_area` VALUES (2117, 1997, '431200', '怀化市', 2);
INSERT INTO `m_area` VALUES (2118, 2117, '431201', '市辖区', 3);
INSERT INTO `m_area` VALUES (2119, 2117, '431202', '鹤城区', 3);
INSERT INTO `m_area` VALUES (2120, 2117, '431221', '中方县', 3);
INSERT INTO `m_area` VALUES (2121, 2117, '431222', '沅陵县', 3);
INSERT INTO `m_area` VALUES (2122, 2117, '431223', '辰溪县', 3);
INSERT INTO `m_area` VALUES (2123, 2117, '431224', '溆浦县', 3);
INSERT INTO `m_area` VALUES (2124, 2117, '431225', '会同县', 3);
INSERT INTO `m_area` VALUES (2125, 2117, '431226', '麻阳苗族自治县', 3);
INSERT INTO `m_area` VALUES (2126, 2117, '431227', '新晃侗族自治县', 3);
INSERT INTO `m_area` VALUES (2127, 2117, '431228', '芷江侗族自治县', 3);
INSERT INTO `m_area` VALUES (2128, 2117, '431229', '靖州苗族侗族自治县', 3);
INSERT INTO `m_area` VALUES (2129, 2117, '431230', '通道侗族自治县', 3);
INSERT INTO `m_area` VALUES (2130, 2117, '431281', '洪江市', 3);
INSERT INTO `m_area` VALUES (2131, 1997, '431300', '娄底市', 2);
INSERT INTO `m_area` VALUES (2132, 2131, '431301', '市辖区', 3);
INSERT INTO `m_area` VALUES (2133, 2131, '431302', '娄星区', 3);
INSERT INTO `m_area` VALUES (2134, 2131, '431321', '双峰县', 3);
INSERT INTO `m_area` VALUES (2135, 2131, '431322', '新化县', 3);
INSERT INTO `m_area` VALUES (2136, 2131, '431381', '冷水江市', 3);
INSERT INTO `m_area` VALUES (2137, 2131, '431382', '涟源市', 3);
INSERT INTO `m_area` VALUES (2138, 1997, '433100', '湘西土家族苗族自治州', 2);
INSERT INTO `m_area` VALUES (2139, 2138, '433101', '吉首市', 3);
INSERT INTO `m_area` VALUES (2140, 2138, '433122', '泸溪县', 3);
INSERT INTO `m_area` VALUES (2141, 2138, '433123', '凤凰县', 3);
INSERT INTO `m_area` VALUES (2142, 2138, '433124', '花垣县', 3);
INSERT INTO `m_area` VALUES (2143, 2138, '433125', '保靖县', 3);
INSERT INTO `m_area` VALUES (2144, 2138, '433126', '古丈县', 3);
INSERT INTO `m_area` VALUES (2145, 2138, '433127', '永顺县', 3);
INSERT INTO `m_area` VALUES (2146, 2138, '433130', '龙山县', 3);
INSERT INTO `m_area` VALUES (2147, 0, '440000', '广东省', 1);
INSERT INTO `m_area` VALUES (2148, 2147, '440100', '广州市', 2);
INSERT INTO `m_area` VALUES (2149, 2148, '440101', '市辖区', 3);
INSERT INTO `m_area` VALUES (2150, 2148, '440102', '东山区', 3);
INSERT INTO `m_area` VALUES (2151, 2148, '440103', '荔湾区', 3);
INSERT INTO `m_area` VALUES (2152, 2148, '440104', '越秀区', 3);
INSERT INTO `m_area` VALUES (2153, 2148, '440105', '海珠区', 3);
INSERT INTO `m_area` VALUES (2154, 2148, '440106', '天河区', 3);
INSERT INTO `m_area` VALUES (2155, 2148, '440107', '芳村区', 3);
INSERT INTO `m_area` VALUES (2156, 2148, '440111', '白云区', 3);
INSERT INTO `m_area` VALUES (2157, 2148, '440112', '黄埔区', 3);
INSERT INTO `m_area` VALUES (2158, 2148, '440113', '番禺区', 3);
INSERT INTO `m_area` VALUES (2159, 2148, '440114', '花都区', 3);
INSERT INTO `m_area` VALUES (2160, 2148, '440183', '增城市', 3);
INSERT INTO `m_area` VALUES (2161, 2148, '440184', '从化市', 3);
INSERT INTO `m_area` VALUES (2162, 2147, '440200', '韶关市', 2);
INSERT INTO `m_area` VALUES (2163, 2162, '440201', '市辖区', 3);
INSERT INTO `m_area` VALUES (2164, 2162, '440203', '武江区', 3);
INSERT INTO `m_area` VALUES (2165, 2162, '440204', '浈江区', 3);
INSERT INTO `m_area` VALUES (2166, 2162, '440205', '曲江区', 3);
INSERT INTO `m_area` VALUES (2167, 2162, '440222', '始兴县', 3);
INSERT INTO `m_area` VALUES (2168, 2162, '440224', '仁化县', 3);
INSERT INTO `m_area` VALUES (2169, 2162, '440229', '翁源县', 3);
INSERT INTO `m_area` VALUES (2170, 2162, '440232', '乳源瑶族自治县', 3);
INSERT INTO `m_area` VALUES (2171, 2162, '440233', '新丰县', 3);
INSERT INTO `m_area` VALUES (2172, 2162, '440281', '乐昌市', 3);
INSERT INTO `m_area` VALUES (2173, 2162, '440282', '南雄市', 3);
INSERT INTO `m_area` VALUES (2174, 2147, '440300', '深圳市', 2);
INSERT INTO `m_area` VALUES (2175, 2174, '440301', '市辖区', 3);
INSERT INTO `m_area` VALUES (2176, 2174, '440303', '罗湖区', 3);
INSERT INTO `m_area` VALUES (2177, 2174, '440304', '福田区', 3);
INSERT INTO `m_area` VALUES (2178, 2174, '440305', '南山区', 3);
INSERT INTO `m_area` VALUES (2179, 2174, '440306', '宝安区', 3);
INSERT INTO `m_area` VALUES (2180, 2174, '440307', '龙岗区', 3);
INSERT INTO `m_area` VALUES (2181, 2174, '440308', '盐田区', 3);
INSERT INTO `m_area` VALUES (2182, 2147, '440400', '珠海市', 2);
INSERT INTO `m_area` VALUES (2183, 2182, '440401', '市辖区', 3);
INSERT INTO `m_area` VALUES (2184, 2182, '440402', '香洲区', 3);
INSERT INTO `m_area` VALUES (2185, 2182, '440403', '斗门区', 3);
INSERT INTO `m_area` VALUES (2186, 2182, '440404', '金湾区', 3);
INSERT INTO `m_area` VALUES (2187, 2147, '440500', '汕头市', 2);
INSERT INTO `m_area` VALUES (2188, 2187, '440501', '市辖区', 3);
INSERT INTO `m_area` VALUES (2189, 2187, '440507', '龙湖区', 3);
INSERT INTO `m_area` VALUES (2190, 2187, '440511', '金平区', 3);
INSERT INTO `m_area` VALUES (2191, 2187, '440512', '濠江区', 3);
INSERT INTO `m_area` VALUES (2192, 2187, '440513', '潮阳区', 3);
INSERT INTO `m_area` VALUES (2193, 2187, '440514', '潮南区', 3);
INSERT INTO `m_area` VALUES (2194, 2187, '440515', '澄海区', 3);
INSERT INTO `m_area` VALUES (2195, 2187, '440523', '南澳县', 3);
INSERT INTO `m_area` VALUES (2196, 2147, '440600', '佛山市', 2);
INSERT INTO `m_area` VALUES (2197, 2196, '440601', '市辖区', 3);
INSERT INTO `m_area` VALUES (2198, 2196, '440604', '禅城区', 3);
INSERT INTO `m_area` VALUES (2199, 2196, '440605', '南海区', 3);
INSERT INTO `m_area` VALUES (2200, 2196, '440606', '顺德区', 3);
INSERT INTO `m_area` VALUES (2201, 2196, '440607', '三水区', 3);
INSERT INTO `m_area` VALUES (2202, 2196, '440608', '高明区', 3);
INSERT INTO `m_area` VALUES (2203, 2147, '440700', '江门市', 2);
INSERT INTO `m_area` VALUES (2204, 2203, '440701', '市辖区', 3);
INSERT INTO `m_area` VALUES (2205, 2203, '440703', '蓬江区', 3);
INSERT INTO `m_area` VALUES (2206, 2203, '440704', '江海区', 3);
INSERT INTO `m_area` VALUES (2207, 2203, '440705', '新会区', 3);
INSERT INTO `m_area` VALUES (2208, 2203, '440781', '台山市', 3);
INSERT INTO `m_area` VALUES (2209, 2203, '440783', '开平市', 3);
INSERT INTO `m_area` VALUES (2210, 2203, '440784', '鹤山市', 3);
INSERT INTO `m_area` VALUES (2211, 2203, '440785', '恩平市', 3);
INSERT INTO `m_area` VALUES (2212, 2147, '440800', '湛江市', 2);
INSERT INTO `m_area` VALUES (2213, 2212, '440801', '市辖区', 3);
INSERT INTO `m_area` VALUES (2214, 2212, '440802', '赤坎区', 3);
INSERT INTO `m_area` VALUES (2215, 2212, '440803', '霞山区', 3);
INSERT INTO `m_area` VALUES (2216, 2212, '440804', '坡头区', 3);
INSERT INTO `m_area` VALUES (2217, 2212, '440811', '麻章区', 3);
INSERT INTO `m_area` VALUES (2218, 2212, '440823', '遂溪县', 3);
INSERT INTO `m_area` VALUES (2219, 2212, '440825', '徐闻县', 3);
INSERT INTO `m_area` VALUES (2220, 2212, '440881', '廉江市', 3);
INSERT INTO `m_area` VALUES (2221, 2212, '440882', '雷州市', 3);
INSERT INTO `m_area` VALUES (2222, 2212, '440883', '吴川市', 3);
INSERT INTO `m_area` VALUES (2223, 2147, '440900', '茂名市', 2);
INSERT INTO `m_area` VALUES (2224, 2223, '440901', '市辖区', 3);
INSERT INTO `m_area` VALUES (2225, 2223, '440902', '茂南区', 3);
INSERT INTO `m_area` VALUES (2226, 2223, '440903', '茂港区', 3);
INSERT INTO `m_area` VALUES (2227, 2223, '440923', '电白县', 3);
INSERT INTO `m_area` VALUES (2228, 2223, '440981', '高州市', 3);
INSERT INTO `m_area` VALUES (2229, 2223, '440982', '化州市', 3);
INSERT INTO `m_area` VALUES (2230, 2223, '440983', '信宜市', 3);
INSERT INTO `m_area` VALUES (2231, 2147, '441200', '肇庆市', 2);
INSERT INTO `m_area` VALUES (2232, 2231, '441201', '市辖区', 3);
INSERT INTO `m_area` VALUES (2233, 2231, '441202', '端州区', 3);
INSERT INTO `m_area` VALUES (2234, 2231, '441203', '鼎湖区', 3);
INSERT INTO `m_area` VALUES (2235, 2231, '441223', '广宁县', 3);
INSERT INTO `m_area` VALUES (2236, 2231, '441224', '怀集县', 3);
INSERT INTO `m_area` VALUES (2237, 2231, '441225', '封开县', 3);
INSERT INTO `m_area` VALUES (2238, 2231, '441226', '德庆县', 3);
INSERT INTO `m_area` VALUES (2239, 2231, '441283', '高要市', 3);
INSERT INTO `m_area` VALUES (2240, 2231, '441284', '四会市', 3);
INSERT INTO `m_area` VALUES (2241, 2147, '441300', '惠州市', 2);
INSERT INTO `m_area` VALUES (2242, 2241, '441301', '市辖区', 3);
INSERT INTO `m_area` VALUES (2243, 2241, '441302', '惠城区', 3);
INSERT INTO `m_area` VALUES (2244, 2241, '441303', '惠阳区', 3);
INSERT INTO `m_area` VALUES (2245, 2241, '441322', '博罗县', 3);
INSERT INTO `m_area` VALUES (2246, 2241, '441323', '惠东县', 3);
INSERT INTO `m_area` VALUES (2247, 2241, '441324', '龙门县', 3);
INSERT INTO `m_area` VALUES (2248, 2147, '441400', '梅州市', 2);
INSERT INTO `m_area` VALUES (2249, 2248, '441401', '市辖区', 3);
INSERT INTO `m_area` VALUES (2250, 2248, '441402', '梅江区', 3);
INSERT INTO `m_area` VALUES (2251, 2248, '441421', '梅　县', 3);
INSERT INTO `m_area` VALUES (2252, 2248, '441422', '大埔县', 3);
INSERT INTO `m_area` VALUES (2253, 2248, '441423', '丰顺县', 3);
INSERT INTO `m_area` VALUES (2254, 2248, '441424', '五华县', 3);
INSERT INTO `m_area` VALUES (2255, 2248, '441426', '平远县', 3);
INSERT INTO `m_area` VALUES (2256, 2248, '441427', '蕉岭县', 3);
INSERT INTO `m_area` VALUES (2257, 2248, '441481', '兴宁市', 3);
INSERT INTO `m_area` VALUES (2258, 2147, '441500', '汕尾市', 2);
INSERT INTO `m_area` VALUES (2259, 2258, '441501', '市辖区', 3);
INSERT INTO `m_area` VALUES (2260, 2258, '441502', '城　区', 3);
INSERT INTO `m_area` VALUES (2261, 2258, '441521', '海丰县', 3);
INSERT INTO `m_area` VALUES (2262, 2258, '441523', '陆河县', 3);
INSERT INTO `m_area` VALUES (2263, 2258, '441581', '陆丰市', 3);
INSERT INTO `m_area` VALUES (2264, 2147, '441600', '河源市', 2);
INSERT INTO `m_area` VALUES (2265, 2264, '441601', '市辖区', 3);
INSERT INTO `m_area` VALUES (2266, 2264, '441602', '源城区', 3);
INSERT INTO `m_area` VALUES (2267, 2264, '441621', '紫金县', 3);
INSERT INTO `m_area` VALUES (2268, 2264, '441622', '龙川县', 3);
INSERT INTO `m_area` VALUES (2269, 2264, '441623', '连平县', 3);
INSERT INTO `m_area` VALUES (2270, 2264, '441624', '和平县', 3);
INSERT INTO `m_area` VALUES (2271, 2264, '441625', '东源县', 3);
INSERT INTO `m_area` VALUES (2272, 2147, '441700', '阳江市', 2);
INSERT INTO `m_area` VALUES (2273, 2272, '441701', '市辖区', 3);
INSERT INTO `m_area` VALUES (2274, 2272, '441702', '江城区', 3);
INSERT INTO `m_area` VALUES (2275, 2272, '441721', '阳西县', 3);
INSERT INTO `m_area` VALUES (2276, 2272, '441723', '阳东县', 3);
INSERT INTO `m_area` VALUES (2277, 2272, '441781', '阳春市', 3);
INSERT INTO `m_area` VALUES (2278, 2147, '441800', '清远市', 2);
INSERT INTO `m_area` VALUES (2279, 2278, '441801', '市辖区', 3);
INSERT INTO `m_area` VALUES (2280, 2278, '441802', '清城区', 3);
INSERT INTO `m_area` VALUES (2281, 2278, '441821', '佛冈县', 3);
INSERT INTO `m_area` VALUES (2282, 2278, '441823', '阳山县', 3);
INSERT INTO `m_area` VALUES (2283, 2278, '441825', '连山壮族瑶族自治县', 3);
INSERT INTO `m_area` VALUES (2284, 2278, '441826', '连南瑶族自治县', 3);
INSERT INTO `m_area` VALUES (2285, 2278, '441827', '清新县', 3);
INSERT INTO `m_area` VALUES (2286, 2278, '441881', '英德市', 3);
INSERT INTO `m_area` VALUES (2287, 2278, '441882', '连州市', 3);
INSERT INTO `m_area` VALUES (2288, 2147, '441900', '东莞市', 2);
INSERT INTO `m_area` VALUES (2289, 2147, '442000', '中山市', 2);
INSERT INTO `m_area` VALUES (2290, 2147, '445100', '潮州市', 2);
INSERT INTO `m_area` VALUES (2291, 2290, '445101', '市辖区', 3);
INSERT INTO `m_area` VALUES (2292, 2290, '445102', '湘桥区', 3);
INSERT INTO `m_area` VALUES (2293, 2290, '445121', '潮安县', 3);
INSERT INTO `m_area` VALUES (2294, 2290, '445122', '饶平县', 3);
INSERT INTO `m_area` VALUES (2295, 2147, '445200', '揭阳市', 2);
INSERT INTO `m_area` VALUES (2296, 2295, '445201', '市辖区', 3);
INSERT INTO `m_area` VALUES (2297, 2295, '445202', '榕城区', 3);
INSERT INTO `m_area` VALUES (2298, 2295, '445221', '揭东县', 3);
INSERT INTO `m_area` VALUES (2299, 2295, '445222', '揭西县', 3);
INSERT INTO `m_area` VALUES (2300, 2295, '445224', '惠来县', 3);
INSERT INTO `m_area` VALUES (2301, 2295, '445281', '普宁市', 3);
INSERT INTO `m_area` VALUES (2302, 2147, '445300', '云浮市', 2);
INSERT INTO `m_area` VALUES (2303, 2302, '445301', '市辖区', 3);
INSERT INTO `m_area` VALUES (2304, 2302, '445302', '云城区', 3);
INSERT INTO `m_area` VALUES (2305, 2302, '445321', '新兴县', 3);
INSERT INTO `m_area` VALUES (2306, 2302, '445322', '郁南县', 3);
INSERT INTO `m_area` VALUES (2307, 2302, '445323', '云安县', 3);
INSERT INTO `m_area` VALUES (2308, 2302, '445381', '罗定市', 3);
INSERT INTO `m_area` VALUES (2309, 0, '450000', '广西壮族自治区', 1);
INSERT INTO `m_area` VALUES (2310, 2309, '450100', '南宁市', 2);
INSERT INTO `m_area` VALUES (2311, 2310, '450101', '市辖区', 3);
INSERT INTO `m_area` VALUES (2312, 2310, '450102', '兴宁区', 3);
INSERT INTO `m_area` VALUES (2313, 2310, '450103', '青秀区', 3);
INSERT INTO `m_area` VALUES (2314, 2310, '450105', '江南区', 3);
INSERT INTO `m_area` VALUES (2315, 2310, '450107', '西乡塘区', 3);
INSERT INTO `m_area` VALUES (2316, 2310, '450108', '良庆区', 3);
INSERT INTO `m_area` VALUES (2317, 2310, '450109', '邕宁区', 3);
INSERT INTO `m_area` VALUES (2318, 2310, '450122', '武鸣县', 3);
INSERT INTO `m_area` VALUES (2319, 2310, '450123', '隆安县', 3);
INSERT INTO `m_area` VALUES (2320, 2310, '450124', '马山县', 3);
INSERT INTO `m_area` VALUES (2321, 2310, '450125', '上林县', 3);
INSERT INTO `m_area` VALUES (2322, 2310, '450126', '宾阳县', 3);
INSERT INTO `m_area` VALUES (2323, 2310, '450127', '横　县', 3);
INSERT INTO `m_area` VALUES (2324, 2309, '450200', '柳州市', 2);
INSERT INTO `m_area` VALUES (2325, 2324, '450201', '市辖区', 3);
INSERT INTO `m_area` VALUES (2326, 2324, '450202', '城中区', 3);
INSERT INTO `m_area` VALUES (2327, 2324, '450203', '鱼峰区', 3);
INSERT INTO `m_area` VALUES (2328, 2324, '450204', '柳南区', 3);
INSERT INTO `m_area` VALUES (2329, 2324, '450205', '柳北区', 3);
INSERT INTO `m_area` VALUES (2330, 2324, '450221', '柳江县', 3);
INSERT INTO `m_area` VALUES (2331, 2324, '450222', '柳城县', 3);
INSERT INTO `m_area` VALUES (2332, 2324, '450223', '鹿寨县', 3);
INSERT INTO `m_area` VALUES (2333, 2324, '450224', '融安县', 3);
INSERT INTO `m_area` VALUES (2334, 2324, '450225', '融水苗族自治县', 3);
INSERT INTO `m_area` VALUES (2335, 2324, '450226', '三江侗族自治县', 3);
INSERT INTO `m_area` VALUES (2336, 2309, '450300', '桂林市', 2);
INSERT INTO `m_area` VALUES (2337, 2336, '450301', '市辖区', 3);
INSERT INTO `m_area` VALUES (2338, 2336, '450302', '秀峰区', 3);
INSERT INTO `m_area` VALUES (2339, 2336, '450303', '叠彩区', 3);
INSERT INTO `m_area` VALUES (2340, 2336, '450304', '象山区', 3);
INSERT INTO `m_area` VALUES (2341, 2336, '450305', '七星区', 3);
INSERT INTO `m_area` VALUES (2342, 2336, '450311', '雁山区', 3);
INSERT INTO `m_area` VALUES (2343, 2336, '450321', '阳朔县', 3);
INSERT INTO `m_area` VALUES (2344, 2336, '450322', '临桂县', 3);
INSERT INTO `m_area` VALUES (2345, 2336, '450323', '灵川县', 3);
INSERT INTO `m_area` VALUES (2346, 2336, '450324', '全州县', 3);
INSERT INTO `m_area` VALUES (2347, 2336, '450325', '兴安县', 3);
INSERT INTO `m_area` VALUES (2348, 2336, '450326', '永福县', 3);
INSERT INTO `m_area` VALUES (2349, 2336, '450327', '灌阳县', 3);
INSERT INTO `m_area` VALUES (2350, 2336, '450328', '龙胜各族自治县', 3);
INSERT INTO `m_area` VALUES (2351, 2336, '450329', '资源县', 3);
INSERT INTO `m_area` VALUES (2352, 2336, '450330', '平乐县', 3);
INSERT INTO `m_area` VALUES (2353, 2336, '450331', '荔蒲县', 3);
INSERT INTO `m_area` VALUES (2354, 2336, '450332', '恭城瑶族自治县', 3);
INSERT INTO `m_area` VALUES (2355, 2309, '450400', '梧州市', 2);
INSERT INTO `m_area` VALUES (2356, 2355, '450401', '市辖区', 3);
INSERT INTO `m_area` VALUES (2357, 2355, '450403', '万秀区', 3);
INSERT INTO `m_area` VALUES (2358, 2355, '450404', '蝶山区', 3);
INSERT INTO `m_area` VALUES (2359, 2355, '450405', '长洲区', 3);
INSERT INTO `m_area` VALUES (2360, 2355, '450421', '苍梧县', 3);
INSERT INTO `m_area` VALUES (2361, 2355, '450422', '藤　县', 3);
INSERT INTO `m_area` VALUES (2362, 2355, '450423', '蒙山县', 3);
INSERT INTO `m_area` VALUES (2363, 2355, '450481', '岑溪市', 3);
INSERT INTO `m_area` VALUES (2364, 2309, '450500', '北海市', 2);
INSERT INTO `m_area` VALUES (2365, 2364, '450501', '市辖区', 3);
INSERT INTO `m_area` VALUES (2366, 2364, '450502', '海城区', 3);
INSERT INTO `m_area` VALUES (2367, 2364, '450503', '银海区', 3);
INSERT INTO `m_area` VALUES (2368, 2364, '450512', '铁山港区', 3);
INSERT INTO `m_area` VALUES (2369, 2364, '450521', '合浦县', 3);
INSERT INTO `m_area` VALUES (2370, 2309, '450600', '防城港市', 2);
INSERT INTO `m_area` VALUES (2371, 2370, '450601', '市辖区', 3);
INSERT INTO `m_area` VALUES (2372, 2370, '450602', '港口区', 3);
INSERT INTO `m_area` VALUES (2373, 2370, '450603', '防城区', 3);
INSERT INTO `m_area` VALUES (2374, 2370, '450621', '上思县', 3);
INSERT INTO `m_area` VALUES (2375, 2370, '450681', '东兴市', 3);
INSERT INTO `m_area` VALUES (2376, 2309, '450700', '钦州市', 2);
INSERT INTO `m_area` VALUES (2377, 2376, '450701', '市辖区', 3);
INSERT INTO `m_area` VALUES (2378, 2376, '450702', '钦南区', 3);
INSERT INTO `m_area` VALUES (2379, 2376, '450703', '钦北区', 3);
INSERT INTO `m_area` VALUES (2380, 2376, '450721', '灵山县', 3);
INSERT INTO `m_area` VALUES (2381, 2376, '450722', '浦北县', 3);
INSERT INTO `m_area` VALUES (2382, 2309, '450800', '贵港市', 2);
INSERT INTO `m_area` VALUES (2383, 2382, '450801', '市辖区', 3);
INSERT INTO `m_area` VALUES (2384, 2382, '450802', '港北区', 3);
INSERT INTO `m_area` VALUES (2385, 2382, '450803', '港南区', 3);
INSERT INTO `m_area` VALUES (2386, 2382, '450804', '覃塘区', 3);
INSERT INTO `m_area` VALUES (2387, 2382, '450821', '平南县', 3);
INSERT INTO `m_area` VALUES (2388, 2382, '450881', '桂平市', 3);
INSERT INTO `m_area` VALUES (2389, 2309, '450900', '玉林市', 2);
INSERT INTO `m_area` VALUES (2390, 2389, '450901', '市辖区', 3);
INSERT INTO `m_area` VALUES (2391, 2389, '450902', '玉州区', 3);
INSERT INTO `m_area` VALUES (2392, 2389, '450921', '容　县', 3);
INSERT INTO `m_area` VALUES (2393, 2389, '450922', '陆川县', 3);
INSERT INTO `m_area` VALUES (2394, 2389, '450923', '博白县', 3);
INSERT INTO `m_area` VALUES (2395, 2389, '450924', '兴业县', 3);
INSERT INTO `m_area` VALUES (2396, 2389, '450981', '北流市', 3);
INSERT INTO `m_area` VALUES (2397, 2309, '451000', '百色市', 2);
INSERT INTO `m_area` VALUES (2398, 2397, '451001', '市辖区', 3);
INSERT INTO `m_area` VALUES (2399, 2397, '451002', '右江区', 3);
INSERT INTO `m_area` VALUES (2400, 2397, '451021', '田阳县', 3);
INSERT INTO `m_area` VALUES (2401, 2397, '451022', '田东县', 3);
INSERT INTO `m_area` VALUES (2402, 2397, '451023', '平果县', 3);
INSERT INTO `m_area` VALUES (2403, 2397, '451024', '德保县', 3);
INSERT INTO `m_area` VALUES (2404, 2397, '451025', '靖西县', 3);
INSERT INTO `m_area` VALUES (2405, 2397, '451026', '那坡县', 3);
INSERT INTO `m_area` VALUES (2406, 2397, '451027', '凌云县', 3);
INSERT INTO `m_area` VALUES (2407, 2397, '451028', '乐业县', 3);
INSERT INTO `m_area` VALUES (2408, 2397, '451029', '田林县', 3);
INSERT INTO `m_area` VALUES (2409, 2397, '451030', '西林县', 3);
INSERT INTO `m_area` VALUES (2410, 2397, '451031', '隆林各族自治县', 3);
INSERT INTO `m_area` VALUES (2411, 2309, '451100', '贺州市', 2);
INSERT INTO `m_area` VALUES (2412, 2411, '451101', '市辖区', 3);
INSERT INTO `m_area` VALUES (2413, 2411, '451102', '八步区', 3);
INSERT INTO `m_area` VALUES (2414, 2411, '451121', '昭平县', 3);
INSERT INTO `m_area` VALUES (2415, 2411, '451122', '钟山县', 3);
INSERT INTO `m_area` VALUES (2416, 2411, '451123', '富川瑶族自治县', 3);
INSERT INTO `m_area` VALUES (2417, 2309, '451200', '河池市', 2);
INSERT INTO `m_area` VALUES (2418, 2417, '451201', '市辖区', 3);
INSERT INTO `m_area` VALUES (2419, 2417, '451202', '金城江区', 3);
INSERT INTO `m_area` VALUES (2420, 2417, '451221', '南丹县', 3);
INSERT INTO `m_area` VALUES (2421, 2417, '451222', '天峨县', 3);
INSERT INTO `m_area` VALUES (2422, 2417, '451223', '凤山县', 3);
INSERT INTO `m_area` VALUES (2423, 2417, '451224', '东兰县', 3);
INSERT INTO `m_area` VALUES (2424, 2417, '451225', '罗城仫佬族自治县', 3);
INSERT INTO `m_area` VALUES (2425, 2417, '451226', '环江毛南族自治县', 3);
INSERT INTO `m_area` VALUES (2426, 2417, '451227', '巴马瑶族自治县', 3);
INSERT INTO `m_area` VALUES (2427, 2417, '451228', '都安瑶族自治县', 3);
INSERT INTO `m_area` VALUES (2428, 2417, '451229', '大化瑶族自治县', 3);
INSERT INTO `m_area` VALUES (2429, 2417, '451281', '宜州市', 3);
INSERT INTO `m_area` VALUES (2430, 2309, '451300', '来宾市', 2);
INSERT INTO `m_area` VALUES (2431, 2430, '451301', '市辖区', 3);
INSERT INTO `m_area` VALUES (2432, 2430, '451302', '兴宾区', 3);
INSERT INTO `m_area` VALUES (2433, 2430, '451321', '忻城县', 3);
INSERT INTO `m_area` VALUES (2434, 2430, '451322', '象州县', 3);
INSERT INTO `m_area` VALUES (2435, 2430, '451323', '武宣县', 3);
INSERT INTO `m_area` VALUES (2436, 2430, '451324', '金秀瑶族自治县', 3);
INSERT INTO `m_area` VALUES (2437, 2430, '451381', '合山市', 3);
INSERT INTO `m_area` VALUES (2438, 2309, '451400', '崇左市', 2);
INSERT INTO `m_area` VALUES (2439, 2438, '451401', '市辖区', 3);
INSERT INTO `m_area` VALUES (2440, 2438, '451402', '江洲区', 3);
INSERT INTO `m_area` VALUES (2441, 2438, '451421', '扶绥县', 3);
INSERT INTO `m_area` VALUES (2442, 2438, '451422', '宁明县', 3);
INSERT INTO `m_area` VALUES (2443, 2438, '451423', '龙州县', 3);
INSERT INTO `m_area` VALUES (2444, 2438, '451424', '大新县', 3);
INSERT INTO `m_area` VALUES (2445, 2438, '451425', '天等县', 3);
INSERT INTO `m_area` VALUES (2446, 2438, '451481', '凭祥市', 3);
INSERT INTO `m_area` VALUES (2447, 0, '460000', '海南省', 1);
INSERT INTO `m_area` VALUES (2448, 2447, '460100', '海口市', 2);
INSERT INTO `m_area` VALUES (2449, 2448, '460101', '市辖区', 3);
INSERT INTO `m_area` VALUES (2450, 2448, '460105', '秀英区', 3);
INSERT INTO `m_area` VALUES (2451, 2448, '460106', '龙华区', 3);
INSERT INTO `m_area` VALUES (2452, 2448, '460107', '琼山区', 3);
INSERT INTO `m_area` VALUES (2453, 2448, '460108', '美兰区', 3);
INSERT INTO `m_area` VALUES (2454, 2447, '460200', '三亚市', 2);
INSERT INTO `m_area` VALUES (2455, 2454, '460201', '市辖区', 3);
INSERT INTO `m_area` VALUES (2456, 2447, '469000', '省直辖县级行政单位', 2);
INSERT INTO `m_area` VALUES (2457, 2456, '469001', '五指山市', 3);
INSERT INTO `m_area` VALUES (2458, 2456, '469002', '琼海市', 3);
INSERT INTO `m_area` VALUES (2459, 2456, '469003', '儋州市', 3);
INSERT INTO `m_area` VALUES (2460, 2456, '469005', '文昌市', 3);
INSERT INTO `m_area` VALUES (2461, 2456, '469006', '万宁市', 3);
INSERT INTO `m_area` VALUES (2462, 2456, '469007', '东方市', 3);
INSERT INTO `m_area` VALUES (2463, 2456, '469025', '定安县', 3);
INSERT INTO `m_area` VALUES (2464, 2456, '469026', '屯昌县', 3);
INSERT INTO `m_area` VALUES (2465, 2456, '469027', '澄迈县', 3);
INSERT INTO `m_area` VALUES (2466, 2456, '469028', '临高县', 3);
INSERT INTO `m_area` VALUES (2467, 2456, '469030', '白沙黎族自治县', 3);
INSERT INTO `m_area` VALUES (2468, 2456, '469031', '昌江黎族自治县', 3);
INSERT INTO `m_area` VALUES (2469, 2456, '469033', '乐东黎族自治县', 3);
INSERT INTO `m_area` VALUES (2470, 2456, '469034', '陵水黎族自治县', 3);
INSERT INTO `m_area` VALUES (2471, 2456, '469035', '保亭黎族苗族自治县', 3);
INSERT INTO `m_area` VALUES (2472, 2456, '469036', '琼中黎族苗族自治县', 3);
INSERT INTO `m_area` VALUES (2473, 2456, '469037', '西沙群岛', 3);
INSERT INTO `m_area` VALUES (2474, 2456, '469038', '南沙群岛', 3);
INSERT INTO `m_area` VALUES (2475, 2456, '469039', '中沙群岛的岛礁及其海域', 3);
INSERT INTO `m_area` VALUES (2476, 0, '500000', '重庆市', 1);
INSERT INTO `m_area` VALUES (2477, 2476, '500100', '市辖区', 2);
INSERT INTO `m_area` VALUES (2478, 2477, '500101', '万州区', 3);
INSERT INTO `m_area` VALUES (2479, 2477, '500102', '涪陵区', 3);
INSERT INTO `m_area` VALUES (2480, 2477, '500103', '渝中区', 3);
INSERT INTO `m_area` VALUES (2481, 2477, '500104', '大渡口区', 3);
INSERT INTO `m_area` VALUES (2482, 2477, '500105', '江北区', 3);
INSERT INTO `m_area` VALUES (2483, 2477, '500106', '沙坪坝区', 3);
INSERT INTO `m_area` VALUES (2484, 2477, '500107', '九龙坡区', 3);
INSERT INTO `m_area` VALUES (2485, 2477, '500108', '南岸区', 3);
INSERT INTO `m_area` VALUES (2486, 2477, '500109', '北碚区', 3);
INSERT INTO `m_area` VALUES (2487, 2477, '500110', '万盛区', 3);
INSERT INTO `m_area` VALUES (2488, 2477, '500111', '双桥区', 3);
INSERT INTO `m_area` VALUES (2489, 2477, '500112', '渝北区', 3);
INSERT INTO `m_area` VALUES (2490, 2477, '500113', '巴南区', 3);
INSERT INTO `m_area` VALUES (2491, 2477, '500114', '黔江区', 3);
INSERT INTO `m_area` VALUES (2492, 2477, '500115', '长寿区', 3);
INSERT INTO `m_area` VALUES (2493, 2476, '500200', '县', 2);
INSERT INTO `m_area` VALUES (2494, 2493, '500222', '綦江县', 3);
INSERT INTO `m_area` VALUES (2495, 2493, '500223', '潼南县', 3);
INSERT INTO `m_area` VALUES (2496, 2493, '500224', '铜梁县', 3);
INSERT INTO `m_area` VALUES (2497, 2493, '500225', '大足县', 3);
INSERT INTO `m_area` VALUES (2498, 2493, '500226', '荣昌县', 3);
INSERT INTO `m_area` VALUES (2499, 2493, '500227', '璧山县', 3);
INSERT INTO `m_area` VALUES (2500, 2493, '500228', '梁平县', 3);
INSERT INTO `m_area` VALUES (2501, 2493, '500229', '城口县', 3);
INSERT INTO `m_area` VALUES (2502, 2493, '500230', '丰都县', 3);
INSERT INTO `m_area` VALUES (2503, 2493, '500231', '垫江县', 3);
INSERT INTO `m_area` VALUES (2504, 2493, '500232', '武隆县', 3);
INSERT INTO `m_area` VALUES (2505, 2493, '500233', '忠　县', 3);
INSERT INTO `m_area` VALUES (2506, 2493, '500234', '开　县', 3);
INSERT INTO `m_area` VALUES (2507, 2493, '500235', '云阳县', 3);
INSERT INTO `m_area` VALUES (2508, 2493, '500236', '奉节县', 3);
INSERT INTO `m_area` VALUES (2509, 2493, '500237', '巫山县', 3);
INSERT INTO `m_area` VALUES (2510, 2493, '500238', '巫溪县', 3);
INSERT INTO `m_area` VALUES (2511, 2493, '500240', '石柱土家族自治县', 3);
INSERT INTO `m_area` VALUES (2512, 2493, '500241', '秀山土家族苗族自治县', 3);
INSERT INTO `m_area` VALUES (2513, 2493, '500242', '酉阳土家族苗族自治县', 3);
INSERT INTO `m_area` VALUES (2514, 2493, '500243', '彭水苗族土家族自治县', 3);
INSERT INTO `m_area` VALUES (2515, 2476, '500300', '市', 2);
INSERT INTO `m_area` VALUES (2516, 2515, '500381', '江津市', 3);
INSERT INTO `m_area` VALUES (2517, 2515, '500382', '合川市', 3);
INSERT INTO `m_area` VALUES (2518, 2515, '500383', '永川市', 3);
INSERT INTO `m_area` VALUES (2519, 2515, '500384', '南川市', 3);
INSERT INTO `m_area` VALUES (2520, 0, '510000', '四川省', 1);
INSERT INTO `m_area` VALUES (2521, 2520, '510100', '成都市', 2);
INSERT INTO `m_area` VALUES (2522, 2521, '510101', '市辖区', 3);
INSERT INTO `m_area` VALUES (2523, 2521, '510104', '锦江区', 3);
INSERT INTO `m_area` VALUES (2524, 2521, '510105', '青羊区', 3);
INSERT INTO `m_area` VALUES (2525, 2521, '510106', '金牛区', 3);
INSERT INTO `m_area` VALUES (2526, 2521, '510107', '武侯区', 3);
INSERT INTO `m_area` VALUES (2527, 2521, '510108', '成华区', 3);
INSERT INTO `m_area` VALUES (2528, 2521, '510112', '龙泉驿区', 3);
INSERT INTO `m_area` VALUES (2529, 2521, '510113', '青白江区', 3);
INSERT INTO `m_area` VALUES (2530, 2521, '510114', '新都区', 3);
INSERT INTO `m_area` VALUES (2531, 2521, '510115', '温江区', 3);
INSERT INTO `m_area` VALUES (2532, 2521, '510121', '金堂县', 3);
INSERT INTO `m_area` VALUES (2533, 2521, '510122', '双流县', 3);
INSERT INTO `m_area` VALUES (2534, 2521, '510124', '郫　县', 3);
INSERT INTO `m_area` VALUES (2535, 2521, '510129', '大邑县', 3);
INSERT INTO `m_area` VALUES (2536, 2521, '510131', '蒲江县', 3);
INSERT INTO `m_area` VALUES (2537, 2521, '510132', '新津县', 3);
INSERT INTO `m_area` VALUES (2538, 2521, '510181', '都江堰市', 3);
INSERT INTO `m_area` VALUES (2539, 2521, '510182', '彭州市', 3);
INSERT INTO `m_area` VALUES (2540, 2521, '510183', '邛崃市', 3);
INSERT INTO `m_area` VALUES (2541, 2521, '510184', '崇州市', 3);
INSERT INTO `m_area` VALUES (2542, 2520, '510300', '自贡市', 2);
INSERT INTO `m_area` VALUES (2543, 2542, '510301', '市辖区', 3);
INSERT INTO `m_area` VALUES (2544, 2542, '510302', '自流井区', 3);
INSERT INTO `m_area` VALUES (2545, 2542, '510303', '贡井区', 3);
INSERT INTO `m_area` VALUES (2546, 2542, '510304', '大安区', 3);
INSERT INTO `m_area` VALUES (2547, 2542, '510311', '沿滩区', 3);
INSERT INTO `m_area` VALUES (2548, 2542, '510321', '荣　县', 3);
INSERT INTO `m_area` VALUES (2549, 2542, '510322', '富顺县', 3);
INSERT INTO `m_area` VALUES (2550, 2520, '510400', '攀枝花市', 2);
INSERT INTO `m_area` VALUES (2551, 2550, '510401', '市辖区', 3);
INSERT INTO `m_area` VALUES (2552, 2550, '510402', '东　区', 3);
INSERT INTO `m_area` VALUES (2553, 2550, '510403', '西　区', 3);
INSERT INTO `m_area` VALUES (2554, 2550, '510411', '仁和区', 3);
INSERT INTO `m_area` VALUES (2555, 2550, '510421', '米易县', 3);
INSERT INTO `m_area` VALUES (2556, 2550, '510422', '盐边县', 3);
INSERT INTO `m_area` VALUES (2557, 2520, '510500', '泸州市', 2);
INSERT INTO `m_area` VALUES (2558, 2557, '510501', '市辖区', 3);
INSERT INTO `m_area` VALUES (2559, 2557, '510502', '江阳区', 3);
INSERT INTO `m_area` VALUES (2560, 2557, '510503', '纳溪区', 3);
INSERT INTO `m_area` VALUES (2561, 2557, '510504', '龙马潭区', 3);
INSERT INTO `m_area` VALUES (2562, 2557, '510521', '泸　县', 3);
INSERT INTO `m_area` VALUES (2563, 2557, '510522', '合江县', 3);
INSERT INTO `m_area` VALUES (2564, 2557, '510524', '叙永县', 3);
INSERT INTO `m_area` VALUES (2565, 2557, '510525', '古蔺县', 3);
INSERT INTO `m_area` VALUES (2566, 2520, '510600', '德阳市', 2);
INSERT INTO `m_area` VALUES (2567, 2566, '510601', '市辖区', 3);
INSERT INTO `m_area` VALUES (2568, 2566, '510603', '旌阳区', 3);
INSERT INTO `m_area` VALUES (2569, 2566, '510623', '中江县', 3);
INSERT INTO `m_area` VALUES (2570, 2566, '510626', '罗江县', 3);
INSERT INTO `m_area` VALUES (2571, 2566, '510681', '广汉市', 3);
INSERT INTO `m_area` VALUES (2572, 2566, '510682', '什邡市', 3);
INSERT INTO `m_area` VALUES (2573, 2566, '510683', '绵竹市', 3);
INSERT INTO `m_area` VALUES (2574, 2520, '510700', '绵阳市', 2);
INSERT INTO `m_area` VALUES (2575, 2574, '510701', '市辖区', 3);
INSERT INTO `m_area` VALUES (2576, 2574, '510703', '涪城区', 3);
INSERT INTO `m_area` VALUES (2577, 2574, '510704', '游仙区', 3);
INSERT INTO `m_area` VALUES (2578, 2574, '510722', '三台县', 3);
INSERT INTO `m_area` VALUES (2579, 2574, '510723', '盐亭县', 3);
INSERT INTO `m_area` VALUES (2580, 2574, '510724', '安　县', 3);
INSERT INTO `m_area` VALUES (2581, 2574, '510725', '梓潼县', 3);
INSERT INTO `m_area` VALUES (2582, 2574, '510726', '北川羌族自治县', 3);
INSERT INTO `m_area` VALUES (2583, 2574, '510727', '平武县', 3);
INSERT INTO `m_area` VALUES (2584, 2574, '510781', '江油市', 3);
INSERT INTO `m_area` VALUES (2585, 2520, '510800', '广元市', 2);
INSERT INTO `m_area` VALUES (2586, 2585, '510801', '市辖区', 3);
INSERT INTO `m_area` VALUES (2587, 2585, '510802', '市中区', 3);
INSERT INTO `m_area` VALUES (2588, 2585, '510811', '元坝区', 3);
INSERT INTO `m_area` VALUES (2589, 2585, '510812', '朝天区', 3);
INSERT INTO `m_area` VALUES (2590, 2585, '510821', '旺苍县', 3);
INSERT INTO `m_area` VALUES (2591, 2585, '510822', '青川县', 3);
INSERT INTO `m_area` VALUES (2592, 2585, '510823', '剑阁县', 3);
INSERT INTO `m_area` VALUES (2593, 2585, '510824', '苍溪县', 3);
INSERT INTO `m_area` VALUES (2594, 2520, '510900', '遂宁市', 2);
INSERT INTO `m_area` VALUES (2595, 2594, '510901', '市辖区', 3);
INSERT INTO `m_area` VALUES (2596, 2594, '510903', '船山区', 3);
INSERT INTO `m_area` VALUES (2597, 2594, '510904', '安居区', 3);
INSERT INTO `m_area` VALUES (2598, 2594, '510921', '蓬溪县', 3);
INSERT INTO `m_area` VALUES (2599, 2594, '510922', '射洪县', 3);
INSERT INTO `m_area` VALUES (2600, 2594, '510923', '大英县', 3);
INSERT INTO `m_area` VALUES (2601, 2520, '511000', '内江市', 2);
INSERT INTO `m_area` VALUES (2602, 2601, '511001', '市辖区', 3);
INSERT INTO `m_area` VALUES (2603, 2601, '511002', '市中区', 3);
INSERT INTO `m_area` VALUES (2604, 2601, '511011', '东兴区', 3);
INSERT INTO `m_area` VALUES (2605, 2601, '511024', '威远县', 3);
INSERT INTO `m_area` VALUES (2606, 2601, '511025', '资中县', 3);
INSERT INTO `m_area` VALUES (2607, 2601, '511028', '隆昌县', 3);
INSERT INTO `m_area` VALUES (2608, 2520, '511100', '乐山市', 2);
INSERT INTO `m_area` VALUES (2609, 2608, '511101', '市辖区', 3);
INSERT INTO `m_area` VALUES (2610, 2608, '511102', '市中区', 3);
INSERT INTO `m_area` VALUES (2611, 2608, '511111', '沙湾区', 3);
INSERT INTO `m_area` VALUES (2612, 2608, '511112', '五通桥区', 3);
INSERT INTO `m_area` VALUES (2613, 2608, '511113', '金口河区', 3);
INSERT INTO `m_area` VALUES (2614, 2608, '511123', '犍为县', 3);
INSERT INTO `m_area` VALUES (2615, 2608, '511124', '井研县', 3);
INSERT INTO `m_area` VALUES (2616, 2608, '511126', '夹江县', 3);
INSERT INTO `m_area` VALUES (2617, 2608, '511129', '沐川县', 3);
INSERT INTO `m_area` VALUES (2618, 2608, '511132', '峨边彝族自治县', 3);
INSERT INTO `m_area` VALUES (2619, 2608, '511133', '马边彝族自治县', 3);
INSERT INTO `m_area` VALUES (2620, 2608, '511181', '峨眉山市', 3);
INSERT INTO `m_area` VALUES (2621, 2520, '511300', '南充市', 2);
INSERT INTO `m_area` VALUES (2622, 2621, '511301', '市辖区', 3);
INSERT INTO `m_area` VALUES (2623, 2621, '511302', '顺庆区', 3);
INSERT INTO `m_area` VALUES (2624, 2621, '511303', '高坪区', 3);
INSERT INTO `m_area` VALUES (2625, 2621, '511304', '嘉陵区', 3);
INSERT INTO `m_area` VALUES (2626, 2621, '511321', '南部县', 3);
INSERT INTO `m_area` VALUES (2627, 2621, '511322', '营山县', 3);
INSERT INTO `m_area` VALUES (2628, 2621, '511323', '蓬安县', 3);
INSERT INTO `m_area` VALUES (2629, 2621, '511324', '仪陇县', 3);
INSERT INTO `m_area` VALUES (2630, 2621, '511325', '西充县', 3);
INSERT INTO `m_area` VALUES (2631, 2621, '511381', '阆中市', 3);
INSERT INTO `m_area` VALUES (2632, 2520, '511400', '眉山市', 2);
INSERT INTO `m_area` VALUES (2633, 2632, '511401', '市辖区', 3);
INSERT INTO `m_area` VALUES (2634, 2632, '511402', '东坡区', 3);
INSERT INTO `m_area` VALUES (2635, 2632, '511421', '仁寿县', 3);
INSERT INTO `m_area` VALUES (2636, 2632, '511422', '彭山县', 3);
INSERT INTO `m_area` VALUES (2637, 2632, '511423', '洪雅县', 3);
INSERT INTO `m_area` VALUES (2638, 2632, '511424', '丹棱县', 3);
INSERT INTO `m_area` VALUES (2639, 2632, '511425', '青神县', 3);
INSERT INTO `m_area` VALUES (2640, 2520, '511500', '宜宾市', 2);
INSERT INTO `m_area` VALUES (2641, 2640, '511501', '市辖区', 3);
INSERT INTO `m_area` VALUES (2642, 2640, '511502', '翠屏区', 3);
INSERT INTO `m_area` VALUES (2643, 2640, '511521', '宜宾县', 3);
INSERT INTO `m_area` VALUES (2644, 2640, '511522', '南溪县', 3);
INSERT INTO `m_area` VALUES (2645, 2640, '511523', '江安县', 3);
INSERT INTO `m_area` VALUES (2646, 2640, '511524', '长宁县', 3);
INSERT INTO `m_area` VALUES (2647, 2640, '511525', '高　县', 3);
INSERT INTO `m_area` VALUES (2648, 2640, '511526', '珙　县', 3);
INSERT INTO `m_area` VALUES (2649, 2640, '511527', '筠连县', 3);
INSERT INTO `m_area` VALUES (2650, 2640, '511528', '兴文县', 3);
INSERT INTO `m_area` VALUES (2651, 2640, '511529', '屏山县', 3);
INSERT INTO `m_area` VALUES (2652, 2520, '511600', '广安市', 2);
INSERT INTO `m_area` VALUES (2653, 2652, '511601', '市辖区', 3);
INSERT INTO `m_area` VALUES (2654, 2652, '511602', '广安区', 3);
INSERT INTO `m_area` VALUES (2655, 2652, '511621', '岳池县', 3);
INSERT INTO `m_area` VALUES (2656, 2652, '511622', '武胜县', 3);
INSERT INTO `m_area` VALUES (2657, 2652, '511623', '邻水县', 3);
INSERT INTO `m_area` VALUES (2658, 2652, '511681', '华莹市', 3);
INSERT INTO `m_area` VALUES (2659, 2520, '511700', '达州市', 2);
INSERT INTO `m_area` VALUES (2660, 2659, '511701', '市辖区', 3);
INSERT INTO `m_area` VALUES (2661, 2659, '511702', '通川区', 3);
INSERT INTO `m_area` VALUES (2662, 2659, '511721', '达　县', 3);
INSERT INTO `m_area` VALUES (2663, 2659, '511722', '宣汉县', 3);
INSERT INTO `m_area` VALUES (2664, 2659, '511723', '开江县', 3);
INSERT INTO `m_area` VALUES (2665, 2659, '511724', '大竹县', 3);
INSERT INTO `m_area` VALUES (2666, 2659, '511725', '渠　县', 3);
INSERT INTO `m_area` VALUES (2667, 2659, '511781', '万源市', 3);
INSERT INTO `m_area` VALUES (2668, 2520, '511800', '雅安市', 2);
INSERT INTO `m_area` VALUES (2669, 2668, '511801', '市辖区', 3);
INSERT INTO `m_area` VALUES (2670, 2668, '511802', '雨城区', 3);
INSERT INTO `m_area` VALUES (2671, 2668, '511821', '名山县', 3);
INSERT INTO `m_area` VALUES (2672, 2668, '511822', '荥经县', 3);
INSERT INTO `m_area` VALUES (2673, 2668, '511823', '汉源县', 3);
INSERT INTO `m_area` VALUES (2674, 2668, '511824', '石棉县', 3);
INSERT INTO `m_area` VALUES (2675, 2668, '511825', '天全县', 3);
INSERT INTO `m_area` VALUES (2676, 2668, '511826', '芦山县', 3);
INSERT INTO `m_area` VALUES (2677, 2668, '511827', '宝兴县', 3);
INSERT INTO `m_area` VALUES (2678, 2520, '511900', '巴中市', 2);
INSERT INTO `m_area` VALUES (2679, 2678, '511901', '市辖区', 3);
INSERT INTO `m_area` VALUES (2680, 2678, '511902', '巴州区', 3);
INSERT INTO `m_area` VALUES (2681, 2678, '511921', '通江县', 3);
INSERT INTO `m_area` VALUES (2682, 2678, '511922', '南江县', 3);
INSERT INTO `m_area` VALUES (2683, 2678, '511923', '平昌县', 3);
INSERT INTO `m_area` VALUES (2684, 2520, '512000', '资阳市', 2);
INSERT INTO `m_area` VALUES (2685, 2684, '512001', '市辖区', 3);
INSERT INTO `m_area` VALUES (2686, 2684, '512002', '雁江区', 3);
INSERT INTO `m_area` VALUES (2687, 2684, '512021', '安岳县', 3);
INSERT INTO `m_area` VALUES (2688, 2684, '512022', '乐至县', 3);
INSERT INTO `m_area` VALUES (2689, 2684, '512081', '简阳市', 3);
INSERT INTO `m_area` VALUES (2690, 2520, '513200', '阿坝藏族羌族自治州', 2);
INSERT INTO `m_area` VALUES (2691, 2690, '513221', '汶川县', 3);
INSERT INTO `m_area` VALUES (2692, 2690, '513222', '理　县', 3);
INSERT INTO `m_area` VALUES (2693, 2690, '513223', '茂　县', 3);
INSERT INTO `m_area` VALUES (2694, 2690, '513224', '松潘县', 3);
INSERT INTO `m_area` VALUES (2695, 2690, '513225', '九寨沟县', 3);
INSERT INTO `m_area` VALUES (2696, 2690, '513226', '金川县', 3);
INSERT INTO `m_area` VALUES (2697, 2690, '513227', '小金县', 3);
INSERT INTO `m_area` VALUES (2698, 2690, '513228', '黑水县', 3);
INSERT INTO `m_area` VALUES (2699, 2690, '513229', '马尔康县', 3);
INSERT INTO `m_area` VALUES (2700, 2690, '513230', '壤塘县', 3);
INSERT INTO `m_area` VALUES (2701, 2690, '513231', '阿坝县', 3);
INSERT INTO `m_area` VALUES (2702, 2690, '513232', '若尔盖县', 3);
INSERT INTO `m_area` VALUES (2703, 2690, '513233', '红原县', 3);
INSERT INTO `m_area` VALUES (2704, 2520, '513300', '甘孜藏族自治州', 2);
INSERT INTO `m_area` VALUES (2705, 2704, '513321', '康定县', 3);
INSERT INTO `m_area` VALUES (2706, 2704, '513322', '泸定县', 3);
INSERT INTO `m_area` VALUES (2707, 2704, '513323', '丹巴县', 3);
INSERT INTO `m_area` VALUES (2708, 2704, '513324', '九龙县', 3);
INSERT INTO `m_area` VALUES (2709, 2704, '513325', '雅江县', 3);
INSERT INTO `m_area` VALUES (2710, 2704, '513326', '道孚县', 3);
INSERT INTO `m_area` VALUES (2711, 2704, '513327', '炉霍县', 3);
INSERT INTO `m_area` VALUES (2712, 2704, '513328', '甘孜县', 3);
INSERT INTO `m_area` VALUES (2713, 2704, '513329', '新龙县', 3);
INSERT INTO `m_area` VALUES (2714, 2704, '513330', '德格县', 3);
INSERT INTO `m_area` VALUES (2715, 2704, '513331', '白玉县', 3);
INSERT INTO `m_area` VALUES (2716, 2704, '513332', '石渠县', 3);
INSERT INTO `m_area` VALUES (2717, 2704, '513333', '色达县', 3);
INSERT INTO `m_area` VALUES (2718, 2704, '513334', '理塘县', 3);
INSERT INTO `m_area` VALUES (2719, 2704, '513335', '巴塘县', 3);
INSERT INTO `m_area` VALUES (2720, 2704, '513336', '乡城县', 3);
INSERT INTO `m_area` VALUES (2721, 2704, '513337', '稻城县', 3);
INSERT INTO `m_area` VALUES (2722, 2704, '513338', '得荣县', 3);
INSERT INTO `m_area` VALUES (2723, 2520, '513400', '凉山彝族自治州', 2);
INSERT INTO `m_area` VALUES (2724, 2723, '513401', '西昌市', 3);
INSERT INTO `m_area` VALUES (2725, 2723, '513422', '木里藏族自治县', 3);
INSERT INTO `m_area` VALUES (2726, 2723, '513423', '盐源县', 3);
INSERT INTO `m_area` VALUES (2727, 2723, '513424', '德昌县', 3);
INSERT INTO `m_area` VALUES (2728, 2723, '513425', '会理县', 3);
INSERT INTO `m_area` VALUES (2729, 2723, '513426', '会东县', 3);
INSERT INTO `m_area` VALUES (2730, 2723, '513427', '宁南县', 3);
INSERT INTO `m_area` VALUES (2731, 2723, '513428', '普格县', 3);
INSERT INTO `m_area` VALUES (2732, 2723, '513429', '布拖县', 3);
INSERT INTO `m_area` VALUES (2733, 2723, '513430', '金阳县', 3);
INSERT INTO `m_area` VALUES (2734, 2723, '513431', '昭觉县', 3);
INSERT INTO `m_area` VALUES (2735, 2723, '513432', '喜德县', 3);
INSERT INTO `m_area` VALUES (2736, 2723, '513433', '冕宁县', 3);
INSERT INTO `m_area` VALUES (2737, 2723, '513434', '越西县', 3);
INSERT INTO `m_area` VALUES (2738, 2723, '513435', '甘洛县', 3);
INSERT INTO `m_area` VALUES (2739, 2723, '513436', '美姑县', 3);
INSERT INTO `m_area` VALUES (2740, 2723, '513437', '雷波县', 3);
INSERT INTO `m_area` VALUES (2741, 0, '520000', '贵州省', 1);
INSERT INTO `m_area` VALUES (2742, 2741, '520100', '贵阳市', 2);
INSERT INTO `m_area` VALUES (2743, 2742, '520101', '市辖区', 3);
INSERT INTO `m_area` VALUES (2744, 2742, '520102', '南明区', 3);
INSERT INTO `m_area` VALUES (2745, 2742, '520103', '云岩区', 3);
INSERT INTO `m_area` VALUES (2746, 2742, '520111', '花溪区', 3);
INSERT INTO `m_area` VALUES (2747, 2742, '520112', '乌当区', 3);
INSERT INTO `m_area` VALUES (2748, 2742, '520113', '白云区', 3);
INSERT INTO `m_area` VALUES (2749, 2742, '520114', '小河区', 3);
INSERT INTO `m_area` VALUES (2750, 2742, '520121', '开阳县', 3);
INSERT INTO `m_area` VALUES (2751, 2742, '520122', '息烽县', 3);
INSERT INTO `m_area` VALUES (2752, 2742, '520123', '修文县', 3);
INSERT INTO `m_area` VALUES (2753, 2742, '520181', '清镇市', 3);
INSERT INTO `m_area` VALUES (2754, 2741, '520200', '六盘水市', 2);
INSERT INTO `m_area` VALUES (2755, 2754, '520201', '钟山区', 3);
INSERT INTO `m_area` VALUES (2756, 2754, '520203', '六枝特区', 3);
INSERT INTO `m_area` VALUES (2757, 2754, '520221', '水城县', 3);
INSERT INTO `m_area` VALUES (2758, 2754, '520222', '盘　县', 3);
INSERT INTO `m_area` VALUES (2759, 2741, '520300', '遵义市', 2);
INSERT INTO `m_area` VALUES (2760, 2759, '520301', '市辖区', 3);
INSERT INTO `m_area` VALUES (2761, 2759, '520302', '红花岗区', 3);
INSERT INTO `m_area` VALUES (2762, 2759, '520303', '汇川区', 3);
INSERT INTO `m_area` VALUES (2763, 2759, '520321', '遵义县', 3);
INSERT INTO `m_area` VALUES (2764, 2759, '520322', '桐梓县', 3);
INSERT INTO `m_area` VALUES (2765, 2759, '520323', '绥阳县', 3);
INSERT INTO `m_area` VALUES (2766, 2759, '520324', '正安县', 3);
INSERT INTO `m_area` VALUES (2767, 2759, '520325', '道真仡佬族苗族自治县', 3);
INSERT INTO `m_area` VALUES (2768, 2759, '520326', '务川仡佬族苗族自治县', 3);
INSERT INTO `m_area` VALUES (2769, 2759, '520327', '凤冈县', 3);
INSERT INTO `m_area` VALUES (2770, 2759, '520328', '湄潭县', 3);
INSERT INTO `m_area` VALUES (2771, 2759, '520329', '余庆县', 3);
INSERT INTO `m_area` VALUES (2772, 2759, '520330', '习水县', 3);
INSERT INTO `m_area` VALUES (2773, 2759, '520381', '赤水市', 3);
INSERT INTO `m_area` VALUES (2774, 2759, '520382', '仁怀市', 3);
INSERT INTO `m_area` VALUES (2775, 2741, '520400', '安顺市', 2);
INSERT INTO `m_area` VALUES (2776, 2775, '520401', '市辖区', 3);
INSERT INTO `m_area` VALUES (2777, 2775, '520402', '西秀区', 3);
INSERT INTO `m_area` VALUES (2778, 2775, '520421', '平坝县', 3);
INSERT INTO `m_area` VALUES (2779, 2775, '520422', '普定县', 3);
INSERT INTO `m_area` VALUES (2780, 2775, '520423', '镇宁布依族苗族自治县', 3);
INSERT INTO `m_area` VALUES (2781, 2775, '520424', '关岭布依族苗族自治县', 3);
INSERT INTO `m_area` VALUES (2782, 2775, '520425', '紫云苗族布依族自治县', 3);
INSERT INTO `m_area` VALUES (2783, 2741, '522200', '铜仁地区', 2);
INSERT INTO `m_area` VALUES (2784, 2783, '522201', '铜仁市', 3);
INSERT INTO `m_area` VALUES (2785, 2783, '522222', '江口县', 3);
INSERT INTO `m_area` VALUES (2786, 2783, '522223', '玉屏侗族自治县', 3);
INSERT INTO `m_area` VALUES (2787, 2783, '522224', '石阡县', 3);
INSERT INTO `m_area` VALUES (2788, 2783, '522225', '思南县', 3);
INSERT INTO `m_area` VALUES (2789, 2783, '522226', '印江土家族苗族自治县', 3);
INSERT INTO `m_area` VALUES (2790, 2783, '522227', '德江县', 3);
INSERT INTO `m_area` VALUES (2791, 2783, '522228', '沿河土家族自治县', 3);
INSERT INTO `m_area` VALUES (2792, 2783, '522229', '松桃苗族自治县', 3);
INSERT INTO `m_area` VALUES (2793, 2783, '522230', '万山特区', 3);
INSERT INTO `m_area` VALUES (2794, 2741, '522300', '黔西南布依族苗族自治州', 2);
INSERT INTO `m_area` VALUES (2795, 2794, '522301', '兴义市', 3);
INSERT INTO `m_area` VALUES (2796, 2794, '522322', '兴仁县', 3);
INSERT INTO `m_area` VALUES (2797, 2794, '522323', '普安县', 3);
INSERT INTO `m_area` VALUES (2798, 2794, '522324', '晴隆县', 3);
INSERT INTO `m_area` VALUES (2799, 2794, '522325', '贞丰县', 3);
INSERT INTO `m_area` VALUES (2800, 2794, '522326', '望谟县', 3);
INSERT INTO `m_area` VALUES (2801, 2794, '522327', '册亨县', 3);
INSERT INTO `m_area` VALUES (2802, 2794, '522328', '安龙县', 3);
INSERT INTO `m_area` VALUES (2803, 2741, '522400', '毕节地区', 2);
INSERT INTO `m_area` VALUES (2804, 2803, '522401', '毕节市', 3);
INSERT INTO `m_area` VALUES (2805, 2803, '522422', '大方县', 3);
INSERT INTO `m_area` VALUES (2806, 2803, '522423', '黔西县', 3);
INSERT INTO `m_area` VALUES (2807, 2803, '522424', '金沙县', 3);
INSERT INTO `m_area` VALUES (2808, 2803, '522425', '织金县', 3);
INSERT INTO `m_area` VALUES (2809, 2803, '522426', '纳雍县', 3);
INSERT INTO `m_area` VALUES (2810, 2803, '522427', '威宁彝族回族苗族自治县', 3);
INSERT INTO `m_area` VALUES (2811, 2803, '522428', '赫章县', 3);
INSERT INTO `m_area` VALUES (2812, 2741, '522600', '黔东南苗族侗族自治州', 2);
INSERT INTO `m_area` VALUES (2813, 2812, '522601', '凯里市', 3);
INSERT INTO `m_area` VALUES (2814, 2812, '522622', '黄平县', 3);
INSERT INTO `m_area` VALUES (2815, 2812, '522623', '施秉县', 3);
INSERT INTO `m_area` VALUES (2816, 2812, '522624', '三穗县', 3);
INSERT INTO `m_area` VALUES (2817, 2812, '522625', '镇远县', 3);
INSERT INTO `m_area` VALUES (2818, 2812, '522626', '岑巩县', 3);
INSERT INTO `m_area` VALUES (2819, 2812, '522627', '天柱县', 3);
INSERT INTO `m_area` VALUES (2820, 2812, '522628', '锦屏县', 3);
INSERT INTO `m_area` VALUES (2821, 2812, '522629', '剑河县', 3);
INSERT INTO `m_area` VALUES (2822, 2812, '522630', '台江县', 3);
INSERT INTO `m_area` VALUES (2823, 2812, '522631', '黎平县', 3);
INSERT INTO `m_area` VALUES (2824, 2812, '522632', '榕江县', 3);
INSERT INTO `m_area` VALUES (2825, 2812, '522633', '从江县', 3);
INSERT INTO `m_area` VALUES (2826, 2812, '522634', '雷山县', 3);
INSERT INTO `m_area` VALUES (2827, 2812, '522635', '麻江县', 3);
INSERT INTO `m_area` VALUES (2828, 2812, '522636', '丹寨县', 3);
INSERT INTO `m_area` VALUES (2829, 2741, '522700', '黔南布依族苗族自治州', 2);
INSERT INTO `m_area` VALUES (2830, 2829, '522701', '都匀市', 3);
INSERT INTO `m_area` VALUES (2831, 2829, '522702', '福泉市', 3);
INSERT INTO `m_area` VALUES (2832, 2829, '522722', '荔波县', 3);
INSERT INTO `m_area` VALUES (2833, 2829, '522723', '贵定县', 3);
INSERT INTO `m_area` VALUES (2834, 2829, '522725', '瓮安县', 3);
INSERT INTO `m_area` VALUES (2835, 2829, '522726', '独山县', 3);
INSERT INTO `m_area` VALUES (2836, 2829, '522727', '平塘县', 3);
INSERT INTO `m_area` VALUES (2837, 2829, '522728', '罗甸县', 3);
INSERT INTO `m_area` VALUES (2838, 2829, '522729', '长顺县', 3);
INSERT INTO `m_area` VALUES (2839, 2829, '522730', '龙里县', 3);
INSERT INTO `m_area` VALUES (2840, 2829, '522731', '惠水县', 3);
INSERT INTO `m_area` VALUES (2841, 2829, '522732', '三都水族自治县', 3);
INSERT INTO `m_area` VALUES (2842, 0, '530000', '云南省', 1);
INSERT INTO `m_area` VALUES (2843, 2842, '530100', '昆明市', 2);
INSERT INTO `m_area` VALUES (2844, 2843, '530101', '市辖区', 3);
INSERT INTO `m_area` VALUES (2845, 2843, '530102', '五华区', 3);
INSERT INTO `m_area` VALUES (2846, 2843, '530103', '盘龙区', 3);
INSERT INTO `m_area` VALUES (2847, 2843, '530111', '官渡区', 3);
INSERT INTO `m_area` VALUES (2848, 2843, '530112', '西山区', 3);
INSERT INTO `m_area` VALUES (2849, 2843, '530113', '东川区', 3);
INSERT INTO `m_area` VALUES (2850, 2843, '530121', '呈贡县', 3);
INSERT INTO `m_area` VALUES (2851, 2843, '530122', '晋宁县', 3);
INSERT INTO `m_area` VALUES (2852, 2843, '530124', '富民县', 3);
INSERT INTO `m_area` VALUES (2853, 2843, '530125', '宜良县', 3);
INSERT INTO `m_area` VALUES (2854, 2843, '530126', '石林彝族自治县', 3);
INSERT INTO `m_area` VALUES (2855, 2843, '530127', '嵩明县', 3);
INSERT INTO `m_area` VALUES (2856, 2843, '530128', '禄劝彝族苗族自治县', 3);
INSERT INTO `m_area` VALUES (2857, 2843, '530129', '寻甸回族彝族自治县', 3);
INSERT INTO `m_area` VALUES (2858, 2843, '530181', '安宁市', 3);
INSERT INTO `m_area` VALUES (2859, 2842, '530300', '曲靖市', 2);
INSERT INTO `m_area` VALUES (2860, 2859, '530301', '市辖区', 3);
INSERT INTO `m_area` VALUES (2861, 2859, '530302', '麒麟区', 3);
INSERT INTO `m_area` VALUES (2862, 2859, '530321', '马龙县', 3);
INSERT INTO `m_area` VALUES (2863, 2859, '530322', '陆良县', 3);
INSERT INTO `m_area` VALUES (2864, 2859, '530323', '师宗县', 3);
INSERT INTO `m_area` VALUES (2865, 2859, '530324', '罗平县', 3);
INSERT INTO `m_area` VALUES (2866, 2859, '530325', '富源县', 3);
INSERT INTO `m_area` VALUES (2867, 2859, '530326', '会泽县', 3);
INSERT INTO `m_area` VALUES (2868, 2859, '530328', '沾益县', 3);
INSERT INTO `m_area` VALUES (2869, 2859, '530381', '宣威市', 3);
INSERT INTO `m_area` VALUES (2870, 2842, '530400', '玉溪市', 2);
INSERT INTO `m_area` VALUES (2871, 2870, '530401', '市辖区', 3);
INSERT INTO `m_area` VALUES (2872, 2870, '530402', '红塔区', 3);
INSERT INTO `m_area` VALUES (2873, 2870, '530421', '江川县', 3);
INSERT INTO `m_area` VALUES (2874, 2870, '530422', '澄江县', 3);
INSERT INTO `m_area` VALUES (2875, 2870, '530423', '通海县', 3);
INSERT INTO `m_area` VALUES (2876, 2870, '530424', '华宁县', 3);
INSERT INTO `m_area` VALUES (2877, 2870, '530425', '易门县', 3);
INSERT INTO `m_area` VALUES (2878, 2870, '530426', '峨山彝族自治县', 3);
INSERT INTO `m_area` VALUES (2879, 2870, '530427', '新平彝族傣族自治县', 3);
INSERT INTO `m_area` VALUES (2880, 2870, '530428', '元江哈尼族彝族傣族自治县', 3);
INSERT INTO `m_area` VALUES (2881, 2842, '530500', '保山市', 2);
INSERT INTO `m_area` VALUES (2882, 2881, '530501', '市辖区', 3);
INSERT INTO `m_area` VALUES (2883, 2881, '530502', '隆阳区', 3);
INSERT INTO `m_area` VALUES (2884, 2881, '530521', '施甸县', 3);
INSERT INTO `m_area` VALUES (2885, 2881, '530522', '腾冲县', 3);
INSERT INTO `m_area` VALUES (2886, 2881, '530523', '龙陵县', 3);
INSERT INTO `m_area` VALUES (2887, 2881, '530524', '昌宁县', 3);
INSERT INTO `m_area` VALUES (2888, 2842, '530600', '昭通市', 2);
INSERT INTO `m_area` VALUES (2889, 2888, '530601', '市辖区', 3);
INSERT INTO `m_area` VALUES (2890, 2888, '530602', '昭阳区', 3);
INSERT INTO `m_area` VALUES (2891, 2888, '530621', '鲁甸县', 3);
INSERT INTO `m_area` VALUES (2892, 2888, '530622', '巧家县', 3);
INSERT INTO `m_area` VALUES (2893, 2888, '530623', '盐津县', 3);
INSERT INTO `m_area` VALUES (2894, 2888, '530624', '大关县', 3);
INSERT INTO `m_area` VALUES (2895, 2888, '530625', '永善县', 3);
INSERT INTO `m_area` VALUES (2896, 2888, '530626', '绥江县', 3);
INSERT INTO `m_area` VALUES (2897, 2888, '530627', '镇雄县', 3);
INSERT INTO `m_area` VALUES (2898, 2888, '530628', '彝良县', 3);
INSERT INTO `m_area` VALUES (2899, 2888, '530629', '威信县', 3);
INSERT INTO `m_area` VALUES (2900, 2888, '530630', '水富县', 3);
INSERT INTO `m_area` VALUES (2901, 2842, '530700', '丽江市', 2);
INSERT INTO `m_area` VALUES (2902, 2901, '530701', '市辖区', 3);
INSERT INTO `m_area` VALUES (2903, 2901, '530702', '古城区', 3);
INSERT INTO `m_area` VALUES (2904, 2901, '530721', '玉龙纳西族自治县', 3);
INSERT INTO `m_area` VALUES (2905, 2901, '530722', '永胜县', 3);
INSERT INTO `m_area` VALUES (2906, 2901, '530723', '华坪县', 3);
INSERT INTO `m_area` VALUES (2907, 2901, '530724', '宁蒗彝族自治县', 3);
INSERT INTO `m_area` VALUES (2908, 2842, '530800', '思茅市', 2);
INSERT INTO `m_area` VALUES (2909, 2908, '530801', '市辖区', 3);
INSERT INTO `m_area` VALUES (2910, 2908, '530802', '翠云区', 3);
INSERT INTO `m_area` VALUES (2911, 2908, '530821', '普洱哈尼族彝族自治县', 3);
INSERT INTO `m_area` VALUES (2912, 2908, '530822', '墨江哈尼族自治县', 3);
INSERT INTO `m_area` VALUES (2913, 2908, '530823', '景东彝族自治县', 3);
INSERT INTO `m_area` VALUES (2914, 2908, '530824', '景谷傣族彝族自治县', 3);
INSERT INTO `m_area` VALUES (2915, 2908, '530825', '镇沅彝族哈尼族拉祜族自治县', 3);
INSERT INTO `m_area` VALUES (2916, 2908, '530826', '江城哈尼族彝族自治县', 3);
INSERT INTO `m_area` VALUES (2917, 2908, '530827', '孟连傣族拉祜族佤族自治县', 3);
INSERT INTO `m_area` VALUES (2918, 2908, '530828', '澜沧拉祜族自治县', 3);
INSERT INTO `m_area` VALUES (2919, 2908, '530829', '西盟佤族自治县', 3);
INSERT INTO `m_area` VALUES (2920, 2842, '530900', '临沧市', 2);
INSERT INTO `m_area` VALUES (2921, 2920, '530901', '市辖区', 3);
INSERT INTO `m_area` VALUES (2922, 2920, '530902', '临翔区', 3);
INSERT INTO `m_area` VALUES (2923, 2920, '530921', '凤庆县', 3);
INSERT INTO `m_area` VALUES (2924, 2920, '530922', '云　县', 3);
INSERT INTO `m_area` VALUES (2925, 2920, '530923', '永德县', 3);
INSERT INTO `m_area` VALUES (2926, 2920, '530924', '镇康县', 3);
INSERT INTO `m_area` VALUES (2927, 2920, '530925', '双江拉祜族佤族布朗族傣族自治县', 3);
INSERT INTO `m_area` VALUES (2928, 2920, '530926', '耿马傣族佤族自治县', 3);
INSERT INTO `m_area` VALUES (2929, 2920, '530927', '沧源佤族自治县', 3);
INSERT INTO `m_area` VALUES (2930, 2842, '532300', '楚雄彝族自治州', 2);
INSERT INTO `m_area` VALUES (2931, 2930, '532301', '楚雄市', 3);
INSERT INTO `m_area` VALUES (2932, 2930, '532322', '双柏县', 3);
INSERT INTO `m_area` VALUES (2933, 2930, '532323', '牟定县', 3);
INSERT INTO `m_area` VALUES (2934, 2930, '532324', '南华县', 3);
INSERT INTO `m_area` VALUES (2935, 2930, '532325', '姚安县', 3);
INSERT INTO `m_area` VALUES (2936, 2930, '532326', '大姚县', 3);
INSERT INTO `m_area` VALUES (2937, 2930, '532327', '永仁县', 3);
INSERT INTO `m_area` VALUES (2938, 2930, '532328', '元谋县', 3);
INSERT INTO `m_area` VALUES (2939, 2930, '532329', '武定县', 3);
INSERT INTO `m_area` VALUES (2940, 2930, '532331', '禄丰县', 3);
INSERT INTO `m_area` VALUES (2941, 2842, '532500', '红河哈尼族彝族自治州', 2);
INSERT INTO `m_area` VALUES (2942, 2941, '532501', '个旧市', 3);
INSERT INTO `m_area` VALUES (2943, 2941, '532502', '开远市', 3);
INSERT INTO `m_area` VALUES (2944, 2941, '532522', '蒙自县', 3);
INSERT INTO `m_area` VALUES (2945, 2941, '532523', '屏边苗族自治县', 3);
INSERT INTO `m_area` VALUES (2946, 2941, '532524', '建水县', 3);
INSERT INTO `m_area` VALUES (2947, 2941, '532525', '石屏县', 3);
INSERT INTO `m_area` VALUES (2948, 2941, '532526', '弥勒县', 3);
INSERT INTO `m_area` VALUES (2949, 2941, '532527', '泸西县', 3);
INSERT INTO `m_area` VALUES (2950, 2941, '532528', '元阳县', 3);
INSERT INTO `m_area` VALUES (2951, 2941, '532529', '红河县', 3);
INSERT INTO `m_area` VALUES (2952, 2941, '532530', '金平苗族瑶族傣族自治县', 3);
INSERT INTO `m_area` VALUES (2953, 2941, '532531', '绿春县', 3);
INSERT INTO `m_area` VALUES (2954, 2941, '532532', '河口瑶族自治县', 3);
INSERT INTO `m_area` VALUES (2955, 2842, '532600', '文山壮族苗族自治州', 2);
INSERT INTO `m_area` VALUES (2956, 2955, '532621', '文山县', 3);
INSERT INTO `m_area` VALUES (2957, 2955, '532622', '砚山县', 3);
INSERT INTO `m_area` VALUES (2958, 2955, '532623', '西畴县', 3);
INSERT INTO `m_area` VALUES (2959, 2955, '532624', '麻栗坡县', 3);
INSERT INTO `m_area` VALUES (2960, 2955, '532625', '马关县', 3);
INSERT INTO `m_area` VALUES (2961, 2955, '532626', '丘北县', 3);
INSERT INTO `m_area` VALUES (2962, 2955, '532627', '广南县', 3);
INSERT INTO `m_area` VALUES (2963, 2955, '532628', '富宁县', 3);
INSERT INTO `m_area` VALUES (2964, 2842, '532800', '西双版纳傣族自治州', 2);
INSERT INTO `m_area` VALUES (2965, 2964, '532801', '景洪市', 3);
INSERT INTO `m_area` VALUES (2966, 2964, '532822', '勐海县', 3);
INSERT INTO `m_area` VALUES (2967, 2964, '532823', '勐腊县', 3);
INSERT INTO `m_area` VALUES (2968, 2842, '532900', '大理白族自治州', 2);
INSERT INTO `m_area` VALUES (2969, 2968, '532901', '大理市', 3);
INSERT INTO `m_area` VALUES (2970, 2968, '532922', '漾濞彝族自治县', 3);
INSERT INTO `m_area` VALUES (2971, 2968, '532923', '祥云县', 3);
INSERT INTO `m_area` VALUES (2972, 2968, '532924', '宾川县', 3);
INSERT INTO `m_area` VALUES (2973, 2968, '532925', '弥渡县', 3);
INSERT INTO `m_area` VALUES (2974, 2968, '532926', '南涧彝族自治县', 3);
INSERT INTO `m_area` VALUES (2975, 2968, '532927', '巍山彝族回族自治县', 3);
INSERT INTO `m_area` VALUES (2976, 2968, '532928', '永平县', 3);
INSERT INTO `m_area` VALUES (2977, 2968, '532929', '云龙县', 3);
INSERT INTO `m_area` VALUES (2978, 2968, '532930', '洱源县', 3);
INSERT INTO `m_area` VALUES (2979, 2968, '532931', '剑川县', 3);
INSERT INTO `m_area` VALUES (2980, 2968, '532932', '鹤庆县', 3);
INSERT INTO `m_area` VALUES (2981, 2842, '533100', '德宏傣族景颇族自治州', 2);
INSERT INTO `m_area` VALUES (2982, 2981, '533102', '瑞丽市', 3);
INSERT INTO `m_area` VALUES (2983, 2981, '533103', '潞西市', 3);
INSERT INTO `m_area` VALUES (2984, 2981, '533122', '梁河县', 3);
INSERT INTO `m_area` VALUES (2985, 2981, '533123', '盈江县', 3);
INSERT INTO `m_area` VALUES (2986, 2981, '533124', '陇川县', 3);
INSERT INTO `m_area` VALUES (2987, 2842, '533300', '怒江傈僳族自治州', 2);
INSERT INTO `m_area` VALUES (2988, 2987, '533321', '泸水县', 3);
INSERT INTO `m_area` VALUES (2989, 2987, '533323', '福贡县', 3);
INSERT INTO `m_area` VALUES (2990, 2987, '533324', '贡山独龙族怒族自治县', 3);
INSERT INTO `m_area` VALUES (2991, 2987, '533325', '兰坪白族普米族自治县', 3);
INSERT INTO `m_area` VALUES (2992, 2842, '533400', '迪庆藏族自治州', 2);
INSERT INTO `m_area` VALUES (2993, 2992, '533421', '香格里拉县', 3);
INSERT INTO `m_area` VALUES (2994, 2992, '533422', '德钦县', 3);
INSERT INTO `m_area` VALUES (2995, 2992, '533423', '维西傈僳族自治县', 3);
INSERT INTO `m_area` VALUES (2996, 0, '540000', '西藏自治区', 1);
INSERT INTO `m_area` VALUES (2997, 2996, '540100', '拉萨市', 2);
INSERT INTO `m_area` VALUES (2998, 2997, '540101', '市辖区', 3);
INSERT INTO `m_area` VALUES (2999, 2997, '540102', '城关区', 3);
INSERT INTO `m_area` VALUES (3000, 2997, '540121', '林周县', 3);
INSERT INTO `m_area` VALUES (3001, 2997, '540122', '当雄县', 3);
INSERT INTO `m_area` VALUES (3002, 2997, '540123', '尼木县', 3);
INSERT INTO `m_area` VALUES (3003, 2997, '540124', '曲水县', 3);
INSERT INTO `m_area` VALUES (3004, 2997, '540125', '堆龙德庆县', 3);
INSERT INTO `m_area` VALUES (3005, 2997, '540126', '达孜县', 3);
INSERT INTO `m_area` VALUES (3006, 2997, '540127', '墨竹工卡县', 3);
INSERT INTO `m_area` VALUES (3007, 2996, '542100', '昌都地区', 2);
INSERT INTO `m_area` VALUES (3008, 3007, '542121', '昌都县', 3);
INSERT INTO `m_area` VALUES (3009, 3007, '542122', '江达县', 3);
INSERT INTO `m_area` VALUES (3010, 3007, '542123', '贡觉县', 3);
INSERT INTO `m_area` VALUES (3011, 3007, '542124', '类乌齐县', 3);
INSERT INTO `m_area` VALUES (3012, 3007, '542125', '丁青县', 3);
INSERT INTO `m_area` VALUES (3013, 3007, '542126', '察雅县', 3);
INSERT INTO `m_area` VALUES (3014, 3007, '542127', '八宿县', 3);
INSERT INTO `m_area` VALUES (3015, 3007, '542128', '左贡县', 3);
INSERT INTO `m_area` VALUES (3016, 3007, '542129', '芒康县', 3);
INSERT INTO `m_area` VALUES (3017, 3007, '542132', '洛隆县', 3);
INSERT INTO `m_area` VALUES (3018, 3007, '542133', '边坝县', 3);
INSERT INTO `m_area` VALUES (3019, 2996, '542200', '山南地区', 2);
INSERT INTO `m_area` VALUES (3020, 3019, '542221', '乃东县', 3);
INSERT INTO `m_area` VALUES (3021, 3019, '542222', '扎囊县', 3);
INSERT INTO `m_area` VALUES (3022, 3019, '542223', '贡嘎县', 3);
INSERT INTO `m_area` VALUES (3023, 3019, '542224', '桑日县', 3);
INSERT INTO `m_area` VALUES (3024, 3019, '542225', '琼结县', 3);
INSERT INTO `m_area` VALUES (3025, 3019, '542226', '曲松县', 3);
INSERT INTO `m_area` VALUES (3026, 3019, '542227', '措美县', 3);
INSERT INTO `m_area` VALUES (3027, 3019, '542228', '洛扎县', 3);
INSERT INTO `m_area` VALUES (3028, 3019, '542229', '加查县', 3);
INSERT INTO `m_area` VALUES (3029, 3019, '542231', '隆子县', 3);
INSERT INTO `m_area` VALUES (3030, 3019, '542232', '错那县', 3);
INSERT INTO `m_area` VALUES (3031, 3019, '542233', '浪卡子县', 3);
INSERT INTO `m_area` VALUES (3032, 2996, '542300', '日喀则地区', 2);
INSERT INTO `m_area` VALUES (3033, 3032, '542301', '日喀则市', 3);
INSERT INTO `m_area` VALUES (3034, 3032, '542322', '南木林县', 3);
INSERT INTO `m_area` VALUES (3035, 3032, '542323', '江孜县', 3);
INSERT INTO `m_area` VALUES (3036, 3032, '542324', '定日县', 3);
INSERT INTO `m_area` VALUES (3037, 3032, '542325', '萨迦县', 3);
INSERT INTO `m_area` VALUES (3038, 3032, '542326', '拉孜县', 3);
INSERT INTO `m_area` VALUES (3039, 3032, '542327', '昂仁县', 3);
INSERT INTO `m_area` VALUES (3040, 3032, '542328', '谢通门县', 3);
INSERT INTO `m_area` VALUES (3041, 3032, '542329', '白朗县', 3);
INSERT INTO `m_area` VALUES (3042, 3032, '542330', '仁布县', 3);
INSERT INTO `m_area` VALUES (3043, 3032, '542331', '康马县', 3);
INSERT INTO `m_area` VALUES (3044, 3032, '542332', '定结县', 3);
INSERT INTO `m_area` VALUES (3045, 3032, '542333', '仲巴县', 3);
INSERT INTO `m_area` VALUES (3046, 3032, '542334', '亚东县', 3);
INSERT INTO `m_area` VALUES (3047, 3032, '542335', '吉隆县', 3);
INSERT INTO `m_area` VALUES (3048, 3032, '542336', '聂拉木县', 3);
INSERT INTO `m_area` VALUES (3049, 3032, '542337', '萨嘎县', 3);
INSERT INTO `m_area` VALUES (3050, 3032, '542338', '岗巴县', 3);
INSERT INTO `m_area` VALUES (3051, 2996, '542400', '那曲地区', 2);
INSERT INTO `m_area` VALUES (3052, 3051, '542421', '那曲县', 3);
INSERT INTO `m_area` VALUES (3053, 3051, '542422', '嘉黎县', 3);
INSERT INTO `m_area` VALUES (3054, 3051, '542423', '比如县', 3);
INSERT INTO `m_area` VALUES (3055, 3051, '542424', '聂荣县', 3);
INSERT INTO `m_area` VALUES (3056, 3051, '542425', '安多县', 3);
INSERT INTO `m_area` VALUES (3057, 3051, '542426', '申扎县', 3);
INSERT INTO `m_area` VALUES (3058, 3051, '542427', '索　县', 3);
INSERT INTO `m_area` VALUES (3059, 3051, '542428', '班戈县', 3);
INSERT INTO `m_area` VALUES (3060, 3051, '542429', '巴青县', 3);
INSERT INTO `m_area` VALUES (3061, 3051, '542430', '尼玛县', 3);
INSERT INTO `m_area` VALUES (3062, 2996, '542500', '阿里地区', 2);
INSERT INTO `m_area` VALUES (3063, 3062, '542521', '普兰县', 3);
INSERT INTO `m_area` VALUES (3064, 3062, '542522', '札达县', 3);
INSERT INTO `m_area` VALUES (3065, 3062, '542523', '噶尔县', 3);
INSERT INTO `m_area` VALUES (3066, 3062, '542524', '日土县', 3);
INSERT INTO `m_area` VALUES (3067, 3062, '542525', '革吉县', 3);
INSERT INTO `m_area` VALUES (3068, 3062, '542526', '改则县', 3);
INSERT INTO `m_area` VALUES (3069, 3062, '542527', '措勤县', 3);
INSERT INTO `m_area` VALUES (3070, 2996, '542600', '林芝地区', 2);
INSERT INTO `m_area` VALUES (3071, 3070, '542621', '林芝县', 3);
INSERT INTO `m_area` VALUES (3072, 3070, '542622', '工布江达县', 3);
INSERT INTO `m_area` VALUES (3073, 3070, '542623', '米林县', 3);
INSERT INTO `m_area` VALUES (3074, 3070, '542624', '墨脱县', 3);
INSERT INTO `m_area` VALUES (3075, 3070, '542625', '波密县', 3);
INSERT INTO `m_area` VALUES (3076, 3070, '542626', '察隅县', 3);
INSERT INTO `m_area` VALUES (3077, 3070, '542627', '朗　县', 3);
INSERT INTO `m_area` VALUES (3078, 0, '610000', '陕西省', 1);
INSERT INTO `m_area` VALUES (3079, 3078, '610100', '西安市', 2);
INSERT INTO `m_area` VALUES (3080, 3079, '610101', '市辖区', 3);
INSERT INTO `m_area` VALUES (3081, 3079, '610102', '新城区', 3);
INSERT INTO `m_area` VALUES (3082, 3079, '610103', '碑林区', 3);
INSERT INTO `m_area` VALUES (3083, 3079, '610104', '莲湖区', 3);
INSERT INTO `m_area` VALUES (3084, 3079, '610111', '灞桥区', 3);
INSERT INTO `m_area` VALUES (3085, 3079, '610112', '未央区', 3);
INSERT INTO `m_area` VALUES (3086, 3079, '610113', '雁塔区', 3);
INSERT INTO `m_area` VALUES (3087, 3079, '610114', '阎良区', 3);
INSERT INTO `m_area` VALUES (3088, 3079, '610115', '临潼区', 3);
INSERT INTO `m_area` VALUES (3089, 3079, '610116', '长安区', 3);
INSERT INTO `m_area` VALUES (3090, 3079, '610122', '蓝田县', 3);
INSERT INTO `m_area` VALUES (3091, 3079, '610124', '周至县', 3);
INSERT INTO `m_area` VALUES (3092, 3079, '610125', '户　县', 3);
INSERT INTO `m_area` VALUES (3093, 3079, '610126', '高陵县', 3);
INSERT INTO `m_area` VALUES (3094, 3078, '610200', '铜川市', 2);
INSERT INTO `m_area` VALUES (3095, 3094, '610201', '市辖区', 3);
INSERT INTO `m_area` VALUES (3096, 3094, '610202', '王益区', 3);
INSERT INTO `m_area` VALUES (3097, 3094, '610203', '印台区', 3);
INSERT INTO `m_area` VALUES (3098, 3094, '610204', '耀州区', 3);
INSERT INTO `m_area` VALUES (3099, 3094, '610222', '宜君县', 3);
INSERT INTO `m_area` VALUES (3100, 3078, '610300', '宝鸡市', 2);
INSERT INTO `m_area` VALUES (3101, 3100, '610301', '市辖区', 3);
INSERT INTO `m_area` VALUES (3102, 3100, '610302', '渭滨区', 3);
INSERT INTO `m_area` VALUES (3103, 3100, '610303', '金台区', 3);
INSERT INTO `m_area` VALUES (3104, 3100, '610304', '陈仓区', 3);
INSERT INTO `m_area` VALUES (3105, 3100, '610322', '凤翔县', 3);
INSERT INTO `m_area` VALUES (3106, 3100, '610323', '岐山县', 3);
INSERT INTO `m_area` VALUES (3107, 3100, '610324', '扶风县', 3);
INSERT INTO `m_area` VALUES (3108, 3100, '610326', '眉　县', 3);
INSERT INTO `m_area` VALUES (3109, 3100, '610327', '陇　县', 3);
INSERT INTO `m_area` VALUES (3110, 3100, '610328', '千阳县', 3);
INSERT INTO `m_area` VALUES (3111, 3100, '610329', '麟游县', 3);
INSERT INTO `m_area` VALUES (3112, 3100, '610330', '凤　县', 3);
INSERT INTO `m_area` VALUES (3113, 3100, '610331', '太白县', 3);
INSERT INTO `m_area` VALUES (3114, 3078, '610400', '咸阳市', 2);
INSERT INTO `m_area` VALUES (3115, 3114, '610401', '市辖区', 3);
INSERT INTO `m_area` VALUES (3116, 3114, '610402', '秦都区', 3);
INSERT INTO `m_area` VALUES (3117, 3114, '610403', '杨凌区', 3);
INSERT INTO `m_area` VALUES (3118, 3114, '610404', '渭城区', 3);
INSERT INTO `m_area` VALUES (3119, 3114, '610422', '三原县', 3);
INSERT INTO `m_area` VALUES (3120, 3114, '610423', '泾阳县', 3);
INSERT INTO `m_area` VALUES (3121, 3114, '610424', '乾　县', 3);
INSERT INTO `m_area` VALUES (3122, 3114, '610425', '礼泉县', 3);
INSERT INTO `m_area` VALUES (3123, 3114, '610426', '永寿县', 3);
INSERT INTO `m_area` VALUES (3124, 3114, '610427', '彬　县', 3);
INSERT INTO `m_area` VALUES (3125, 3114, '610428', '长武县', 3);
INSERT INTO `m_area` VALUES (3126, 3114, '610429', '旬邑县', 3);
INSERT INTO `m_area` VALUES (3127, 3114, '610430', '淳化县', 3);
INSERT INTO `m_area` VALUES (3128, 3114, '610431', '武功县', 3);
INSERT INTO `m_area` VALUES (3129, 3114, '610481', '兴平市', 3);
INSERT INTO `m_area` VALUES (3130, 3078, '610500', '渭南市', 2);
INSERT INTO `m_area` VALUES (3131, 3130, '610501', '市辖区', 3);
INSERT INTO `m_area` VALUES (3132, 3130, '610502', '临渭区', 3);
INSERT INTO `m_area` VALUES (3133, 3130, '610521', '华　县', 3);
INSERT INTO `m_area` VALUES (3134, 3130, '610522', '潼关县', 3);
INSERT INTO `m_area` VALUES (3135, 3130, '610523', '大荔县', 3);
INSERT INTO `m_area` VALUES (3136, 3130, '610524', '合阳县', 3);
INSERT INTO `m_area` VALUES (3137, 3130, '610525', '澄城县', 3);
INSERT INTO `m_area` VALUES (3138, 3130, '610526', '蒲城县', 3);
INSERT INTO `m_area` VALUES (3139, 3130, '610527', '白水县', 3);
INSERT INTO `m_area` VALUES (3140, 3130, '610528', '富平县', 3);
INSERT INTO `m_area` VALUES (3141, 3130, '610581', '韩城市', 3);
INSERT INTO `m_area` VALUES (3142, 3130, '610582', '华阴市', 3);
INSERT INTO `m_area` VALUES (3143, 3078, '610600', '延安市', 2);
INSERT INTO `m_area` VALUES (3144, 3143, '610601', '市辖区', 3);
INSERT INTO `m_area` VALUES (3145, 3143, '610602', '宝塔区', 3);
INSERT INTO `m_area` VALUES (3146, 3143, '610621', '延长县', 3);
INSERT INTO `m_area` VALUES (3147, 3143, '610622', '延川县', 3);
INSERT INTO `m_area` VALUES (3148, 3143, '610623', '子长县', 3);
INSERT INTO `m_area` VALUES (3149, 3143, '610624', '安塞县', 3);
INSERT INTO `m_area` VALUES (3150, 3143, '610625', '志丹县', 3);
INSERT INTO `m_area` VALUES (3151, 3143, '610626', '吴旗县', 3);
INSERT INTO `m_area` VALUES (3152, 3143, '610627', '甘泉县', 3);
INSERT INTO `m_area` VALUES (3153, 3143, '610628', '富　县', 3);
INSERT INTO `m_area` VALUES (3154, 3143, '610629', '洛川县', 3);
INSERT INTO `m_area` VALUES (3155, 3143, '610630', '宜川县', 3);
INSERT INTO `m_area` VALUES (3156, 3143, '610631', '黄龙县', 3);
INSERT INTO `m_area` VALUES (3157, 3143, '610632', '黄陵县', 3);
INSERT INTO `m_area` VALUES (3158, 3078, '610700', '汉中市', 2);
INSERT INTO `m_area` VALUES (3159, 3158, '610701', '市辖区', 3);
INSERT INTO `m_area` VALUES (3160, 3158, '610702', '汉台区', 3);
INSERT INTO `m_area` VALUES (3161, 3158, '610721', '南郑县', 3);
INSERT INTO `m_area` VALUES (3162, 3158, '610722', '城固县', 3);
INSERT INTO `m_area` VALUES (3163, 3158, '610723', '洋　县', 3);
INSERT INTO `m_area` VALUES (3164, 3158, '610724', '西乡县', 3);
INSERT INTO `m_area` VALUES (3165, 3158, '610725', '勉　县', 3);
INSERT INTO `m_area` VALUES (3166, 3158, '610726', '宁强县', 3);
INSERT INTO `m_area` VALUES (3167, 3158, '610727', '略阳县', 3);
INSERT INTO `m_area` VALUES (3168, 3158, '610728', '镇巴县', 3);
INSERT INTO `m_area` VALUES (3169, 3158, '610729', '留坝县', 3);
INSERT INTO `m_area` VALUES (3170, 3158, '610730', '佛坪县', 3);
INSERT INTO `m_area` VALUES (3171, 3078, '610800', '榆林市', 2);
INSERT INTO `m_area` VALUES (3172, 3171, '610801', '市辖区', 3);
INSERT INTO `m_area` VALUES (3173, 3171, '610802', '榆阳区', 3);
INSERT INTO `m_area` VALUES (3174, 3171, '610821', '神木县', 3);
INSERT INTO `m_area` VALUES (3175, 3171, '610822', '府谷县', 3);
INSERT INTO `m_area` VALUES (3176, 3171, '610823', '横山县', 3);
INSERT INTO `m_area` VALUES (3177, 3171, '610824', '靖边县', 3);
INSERT INTO `m_area` VALUES (3178, 3171, '610825', '定边县', 3);
INSERT INTO `m_area` VALUES (3179, 3171, '610826', '绥德县', 3);
INSERT INTO `m_area` VALUES (3180, 3171, '610827', '米脂县', 3);
INSERT INTO `m_area` VALUES (3181, 3171, '610828', '佳　县', 3);
INSERT INTO `m_area` VALUES (3182, 3171, '610829', '吴堡县', 3);
INSERT INTO `m_area` VALUES (3183, 3171, '610830', '清涧县', 3);
INSERT INTO `m_area` VALUES (3184, 3171, '610831', '子洲县', 3);
INSERT INTO `m_area` VALUES (3185, 3078, '610900', '安康市', 2);
INSERT INTO `m_area` VALUES (3186, 3185, '610901', '市辖区', 3);
INSERT INTO `m_area` VALUES (3187, 3185, '610902', '汉滨区', 3);
INSERT INTO `m_area` VALUES (3188, 3185, '610921', '汉阴县', 3);
INSERT INTO `m_area` VALUES (3189, 3185, '610922', '石泉县', 3);
INSERT INTO `m_area` VALUES (3190, 3185, '610923', '宁陕县', 3);
INSERT INTO `m_area` VALUES (3191, 3185, '610924', '紫阳县', 3);
INSERT INTO `m_area` VALUES (3192, 3185, '610925', '岚皋县', 3);
INSERT INTO `m_area` VALUES (3193, 3185, '610926', '平利县', 3);
INSERT INTO `m_area` VALUES (3194, 3185, '610927', '镇坪县', 3);
INSERT INTO `m_area` VALUES (3195, 3185, '610928', '旬阳县', 3);
INSERT INTO `m_area` VALUES (3196, 3185, '610929', '白河县', 3);
INSERT INTO `m_area` VALUES (3197, 3078, '611000', '商洛市', 2);
INSERT INTO `m_area` VALUES (3198, 3197, '611001', '市辖区', 3);
INSERT INTO `m_area` VALUES (3199, 3197, '611002', '商州区', 3);
INSERT INTO `m_area` VALUES (3200, 3197, '611021', '洛南县', 3);
INSERT INTO `m_area` VALUES (3201, 3197, '611022', '丹凤县', 3);
INSERT INTO `m_area` VALUES (3202, 3197, '611023', '商南县', 3);
INSERT INTO `m_area` VALUES (3203, 3197, '611024', '山阳县', 3);
INSERT INTO `m_area` VALUES (3204, 3197, '611025', '镇安县', 3);
INSERT INTO `m_area` VALUES (3205, 3197, '611026', '柞水县', 3);
INSERT INTO `m_area` VALUES (3206, 0, '620000', '甘肃省', 1);
INSERT INTO `m_area` VALUES (3207, 3206, '620100', '兰州市', 2);
INSERT INTO `m_area` VALUES (3208, 3207, '620101', '市辖区', 3);
INSERT INTO `m_area` VALUES (3209, 3207, '620102', '城关区', 3);
INSERT INTO `m_area` VALUES (3210, 3207, '620103', '七里河区', 3);
INSERT INTO `m_area` VALUES (3211, 3207, '620104', '西固区', 3);
INSERT INTO `m_area` VALUES (3212, 3207, '620105', '安宁区', 3);
INSERT INTO `m_area` VALUES (3213, 3207, '620111', '红古区', 3);
INSERT INTO `m_area` VALUES (3214, 3207, '620121', '永登县', 3);
INSERT INTO `m_area` VALUES (3215, 3207, '620122', '皋兰县', 3);
INSERT INTO `m_area` VALUES (3216, 3207, '620123', '榆中县', 3);
INSERT INTO `m_area` VALUES (3217, 3206, '620200', '嘉峪关市', 2);
INSERT INTO `m_area` VALUES (3218, 3217, '620201', '市辖区', 3);
INSERT INTO `m_area` VALUES (3219, 3206, '620300', '金昌市', 2);
INSERT INTO `m_area` VALUES (3220, 3219, '620301', '市辖区', 3);
INSERT INTO `m_area` VALUES (3221, 3219, '620302', '金川区', 3);
INSERT INTO `m_area` VALUES (3222, 3219, '620321', '永昌县', 3);
INSERT INTO `m_area` VALUES (3223, 3206, '620400', '白银市', 2);
INSERT INTO `m_area` VALUES (3224, 3223, '620401', '市辖区', 3);
INSERT INTO `m_area` VALUES (3225, 3223, '620402', '白银区', 3);
INSERT INTO `m_area` VALUES (3226, 3223, '620403', '平川区', 3);
INSERT INTO `m_area` VALUES (3227, 3223, '620421', '靖远县', 3);
INSERT INTO `m_area` VALUES (3228, 3223, '620422', '会宁县', 3);
INSERT INTO `m_area` VALUES (3229, 3223, '620423', '景泰县', 3);
INSERT INTO `m_area` VALUES (3230, 3206, '620500', '天水市', 2);
INSERT INTO `m_area` VALUES (3231, 3230, '620501', '市辖区', 3);
INSERT INTO `m_area` VALUES (3232, 3230, '620502', '秦城区', 3);
INSERT INTO `m_area` VALUES (3233, 3230, '620503', '北道区', 3);
INSERT INTO `m_area` VALUES (3234, 3230, '620521', '清水县', 3);
INSERT INTO `m_area` VALUES (3235, 3230, '620522', '秦安县', 3);
INSERT INTO `m_area` VALUES (3236, 3230, '620523', '甘谷县', 3);
INSERT INTO `m_area` VALUES (3237, 3230, '620524', '武山县', 3);
INSERT INTO `m_area` VALUES (3238, 3230, '620525', '张家川回族自治县', 3);
INSERT INTO `m_area` VALUES (3239, 3206, '620600', '武威市', 2);
INSERT INTO `m_area` VALUES (3240, 3239, '620601', '市辖区', 3);
INSERT INTO `m_area` VALUES (3241, 3239, '620602', '凉州区', 3);
INSERT INTO `m_area` VALUES (3242, 3239, '620621', '民勤县', 3);
INSERT INTO `m_area` VALUES (3243, 3239, '620622', '古浪县', 3);
INSERT INTO `m_area` VALUES (3244, 3239, '620623', '天祝藏族自治县', 3);
INSERT INTO `m_area` VALUES (3245, 3206, '620700', '张掖市', 2);
INSERT INTO `m_area` VALUES (3246, 3245, '620701', '市辖区', 3);
INSERT INTO `m_area` VALUES (3247, 3245, '620702', '甘州区', 3);
INSERT INTO `m_area` VALUES (3248, 3245, '620721', '肃南裕固族自治县', 3);
INSERT INTO `m_area` VALUES (3249, 3245, '620722', '民乐县', 3);
INSERT INTO `m_area` VALUES (3250, 3245, '620723', '临泽县', 3);
INSERT INTO `m_area` VALUES (3251, 3245, '620724', '高台县', 3);
INSERT INTO `m_area` VALUES (3252, 3245, '620725', '山丹县', 3);
INSERT INTO `m_area` VALUES (3253, 3206, '620800', '平凉市', 2);
INSERT INTO `m_area` VALUES (3254, 3253, '620801', '市辖区', 3);
INSERT INTO `m_area` VALUES (3255, 3253, '620802', '崆峒区', 3);
INSERT INTO `m_area` VALUES (3256, 3253, '620821', '泾川县', 3);
INSERT INTO `m_area` VALUES (3257, 3253, '620822', '灵台县', 3);
INSERT INTO `m_area` VALUES (3258, 3253, '620823', '崇信县', 3);
INSERT INTO `m_area` VALUES (3259, 3253, '620824', '华亭县', 3);
INSERT INTO `m_area` VALUES (3260, 3253, '620825', '庄浪县', 3);
INSERT INTO `m_area` VALUES (3261, 3253, '620826', '静宁县', 3);
INSERT INTO `m_area` VALUES (3262, 3206, '620900', '酒泉市', 2);
INSERT INTO `m_area` VALUES (3263, 3262, '620901', '市辖区', 3);
INSERT INTO `m_area` VALUES (3264, 3262, '620902', '肃州区', 3);
INSERT INTO `m_area` VALUES (3265, 3262, '620921', '金塔县', 3);
INSERT INTO `m_area` VALUES (3266, 3262, '620922', '安西县', 3);
INSERT INTO `m_area` VALUES (3267, 3262, '620923', '肃北蒙古族自治县', 3);
INSERT INTO `m_area` VALUES (3268, 3262, '620924', '阿克塞哈萨克族自治县', 3);
INSERT INTO `m_area` VALUES (3269, 3262, '620981', '玉门市', 3);
INSERT INTO `m_area` VALUES (3270, 3262, '620982', '敦煌市', 3);
INSERT INTO `m_area` VALUES (3271, 3206, '621000', '庆阳市', 2);
INSERT INTO `m_area` VALUES (3272, 3271, '621001', '市辖区', 3);
INSERT INTO `m_area` VALUES (3273, 3271, '621002', '西峰区', 3);
INSERT INTO `m_area` VALUES (3274, 3271, '621021', '庆城县', 3);
INSERT INTO `m_area` VALUES (3275, 3271, '621022', '环　县', 3);
INSERT INTO `m_area` VALUES (3276, 3271, '621023', '华池县', 3);
INSERT INTO `m_area` VALUES (3277, 3271, '621024', '合水县', 3);
INSERT INTO `m_area` VALUES (3278, 3271, '621025', '正宁县', 3);
INSERT INTO `m_area` VALUES (3279, 3271, '621026', '宁　县', 3);
INSERT INTO `m_area` VALUES (3280, 3271, '621027', '镇原县', 3);
INSERT INTO `m_area` VALUES (3281, 3206, '621100', '定西市', 2);
INSERT INTO `m_area` VALUES (3282, 3281, '621101', '市辖区', 3);
INSERT INTO `m_area` VALUES (3283, 3281, '621102', '安定区', 3);
INSERT INTO `m_area` VALUES (3284, 3281, '621121', '通渭县', 3);
INSERT INTO `m_area` VALUES (3285, 3281, '621122', '陇西县', 3);
INSERT INTO `m_area` VALUES (3286, 3281, '621123', '渭源县', 3);
INSERT INTO `m_area` VALUES (3287, 3281, '621124', '临洮县', 3);
INSERT INTO `m_area` VALUES (3288, 3281, '621125', '漳　县', 3);
INSERT INTO `m_area` VALUES (3289, 3281, '621126', '岷　县', 3);
INSERT INTO `m_area` VALUES (3290, 3206, '621200', '陇南市', 2);
INSERT INTO `m_area` VALUES (3291, 3290, '621201', '市辖区', 3);
INSERT INTO `m_area` VALUES (3292, 3290, '621202', '武都区', 3);
INSERT INTO `m_area` VALUES (3293, 3290, '621221', '成　县', 3);
INSERT INTO `m_area` VALUES (3294, 3290, '621222', '文　县', 3);
INSERT INTO `m_area` VALUES (3295, 3290, '621223', '宕昌县', 3);
INSERT INTO `m_area` VALUES (3296, 3290, '621224', '康　县', 3);
INSERT INTO `m_area` VALUES (3297, 3290, '621225', '西和县', 3);
INSERT INTO `m_area` VALUES (3298, 3290, '621226', '礼　县', 3);
INSERT INTO `m_area` VALUES (3299, 3290, '621227', '徽　县', 3);
INSERT INTO `m_area` VALUES (3300, 3290, '621228', '两当县', 3);
INSERT INTO `m_area` VALUES (3301, 3206, '622900', '临夏回族自治州', 2);
INSERT INTO `m_area` VALUES (3302, 3301, '622901', '临夏市', 3);
INSERT INTO `m_area` VALUES (3303, 3301, '622921', '临夏县', 3);
INSERT INTO `m_area` VALUES (3304, 3301, '622922', '康乐县', 3);
INSERT INTO `m_area` VALUES (3305, 3301, '622923', '永靖县', 3);
INSERT INTO `m_area` VALUES (3306, 3301, '622924', '广河县', 3);
INSERT INTO `m_area` VALUES (3307, 3301, '622925', '和政县', 3);
INSERT INTO `m_area` VALUES (3308, 3301, '622926', '东乡族自治县', 3);
INSERT INTO `m_area` VALUES (3309, 3301, '622927', '积石山保安族东乡族撒拉族自治县', 3);
INSERT INTO `m_area` VALUES (3310, 3206, '623000', '甘南藏族自治州', 2);
INSERT INTO `m_area` VALUES (3311, 3310, '623001', '合作市', 3);
INSERT INTO `m_area` VALUES (3312, 3310, '623021', '临潭县', 3);
INSERT INTO `m_area` VALUES (3313, 3310, '623022', '卓尼县', 3);
INSERT INTO `m_area` VALUES (3314, 3310, '623023', '舟曲县', 3);
INSERT INTO `m_area` VALUES (3315, 3310, '623024', '迭部县', 3);
INSERT INTO `m_area` VALUES (3316, 3310, '623025', '玛曲县', 3);
INSERT INTO `m_area` VALUES (3317, 3310, '623026', '碌曲县', 3);
INSERT INTO `m_area` VALUES (3318, 3310, '623027', '夏河县', 3);
INSERT INTO `m_area` VALUES (3319, 0, '630000', '青海省', 1);
INSERT INTO `m_area` VALUES (3320, 3319, '630100', '西宁市', 2);
INSERT INTO `m_area` VALUES (3321, 3320, '630101', '市辖区', 3);
INSERT INTO `m_area` VALUES (3322, 3320, '630102', '城东区', 3);
INSERT INTO `m_area` VALUES (3323, 3320, '630103', '城中区', 3);
INSERT INTO `m_area` VALUES (3324, 3320, '630104', '城西区', 3);
INSERT INTO `m_area` VALUES (3325, 3320, '630105', '城北区', 3);
INSERT INTO `m_area` VALUES (3326, 3320, '630121', '大通回族土族自治县', 3);
INSERT INTO `m_area` VALUES (3327, 3320, '630122', '湟中县', 3);
INSERT INTO `m_area` VALUES (3328, 3320, '630123', '湟源县', 3);
INSERT INTO `m_area` VALUES (3329, 3319, '632100', '海东地区', 2);
INSERT INTO `m_area` VALUES (3330, 3329, '632121', '平安县', 3);
INSERT INTO `m_area` VALUES (3331, 3329, '632122', '民和回族土族自治县', 3);
INSERT INTO `m_area` VALUES (3332, 3329, '632123', '乐都县', 3);
INSERT INTO `m_area` VALUES (3333, 3329, '632126', '互助土族自治县', 3);
INSERT INTO `m_area` VALUES (3334, 3329, '632127', '化隆回族自治县', 3);
INSERT INTO `m_area` VALUES (3335, 3329, '632128', '循化撒拉族自治县', 3);
INSERT INTO `m_area` VALUES (3336, 3319, '632200', '海北藏族自治州', 2);
INSERT INTO `m_area` VALUES (3337, 3336, '632221', '门源回族自治县', 3);
INSERT INTO `m_area` VALUES (3338, 3336, '632222', '祁连县', 3);
INSERT INTO `m_area` VALUES (3339, 3336, '632223', '海晏县', 3);
INSERT INTO `m_area` VALUES (3340, 3336, '632224', '刚察县', 3);
INSERT INTO `m_area` VALUES (3341, 3319, '632300', '黄南藏族自治州', 2);
INSERT INTO `m_area` VALUES (3342, 3341, '632321', '同仁县', 3);
INSERT INTO `m_area` VALUES (3343, 3341, '632322', '尖扎县', 3);
INSERT INTO `m_area` VALUES (3344, 3341, '632323', '泽库县', 3);
INSERT INTO `m_area` VALUES (3345, 3341, '632324', '河南蒙古族自治县', 3);
INSERT INTO `m_area` VALUES (3346, 3319, '632500', '海南藏族自治州', 2);
INSERT INTO `m_area` VALUES (3347, 3346, '632521', '共和县', 3);
INSERT INTO `m_area` VALUES (3348, 3346, '632522', '同德县', 3);
INSERT INTO `m_area` VALUES (3349, 3346, '632523', '贵德县', 3);
INSERT INTO `m_area` VALUES (3350, 3346, '632524', '兴海县', 3);
INSERT INTO `m_area` VALUES (3351, 3346, '632525', '贵南县', 3);
INSERT INTO `m_area` VALUES (3352, 3319, '632600', '果洛藏族自治州', 2);
INSERT INTO `m_area` VALUES (3353, 3352, '632621', '玛沁县', 3);
INSERT INTO `m_area` VALUES (3354, 3352, '632622', '班玛县', 3);
INSERT INTO `m_area` VALUES (3355, 3352, '632623', '甘德县', 3);
INSERT INTO `m_area` VALUES (3356, 3352, '632624', '达日县', 3);
INSERT INTO `m_area` VALUES (3357, 3352, '632625', '久治县', 3);
INSERT INTO `m_area` VALUES (3358, 3352, '632626', '玛多县', 3);
INSERT INTO `m_area` VALUES (3359, 3319, '632700', '玉树藏族自治州', 2);
INSERT INTO `m_area` VALUES (3360, 3359, '632721', '玉树县', 3);
INSERT INTO `m_area` VALUES (3361, 3359, '632722', '杂多县', 3);
INSERT INTO `m_area` VALUES (3362, 3359, '632723', '称多县', 3);
INSERT INTO `m_area` VALUES (3363, 3359, '632724', '治多县', 3);
INSERT INTO `m_area` VALUES (3364, 3359, '632725', '囊谦县', 3);
INSERT INTO `m_area` VALUES (3365, 3359, '632726', '曲麻莱县', 3);
INSERT INTO `m_area` VALUES (3366, 3319, '632800', '海西蒙古族藏族自治州', 2);
INSERT INTO `m_area` VALUES (3367, 3366, '632801', '格尔木市', 3);
INSERT INTO `m_area` VALUES (3368, 3366, '632802', '德令哈市', 3);
INSERT INTO `m_area` VALUES (3369, 3366, '632821', '乌兰县', 3);
INSERT INTO `m_area` VALUES (3370, 3366, '632822', '都兰县', 3);
INSERT INTO `m_area` VALUES (3371, 3366, '632823', '天峻县', 3);
INSERT INTO `m_area` VALUES (3372, 0, '640000', '宁夏回族自治区', 1);
INSERT INTO `m_area` VALUES (3373, 3372, '640100', '银川市', 2);
INSERT INTO `m_area` VALUES (3374, 3373, '640101', '市辖区', 3);
INSERT INTO `m_area` VALUES (3375, 3373, '640104', '兴庆区', 3);
INSERT INTO `m_area` VALUES (3376, 3373, '640105', '西夏区', 3);
INSERT INTO `m_area` VALUES (3377, 3373, '640106', '金凤区', 3);
INSERT INTO `m_area` VALUES (3378, 3373, '640121', '永宁县', 3);
INSERT INTO `m_area` VALUES (3379, 3373, '640122', '贺兰县', 3);
INSERT INTO `m_area` VALUES (3380, 3373, '640181', '灵武市', 3);
INSERT INTO `m_area` VALUES (3381, 3372, '640200', '石嘴山市', 2);
INSERT INTO `m_area` VALUES (3382, 3381, '640201', '市辖区', 3);
INSERT INTO `m_area` VALUES (3383, 3381, '640202', '大武口区', 3);
INSERT INTO `m_area` VALUES (3384, 3381, '640205', '惠农区', 3);
INSERT INTO `m_area` VALUES (3385, 3381, '640221', '平罗县', 3);
INSERT INTO `m_area` VALUES (3386, 3372, '640300', '吴忠市', 2);
INSERT INTO `m_area` VALUES (3387, 3386, '640301', '市辖区', 3);
INSERT INTO `m_area` VALUES (3388, 3386, '640302', '利通区', 3);
INSERT INTO `m_area` VALUES (3389, 3386, '640323', '盐池县', 3);
INSERT INTO `m_area` VALUES (3390, 3386, '640324', '同心县', 3);
INSERT INTO `m_area` VALUES (3391, 3386, '640381', '青铜峡市', 3);
INSERT INTO `m_area` VALUES (3392, 3372, '640400', '固原市', 2);
INSERT INTO `m_area` VALUES (3393, 3392, '640401', '市辖区', 3);
INSERT INTO `m_area` VALUES (3394, 3392, '640402', '原州区', 3);
INSERT INTO `m_area` VALUES (3395, 3392, '640422', '西吉县', 3);
INSERT INTO `m_area` VALUES (3396, 3392, '640423', '隆德县', 3);
INSERT INTO `m_area` VALUES (3397, 3392, '640424', '泾源县', 3);
INSERT INTO `m_area` VALUES (3398, 3392, '640425', '彭阳县', 3);
INSERT INTO `m_area` VALUES (3399, 3372, '640500', '中卫市', 2);
INSERT INTO `m_area` VALUES (3400, 3399, '640501', '市辖区', 3);
INSERT INTO `m_area` VALUES (3401, 3399, '640502', '沙坡头区', 3);
INSERT INTO `m_area` VALUES (3402, 3399, '640521', '中宁县', 3);
INSERT INTO `m_area` VALUES (3403, 3399, '640522', '海原县', 3);
INSERT INTO `m_area` VALUES (3404, 0, '650000', '新疆维吾尔自治区', 1);
INSERT INTO `m_area` VALUES (3405, 3404, '650100', '乌鲁木齐市', 2);
INSERT INTO `m_area` VALUES (3406, 3405, '650101', '市辖区', 3);
INSERT INTO `m_area` VALUES (3407, 3405, '650102', '天山区', 3);
INSERT INTO `m_area` VALUES (3408, 3405, '650103', '沙依巴克区', 3);
INSERT INTO `m_area` VALUES (3409, 3405, '650104', '新市区', 3);
INSERT INTO `m_area` VALUES (3410, 3405, '650105', '水磨沟区', 3);
INSERT INTO `m_area` VALUES (3411, 3405, '650106', '头屯河区', 3);
INSERT INTO `m_area` VALUES (3412, 3405, '650107', '达坂城区', 3);
INSERT INTO `m_area` VALUES (3413, 3405, '650108', '东山区', 3);
INSERT INTO `m_area` VALUES (3414, 3405, '650121', '乌鲁木齐县', 3);
INSERT INTO `m_area` VALUES (3415, 3404, '650200', '克拉玛依市', 2);
INSERT INTO `m_area` VALUES (3416, 3415, '650201', '市辖区', 3);
INSERT INTO `m_area` VALUES (3417, 3415, '650202', '独山子区', 3);
INSERT INTO `m_area` VALUES (3418, 3415, '650203', '克拉玛依区', 3);
INSERT INTO `m_area` VALUES (3419, 3415, '650204', '白碱滩区', 3);
INSERT INTO `m_area` VALUES (3420, 3415, '650205', '乌尔禾区', 3);
INSERT INTO `m_area` VALUES (3421, 3404, '652100', '吐鲁番地区', 2);
INSERT INTO `m_area` VALUES (3422, 3421, '652101', '吐鲁番市', 3);
INSERT INTO `m_area` VALUES (3423, 3421, '652122', '鄯善县', 3);
INSERT INTO `m_area` VALUES (3424, 3421, '652123', '托克逊县', 3);
INSERT INTO `m_area` VALUES (3425, 3404, '652200', '哈密地区', 2);
INSERT INTO `m_area` VALUES (3426, 3425, '652201', '哈密市', 3);
INSERT INTO `m_area` VALUES (3427, 3425, '652222', '巴里坤哈萨克自治县', 3);
INSERT INTO `m_area` VALUES (3428, 3425, '652223', '伊吾县', 3);
INSERT INTO `m_area` VALUES (3429, 3404, '652300', '昌吉回族自治州', 2);
INSERT INTO `m_area` VALUES (3430, 3429, '652301', '昌吉市', 3);
INSERT INTO `m_area` VALUES (3431, 3429, '652302', '阜康市', 3);
INSERT INTO `m_area` VALUES (3432, 3429, '652303', '米泉市', 3);
INSERT INTO `m_area` VALUES (3433, 3429, '652323', '呼图壁县', 3);
INSERT INTO `m_area` VALUES (3434, 3429, '652324', '玛纳斯县', 3);
INSERT INTO `m_area` VALUES (3435, 3429, '652325', '奇台县', 3);
INSERT INTO `m_area` VALUES (3436, 3429, '652327', '吉木萨尔县', 3);
INSERT INTO `m_area` VALUES (3437, 3429, '652328', '木垒哈萨克自治县', 3);
INSERT INTO `m_area` VALUES (3438, 3404, '652700', '博尔塔拉蒙古自治州', 2);
INSERT INTO `m_area` VALUES (3439, 3438, '652701', '博乐市', 3);
INSERT INTO `m_area` VALUES (3440, 3438, '652722', '精河县', 3);
INSERT INTO `m_area` VALUES (3441, 3438, '652723', '温泉县', 3);
INSERT INTO `m_area` VALUES (3442, 3404, '652800', '巴音郭楞蒙古自治州', 2);
INSERT INTO `m_area` VALUES (3443, 3442, '652801', '库尔勒市', 3);
INSERT INTO `m_area` VALUES (3444, 3442, '652822', '轮台县', 3);
INSERT INTO `m_area` VALUES (3445, 3442, '652823', '尉犁县', 3);
INSERT INTO `m_area` VALUES (3446, 3442, '652824', '若羌县', 3);
INSERT INTO `m_area` VALUES (3447, 3442, '652825', '且末县', 3);
INSERT INTO `m_area` VALUES (3448, 3442, '652826', '焉耆回族自治县', 3);
INSERT INTO `m_area` VALUES (3449, 3442, '652827', '和静县', 3);
INSERT INTO `m_area` VALUES (3450, 3442, '652828', '和硕县', 3);
INSERT INTO `m_area` VALUES (3451, 3442, '652829', '博湖县', 3);
INSERT INTO `m_area` VALUES (3452, 3404, '652900', '阿克苏地区', 2);
INSERT INTO `m_area` VALUES (3453, 3452, '652901', '阿克苏市', 3);
INSERT INTO `m_area` VALUES (3454, 3452, '652922', '温宿县', 3);
INSERT INTO `m_area` VALUES (3455, 3452, '652923', '库车县', 3);
INSERT INTO `m_area` VALUES (3456, 3452, '652924', '沙雅县', 3);
INSERT INTO `m_area` VALUES (3457, 3452, '652925', '新和县', 3);
INSERT INTO `m_area` VALUES (3458, 3452, '652926', '拜城县', 3);
INSERT INTO `m_area` VALUES (3459, 3452, '652927', '乌什县', 3);
INSERT INTO `m_area` VALUES (3460, 3452, '652928', '阿瓦提县', 3);
INSERT INTO `m_area` VALUES (3461, 3452, '652929', '柯坪县', 3);
INSERT INTO `m_area` VALUES (3462, 3404, '653000', '克孜勒苏柯尔克孜自治州', 2);
INSERT INTO `m_area` VALUES (3463, 3462, '653001', '阿图什市', 3);
INSERT INTO `m_area` VALUES (3464, 3462, '653022', '阿克陶县', 3);
INSERT INTO `m_area` VALUES (3465, 3462, '653023', '阿合奇县', 3);
INSERT INTO `m_area` VALUES (3466, 3462, '653024', '乌恰县', 3);
INSERT INTO `m_area` VALUES (3467, 3404, '653100', '喀什地区', 2);
INSERT INTO `m_area` VALUES (3468, 3467, '653101', '喀什市', 3);
INSERT INTO `m_area` VALUES (3469, 3467, '653121', '疏附县', 3);
INSERT INTO `m_area` VALUES (3470, 3467, '653122', '疏勒县', 3);
INSERT INTO `m_area` VALUES (3471, 3467, '653123', '英吉沙县', 3);
INSERT INTO `m_area` VALUES (3472, 3467, '653124', '泽普县', 3);
INSERT INTO `m_area` VALUES (3473, 3467, '653125', '莎车县', 3);
INSERT INTO `m_area` VALUES (3474, 3467, '653126', '叶城县', 3);
INSERT INTO `m_area` VALUES (3475, 3467, '653127', '麦盖提县', 3);
INSERT INTO `m_area` VALUES (3476, 3467, '653128', '岳普湖县', 3);
INSERT INTO `m_area` VALUES (3477, 3467, '653129', '伽师县', 3);
INSERT INTO `m_area` VALUES (3478, 3467, '653130', '巴楚县', 3);
INSERT INTO `m_area` VALUES (3479, 3467, '653131', '塔什库尔干塔吉克自治县', 3);
INSERT INTO `m_area` VALUES (3480, 3404, '653200', '和田地区', 2);
INSERT INTO `m_area` VALUES (3481, 3480, '653201', '和田市', 3);
INSERT INTO `m_area` VALUES (3482, 3480, '653221', '和田县', 3);
INSERT INTO `m_area` VALUES (3483, 3480, '653222', '墨玉县', 3);
INSERT INTO `m_area` VALUES (3484, 3480, '653223', '皮山县', 3);
INSERT INTO `m_area` VALUES (3485, 3480, '653224', '洛浦县', 3);
INSERT INTO `m_area` VALUES (3486, 3480, '653225', '策勒县', 3);
INSERT INTO `m_area` VALUES (3487, 3480, '653226', '于田县', 3);
INSERT INTO `m_area` VALUES (3488, 3480, '653227', '民丰县', 3);
INSERT INTO `m_area` VALUES (3489, 3404, '654000', '伊犁哈萨克自治州', 2);
INSERT INTO `m_area` VALUES (3490, 3489, '654002', '伊宁市', 3);
INSERT INTO `m_area` VALUES (3491, 3489, '654003', '奎屯市', 3);
INSERT INTO `m_area` VALUES (3492, 3489, '654021', '伊宁县', 3);
INSERT INTO `m_area` VALUES (3493, 3489, '654022', '察布查尔锡伯自治县', 3);
INSERT INTO `m_area` VALUES (3494, 3489, '654023', '霍城县', 3);
INSERT INTO `m_area` VALUES (3495, 3489, '654024', '巩留县', 3);
INSERT INTO `m_area` VALUES (3496, 3489, '654025', '新源县', 3);
INSERT INTO `m_area` VALUES (3497, 3489, '654026', '昭苏县', 3);
INSERT INTO `m_area` VALUES (3498, 3489, '654027', '特克斯县', 3);
INSERT INTO `m_area` VALUES (3499, 3489, '654028', '尼勒克县', 3);
INSERT INTO `m_area` VALUES (3500, 3404, '654200', '塔城地区', 2);
INSERT INTO `m_area` VALUES (3501, 3500, '654201', '塔城市', 3);
INSERT INTO `m_area` VALUES (3502, 3500, '654202', '乌苏市', 3);
INSERT INTO `m_area` VALUES (3503, 3500, '654221', '额敏县', 3);
INSERT INTO `m_area` VALUES (3504, 3500, '654223', '沙湾县', 3);
INSERT INTO `m_area` VALUES (3505, 3500, '654224', '托里县', 3);
INSERT INTO `m_area` VALUES (3506, 3500, '654225', '裕民县', 3);
INSERT INTO `m_area` VALUES (3507, 3500, '654226', '和布克赛尔蒙古自治县', 3);
INSERT INTO `m_area` VALUES (3508, 3404, '654300', '阿勒泰地区', 2);
INSERT INTO `m_area` VALUES (3509, 3508, '654301', '阿勒泰市', 3);
INSERT INTO `m_area` VALUES (3510, 3508, '654321', '布尔津县', 3);
INSERT INTO `m_area` VALUES (3511, 3508, '654322', '富蕴县', 3);
INSERT INTO `m_area` VALUES (3512, 3508, '654323', '福海县', 3);
INSERT INTO `m_area` VALUES (3513, 3508, '654324', '哈巴河县', 3);
INSERT INTO `m_area` VALUES (3514, 3508, '654325', '青河县', 3);
INSERT INTO `m_area` VALUES (3515, 3508, '654326', '吉木乃县', 3);
INSERT INTO `m_area` VALUES (3516, 3404, '659000', '省直辖行政单位', 2);
INSERT INTO `m_area` VALUES (3517, 3516, '659001', '石河子市', 3);
INSERT INTO `m_area` VALUES (3518, 3516, '659002', '阿拉尔市', 3);
INSERT INTO `m_area` VALUES (3519, 3516, '659003', '图木舒克市', 3);
INSERT INTO `m_area` VALUES (3520, 3516, '659004', '五家渠市', 3);
INSERT INTO `m_area` VALUES (3521, 0, '710000', '台湾省', 0);
INSERT INTO `m_area` VALUES (3522, 0, '810000', '香港特别行政区', 0);
INSERT INTO `m_area` VALUES (3523, 0, '820000', '澳门特别行政区', 0);

-- ----------------------------
-- Table structure for meeting_auditor
-- ----------------------------
DROP TABLE IF EXISTS `meeting_auditor`;
CREATE TABLE `meeting_auditor`  (
  `id` bigint(32) NOT NULL AUTO_INCREMENT,
  `meeting_id` bigint(32) NOT NULL COMMENT '会议ID',
  `auditor_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '审核人姓名',
  `auditor_time` datetime(0) NULL DEFAULT NULL COMMENT '审核时间',
  `auditor_text` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '审核内容',
  `auditor_status` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '审核状态',
  `auditor_channel` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '审核渠道',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for meeting_cloud
-- ----------------------------
DROP TABLE IF EXISTS `meeting_cloud`;
CREATE TABLE `meeting_cloud`  (
  `id` bigint(32) NOT NULL AUTO_INCREMENT,
  `meeting_id` bigint(32) NULL DEFAULT NULL COMMENT '会议表id',
  `type` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文件类型 01视频 02会议照片 03劳务报销单 04费用发票',
  `upload_time` datetime(0) NULL DEFAULT NULL COMMENT '上传时间',
  `user_id` bigint(32) NOT NULL COMMENT '上传者用户ID',
  `url` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文件url\r\n',
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文件名',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `meeting_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '会议编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of meeting_cloud
-- ----------------------------
INSERT INTO `meeting_cloud` VALUES (12, 25, '01', '2019-10-29 03:09:01', 1, 'http://img.jcscdata.com/M201910290002/5efd31bc-6285-4db9-a3fc-93202933d69f.jpg', '空洞骑士 (2).jpg', '2019-10-29 03:09:01', '2019-11-15 18:02:10', 'M201911140001');
INSERT INTO `meeting_cloud` VALUES (13, NULL, '02', '2019-10-30 09:54:08', 1, 'http://img.jcscdata.com/M201910290001/93a4538b-4c6e-4281-a44d-a5a0edd74bfc.jpg', 'w (1).jpg', '2019-10-30 09:54:08', '2019-10-30 09:54:08', '');
INSERT INTO `meeting_cloud` VALUES (14, NULL, '02', '2019-10-30 09:54:10', 1, 'http://img.jcscdata.com/M201910290001/eebbd8a2-0185-4389-b548-d1bc53baea72.png', 'w (1).png', '2019-10-30 09:54:10', '2019-10-30 09:54:10', '');
INSERT INTO `meeting_cloud` VALUES (16, NULL, '02', '2019-11-13 10:27:02', 1, 'http://img.jcscdata.com/M201910290001/05db49dc-5e8f-4145-ac80-dda00c3c2e94.jpg', 'w (2).jpg', '2019-11-13 10:27:02', '2019-11-13 10:27:02', '');
INSERT INTO `meeting_cloud` VALUES (17, 25, '02', '2019-11-13 10:28:34', 1, 'http://img.jcscdata.com/M201910290001/e2295e53-3976-43fc-b09e-17d95e847891.jpg', 'w (2).jpg', '2019-11-13 10:28:42', '2019-11-15 18:02:10', 'M201911140001');
INSERT INTO `meeting_cloud` VALUES (18, 25, '02', '2019-11-13 10:30:16', 1, 'http://img.jcscdata.com/M201910290001/f8235c2b-9013-41ef-90c5-07fda800e4b6.jpg', 'w (2).jpg', '2019-11-13 10:30:16', '2019-11-15 18:02:10', 'M201911140001');
INSERT INTO `meeting_cloud` VALUES (19, 25, '02', '2019-11-13 10:33:18', 1, 'http://img.jcscdata.com/M201910290001/188d0e62-120f-4853-ba0a-7d61b86188df.jpg', 'w (2).jpg', '2019-11-13 10:33:18', '2019-11-15 18:02:10', 'M201911140001');

-- ----------------------------
-- Table structure for meeting_course
-- ----------------------------
DROP TABLE IF EXISTS `meeting_course`;
CREATE TABLE `meeting_course`  (
  `id` bigint(32) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '课件名',
  `url` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'url地址',
  `size` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '大小',
  `times` int(32) NULL DEFAULT NULL COMMENT '课件下载次数',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 90 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of meeting_course
-- ----------------------------
INSERT INTO `meeting_course` VALUES (90, '流弊的会议', 'http://img.jcscdata.com/course/75567189-077e-447b-87d7-2f9962cb9a26.jpg', '1.34MB', 1, '2019-10-31 09:59:45', '2019-10-31 10:01:49');

-- ----------------------------
-- Table structure for meeting_detail
-- ----------------------------
DROP TABLE IF EXISTS `meeting_detail`;
CREATE TABLE `meeting_detail`  (
  `id` bigint(32) NOT NULL AUTO_INCREMENT,
  `meeting_type` int(4) NOT NULL DEFAULT 1 COMMENT '类型 1-科室会 2-学术会 3-推广会',
  `code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '编号',
  `meeting_time` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '会议日期',
  `hospital_id` bigint(32) NULL DEFAULT NULL COMMENT '医院id',
  `question_id` bigint(32) NULL DEFAULT NULL COMMENT '问卷id',
  `speakers_id` bigint(32) NULL DEFAULT NULL COMMENT '讲者id',
  `applicant_id` bigint(32) NULL DEFAULT NULL COMMENT '申请人-员工id',
  `pre_persons` int(16) NULL DEFAULT NULL COMMENT '预估人数',
  `applicant_time` datetime(0) NULL DEFAULT NULL COMMENT '申请日期',
  `source` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '来源',
  `meeting_status` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '审核状态（01待审核 02待修改 03待开展 04开展中 05已结束）',
  `real_persons` int(16) NULL DEFAULT NULL COMMENT '实际人数',
  `address` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '定位地址',
  `create_time` datetime(0) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `labor_cost` decimal(16, 2) NULL DEFAULT NULL COMMENT '劳务费用',
  `activity_cost` decimal(16, 2) NULL DEFAULT NULL COMMENT '活动费用',
  `auditor_id` bigint(32) NULL DEFAULT NULL COMMENT '审核人',
  `topic_id` bigint(32) NULL DEFAULT NULL COMMENT '会议主题(即会议课件ID)',
  `auditor_time` datetime(0) NULL DEFAULT NULL COMMENT '审核时间',
  `auditor_text` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '审核原因',
  `del_flag` int(2) NULL DEFAULT NULL COMMENT '1未删除 0已删除',
  `auditor_channel` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '审核渠道(beam后台管理，heart小程序\n)\n',
  `conclusion` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '会议总结',
  `longitude` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '经度',
  `latitude` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '纬度',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `IDX_CODE`(`code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of meeting_detail
-- ----------------------------
INSERT INTO `meeting_detail` VALUES (1, 1, 'M201910290001', '2019-11-18', 1, 1, 1, 1, 200, '2019-09-25 10:50:46', '小程序', '05', 100, '北京协和', '2019-09-25 10:51:47', '2019-11-13 17:59:58', 100.51, 400.00, 1, 90, '2019-11-13 14:54:54', '菜', 1, 'heart', NULL, NULL, NULL);
INSERT INTO `meeting_detail` VALUES (2, 2, 'M201910290002', '2019-09-25', 1, 1, 1, 1, 200, '2019-09-25 10:50:46', '小程序', '05', 100, '同仁堂', '2019-09-25 10:51:47', '2019-11-13 17:59:58', 150.50, 600.00, 1, 90, NULL, NULL, 1, 'beam', NULL, NULL, NULL);
INSERT INTO `meeting_detail` VALUES (20, 1, 'M201911090001', '2019-11-08', 1, NULL, 2, 1, 2, '2019-11-09 06:39:06', '小程序', '05', NULL, NULL, '2019-11-09 06:39:06', '2019-11-09 06:39:06', 150.50, 100.22, 1, 90, NULL, NULL, 1, 'heart', NULL, NULL, NULL);
INSERT INTO `meeting_detail` VALUES (21, 1, 'M201911090002', '2019-11-08', 2, NULL, 2, 1, 33, '2019-11-09 08:10:04', '小程序', '05', NULL, NULL, '2019-11-09 08:10:04', '2019-11-09 08:10:04', 150.50, 100.22, 1, 90, NULL, NULL, 1, 'heart', NULL, NULL, NULL);
INSERT INTO `meeting_detail` VALUES (22, 1, 'M201911090003', '2019-11-08', 2, NULL, 2, 1, 222, '2019-11-09 08:42:26', '小程序', '05', NULL, NULL, '2019-11-09 08:42:26', '2019-11-09 08:42:26', 150.50, 100.22, 1, 90, NULL, NULL, 1, 'heart', NULL, NULL, NULL);
INSERT INTO `meeting_detail` VALUES (23, 1, 'M201911090004', '2019-11-08', 2, NULL, 2, 1, 22, '2019-11-09 08:52:44', '小程序', '05', NULL, NULL, '2019-11-09 08:52:44', '2019-11-09 08:52:44', 150.50, 100.22, 1, 90, NULL, NULL, 1, 'heart', NULL, NULL, NULL);
INSERT INTO `meeting_detail` VALUES (24, 1, 'M201911090005', '2019-11-08', 1, NULL, 2, 1, 122, '2019-11-09 08:53:50', '小程序', '05', NULL, NULL, '2019-11-09 08:53:50', '2019-11-09 08:53:50', 150.50, 100.22, 1, 90, NULL, NULL, 1, 'heart', NULL, NULL, NULL);
INSERT INTO `meeting_detail` VALUES (25, 1, 'M201911140001', '2019-11-14', 2, NULL, 1, 1, 22, '2019-11-14 16:26:11', '小程序', '01', 100, '北京市朝阳区那旮沓胡同', '2019-11-14 16:26:11', '2019-11-21 16:33:15', 100.01, 100.22, NULL, 90, NULL, NULL, 1, NULL, NULL, NULL, NULL);
INSERT INTO `meeting_detail` VALUES (28, 1, 'M201911210003', '2019-11-21', 1, NULL, 1, 2, 20, '2019-11-21 17:00:37', '小程序', '01', NULL, NULL, '2019-11-21 17:00:45', '2019-11-21 17:00:45', 20.22, 100.22, NULL, 90, NULL, NULL, 1, NULL, NULL, NULL, NULL);
INSERT INTO `meeting_detail` VALUES (29, 1, 'M201911210004', '2019-11-21', 1, NULL, 1, 1, 20, '2019-11-21 17:05:34', '小程序', '01', NULL, NULL, '2019-11-21 17:05:34', '2019-11-21 17:05:34', 20.22, 100.22, NULL, 90, NULL, NULL, 1, NULL, NULL, NULL, NULL);
INSERT INTO `meeting_detail` VALUES (30, 1, 'M201911210005', '2019-11-21', 1, NULL, 1, 2, 20, '2019-11-21 17:06:20', '小程序', '01', NULL, NULL, '2019-11-21 17:06:20', '2019-11-21 17:06:20', 20.22, 100.22, NULL, 90, NULL, NULL, 1, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for meeting_question
-- ----------------------------
DROP TABLE IF EXISTS `meeting_question`;
CREATE TABLE `meeting_question`  (
  `id` bigint(32) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '问卷名称',
  `url` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'url地址',
  `times` int(32) NULL DEFAULT NULL COMMENT '问卷下载次数',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `size` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文件大小',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `BLOB_DATA` blob NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `SCHED_NAME`(`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `QRTZ_BLOB_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CALENDAR_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `CALENDAR_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CRON_EXPRESSION` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TIME_ZONE_ID` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `QRTZ_CRON_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------
INSERT INTO `qrtz_cron_triggers` VALUES ('RenrenScheduler', 'TASK_1', 'DEFAULT', '*/5 * * * * ?', 'Asia/Shanghai');

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ENTRY_ID` varchar(95) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `INSTANCE_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `FIRED_TIME` bigint(13) NOT NULL,
  `SCHED_TIME` bigint(13) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `IS_NONCONCURRENT` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `ENTRY_ID`) USING BTREE,
  INDEX `IDX_QRTZ_FT_TRIG_INST_NAME`(`SCHED_NAME`, `INSTANCE_NAME`) USING BTREE,
  INDEX `IDX_QRTZ_FT_INST_JOB_REQ_RCVRY`(`SCHED_NAME`, `INSTANCE_NAME`, `REQUESTS_RECOVERY`) USING BTREE,
  INDEX `IDX_QRTZ_FT_J_G`(`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_FT_JG`(`SCHED_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_FT_T_G`(`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_FT_TG`(`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `DESCRIPTION` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `IS_DURABLE` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `IS_NONCONCURRENT` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `IS_UPDATE_DATA` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_DATA` blob NULL,
  PRIMARY KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_J_REQ_RECOVERY`(`SCHED_NAME`, `REQUESTS_RECOVERY`) USING BTREE,
  INDEX `IDX_QRTZ_J_GRP`(`SCHED_NAME`, `JOB_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------
INSERT INTO `qrtz_job_details` VALUES ('RenrenScheduler', 'TASK_1', 'DEFAULT', NULL, 'com.ksh.beam.common.quartz.ScheduleJob', '0', '0', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B45597372002A636F6D2E6B73682E6265616D2E73797374656D2E656E746974792E7379732E5363686564756C654A6F6200000000000000010200074C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000269647400104C6A6176612F6C616E672F4C6F6E673B4C000A6D6574686F644E616D6571007E00094C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7872002A636F6D2E6B73682E6265616D2E636F6D6D6F6E2E626173652E656E746974792E52657374456E746974795EADF9A34ADCA4C70200024C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000A75706461746554696D6571007E000D7872002E636F6D2E6B73682E6265616D2E636F6D6D6F6E2E626173652E656E746974792E4162737472616374456E74697479F87F9639587291B80200024A000B63757272656E74506167654A00087061676553697A6578720035636F6D2E62616F6D69646F752E6D796261746973706C75732E657874656E73696F6E2E6163746976657265636F72642E4D6F64656C000000000000000102000078700000000000000000000000000000000A7372000E6A6176612E7574696C2E44617465686A81014B59741903000078707708000001680B7908A0787371007E001177080000016BBFEAF1B0787400047461736B74000D2A2F35202A202A202A202A203F7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000000000000017400047465737470740006E6B58BE8AF95737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E0017000000007800);

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `LOCK_NAME` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `LOCK_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
INSERT INTO `qrtz_locks` VALUES ('RenrenScheduler', 'STATE_ACCESS');
INSERT INTO `qrtz_locks` VALUES ('RenrenScheduler', 'TRIGGER_ACCESS');

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `INSTANCE_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `INSTANCE_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------
INSERT INTO `qrtz_scheduler_state` VALUES ('RenrenScheduler', 'DESKTOP-5N8RA0F1574241320884', 1574241672891, 15000);

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(10) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `QRTZ_SIMPLE_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `STR_PROP_1` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `STR_PROP_2` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `STR_PROP_3` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `INT_PROP_1` int(11) NULL DEFAULT NULL,
  `INT_PROP_2` int(11) NULL DEFAULT NULL,
  `LONG_PROP_1` bigint(20) NULL DEFAULT NULL,
  `LONG_PROP_2` bigint(20) NULL DEFAULT NULL,
  `DEC_PROP_1` decimal(13, 4) NULL DEFAULT NULL,
  `DEC_PROP_2` decimal(13, 4) NULL DEFAULT NULL,
  `BOOL_PROP_1` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `BOOL_PROP_2` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `QRTZ_SIMPROP_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `DESCRIPTION` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(13) NULL DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(13) NULL DEFAULT NULL,
  `PRIORITY` int(11) NULL DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_TYPE` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `START_TIME` bigint(13) NOT NULL,
  `END_TIME` bigint(13) NULL DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `MISFIRE_INSTR` smallint(2) NULL DEFAULT NULL,
  `JOB_DATA` blob NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_J`(`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_JG`(`SCHED_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_C`(`SCHED_NAME`, `CALENDAR_NAME`) USING BTREE,
  INDEX `IDX_QRTZ_T_G`(`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_STATE`(`SCHED_NAME`, `TRIGGER_STATE`) USING BTREE,
  INDEX `IDX_QRTZ_T_N_STATE`(`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`, `TRIGGER_STATE`) USING BTREE,
  INDEX `IDX_QRTZ_T_N_G_STATE`(`SCHED_NAME`, `TRIGGER_GROUP`, `TRIGGER_STATE`) USING BTREE,
  INDEX `IDX_QRTZ_T_NEXT_FIRE_TIME`(`SCHED_NAME`, `NEXT_FIRE_TIME`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_ST`(`SCHED_NAME`, `TRIGGER_STATE`, `NEXT_FIRE_TIME`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_MISFIRE`(`SCHED_NAME`, `MISFIRE_INSTR`, `NEXT_FIRE_TIME`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_ST_MISFIRE`(`SCHED_NAME`, `MISFIRE_INSTR`, `NEXT_FIRE_TIME`, `TRIGGER_STATE`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_ST_MISFIRE_GRP`(`SCHED_NAME`, `MISFIRE_INSTR`, `NEXT_FIRE_TIME`, `TRIGGER_GROUP`, `TRIGGER_STATE`) USING BTREE,
  CONSTRAINT `QRTZ_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------
INSERT INTO `qrtz_triggers` VALUES ('RenrenScheduler', 'TASK_1', 'DEFAULT', 'TASK_1', 'DEFAULT', NULL, 1565231570000, -1, 5, 'PAUSED', 'CRON', 1565231569000, 0, NULL, 2, 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B45597372002A636F6D2E6B73682E6265616D2E73797374656D2E656E746974792E7379732E5363686564756C654A6F6200000000000000010200074C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000269647400104C6A6176612F6C616E672F4C6F6E673B4C000A6D6574686F644E616D6571007E00094C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7872002A636F6D2E6B73682E6265616D2E636F6D6D6F6E2E626173652E656E746974792E52657374456E746974795EADF9A34ADCA4C70200024C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000A75706461746554696D6571007E000D7872002E636F6D2E6B73682E6265616D2E636F6D6D6F6E2E626173652E656E746974792E4162737472616374456E74697479F87F9639587291B80200024A000B63757272656E74506167654A00087061676553697A6578720035636F6D2E62616F6D69646F752E6D796261746973706C75732E657874656E73696F6E2E6163746976657265636F72642E4D6F64656C000000000000000102000078700000000000000000000000000000000A7372000E6A6176612E7574696C2E44617465686A81014B59741903000078707708000001680B7908A0787371007E001177080000016BBFEAF1B0787400047461736B74000D2A2F35202A202A202A202A203F7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000000000000017400047465737470740006E6B58BE8AF95737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E0017000000007800);

-- ----------------------------
-- Table structure for schedule_job
-- ----------------------------
DROP TABLE IF EXISTS `schedule_job`;
CREATE TABLE `schedule_job`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务id',
  `bean_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'spring bean名称',
  `method_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '方法名',
  `params` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参数',
  `cron_expression` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'cron表达式',
  `status` tinyint(4) NULL DEFAULT NULL COMMENT '任务状态  0：正常  1：暂停',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '定时任务' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of schedule_job
-- ----------------------------
INSERT INTO `schedule_job` VALUES (1, 'task', 'test', NULL, '*/5 * * * * ?', 0, '测试', '2019-01-02 06:11:48', '2019-07-05 10:16:14');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `param_key` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'key',
  `param_value` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'value',
  `status` tinyint(4) NULL DEFAULT 1 COMMENT '状态   0：隐藏   1：显示',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime(0) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `param_key`(`param_key`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统配置信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, 'CLOUD_STORAGE_CONFIG_KEY', '{\"qiniuDomain\":\"img.jcscdata.com\",\"qiniuPrefix\":\"wehert\",\"qiniuAccessKey\":\"1hAtppUg5XlE8mRv5ZnFQzpu5j43KJoy4bLPdMLg\",\"qiniuSecretKey\":\"achVhae0ZYTDFBxq3U3Fa2dTsxhvNlyPyptPQ9wN\",\"qiniuBucketName\":\"care\",\"type\":3}\r\n\r\n    \r\n\r\n', 1, '云存储配置信息', '2019-07-03 11:05:29', '2019-07-03 11:05:32');
INSERT INTO `sys_config` VALUES (2, 'FTP_CONFIG_KEY', '{\"ftpIp\":\"192.168.226.128\",\"ftpPort\":\"21\",\"ftpUsername\":\"uftp\",\"ftpPassword\":\"qweasdzxc\"}\r\n', 1, 'ftp配置信息', '2019-07-22 17:41:24', '2019-07-22 17:41:28');
INSERT INTO `sys_config` VALUES (3, 'SMS_CONFIG_KEY', '{\"product\":\"Dysmsapi\",\"domain\":\"dysmsapi.aliyuncs.com\",\"accessKeyId\":\"LTAIpo5P6QxBUw5K\",\"accessKeySecret\":\"EwfCzU5dHZUZJPARIgshC4OvQ3Mso1\",\"signName\": \"蓝色县域项目组\", \"templateCode\": \"SMS_166720034\"}', 1, 'sms配置信息', '2019-11-10 13:24:07', '2019-11-10 13:24:12');
INSERT INTO `sys_config` VALUES (4, 'WECHAT_CONFIG_KEY', '{\"appId\":\"wx721cde90734ebc81\",\"secret\":\"0ae93d6bafc5f00fa32292c883712ee8\",\"jsCode2Session\":\"https://api.weixin.qq.com/sns/jscode2session\",\"grant_type\": \"authorization_code\"}', 1, '微信配置', '2019-11-12 11:11:24', '2019-11-12 11:11:28');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) NULL DEFAULT NULL COMMENT '部门ID，一级部门为0',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门名称',
  `order_num` int(11) NULL DEFAULT NULL COMMENT '排序',
  `del_flag` tinyint(4) NULL DEFAULT 0 COMMENT '是否删除  -1：已删除  0：正常',
  `create_time` datetime(0) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '部门管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (1, 0, '腾讯', 0, 0, '2018-12-18 21:43:48', '2019-07-16 14:10:19');
INSERT INTO `sys_dept` VALUES (2, 1, '北京分公司', 0, 0, '2018-12-22 23:28:09', '2019-07-16 14:06:55');
INSERT INTO `sys_dept` VALUES (3, 1, '上海公司', 1, 0, '2018-12-22 23:28:14', '2019-07-16 14:06:59');
INSERT INTO `sys_dept` VALUES (4, 3, '技术部', 0, 0, '2018-12-22 23:28:18', '2019-07-16 14:07:16');
INSERT INTO `sys_dept` VALUES (5, 2, '销售部', 0, 0, '2018-12-22 23:28:23', '2019-07-16 14:07:04');
INSERT INTO `sys_dept` VALUES (6, 2, '技术部', 1, 0, '2018-12-22 15:27:54', '2019-07-16 14:07:09');
INSERT INTO `sys_dept` VALUES (7, 0, '阿里巴巴责任有限公司', 1, 0, '2019-07-16 13:48:09', '2019-07-16 14:10:24');
INSERT INTO `sys_dept` VALUES (8, 7, '支付宝', 0, 0, '2019-07-16 13:49:02', '2019-07-16 14:07:43');
INSERT INTO `sys_dept` VALUES (9, 8, '花呗', 0, 0, '2019-07-16 14:07:57', '2019-07-16 14:07:57');
INSERT INTO `sys_dept` VALUES (14, 7, '淘宝', 1, 0, '2019-07-17 17:35:31', '2019-07-17 17:35:31');
INSERT INTO `sys_dept` VALUES (15, 14, '技术部', 0, 0, '2019-07-17 17:35:58', '2019-07-17 17:35:58');
INSERT INTO `sys_dept` VALUES (16, 7, '闲鱼', 2, 0, '2019-08-15 18:12:38', '2019-08-15 18:12:44');

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `pid` bigint(20) NULL DEFAULT NULL COMMENT '父级字典',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `des` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '编码',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES (1, 0, '状态', '', 'status', 1, '2019-04-12 10:50:21', '2019-04-13 07:30:04');
INSERT INTO `sys_dict` VALUES (2, 1, '启用', NULL, '1', 1, '2019-04-12 10:50:25', '2019-04-12 10:50:28');
INSERT INTO `sys_dict` VALUES (3, 1, '禁用', NULL, '0', 2, '2019-04-12 10:50:30', '2019-04-12 10:50:33');
INSERT INTO `sys_dict` VALUES (4, 0, '性别', '', 'sex', 2, '2019-04-12 10:50:36', '2019-04-13 07:29:59');
INSERT INTO `sys_dict` VALUES (5, 4, '男', NULL, '1', 1, '2019-04-12 10:50:41', '2019-04-12 10:50:43');
INSERT INTO `sys_dict` VALUES (6, 4, '女', NULL, '2', 2, '2019-04-12 10:50:46', '2019-04-12 10:50:48');
INSERT INTO `sys_dict` VALUES (7, 0, '菜单类型', NULL, 'menu_type', 3, '2019-04-12 18:30:54', '2019-04-12 18:30:57');
INSERT INTO `sys_dict` VALUES (8, 7, '目录', NULL, '0', 1, '2019-04-12 18:31:48', '2019-04-12 18:31:50');
INSERT INTO `sys_dict` VALUES (9, 7, '菜单', NULL, '1', 2, '2019-04-12 18:32:10', '2019-04-12 18:32:12');
INSERT INTO `sys_dict` VALUES (10, 7, '按钮', NULL, '2', 3, '2019-04-12 18:32:25', '2019-04-12 18:32:28');
INSERT INTO `sys_dict` VALUES (11, 0, '定时任务状态', NULL, 'schedule_status', 4, '2019-04-13 11:49:28', '2019-04-13 11:49:30');
INSERT INTO `sys_dict` VALUES (12, 11, '正常', NULL, '1', 1, '2019-04-13 11:50:08', '2019-04-13 11:50:10');
INSERT INTO `sys_dict` VALUES (13, 11, '暂停', NULL, '0', 2, '2019-04-13 11:50:24', '2019-04-13 11:50:27');
INSERT INTO `sys_dict` VALUES (14, 0, '会议类型', NULL, 'meeting_type', 5, '2019-09-26 16:11:32', '2019-09-26 16:11:35');
INSERT INTO `sys_dict` VALUES (15, 14, '科室会', NULL, '1', 1, '2019-09-26 16:12:52', '2019-09-26 16:12:52');
INSERT INTO `sys_dict` VALUES (16, 14, '学术会', NULL, '2', 2, '2019-09-26 16:12:52', '2019-09-26 16:12:52');
INSERT INTO `sys_dict` VALUES (17, 14, '推广会', NULL, '3', 3, '2019-09-26 16:12:52', '2019-09-26 16:12:52');
INSERT INTO `sys_dict` VALUES (18, 0, '会议状态', NULL, 'meeting_status', 6, '2019-09-26 16:12:52', '2019-09-26 16:12:52');
INSERT INTO `sys_dict` VALUES (19, 18, '待审核', NULL, '01', 1, '2019-09-26 16:12:52', '2019-09-26 16:12:52');
INSERT INTO `sys_dict` VALUES (20, 18, '待修改', NULL, '02', 2, '2019-09-26 16:12:52', '2019-09-26 16:12:52');
INSERT INTO `sys_dict` VALUES (21, 18, '待开展', NULL, '03', 3, '2019-09-26 16:12:52', '2019-09-26 16:12:52');
INSERT INTO `sys_dict` VALUES (22, 18, '开展中', NULL, '04', 4, '2019-11-11 14:04:19', '2019-11-11 14:04:19');
INSERT INTO `sys_dict` VALUES (23, 18, '已结束', NULL, '05', 5, '2019-11-11 14:04:19', '2019-11-11 14:04:19');
INSERT INTO `sys_dict` VALUES (24, 0, '验证码限制次数', NULL, 'sms_code_limit', 7, '2019-11-11 14:04:19', '2019-11-11 14:04:19');
INSERT INTO `sys_dict` VALUES (25, 24, '30', NULL, 'day', 1, '2019-11-11 14:04:19', '2019-11-11 14:04:19');
INSERT INTO `sys_dict` VALUES (26, 24, '20', NULL, 'hours', 2, '2019-11-11 14:04:19', '2019-11-11 14:04:19');
INSERT INTO `sys_dict` VALUES (27, 24, '10', NULL, 'halfHours', 3, '2019-11-11 14:04:19', '2019-11-11 14:04:19');

-- ----------------------------
-- Table structure for sys_login_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_login_log`;
CREATE TABLE `sys_login_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `log_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '日志名称',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户ID',
  `succeed` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否成功',
  `message` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '消息',
  `ip_address` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'ip',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1150667819491475971 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '登陆日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_login_log
-- ----------------------------
INSERT INTO `sys_login_log` VALUES (1150667819491475800, '退出日志', 1, '成功', NULL, '127.0.0.1', '2019-08-06 10:01:11', '2019-08-06 10:01:11');
INSERT INTO `sys_login_log` VALUES (1150667819491475801, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-06 10:01:14', '2019-08-06 10:01:14');
INSERT INTO `sys_login_log` VALUES (1150667819491475802, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-06 13:45:46', '2019-08-06 13:45:46');
INSERT INTO `sys_login_log` VALUES (1150667819491475803, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-06 15:31:56', '2019-08-06 15:31:56');
INSERT INTO `sys_login_log` VALUES (1150667819491475804, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-07 08:37:55', '2019-08-07 08:37:55');
INSERT INTO `sys_login_log` VALUES (1150667819491475805, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-07 13:39:40', '2019-08-07 13:39:40');
INSERT INTO `sys_login_log` VALUES (1150667819491475806, '退出日志', 1, '成功', NULL, '127.0.0.1', '2019-08-07 16:16:13', '2019-08-07 16:16:13');
INSERT INTO `sys_login_log` VALUES (1150667819491475807, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-07 16:16:18', '2019-08-07 16:16:18');
INSERT INTO `sys_login_log` VALUES (1150667819491475808, '退出日志', 1, '成功', NULL, '127.0.0.1', '2019-08-07 17:56:22', '2019-08-07 17:56:22');
INSERT INTO `sys_login_log` VALUES (1150667819491475809, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-07 17:56:24', '2019-08-07 17:56:24');
INSERT INTO `sys_login_log` VALUES (1150667819491475810, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-08 09:32:55', '2019-08-08 09:32:55');
INSERT INTO `sys_login_log` VALUES (1150667819491475811, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-08 13:47:07', '2019-08-08 13:47:07');
INSERT INTO `sys_login_log` VALUES (1150667819491475812, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-08 14:29:37', '2019-08-08 14:29:37');
INSERT INTO `sys_login_log` VALUES (1150667819491475813, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-08 17:28:53', '2019-08-08 17:28:53');
INSERT INTO `sys_login_log` VALUES (1150667819491475814, '退出日志', 1, '成功', NULL, '127.0.0.1', '2019-08-08 17:30:30', '2019-08-08 17:30:30');
INSERT INTO `sys_login_log` VALUES (1150667819491475815, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-08 17:30:32', '2019-08-08 17:30:32');
INSERT INTO `sys_login_log` VALUES (1150667819491475816, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-09 08:50:45', '2019-08-09 08:50:45');
INSERT INTO `sys_login_log` VALUES (1150667819491475817, '退出日志', 1, '成功', NULL, '127.0.0.1', '2019-08-09 10:43:11', '2019-08-09 10:43:11');
INSERT INTO `sys_login_log` VALUES (1150667819491475818, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-09 10:43:24', '2019-08-09 10:43:24');
INSERT INTO `sys_login_log` VALUES (1150667819491475819, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-09 13:37:52', '2019-08-09 13:37:52');
INSERT INTO `sys_login_log` VALUES (1150667819491475820, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-12 09:52:58', '2019-08-12 09:52:58');
INSERT INTO `sys_login_log` VALUES (1150667819491475821, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-12 11:28:06', '2019-08-12 11:28:06');
INSERT INTO `sys_login_log` VALUES (1150667819491475822, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-12 13:36:42', '2019-08-12 13:36:42');
INSERT INTO `sys_login_log` VALUES (1150667819491475823, '退出日志', 1, '成功', NULL, '127.0.0.1', '2019-08-12 15:23:07', '2019-08-12 15:23:07');
INSERT INTO `sys_login_log` VALUES (1150667819491475824, '登录日志', 2, '成功', NULL, '127.0.0.1', '2019-08-12 15:23:12', '2019-08-12 15:23:12');
INSERT INTO `sys_login_log` VALUES (1150667819491475825, '退出日志', 2, '成功', NULL, '127.0.0.1', '2019-08-12 15:23:16', '2019-08-12 15:23:16');
INSERT INTO `sys_login_log` VALUES (1150667819491475826, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-12 15:23:19', '2019-08-12 15:23:19');
INSERT INTO `sys_login_log` VALUES (1150667819491475827, '退出日志', 1, '成功', NULL, '127.0.0.1', '2019-08-12 15:44:17', '2019-08-12 15:44:17');
INSERT INTO `sys_login_log` VALUES (1150667819491475828, '登录日志', 2, '成功', NULL, '127.0.0.1', '2019-08-12 15:44:22', '2019-08-12 15:44:22');
INSERT INTO `sys_login_log` VALUES (1150667819491475829, '退出日志', 2, '成功', NULL, '127.0.0.1', '2019-08-12 15:45:33', '2019-08-12 15:45:33');
INSERT INTO `sys_login_log` VALUES (1150667819491475830, '登录日志', 2, '成功', NULL, '127.0.0.1', '2019-08-12 15:45:37', '2019-08-12 15:45:37');
INSERT INTO `sys_login_log` VALUES (1150667819491475831, '退出日志', 2, '成功', NULL, '127.0.0.1', '2019-08-12 15:45:48', '2019-08-12 15:45:48');
INSERT INTO `sys_login_log` VALUES (1150667819491475832, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-12 15:45:50', '2019-08-12 15:45:50');
INSERT INTO `sys_login_log` VALUES (1150667819491475833, '退出日志', 1, '成功', NULL, '127.0.0.1', '2019-08-12 16:34:44', '2019-08-12 16:34:44');
INSERT INTO `sys_login_log` VALUES (1150667819491475834, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-12 16:34:46', '2019-08-12 16:34:46');
INSERT INTO `sys_login_log` VALUES (1150667819491475835, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-13 15:01:27', '2019-08-13 15:01:27');
INSERT INTO `sys_login_log` VALUES (1150667819491475836, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-14 08:59:55', '2019-08-14 08:59:55');
INSERT INTO `sys_login_log` VALUES (1150667819491475837, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-14 13:55:58', '2019-08-14 13:55:58');
INSERT INTO `sys_login_log` VALUES (1150667819491475838, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-14 15:04:34', '2019-08-14 15:04:34');
INSERT INTO `sys_login_log` VALUES (1150667819491475839, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-14 15:42:55', '2019-08-14 15:42:55');
INSERT INTO `sys_login_log` VALUES (1150667819491475840, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-14 17:58:56', '2019-08-14 17:58:56');
INSERT INTO `sys_login_log` VALUES (1150667819491475841, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-15 09:06:35', '2019-08-15 09:06:35');
INSERT INTO `sys_login_log` VALUES (1150667819491475842, '退出日志', 1, '成功', NULL, '127.0.0.1', '2019-08-15 09:20:56', '2019-08-15 09:20:56');
INSERT INTO `sys_login_log` VALUES (1150667819491475843, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-15 09:21:10', '2019-08-15 09:21:10');
INSERT INTO `sys_login_log` VALUES (1150667819491475844, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-15 11:19:50', '2019-08-15 11:19:50');
INSERT INTO `sys_login_log` VALUES (1150667819491475845, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-15 13:40:11', '2019-08-15 13:40:11');
INSERT INTO `sys_login_log` VALUES (1150667819491475846, '退出日志', 1, '成功', NULL, '127.0.0.1', '2019-08-15 14:17:00', '2019-08-15 14:17:00');
INSERT INTO `sys_login_log` VALUES (1150667819491475847, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-15 14:17:03', '2019-08-15 14:17:03');
INSERT INTO `sys_login_log` VALUES (1150667819491475848, '退出日志', 1, '成功', NULL, '127.0.0.1', '2019-08-15 14:17:21', '2019-08-15 14:17:21');
INSERT INTO `sys_login_log` VALUES (1150667819491475849, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-15 14:17:24', '2019-08-15 14:17:24');
INSERT INTO `sys_login_log` VALUES (1150667819491475850, '退出日志', 1, '成功', NULL, '127.0.0.1', '2019-08-15 15:47:43', '2019-08-15 15:47:43');
INSERT INTO `sys_login_log` VALUES (1150667819491475851, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-15 15:47:46', '2019-08-15 15:47:46');
INSERT INTO `sys_login_log` VALUES (1150667819491475852, '退出日志', 1, '成功', NULL, '127.0.0.1', '2019-08-15 17:35:56', '2019-08-15 17:35:56');
INSERT INTO `sys_login_log` VALUES (1150667819491475853, '登录日志', 2, '成功', NULL, '127.0.0.1', '2019-08-15 17:36:02', '2019-08-15 17:36:02');
INSERT INTO `sys_login_log` VALUES (1150667819491475854, '退出日志', 2, '成功', NULL, '127.0.0.1', '2019-08-15 17:36:09', '2019-08-15 17:36:09');
INSERT INTO `sys_login_log` VALUES (1150667819491475855, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-15 17:36:12', '2019-08-15 17:36:12');
INSERT INTO `sys_login_log` VALUES (1150667819491475856, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-16 08:55:17', '2019-08-16 08:55:17');
INSERT INTO `sys_login_log` VALUES (1150667819491475857, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-16 14:48:57', '2019-08-16 14:48:57');
INSERT INTO `sys_login_log` VALUES (1150667819491475858, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-21 08:53:27', '2019-08-21 08:53:27');
INSERT INTO `sys_login_log` VALUES (1150667819491475859, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-21 13:43:59', '2019-08-21 13:43:59');
INSERT INTO `sys_login_log` VALUES (1150667819491475860, '退出日志', 1, '成功', NULL, '127.0.0.1', '2019-08-21 14:12:05', '2019-08-21 14:12:05');
INSERT INTO `sys_login_log` VALUES (1150667819491475861, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-21 14:12:08', '2019-08-21 14:12:08');
INSERT INTO `sys_login_log` VALUES (1150667819491475862, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-22 09:57:48', '2019-08-22 09:57:48');
INSERT INTO `sys_login_log` VALUES (1150667819491475863, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-22 10:37:55', '2019-08-22 10:37:55');
INSERT INTO `sys_login_log` VALUES (1150667819491475864, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-22 10:42:21', '2019-08-22 10:42:21');
INSERT INTO `sys_login_log` VALUES (1150667819491475865, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-22 10:43:22', '2019-08-22 10:43:22');
INSERT INTO `sys_login_log` VALUES (1150667819491475866, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-22 10:43:58', '2019-08-22 10:43:58');
INSERT INTO `sys_login_log` VALUES (1150667819491475867, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-22 11:16:27', '2019-08-22 11:16:27');
INSERT INTO `sys_login_log` VALUES (1150667819491475868, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-22 11:18:32', '2019-08-22 11:18:32');
INSERT INTO `sys_login_log` VALUES (1150667819491475869, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-22 11:20:15', '2019-08-22 11:20:15');
INSERT INTO `sys_login_log` VALUES (1150667819491475870, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-22 11:22:26', '2019-08-22 11:22:26');
INSERT INTO `sys_login_log` VALUES (1150667819491475871, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-22 11:23:57', '2019-08-22 11:23:57');
INSERT INTO `sys_login_log` VALUES (1150667819491475872, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-22 14:20:09', '2019-08-22 14:20:09');
INSERT INTO `sys_login_log` VALUES (1150667819491475873, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-22 14:23:14', '2019-08-22 14:23:14');
INSERT INTO `sys_login_log` VALUES (1150667819491475874, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-22 15:12:12', '2019-08-22 15:12:12');
INSERT INTO `sys_login_log` VALUES (1150667819491475875, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-22 15:14:42', '2019-08-22 15:14:42');
INSERT INTO `sys_login_log` VALUES (1150667819491475876, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-22 16:22:08', '2019-08-22 16:22:08');
INSERT INTO `sys_login_log` VALUES (1150667819491475877, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-22 16:22:43', '2019-08-22 16:22:43');
INSERT INTO `sys_login_log` VALUES (1150667819491475878, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-22 17:01:07', '2019-08-22 17:01:07');
INSERT INTO `sys_login_log` VALUES (1150667819491475879, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-22 17:59:49', '2019-08-22 17:59:49');
INSERT INTO `sys_login_log` VALUES (1150667819491475880, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-22 18:01:41', '2019-08-22 18:01:41');
INSERT INTO `sys_login_log` VALUES (1150667819491475881, '退出日志', 1, '成功', NULL, '127.0.0.1', '2019-08-22 18:01:50', '2019-08-22 18:01:50');
INSERT INTO `sys_login_log` VALUES (1150667819491475882, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-23 08:56:51', '2019-08-23 08:56:51');
INSERT INTO `sys_login_log` VALUES (1150667819491475883, '退出日志', 1, '成功', NULL, '127.0.0.1', '2019-08-23 08:56:59', '2019-08-23 08:56:59');
INSERT INTO `sys_login_log` VALUES (1150667819491475884, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-23 09:09:18', '2019-08-23 09:09:18');
INSERT INTO `sys_login_log` VALUES (1150667819491475885, '退出日志', 1, '成功', NULL, '127.0.0.1', '2019-08-23 09:09:24', '2019-08-23 09:09:24');
INSERT INTO `sys_login_log` VALUES (1150667819491475886, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-23 10:52:20', '2019-08-23 10:52:20');
INSERT INTO `sys_login_log` VALUES (1150667819491475887, '退出日志', 1, '成功', NULL, '127.0.0.1', '2019-08-23 10:52:32', '2019-08-23 10:52:32');
INSERT INTO `sys_login_log` VALUES (1150667819491475888, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-23 10:53:55', '2019-08-23 10:53:55');
INSERT INTO `sys_login_log` VALUES (1150667819491475889, '退出日志', 1, '成功', NULL, '127.0.0.1', '2019-08-23 10:54:05', '2019-08-23 10:54:05');
INSERT INTO `sys_login_log` VALUES (1150667819491475890, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-23 10:54:23', '2019-08-23 10:54:23');
INSERT INTO `sys_login_log` VALUES (1150667819491475891, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-23 16:25:44', '2019-08-23 16:25:44');
INSERT INTO `sys_login_log` VALUES (1150667819491475892, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-23 16:39:16', '2019-08-23 16:39:16');
INSERT INTO `sys_login_log` VALUES (1150667819491475893, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-23 16:41:31', '2019-08-23 16:41:31');
INSERT INTO `sys_login_log` VALUES (1150667819491475894, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-26 14:10:42', '2019-08-26 14:10:42');
INSERT INTO `sys_login_log` VALUES (1150667819491475895, '退出日志', 1, '成功', NULL, '127.0.0.1', '2019-08-26 14:43:36', '2019-08-26 14:43:36');
INSERT INTO `sys_login_log` VALUES (1150667819491475896, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-26 14:47:03', '2019-08-26 14:47:03');
INSERT INTO `sys_login_log` VALUES (1150667819491475897, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-26 14:48:44', '2019-08-26 14:48:44');
INSERT INTO `sys_login_log` VALUES (1150667819491475898, '退出日志', 1, '成功', NULL, '127.0.0.1', '2019-08-26 14:49:45', '2019-08-26 14:49:45');
INSERT INTO `sys_login_log` VALUES (1150667819491475899, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-26 14:56:04', '2019-08-26 14:56:04');
INSERT INTO `sys_login_log` VALUES (1150667819491475900, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-27 10:40:12', '2019-08-27 10:40:12');
INSERT INTO `sys_login_log` VALUES (1150667819491475901, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-27 14:27:06', '2019-08-27 14:27:06');
INSERT INTO `sys_login_log` VALUES (1150667819491475902, '退出日志', 1, '成功', NULL, '127.0.0.1', '2019-08-27 14:50:30', '2019-08-27 14:50:30');
INSERT INTO `sys_login_log` VALUES (1150667819491475903, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-08-27 14:50:32', '2019-08-27 14:50:32');
INSERT INTO `sys_login_log` VALUES (1150667819491475904, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-09-02 09:43:56', '2019-09-02 09:43:56');
INSERT INTO `sys_login_log` VALUES (1150667819491475905, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-09-02 14:12:47', '2019-09-02 14:12:47');
INSERT INTO `sys_login_log` VALUES (1150667819491475906, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-09-05 09:49:34', '2019-09-05 09:49:34');
INSERT INTO `sys_login_log` VALUES (1150667819491475907, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-09-05 16:17:22', '2019-09-05 16:17:22');
INSERT INTO `sys_login_log` VALUES (1150667819491475908, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-09-25 09:35:17', '2019-09-25 09:35:17');
INSERT INTO `sys_login_log` VALUES (1150667819491475909, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-09-25 14:08:00', '2019-09-25 14:08:00');
INSERT INTO `sys_login_log` VALUES (1150667819491475910, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-09-26 08:43:45', '2019-09-26 08:43:45');
INSERT INTO `sys_login_log` VALUES (1150667819491475911, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-09-26 10:46:49', '2019-09-26 10:46:49');
INSERT INTO `sys_login_log` VALUES (1150667819491475912, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-09-26 14:07:36', '2019-09-26 14:07:36');
INSERT INTO `sys_login_log` VALUES (1150667819491475913, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-09-27 09:03:21', '2019-09-27 09:03:21');
INSERT INTO `sys_login_log` VALUES (1150667819491475914, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-09-27 14:06:18', '2019-09-27 14:06:18');
INSERT INTO `sys_login_log` VALUES (1150667819491475915, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-09-29 08:59:50', '2019-09-29 08:59:50');
INSERT INTO `sys_login_log` VALUES (1150667819491475916, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-09-29 13:58:40', '2019-09-29 13:58:40');
INSERT INTO `sys_login_log` VALUES (1150667819491475917, '退出日志', 1, '成功', NULL, '127.0.0.1', '2019-09-29 14:09:11', '2019-09-29 14:09:11');
INSERT INTO `sys_login_log` VALUES (1150667819491475918, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-09-29 14:09:13', '2019-09-29 14:09:13');
INSERT INTO `sys_login_log` VALUES (1150667819491475919, '退出日志', 1, '成功', NULL, '127.0.0.1', '2019-09-29 15:00:25', '2019-09-29 15:00:25');
INSERT INTO `sys_login_log` VALUES (1150667819491475920, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-09-29 15:00:38', '2019-09-29 15:00:38');
INSERT INTO `sys_login_log` VALUES (1150667819491475921, '退出日志', 1, '成功', NULL, '127.0.0.1', '2019-09-29 15:03:50', '2019-09-29 15:03:50');
INSERT INTO `sys_login_log` VALUES (1150667819491475922, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-09-29 15:03:53', '2019-09-29 15:03:53');
INSERT INTO `sys_login_log` VALUES (1150667819491475923, '退出日志', 1, '成功', NULL, '127.0.0.1', '2019-09-29 15:05:05', '2019-09-29 15:05:05');
INSERT INTO `sys_login_log` VALUES (1150667819491475924, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-09-29 15:05:08', '2019-09-29 15:05:08');
INSERT INTO `sys_login_log` VALUES (1150667819491475925, '退出日志', 1, '成功', NULL, '127.0.0.1', '2019-09-29 15:05:31', '2019-09-29 15:05:31');
INSERT INTO `sys_login_log` VALUES (1150667819491475926, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-09-29 15:05:33', '2019-09-29 15:05:33');
INSERT INTO `sys_login_log` VALUES (1150667819491475927, '退出日志', 1, '成功', NULL, '127.0.0.1', '2019-09-29 15:22:55', '2019-09-29 15:22:55');
INSERT INTO `sys_login_log` VALUES (1150667819491475928, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-09-29 15:22:57', '2019-09-29 15:22:57');
INSERT INTO `sys_login_log` VALUES (1150667819491475929, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-10-16 15:34:43', '2019-10-16 15:34:43');
INSERT INTO `sys_login_log` VALUES (1150667819491475930, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-10-18 16:50:09', '2019-10-18 16:50:09');
INSERT INTO `sys_login_log` VALUES (1150667819491475931, '登录日志', 1, '成功', NULL, '117.136.38.135', '2019-10-23 14:59:41', '2019-10-23 14:59:41');
INSERT INTO `sys_login_log` VALUES (1150667819491475932, '退出日志', 1, '成功', NULL, '117.136.38.135', '2019-10-23 15:00:13', '2019-10-23 15:00:13');
INSERT INTO `sys_login_log` VALUES (1150667819491475933, '登录日志', 1, '成功', NULL, '117.136.38.135', '2019-10-23 15:00:16', '2019-10-23 15:00:16');
INSERT INTO `sys_login_log` VALUES (1150667819491475934, '登录日志', 1, '成功', NULL, '117.136.38.135', '2019-10-23 15:02:55', '2019-10-23 15:02:55');
INSERT INTO `sys_login_log` VALUES (1150667819491475935, '退出日志', 1, '成功', NULL, '117.136.38.135', '2019-10-23 15:03:03', '2019-10-23 15:03:03');
INSERT INTO `sys_login_log` VALUES (1150667819491475936, '登录日志', 1, '成功', NULL, '117.136.38.135', '2019-10-23 15:43:38', '2019-10-23 15:43:38');
INSERT INTO `sys_login_log` VALUES (1150667819491475937, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-10-31 06:30:41', '2019-10-31 06:30:41');
INSERT INTO `sys_login_log` VALUES (1150667819491475938, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-10-31 07:01:39', '2019-10-31 07:01:39');
INSERT INTO `sys_login_log` VALUES (1150667819491475939, '退出日志', 1, '成功', NULL, '127.0.0.1', '2019-10-31 07:03:01', '2019-10-31 07:03:01');
INSERT INTO `sys_login_log` VALUES (1150667819491475940, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-10-31 07:03:04', '2019-10-31 07:03:04');
INSERT INTO `sys_login_log` VALUES (1150667819491475941, '退出日志', 1, '成功', NULL, '127.0.0.1', '2019-10-31 08:30:22', '2019-10-31 08:30:22');
INSERT INTO `sys_login_log` VALUES (1150667819491475942, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-10-31 08:30:26', '2019-10-31 08:30:26');
INSERT INTO `sys_login_log` VALUES (1150667819491475943, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-10-31 09:55:52', '2019-10-31 09:55:52');
INSERT INTO `sys_login_log` VALUES (1150667819491475944, '登录日志', 1, '成功', NULL, '117.136.0.240', '2019-11-04 02:31:34', '2019-11-04 02:31:34');
INSERT INTO `sys_login_log` VALUES (1150667819491475945, '退出日志', 1, '成功', NULL, '117.136.0.240', '2019-11-04 02:32:37', '2019-11-04 02:32:37');
INSERT INTO `sys_login_log` VALUES (1150667819491475946, '登录日志', 1, '成功', NULL, '61.148.245.251', '2019-11-04 10:14:57', '2019-11-04 10:14:57');
INSERT INTO `sys_login_log` VALUES (1150667819491475947, '退出日志', 1, '成功', NULL, '61.148.245.251', '2019-11-04 10:15:10', '2019-11-04 10:15:10');
INSERT INTO `sys_login_log` VALUES (1150667819491475948, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-11-18 01:51:32', '2019-11-18 01:51:32');
INSERT INTO `sys_login_log` VALUES (1150667819491475949, '退出日志', 1, '成功', NULL, '127.0.0.1', '2019-11-18 01:52:41', '2019-11-18 01:52:41');
INSERT INTO `sys_login_log` VALUES (1150667819491475950, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-11-18 01:52:58', '2019-11-18 01:52:58');
INSERT INTO `sys_login_log` VALUES (1150667819491475951, '退出日志', 1, '成功', NULL, '127.0.0.1', '2019-11-18 01:53:16', '2019-11-18 01:53:16');
INSERT INTO `sys_login_log` VALUES (1150667819491475952, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-11-19 06:46:28', '2019-11-19 06:46:28');
INSERT INTO `sys_login_log` VALUES (1150667819491475953, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-11-19 07:17:52', '2019-11-19 07:17:52');
INSERT INTO `sys_login_log` VALUES (1150667819491475954, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-11-19 07:18:35', '2019-11-19 07:18:35');
INSERT INTO `sys_login_log` VALUES (1150667819491475955, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-11-19 09:10:57', '2019-11-19 09:10:57');
INSERT INTO `sys_login_log` VALUES (1150667819491475956, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-11-19 09:17:57', '2019-11-19 09:17:57');
INSERT INTO `sys_login_log` VALUES (1150667819491475957, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-11-19 09:26:58', '2019-11-19 09:26:58');
INSERT INTO `sys_login_log` VALUES (1150667819491475958, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-11-19 09:29:02', '2019-11-19 09:29:02');
INSERT INTO `sys_login_log` VALUES (1150667819491475959, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-11-19 09:29:27', '2019-11-19 09:29:27');
INSERT INTO `sys_login_log` VALUES (1150667819491475960, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-11-19 09:56:27', '2019-11-19 09:56:27');
INSERT INTO `sys_login_log` VALUES (1150667819491475961, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-11-20 01:45:14', '2019-11-20 01:45:14');
INSERT INTO `sys_login_log` VALUES (1150667819491475962, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-11-20 02:09:44', '2019-11-20 02:09:44');
INSERT INTO `sys_login_log` VALUES (1150667819491475963, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-11-20 02:16:47', '2019-11-20 02:16:47');
INSERT INTO `sys_login_log` VALUES (1150667819491475964, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-11-20 10:25:19', '2019-11-20 10:25:19');
INSERT INTO `sys_login_log` VALUES (1150667819491475965, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-11-20 10:32:15', '2019-11-20 10:32:15');
INSERT INTO `sys_login_log` VALUES (1150667819491475966, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-11-20 10:42:27', '2019-11-20 10:42:27');
INSERT INTO `sys_login_log` VALUES (1150667819491475967, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-11-20 11:01:34', '2019-11-20 11:01:34');
INSERT INTO `sys_login_log` VALUES (1150667819491475968, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-11-20 11:04:05', '2019-11-20 11:04:05');
INSERT INTO `sys_login_log` VALUES (1150667819491475969, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-11-20 11:07:19', '2019-11-20 11:07:19');
INSERT INTO `sys_login_log` VALUES (1150667819491475970, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-11-20 11:12:19', '2019-11-20 11:12:19');
INSERT INTO `sys_login_log` VALUES (1150667819491475971, '登录日志', 1, '成功', NULL, '127.0.0.1', '2019-11-20 17:02:43', '2019-11-20 17:02:43');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) NULL DEFAULT NULL COMMENT '父菜单ID，一级菜单为0',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单名称',
  `url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单URL',
  `perms` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '授权(多个用逗号分隔，如：user:list,user:create)',
  `type` int(11) NULL DEFAULT NULL COMMENT '类型   0：目录   1：菜单   2：按钮',
  `icon` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单图标',
  `order_num` int(11) NULL DEFAULT NULL COMMENT '排序',
  `create_by` bigint(20) NULL DEFAULT NULL,
  `update_by` bigint(20) NULL DEFAULT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `del_flag` tinyint(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 90 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜单管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, 0, '系统首页', 'dashboard', 'sys:dashboard:info', 1, 'el-icon-lx-home', 0, 1, 1, '2018-12-06 14:54:07', '2018-12-06 14:54:09', 0);
INSERT INTO `sys_menu` VALUES (2, 0, '系统管理', 'sys', '', 0, 'el-icon-lx-settings', 15, 1, 1, '2018-12-10 17:52:34', '2018-12-10 17:52:37', 0);
INSERT INTO `sys_menu` VALUES (3, 2, '用户管理', 'sysuser', 'sys:user:list', 1, NULL, 16, 1, 1, '2018-12-10 18:28:59', '2019-01-02 10:38:09', 0);
INSERT INTO `sys_menu` VALUES (4, 2, '角色管理', 'sysrole', 'sys:role:list', 1, NULL, 17, 1, 1, '2018-12-10 18:35:34', '2019-01-03 01:33:09', 0);
INSERT INTO `sys_menu` VALUES (5, 2, '菜单管理', 'sysmenu', 'sys:menu:list', 1, NULL, 18, 1, 1, '2018-12-10 18:36:16', '2019-01-03 01:39:01', 0);
INSERT INTO `sys_menu` VALUES (6, 2, '企业管理', 'sysdept', 'sys:dept:list', 1, NULL, 19, 1, 1, '2018-12-10 18:37:20', '2019-01-03 01:41:49', 0);
INSERT INTO `sys_menu` VALUES (7, 2, '定时任务', 'sysschedule', 'sys:schedule:list', 1, NULL, 21, 1, 1, '2018-12-10 18:39:14', '2019-01-03 01:42:33', 0);
INSERT INTO `sys_menu` VALUES (8, 2, '字典管理', 'sysdict', 'sys:dict:list', 1, NULL, 24, NULL, NULL, '2019-04-13 07:10:28', '2019-04-15 07:18:41', 0);
INSERT INTO `sys_menu` VALUES (10, 2, '登陆日志', 'sysloginlog', 'sys:loginLog:list', 1, NULL, 22, NULL, NULL, '2019-04-12 07:26:22', '2019-04-15 07:14:49', 0);
INSERT INTO `sys_menu` VALUES (11, 2, '操作日志', 'sysoperationlog', 'sys:operationLog:list', 1, NULL, 23, NULL, NULL, '2019-04-12 08:07:19', '2019-04-15 07:18:14', 0);
INSERT INTO `sys_menu` VALUES (12, 3, '新增', 'sys/user/add', 'sys:user:add', 2, NULL, 1, NULL, NULL, '2019-01-02 10:35:57', '2019-06-27 17:35:21', 0);
INSERT INTO `sys_menu` VALUES (13, 3, '删除', 'sys/user/del', 'sys:user:del', 2, NULL, 3, NULL, NULL, '2019-01-02 10:38:50', '2019-06-27 17:34:58', 0);
INSERT INTO `sys_menu` VALUES (14, 3, '重置密码', 'sys/user/reset/password', 'sys:user:resetPassword', 2, NULL, 4, NULL, NULL, '2019-01-03 01:26:19', '2019-06-27 17:34:47', 0);
INSERT INTO `sys_menu` VALUES (15, 3, '修改密码', 'sys/user/change/password', 'sys:user:changePassword', 2, NULL, 5, NULL, NULL, '2019-01-03 01:27:06', '2019-06-27 17:34:38', 0);
INSERT INTO `sys_menu` VALUES (16, 3, '编辑', 'sys/user/edit', 'sys:user:edit', 2, NULL, 2, NULL, NULL, '2019-06-27 17:36:01', '2019-06-27 17:36:01', 0);
INSERT INTO `sys_menu` VALUES (17, 3, '清除缓存', 'sys/user/clearCache', 'sys:user:clearCache', 2, NULL, 6, NULL, NULL, '2019-06-28 10:51:11', '2019-06-28 10:51:37', 0);
INSERT INTO `sys_menu` VALUES (18, 4, '新增', 'sys/role/add', 'sys:role:add', 2, NULL, 1, NULL, NULL, '2019-01-03 01:30:55', '2019-06-27 17:37:17', 0);
INSERT INTO `sys_menu` VALUES (19, 4, '删除', 'sys/role/del', 'sys:role:del', 2, NULL, 3, NULL, NULL, '2019-01-03 01:31:49', '2019-06-27 17:36:30', 0);
INSERT INTO `sys_menu` VALUES (20, 4, '权限配置', 'sys/role/configPerm', 'sys:role:configPerm', 2, NULL, 4, NULL, NULL, '2019-01-03 01:32:42', '2019-06-27 17:36:22', 0);
INSERT INTO `sys_menu` VALUES (21, 4, '编辑', 'sys/role/edit', 'sys:role:edit', 2, NULL, 2, NULL, NULL, '2019-06-27 17:37:02', '2019-06-27 17:37:02', 0);
INSERT INTO `sys_menu` VALUES (22, 5, '新增', 'sys/menu/add', 'sys:menu:add', 2, NULL, 1, NULL, NULL, '2019-01-03 01:37:40', '2019-06-27 17:37:53', 0);
INSERT INTO `sys_menu` VALUES (23, 5, '删除', 'sys/menu/del', 'sys:menu:del', 2, NULL, 2, NULL, NULL, '2019-01-03 01:38:13', '2019-04-15 07:22:48', 0);
INSERT INTO `sys_menu` VALUES (24, 5, '编辑', 'sys/menu/edit', 'sys:menu:edit', 2, NULL, 3, NULL, NULL, '2019-01-03 01:38:47', '2019-04-15 07:22:54', 0);
INSERT INTO `sys_menu` VALUES (25, 6, '编辑', 'sys/dept/edit', 'sys:dept:edit', 2, NULL, 3, NULL, NULL, '2019-01-03 01:41:23', '2019-04-15 07:23:13', 0);
INSERT INTO `sys_menu` VALUES (26, 6, '新增', 'sys/dept/add', 'sys:dept:add', 2, NULL, 1, NULL, NULL, '2019-01-03 01:39:55', '2019-07-15 11:14:21', 0);
INSERT INTO `sys_menu` VALUES (27, 6, '删除', 'sys/dept/del', 'sys:dept:del', 2, NULL, 2, NULL, NULL, '2019-01-03 01:40:57', '2019-04-15 07:23:07', 0);
INSERT INTO `sys_menu` VALUES (28, 7, '删除', 'sys/schedule/del', 'sys:schedule:del', 2, NULL, 3, NULL, NULL, '2019-01-03 01:44:42', '2019-04-15 07:23:44', 0);
INSERT INTO `sys_menu` VALUES (29, 7, '新增', 'sys/schedule/add', 'sys:schedule:add', 2, NULL, 1, NULL, NULL, '2019-01-03 01:43:30', '2019-04-15 07:23:35', 0);
INSERT INTO `sys_menu` VALUES (30, 7, '修改', 'sys/schedule/edit', 'sys:schedule:edit', 2, NULL, 2, NULL, NULL, '2019-01-03 01:44:03', '2019-04-15 07:23:28', 0);
INSERT INTO `sys_menu` VALUES (31, 7, '运行一次', 'sys/schedule/run', 'sys:schedule:run', 2, NULL, 4, NULL, NULL, '2019-06-28 10:36:50', '2019-06-28 10:36:50', 0);
INSERT INTO `sys_menu` VALUES (32, 7, '停止', 'sys/schedule/pause', 'sys:schedule:pause', 2, NULL, 5, NULL, NULL, '2019-06-28 10:37:31', '2019-06-28 10:37:31', 0);
INSERT INTO `sys_menu` VALUES (33, 7, '恢复', 'sys/schedule/resume', 'sys:schedule:resume', 2, NULL, 6, NULL, NULL, '2019-06-28 10:38:07', '2019-06-28 10:38:07', 0);
INSERT INTO `sys_menu` VALUES (34, 10, '清空日志', 'sys/loginLog/clear', 'sys:loginLog:clear', 2, NULL, 1, NULL, NULL, '2019-04-15 07:25:37', '2019-04-15 07:25:37', 0);
INSERT INTO `sys_menu` VALUES (35, 11, '清空日志', 'sys/operationLog/clear', 'sys:operationLog:clear', 2, NULL, 2, NULL, NULL, '2019-04-15 07:27:08', '2019-04-15 07:27:08', 0);
INSERT INTO `sys_menu` VALUES (36, 8, '查看字典', 'sys/dict/info', 'sys:dict:info', 2, NULL, 4, NULL, NULL, '2019-06-28 10:45:47', '2019-06-28 10:45:47', 0);
INSERT INTO `sys_menu` VALUES (37, 8, '新增', 'sys/dict/add', 'sys:dict:add', 2, NULL, 1, NULL, NULL, '2019-04-15 07:19:26', '2019-04-15 07:24:11', 0);
INSERT INTO `sys_menu` VALUES (38, 8, '删除', 'sys/dict/delete', 'sys:dict:del', 2, NULL, 2, NULL, NULL, '2019-04-15 07:20:14', '2019-04-15 07:24:16', 0);
INSERT INTO `sys_menu` VALUES (39, 8, '编辑', 'sys/dict/edit', 'sys:dict:edit', 2, NULL, 3, NULL, NULL, '2019-06-28 10:44:41', '2019-06-28 10:44:41', 0);
INSERT INTO `sys_menu` VALUES (40, 0, '会议管理', 'meeting', '', 0, 'el-icon-notebook-1', 30, NULL, NULL, '2019-06-17 14:07:41', '2019-07-17 13:39:53', 0);
INSERT INTO `sys_menu` VALUES (41, 40, '会议列表', 'meetingdetail', 'meeting:detail:list', 1, NULL, 31, NULL, NULL, '2019-06-19 16:21:49', '2019-06-19 16:22:13', 0);
INSERT INTO `sys_menu` VALUES (42, 40, '会议课件', 'meetingcourse', 'meeting:course:list', 1, NULL, 32, NULL, NULL, '2019-06-28 16:52:43', '2019-06-28 16:58:29', 0);
INSERT INTO `sys_menu` VALUES (43, 40, '会议场所', 'meetingplace', 'meeting:place:list', 1, NULL, 33, NULL, NULL, '2019-06-28 16:56:22', '2019-06-28 16:56:22', 0);
INSERT INTO `sys_menu` VALUES (44, 40, '会议问卷', 'meetingquestion', 'meeting:question:list', 1, NULL, 34, NULL, NULL, '2019-06-28 16:58:06', '2019-06-28 16:58:06', 0);
INSERT INTO `sys_menu` VALUES (45, 41, '导出', 'meeting/detail/export', 'meeting:detail:export', 2, NULL, 1, NULL, NULL, '2019-06-27 15:46:49', '2019-07-11 11:00:23', 0);
INSERT INTO `sys_menu` VALUES (46, 41, '查看', 'meeting/detail/info', 'meeting:detail:info', 2, NULL, 2, NULL, NULL, '2019-06-27 15:59:08', '2019-07-11 11:00:28', 0);
INSERT INTO `sys_menu` VALUES (47, 42, '上传', 'meeting/course/upload', 'meeting:course:upload', 2, NULL, 1, NULL, NULL, '2019-07-11 10:59:30', '2019-07-11 10:59:58', 0);
INSERT INTO `sys_menu` VALUES (48, 42, '下载', 'meeting/course/download', 'meeting:course:download', 2, NULL, 2, NULL, NULL, '2019-07-11 13:27:44', '2019-07-11 13:27:44', 0);
INSERT INTO `sys_menu` VALUES (49, 42, '删除', 'meeting/course/del', 'meeting:course:del', 2, NULL, 3, NULL, NULL, '2019-07-11 13:28:18', '2019-07-11 13:28:18', 0);
INSERT INTO `sys_menu` VALUES (50, 0, '医生管理', 'hospital', '', 0, 'el-icon-first-aid-kit', 40, NULL, NULL, '2019-06-28 17:31:58', '2019-07-17 13:40:00', 0);
INSERT INTO `sys_menu` VALUES (51, 50, '医生列表', 'hospitaldoctor', 'hospital:doctor:list', 1, NULL, 41, NULL, NULL, '2019-06-28 17:33:54', '2019-06-28 17:33:54', 0);
INSERT INTO `sys_menu` VALUES (52, 50, '医院列表', 'hospitaldetail', 'hospital:detail:list', 1, NULL, 42, NULL, NULL, '2019-06-28 17:34:48', '2019-06-28 17:34:48', 0);
INSERT INTO `sys_menu` VALUES (57, 0, '用户管理', 'user', NULL, 0, 'el-icon-user', 50, NULL, NULL, '2019-08-05 10:33:48', '2019-08-05 10:34:45', 0);
INSERT INTO `sys_menu` VALUES (58, 57, '用户列表', 'userdetail', 'user:detail:list', 1, NULL, 51, NULL, NULL, '2019-08-05 10:54:05', '2019-08-05 10:54:05', 0);
INSERT INTO `sys_menu` VALUES (59, 57, '区域管理', 'userarea', 'user:area:list', 1, NULL, 52, NULL, NULL, '2019-08-05 10:55:35', '2019-08-05 10:55:35', 0);
INSERT INTO `sys_menu` VALUES (60, 57, '角色管理', 'userrole', 'user:role:list', 1, NULL, 53, NULL, NULL, '2019-08-05 10:56:12', '2019-08-05 10:56:12', 0);
INSERT INTO `sys_menu` VALUES (61, 57, '权限管理', 'userpermissions', 'user:permissions:list', 1, NULL, 54, NULL, NULL, '2019-08-05 10:57:33', '2019-08-05 10:57:33', 0);
INSERT INTO `sys_menu` VALUES (64, 58, '新增', 'user/detail/add', 'user:detail:add', 2, NULL, 1, NULL, NULL, '2019-08-05 15:52:24', '2019-08-05 15:52:24', 0);
INSERT INTO `sys_menu` VALUES (65, 58, '编辑', 'user/detail/edit', 'user:detail:edit', 2, NULL, 2, NULL, NULL, '2019-08-05 15:52:50', '2019-08-05 15:52:50', 0);
INSERT INTO `sys_menu` VALUES (66, 58, '删除', 'user/detail/del', 'user:detail:del', 2, NULL, 3, NULL, NULL, '2019-08-05 15:53:18', '2019-08-05 15:53:18', 0);
INSERT INTO `sys_menu` VALUES (67, 58, '导出', 'user/detail/export', 'user:detail:export', 2, NULL, 4, NULL, NULL, '2019-08-05 15:53:48', '2019-08-05 15:53:48', 0);
INSERT INTO `sys_menu` VALUES (68, 59, '新增', 'user/area/add', 'user:area:add', 2, NULL, 1, NULL, NULL, '2019-08-06 10:06:28', '2019-08-06 10:06:28', 0);
INSERT INTO `sys_menu` VALUES (69, 59, '编辑', 'user/area/edit', 'user:area:edit', 2, NULL, 2, NULL, NULL, '2019-08-06 10:06:59', '2019-08-06 10:06:59', 0);
INSERT INTO `sys_menu` VALUES (70, 59, '删除', 'user/area/del', 'user:area:del', 2, NULL, 3, NULL, NULL, '2019-08-06 10:07:21', '2019-08-06 10:07:21', 0);
INSERT INTO `sys_menu` VALUES (71, 60, '新增', 'user/role/dd', 'user:role:add', 2, NULL, 1, NULL, NULL, '2019-08-06 10:08:25', '2019-08-06 10:08:25', 0);
INSERT INTO `sys_menu` VALUES (72, 60, '编辑', 'user/role/edit', 'user:role:edit', 2, NULL, 2, NULL, NULL, '2019-08-06 10:08:50', '2019-08-06 10:08:50', 0);
INSERT INTO `sys_menu` VALUES (73, 60, '删除', 'user/role/del', 'user:role:del', 2, NULL, 3, NULL, NULL, '2019-08-06 10:09:12', '2019-08-06 10:09:12', 0);
INSERT INTO `sys_menu` VALUES (74, 43, '新增', 'meeting/place/add', 'meeting:place:add', 2, NULL, 1, NULL, NULL, '2019-08-12 13:38:26', '2019-08-12 13:38:26', 0);
INSERT INTO `sys_menu` VALUES (75, 43, '删除', 'meeting/place/del', 'meeting:place:del', 2, NULL, 2, NULL, NULL, '2019-08-12 13:39:04', '2019-08-12 13:39:04', 0);
INSERT INTO `sys_menu` VALUES (76, 44, '上传', 'meeting/question/upload', 'meeting:question:upload', 2, NULL, 1, NULL, NULL, '2019-08-12 14:31:31', '2019-08-12 14:31:31', 0);
INSERT INTO `sys_menu` VALUES (77, 44, '下载', 'meeting/question/download', 'meeting:question:download', 2, NULL, 2, NULL, NULL, '2019-08-12 14:32:00', '2019-08-12 14:32:00', 0);
INSERT INTO `sys_menu` VALUES (78, 44, '删除', 'meeting/question/del', 'meeting:question:del', 2, NULL, 3, NULL, NULL, '2019-08-12 14:32:25', '2019-08-12 14:32:25', 0);
INSERT INTO `sys_menu` VALUES (79, 51, '导出', 'hospital/doctor/export', 'hospital:doctor:export', 2, NULL, 1, NULL, NULL, '2019-09-29 15:21:52', '2019-09-29 15:22:45', 0);
INSERT INTO `sys_menu` VALUES (80, 52, '导出', 'hospital/detail/export', 'hospital:detail:export', 2, NULL, 1, NULL, NULL, '2019-09-29 15:22:23', '2019-09-29 15:22:50', 0);
INSERT INTO `sys_menu` VALUES (81, 50, '区域管理', 'hospital/area/list', 'hospital:area:list', 1, NULL, 43, NULL, NULL, '2019-10-31 06:55:12', '2019-10-31 06:55:12', 0);
INSERT INTO `sys_menu` VALUES (82, 81, '新增', 'hospital/area/add', 'hospital:area:add', 2, NULL, 1, NULL, NULL, '2019-10-31 06:56:13', '2019-10-31 06:56:13', 0);
INSERT INTO `sys_menu` VALUES (83, 81, '编辑', 'hospital/area/edit', 'hospital:area:edit', 2, NULL, 2, NULL, NULL, '2019-10-31 06:56:54', '2019-10-31 06:56:54', 0);
INSERT INTO `sys_menu` VALUES (84, 81, '删除', 'hospital/area/del', 'hospital:area:del', 2, NULL, 3, NULL, NULL, '2019-10-31 06:57:22', '2019-10-31 06:57:22', 0);
INSERT INTO `sys_menu` VALUES (85, 52, '新增', 'hospital/detail/add', 'hospital:detail:add', 2, NULL, 2, NULL, NULL, '2019-10-31 07:47:50', '2019-10-31 07:47:50', 0);
INSERT INTO `sys_menu` VALUES (86, 52, '编辑', 'hospital/detail/edit', 'hospital:detail:edit', 2, NULL, 3, NULL, NULL, '2019-10-31 07:48:23', '2019-10-31 07:48:23', 0);
INSERT INTO `sys_menu` VALUES (87, 52, '删除', 'hospital/detail/del', 'hospital:detail:del', 2, NULL, 4, NULL, NULL, '2019-10-31 07:49:44', '2019-10-31 07:49:44', 0);
INSERT INTO `sys_menu` VALUES (88, 51, '新增', 'hospital/doctor/add', 'hospital:doctor:add', 2, NULL, 2, NULL, NULL, '2019-10-31 07:54:46', '2019-10-31 07:54:46', 0);
INSERT INTO `sys_menu` VALUES (89, 51, '编辑', 'hospital/doctor/edit', 'hospital:doctor:edit', 2, NULL, 3, NULL, NULL, '2019-10-31 07:55:17', '2019-10-31 07:55:17', 0);
INSERT INTO `sys_menu` VALUES (90, 51, '删除', 'hospital/doctor/del', 'hospital:doctor:del', 2, NULL, 4, NULL, NULL, '2019-10-31 07:55:59', '2019-10-31 07:55:59', 0);

-- ----------------------------
-- Table structure for sys_operation_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_operation_log`;
CREATE TABLE `sys_operation_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `log_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '日志类型',
  `log_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '日志名称',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户ID',
  `class_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '类名称',
  `method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '方法名称',
  `succeed` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否成功',
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '备注',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `execute_time` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '执行时间(毫秒)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1150601874915967778 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '操作日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_operation_log
-- ----------------------------
INSERT INTO `sys_operation_log` VALUES (1150601874915967635, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":40,\"parentId\":0,\"areaName\":\"英国\",\"level\":0,\"levelName\":\"无级\",\"createTime\":\"Aug 15, 2019 10:05:57 AM\",\"updateTime\":\"Aug 15, 2019 10:05:57 AM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-15 10:05:57', '2019-08-15 10:05:57', '56');
INSERT INTO `sys_operation_log` VALUES (1150601874915967636, '操作日志', '区域删除', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'del', '成功', '[40]', '2019-08-15 14:01:04', '2019-08-15 14:01:04', '38');
INSERT INTO `sys_operation_log` VALUES (1150601874915967637, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":41,\"parentId\":39,\"areaName\":\"大兴区\",\"level\":3,\"levelName\":\"三级\",\"optionAreas\":\"全国/北京\",\"createTime\":\"Aug 16, 2019 9:01:30 AM\",\"updateTime\":\"Aug 16, 2019 9:01:30 AM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-16 09:01:31', '2019-08-16 09:01:31', '35');
INSERT INTO `sys_operation_log` VALUES (1150601874915967638, '操作日志', '区域删除', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'del', '成功', '[39]', '2019-08-16 09:21:46', '2019-08-16 09:21:46', '155');
INSERT INTO `sys_operation_log` VALUES (1150601874915967639, '操作日志', '区域删除', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'del', '成功', '[39]', '2019-08-16 09:44:41', '2019-08-16 09:44:41', '25973');
INSERT INTO `sys_operation_log` VALUES (1150601874915967640, '操作日志', '区域删除', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'del', '成功', '[39]', '2019-08-16 10:06:28', '2019-08-16 10:06:28', '64');
INSERT INTO `sys_operation_log` VALUES (1150601874915967641, '操作日志', '区域删除', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'del', '成功', '[39]', '2019-08-16 10:09:40', '2019-08-16 10:09:40', '125');
INSERT INTO `sys_operation_log` VALUES (1150601874915967642, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":42,\"parentId\":38,\"areaName\":\"华盛顿\",\"level\":2,\"levelName\":\"二级\",\"optionAreas\":\"美国\",\"createTime\":\"Aug 16, 2019 10:25:45 AM\",\"updateTime\":\"Aug 16, 2019 10:25:45 AM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-16 10:25:46', '2019-08-16 10:25:46', '55');
INSERT INTO `sys_operation_log` VALUES (1150601874915967643, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":41,\"parentId\":42,\"areaName\":\"大兴区\",\"level\":3,\"levelName\":\"三级\",\"optionAreas\":\"美国/华盛顿\",\"createTime\":\"Aug 16, 2019 9:01:30 AM\",\"updateTime\":\"Aug 16, 2019 10:32:54 AM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-16 10:32:54', '2019-08-16 10:32:54', '90');
INSERT INTO `sys_operation_log` VALUES (1150601874915967644, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":43,\"parentId\":33,\"areaName\":\"北京\",\"level\":2,\"levelName\":\"二级\",\"optionAreas\":\"全国\",\"createTime\":\"Aug 16, 2019 10:33:11 AM\",\"updateTime\":\"Aug 16, 2019 10:33:11 AM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-16 10:33:12', '2019-08-16 10:33:12', '19');
INSERT INTO `sys_operation_log` VALUES (1150601874915967645, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":41,\"parentId\":43,\"areaName\":\"大兴区\",\"level\":3,\"levelName\":\"三级\",\"optionAreas\":\"全国/北京\",\"createTime\":\"Aug 16, 2019 9:01:30 AM\",\"updateTime\":\"Aug 16, 2019 10:33:19 AM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-16 10:33:19', '2019-08-16 10:33:19', '23');
INSERT INTO `sys_operation_log` VALUES (1150601874915967646, '操作日志', '区域删除', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'del', '成功', '[43]', '2019-08-16 10:37:57', '2019-08-16 10:37:57', '83');
INSERT INTO `sys_operation_log` VALUES (1150601874915967647, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":44,\"parentId\":33,\"areaName\":\"北京\",\"level\":2,\"levelName\":\"二级\",\"optionAreas\":\"全国\",\"createTime\":\"Aug 16, 2019 2:55:52 PM\",\"updateTime\":\"Aug 16, 2019 2:55:52 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-16 14:55:52', '2019-08-16 14:55:52', '50');
INSERT INTO `sys_operation_log` VALUES (1150601874915967648, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":41,\"parentId\":44,\"areaName\":\"大兴区\",\"level\":3,\"levelName\":\"三级\",\"optionAreas\":\"全国/北京\",\"createTime\":\"Aug 16, 2019 9:01:30 AM\",\"updateTime\":\"Aug 16, 2019 3:03:36 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-16 15:03:37', '2019-08-16 15:03:37', '70');
INSERT INTO `sys_operation_log` VALUES (1150601874915967649, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":45,\"parentId\":41,\"areaName\":\"兴涛社区\",\"level\":4,\"levelName\":\"四级\",\"optionAreas\":\"全国/北京/大兴区\",\"createTime\":\"Aug 16, 2019 3:03:54 PM\",\"updateTime\":\"Aug 16, 2019 3:03:54 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-16 15:03:54', '2019-08-16 15:03:54', '40');
INSERT INTO `sys_operation_log` VALUES (1150601874915967650, '操作日志', '区域删除', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'del', '成功', '[44]', '2019-08-16 15:04:22', '2019-08-16 15:04:22', '65');
INSERT INTO `sys_operation_log` VALUES (1150601874915967651, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":46,\"parentId\":33,\"areaName\":\"北京\",\"level\":2,\"levelName\":\"二级\",\"optionAreas\":\"全国\",\"createTime\":\"Aug 16, 2019 3:27:33 PM\",\"updateTime\":\"Aug 16, 2019 3:27:33 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-16 15:27:34', '2019-08-16 15:27:34', '29');
INSERT INTO `sys_operation_log` VALUES (1150601874915967652, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":41,\"parentId\":46,\"areaName\":\"大兴区\",\"level\":3,\"levelName\":\"三级\",\"optionAreas\":\"全国/北京\",\"createTime\":\"Aug 16, 2019 9:01:30 AM\",\"updateTime\":\"Aug 16, 2019 3:27:44 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-16 15:27:45', '2019-08-16 15:27:45', '42');
INSERT INTO `sys_operation_log` VALUES (1150601874915967653, '操作日志', '区域删除', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'del', '成功', '[46]', '2019-08-16 15:27:55', '2019-08-16 15:27:55', '59');
INSERT INTO `sys_operation_log` VALUES (1150601874915967654, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"areaName\":\"北京\",\"level\":2,\"levelName\":\"二级\",\"currentPage\":0,\"pageSize\":10}', '2019-08-16 15:29:07', '2019-08-16 15:29:07', '0');
INSERT INTO `sys_operation_log` VALUES (1150601874915967655, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":47,\"parentId\":33,\"areaName\":\"北京\",\"level\":2,\"levelName\":\"二级\",\"optionAreas\":\"全国\",\"createTime\":\"Aug 16, 2019 3:29:11 PM\",\"updateTime\":\"Aug 16, 2019 3:29:11 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-16 15:29:11', '2019-08-16 15:29:11', '15');
INSERT INTO `sys_operation_log` VALUES (1150601874915967656, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":41,\"parentId\":47,\"areaName\":\"大兴区\",\"level\":3,\"levelName\":\"三级\",\"optionAreas\":\"全国/北京\",\"createTime\":\"Aug 16, 2019 9:01:30 AM\",\"updateTime\":\"Aug 16, 2019 3:29:25 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-16 15:29:25', '2019-08-16 15:29:25', '15');
INSERT INTO `sys_operation_log` VALUES (1150601874915967657, '操作日志', '区域删除', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'del', '成功', '[47]', '2019-08-16 15:30:36', '2019-08-16 15:30:36', '17205');
INSERT INTO `sys_operation_log` VALUES (1150601874915967658, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":48,\"parentId\":33,\"areaName\":\"北京\",\"level\":2,\"levelName\":\"二级\",\"optionAreas\":\"全国\",\"createTime\":\"Aug 16, 2019 3:31:00 PM\",\"updateTime\":\"Aug 16, 2019 3:31:00 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-16 15:31:01', '2019-08-16 15:31:01', '22');
INSERT INTO `sys_operation_log` VALUES (1150601874915967659, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":41,\"parentId\":48,\"areaName\":\"大兴区\",\"level\":3,\"levelName\":\"三级\",\"optionAreas\":\"全国/北京\",\"createTime\":\"Aug 16, 2019 9:01:30 AM\",\"updateTime\":\"Aug 16, 2019 3:31:04 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-16 15:31:05', '2019-08-16 15:31:05', '22');
INSERT INTO `sys_operation_log` VALUES (1150601874915967660, '操作日志', '区域删除', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'del', '成功', '[48]', '2019-08-16 15:32:11', '2019-08-16 15:32:11', '77');
INSERT INTO `sys_operation_log` VALUES (1150601874915967661, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":49,\"parentId\":33,\"areaName\":\"北京\",\"level\":2,\"levelName\":\"二级\",\"optionAreas\":\"全国\",\"optionStatus\":1,\"createTime\":\"Aug 16, 2019 4:01:11 PM\",\"updateTime\":\"Aug 16, 2019 4:01:11 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-16 16:01:12', '2019-08-16 16:01:12', '127');
INSERT INTO `sys_operation_log` VALUES (1150601874915967662, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":41,\"parentId\":49,\"areaName\":\"大兴区\",\"level\":3,\"levelName\":\"三级\",\"optionAreas\":\"全国/北京\",\"optionStatus\":1,\"createTime\":\"Aug 16, 2019 9:01:30 AM\",\"updateTime\":\"Aug 16, 2019 4:02:28 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-16 16:02:28', '2019-08-16 16:02:28', '54');
INSERT INTO `sys_operation_log` VALUES (1150601874915967663, '操作日志', '区域删除', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'del', '成功', '[49]', '2019-08-16 16:03:17', '2019-08-16 16:03:17', '100');
INSERT INTO `sys_operation_log` VALUES (1150601874915967664, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":50,\"parentId\":33,\"areaName\":\"qweqwe\",\"level\":2,\"levelName\":\"二级\",\"optionAreas\":\"全国\",\"optionStatus\":1,\"createTime\":\"Aug 16, 2019 4:04:29 PM\",\"updateTime\":\"Aug 16, 2019 4:04:29 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-16 16:04:29', '2019-08-16 16:04:29', '29');
INSERT INTO `sys_operation_log` VALUES (1150601874915967665, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":41,\"parentId\":50,\"areaName\":\"大兴区\",\"level\":3,\"levelName\":\"三级\",\"optionAreas\":\"全国/qweqwe\",\"optionStatus\":1,\"createTime\":\"Aug 16, 2019 9:01:30 AM\",\"updateTime\":\"Aug 16, 2019 4:05:21 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-16 16:05:22', '2019-08-16 16:05:22', '36481');
INSERT INTO `sys_operation_log` VALUES (1150601874915967666, '操作日志', '区域删除', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'del', '成功', '[50]', '2019-08-16 16:05:37', '2019-08-16 16:05:37', '47');
INSERT INTO `sys_operation_log` VALUES (1150601874915967667, '异常日志', '', 1, NULL, NULL, '失败', NULL, '2019-08-16 16:19:13', '2019-08-16 16:19:13', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967668, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":51,\"parentId\":33,\"areaName\":\"北京\",\"level\":2,\"levelName\":\"二级\",\"optionAreas\":\"全国\",\"optionStatus\":1,\"createTime\":\"Aug 16, 2019 4:21:34 PM\",\"updateTime\":\"Aug 16, 2019 4:21:34 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-16 16:21:34', '2019-08-16 16:21:34', '58');
INSERT INTO `sys_operation_log` VALUES (1150601874915967669, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":41,\"parentId\":51,\"areaName\":\"大兴区\",\"level\":3,\"levelName\":\"三级\",\"optionAreas\":\"全国/北京\",\"optionStatus\":1,\"createTime\":\"Aug 16, 2019 9:01:30 AM\",\"updateTime\":\"Aug 16, 2019 4:21:49 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-16 16:21:50', '2019-08-16 16:21:50', '61');
INSERT INTO `sys_operation_log` VALUES (1150601874915967670, '操作日志', '用户新增', 1, 'com.ksh.beam.system.controller.user.UserDetailController', 'add', '成功', '{\"id\":1,\"jobCode\":\"20190805\",\"avatar\":\"https://mwy-1259572200.cos.ap-beijing.myqcloud.com/50099e79-d9b6-4eaf-82fe-f912dad845ba.jpg\",\"nickname\":\"墨子\",\"username\":\"王林\",\"phone\":\"18212341234\",\"areaId\":33,\"roleId\":2,\"status\":1,\"boundTime\":\"Aug 5, 2019 3:02:45 PM\",\"areaName\":\"\",\"roleName\":\"大区经理\",\"createTime\":\"Aug 5, 2019 3:02:49 PM\",\"updateTime\":\"Aug 16, 2019 5:45:00 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-16 17:45:00', '2019-08-16 17:45:00', '81');
INSERT INTO `sys_operation_log` VALUES (1150601874915967671, '操作日志', '区域删除', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'del', '成功', '[51]', '2019-08-16 17:49:59', '2019-08-16 17:49:59', '147');
INSERT INTO `sys_operation_log` VALUES (1150601874915967672, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":52,\"parentId\":33,\"areaName\":\"北京\",\"level\":2,\"levelName\":\"二级\",\"optionAreas\":\"全国\",\"optionStatus\":1,\"createTime\":\"Aug 16, 2019 6:03:45 PM\",\"updateTime\":\"Aug 16, 2019 6:03:45 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-16 18:03:46', '2019-08-16 18:03:46', '151');
INSERT INTO `sys_operation_log` VALUES (1150601874915967673, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":41,\"parentId\":52,\"areaName\":\"大兴区\",\"level\":3,\"levelName\":\"三级\",\"optionAreas\":\"全国/北京\",\"optionStatus\":1,\"createTime\":\"Aug 16, 2019 9:01:30 AM\",\"updateTime\":\"Aug 16, 2019 6:03:52 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-16 18:03:52', '2019-08-16 18:03:52', '63');
INSERT INTO `sys_operation_log` VALUES (1150601874915967674, '操作日志', '区域删除', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'del', '成功', '[52]', '2019-08-16 18:04:13', '2019-08-16 18:04:13', '57');
INSERT INTO `sys_operation_log` VALUES (1150601874915967675, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":53,\"parentId\":33,\"areaName\":\"qweqwe\",\"level\":2,\"levelName\":\"二级\",\"optionAreas\":\"全国\",\"optionStatus\":1,\"createTime\":\"Aug 16, 2019 6:05:12 PM\",\"updateTime\":\"Aug 16, 2019 6:05:12 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-16 18:05:12', '2019-08-16 18:05:12', '28');
INSERT INTO `sys_operation_log` VALUES (1150601874915967676, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":45,\"parentId\":53,\"areaName\":\"兴涛社区\",\"level\":4,\"levelName\":\"四级\",\"optionAreas\":\"全国/qweqwe\",\"optionStatus\":1,\"createTime\":\"Aug 16, 2019 3:03:54 PM\",\"updateTime\":\"Aug 16, 2019 6:03:52 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-16 18:05:18', '2019-08-16 18:05:18', '6');
INSERT INTO `sys_operation_log` VALUES (1150601874915967677, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":41,\"parentId\":53,\"areaName\":\"大兴区\",\"level\":3,\"levelName\":\"三级\",\"optionAreas\":\"全国/qweqwe\",\"optionStatus\":1,\"createTime\":\"Aug 16, 2019 9:01:30 AM\",\"updateTime\":\"Aug 16, 2019 6:05:26 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-16 18:05:26', '2019-08-16 18:05:26', '50');
INSERT INTO `sys_operation_log` VALUES (1150601874915967678, '操作日志', '区域删除', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'del', '成功', '[53]', '2019-08-16 18:05:31', '2019-08-16 18:05:31', '27');
INSERT INTO `sys_operation_log` VALUES (1150601874915967679, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":54,\"parentId\":33,\"areaName\":\"qweqwe\",\"level\":2,\"levelName\":\"二级\",\"optionAreas\":\"全国\",\"optionStatus\":1,\"createTime\":\"Aug 16, 2019 6:05:57 PM\",\"updateTime\":\"Aug 16, 2019 6:05:57 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-16 18:05:57', '2019-08-16 18:05:57', '155');
INSERT INTO `sys_operation_log` VALUES (1150601874915967680, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":41,\"parentId\":54,\"areaName\":\"大兴区\",\"level\":3,\"levelName\":\"三级\",\"optionAreas\":\"全国/qweqwe\",\"optionStatus\":1,\"createTime\":\"Aug 16, 2019 9:01:30 AM\",\"updateTime\":\"Aug 16, 2019 6:06:04 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-16 18:06:04', '2019-08-16 18:06:04', '45');
INSERT INTO `sys_operation_log` VALUES (1150601874915967681, '操作日志', '区域删除', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'del', '成功', '[54]', '2019-08-16 18:07:52', '2019-08-16 18:07:52', '99388');
INSERT INTO `sys_operation_log` VALUES (1150601874915967682, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":55,\"parentId\":33,\"areaName\":\"asdasdasd\",\"level\":2,\"levelName\":\"二级\",\"optionAreas\":\"全国\",\"optionStatus\":1,\"createTime\":\"Aug 16, 2019 6:09:56 PM\",\"updateTime\":\"Aug 16, 2019 6:09:56 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-16 18:09:57', '2019-08-16 18:09:57', '86');
INSERT INTO `sys_operation_log` VALUES (1150601874915967683, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":41,\"parentId\":55,\"areaName\":\"大兴区\",\"level\":3,\"levelName\":\"三级\",\"optionAreas\":\"全国/asdasdasd\",\"optionStatus\":1,\"createTime\":\"Aug 16, 2019 9:01:30 AM\",\"updateTime\":\"Aug 16, 2019 6:10:04 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-16 18:10:04', '2019-08-16 18:10:04', '42');
INSERT INTO `sys_operation_log` VALUES (1150601874915967684, '操作日志', '区域删除', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'del', '成功', '[55]', '2019-08-16 18:13:10', '2019-08-16 18:13:10', '175376');
INSERT INTO `sys_operation_log` VALUES (1150601874915967685, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":56,\"parentId\":33,\"areaName\":\"北京\",\"level\":2,\"levelName\":\"二级\",\"optionAreas\":\"全国\",\"optionStatus\":1,\"createTime\":\"Aug 16, 2019 6:15:33 PM\",\"updateTime\":\"Aug 16, 2019 6:15:33 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-16 18:15:33', '2019-08-16 18:15:33', '46');
INSERT INTO `sys_operation_log` VALUES (1150601874915967686, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":41,\"parentId\":56,\"areaName\":\"大兴区\",\"level\":3,\"levelName\":\"三级\",\"optionAreas\":\"全国/北京\",\"optionStatus\":1,\"createTime\":\"Aug 16, 2019 9:01:30 AM\",\"updateTime\":\"Aug 16, 2019 6:15:47 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-16 18:15:48', '2019-08-16 18:15:48', '75');
INSERT INTO `sys_operation_log` VALUES (1150601874915967687, '操作日志', '区域删除', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'del', '成功', '[56]', '2019-08-16 18:16:16', '2019-08-16 18:16:16', '5894');
INSERT INTO `sys_operation_log` VALUES (1150601874915967688, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":57,\"parentId\":33,\"areaName\":\"asdadasd\",\"level\":2,\"levelName\":\"二级\",\"optionAreas\":\"全国\",\"optionStatus\":1,\"createTime\":\"Aug 16, 2019 6:17:07 PM\",\"updateTime\":\"Aug 16, 2019 6:17:07 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-16 18:17:08', '2019-08-16 18:17:08', '27');
INSERT INTO `sys_operation_log` VALUES (1150601874915967689, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":41,\"parentId\":57,\"areaName\":\"大兴区\",\"level\":3,\"levelName\":\"三级\",\"optionAreas\":\"全国/asdadasd\",\"optionStatus\":1,\"createTime\":\"Aug 16, 2019 9:01:30 AM\",\"updateTime\":\"Aug 16, 2019 6:17:12 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-16 18:17:12', '2019-08-16 18:17:12', '38');
INSERT INTO `sys_operation_log` VALUES (1150601874915967690, '操作日志', '区域删除', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'del', '成功', '[57]', '2019-08-16 18:17:20', '2019-08-16 18:17:20', '96');
INSERT INTO `sys_operation_log` VALUES (1150601874915967691, '操作日志', '区域删除', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'del', '成功', '[33]', '2019-08-16 18:31:04', '2019-08-16 18:31:04', '59');
INSERT INTO `sys_operation_log` VALUES (1150601874915967692, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":58,\"parentId\":0,\"areaName\":\"全国\",\"level\":1,\"levelName\":\"一级\",\"optionStatus\":1,\"createTime\":\"Aug 16, 2019 6:31:30 PM\",\"updateTime\":\"Aug 16, 2019 6:31:30 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-16 18:31:31', '2019-08-16 18:31:31', '147');
INSERT INTO `sys_operation_log` VALUES (1150601874915967693, '操作日志', '区域删除', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'del', '成功', '[58]', '2019-08-16 18:33:12', '2019-08-16 18:33:12', '36703');
INSERT INTO `sys_operation_log` VALUES (1150601874915967694, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":59,\"parentId\":0,\"areaName\":\"全国\",\"level\":1,\"levelName\":\"一级\",\"optionStatus\":1,\"createTime\":\"Aug 16, 2019 6:33:23 PM\",\"updateTime\":\"Aug 16, 2019 6:33:23 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-16 18:33:24', '2019-08-16 18:33:24', '35');
INSERT INTO `sys_operation_log` VALUES (1150601874915967695, '操作日志', '区域删除', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'del', '成功', '[59]', '2019-08-16 18:33:48', '2019-08-16 18:33:48', '15');
INSERT INTO `sys_operation_log` VALUES (1150601874915967696, '操作日志', '角色删除', 1, 'com.ksh.beam.system.controller.user.UserRoleController', 'del', '成功', '[2]', '2019-08-16 18:35:46', '2019-08-16 18:35:46', '10');
INSERT INTO `sys_operation_log` VALUES (1150601874915967697, '异常日志', '', 1, NULL, NULL, '失败', 'Redis command timed out; nested exception is io.lettuce.core.RedisCommandTimeoutException: Command timed out after 6 second(s)', '2019-08-21 13:46:23', '2019-08-21 13:46:23', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967698, '操作日志', '用户新增', 1, 'com.ksh.beam.system.controller.user.UserDetailController', 'add', '成功', '{\"id\":2,\"username\":\"qwe\",\"phone\":\"13412341234\",\"areaId\":42,\"roleId\":2,\"status\":1,\"createTime\":\"Aug 21, 2019 2:40:40 PM\",\"updateTime\":\"Aug 21, 2019 2:40:40 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-21 14:40:41', '2019-08-21 14:40:41', '109');
INSERT INTO `sys_operation_log` VALUES (1150601874915967699, '操作日志', '用户新增', 1, 'com.ksh.beam.system.controller.user.UserDetailController', 'add', '成功', '{\"id\":3,\"username\":\"qweqwe\",\"phone\":\"13412341233\",\"areaId\":42,\"roleId\":1,\"status\":1,\"roleLevel\":1,\"createTime\":\"Aug 21, 2019 5:23:50 PM\",\"updateTime\":\"Aug 21, 2019 5:23:50 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-21 17:23:50', '2019-08-21 17:23:50', '24568');
INSERT INTO `sys_operation_log` VALUES (1150601874915967700, '操作日志', '用户删除', 1, 'com.ksh.beam.system.controller.user.UserDetailController', 'del', '成功', '[3]', '2019-08-21 17:24:05', '2019-08-21 17:24:05', '46');
INSERT INTO `sys_operation_log` VALUES (1150601874915967701, '操作日志', '用户新增', 1, 'com.ksh.beam.system.controller.user.UserDetailController', 'add', '成功', '{\"username\":\"qweqwe\",\"phone\":\"13412341231\",\"areaId\":59,\"roleId\":2,\"status\":1,\"areaLevel\":1,\"roleLevel\":2,\"currentPage\":0,\"pageSize\":10}', '2019-08-21 17:25:53', '2019-08-21 17:25:53', '2');
INSERT INTO `sys_operation_log` VALUES (1150601874915967702, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":60,\"parentId\":59,\"areaName\":\"北京\",\"level\":2,\"levelName\":\"二级\",\"optionAreas\":\"全国\",\"optionStatus\":1,\"createTime\":\"Aug 21, 2019 5:44:27 PM\",\"updateTime\":\"Aug 21, 2019 5:44:27 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-21 17:44:28', '2019-08-21 17:44:28', '33');
INSERT INTO `sys_operation_log` VALUES (1150601874915967703, '操作日志', '区域新增', 1, 'com.ksh.beam.system.controller.user.UserAreaController', 'add', '成功', '{\"id\":61,\"parentId\":60,\"areaName\":\"朝阳区\",\"level\":3,\"levelName\":\"三级\",\"optionAreas\":\"全国/北京\",\"optionStatus\":1,\"createTime\":\"Aug 21, 2019 5:44:46 PM\",\"updateTime\":\"Aug 21, 2019 5:44:46 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-08-21 17:44:46', '2019-08-21 17:44:46', '13');
INSERT INTO `sys_operation_log` VALUES (1150601874915967704, '操作日志', '用户新增', 1, 'com.ksh.beam.system.controller.user.UserDetailController', 'add', '成功', '{\"username\":\"qweqweqe\",\"phone\":\"13412341231\",\"areaId\":61,\"roleId\":2,\"status\":1,\"areaLevel\":3,\"roleLevel\":2,\"currentPage\":0,\"pageSize\":10}', '2019-08-21 17:47:36', '2019-08-21 17:47:36', '7');
INSERT INTO `sys_operation_log` VALUES (1150601874915967705, '操作日志', '用户列表导出', 1, 'com.ksh.beam.system.controller.user.UserDetailController', 'export', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-08-22 10:22:27', '2019-08-22 10:22:27', '719');
INSERT INTO `sys_operation_log` VALUES (1150601874915967706, '操作日志', '场所新增', 1, 'com.ksh.beam.system.controller.meeting.MeetingPlaceController', 'add', '成功', '{\"id\":2,\"typeId\":1,\"place\":\"北京北海海下\",\"createTime\":\"Sep 25, 2019 10:11:29 AM\",\"updateTime\":\"Sep 25, 2019 10:11:29 AM\",\"currentPage\":0,\"pageSize\":10}', '2019-09-25 10:11:29', '2019-09-25 10:11:29', '28');
INSERT INTO `sys_operation_log` VALUES (1150601874915967707, '异常日志', '', 1, NULL, NULL, '失败', 'nested exception is org.apache.ibatis.builder.BuilderException: Error evaluating expression \'meeting.hospitalName != null and meeting.hospitalName != \'\'\'. Cause: org.apache.ibatis.ognl.NoSuchPropertyException: com.ksh.beam.system.entity.meeting.Detail.hospitalName', '2019-09-25 10:19:17', '2019-09-25 10:19:17', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967708, '异常日志', '', 1, NULL, NULL, '失败', 'nested exception is org.apache.ibatis.builder.BuilderException: Error evaluating expression \'meeting.startTime != null and meeting.startTime != \'\'\'. Cause: org.apache.ibatis.ognl.NoSuchPropertyException: com.ksh.beam.system.entity.meeting.Detail.startTime', '2019-09-25 14:08:21', '2019-09-25 14:08:21', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967709, '异常日志', '', 1, NULL, NULL, '失败', 'JSON parse error: parse enum com.ksh.beam.system.enums.UserStatusEnum error, value : true; nested exception is com.alibaba.fastjson.JSONException: parse enum com.ksh.beam.system.enums.UserStatusEnum error, value : true', '2019-09-26 14:08:12', '2019-09-26 14:08:12', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967710, '操作日志', '用户新增', 1, 'com.ksh.beam.system.controller.user.UserDetailController', 'add', '成功', '{\"nickname\":\"qweweqe\",\"username\":\"qweqeqweqe\",\"phone\":\"13412314123\",\"areaId\":42,\"roleId\":1,\"status\":\"NORMAL\",\"areaLevel\":2,\"roleLevel\":1,\"currentPage\":0,\"pageSize\":10}', '2019-09-26 14:15:18', '2019-09-26 14:15:18', '13');
INSERT INTO `sys_operation_log` VALUES (1150601874915967711, '操作日志', '用户新增', 1, 'com.ksh.beam.system.controller.user.UserDetailController', 'add', '成功', '{\"id\":4,\"nickname\":\"qweweqe\",\"username\":\"qweqeqweqe\",\"phone\":\"13412314123\",\"areaId\":38,\"roleId\":1,\"status\":\"LOCK\",\"areaLevel\":1,\"roleLevel\":1,\"createTime\":\"Sep 26, 2019 2:15:25 PM\",\"updateTime\":\"Sep 26, 2019 2:15:25 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-09-26 14:15:25', '2019-09-26 14:15:25', '59');
INSERT INTO `sys_operation_log` VALUES (1150601874915967712, '操作日志', '用户新增', 1, 'com.ksh.beam.system.controller.user.UserDetailController', 'add', '成功', '{\"id\":4,\"jobCode\":\"\",\"avatar\":\"\",\"nickname\":\"qweweqe\",\"username\":\"qweqeqweqe\",\"phone\":\"13412314123\",\"areaId\":38,\"roleId\":1,\"status\":\"LOCK\",\"areaName\":\"美国\",\"roleName\":\"管理者\",\"createTime\":\"Sep 26, 2019 2:15:25 PM\",\"updateTime\":\"Sep 26, 2019 2:16:16 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-09-26 14:16:17', '2019-09-26 14:16:17', '50');
INSERT INTO `sys_operation_log` VALUES (1150601874915967713, '操作日志', '用户新增', 1, 'com.ksh.beam.system.controller.user.UserDetailController', 'add', '成功', '{\"id\":4,\"jobCode\":\"\",\"avatar\":\"\",\"nickname\":\"qweweqe\",\"username\":\"qweqeqweqe\",\"phone\":\"13412314123\",\"areaId\":38,\"roleId\":1,\"status\":\"NORMAL\",\"areaName\":\"美国\",\"roleName\":\"管理者\",\"createTime\":\"Sep 26, 2019 2:15:25 PM\",\"updateTime\":\"Sep 26, 2019 2:16:41 PM\",\"currentPage\":0,\"pageSize\":10}', '2019-09-26 14:16:42', '2019-09-26 14:16:42', '17');
INSERT INTO `sys_operation_log` VALUES (1150601874915967714, '异常日志', '', 1, NULL, NULL, '失败', 'com.baomidou.mybatisplus.extension.plugins.pagination.Page cannot be cast to java.util.List', '2019-09-26 15:15:33', '2019-09-26 15:15:33', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967715, '操作日志', '用户列表导出', 1, 'com.ksh.beam.system.controller.user.UserDetailController', 'export', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-09-26 15:21:21', '2019-09-26 15:21:21', '90643');
INSERT INTO `sys_operation_log` VALUES (1150601874915967716, '异常日志', '', 1, NULL, NULL, '失败', 'com.ksh.beam.system.entity.user.Detail cannot be cast to java.util.Map', '2019-09-26 15:35:46', '2019-09-26 15:35:46', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967717, '异常日志', '', 1, NULL, NULL, '失败', 'com.ksh.beam.system.entity.user.Detail cannot be cast to java.util.Map', '2019-09-26 15:37:41', '2019-09-26 15:37:41', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967718, '异常日志', '', 1, NULL, NULL, '失败', 'com.ksh.beam.system.entity.user.Detail cannot be cast to java.util.Map', '2019-09-26 15:38:37', '2019-09-26 15:38:37', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967719, '异常日志', '', 1, NULL, NULL, '失败', 'com.ksh.beam.system.entity.user.Detail cannot be cast to java.util.Map', '2019-09-26 15:38:50', '2019-09-26 15:38:50', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967720, '异常日志', '', 1, NULL, NULL, '失败', 'com.ksh.beam.system.entity.user.Detail cannot be cast to java.util.Map', '2019-09-26 15:38:57', '2019-09-26 15:38:57', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967721, '异常日志', '', 1, NULL, NULL, '失败', 'com.ksh.beam.system.entity.user.Detail cannot be cast to java.util.Map', '2019-09-26 15:41:31', '2019-09-26 15:41:31', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967722, '操作日志', '用户列表导出', 1, 'com.ksh.beam.system.controller.user.UserDetailController', 'export', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-09-26 15:44:53', '2019-09-26 15:44:53', '13270');
INSERT INTO `sys_operation_log` VALUES (1150601874915967723, '异常日志', '', 1, NULL, NULL, '失败', 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error querying database.  Cause: com.baomidou.mybatisplus.core.exceptions.MybatisPlusException: Error: Method queryTotal execution error.\r\n### The error may exist in file [D:\\Development\\Workspaces\\beam\\beam-admin\\target\\classes\\com\\ksh\\beam\\system\\dao\\mapping\\MeetingDetailMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### Cause: com.baomidou.mybatisplus.core.exceptions.MybatisPlusException: Error: Method queryTotal execution error.', '2019-09-26 17:26:31', '2019-09-26 17:26:31', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967724, '异常日志', '', 1, NULL, NULL, '失败', 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error querying database.  Cause: com.baomidou.mybatisplus.core.exceptions.MybatisPlusException: Error: Method queryTotal execution error.\r\n### The error may exist in file [D:\\Development\\Workspaces\\beam\\beam-admin\\target\\classes\\com\\ksh\\beam\\system\\dao\\mapping\\MeetingDetailMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### Cause: com.baomidou.mybatisplus.core.exceptions.MybatisPlusException: Error: Method queryTotal execution error.', '2019-09-26 17:34:22', '2019-09-26 17:34:22', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967725, '异常日志', '', 1, NULL, NULL, '失败', 'nested exception is org.apache.ibatis.builder.BuilderException: Error evaluating expression \'meeting.flag != null and meeting.flag != \'\'\'. Cause: org.apache.ibatis.ognl.NoSuchPropertyException: com.ksh.beam.system.entity.meeting.Detail.flag', '2019-09-27 14:06:27', '2019-09-27 14:06:27', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967726, '异常日志', '', 1, NULL, NULL, '失败', 'nested exception is org.apache.ibatis.builder.BuilderException: Error evaluating expression \'meeting.flag != null and meeting.flag != \'\'\'. Cause: org.apache.ibatis.ognl.NoSuchPropertyException: com.ksh.beam.system.entity.meeting.Detail.flag', '2019-09-27 14:11:55', '2019-09-27 14:11:55', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967727, '异常日志', '', 1, NULL, NULL, '失败', 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error querying database.  Cause: com.baomidou.mybatisplus.core.exceptions.MybatisPlusException: Error: Method queryTotal execution error.\r\n### The error may exist in file [D:\\Development\\Workspaces\\beam\\beam-admin\\target\\classes\\com\\ksh\\beam\\system\\dao\\mapping\\MeetingDetailMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### Cause: com.baomidou.mybatisplus.core.exceptions.MybatisPlusException: Error: Method queryTotal execution error.', '2019-09-27 14:13:16', '2019-09-27 14:13:16', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967728, '异常日志', '', 1, NULL, NULL, '失败', NULL, '2019-09-27 14:15:43', '2019-09-27 14:15:43', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967729, '异常日志', '', 1, NULL, NULL, '失败', NULL, '2019-09-27 14:16:20', '2019-09-27 14:16:20', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967730, '异常日志', '', 1, NULL, NULL, '失败', NULL, '2019-09-27 14:19:32', '2019-09-27 14:19:32', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967731, '异常日志', '', 1, NULL, NULL, '失败', NULL, '2019-09-27 14:20:31', '2019-09-27 14:20:31', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967732, '异常日志', '', 1, NULL, NULL, '失败', NULL, '2019-09-27 14:26:50', '2019-09-27 14:26:50', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967733, '异常日志', '', 1, NULL, NULL, '失败', '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'real_name\' in \'field list\'\r\n### The error may exist in com/ksh/beam/system/dao/mapping/MeetingSceneMapper.java (best guess)\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: SELECT  id,meeting_id AS meetingId,file_type AS fileType,upload_time AS uploadTime,uploader_id AS uploaderId,file_path AS filePath,file_name AS fileName,real_name AS realName  FROM meeting_scene  WHERE  meeting_id = ? AND file_type = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'real_name\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'real_name\' in \'field list\'', '2019-09-27 14:32:03', '2019-09-27 14:32:03', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967734, '异常日志', '', 1, NULL, NULL, '失败', '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'real_name\' in \'field list\'\r\n### The error may exist in com/ksh/beam/system/dao/mapping/MeetingSceneMapper.java (best guess)\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: SELECT  id,meeting_id AS meetingId,file_type AS fileType,upload_time AS uploadTime,uploader_id AS uploaderId,file_path AS filePath,file_name AS fileName,real_name AS realName  FROM meeting_scene  WHERE  meeting_id = ? AND file_type = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'real_name\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'real_name\' in \'field list\'', '2019-09-27 14:33:25', '2019-09-27 14:33:25', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967735, '异常日志', '', 1, NULL, NULL, '失败', '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'real_name\' in \'field list\'\r\n### The error may exist in com/ksh/beam/system/dao/mapping/MeetingSceneMapper.java (best guess)\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: SELECT  id,meeting_id AS meetingId,file_type AS fileType,upload_time AS uploadTime,uploader_id AS uploaderId,file_path AS filePath,file_name AS fileName,real_name AS realName  FROM meeting_scene  WHERE  meeting_id = ? AND file_type = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'real_name\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'real_name\' in \'field list\'', '2019-09-27 14:36:53', '2019-09-27 14:36:53', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967736, '异常日志', '', 1, NULL, NULL, '失败', 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error querying database.  Cause: com.baomidou.mybatisplus.core.exceptions.MybatisPlusException: Error: Method queryTotal execution error.\r\n### The error may exist in file [D:\\Development\\Workspaces\\beam\\beam-admin\\target\\classes\\com\\ksh\\beam\\system\\dao\\mapping\\MeetingDetailMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### Cause: com.baomidou.mybatisplus.core.exceptions.MybatisPlusException: Error: Method queryTotal execution error.', '2019-09-27 16:32:05', '2019-09-27 16:32:05', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967737, '异常日志', '', 1, NULL, NULL, '失败', 'nested exception is org.apache.ibatis.builder.BuilderException: Error evaluating expression \'meeting.status != null and meeting.status != \'\'\'. Cause: org.apache.ibatis.ognl.NoSuchPropertyException: com.ksh.beam.system.entity.meeting.Detail.status', '2019-09-27 16:35:17', '2019-09-27 16:35:17', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967738, '异常日志', '', 1, NULL, NULL, '失败', 'Required request body is missing: public com.ksh.beam.common.utils.R com.ksh.beam.system.controller.meeting.MeetingDetailController.info(java.lang.Long)', '2019-09-27 16:37:03', '2019-09-27 16:37:03', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967739, '异常日志', '', 1, NULL, NULL, '失败', 'Required request body is missing: public com.ksh.beam.common.utils.R com.ksh.beam.system.controller.meeting.MeetingDetailController.info(java.lang.Long)', '2019-09-27 16:39:38', '2019-09-27 16:39:38', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967740, '异常日志', '', 1, NULL, NULL, '失败', NULL, '2019-09-27 17:28:15', '2019-09-27 17:28:15', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967741, '异常日志', '', 1, NULL, NULL, '失败', NULL, '2019-09-27 17:28:21', '2019-09-27 17:28:21', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967742, '异常日志', '', 1, NULL, NULL, '失败', NULL, '2019-09-27 17:28:30', '2019-09-27 17:28:30', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967743, '操作日志', '会议数据导出', 1, 'com.ksh.beam.system.controller.meeting.MeetingDetailController', 'export', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-09-27 17:30:32', '2019-09-27 17:30:32', '6356');
INSERT INTO `sys_operation_log` VALUES (1150601874915967744, '异常日志', '', 1, NULL, NULL, '失败', 'com.ksh.beam.system.entity.meeting.Detail cannot be cast to java.util.Map', '2019-09-27 17:39:13', '2019-09-27 17:39:13', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967745, '操作日志', '会议数据导出', 1, 'com.ksh.beam.system.controller.meeting.MeetingDetailController', 'export', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-09-27 17:47:32', '2019-09-27 17:47:32', '983');
INSERT INTO `sys_operation_log` VALUES (1150601874915967746, '操作日志', '会议数据导出', 1, 'com.ksh.beam.system.controller.meeting.MeetingDetailController', 'export', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-09-27 17:48:58', '2019-09-27 17:48:58', '52');
INSERT INTO `sys_operation_log` VALUES (1150601874915967747, '操作日志', '用户列表导出', 1, 'com.ksh.beam.system.controller.user.UserDetailController', 'export', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-09-29 09:02:13', '2019-09-29 09:02:13', '554');
INSERT INTO `sys_operation_log` VALUES (1150601874915967748, '操作日志', '用户列表导出', 1, 'com.ksh.beam.system.controller.user.UserDetailController', 'export', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-09-29 09:03:12', '2019-09-29 09:03:12', '100');
INSERT INTO `sys_operation_log` VALUES (1150601874915967749, '操作日志', '用户列表导出', 1, 'com.ksh.beam.system.controller.user.UserDetailController', 'export', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-09-29 09:03:49', '2019-09-29 09:03:49', '17583');
INSERT INTO `sys_operation_log` VALUES (1150601874915967750, '操作日志', '用户列表导出', 1, 'com.ksh.beam.system.controller.user.UserDetailController', 'export', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-09-29 09:12:36', '2019-09-29 09:12:36', '71');
INSERT INTO `sys_operation_log` VALUES (1150601874915967751, '操作日志', '用户列表导出', 1, 'com.ksh.beam.system.controller.user.UserDetailController', 'export', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-09-29 09:15:21', '2019-09-29 09:15:21', '37');
INSERT INTO `sys_operation_log` VALUES (1150601874915967752, '操作日志', '用户列表导出', 1, 'com.ksh.beam.system.controller.user.UserDetailController', 'export', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-09-29 09:29:35', '2019-09-29 09:29:35', '52665');
INSERT INTO `sys_operation_log` VALUES (1150601874915967753, '操作日志', '用户列表导出', 1, 'com.ksh.beam.system.controller.user.UserDetailController', 'export', '成功', '{\"roleId\":1,\"currentPage\":1,\"pageSize\":10}', '2019-09-29 09:59:44', '2019-09-29 09:59:44', '43');
INSERT INTO `sys_operation_log` VALUES (1150601874915967754, '操作日志', '用户列表导出', 1, 'com.ksh.beam.system.controller.user.UserDetailController', 'export', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-09-29 10:08:53', '2019-09-29 10:08:53', '117');
INSERT INTO `sys_operation_log` VALUES (1150601874915967755, '操作日志', '用户列表导出', 1, 'com.ksh.beam.system.controller.user.UserDetailController', 'export', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-09-29 10:09:33', '2019-09-29 10:09:33', '297');
INSERT INTO `sys_operation_log` VALUES (1150601874915967756, '操作日志', '用户列表导出', 1, 'com.ksh.beam.system.controller.user.UserDetailController', 'export', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-09-29 10:11:34', '2019-09-29 10:11:34', '53');
INSERT INTO `sys_operation_log` VALUES (1150601874915967757, '异常日志', '', 1, NULL, NULL, '失败', NULL, '2019-09-29 10:21:01', '2019-09-29 10:21:01', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967758, '操作日志', '用户列表导出', 1, 'com.ksh.beam.system.controller.user.UserDetailController', 'export', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-09-29 10:43:59', '2019-09-29 10:43:59', '639');
INSERT INTO `sys_operation_log` VALUES (1150601874915967759, '操作日志', '用户列表导出', 1, 'com.ksh.beam.system.controller.user.UserDetailController', 'export', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-09-29 10:44:59', '2019-09-29 10:44:59', '670');
INSERT INTO `sys_operation_log` VALUES (1150601874915967760, '操作日志', '用户列表导出', 1, 'com.ksh.beam.system.controller.user.UserDetailController', 'export', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-09-29 10:45:44', '2019-09-29 10:45:44', '82');
INSERT INTO `sys_operation_log` VALUES (1150601874915967761, '操作日志', '医生列表导出', 1, 'com.ksh.beam.system.controller.hospital.HospitalDoctorController', 'export', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-09-29 15:23:28', '2019-09-29 15:23:28', '577');
INSERT INTO `sys_operation_log` VALUES (1150601874915967762, '操作日志', '医院列表导出', 1, 'com.ksh.beam.system.controller.hospital.HospitalDetailController', 'export', '成功', '{\"currentPage\":1,\"pageSize\":10}', '2019-09-29 15:23:39', '2019-09-29 15:23:39', '32');
INSERT INTO `sys_operation_log` VALUES (1150601874915967763, '操作日志', '课件上传', 1, 'com.ksh.beam.system.controller.meeting.MeetingCourseController', 'upload', '成功', '{\"part\":{\"fileItem\":{\"fieldName\":\"file\",\"contentType\":\"image/jpeg\",\"isFormField\":false,\"fileName\":\"w (1).jpg\",\"size\":-1,\"sizeThreshold\":0,\"repository\":{\"path\":\"C:\\\\Users\\\\Dell\\\\AppData\\\\Local\\\\Temp\\\\tomcat.3827726034793911010.8080\\\\work\\\\Tomcat\\\\localhost\\\\beam_admin\"},\"headers\":{\"headerNameToValueListMap\":{\"content-disposition\":[\"form-data; name\\u003d\\\"file\\\"; filename\\u003d\\\"w (1).jpg\\\"\"],\"content-type\":[\"image/jpeg\"]}},\"defaultCharset\":\"ISO-8859-1\"},\"location\":{\"path\":\"C:\\\\Users\\\\Dell\\\\AppData\\\\Local\\\\Temp\\\\tomcat.3827726034793911010.8080\\\\work\\\\Tomcat\\\\localhost\\\\beam_admin\"}},\"filename\":\"w (1).jpg\"}', '2019-10-31 09:59:45', '2019-10-31 09:59:45', '3623');
INSERT INTO `sys_operation_log` VALUES (1150601874915967764, '操作日志', '课件下载', 1, 'com.ksh.beam.system.controller.meeting.MeetingCourseController', 'download', '成功', '90', '2019-10-31 10:01:49', '2019-10-31 10:01:49', '1671');
INSERT INTO `sys_operation_log` VALUES (1150601874915967765, '异常日志', '', 1, NULL, NULL, '失败', 'nested exception is org.apache.ibatis.builder.BuilderException: Error evaluating expression \'meeting.status != null and meeting.status != \'\'\'. Cause: org.apache.ibatis.ognl.NoSuchPropertyException: com.ksh.beam.system.entity.meeting.Detail.status', '2019-11-20 01:45:51', '2019-11-20 01:45:51', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967766, '异常日志', '', 1, NULL, NULL, '失败', 'nested exception is org.apache.ibatis.builder.BuilderException: Error evaluating expression \'meeting.status != null and meeting.status != \'\'\'. Cause: org.apache.ibatis.ognl.NoSuchPropertyException: com.ksh.beam.system.entity.meeting.Detail.status', '2019-11-20 01:57:05', '2019-11-20 01:57:05', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967767, '异常日志', '', 1, NULL, NULL, '失败', 'nested exception is org.apache.ibatis.builder.BuilderException: Error evaluating expression \'meeting.status != null and meeting.status != \'\'\'. Cause: org.apache.ibatis.ognl.NoSuchPropertyException: com.ksh.beam.system.entity.meeting.Detail.status', '2019-11-20 01:57:05', '2019-11-20 01:57:05', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967768, '异常日志', '', 1, NULL, NULL, '失败', 'nested exception is org.apache.ibatis.builder.BuilderException: Error evaluating expression \'meeting.status != null and meeting.status != \'\'\'. Cause: org.apache.ibatis.ognl.NoSuchPropertyException: com.ksh.beam.system.entity.meeting.Detail.status', '2019-11-20 01:57:06', '2019-11-20 01:57:06', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967769, '异常日志', '', 1, NULL, NULL, '失败', 'nested exception is org.apache.ibatis.builder.BuilderException: Error evaluating expression \'meeting.status != null and meeting.status != \'\'\'. Cause: org.apache.ibatis.ognl.NoSuchPropertyException: com.ksh.beam.system.entity.meeting.Detail.status', '2019-11-20 01:57:08', '2019-11-20 01:57:08', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967770, '异常日志', '', 1, NULL, NULL, '失败', 'nested exception is org.apache.ibatis.builder.BuilderException: Error evaluating expression \'meeting.status != null and meeting.status != \'\'\'. Cause: org.apache.ibatis.ognl.NoSuchPropertyException: com.ksh.beam.system.entity.meeting.Detail.status', '2019-11-20 01:59:34', '2019-11-20 01:59:34', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967771, '异常日志', '', 1, NULL, NULL, '失败', 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error querying database.  Cause: com.baomidou.mybatisplus.core.exceptions.MybatisPlusException: Error: Method queryTotal execution error.\r\n### The error may exist in file [D:\\Development\\Workspaces\\beam\\beam-admin\\target\\classes\\com\\ksh\\beam\\system\\dao\\mapping\\MeetingDetailMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### Cause: com.baomidou.mybatisplus.core.exceptions.MybatisPlusException: Error: Method queryTotal execution error.', '2019-11-20 02:10:06', '2019-11-20 02:10:06', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967772, '异常日志', '', 1, NULL, NULL, '失败', 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error querying database.  Cause: com.baomidou.mybatisplus.core.exceptions.MybatisPlusException: Error: Method queryTotal execution error.\r\n### The error may exist in file [D:\\Development\\Workspaces\\beam\\beam-admin\\target\\classes\\com\\ksh\\beam\\system\\dao\\mapping\\MeetingDetailMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### Cause: com.baomidou.mybatisplus.core.exceptions.MybatisPlusException: Error: Method queryTotal execution error.', '2019-11-20 02:11:18', '2019-11-20 02:11:18', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967773, '异常日志', '', 1, NULL, NULL, '失败', 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error querying database.  Cause: com.baomidou.mybatisplus.core.exceptions.MybatisPlusException: Error: Method queryTotal execution error.\r\n### The error may exist in file [D:\\Development\\Workspaces\\beam\\beam-admin\\target\\classes\\com\\ksh\\beam\\system\\dao\\mapping\\MeetingDetailMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### Cause: com.baomidou.mybatisplus.core.exceptions.MybatisPlusException: Error: Method queryTotal execution error.', '2019-11-20 02:13:42', '2019-11-20 02:13:42', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967774, '异常日志', '', 1, NULL, NULL, '失败', 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error querying database.  Cause: com.baomidou.mybatisplus.core.exceptions.MybatisPlusException: Error: Method queryTotal execution error.\r\n### The error may exist in file [D:\\Development\\Workspaces\\beam\\beam-admin\\target\\classes\\com\\ksh\\beam\\system\\dao\\mapping\\MeetingDetailMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### Cause: com.baomidou.mybatisplus.core.exceptions.MybatisPlusException: Error: Method queryTotal execution error.', '2019-11-20 10:30:16', '2019-11-20 10:30:16', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967775, '异常日志', '', 1, NULL, NULL, '失败', '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'file_type\' in \'where clause\'\r\n### The error may exist in com/ksh/beam/system/dao/MeetingSceneMapper.java (best guess)\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: SELECT  id,meeting_id AS meetingId,meeting_code AS meetingCode,type,upload_time AS uploadTime,user_id AS userId,url,name  FROM meeting_cloud  WHERE  meeting_id = ? AND file_type = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'file_type\' in \'where clause\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'file_type\' in \'where clause\'', '2019-11-20 10:36:10', '2019-11-20 10:36:10', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967776, '异常日志', '', 1, NULL, NULL, '失败', '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'file_type\' in \'where clause\'\r\n### The error may exist in com/ksh/beam/system/dao/MeetingSceneMapper.java (best guess)\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: SELECT  id,meeting_id AS meetingId,meeting_code AS meetingCode,type,upload_time AS uploadTime,user_id AS userId,url,name  FROM meeting_cloud  WHERE  meeting_id = ? AND file_type = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'file_type\' in \'where clause\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'file_type\' in \'where clause\'', '2019-11-20 10:36:15', '2019-11-20 10:36:15', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967777, '异常日志', '', 1, NULL, NULL, '失败', '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'hdc.name speakers_name, ud1.username applicant_name, ud1.phone, mc.name topic_na\' at line 3\r\n### The error may exist in file [D:\\Development\\Workspaces\\beam\\beam-admin\\target\\classes\\com\\ksh\\beam\\system\\dao\\mapping\\MeetingDetailMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: select * from         (select md.*,hde.name hospital_name, hde.address hospital_address, hde.code hospital_code, hde.level hospital_level,hde.area_name hospital_area         hdc.name speakers_name, ud1.username applicant_name, ud1.phone, mc.name topic_name,         case md.auditor_channel when \'beam\' then su.name when \'heart\' then ud2.username else \'\' end auditor_name         from meeting_detail md         left join (select * from hospital_detail d left join hospital_area a on d.area_id = a.id) hde on md.hospital_id = hde.id         left join hospital_doctor hdc on md.speakers_id = hdc.id         left join sys_user su on md.auditor_id = su.id         left join user_detail ud1 on md.applicant_id = ud1.id         left join user_detail ud2 on md.auditor_id = ud2.id         left join meeting_course mc on md.topic_id = mc.id         ) m         where m.del_flag = 1 and m.id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'hdc.name speakers_name, ud1.username applicant_name, ud1.phone, mc.name topic_na\' at line 3\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'hdc.name speakers_name, ud1.username applicant_name, ud1.phone, mc.name topic_na\' at line 3', '2019-11-20 11:01:53', '2019-11-20 11:01:53', 'null');
INSERT INTO `sys_operation_log` VALUES (1150601874915967778, '异常日志', '', 1, NULL, NULL, '失败', '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Duplicate column name \'id\'\r\n### The error may exist in file [D:\\Development\\Workspaces\\beam\\beam-admin\\target\\classes\\com\\ksh\\beam\\system\\dao\\mapping\\MeetingDetailMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: select * from         (select md.*,hde.name hospital_name, hde.address hospital_address, hde.code hospital_code, hde.level hospital_level,hde.area_name hospital_area,         hdc.name speakers_name, ud1.username applicant_name, ud1.phone, mc.name topic_name,         case md.auditor_channel when \'beam\' then su.name when \'heart\' then ud2.username else \'\' end auditor_name         from meeting_detail md         left join (select * from hospital_detail d left join hospital_area a on d.area_id = a.id) hde on md.hospital_id = hde.id         left join hospital_doctor hdc on md.speakers_id = hdc.id         left join sys_user su on md.auditor_id = su.id         left join user_detail ud1 on md.applicant_id = ud1.id         left join user_detail ud2 on md.auditor_id = ud2.id         left join meeting_course mc on md.topic_id = mc.id         ) m         where m.del_flag = 1 and m.id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Duplicate column name \'id\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Duplicate column name \'id\'', '2019-11-20 11:04:21', '2019-11-20 11:04:21', 'null');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色名称',
  `remark` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', '超级管理员', '2018-10-10 22:39:38', '2018-12-23 11:45:49');
INSERT INTO `sys_role` VALUES (2, '游客', '游客', '2018-12-23 03:45:15', '2019-04-12 07:12:41');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) NULL DEFAULT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NULL DEFAULT NULL COMMENT '菜单ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2251 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色与菜单对应关系' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2112, 1, 1);
INSERT INTO `sys_role_menu` VALUES (2113, 1, 2);
INSERT INTO `sys_role_menu` VALUES (2114, 1, 3);
INSERT INTO `sys_role_menu` VALUES (2115, 1, 12);
INSERT INTO `sys_role_menu` VALUES (2116, 1, 16);
INSERT INTO `sys_role_menu` VALUES (2117, 1, 13);
INSERT INTO `sys_role_menu` VALUES (2118, 1, 14);
INSERT INTO `sys_role_menu` VALUES (2119, 1, 15);
INSERT INTO `sys_role_menu` VALUES (2120, 1, 17);
INSERT INTO `sys_role_menu` VALUES (2121, 1, 4);
INSERT INTO `sys_role_menu` VALUES (2122, 1, 18);
INSERT INTO `sys_role_menu` VALUES (2123, 1, 21);
INSERT INTO `sys_role_menu` VALUES (2124, 1, 19);
INSERT INTO `sys_role_menu` VALUES (2125, 1, 20);
INSERT INTO `sys_role_menu` VALUES (2126, 1, 5);
INSERT INTO `sys_role_menu` VALUES (2127, 1, 22);
INSERT INTO `sys_role_menu` VALUES (2128, 1, 23);
INSERT INTO `sys_role_menu` VALUES (2129, 1, 24);
INSERT INTO `sys_role_menu` VALUES (2130, 1, 6);
INSERT INTO `sys_role_menu` VALUES (2131, 1, 26);
INSERT INTO `sys_role_menu` VALUES (2132, 1, 27);
INSERT INTO `sys_role_menu` VALUES (2133, 1, 25);
INSERT INTO `sys_role_menu` VALUES (2134, 1, 7);
INSERT INTO `sys_role_menu` VALUES (2135, 1, 29);
INSERT INTO `sys_role_menu` VALUES (2136, 1, 30);
INSERT INTO `sys_role_menu` VALUES (2137, 1, 28);
INSERT INTO `sys_role_menu` VALUES (2138, 1, 31);
INSERT INTO `sys_role_menu` VALUES (2139, 1, 32);
INSERT INTO `sys_role_menu` VALUES (2140, 1, 33);
INSERT INTO `sys_role_menu` VALUES (2141, 1, 10);
INSERT INTO `sys_role_menu` VALUES (2142, 1, 34);
INSERT INTO `sys_role_menu` VALUES (2143, 1, 11);
INSERT INTO `sys_role_menu` VALUES (2144, 1, 35);
INSERT INTO `sys_role_menu` VALUES (2145, 1, 8);
INSERT INTO `sys_role_menu` VALUES (2146, 1, 37);
INSERT INTO `sys_role_menu` VALUES (2147, 1, 38);
INSERT INTO `sys_role_menu` VALUES (2148, 1, 39);
INSERT INTO `sys_role_menu` VALUES (2149, 1, 36);
INSERT INTO `sys_role_menu` VALUES (2150, 1, 40);
INSERT INTO `sys_role_menu` VALUES (2151, 1, 41);
INSERT INTO `sys_role_menu` VALUES (2152, 1, 45);
INSERT INTO `sys_role_menu` VALUES (2153, 1, 46);
INSERT INTO `sys_role_menu` VALUES (2154, 1, 42);
INSERT INTO `sys_role_menu` VALUES (2155, 1, 47);
INSERT INTO `sys_role_menu` VALUES (2156, 1, 48);
INSERT INTO `sys_role_menu` VALUES (2157, 1, 49);
INSERT INTO `sys_role_menu` VALUES (2158, 1, 43);
INSERT INTO `sys_role_menu` VALUES (2159, 1, 74);
INSERT INTO `sys_role_menu` VALUES (2160, 1, 75);
INSERT INTO `sys_role_menu` VALUES (2161, 1, 44);
INSERT INTO `sys_role_menu` VALUES (2162, 1, 76);
INSERT INTO `sys_role_menu` VALUES (2163, 1, 77);
INSERT INTO `sys_role_menu` VALUES (2164, 1, 78);
INSERT INTO `sys_role_menu` VALUES (2165, 1, 50);
INSERT INTO `sys_role_menu` VALUES (2166, 1, 51);
INSERT INTO `sys_role_menu` VALUES (2167, 1, 79);
INSERT INTO `sys_role_menu` VALUES (2168, 1, 88);
INSERT INTO `sys_role_menu` VALUES (2169, 1, 89);
INSERT INTO `sys_role_menu` VALUES (2170, 1, 90);
INSERT INTO `sys_role_menu` VALUES (2171, 1, 52);
INSERT INTO `sys_role_menu` VALUES (2172, 1, 80);
INSERT INTO `sys_role_menu` VALUES (2173, 1, 85);
INSERT INTO `sys_role_menu` VALUES (2174, 1, 86);
INSERT INTO `sys_role_menu` VALUES (2175, 1, 87);
INSERT INTO `sys_role_menu` VALUES (2176, 1, 81);
INSERT INTO `sys_role_menu` VALUES (2177, 1, 82);
INSERT INTO `sys_role_menu` VALUES (2178, 1, 83);
INSERT INTO `sys_role_menu` VALUES (2179, 1, 84);
INSERT INTO `sys_role_menu` VALUES (2180, 1, 57);
INSERT INTO `sys_role_menu` VALUES (2181, 1, 58);
INSERT INTO `sys_role_menu` VALUES (2182, 1, 64);
INSERT INTO `sys_role_menu` VALUES (2183, 1, 65);
INSERT INTO `sys_role_menu` VALUES (2184, 1, 66);
INSERT INTO `sys_role_menu` VALUES (2185, 1, 67);
INSERT INTO `sys_role_menu` VALUES (2186, 1, 59);
INSERT INTO `sys_role_menu` VALUES (2187, 1, 68);
INSERT INTO `sys_role_menu` VALUES (2188, 1, 69);
INSERT INTO `sys_role_menu` VALUES (2189, 1, 70);
INSERT INTO `sys_role_menu` VALUES (2190, 1, 60);
INSERT INTO `sys_role_menu` VALUES (2191, 1, 71);
INSERT INTO `sys_role_menu` VALUES (2192, 1, 72);
INSERT INTO `sys_role_menu` VALUES (2193, 1, 73);
INSERT INTO `sys_role_menu` VALUES (2194, 1, 61);
INSERT INTO `sys_role_menu` VALUES (2195, 2, 1);
INSERT INTO `sys_role_menu` VALUES (2196, 2, 2);
INSERT INTO `sys_role_menu` VALUES (2197, 2, 3);
INSERT INTO `sys_role_menu` VALUES (2198, 2, 12);
INSERT INTO `sys_role_menu` VALUES (2199, 2, 16);
INSERT INTO `sys_role_menu` VALUES (2200, 2, 14);
INSERT INTO `sys_role_menu` VALUES (2201, 2, 15);
INSERT INTO `sys_role_menu` VALUES (2202, 2, 17);
INSERT INTO `sys_role_menu` VALUES (2203, 2, 6);
INSERT INTO `sys_role_menu` VALUES (2204, 2, 26);
INSERT INTO `sys_role_menu` VALUES (2205, 2, 27);
INSERT INTO `sys_role_menu` VALUES (2206, 2, 25);
INSERT INTO `sys_role_menu` VALUES (2207, 2, 40);
INSERT INTO `sys_role_menu` VALUES (2208, 2, 41);
INSERT INTO `sys_role_menu` VALUES (2209, 2, 45);
INSERT INTO `sys_role_menu` VALUES (2210, 2, 46);
INSERT INTO `sys_role_menu` VALUES (2211, 2, 42);
INSERT INTO `sys_role_menu` VALUES (2212, 2, 47);
INSERT INTO `sys_role_menu` VALUES (2213, 2, 48);
INSERT INTO `sys_role_menu` VALUES (2214, 2, 49);
INSERT INTO `sys_role_menu` VALUES (2215, 2, 43);
INSERT INTO `sys_role_menu` VALUES (2216, 2, 74);
INSERT INTO `sys_role_menu` VALUES (2217, 2, 75);
INSERT INTO `sys_role_menu` VALUES (2218, 2, 44);
INSERT INTO `sys_role_menu` VALUES (2219, 2, 76);
INSERT INTO `sys_role_menu` VALUES (2220, 2, 77);
INSERT INTO `sys_role_menu` VALUES (2221, 2, 78);
INSERT INTO `sys_role_menu` VALUES (2222, 2, 50);
INSERT INTO `sys_role_menu` VALUES (2223, 2, 51);
INSERT INTO `sys_role_menu` VALUES (2224, 2, 79);
INSERT INTO `sys_role_menu` VALUES (2225, 2, 88);
INSERT INTO `sys_role_menu` VALUES (2226, 2, 89);
INSERT INTO `sys_role_menu` VALUES (2227, 2, 90);
INSERT INTO `sys_role_menu` VALUES (2228, 2, 52);
INSERT INTO `sys_role_menu` VALUES (2229, 2, 80);
INSERT INTO `sys_role_menu` VALUES (2230, 2, 85);
INSERT INTO `sys_role_menu` VALUES (2231, 2, 86);
INSERT INTO `sys_role_menu` VALUES (2232, 2, 87);
INSERT INTO `sys_role_menu` VALUES (2233, 2, 81);
INSERT INTO `sys_role_menu` VALUES (2234, 2, 82);
INSERT INTO `sys_role_menu` VALUES (2235, 2, 83);
INSERT INTO `sys_role_menu` VALUES (2236, 2, 84);
INSERT INTO `sys_role_menu` VALUES (2237, 2, 57);
INSERT INTO `sys_role_menu` VALUES (2238, 2, 58);
INSERT INTO `sys_role_menu` VALUES (2239, 2, 64);
INSERT INTO `sys_role_menu` VALUES (2240, 2, 65);
INSERT INTO `sys_role_menu` VALUES (2241, 2, 66);
INSERT INTO `sys_role_menu` VALUES (2242, 2, 67);
INSERT INTO `sys_role_menu` VALUES (2243, 2, 59);
INSERT INTO `sys_role_menu` VALUES (2244, 2, 68);
INSERT INTO `sys_role_menu` VALUES (2245, 2, 69);
INSERT INTO `sys_role_menu` VALUES (2246, 2, 70);
INSERT INTO `sys_role_menu` VALUES (2247, 2, 60);
INSERT INTO `sys_role_menu` VALUES (2248, 2, 71);
INSERT INTO `sys_role_menu` VALUES (2249, 2, 72);
INSERT INTO `sys_role_menu` VALUES (2250, 2, 73);
INSERT INTO `sys_role_menu` VALUES (2251, 2, 61);

-- ----------------------------
-- Table structure for sys_sequence
-- ----------------------------
DROP TABLE IF EXISTS `sys_sequence`;
CREATE TABLE `sys_sequence`  (
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '编号名',
  `value` int(8) NULL DEFAULT NULL COMMENT '编号值',
  `next` int(1) NULL DEFAULT NULL COMMENT '递增值',
  PRIMARY KEY (`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_sequence
-- ----------------------------
INSERT INTO `sys_sequence` VALUES ('hospital_no', 0, 1);
INSERT INTO `sys_sequence` VALUES ('meeting_no', 5, 1);

-- ----------------------------
-- Table structure for sys_sms
-- ----------------------------
DROP TABLE IF EXISTS `sys_sms`;
CREATE TABLE `sys_sms`  (
  `id` bigint(32) NOT NULL AUTO_INCREMENT,
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '手机号',
  `code` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '验证码',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `status` int(2) NULL DEFAULT NULL COMMENT '是否有效 0无效 1有效 ',
  `ip` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'ip地址',
  `text` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '短信内容',
  `type` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '01登陆验证码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_sms
-- ----------------------------
INSERT INTO `sys_sms` VALUES (12, '18247270927', '491273', '2019-11-11 17:29:59', '2019-11-11 17:30:52', 0, '0:0:0:0:0:0:0:1', '【蓝色县域项目组】验证码491273，您正在登录，若非本人操作，请勿泄露。', '01');
INSERT INTO `sys_sms` VALUES (13, '18247270927', '470321', '2019-11-13 17:25:31', '2019-11-13 17:25:31', 1, '0:0:0:0:0:0:0:1', '【蓝色县域项目组】验证码470321，您正在登录，若非本人操作，请勿泄露。', '01');
INSERT INTO `sys_sms` VALUES (14, '18247270927', '481051', '2019-11-13 18:02:22', '2019-11-13 18:02:22', 1, '0:0:0:0:0:0:0:1', '【蓝色县域项目组】验证码481051，您正在登录，若非本人操作，请勿泄露。', '01');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `avatar` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `account` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '账号',
  `password` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `salt` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'md5密码盐',
  `name` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名字',
  `dept_id` bigint(20) NULL DEFAULT NULL,
  `birthday` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生日',
  `sex` int(2) NULL DEFAULT NULL COMMENT '性别（1：男 2：女）',
  `email` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电子邮件',
  `phone` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话',
  `status` int(2) NULL DEFAULT NULL COMMENT '状态(1：可用  0：不可用)',
  `version` int(20) NULL DEFAULT NULL COMMENT '保留字段',
  `create_by` bigint(20) NULL DEFAULT NULL,
  `update_by` bigint(20) NULL DEFAULT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `del_flag` tinyint(1) NULL DEFAULT NULL,
  `company_id` bigint(20) NULL DEFAULT NULL COMMENT '公司ID',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `account`(`account`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '管理员表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'https://mwy-1259572200.cos.ap-beijing.myqcloud.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 'admin', 'aa0d7f0f4fc75910c2cab9a3547d4ec5fdfea6095c27fd2d13e17dc216df3581', 'BFDze8hBJwwhOw3BDvhg', 'admin', NULL, '2018-10-08', 1, 'admin@qq.com', '13412341234', 1, NULL, NULL, NULL, '2018-10-31 17:48:40', '2019-07-26 17:40:05', 0, NULL);
INSERT INTO `sys_user` VALUES (2, 'https://mwy-1259572200.cos.ap-beijing.myqcloud.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 'test', '7848e5f0b4a6d48ad145984735bf98efe2ff2ab4f99a92b2c29201207ea3fe5f', 'ZCCRZ4gOfa8WzorCBFii', 'test', 4, '2019-07-18', 1, 'test@163.com', '13412341234', 1, NULL, NULL, NULL, '2018-12-11 09:55:35', '2019-07-16 10:36:25', 0, 1);
INSERT INTO `sys_user` VALUES (3, 'https://mwy-1259572200.cos.ap-beijing.myqcloud.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', 'qwe', '8a3f7dd608fac8f941c1bafc8202b0e918b7193d5350871a58baa3b4f3e46658', 'B0nbSiCZSvHPSvyLk6Sj', 'qwe', 9, '2019-07-26', 1, 'Q@Q163.com', '13412341234', 1, NULL, NULL, NULL, '2019-07-16 14:55:50', '2019-08-05 16:25:40', 0, 7);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户ID',
  `role_id` bigint(20) NULL DEFAULT NULL COMMENT '角色ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 75 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户与角色对应关系' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (63, 2, 2);
INSERT INTO `sys_user_role` VALUES (64, 1, 1);
INSERT INTO `sys_user_role` VALUES (75, 3, 2);

-- ----------------------------
-- Table structure for user_area
-- ----------------------------
DROP TABLE IF EXISTS `user_area`;
CREATE TABLE `user_area`  (
  `id` bigint(32) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(32) NULL DEFAULT NULL COMMENT '父ID',
  `area_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '区域名称',
  `level` int(4) NULL DEFAULT NULL COMMENT '级别',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `level_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '级别名称',
  `option_areas` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '关联区域',
  `option_status` int(4) NULL DEFAULT NULL COMMENT '关联区域标识（0：该区域的最顶级无关联，属于游离，1：有关联，在使用）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 61 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_area
-- ----------------------------
INSERT INTO `user_area` VALUES (38, 0, '美国', 1, '2019-08-14 09:44:48', '2019-08-14 09:44:48', '一级', NULL, 1);
INSERT INTO `user_area` VALUES (41, NULL, '大兴区', 3, '2019-08-16 09:01:30', '2019-08-16 18:17:20', '三级', '无关联区域', 0);
INSERT INTO `user_area` VALUES (42, 38, '华盛顿', 2, '2019-08-16 10:25:46', '2019-08-16 10:25:46', '二级', '美国', 1);
INSERT INTO `user_area` VALUES (45, 41, '兴涛社区', 4, '2019-08-16 15:03:54', '2019-08-16 18:17:20', '四级', '大兴区', 0);
INSERT INTO `user_area` VALUES (59, 0, '全国', 1, '2019-08-16 18:33:24', '2019-08-16 18:33:24', '一级', NULL, 1);
INSERT INTO `user_area` VALUES (60, 59, '北京', 2, '2019-08-21 17:44:28', '2019-08-21 17:44:28', '二级', '全国', 1);
INSERT INTO `user_area` VALUES (61, 60, '朝阳区', 3, '2019-08-21 17:44:46', '2019-08-21 17:44:46', '三级', '全国/北京', 1);

-- ----------------------------
-- Table structure for user_config
-- ----------------------------
DROP TABLE IF EXISTS `user_config`;
CREATE TABLE `user_config`  (
  `id` bigint(32) NOT NULL AUTO_INCREMENT,
  `config_id` int(6) NULL DEFAULT NULL COMMENT '配置ID',
  `param_key` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `param_value` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `status` int(4) NULL DEFAULT NULL COMMENT '状态（1：启动，2：停用）',
  `create_time` datetime(0) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_config
-- ----------------------------
INSERT INTO `user_config` VALUES (1, 1004, '1', '一级', 1, '2019-08-07 14:53:56', '2019-08-07 14:53:59');
INSERT INTO `user_config` VALUES (2, 1004, '2', '二级', 1, '2019-08-07 14:53:56', '2019-08-07 14:53:59');
INSERT INTO `user_config` VALUES (3, 1004, '3', '三级', 1, '2019-08-07 14:53:56', '2019-08-07 14:53:59');
INSERT INTO `user_config` VALUES (4, 1004, '4', '四级', 1, '2019-08-07 14:53:56', '2019-08-07 14:53:59');
INSERT INTO `user_config` VALUES (5, 1004, '5', '五级', 1, '2019-08-07 14:53:56', '2019-08-07 14:53:59');
INSERT INTO `user_config` VALUES (6, 1004, '6', '六级', 1, '2019-08-07 14:53:56', '2019-08-07 14:53:59');
INSERT INTO `user_config` VALUES (7, 1004, '7', '七级', 1, '2019-08-07 14:53:56', '2019-08-07 14:53:59');
INSERT INTO `user_config` VALUES (8, 1004, '8', '八级', 1, '2019-08-07 14:53:56', '2019-08-07 14:53:59');
INSERT INTO `user_config` VALUES (9, 1004, '9', '九级', 1, '2019-08-07 14:53:56', '2019-08-07 14:53:59');
INSERT INTO `user_config` VALUES (10, 1004, '10', '十级', 1, '2019-08-07 14:53:56', '2019-08-07 14:53:59');

-- ----------------------------
-- Table structure for user_detail
-- ----------------------------
DROP TABLE IF EXISTS `user_detail`;
CREATE TABLE `user_detail`  (
  `id` bigint(32) NOT NULL AUTO_INCREMENT,
  `avatar` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像',
  `nickname` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '昵称',
  `username` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '姓名',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '电话号',
  `area_id` bigint(32) NULL DEFAULT NULL COMMENT '区域ID',
  `role_id` bigint(32) NULL DEFAULT NULL COMMENT '角色ID',
  `status` int(1) NULL DEFAULT NULL COMMENT '状态（1：正常，0：锁定）',
  `bound_time` datetime(0) NULL DEFAULT NULL COMMENT '绑定时间',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `password` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `salt` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'md5密码盐',
  `openid` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '微信唯一标识',
  `sex` int(2) NULL DEFAULT NULL COMMENT '性别（1：男 2：女）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_detail
-- ----------------------------
INSERT INTO `user_detail` VALUES (1, 'https://wx.qlogo.cn/mmopen/vi_32/PiajxSqBRaEKf5Mg2TUNIDCIWcewjlm14KRskwdpclnyfZ2H8W40hCfUIoTia622MefOsYqmjNFEqibMHmMcyZibvA/132', '余洋', '余洋', '18851006060', 59, 2, 1, '2019-08-05 15:02:45', '2019-08-05 15:02:49', '2019-11-12 17:30:13', '66c1a54043ca91ebd33ca39c1ebdb414', 'd8b61e3e10124e17a2f1', 'o0ypL5IvtcNyQwPXB7j8_BL_6Wtc', 1);
INSERT INTO `user_detail` VALUES (5, NULL, '', '余洋', '13327736325', 59, 1, 1, NULL, '2019-11-18 09:59:50', '2019-11-18 09:59:53', '66c1a54043ca91ebd33ca39c1ebdb414', 'd8b61e3e10124e17a2f1', NULL, 2);

-- ----------------------------
-- Table structure for user_login_log
-- ----------------------------
DROP TABLE IF EXISTS `user_login_log`;
CREATE TABLE `user_login_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `log_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '日志名称',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户ID',
  `succeed` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否成功',
  `message` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '消息',
  `ip_address` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'ip',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1150667819491476079 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '登陆日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_login_log
-- ----------------------------
INSERT INTO `user_login_log` VALUES (1150667819491475930, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-23 16:45:08', '2019-10-23 16:45:08');
INSERT INTO `user_login_log` VALUES (1150667819491475931, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-23 16:45:38', '2019-10-23 16:45:38');
INSERT INTO `user_login_log` VALUES (1150667819491475932, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-24 08:48:48', '2019-10-24 08:48:48');
INSERT INTO `user_login_log` VALUES (1150667819491475933, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-24 10:06:18', '2019-10-24 10:06:18');
INSERT INTO `user_login_log` VALUES (1150667819491475934, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-24 10:10:49', '2019-10-24 10:10:49');
INSERT INTO `user_login_log` VALUES (1150667819491475935, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-24 10:12:03', '2019-10-24 10:12:03');
INSERT INTO `user_login_log` VALUES (1150667819491475936, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-24 10:12:38', '2019-10-24 10:12:38');
INSERT INTO `user_login_log` VALUES (1150667819491475937, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-24 10:19:38', '2019-10-24 10:19:38');
INSERT INTO `user_login_log` VALUES (1150667819491475938, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-24 11:05:36', '2019-10-24 11:05:36');
INSERT INTO `user_login_log` VALUES (1150667819491475939, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-24 11:05:48', '2019-10-24 11:05:48');
INSERT INTO `user_login_log` VALUES (1150667819491475940, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-24 11:06:22', '2019-10-24 11:06:22');
INSERT INTO `user_login_log` VALUES (1150667819491475941, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-24 11:07:00', '2019-10-24 11:07:00');
INSERT INTO `user_login_log` VALUES (1150667819491475942, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-24 11:07:08', '2019-10-24 11:07:08');
INSERT INTO `user_login_log` VALUES (1150667819491475943, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-24 11:07:17', '2019-10-24 11:07:17');
INSERT INTO `user_login_log` VALUES (1150667819491475944, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-24 11:08:48', '2019-10-24 11:08:48');
INSERT INTO `user_login_log` VALUES (1150667819491475945, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-24 11:11:09', '2019-10-24 11:11:09');
INSERT INTO `user_login_log` VALUES (1150667819491475946, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-24 11:37:34', '2019-10-24 11:37:34');
INSERT INTO `user_login_log` VALUES (1150667819491475947, '登录日志', 1, '成功', NULL, '111.197.241.111', '2019-10-24 11:48:38', '2019-10-24 11:48:38');
INSERT INTO `user_login_log` VALUES (1150667819491475948, '登录日志', 1, '成功', NULL, '111.197.241.111', '2019-10-24 12:03:46', '2019-10-24 12:03:46');
INSERT INTO `user_login_log` VALUES (1150667819491475949, '登录日志', 1, '成功', NULL, '111.197.241.111', '2019-10-24 12:05:07', '2019-10-24 12:05:07');
INSERT INTO `user_login_log` VALUES (1150667819491475950, '退出日志', 1, '成功', NULL, '111.197.241.111', '2019-10-24 12:05:21', '2019-10-24 12:05:21');
INSERT INTO `user_login_log` VALUES (1150667819491475951, '登录日志', 1, '成功', NULL, '111.197.241.111', '2019-10-24 12:05:27', '2019-10-24 12:05:27');
INSERT INTO `user_login_log` VALUES (1150667819491475952, '登录日志', 1, '成功', NULL, '111.197.241.111', '2019-10-24 12:06:22', '2019-10-24 12:06:22');
INSERT INTO `user_login_log` VALUES (1150667819491475953, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 01:47:12', '2019-10-25 01:47:12');
INSERT INTO `user_login_log` VALUES (1150667819491475954, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 01:47:37', '2019-10-25 01:47:37');
INSERT INTO `user_login_log` VALUES (1150667819491475955, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 01:48:39', '2019-10-25 01:48:39');
INSERT INTO `user_login_log` VALUES (1150667819491475956, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 01:49:02', '2019-10-25 01:49:02');
INSERT INTO `user_login_log` VALUES (1150667819491475957, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 01:49:17', '2019-10-25 01:49:17');
INSERT INTO `user_login_log` VALUES (1150667819491475958, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 01:49:30', '2019-10-25 01:49:30');
INSERT INTO `user_login_log` VALUES (1150667819491475959, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 01:49:31', '2019-10-25 01:49:31');
INSERT INTO `user_login_log` VALUES (1150667819491475960, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 01:50:23', '2019-10-25 01:50:23');
INSERT INTO `user_login_log` VALUES (1150667819491475961, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 01:56:15', '2019-10-25 01:56:15');
INSERT INTO `user_login_log` VALUES (1150667819491475962, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 01:59:07', '2019-10-25 01:59:07');
INSERT INTO `user_login_log` VALUES (1150667819491475963, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 02:04:06', '2019-10-25 02:04:06');
INSERT INTO `user_login_log` VALUES (1150667819491475964, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 02:19:14', '2019-10-25 02:19:14');
INSERT INTO `user_login_log` VALUES (1150667819491475965, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 02:19:54', '2019-10-25 02:19:54');
INSERT INTO `user_login_log` VALUES (1150667819491475966, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 02:28:32', '2019-10-25 02:28:32');
INSERT INTO `user_login_log` VALUES (1150667819491475967, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 02:28:38', '2019-10-25 02:28:38');
INSERT INTO `user_login_log` VALUES (1150667819491475968, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 02:29:35', '2019-10-25 02:29:35');
INSERT INTO `user_login_log` VALUES (1150667819491475969, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 02:31:23', '2019-10-25 02:31:23');
INSERT INTO `user_login_log` VALUES (1150667819491475970, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 02:34:17', '2019-10-25 02:34:17');
INSERT INTO `user_login_log` VALUES (1150667819491475971, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 02:34:27', '2019-10-25 02:34:27');
INSERT INTO `user_login_log` VALUES (1150667819491475972, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 02:35:12', '2019-10-25 02:35:12');
INSERT INTO `user_login_log` VALUES (1150667819491475973, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 02:36:36', '2019-10-25 02:36:36');
INSERT INTO `user_login_log` VALUES (1150667819491475974, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 02:38:03', '2019-10-25 02:38:03');
INSERT INTO `user_login_log` VALUES (1150667819491475975, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 02:38:36', '2019-10-25 02:38:36');
INSERT INTO `user_login_log` VALUES (1150667819491475976, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 02:38:59', '2019-10-25 02:38:59');
INSERT INTO `user_login_log` VALUES (1150667819491475977, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 02:39:36', '2019-10-25 02:39:36');
INSERT INTO `user_login_log` VALUES (1150667819491475978, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 02:40:34', '2019-10-25 02:40:34');
INSERT INTO `user_login_log` VALUES (1150667819491475979, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 02:40:46', '2019-10-25 02:40:46');
INSERT INTO `user_login_log` VALUES (1150667819491475980, '退出日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 02:45:54', '2019-10-25 02:45:54');
INSERT INTO `user_login_log` VALUES (1150667819491475981, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 02:57:30', '2019-10-25 02:57:30');
INSERT INTO `user_login_log` VALUES (1150667819491475982, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 02:58:02', '2019-10-25 02:58:02');
INSERT INTO `user_login_log` VALUES (1150667819491475983, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 03:01:27', '2019-10-25 03:01:27');
INSERT INTO `user_login_log` VALUES (1150667819491475984, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 03:01:32', '2019-10-25 03:01:32');
INSERT INTO `user_login_log` VALUES (1150667819491475985, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 03:02:37', '2019-10-25 03:02:37');
INSERT INTO `user_login_log` VALUES (1150667819491475986, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 03:08:44', '2019-10-25 03:08:44');
INSERT INTO `user_login_log` VALUES (1150667819491475987, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 03:16:13', '2019-10-25 03:16:13');
INSERT INTO `user_login_log` VALUES (1150667819491475988, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 03:16:32', '2019-10-25 03:16:32');
INSERT INTO `user_login_log` VALUES (1150667819491475989, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 03:16:45', '2019-10-25 03:16:45');
INSERT INTO `user_login_log` VALUES (1150667819491475990, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 03:17:49', '2019-10-25 03:17:49');
INSERT INTO `user_login_log` VALUES (1150667819491475991, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 03:18:19', '2019-10-25 03:18:19');
INSERT INTO `user_login_log` VALUES (1150667819491475992, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 03:19:52', '2019-10-25 03:19:52');
INSERT INTO `user_login_log` VALUES (1150667819491475993, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 03:20:44', '2019-10-25 03:20:44');
INSERT INTO `user_login_log` VALUES (1150667819491475994, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 03:38:49', '2019-10-25 03:38:49');
INSERT INTO `user_login_log` VALUES (1150667819491475995, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 03:39:04', '2019-10-25 03:39:04');
INSERT INTO `user_login_log` VALUES (1150667819491475996, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 03:39:11', '2019-10-25 03:39:11');
INSERT INTO `user_login_log` VALUES (1150667819491475997, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 03:43:22', '2019-10-25 03:43:22');
INSERT INTO `user_login_log` VALUES (1150667819491475998, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 03:43:49', '2019-10-25 03:43:49');
INSERT INTO `user_login_log` VALUES (1150667819491475999, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 03:44:15', '2019-10-25 03:44:15');
INSERT INTO `user_login_log` VALUES (1150667819491476000, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 03:45:00', '2019-10-25 03:45:00');
INSERT INTO `user_login_log` VALUES (1150667819491476001, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 03:45:43', '2019-10-25 03:45:43');
INSERT INTO `user_login_log` VALUES (1150667819491476002, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 03:46:17', '2019-10-25 03:46:17');
INSERT INTO `user_login_log` VALUES (1150667819491476003, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 03:47:12', '2019-10-25 03:47:12');
INSERT INTO `user_login_log` VALUES (1150667819491476004, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 03:47:21', '2019-10-25 03:47:21');
INSERT INTO `user_login_log` VALUES (1150667819491476005, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 03:47:55', '2019-10-25 03:47:55');
INSERT INTO `user_login_log` VALUES (1150667819491476006, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 03:48:10', '2019-10-25 03:48:10');
INSERT INTO `user_login_log` VALUES (1150667819491476007, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 05:49:26', '2019-10-25 05:49:26');
INSERT INTO `user_login_log` VALUES (1150667819491476008, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 05:49:44', '2019-10-25 05:49:44');
INSERT INTO `user_login_log` VALUES (1150667819491476009, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 05:50:26', '2019-10-25 05:50:26');
INSERT INTO `user_login_log` VALUES (1150667819491476010, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 06:01:23', '2019-10-25 06:01:23');
INSERT INTO `user_login_log` VALUES (1150667819491476011, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 06:01:34', '2019-10-25 06:01:34');
INSERT INTO `user_login_log` VALUES (1150667819491476012, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 06:03:20', '2019-10-25 06:03:20');
INSERT INTO `user_login_log` VALUES (1150667819491476013, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 06:03:35', '2019-10-25 06:03:35');
INSERT INTO `user_login_log` VALUES (1150667819491476014, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 06:03:37', '2019-10-25 06:03:37');
INSERT INTO `user_login_log` VALUES (1150667819491476015, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 06:05:13', '2019-10-25 06:05:13');
INSERT INTO `user_login_log` VALUES (1150667819491476016, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 06:13:32', '2019-10-25 06:13:32');
INSERT INTO `user_login_log` VALUES (1150667819491476017, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 06:14:09', '2019-10-25 06:14:09');
INSERT INTO `user_login_log` VALUES (1150667819491476018, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 06:14:52', '2019-10-25 06:14:52');
INSERT INTO `user_login_log` VALUES (1150667819491476019, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 06:15:22', '2019-10-25 06:15:22');
INSERT INTO `user_login_log` VALUES (1150667819491476020, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-25 06:15:47', '2019-10-25 06:15:47');
INSERT INTO `user_login_log` VALUES (1150667819491476021, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-28 06:38:46', '2019-10-28 06:38:46');
INSERT INTO `user_login_log` VALUES (1150667819491476022, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-28 06:40:26', '2019-10-28 06:40:26');
INSERT INTO `user_login_log` VALUES (1150667819491476023, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-28 06:40:51', '2019-10-28 06:40:51');
INSERT INTO `user_login_log` VALUES (1150667819491476024, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-28 06:50:52', '2019-10-28 06:50:52');
INSERT INTO `user_login_log` VALUES (1150667819491476025, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-28 06:51:26', '2019-10-28 06:51:26');
INSERT INTO `user_login_log` VALUES (1150667819491476026, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-28 07:25:23', '2019-10-28 07:25:23');
INSERT INTO `user_login_log` VALUES (1150667819491476027, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-28 07:25:55', '2019-10-28 07:25:55');
INSERT INTO `user_login_log` VALUES (1150667819491476028, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-28 07:59:46', '2019-10-28 07:59:46');
INSERT INTO `user_login_log` VALUES (1150667819491476029, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-28 08:02:15', '2019-10-28 08:02:15');
INSERT INTO `user_login_log` VALUES (1150667819491476030, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-28 08:05:52', '2019-10-28 08:05:52');
INSERT INTO `user_login_log` VALUES (1150667819491476031, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-28 08:07:29', '2019-10-28 08:07:29');
INSERT INTO `user_login_log` VALUES (1150667819491476032, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-28 08:17:02', '2019-10-28 08:17:02');
INSERT INTO `user_login_log` VALUES (1150667819491476033, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-28 08:18:51', '2019-10-28 08:18:51');
INSERT INTO `user_login_log` VALUES (1150667819491476034, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-28 08:24:44', '2019-10-28 08:24:44');
INSERT INTO `user_login_log` VALUES (1150667819491476035, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-28 08:26:03', '2019-10-28 08:26:03');
INSERT INTO `user_login_log` VALUES (1150667819491476036, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-28 08:26:39', '2019-10-28 08:26:39');
INSERT INTO `user_login_log` VALUES (1150667819491476037, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-28 08:38:39', '2019-10-28 08:38:39');
INSERT INTO `user_login_log` VALUES (1150667819491476038, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-28 08:40:55', '2019-10-28 08:40:55');
INSERT INTO `user_login_log` VALUES (1150667819491476039, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-28 08:42:32', '2019-10-28 08:42:32');
INSERT INTO `user_login_log` VALUES (1150667819491476040, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-28 08:43:38', '2019-10-28 08:43:38');
INSERT INTO `user_login_log` VALUES (1150667819491476041, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-28 08:49:20', '2019-10-28 08:49:20');
INSERT INTO `user_login_log` VALUES (1150667819491476042, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-28 08:52:29', '2019-10-28 08:52:29');
INSERT INTO `user_login_log` VALUES (1150667819491476043, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-28 08:52:49', '2019-10-28 08:52:49');
INSERT INTO `user_login_log` VALUES (1150667819491476044, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-28 08:55:04', '2019-10-28 08:55:04');
INSERT INTO `user_login_log` VALUES (1150667819491476045, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-28 08:56:10', '2019-10-28 08:56:10');
INSERT INTO `user_login_log` VALUES (1150667819491476046, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-28 08:57:34', '2019-10-28 08:57:34');
INSERT INTO `user_login_log` VALUES (1150667819491476047, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-28 08:57:42', '2019-10-28 08:57:42');
INSERT INTO `user_login_log` VALUES (1150667819491476048, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-28 09:02:51', '2019-10-28 09:02:51');
INSERT INTO `user_login_log` VALUES (1150667819491476049, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-10-28 09:28:20', '2019-10-28 09:28:20');
INSERT INTO `user_login_log` VALUES (1150667819491476050, '登录日志', 1, '成功', NULL, '0:0:0:0:0:0:0:1', '2019-10-31 02:25:55', '2019-10-31 02:25:55');
INSERT INTO `user_login_log` VALUES (1150667819491476051, '退出日志', 1, '成功', NULL, '0:0:0:0:0:0:0:1', '2019-10-31 02:26:21', '2019-10-31 02:26:21');
INSERT INTO `user_login_log` VALUES (1150667819491476052, '登录日志', 1, '成功', NULL, '0:0:0:0:0:0:0:1', '2019-10-31 02:27:35', '2019-10-31 02:27:35');
INSERT INTO `user_login_log` VALUES (1150667819491476053, '退出日志', 1, '成功', NULL, '0:0:0:0:0:0:0:1', '2019-10-31 02:27:56', '2019-10-31 02:27:56');
INSERT INTO `user_login_log` VALUES (1150667819491476054, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-11-06 07:41:20', '2019-11-06 07:41:20');
INSERT INTO `user_login_log` VALUES (1150667819491476055, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-11-06 07:43:45', '2019-11-06 07:43:45');
INSERT INTO `user_login_log` VALUES (1150667819491476056, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-11-06 07:47:15', '2019-11-06 07:47:15');
INSERT INTO `user_login_log` VALUES (1150667819491476057, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-11-06 07:51:50', '2019-11-06 07:51:50');
INSERT INTO `user_login_log` VALUES (1150667819491476058, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-11-06 08:00:38', '2019-11-06 08:00:38');
INSERT INTO `user_login_log` VALUES (1150667819491476059, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-11-06 08:10:05', '2019-11-06 08:10:05');
INSERT INTO `user_login_log` VALUES (1150667819491476060, '登录日志', 1, '成功', NULL, '221.226.22.218', '2019-11-06 08:10:19', '2019-11-06 08:10:19');
INSERT INTO `user_login_log` VALUES (1150667819491476061, '登录日志', 1, '成功', NULL, '0:0:0:0:0:0:0:1', '2019-11-10 06:03:28', '2019-11-10 06:03:28');
INSERT INTO `user_login_log` VALUES (1150667819491476062, '登录日志', 1, '成功', NULL, '0:0:0:0:0:0:0:1', '2019-11-10 06:13:28', '2019-11-10 06:13:28');
INSERT INTO `user_login_log` VALUES (1150667819491476063, '登录日志', 1, '成功', NULL, '0:0:0:0:0:0:0:1', '2019-11-10 06:33:07', '2019-11-10 06:33:07');
INSERT INTO `user_login_log` VALUES (1150667819491476064, '登录日志', 1, '成功', NULL, '0:0:0:0:0:0:0:1', '2019-11-10 06:45:53', '2019-11-10 06:45:53');
INSERT INTO `user_login_log` VALUES (1150667819491476065, '登录日志', 1, '成功', NULL, '0:0:0:0:0:0:0:1', '2019-11-10 10:19:32', '2019-11-10 10:19:32');
INSERT INTO `user_login_log` VALUES (1150667819491476066, '登录日志', 1, '成功', NULL, '0:0:0:0:0:0:0:1', '2019-11-10 11:39:36', '2019-11-10 11:39:36');
INSERT INTO `user_login_log` VALUES (1150667819491476067, '登录日志', 1, '成功', NULL, '0:0:0:0:0:0:0:1', '2019-11-11 17:30:55', '2019-11-11 17:30:55');
INSERT INTO `user_login_log` VALUES (1150667819491476068, '登录日志', 1, '成功', NULL, '0:0:0:0:0:0:0:1', '2019-11-12 09:26:21', '2019-11-12 09:26:21');
INSERT INTO `user_login_log` VALUES (1150667819491476069, '登录日志', 1, '成功', NULL, '0:0:0:0:0:0:0:1', '2019-11-12 09:26:56', '2019-11-12 09:26:56');
INSERT INTO `user_login_log` VALUES (1150667819491476070, '登录日志', 1, '成功', NULL, '0:0:0:0:0:0:0:1', '2019-11-12 09:33:25', '2019-11-12 09:33:25');
INSERT INTO `user_login_log` VALUES (1150667819491476071, '登录日志', 1, '成功', NULL, '0:0:0:0:0:0:0:1', '2019-11-12 09:37:02', '2019-11-12 09:37:02');
INSERT INTO `user_login_log` VALUES (1150667819491476072, '登录日志', 1, '成功', NULL, '0:0:0:0:0:0:0:1', '2019-11-12 14:02:11', '2019-11-12 14:02:11');
INSERT INTO `user_login_log` VALUES (1150667819491476073, '登录日志', 1, '成功', NULL, '0:0:0:0:0:0:0:1', '2019-11-12 17:09:55', '2019-11-12 17:09:55');
INSERT INTO `user_login_log` VALUES (1150667819491476074, '登录日志', 1, '成功', NULL, '0:0:0:0:0:0:0:1', '2019-11-12 17:13:52', '2019-11-12 17:13:52');
INSERT INTO `user_login_log` VALUES (1150667819491476075, '登录日志', 1, '成功', NULL, '0:0:0:0:0:0:0:1', '2019-11-12 17:22:55', '2019-11-12 17:22:55');
INSERT INTO `user_login_log` VALUES (1150667819491476076, '登录日志', 1, '成功', NULL, '0:0:0:0:0:0:0:1', '2019-11-12 17:30:15', '2019-11-12 17:30:15');
INSERT INTO `user_login_log` VALUES (1150667819491476077, '登录日志', 1, '成功', NULL, '0:0:0:0:0:0:0:1', '2019-11-12 17:55:33', '2019-11-12 17:55:33');
INSERT INTO `user_login_log` VALUES (1150667819491476078, '登录日志', 1, '成功', NULL, '0:0:0:0:0:0:0:1', '2019-11-13 09:12:06', '2019-11-13 09:12:06');
INSERT INTO `user_login_log` VALUES (1150667819491476079, '登录日志', 1, '成功', NULL, '0:0:0:0:0:0:0:1', '2019-11-13 15:51:48', '2019-11-13 15:51:48');
INSERT INTO `user_login_log` VALUES (1150667819491476080, '登录日志', 1, '成功', NULL, '0:0:0:0:0:0:0:1', '2019-11-22 11:05:44', '2019-11-22 11:05:44');
INSERT INTO `user_login_log` VALUES (1150667819491476081, '登录日志', 5, '成功', NULL, '0:0:0:0:0:0:0:1', '2019-11-22 11:07:42', '2019-11-22 11:07:42');

-- ----------------------------
-- Table structure for user_operation_log
-- ----------------------------
DROP TABLE IF EXISTS `user_operation_log`;
CREATE TABLE `user_operation_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `log_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '日志类型',
  `log_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '日志名称',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户ID',
  `class_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '类名称',
  `method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '方法名称',
  `succeed` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否成功',
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '备注',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `execute_time` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '执行时间(毫秒)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1150601874915967931 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '操作日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_operation_log
-- ----------------------------
INSERT INTO `user_operation_log` VALUES (1150601874915967835, '操作日志', '下载会议文件', NULL, 'com.ksh.wehert.system.controller.meeting.MeetingCloudController', 'download', '成功', '\"http://img.jcscdata.com/M201910290002/bd75cd75-dbe2-4f51-bff0-dd27aca2fd31.jpg\"', '2019-10-30 05:44:57', '2019-10-30 05:44:57', '451');
INSERT INTO `user_operation_log` VALUES (1150601874915967836, '操作日志', '下载会议文件', NULL, 'com.ksh.wehert.system.controller.meeting.MeetingCloudController', 'download', '成功', '\"M201910290002\"', '2019-10-30 09:33:33', '2019-10-30 09:33:33', '1877');
INSERT INTO `user_operation_log` VALUES (1150601874915967837, '操作日志', '下载会议文件', NULL, 'com.ksh.wehert.system.controller.meeting.MeetingCloudController', 'download', '成功', '\"M201910290002\"', '2019-10-30 09:38:20', '2019-10-30 09:38:20', '1767');
INSERT INTO `user_operation_log` VALUES (1150601874915967838, '异常日志', '', NULL, NULL, NULL, '失败', 'Current request is not a multipart request', '2019-10-30 09:48:45', '2019-10-30 09:48:45', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967839, '操作日志', '上传会议文件', NULL, 'com.ksh.wehert.system.controller.meeting.MeetingCloudController', 'upload', '成功', '[{\"part\":{\"fileItem\":{\"fieldName\":\"file\",\"contentType\":\"image/jpeg\",\"isFormField\":false,\"fileName\":\"w (1).jpg\",\"size\":-1,\"sizeThreshold\":0,\"repository\":{\"path\":\"C:\\\\Users\\\\Dell\\\\AppData\\\\Local\\\\Temp\\\\tomcat.4985438838678968605.8081\\\\work\\\\Tomcat\\\\localhost\\\\wehert_api\"},\"headers\":{\"headerNameToValueListMap\":{\"content-disposition\":[\"form-data; name\\u003d\\\"file\\\"; filename\\u003d\\\"w (1).jpg\\\"\"],\"content-type\":[\"image/jpeg\"]}},\"defaultCharset\":\"ISO-8859-1\"},\"location\":{\"path\":\"C:\\\\Users\\\\Dell\\\\AppData\\\\Local\\\\Temp\\\\tomcat.4985438838678968605.8081\\\\work\\\\Tomcat\\\\localhost\\\\wehert_api\"}},\"filename\":\"w (1).jpg\"},{\"part\":{\"fileItem\":{\"fieldName\":\"file\",\"contentType\":\"image/png\",\"isFormField\":false,\"fileName\":\"w (1).png\",\"size\":-1,\"sizeThreshold\":0,\"repository\":{\"path\":\"C:\\\\Users\\\\Dell\\\\AppData\\\\Local\\\\Temp\\\\tomcat.4985438838678968605.8081\\\\work\\\\Tomcat\\\\localhost\\\\wehert_api\"},\"headers\":{\"headerNameToValueListMap\":{\"content-disposition\":[\"form-data; name\\u003d\\\"file\\\"; filename\\u003d\\\"w (1).png\\\"\"],\"content-type\":[\"image/png\"]}},\"defaultCharset\":\"ISO-8859-1\"},\"location\":{\"path\":\"C:\\\\Users\\\\Dell\\\\AppData\\\\Local\\\\Temp\\\\tomcat.4985438838678968605.8081\\\\work\\\\Tomcat\\\\localhost\\\\wehert_api\"}},\"filename\":\"w (1).png\"}]', '2019-10-30 09:54:11', '2019-10-30 09:54:11', '21425');
INSERT INTO `user_operation_log` VALUES (1150601874915967840, '异常日志', '', NULL, NULL, NULL, '失败', NULL, '2019-10-31 02:45:26', '2019-10-31 02:45:26', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967841, '异常日志', '', NULL, NULL, NULL, '失败', NULL, '2019-10-31 02:48:53', '2019-10-31 02:48:53', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967842, '异常日志', '', NULL, NULL, NULL, '失败', 'invalid comment', '2019-10-31 02:50:45', '2019-10-31 02:50:45', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967843, '异常日志', '', NULL, NULL, NULL, '失败', 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error querying database.  Cause: com.baomidou.mybatisplus.core.exceptions.MybatisPlusException: Error: Method queryTotal execution error.\r\n### The error may exist in file [D:\\Development\\Workspaces\\wehert\\wehert-api\\target\\classes\\com\\ksh\\wehert\\system\\dao\\mapping\\MeetingDetailMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### Cause: com.baomidou.mybatisplus.core.exceptions.MybatisPlusException: Error: Method queryTotal execution error.', '2019-10-31 02:50:59', '2019-10-31 02:50:59', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967844, '异常日志', '', NULL, NULL, NULL, '失败', 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error querying database.  Cause: com.baomidou.mybatisplus.core.exceptions.MybatisPlusException: Error: Method queryTotal execution error.\r\n### The error may exist in file [D:\\Development\\Workspaces\\wehert\\wehert-api\\target\\classes\\com\\ksh\\wehert\\system\\dao\\mapping\\MeetingDetailMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### Cause: com.baomidou.mybatisplus.core.exceptions.MybatisPlusException: Error: Method queryTotal execution error.', '2019-10-31 02:52:06', '2019-10-31 02:52:06', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967845, '异常日志', '', NULL, NULL, NULL, '失败', '\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'file_type\' in \'where clause\'\n### The error may exist in com/ksh/wehert/system/dao/MeetingCloudMapper.java (best guess)\n### The error may involve defaultParameterMap\n### The error occurred while setting parameters\n### SQL: SELECT  id,meeting_id AS meetingId,meeting_code AS meetingCode,type,upload_time AS uploadTime,user_id AS userId,url,name,create_time AS createTime,update_time AS updateTime  FROM meeting_cloud  WHERE  meeting_id = ? AND file_type = ?\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'file_type\' in \'where clause\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'file_type\' in \'where clause\'', '2019-11-09 05:26:35', '2019-11-09 05:26:35', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967846, '异常日志', '', NULL, NULL, NULL, '失败', '\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'file_type\' in \'where clause\'\n### The error may exist in com/ksh/wehert/system/dao/MeetingCloudMapper.java (best guess)\n### The error may involve defaultParameterMap\n### The error occurred while setting parameters\n### SQL: SELECT  id,meeting_id AS meetingId,meeting_code AS meetingCode,type,upload_time AS uploadTime,user_id AS userId,url,name,create_time AS createTime,update_time AS updateTime  FROM meeting_cloud  WHERE  meeting_id = ? AND file_type = ?\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'file_type\' in \'where clause\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'file_type\' in \'where clause\'', '2019-11-09 05:28:59', '2019-11-09 05:28:59', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967847, '异常日志', '', NULL, NULL, NULL, '失败', NULL, '2019-11-09 05:29:40', '2019-11-09 05:29:40', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967848, '异常日志', '', NULL, NULL, NULL, '失败', NULL, '2019-11-09 05:30:25', '2019-11-09 05:30:25', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967849, '异常日志', '', NULL, NULL, NULL, '失败', NULL, '2019-11-09 05:30:31', '2019-11-09 05:30:31', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967850, '异常日志', '', NULL, NULL, NULL, '失败', '\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'file_type\' in \'where clause\'\n### The error may exist in com/ksh/wehert/system/dao/MeetingCloudMapper.java (best guess)\n### The error may involve defaultParameterMap\n### The error occurred while setting parameters\n### SQL: SELECT  id,meeting_id AS meetingId,meeting_code AS meetingCode,type,upload_time AS uploadTime,user_id AS userId,url,name,create_time AS createTime,update_time AS updateTime  FROM meeting_cloud  WHERE  meeting_id = ? AND file_type = ?\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'file_type\' in \'where clause\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'file_type\' in \'where clause\'', '2019-11-09 06:08:57', '2019-11-09 06:08:57', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967851, '异常日志', '', NULL, NULL, NULL, '失败', '\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'applicant_id\' in \'field list\'\n### The error may involve com.ksh.wehert.system.dao.MeetingDetailMapper.insert-Inline\n### The error occurred while setting parameters\n### SQL: INSERT INTO meeting_detail   ( code,meeting_time,meeting_type,hospital_id,speakers_id,applicant_id,applicant_time,pre_cost,activity_cost,pre_persons,source,status,topic_id,create_time,update_time )  VALUES   ( ?,?,?,?,?,?,?,?,?,?,?,?,?,?,? )\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'applicant_id\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'applicant_id\' in \'field list\'', '2019-11-09 06:22:05', '2019-11-09 06:22:05', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967852, '异常日志', '', NULL, NULL, NULL, '失败', NULL, '2019-11-09 06:22:32', '2019-11-09 06:22:32', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967853, '异常日志', '', NULL, NULL, NULL, '失败', '\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'applicant_id\' in \'field list\'\n### The error may involve com.ksh.wehert.system.dao.MeetingDetailMapper.insert-Inline\n### The error occurred while setting parameters\n### SQL: INSERT INTO meeting_detail   ( code,meeting_time,meeting_type,hospital_id,speakers_id,applicant_id,applicant_time,pre_cost,activity_cost,pre_persons,source,status,topic_id,create_time,update_time )  VALUES   ( ?,?,?,?,?,?,?,?,?,?,?,?,?,?,? )\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'applicant_id\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'applicant_id\' in \'field list\'', '2019-11-09 06:22:47', '2019-11-09 06:22:47', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967854, '异常日志', '', NULL, NULL, NULL, '失败', '\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'applicant_id\' in \'field list\'\n### The error may involve com.ksh.wehert.system.dao.MeetingDetailMapper.insert-Inline\n### The error occurred while setting parameters\n### SQL: INSERT INTO meeting_detail   ( code,meeting_time,meeting_type,hospital_id,speakers_id,applicant_id,applicant_time,pre_cost,pre_persons,source,status,topic_id,create_time,update_time )  VALUES   ( ?,?,?,?,?,?,?,?,?,?,?,?,?,? )\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'applicant_id\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'applicant_id\' in \'field list\'', '2019-11-09 06:24:47', '2019-11-09 06:24:47', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967855, '异常日志', '', NULL, NULL, NULL, '失败', '\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'file_type\' in \'where clause\'\n### The error may exist in com/ksh/wehert/system/dao/MeetingCloudMapper.java (best guess)\n### The error may involve defaultParameterMap\n### The error occurred while setting parameters\n### SQL: SELECT  id,meeting_id AS meetingId,meeting_code AS meetingCode,type,upload_time AS uploadTime,user_id AS userId,url,name,create_time AS createTime,update_time AS updateTime  FROM meeting_cloud  WHERE  meeting_id = ? AND file_type = ?\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'file_type\' in \'where clause\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'file_type\' in \'where clause\'', '2019-11-09 06:31:56', '2019-11-09 06:31:56', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967856, '异常日志', '', NULL, NULL, NULL, '失败', '\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'file_type\' in \'where clause\'\n### The error may exist in com/ksh/wehert/system/dao/MeetingCloudMapper.java (best guess)\n### The error may involve defaultParameterMap\n### The error occurred while setting parameters\n### SQL: SELECT  id,meeting_id AS meetingId,meeting_code AS meetingCode,type,upload_time AS uploadTime,user_id AS userId,url,name,create_time AS createTime,update_time AS updateTime  FROM meeting_cloud  WHERE  meeting_id = ? AND file_type = ?\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'file_type\' in \'where clause\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'file_type\' in \'where clause\'', '2019-11-09 06:34:19', '2019-11-09 06:34:19', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967857, '异常日志', '', NULL, NULL, NULL, '失败', 'syntax error, pos 9, json : {object: \"eyJtZWV0aW5nVHlwZSI6MSwiaG9zcGl0YWxJZCI6IjEiLCJ0b3BpY0lkIjo5MCwic3BlYWtlcnNJZCI6IjIiLCJtZWV0aW5nVGltZSI6IjIwMTktMTEtMDkiLCJwcmVQZXJzb25zIjoiMiIsInByZUNvc3QiOiIzIn0=\",\nsign: \"1c6235f1076bf038222a3766eca73030\"\n}', '2019-11-09 06:37:11', '2019-11-09 06:37:11', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967858, '异常日志', '', NULL, NULL, NULL, '失败', '\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'applicant_id\' in \'field list\'\n### The error may involve com.ksh.wehert.system.dao.MeetingDetailMapper.insert-Inline\n### The error occurred while setting parameters\n### SQL: INSERT INTO meeting_detail   ( code,meeting_time,meeting_type,hospital_id,speakers_id,applicant_id,applicant_time,pre_cost,pre_persons,source,status,topic_id,create_time,update_time )  VALUES   ( ?,?,?,?,?,?,?,?,?,?,?,?,?,? )\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'applicant_id\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'applicant_id\' in \'field list\'', '2019-11-09 06:37:52', '2019-11-09 06:37:52', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967859, '操作日志', '新增会议', NULL, 'com.ksh.wehert.system.controller.meeting.MeetingDetailController', 'add', '成功', '{\"id\":20,\"code\":\"M201911090001\",\"meetingTime\":\"Nov 9, 2019 12:00:00 AM\",\"meetingType\":1,\"hospitalId\":1,\"speakersId\":2,\"applicantId\":1,\"applicantTime\":\"Nov 9, 2019 2:39:05 PM\",\"preCost\":3,\"prePersons\":2,\"source\":\"小程序\",\"status\":\"01\",\"topicId\":90,\"createTime\":\"Nov 9, 2019 2:39:05 PM\",\"updateTime\":\"Nov 9, 2019 2:39:05 PM\",\"currentPage\":1,\"pageSize\":10}', '2019-11-09 06:39:06', '2019-11-09 06:39:06', '9');
INSERT INTO `user_operation_log` VALUES (1150601874915967860, '异常日志', '', NULL, NULL, NULL, '失败', 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \n### Error querying database.  Cause: com.baomidou.mybatisplus.core.exceptions.MybatisPlusException: Error: Method queryTotal execution error.\n### The error may exist in URL [jar:file:/home/appadmin/wehert/wehert-api-0.0.1-SNAPSHOT.jar!/BOOT-INF/classes!/com/ksh/wehert/system/dao/mapping/MeetingDetailMapper.xml]\n### The error may involve defaultParameterMap\n### The error occurred while setting parameters\n### Cause: com.baomidou.mybatisplus.core.exceptions.MybatisPlusException: Error: Method queryTotal execution error.', '2019-11-09 08:02:54', '2019-11-09 08:02:54', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967861, '异常日志', '', NULL, NULL, NULL, '失败', 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \n### Error querying database.  Cause: com.baomidou.mybatisplus.core.exceptions.MybatisPlusException: Error: Method queryTotal execution error.\n### The error may exist in URL [jar:file:/home/appadmin/wehert/wehert-api-0.0.1-SNAPSHOT.jar!/BOOT-INF/classes!/com/ksh/wehert/system/dao/mapping/MeetingDetailMapper.xml]\n### The error may involve defaultParameterMap\n### The error occurred while setting parameters\n### Cause: com.baomidou.mybatisplus.core.exceptions.MybatisPlusException: Error: Method queryTotal execution error.', '2019-11-09 08:03:42', '2019-11-09 08:03:42', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967862, '异常日志', '', NULL, NULL, NULL, '失败', 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \n### Error querying database.  Cause: com.baomidou.mybatisplus.core.exceptions.MybatisPlusException: Error: Method queryTotal execution error.\n### The error may exist in URL [jar:file:/home/appadmin/wehert/wehert-api-0.0.1-SNAPSHOT.jar!/BOOT-INF/classes!/com/ksh/wehert/system/dao/mapping/MeetingDetailMapper.xml]\n### The error may involve defaultParameterMap\n### The error occurred while setting parameters\n### Cause: com.baomidou.mybatisplus.core.exceptions.MybatisPlusException: Error: Method queryTotal execution error.', '2019-11-09 08:08:06', '2019-11-09 08:08:06', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967863, '异常日志', '', NULL, NULL, NULL, '失败', 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \n### Error querying database.  Cause: com.baomidou.mybatisplus.core.exceptions.MybatisPlusException: Error: Method queryTotal execution error.\n### The error may exist in URL [jar:file:/home/appadmin/wehert/wehert-api-0.0.1-SNAPSHOT.jar!/BOOT-INF/classes!/com/ksh/wehert/system/dao/mapping/MeetingDetailMapper.xml]\n### The error may involve defaultParameterMap\n### The error occurred while setting parameters\n### Cause: com.baomidou.mybatisplus.core.exceptions.MybatisPlusException: Error: Method queryTotal execution error.', '2019-11-09 08:08:59', '2019-11-09 08:08:59', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967864, '异常日志', '', NULL, NULL, NULL, '失败', '\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'md.auditor_id\' in \'on clause\'\n### The error may exist in URL [jar:file:/home/appadmin/wehert/wehert-api-0.0.1-SNAPSHOT.jar!/BOOT-INF/classes!/com/ksh/wehert/system/dao/mapping/MeetingDetailMapper.xml]\n### The error may involve defaultParameterMap\n### The error occurred while setting parameters\n### SQL: select * from         (select md.*,hde.name hospital_name, hde.address hospital_address, hdc.name speakers_name,         su.name auditor_name, ud.username applicant_name, mc.name topic_name         from meeting_detail md         left join hospital_detail hde on md.hospital_id = hde.id         left join hospital_doctor hdc on md.speakers_id = hdc.id         left join sys_user su on md.auditor_id = su.id         left join user_detail ud on md.user_id = ud.id         left join meeting_course mc on md.topic_id = mc.id         ) m         where m.id = ?\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'md.auditor_id\' in \'on clause\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'md.auditor_id\' in \'on clause\'', '2019-11-09 08:09:29', '2019-11-09 08:09:29', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967865, '操作日志', '新增会议', NULL, 'com.ksh.wehert.system.controller.meeting.MeetingDetailController', 'add', '成功', '{\"id\":21,\"code\":\"M201911090002\",\"meetingTime\":\"Nov 9, 2019 12:00:00 AM\",\"meetingType\":1,\"hospitalId\":2,\"speakersId\":2,\"applicantId\":1,\"applicantTime\":\"Nov 9, 2019 4:10:04 PM\",\"preCost\":222,\"prePersons\":33,\"source\":\"小程序\",\"status\":\"01\",\"topicId\":90,\"createTime\":\"Nov 9, 2019 4:10:04 PM\",\"updateTime\":\"Nov 9, 2019 4:10:04 PM\",\"currentPage\":1,\"pageSize\":10}', '2019-11-09 08:10:04', '2019-11-09 08:10:04', '21');
INSERT INTO `user_operation_log` VALUES (1150601874915967866, '操作日志', '新增会议', NULL, 'com.ksh.wehert.system.controller.meeting.MeetingDetailController', 'add', '成功', '{\"id\":22,\"code\":\"M201911090003\",\"meetingTime\":\"Nov 9, 2019 12:00:00 AM\",\"meetingType\":1,\"hospitalId\":2,\"speakersId\":2,\"applicantId\":1,\"applicantTime\":\"Nov 9, 2019 4:42:26 PM\",\"preCost\":3333,\"prePersons\":222,\"source\":\"小程序\",\"status\":\"01\",\"topicId\":90,\"createTime\":\"Nov 9, 2019 4:42:26 PM\",\"updateTime\":\"Nov 9, 2019 4:42:26 PM\",\"currentPage\":1,\"pageSize\":10}', '2019-11-09 08:42:26', '2019-11-09 08:42:26', '12');
INSERT INTO `user_operation_log` VALUES (1150601874915967867, '异常日志', '', NULL, NULL, NULL, '失败', 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \n### Error querying database.  Cause: com.baomidou.mybatisplus.core.exceptions.MybatisPlusException: Error: Method queryTotal execution error.\n### The error may exist in URL [jar:file:/home/appadmin/wehert/wehert-api-0.0.1-SNAPSHOT.jar!/BOOT-INF/classes!/com/ksh/wehert/system/dao/mapping/MeetingDetailMapper.xml]\n### The error may involve defaultParameterMap\n### The error occurred while setting parameters\n### Cause: com.baomidou.mybatisplus.core.exceptions.MybatisPlusException: Error: Method queryTotal execution error.', '2019-11-09 08:51:45', '2019-11-09 08:51:45', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967868, '异常日志', '', NULL, NULL, NULL, '失败', 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \n### Error querying database.  Cause: com.baomidou.mybatisplus.core.exceptions.MybatisPlusException: Error: Method queryTotal execution error.\n### The error may exist in URL [jar:file:/home/appadmin/wehert/wehert-api-0.0.1-SNAPSHOT.jar!/BOOT-INF/classes!/com/ksh/wehert/system/dao/mapping/MeetingDetailMapper.xml]\n### The error may involve defaultParameterMap\n### The error occurred while setting parameters\n### Cause: com.baomidou.mybatisplus.core.exceptions.MybatisPlusException: Error: Method queryTotal execution error.', '2019-11-09 08:52:07', '2019-11-09 08:52:07', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967869, '操作日志', '新增会议', NULL, 'com.ksh.wehert.system.controller.meeting.MeetingDetailController', 'add', '成功', '{\"id\":23,\"code\":\"M201911090004\",\"meetingTime\":\"Nov 9, 2019 12:00:00 AM\",\"meetingType\":1,\"hospitalId\":2,\"speakersId\":2,\"applicantId\":1,\"applicantTime\":\"Nov 9, 2019 4:52:44 PM\",\"preCost\":333,\"prePersons\":22,\"source\":\"小程序\",\"status\":\"01\",\"topicId\":90,\"createTime\":\"Nov 9, 2019 4:52:44 PM\",\"updateTime\":\"Nov 9, 2019 4:52:44 PM\",\"currentPage\":1,\"pageSize\":10}', '2019-11-09 08:52:45', '2019-11-09 08:52:45', '8');
INSERT INTO `user_operation_log` VALUES (1150601874915967870, '异常日志', '', NULL, NULL, NULL, '失败', 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \n### Error querying database.  Cause: com.baomidou.mybatisplus.core.exceptions.MybatisPlusException: Error: Method queryTotal execution error.\n### The error may exist in URL [jar:file:/home/appadmin/wehert/wehert-api-0.0.1-SNAPSHOT.jar!/BOOT-INF/classes!/com/ksh/wehert/system/dao/mapping/MeetingDetailMapper.xml]\n### The error may involve defaultParameterMap\n### The error occurred while setting parameters\n### Cause: com.baomidou.mybatisplus.core.exceptions.MybatisPlusException: Error: Method queryTotal execution error.', '2019-11-09 08:53:21', '2019-11-09 08:53:21', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967871, '操作日志', '新增会议', NULL, 'com.ksh.wehert.system.controller.meeting.MeetingDetailController', 'add', '成功', '{\"id\":24,\"code\":\"M201911090005\",\"meetingTime\":\"Nov 9, 2019 12:00:00 AM\",\"meetingType\":1,\"hospitalId\":1,\"speakersId\":2,\"applicantId\":1,\"applicantTime\":\"Nov 9, 2019 4:53:49 PM\",\"preCost\":333,\"prePersons\":122,\"source\":\"小程序\",\"status\":\"01\",\"topicId\":90,\"createTime\":\"Nov 9, 2019 4:53:49 PM\",\"updateTime\":\"Nov 9, 2019 4:53:49 PM\",\"currentPage\":1,\"pageSize\":10}', '2019-11-09 08:53:50', '2019-11-09 08:53:50', '8');
INSERT INTO `user_operation_log` VALUES (1150601874915967872, '异常日志', '', NULL, NULL, NULL, '失败', 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \n### Error querying database.  Cause: com.baomidou.mybatisplus.core.exceptions.MybatisPlusException: Error: Method queryTotal execution error.\n### The error may exist in URL [jar:file:/home/appadmin/wehert/wehert-api-0.0.1-SNAPSHOT.jar!/BOOT-INF/classes!/com/ksh/wehert/system/dao/mapping/MeetingDetailMapper.xml]\n### The error may involve defaultParameterMap\n### The error occurred while setting parameters\n### Cause: com.baomidou.mybatisplus.core.exceptions.MybatisPlusException: Error: Method queryTotal execution error.', '2019-11-09 13:27:54', '2019-11-09 13:27:54', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967873, '异常日志', '', NULL, NULL, NULL, '失败', 'Error in execution; nested exception is io.lettuce.core.RedisCommandExecutionException: NOAUTH Authentication required.', '2019-11-10 05:48:40', '2019-11-10 05:48:40', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967874, '异常日志', '', NULL, NULL, NULL, '失败', 'Error in execution; nested exception is io.lettuce.core.RedisCommandExecutionException: NOAUTH Authentication required.', '2019-11-10 05:50:15', '2019-11-10 05:50:15', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967875, '异常日志', '', NULL, NULL, NULL, '失败', 'Error in execution; nested exception is io.lettuce.core.RedisCommandExecutionException: NOAUTH Authentication required.', '2019-11-10 05:51:32', '2019-11-10 05:51:32', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967876, '异常日志', '', NULL, NULL, NULL, '失败', 'Error in execution; nested exception is io.lettuce.core.RedisCommandExecutionException: NOAUTH Authentication required.', '2019-11-10 05:52:04', '2019-11-10 05:52:04', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967877, '异常日志', '', NULL, NULL, NULL, '失败', 'Error in execution; nested exception is io.lettuce.core.RedisCommandExecutionException: NOAUTH Authentication required.', '2019-11-10 05:58:00', '2019-11-10 05:58:00', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967878, '异常日志', '', NULL, NULL, NULL, '失败', 'Error in execution; nested exception is io.lettuce.core.RedisCommandExecutionException: NOAUTH Authentication required.', '2019-11-10 05:58:36', '2019-11-10 05:58:36', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967879, '异常日志', '', NULL, NULL, NULL, '失败', 'Error in execution; nested exception is io.lettuce.core.RedisCommandExecutionException: NOAUTH Authentication required.', '2019-11-10 05:59:13', '2019-11-10 05:59:13', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967880, '异常日志', '', NULL, NULL, NULL, '失败', 'Error in execution; nested exception is io.lettuce.core.RedisCommandExecutionException: NOAUTH Authentication required.', '2019-11-10 06:01:33', '2019-11-10 06:01:33', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967881, '异常日志', '', NULL, NULL, NULL, '失败', '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'hdc.i\' in \'on clause\'\r\n### The error may exist in file [D:\\Development\\Projects\\wehert\\wehert-api\\target\\classes\\com\\ksh\\wehert\\system\\dao\\mapping\\MeetingDetailMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: select * from         (select md.*,hde.name hospital_name, hde.address hospital_address, hdc.name speakers_name,         su.name auditor_name, ud.username applicant_name, mc.name topic_name         from meeting_detail md         left join hospital_detail hde on md.hospital_id = hde.id         left join hospital_doctor hdc on md.speakers_id = hdc.i         left join sys_user su on md.auditor_id = su.id         left join user_detail ud on md.applicant_id = ud.id         left join meeting_course mc on md.topic_id = mc.id         ) m         where m.id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'hdc.i\' in \'on clause\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'hdc.i\' in \'on clause\'', '2019-11-10 10:21:02', '2019-11-10 10:21:02', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967882, '异常日志', '', NULL, NULL, NULL, '失败', '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'WHERE 1 = 1 \n		\n			and phone =  \'15210203952\'\n		\n		\n			and type =  \'01\'\' at line 3\r\n### The error may exist in file [D:\\Development\\Workspaces\\wehert\\wehert-api\\target\\classes\\com\\ksh\\wehert\\system\\dao\\mapping\\UserSmsMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: select count(*) from sys_sms   where create_time > DATE_SUB(NOW(), INTERVAL 1 DAY)    WHERE 1 = 1        and phone =  ?          and type =  ?\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'WHERE 1 = 1 \n		\n			and phone =  \'15210203952\'\n		\n		\n			and type =  \'01\'\' at line 3\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'WHERE 1 = 1 \n		\n			and phone =  \'15210203952\'\n		\n		\n			and type =  \'01\'\' at line 3', '2019-11-11 06:38:42', '2019-11-11 06:38:42', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967883, '异常日志', '', NULL, NULL, NULL, '失败', 'nested exception is org.apache.ibatis.binding.BindingException: Parameter \'phone\' not found. Available parameters are [arg1, arg0, param1, param2]', '2019-11-11 06:45:52', '2019-11-11 06:45:52', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967884, '异常日志', '', NULL, NULL, NULL, '失败', 'nested exception is org.apache.ibatis.binding.BindingException: Parameter \'phone\' not found. Available parameters are [arg1, arg0, param1, param2]', '2019-11-11 06:48:13', '2019-11-11 06:48:13', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967885, '异常日志', '', NULL, NULL, NULL, '失败', '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'WHERE 1 = 1 \n		\n			and ss.phone =  \'15210203952\'\n		\n		\n			and ss.type =  \'01\'\' at line 3\r\n### The error may exist in file [D:\\Development\\Workspaces\\wehert\\wehert-api\\target\\classes\\com\\ksh\\wehert\\system\\dao\\mapping\\SysSmsMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: select count(*) from sys_sms ss   where ss.create_time > DATE_SUB(NOW(), INTERVAL 1 DAY)    WHERE 1 = 1        and ss.phone =  ?          and ss.type =  ?\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'WHERE 1 = 1 \n		\n			and ss.phone =  \'15210203952\'\n		\n		\n			and ss.type =  \'01\'\' at line 3\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'WHERE 1 = 1 \n		\n			and ss.phone =  \'15210203952\'\n		\n		\n			and ss.type =  \'01\'\' at line 3', '2019-11-11 07:00:09', '2019-11-11 07:00:09', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967886, '异常日志', '', NULL, NULL, NULL, '失败', 'Index: 0, Size: 0', '2019-11-11 17:11:15', '2019-11-11 17:11:15', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967887, '异常日志', '', NULL, NULL, NULL, '失败', 'Index: 0, Size: 0', '2019-11-11 17:18:01', '2019-11-11 17:18:01', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967888, '异常日志', '', NULL, NULL, NULL, '失败', 'Index: 0, Size: 0', '2019-11-11 17:19:35', '2019-11-11 17:19:35', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967889, '异常日志', '', NULL, NULL, NULL, '失败', 'Index: 0, Size: 0', '2019-11-11 17:23:12', '2019-11-11 17:23:12', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967890, '异常日志', '', NULL, NULL, NULL, '失败', 'Index: 0, Size: 0', '2019-11-11 17:25:36', '2019-11-11 17:25:36', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967891, '异常日志', '', NULL, NULL, NULL, '失败', 'JWT expired at 2019-11-12T09:24:29Z. Current time: 2019-11-12T09:24:31Z, a difference of 2941 milliseconds.  Allowed clock skew: 0 milliseconds.', '2019-11-12 09:24:32', '2019-11-12 09:24:32', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967892, '异常日志', '', NULL, NULL, NULL, '失败', 'Failed to parse multipart servlet request; nested exception is java.io.IOException: org.apache.tomcat.util.http.fileupload.FileUploadException: the request was rejected because no multipart boundary was found', '2019-11-12 15:13:06', '2019-11-12 15:13:06', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967893, '操作日志', '上传会议文件', NULL, 'com.ksh.wehert.system.controller.meeting.MeetingCloudController', 'upload', '成功', '[{\"part\":{\"fileItem\":{\"fieldName\":\"file\",\"contentType\":\"image/jpeg\",\"isFormField\":false,\"fileName\":\"w (2).jpg\",\"size\":-1,\"sizeThreshold\":0,\"repository\":{\"path\":\"C:\\\\Users\\\\Dell\\\\AppData\\\\Local\\\\Temp\\\\tomcat.1550202799080507923.8081\\\\work\\\\Tomcat\\\\localhost\\\\wehert_api\"},\"headers\":{\"headerNameToValueListMap\":{\"content-disposition\":[\"form-data; name\\u003d\\\"file\\\"; filename\\u003d\\\"w (2).jpg\\\"\"],\"content-type\":[\"image/jpeg\"]}},\"defaultCharset\":\"ISO-8859-1\"},\"location\":{\"path\":\"C:\\\\Users\\\\Dell\\\\AppData\\\\Local\\\\Temp\\\\tomcat.1550202799080507923.8081\\\\work\\\\Tomcat\\\\localhost\\\\wehert_api\"}},\"filename\":\"w (2).jpg\"}]', '2019-11-12 15:16:56', '2019-11-12 15:16:56', '2476');
INSERT INTO `user_operation_log` VALUES (1150601874915967894, '异常日志', '', NULL, NULL, NULL, '失败', 'Failed to parse multipart servlet request; nested exception is java.io.IOException: org.apache.tomcat.util.http.fileupload.FileUploadException: the request was rejected because no multipart boundary was found', '2019-11-12 15:37:53', '2019-11-12 15:37:53', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967895, '异常日志', '', NULL, NULL, NULL, '失败', 'Failed to parse multipart servlet request; nested exception is java.io.IOException: org.apache.tomcat.util.http.fileupload.FileUploadException: the request was rejected because no multipart boundary was found', '2019-11-12 15:43:16', '2019-11-12 15:43:16', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967896, '异常日志', '', NULL, NULL, NULL, '失败', 'Failed to parse multipart servlet request; nested exception is java.io.IOException: org.apache.tomcat.util.http.fileupload.FileUploadException: the request was rejected because no multipart boundary was found', '2019-11-12 15:48:24', '2019-11-12 15:48:24', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967897, '异常日志', '', NULL, NULL, NULL, '失败', 'Failed to parse multipart servlet request; nested exception is java.io.IOException: org.apache.tomcat.util.http.fileupload.FileUploadException: the request was rejected because no multipart boundary was found', '2019-11-12 15:49:06', '2019-11-12 15:49:06', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967898, '异常日志', '', NULL, NULL, NULL, '失败', 'Current request is not a multipart request', '2019-11-12 15:50:25', '2019-11-12 15:50:25', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967899, '异常日志', '', NULL, NULL, NULL, '失败', 'Failed to parse multipart servlet request; nested exception is java.io.IOException: org.apache.tomcat.util.http.fileupload.FileUploadException: the request was rejected because no multipart boundary was found', '2019-11-12 15:50:59', '2019-11-12 15:50:59', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967900, '异常日志', '', NULL, NULL, NULL, '失败', 'Failed to parse multipart servlet request; nested exception is java.io.IOException: org.apache.tomcat.util.http.fileupload.FileUploadException: the request was rejected because no multipart boundary was found', '2019-11-12 15:59:13', '2019-11-12 15:59:13', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967901, '异常日志', '', NULL, NULL, NULL, '失败', 'Failed to parse multipart servlet request; nested exception is java.io.IOException: org.apache.tomcat.util.http.fileupload.FileUploadException: the request was rejected because no multipart boundary was found', '2019-11-12 15:59:53', '2019-11-12 15:59:53', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967902, '异常日志', '', NULL, NULL, NULL, '失败', 'Failed to parse multipart servlet request; nested exception is java.io.IOException: org.apache.tomcat.util.http.fileupload.FileUploadException: the request was rejected because no multipart boundary was found', '2019-11-12 16:00:28', '2019-11-12 16:00:28', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967903, '操作日志', '上传会议文件', NULL, 'com.ksh.wehert.system.controller.meeting.MeetingCloudController', 'upload', '成功', '[{\"part\":{\"fileItem\":{\"fieldName\":\"file\",\"contentType\":\"image/jpeg\",\"isFormField\":false,\"fileName\":\"w (2).jpg\",\"size\":-1,\"sizeThreshold\":0,\"repository\":{\"path\":\"C:\\\\Users\\\\Dell\\\\AppData\\\\Local\\\\Temp\\\\tomcat.1209718498967812137.8081\\\\work\\\\Tomcat\\\\localhost\\\\wehert_api\"},\"headers\":{\"headerNameToValueListMap\":{\"content-disposition\":[\"form-data; name\\u003d\\\"file\\\"; filename\\u003d\\\"w (2).jpg\\\"\"],\"content-type\":[\"image/jpeg\"]}},\"defaultCharset\":\"ISO-8859-1\"},\"location\":{\"path\":\"C:\\\\Users\\\\Dell\\\\AppData\\\\Local\\\\Temp\\\\tomcat.1209718498967812137.8081\\\\work\\\\Tomcat\\\\localhost\\\\wehert_api\"}},\"filename\":\"w (2).jpg\"}]', '2019-11-12 16:04:40', '2019-11-12 16:04:40', '8990');
INSERT INTO `user_operation_log` VALUES (1150601874915967904, '操作日志', '上传会议文件', NULL, 'com.ksh.wehert.system.controller.meeting.MeetingCloudController', 'upload', '成功', '[{\"part\":{\"fileItem\":{\"fieldName\":\"file\",\"contentType\":\"image/jpeg\",\"isFormField\":false,\"fileName\":\"w (2).jpg\",\"size\":-1,\"sizeThreshold\":0,\"repository\":{\"path\":\"C:\\\\Users\\\\Dell\\\\AppData\\\\Local\\\\Temp\\\\tomcat.5675769926562323167.8081\\\\work\\\\Tomcat\\\\localhost\\\\wehert_api\"},\"headers\":{\"headerNameToValueListMap\":{\"content-disposition\":[\"form-data; name\\u003d\\\"file\\\"; filename\\u003d\\\"w (2).jpg\\\"\"],\"content-type\":[\"image/jpeg\"]}},\"defaultCharset\":\"ISO-8859-1\"},\"location\":{\"path\":\"C:\\\\Users\\\\Dell\\\\AppData\\\\Local\\\\Temp\\\\tomcat.5675769926562323167.8081\\\\work\\\\Tomcat\\\\localhost\\\\wehert_api\"}},\"filename\":\"w (2).jpg\"}]', '2019-11-12 18:00:21', '2019-11-12 18:00:21', '5295');
INSERT INTO `user_operation_log` VALUES (1150601874915967905, '操作日志', '上传会议文件', NULL, 'com.ksh.wehert.system.controller.meeting.MeetingCloudController', 'upload', '成功', '[{\"part\":{\"fileItem\":{\"fieldName\":\"file\",\"contentType\":\"image/jpeg\",\"isFormField\":false,\"fileName\":\"w (2).jpg\",\"size\":-1,\"sizeThreshold\":0,\"repository\":{\"path\":\"C:\\\\Users\\\\Dell\\\\AppData\\\\Local\\\\Temp\\\\tomcat.5675769926562323167.8081\\\\work\\\\Tomcat\\\\localhost\\\\wehert_api\"},\"headers\":{\"headerNameToValueListMap\":{\"content-disposition\":[\"form-data; name\\u003d\\\"file\\\"; filename\\u003d\\\"w (2).jpg\\\"\"],\"content-type\":[\"image/jpeg\"]}},\"defaultCharset\":\"ISO-8859-1\"},\"location\":{\"path\":\"C:\\\\Users\\\\Dell\\\\AppData\\\\Local\\\\Temp\\\\tomcat.5675769926562323167.8081\\\\work\\\\Tomcat\\\\localhost\\\\wehert_api\"}},\"filename\":\"w (2).jpg\"}]', '2019-11-12 18:01:36', '2019-11-12 18:01:36', '44037');
INSERT INTO `user_operation_log` VALUES (1150601874915967906, '异常日志', '', NULL, NULL, NULL, '失败', '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'d.createTime\' in \'order clause\'\r\n### The error may exist in file [D:\\Development\\Workspaces\\wehert\\wehert-api\\target\\classes\\com\\ksh\\wehert\\system\\dao\\mapping\\HospitalDeptMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: select d.* from hospital_dept d order by d.createTime desc\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'d.createTime\' in \'order clause\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'d.createTime\' in \'order clause\'', '2019-11-13 09:15:05', '2019-11-13 09:15:05', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967907, '异常日志', '', NULL, NULL, NULL, '失败', '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'d.createTime\' in \'order clause\'\r\n### The error may exist in file [D:\\Development\\Workspaces\\wehert\\wehert-api\\target\\classes\\com\\ksh\\wehert\\system\\dao\\mapping\\HospitalDeptMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: select d.* from hospital_dept d order by d.createTime desc\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'d.createTime\' in \'order clause\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'d.createTime\' in \'order clause\'', '2019-11-13 09:18:50', '2019-11-13 09:18:50', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967908, '异常日志', '', NULL, NULL, NULL, '失败', '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'d.createTime\' in \'order clause\'\r\n### The error may exist in file [D:\\Development\\Workspaces\\wehert\\wehert-api\\target\\classes\\com\\ksh\\wehert\\system\\dao\\mapping\\HospitalDeptMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: select d.* from hospital_dept d order by d.createTime desc\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'d.createTime\' in \'order clause\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'d.createTime\' in \'order clause\'', '2019-11-13 09:21:16', '2019-11-13 09:21:16', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967909, '异常日志', '', NULL, NULL, NULL, '失败', '\r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'d.createTime\' in \'order clause\'\r\n### The error may exist in file [D:\\Development\\Workspaces\\wehert\\wehert-api\\target\\classes\\com\\ksh\\wehert\\system\\dao\\mapping\\HospitalDeptMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: select d.* from hospital_dept d order by d.createTime desc\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'d.createTime\' in \'order clause\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'d.createTime\' in \'order clause\'', '2019-11-13 09:24:38', '2019-11-13 09:24:38', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967910, '操作日志', '上传会议文件', NULL, 'com.ksh.wehert.system.controller.meeting.MeetingCloudController', 'upload', '成功', '[{\"part\":{\"fileItem\":{\"fieldName\":\"file\",\"contentType\":\"image/jpeg\",\"isFormField\":false,\"fileName\":\"w (2).jpg\",\"size\":-1,\"sizeThreshold\":0,\"repository\":{\"path\":\"C:\\\\Users\\\\Dell\\\\AppData\\\\Local\\\\Temp\\\\tomcat.940397526716209590.8081\\\\work\\\\Tomcat\\\\localhost\\\\wehert_api\"},\"headers\":{\"headerNameToValueListMap\":{\"content-disposition\":[\"form-data; name\\u003d\\\"file\\\"; filename\\u003d\\\"w (2).jpg\\\"\"],\"content-type\":[\"image/jpeg\"]}},\"defaultCharset\":\"ISO-8859-1\"},\"location\":{\"path\":\"C:\\\\Users\\\\Dell\\\\AppData\\\\Local\\\\Temp\\\\tomcat.940397526716209590.8081\\\\work\\\\Tomcat\\\\localhost\\\\wehert_api\"}},\"filename\":\"w (2).jpg\"}]', '2019-11-13 10:27:02', '2019-11-13 10:27:02', '4500');
INSERT INTO `user_operation_log` VALUES (1150601874915967911, '操作日志', '上传会议文件', NULL, 'com.ksh.wehert.system.controller.meeting.MeetingCloudController', 'upload', '成功', '[{\"part\":{\"fileItem\":{\"fieldName\":\"file\",\"contentType\":\"image/jpeg\",\"isFormField\":false,\"fileName\":\"w (2).jpg\",\"size\":-1,\"sizeThreshold\":0,\"repository\":{\"path\":\"C:\\\\Users\\\\Dell\\\\AppData\\\\Local\\\\Temp\\\\tomcat.940397526716209590.8081\\\\work\\\\Tomcat\\\\localhost\\\\wehert_api\"},\"headers\":{\"headerNameToValueListMap\":{\"content-disposition\":[\"form-data; name\\u003d\\\"file\\\"; filename\\u003d\\\"w (2).jpg\\\"\"],\"content-type\":[\"image/jpeg\"]}},\"defaultCharset\":\"ISO-8859-1\"},\"location\":{\"path\":\"C:\\\\Users\\\\Dell\\\\AppData\\\\Local\\\\Temp\\\\tomcat.940397526716209590.8081\\\\work\\\\Tomcat\\\\localhost\\\\wehert_api\"}},\"filename\":\"w (2).jpg\"}]', '2019-11-13 10:28:47', '2019-11-13 10:28:47', '31111');
INSERT INTO `user_operation_log` VALUES (1150601874915967912, '操作日志', '上传会议文件', NULL, 'com.ksh.wehert.system.controller.meeting.MeetingCloudController', 'upload', '成功', '[{\"part\":{\"fileItem\":{\"fieldName\":\"file\",\"contentType\":\"image/jpeg\",\"isFormField\":false,\"fileName\":\"w (2).jpg\",\"size\":-1,\"sizeThreshold\":0,\"repository\":{\"path\":\"C:\\\\Users\\\\Dell\\\\AppData\\\\Local\\\\Temp\\\\tomcat.940397526716209590.8081\\\\work\\\\Tomcat\\\\localhost\\\\wehert_api\"},\"headers\":{\"headerNameToValueListMap\":{\"content-disposition\":[\"form-data; name\\u003d\\\"file\\\"; filename\\u003d\\\"w (2).jpg\\\"\"],\"content-type\":[\"image/jpeg\"]}},\"defaultCharset\":\"ISO-8859-1\"},\"location\":{\"path\":\"C:\\\\Users\\\\Dell\\\\AppData\\\\Local\\\\Temp\\\\tomcat.940397526716209590.8081\\\\work\\\\Tomcat\\\\localhost\\\\wehert_api\"}},\"filename\":\"w (2).jpg\"}]', '2019-11-13 10:30:16', '2019-11-13 10:30:16', '2379');
INSERT INTO `user_operation_log` VALUES (1150601874915967913, '操作日志', '上传会议文件', NULL, 'com.ksh.wehert.system.controller.meeting.MeetingCloudController', 'upload', '成功', '[{\"part\":{\"fileItem\":{\"fieldName\":\"file\",\"contentType\":\"image/jpeg\",\"isFormField\":false,\"fileName\":\"w (2).jpg\",\"size\":-1,\"sizeThreshold\":0,\"repository\":{\"path\":\"C:\\\\Users\\\\Dell\\\\AppData\\\\Local\\\\Temp\\\\tomcat.2553549461867290333.8081\\\\work\\\\Tomcat\\\\localhost\\\\wehert_api\"},\"headers\":{\"headerNameToValueListMap\":{\"content-disposition\":[\"form-data; name\\u003d\\\"file\\\"; filename\\u003d\\\"w (2).jpg\\\"\"],\"content-type\":[\"image/jpeg\"]}},\"defaultCharset\":\"ISO-8859-1\"},\"location\":{\"path\":\"C:\\\\Users\\\\Dell\\\\AppData\\\\Local\\\\Temp\\\\tomcat.2553549461867290333.8081\\\\work\\\\Tomcat\\\\localhost\\\\wehert_api\"}},\"filename\":\"w (2).jpg\"}]', '2019-11-13 10:33:18', '2019-11-13 10:33:18', '4920');
INSERT INTO `user_operation_log` VALUES (1150601874915967914, '操作日志', '上传会议文件', NULL, 'com.ksh.wehert.system.controller.meeting.MeetingCloudController', 'upload', '成功', '[{\"part\":{\"fileItem\":{\"fieldName\":\"file\",\"contentType\":\"image/jpeg\",\"isFormField\":false,\"fileName\":\"w (2).jpg\",\"size\":-1,\"sizeThreshold\":0,\"repository\":{\"path\":\"C:\\\\Users\\\\Dell\\\\AppData\\\\Local\\\\Temp\\\\tomcat.8907101351510611927.8081\\\\work\\\\Tomcat\\\\localhost\\\\wehert_api\"},\"headers\":{\"headerNameToValueListMap\":{\"content-disposition\":[\"form-data; name\\u003d\\\"file\\\"; filename\\u003d\\\"w (2).jpg\\\"\"],\"content-type\":[\"image/jpeg\"]}},\"defaultCharset\":\"ISO-8859-1\"},\"location\":{\"path\":\"C:\\\\Users\\\\Dell\\\\AppData\\\\Local\\\\Temp\\\\tomcat.8907101351510611927.8081\\\\work\\\\Tomcat\\\\localhost\\\\wehert_api\"}},\"filename\":\"w (2).jpg\"}]', '2019-11-13 10:34:08', '2019-11-13 10:34:08', '3753');
INSERT INTO `user_operation_log` VALUES (1150601874915967915, '操作日志', '上传会议文件', NULL, 'com.ksh.wehert.system.controller.meeting.MeetingCloudController', 'upload', '成功', '[{\"part\":{\"fileItem\":{\"fieldName\":\"file\",\"contentType\":\"image/jpeg\",\"isFormField\":false,\"fileName\":\"w (14).jpg\",\"size\":-1,\"sizeThreshold\":0,\"repository\":{\"path\":\"C:\\\\Users\\\\Dell\\\\AppData\\\\Local\\\\Temp\\\\tomcat.8907101351510611927.8081\\\\work\\\\Tomcat\\\\localhost\\\\wehert_api\"},\"headers\":{\"headerNameToValueListMap\":{\"content-disposition\":[\"form-data; name\\u003d\\\"file\\\"; filename\\u003d\\\"w (14).jpg\\\"\"],\"content-type\":[\"image/jpeg\"]}},\"defaultCharset\":\"ISO-8859-1\"},\"location\":{\"path\":\"C:\\\\Users\\\\Dell\\\\AppData\\\\Local\\\\Temp\\\\tomcat.8907101351510611927.8081\\\\work\\\\Tomcat\\\\localhost\\\\wehert_api\"}},\"filename\":\"w (14).jpg\"}]', '2019-11-13 10:37:22', '2019-11-13 10:37:22', '3655');
INSERT INTO `user_operation_log` VALUES (1150601874915967916, '操作日志', '上传会议文件', NULL, 'com.ksh.wehert.system.controller.meeting.MeetingCloudController', 'upload', '成功', '[{\"part\":{\"fileItem\":{\"fieldName\":\"file\",\"contentType\":\"image/jpeg\",\"isFormField\":false,\"fileName\":\"w (14).jpg\",\"size\":-1,\"sizeThreshold\":0,\"repository\":{\"path\":\"C:\\\\Users\\\\Dell\\\\AppData\\\\Local\\\\Temp\\\\tomcat.8907101351510611927.8081\\\\work\\\\Tomcat\\\\localhost\\\\wehert_api\"},\"headers\":{\"headerNameToValueListMap\":{\"content-disposition\":[\"form-data; name\\u003d\\\"file\\\"; filename\\u003d\\\"w (14).jpg\\\"\"],\"content-type\":[\"image/jpeg\"]}},\"defaultCharset\":\"ISO-8859-1\"},\"location\":{\"path\":\"C:\\\\Users\\\\Dell\\\\AppData\\\\Local\\\\Temp\\\\tomcat.8907101351510611927.8081\\\\work\\\\Tomcat\\\\localhost\\\\wehert_api\"}},\"filename\":\"w (14).jpg\"}]', '2019-11-13 10:39:16', '2019-11-13 10:39:16', '3196');
INSERT INTO `user_operation_log` VALUES (1150601874915967917, '操作日志', '删除会议', NULL, 'com.ksh.wehert.system.controller.meeting.MeetingDetailController', 'del', '成功', '[1,2]', '2019-11-13 14:52:50', '2019-11-13 14:52:50', '262');
INSERT INTO `user_operation_log` VALUES (1150601874915967918, '操作日志', '审核 会议', NULL, 'com.ksh.wehert.system.controller.meeting.MeetingDetailController', 'auditor', '成功', '1', '2019-11-13 14:54:54', '2019-11-13 14:54:54', '103');
INSERT INTO `user_operation_log` VALUES (1150601874915967919, '操作日志', '更新会议', NULL, 'com.ksh.wehert.system.controller.meeting.MeetingDetailController', 'update', '成功', '{\"id\":1,\"fileIds\":[18,19,20],\"currentPage\":1,\"pageSize\":10,\"updateTime\":\"Nov 13, 2019 3:02:05 PM\"}', '2019-11-13 15:02:05', '2019-11-13 15:02:05', '10240');
INSERT INTO `user_operation_log` VALUES (1150601874915967920, '异常日志', '', NULL, NULL, NULL, '失败', 'exepct \'[\', but {, pos 1, json : {\n \"ids\": [1,2]\n}', '2019-11-13 17:55:41', '2019-11-13 17:55:41', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967921, '异常日志', '', NULL, NULL, NULL, '失败', 'exepct \'[\', but {, pos 1, json : {\n \"ids\": [1,2]\n}', '2019-11-13 17:56:10', '2019-11-13 17:56:10', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967922, '异常日志', '', NULL, NULL, NULL, '失败', 'exepct \'[\', but {, pos 1, json : {\n \"ids\": [1,2]\n}', '2019-11-13 17:56:15', '2019-11-13 17:56:15', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967923, '异常日志', '', NULL, NULL, NULL, '失败', 'exepct \'[\', but {, pos 1, json : {\n \"ids\": [1,2]\n}', '2019-11-13 17:58:18', '2019-11-13 17:58:18', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967924, '异常日志', '', NULL, NULL, NULL, '失败', 'exepct \'[\', but {, pos 1, json : {\n \"ids\": [1,2]\n}', '2019-11-13 17:58:20', '2019-11-13 17:58:20', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967925, '操作日志', '删除会议', NULL, 'com.ksh.heart.system.controller.meeting.MeetingDetailController', 'del', '成功', '[1,2]', '2019-11-13 17:59:58', '2019-11-13 17:59:58', '21994');
INSERT INTO `user_operation_log` VALUES (1150601874915967926, '异常日志', '', NULL, NULL, NULL, '失败', NULL, '2019-11-14 15:43:50', '2019-11-14 15:43:50', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967927, '操作日志', '新增会议', NULL, 'com.ksh.heart.system.controller.meeting.MeetingDetailController', 'add', '成功', '{\"id\":25,\"code\":\"M201911140001\",\"meetingTime\":\"Nov 14, 2019 12:00:00 AM\",\"meetingType\":1,\"hospitalId\":2,\"speakersId\":1,\"applicantId\":1,\"applicantTime\":\"Nov 14, 2019 4:26:11 PM\",\"preCost\":33,\"prePersons\":22,\"source\":\"小程序\",\"auditorStatus\":\"01\",\"topicId\":90,\"delFlag\":1,\"currentPage\":1,\"pageSize\":10,\"createTime\":\"Nov 14, 2019 4:26:11 PM\",\"updateTime\":\"Nov 14, 2019 4:26:11 PM\"}', '2019-11-14 16:26:12', '2019-11-14 16:26:12', '514');
INSERT INTO `user_operation_log` VALUES (1150601874915967928, '异常日志', '', NULL, NULL, NULL, '失败', 'com.alibaba.fastjson.JSONArray cannot be cast to [Ljava.lang.Long;', '2019-11-14 16:32:22', '2019-11-14 16:32:22', 'null');
INSERT INTO `user_operation_log` VALUES (1150601874915967929, '操作日志', '更新会议现场', NULL, 'com.ksh.heart.system.controller.meeting.MeetingDetailController', 'updateScene', '成功', '{\"id\":25,\"realPersons\":100,\"address\":\"北京市朝阳区那旮沓胡同\",\"videoId\":15,\"sceneIds\":[20,21,22],\"currentPage\":1,\"pageSize\":10,\"updateTime\":\"Nov 15, 2019 5:45:06 PM\"}', '2019-11-15 17:45:06', '2019-11-15 17:45:06', '194677');
INSERT INTO `user_operation_log` VALUES (1150601874915967930, '操作日志', '更新会议现场', NULL, 'com.ksh.heart.system.controller.meeting.MeetingDetailController', 'updateScene', '成功', '{\"id\":25,\"realPersons\":100,\"address\":\"北京市朝阳区那旮沓胡同\",\"videoId\":11,\"sceneIds\":[17,18,19],\"currentPage\":1,\"pageSize\":10,\"updateTime\":\"Nov 15, 2019 5:59:11 PM\"}', '2019-11-15 17:59:11', '2019-11-15 17:59:11', '273');
INSERT INTO `user_operation_log` VALUES (1150601874915967931, '操作日志', '更新会议现场', NULL, 'com.ksh.heart.system.controller.meeting.MeetingDetailController', 'updateScene', '成功', '{\"id\":25,\"realPersons\":100,\"address\":\"北京市朝阳区那旮沓胡同\",\"videoId\":12,\"sceneIds\":[17,18,19],\"currentPage\":1,\"pageSize\":10,\"updateTime\":\"Nov 15, 2019 6:02:10 PM\"}', '2019-11-15 18:02:10', '2019-11-15 18:02:10', '7012');
INSERT INTO `user_operation_log` VALUES (1150601874915967932, '操作日志', '更新会议信息', NULL, 'com.ksh.heart.system.controller.meeting.MeetingDetailController', 'updateInfo', '成功', '{\"id\":25,\"laborCost\":100.01,\"activityCost\":100.22,\"meetingStatus\":\"01\",\"currentPage\":1,\"pageSize\":10,\"updateTime\":\"Nov 21, 2019 4:33:15 PM\"}', '2019-11-21 16:33:15', '2019-11-21 16:33:15', '606');
INSERT INTO `user_operation_log` VALUES (1150601874915967933, '操作日志', '新增会议', NULL, 'com.ksh.heart.system.controller.meeting.MeetingDetailController', 'add', '成功', '{\"id\":26,\"code\":\"M201911210001\",\"meetingTime\":\"2019-11-21\",\"meetingType\":1,\"hospitalId\":1,\"speakersId\":1,\"applicantId\":2,\"applicantTime\":\"Nov 21, 2019 4:58:27 PM\",\"laborCost\":20.22,\"activityCost\":100.22,\"prePersons\":20,\"source\":\"小程序\",\"meetingStatus\":\"01\",\"topicId\":90,\"delFlag\":1,\"currentPage\":1,\"pageSize\":10,\"createTime\":\"Nov 21, 2019 4:58:45 PM\",\"updateTime\":\"Nov 21, 2019 4:58:45 PM\"}', '2019-11-21 16:58:45', '2019-11-21 16:58:45', '21358');
INSERT INTO `user_operation_log` VALUES (1150601874915967934, '操作日志', '新增会议', NULL, 'com.ksh.heart.system.controller.meeting.MeetingDetailController', 'add', '成功', '{\"id\":27,\"code\":\"M201911210002\",\"meetingTime\":\"2019-11-21\",\"meetingType\":1,\"hospitalId\":1,\"speakersId\":1,\"applicantId\":2,\"applicantTime\":\"Nov 21, 2019 4:59:34 PM\",\"laborCost\":20.22,\"activityCost\":100.22,\"prePersons\":20,\"source\":\"小程序\",\"meetingStatus\":\"01\",\"topicId\":90,\"delFlag\":1,\"currentPage\":1,\"pageSize\":10,\"createTime\":\"Nov 21, 2019 5:00:06 PM\",\"updateTime\":\"Nov 21, 2019 5:00:06 PM\"}', '2019-11-21 17:00:07', '2019-11-21 17:00:07', '34988');
INSERT INTO `user_operation_log` VALUES (1150601874915967935, '操作日志', '新增会议', NULL, 'com.ksh.heart.system.controller.meeting.MeetingDetailController', 'add', '成功', '{\"id\":28,\"code\":\"M201911210003\",\"meetingTime\":\"2019-11-21\",\"meetingType\":1,\"hospitalId\":1,\"speakersId\":1,\"applicantId\":2,\"applicantTime\":\"Nov 21, 2019 5:00:36 PM\",\"laborCost\":20.22,\"activityCost\":100.22,\"prePersons\":20,\"source\":\"小程序\",\"meetingStatus\":\"01\",\"topicId\":90,\"delFlag\":1,\"currentPage\":1,\"pageSize\":10,\"createTime\":\"Nov 21, 2019 5:00:44 PM\",\"updateTime\":\"Nov 21, 2019 5:00:44 PM\"}', '2019-11-21 17:00:45', '2019-11-21 17:00:45', '10823');
INSERT INTO `user_operation_log` VALUES (1150601874915967936, '操作日志', '新增会议', NULL, 'com.ksh.heart.system.controller.meeting.MeetingDetailController', 'add', '成功', '{\"id\":29,\"code\":\"M201911210004\",\"meetingTime\":\"2019-11-21\",\"meetingType\":1,\"hospitalId\":1,\"speakersId\":1,\"applicantId\":1,\"applicantTime\":\"Nov 21, 2019 5:05:33 PM\",\"laborCost\":20.22,\"activityCost\":100.22,\"prePersons\":20,\"source\":\"小程序\",\"meetingStatus\":\"01\",\"topicId\":90,\"delFlag\":1,\"currentPage\":1,\"pageSize\":10,\"createTime\":\"Nov 21, 2019 5:05:33 PM\",\"updateTime\":\"Nov 21, 2019 5:05:33 PM\"}', '2019-11-21 17:05:34', '2019-11-21 17:05:34', '154');
INSERT INTO `user_operation_log` VALUES (1150601874915967937, '操作日志', '新增会议', NULL, 'com.ksh.heart.system.controller.meeting.MeetingDetailController', 'add', '成功', '{\"id\":30,\"code\":\"M201911210005\",\"meetingTime\":\"2019-11-21\",\"meetingType\":1,\"hospitalId\":1,\"speakersId\":1,\"applicantId\":2,\"applicantTime\":\"Nov 21, 2019 5:06:19 PM\",\"laborCost\":20.22,\"activityCost\":100.22,\"prePersons\":20,\"source\":\"小程序\",\"meetingStatus\":\"01\",\"topicId\":90,\"delFlag\":1,\"currentPage\":1,\"pageSize\":10,\"createTime\":\"Nov 21, 2019 5:06:19 PM\",\"updateTime\":\"Nov 21, 2019 5:06:19 PM\"}', '2019-11-21 17:06:20', '2019-11-21 17:06:20', '91');

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role`  (
  `id` bigint(32) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '角色名称',
  `level` int(4) NULL DEFAULT NULL COMMENT '级别',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `level_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '级别名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES (1, '管理者', 1, '2019-08-05 14:58:58', '2019-08-05 14:59:02', '一级');
INSERT INTO `user_role` VALUES (2, '大区经理', 2, '2019-08-05 14:59:25', '2019-08-05 14:59:27', '二级');

-- ----------------------------
-- Function structure for get_hospital_num
-- ----------------------------
DROP FUNCTION IF EXISTS `get_hospital_num`;
delimiter ;;
CREATE FUNCTION `get_hospital_num`()
 RETURNS varchar(16) CHARSET utf8mb4
  READS SQL DATA 
BEGIN
	DECLARE getval VARCHAR(16);
	SET getval = (SELECT CONCAT('H',DATE_FORMAT(NOW(),'%Y%m%d'),LPAD((SELECT next_sequence_num('hospital_no')),4,'0')));
RETURN getval;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for get_meeting_num
-- ----------------------------
DROP FUNCTION IF EXISTS `get_meeting_num`;
delimiter ;;
CREATE FUNCTION `get_meeting_num`()
 RETURNS varchar(16) CHARSET utf8mb4
  READS SQL DATA 
BEGIN
	DECLARE getval VARCHAR(16);
	SET getval = (SELECT CONCAT('M',DATE_FORMAT(NOW(),'%Y%m%d'),LPAD((SELECT next_sequence_num('meeting_no')),4,'0')));
RETURN getval;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for next_sequence_num
-- ----------------------------
DROP FUNCTION IF EXISTS `next_sequence_num`;
delimiter ;;
CREATE FUNCTION `next_sequence_num`(`seq_name` varchar(32))
 RETURNS int(8)
  READS SQL DATA 
BEGIN
 UPDATE sys_sequence SET value=last_insert_id(value+next) WHERE name=seq_name;
 RETURN last_insert_id();
END
;;
delimiter ;

-- ----------------------------
-- Event structure for hospital_no
-- ----------------------------
DROP EVENT IF EXISTS `hospital_no`;
delimiter ;;
CREATE EVENT `hospital_no`
ON SCHEDULE
EVERY '1' DAY STARTS '2019-10-30 00:00:00'
DO UPDATE sys_sequence SET value=0 WHERE name='hospital_no'
;;
delimiter ;

-- ----------------------------
-- Event structure for meeting_no
-- ----------------------------
DROP EVENT IF EXISTS `meeting_no`;
delimiter ;;
CREATE EVENT `meeting_no`
ON SCHEDULE
EVERY '1' DAY STARTS '2019-10-30 00:00:00'
DO UPDATE sys_sequence SET value=0 WHERE name='meeting_no'
;;
delimiter ;

-- ----------------------------
-- Event structure for meeting_status
-- ----------------------------
DROP EVENT IF EXISTS `meeting_status`;
delimiter ;;
CREATE EVENT `meeting_status`
ON SCHEDULE
EVERY '1' DAY STARTS '2019-11-15 00:00:00'
DO update meeting_detail set meeting_status =
case when STR_TO_DATE(meeting_time,'%Y-%m-%d') = CURDATE() then '04' 
when STR_TO_DATE(meeting_time,'%Y-%m-%d') < CURDATE() then '05' end
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
