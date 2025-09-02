#!/usr/bin/env python3
"""
分析不同数据库系统的SQLStorm v1.0测试结果
"""

import os
import pandas as pd
import matplotlib.pyplot as plt
from pathlib import Path

def analyze_database_results(results_dir, db_name):
    """分析指定数据库的结果"""
    csv_files = list(Path(results_dir).glob("*.csv"))
    if not csv_files:
        return None
    
    # 找到主要的CSV文件（排除_current文件）
    main_csv = None
    for csv_file in csv_files:
        if not csv_file.name.endswith('_current'):
            main_csv = csv_file
            break
    
    if not main_csv:
        return None
    
    try:
        df = pd.read_csv(main_csv)
        print(f"\n=== {db_name} 结果分析 ===")
        print(f"结果文件: {main_csv.name}")
        print(f"总查询数: {len(df)}")
        
        # 统计成功/失败
        success_count = len(df[df['state'] == 'success'])
        error_count = len(df[df['state'] == 'error'])
        
        print(f"成功查询: {success_count}")
        print(f"失败查询: {error_count}")
        print(f"成功率: {success_count/len(df)*100:.1f}%")
        
        # 分析执行时间
        if success_count > 0:
            success_df = df[df['state'] == 'success']
            
            # 提取执行时间（从client_total字段）
            def extract_time(time_str):
                try:
                    if pd.isna(time_str) or time_str == '':
                        return None
                    # 处理 [123.456] 格式
                    if isinstance(time_str, str) and time_str.startswith('[') and time_str.endswith(']'):
                        return float(time_str[1:-1])
                    return float(time_str)
                except:
                    return None
            
            times = success_df['client_total'].apply(extract_time).dropna()
            
            if len(times) > 0:
                print(f"平均执行时间: {times.mean():.2f} ms")
                print(f"中位数执行时间: {times.median():.2f} ms")
                print(f"最快查询: {times.min():.2f} ms")
                print(f"最慢查询: {times.max():.2f} ms")
        
        # 分析错误类型
        if error_count > 0:
            error_df = df[df['state'] == 'error']
            print(f"\n错误类型分析:")
            error_messages = error_df['message'].value_counts().head(5)
            for error, count in error_messages.items():
                print(f"  {error[:100]}... ({count}次)")
        
        return {
            'db_name': db_name,
            'total_queries': len(df),
            'success_count': success_count,
            'error_count': error_count,
            'success_rate': success_count/len(df)*100,
            'file_path': str(main_csv)
        }
        
    except Exception as e:
        print(f"分析 {db_name} 结果时出错: {e}")
        return None

def compare_databases():
    """对比不同数据库的结果"""
    results_dir = Path("results")
    if not results_dir.exists():
        print("结果目录不存在")
        return
    
    # 查找所有数据库结果目录
    db_dirs = [d for d in results_dir.iterdir() if d.is_dir() and 'sqlstorm' in d.name]
    
    if not db_dirs:
        print("未找到SQLStorm测试结果")
        return
    
    print("找到以下数据库测试结果:")
    for db_dir in db_dirs:
        print(f"  - {db_dir.name}")
    
    # 分析每个数据库的结果
    results = []
    for db_dir in db_dirs:
        db_name = db_dir.name.replace('_sqlstorm_v1.0_test', '').replace('_sqlstorm_v1.0', '')
        result = analyze_database_results(db_dir, db_name)
        if result:
            results.append(result)
    
    # 生成对比报告
    if results:
        print(f"\n{'='*60}")
        print("数据库性能对比报告")
        print(f"{'='*60}")
        
        # 创建对比表格
        comparison_df = pd.DataFrame(results)
        comparison_df = comparison_df.sort_values('success_rate', ascending=False)
        
        print(f"\n{comparison_df.to_string(index=False)}")
        
        # 生成可视化图表
        try:
            plt.figure(figsize=(12, 8))
            
            # 成功率对比
            plt.subplot(2, 2, 1)
            plt.bar(comparison_df['db_name'], comparison_df['success_rate'])
            plt.title('查询成功率对比')
            plt.ylabel('成功率 (%)')
            plt.xticks(rotation=45)
            
            # 成功查询数量对比
            plt.subplot(2, 2, 2)
            plt.bar(comparison_df['db_name'], comparison_df['success_count'])
            plt.title('成功查询数量对比')
            plt.ylabel('成功查询数')
            plt.xticks(rotation=45)
            
            # 失败查询数量对比
            plt.subplot(2, 2, 3)
            plt.bar(comparison_df['db_name'], comparison_df['error_count'])
            plt.title('失败查询数量对比')
            plt.ylabel('失败查询数')
            plt.xticks(rotation=45)
            
            # 总查询数量对比
            plt.subplot(2, 2, 4)
            plt.bar(comparison_df['db_name'], comparison_df['total_queries'])
            plt.title('总查询数量对比')
            plt.ylabel('总查询数')
            plt.xticks(rotation=45)
            
            plt.tight_layout()
            plt.savefig('database_comparison.png', dpi=300, bbox_inches='tight')
            print(f"\n对比图表已保存为: database_comparison.png")
            
        except Exception as e:
            print(f"生成图表时出错: {e}")

if __name__ == "__main__":
    compare_databases()
