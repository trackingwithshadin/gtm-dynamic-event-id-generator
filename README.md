# Dynamic Event ID Generator | Tracking with Shadin

The **Dynamic Event ID Generator** is an essential tool for any Google Tag Manager setup that involves Server-Side Tracking and Event Deduplication. It is specifically designed to ensure that browser-side events (Pixel) and server-side events (CAPI) share the exact same ID, allowing platforms like Meta (Facebook) to deduplicate them 100% accurately.

## Key Features

- **Unique ID Generation**: Combines high-resolution timestamps with cryptographically safe random numbers to prevent collisions.
- **Deduplication Ready**: Perfectly formats IDs for Meta CAPI `event_id`, TikTok `event_id`, and GA4 custom dimensions.
- **Customizable Prefixes**: Add your own prefix (e.g., `sid_`, `shadin_`) for better tracking organization.
- **Lightweight**: Zero external dependencies, built entirely with GTM's native sandboxed JavaScript.

## Why Use This?

When sending data to Meta or TikTok through both the Browser and the Server, the platforms need a way to know that `Event A` from the browser and `Event B` from the server are actually the same event. If the IDs don't match, you will see inflated numbers and double-counting. This template solves that problem permanently.

## Configuration

1. **Prefix (Optional)**: Enter a string to appear at the start of your ID.
2. **Suffix Type**:
   - **Both (Recommended)**: Combines timestamp and a random number (e.g., `1712345678.987654`).
   - **Timestamp**: Uses the current Unix timestamp in milliseconds.
   - **Random**: Uses a high-range random integer.

## Permissions

This template is privacy-safe and requires **no special permissions** to run.

## Developed By

**Md Sadikul Islam Shadin**  
[LinkedIn Profile](https://www.linkedin.com/in/sadikulshadin/)
