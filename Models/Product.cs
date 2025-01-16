using System;
using System.Collections.Generic;

namespace final.Models;

public partial class Product
{
    public int Id { get; set; }

    public string? Title { get; set; }

    public decimal? Price { get; set; }

    public string? Image { get; set; }

    public int CategoryId { get; set; }

    public virtual Category Category { get; set; } = null!;

    public virtual ICollection<OrderNoLoginProduct> OrderNoLoginProducts { get; set; } = new List<OrderNoLoginProduct>();

    public virtual ICollection<OrderProduct> OrderProducts { get; set; } = new List<OrderProduct>();
}
