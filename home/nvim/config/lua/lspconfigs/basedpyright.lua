-- basedpyright defaults to typeCheckingMode = "recommended", which turns
-- every optional rule into an error. "standard" is pyright's own default:
-- it still catches wrong types, bad attrs and None-deref, without demanding
-- a fully annotated codebase. A project's pyproject.toml wins over this.

return {
    normal = {
        analysis = {
            typeCheckingMode = "standard",
            diagnosticMode = "workspace",
            diagnosticSeverityOverrides = {
                reportImplicitAbstractClass = "error",
                reportUnusedImport = "none",
                reportUnusedVariable = "none",
                reportMissingTypeStubs = "none",
                reportUnknownMemberType = "none",
                reportUnknownArgumentType = "none",
                reportUnknownVariableType = "none",
                reportAny = "none",
                reportExplicitAny = "none",
                reportUnusedCallResult = "none",
                reportImplicitOverride = "none",
                reportUnannotatedClassAttribute = "none",
            },
        },
    },

    strict = {
        analysis = {
            typeCheckingMode = "strict",
            diagnosticMode = "workspace",
            diagnosticSeverityOverrides = {
                reportImplicitAbstractClass = "error",
                reportUnusedImport = "none",
                reportUnusedVariable = "none",
                reportMissingTypeStubs = "error",
                reportUnknownMemberType = "error",
                reportUnknownArgumentType = "error",
                reportUnknownVariableType = "error",
                reportAny = "warning",
                reportExplicitAny = "warning",
                reportUnusedCallResult = "warning",
                reportImplicitOverride = "warning",
                reportUnannotatedClassAttribute = "warning",
            },
        },
    },
}
