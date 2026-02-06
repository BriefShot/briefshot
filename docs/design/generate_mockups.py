#!/usr/bin/env python3
"""BriefShot — Visual Mockup Generator using Pillow"""

from PIL import Image, ImageDraw, ImageFont
import os

# ─── Design Tokens ───────────────────────────────────────
BG_PRIMARY    = (11, 16, 18)       # #0B1012
BG_SECONDARY  = (19, 26, 30)      # #131A1E
BG_TERTIARY   = (26, 35, 40)      # #1A2328
ACCENT_TEAL   = (45, 212, 191)    # #2DD4BF
ACCENT_ORANGE = (249, 115, 22)    # #F97316
TEXT_PRIMARY   = (255, 255, 255)   # #FFFFFF
TEXT_SECONDARY = (148, 163, 184)   # #94A3B8
TEXT_MUTED     = (100, 116, 139)   # #64748B
ERROR          = (239, 68, 68)     # #EF4444
SUCCESS        = (34, 197, 94)     # #22C55E
BORDER         = (30, 41, 59)      # #1E293B
BLACK          = (0, 0, 0)

PHONE_W = 390
PHONE_H = 844
PHONE_RADIUS = 40
NAVBAR_H = 80
STATUS_BAR_H = 44
HEADER_H = 64

FONT_DIR = "/home/user/briefshot/assets/fonts/"
OUTPUT_DIR = "/home/user/briefshot/docs/design/renders/"

os.makedirs(OUTPUT_DIR, exist_ok=True)

# ─── Font helpers ────────────────────────────────────────
def font_druk(size):
    return ImageFont.truetype(FONT_DIR + "Druk_wide_web-Regular.ttf", size)

def font_sys(size):
    try:
        return ImageFont.truetype("/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf", size)
    except:
        return ImageFont.load_default()

def font_sys_bold(size):
    try:
        return ImageFont.truetype("/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf", size)
    except:
        return font_sys(size)

# ─── Drawing helpers ─────────────────────────────────────
def rounded_rect(draw, xy, fill, radius=16):
    x0, y0, x1, y1 = xy
    draw.rounded_rectangle(xy, radius=radius, fill=fill)

def pill(draw, xy, fill, text, text_color, font):
    x0, y0, x1, y1 = xy
    draw.rounded_rectangle(xy, radius=(y1-y0)//2, fill=fill)
    tw = draw.textlength(text, font=font)
    tx = x0 + ((x1-x0) - tw) / 2
    ty = y0 + ((y1-y0) - font.size) / 2 - 2
    draw.text((tx, ty), text, fill=text_color, font=font)

def circle(draw, center, radius, fill):
    x, y = center
    draw.ellipse([x-radius, y-radius, x+radius, y+radius], fill=fill)

def phone_frame(draw):
    """Draw the phone bezel"""
    # Status bar
    f = font_sys(12)
    draw.text((20, 14), "9:41", fill=TEXT_PRIMARY, font=f)
    draw.text((PHONE_W - 70, 14), "100%", fill=TEXT_PRIMARY, font=f)
    # Battery icon
    draw.rounded_rectangle([PHONE_W-35, 15, PHONE_W-15, 27], radius=3, fill=None, outline=TEXT_PRIMARY, width=1)
    draw.rectangle([PHONE_W-14, 19, PHONE_W-12, 23], fill=TEXT_PRIMARY)

def navbar(draw, active_index=0):
    """Draw the bottom navigation bar"""
    y = PHONE_H - NAVBAR_H
    # Gradient overlay area
    for i in range(60):
        alpha = int(255 * (i / 60))
        c = tuple(int(BG_PRIMARY[j] * alpha / 255) for j in range(3))
        draw.line([(0, y - 60 + i), (PHONE_W, y - 60 + i)], fill=c)

    draw.rectangle([0, y, PHONE_W, PHONE_H], fill=BG_PRIMARY)

    icons = ["Home", "Chat", "Profil", "Notif"]
    emojis = ["🏠", "💬", "👤", "🔔"]
    section_w = PHONE_W // 4
    f = font_sys(10)

    for i, (label, emoji) in enumerate(zip(icons, emojis)):
        cx = section_w * i + section_w // 2
        color = ACCENT_TEAL if i == active_index else TEXT_MUTED
        # Icon circle
        circle(draw, (cx, y + 22), 16, BG_SECONDARY if i == active_index else None)
        draw.text((cx - 5, y + 14), emoji, font=font_sys(14))
        draw.text((cx - draw.textlength(label, font=f)//2, y + 44), label, fill=color, font=f)

    # Active indicator
    ax = section_w * active_index + section_w // 2
    draw.rounded_rectangle([ax - 20, y + 2, ax + 20, y + 4], radius=2, fill=ACCENT_TEAL)

def create_phone():
    img = Image.new("RGB", (PHONE_W, PHONE_H), BG_PRIMARY)
    draw = ImageDraw.Draw(img)
    return img, draw

def add_notif_badge(draw, x, y, count="3"):
    """Small notification badge"""
    f = font_sys_bold(9)
    circle(draw, (x, y), 9, ACCENT_ORANGE)
    tw = draw.textlength(count, font=f)
    draw.text((x - tw/2, y - 6), count, fill=TEXT_PRIMARY, font=f)


# ═══════════════════════════════════════════════════════════
# SCREEN 1: MAP + SHOT DETAIL BOTTOM SHEET
# ═══════════════════════════════════════════════════════════
def render_map_screen():
    img, draw = create_phone()
    phone_frame(draw)

    # Map area (simulated with a dark blue-grey)
    MAP_COLOR = (20, 30, 38)
    draw.rectangle([0, STATUS_BAR_H, PHONE_W, PHONE_H - NAVBAR_H], fill=MAP_COLOR)

    # Grid lines (map roads)
    for x in range(0, PHONE_W, 60):
        draw.line([(x, STATUS_BAR_H), (x, 400)], fill=(30, 42, 52), width=1)
    for y in range(STATUS_BAR_H, 400, 40):
        draw.line([(0, y), (PHONE_W, y)], fill=(30, 42, 52), width=1)

    # Map markers
    markers = [(120, 140), (250, 100), (180, 220), (300, 180), (80, 280)]
    for mx, my in markers:
        # Pin shadow
        circle(draw, (mx+1, my+1), 10, (0,0,0))
        # Pin
        circle(draw, (mx, my), 10, ACCENT_TEAL)
        circle(draw, (mx, my), 5, TEXT_PRIMARY)

    # User location
    circle(draw, (200, 310), 12, (45, 212, 191, 80))
    circle(draw, (200, 310), 6, ACCENT_TEAL)
    circle(draw, (200, 310), 3, TEXT_PRIMARY)

    # Filter button
    rounded_rect(draw, [16, STATUS_BAR_H + 12, 110, STATUS_BAR_H + 48], BG_SECONDARY, 18)
    draw.text((30, STATUS_BAR_H + 20), "☰ Filtrer", fill=TEXT_PRIMARY, font=font_sys(13))

    # ── Bottom sheet ──
    sheet_y = 380
    rounded_rect(draw, [0, sheet_y, PHONE_W, PHONE_H], BG_SECONDARY, 24)

    # Drag handle
    handle_w = 40
    draw.rounded_rectangle(
        [(PHONE_W - handle_w)//2, sheet_y + 10, (PHONE_W + handle_w)//2, sheet_y + 14],
        radius=2, fill=TEXT_MUTED
    )

    # Photo placeholder
    photo_y = sheet_y + 28
    photo_h = 160
    rounded_rect(draw, [16, photo_y, PHONE_W - 16, photo_y + photo_h], BG_TERTIARY, 12)
    # Photo shimmer lines
    for i in range(3):
        ly = photo_y + 60 + i * 20
        draw.line([(40, ly), (PHONE_W - 40, ly)], fill=(35, 48, 56), width=1)
    pf = font_sys(14)
    ptxt = "📷  Shot Photo"
    ptw = draw.textlength(ptxt, font=pf)
    draw.text(((PHONE_W - ptw)//2, photo_y + photo_h//2 - 8), ptxt, fill=TEXT_MUTED, font=pf)

    # Shot info
    info_y = photo_y + photo_h + 16
    draw.text((20, info_y), "Café du Marais", fill=TEXT_PRIMARY, font=font_sys_bold(17))
    draw.text((20, info_y + 26), "📍 1.2 km  •  Ajouté par ", fill=TEXT_SECONDARY, font=font_sys(13))
    draw.text((215, info_y + 26), "@alice", fill=ACCENT_TEAL, font=font_sys(13))

    # Action buttons
    btn_y = info_y + 58
    # Like button
    pill(draw, [20, btn_y, 110, btn_y + 40], BG_TERTIARY, "❤️  42", TEXT_PRIMARY, font_sys(14))
    # See more button
    pill(draw, [124, btn_y, 250, btn_y + 40], ACCENT_TEAL, "Voir plus", BLACK, font_sys_bold(14))

    navbar(draw, 0)

    # Round corners
    mask = Image.new("L", (PHONE_W, PHONE_H), 0)
    mask_draw = ImageDraw.Draw(mask)
    mask_draw.rounded_rectangle([0, 0, PHONE_W, PHONE_H], radius=PHONE_RADIUS, fill=255)

    bg = Image.new("RGB", (PHONE_W, PHONE_H), (30, 30, 30))
    bg.paste(img, mask=mask)
    return bg


# ═══════════════════════════════════════════════════════════
# SCREEN 2: MESSAGE LIST
# ═══════════════════════════════════════════════════════════
def render_message_list():
    img, draw = create_phone()
    phone_frame(draw)

    # Header
    hy = STATUS_BAR_H
    draw.rectangle([0, hy, PHONE_W, hy + HEADER_H], fill=BG_PRIMARY)
    draw.text((24, hy + 16), "MESSAGES", fill=TEXT_PRIMARY, font=font_druk(22))
    draw.text((PHONE_W - 40, hy + 22), "🔍", font=font_sys(18))

    # Separator
    draw.line([(0, hy + HEADER_H), (PHONE_W, hy + HEADER_H)], fill=BORDER, width=1)

    # Conversations
    conversations = [
        ("Alice Martin", "Salut, tu connais ce spot ?", "14:32", True, SUCCESS),
        ("Bob Dupont", "Super le shot !", "Hier", False, TEXT_MUTED),
        ("Clara Petit", "On se retrouve là-bas ?", "Lun.", True, SUCCESS),
        ("David Moreau", "Merci pour le tip !", "23 jan.", False, None),
        ("Emma Leroy", "J'adore cette vue !", "20 jan.", False, None),
        ("François Blanc", "Tu es dispo samedi ?", "18 jan.", False, None),
    ]

    cell_h = 76
    start_y = hy + HEADER_H + 1

    for i, (name, msg, time, unread, status_color) in enumerate(conversations):
        cy = start_y + i * cell_h

        # Unread background
        if unread:
            draw.rectangle([0, cy, PHONE_W, cy + cell_h], fill=(15, 22, 26))

        # Avatar circle
        avatar_x, avatar_y = 40, cy + cell_h // 2
        colors = [ACCENT_TEAL, ACCENT_ORANGE, (147, 51, 234), (59, 130, 246), (236, 72, 153), (234, 179, 8)]
        circle(draw, (avatar_x, avatar_y), 24, colors[i % len(colors)])
        # Initial
        initial = name[0]
        iw = draw.textlength(initial, font=font_sys_bold(16))
        draw.text((avatar_x - iw/2, avatar_y - 10), initial, fill=TEXT_PRIMARY, font=font_sys_bold(16))

        # Online status
        if status_color:
            circle(draw, (avatar_x + 17, avatar_y + 17), 6, BG_PRIMARY)
            circle(draw, (avatar_x + 17, avatar_y + 17), 4, status_color)

        # Name
        draw.text((76, cy + 16), name, fill=TEXT_PRIMARY, font=font_sys_bold(15))

        # Last message
        max_msg_w = PHONE_W - 160
        msg_display = msg
        if draw.textlength(msg, font=font_sys(13)) > max_msg_w:
            while draw.textlength(msg_display + "...", font=font_sys(13)) > max_msg_w:
                msg_display = msg_display[:-1]
            msg_display += "..."
        draw.text((76, cy + 40), msg_display, fill=TEXT_SECONDARY, font=font_sys(13))

        # Timestamp
        tw = draw.textlength(time, font=font_sys(11))
        draw.text((PHONE_W - 20 - tw, cy + 18), time, fill=TEXT_MUTED, font=font_sys(11))

        # Unread dot
        if unread:
            circle(draw, (PHONE_W - 20, cy + 48), 5, ACCENT_ORANGE)

        # Separator
        draw.line([(76, cy + cell_h - 1), (PHONE_W, cy + cell_h - 1)], fill=BORDER, width=1)

    navbar(draw, 1)

    mask = Image.new("L", (PHONE_W, PHONE_H), 0)
    mask_draw = ImageDraw.Draw(mask)
    mask_draw.rounded_rectangle([0, 0, PHONE_W, PHONE_H], radius=PHONE_RADIUS, fill=255)
    bg = Image.new("RGB", (PHONE_W, PHONE_H), (30, 30, 30))
    bg.paste(img, mask=mask)
    return bg


# ═══════════════════════════════════════════════════════════
# SCREEN 3: CHAT
# ═══════════════════════════════════════════════════════════
def render_chat_screen():
    img, draw = create_phone()
    phone_frame(draw)

    # Header
    hy = STATUS_BAR_H
    draw.rectangle([0, hy, PHONE_W, hy + 56], fill=BG_SECONDARY)
    # Back arrow
    draw.text((16, hy + 16), "←", fill=TEXT_PRIMARY, font=font_sys_bold(20))
    # Avatar
    circle(draw, (64, hy + 28), 18, ACCENT_TEAL)
    draw.text((56, hy + 18), "A", fill=TEXT_PRIMARY, font=font_sys_bold(14))
    # Name + status
    draw.text((90, hy + 12), "Alice Martin", fill=TEXT_PRIMARY, font=font_sys_bold(15))
    circle(draw, (90 + 8, hy + 42), 4, SUCCESS)
    draw.text((102, hy + 34), "En ligne", fill=SUCCESS, font=font_sys(11))

    draw.line([(0, hy + 56), (PHONE_W, hy + 56)], fill=BORDER, width=1)

    # Messages area
    msg_y = hy + 72

    # Date separator
    sep_text = "Aujourd'hui"
    stw = draw.textlength(sep_text, font=font_sys(11))
    sep_cx = PHONE_W // 2
    draw.line([(30, msg_y + 6), (sep_cx - stw/2 - 10, msg_y + 6)], fill=BORDER, width=1)
    draw.text((sep_cx - stw/2, msg_y), sep_text, fill=TEXT_MUTED, font=font_sys(11))
    draw.line([(sep_cx + stw/2 + 10, msg_y + 6), (PHONE_W - 30, msg_y + 6)], fill=BORDER, width=1)

    msg_y += 30

    def bubble_received(draw, y, text, time_str):
        f = font_sys(14)
        lines = []
        words = text.split()
        line = ""
        max_w = 240
        for w in words:
            test = line + (" " if line else "") + w
            if draw.textlength(test, font=f) > max_w:
                lines.append(line)
                line = w
            else:
                line = test
        if line:
            lines.append(line)

        line_h = 20
        bw = max(draw.textlength(l, font=f) for l in lines) + 24
        bh = len(lines) * line_h + 16

        # Bubble
        draw.rounded_rectangle([20, y, 20 + bw, y + bh], radius=16, fill=BG_TERTIARY)
        # Pointy corner (bottom-left)
        draw.polygon([(20, y + bh - 12), (20, y + bh), (12, y + bh)], fill=BG_TERTIARY)

        for i, l in enumerate(lines):
            draw.text((32, y + 8 + i * line_h), l, fill=TEXT_PRIMARY, font=f)

        # Time
        draw.text((24, y + bh + 4), time_str, fill=TEXT_MUTED, font=font_sys(10))

        return y + bh + 24

    def bubble_sent(draw, y, text, time_str, read=True):
        f = font_sys(14)
        lines = []
        words = text.split()
        line = ""
        max_w = 240
        for w in words:
            test = line + (" " if line else "") + w
            if draw.textlength(test, font=f) > max_w:
                lines.append(line)
                line = w
            else:
                line = test
        if line:
            lines.append(line)

        line_h = 20
        bw = max(draw.textlength(l, font=f) for l in lines) + 24
        bh = len(lines) * line_h + 16
        bx = PHONE_W - 20 - bw

        # Bubble
        draw.rounded_rectangle([bx, y, PHONE_W - 20, y + bh], radius=16, fill=ACCENT_TEAL)
        # Pointy corner (bottom-right)
        draw.polygon([(PHONE_W - 20, y + bh - 12), (PHONE_W - 20, y + bh), (PHONE_W - 12, y + bh)], fill=ACCENT_TEAL)

        for i, l in enumerate(lines):
            draw.text((bx + 12, y + 8 + i * line_h), l, fill=BLACK, font=f)

        # Time + read receipt
        check = "✓✓" if read else "✓"
        time_text = f"{time_str}  {check}"
        ttw = draw.textlength(time_text, font=font_sys(10))
        draw.text((PHONE_W - 24 - ttw, y + bh + 4), time_str + "  ", fill=TEXT_MUTED, font=font_sys(10))
        draw.text((PHONE_W - 24 - ttw + draw.textlength(time_str + "  ", font=font_sys(10)), y + bh + 4),
                   check, fill=ACCENT_TEAL if read else TEXT_MUTED, font=font_sys(10))

        return y + bh + 24

    msg_y = bubble_received(draw, msg_y, "Salut ! Tu connais ce spot près de Belleville ?", "14:30")
    msg_y = bubble_sent(draw, msg_y, "Oui c'est génial ! J'y suis allé la semaine dernière", "14:32", True)
    msg_y = bubble_received(draw, msg_y, "Tu devrais essayer le brunch aussi, c'est le meilleur du quartier", "14:33")
    msg_y = bubble_sent(draw, msg_y, "J'y vais ce weekend !", "14:35", True)
    msg_y = bubble_received(draw, msg_y, "Top ! Tu me diras ce que t'en penses", "14:36")

    # Typing indicator
    ty = msg_y + 4
    draw.rounded_rectangle([20, ty, 80, ty + 32], radius=16, fill=BG_TERTIARY)
    for i, dx in enumerate([34, 46, 58]):
        alpha = 180 + i * 25
        c = tuple(min(255, TEXT_MUTED[j] + 20 * i) for j in range(3))
        circle(draw, (dx, ty + 16), 4, c)

    # Input bar
    input_y = PHONE_H - NAVBAR_H - 56
    draw.rectangle([0, input_y, PHONE_W, input_y + 56], fill=BG_SECONDARY)
    draw.line([(0, input_y), (PHONE_W, input_y)], fill=BORDER, width=1)

    # Attachment
    draw.text((16, input_y + 16), "📎", font=font_sys(18))

    # Text input
    draw.rounded_rectangle([50, input_y + 8, PHONE_W - 56, input_y + 48], radius=20, fill=BG_TERTIARY)
    draw.text((66, input_y + 18), "Message...", fill=TEXT_MUTED, font=font_sys(14))

    # Send button
    circle(draw, (PHONE_W - 30, input_y + 28), 20, ACCENT_TEAL)
    draw.text((PHONE_W - 37, input_y + 18), "➤", fill=BLACK, font=font_sys_bold(16))

    # No navbar on chat screen (full screen)

    mask = Image.new("L", (PHONE_W, PHONE_H), 0)
    mask_draw = ImageDraw.Draw(mask)
    mask_draw.rounded_rectangle([0, 0, PHONE_W, PHONE_H], radius=PHONE_RADIUS, fill=255)
    bg = Image.new("RGB", (PHONE_W, PHONE_H), (30, 30, 30))
    bg.paste(img, mask=mask)
    return bg


# ═══════════════════════════════════════════════════════════
# SCREEN 4: NOTIFICATIONS
# ═══════════════════════════════════════════════════════════
def render_notifications():
    img, draw = create_phone()
    phone_frame(draw)

    # Header
    hy = STATUS_BAR_H
    draw.rectangle([0, hy, PHONE_W, hy + HEADER_H], fill=BG_PRIMARY)
    draw.text((24, hy + 16), "NOTIFICATIONS", fill=TEXT_PRIMARY, font=font_druk(18))
    draw.text((PHONE_W - 80, hy + 24), "Tout lire", fill=ACCENT_TEAL, font=font_sys(12))
    draw.line([(0, hy + HEADER_H), (PHONE_W, hy + HEADER_H)], fill=BORDER, width=1)

    start_y = hy + HEADER_H + 1

    # Section header
    draw.text((20, start_y + 12), "Aujourd'hui", fill=TEXT_MUTED, font=font_sys_bold(11))
    start_y += 40

    notifications = [
        ("❤️", ERROR, "Alice a aimé votre shot", "\"Café du Marais\"", "il y a 2h", True),
        ("👤", ACCENT_TEAL, "Bob vous suit", "Nouveau follower", "il y a 5h", True),
        ("📍", ACCENT_TEAL, "Shot à proximité", "\"Rooftop Belleville\" à 800m", "il y a 8h", True),
    ]

    cell_h = 72
    for i, (icon, color, title, subtitle, time, unread) in enumerate(notifications):
        cy = start_y + i * cell_h

        if unread:
            draw.rectangle([0, cy, PHONE_W, cy + cell_h], fill=(13, 19, 22))

        # Icon container
        icon_x, icon_y = 36, cy + cell_h // 2
        # Background circle with color at 20% opacity
        bg_color = tuple(int(c * 0.2 + BG_PRIMARY[j] * 0.8) for j, c in enumerate(color))
        circle(draw, (icon_x, icon_y), 22, bg_color)
        draw.text((icon_x - 8, icon_y - 10), icon, font=font_sys(16))

        # Text
        draw.text((70, cy + 14), title, fill=TEXT_PRIMARY, font=font_sys_bold(14))
        draw.text((70, cy + 36), subtitle, fill=TEXT_SECONDARY, font=font_sys(12))

        # Time
        tw = draw.textlength(time, font=font_sys(10))
        draw.text((PHONE_W - 20 - tw, cy + 16), time, fill=TEXT_MUTED, font=font_sys(10))

        # Unread dot
        if unread:
            circle(draw, (PHONE_W - 16, cy + cell_h // 2), 4, ACCENT_ORANGE)

        draw.line([(70, cy + cell_h - 1), (PHONE_W, cy + cell_h - 1)], fill=BORDER, width=1)

    # Yesterday section
    y_section = start_y + len(notifications) * cell_h + 8
    draw.text((20, y_section + 8), "Hier", fill=TEXT_MUTED, font=font_sys_bold(11))
    y_section += 36

    old_notifs = [
        ("💬", ACCENT_ORANGE, "Nouveau message de Clara", "\"Salut, tu connais...\"", "14:30", False),
        ("⚙️", TEXT_SECONDARY, "Mise à jour disponible", "Version 1.1 est sortie", "10:00", False),
        ("❤️", ERROR, "Emma a aimé votre shot", "\"Jardin du Luxembourg\"", "09:15", False),
    ]

    for i, (icon, color, title, subtitle, time, unread) in enumerate(old_notifs):
        cy = y_section + i * cell_h

        icon_x, icon_y = 36, cy + cell_h // 2
        bg_color = tuple(int(c * 0.15 + BG_PRIMARY[j] * 0.85) for j, c in enumerate(color))
        circle(draw, (icon_x, icon_y), 22, bg_color)
        draw.text((icon_x - 8, icon_y - 10), icon, font=font_sys(16))

        draw.text((70, cy + 14), title, fill=TEXT_SECONDARY, font=font_sys(14))
        draw.text((70, cy + 36), subtitle, fill=TEXT_MUTED, font=font_sys(12))

        tw = draw.textlength(time, font=font_sys(10))
        draw.text((PHONE_W - 20 - tw, cy + 16), time, fill=TEXT_MUTED, font=font_sys(10))

        draw.line([(70, cy + cell_h - 1), (PHONE_W, cy + cell_h - 1)], fill=BORDER, width=1)

    navbar(draw, 3)
    # Badge on notification tab
    add_notif_badge(draw, PHONE_W - PHONE_W//8 + 12, PHONE_H - NAVBAR_H + 14, "3")

    mask = Image.new("L", (PHONE_W, PHONE_H), 0)
    mask_draw = ImageDraw.Draw(mask)
    mask_draw.rounded_rectangle([0, 0, PHONE_W, PHONE_H], radius=PHONE_RADIUS, fill=255)
    bg = Image.new("RGB", (PHONE_W, PHONE_H), (30, 30, 30))
    bg.paste(img, mask=mask)
    return bg


# ═══════════════════════════════════════════════════════════
# SCREEN 5: PROFILE
# ═══════════════════════════════════════════════════════════
def render_profile():
    img, draw = create_phone()
    phone_frame(draw)

    # Header
    hy = STATUS_BAR_H
    draw.rectangle([0, hy, PHONE_W, hy + HEADER_H], fill=BG_PRIMARY)
    draw.text((24, hy + 16), "PROFIL", fill=TEXT_PRIMARY, font=font_druk(22))
    draw.text((PHONE_W - 80, hy + 22), "✏️  ⚙️", font=font_sys(18))

    # Cover photo
    cover_y = hy + HEADER_H
    cover_h = 140
    # Gradient cover
    for y in range(cover_h):
        r = int(20 + y * 0.15)
        g = int(45 + y * 0.3)
        b = int(55 + y * 0.25)
        draw.line([(0, cover_y + y), (PHONE_W, cover_y + y)], fill=(r, g, b))

    # Avatar
    avatar_y = cover_y + cover_h - 36
    avatar_x = PHONE_W // 2
    circle(draw, (avatar_x, avatar_y), 42, BG_PRIMARY)  # Border
    circle(draw, (avatar_x, avatar_y), 38, ACCENT_TEAL)  # Avatar bg
    draw.text((avatar_x - 12, avatar_y - 14), "A", fill=TEXT_PRIMARY, font=font_sys_bold(24))

    # Username
    name_y = avatar_y + 50
    name = "@alice_martin"
    nw = draw.textlength(name, font=font_sys_bold(16))
    draw.text(((PHONE_W - nw)//2, name_y), name, fill=TEXT_PRIMARY, font=font_sys_bold(16))

    # Stats row
    stat_y = name_y + 36
    stats = [("127", "shots"), ("342", "followers"), ("28", "following")]
    section_w = PHONE_W // 3
    for i, (num, label) in enumerate(stats):
        cx = section_w * i + section_w // 2
        nw = draw.textlength(num, font=font_sys_bold(18))
        draw.text((cx - nw/2, stat_y), num, fill=TEXT_PRIMARY, font=font_sys_bold(18))
        lw = draw.textlength(label, font=font_sys(11))
        draw.text((cx - lw/2, stat_y + 22), label, fill=TEXT_SECONDARY, font=font_sys(11))

    # Follow button
    btn_y = stat_y + 52
    draw.rounded_rectangle([40, btn_y, PHONE_W - 40, btn_y + 40], radius=20, fill=ACCENT_TEAL)
    ftxt = "+ Suivre"
    ftw = draw.textlength(ftxt, font=font_sys_bold(15))
    draw.text(((PHONE_W - ftw)//2, btn_y + 10), ftxt, fill=BLACK, font=font_sys_bold(15))

    # Interests section
    int_y = btn_y + 60
    draw.text((20, int_y), "Centres d'intérêt", fill=TEXT_SECONDARY, font=font_sys_bold(13))

    tags = ["Coffee", "Street Art", "Rooftops", "Nature", "Food"]
    tag_x = 20
    tag_y = int_y + 28
    for tag in tags:
        tw = draw.textlength(tag, font=font_sys(12))
        tag_w = tw + 20
        if tag_x + tag_w > PHONE_W - 20:
            tag_x = 20
            tag_y += 34
        draw.rounded_rectangle([tag_x, tag_y, tag_x + tag_w, tag_y + 28], radius=14, fill=BG_TERTIARY)
        draw.text((tag_x + 10, tag_y + 6), tag, fill=ACCENT_TEAL, font=font_sys(12))
        tag_x += tag_w + 8

    # Shots grid section
    grid_y = tag_y + 50
    draw.text((20, grid_y), "Mes shots", fill=TEXT_SECONDARY, font=font_sys_bold(13))
    grid_y += 28

    grid_size = (PHONE_W - 48) // 3
    grid_colors = [(30, 60, 50), (40, 35, 55), (35, 50, 60), (50, 40, 35), (35, 45, 50), (45, 35, 45)]
    for row in range(2):
        for col in range(3):
            gx = 16 + col * (grid_size + 4)
            gy = grid_y + row * (grid_size + 4)
            idx = row * 3 + col
            rounded_rect(draw, [gx, gy, gx + grid_size, gy + grid_size], grid_colors[idx], 8)
            draw.text((gx + grid_size//2 - 5, gy + grid_size//2 - 8), "📷", font=font_sys(12))

    navbar(draw, 2)

    mask = Image.new("L", (PHONE_W, PHONE_H), 0)
    mask_draw = ImageDraw.Draw(mask)
    mask_draw.rounded_rectangle([0, 0, PHONE_W, PHONE_H], radius=PHONE_RADIUS, fill=255)
    bg = Image.new("RGB", (PHONE_W, PHONE_H), (30, 30, 30))
    bg.paste(img, mask=mask)
    return bg


# ═══════════════════════════════════════════════════════════
# COMPOSITE: All screens side by side
# ═══════════════════════════════════════════════════════════
def render_all():
    screens = [
        ("Carte + Détail Shot", render_map_screen()),
        ("Messages", render_message_list()),
        ("Chat", render_chat_screen()),
        ("Notifications", render_notifications()),
        ("Profil", render_profile()),
    ]

    gap = 32
    label_h = 48
    padding = 40

    total_w = len(screens) * PHONE_W + (len(screens) - 1) * gap + padding * 2
    total_h = PHONE_H + label_h + padding * 2

    canvas = Image.new("RGB", (total_w, total_h), (18, 18, 24))
    canvas_draw = ImageDraw.Draw(canvas)

    # Title
    title = "BriefShot — Maquettes UI"
    tf = font_druk(20)
    ttw = canvas_draw.textlength(title, font=tf)
    canvas_draw.text(((total_w - ttw)//2, 10), title, fill=ACCENT_TEAL, font=tf)

    for i, (label, screen_img) in enumerate(screens):
        x = padding + i * (PHONE_W + gap)
        y = padding

        # Drop shadow
        shadow = Image.new("RGB", (PHONE_W + 8, PHONE_H + 8), (18, 18, 24))
        shadow_draw = ImageDraw.Draw(shadow)
        shadow_draw.rounded_rectangle([4, 4, PHONE_W + 4, PHONE_H + 4], radius=PHONE_RADIUS, fill=(8, 8, 12))
        canvas.paste(shadow, (x - 4, y - 4))

        # Phone
        canvas.paste(screen_img, (x, y))

        # Label
        lf = font_sys_bold(14)
        lw = canvas_draw.textlength(label, font=lf)
        canvas_draw.text((x + (PHONE_W - lw)//2, y + PHONE_H + 12), label, fill=TEXT_SECONDARY, font=lf)

    # Save individual screens too
    for label, screen_img in screens:
        fname = label.lower().replace(" + ", "_").replace(" ", "_")
        screen_img.save(f"{OUTPUT_DIR}{fname}.png", "PNG")
        print(f"  ✓ {fname}.png")

    canvas.save(f"{OUTPUT_DIR}all_screens.png", "PNG")
    print(f"  ✓ all_screens.png ({total_w}x{total_h})")

    return canvas


if __name__ == "__main__":
    print("🎨 Generating BriefShot mockups...")
    render_all()
    print(f"\n✅ Done! Files saved to {OUTPUT_DIR}")
