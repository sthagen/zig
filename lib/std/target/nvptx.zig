const std = @import("../std.zig");
const Cpu = std.Target.Cpu;

pub const Feature = enum {
    ptx32,
    ptx40,
    ptx41,
    ptx42,
    ptx43,
    ptx50,
    ptx60,
    ptx61,
    ptx63,
    ptx64,
    sm_20,
    sm_21,
    sm_30,
    sm_32,
    sm_35,
    sm_37,
    sm_50,
    sm_52,
    sm_53,
    sm_60,
    sm_61,
    sm_62,
    sm_70,
    sm_72,
    sm_75,
};

pub usingnamespace Cpu.Feature.feature_set_fns(Feature);

pub const all_features = blk: {
    const len = @typeInfo(Feature).Enum.fields.len;
    std.debug.assert(len <= Cpu.Feature.Set.needed_bit_count);
    var result: [len]Cpu.Feature = undefined;
    result[@enumToInt(Feature.ptx32)] = .{
        .llvm_name = "ptx32",
        .description = "Use PTX version 3.2",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.ptx40)] = .{
        .llvm_name = "ptx40",
        .description = "Use PTX version 4.0",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.ptx41)] = .{
        .llvm_name = "ptx41",
        .description = "Use PTX version 4.1",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.ptx42)] = .{
        .llvm_name = "ptx42",
        .description = "Use PTX version 4.2",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.ptx43)] = .{
        .llvm_name = "ptx43",
        .description = "Use PTX version 4.3",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.ptx50)] = .{
        .llvm_name = "ptx50",
        .description = "Use PTX version 5.0",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.ptx60)] = .{
        .llvm_name = "ptx60",
        .description = "Use PTX version 6.0",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.ptx61)] = .{
        .llvm_name = "ptx61",
        .description = "Use PTX version 6.1",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.ptx63)] = .{
        .llvm_name = "ptx63",
        .description = "Use PTX version 6.3",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.ptx64)] = .{
        .llvm_name = "ptx64",
        .description = "Use PTX version 6.4",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.sm_20)] = .{
        .llvm_name = "sm_20",
        .description = "Target SM 2.0",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.sm_21)] = .{
        .llvm_name = "sm_21",
        .description = "Target SM 2.1",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.sm_30)] = .{
        .llvm_name = "sm_30",
        .description = "Target SM 3.0",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.sm_32)] = .{
        .llvm_name = "sm_32",
        .description = "Target SM 3.2",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.sm_35)] = .{
        .llvm_name = "sm_35",
        .description = "Target SM 3.5",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.sm_37)] = .{
        .llvm_name = "sm_37",
        .description = "Target SM 3.7",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.sm_50)] = .{
        .llvm_name = "sm_50",
        .description = "Target SM 5.0",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.sm_52)] = .{
        .llvm_name = "sm_52",
        .description = "Target SM 5.2",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.sm_53)] = .{
        .llvm_name = "sm_53",
        .description = "Target SM 5.3",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.sm_60)] = .{
        .llvm_name = "sm_60",
        .description = "Target SM 6.0",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.sm_61)] = .{
        .llvm_name = "sm_61",
        .description = "Target SM 6.1",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.sm_62)] = .{
        .llvm_name = "sm_62",
        .description = "Target SM 6.2",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.sm_70)] = .{
        .llvm_name = "sm_70",
        .description = "Target SM 7.0",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.sm_72)] = .{
        .llvm_name = "sm_72",
        .description = "Target SM 7.2",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.sm_75)] = .{
        .llvm_name = "sm_75",
        .description = "Target SM 7.5",
        .dependencies = featureSet(&[_]Feature{}),
    };
    const ti = @typeInfo(Feature);
    for (result) |*elem, i| {
        elem.index = i;
        elem.name = ti.Enum.fields[i].name;
    }
    break :blk result;
};

pub const cpu = struct {
    pub const sm_20 = Cpu{
        .name = "sm_20",
        .llvm_name = "sm_20",
        .features = featureSet(&[_]Feature{
            .sm_20,
        }),
    };
    pub const sm_21 = Cpu{
        .name = "sm_21",
        .llvm_name = "sm_21",
        .features = featureSet(&[_]Feature{
            .sm_21,
        }),
    };
    pub const sm_30 = Cpu{
        .name = "sm_30",
        .llvm_name = "sm_30",
        .features = featureSet(&[_]Feature{
            .sm_30,
        }),
    };
    pub const sm_32 = Cpu{
        .name = "sm_32",
        .llvm_name = "sm_32",
        .features = featureSet(&[_]Feature{
            .ptx40,
            .sm_32,
        }),
    };
    pub const sm_35 = Cpu{
        .name = "sm_35",
        .llvm_name = "sm_35",
        .features = featureSet(&[_]Feature{
            .sm_35,
        }),
    };
    pub const sm_37 = Cpu{
        .name = "sm_37",
        .llvm_name = "sm_37",
        .features = featureSet(&[_]Feature{
            .ptx41,
            .sm_37,
        }),
    };
    pub const sm_50 = Cpu{
        .name = "sm_50",
        .llvm_name = "sm_50",
        .features = featureSet(&[_]Feature{
            .ptx40,
            .sm_50,
        }),
    };
    pub const sm_52 = Cpu{
        .name = "sm_52",
        .llvm_name = "sm_52",
        .features = featureSet(&[_]Feature{
            .ptx41,
            .sm_52,
        }),
    };
    pub const sm_53 = Cpu{
        .name = "sm_53",
        .llvm_name = "sm_53",
        .features = featureSet(&[_]Feature{
            .ptx42,
            .sm_53,
        }),
    };
    pub const sm_60 = Cpu{
        .name = "sm_60",
        .llvm_name = "sm_60",
        .features = featureSet(&[_]Feature{
            .ptx50,
            .sm_60,
        }),
    };
    pub const sm_61 = Cpu{
        .name = "sm_61",
        .llvm_name = "sm_61",
        .features = featureSet(&[_]Feature{
            .ptx50,
            .sm_61,
        }),
    };
    pub const sm_62 = Cpu{
        .name = "sm_62",
        .llvm_name = "sm_62",
        .features = featureSet(&[_]Feature{
            .ptx50,
            .sm_62,
        }),
    };
    pub const sm_70 = Cpu{
        .name = "sm_70",
        .llvm_name = "sm_70",
        .features = featureSet(&[_]Feature{
            .ptx60,
            .sm_70,
        }),
    };
    pub const sm_72 = Cpu{
        .name = "sm_72",
        .llvm_name = "sm_72",
        .features = featureSet(&[_]Feature{
            .ptx61,
            .sm_72,
        }),
    };
    pub const sm_75 = Cpu{
        .name = "sm_75",
        .llvm_name = "sm_75",
        .features = featureSet(&[_]Feature{
            .ptx63,
            .sm_75,
        }),
    };
};

/// All nvptx CPUs, sorted alphabetically by name.
/// TODO: Replace this with usage of `std.meta.declList`. It does work, but stage1
/// compiler has inefficient memory and CPU usage, affecting build times.
pub const all_cpus = &[_]*const Cpu{
    &cpu.sm_20,
    &cpu.sm_21,
    &cpu.sm_30,
    &cpu.sm_32,
    &cpu.sm_35,
    &cpu.sm_37,
    &cpu.sm_50,
    &cpu.sm_52,
    &cpu.sm_53,
    &cpu.sm_60,
    &cpu.sm_61,
    &cpu.sm_62,
    &cpu.sm_70,
    &cpu.sm_72,
    &cpu.sm_75,
};
