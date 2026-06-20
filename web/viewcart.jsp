<%-- 
    Document   : viewcart
    Created on : 1 Jun, 2026, 12:40:44 AM
    Author     : Anunay 
--%>
<%@page import="java.util.List"%>
<%@page import="dto.BookDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
List<BookDTO> books = (List<BookDTO>)request.getAttribute("books");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Your Cart – E-lib Store</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@latest/tabler-icons.min.css" />
        <style>
            * { box-sizing: border-box; margin: 0; padding: 0; }

            body {
                font-family: Arial, sans-serif;
                background: #e8e6f0;
                min-height: 100vh;
                color: #2e2b4a;
            }

            /* ── Navbar ── */
            .navbar {
                background: #2e2b4a;
                padding: 0 32px;
                height: 60px;
                display: flex;
                align-items: center;
                justify-content: space-between;
                position: sticky;
                top: 0;
                z-index: 100;
            }

            .navbar-brand {
                display: flex;
                align-items: center;
                gap: 10px;
                text-decoration: none;
            }

            .navbar-brand .nav-icon {
                width: 34px; height: 34px;
                background: rgba(174,169,236,0.18);
                border-radius: 8px;
                display: flex; align-items: center; justify-content: center;
            }

            .navbar-brand .nav-icon i { font-size: 19px; color: #c8c4f0; }
            .navbar-brand span { font-size: 17px; font-weight: 600; color: #eeedf8; }

            .btn-nav-back {
                display: flex;
                align-items: center;
                gap: 6px;
                font-size: 13px;
                color: #a8a4cc;
                text-decoration: none;
                transition: color 0.15s;
                font-weight: 600;
            }

            .btn-nav-back:hover { color: #eeedf8; }
            .btn-nav-back i { font-size: 16px; }

            /* ── Page wrapper ── */
            .page-wrapper {
                max-width: 780px;
                margin: 0 auto;
                padding: 36px 24px 64px;
            }

            /* ── Section heading ── */
            .section-heading {
                display: flex;
                align-items: center;
                gap: 10px;
                margin-bottom: 24px;
            }

            .section-heading i { font-size: 22px; color: #6c63b8; }

            .section-heading h2 {
                font-size: 20px;
                font-weight: 600;
                color: #2e2b4a;
            }

            .item-count {
                font-size: 13px;
                color: #9b99b8;
                margin-left: 4px;
                font-weight: 400;
            }

            /* ── Cart layout ── */
            .cart-layout {
                display: flex;
                flex-direction: column;
                gap: 14px;
            }

            /* ── Cart item ── */
            .cart-item {
                background: #f2f0f7;
                border: 1px solid #d4d2e3;
                border-radius: 13px;
                display: flex;
                align-items: center;
                gap: 18px;
                padding: 16px;
                transition: box-shadow 0.15s;
            }

            .cart-item:hover {
                box-shadow: 0 4px 16px rgba(78,71,152,0.10);
            }

            .item-cover {
                width: 70px;
                height: 95px;
                border-radius: 8px;
                overflow: hidden;
                background: #dddaf0;
                flex-shrink: 0;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .item-cover img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                display: block;
            }

            .item-cover .no-cover {
                display: none;
                align-items: center;
                justify-content: center;
                width: 100%;
                height: 100%;
            }

            .item-cover .no-cover i { font-size: 26px; color: #9b99b8; }

            .item-info {
                flex: 1;
                min-width: 0;
            }

            .item-title {
                font-size: 15px;
                font-weight: 600;
                color: #2e2b4a;
                margin-bottom: 3px;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }

            .item-author {
                font-size: 13px;
                color: #7a7896;
                margin-bottom: 10px;
            }

            .item-meta {
                display: flex;
                align-items: center;
                gap: 10px;
                flex-wrap: wrap;
            }

            .meta-pill {
                display: flex;
                align-items: center;
                gap: 5px;
                padding: 4px 10px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 600;
            }

            .meta-pill i { font-size: 13px; }

            .pill-price {
                background: #e8e6f8;
                color: #4e4798;
                border: 1px solid #c8c4e8;
            }

            .pill-new {
                background: #d4f0e4;
                color: #0f6e56;
                border: 1px solid #a8ddc8;
            }

            .pill-old {
                background: #f0e4d4;
                color: #7a3c1d;
                border: 1px solid #ddc0a8;
            }

            /* ── Remove button ── */
            .btn-remove {
                height: 36px;
                padding: 0 14px;
                background: #fdf5f5;
                color: #c0504a;
                border: 1px solid #e8c8c8;
                border-radius: 8px;
                font-size: 13px;
                font-weight: 600;
                cursor: pointer;
                font-family: Arial, sans-serif;
                display: flex;
                align-items: center;
                gap: 6px;
                flex-shrink: 0;
                transition: background 0.15s, transform 0.1s;
            }

            .btn-remove:hover { background: #f5e8e8; }
            .btn-remove:active { transform: scale(0.97); }
            .btn-remove i { font-size: 15px; }

            /* ── Summary card ── */
            .summary-card {
                background: #f2f0f7;
                border: 1px solid #d4d2e3;
                border-radius: 13px;
                padding: 20px 24px;
                margin-top: 24px;
                display: flex;
                align-items: center;
                justify-content: space-between;
                gap: 16px;
            }

            .summary-label {
                font-size: 13px;
                color: #7a7896;
                margin-bottom: 4px;
            }

            .summary-total {
                font-size: 22px;
                font-weight: 600;
                color: #4e4798;
            }

            .btn-checkout {
                height: 44px;
                padding: 0 28px;
                background: #4e4798;
                color: #eeedf8;
                border: none;
                border-radius: 9px;
                font-size: 15px;
                font-weight: 600;
                cursor: pointer;
                font-family: Arial, sans-serif;
                display: flex;
                align-items: center;
                gap: 8px;
                text-decoration: none;
                transition: background 0.15s, transform 0.1s;
            }

            .btn-checkout:hover { background: #3b3478; }
            .btn-checkout:active { transform: scale(0.98); }
            .btn-checkout i { font-size: 18px; }

            /* ── Empty state ── */
            .empty-state {
                text-align: center;
                padding: 72px 24px;
                color: #9b99b8;
            }

            .empty-state i { font-size: 56px; margin-bottom: 16px; display: block; }
            .empty-state h3 { font-size: 17px; font-weight: 600; margin-bottom: 6px; color: #7a7896; }
            .empty-state p { font-size: 14px; }

            .empty-state a {
                display: inline-flex;
                align-items: center;
                gap: 7px;
                margin-top: 20px;
                padding: 10px 22px;
                background: #4e4798;
                color: #eeedf8;
                border-radius: 8px;
                font-size: 14px;
                font-weight: 600;
                text-decoration: none;
                transition: background 0.15s;
            }

            .empty-state a:hover { background: #3b3478; }

            @media (max-width: 560px) {
                .cart-item { flex-wrap: wrap; }
                .item-cover { width: 56px; height: 76px; }
                .summary-card { flex-direction: column; align-items: flex-start; }
                .btn-checkout { width: 100%; justify-content: center; }
                .page-wrapper { padding: 24px 16px 48px; }
                .navbar { padding: 0 16px; }
            }
        </style>
    </head>
    <body>

        <!-- Navbar -->
        <nav class="navbar">
            <a href="#" class="navbar-brand">
                <div class="nav-icon"><i class="ti ti-book-2"></i></div>
                <span>E-lib Store</span>
            </a>
            <a href="javascript:history.back()" class="btn-nav-back">
                <i class="ti ti-arrow-left"></i>
                Continue browsing
            </a>
        </nav>

        <div class="page-wrapper">

            <div class="section-heading">
                <i class="ti ti-shopping-cart"></i>
                <h2>Your cart
                    <%
                        if (books != null && !books.isEmpty()) {
                    %>
                    <span class="item-count">(<%=books.size()%> item<%=books.size() == 1 ? "" : "s"%>)</span>
                    <%
                        }
                    %>
                </h2>
            </div>

            <%
                if (books == null || books.isEmpty()) {
            %>
            <div class="empty-state">
                <i class="ti ti-shopping-cart-off"></i>
                <h3>Your cart is empty</h3>
                <p>Looks like you haven't added any books yet.</p>
                <a href="javascript:history.back()">
                    <i class="ti ti-books"></i>
                    Browse books
                </a>
            </div>
            <%
                } else {
                    int total = 0;
            %>
            <div class="cart-layout">
                <%
                    for (BookDTO book : books) {
                        total += book.getBookprice();
                %>
                <div class="cart-item">

                    <div class="item-cover">
                        <img src="BookCoverDisplay?bookid=<%=book.getBookid()%>"
                             alt="<%=book.getBooktitle()%>"
                             onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';" />
                        <div class="no-cover">
                            <i class="ti ti-book-off"></i>
                        </div>
                    </div>

                    <div class="item-info">
                        <div class="item-title"><%=book.getBooktitle()%></div>
                        <div class="item-author"><%=book.getBookauthor()%></div>
                        <div class="item-meta">
                            <span class="meta-pill pill-price">
                                <i class="ti ti-currency-rupee"></i>
                                <%=book.getBookprice()%>
                            </span>
                            <span class="meta-pill <%="New".equals(book.getBookcondition()) ? "pill-new" : "pill-old"%>">
                                <i class="ti ti-tag"></i>
                                <%=book.getBookcondition()%>
                            </span>
                        </div>
                    </div>

                    <form action="DeleteFromCart" method="post">
                        <input type="hidden" name="bookid" value="<%=book.getBookid()%>" />
                        <button type="submit" class="btn-remove">
                            <i class="ti ti-trash"></i>
                            Remove
                        </button>
                    </form>

                </div>
                <%
                    }
                %>
            </div>

            <!-- Order summary -->
            <div class="summary-card">
                <div>
                    <div class="summary-label">Order total</div>
                    <div class="summary-total">₹<%=total%></div>
                </div>
                <a href="#" class="btn-checkout">
                    <i class="ti ti-credit-card"></i>
                    Proceed to checkout
                </a>
            </div>

            <%
                }
            %>

        </div>

    </body>
</html>