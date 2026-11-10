static int read_int(const char *path, int default_val) {
    FILE *f = fopen(path, "r");
    if (!f) return default_val;
    int val = default_val;
    if (fscanf(f, "%d", &val) != 1) {
        val = default_val;
    }
    fclose(f);
    return val;
}

static unsigned long long read_ull(const char *path) {
    FILE *f = fopen(path, "r");
    if (!f) return 0;
    unsigned long long val = 0;
    if (fscanf(f, "%llu", &val) != 1) {
        val = 0;
    }
    fclose(f);
    return val;
}

int main(void) {
    const char *base = "/sys/class/drm/card0/device";

    FILE *test = fopen("/sys/class/drm/card0/device/gpu_busy_percent", "r");
    if (!test) {
        printf("{\"text\":\"N/A\",\"tooltip\":\"No AMD GPU detected\",\"class\":\"off\"}\n");
        return 0;
    }
    fclose(test);

    char path[256];
    snprintf(path, sizeof(path), "%s/gpu_busy_percent", base);
    int usage = read_int(path, -1);

    int temp_raw = -1;
    for (int i = 0; i <= 4; i++) {
        snprintf(path, sizeof(path), "%s/hwmon/hwmon%d/temp1_input", base, i);
        temp_raw = read_int(path, -1);
        if (temp_raw > 0) break;
    }
    int temp = (temp_raw > 0) ? (temp_raw / 1000) : -1;

    snprintf(path, sizeof(path), "%s/mem_info_vram_used", base);
    unsigned long long vram_used = read_ull(path) / 1048576;

    snprintf(path, sizeof(path), "%s/mem_info_vram_total", base);
    unsigned long long vram_total = read_ull(path) / 1048576;

    const char *status_class = "normal";
    if (temp >= 85) {
        status_class = "critical";
    } else if (temp >= 70) {
        status_class = "warning";
    }

    char usage_str[16], temp_str[16];
    if (usage >= 0) snprintf(usage_str, sizeof(usage_str), "%d%%", usage);
    else strncpy(usage_str, "?", sizeof(usage_str));

    if (temp >= 0) snprintf(temp_str, sizeof(temp_str), "%d°", temp);
    else strncpy(temp_str, "?", sizeof(temp_str));

    printf("{\"text\":\"%s %s\",\"tooltip\":\"AMD GPU %s  Temp %s\\nVRAM %lluMiB / %lluMiB\",\"class\":\"%s\"}\n",
           usage_str, temp_str, usage_str, temp_str, vram_used, vram_total, status_class);

    return 0;
}
