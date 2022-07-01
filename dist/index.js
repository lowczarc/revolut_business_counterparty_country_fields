"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const company_1 = __importDefault(require("./company"));
const individual_1 = __importDefault(require("./individual"));
const CompanyCoutryFields = company_1.default;
const IndividualCountryFields = individual_1.default;
exports.default = {
    company: CompanyCoutryFields,
    individual: IndividualCountryFields,
};
