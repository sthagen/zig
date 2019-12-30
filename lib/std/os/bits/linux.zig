const builtin = @import("builtin");
const std = @import("../../std.zig");
const maxInt = std.math.maxInt;
usingnamespace @import("../bits.zig");

pub usingnamespace switch (builtin.arch) {
    .mips, .mipsel => @import("linux/errno-mips.zig"),
    else => @import("linux/errno-generic.zig"),
};

pub usingnamespace switch (builtin.arch) {
    .i386 => @import("linux/i386.zig"),
    .x86_64 => @import("linux/x86_64.zig"),
    .aarch64 => @import("linux/arm64.zig"),
    .arm => @import("linux/arm-eabi.zig"),
    .riscv64 => @import("linux/riscv64.zig"),
    .mipsel => @import("linux/mipsel.zig"),
    else => struct {},
};

const is_mips = builtin.arch == .mipsel;

pub const pid_t = i32;
pub const fd_t = i32;
pub const uid_t = i32;
pub const gid_t = u32;
pub const clock_t = isize;

pub const PATH_MAX = 4096;
pub const IOV_MAX = 1024;

pub const STDIN_FILENO = 0;
pub const STDOUT_FILENO = 1;
pub const STDERR_FILENO = 2;

/// Special value used to indicate openat should use the current working directory
pub const AT_FDCWD = -100;

/// Do not follow symbolic links
pub const AT_SYMLINK_NOFOLLOW = 0x100;

/// Remove directory instead of unlinking file
pub const AT_REMOVEDIR = 0x200;

/// Follow symbolic links.
pub const AT_SYMLINK_FOLLOW = 0x400;

/// Suppress terminal automount traversal
pub const AT_NO_AUTOMOUNT = 0x800;

/// Allow empty relative pathname
pub const AT_EMPTY_PATH = 0x1000;

/// Type of synchronisation required from statx()
pub const AT_STATX_SYNC_TYPE = 0x6000;

/// - Do whatever stat() does
pub const AT_STATX_SYNC_AS_STAT = 0x0000;

/// - Force the attributes to be sync'd with the server
pub const AT_STATX_FORCE_SYNC = 0x2000;

/// - Don't sync attributes with the server
pub const AT_STATX_DONT_SYNC = 0x4000;

/// Apply to the entire subtree
pub const AT_RECURSIVE = 0x8000;

pub const FUTEX_WAIT = 0;
pub const FUTEX_WAKE = 1;
pub const FUTEX_FD = 2;
pub const FUTEX_REQUEUE = 3;
pub const FUTEX_CMP_REQUEUE = 4;
pub const FUTEX_WAKE_OP = 5;
pub const FUTEX_LOCK_PI = 6;
pub const FUTEX_UNLOCK_PI = 7;
pub const FUTEX_TRYLOCK_PI = 8;
pub const FUTEX_WAIT_BITSET = 9;

pub const FUTEX_PRIVATE_FLAG = 128;

pub const FUTEX_CLOCK_REALTIME = 256;

pub const PROT_NONE = 0;
pub const PROT_READ = 1;
pub const PROT_WRITE = 2;
pub const PROT_EXEC = 4;
pub const PROT_GROWSDOWN = 0x01000000;
pub const PROT_GROWSUP = 0x02000000;

/// Share changes
pub const MAP_SHARED = 0x01;

/// Changes are private
pub const MAP_PRIVATE = 0x02;

/// share + validate extension flags
pub const MAP_SHARED_VALIDATE = 0x03;

/// Mask for type of mapping
pub const MAP_TYPE = 0x0f;

/// Interpret addr exactly
pub const MAP_FIXED = 0x10;

/// don't use a file
pub const MAP_ANONYMOUS = if (is_mips) 0x800 else 0x20;

// MAP_ 0x0100 - 0x4000 flags are per architecture

/// populate (prefault) pagetables
pub const MAP_POPULATE = if (is_mips) 0x10000 else 0x8000;

/// do not block on IO
pub const MAP_NONBLOCK = if (is_mips) 0x20000 else 0x10000;

/// give out an address that is best suited for process/thread stacks
pub const MAP_STACK = if (is_mips) 0x40000 else 0x20000;

/// create a huge page mapping
pub const MAP_HUGETLB = if (is_mips) 0x80000 else 0x40000;

/// perform synchronous page faults for the mapping
pub const MAP_SYNC = 0x80000;

/// MAP_FIXED which doesn't unmap underlying mapping
pub const MAP_FIXED_NOREPLACE = 0x100000;

/// For anonymous mmap, memory could be uninitialized
pub const MAP_UNINITIALIZED = 0x4000000;

pub const F_OK = 0;
pub const X_OK = 1;
pub const W_OK = 2;
pub const R_OK = 4;

pub const WNOHANG = 1;
pub const WUNTRACED = 2;
pub const WSTOPPED = 2;
pub const WEXITED = 4;
pub const WCONTINUED = 8;
pub const WNOWAIT = 0x1000000;

pub usingnamespace if (is_mips)
    struct {
        pub const SA_NOCLDSTOP = 1;
        pub const SA_NOCLDWAIT = 0x10000;
        pub const SA_SIGINFO = 8;

        pub const SIG_BLOCK = 1;
        pub const SIG_UNBLOCK = 2;
        pub const SIG_SETMASK = 3;
    }
else
    struct {
        pub const SA_NOCLDSTOP = 1;
        pub const SA_NOCLDWAIT = 2;
        pub const SA_SIGINFO = 4;

        pub const SIG_BLOCK = 0;
        pub const SIG_UNBLOCK = 1;
        pub const SIG_SETMASK = 2;
    };

pub const SA_ONSTACK = 0x08000000;
pub const SA_RESTART = 0x10000000;
pub const SA_NODEFER = 0x40000000;
pub const SA_RESETHAND = 0x80000000;
pub const SA_RESTORER = 0x04000000;

pub const SIGHUP = 1;
pub const SIGINT = 2;
pub const SIGQUIT = 3;
pub const SIGILL = 4;
pub const SIGTRAP = 5;
pub const SIGABRT = 6;
pub const SIGIOT = SIGABRT;
pub const SIGBUS = 7;
pub const SIGFPE = 8;
pub const SIGKILL = 9;
pub const SIGUSR1 = 10;
pub const SIGSEGV = 11;
pub const SIGUSR2 = 12;
pub const SIGPIPE = 13;
pub const SIGALRM = 14;
pub const SIGTERM = 15;
pub const SIGSTKFLT = 16;
pub const SIGCHLD = 17;
pub const SIGCONT = 18;
pub const SIGSTOP = 19;
pub const SIGTSTP = 20;
pub const SIGTTIN = 21;
pub const SIGTTOU = 22;
pub const SIGURG = 23;
pub const SIGXCPU = 24;
pub const SIGXFSZ = 25;
pub const SIGVTALRM = 26;
pub const SIGPROF = 27;
pub const SIGWINCH = 28;
pub const SIGIO = 29;
pub const SIGPOLL = 29;
pub const SIGPWR = 30;
pub const SIGSYS = 31;
pub const SIGUNUSED = SIGSYS;

pub const O_RDONLY = 0o0;
pub const O_WRONLY = 0o1;
pub const O_RDWR = 0o2;

pub const kernel_rwf = u32;

/// high priority request, poll if possible
pub const RWF_HIPRI = kernel_rwf(0x00000001);

/// per-IO O_DSYNC
pub const RWF_DSYNC = kernel_rwf(0x00000002);

/// per-IO O_SYNC
pub const RWF_SYNC = kernel_rwf(0x00000004);

/// per-IO, return -EAGAIN if operation would block
pub const RWF_NOWAIT = kernel_rwf(0x00000008);

/// per-IO O_APPEND
pub const RWF_APPEND = kernel_rwf(0x00000010);

pub const SEEK_SET = 0;
pub const SEEK_CUR = 1;
pub const SEEK_END = 2;

pub const SHUT_RD = 0;
pub const SHUT_WR = 1;
pub const SHUT_RDWR = 2;

pub const SOCK_STREAM = if (is_mips) 2 else 1;
pub const SOCK_DGRAM = if (is_mips) 1 else 2;
pub const SOCK_RAW = 3;
pub const SOCK_RDM = 4;
pub const SOCK_SEQPACKET = 5;
pub const SOCK_DCCP = 6;
pub const SOCK_PACKET = 10;
pub const SOCK_CLOEXEC = 0o2000000;
pub const SOCK_NONBLOCK = if (is_mips) 0o200 else 0o4000;

pub const PF_UNSPEC = 0;
pub const PF_LOCAL = 1;
pub const PF_UNIX = PF_LOCAL;
pub const PF_FILE = PF_LOCAL;
pub const PF_INET = 2;
pub const PF_AX25 = 3;
pub const PF_IPX = 4;
pub const PF_APPLETALK = 5;
pub const PF_NETROM = 6;
pub const PF_BRIDGE = 7;
pub const PF_ATMPVC = 8;
pub const PF_X25 = 9;
pub const PF_INET6 = 10;
pub const PF_ROSE = 11;
pub const PF_DECnet = 12;
pub const PF_NETBEUI = 13;
pub const PF_SECURITY = 14;
pub const PF_KEY = 15;
pub const PF_NETLINK = 16;
pub const PF_ROUTE = PF_NETLINK;
pub const PF_PACKET = 17;
pub const PF_ASH = 18;
pub const PF_ECONET = 19;
pub const PF_ATMSVC = 20;
pub const PF_RDS = 21;
pub const PF_SNA = 22;
pub const PF_IRDA = 23;
pub const PF_PPPOX = 24;
pub const PF_WANPIPE = 25;
pub const PF_LLC = 26;
pub const PF_IB = 27;
pub const PF_MPLS = 28;
pub const PF_CAN = 29;
pub const PF_TIPC = 30;
pub const PF_BLUETOOTH = 31;
pub const PF_IUCV = 32;
pub const PF_RXRPC = 33;
pub const PF_ISDN = 34;
pub const PF_PHONET = 35;
pub const PF_IEEE802154 = 36;
pub const PF_CAIF = 37;
pub const PF_ALG = 38;
pub const PF_NFC = 39;
pub const PF_VSOCK = 40;
pub const PF_KCM = 41;
pub const PF_QIPCRTR = 42;
pub const PF_SMC = 43;
pub const PF_MAX = 44;

pub const AF_UNSPEC = PF_UNSPEC;
pub const AF_LOCAL = PF_LOCAL;
pub const AF_UNIX = AF_LOCAL;
pub const AF_FILE = AF_LOCAL;
pub const AF_INET = PF_INET;
pub const AF_AX25 = PF_AX25;
pub const AF_IPX = PF_IPX;
pub const AF_APPLETALK = PF_APPLETALK;
pub const AF_NETROM = PF_NETROM;
pub const AF_BRIDGE = PF_BRIDGE;
pub const AF_ATMPVC = PF_ATMPVC;
pub const AF_X25 = PF_X25;
pub const AF_INET6 = PF_INET6;
pub const AF_ROSE = PF_ROSE;
pub const AF_DECnet = PF_DECnet;
pub const AF_NETBEUI = PF_NETBEUI;
pub const AF_SECURITY = PF_SECURITY;
pub const AF_KEY = PF_KEY;
pub const AF_NETLINK = PF_NETLINK;
pub const AF_ROUTE = PF_ROUTE;
pub const AF_PACKET = PF_PACKET;
pub const AF_ASH = PF_ASH;
pub const AF_ECONET = PF_ECONET;
pub const AF_ATMSVC = PF_ATMSVC;
pub const AF_RDS = PF_RDS;
pub const AF_SNA = PF_SNA;
pub const AF_IRDA = PF_IRDA;
pub const AF_PPPOX = PF_PPPOX;
pub const AF_WANPIPE = PF_WANPIPE;
pub const AF_LLC = PF_LLC;
pub const AF_IB = PF_IB;
pub const AF_MPLS = PF_MPLS;
pub const AF_CAN = PF_CAN;
pub const AF_TIPC = PF_TIPC;
pub const AF_BLUETOOTH = PF_BLUETOOTH;
pub const AF_IUCV = PF_IUCV;
pub const AF_RXRPC = PF_RXRPC;
pub const AF_ISDN = PF_ISDN;
pub const AF_PHONET = PF_PHONET;
pub const AF_IEEE802154 = PF_IEEE802154;
pub const AF_CAIF = PF_CAIF;
pub const AF_ALG = PF_ALG;
pub const AF_NFC = PF_NFC;
pub const AF_VSOCK = PF_VSOCK;
pub const AF_KCM = PF_KCM;
pub const AF_QIPCRTR = PF_QIPCRTR;
pub const AF_SMC = PF_SMC;
pub const AF_MAX = PF_MAX;

pub usingnamespace if (!is_mips)
    struct {
        pub const SO_DEBUG = 1;
        pub const SO_REUSEADDR = 2;
        pub const SO_TYPE = 3;
        pub const SO_ERROR = 4;
        pub const SO_DONTROUTE = 5;
        pub const SO_BROADCAST = 6;
        pub const SO_SNDBUF = 7;
        pub const SO_RCVBUF = 8;
        pub const SO_KEEPALIVE = 9;
        pub const SO_OOBINLINE = 10;
        pub const SO_NO_CHECK = 11;
        pub const SO_PRIORITY = 12;
        pub const SO_LINGER = 13;
        pub const SO_BSDCOMPAT = 14;
        pub const SO_REUSEPORT = 15;
        pub const SO_PASSCRED = 16;
        pub const SO_PEERCRED = 17;
        pub const SO_RCVLOWAT = 18;
        pub const SO_SNDLOWAT = 19;
        pub const SO_RCVTIMEO = 20;
        pub const SO_SNDTIMEO = 21;
        pub const SO_ACCEPTCONN = 30;
        pub const SO_PEERSEC = 31;
        pub const SO_SNDBUFFORCE = 32;
        pub const SO_RCVBUFFORCE = 33;
        pub const SO_PROTOCOL = 38;
        pub const SO_DOMAIN = 39;
    }
else
    struct {};

pub const SO_SECURITY_AUTHENTICATION = 22;
pub const SO_SECURITY_ENCRYPTION_TRANSPORT = 23;
pub const SO_SECURITY_ENCRYPTION_NETWORK = 24;

pub const SO_BINDTODEVICE = 25;

pub const SO_ATTACH_FILTER = 26;
pub const SO_DETACH_FILTER = 27;
pub const SO_GET_FILTER = SO_ATTACH_FILTER;

pub const SO_PEERNAME = 28;
pub const SO_TIMESTAMP_OLD = 29;
pub const SO_PASSSEC = 34;
pub const SO_TIMESTAMPNS_OLD = 35;
pub const SO_MARK = 36;
pub const SO_TIMESTAMPING_OLD = 37;

pub const SO_RXQ_OVFL = 40;
pub const SO_WIFI_STATUS = 41;
pub const SCM_WIFI_STATUS = SO_WIFI_STATUS;
pub const SO_PEEK_OFF = 42;
pub const SO_NOFCS = 43;
pub const SO_LOCK_FILTER = 44;
pub const SO_SELECT_ERR_QUEUE = 45;
pub const SO_BUSY_POLL = 46;
pub const SO_MAX_PACING_RATE = 47;
pub const SO_BPF_EXTENSIONS = 48;
pub const SO_INCOMING_CPU = 49;
pub const SO_ATTACH_BPF = 50;
pub const SO_DETACH_BPF = SO_DETACH_FILTER;
pub const SO_ATTACH_REUSEPORT_CBPF = 51;
pub const SO_ATTACH_REUSEPORT_EBPF = 52;
pub const SO_CNX_ADVICE = 53;
pub const SCM_TIMESTAMPING_OPT_STATS = 54;
pub const SO_MEMINFO = 55;
pub const SO_INCOMING_NAPI_ID = 56;
pub const SO_COOKIE = 57;
pub const SCM_TIMESTAMPING_PKTINFO = 58;
pub const SO_PEERGROUPS = 59;
pub const SO_ZEROCOPY = 60;
pub const SO_TXTIME = 61;
pub const SCM_TXTIME = SO_TXTIME;
pub const SO_BINDTOIFINDEX = 62;
pub const SO_TIMESTAMP_NEW = 63;
pub const SO_TIMESTAMPNS_NEW = 64;
pub const SO_TIMESTAMPING_NEW = 65;
pub const SO_RCVTIMEO_NEW = 66;
pub const SO_SNDTIMEO_NEW = 67;
pub const SO_DETACH_REUSEPORT_BPF = 68;

pub const SOL_SOCKET = if (is_mips) 65535 else 1;

pub const SOL_IP = 0;
pub const SOL_IPV6 = 41;
pub const SOL_ICMPV6 = 58;

pub const SOL_RAW = 255;
pub const SOL_DECNET = 261;
pub const SOL_X25 = 262;
pub const SOL_PACKET = 263;
pub const SOL_ATM = 264;
pub const SOL_AAL = 265;
pub const SOL_IRDA = 266;
pub const SOL_NETBEUI = 267;
pub const SOL_LLC = 268;
pub const SOL_DCCP = 269;
pub const SOL_NETLINK = 270;
pub const SOL_TIPC = 271;
pub const SOL_RXRPC = 272;
pub const SOL_PPPOL2TP = 273;
pub const SOL_BLUETOOTH = 274;
pub const SOL_PNPIPE = 275;
pub const SOL_RDS = 276;
pub const SOL_IUCV = 277;
pub const SOL_CAIF = 278;
pub const SOL_ALG = 279;
pub const SOL_NFC = 280;
pub const SOL_KCM = 281;
pub const SOL_TLS = 282;

pub const SOMAXCONN = 128;

pub const MSG_OOB = 0x0001;
pub const MSG_PEEK = 0x0002;
pub const MSG_DONTROUTE = 0x0004;
pub const MSG_CTRUNC = 0x0008;
pub const MSG_PROXY = 0x0010;
pub const MSG_TRUNC = 0x0020;
pub const MSG_DONTWAIT = 0x0040;
pub const MSG_EOR = 0x0080;
pub const MSG_WAITALL = 0x0100;
pub const MSG_FIN = 0x0200;
pub const MSG_SYN = 0x0400;
pub const MSG_CONFIRM = 0x0800;
pub const MSG_RST = 0x1000;
pub const MSG_ERRQUEUE = 0x2000;
pub const MSG_NOSIGNAL = 0x4000;
pub const MSG_MORE = 0x8000;
pub const MSG_WAITFORONE = 0x10000;
pub const MSG_BATCH = 0x40000;
pub const MSG_ZEROCOPY = 0x4000000;
pub const MSG_FASTOPEN = 0x20000000;
pub const MSG_CMSG_CLOEXEC = 0x40000000;

pub const DT_UNKNOWN = 0;
pub const DT_FIFO = 1;
pub const DT_CHR = 2;
pub const DT_DIR = 4;
pub const DT_BLK = 6;
pub const DT_REG = 8;
pub const DT_LNK = 10;
pub const DT_SOCK = 12;
pub const DT_WHT = 14;

pub const TCGETS = if (is_mips) 0x540D else 0x5401;
pub const TCSETS = 0x5402;
pub const TCSETSW = 0x5403;
pub const TCSETSF = 0x5404;
pub const TCGETA = 0x5405;
pub const TCSETA = 0x5406;
pub const TCSETAW = 0x5407;
pub const TCSETAF = 0x5408;
pub const TCSBRK = 0x5409;
pub const TCXONC = 0x540A;
pub const TCFLSH = 0x540B;
pub const TIOCEXCL = 0x540C;
pub const TIOCNXCL = 0x540D;
pub const TIOCSCTTY = 0x540E;
pub const TIOCGPGRP = 0x540F;
pub const TIOCSPGRP = 0x5410;
pub const TIOCOUTQ = if (is_mips) 0x7472 else 0x5411;
pub const TIOCSTI = 0x5412;
pub const TIOCGWINSZ = if (is_mips) 0x40087468 else 0x5413;
pub const TIOCSWINSZ = if (is_mips) 0x80087467 else 0x5414;
pub const TIOCMGET = 0x5415;
pub const TIOCMBIS = 0x5416;
pub const TIOCMBIC = 0x5417;
pub const TIOCMSET = 0x5418;
pub const TIOCGSOFTCAR = 0x5419;
pub const TIOCSSOFTCAR = 0x541A;
pub const FIONREAD = if (is_mips) 0x467F else 0x541B;
pub const TIOCINQ = FIONREAD;
pub const TIOCLINUX = 0x541C;
pub const TIOCCONS = 0x541D;
pub const TIOCGSERIAL = 0x541E;
pub const TIOCSSERIAL = 0x541F;
pub const TIOCPKT = 0x5420;
pub const FIONBIO = 0x5421;
pub const TIOCNOTTY = 0x5422;
pub const TIOCSETD = 0x5423;
pub const TIOCGETD = 0x5424;
pub const TCSBRKP = 0x5425;
pub const TIOCSBRK = 0x5427;
pub const TIOCCBRK = 0x5428;
pub const TIOCGSID = 0x5429;
pub const TIOCGRS485 = 0x542E;
pub const TIOCSRS485 = 0x542F;
pub const TIOCGPTN = 0x80045430;
pub const TIOCSPTLCK = 0x40045431;
pub const TIOCGDEV = 0x80045432;
pub const TCGETX = 0x5432;
pub const TCSETX = 0x5433;
pub const TCSETXF = 0x5434;
pub const TCSETXW = 0x5435;
pub const TIOCSIG = 0x40045436;
pub const TIOCVHANGUP = 0x5437;
pub const TIOCGPKT = 0x80045438;
pub const TIOCGPTLCK = 0x80045439;
pub const TIOCGEXCL = 0x80045440;

pub const EPOLL_CLOEXEC = O_CLOEXEC;

pub const EPOLL_CTL_ADD = 1;
pub const EPOLL_CTL_DEL = 2;
pub const EPOLL_CTL_MOD = 3;

pub const EPOLLIN = 0x001;
pub const EPOLLPRI = 0x002;
pub const EPOLLOUT = 0x004;
pub const EPOLLRDNORM = 0x040;
pub const EPOLLRDBAND = 0x080;
pub const EPOLLWRNORM = if (is_mips) 0x004 else 0x100;
pub const EPOLLWRBAND = if (is_mips) 0x100 else 0x200;
pub const EPOLLMSG = 0x400;
pub const EPOLLERR = 0x008;
pub const EPOLLHUP = 0x010;
pub const EPOLLRDHUP = 0x2000;
pub const EPOLLEXCLUSIVE = (@as(u32, 1) << 28);
pub const EPOLLWAKEUP = (@as(u32, 1) << 29);
pub const EPOLLONESHOT = (@as(u32, 1) << 30);
pub const EPOLLET = (@as(u32, 1) << 31);

pub const CLOCK_REALTIME = 0;
pub const CLOCK_MONOTONIC = 1;
pub const CLOCK_PROCESS_CPUTIME_ID = 2;
pub const CLOCK_THREAD_CPUTIME_ID = 3;
pub const CLOCK_MONOTONIC_RAW = 4;
pub const CLOCK_REALTIME_COARSE = 5;
pub const CLOCK_MONOTONIC_COARSE = 6;
pub const CLOCK_BOOTTIME = 7;
pub const CLOCK_REALTIME_ALARM = 8;
pub const CLOCK_BOOTTIME_ALARM = 9;
pub const CLOCK_SGI_CYCLE = 10;
pub const CLOCK_TAI = 11;

pub const CSIGNAL = 0x000000ff;
pub const CLONE_VM = 0x00000100;
pub const CLONE_FS = 0x00000200;
pub const CLONE_FILES = 0x00000400;
pub const CLONE_SIGHAND = 0x00000800;
pub const CLONE_PTRACE = 0x00002000;
pub const CLONE_VFORK = 0x00004000;
pub const CLONE_PARENT = 0x00008000;
pub const CLONE_THREAD = 0x00010000;
pub const CLONE_NEWNS = 0x00020000;
pub const CLONE_SYSVSEM = 0x00040000;
pub const CLONE_SETTLS = 0x00080000;
pub const CLONE_PARENT_SETTID = 0x00100000;
pub const CLONE_CHILD_CLEARTID = 0x00200000;
pub const CLONE_DETACHED = 0x00400000;
pub const CLONE_UNTRACED = 0x00800000;
pub const CLONE_CHILD_SETTID = 0x01000000;
pub const CLONE_NEWCGROUP = 0x02000000;
pub const CLONE_NEWUTS = 0x04000000;
pub const CLONE_NEWIPC = 0x08000000;
pub const CLONE_NEWUSER = 0x10000000;
pub const CLONE_NEWPID = 0x20000000;
pub const CLONE_NEWNET = 0x40000000;
pub const CLONE_IO = 0x80000000;

pub const EFD_SEMAPHORE = 1;
pub const EFD_CLOEXEC = O_CLOEXEC;
pub const EFD_NONBLOCK = O_NONBLOCK;

pub const MS_RDONLY = 1;
pub const MS_NOSUID = 2;
pub const MS_NODEV = 4;
pub const MS_NOEXEC = 8;
pub const MS_SYNCHRONOUS = 16;
pub const MS_REMOUNT = 32;
pub const MS_MANDLOCK = 64;
pub const MS_DIRSYNC = 128;
pub const MS_NOATIME = 1024;
pub const MS_NODIRATIME = 2048;
pub const MS_BIND = 4096;
pub const MS_MOVE = 8192;
pub const MS_REC = 16384;
pub const MS_SILENT = 32768;
pub const MS_POSIXACL = (1 << 16);
pub const MS_UNBINDABLE = (1 << 17);
pub const MS_PRIVATE = (1 << 18);
pub const MS_SLAVE = (1 << 19);
pub const MS_SHARED = (1 << 20);
pub const MS_RELATIME = (1 << 21);
pub const MS_KERNMOUNT = (1 << 22);
pub const MS_I_VERSION = (1 << 23);
pub const MS_STRICTATIME = (1 << 24);
pub const MS_LAZYTIME = (1 << 25);
pub const MS_NOREMOTELOCK = (1 << 27);
pub const MS_NOSEC = (1 << 28);
pub const MS_BORN = (1 << 29);
pub const MS_ACTIVE = (1 << 30);
pub const MS_NOUSER = (1 << 31);

pub const MS_RMT_MASK = (MS_RDONLY | MS_SYNCHRONOUS | MS_MANDLOCK | MS_I_VERSION | MS_LAZYTIME);

pub const MS_MGC_VAL = 0xc0ed0000;
pub const MS_MGC_MSK = 0xffff0000;

pub const MNT_FORCE = 1;
pub const MNT_DETACH = 2;
pub const MNT_EXPIRE = 4;
pub const UMOUNT_NOFOLLOW = 8;

pub const IN_CLOEXEC = O_CLOEXEC;
pub const IN_NONBLOCK = O_NONBLOCK;

pub const IN_ACCESS = 0x00000001;
pub const IN_MODIFY = 0x00000002;
pub const IN_ATTRIB = 0x00000004;
pub const IN_CLOSE_WRITE = 0x00000008;
pub const IN_CLOSE_NOWRITE = 0x00000010;
pub const IN_CLOSE = IN_CLOSE_WRITE | IN_CLOSE_NOWRITE;
pub const IN_OPEN = 0x00000020;
pub const IN_MOVED_FROM = 0x00000040;
pub const IN_MOVED_TO = 0x00000080;
pub const IN_MOVE = IN_MOVED_FROM | IN_MOVED_TO;
pub const IN_CREATE = 0x00000100;
pub const IN_DELETE = 0x00000200;
pub const IN_DELETE_SELF = 0x00000400;
pub const IN_MOVE_SELF = 0x00000800;
pub const IN_ALL_EVENTS = 0x00000fff;

pub const IN_UNMOUNT = 0x00002000;
pub const IN_Q_OVERFLOW = 0x00004000;
pub const IN_IGNORED = 0x00008000;

pub const IN_ONLYDIR = 0x01000000;
pub const IN_DONT_FOLLOW = 0x02000000;
pub const IN_EXCL_UNLINK = 0x04000000;
pub const IN_MASK_ADD = 0x20000000;

pub const IN_ISDIR = 0x40000000;
pub const IN_ONESHOT = 0x80000000;

pub const S_IFMT = 0o170000;

pub const S_IFDIR = 0o040000;
pub const S_IFCHR = 0o020000;
pub const S_IFBLK = 0o060000;
pub const S_IFREG = 0o100000;
pub const S_IFIFO = 0o010000;
pub const S_IFLNK = 0o120000;
pub const S_IFSOCK = 0o140000;

pub const S_ISUID = 0o4000;
pub const S_ISGID = 0o2000;
pub const S_ISVTX = 0o1000;
pub const S_IRUSR = 0o400;
pub const S_IWUSR = 0o200;
pub const S_IXUSR = 0o100;
pub const S_IRWXU = 0o700;
pub const S_IRGRP = 0o040;
pub const S_IWGRP = 0o020;
pub const S_IXGRP = 0o010;
pub const S_IRWXG = 0o070;
pub const S_IROTH = 0o004;
pub const S_IWOTH = 0o002;
pub const S_IXOTH = 0o001;
pub const S_IRWXO = 0o007;

pub fn S_ISREG(m: u32) bool {
    return m & S_IFMT == S_IFREG;
}

pub fn S_ISDIR(m: u32) bool {
    return m & S_IFMT == S_IFDIR;
}

pub fn S_ISCHR(m: u32) bool {
    return m & S_IFMT == S_IFCHR;
}

pub fn S_ISBLK(m: u32) bool {
    return m & S_IFMT == S_IFBLK;
}

pub fn S_ISFIFO(m: u32) bool {
    return m & S_IFMT == S_IFIFO;
}

pub fn S_ISLNK(m: u32) bool {
    return m & S_IFMT == S_IFLNK;
}

pub fn S_ISSOCK(m: u32) bool {
    return m & S_IFMT == S_IFSOCK;
}

pub const TFD_NONBLOCK = O_NONBLOCK;
pub const TFD_CLOEXEC = O_CLOEXEC;

pub const TFD_TIMER_ABSTIME = 1;
pub const TFD_TIMER_CANCEL_ON_SET = (1 << 1);

pub fn WEXITSTATUS(s: u32) u32 {
    return (s & 0xff00) >> 8;
}
pub fn WTERMSIG(s: u32) u32 {
    return s & 0x7f;
}
pub fn WSTOPSIG(s: u32) u32 {
    return WEXITSTATUS(s);
}
pub fn WIFEXITED(s: u32) bool {
    return WTERMSIG(s) == 0;
}
pub fn WIFSTOPPED(s: u32) bool {
    return @intCast(u16, ((s & 0xffff) *% 0x10001) >> 8) > 0x7f00;
}
pub fn WIFSIGNALED(s: u32) bool {
    return (s & 0xffff) -% 1 < 0xff;
}

pub const winsize = extern struct {
    ws_row: u16,
    ws_col: u16,
    ws_xpixel: u16,
    ws_ypixel: u16,
};

/// NSIG is the total number of signals defined.
/// As signal numbers are sequential, NSIG is one greater than the largest defined signal number.
pub const NSIG = if (is_mips) 128 else 65;

pub const sigset_t = [1024 / 32]u32;

pub const all_mask: sigset_t = [_]u32{0xffffffff} ** sigset_t.len;
pub const app_mask: sigset_t = [2]u32{ 0xfffffffc, 0x7fffffff } ++ [_]u32{0xffffffff} ** 30;

pub const k_sigaction = if (is_mips)
    extern struct {
        flags: usize,
        sigaction: ?extern fn (i32, *siginfo_t, *c_void) void,
        mask: [4]u32,
        restorer: extern fn () void,
    }
else
    extern struct {
        sigaction: ?extern fn (i32, *siginfo_t, *c_void) void,
        flags: usize,
        restorer: extern fn () void,
        mask: [2]u32,
    };

/// Renamed from `sigaction` to `Sigaction` to avoid conflict with the syscall.
pub const Sigaction = extern struct {
    sigaction: ?extern fn (i32, *siginfo_t, *c_void) void,
    mask: sigset_t,
    flags: u32,
    restorer: ?extern fn () void = null,
};

pub const SIG_ERR = @intToPtr(extern fn (i32, *siginfo_t, *c_void) void, maxInt(usize));
pub const SIG_DFL = @intToPtr(?extern fn (i32, *siginfo_t, *c_void) void, 0);
pub const SIG_IGN = @intToPtr(extern fn (i32, *siginfo_t, *c_void) void, 1);
pub const empty_sigset = [_]u32{0} ** sigset_t.len;

pub const in_port_t = u16;
pub const sa_family_t = u16;
pub const socklen_t = u32;

pub const sockaddr = extern struct {
    family: sa_family_t,
    data: [14]u8,
};

/// IPv4 socket address
pub const sockaddr_in = extern struct {
    family: sa_family_t = AF_INET,
    port: in_port_t,
    addr: u32,
    zero: [8]u8 = [8]u8{ 0, 0, 0, 0, 0, 0, 0, 0 },
};

/// IPv6 socket address
pub const sockaddr_in6 = extern struct {
    family: sa_family_t = AF_INET6,
    port: in_port_t,
    flowinfo: u32,
    addr: [16]u8,
    scope_id: u32,
};

/// UNIX domain socket address
pub const sockaddr_un = extern struct {
    family: sa_family_t = AF_UNIX,
    path: [108]u8,
};

pub const mmsghdr = extern struct {
    msg_hdr: msghdr,
    msg_len: u32,
};

pub const mmsghdr_const = extern struct {
    msg_hdr: msghdr_const,
    msg_len: u32,
};

pub const epoll_data = extern union {
    ptr: usize,
    fd: i32,
    @"u32": u32,
    @"u64": u64,
};

// On x86_64 the structure is packed so that it matches the definition of its
// 32bit counterpart
pub const epoll_event = switch (builtin.arch) {
    .x86_64 => packed struct {
        events: u32,
        data: epoll_data,
    },
    else => extern struct {
        events: u32,
        data: epoll_data,
    },
};

pub const _LINUX_CAPABILITY_VERSION_1 = 0x19980330;
pub const _LINUX_CAPABILITY_U32S_1 = 1;

pub const _LINUX_CAPABILITY_VERSION_2 = 0x20071026;
pub const _LINUX_CAPABILITY_U32S_2 = 2;

pub const _LINUX_CAPABILITY_VERSION_3 = 0x20080522;
pub const _LINUX_CAPABILITY_U32S_3 = 2;

pub const VFS_CAP_REVISION_MASK = 0xFF000000;
pub const VFS_CAP_REVISION_SHIFT = 24;
pub const VFS_CAP_FLAGS_MASK = ~VFS_CAP_REVISION_MASK;
pub const VFS_CAP_FLAGS_EFFECTIVE = 0x000001;

pub const VFS_CAP_REVISION_1 = 0x01000000;
pub const VFS_CAP_U32_1 = 1;
pub const XATTR_CAPS_SZ_1 = @sizeOf(u32) * (1 + 2 * VFS_CAP_U32_1);

pub const VFS_CAP_REVISION_2 = 0x02000000;
pub const VFS_CAP_U32_2 = 2;
pub const XATTR_CAPS_SZ_2 = @sizeOf(u32) * (1 + 2 * VFS_CAP_U32_2);

pub const XATTR_CAPS_SZ = XATTR_CAPS_SZ_2;
pub const VFS_CAP_U32 = VFS_CAP_U32_2;
pub const VFS_CAP_REVISION = VFS_CAP_REVISION_2;

pub const vfs_cap_data = extern struct {
    //all of these are mandated as little endian
    //when on disk.
    const Data = struct {
        permitted: u32,
        inheritable: u32,
    };

    magic_etc: u32,
    data: [VFS_CAP_U32]Data,
};

pub const CAP_CHOWN = 0;
pub const CAP_DAC_OVERRIDE = 1;
pub const CAP_DAC_READ_SEARCH = 2;
pub const CAP_FOWNER = 3;
pub const CAP_FSETID = 4;
pub const CAP_KILL = 5;
pub const CAP_SETGID = 6;
pub const CAP_SETUID = 7;
pub const CAP_SETPCAP = 8;
pub const CAP_LINUX_IMMUTABLE = 9;
pub const CAP_NET_BIND_SERVICE = 10;
pub const CAP_NET_BROADCAST = 11;
pub const CAP_NET_ADMIN = 12;
pub const CAP_NET_RAW = 13;
pub const CAP_IPC_LOCK = 14;
pub const CAP_IPC_OWNER = 15;
pub const CAP_SYS_MODULE = 16;
pub const CAP_SYS_RAWIO = 17;
pub const CAP_SYS_CHROOT = 18;
pub const CAP_SYS_PTRACE = 19;
pub const CAP_SYS_PACCT = 20;
pub const CAP_SYS_ADMIN = 21;
pub const CAP_SYS_BOOT = 22;
pub const CAP_SYS_NICE = 23;
pub const CAP_SYS_RESOURCE = 24;
pub const CAP_SYS_TIME = 25;
pub const CAP_SYS_TTY_CONFIG = 26;
pub const CAP_MKNOD = 27;
pub const CAP_LEASE = 28;
pub const CAP_AUDIT_WRITE = 29;
pub const CAP_AUDIT_CONTROL = 30;
pub const CAP_SETFCAP = 31;
pub const CAP_MAC_OVERRIDE = 32;
pub const CAP_MAC_ADMIN = 33;
pub const CAP_SYSLOG = 34;
pub const CAP_WAKE_ALARM = 35;
pub const CAP_BLOCK_SUSPEND = 36;
pub const CAP_AUDIT_READ = 37;
pub const CAP_LAST_CAP = CAP_AUDIT_READ;

pub fn cap_valid(u8: x) bool {
    return x >= 0 and x <= CAP_LAST_CAP;
}

pub fn CAP_TO_MASK(cap: u8) u32 {
    return @as(u32, 1) << @intCast(u5, cap & 31);
}

pub fn CAP_TO_INDEX(cap: u8) u8 {
    return cap >> 5;
}

pub const cap_t = extern struct {
    hdrp: *cap_user_header_t,
    datap: *cap_user_data_t,
};

pub const cap_user_header_t = extern struct {
    version: u32,
    pid: usize,
};

pub const cap_user_data_t = extern struct {
    effective: u32,
    permitted: u32,
    inheritable: u32,
};

pub const inotify_event = extern struct {
    wd: i32,
    mask: u32,
    cookie: u32,
    len: u32,
    //name: [?]u8,
};

pub const dirent64 = extern struct {
    d_ino: u64,
    d_off: u64,
    d_reclen: u16,
    d_type: u8,
    d_name: u8, // field address is the address of first byte of name https://github.com/ziglang/zig/issues/173

    pub fn reclen(self: dirent64) u16 {
        return self.d_reclen;
    }
};

pub const dl_phdr_info = extern struct {
    dlpi_addr: usize,
    dlpi_name: ?[*]const u8,
    dlpi_phdr: [*]std.elf.Phdr,
    dlpi_phnum: u16,
};

pub const CPU_SETSIZE = 128;
pub const cpu_set_t = [CPU_SETSIZE / @sizeOf(usize)]usize;
pub const cpu_count_t = @IntType(false, std.math.log2(CPU_SETSIZE * 8));

pub fn CPU_COUNT(set: cpu_set_t) cpu_count_t {
    var sum: cpu_count_t = 0;
    for (set) |x| {
        sum += @popCount(usize, x);
    }
    return sum;
}

// TODO port these over
//#define CPU_SET(i, set) CPU_SET_S(i,sizeof(cpu_set_t),set)
//#define CPU_CLR(i, set) CPU_CLR_S(i,sizeof(cpu_set_t),set)
//#define CPU_ISSET(i, set) CPU_ISSET_S(i,sizeof(cpu_set_t),set)
//#define CPU_AND(d,s1,s2) CPU_AND_S(sizeof(cpu_set_t),d,s1,s2)
//#define CPU_OR(d,s1,s2) CPU_OR_S(sizeof(cpu_set_t),d,s1,s2)
//#define CPU_XOR(d,s1,s2) CPU_XOR_S(sizeof(cpu_set_t),d,s1,s2)
//#define CPU_COUNT(set) CPU_COUNT_S(sizeof(cpu_set_t),set)
//#define CPU_ZERO(set) CPU_ZERO_S(sizeof(cpu_set_t),set)
//#define CPU_EQUAL(s1,s2) CPU_EQUAL_S(sizeof(cpu_set_t),s1,s2)

pub const MINSIGSTKSZ = switch (builtin.arch) {
    .i386, .x86_64, .arm, .mipsel => 2048,
    .aarch64 => 5120,
    else => @compileError("MINSIGSTKSZ not defined for this architecture"),
};
pub const SIGSTKSZ = switch (builtin.arch) {
    .i386, .x86_64, .arm, .mipsel => 8192,
    .aarch64 => 16384,
    else => @compileError("SIGSTKSZ not defined for this architecture"),
};

pub const SS_ONSTACK = 1;
pub const SS_DISABLE = 2;
pub const SS_AUTODISARM = 1 << 31;

pub const stack_t = extern struct {
    ss_sp: [*]u8,
    ss_flags: i32,
    ss_size: isize,
};

pub const sigval = extern union {
    int: i32,
    ptr: *c_void,
};

const siginfo_fields_union = extern union {
    pad: [128 - 2 * @sizeOf(c_int) - @sizeOf(c_long)]u8,
    common: extern struct {
        first: extern union {
            piduid: extern struct {
                pid: pid_t,
                uid: uid_t,
            },
            timer: extern struct {
                timerid: i32,
                overrun: i32,
            },
        },
        second: extern union {
            value: sigval,
            sigchld: extern struct {
                status: i32,
                utime: clock_t,
                stime: clock_t,
            },
        },
    },
    sigfault: extern struct {
        addr: *c_void,
        addr_lsb: i16,
        first: extern union {
            addr_bnd: extern struct {
                lower: *c_void,
                upper: *c_void,
            },
            pkey: u32,
        },
    },
    sigpoll: extern struct {
        band: isize,
        fd: i32,
    },
    sigsys: extern struct {
        call_addr: *c_void,
        syscall: i32,
        arch: u32,
    },
};

pub const siginfo_t = if (is_mips)
    extern struct {
        signo: i32,
        code: i32,
        errno: i32,
        fields: siginfo_fields_union,
    }
else
    extern struct {
        signo: i32,
        errno: i32,
        code: i32,
        fields: siginfo_fields_union,
    };

pub const io_uring_params = extern struct {
    sq_entries: u32,
    cq_entries: u32,
    flags: u32,
    sq_thread_cpu: u32,
    sq_thread_idle: u32,
    features: u32,
    resv: [4]u32,
    sq_off: io_sqring_offsets,
    cq_off: io_cqring_offsets,
};

// io_uring_params.features flags

pub const IORING_FEAT_SINGLE_MMAP = 1 << 0;

// io_uring_params.flags

/// io_context is polled
pub const IORING_SETUP_IOPOLL = (1 << 0);

/// SQ poll thread
pub const IORING_SETUP_SQPOLL = (1 << 1);

/// sq_thread_cpu is valid
pub const IORING_SETUP_SQ_AFF = (1 << 2);

pub const io_sqring_offsets = extern struct {
    /// offset of ring head
    head: u32,

    /// offset of ring tail
    tail: u32,

    /// ring mask value
    ring_mask: u32,

    /// entries in ring
    ring_entries: u32,

    /// ring flags
    flags: u32,

    /// number of sqes not submitted
    dropped: u32,

    /// sqe index array
    array: u32,

    resv1: u32,
    resv2: u64,
};

// io_sqring_offsets.flags

/// needs io_uring_enter wakeup
pub const IORING_SQ_NEED_WAKEUP = 1 << 0;

pub const io_cqring_offsets = extern struct {
    head: u32,
    tail: u32,
    ring_mask: u32,
    ring_entries: u32,
    overflow: u32,
    cqes: u32,
    resv: [2]u64,
};

pub const io_uring_sqe = extern struct {
    opcode: u8,
    flags: u8,
    ioprio: u16,
    fd: i32,
    off: u64,
    addr: u64,
    len: u32,
    pub const union1 = extern union {
        rw_flags: kernel_rwf,
        fsync_flags: u32,
        poll_events: u16,
        sync_range_flags: u32,
        msg_flags: u32,
        timeout_flags: u32,
    };
    union1: union1,
    user_data: u64,
    pub const union2 = extern union {
        buf_index: u16,
        __pad2: [3]u64,
    };
    union2: union2,
};

// io_uring_sqe.flags

/// use fixed fileset
pub const IOSQE_FIXED_FILE = (1 << 0);

/// issue after inflight IO
pub const IOSQE_IO_DRAIN = (1 << 1);

/// links next sqe
pub const IOSQE_IO_LINK = (1 << 2);

pub const IORING_OP_NOP = 0;
pub const IORING_OP_READV = 1;
pub const IORING_OP_WRITEV = 2;
pub const IORING_OP_FSYNC = 3;
pub const IORING_OP_READ_FIXED = 4;
pub const IORING_OP_WRITE_FIXED = 5;
pub const IORING_OP_POLL_ADD = 6;
pub const IORING_OP_POLL_REMOVE = 7;
pub const IORING_OP_SYNC_FILE_RANGE = 8;
pub const IORING_OP_SENDMSG = 9;
pub const IORING_OP_RECVMSG = 10;
pub const IORING_OP_TIMEOUT = 11;

// io_uring_sqe.fsync_flags
pub const IORING_FSYNC_DATASYNC = (1 << 0);

// IO completion data structure (Completion Queue Entry)
pub const io_uring_cqe = extern struct {
    /// io_uring_sqe.data submission passed back
    user_data: u64,

    /// result code for this event
    res: i32,
    flags: u32,
};

pub const IORING_OFF_SQ_RING = 0;
pub const IORING_OFF_CQ_RING = 0x8000000;
pub const IORING_OFF_SQES = 0x10000000;

// io_uring_enter flags
pub const IORING_ENTER_GETEVENTS = (1 << 0);
pub const IORING_ENTER_SQ_WAKEUP = (1 << 1);

// io_uring_register opcodes and arguments
pub const IORING_REGISTER_BUFFERS = 0;
pub const IORING_UNREGISTER_BUFFERS = 1;
pub const IORING_REGISTER_FILES = 2;
pub const IORING_UNREGISTER_FILES = 3;
pub const IORING_REGISTER_EVENTFD = 4;
pub const IORING_UNREGISTER_EVENTFD = 5;

pub const utsname = extern struct {
    sysname: [65]u8,
    nodename: [65]u8,
    release: [65]u8,
    version: [65]u8,
    machine: [65]u8,
    domainname: [65]u8,
};
pub const HOST_NAME_MAX = 64;

pub const STATX_TYPE = 0x0001;
pub const STATX_MODE = 0x0002;
pub const STATX_NLINK = 0x0004;
pub const STATX_UID = 0x0008;
pub const STATX_GID = 0x0010;
pub const STATX_ATIME = 0x0020;
pub const STATX_MTIME = 0x0040;
pub const STATX_CTIME = 0x0080;
pub const STATX_INO = 0x0100;
pub const STATX_SIZE = 0x0200;
pub const STATX_BLOCKS = 0x0400;
pub const STATX_BASIC_STATS = 0x07ff;

pub const STATX_BTIME = 0x0800;

pub const STATX_ATTR_COMPRESSED = 0x0004;
pub const STATX_ATTR_IMMUTABLE = 0x0010;
pub const STATX_ATTR_APPEND = 0x0020;
pub const STATX_ATTR_NODUMP = 0x0040;
pub const STATX_ATTR_ENCRYPTED = 0x0800;
pub const STATX_ATTR_AUTOMOUNT = 0x1000;

pub const statx_timestamp = extern struct {
    tv_sec: i64,
    tv_nsec: u32,
    __pad1: u32,
};

/// Renamed to `Statx` to not conflict with the `statx` function.
pub const Statx = extern struct {
    /// Mask of bits indicating filled fields
    mask: u32,

    /// Block size for filesystem I/O
    blksize: u32,

    /// Extra file attribute indicators
    attributes: u64,

    /// Number of hard links
    nlink: u32,

    /// User ID of owner
    uid: u32,

    /// Group ID of owner
    gid: u32,

    /// File type and mode
    mode: u16,
    __pad1: u16,

    /// Inode number
    ino: u64,

    /// Total size in bytes
    size: u64,

    /// Number of 512B blocks allocated
    blocks: u64,

    /// Mask to show what's supported in `attributes`.
    attributes_mask: u64,

    /// Last access file timestamp
    atime: statx_timestamp,

    /// Creation file timestamp
    btime: statx_timestamp,

    /// Last status change file timestamp
    ctime: statx_timestamp,

    /// Last modification file timestamp
    mtime: statx_timestamp,

    /// Major ID, if this file represents a device.
    rdev_major: u32,

    /// Minor ID, if this file represents a device.
    rdev_minor: u32,

    /// Major ID of the device containing the filesystem where this file resides.
    dev_major: u32,

    /// Minor ID of the device containing the filesystem where this file resides.
    dev_minor: u32,

    __pad2: [14]u64,
};

pub const addrinfo = extern struct {
    flags: i32,
    family: i32,
    socktype: i32,
    protocol: i32,
    addrlen: socklen_t,
    addr: ?*sockaddr,
    canonname: ?[*:0]u8,
    next: ?*addrinfo,
};

pub const IPPORT_RESERVED = 1024;

pub const IPPROTO_IP = 0;
pub const IPPROTO_HOPOPTS = 0;
pub const IPPROTO_ICMP = 1;
pub const IPPROTO_IGMP = 2;
pub const IPPROTO_IPIP = 4;
pub const IPPROTO_TCP = 6;
pub const IPPROTO_EGP = 8;
pub const IPPROTO_PUP = 12;
pub const IPPROTO_UDP = 17;
pub const IPPROTO_IDP = 22;
pub const IPPROTO_TP = 29;
pub const IPPROTO_DCCP = 33;
pub const IPPROTO_IPV6 = 41;
pub const IPPROTO_ROUTING = 43;
pub const IPPROTO_FRAGMENT = 44;
pub const IPPROTO_RSVP = 46;
pub const IPPROTO_GRE = 47;
pub const IPPROTO_ESP = 50;
pub const IPPROTO_AH = 51;
pub const IPPROTO_ICMPV6 = 58;
pub const IPPROTO_NONE = 59;
pub const IPPROTO_DSTOPTS = 60;
pub const IPPROTO_MTP = 92;
pub const IPPROTO_BEETPH = 94;
pub const IPPROTO_ENCAP = 98;
pub const IPPROTO_PIM = 103;
pub const IPPROTO_COMP = 108;
pub const IPPROTO_SCTP = 132;
pub const IPPROTO_MH = 135;
pub const IPPROTO_UDPLITE = 136;
pub const IPPROTO_MPLS = 137;
pub const IPPROTO_RAW = 255;
pub const IPPROTO_MAX = 256;

pub const RR_A = 1;
pub const RR_CNAME = 5;
pub const RR_AAAA = 28;

pub const nfds_t = usize;
pub const pollfd = extern struct {
    fd: fd_t,
    events: i16,
    revents: i16,
};

pub const POLLIN = 0x001;
pub const POLLPRI = 0x002;
pub const POLLOUT = 0x004;
pub const POLLERR = 0x008;
pub const POLLHUP = 0x010;
pub const POLLNVAL = 0x020;
pub const POLLRDNORM = 0x040;
pub const POLLRDBAND = 0x080;
