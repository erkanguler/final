using System;
using System.Collections.Generic;

namespace final.Models;

public partial class OrderNoLoginProduct
{
    public int OrderId { get; set; }

    public int ProductId { get; set; }

    public int Quantity { get; set; }

    public decimal Price { get; set; }

    public virtual OrderNoLogin Order { get; set; } = null!;

    public virtual Product Product { get; set; } = null!;
}
