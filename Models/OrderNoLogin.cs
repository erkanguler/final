using System;
using System.Collections.Generic;

namespace final.Models;

public partial class OrderNoLogin
{
    public int Id { get; set; }

    public int CustomerId { get; set; }

    public DateTime? Date { get; set; }

    public virtual CustomerNoLogin Customer { get; set; } = null!;

    public virtual ICollection<OrderNoLoginProduct> OrderNoLoginProducts { get; set; } = new List<OrderNoLoginProduct>();
}
