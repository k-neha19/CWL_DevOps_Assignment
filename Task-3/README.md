# Task 3 - Monitor Container CPU and Memory

## Objective

Automate Docker container monitoring by logging CPU and memory usage with timestamps every minute.

## File in This Task

- `monitor.sh` - Monitoring script that appends metrics to log file

## Monitoring Script Behavior

The script:

- Accepts optional container name argument (default: `custom-web`)
- Collects one-time (`--no-stream`) Docker stats
- Adds timestamp to each record
- Appends logs to:
  - `/opt/container-monitor/logs/monitor.log`
- Logs a fallback message if container is not running

## Setup Commands

```bash
cd Task-3
chmod +x monitor.sh
sudo mkdir -p /opt/container-monitor/logs
sudo cp monitor.sh /opt/container-monitor/monitor.sh
sudo chmod +x /opt/container-monitor/monitor.sh
```

Run once manually for testing:

```bash
sudo /opt/container-monitor/monitor.sh custom-web
sudo tail -n 5 /opt/container-monitor/logs/monitor.log
```

## Cron Job Setup (Every Minute)

Run cron as the dedicated monitoring user (`monitoruser`) so monitoring operations match the assignment requirement.

```bash
sudo -u monitoruser crontab -e
```

Add this line:

```cron
* * * * * /opt/container-monitor/monitor.sh custom-web
```

Verify cron entry:

```bash
sudo -u monitoruser crontab -l
```

Optional verification (run once as `monitoruser`):

```bash
sudo -u monitoruser /opt/container-monitor/monitor.sh custom-web
tail -n 5 /opt/container-monitor/logs/monitor.log
```

## Sample Log Output

```text
2026-03-31 10:40:00 | container=custom-web | cpu=0.05% | memory=3.21MiB / 128MiB
2026-03-31 10:41:00 | container=custom-web | cpu=0.03% | memory=3.18MiB / 128MiB
```

## Expected Outcome

- A new log entry is added every minute.
- Each entry contains timestamp, container name, CPU usage, and memory usage.
